
---还有隐身自己手动，没有写隐身自动解控
--脚本说明("奇穴适用 \n  [[血泪成悦][日月凌天][燎原烈火][善法肉身|超凡入圣][恶秽满路][辉耀红尘][善恶如梦][超然物外][天地诛戮][秘影诡行][伏明众生][冥月渡心]  \n  \n 增加减疗模式，此模式针对超凡入圣奇穴写的，可以上减疗(按下银月斩后就会进入减疗模式，按下破魔击或者生死劫就会切换回来普通的输出模式  \n  \n 如果需要手动流光，推荐在门派设置那里关闭流光追击，因为脚本的自动流光可以有效的回避某些职业的控制 \n 更新日记  3/26 修复隐身BUG导致脚本发呆问题 ")

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--脱战隐身
if not player.bFightState and not s_util.GetBuffInfo(player)[4052] then
    if s_util.CastSkill(3974, false) then return end
end
--------------------↓↓↓↓遍历处理区开始↓↓↓↓--------------------


--------------------↑↑↑↑遍历处理区结束↑↑↑↑--------------------
--------------------↓↓↓↓目标处理区开始↓↓↓↓--------------------

--获取当前目标,未进战没目标直接返回,战斗中没目标选择最近敌对NPC,调整面向
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID)) and targetClass~=TARGET.PLAYER then return end
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) or targetClass~=TARGET.PLAYER then  
local MinDistance = 20		
local MindwID = 0		    
for i,v in ipairs(GetAllPlayer()) do		--遍历
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance then
		MinDistance = s_util.GetDistance(v, player)
		MindwID = v.dwID
		end
	end
if MindwID == 0 then 
    return
else
    SetTarget(TARGET.PLAYER, MindwID)  --设定目标
end
end
if target then s_util.TurnTo(target.nX,target.nY) end  --调整面向

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end
--------------------------↑↑↑↑目标处理区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓变量定义区开始↓↓↓↓-------------------------

--定义自己和目标的距离
local distance = s_util.GetDistance(player, target)	

--定义自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--定义自己对目标造成的buff列表
local TargetBuff = s_util.GetBuffInfo(target, true)

--定义目标的全部buff列表
local TargetBuffAll = s_util.GetBuffInfo(target)

--定义目标读条数据，是否在读条, 技能ID，等级，读条百分比，动作类型
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)

--定义自己读条数据，是否在读条, 技能ID，等级，读条百分比，动作类型
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)

--定义自己的血量比
local hpRatio = player.nCurrentLife / player.nMaxLife

--简化日月能量
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--定义需停手的BUff 无名魂锁，南风吐月，镇山河，雷霆震怒，盾立
local TingShouBuff = TargetBuffAll[4871] or TargetBuffAll[9934] or TargetBuffAll[377] or TargetBuffAll[682] or TargetBuffAll[8303] or TargetBuffAll[9534] or TargetBuffAll[961] or TargetBuffAll[3425] or TargetBuffAll[11151]

--定义自身免控buff 蛊虫狂暴,蛊虫狂暴2,秘影,迷心蛊,镇山河,超然,隐身
local MianKongSelf = MyBuff[2840] or MyBuff[2830] or MyBuff[12665] or MyBuff[6247] or MyBuff[377] or MyBuff[4468] or MyBuff[12492] or MyBuff[4421]

--定义自身免伤BUFF 
local MianShangSelf = MyBuff[8303] or MyBuff[9534] or MyBuff[377] or MyBuff[961] or MyBuff[772] or MyBuff[9934] or MyBuff[12492]

--定义目标减伤BUFF
local JianShangTar = TargetBuffAll[6163] or TargetBuffAll[3193] or TargetBuffAll[6264] or TargetBuffAll[6257] or TargetBuffAll[3171] or TargetBuffAll[4444] or TargetBuffAll[5744] or TargetBuffAll[6637] or TargetBuffAll[8292] or TargetBuffAll[11319] or TargetBuffAll[368] or TargetBuffAll[367] or TargetBuffAll[384] or TargetBuffAll[399] or TargetBuffAll[3068] or TargetBuffAll[122] or TargetBuffAll[1802] or TargetBuffAll[684] or TargetBuffAll[4439] or TargetBuffAll[6315] or TargetBuffAll[6240] or TargetBuffAll[5996] or TargetBuffAll[6200] or TargetBuffAll[6636] or TargetBuffAll[6262] or TargetBuffAll[2849] or TargetBuffAll[3315] or TargetBuffAll[8279] or TargetBuffAll[8300] or TargetBuffAll[8427] or TargetBuffAll[8291] or TargetBuffAll[2983] or TargetBuffAll[10014]

----定义自己减伤BUFF
local JianShangSelf = MyBuff[6163] or MyBuff[3193] or MyBuff[6264] or MyBuff[6257] or MyBuff[3171] or MyBuff[4444] or MyBuff[5744] or MyBuff[6637] or MyBuff[8292] or MyBuff[11319] or MyBuff[368] or MyBuff[367] or MyBuff[384] or MyBuff[399] or MyBuff[3068] or MyBuff[122] or MyBuff[1802] or MyBuff[684] or MyBuff[4439] or MyBuff[6315] or MyBuff[6240] or MyBuff[5996] or MyBuff[6200] or MyBuff[6636] or MyBuff[6262] or MyBuff[2849] or MyBuff[3315] or MyBuff[8279] or MyBuff[8300] or MyBuff[8427] or MyBuff[8291] or MyBuff[2983] or MyBuff[10014]
--------------------------↑↑↑↑变量定义区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓应急技能区开始↓↓↓↓-------------------------

--回避控制
if not MianKongSelf and not MianShangSelf then 
    if s_util.GetTimer("tkongzhi1")>0 and s_util.GetTimer("tkongzhi1")<1000 then
        if s_util.CastSkill(9004, false) or s_util.CastSkill(9005, false) or s_util.CastSkill(9006, false) or s_util.CastSkill(9007, false) then
            return
        end
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 then
        if s_util.CastSkill(3977, false) or s_util.CastSkill(3973, false) or s_util.CastSkill(9004, false) or s_util.CastSkill(9005, false) or s_util.CastSkill(9006, false) or s_util.CastSkill(9007, false) then
            return
        end
    end
end

--回避伤害
if not JianShangSelf and not MianShangSelf and not MyBuff[12491] and not MyBuff[4052] then
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1500 then
        if s_util.CastSkill(3973,true) then return end
    end
end

--自动扶摇
if distance< 50 and not MyBuff[208] then
	if s_util.CastSkill(9002,true) then return end
end

--停手
if TingShouBuff then return end

--------------------------↑↑↑↑应急技能区结束↑↑↑↑-------------------------


--------------------------↓↓↓↓输出循环区开始↓↓↓↓-------------------------

--破魔
if s_util.CastSkill(3967,false) then return end


--日大
if distance< 8 and not JianShangTa then
    if s_util.CastSkill(18626,false) then return end
end
--月大
if distance< 12 and not JianShangTar then
    if s_util.CastSkill(18629,false) then return end
end

--驱夜
if s_util.CastSkill(3979,false) then return end

--银月斩优先月循环上仇
if CurrentMoon >= CurrentSun and CurrentMoon < 61 then
    if  s_util.CastSkill(3960,false)  then return end
end

-- 烈日斩，日灵>月灵时释放
if CurrentSun > CurrentMoon and CurrentSun < 61 then
    if  s_util.CastSkill(3963,false)  then return end
end

-- 日灵大于等于月灵且不满灵时打赤日轮
if CurrentSun >= CurrentMoon and CurrentSun < 100 then
    if  s_util.CastSkill(3962,false)  then return end
end

--月灵大于日灵且不满灵时打幽月轮
if CurrentSun < CurrentMoon and CurrentMoon < 100 then
    if s_util.CastSkill(3959,false) then return end
end