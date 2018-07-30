--玩家对象
local player = GetClientPlayer()
--目标对象
local target = s_util.GetTarget(player)

if target then
    s_Output(target.nMoveState)
end

s_Output(player.nMoveState)