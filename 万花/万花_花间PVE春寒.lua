--奇穴：弹指 雪中行 倚天 焚玉 青歌 青冠 春寒 雪弃 生息 梦歌 踏歌 涓流
--属性：加速要求249
--秘籍：3毒持续时间+3S，阳明、钟林、兰催减读条时间

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end
--------------------------↓↓↓↓目标处理区开始↓↓↓↓-------------------------

--获取当前目标,未进战没目标直接返回,战斗中没目标选择最近敌对NPC,调整面向
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end 
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
local MinDistance = 20			--最小距离
local MindwID = 0		    --最近NPC的ID
for i,v in ipairs(GetAllNpc()) do		--遍历所有NPC
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMaxLife>1000 then
		MinDistance = s_util.GetDistance(v, player)                             
		MindwID = v.dwID                           --如果敌对并且距离更近则替换距离和ID
		end
	end
if MindwID == 0 then 
    return                          --没有敌对NPC则返回
else	
    SetTarget(TARGET.NPC, MindwID)  --设定目标为最近的敌对NPC                
end
end
if target then s_util.TurnTo(target.nX,target.nY) end  --调整面向

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end
--------------------------↑↑↑↑目标处理区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓变量定义区开始↓↓↓↓-------------------------

--初始化爆发全局变量
if not g_MacroVars.State_baofa then
    g_MacroVars.State_baofa = 0
    g_MacroVars.State_guodu = 0
end

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

--定义自己的蓝量比
local ManaRatio = player.nCurrentMana / player.nMaxMana
--------------------------↑↑↑↑变量定义区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓应急技能区开始↓↓↓↓-------------------------

--血量小于30%对自己释放春泥护花
if hpRatio < 0.3 then 
    if s_util.CastSkill(132,true) then return end
end

--蓝量小于30%对自己释放碧水
if ManaRatio < 0.3 then
    if s_util.CastSkill(131,true) then return end
end

--自己没有清心补清心
if not MyBuff[112] then
    if s_util.CastSkill(130,true) then return end
end

--按下"Alt"+"Q" 蹑云
if(IsAltKeyDown() and IsKeyDown("Q")) then
	s_util.CastSkill(9003,false,true)
end

--按下“Alt”+“E” 扶摇跳
if(IsAltKeyDown() and IsKeyDown("E")) then
	s_util.CastSkill(9002,true,false)
	if(playerBuffs[208]) then Jump() end
end

--后跳躲珈罗兰猎物
if MyBuff[13034] and MyBuff[13034].nLeftTime > 2.5 then
	--打断读条
	s_util.StopSkill()
	--后跳
	if s_util.CastSkill(9007, false) then return end 
end

--按下"Alt"停手
if IsAltKeyDown() then
	return
end
--------------------------↑↑↑↑应急技能区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓自动位移区开始↓↓↓↓-------------------------

--[[
--与目标距离超过15尺自动靠近目标（影响走位控制，团本慎用）
if distance > 15 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end
--]]

--------------------------↑↑↑↑自动位移区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓输出循环区开始↓↓↓↓-------------------------

--水月CD小于等于7.8S且目标无3毒且玉石无CD进入爆发循环
if s_util.GetSkillCD(136) <=7.8 and s_util.GetSkillCD(182) <=0 and not TargetBuff[666] and not TargetBuff[714] and not TargetBuff[711] then
    g_MacroVars.State_baofa = 1 
    g_MacroVars.State_guodu = 0
end
--爆发结束且3毒不全时进入普通循环
if g_MacroVars.State_baofa == 15 and (not TargetBuff[666] or not TargetBuff[714] or not TargetBuff[711]) then
    g_MacroVars.State_guodu = 1
end
s_Output(g_MacroVars.State_baofa)
s_Output(g_MacroVars.State_guodu)
--↓↓爆发循环开始↓↓
--(190) 兰摧玉折
if g_MacroVars.State_baofa == 2 then
    if s_util.CastSkill(190,false) then g_MacroVars.State_baofa = 3 return end
end
--(189) 钟林毓秀
if g_MacroVars.State_baofa == 1 then
    if s_util.CastSkill(189,false) then g_MacroVars.State_baofa = 2 return end
end
--(180) 商阳指
if g_MacroVars.State_baofa == 3 then
    if s_util.CastSkill(180,false) and TargetBuff[666] then g_MacroVars.State_baofa = 4 return end
end
--(182) 玉石俱焚
if g_MacroVars.State_baofa == 4 then
    if s_util.CastSkill(182,false) and s_util.GetSkillCD(182) >0 then g_MacroVars.State_baofa = 5 return end
end
--(189) 钟林毓秀
if g_MacroVars.State_baofa == 5 then
    if s_util.CastSkill(189,false) then g_MacroVars.State_baofa = 6 return end
end
--(190) 兰摧玉折
if g_MacroVars.State_baofa == 6 then
    if s_util.CastSkill(190,false) then g_MacroVars.State_baofa = 7 return end
end
--(180) 商阳指
if g_MacroVars.State_baofa == 7 then
    if s_util.CastSkill(180,false) and TargetBuff[666] then g_MacroVars.State_baofa = 8 return end
end
--(136) 水月无间
if g_MacroVars.State_baofa == 8 then
    if s_util.CastSkill(136,false) then g_MacroVars.State_baofa = 9 return end
end
--(2645) 乱洒青荷
if g_MacroVars.State_baofa == 9 then
    if s_util.CastSkill(2645,false) then g_MacroVars.State_baofa = 10 return end
end
--(2636) 快雪时晴
if g_MacroVars.State_baofa == 10 then
    if s_util.CastSkill(2636,false) then g_MacroVars.State_baofa = 11 return end
end
--(2636) 快雪时晴断读条
if g_MacroVars.State_baofa == 11 and dwSkillIdMe==2636 and nLeftTimeMe<=0.398 then
    if s_util.CastSkill(2636,false,true) then g_MacroVars.State_baofa = 12 return end
end
--(182) 玉石俱焚断读条
if g_MacroVars.State_baofa == 12 and dwSkillIdMe==2636 and nLeftTimeMe<=0.398 then
    if s_util.CastSkill(182,false,true) then g_MacroVars.State_baofa = 13 return end
end
--(180) 商阳指
if g_MacroVars.State_baofa == 13 then
    if s_util.CastSkill(180,false) then g_MacroVars.State_baofa = 14 return end
end
--(179) 阳明指
if g_MacroVars.State_baofa == 14 then
    if s_util.CastSkill(179,false) then g_MacroVars.State_baofa = 15 return end
end
--↑↑爆发循环结束↑↑

--↓↓普通循环开始↓↓
--(190) 兰摧玉折
if g_MacroVars.State_guodu == 1  then
    if bPrepareMe and dwSkillIdMe==2636 and nLeftTimeMe<0.2 then
        if s_util.CastSkill(190,false,true) then 
            g_MacroVars.State_baofa = 16 
            g_MacroVars.State_guodu = 2 
            return 
        end
    else
        if s_util.CastSkill(190,false,true) then 
            g_MacroVars.State_baofa = 16 
            g_MacroVars.State_guodu = 2 
            return 
        end
    end
end
--(189) 钟林毓秀
if g_MacroVars.State_guodu == 2 then
    if s_util.CastSkill(189,false) then g_MacroVars.State_guodu = 3 return end
end
--(180) 商阳指
if g_MacroVars.State_guodu == 3 then
    if s_util.CastSkill(180,false) then g_MacroVars.State_guodu = 4 return end
end
--(182) 玉石俱焚
if g_MacroVars.State_guodu == 4 then
    if s_util.CastSkill(182,false) then g_MacroVars.State_guodu = 5 return end
end
--(189) 钟林毓秀
if g_MacroVars.State_guodu == 5 then
    if s_util.CastSkill(189,false) then g_MacroVars.State_guodu = 6 return end
end
--(190) 兰摧玉折
if g_MacroVars.State_guodu == 6 then
    if s_util.CastSkill(190,false) then g_MacroVars.State_guodu = 7 return end
end
--(180) 商阳指
if g_MacroVars.State_guodu == 7 then
    if s_util.CastSkill(180,false) then g_MacroVars.State_guodu = 8 return end
end
--↑↑普通循环结束↑↑

--满3毒 (2636) 快雪时晴
if TargetBuff[666] and TargetBuff[711] and TargetBuff[714] then
    if s_util.CastSkill(2636,false) then return end
end