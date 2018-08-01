
---还有隐身自己手动，没有写隐身自动解控
--脚本说明("奇穴适用 \n  [[血泪成悦][日月凌天][燎原烈火][善法肉身|超凡入圣][恶秽满路][辉耀红尘][善恶如梦][超然物外][天地诛戮][秘影诡行][伏明众生][冥月渡心]  \n  \n 增加减疗模式，此模式针对超凡入圣奇穴写的，可以上减疗(按下银月斩后就会进入减疗模式，按下破魔击或者生死劫就会切换回来普通的输出模式  \n  \n 如果需要手动流光，推荐在门派设置那里关闭流光追击，因为脚本的自动流光可以有效的回避某些职业的控制 \n 更新日记  3/26 修复隐身BUG导致脚本发呆问题 ")
--todo 防嘲讽 预判函数 改变面向函数

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--脱战隐身
if (not player.bFightState and not s_util.GetBuffInfo(player)[4052]) or IsKeyDown("Z") then
    if s_util.CastSkill(3974, false) then return end
end

--贪魔体下停止追击
if s_util.GetBuffInfo(player)[4439] then return end

if IsKeyDown("T") then
    SetTarget(TARGET.PLAYER, player.dwID)
    if s_util.CastSkill(18633,false) then return end 
end
--------------------↓↓↓↓函数声明区开始↓↓↓↓--------------------
--判断对象B是否在对象A的扇形面向内
--参数：对象A,对象B,面向角(角度制)
local function Is_B_in_A_FaceDirection(pA, pB, agl)
	local rd = (pA.nFaceDirection%256)*math.pi/128
    local dx = pB.nX - pA.nX;
    local dy = pB.nY - pA.nY;
	local length = math.sqrt(dx*dx+dy*dy);
    return math.acos(dx/length*math.cos(rd)+dy/length*math.sin(rd)) < agl*math.pi/360;
end

--爆发
local BaoFa = s_tBuffFunc.BaoFa
--减疗
local JianLiao = s_tBuffFunc.JianLiao
--禁疗
local JinLiao = s_tBuffFunc.JinLiao
--无敌
local WuDi = s_tBuffFunc.WuDi
--沉默
local ChenMo = s_tBuffFunc.ChenMo
--免控
local MianKong = s_tBuffFunc.MianKong
--减伤
local JianShang = s_tBuffFunc.JianShang
--减速
local JianSu = s_tBuffFunc.JianSu
--眩晕
local XuanYun = s_tBuffFunc.XuanYun
--锁足
local SuoZu = s_tBuffFunc.SuoZu
--定身
local DingShen = s_tBuffFunc.DingShen
--闪避
local ShanBi = s_tBuffFunc.ShanBi
--封轻功
local FengQingGong = s_tBuffFunc.FengQingGong
--改变面向
local ChFace = s_tBuffFunc.ChFace
--------------------↑↑↑↑函数声明区结束↑↑↑↑--------------------

--------------------↓↓↓↓目标处理区开始↓↓↓↓--------------------

--获取当前目标,未进战没目标直接返回,战斗中没目标选择血量最少的玩家,调整面向
--按下"F"可选择NPC
local target, targetClass = s_util.GetTarget(player)	
if IsKeyDown("F") then	
    if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
    if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
        local MinDistance = 20			--最小距离
        local MindwID = 0		    --最近NPC的ID
        for i,v in ipairs(GetAllNpc()) do		--遍历所有NPC
            if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then
                MinDistance = s_util.GetDistance(v, player)   
                MindwID = v.dwID     --替换距离和ID
            end
        end
        if MindwID == 0 then 
            return --没有敌对NPC则返回
        else	
            SetTarget(TARGET.NPC, MindwID)
        end
    end
else
    if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID)) and targetClass~=TARGET.PLAYER then return end
    if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) or targetClass~=TARGET.PLAYER or target.nMoveState == MOVE_STATE.ON_DEATH then  
        local MinDistance = 20		
        local MindwID = 0
        local MinHp = 80000		    
        for i,v in ipairs(GetAllPlayer()) do		--遍历
            if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMoveState ~= MOVE_STATE.ON_DEATH and v.nCurrentLife < MinHp then
                MinHp = v.nCurrentLife
                MindwID = v.dwID
            end
        end
        if MindwID == 0 then 
            return
        else
            SetTarget(TARGET.PLAYER, MindwID)  --设定目标
        end
    end
end
local target, targetClass = s_util.GetTarget(player)
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

--定义目标的血量比
local thpRatio = target.nCurrentLife / target.nMaxLife

--简化日月能量
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--风车
local tfengche = s_tBuffFunc.FengChe(target)
local mefengche = s_tBuffFunc.FengChe(player)
--------------------------↑↑↑↑变量定义区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓追击位移区开始↓↓↓↓-------------------------

--与目标距离>8尺,战斗中且目标附近无风车 使用流光，流光CD使用幻光步
if not tfengche and not mefengche and IsEnemy(player.dwID, target.dwID) and not WuDi(target) then
    if distance > 8 and player.bFightState then if s_util.CastSkill(3977,false) then return end end --流光
    if distance > 8 and player.bFightState then if s_util.CastSkill(3970,false) then return end end --幻光

    --追击+托马斯
    if not IsKeyDown("W") then
        if Is_B_in_A_FaceDirection(target, player, 180) or distance > 3.5 then
            s_util.TurnTo(target.nX,target.nY) 
            MoveForwardStart()
        else
            MoveForwardStop()
            s_util.TurnTo(target.nX,target.nY)
        end
    end
end
--------------------------↑↑↑↑追击位移区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓应急技能区开始↓↓↓↓-------------------------

--回避控制
if not MianKong(player) and not WuDi(player) then 
    if s_util.GetTimer("tkongzhi1")>0 and s_util.GetTimer("tkongzhi1")<1000 then
        if s_util.CastSkill(9004, false) or s_util.CastSkill(9005, false) or s_util.CastSkill(9006, false) or s_util.CastSkill(9007, false) then
            s_Output("回避控制")
            return
        end
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 and not tfengche then
        if s_util.CastSkill(3977, false) then s_Output("回避控制") return end
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 then
        if s_util.CastSkill(3973, false) or s_util.CastSkill(3977, false) or s_util.CastSkill(3973, false) or s_util.CastSkill(9004, false) or s_util.CastSkill(9005, false) or s_util.CastSkill(9006, false) or s_util.CastSkill(9007, false) then
            s_Output("回避控制")
            return
        end
    end
end

--回避伤害
if not JianShang(player) and not WuDi(player) and not MyBuff[12491] and not MyBuff[4052] then
    --防月大，紫气，擒龙，乱洒
    if s_util.GetTimer("tbaofa1")>0 and hpRatio < 0.7 and thpRatio>0.3 and s_util.GetTimer("tbaofa1")<1500 then
        if s_util.CastSkill(3973,true) then s_Output("回避伤害") return end
    end
    --防隐身追命
    if s_util.GetTimer("tbaofa3")>3000 and s_util.GetTimer("tbaofa3")<5000 then
        if s_util.CastSkill(3973,true) then s_Output("回避伤害") return end
    end
    --防梵音
    if s_util.GetTimer("tbaofa2")>0 and s_util.GetTimer("tbaofa2")<5000 and thpRatio>0.3 and MyBuff[2920] then
        if s_util.CastSkill(3973,true) then s_Output("回避伤害") return end
    end
    --敌方无敌时开减伤
    if WuDi(target) and hpRatio < 0.75 then
        if s_util.CastSkill(3973,true) then s_Output("回避伤害") return end
    end
end

--回避风车，读条风车优先扶摇跳，离手风车直接蹑云贪墨
if mefengche==2 and not WuDi(player) then
    if MyBuff[208] then 
        s_util.Jump()
    else
        if s_util.CastSkill(9003,false) or s_util.CastSkill(3973,true) then return end
    end
end
if mefengche==1 and not WuDi(player) then
        if s_util.CastSkill(9003,false) or s_util.CastSkill(3973,true) then return end
end

--被封内后转身蹑云
if ChenMo(player) and  ChenMo(player).nLeftTime > 2000 then 
    ChFace(128)
    if MyBuff[208] then 
        s_util.Jump()
    else
        if s_util.CastSkill(9003,false) then return end
    end
end

--自动扶摇
if distance< 50 and not MyBuff[208] then
	if s_util.CastSkill(9002,true) then return end
end

--被顿蹑云
if player.nMoveState == MOVE_STATE.ON_SKILL_MOVE_DST then
    if s_util.CastSkill(9003,false) then return end
end 	

--自动吃鸡大药
if hpRatio < 0.4 and s_util.GetItemCount(5, 29036) > 1 and s_util.GetItemCD (5, 29036, true) < 0.5 then
    s_util.UseItem(5,29036)
end
--判断盾立buff刷新停手
if s_util.GetTimer("dunli") > 0 and s_util.GetTimer("dunli") <= 1500 then OutputWarningMessage("MSG_WARNING_RED", "盾立停手") s_util.StopSkill() return end

--停手
if WuDi(target) then OutputWarningMessage("MSG_WARNING_RED", "目标无敌") s_util.StopSkill() return end

--月大保命
if distance< 12 and hpRatio < 0.7 then
    if s_util.CastSkill(18629,false) then return end
end

--------------------------↑↑↑↑应急技能区结束↑↑↑↑-------------------------


--------------------------↓↓↓↓输出循环区开始↓↓↓↓-------------------------

--魂锁天策虎
if not MianKong(target) and not WuDi(target) and TargetBuffAll[203] and  thpRatio<0.2 and not MyBuff[12491] then
    if s_util.CastSkill(4910,false) then return end 
end

--魂锁骑马目标
if not MianKong(target) and not WuDi(target) and TargetBuffAll[244] then
    if s_util.CastSkill(4910,false) then return end 
end

--生灭后隐身
if s_util.GetSkillCD(3978) > 115 and not MyBuff[4052] then
    if s_util.CastSkill(3974, false) then return end
end

--隐身，驱夜，缴械全部CD时生灭
if  s_util.GetSkillCD(3974) > 10 and  s_util.GetSkillCD(3979) > 2 and s_util.GetSkillCD(3975) > 2 and not ChenMo(target) then
    if s_util.CastSkill(3978, false) then return end
end

--无免控 沉默 眩晕 无敌就释放缴械
if not MianKong(target) and not ChenMo(target) and not XuanYun(target) and not WuDi(target) and not IsKeyDown("F") then
    if s_util.CastSkill(3975,false) then return end 
end

--满日或满月且没有同辉，光明相
if (player.nSunPowerValue>0) then
	if s_util.CastSkill(3969,true) then return end
end

--按下"F"不打生死劫，破魔爆发
if not IsKeyDown("F") and s_util.GetTalentIndex(7)==4 then
    --日劫减疗
    if player.nSunPowerValue >0 and not JianLiao(target) and not JinLiao(target) then
        if s_util.CastSkill(3966,false) then return end 
    end
end

--日劫眩晕
if player.nSunPowerValue >0 and not MianKong(target) and not ChenMo(target) and not XuanYun(target) and not SuoZu(target) and not DingShen(target) and not IsKeyDown("F") then
    if s_util.CastSkill(3966,false) then return end 
end

--日大
if distance< 6 and not JianShang(target) and CurrentMoon < 100 then
    if s_util.CastSkill(18626,false) then return end
end

--月大
if distance< 12 and not JianShang(target) and player.nMoonPowerValue >0 then
    if s_util.CastSkill(18629,false) then return end
end

--破魔
if s_util.CastSkill(3967,false) then return end

--驱夜
if CurrentMoon < 100 and CurrentSun < 100 then
    if s_util.CastSkill(3979,false) then return end
end

--银月斩
if CurrentMoon < 100 and CurrentSun < 100 then
    if s_util.CastSkill(3960,false) then return end
end
--烈日斩
if CurrentMoon < 100 and CurrentSun < 100 then
    if s_util.CastSkill(3963,false) then return end
end

--月灵大于等于日灵且不满灵时打幽月轮
if CurrentSun <= CurrentMoon and CurrentMoon < 100 then
    if s_util.CastSkill(3959,false) then return end
end

--日灵大于月灵且不满灵时打赤日轮
if CurrentSun > CurrentMoon and CurrentSun < 100 then
    if  s_util.CastSkill(3962,false)  then return end
end