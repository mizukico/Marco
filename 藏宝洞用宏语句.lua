--获取玩家，没有玩家说明没进入游戏
local player = GetClientPlayer()
if not player then return end

--获取自己血量百分比
local hpRatio = player.nCurrentLife / player.nMaxLife

--获取目标，战斗中没有目标选择最近的敌对NPC
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end 
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
	local MinDistance = 20			--最小距离
	local MindwID = 0		    --NPC的ID
	for i,v in ipairs(GetAllNpc()) do		--遍历NPC
		if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance then	--敌对且距离更近
			MinDistance = s_util.GetDistance(v, player)                             
			MindwID = v.dwID                                                                    --替换最小距离和ID
		end
	end
	if MindwID == 0 then 
		return --没有敌对NPC返回
	else	
    	SetTarget(TARGET.NPC, MindwID)  --设置目标为最近NPC                
	end
end
if target then s_util.TurnTo(target.nX,target.nY) end  --调整面向

--目标死亡直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--获取目标的读条信息
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)

--获取自己的读条信息
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)	

--获取自己的BUFF列表
local MyBuff = s_util.GetBuffInfo(player)

--获取自己对目标造成的BUFF列表
local TargetBuff = s_util.GetBuffInfo(target, true)

--获取目标全部的BUFF列表
local TargetBuffAll = s_util.GetBuffInfo(target)

--获取自己与目标的距离
local distance = s_util.GetDistance(player, target)

--DPS老虎处理
local laohu=s_util.GetNpc(36688,40)
if laohu then SetTarget(TARGET.NPC, laohu.dwID) s_util.TurnTo(laohu.nX,laohu.nY) end

--距离超过3.5尺向前靠近目标
if distance > 3.5 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end

--藏宝洞BOSS读条处理
if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end   --野人谷毁天灭地后跳

--藏宝洞BOSS道具处理
if TargetBuffAll[7929] then if s_util.UseItem(5,21534) then return end end	--夜狼山无敌驱散

--藏宝洞地形伤害规避
local xianjing = 0
for i,v in ipairs(GetAllNpc()) do		--遍历周围NPC
	if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5尺内有火圈
		xianjing = 1                                                                
	end
	if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5尺内有地刺
		xianjing = 1                                                                
	end
end
if xianjing ==1 then
	s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
else
	StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
end

--DPS野人谷BOSS OT扶摇
if target.dwTemplateID==36680 and s_util.GetTarget(target).dwID== player.dwID then
    s_util.CastSkill(9002,false,true)
	if(playerBuffs[208]) then Jump() end
	return
end