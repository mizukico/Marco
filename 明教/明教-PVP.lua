
--奇穴适用 [-][-][-][-][-][-][-][-][天地诛戮/生灭予夺][-][伏明众生][冥月渡心]
--不支持驱夷核弹，默认只对玩家施放技能，要攻击NPC需按下"F"键
--第7个奇穴选择善恶如梦会在25尺有敌对治疗时自动减疗，不需要可按住"G"取消减疗模式
--非战斗状态下自动隐身，按住“Alt”取消自动隐身，没有写隐身自动解控，按住“Z”可强制隐身
--默认自动日劫眩晕控制，不需要可按住"F"打破魔爆发
--默认战斗状态下自动追击绕背，按住“Alt”取消

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
--龙门跳伞
s_util.Cast(18876, false)

local player = GetClientPlayer()
if not player then return end

--脱战隐身
if (not player.bFightState and not s_util.GetBuffInfo(player)[4052] or IsKeyDown("Z")) and not IsAltKeyDown() then
    s_util.Cast(3974, false)
end

--贪魔体下停止追击
if s_util.GetBuffInfo(player)[4439] then return end

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
--免封内
local MianFengNei = s_tBuffFunc.MianFengNei
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

--如果没有目标或目标死亡，直接返回
if not target or target.nMoveState == MOVE_STATE.ON_DEATH then return end
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
local tfengche = nil
local mefengche = nil

--附近治疗
local near_zhiliao = nil
--------------------------↑↑↑↑变量定义区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓遍历处理区开始↓↓↓↓-------------------------

local npc = s_util.GetNpc(57739, 30) --获取30尺内的离手风车
local me = GetClientPlayer()
local zhiliao_kungfu = {[10176] = "补天", [10448] = "相知", [10028] = "离经", [10080] = "云裳" }
if npc and IsEnemy(me.dwID, npc.dwID) then
    if s_util.GetDistance(me, npc) <=10 then mefengche = 1 end
    if s_util.GetDistance(target, npc) <=10 then tfengche = 1 end
end

for i,v in ipairs(GetAllPlayer()) do	--遍历周围玩家
    local disme = s_util.GetDistance(me, v)
    if  disme < 25 and v.nMoveState ~= MOVE_STATE.ON_DEATH and IsEnemy(me.dwID, v.dwID) then
        local distar = s_util.GetDistance(target, v)
        local bPrepare,dwSkillId = GetSkillOTActionState(v)
        if dwSkillId == 1645 or dwSkillId == 16381 then --判断读条风车
            if disme <= 10 then mefengche = 2 end
            if distar <= 10 then tfengche = 2 end
        end
        if not near_zhiliao then --判断25尺内的敌方治疗
            if v.dwMountKungfuID then
                if zhiliao_kungfu[v.dwMountKungfuID] then
                    near_zhiliao = 1
                end
            else
                local kungfu = v.GetKungfuMount()
                if kungfu and zhiliao_kungfu[kungfu.dwSkillID] then
                    near_zhiliao = 1
                end
            end	
        end
    end
end

--------------------------↑↑↑↑遍历处理区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓追击位移区开始↓↓↓↓-------------------------

--调整面向
if target and not tfengche and not mefengche and IsEnemy(player.dwID, target.dwID) and not WuDi(target) and not IsAltKeyDown() then 
    s_util.TurnTo(target.nX,target.nY) 
end

--与目标距离>8尺,战斗中且目标附近无风车 使用流光，流光CD使用幻光步
if not tfengche and not mefengche and IsEnemy(player.dwID, target.dwID) and not WuDi(target) and not IsAltKeyDown() then
    if distance > 8 and player.bFightState then if s_util.Cast(3977,false) then return end end --流光
    if distance > 8 and player.bFightState then if s_util.Cast(3970,false) then return end end --幻光
    if distance > 8 and player.bFightState then if s_util.Cast(18633,false) then return end end --幻光

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
        if s_util.Cast(9004, false) or s_util.Cast(9005, false) or s_util.Cast(9006, false) or s_util.Cast(9007, false) then
            s_Output("回避控制")
            return
        end
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 and not tfengche then
        if s_util.Cast(3977, false) then s_Output("回避控制") return end
    end
    if s_util.GetTimer("tkongzhi2")>0 and s_util.GetTimer("tkongzhi2")<1000 then
        if s_util.Cast(3973, false) or s_util.Cast(3977, false) or s_util.Cast(3973, false) or s_util.Cast(9004, false) or s_util.Cast(9005, false) or s_util.Cast(9006, false) or s_util.Cast(9007, false) then
            s_Output("回避控制")
            return
        end
    end
end

--回避伤害
if not JianShang(player) and not WuDi(player) and not MyBuff[12491] and not MyBuff[4052] then
    --防月大，紫气，擒龙，乱洒
    if s_util.GetTimer("tbaofa1")>0 and hpRatio < 0.7 and thpRatio>0.3 and s_util.GetTimer("tbaofa1")<1500 then
        if s_util.Cast(3973,true) then s_Output("回避爆发") return end
    end
    --防隐身追命
    if s_util.GetTimer("tbaofa3")>3000 and s_util.GetTimer("tbaofa3")<5000 then
        if s_util.Cast(3973,true) then s_Output("回避隐身追命") return end
    end
    --防梵音
    if s_util.GetTimer("tbaofa2")>0 and s_util.GetTimer("tbaofa2")<5000 and thpRatio>0.3 and MyBuff[2920] then
        if s_util.Cast(3973,true) then s_Output("回避梵音") return end
    end
    --敌方无敌时开减伤
    if WuDi(target) and hpRatio < 0.70 then
        if s_util.Cast(3973,true) then s_Output("回避无敌") return end
    end
end

--回避风车，读条风车优先扶摇跳，离手风车直接蹑云贪墨
if mefengche==1 and not WuDi(player) then
    ChFace(128)
    if s_util.Cast(9003,false) or s_util.Cast(3973,true) then return end
end
if mefengche==2 and not WuDi(player) then
    if MyBuff[208] then 
        s_util.Jump()
    else
        ChFace(128)
        if s_util.Cast(9003,false) or s_util.Cast(3973,true) then return end
    end
end

--被封内后转身蹑云
if ChenMo(player) and ChenMo(player).nLeftTime > 2000 and distance < 4 then 
    ChFace(128) --改变面向180°
    if MyBuff[208] then 
        s_Output("回避封内")
        s_util.Jump()
        return
    else
        if s_util.Cast(9003,false) then s_Output("回避封内") return end
    end
end

--自动扶摇
if distance< 50 and not MyBuff[208] then
	s_util.Cast(9002,true)
end

--被顿蹑云
if player.nMoveState == MOVE_STATE.ON_SKILL_MOVE_DST then
    s_util.Cast(9003,false)
end 	

--自动吃鸡大药
if hpRatio < 0.4 and s_util.GetItemCount(5, 29036) > 1 and s_util.GetItemCD (5, 29036, true) < 0.5 then
    s_util.UseItem(5,29036)
end

--判断盾立buff刷新停手
if s_util.GetTimer("dunli") > 0 and s_util.GetTimer("dunli") <= 1500 then OutputWarningMessage("MSG_WARNING_RED", "盾立停手",1) s_util.StopSkill() return end

--无敌停手并输出警告
if WuDi(target) then 
    OutputWarningMessage("MSG_WARNING_RED", "目标无敌-"..Table_GetBuffName(WuDi(target).dwID, WuDi(target).nLevel),1)
    return 
end

--月大保命
if distance< 12 and hpRatio < 0.7 then
    s_util.Cast(18629,false)
end

--------------------------↑↑↑↑应急技能区结束↑↑↑↑-------------------------


--------------------------↓↓↓↓输出循环区开始↓↓↓↓-------------------------

--魂锁天策虎
if not MianKong(target) and not WuDi(target) and TargetBuffAll[203] and  thpRatio<0.2 and not MyBuff[12491] then
    s_util.Cast(4910,false)
end

--魂锁骑马目标
if not MianKong(target) and not WuDi(target) and TargetBuffAll[244] then
    s_util.Cast(4910,false)
end

--无免封内 无敌 沉默 眩晕 且目标非丐帮，双刀霸刀就释放缴械
if not MianFengNei(target) and (not ChenMo(target) or ChenMo(target).nLeftTime<500) and target.nMoveState ~= MOVE_STATE.ON_HALT and not WuDi(target) and target.dwForceID ~= FORCE_TYPE.GAI_BANG and  target.nPoseState ~= POSE_TYPE.DOUBLE_BLADE and not IsKeyDown("F") then
    s_util.Cast(3975,false)
end

--生灭后隐身
if s_util.SkillTimer(3978) < 1000 and not MyBuff[4052] then
    s_util.Cast(3974, false)
end

--如果目标血量少于50,并且缴械CD大于5秒,重置缴械cd	
if  thpRatio < 0.5 and s_util.GetSkillCD(3975) > 5 and target.dwForceID ~= FORCE_TYPE.GAI_BANG and  target.nPoseState ~= POSE_TYPE.DOUBLE_BLADE then
    s_util.Cast(3978, false)
end

--隐身，驱夜，缴械全部CD时生灭
if  s_util.GetSkillCD(3974) > 10 and  s_util.GetSkillCD(3979) > 2 and s_util.GetSkillCD(3975) > 2 and not ChenMo(target) then
    s_util.Cast(3978, false)
end

--满日且没有同辉，光明相
if (player.nSunPowerValue>0) and player.bFightState then
	s_util.Cast(3969,true)
end

--按下"F"不打生死劫，破魔爆发
--日劫减疗,按下G不挂减疗
if s_util.GetTalentIndex(7)==4 and player.nSunPowerValue >0 and not JianLiao(target) and not JinLiao(target)  and targetClass==TARGET.PLAYER and near_zhiliao and not MyBuff[4052] and (not IsKeyDown("G") or not IsKeyDown("F")) then
    s_util.Cast(3966,false)
    s_Output("日劫减疗")
end

--日劫眩晕
if player.nSunPowerValue >0 and not MianKong(target) and (not ChenMo(target) or ChenMo(target).nLeftTime<500) and (not XuanYun(target) or XuanYun(target).nLeftTime<500) and not SuoZu(target) and not DingShen(target) and not IsKeyDown("F") and targetClass==TARGET.PLAYER then
    s_util.Cast(3966,false) 
    s_Output("日劫眩晕")
end

--日大
if distance< 6 and not JianShang(target) and s_util.GetSkillCD(18629) > 2 and player.bFightState then
    s_util.Cast(18626,false)
end

--月大
if distance< 12 and not JianShang(target) and player.nMoonPowerValue >0 then
    s_util.Cast(18629,false)
end

--破魔 
s_util.Cast(3967,false)

--驱夜
if CurrentMoon < 100 and CurrentSun < 100 then
    s_util.Cast(3979,false)
end

--银月斩
if CurrentMoon < 100 and CurrentSun < 100 and CurrentSun < CurrentMoon then
    s_util.Cast(3960,false)
end
--烈日斩
if CurrentMoon < 100 and CurrentSun < 100 and CurrentSun > CurrentMoon then
    s_util.Cast(3963,false)
end

--银月斩
if CurrentMoon < 100 and CurrentSun < 100 then
    s_util.Cast(3960,false)
end
--烈日斩
if CurrentMoon < 100 and CurrentSun < 100 then
    s_util.Cast(3963,false)
end

--月灵大于等于日灵且不满灵时打幽月轮
if CurrentSun <= CurrentMoon and CurrentMoon < 100 then
    s_util.Cast(3959,false)
end

--日灵大于月灵且不满灵时打赤日轮
if CurrentSun > CurrentMoon and CurrentSun < 100 then
    s_util.Cast(3962,false)
end