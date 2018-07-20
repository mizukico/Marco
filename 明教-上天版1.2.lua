--定义技能ID
  赤日轮  =3962  幽月轮 =3959  净世破魔击 =3967   流光囚影 = 3977  冥月渡心=18629 烈日斩 =3963  银月斩 = 3960   伏明众生=18626   生死劫 =3966 无明魂锁 = 4910  驱夜断愁 =3979   生灭予夺 = 3978  暗尘弥散 =3974   光明相 =3969  大漠刀法=4326  幻光步 =3970  贪魔体 = 3973  怖畏暗刑=3975  幻光步2=18633 
  大狮子吼=252  摩诃无量=236 大道无术 =366
--定义BUFF
  隐身F =4052  隐身2F =5496  贯木流华F = 9908 贯木流年F = 9906  暗尘F =4052  生灭F=4056  光明相F = 4423  月劫F =4030  日劫F =4029  无明魂锁F = 4871   贪魔体F =4439  冥月渡心F =12491  南风吐月F= 9934  镇山河F=377
--定义技能UIID
  赤日轮U =3868  幽月轮U =3808    烈日斩U =3796   生灭U=3799   隐身U=3785    流光U =3795  幻光步U = 4173   生太极2F=11991  秘隐F=12665  贪魔体U =4178
  镇山河F=377  松烟竹雾F = 11151  影歌F=9694  影歌F2=9693
--其他职业给予的免控
  蛊虫狂暴F = 2840 BF蛊虫狂暴F2 = 2830    梦泉虎跑F =1802
--定义奇穴
  日月齐光 =18635 善恶如梦 =6727  超然物外 =5984  光影=6893  知我罪我 =4173  超凡入圣=6720
--监控爆发类的技能
  浮光掠影=3112  冥月渡心=18629   紫气东来 =2681 繁音急节 =568  擒龙诀=260   乱洒青荷=2645

  nReset_CRL=0
  nReset_YYL=0

  脚本说明("更新日记4/24，优化常规输出·6秒爆发秒人。支持全奇穴")

--明教免控  
  超然F =4468 灵辉 =4421   

是否扶摇 =0
扶摇消失 =0

ID魂锁连控 = 设置门派("魂锁控连",2222)
ID脱战隐身 = 设置门派("脱战隐身",2222)
ID自动光明 = 设置门派("自动光明",2222)
ID自动驱夜 = 设置门派("自动驱夜",2222)
ID自动解控 = 设置门派("自动解控",2222)
ID减疗模式 = 设置门派("减疗模式",2222)
ID生死劫·眩晕 = 设置门派("生死劫·眩晕",2222)

设置脚本名("明教PVP")

贪墨体保护 = 0

	if 加载 ==0 and m门派==m明教 then
        手动技能("烈日斩",烈日斩)
	手动技能("贪魔体",贪魔体)
	手动技能("生灭予夺",生灭予夺)
	手动技能("暗尘弥散",暗尘弥散)
	手动技能("幻光步",幻光步)
	手动技能("净世破魔击",净世破魔击)
	手动技能("生死劫",生死劫)
	手动技能("冥月渡心",冥月渡心)
	手动技能("伏明众生",伏明众生)
	手动技能("驱夜断愁",驱夜断愁)
	手动技能("无明魂锁",无明魂锁)
	手动技能("流光囚影",流光囚影)
	加载=1
	end 

	
function 明教PVP ()


	if 加载 ==0 and m门派==m明教 then
        手动技能("烈日斩",烈日斩)
	手动技能("贪魔体",贪魔体)
	手动技能("生灭予夺",生灭予夺)
	手动技能("暗尘弥散",暗尘弥散)
	手动技能("幻光步",幻光步)
	手动技能("净世破魔击",净世破魔击)
	手动技能("生死劫",生死劫)
	手动技能("冥月渡心",冥月渡心)
	手动技能("伏明众生",伏明众生)
	手动技能("驱夜断愁",驱夜断愁)
	手动技能("无明魂锁",无明魂锁)
	手动技能("流光囚影",流光囚影)
	手动技能("赤日轮",赤日轮)
	手动技能("幽月轮",幽月轮)
	手动技能("怖畏暗刑",怖畏暗刑)
	加载=1
	end 
			   
获取玩家目标状态()

local t盾立 =bufftimeT(盾立)
local t日劫 =bufftimeT(日劫F)
local f隐身=bufftimeR(隐身F)
local f隐身2=bufftimeR(隐身2F)
local f冥月渡心=bufftimeR(冥月渡心F)
local f日盈 = bufftimeR(12487)
local f暗尘 = bufftimeR(暗尘F)
local ft松烟竹雾=bufftimeT(松烟竹雾F)
local ft梦泉虎跑=bufftimeT(梦泉虎跑F)
local cn贪魔体=UICALL(贪魔体U,UI_CHONGNENG)
local f生灭 = bufftimeR(生灭F)
local m贪魔体F = bufftimeR(贪魔体F)
local af流光= SkillAfter(流光囚影)
local cd银月斩=技能CD(银月斩)
local m橙武 = bufftimeR(1911,1912,1913,1914,1915,1916,1917,1918,1919,1920,1921,1922,3028,3487,3488,4930,4931,6466,6471,8474,10192,11376,12768)
local ft长歌减伤= bufftimeR(影歌F,影歌F2)
local ft急曲=GetBuffS("自身",急曲F)
local N对敌玩家_60尺 = 周围敌对玩家(60)
local 魂锁连控 = 门派设置是否开启(ID魂锁连控)
local 脱战隐身 = 门派设置是否开启(ID脱战隐身)
local 自动光明 = 门派设置是否开启(ID自动光明)
local 自动驱夜 = 门派设置是否开启(ID自动驱夜)
local 自动解控 = 门派设置是否开启(ID自动解控)
local 减疗模式 = 门派设置是否开启(ID减疗模式)
local 生死劫·眩晕 = 门派设置是否开启(ID生死劫·眩晕)	
local t门派=menpai(target)
local 日月齐光=技能等级(日月齐光)
local GCD=技能GCD(赤日轮)
local 赤日轮CD=技能CD(赤日轮)
local bufftime生死劫月 =bufftimeT(生死劫月F)
local fm明教免控 = bufftimeR(超然物外,蛊虫狂暴F,蛊虫狂暴F2,秘隐F)
local f月劫 = bufftimeT(月劫F)
local nState = 目标状态()
local t镇山河 = bufftimeT(镇山河F)
local t南风吐月 = bufftimeT(南风吐月F)
local t不控 = bufftimeT(11361,11385,10258,11077,11148,11149,16381,8247,8864,1186,4439,5994,5995,5996,8458,1802,3973)

--技能监控判断

local nC乱洒青荷 , nC乱洒青荷ID = 敌对对自己释放的技能(乱洒青荷,2000,20)
local nC浮光掠影 , nC浮光掠影ID = 敌对对自己释放的技能(浮光掠影,1500,30)
local nC捉影式 , nC捉影式ID = 敌对对自己释放的技能(捉影式,500,25)
local nC千斤坠 , nC千斤坠ID = 敌对对自己释放的技能(千斤坠,400,20)
local nC浮光掠影 , nC浮光掠影ID = 敌对对自己释放的技能(浮光掠影,400,30)
local nC盾猛 , nC盾猛ID =   敌对对自己释放的技能(盾猛,400,12)
local nC撼地 , nC撼地ID = 敌对对自己释放的技能(撼地,400,20)
local nC断魂刺 , nC断魂刺ID = 敌对对自己释放的技能(断魂刺,400,27)
local nC擒龙诀 , nC擒龙诀ID = 敌对对自己释放的技能(擒龙诀,10000,10)
local nC龙跃于渊 , nC龙跃于渊ID = 敌对对自己释放的技能(龙跃于渊,7000,20)
local nC龙战于野 , nC龙战于野ID = 敌对对自己释放的技能(龙战于野,7000,20)
local nC繁音急节 , nC繁音急节ID = 敌对对自己释放的技能(繁音急节,7000,20)
local nC紫气东来 , nC紫气东来ID = 敌对对自己释放的技能(紫气东来,3000,20)
local 预判_醉月 = 预判敌对技能(醉月,15000,8,问水,"剑气",15)
local 预判_破坚阵,预判_破坚阵ID = 预判敌对技能(破坚阵,15000,4,傲血,"战意",3)
local 预判_剑影留痕,预判_剑影留痕ID = 预判敌对技能(剑影留痕,8000,10,冰心,0,0)
local 预判_剑破虚空,预判_剑破虚空ID = 预判敌对技能(剑破虚空,8000,20,冰心,"禅那",4)

        if 脱战隐身 == 1 and 脱战瞬间() == 1 then
		if  f隐身 <0 and f冥月渡心 <0 then
		释放(暗尘弥散)
		end
        end

        读条保护()   
        是否敌对()

        if 自动驱夜 == 0 and 技能触发(暗尘弥散,4000) == 1 then 
                return 0
	end

        if SkillAfter(无明魂锁)>0 and SkillAfter(无明魂锁)<1300 then 
                return 0
	end
        

        --核弹爆发

        if ISNPC() == 4 and 技能等级(14698) == 1 and t免封内 <0 then
        if SkillAfter(生灭予夺) > 1500 then
		释放(怖畏暗刑) 
        end
        if SkillAfter(怖畏暗刑) < 1300 then
		释放(光明相,1)
	end        
        if SkillAfter(光明相) < 1300 then
                释放(烈日斩)
	end
        if SkillAfter(烈日斩) < 1500 then
		释放(驱夜断愁)
	end 
        if SkillAfter(驱夜断愁) < 1500 then
		释放(伏明众生)
	end 
        if SkillAfter(伏明众生) < 3000 and SkillAfter(光明相) < 9000 then
		释放(净世破魔击)
	end
        if bufftimeT(6365) >0 and SkillAfter(生灭予夺) > 7000 and SkillAfter(暗尘弥散) > 2000 and SkillAfter(光明相) < 9000 then
                释放(暗尘弥散)
        end
        if SkillAfter(暗尘弥散) < 999 and SkillAfter(净世破魔击) < 3000 then
		释放(生灭予夺)
	end
        if SkillAfter(生灭予夺) < 1500 then
		释放(怖畏暗刑)
	end
        if SkillAfter(怖畏暗刑) < 1300 and SkillAfter(光明相) > 1500 then
		释放(驱夜断愁)
	end
        if SkillAfter(生灭予夺) > 888 and SkillAfter(生灭予夺) < 9000 then
		释放(净世破魔击) 
		释放(驱夜断愁)
		释放(银月斩)
                释放(烈日斩)
	end
        if 脱战瞬间() == 1 then
	if f隐身 <0 and f冥月渡心 <0 then
		释放(暗尘弥散)
	end
        end
                return 0
	end 

  
        if t盾立 < 0 and 自动驱夜 ==1 and bufftimeT(无明魂锁F) <0 then
	if f冥月渡心<0 then
		释放(驱夜断愁)
		end
	end

	if f隐身 < 4000 then 
        if m封内 > 2000  and GCD ==1   and t门派~=m五毒  and t门派~=m七秀 and t门派 ~=m唐门   and 玩家.nState ~= 轻功  and m贪魔体F < 0  then
		改变面向(128)
			if bufftimeR(扶摇F)>0 then
			  跳(1,1)
			end
		释放(蹑云逐月)
		释放(凌霄揽胜)
        end 

        if m沉默 > 2000  and GCD ==1   and t门派~=m五毒  and t门派~=m七秀 and t门派 ~=m唐门   and 玩家.nState ~= 轻功   and m贪魔体F < 0  then
		改变面向(128)
			if bufftimeR(扶摇F)>0 then
			  跳(1,1)
			end
		释放(蹑云逐月)
		释放(凌霄揽胜)
        end 

        if t盾立 > 0 or t镇山河 > 0 or t南风吐月 > 0 or m贪魔体F > 0 then
		return 0
	end   
  
        if 防止嘲讽() == 1 and GCD==1  and 玩家.nState ~= 轻功  then

        end 

        if m贪魔体F < 0 then 
	        回避风车躲控制()
        end

        if 目标.nState == 死亡 then 
                return 0  
        end

        if nC乱洒青荷 == me then
		释放(贪魔体)
	end

        if f冥月渡心 >0 and m贪魔体F <0 and Distance <12 and 风车==0 then
		面对目标()
        end 

        if af流光 <1000 and GCD==1 and m贪魔体F <0 and bufftimeT(无明魂锁F) <0 and 风车==0 and Distance < 6 then
	        面对目标()
        end 

        技能前置(生死劫,1000)
	技能前置(无明魂锁,1000)
	技能前置(净世破魔击,1000)
	
	if m贪魔体F <0 then
		技能前置(贪魔体,1000)	
	end 
	
	if t门派 == 霸刀 and Distance < 60 then
		释放(扶摇)
	end 

	if bufftimeT(无明魂锁F) >0 then
        if bufftimeT(无明魂锁F) <3333 then
                释放(驱夜断愁)
        end
	if bufftimeT(无明魂锁F) <2000 then
	if 玩家.满月==1 then
                释放(大漠刀法)
	        释放(净世破魔击)
	end			
	if 玩家.满日==1 then
		释放(大漠刀法)
		释放(生死劫)
	end
        if 玩家.月灵 >= 6000 then
		释放(银月斩)
        end
        if 玩家.日灵 >= 6000 then
		释放(烈日斩)
        end
	end
        return 0
	end

	if ISNPC() == 3 then
		攻击(净世破魔击)
	end 

        --技能监控

        if fm明教免控 <0 and f冥月渡心 <0 and SkillAfter(流光囚影) > 3000 and SkillAfter(暗尘弥散)> 2000 and SkillAfter(幻光步)>3000 and m免伤<0 then
        if CheckSkill(1577,0,1000) == me or CheckSkill(1596,0,900) == me or CheckSkill(13424,0,900) == me or CheckSkill(5259,0,900) == me or CheckSkill(18604,0,900) == me or CheckSkill(18633,0,900) == me or CheckSkill(16455,0,1300) == me or CheckSkill(16621,0,1300) == me or CheckSkill(242,0,1500) == me then
                        释放(凌霄揽胜)
		        释放(迎风回浪)
		        释放(瑶台枕鹤) 
	end
        end       
       
        if fm明教免控 <0 and f冥月渡心 <0 and SkillAfter(暗尘弥散)> 2000 and SkillAfter(幻光步)>3000 and m免伤<0 then
        if CheckSkill(5269,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(1613,0,2500) == me then
                        释放(流光囚影)
	end
        if CheckSkill(2690,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(5262,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(303,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(5266,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(428,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(3977,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(15187,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(16479,0,900) == me then
                        释放(流光囚影)
	end
        if CheckSkill(13046,0,900) == me then 
                        释放(流光囚影)                  
        end      
        if CheckSkill(13054,0,900) == me then
                        释放(流光囚影) 
	end
        if CheckSkill(16621,0,900) == me then
                        释放(流光囚影) 
	end
        if CheckSkill(228,0,900) == me then
                        释放(流光囚影) 
	end
        end 

        if fm明教免控 <0 and f冥月渡心 <0 and SkillAfter(流光囚影) > 3000 and SkillAfter(暗尘弥散)> 3000 and SkillAfter(幻光步)>3000 and m免伤<0 then
        if 预判_醉月 == me or 预判_摩诃无量 == me or 预判_大道无术 == me then
		释放(凌霄揽胜)
		释放(迎风回浪)
		释放(瑶台枕鹤)
                释放(流光囚影)
	end 
	if 预判_破坚阵 == me  and t马御>0 and 目标ID() == 预判_破坚阵ID then
		释放(凌霄揽胜)
		释放(迎风回浪)
		释放(瑶台枕鹤)
		释放(流光囚影)
	end
        end

        if m贪魔体F <0 and m免伤<0 and m减伤<0 and f冥月渡心 < 0 and SkillAfter(暗尘弥散)>2000 and  SkillAfter(冥月渡心)>2000 then
		if nC浮光掠影 == me or nC乱洒青荷 == me then
		  释放(贪魔体)
		end 
		if  玩家.nHP <70 then
		if nC繁音急节 == me then  
			if 预判_剑影留痕 == me then
				 释放(贪魔体)
			end 
		end 
			if nC繁音急节 == me then   
				if 预判_剑破虚空 == me  and ft急曲 >=1 then
					 释放(贪魔体)
				end 
			end
		end
		if  被集火 == 1 then	
			if nC紫气东来 == me and 目标.nHP > 30 then
				释放(贪魔体)
			end
		end		
		if  被集火 >=2 then
			if nC紫气东来 == me and 目标.nHP > 30 and 玩家.nHP <80 then
				释放(贪魔体)
			end
		end 
		if 附近的风车() == 1 then
		  if bufftimeR(扶摇F)> 0 then
			跳(1,1)
		  end 
		
		end 
	end

        if CheckSkill(3110,0,700) == me and m贪魔体F < 0  and m免伤<0 and m减伤<0 and f冥月渡心 < 0 and SkillAfter(暗尘弥散)>2000 and SkillAfter(冥月渡心)>2000 then
                        改变面向(128)
                        释放(蹑云逐月)
	end

        if m贪魔体F < 0 and m免伤<0 and m减伤<0 and f冥月渡心 <0 and SkillAfter(暗尘弥散) >2000 and SkillAfter(冥月渡心)>2000 and 玩家.nHP <77 then
        if CheckSkill(260,0,900) == me or CheckSkill(1596,0,900) == me or CheckSkill(2681,0,900) == me or CheckSkill(3112,0,900) == me or CheckSkill(3094,0,900) == me or CheckSkill(3969,0,900) == me or CheckSkill(313,0,900) == me or CheckSkill(15193,0,900) == me or CheckSkill(3110,0,900) == me or        
        CheckSkill(3978,0,700) == me or CheckSkill(18629,0,700) == me then
	                释放(贪魔体)
	end
        end

        if 目标.nHP > 30 and Distance > 15 and 玩家.nState ~= 浮空 and 玩家.nState ~= 轻功 then
		        释放(扶摇,1)
	end

	--减伤	

        if SkillAfter(暗尘弥散)> 2000 and f冥月渡心 < 0 and m贪魔体F <0 and SkillAfter(冥月渡心)>2000 then
	if t风车 == 1 and Distance < 10 then
	if cn贪魔体 == 2 then
		释放(贪魔体)
	end 
        end
        if t风车 == 1 and Distance <10 and m贪魔体F < 0 and 技能CD(蹑云逐月)==0 and bufftimeR(扶摇F)<0 and 玩家.nState ~=浮空 then
	if cn贪魔体 == 1 then
		释放(贪魔体)
	end 
        end 	
	if 玩家.nHP < 35 and 目标.nHP > 玩家.nHP and m减伤 <0 and 被集火>=1 and t控制 ==0 then
		释放(贪魔体)
	end 
	end

        --自动解控  

	if 自动解控 == 1 and SkillAfter(流光囚影) >3000 and f冥月渡心 <0 and SkillAfter(冥月渡心) >9000 and m贪魔体F < 0 then
	if 技能等级(18634) ==1 and m控制 ==1 then
		释放(幻光步2,4,20,1)
	end
        if SkillAfter(幻光步2)> 3000 and 玩家.nState == E then
		释放(流光囚影)
	end 
	end 

	if 玩家.nState == 后仰 then
		释放(蹑云逐月)
	end 

        --光明

        if 自动光明 == 1 then
        if 玩家.满日 == 1 and 不可控制减伤BUFF<0 then
	if t沉默 <1000 and SkillAfter(怖畏暗刑)>1000 then
	if 玩家.月灵 <3000 and t免伤 < 0 and  t减伤 < 0 and f冥月渡心 <0 and m橙武 <0 then
		攻击(光明相,1,15)
	end
        end
        end

        if bufftimeT(生死劫月F) < 4000  and t控制==0  then
        if 玩家.满月 == 1 and 不可控制减伤BUFF <0 and t风车==0 then  
	if t免控<0 and Distance > 8  and  玩家.日灵 < 3000 and  m橙武 <0 and t控制==0 then
		释放(光明相,1,17)
	end 
        end
        end
        end
	
        --大招

	if t免伤<0 and t减伤 <0 then
		攻击(伏明众生,0,8)
	end 
	if t免伤<0 and f生灭 < 0 then
		攻击(冥月渡心,0,12)  
	end
	if t免伤<0 and t门派 ==m纯阳  then
		攻击(伏明众生,0,8)
	end 
	if t免伤<0 and t门派 ==m纯阳 and f生灭 < 0 then
		攻击(冥月渡心,0,12)  
	end 
	if t免伤<0 and t门派 ==m纯阳 and f生灭 < 0 then
		攻击(冥月渡心,0,12)  
	end

        --减疗
        
        if 减疗模式 == 1 and m贪魔体F <0 and GCD == 1 and 玩家.满月 == 1 and t减疗 <2000 then
	    释放(生死劫,2,6,1)	
        end
        if 减疗模式 == 1 and m贪魔体F <0 and GCD == 1 and 技能等级(6727) == 1 and t减疗 <2000 then
	    释放(生死劫,2,6,1)	
        end


        --月大输出
 	
	if f冥月渡心 > 0 then  
                释放(驱夜断愁)
        if 生死劫·眩晕 == 1 and 玩家.满日 == 1 and GCD==1 and m贪魔体F <0 and m橙武 <0 and t不控 <0 and SkillAfter(生死劫) > 8000 then
	        控制(生死劫,眩晕,10,2,6,1)	
        end
        if t免伤<0 and m橙武 >0 then
		释放 (净世破魔击)
	end
        if 玩家.满日 == 1 or 玩家.满月 == 1 then
		释放(净世破魔击)
        end
        if SkillAfter(生死劫) <7000 and SkillAfter(生死劫) > 10 then
	        释放(净世破魔击)
	end
		if 玩家.月灵 >=  玩家.日灵 then
			释放(银月斩)
			if 技能CD(银月斩)==0 and 技能CD(驱夜)==0 then
				释放(幽月轮)
			end
			else
                        if bufftimeT(日劫F) <0 then
			释放(烈日斩)
                        end
			if 技能CD(烈日斩)==0 and 技能CD(驱夜)==0 then
				释放(赤日轮)
			end
		end
             return 0
	end

        --控制

        if ISNPC() == 4 and Distance >8 and 技能等级(知我罪我) == 1 and Distance <20 and 玩家.满日 == 0 and 玩家.满月 == 0 then
	    控制(幻光步,眩晕,900,4,20,1)
	end
        if ISNPC() == 4 and 生死劫·眩晕 == 1 and 玩家.满月 == 1 and m贪魔体F <0 and m橙武 <0 and f冥月渡心 <0 and f生灭 <0 and bufftimeR(光明相F) <0 and GetBuffS("目标",日劫F) >=1 and bufftimeT(日劫F) <700 and Distance <15 then
	    return 0	
        end
        if GCD==1 and 玩家.满月 == 1 and t不控 <0 then
	    控制(净世破魔击,眩晕,1000,2,15,1)	
        end
        if ISNPC() == 4 and 生死劫·眩晕 == 1 and GCD==1 and m贪魔体F <0 and 玩家.满日 == 1 and f冥月渡心 <0 and m橙武 <0 and t不控 <0 then
	    控制(生死劫,眩晕,1000,2,6,1)	
        end
        if ISNPC() == 4 and SkillAfter(生死劫) >1500 and t不控 <0 and 可控制减伤BUFF >300 and 目标.nState~= 后仰 and 目标.nState~= 轻功 and 目标.nState~=爬起 and 目标.nState~=击退 and 目标.nState~=击退2 then
	    控制(无明魂锁,眩晕,1000)	
        end
        if ISNPC() == 4 and 魂锁连控 == 1 and t不控 <0 and SkillAfter(净世破魔击) <2300 and SkillAfter(净世破魔击) >0 and t沉默 <1300 and m橙武 <0 and SkillAfter(怖畏暗刑) >1000 and bufftimeR(光明相F) <0 and SkillAfter(光明相)>1000 and SkillAfter(冥月渡心)>9000 and f冥月渡心 <0 and f生灭 <0 then
	    控制(无明魂锁,眩晕,1000)
	end
     
        --缴械

        if ISNPC() == 4 and ft梦泉虎跑<0 and 玩家.满日 ~= 1 and 玩家.满月 ~= 1 and t封内 <0 and t沉默 <0 and t控制 ==0 and t不控 <0 and 不可控制减伤BUFF <0 and t免封内 <0 and ft松烟竹雾<0 and t门派 ~=m丐帮 then
		释放(怖畏暗刑)
	end 
        
        --常规输出
        
	释放(驱夜断愁)

        if t免伤<0 and m橙武 >0 then
		释放(净世破魔击)
	end
        if 玩家.满日 == 1 or 玩家.满月 == 1 then
		释放(净世破魔击)
        end
                if 玩家.月灵>=8000 then
			释放(幽月轮)
		end
		if 玩家.日灵>=6000 then
			释放(烈日斩)
		end 
		if 玩家.日灵  >  玩家.月灵   then
			if  玩家.日灵 >= 8000 then
				释放(赤日轮)
			end
		end
		if 玩家.月灵 >= 5600 then
			释放(银月斩)
		end 
		if 日月齐光 > 0 then
			if SkillAfter(幽月轮) >  SkillAfter(赤日轮) then
				释放(幽月轮)
				else
				释放(赤日轮)
			end
		end 
			释放(烈日斩)
			释放(银月斩)
			释放(幽月轮)
			释放(赤日轮)
        end
        end