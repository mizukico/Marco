local player = GetClientPlayer()
local target = s_util.GetTarget(player)
local aaa = player.GetKungfuMount().dwSkillID

s_tFightFunc[aaa][2]()