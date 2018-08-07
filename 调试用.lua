--玩家对象
local player = GetClientPlayer()
--目标对象
local target = s_util.GetTarget(player)

s_util.UseEquip(7, 37483)
s_util.UseItem(5, 24779)
if target then
    s_Output("目标："..tostring(target.nMoveState))
    s_Output(target.dwTeamID)
    s_Output("装总分："..tostring(target.GetTotalEquipScore()))
    s_Output("装基分："..tostring(target.GetBaseEquipScore()))
    s_Output("东主："..tostring(target.nBattleFieldSide))
    s_Output("活动奖励："..tostring(target.nActivityAward))
end

s_Output("自己："..tostring(player.nMoveState))
s_Output(player.dwTeamID)
s_Output("装总分："..tostring(player.GetTotalEquipScore()))
s_Output("装基分："..tostring(player.GetBaseEquipScore()))
s_Output("东主："..tostring(player.nBattleFieldSide))
s_Output("活动奖励："..tostring(player.nActivityAward))

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