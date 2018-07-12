--奇穴:[蔚风][秋鸿][争簇][殊曲][谪仙][自赏][寸光阴][鸣鸾][凝绝][棋宫][掷杯][无尽藏]

--获取玩家对象
local player = GetClientPlayer()
--获取目标对象
local target = s_util.GetTarget(player)

--自动选择队友开关
local autoSelectTeamMember = true
--杯水留影快捷键
local beiShuiKey = "Z"

--杯水快捷键按下且目标重伤时强制释放杯水留影
if(IsKeyDown(beiShuiKey) and (target and target.nMoveState == MOVE_STATE.ON_DEATH)) then s_util.CastSkill(14084,false,false) end

--获取目标Buff表
local targetBuffs = s_util.GetBuffInfo(target)
--获取自身Buff表
local playerBuffs = s_util.GetBuffInfo(player)
--获取20尺范围内队伍内血量最低玩家,队伍平均血量,队伍人数
local lowLifePartner,teamAvgLife,memberCount = s_util.GetTeamMember()

--快捷键强制扶摇
if(IsAltKeyDown() and IsKeyDown("Q")) then
	s_util.CastSkill(9002,true,false)
	if(playerBuffs[208]) then Jump() end
end

--如果队友不存在，则设为玩家自身
if(not(lowLifePartner)) then 
	lowLifePartner = player
	teamAvgLife = player.nCurrentLife/player.nMaxLife
	memberCount = 1
end

--如果队伍平均血量低于40%则强制释放减伤圈
if(teamAvgLife and teamAvgLife <= 0.4) then s_util.CastSkill(14075,true,false) end

--如果自身血量低于30%且[云生结海]减伤不存在则释放[青霄飞羽]规避伤害
if(player.nCurrentLife/player.nMaxLife <= 0.3 and not(playerBuffs[9265])) then s_util.CastSkill(14076,false,false) end

--如果自动选择队友开启且最低血量队友存在并血量低于40%则自动切换目标
if(lowLifePartner and (lowLifePartner.nCurrentLife/lowLifePartner.nMaxLife <= 0.4) and autoSelectTeamMember) then 
	SetTarget(TARGET.PLAYER,lowLifePartner.dwID)
	if(targetBuffs[9460] and targetBuffs[9464] and s_util.GetSkillCN(14141) >=1) then s_util.CastSkill(14141,false,false) --如果Hot存在且[羽]不在CD，则强制释放[羽]使Hot立即生效
	else s_util.CastSkill(14137,false,false) end --如果Hot不存在或[羽]无法释放，则强制释放[宫]
end

--保持[商][角]存在
if(not(targetBuffs[9464]) or (targetBuffs[9464] and targetBuffs[9464].nLeftTime <= 1.5)) then s_util.CastSkill(14139,false) end --当目标[角]Buff不存在或剩余时间低于1.5s时,释放[角]
if(not(targetBuffs[9460]) or (targetBuffs[9460] and targetBuffs[9460].nLeftTime <= 1.5)) then s_util.CastSkill(14138,false) end --当目标[商]Buff不存在或剩余时间低于1.5s时,释放[商]

--当无目标时，自动选择自己为目标
if(not(target)) then SetTarget(TARGET.PLAYER,player.dwID) end

--如果曲目不为阳春白雪，则释放阳春白雪切换曲目
if(player.nPoseSate ~= POSE_TYPE.YANGCUNBAIXUE) then s_util.CastSkill(14070,true) end

--当[疏影横斜]充能大于等于1层时释放影子
if(s_util.GetSkillCN(14082) >= 1) then s_util.CastSkill(14082,true) end

--当目标血量低于93%时释放[徽]填补技能空隙
if(target and target.nCurrentLife/target.nMaxLife <= 0.93) then s_util.CastSkill(14140,false) end