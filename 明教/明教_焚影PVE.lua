--基于贴吧蓝贝的量子理论编写，输出循环严格执行“轮斩驱轮斩破破”，并处理日盈期间交替轮的问题
--奇穴：【腾焰飞芒】【净身明礼】【洞若观火】【无明业火】【明光恒照】【辉耀红尘】【万念俱寂】【日月同辉】【天地诛戮】【寂灭劫灰】【伏明众生】【驱夷逐法】
--属性：优先满命中。加速要求318，加速低了会影响驱夷bug覆盖率，再高一段会打乱日大处理。
--秘籍：不要任何回灵秘籍，包括光明相回灵，对DPS没有提升还会打乱循环
--延迟：网络延迟最好小于100，不然出现满灵延迟可能会吞掉满日

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--当前血量比值
local hpRatio = player.nCurrentLife / player.nMaxLife

--获取当前目标,未进战没目标直接返回,战斗中没目标选择最近敌对NPC,调整面向
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end --
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
local MinDistance = 20			--最小距离
local MindwID = 0		    --最近NPC的ID
for i,v in ipairs(GetAllNpc()) do		--遍历所有NPC
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMaxLife>1000 then	--如果是敌对，并且距离更小
		MinDistance = s_util.GetDistance(v, player)                             
		MindwID = v.dwID                                                                    --替换距离和ID
		end
	end
if MindwID == 0 then 
    return --没有敌对NPC则返回
else	
    SetTarget(TARGET.NPC, MindwID)  --设定目标为最近的敌对NPC                
end
end
if target then s_util.TurnTo(target.nX,target.nY) end  --调整面向

--判断对象B是否在对象A的扇形面向内
--参数：对象A,对象B,面向角(角度制)
local function Is_B_in_A_FaceDirection(pA, pB, agl)
	local rd = (pA.nFaceDirection%256)*math.pi/128
    local dx = pB.nX - pA.nX;
    local dy = pB.nY - pA.nY;
	local length = math.sqrt(dx*dx+dy*dy);
    return math.acos(dx/length*math.cos(rd)+dy/length*math.sin(rd)) < agl*math.pi/360;
end



--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--获取自己的读条数据
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)	

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取自己对目标造成的buff表11
local TargetBuff = s_util.GetBuffInfo(target, true)

--获取目标全部的buff表
local TargetBuffAll = s_util.GetBuffInfo(target)

--判断目标读条，这里没有做处理，可以判断读条的技能ID做相应处理(打断、迎风回浪、挑起等等)
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--返回 是否在读条, 技能ID，等级，剩余时间(秒)，动作类型
if target.dwTemplateID == 58340 and dwSkillId ==18387 and not TargetBuffAll[12348] then
if s_util.CastSkill(3961,false) then return end
end
--简化日月能量
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--与目标距离>8尺使用流光，流光CD使用幻光步
if distance > 8 then if s_util.CastSkill(3977,false) then return end end --流光
if distance > 8 then if s_util.CastSkill(3970,false) then return end end --幻光
--判断player是否在target的180°扇形面向内
if (Is_B_in_A_FaceDirection(target, player, 180) and s_util.GetTarget(target).dwID ~= player.dwID) or distance > 3.5 then
s_util.TurnTo(target.nX,target.nY) 
MoveForwardStart()
end
if (not Is_B_in_A_FaceDirection(target, player, 180) or s_util.GetTarget(target).dwID == player.dwID) and distance < 3.5 then 
MoveForwardStop()
s_util.TurnTo(target.nX,target.nY)
end

--满日且没有同辉，光明相
if player.nSunPowerValue > 0 and (not MyBuff[4937] or MyBuff[4937] and MyBuff[4937].nLevel ~= 2)   then
	if s_util.CastSkill(3969,true) then return end
end

--日60，日大
if CurrentSun > 59 and CurrentSun <=79 then if s_util.CastSkill(18626,true) then return end end

--破魔
if s_util.CastSkill(3967,false) then return end

--日0 月0,幽月轮；日80 月40，幽月轮
if (CurrentMoon <= 19 and CurrentSun <= 19 ) or (CurrentSun >79 and CurrentSun <=99 and CurrentMoon >39 and CurrentMoon <=59 ) then 
    if s_util.CastSkill(3959,false) then return end
end
--日0 月20 且日盈中，幽月轮
if CurrentSun <= 19 and CurrentMoon >19 and CurrentMoon <=39 and MyBuff[12487] then 
    if s_util.CastSkill(3959,false) then return end
end

--日0 月40 且非日盈中，日斩
if  CurrentSun <= 19 and CurrentMoon >39 and CurrentMoon <=59 and not MyBuff[12487] then
    if  s_util.CastSkill(3963,false)  then return end 
end
--日20 月20 且非日盈中，日斩
if CurrentSun >19 and CurrentSun <=39 and CurrentMoon >19 and CurrentMoon <=39 and not MyBuff[12487] then 
    if  s_util.CastSkill(3963,false)  then return end 
end

--日0 月20 且非日盈中，赤日轮
if CurrentSun <= 18 and CurrentMoon >19 and CurrentMoon <=39 and not MyBuff[12487] then 
    if  s_util.CastSkill(3962,false)  then return end 
end
--日60 月60 且非日盈中，赤日轮
if CurrentSun >59 and CurrentSun <=79 and CurrentMoon >59 and CurrentMoon <=79 and not MyBuff[12487] then
   if  s_util.CastSkill(3962,false)  then return end 
end


--日60 月20，驱夜
if  CurrentSun >59 and CurrentSun <=79 and CurrentMoon >19 and CurrentMoon <=39 then
	if s_util.CastSkill(3979,false) then return end
end
--日40 月40，驱夜
if  CurrentSun >39 and CurrentSun <=59 and CurrentMoon >39 and CurrentMoon <=59 then
	if s_util.CastSkill(3979,false) then return end
end

--日80 月60，月斩
if CurrentSun >79 and CurrentSun <=99 and CurrentMoon >59 and CurrentMoon <=79 then if s_util.CastSkill(3960,false) then return end end 

--卡宏补月轮
if CurrentSun < 100 and CurrentMoon < 100 and player.nSunPowerValue <= 0 and player.nMoonPowerValue <= 0 then
   if s_util.CastSkill(3959,false) then return end
end