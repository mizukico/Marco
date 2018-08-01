--玩家对象
local player = GetClientPlayer()
--目标对象
local target = s_util.GetTarget(player)

if target then
    s_Output(target.nMoveState)
end

s_Output(player.nMoveState)

local MinDistance = 20		
local MindwID = 0
local MinHp = 80000		    
for i,v in ipairs(GetAllPlayer()) do		--遍历
    if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMoveState ~= MOVE_STATE.ON_DEATH and v.nCurrentLife < MinHp then
        MinHp = v.nCurrentLife
        MindwID = v.dwID
    end
end
if MindwID == 0 then 
    return
else
    SetTarget(TARGET.PLAYER, MindwID)  --设定目标
end