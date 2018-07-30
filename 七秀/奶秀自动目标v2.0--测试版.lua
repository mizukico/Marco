--奶秀自动选择目标 v2.0
--（2018.07.20）修改了月影入侵，以及迦楼罗后跳；优化 盛夏or双孪 的写法，修复之前乱开梵音的bug，修改回雪瞎奶
--推荐奇穴 朝露——盛夏or双孪——辞致——瑰姿——乞巧——散余霞——晚晴——碎冰——霜风——秋深——焕颜——余寒映日
--双孪脚本优势大
--获取自己的Player对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--获取自身读条信息
local bPrepare2, dwSkillId2, dwLevel2, nLeftTime2, nActionState2 = GetSkillOTActionState(player)
--断读条
if dwSkillId2 == 565 or dwSkillId2 == 18222 then
	if bPrepare2 and nLeftTime2 < 0.34 then
		s_util.StopSkill()
	else return
	end
end
--如果当前门派不是七秀，输出错误信息
if player.dwForceID ~= FORCE_TYPE.QI_XIU then
	s_util.OutputTip("当前门派不是七秀，这个宏无法正确运行。", 1)
	return
end

--月影入侵
local yueying = nil
for _, v in ipairs(GetAllPlayer()) do
	local TargetBuff = s_util.GetBuffInfo(v)
	if TargetBuff[12891] and TargetBuff[12891].nLeftTime < 3.5 then
		yueying = v
		break
	end
end

--自己血量比值
local myhp = player.nCurrentLife / player.nMaxLife

--获取 团队中血量最低的玩家，团血
local duiyou, teamHP = s_util.GetTeamMember()
if not duiyou then duiyou = GetClientPlayer() end	
local dhp = duiyou.nCurrentLife / duiyou.nMaxLife

if yueying then
	s_util.SetTarget(TARGET.PLAYER, yueying.dwID)
else	
	--自动选择团队中血量最少的目标
	if myhp > dhp then
		if dhp < 0.97 then
			SetTarget(TARGET.PLAYER, duiyou.dwID)
		end
	else
		if myhp < 0.97 then
			SetTarget(TARGET.PLAYER, player.dwID)
		end
	end
end
--获取当前目标，目标类型 没有目标设置自己为目标
local target, targetClass = s_util.GetTarget(player)		
if not target then SetTarget(TARGET.PLAYER, player.dwID) return end	
local thp = target.nCurrentLife / target.nMaxLife

--判断是否敌对，敌对选自己为目标
if IsEnemy(player.dwID, target.dwID) then SetTarget(TARGET.PLAYER, player.dwID) return end

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)
local mMyBuff = s_util.GetBuffInfo(player, true)
--获取目标的buff表
local TargetBuff = s_util.GetBuffInfo(target)
local mTargetBuff = s_util.GetBuffInfo(target, true)
--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--驱散部分
if TargetBuff[12891] and TargetBuff[12891].nLeftTime <= 2 then
	if s_util.CastSkill(566, false, true) then return end
end

--大战保命部分
local npc = s_util.GetNpc(52087) or s_util.GetNpc(52088) or s_util.GetNpc(51211)
if npc then
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState = GetSkillOTActionState(npc)
	local bt = s_util.GetTarget(npc)
	if bPrepare and(dwSkillId == 16449 or dwSkillId == 16398 or dwSkillId == 16029) then
		SetTarget(TARGET.PLAYER, bt.dwID)
		local TargetBuff = s_util.GetBuffInfo(bt)
		if not TargetBuff[684] then
			if s_util.CastSkill(555, false, true) then return end --风袖
			if s_util.CastSkill(569, false, true) then return end --王母
		end
	end
end
--后跳躲珈罗兰猎物
if MyBuff[13034] and MyBuff[13034].nLeftTime > 2.5 then
	--打断读条
	if bPrepare2 then
		s_util.StopSkill()
	end
	--后跳
	if s_util.CastSkill(9007, false) then return end
end

--补袖气
if not MyBuff[673] then
	if s_util.CastSkill(545, true) then return end
end

--如果目标死亡，执行下一个
if target.nMoveState ~= MOVE_STATE.ON_DEATH then
	--目标血量低于30%且无减伤用[风袖低昂]
	if thp < 0.3 and not mTargetBuff[684] then
		if s_util.CastSkill(555, false) then return end
	end
	if myhp < 0.7 and not mMyBuff[684] then --我的血量低于70%且无减伤用[天地低昂]
		if s_util.CastSkill(557, true) then return end
	end
	--目标血量低于60%且无减伤 [风袖低昂]爆翔舞
	if thp < 0.6 and not mTargetBuff[684] then
		if(not mTargetBuff[680] or mTargetBuff[680].nLeftTime <= 5) and s_util.GetSkillCD(555) <= 0 then
			if s_util.CastSkill(554, false) then end
		end
		if mTargetBuff[680] and mTargetBuff[680].nLeftTime > 5 then
			if s_util.CastSkill(555, false) then return end
		end
	end
	--王母
	if thp < 0.6 then
		if s_util.CastSkill(569, false) then return end
	end
	--[余寒映日]
	if MyBuff[6436] and thp < 0.45 then
		if s_util.CastSkill(18221, false) then return end
	end
	--[繁音急节]
	if not mTargetBuff[684] and s_util.GetSkillCD(569) > 1.5 and s_util.GetSkillCD(555) > 1.5 and thp < 0.5 then
		--[繁音急节]
		if s_util.CastSkill(568, false) then return end	
		--[余寒映日]	
		if s_util.CastSkill(18221, false) then return end	
	end
	--补自己上元保证回蓝
	if not mMyBuff[681] then
		if s_util.CastSkill(556, true) then return end
	end
	
	--根据奇穴
	if s_util.GetTalentIndex(2) == 1 then
		--无翔舞补翔舞
		if not mTargetBuff[680] then
			if s_util.CastSkill(554, false) then return end
		end
		--上元
		if not mTargetBuff[681] then
			if s_util.CastSkill(556, false) then return end
		end
	else
		--上元
		if not mTargetBuff[681] then
			if s_util.CastSkill(556, false) then return end
		end
		--无翔舞补翔舞
		if not mTargetBuff[680] then
			if s_util.CastSkill(554, false) then return end
		end
	end
	
	--无限回雪
	if s_util.CastSkill(554, false) then return end
	if MyBuff[12287] then
		if s_util.CastSkill(18222, false) then return end
	end
	if s_util.CastSkill(565, false) then return end
end 