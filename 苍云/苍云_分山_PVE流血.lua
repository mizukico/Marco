--奇穴：[刀魂][炼狱][飞瀑][劫生][北漠][割裂][活脉][恋战][赤心][从容][蔑视][骇日]
--秘籍：自己看着弄
--作者：还珠楼主
--最后修改日期：2018/3/31
--说明：这个只是演示，感觉还有很多地需要修改，怒气用不完，劫刀打的太少，盾击打的太多。
--为什么技能和Buff都用ID而不用名字，因为很多buff是隐藏的没有名字。用ID可以精确控制。



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

--判断目标读条，这里没有做处理，可以判断读条的技能ID做相应处理(打断、迎风回浪等等)
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
	--条件达到，不管施放成功没有，都返回，优先保证3盾击
	if TargetBuff[8249] and s_util.GetSkillCN(13047) > 0 and distance < 4 then		--如果 目标有流血buff, 盾击可使用次数大于0, 距离小于4尺
		s_util.CastSkill(13047, false)												--施放盾击
		return
	end

	--盾压
	if s_util.CastSkill(13045, false) then return end

	--斩刀冷却了就要切刀保流血
	if player.nCurrentRage > 30 and s_util.GetSkillCD(13054) == 0 then			--如果怒气大于30点, 并且斩刀冷却了
		if s_util.CastSkill(13050, false) then return end						--施放盾飞
	end

	--盾猛
	if s_util.CastSkill(13046, false) then return end

	--如果怒气大于70，切刀打劫刀
	if player.nCurrentRage > 70 then
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
	if player.nCurrentRage < 10 then					--如果怒气小于5点
		s_util.CastSkill(13051, false)				--施放盾回
		return
	end

	--优先斩刀，保流血
	if s_util.CastSkill(13054, false) then return end

	--闪刀伤害不高，一次斩刀后面接一次闪刀就行了
	if TargetBuff[8249] and TargetBuff[8249].nLeftTime > 18 then		--如果有流血buff, 并且buff剩余时间大于18秒
		if s_util.CastSkill(13053, false) then return end				--施放闪刀
	end

	--如果有3次盾击，就切回盾
	local djCount, djLefttime = s_util.GetSkillCN(13047)		--获取盾击的和使用次数和充能剩余时间
	if TargetBuff[8249] and TargetBuff[8249].nLeftTime > 4 and djCount >= 2 and djLefttime < 2 then		--如果有流血buff，并且时间大于4秒, 盾击次数大于等于2，并且充能剩余时间小于2秒(前两次盾击2秒)
		s_util.CastSkill(13051, false)							--施放盾回
		return
	end

	--劫刀
	if s_util.CastSkill(13052, false) then return end
end
