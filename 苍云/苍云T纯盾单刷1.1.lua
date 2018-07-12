--奇穴：盾威,出尘,铿锵,卷云,千山,当关,活血,雄峦,寒甲,从容,叱威,澄生

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--当前血量比值
local hpRatio = player.nCurrentLife / player.nMaxLife

--获取当前目标，返回目标对象和目标类型(玩家或者NPC)
local target, targetClass = s_util.GetTarget(player)

--没有目标或者目标不是敌人，直接返回
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取目标的buff表
local TargetBuff = s_util.GetBuffInfo(target)

--获取自己和目标的距离
local dis = s_util.GetDistance(player, target)
if dis > 3.5 then
s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end

--如果血量小于20，释放盾壁
if hpRatio < 0.20 and s_util.CastSkill(13070, false) then return end

--如果姿态是擎盾
if player.nPoseState == 2 then
	--施放盾挡
	if player.nCurrentRage > 105 then
	if s_util.CastSkill(13391, false) then return end
	end
	
	--施放盾飞
	if MyBuff[8448] and MyBuff[8448].nLeftTime > 8 and s_util.GetSkillCN(13050) > 0 then
	if s_util.CastSkill(13050, false) then return end
	end

	--施放盾压
	if player.nCurrentRage < 100 then
	if s_util.CastSkill(13045, false) then return end
	end

	--施放盾刀的4321段
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--如果姿态是擎刀
if player.nPoseState == 1 then

	--切换姿态
	if s_util.CastSkill(13051, false) then return end
end
