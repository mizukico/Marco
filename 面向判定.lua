local function Is_B_in_A_FaceDirection(pA, pB, agl)
	local rd = (pA.nFaceDirection%256)*math.pi/256
    local dx = pB.nX - pA.nX;
    local dy = pB.nY - pA.nY;
	local length = math.sqrt(dx*dx+dy*dy);
    return math.acos(dx/length*math.cos(rd)+dy/length*math.sin(rd)) < agl*math.pi/360;
end

local angle=30
local ang = (angle+5)*math.pi/360
local player = GetClientPlayer()
local target = s_util.GetTarget(player)
local x1,y1,x2,y2,ddx,ddy,leng,rrd,finX,finY,finX1,finY1,finX2,finY2,dis1,dis2 = 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
if GetClientPlayer().bFightState then
if taget and Is_B_in_A_FaceDirection(target,player,angle) then
 x1=target.nX
 y1=target.nY
 x2=player.nX
 y2=player.nY
 ddx = x2 - x1
 ddy = y2 - y1
 leng = math.sqrt(ddx*ddx+ddy*ddy)
 rrd = (target.nFaceDirection%256)*math.pi/128
 finX = leng*math.sin(rrd)+x1
 finY = leng*math.cos(rrd)+y1
 finX1 = (finX-x1)*math.cos(ang)-(finY-y1)math.sin(ang)+x1
 finY1 = (finX-x1)*math.sin(ang)+(finY-y1)math.cos(ang)+y1
 finX2 = (finX-x1)*math.cos(ang)+(finY-y1)math.sin(ang)+x1
 finY2 = (finY-y1)math.cos(ang)-(finX-x1)*math.sin(ang)+y1
 dis1 = math.sqrt((x2-finX1)^2+(y2-finY1)^2)
 dis2 = math.sqrt((x2-finX2)^2+(y2-finY2)^2)
 if dis1 <= dis2 then s_cmd.MoveTo(finX1, finY1, target.nZ) 
 else s_cmd.MoveTo(finX2, finY2, target.nZ)
 end
 else s_cmd.Fight(2, 0, 10)
 end
 else s_cmd.Next()
 end