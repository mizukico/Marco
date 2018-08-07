--绝返奇穴
--奇穴：[刀魂][绝返][飞瀑][劫生][锋鸣][怒炎][活脉][恋战][从容][愤怒][蔑视][骇日]
--秘籍：PVE秘籍
--绝刀减消耗其它常规即可

--流血奇穴
--奇穴：[刀魂][炼狱][飞瀑][劫生][北漠][割裂][活脉][恋战][从容][愤怒][蔑视][骇日]
--秘籍：PVE秘籍

--T宏纯盾单刷110怒气奇穴
--奇穴：[盾威][出尘][铿锵][卷云][千山][当关][活血][雄峦][从容][寒甲][叱威][澄生]
--秘籍：PVE秘籍

--T宏纯盾单刷100怒气奇穴（主要针对伤害较大的怪）
--奇穴：[盾威][出尘][慑服][卷云/坚铁][千山][当关][活血][雄峦][从容][寒甲][叱威][澄生]
--秘籍：PVE秘籍

--战兽山老4wifi
--奇穴：[盾威][激昂][慑服][坚铁][振奋][当光][活脉][雄峦][百炼][愤怒][肃驾][寒啸千军]
--秘籍：PVE秘籍

--辉天堑老4wifi
--奇穴：[盾威][激昂][践踏][坚铁][振奋][雷云][活脉][雄峦][百炼][战毅][肃驾][寒啸千军]
--秘籍：PVE秘籍

--2.0把T宏也整合进来了
--1.0整合绝返和流血为1个宏免去切来切去的麻烦自动根据第二个奇穴决定打绝返还是流血

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--当前血量比值
local hpRatio = player.nCurrentLife / player.nMaxLife

--获取当前目标，返回目标对象和目标类型(玩家或者NPC)
local target, targetClass = s_util.GetTarget(player)

--没有目标或者目标不是敌人，直接返回
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--获取目标的目标数据
local ttarget, ttargetClass = s_util.GetTarget(target)

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取目标的buff表
local TargetBuff = s_util.GetBuffInfo(target)

--获取目标的目标的buff表
local TTargetBuff = s_util.GetBuffInfo(ttarget)

--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--获取目标当前血量比值
local thpRatio = target.nCurrentLife / target.nMaxLife

--获取目标的读条数据
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)

--获取目标强度
local Strength = GetNpcIntensity(target)

--获取地图ID
local GetMap = s_util.GetMapID()

--获取第一个奇穴
local qixue1 = s_util.GetTalentIndex(1)

--获取第二个奇穴
local qixue2 = s_util.GetTalentIndex(2)

--获取第三个奇穴
local qixue3 = s_util.GetTalentIndex(3)

--获取第四个奇穴
local qixue4 = s_util.GetTalentIndex(4)

--获取第五个奇穴
local qixue5 = s_util.GetTalentIndex(5)

--获取第六个奇穴
local qixue6 = s_util.GetTalentIndex(6)

--获取第七个奇穴
local qixue7 = s_util.GetTalentIndex(7)

--获取第八个奇穴
local qixue8 = s_util.GetTalentIndex(8)

--获取第九个奇穴
local qixue9 = s_util.GetTalentIndex(9)

--获取第十个奇穴
local qixue10 = s_util.GetTalentIndex(10)

--获取第十一个奇穴
local qixue11 = s_util.GetTalentIndex(11)

--获取第十二个奇穴
local qixue12 = s_util.GetTalentIndex(12)

--初始化血怒变量
if not g_MacroVars.State_13040 then
	g_MacroVars.State_13040 = 0				
end

--如果目标释放神佑,使用冰泉水	
if TargetBuff[7929] then
if s_util.UseItem(5,21534) then end
end

--非战斗状态开爆发（正常情况下目标是boss才会有开怪爆发，试炼之地也会开启爆发前提是地图ID为143）
if not player.bFightState and player.GetKungfuMount().dwSkillID==10390 then
--释放所有血怒
if not MyBuff[8385] or MyBuff[8385].nStackNum < 3 then
    if s_util.CastSkill(13040, false) then return end
end
--非战斗状态结束
end	

--进入战斗状态并且第二个奇穴是绝返
if player.bFightState and qixue2 == 3 and player.GetKungfuMount().dwSkillID==10390 then

--如果血量小于30，释放盾壁
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--设置血怒释放条件	
--local xuenu33 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3
local xuenu3 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3  --如果没有血怒buff而且血怒可用次数=3次
local xuenu2 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 2  --如果没有血怒buff而且血怒可用次数=2次	
local xuenu1 = not MyBuff[8385]                                    --如果没有血怒buff

--如果没有血怒buff,并且血怒可用次数=3次,释放血怒并且标记为3
    if xuenu3 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 3 return end 
	elseif 
--如果没有血怒buff，并且血怒可用次数=2次,释放血怒并且标记为2
	xuenu2 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 2 return end 
	elseif 
--如果没有血怒buff,释放血怒并且标记为1
	xuenu1 then 
	if s_util.CastSkill(13040, false) then return end
end

--如果血怒标记为3，再次释放血怒并清空标记
	if g_MacroVars.State_13040 == 3 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end
	
--如果血怒标记为2，再次释放血怒并清空标记
	if g_MacroVars.State_13040 == 2 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end
	

--如果姿态是擎盾
if player.nPoseState == 2 then

--设置血怒释放条件	
--local xuenu33 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3
local xuenu3 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3  --如果没有血怒buff而且血怒可用次数=3次
local xuenu2 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 2  --如果没有血怒buff而且血怒可用次数=2次	
local xuenu1 = not MyBuff[8385]                                    --如果没有血怒buff

--如果没有血怒buff,并且血怒可用次数=3次,释放血怒并且标记为3
    if xuenu3 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 3 return end 
	elseif 
--如果没有血怒buff，并且血怒可用次数=2次,释放血怒并且标记为2
	xuenu2 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 2 return end 
	elseif 
--如果没有血怒buff,释放血怒并且标记为1
	xuenu1 then 
	if s_util.CastSkill(13040, false) then return end
end

--如果血怒标记为3，再次释放血怒并设置标记为2
	if g_MacroVars.State_13040 == 3 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 2 return end
	end
	
--如果血怒标记为2，再次释放血怒并清空标记
	if g_MacroVars.State_13040 == 2 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end

	--如果目标没有虚弱buff,并且怒气>66或者怒气>65,并且盾猛CD>1,施放盾飞
	if not TargetBuff[8248] and player.nCurrentRage >= 65 or ( player.nCurrentRage>= 65 and s_util.GetSkillCD(13046) > 1 ) then
		if s_util.CastSkill(13050, false) then return end
	end

    --施放盾猛
	    if s_util.CastSkill(13046, false) then return end

    --如果盾猛CD>1,并且怒气<65,施放盾压
    if s_util.GetSkillCD(13046) > 1 and player.nCurrentRage <= 65 or player.nCurrentRage >=65 and s_util.GetSkillCN(13050) < 1 then
		if s_util.CastSkill(13045, false) then return end
	end

	--盾刀的4321段
	    if s_util.CastSkill(13119, false) then return end
	    if s_util.CastSkill(13060, false) then return end
	    if s_util.CastSkill(13059, false) then return end
	    if s_util.CastSkill(13044, false) then return end
end
--如果姿态是擎刀
if player.nPoseState == 1 then		

    --如果自身有怒炎BUFF,并且怒炎BUFF时间<5,并且斩刀CD<3,并且盾飞次数>0或者自身没有狂绝BUFF,并且斩刀CD<3,并且盾飞次数>0,或者怒气<5或者盾飞时间<1.5,施放盾回
	if ( MyBuff[8276] and MyBuff[8276].nLeftTime < 5 and s_util.GetSkillCD(13054) < 1 and s_util.GetSkillCN(13050) > 0 ) or ( not MyBuff[8276] and s_util.GetSkillCD(13054) < 1 and s_util.GetSkillCN(13050) > 0 ) or player.nCurrentRage < 5 or MyBuff[8391].nLeftTime < 0.5 then
        if s_util.CastSkill(13051, false) then return end
	end	
	
	--如果自身有怒炎BUFF,并且绝刀CD< 3.5,释放斩刀
	if player.nCurrentRage > 60 and s_util.GetSkillCD(13055) < 3.5 then
	    if s_util.CastSkill(13054, false) then return end 
    end	
	
	--如果自身有BUFF狂绝,释放绝刀
	if MyBuff[8451] then
	    if s_util.CastSkill(13055, false) then return end 
    end
	
	--如果自身没有BUFF狂绝,释放劫刀
	if not MyBuff[8451] or s_util.GetSkillCD(13055) > 0.1  then
	if s_util.CastSkill(13052, false) then return end
	end
	
end

end 

--进入战斗状态并且第二个奇穴是炼狱
if player.bFightState and qixue2 == 1 and player.GetKungfuMount().dwSkillID==10390 then

--如果血量小于30，释放盾壁
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--设置血怒释放条件	
--local xuenu33 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3
local xuenu3 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3  --如果没有血怒buff而且血怒可用次数=3次
local xuenu2 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 2  --如果没有血怒buff而且血怒可用次数=2次	
local xuenu1 = not MyBuff[8385]                                    --如果没有血怒buff

--如果没有血怒buff,并且血怒可用次数=3次,释放血怒并且标记为3
    if xuenu3 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 3 return end 
	elseif 
--如果没有血怒buff，并且血怒可用次数=2次,释放血怒并且标记为2
	xuenu2 then 
	if s_util.CastSkill(13040, false) then 
	g_MacroVars.State_13040 = 2 return end 
	elseif 
--如果没有血怒buff,释放血怒并且标记为1
	xuenu1 then 
	if s_util.CastSkill(13040, false) then return end
end

--如果血怒标记为3，再次释放血怒并清空标记
	if g_MacroVars.State_13040 == 3 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end
	
--如果血怒标记为2，再次释放血怒并清空标记
	if g_MacroVars.State_13040 == 2 then 
	if s_util.CastSkill(13040, false) then
	g_MacroVars.State_13040 = 0 return end
	end
	
--如果姿态是擎盾
if player.nPoseState == 2 then

    --如果怒气<30,并且目标有流血buff,并且流血层数=1,并且流血时间>15,没有buff缓深,施放盾压
	if player.nCurrentRage<= 30 or TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and TargetBuff[8249].nLeftTime > 15 and not MyBuff[8738] then
	if s_util.CastSkill(13045, false) then return end
    end

    --如果目标有流血buff, 盾击可使用次数大于0, 施放盾击
	if TargetBuff[8249] and s_util.GetSkillCN(13047) > 0 then 
	if s_util.CastSkill(13047, false) then return end
	end

	--2层以下流血盾飞判定
	if not TargetBuff[8249] and player.nCurrentRage>= 40 or  --如果目标没有流血buff,并且自身怒气>25,或者
	TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and s_util.GetSkillCN(13047) < 1 or
	s_util.GetSkillCN(13047) < 1 and player.nCurrentRage>= 40 and TargetBuff[8249] and TargetBuff[8249].nStackNum >= 2 or
	TargetBuff[8249] and TargetBuff[8249].nLeftTime < 2 then
	if s_util.CastSkill(13050, false) then return end  
	end
	
	--如果怒气小于40,并且盾压CD>1,并且盾击并标记为3,释放盾猛
	if player.nCurrentRage<= 40 and s_util.GetSkillCD(13045) > 1 and s_util.GetSkillCN(13047) < 1 then
	if s_util.CastSkill(13046, false) then return end
	end
	
	--盾刀的4321段
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
	
	--擎盾姿态结束
	end
	
--如果姿态是擎刀
if player.nPoseState == 1 then		

	--目标流血时间>18并且流血层数>1,施放闪刀
	if TargetBuff[8249] and TargetBuff[8249].nStackNum > 1 and TargetBuff[8249].nLeftTime > 18 then
	    if s_util.CastSkill(13053, false) then return end
	end
	
    --如果目标没有流血buff,或者流血层数<3,或者流血时间<4,释放斩刀
	if not TargetBuff[8249] or TargetBuff[8249].nStackNum < 3 or TargetBuff[8249].nLeftTime < 4 then
	    if s_util.CastSkill(13054, false) then return end 
    end	
	
	--（1层流血情况）如果盾击可使用次数>2,并且盾飞可使用次数>0,并且斩刀CD>1,并且目标有流血buff,并且流血层数=1,并且流血时间>15,施放盾回
	if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and TargetBuff[8249].nLeftTime > 15 then
        if s_util.CastSkill(13051, false) then
        g_MacroVars.State_13047 =0 return end
	end
	
	--（2层流血情况）如果盾击可使用次数>2,并且盾飞可使用次数>0,并且斩刀CD>1,并且闪刀CD>1,并且目标有流血buff,并且流血层数=2,施放盾回
	if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and s_util.GetSkillCD(13053) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 2 then
        if s_util.CastSkill(13051, false) then
		g_MacroVars.State_13047 =0 return end
	end	
	
	--（3层流血情况1）如果盾击可使用次数>2,并且盾飞可使用次数>0,并且斩刀CD>1,并且闪刀CD>1,并且目标有流血buff,并且流血层数=3,并且流血时间<7,施放盾回
	if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and s_util.GetSkillCD(13053) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 3 and TargetBuff[8249].nLeftTime < 7 then
        if s_util.CastSkill(13051, false) then
		g_MacroVars.State_13047 =0 return end
	end	
	
	--（3层流血情况2）如果怒气<=4,或者盾飞可使用次数>0,并且闪刀CD>1,并且斩刀CD>1,并且目标有流血buff,并且流血层数=3,施放盾回
	if player.nCurrentRage<=4 then 
		if s_util.CastSkill(13051, false) then
		g_MacroVars.State_13047 =0 return end
    end
	
	--劫刀
	if s_util.CastSkill(13052, false) then return end
	
--擎刀姿态结束	
end

--战斗状态结束  
end	

--铁骨整合区
if player.GetKungfuMount().dwSkillID==10389 then

--如果目标释放控制类技能就释放后跳躲避
	if bPrepare and ( dwSkillId == 18300 or dwSkillId == 18372 or dwSkillId == 9568 or dwSkillId == 18369 or dwSkillId == 9569 or dwSkillId == 9242 ) and s_util.GetDistance(player, target) < 6  then
	if s_util.CastSkill(9007, false) then return end
	end
	
--T宏纯盾单刷110怒气
if qixue10 == 4 and qixue3 == 4 then

--如果血量小于30，释放盾壁
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--如果姿态是擎盾
if player.nPoseState == 2 then

	--施放盾挡
	if player.nCurrentRage > 105 then
	if s_util.CastSkill(13391, false) then return end
	end

	--施放盾压
	if player.nCurrentRage < 100 then
	if s_util.CastSkill(13045, false) then return end
	end

	--施放盾刀的4321段
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--如果姿态是擎刀
if player.nPoseState == 1 then

	--切换姿态
	if s_util.CastSkill(13051, false) then return end
end

end

--T宏纯盾单刷100怒气
if qixue10 == 4 and qixue3 == 1 then

--如果血量小于30，释放盾壁
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--如果姿态是擎盾
if player.nPoseState == 2 then

	--施放盾挡
	if player.nCurrentRage > 95 then
	if s_util.CastSkill(13391, false) then return end
	end

	--施放盾压
	if player.nCurrentRage < 90 then
	if s_util.CastSkill(13045, false) then return end
	end

	--施放盾刀的4321段
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--如果姿态是擎刀
if player.nPoseState == 1 then

	--切换姿态
	if s_util.CastSkill(13051, false) then return end
end

end

--战兽山老4wifi手动盾飞
if qixue12 == 4 and qixue6 == 3 then

--如果血量小于30，释放盾壁
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

    --如果姿态是擎盾
if player.nPoseState == 2 then
	
	--如果有buff雄峦,释放寒啸千军
	if MyBuff[8253] then
    	if s_util.CastSkill(15072, false) then return end
    
	end
	--施放盾挡
	if not MyBuff[8499] then
		if s_util.CastSkill(13391, false) then return end
	end

	--施放盾压
	if s_util.CastSkill(13045, false) then return end

	--施放盾刀的4321段
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--如果姿态是擎刀
if player.nPoseState == 1 then

    --劫刀
	if s_util.CastSkill(13052, false) then return end

	--如果目标的目标不是自己,并且怒气小于5,释放血怒
	if ttarget and ttarget.dwID ~= player.dwID and player.nCurrentRage < 5  then
    if s_util.CastSkill(13040, false) then return end
	end

	--如果目标是自己,释放盾回
	if ttarget and ttarget.dwID == player.dwID then
	if s_util.CastSkill(13051, false) then return end
	end
	
end 
end

--辉天堑老4wifi
if qixue12 == 4 and qixue6 == 4 then

--如果血量小于30，释放盾壁
if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end

--如果目标在读条,并且技能ID是13126,释放盾飞
if bPrepare and dwSkillId == 19044 then
if s_util.CastSkill(13050, false) then return end
end

--如果周围BOSS释放技能ID13126,释放盾飞（未测试）
local zy = nil	--初始化为nil
for _,v in ipairs(GetAllNpc()) do
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState = GetSkillOTActionState(v)
	if bPrepare and dwSkillId == 19044 then	--如果在读条，并且技能ID是19044
		zy = v			--记录这个NPC
		break				--跳出循环
	end
end

if zy then	--如果有在读条19044技能的npc，这里最好再判断下自己打断技能的CD
	s_util.SetTarget(TARGET.PLAYER, zy.dwID)		--选择他为目标
	s_util.CastSkill(13051, false)
	s_util.CastSkill(13050, false)			--使用打断技能
	return
end

--如果姿态是擎盾
if player.nPoseState == 2 then

	--如果目标的目标不是自己,并且有BUFF剑威阳或者剑威阴,并且>1层,释放盾猛
	if (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 ) then
	if s_util.CastSkill(13046, false) then return end
	end

	--如果目标的目标不是自己,并且有BUFF剑威阳或者剑威阴,并且>1层,释放盾飞
	if  (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and  ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 )  then
	if s_util.CastSkill(13050, false) then return end
	end
	
	--如果有BUFF雄峦,释放寒啸千军
	if MyBuff[8253] then
    	if s_util.CastSkill(15072, false) then return end
	end
	--如果没有BUFF盾挡,释放盾挡
	if not MyBuff[8499] then
		if s_util.CastSkill(13391, false) then return end
	end

	--施放盾压
	if s_util.CastSkill(13045, false) then return end

	--施放盾刀的4321段
	if s_util.CastSkill(13119, false) then return end
	if s_util.CastSkill(13060, false) then return end
	if s_util.CastSkill(13059, false) then return end
	if s_util.CastSkill(13044, false) then return end
end

--如果姿态是擎刀
if player.nPoseState == 1 then

    --如果目标的目标不是自己,并且有BUFF剑威阳或者剑威阴,并且>1层,释放斩刀
	if  (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and  ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 )  then
	if s_util.CastSkill(13054, false) then return end
    end
	
    --如果目标的目标不是自己,并且有BUFF剑威阳或者剑威阴,并且>1层,释放劫刀
	if  (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and  ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 )  then
	if s_util.CastSkill(13052, false) then return end
	end

	--如果目标的目标不是自己,并且有BUFF剑威阳或者剑威阴,并且>1层,并且怒气小于5,释放血怒
	if  (( target.dwTemplateID == 60133 or target.dwTemplateID == 60446 or target.dwTemplateID == 59433 ) and TTargetBuff[12862] and TTargetBuff[12862].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and player.nCurrentRage < 5 and ( not MyBuff[12862] or MyBuff[12862] and MyBuff[12862].nStackNum < 2 ) or
	(( target.dwTemplateID == 60134 or target.dwTemplateID == 60447 or target.dwTemplateID == 59434 ) and TTargetBuff[12861] and TTargetBuff[12861].nStackNum > 1 and ttarget and ttarget.dwID ~= player.dwID ) and player.nCurrentRage < 5 and  ( not MyBuff[12861] or MyBuff[12861] and MyBuff[12861].nStackNum < 2 )  then
    if s_util.CastSkill(13040, false) then return end
	end
	
	--如果目标是自己,释放盾回
	if ttarget and ttarget.dwID == player.dwID then
	if s_util.CastSkill(13051, false) then return end
	end
	
end 
end 
end 