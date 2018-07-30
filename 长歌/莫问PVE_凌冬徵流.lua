--奇穴：【号钟】【飞帆/长情】【唳风】【凌冬】【豪情】【师襄】【广雅】【刻梦】【书离】【参连】【凝眉】【无尽藏】
--目前还在调试中，仅在木桩跟大战中进行测试，有错误或需要优化的地方欢迎反馈

--获取自己的Player对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--当前血量比值
local hpRatio = player.nCurrentLife / player.nMaxLife

--获取当前目标，没有目标或者目标不是敌人，直接返回
local target, targetClass = s_util.GetTarget(player)			
				
--返回 目标对象和目标类型(玩家或者NPC)
if not target or not IsEnemy(player.dwID, target.dwID) then return end

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取自己对目标造成的buff表
local TargetBuff = s_util.GetBuffInfo(target, true)

--获取目标全部的buff表
local TargetBuffAll = s_util.GetBuffInfo(target)

--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--获取自己影子数量
local ShadowNumber = s_util.GetShadow()


--初始化DOT刷新标志
if not g_MacroVars.State_14064 then
	g_MacroVars.State_14064 = 0				--DOT刷新标志
end		

if player.nPoseState ~= POSE_TYPE.YANGCUNBAIXUE then		--如果不是阳春白雪曲风
		s_util.CastSkill(14070, false)						--切换阳春白雪
		return
	end

--疏影满且徵不在CD时开孤影
if s_util.GetSkillCN(14082) > 2 and s_util.GetSkillCD(14067) <=0 then
   if s_util.CastSkill(14081, false) then return end
end

--孤影化双buff小于1S重置孤影
if MyBuff[9284] and MyBuff[9284].nLeftTime < 1 then
    if s_util.CastSkill(14162, false) then return end
end	

--长歌切剑时机自己掌握，小的大战本无所谓，打10人或者25人副本最好注释掉
--if s_util.CastSkill(14083, false) then return end  --清绝影歌
--if s_util.CastSkill(14452, false) then return end  --剑羽
--if s_util.CastSkill(14449, false) then return end  --剑宫

--释放阳春白雪(优先）
if s_util.CastSkill(14230, false, true) then return end

--获取我的读条数据
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(player)

--处理商、角刷新延迟重复读宫问题
--如果正在读宫
if  dwSkillId == 14064 and nLeftTime < 0.5 then  
    g_MacroVars.State_14064 = 1 	--设置刷新DOT标志
end

--判定刷新且充能次数大于等于2则释放羽
if  g_MacroVars.State_14064 == 1 and s_util.GetSkillCN(14068) >= 2 then
if s_util.CastSkill(14068, false)  then 
	g_MacroVars.State_14064 = 0
	return 
	end   --释放羽
end

--目标商或角持续时间小于4S且没有刷新DOT标志，读宫
if (TargetBuff[9357] and TargetBuff[9357].nLeftTime < 4 and g_MacroVars.State_14064 == 0) or (TargetBuff[9361] and TargetBuff[9361].nLeftTime < 4 and g_MacroVars.State_14064 == 0) then
if s_util.CastSkill(14064, false) then				--施放宫刷新DOT
			g_MacroVars.State_14064 = 1             --重置刷新DOT标志
			return
		end
	end
	
--如果影子数量小于6并且充能大于0且孤影CD>50S且不在读条就放影子
--非刻梦奇穴需要改影子数量为3
if ShadowNumber < 6 and s_util.GetSkillCN(14082) > 0 and s_util.GetSkillCD(14081) > 50 and not bPrepare then
   if s_util.CastSkill(14082, false) then return end
end

--读商（DOT）
if not TargetBuff[9357] then
    if s_util.CastSkill(14065, false) then return end  
end

--读角（DOT）
if not TargetBuff[9361] then
  if  s_util.CastSkill(14066, false) then return end  
end

--没有凌冬buff或者凌冬等于2级释放羽
if  not MyBuff[9353] or (MyBuff[9353] and MyBuff[9353].nLevel ==2 )then
    if s_util.CastSkill(14068, false)  then return end   --释放羽
end

--凌冬buff1级时需要2层充能以上才释放羽，保证书离时间
if  MyBuff[9353] and MyBuff[9353].nLevel ==1 and s_util.GetSkillCN(14068) >= 2 then
    if s_util.CastSkill(14068, false)  then return end   --释放羽
end

--有3级凌冬且不再孤影中，读徵
if MyBuff[9353] and MyBuff[9353].nLevel > 2 and not MyBuff[9284] then
  if  s_util.CastSkill(14067, false)  then return end  --读条徵
end

--读宫填充
if s_util.CastSkill(14064, false) then return end