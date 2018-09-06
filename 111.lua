local player = GetClientPlayer()
local target = s_util.GetTarget(player)
local aaa = player.GetKungfuMount().dwSkillID
if player.bFightState then
	s_tFightFunc[10242][2]()
else
	s_cmd.InteractDoodad(6826)
end