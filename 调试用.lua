--玩家对象
local player = GetClientPlayer()
--目标对象
local target = s_util.GetTarget(player)


-- #调试函数声明开始#

--输出Table
--参数(表:对象)
--返回值:无
local function outputTable(t)
    local s_Output_r_cache={}
    local function sub_s_Output_r(t,indent)
        if (s_Output_r_cache[tostring(t)]) then
            s_Output(indent.."*"..tostring(t))
        else
            s_Output_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        s_Output(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_s_Output_r(val,indent..string.rep(" ",string.len(pos)+8))
                        s_Output(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        s_Output(indent.."["..pos..'] => "'..val..'"')
                    else
                        s_Output(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                s_Output(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        s_Output(tostring(t).." {")
        sub_s_Output_r(t,"  ")
        s_Output("}")
    else
        sub_s_Output_r(t,"  ")
    end
    s_Output()
end

local npc_mjrw = s_util.GetNpc(53233)
local npc_mjrw2 = s_util.GetNpc(36780)
local npc_mjrw3 = s_util.GetNpc(36774)
local npc_mjrw1 = s_util.GetTarget(player)
if npc_mjrw then
s_Output("NPC")
s_Output("最大血量"..npc_mjrw.nMaxLife)
s_Output("等级"..npc_mjrw.nLevel)
s_Output("强度"..npc_mjrw.nIntensity)
s_Output("状态"..npc_mjrw.nMoveState)
s_Output("雇主"..npc_mjrw.dwEmployer)
s_Output("蓝量"..npc_mjrw.nMaxMana)
s_Output(npc_mjrw.bFightState)
end
if npc_mjrw1 then
s_Output("目标")
s_Output("最大血量"..npc_mjrw1.nMaxLife)
s_Output("等级"..npc_mjrw1.nLevel)
s_Output("强度"..npc_mjrw1.nIntensity)
s_Output("状态"..npc_mjrw1.nMoveState)
s_Output("雇主"..npc_mjrw1.dwEmployer)
end
if npc_mjrw2 then
    s_Output("陷阱")
    s_Output("最大血量"..npc_mjrw2.nMaxLife)
    s_Output("等级"..npc_mjrw2.nLevel)
    s_Output("强度"..npc_mjrw2.nIntensity)
    s_Output("状态"..npc_mjrw2.nMoveState)
    s_Output("雇主"..npc_mjrw2.dwEmployer)
    s_Output("蓝量"..npc_mjrw2.nMaxMana)
    s_Output(npc_mjrw2.bFightState)
    end

    if npc_mjrw3 then
        s_Output("陷阱")
        s_Output("最大血量"..npc_mjrw3.nMaxLife)
        s_Output("等级"..npc_mjrw3.nLevel)
        s_Output("强度"..npc_mjrw3.nIntensity)
        s_Output("状态"..npc_mjrw3.nMoveState)
        s_Output("雇主"..npc_mjrw3.dwEmployer)
        s_Output("蓝量"..npc_mjrw3.nMaxMana)
        s_Output(npc_mjrw3.bFightState)
    end

