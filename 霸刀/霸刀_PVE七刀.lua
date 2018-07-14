--参考借鉴了楼主的霸刀宏
--奇穴：虎踞 阳关 归酣 霜天 含风 励锋 分疆 星火 楚歌 绝期 重烟 心境
--自动断上将，打飞镖
--作者：翅桶#2743
--最后修改日期：2018/7/03

--获取自己的Player对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--如果当前门派不是霸刀，输出错误信息
if player.dwForceID ~= FORCE_TYPE.BA_DAO then
	s_util.OutputTip("当前门派不是霸刀，这个宏无法正确运行。", 1)
	return
end

--当前血量比值
local myhp = player.nCurrentLife / player.nMaxLife

--获取当前目标,未进战没目标直接返回,战斗中没目标选择最近敌对NPC,调整面向
local target, targetClass = s_util.GetTarget(player)							
if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
local MinDistance = 20		--最小距离
local MindwID = 0		    --最近NPC的ID
for i,v in ipairs(GetAllNpc()) do		--遍历所有NPC
	if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then  --如果是敌对，并且距离更小
		MinDistance = s_util.GetDistance(v, player)                             
		MindwID = v.dwID                                                                  --替换距离和ID
		end
	end
if MindwID == 0 then 
    return --没有敌对NPC则返回
else	
    SetTarget(TARGET.NPC, MindwID)  --设定目标为最近的敌对NPC                
end
end
if target then s_util.TurnTo(target.nX,target.nY,target.nZ) end

--如果目标死亡，直接返回
if target.nMoveState == MOVE_STATE.ON_DEATH then return end

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取目标的buff表
local TargetBuff = s_util.GetBuffInfo(target)
local mTargetBuff = s_util.GetBuffInfo(target,true)

--获取自己和目标的距离
local dis = s_util.GetDistance(player, target)
if dis > 3.5 then
s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
else
MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
end

--给目标挂上闹须弥
if (not TargetBuff[11447] or TargetBuff[11447].dwSkillSrcID ~= player.dwID) and s_util.GetSkillCD(17057) <= 0 then		--如果目标没有闹须弥buff或者不是我的，闹须弥冷却
	if player.nPoseState ~= POSE_TYPE.DOUBLE_BLADE then		--如果不是松烟竹雾姿态
		s_util.CastSkill(16166, false)						--施放松烟竹雾
		return
	end
	s_util.CastSkill(17057,false)							--释放 闹须弥
	return
end


--如果是松烟竹雾切姿态
if player.nPoseState == POSE_TYPE.DOUBLE_BLADE then
	if s_util.GetSkillCD(16621) <= 0 and player.nCurrentSunEnergy >= 10  then					--如果坚壁清野冷却了，气劲大于等于10
		s_util.CastSkill(16169, false)						--施放雪絮金屏
	end
	--if player.nCurrentRage > 25 and dis < 6 then
	--	s_util.CastSkill(16168, false)						--施放秀明尘身
	--end
	--擒龙3段+飞镖
	if s_util.CastSkill(16870,false) then return end
	if MyBuff[11156] then 
		if s_util.CastSkill(34,false) then return end
	end
	if s_util.CastSkill(16871,false) then return end
	if s_util.CastSkill(16872,false) then return end
	if  MyBuff[11156] and MyBuff[11156].nStackNum > 1 and player.nCurrentRage > 28 then
		s_util.CastSkill(16168, false)						--施放秀明尘身
	end
end


--如果是秀明尘身姿态
if player.nPoseState == POSE_TYPE.BROADSWORD then
	if MyBuff[11322] and MyBuff[11322].nLeftTime < 0.7 then s_util.CastSkill(18976,false,true) end
	if dis > 8 then  s_util.CastSkill(16166, false) return end --切刀追击
	--优先放坚壁清野
	if s_util.GetSkillCD(16621) <= 0 and player.nCurrentSunEnergy >= 10 then					--如果坚壁清野冷却了，气劲大于等于10
		--切换到雪絮金屏姿态
		s_util.CastSkill(16169, false,true)
		return
	end
	if player.nCurrentRage < 5 then  s_util.CastSkill(16166, false,true) return end --没狂切刀

	--雷走风切
	if s_util.CastSkill(16629, false) then return end

		--上将军印 7刀
	if s_util.CastSkill(19344, false) then return end

	if player.nCurrentSunEnergy > 20 then s_util.CastSkill(16169, false) return end

	--破釜沉舟 cw特效可以打
	--if MyBuff[xxx] then
	--	if s_util.CastSkill(16602, false) then return end
	--end

	--项王击鼎321段
	if s_util.CastSkill(17079, false) then return end
	if s_util.CastSkill(17078, false) then return end
	if s_util.CastSkill(16601, false) then return end
end


--如果是雪絮金屏姿态 
if player.nPoseState == POSE_TYPE.SHEATH_KNIFE then
	--处理雪絮金屏姿态气劲用完的情况
	if player.nCurrentSunEnergy < 5 then				--如果气劲小于5点
		s_util.CastSkill(16166, false)					--施放松烟竹雾
		return
	end

	--坚壁清野
	if s_util.CastSkill(16621, false,true) then return end


	--切到秀明尘身
	if s_util.GetSkillCD(19344) <= 0 then		--
		s_util.CastSkill(16168, false,true)			--施放秀明尘身
		return
	end

	--刀啸风吟
	if s_util.CastSkill(16027,false) then return end	--施放刀啸风吟
	--醉斩白蛇
	if s_util.CastSkill(16085, false) then return end
end
