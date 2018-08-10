--[[
奇穴：【圣光明】【慈悲心】【寂灭】【月尽天明】【归寂道】【极乐引】【纵遇善缘】【妙境惊寂】【渡厄力】【日月同辉】【无量妙境】【心火叹】
1.奇穴根据需要自行调整，第11层奇穴“无量妙境”会影响攒灵循环；
2.默认战斗中自动无目标自动选目标，自动追击，自动戒火斩，自动慈悲愿，满灵打生死劫。
3.启用宏后可在右侧工具箱扳手菜单中找到"明尊PVE宏工具"菜单自定义以上内容
--]]

--开头必须是这个，先获取自己的对象，没有的话说明还没进入游戏，直接返回
local player = GetClientPlayer()
if not player then return end

--------------------------↓↓↓↓自定义菜单区开始↓↓↓↓-------------------------
--定义菜单用全局变量表
if not g_MacroVars.Mingjiao_MingZun then
    g_MacroVars.Mingjiao_MingZun = {
        ["Auto_Target"] = true,   --战斗中自动选择目标，默认开启
        ["Auto_Move"] = true,     --自动追击，默认开启
        ["Auto_Jiehuo"] = true,   --自动戒火斩，默认开启
        ["Auto_Cibei"] = true,    --自动慈悲愿，默认开启
        ["Mode_FullPow"] = 1,     --满灵模式，默认双生死劫
    }
end

--定义扳手菜单 为全局变量
if not g_MacroVars.Mingjiao_MingZun.TollMenu then
    g_MacroVars.Mingjiao_MingZun.TollMenu = {
        szOption = "明尊琉璃体",
        szIcon = "ui/Image/icon/mingjiao_taolu_7.UITex",
        nFrame =105,
        nMouseOverFrame = 106,
        szLayer = "ICON_RIGHT",
        {
            szOption = "自动目标",
            bCheck = true, 
            bChecked =function() return g_MacroVars.Mingjiao_MingZun.Auto_Target end,
            fnAction =function() 
                g_MacroVars.Mingjiao_MingZun.Auto_Target = not g_MacroVars.Mingjiao_MingZun.Auto_Target
            end,
        },
        {
            szOption = "自动追击",
            bCheck = true, 
            bChecked =function() return g_MacroVars.Mingjiao_MingZun.Auto_Move end,
            fnAction =function() 
                g_MacroVars.Mingjiao_MingZun.Auto_Move = not g_MacroVars.Mingjiao_MingZun.Auto_Move
            end,
        },
        {
            szOption = "自动戒火",
            szIcon = "ui/Image/icon/skill_mingjiao14.UITex",
            nFrame =105,
            nMouseOverFrame = 106,
            szLayer = "ICON_RIGHT",
            bCheck = true, 
            bChecked =function() return g_MacroVars.Mingjiao_MingZun.Auto_Jiehuo end,
            fnAction =function() 
                g_MacroVars.Mingjiao_MingZun.Auto_Jiehuo = not g_MacroVars.Mingjiao_MingZun.Auto_Jiehuo
            end,
        },
        {
            szOption = "自动慈悲",
            szIcon = "ui/Image/icon/skill_mingjiao35.UITex",
            nFrame =105,
            nMouseOverFrame = 106,
            szLayer = "ICON_RIGHT",
            bCheck = true, 
            bChecked =function() return g_MacroVars.Mingjiao_MingZun.Auto_Cibei end,
            fnAction =function() 
                g_MacroVars.Mingjiao_MingZun.Auto_Cibei = not g_MacroVars.Mingjiao_MingZun.Auto_Cibei
            end,
        },
        {   szOption = "满灵模式选择",
            {
                szOption = "满灵双劫",
                szIcon = "ui/Image/icon/skill_mingjiao29.UITex",
                nFrame =105,
                nMouseOverFrame = 106,
                szLayer = "ICON_RIGHT",
                bMCheck=true,
                bCheck = true, 
                bChecked =function() return g_MacroVars.Mingjiao_MingZun.Mode_FullPow == 1 end,
                fnAction =function() 
                    g_MacroVars.Mingjiao_MingZun.Mode_FullPow = 1
                end,
            },
            {
                szOption = "满灵双破",
                szIcon = "ui/Image/icon/skill_mingjiao31.UITex",
                nFrame =105,
                nMouseOverFrame = 106,
                szLayer = "ICON_RIGHT",
                bMCheck=true,
                bCheck = true, 
                bChecked =function() return g_MacroVars.Mingjiao_MingZun.Mode_FullPow == 2 end,
                fnAction =function() 
                    g_MacroVars.Mingjiao_MingZun.Mode_FullPow = 2
                end,
            },
            {
                szOption = "月劫日破",
                bMCheck=true,
                bCheck = true, 
                bChecked =function() return g_MacroVars.Mingjiao_MingZun.Mode_FullPow == 3 end,
                fnAction =function() 
                    g_MacroVars.Mingjiao_MingZun.Mode_FullPow = 3
                end,
            },
            {
                szOption = "日劫月破",
                bMCheck=true,
                bCheck = true, 
                bChecked =function() return g_MacroVars.Mingjiao_MingZun.Mode_FullPow == 4 end,
                fnAction =function() 
                    g_MacroVars.Mingjiao_MingZun.Mode_FullPow = 4
                end,
            },
        },
    }
end

--判断菜单是否已加载
local menuisaction = false
for i,v in ipairs(TraceButton_GetAddonMenu()) do
    if type(v)=="table" then
        if v.szOption and v.szOption == "明尊琉璃体" then
            menuisaction = true
            break
        end
    end
end

--判定未加载菜单则在工具箱菜单插入宏菜单
if not menuisaction then
    TraceButton_AppendAddonMenu({g_MacroVars.Mingjiao_MingZun.TollMenu})
end

--局部化菜单变量
local Auto_Target = g_MacroVars.Mingjiao_MingZun.Auto_Target
local Auto_Move = g_MacroVars.Mingjiao_MingZun.Auto_Move
local Auto_Jiehuo = g_MacroVars.Mingjiao_MingZun.Auto_Jiehuo
local Auto_Cibei = g_MacroVars.Mingjiao_MingZun.Auto_Cibei
local Mode_FullPow = g_MacroVars.Mingjiao_MingZun.Mode_FullPow

--------------------------↑↑↑↑自定义菜单区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓目标处理区开始↓↓↓↓-------------------------
--获取当前目标,未进战没目标直接返回,战斗中没目标选择最近敌对NPC,调整面向
local target, targetClass = s_util.GetTarget(player)							
if Auto_Target and (not target or not IsEnemy(player.dwID, target.dwID))then 
    if player.bFightState then
        local MinDistance = 20			--最小距离
        local MindwID = 0		    --最近NPC的ID
        for i,v in ipairs(GetAllNpc()) do		--遍历所有NPC
            if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.CanSeeName then	--如果是敌对，并且距离更小
                MinDistance = s_util.GetDistance(v, player)                             
                MindwID = v.dwID     --替换距离和ID
            end
        end
        if MindwID == 0 then 
            return                  --没有敌对NPC则返回
        else	
            SetTarget(TARGET.NPC, MindwID)  --设定目标为最近的敌对NPC                
        end
    else
        return
    end
end
local target, targetClass = s_util.GetTarget(player)

--如果没有目标或目标死亡，直接返回
if not target or target.nMoveState == MOVE_STATE.ON_DEATH then return end
--------------------------↑↑↑↑目标处理区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓变量定义区开始↓↓↓↓-------------------------
--判断目标读条，这里没有做处理，可以判断读条的技能ID做相应处理(打断、迎风回浪、挑起等等)
local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--返回 是否在读条, 技能ID，等级，剩余时间(秒)，动作类型

--获取自己的buff表
local MyBuff = s_util.GetBuffInfo(player)

--获取自己对目标造成的buff表
local TargetBuff = s_util.GetBuffInfo(target, true)

--获取目标全部的buff表
local TargetBuffAll = s_util.GetBuffInfo(target)

--当前血量比值
local hpRatio = player.nCurrentLife / player.nMaxLife

--获取自己和目标的距离
local distance = s_util.GetDistance(player, target)

--简化日月能量
local CurrentSun=player.nCurrentSunEnergy/100
local CurrentMoon=player.nCurrentMoonEnergy/100

--获取我的读条数据
local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)

--------------------------↓↓↓↓追击位移区开始↓↓↓↓-------------------------

if target and IsEnemy(player.dwID, target.dwID) and Auto_Move then 
    --调整面向
    s_util.TurnTo(target.nX,target.nY) 

    if distance > 8 and player.bFightState then if s_util.CastSkill(3970,false) then return end end --幻光
    if distance > 8 and player.bFightState then if s_util.CastSkill(18633,false) then return end end --幻光

    --追击
    if not IsKeyDown("W") then
        if distance > 3.5 then
            s_util.TurnTo(target.nX,target.nY) 
            MoveForwardStart()
        else
            MoveForwardStop()
            s_util.TurnTo(target.nX,target.nY)
        end
    end
end
--------------------------↑↑↑↑追击位移区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓应急技能区开始↓↓↓↓-------------------------
--取消自己身上的无威胁气劲buff
if MyBuff[4487] then s_util.CancelBuff(4487) end  --明教极乐
if MyBuff[917] then s_util.CancelBuff(917) end    --大师阵
if MyBuff[8422] then s_util.CancelBuff(8422) end  --苍云盾墙
if MyBuff[926] then s_util.CancelBuff(926) end    --天策阵
if MyBuff[4101] then s_util.CancelBuff(4101) end  --天策引羌笛
--------------------------↑↑↑↑应急技能区结束↑↑↑↑-------------------------

--------------------------↓↓↓↓输出循环区开始↓↓↓↓-------------------------

--戒火斩
if Auto_Jiehuo and (not TargetBuff[4058] or TargetBuff[4058].nLeftTime < 1) then
	if s_util.CastSkill(3980,false) then return end
end

--满灵前使用心火叹
if player.nSunPowerValue > 0 or player.nMoonPowerValue > 0 or MyBuff[9909] and MyBuff[9909].nLeftTime < 12.97 and player.nCurrentSunEnergy > player.nCurrentMoonEnergy then
    if s_util.CastSkill(14922,false) then return end
end

--按下F切换为破魔循环
if Mode_FullPow==1 then --满灵双劫
    --生死劫
    if s_util.CastSkill(3966,false) then return end
elseif Mode_FullPow==2 then --满灵双破
    --破魔
    if s_util.CastSkill(3967,false) then return end
elseif Mode_FullPow==3 then --月劫日破
    if player.nSunPowerValue > 0 then
        if s_util.CastSkill(3967,false) then return end
    end
    if player.nMoonPowerValue > 0 then
        if s_util.CastSkill(3966,false) then return end
    end
elseif Mode_FullPow==4 then --日劫月破
    if player.nMoonPowerValue > 0 then
        if s_util.CastSkill(3967,false) then return end
    end
    if player.nSunPowerValue > 0 then
        if s_util.CastSkill(3966,false) then return end
    end
end

--慈悲愿
if Auto_Cibei then
    if s_util.CastSkill(3982,false) then return end
end

--银月斩优先月循环上仇
if CurrentMoon >= CurrentSun and CurrentMoon < 61  then
    if  s_util.CastSkill(3960,false)  then return end
end

-- 烈日斩，日灵>月灵时释放
if CurrentSun > CurrentMoon and CurrentSun < 61 then
    if  s_util.CastSkill(3963,false)  then return end
end

-- 日灵大于等于月灵且不满灵时打赤日轮
if CurrentSun >= CurrentMoon and CurrentSun < 100 then
    if  s_util.CastSkill(3962,false)  then return end
end

--月灵大于日灵且不满灵时打幽月轮
if CurrentSun < CurrentMoon and CurrentMoon < 100 then
    if s_util.CastSkill(3959,false) then return end
end