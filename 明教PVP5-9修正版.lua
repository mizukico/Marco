---更新日记 (PVP5-9) 6/30  手动技能里面增加关闭对NPC输出月大日大模式
---更新日记（PVP5-7）   5/10 优化驱咦套路的隐身问题，识别附近的风车
---更新日记   5/10 优化魂锁控制问题，优化小轻功 优化缴械
---更新日记  3/5  优化月大输出问题 
---更新日记 2/23  增强控制衔接，修复不打日劫BUG
---更新日记 1/25 修复目标死亡后月大的情况下也会锁定目标BUG,这版本隐身下不驱夜---更新日记 1/16 优化了月大的输出，增加了幻光步的自动解控
---更新日记 1/18降低扶摇的优先等级让输出更流畅，
---更新日记 1/17 修复超凡入圣识别错误问题，修复触发明教橙武BUFF后会用光明相问题
---更新日记 1/16 )
---专门针对按下触发试写的一个版本 
--使用说明
---还有隐身自己手动，没有写隐身自动解控
脚本说明("奇穴适用 \n  [[血泪成悦][日月凌天][燎原烈火][善法肉身|超凡入圣][恶秽满路][辉耀红尘][善恶如梦][超然物外][天地诛戮][秘影诡行][伏明众生][冥月渡心]  \n  \n 增加减疗模式，此模式针对超凡入圣奇穴写的，可以上减疗(按下银月斩后就会进入减疗模式，按下破魔击或者生死劫就会切换回来普通的输出模式  \n  \n 如果需要手动流光，推荐在门派设置那里关闭流光追击，因为脚本的自动流光可以有效的回避某些职业的控制 \n 更新日记  3/26 修复隐身BUG导致脚本发呆问题 ")
--定义技能ID
  赤日轮  =3962  幽月轮 =3959  破魔击 =3967   流光  = 3977  冥月渡心=18629    烈日斩 =3963  银月斩 = 3960   伏明众生=18626   生死劫 =3966 贪魔体 =3973  魂锁= 4910  驱夜 =3979 生灭=3978  隐身 =3974   光明相 =3969  大漠刀法=4326  幻光步 =3970  贪墨体 = 3973  怖畏暗刑=3975  幻光步2=18633
--定义BUFF
隐身F =4052  隐身2F =5496  贯木流华F = 9908 贯木流年F = 9906  暗尘F =4052  生灭F=4056  光明相F=4423  生死劫月F=4030   无名魂锁F = 4871  贪墨体F =4439  冥月渡心F =12491   明教橙武F=4930
--定义技能UIID
赤日轮U =3868  幽月轮U =3808    烈日斩U =3796   生灭U=3799   隐身U=3785    流光U =3795  幻光步U = 4173   生太极2F=11991  秘隐F=12665  贪墨体U =4178
镇山河F=377  松烟竹雾F = 10814  影歌F=9694 影歌F2=9693  月破控F=6365   秀明尘身F = 10815   雪絮金屏F =10816

----其他职业给予的免控
蛊虫狂暴F = 2840 BF蛊虫狂暴F2 = 2830    梦泉虎跑F =1802
--定义奇穴
   日月齐光 =18635 善恶如梦 =6727  超然物外 =5984  光影=6893  知我罪我 =4173  超凡入圣=6720   驱夷逐法=14698
nReset_CRL=0
nReset_YYL=0
--明教免控  
超然F =4468 灵辉 =4421   




是否扶摇 =0
扶摇消失 =0


追击 =1
ID流光追击 = 设置门派("流光追击",2222)
ID自动解控 = 设置门派("自动解控",2222)
ID魂锁连控 = 设置门派("魂锁控连",2222)
ID自动驱夜 = 设置门派("自动驱夜",2222)

设置脚本名("明教PVP")
--  定义变量
贪墨体保护 = 0
	if  加载 ==0 and m门派==m明教 then
    手动技能("烈日斩",烈日斩)
	手动技能("贪魔体",贪魔体)
	手动技能("生灭",生灭)
	手动技能("隐身",隐身)
	手动技能("幻光步",幻光步)
	手动技能("破魔击",破魔击)
	手动技能("生死劫",生死劫)
	手动技能("冥月渡心",冥月渡心)
	手动技能("伏明众生",伏明众生)
	手动技能("驱夜",驱夜)
	手动技能("魂锁",魂锁)
	手动技能("流光",流光)
	加载=1
	end 

	
	
function 明教PVP ()


	if  加载 ==0 and m门派==m明教 then
    手动技能("烈日斩",烈日斩)
	手动技能("贪魔体",贪魔体)
	手动技能("生灭",生灭)
	手动技能("隐身",隐身)
	手动技能("幻光步",幻光步)
	手动技能("破魔击",破魔击)
	手动技能("生死劫",生死劫)
	手动技能("冥月渡心",冥月渡心)
	手动技能("伏明众生",伏明众生)
	手动技能("驱夜",驱夜)
	手动技能("魂锁",魂锁)
	手动技能("流光",流光)
	手动技能("赤日轮",赤日轮)
	手动技能("光明相",光明相)
	手动技能("幽月轮",幽月轮)
	手动技能("怖畏暗刑",怖畏暗刑)
	加载=1
	end 
			
 -- 调试信息(手动技能("怖畏暗刑",怖畏暗刑))
 
获取玩家目标状态()

local   t盾立 =bufftimeT(盾立)
local q驱夷逐法=技能等级(驱夷逐法)
local f隐身=bufftimeR(隐身F)
local 魂锁连控 = 门派设置是否开启(ID魂锁连控)
local 流光追击 = 门派设置是否开启(ID流光追击)
local 自动驱夜 = 门派设置是否开启(ID自动驱夜)
local f隐身2=bufftimeR(隐身2F)
local f冥月渡心=bufftimeR(冥月渡心F)
local f日盈 = bufftimeR(12487)
local ft松烟竹雾=bufftimeT(松烟竹雾F)
local ft梦泉虎跑=bufftimeT(梦泉虎跑F)
local cn贪墨体=UICALL(贪墨体U,UI_CHONGNENG)
local f生灭 = bufftimeR(生灭F)
local m贪墨体F = bufftimeR(贪墨体F)
local af流光= SkillAfter(流光)
local cd银月斩=技能CD(银月斩)
local f明教橙武=bufftimeR(明教橙武F)
local ft长歌减伤= bufftimeT(影歌F,影歌F2)
local ft急曲=GetBuffS("自身",急曲F)
local N对敌玩家_60尺   =周围敌对玩家(80)
local ft雪絮金屏=  bufftimeT(雪絮金屏F)
local ft秀明尘身=  bufftimeT(秀明尘身F)
local 劫镖模式=手动技能("对NPC日月大",20001)
if  bufftimeR(扶摇F) <  0 then 
	扶摇消失时间 = Newtime()
end 
	if 脱战瞬间() ==1 then
		if  f隐身 < 0   then
			释放(隐身)
		end
	end
	if    t盾立 < -500  and 自动驱夜==1 then
		 if f冥月渡心<0 then
			释放(驱夜)
		 end
	end
	if	nChenckLS == me then
		释放(贪墨体)
	end

local   t门派=menpai(target)
--调试信息(bufftimeR(4439))
--调试信息(bufftimeR(4468))
--调试信息(t门派)
local   l日月齐光=技能等级(日月齐光)
local   GCD=技能GCD(赤日轮)
local   赤日轮CD=技能CD(赤日轮)
local	bufftime生死劫月 =bufftimeT(生死劫月F)
local fm明教免控=bufftimeR(超然物外,蛊虫狂暴F,蛊虫狂暴F2,秘隐F)
local   f生死劫月=bufftimeT(生死劫月F)
-----------------技能监控判断
local nChenckLS = 敌对对自己释放的技能(2645,2000,20)
local nC浮光掠影 , nC浮光掠影ID = 敌对对自己释放的技能(浮光掠影,1500,30)
local nC捉影式 , nC捉影式ID = 敌对对自己释放的技能(捉影式,500,25)
local nC千斤坠 , nC千斤坠ID = 敌对对自己释放的技能(千斤坠,500,20)
local nC擒王六式 , nC擒王六式ID = 敌对对自己释放的技能(擒王六式,500,20)
local nC浮光掠影 , nC浮光掠影ID = 敌对对自己释放的技能(浮光掠影,400,30)
local nC盾猛 , nC盾猛ID =   敌对对自己释放的技能(盾猛,500,12)
local nC疾 , nC疾ID =   敌对对自己释放的技能(疾,500,15)
local nC撼地 , nC撼地ID = 敌对对自己释放的技能(撼地,500,20)
local nC斩刀 , nC斩刀ID = 敌对对自己释放的技能(斩刀,1000,20)
local nC割据秦宫 , nC割据秦宫ID = 敌对对自己释放的技能(割据秦宫,500,10)
local nC断魂刺 , nC断魂刺ID = 敌对对自己释放的技能(断魂刺,500,27)
local nC坚壁清野 ,nC坚壁清野ID =敌对对自己释放的技能(坚壁清野,2000,27)
local nC疾如风 ,nC疾如风ID =敌对对自己释放的技能(疾如风,4000,8)
local nC擒龙诀 , nC擒龙诀ID = 敌对对自己释放的技能(擒龙诀,10000,8)
local nC龙跃于渊 , nC龙跃于渊ID = 敌对对自己释放的技能(龙跃于渊,500,20)
local nC龙战于野 , nC龙战于野ID = 敌对对自己释放的技能(龙战于野,500,20)
local nc棒打狗头 , nC棒打狗头= 敌对对自己释放的技能(棒打狗头,500,20)
local nC繁音急节 , nC繁音急节ID = 敌对对自己释放的技能(繁音急节,7000,20)
local nC紫气东来 , nC紫气东来ID = 敌对对自己释放的技能(紫气东来,3000,20)
local 预判_醉月 = 预判敌对技能(醉月,15000,8,问水,"剑气",15)
local 预判_醉月2 = 预判敌对技能(醉月,15000,8,居山,"剑气",15)
local 预判_惊涛 = 预判敌对技能(惊涛,15000,8,居山,"剑气",20)
local 预判_破坚阵,预判_破坚阵ID = 预判敌对技能(破坚阵,15000,4,傲血,"战意",3)
local 预判_剑破虚空,预判_剑破虚空ID = 预判敌对技能(剑破虚空,8000,20,冰心,"禅那",4)
local 预判_摩诃无量 = 预判敌对技能(摩诃无量,25000,5,易筋,"禅那",1)
local 预判_大道无术 = 预判敌对技能(大道无术,20000,8,太虚,"气点",6)
local 预判_盾猛 = 预判敌对技能(盾猛,15000,12,分山,0,0)
local 预判_剑影留痕,预判_剑影留痕ID = 预判敌对技能(剑影留痕,8000,10,冰心,0,0)
local 预判_百足,预判_百足ID =预判敌对技能(百足,12000,20,毒经,0,0)
local   nc七星拱瑞 = 全局_敌对对自己读条(七星拱瑞,20,60)
local   nc四象轮回 = 全局_敌对对自己读条(四象轮回,20,60)
local   nc夺魄箭 = 全局_敌对对自己读条(夺魄箭,30,60)
local   nc夺魄箭2 = 全局_敌对对自己读条(夺魄箭2,30,60)
local   nc追命箭 = 全局_敌对对自己读条(追命箭,30,60)
local   nc追命箭2 = 全局_敌对对自己读条(追命箭2,30,60)
local  nc刀啸风吟 = 全局_敌对对自己读条(刀啸风吟,30,60)

-----回避控制
if m免控< 0    and SkillAfter(流光) > 3000 and SkillAfter(隐身)> 3000 and SkillAfter(幻光步)>3000  and m免伤<0  then
	if nC撼地 == 1 or nC千斤坠 == 1 or nC疾 ==1  then
	释放(凌霄揽胜)
	释放(迎风回浪)
	释放(瑶台枕鹤)
	 if SkillAfter(后跳)>5000 then
				释放(后跳)
	 end
	end 
	if nC盾猛 == 1 or nC龙跃于渊==1 or  nC龙战于野==1 or nC割据秦宫 ==1 or nc棒打狗头==1  or nC断魂刺 ==1  then
	 if t风车==0 and  目标附近的离手风车()==0 then
	 end 
		释放(流光)
		释放(贪墨体)
		释放(凌霄揽胜)
		释放(迎风回浪)
		释放(瑶台枕鹤)
		 if SkillAfter(后跳)>5000 then
				释放(后跳)
		 end
	end 
	if nC断魂刺 == 1 then
		释放(流光)
		释放(贪墨体)
	end 

	if 预判_破坚阵 ==1  and t马御>0 and 目标ID()==预判_破坚阵ID then
		释放(凌霄揽胜)
		释放(迎风回浪)
		释放(瑶台枕鹤)
		释放(流光)
		if SkillAfter(后跳)> 7000 then
			释放(后跳)
		end 
	end 
	if nC捉影式==1   then
	  if bufftimeR(扶摇F)> 0 then
		跳(1,1)
	  end 
	  		释放(流光)
		if nC擒龙诀==1 then
		
					释放(贪墨体)
		end 
	end 

end 
-------------------回避伤害

	if m贪墨体F < 0 and m免伤<0 and m减伤<0 and f冥月渡心 < 0 and SkillAfter(隐身)>2000 and  SkillAfter(冥月渡心)>2000  then
		if nC浮光掠影 == 1 or nChenckLS ==1 then --鲸鱼跟花间的爆发
		  释放(贪墨体)
		end 
		if  玩家.nHP <70  then
		if nC繁音急节 ==1  then   ---回避冰心爆发
			if 预判_剑影留痕 == 1   then
				 释放(贪墨体)
			end 
		end 
			if nC繁音急节 ==1  then   ---回避冰心爆发
				if 预判_剑破虚空 == 1  and ft急曲 >=1  then
					 释放(贪墨体)
				end 
			end
		end
		
		if  被集火 == 1 then	
			if nC紫气东来 == 1    then --气纯爆发
				释放(贪墨体)
			end
		end		
		if  被集火 >=2 then
			if nC紫气东来 == 1 and 目标.nHP > 30    then --气纯爆发
				释放(贪墨体)
			end
		end 
		if	附近的风车() ==1 then
		  if bufftimeR(扶摇F)> 0 then
			跳(1,1)
		  end 
		
		end 
	end
		if  m贪墨体F > 0 then
			return 0
		end 
    读条保护()   ----自身读条的时候不会运行后面的代码
    是否敌对()   ----如果没有目标或者目标不是可攻击对象，就不会运行后面的代码
	if f隐身 > 0 and f隐身2 > 0  and   SkillAfter(冥月渡心)>14000  and 技能CD(驱夜)==1  then
		return 0
	end 
  if m封内 > 2000  and GCD ==1   and t门派~=m五毒  and t门派~=m七秀 and t门派 ~=m唐门   and 玩家.nState ~= 轻功  and m贪墨体F < 0  then
		改变面向(128)
		
			if bufftimeR(扶摇F)>0 then
			  跳(1,1)
			end
		释放(蹑云逐月)
		释放(凌霄揽胜)
  end 
    if m沉默 > 2000  and GCD ==1   and t门派~=m五毒  and t门派~=m七秀 and t门派 ~=m唐门   and 玩家.nState ~= 轻功   and m贪墨体F < 0  then
		改变面向(128)
			if bufftimeR(扶摇F)>0 then
			  跳(1,1)
			end
		释放(蹑云逐月)
		释放(凌霄揽胜)
  end 
if t盾立 > -500  or 等待技能BUFF刷新(13067)==1 then
	return 0
end  
  
  
--  调试信息(玩家.满月,玩家.月灵)
if 	防止嘲讽() == 1 and GCD==1  and 玩家.nState ~= 轻功  then
end 
---定义目标BUFF
if  t风车 == 1 and Distance < 10 then
	if cn贪墨体 == 2 then
		释放(贪墨体)
	end 
end

if 附近的风车() == 1 then
  if bufftimeR(扶摇F)>0 then
  立定跳()
  end
  if 玩家.nState ~= 浮空 and  bufftimeR(扶摇F)<0 and m贪墨体F < 0  and 技能CD(蹑云逐月)==0   then
	释放(贪墨体)
  end
end 

if m贪墨体F < 0 then 
		回避风车躲控制()
end
if  t风车 == 1 and Distance < 10 and   m贪墨体F < 0  and 技能CD(蹑云逐月)==0   and  bufftimeR(扶摇F)<0  and  玩家.nState ~=浮空 then
	if cn贪墨体 == 1 then
		释放(贪墨体)
	end 
end
 
local t啸如虎=bufftimeT(免伤.啸如虎)
	if m封内>0  and 技能等级(知我罪我) >0 then
		控制(幻光步,眩晕,900,2)
	end 
    if 目标.nState == 死亡 then  return   end
	local nState = 目标状态()

   if af流光 < 1000  and GCD==1 and  Distance < 15 then
	  面对目标()
   end 
   if  SkillAfter(冥月渡心)  < 10000 and  Distance < 12  and 风车==0  then
		  面对目标()
   end 
	技能前置(魂锁,1000)
	技能前置(破魔击,1000)
	技能前置(生死劫,1000)
	if m贪墨体F < 0 then
		技能前置(贪魔体,1000)	
	end 
    if 技能触发(烈日斩,500,1) == 1 then
		模式 =4
	end 
	if( 技能触发(生死劫,2000)==1 ) then
		模式 =0
		释放(生死劫)
	end 
	if( 技能触发(破魔击,2000)==1 ) then
		if 模式 ~=4 then 
			模式 =0
		end
	end 
	
	 if( 技能触发(银月斩,1000)==1 ) then
			模式 =5  --减疗模式
	end
	if( 技能触发(赤日轮,2000)==1 ) then
		模式 =2
	end 
	if bufftimeT(盾立)>0 and  bufftimeR(隐身F) < 0 then
		 return
	end 	
	if t门派 == 霸刀  and Distance < 60   then
		释放(扶摇)
	end 
	if bufftimeT(无名魂锁F) >0 then
		if  bufftimeT(无名魂锁F)<2000 and  bufftimeT(生死劫月F) < 3000   then
		
			if 玩家.满月==1 then
					if 玩家.日灵>=4000   then
						释放(大漠刀法)
			        	释放(破魔击)
						else
						释放(大漠刀法)
						释放(生死劫)
					end 
			
			end		
			if 玩家.满日==1 then
				释放(大漠刀法)
				释放(生死劫)
			end
		end
		return
	end
	 if ISNPC() == 3 then  ---如何是NPC
		攻击(破魔击)
	 end 
	 
	if Distance  > 8 and  技能等级(知我罪我) >0 and Distance <20 and 玩家.满日 ==0 and 玩家.满月==0 then
			控制(幻光步,眩晕,900,4,20,1)
	end
	------减伤判断
	if f冥月渡心 < 0 and SkillAfter(冥月渡心)>8000 then
	
		if t远程爆发> 1000 and ttisme ==1  and Distance < 27 and t控制==0 and  t沉默<0  then
			释放(贪墨体)
		end 
		if t近战爆发> 1000 and ttisme ==1  and Distance < 8  and t控制==0 and  t沉默<0 then
			释放(贪墨体)
		end 
		if 万花爆发== 1 and  t控制==0 and  t沉默<0  and ttisme ==1  then
			释放(贪墨体)
		end 	
	end	
		if f明教橙武 > 0 and t免伤 < 0   then
			攻击(破魔击)
		end 
	  if q驱夷逐法==1 then
				释放(破魔击)
			if  SkillAfter(驱夜)<3000 then
				释放(光明相,1,15)
			end 
			if  技能CD(光明相)==0  and 玩家.满月==0 and 玩家.满日==0 and 技能CD(驱夜)==1  and 技能CD(生灭)==1 then
				释放(隐身)
			end 
			if 技能CD(隐身)==0 and 技能CD(光明相)==0 and 技能CD(驱夜)==0 then
				释放(生灭)
			end 
	  end 
	  -----
	  

	if 模式 ~= 2   and t免伤 <0 then
		if  玩家.满日 == 1 or 玩家.日灵==10000 then

			if  不可控制减伤BUFF<0   then
			if 目标.nHP< 10 and t减伤<0  and t免伤<0 and t啸如虎<0 then
					攻击(破魔击)
			end
			if 模式==5 and 技能等级(善恶如梦) ==1  then
					攻击(生死劫)
			end 		
			if t沉默 <1000 and SkillAfter(怖畏暗刑)>1000 then
				if SkillAfter(破魔击)<3000  and f生死劫月<3000   then
					控制(生死劫,眩晕,1300)
				end
				if bufftimeT(月破控F)>0  and f生死劫月<3000  then
						控制(生死劫,眩晕,1300)
				end 
				if 魂锁连控 == 1 and SkillAfter(生死劫)<5000 and N对敌玩家_60尺==1  and  SkillAfter(生死劫)>10 and bufftimeR(光明相F)< 0 and SkillAfter(光明相)>1000 and f日盈<0 and f冥月渡心 <0 and SkillAfter(缴械)> 4000 then
					控制(魂锁,眩晕,1000)
				end 
				if 玩家.月灵 < 3000 and  t免伤 < 0 and   t减伤 < 0  and f冥月渡心 <0 and f明教橙武 <0 then
					攻击(光明相,1,15)
				end 
				if 技能等级(超凡入圣) == 1 and SkillAfter(生死劫)>8000   then
					控制(生死劫,眩晕,900)
				end 
			end
			if bufftime生死劫月<3000   and t沉默 <1000 and SkillAfter(怖畏暗刑)>1000 then
					控制(生死劫,眩晕,900)
				if Distance > 7  then 
					if m免控 <0  then
						控制(流光,眩晕,900)
					end 
				end 
			end
			if  bufftimeT(生太极,生太极2F)>0 then --免控大于3秒的 
				攻击(破魔击)
			end 
			if bufftimeR(光明相F) >0  then
				攻击(破魔击)
			end 
			if 目标.nHP<10 and t啸如虎<0   then
					攻击(破魔击)
			end 
			if f冥月渡心 > 0  or f生灭 > 0   then
					攻击(破魔击)
			end 
	
			if  t马御 < 0   and 可控制减伤BUFF < 0 then
				if 技能CD(流光)==0  and Distance>9  and t控制==0 then
					攻击(破魔击)
				end	
				if t门派 == m藏剑 or  t门派 ==   m丐帮   then
					攻击(破魔击)
				end	
			end
			if t免控> 2000 then 
				攻击(破魔击)
			end 
			----针对目标被控制的时候输出
			if t定身>2000 or t锁足>2000 or t倒地 >2000 or t眩晕>2000 then  
				if  玩家.月灵>8000 then
						攻击(破魔击)
				end 
			end 
			if t定身>3000 or t锁足>3000 or t倒地 >3000 or t眩晕>3000 then
				if  玩家.月灵>5000 then
						攻击(破魔击)
				end 
			end 
			if t定身>4000 or t锁足>4000 or t倒地 >4000 or t眩晕>4000 then
						攻击(破魔击)
			end 
			if t免控 > 3000 or bufftime生死劫月>5000   then
				攻击(破魔击)
			end	
			if 玩家.月灵 > 5500 and 技能CD(银月斩)==1  and t免控>0 then
				攻击(破魔击)
			end	
			if 玩家.月灵 > 8000 and   t免控>0  then
				攻击(破魔击)
			end		
			if 技能CD(流光)==0  and Distance>9  and t控制==0 then
				攻击(破魔击)
			end	
			if 模式 ==4 then 
				攻击(破魔击)
			end
	end
		
		end 
		
		if ft长歌减伤>0 and t免伤<0 then
			攻击(破魔击)
		end 
		if   玩家.满月 == 1 or 玩家.月灵==10000   then
			if 不可控制减伤BUFF <0  and t风车==0 then  
			if f明教橙武 > 0 and t免伤 < 0   then
			攻击(破魔击)
			end 
		
				if bufftimeT(生死劫月F) < 4000  and t控制==0   then
					if 玩家.日灵>=4000   and 技能CD(烈日斩)==1 then
						控制(破魔击,眩晕,200)
					end 	
					if  玩家.日灵>6000   then
						控制(破魔击,眩晕,200)
					end
				end
			if 魂锁连控 == 1 and SkillAfter(生死劫)<7000 and SkillAfter(生死劫)>10 and 技能等级(善恶如梦) ==1  and bufftimeR(光明相F)< 0 and SkillAfter(光明相)>1000    and f冥月渡心 < 0  and f生灭 < 0  and N对敌玩家_60尺==1  and t沉默<0  then
				控制(魂锁,眩晕,1000)
			end 
			if bufftimeT(生死劫月F) < 3000    then
				if 模式==5 and t减疗<2000  then
					攻击(生死劫)
				end 
				if 技能等级(善恶如梦) ==1 then
					控制(生死劫,眩晕,900)
				end
				if t免控<0 and Distance >8  and  玩家.日灵 < 3000    and f明教橙武 <0 and t控制==0  then
					释放(光明相,1,17)
				end 
			end		
			if 目标.nHP < 20  and t啸如虎<0 then
			 释放(破魔击)
			end 			
			if t控制==0 and 玩家.nState ~=轻功 then
				if Distance > 10  and  t马御 <0 then
					攻击(破魔击)
				end
				if bufftimeR(光明相F) >0  then
						攻击(破魔击)
				end 
					if f冥月渡心 > 0  or f生灭 > 0  or SkillAfter(冥月渡心)<100000 or SkillAfter(生灭予夺) <10000 then
					攻击(破魔击)
					end 
			--	else
					if 可控制减伤BUFF<0   then
						if t马御 >0 then --目标骑马
							if  目标.nHP <8 and  t啸如虎<0   then
									攻击(破魔击)
							end
							if Distance > 6  and t免控<0 then
								攻击(破魔击)
							end
						else --目标不骑马
							if  目标.nHP <10  or  t免控 >1000  or bufftime生死劫月>4500   then
								攻击(破魔击)
							end
							if Distance > 6   then
								攻击(破魔击)
							end
						end
					end	
			end
			if t控制==1 then
				if bufftimeR(光明相F) >0 and t定身<900 and t锁足<900 then
						攻击(破魔击)
				end 
				if f冥月渡心 > 0  or f生灭 > 0  or SkillAfter(冥月渡心)<10000 or SkillAfter(生灭予夺) <6000 then
					if	SkillAfter(冥月渡心) >100 or SkillAfter(生灭予夺) >10 then
											攻击(破魔击)
					end
				end 
				if	目标.nHP < 10 then
					攻击(破魔击)
				end 
				if	Distance > 12 and t定身<1000 and t锁足<1000 then
					攻击(破魔击)										
				end 
				if 玩家.日灵 > 6000   and t定身<1000 and t锁足<1000 then
					攻击(破魔击)										
				end 
			end 
					if f冥月渡心 > 0  or f生灭 > 0  or SkillAfter(冥月渡心)<10000 or SkillAfter(生灭予夺) <10000 then
					攻击(破魔击)
					end 
		if f明教橙武 > 0 and t免伤 < 0 and t风车==0  then
		攻击(破魔击)
		end 
			if  模式 ==4 then
				攻击(破魔击)
			end 	
		end   
		end 
	end
	if   SkillAfter(破魔击)>1000  and 技能CD(冥月渡心)==0    and t免控<0 and t减伤<0 and SkillAfter(冥月渡心)>12000  and  t免封内<0   and 技能等级(生灭)==1  and t风车==0  and f冥月渡心<0  and t门派 ~=霸刀  then 
			if   技能CD(怖畏暗刑)==1  and 玩家.满月==0 and  玩家.满日==0  and 技能CD(驱夜)==1 and t封内<0 and t沉默<0  and SkillAfter(隐身)>5000   then
			--	控制(隐身,定身,1300,0,5) 
			end 
				if 技能CD(隐身)==0 and 技能CD(驱夜)==0  and 技能CD(缴械)==0 and Distance < 20  and SkillAfter(隐身) <5000  and m战斗==1 then
			--			释放(生灭予夺)
				end 
			if SkillAfter(隐身)<5000 and m战斗==1   and  t免封内<0 and SkillAfter(怖畏暗刑)>5000   then
			--	释放(怖畏暗刑)
			end  
	end 
	
	
	if SkillAfter(冥月渡心)<10000 then
			释放(驱夜)
	end
	 if t读条技能() ~= 千蝶吐瑞 then
		if ft梦泉虎跑<0  and   玩家.满日 ~= 1 and 玩家.满月 ~= 1 and t封内< 0 and  t沉默 < 0 and  t控制==0   and  不可控制减伤BUFF < 0  and t免封内 < 0 and ft松烟竹雾<0 and t门派 ~=m丐帮 and SkillAfter(生死劫)>700  and t风车==0  and t门派~=m霸刀 then
				释放(怖畏暗刑)
		end
		if ft梦泉虎跑<0  and   玩家.满日 ~= 1 and 玩家.满月 ~= 1 and t封内< 0 and  t沉默 < 0 and  t控制==0   and  不可控制减伤BUFF < 0  and t免封内 < 0 and ft松烟竹雾<0  and SkillAfter(生死劫)>700  and t风车==0 and  ft秀明尘身 > 0 then
				释放(怖畏暗刑)
		end 
		if ft梦泉虎跑<0  and   玩家.满日 ~= 1 and 玩家.满月 ~= 1 and t封内< 0 and  t沉默 < 0 and  t控制==0   and  不可控制减伤BUFF < 0  and t免封内 < 0 and ft松烟竹雾<0  and SkillAfter(生死劫)>700  and t风车==0 and  ft雪絮金屏 > 0   then
				释放(怖畏暗刑)
		end	
	 end 

	if nState==击倒 or nState ==定身 or nState == 锁足 or nState==眩晕 then
		else
		if bufftimeT(无名魂锁F)<0  and  可控制减伤BUFF>2000  and f冥月渡心< -500  then
			控制(魂锁,1000)
		end
		if bufftimeT(无名魂锁F)<0 and   t啸如虎>2000  and 目标.nHP<20   and f冥月渡心< -500 then --
			控制(魂锁,1000)
		end
		if bufftimeT(无名魂锁F)<0 and   t马御>0  and f冥月渡心< -500 then --
			控制(魂锁,1000)
		end
	end
-----自动解控  
	--	释放(幻光步,1)
	 if f冥月渡心 < 0  and  m贪墨体F < 0  and SkillAfter(幻光步)>3000  and  m控制== 1 and bufftimeR(377--[[镇山河]])<0 and SkillAfter(隐身)>3000 and SkillAfter(流光) > 3000  and m免控<0  and 目标附近的离手风车()==0 then
		if 玩家.nState == 锁足 then
			释放(流光)
		end 
		
		if 玩家.nState ~=后仰  and 玩家.nState ~=倒地 and 玩家.nState~=击退 and 
		玩家.nState~=击退2 then
			释放(幻光步2,4,20,1)
		end
	end 
	if   玩家.nState == 后仰 then
		释放(蹑云逐月)
	end 	
--------  追击技能 	
	if   流光追击==1  and  GCD==1  and 目标附近的离手风车()==0 then
		if Distance > 15 and  af流光> 3000 and t免伤 < 0 and  目标.nState ~= 死亡  and  玩家.满月~=1  and 不可控制减伤BUFF < 0 and  t风车==0  then
			
			if 玩家.满日 ==1 and Distance > 16 then
				控制(流光,眩晕,1000)
			end 
			if t外功 == 0 then
				攻击(流光)
			end 
			if 	t外功==1  and t爆发 < 0 and  t减伤 < 0 then
				攻击(流光)
			end 
		end 
		if Distance > 8 and  Distance < 12 and  af流光> 3000 and t免伤 < 0 and  目标.nState ~= 死亡  and  玩家.满月~=1  and 不可控制减伤BUFF < 0 and  t风车==0  and cd银月斩 ==0   and SkillAfter(冥月渡心)>8000 then 
			if 玩家.满日 ==1 and Distance > 16 then
				控制(流光,眩晕,1000)
			end 
			if t外功 == 0 then
				攻击(流光)
			end 
			if 	t外功==1  and t爆发 < 0 and  t减伤 < 0 then
				攻击(流光)
			end 
		end 
		if Distance > 12 and  Distance < 16 and  af流光> 3000 and t免伤 < 0 and  目标.nState ~= 死亡  and  玩家.满月~=1   and 不可控制减伤BUFF < 0 and  t风车==0   then
			if 玩家.满日 ==1 and Distance > 16 then
				控制(流光,眩晕,1000)
			end 
			if t外功 == 0 then
				攻击(流光)
			end 
			if 	t外功==1  and t爆发 < 0 and  t减伤 < 0    then
				攻击(流光)
			end 
		end
		if   Distance > 12 and  af流光> 3000 and t免伤 < 0 and  目标.nState ~= 死亡  and  玩家.满月~=1  and 不可控制减伤BUFF < 0 and  t风车==0   then
			if f冥月渡心 > 0 then
				攻击(流光)	
			end
		end 		
	end 		
-----免控衔接 针对丐帮这个职业	
	if t门派==m丐帮  and ttisme==1 and  Distance < 8  and SkillAfter(流光) >3000 and SkillAfter(隐身)>4000  then
		if   m免控 < 0 then
			攻击(流光)
		end 
	end 
	if     劫镖模式==0  then  
		if  t免伤<0 and t减伤 <0  then
			攻击(伏明众生,0,8)
		end 
		if t免伤<0 and t减伤 <0 and f生灭 < 0  then
			攻击(冥月渡心,0,12)  
		end
		if  t免伤<0 and t门派 ==m纯阳    then
			攻击(伏明众生,0,8)
		end 
		if t免伤<0 and t门派 ==m纯阳 and f生灭 < 0  then
			攻击(冥月渡心,0,12)  
		end 
		if t免伤<0 and t门派 ==m纯阳 and f生灭 < 0  then
			攻击(冥月渡心,0,12)  
		end 	
	end 
-- 调试信息(劫镖模式,ISNPC())
	if ISNPC()==4 then
		if  t免伤<0 and t减伤 <0  then
			攻击(伏明众生,0,8)
		end 
		if t免伤<0 and t减伤 <0 and f生灭 < 0  then
			攻击(冥月渡心,0,12)  
		end
		if  t免伤<0 and t门派 ==m纯阳    then
			攻击(伏明众生,0,8)
		end 
		if t免伤<0 and t门派 ==m纯阳 and f生灭 < 0  then
			攻击(冥月渡心,0,12)  
		end 
		if t免伤<0 and t门派 ==m纯阳 and f生灭 < 0  then
			攻击(冥月渡心,0,12)  
		end
	end 

	
	释放(驱夜)
	
	
	if t免伤<0 and t免控 <0  and SkillAfter(流光)>3000  and    SkillAfter(隐身)>5000 and      SkillAfter(冥月渡心)>5000  and f冥月渡心<0 and f隐身<0 then
		if  预判小轻功==1 then
			if 预判_醉月==1 or 预判_醉月2==1 or 预判_惊涛==1 or 预判_摩诃无量==1 or 预判_大道无术==1  then
				释放(凌霄揽胜)
				释放(迎风回浪)
				释放(瑶台枕鹤)
				释放(流光)
				if SkillAfter(后跳)> 7000 then
						释放(后跳)
				end 
			end 
			if 目标ID()==预判_破坚阵ID and t马御>0 and 预判_破坚阵==1  then
				释放(凌霄揽胜)
				释放(迎风回浪)
				释放(瑶台枕鹤)
				释放(流光)
					if SkillAfter(后跳)> 7000 then
						释放(后跳)
					end 
			end 
		end
	end 
	if SkillAfter(冥月渡心)<8000 and   SkillAfter(冥月渡心)>1000 then  --------月大的10秒内
	
		if 玩家.月灵 >=  玩家.日灵 then
			释放(银月斩)
		if 技能CD(银月斩)==0  then
				释放(幽月轮)
			end
			else
			释放(烈日斩)
			if 技能CD(烈日斩)==0 then
				释放(赤日轮)
			end
		end		
	end 	
	if f冥月渡心 > 0 then
		if 玩家.月灵 >=  玩家.日灵 then
			释放(银月斩)
			if 技能CD(银月斩)==0 and 技能CD(驱夜)==0 then
				释放(幽月轮)
			end
			else
			释放(烈日斩)
			if 技能CD(烈日斩)==0 and 技能CD(驱夜)==0 then
				释放(赤日轮)
			end
		end		
	end 
		if 玩家.月灵>=8000 then
			释放(幽月轮)
		end
		if 玩家.日灵>=6000 then
			释放(烈日斩)
		end 
		if   玩家.日灵  >  玩家.月灵   then
			if  玩家.日灵 >= 8000 then
				释放(赤日轮)
			end
		end
		if  玩家.月灵 >= 5600 then
			释放(银月斩)
		end 
		if	l日月齐光 > 0 then
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
	if Distance < 50 and bufftimeR(扶摇F)<0   then 
	 释放(扶摇)
	end 
end