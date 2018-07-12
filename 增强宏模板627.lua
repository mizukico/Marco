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

--分割字符串
--参数(初始文本:字符串,分割文本:字符串)
--返回值:{sub1,sub2,...}
function Split(s, sp)  
    local res = {}  
    local temp = s  
    local len = 0  
    while true do  
        len = string.find(temp, sp)  
        if len ~= nil then  
            local result = string.sub(temp, 1, len-1)  
            temp = string.sub(temp, len+1)  
            table.insert(res, result)  
        else  
            table.insert(res, temp)  
            break  
        end  
    end  
  
    return res  
end  

--获取表长度
--参数(表:对象)
--返回值:表长度(整数型)
local function getTableLength(t)
	local length = 0
	for k,v in pairs(getTableLength) do
		length = length + 1
	end
	return(length)
end

--筛选表
--参数(表:对象,筛选函数:函数)
--返回值:符合筛选条件表(对象)
local function filtTable(t,filter,reIndex)
	if(reIndex == nil) then reIndex = true end
	local newT = {}
	for key,value in pairs(t) do
		if(filter(value)) then 
			if(reIndex) then table.insert(newT,value)
			else newT[key] = value end
		end
	end
	return(newT)
end

-- #调试函数声明结束#


-- #基础函数申明开始#

--获取玩家职业名称
--参数(玩家:对象)
--返回值:玩家职业名称(字符串)
local function getPlayerForceName(playerObject)
	if(not playerObject) then return ("无对象") end
	if(not IsPlayer(playerObject.dwID)) then
		return("非玩家")
	end
	local forceNames = {'大侠','少林','万花','天策','纯阳','七秀','五毒','唐门','藏剑','丐帮','明教',[22]='苍云',[23]='长歌',[24]='霸刀'}
	return(forceNames[playerObject.dwForceID+1])
end

--获取玩家心法名称
--参数:(玩家:对象)
--返回值:玩家心法名称(字符串)
local function getPlayerMountName(playerObject)
	if(not playerObject) then return ("无对象") end
	if(not IsPlayer(playerObject.dwID)) then
		return("非玩家")
	end
	local mountObject = playerObject.GetKungfuMount()
	if(mountObject) then
		return(mountObject.szSkillName)
	else
		return("未知")
	end
end

--获取五毒宠物技能
--参数(玩家:对象)
--返回值:{{name = 技能名称,id = 技能ID}...}
local function getWuduPetSkills(playerObject)
	local petObject = playerObject.GetPet()
	local skills = {}
	if(petObject) then
		petSkills = Table_GetPetSkill(petObject.dwTemplateID)
		for key,value in pairs(petSkills) do
			local skillName = Table_GetSkillName(value[1],value[2])
			local skillInfo = {}
			skillInfo.name = skillName
			skillInfo.id = value[1]
			table.insert(skills,skillInfo)
		end
		return(skills)
	else
		return(skills)
	end
end

--获取唐门机关技能
--参数(玩家:对象)
--返回值:{[技能名称]:{技能ID}}
local function getTangmenPuppetSkills()
	local tempID = s_util.GetPuppet()
	local tianLuoSkills = {}
	local skills = {}
	--千机变底座形态
	if(tempID == 16174) then
		tianLuoSkills = {['连弩形态']=3368,['重弩形态']=3369,['毒刹形态']=3370}
	elseif(tempID == 16175 or tempId == 16176) then
		tianLuoSkills = {['攻击']=3360,['停止']=3382,['鬼斧神工']=3110}
	elseif(tempID == 16177) then
		tianLuoSkills = {['毒刹形态']=3370}
	end
	for key,value in pairs(tianLuoSkills) do
		local skillInfo = {}
		skillInfo.name = key
		skillInfo.id = value
		table.insert(skills,skillInfo)
	end
	return(skills)
end

--获取玩家技能列表
local function getPlayerSkillTable(playerObject)
	local skills = {}
	for key,value in pairs(playerObject.GetAllSkillList()) do
		local skillInfo = {}
		skillInfo.name = Table_GetSkillName(key,value)
		skillInfo.id = key
		table.insert(skills,skillInfo)
	end
	--五毒宠物技能获取
	if(getPlayerForceName(playerObject) == "五毒") then
		for key,value in pairs(getWuduPetSkills(playerObject)) do
			table.insert(skills,value)
		end
	end
	--唐门机关技能获取
	if(getPlayerForceName(playerObject) ==  "唐门") then
		for key,value in pairs(getTangmenPuppetSkills(playerObject)) do
			table.insert(skills,value)
		end
	end
	return(skills)
end

--获取玩家Buff列表
--参数(玩家:对象)
--返回值:{[buff名称]:{id = BuffID,leftTime = 剩余时间,stackNum = 层数,level:Buff等级,srcId:Buff来源对象}}
local function getPlayerBuffTable(playerObject)
	local playerBuff = {}
	local buffTable = s_util.GetBuffInfo(playerObject)
	for key,value in pairs(buffTable) do
		local buffInfo = Table_GetBuff(value.dwID,value.nLevel)
		if(buffInfo) then
			local infoTable = {}
			infoTable.id = value.dwID
			infoTable.level = value.nLevel
			infoTable.leftTime = value.nLeftTime
			infoTable.stackNum = value.nStackNum
			infoTable.srcId = value.dwSkillSrcID
			playerBuff[buffInfo["szName"]] = infoTable
		end
	end
	return(playerBuff)
end

--获取周围NPC列表
--参数(无)
--返回值:({[npc名称]:{id = NpcID,tempId = Npc模板ID,distance = npc距离}})
local function getNearbyNpcTable()
	local npcList = GetAllNpc()
	local npcInfoTable = {}
	for key,npcObject in pairs(npcList) do 
		if(npcObject) then
			local npcInfo = {}
			npcInfo.id = npcObject.dwID
			npcInfo.tempId = npcObject.dwTemplateID
			npcInfo.distance = s_util.GetDistance(player,npcObject)
			npcInfoTable[npcObject.szName] = npcInfo
		end
	end
	return(npcInfoTable)
end

--获取周围玩家列表
--参数(无)
--返回值:{[玩家名称]:{id = 玩家ID,life=玩家血量比例,force=玩家门派,mount=玩家心法,distance=玩家距离}}
local function getNearbyPlayerTable()
	local playerList = GetAllPlayer()
	local playerInfoTable = {}
	for key,playerObject in pairs(playerList) do 
		if(playerObject) then
			local playerInfo = {}
			playerInfo.id = playerObject.dwID
			playerInfo.life = playerObject.nCurrentLife/playerObject.nMaxLife
			playerInfo.force = getPlayerForceName(playerObject)
			playerInfo.mount = getPlayerMountName(playerObject)
			playerInfo.distance = s_util.GetDistance(player,playerObject)
			playerInfoTable[playerObject.szName] = playerInfo
		end
	end
	return(PlayerInfoTable)
end

--根据ID释放技能
--参数(技能ID:整数,技能名称:字符串,是否异步释放技能:布尔)
--返回值:技能释放成功(布尔)
local function castSkillById(skill,skillName,async)
	--当目标为敌人且技能为增益气场时,优先对自己释放
	if(target and IsEnemy(player.dwID,target.dwID)) then
		if(skillName == "生太极" or skillName == "破苍穹" or skillName == "碎星辰" or skillName == "千机变") then
			return(s_util.CastSkill(skill,true,async))
		end
	end
	--当技能为蛊虫献祭且宠物不存在时,取消释放技能
	if(skillName == "蛊虫献祭" and player.GetPet() == nil) then return(false) end
	--尝试对目标释放技能,释放失败则对自己释放
	local res = s_util.CastSkill(skill,false,async)
	if(res) then return(res) else return(s_util.CastSkill(skill,true,async)) end
end

-- #基础函数申明结束#


-- $基础变量声明开始$

buffs = getPlayerBuffTable(player)
tbuffs = getPlayerBuffTable(target)
skills = getPlayerSkillTable(player)
tbuffsm = filtTable(tbuffs,function(buffo) return(buffo.srcId == player.dwID) end,false)
nearbyNpcs = getNearbyNpcTable()
nearbyPlayers = getNearbyPlayerTable()

-- $基础变量声明结束$


-- #封装函数申明开始#

--输出信息
--参数(信息:字符串)
--返回值:无
local function msg(message)
	s_util.OutputTip(message)
end

--使用物品
--参数(物品名称:字符串)
--返回值:是否使用成功(布尔)
local function use(itemName)
	local item =  g_ItemNameToID[itemName]
	if(item) then
		return(s_util.UseItem(item[1],item[2]))
	else
		return(false)
	end
end

--释放技能
--参数(技能名称:字符串)
--返回值:是否释放成功(布尔)
local function cast(skillName)
	local skillList = filtTable(skills,function(sobject) return(sobject.name == skillName) end)
	for key,value in pairs(skillList) do
		local res = castSkillById(value.id,value.name,false)
		if(res) then return(res) end
	end
	return(false)
end

--异步释放技能
--参数(技能名称:字符串)
--返回值:是否释放成功(布尔)
local function fcast(skillName)
	local skillList = filtTable(skills,function(sobject) return(sobject.name == skillName) end)
	for key,value in pairs(skillList) do
		local res = castSkillById(value.id,value.name,true)
		if(res) then return(res) end
	end
	return(false)
end

--打断自身读条
--参数(无)
--返回值:无
local function stopcast()
	s_util.StopSkill()
end

--选择玩家
--参数(玩家名称:字符串)
--返回值:是否选择成功(布尔)
local function selectP(playerName)
	local player = nearbyPlayers[playerName]
	if(player) then SetTarget(TARGET.PLAYER,player.id) return true else return false end
end

--选择NPC
--参数(NPC名称:字符串)
--返回值:是否选择成功(布尔)
local function selectN(npcName)
	local npc = nearbyNpcs[npcName]
	if(npc.id) then SetTarget(TARGET.NPC,npc.id) return true else return false end
end

--获取自身Buff层数
--参数(Buff名称:字符串)
--返回值:自身Buff层数(整数)
local function buff(buffName)
	if(buffs[buffName]) then 
		return(buffs[buffName]['stackNum'])
	else 
		return(0) end
end

--获取自身Buff剩余时间
--参数(Buff名称:字符串)
--返回值:自身Buff剩余时间(浮点数)
local function bufftime(buffName)
	if(buffs[buffName]) then 
		return(buffs[buffName]['leftTime'])
	else 
		return(0) end
end

--获取目标Buff层数
--参数(Buff名称:字符串)
--返回值:目标Buff层数(整数)
local function tbuff(buffName)
	if(tbuffs[buffName]) then 
		return(tbuffs[buffName]['stackNum'])
	else 
		return(0) end
end

--获取目标Buff剩余时间
--参数(Buff名称:字符串)
--返回值:目标Buff剩余时间(浮点数)
local function tbufftime(buffName)
	if(tbuffs[buffName]) then 
		return(tbuffs[buffName]['leftTime'])
	else 
		return(0) end
end

--判断自身状态
--参数(状态名称:字符串)
--返回值:自身是否处于状态(布尔)
local function state(stateName)
	local buffTypes = {
	['无敌']= {'弘法', '长致', '鬼斧神工', '镇山河', '雷霆震怒', '太虚', '散流霞', '水魂', '冥泽', '南风吐月', '平沙落雁', '伪·守如山'},
	['反弹']= {'罗汉金身', '无相诀', '盾立', '无相决'},
	['平沙']= {'平沙落雁'},
	['爆发']= {'贯木流华', '凤鸣', '心无旁骛', '光明相', '贯木流年', '疏狂', '紫气东来', '繁音急节', '莺鸣柳', '酒中仙', '布散', '满堂', '激雷', '擒龙诀', '朝圣', '灵蛇献祭', '疾如风', '重激', '渊', '义薄云天', '青龙', '号令三军', '弱水', '高山流水', '扬威', '莺鸣', '疾如风-烈', '乱洒青荷'},
	['免控']= {'流火飞星', '超然', '秘影', '音韵', '生死之交', '迷心蛊', '折骨', '临渊蹈河', '圣法光明', '风蜈献祭', '不工', '力拔', '尘身', '破重围', '突', '无惧', '蛊虫献祭', '西楚悲歌', '烟雨行', '浮空', '梦泉虎跑', '千蝶吐瑞', '捍卫', '石间意', '生太极', '水月无间', '龙跃于渊', '青霄飞羽', '圣体', '笑醉狂', '玉泉鱼跃', '贪魔体', '啸日', '灵辉', '千险', '宽野', '星楼月影', '绝伦逸群', '纵轻骑', '盾墙', '青阳', '蛊虫狂暴', '捣衣', '行天道', '转乾坤', '劫化', '孤影', '吞日月', '飞鸢逐月', '盾毅', '鹊踏枝', '探梅', '霸体'},
	['减伤']= {'轮回', '金屋', '烟消云散', '亮节', '无相诀', '残影', '乘龙戏水', '曳光', '御天', '上将军印', '笑傲光阴', '玄水蛊', '天音知脉', '青霄飞羽', '天地低昂', '贪魔体', '易水', '女娲补天', '寒梅', '守如山', '无我', '无相决', '绝歌', '圣手织天', '蝶戏水', '转乾坤', '春泥护花', '孤影', '散影', '龙啸九天', '盏萤'},
	['闪避']= {'雾雨', '流影', '云栖松', '两生', '御风而行', '慈悲愿', '惊鸿游龙', '风吹荷', '逐星', '醉逍遥'},
	['击倒']= {'踏宴扬旗', '肃杀'},
	['沉默']= {'兰摧玉折', '雷云', '摧城枪·撕喉', '劲刺', '风切', '井仪', '剑飞惊天'},
	['缴械']= {'霞流', '怖畏暗刑', '霞流宝石'},
	['封轻功'] = {'封轻功'},
	['封内']= {'八卦洞玄', '剑心通明', '剑破虚空', '蟾啸迷心', '抢珠式', '梅花针', '凄切', '清音长啸', '厥阴指'},
	['减疗']= {'吞楚', '神龙降世', '楚济', '淤肉断骨击', '月劫', '盾击', '霹雳', '尘息', '百足枯残', '玄一', '穿心弩'},
	['禁疗']= {'息疗', '活祭'},
	['眩晕']= {'猛击', '幻光步', '断魂刺', '割据秦宫', '镇魔', '盾猛', '突', '日劫', '千斤坠', '危楼', '五蕴皆空', '御城·精准', '疾', '北斗', '醉月', '大狮子吼', '撼地', '伏夜·晕', '御城·抛掷', '硝烟弥漫', '地动山摇', '刺魄', '鹤归孤山', '雷震子', '裁骨', '崩', '致盲', '蝎心迷心 ', '天云挂雷', '剑冲阴阳', '净世破魔击', '王眼镇魂', '盾毅', '迷神钉', '日影', '虎贲'},
	['定身']= {'幻蛊', '金针', '迷影', '七星拱瑞', '千针暗沼', '同归', '帝骖龙翔', '伏夜·定', '松涛', '破势', '芙蓉并蒂', '大道无术', '破冰真气', '丝牵', '安患', '葬魂'},
	['锁足']= {'碎冰', '割据秦宫', '落雁', '钟林毓秀', '孔雀翎', '百步缠丝手', '五方行尽', '断筋', '吐故纳新', '转落七星', '擒龙', '冻土', '伏夜·缠', '割据擒宫', '禁缚', '剑·羽', '刖足', '逐星箭', '太阴指', '百足迷心', '滞', '影狱', '铁爪', '复征', '三才化生', '绕足', '天蛛献祭'},
	['减速']= {'卷云', '剑主天地', '业力', '伏尘', '步迟', '轰雷', '埋骨', '生太极', '鸿爪留泥', '击鼎', '景行', '惊风', '惊涛', '缠足', '业海罪缚', '御城·断股', '不善', '禁缚', '徵', '少阳指', '伏夜·缓', '冰封', '玄一', '难行', '千丝', '穿', '抱残式', '剑·宫', '毒蒺藜', '绕足', '暴雨梨花针'}
	}
	for btype,buffs in pairs(buffTypes) do
		for i,v in pairs(buffs) do 
			if(buff(v) > 0) then
				if(btype == stateName) then return true end
			end
		end
	end
	return false
end

--判断自身不在状态
--参数(状态名称:字符串)
--返回值:自身是否不处于状态(布尔)
local function nostate(stateName)
	return(not state(skillName))
end

--判断目标状态
--参数(状态名称:字符串)
--返回值:目标是否处于状态(布尔)
local function tstate(stateName)
	local buffTypes = {
	['无敌']= {'弘法', '长致', '鬼斧神工', '镇山河', '雷霆震怒', '太虚', '散流霞', '水魂', '冥泽', '南风吐月', '平沙落雁', '伪·守如山'},
	['反弹']= {'罗汉金身', '无相诀', '盾立', '无相决'},
	['平沙']= {'平沙落雁'},
	['爆发']= {'贯木流华', '凤鸣', '心无旁骛', '光明相', '贯木流年', '疏狂', '紫气东来', '繁音急节', '莺鸣柳', '酒中仙', '布散', '满堂', '激雷', '擒龙诀', '朝圣', '灵蛇献祭', '疾如风', '重激', '渊', '义薄云天', '青龙', '号令三军', '弱水', '高山流水', '扬威', '莺鸣', '疾如风-烈', '乱洒青荷'},
	['免控']= {'流火飞星', '超然', '秘影', '音韵', '生死之交', '迷心蛊', '折骨', '临渊蹈河', '圣法光明', '风蜈献祭', '不工', '力拔', '尘身', '破重围', '突', '无惧', '蛊虫献祭', '西楚悲歌', '烟雨行', '浮空', '梦泉虎跑', '千蝶吐瑞', '捍卫', '石间意', '生太极', '水月无间', '龙跃于渊', '青霄飞羽', '圣体', '笑醉狂', '玉泉鱼跃', '贪魔体', '啸日', '灵辉', '千险', '宽野', '星楼月影', '绝伦逸群', '纵轻骑', '盾墙', '青阳', '蛊虫狂暴', '捣衣', '行天道', '转乾坤', '劫化', '孤影', '吞日月', '飞鸢逐月', '盾毅', '鹊踏枝', '探梅', '霸体'},
	['减伤']= {'轮回', '金屋', '烟消云散', '亮节', '无相诀', '残影', '乘龙戏水', '曳光', '御天', '上将军印', '笑傲光阴', '玄水蛊', '天音知脉', '青霄飞羽', '天地低昂', '贪魔体', '易水', '女娲补天', '寒梅', '守如山', '无我', '无相决', '绝歌', '圣手织天', '蝶戏水', '转乾坤', '春泥护花', '孤影', '散影', '龙啸九天', '盏萤'},
	['闪避']= {'雾雨', '流影', '云栖松', '两生', '御风而行', '慈悲愿', '惊鸿游龙', '风吹荷', '逐星', '醉逍遥'},
	['击倒']= {'踏宴扬旗', '肃杀'},
	['沉默']= {'兰摧玉折', '雷云', '摧城枪·撕喉', '劲刺', '风切', '井仪', '剑飞惊天'},
	['缴械']= {'霞流', '怖畏暗刑', '霞流宝石'},
	['封轻功'] = {'封轻功'},
	['封内']= {'八卦洞玄', '剑心通明', '剑破虚空', '蟾啸迷心', '抢珠式', '梅花针', '凄切', '清音长啸', '厥阴指'},
	['减疗']= {'吞楚', '神龙降世', '楚济', '淤肉断骨击', '月劫', '盾击', '霹雳', '尘息', '百足枯残', '玄一', '穿心弩'},
	['禁疗']= {'息疗', '活祭'},
	['眩晕']= {'猛击', '幻光步', '断魂刺', '割据秦宫', '镇魔', '盾猛', '突', '日劫', '千斤坠', '危楼', '五蕴皆空', '御城·精准', '疾', '北斗', '醉月', '大狮子吼', '撼地', '伏夜·晕', '御城·抛掷', '硝烟弥漫', '地动山摇', '刺魄', '鹤归孤山', '雷震子', '裁骨', '崩', '致盲', '蝎心迷心 ', '天云挂雷', '剑冲阴阳', '净世破魔击', '王眼镇魂', '盾毅', '迷神钉', '日影', '虎贲'},
	['定身']= {'幻蛊', '金针', '迷影', '七星拱瑞', '千针暗沼', '同归', '帝骖龙翔', '伏夜·定', '松涛', '破势', '芙蓉并蒂', '大道无术', '破冰真气', '丝牵', '安患', '葬魂'},
	['锁足']= {'碎冰', '割据秦宫', '落雁', '钟林毓秀', '孔雀翎', '百步缠丝手', '五方行尽', '断筋', '吐故纳新', '转落七星', '擒龙', '冻土', '伏夜·缠', '割据擒宫', '禁缚', '剑·羽', '刖足', '逐星箭', '太阴指', '百足迷心', '滞', '影狱', '铁爪', '复征', '三才化生', '绕足', '天蛛献祭'},
	['减速']= {'卷云', '剑主天地', '业力', '伏尘', '步迟', '轰雷', '埋骨', '生太极', '鸿爪留泥', '击鼎', '景行', '惊风', '惊涛', '缠足', '业海罪缚', '御城·断股', '不善', '禁缚', '徵', '少阳指', '伏夜·缓', '冰封', '玄一', '难行', '千丝', '穿', '抱残式', '剑·宫', '毒蒺藜', '绕足', '暴雨梨花针'}
	}
	for btype,buffs in pairs(buffTypes) do
		for i,v in pairs(buffs) do 
			if(tbuff(v) > 0) then
				if(btype == stateName) then return true end
			end
		end
	end
	return false
end

--判断目标不在状态
--参数(状态名称:字符串)
--返回值:目标是否不处于状态(布尔)
local function tnostate(stateName)
	return(not tstate(skillName))
end

--获取自身技能CD
--参数(技能名称:字符串)
--返回值:剩余冷却时间(浮点数)
local function cd(skillName)
	local skill = g_SkillNameToID[skillName]
	if(not(skill) and getPlayerForceName(player) == "五毒") then
		skill = getWuduPetSkills(player)[skillName]
	end
	if(skill) then
		return(s_util.GetSkillCD(skill))
	else
		return(9999)
	end
end

--判断自身技能不在CD
--参数(技能名称:字符串)
--返回值:是否自身技能不处于CD(布尔)
local function nocd(skillName)
	return(cd(skillName) <= 0)
end

--获取自身技能充能层数
--参数(技能名称:字符串)
--返回值:自身技能剩余充能层数(整数)
local function charge(skillName)
	local skill = getPlayerSkillTable(player)[skillName]
	if(skill) then
		return(s_util.GetSkillCN(skill))
	else
		return(-1)
	end
end

--获取自身技能充能CD
--参数(技能名称:字符串)
--返回值:自身技能充能CD(浮点数)
local function chargetime(skillName)
	local skill = getPlayerSkillTable(player)[skillName]
	if(skill) then
		local ch,chtime = s_util.GetSkillCN(skill)
		return(chtime)
	else
		return(-1)
	end
end

--获取自身技能透支次数
--参数(技能名称:字符串)
--返回值:自身技能剩余透支次数(整数)
local function stack(skillName)
	local skill = getPlayerSkillTable(player)[skillName]
	if(skill) then
		return(s_util.GetSkillOD(skill))
	else
		return(-1)
	end
end

--获取自身读条进度
--参数(技能名称:字符串)
--返回值:自身当前读条进度(浮点数)
local function prepare(skillName)
	local bPrepare,skillId,skillLv,progress,otType =  GetSkillOTActionState(player)
	if(bPrepare) then
		if(Split(GetSkill(skillId,skillLv).szSkillName,'_')[1] == skillName) then
			return(progress)
		else
			return(0)
		end
	else
		return(0)
	end
end

--获取目标读条进度
--参数(技能名称:字符串)
--返回值:目标当前读条进度(浮点数)
local function tprepare(skillName)
	local bPrepare,skillId,skillLv,progress,otType =  GetSkillOTActionState(target)
	if(bPrepare) then
		msg(GetSkill(skillId,skillLv).szSkillName..tostring(otType))
		if(string.find(GetSkill(skillId,skillLv).szSkillName,skillName) ~= nil) then
			return(progress)
		else
			return(0)
		end
	else
		return(0)
	end
end

--判断自身是否读条
--参数(技能名称:字符串)
--返回值:自身当前是否读条(布尔)
local function isprepare(skillName)
	local bPrepare,skillId,skillLv,progress,otType =  GetSkillOTActionState(player)
	if(bPrepare) then
		if(string.find(GetSkill(skillId,skillLv).szSkillName,skillName) ~= nil) then
			return(true)
		else
			return(false)
		end
	else
		return(false)
	end
end

--判断目标是否读条
--参数(技能名称:字符串)
--返回值:目标当前是否读条(布尔)
local function tisprepare(skillName)
	local bPrepare,skillId,skillLv,progress,otType =  GetSkillOTActionState(target)
	if(bPrepare) then
		if(string.find(GetSkill(skillId,skillLv).szSkillName,skillName) ~= nil) then
			return(true)
		else
			return(false)
		end
	else
		return(false)
	end
end

-- #封装函数申明结束#


-- $封装变量申明开始$

--判断自身目标类型
local function Ftargettype()
	if(not(target)) then return ("none") end
	if(IsPlayer(target.dwID)) then
		return("player")
	else
		return("npc")
	end
end

--判断自身是否无目标
local function Fnotarget()
	return(target == nil)
end

--判断自身是否在战斗状态
local function Ffight()
	if(player) then
		return(player.bFightState)
	else
		return(false)
	end
end

--获取目标距离
local function Fdistance()
	if(target) then
		return(s_util.GetDistance(player,target))
	else
		return(999)
	end
end

local force = getPlayerForceName(player)
local mount = getPlayerMountName(player)
local tforce = getPlayerForceName(target)
local tmount = getPlayerMountName(target)
local distance = Fdistance()
local targettype = Ftargettype()
local fight = Ffight()
local notarget = Fnotarget()

-- $宏封装变量申明结束$