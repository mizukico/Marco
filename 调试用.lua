
local player = GetClientPlayer()
if not player then return end

local target, targetClass = s_util.GetTarget(player)
if not target then return end

if not player.bFightState and target and IsEnemy(player.dwID, target.dwID) then 
Marco_StarPointX=target.nX
Marco_StarPointY=target.nY
end

local warnmsg = s_util.GetWarnMsg()
if string.find(warnmsg, "即将出战斗区域") then
    s_Output("11")
    s_util.TurnTo(Marco_StarPointX, Marco_StarPointY)
	s_util.SetTimer("aaa")
	end
if s_util.GetTimer("aaa") > 1000 and s_util.GetTimer("aaa") < 10000 then
    s_Output("22")
    s_util.CastSkill(9003,false)
end

s_util.CastSkill(9002,true,false)
if(IsAltKeyDown() and IsKeyDown("Q")) then
	s_util.CastSkill(9002,true,false)
end
return