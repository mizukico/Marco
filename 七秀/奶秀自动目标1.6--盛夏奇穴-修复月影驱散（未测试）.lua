--自动选择目标 v1.6
--更新：调整了翔舞与上元的顺序更适合pve使用
--（2018.07.08）更新 月影入侵 自动驱散 （未测试） 后跳躲珈罗兰猎物
--更新 自身血量低选自己为目标，爆翔舞写法（未测试），自动补袖气
--推荐奇穴 朝露——盛夏or双孪——辞致——瑰姿——乞巧——散余霞——晚晴——碎冰——霜风——秋深——焕颜——余寒映日
--双孪脚本优势大

if not g_MacroVars.State_680 then
	g_MacroVars.State_680 = 0				--翔舞标记
end

--获取自己的Player对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--获取自身读条信息
local bPrepare2, dwSkillId2, dwLevel2, nLeftTime2, nActionState2 =  GetSkillOTActionState(player)
--断读条
if dwSkillId2 == 565 or dwSkillId2 == 18222 then
	if nLeftTime2 < 0.333 then
		s_util.StopSkill()
		else return
	end
end
--如果当前门派不是七秀，输出错误信息
if player.dwForceID ~= FORCE_TYPE.QI_XIU then
	s_util.OutputTip("当前门派不是七秀，这个宏无法正确运行。", 1)
	return
end

--月影入侵BUFF剩余时间小于3.5S时选中
local yueying = nil
for _,v in ipairs(GetAllPlayer()) do
    local TargetBuffyue = s_util.GetBuffInfo(v)
    if TargetBuffyue[12891] and TargetBuffyue[12891].nLeftTime < 3.5 then
        yueying = v
        break
    end
end
--月影入侵BUFF剩余时间小于2S时驱散，期间不再切换目标
if yueying then 
    s_util.SetTarget(TARGET.PLAYER, yueying.dwID)
    if s_util.GetBuffInfo(yueying)[12891] and s_util.GetBuffInfo(yueying)[12891].nLeftTime < 2 then 
        if s_util.CastSkill(566,false,true) then return end  
    end
    return
end

--自己血量比值
local myhp = player.nCurrentLife / player.nMaxLife

--获取 团队中血量最低的玩家，团血（有问题）
local duiyou,teamHP = s_util.GetTeamMember()
if not duiyou then duiyou = GetClientPlayer() end	
local dhp = duiyou.nCurrentLife / duiyou.nMaxLife

--自身血量和队友血量比对
if myhp >= dhp then
	--自动选择团队中血量最少的目标
	if dhp < 0.97 then
		SetTarget(TARGET.PLAYER,duiyou.dwID)
	end
	else SetTarget(TARGET.PLAYER,player.dwID)
end

--获取当前目标，目标类型 没有目标设置自己为目标
local target, targetClass = s_util.GetTarget(player)		
if not target then SetTarget(TARGET.PLAYER,player.dwID) return end	
local thp = target.nCurrentLife / target.nMaxLife

--判断是否敌对，敌对选自己为目标
if  IsEnemy(player.dwID, target.dwID) then SetTarget(TARGET.PLAYER,player.dwID) end

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)
local mMyBuff = s_util.GetBuffInfo(player,true)
--获取目标的buff表
local TargetBuff = s_util.GetBuffInfo(target)
local mTargetBuff = s_util.GetBuffInfo(target,true)
--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--后跳躲珈罗兰猎物
if MyBuff[13034] and MyBuff[13034].nLeftTime > 2.5 then
	--打断读条
	s_util.StopSkill()
	--后跳
	if s_util.CastSkill(9007, false) then return end 
end

--补袖气
if not MyBuff[673] then
	if s_util.CastSkill(545,true) then return end
end

--如果目标死亡，执行下一个
if target.nMoveState ~= MOVE_STATE.ON_DEATH then 
	--目标血量低于30%且无减伤用[风袖低昂]
	if thp < 0.3 and not mTargetBuff[684] and not TargetBuff[9694] then 
		if s_util.CastSkill(555,false) then return end
	end
	if myhp < 0.7 and not mMyBuff[684] then --我的血量低于70%且无减伤用[天地低昂]
		if s_util.CastSkill(557,true) then return end
	end
	--目标血量低于60%且无减伤 [风袖低昂]爆翔舞
	if thp < 0.6 and not mTargetBuff[684] and s_util.GetSkillCD(555) <= 0 then 
		if not TargetBuff[680] or TargetBuff[680].nLeftTime <= 5 then 
			if s_util.CastSkill(554,false) then 
				g_MacroVars.State_680 = 1
			end
		end
		if  TargetBuff[680] and (g_MacroVars.State_680 == 1 or TargetBuff[680].nLeftTime > 5 ) then
			if s_util.CastSkill(555,false) then 
				g_MacroVars.State_680 = 0
				return 
			end
		end
	end
	--王母
	if thp < 0.6 then
		if s_util.CastSkill(569,false) then return end
	end
	--[余寒映日]
	if MyBuff[6436] and thp < 0.45 then 
		if s_util.CastSkill(18221,false) then return end
	end
	--[繁音急节]
	if s_util.GetSkillCD(569) > 0 and s_util.GetSkillCD(555) > 0 and target.nMoveState ~= MOVE_STATE.ON_DEATH and thp < 0.5 then
		if s_util.CastSkill(568,false) then return end --[繁音急节]
		if s_util.CastSkill(18221,false) then return end --[余寒映日]
	end
	--补自己上元保证回蓝
	if not mMyBuff[681] then
		if s_util.CastSkill(556,true) then return end
	end
	--无翔舞补翔舞
	if not mTargetBuff[680] then
		if s_util.CastSkill(554,false) then return end
	end
	--上元
	if not mTargetBuff[681] then
		if s_util.CastSkill(556,false) then return end
	end
	--满血满buff不奶
	if thp <= 0.97 then
		s_util.CastSkill(554,false) 
		if MyBuff[12287] then
			if s_util.CastSkill(18222,false) then return end
		end
		if s_util.CastSkill(565,false) then return end
	end
end