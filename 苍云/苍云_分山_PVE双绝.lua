--奇穴：[刀魂][绝返][分野][劫生][锋鸣][怒炎][活脉][恋战][赤心][从容][蔑视][骇日]
--秘籍：自己看着弄
--作者：还珠楼主
--最后修改日期：2018/3/31



--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--当前血量比值
local hpRatio = player.nCurrentLife / player.nMaxLife

--如果血量小于35% ，用盾壁
if hpRatio < 0.35 and s_util.CastSkill(13070, false) then return end

--获取当前目标，没有目标或者目标不是敌人，直接返回
local target, targetClass = s_util.GetTarget()							--返回 目标对象和目标类型(玩家或者NPC)
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--判断目标读条，这里没有做处理，可以判断读条的技能ID做相应处理(打断、迎风回浪、挑起等等)
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--返回 是否在读条, 技能ID，等级，剩余时间(秒)，动作类型

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取目标的buff表
local TargetBuff = s_util.GetBuffInfo(target)

--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--血怒 点了愤恨用这个
--if not MyBuff[8385] and hpRatio > 0.91 then					--如果没有血怒buff，并且血量大于91%
--	if s_util.CastSkill(13040, false) then return end		--如果施放血怒成功，直接返回(每次按下就施放一个技能，没必要再往下走了)
--end

--血怒 没有点愤恨用这个，注意 buff ID 是不一样的
if not MyBuff[8244] or MyBuff[8244].nStackNum < 2 then		--如果没有血怒buff,或者血怒buff堆叠层数小于2
	if s_util.CastSkill(13040, false) then return end
end

--如果姿态是擎盾
if player.nPoseState == 2 then
	--盾猛
	if s_util.CastSkill(13046, false) then return end

	--盾压
	if s_util.CastSkill(13045, false) then return end

	--切刀
	if player.nCurrentRage >55 and s_util.GetSkillCD(13054) == 0 then			--如果怒气大于55点, 并且斩刀冷却了
		if s_util.CastSkill(13050, false) then return end						--施放盾飞
	end

	--盾刀的4321段
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--如果姿态是擎刀
if player.nPoseState == 1 then
	--切换姿态
	if player.nCurrentRage < 5 then					--如果怒气小于5点
		s_util.CastSkill(13051, false)				--施放盾回
		return
	end

	--绝刀
	if MyBuff[8451] then										--如果自己有狂绝
		if s_util.CastSkill(13055, false) then return end		--施放绝刀
	end

	--闪刀
	if TargetBuff[8248] and not MyBuff[8276] then					--如果目标有虚弱, 自己没有怒炎
		if s_util.CastSkill(13053, false) then return end			--施放闪刀
	end

	--斩刀															--如果自己有怒炎
	if MyBuff[8276] then
		if s_util.CastSkill(13054, false) then return end
	end

	--绝刀
	if s_util.CastSkill(13055, false) then return end


	--切盾，这个是优先盾猛，貌似dps低了
	--if s_util.GetSkillCD(13046) == 0 then			--如果盾猛冷却了
	--	s_util.CastSkill(13051, false)				--施放盾回
	--end

	--劫刀
	if s_util.CastSkill(13052, false) then return end
end
