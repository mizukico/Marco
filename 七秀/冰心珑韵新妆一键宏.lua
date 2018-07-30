--根据群友的作品修改
--修改了[珑韵]流打法
local player = GetClientPlayer(player)
if not player then return end

--初始化
if not g_MacroVars.State_2707 then
	g_MacroVars.State_2707 = 0				--标记
end

--当前血量比值
local myhp = player.nCurrentLife / player.nMaxLife
--获取当前目标，没有目标或者目标不是敌人，直接返回
local target, targetClass = s_util.GetTarget(player)							--返回 目标对象和目标类型(玩家或者NPC)
if not target or not IsEnemy(player.dwID, target.dwID) then return end	

--目标血量
local thp = target.nCurrentLife / target.nMaxLife

--判定警告信息 
local warnmsg = s_util.GetWarnMsg()
--获取自己读条数据
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState = GetSkillOTActionState(player)

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取目标的buff表
local mTargetBuff = s_util.GetBuffInfo(target, true)
local TargetBuff = s_util.GetBuffInfo(target)

--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--当前蓝量比值
local mp = player.nCurrentMana / player.nMaxMana

--获取NPC强度
local Intensity = GetNpcIntensity(target)

	
	--如果血量小于40%，释放天地低昂
	if myhp < 0.4 and not MyBuff[122] and not MyBuff[9933] and not MyBuff[9782] and not MyBuff[8839] and not MyBuff[9265] and not MyBuff[1242] and not MyBuff[10208] and not MyBuff[2778] then
		if s_util.CastSkill(557, false) then return end
	end
	
	--剑破后开梵音
	if thp > 0.9 and s_util.GetSkillCD(2716) > 3 then
		if s_util.CastSkill(568, false) then return end
	end
	
	--繁音
	if(MyBuff[5788] and MyBuff[5788].nStackNum > 4) and not MyBuff[9769] then
		if s_util.CastSkill(568, false) then return end
	end
	
		
		--移动状态打剑破
	if s_util.CastSkill(2716, false) then return end
		--移动状态打剑气
	if s_util.CastSkill(561, false) then return end

		if dwSkillId == 2707 and nLeftTime < 0.5 and mTargetBuff[2920] and mTargetBuff[2920].nStackNum == 2 then
			g_MacroVars.State_2707 = 1
		end
		--江海凝光
		if g_MacroVars.State_2707 == 1 or(mTargetBuff[2920] and mTargetBuff[2920].nStackNum > 2) then
			if s_util.CastSkill(553, false) then
				g_MacroVars.State_2707 = 0
				return
			end
		end
		--玳弦急曲
		if s_util.CastSkill(2707, false) then return end
		--剑破虚空
		if s_util.CastSkill(2716, false) then return end
		--移动状态打剑气
		if s_util.CastSkill(561, false) then return end

