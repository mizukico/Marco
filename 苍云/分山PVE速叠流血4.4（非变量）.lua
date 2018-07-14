
--奇穴：[刀魂][炼狱][飞瀑][劫生][北漠][割裂][活脉][恋战][愤恨][从容][蔑视][骇日]
--秘籍：PVE秘籍



--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--当前血量比值
local hpRatio = player.nCurrentLife / player.nMaxLife

--获取当前目标，返回目标对象和目标类型(玩家或者NPC)
local target, targetClass = s_util.GetTarget(player)

--没有目标或者目标不是敌人，直接返回
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取目标的buff表
local TargetBuff = s_util.GetBuffInfo(target)

--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--获取目标当前血量比值
local thpRatio = target.nCurrentLife / target.nMaxLife

--获取目标强度
local Strength = GetNpcIntensity(target)

--初始化血怒变量
if not g_MacroVars.State_13040 then
	g_MacroVars.State_13040 = 0				
end

--非战斗状态
if not player.bFightState then

  --竞技场换装功能区（待添加）
  
  --切换腰坠功能区（请自己修改腰坠状态ID以及腰坠ID，如果只需要切换1个腰坠请自己修改一下）

  --如果没有B腰坠buff,并且B腰坠技能CD<1,并且目标是BOSS切换到B腰坠
  if not MyBuff[3853] and s_util.GetItemCD(8,5147,true) <1 and Strength >3 then
    if s_util.UseEquip(8,5147) then end
  end
  
  --如果没有B腰坠buff,并且B腰坠技能CD<1,,并且目标是BOSS使用B腰坠技能 
  if not MyBuff[3853] and s_util.GetItemCD(8,5147,true) <1 and Strength >3 then
    if s_util.UseItem(8,5147) then end
  end
   
  --如果没有C腰坠buff,并且C腰坠技能CD<1,,并且目标是BOSS切换到C腰坠
  if not MyBuff[6360] and s_util.GetItemCD(8,19078,true) <1 and Strength >3 then
    if s_util.UseEquip(8,19078) then end 
  end 
  
  --如果没有C腰坠buff,并且C腰坠技能CD<1,,并且目标是BOSS使用C腰坠技能  
  if not MyBuff[6360] and s_util.GetItemCD(8,19078,true) <1 and Strength >3 then
    if s_util.UseItem(8,19078) then end
  end	

  --如果有B腰坠buff和C腰坠buff,或者B腰坠技能cd>1并且C腰坠技能cd>1,切换到A腰坠
   if ( MyBuff[6360] and MyBuff[3853] ) or ( s_util.GetItemCD(8,19078,true) >1 and s_util.GetItemCD(8,5147,true) >1 ) then
    if s_util.UseEquip(8,22831) then end
  end
  
  --释放所有血怒
  if not MyBuff[8385] or MyBuff[8385].nStackNum < 2 then
    if s_util.CastSkill(13040, false) then return end
  end
  
--非战斗状态结束
end	
	
--进入战斗状态
if player.bFightState then

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
