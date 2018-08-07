--[[
奇穴：【圣光明】【慈悲心】【寂灭】【月尽天明】【归寂道】【极乐引】【纵遇善缘】【妙境惊寂】【渡厄力】【日月同辉】【无量妙境】【心火叹】
1.奇穴根据需要自行调整，第11层奇穴“无量妙境”会影响攒灵循环；
2.默认自动慈悲愿，手动光明相。
3.默认满灵打生死劫，按下F后可切换为双破魔。
--]]

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--当前血量比值
local hpRatio = player.nCurrentLife / player.nMaxLife

--获取当前目标,未进战没目标直接返回,战斗中没目标选择最近敌对NPC,调整面向
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end --
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
local MinDistance = 20			--最小距离
local MindwID = 0		    --最近NPC的ID
for i,v in ipairs(GetAllNpc()) do		--遍历所有NPC
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then	--如果是敌对，并且距离更小
		MinDistance = s_util.GetDistance(v, player)                             
		MindwID = v.dwID                                                                      --替换距离和ID
		end
	end
if MindwID == 0 then 
    return --没有敌对NPC则返回
else	
    SetTarget(TARGET.NPC, MindwID)  --设定目标为最近的敌对NPC                
end
end
if target then s_util.TurnTo(target.nX,target.nY,target.nZ) end

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--判断目标读条，这里没有做处理，可以判断读条的技能ID做相应处理(打断、迎风回浪、挑起等等)
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--返回 是否在读条, 技能ID，等级，剩余时间(秒)，动作类型

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取自己对目标造成的buff表
local TargetBuff = s_util.GetBuffInfo(target, true)

--获取目标全部的buff表
local TargetBuffAll = s_util.GetBuffInfo(target)

--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--获取我的读条数据
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)	

--如果自己在读条直接返回，避免打断朝圣言
if bPrepareMe then return end --基本没用，还是自己停按键吧

--取消自己身上的无威胁气劲buff
if MyBuff[4487] then s_util.CancelBuff(4487) end  --明教极乐
if MyBuff[917] then s_util.CancelBuff(917) end    --大师阵
if MyBuff[8422] then s_util.CancelBuff(8422) end  --苍云盾墙
if MyBuff[926] then s_util.CancelBuff(926) end    --天策阵
if MyBuff[4101] then s_util.CancelBuff(4101) end  --天策引羌笛


--戒火斩
if not TargetBuff[4058] or (TargetBuff[4058] and TargetBuff[4058].nLeftTime < 1)then
	if s_util.CastSkill(3980,false) then return end
end

--满灵前使用心火叹
if player.nSunPowerValue > 0 or player.nMoonPowerValue > 0 or MyBuff[9909] and MyBuff[9909].nLeftTime < 12.97 and player.nCurrentSunEnergy > player.nCurrentMoonEnergy then
    if s_util.CastSkill(14922,false) then return end
end

--按下F切换为破魔循环
if IsKeyDown("F") then 
    --破魔
    if s_util.CastSkill(3967,false) then return end
else
    --生死劫
    if s_util.CastSkill(3966,false) then return end
end

--慈悲愿
if s_util.CastSkill(3982,false) then return end

--银月斩优先月循环上仇
if CurrentMoon >= CurrentSun and CurrentMoon < 61  then
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