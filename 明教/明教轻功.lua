local player = GetClientPlayer()
local target = s_util.GetTarget(player)
local aaa = player.GetKungfuMount().dwSkillID
player.PitchTo(64)
if IsKeyDown("W") then
	player.PitchTo(0)
end
if IsKeyDown("S") then
	player.PitchTo(-64)
end
if player.nMoveState ~= 25 and player.nSprintPower > 5 then
	StartSprint()
	Jump()
else
	if s_util.Cast(9003, false) then return end
	if s_util.Cast(9005, false) then return end
	if s_util.Cast(9006, false) then return end
	if s_util.Cast(9004, false) then return end
end