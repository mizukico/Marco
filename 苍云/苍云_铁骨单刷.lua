--奇穴：[盾威][炼狱][铿锵][坚铁][胜前][割裂][活血][雄峦][寒甲][从容][石虎][澄生]
--此宏必须要用这套奇穴，此奇穴就一个目的。苟住，我能行。
--秘籍：PVE秘籍
--作者：碎魂

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

--如果血量小于35%，施放盾壁
if hpRatio < 0.35 and s_util.CastSkill(13070, false) then return end

--如果生命低于80%施放血怒
if hpRatio < 0.8 then					
   if s_util.CastSkill(13040, false) then return end
end

--如果姿态是擎盾
if player.nPoseState == 2 then

--怒气>95并且有BUFF寒甲施放盾飞
if player.nCurrentRage > 95 and MyBuff[8437] then
   if s_util.CastSkill(13050, false)  then return end	
end

--如果生命低于<60施放盾击
if hpRatio < 0.6 then					
if s_util.CastSkill(13047, false) then return end
end

--盾压
if s_util.CastSkill(13045, false) then return end
	
--盾猛
if s_util.CastSkill(13046, false) then return end

--盾刀的4321段
if s_util.CastSkill(13119, false) then return end
if s_util.CastSkill(13060, false) then return end
if s_util.CastSkill(13059, false) then return end
if s_util.CastSkill(13044, false) then return end
end

--如果姿态是擎刀
if player.nPoseState == 1 then

--如果目标没有流血buff或者时间小于9秒,释放斩刀												
if not TargetBuff[8249] or TargetBuff[8249].nLeftTime < 9 then  
   if s_util.CastSkill(13054, false) then return end 
end
	
--如果目标有流血BUFF并且流血BUFF>16秒，施放闪刀
if TargetBuff[8249] and TargetBuff[8249].nLeftTime > 16 then					
		if s_util.CastSkill(13053, false) then return end			
	end

--劫刀
if s_util.CastSkill(13052, false) then return end
end

--如果怒气<30点或者没有寒甲BUFF，施放盾回！
if not MyBuff[8437] or player.nCurrentRage < 30 then 			
	if s_util.CastSkill(13051, false) then return end			
end


