--
-- Author: Your Name
-- Date: 2015-07-09 14:22:34
--枚举类型
local Enum={}

-------------------------------建筑类型的枚举-------------------------------
Enum.type = Enum.type or {}
Enum.type.castle = 1 			--城堡
Enum.type.warehouse = 2 		--仓库
Enum.type.wall = 3 			--城墙
Enum.type.watchtower = 4 		--瞭望塔
Enum.type.logging= 5 			--伐木场
Enum.type.farmland = 6 		--农田
Enum.type.ironore = 7 			--铁矿场
Enum.type.mystrile = 8 			--秘银矿
Enum.type.college = 9 			--学院
Enum.type.embassy = 10		--大使馆
Enum.type.wishingWell = 11		--许愿池
Enum.type.market = 12			--市场
Enum.type.barracks = 13		--兵营
Enum.type.stable = 14			--马厩
Enum.type.range = 15			--靶场
Enum.type.chariot = 16			--战车工坊
Enum.type.march = 17			--行军帐篷
Enum.type.emergency = 18		--急救帐篷
Enum.type.warhall = 19			--战争大厅
Enum.type.warfort = 20			--战争堡垒
Enum.type.assemblyPlace = 21		--校场
Enum.type.arrowTower = 22		--箭塔
Enum.type.forgeShop = 23		--铁匠铺
Enum.type.cellar = 24			--地窖

--特殊建筑1
Enum.type.drunkery = 25         --酒馆

--特殊建筑2
Enum.type.business = 26         --旅行商人
Enum.type.cargoship = 27         --货船
Enum.type.dock = 28         --码头
Enum.type.activitycenter = 29         --活动中心
Enum.type.army = 30         --部队集结旗
Enum.type.bulletin = 31         --公告牌
Enum.type.workshop = 32         --作坊
Enum.type.brothers = 33         --兄弟会
Enum.type.NewRecruits = 34         --新兵

Enum.ps ={}
Enum.ps.dock = 303


-------------------------------城内固有建筑-------------------------------
Enum.fix_building = Enum.fix_building or {}
Enum.fix_building [1] = Enum.type.castle
Enum.fix_building [2] = Enum.type.warehouse
Enum.fix_building [3] = Enum.type.wall
Enum.fix_building [4] = Enum.type.watchtower
Enum.fix_building [5] = Enum.type.arrowTower
Enum.fix_building [6] = Enum.type.arrowTower
Enum.fix_building [7] = Enum.type.cellar

-------------------------------建筑物操作类型-------------------------------
Enum.op = Enum.op or {}
Enum.op.build = 1			--建造
Enum.op.lvUp = 2			--升级
Enum.op.lvUpNow = 3			--立即升级
Enum.op.lvUpCancel = 4			--取消升级
Enum.op.train = 5			--训练
Enum.op.trainCancel = 6			--取消训练
Enum.op.toolSpeed = 7			--建筑升级道具加速
Enum.op.buildDemolish = 8		--建筑拆除
Enum.op.produceSpeed = 9        --建筑生产加速
Enum.op.quickTrain = 10         --立即训练
Enum.op.collectTrain = 11         --收取训练结果
Enum.op.forceTrain = 12         --强制训练
Enum.op.relieveArms = 13         --解雇/拆除
Enum.op.buildDemolishCancel = 14         --取消拆除
Enum.op.buildDemolishNow = 15         --立即拆除
Enum.op.vipFreeBuild = 16       --VIP免费完成

-------------------------------返回值相应结果-------------------------------
Enum.fail = 0  			--失败
Enum.success = 1 		--成功
Enum.noGold = 2 		--金币不足
Enum.noMaterial = 3 		--材料不足
Enum.noTool = 4 		--道具不足
Enum.noMainBuilding = 5 	--主建筑物等级不足
Enum.noOpenPosition = 6 	--位置未开放
Enum.hasBuild = 7 		--位置有其它建筑物
Enum.noFixPostion = 8 		--此位置不能建这个类型的建筑
Enum.onOperation = 9 		--在升级或者生产中
Enum.noFreeWorker = 10 	--没有空闲工人
Enum.noFitBuildLv = 11 		--其它建筑物没有达到一定等级
Enum.noFitCondition = 12 	--条件不足
Enum.noFitTime	 = 13 		--未过冷却时间 
Enum.sameBuildEnount = 14  	--同种类型建筑物过多
Enum.errorParam = 15 		--参数为空或者参数出错
Enum.limitMaxValue = 16 	--超过最大值
Enum.noInviteCode = 26 --不存在此缴请码
Enum.theAccountHasBind = 27 --该账号已经绑定过

--品质枚举类型
Enum.minColor = 1
Enum.white = 1
Enum.green = 2
Enum.blue = 3
Enum.purple = 4
Enum.orange = 5
Enum.maxColor = 5

-- 邮件类别枚举
Enum.mail_all = 0			-- 所有邮件
Enum.mail_notice = 1		-- 公告类
Enum.mail_system = 2		-- 系统类
Enum.mail_fight = 3			-- 战斗类
Enum.mail_resource = 4		-- 采集类
Enum.mail_monster = 5		-- 怪物战斗类
Enum.mail_ruins = 6			-- 探险类
Enum.mail_im = 7			-- 聊天记录
Enum.mail_event = 8			-- 活动类
Enum.mail_operation = 9		-- 运营类/工作室

--资源类型
Enum.resources = Enum.resources or {}
Enum.resources.gold = 1			--金币
Enum.resources.food = 2			--粮食
Enum.resources.wood = 3			--木材
Enum.resources.iron = 4			--铁
Enum.resources.silver = 5		--银

Enum.resources.time = 20    	--时间
Enum.resources.build = 21 		--建筑物
Enum.resources.item = 22 		--物品

Enum.resType={"wood","food","iron","silver"}



-- 加速道具物品ID定义
Enum.gainspeed_currency_5min = 200201
Enum.gainspeed_currency_1hour = 200200
Enum.gainspeed_currency_8hour = 200202

Enum.gainspeed_train_5min = 200207
Enum.gainspeed_train_2hour = 200208
Enum.gainspeed_trap_5min = 200217
Enum.gainspeed_trap_2hour = 200218

Enum.outspeed_wood = 200014
Enum.outspeed_food = 200015
Enum.outspeed_iron = 200016
Enum.outspeed_silver = 200017

--成就类型
Enum.achieve = Enum.achieve or {}
Enum.achieve.MIN 			= 0
Enum.achieve.farmlandLv 	= 1 --农田升级
Enum.achieve.collectResources	= 2  --采集资源
Enum.achieve.trapKillArmy 	= 3	--陷阱杀死士兵
Enum.achieve.equipGreen 	= 4	--装备绿装
Enum.achieve.equipBlue		= 5	--装备蓝装
Enum.achieve.equipPurple	= 6	--装备紫装
Enum.achieve.equipOrange	= 7	--装备橙装
Enum.achieve.equipGold		= 8	--装备金装
Enum.achieve.wishingWellTimes	= 9	--使用许愿池次数
Enum.achieve.cureArmy		= 10 	--治疗士兵
Enum.achieve.reinforcementsKill	= 11 --援军杀人数
Enum.achieve.musterKill		= 12 --集结杀人数
Enum.achieve.castleLV		= 13 --城堡等级
Enum.achieve.sciencEnum		= 14 --科技完成数
Enum.achieve.plunderResources	= 15  --采集资源
Enum.achieve.MAX 			= 16
------------------------大地图


--大地图资源类型
Enum.map_resource_type = Enum.map_resource_type or {}
Enum.map_resource_type.wood=1			--木材
Enum.map_resource_type.food=2			--粮食
Enum.map_resource_type.iron=3			--铁矿
Enum.map_resource_type.silver=4			--银矿
Enum.map_resource_type.gold=5			--金币
Enum.map_resource_type.ruin=6			--遗迹
Enum.map_resource_type.monster=7			--怪物

--大地图各类型ID
Enum.map_id = Enum.map_id or {}
Enum.map_id.ruin = 501 			--遗迹
Enum.map_id.player = 800 			--玩家主城建筑
Enum.map_id.guild = 900			--聪明主城建筑



------------------------客户端枚举

Enum.buildstate = Enum.buildstate or {}
Enum.buildstate.nt=1  ---正常状态
Enum.buildstate.bd=2  ---建筑状态
Enum.buildstate.tr=3  ---训练或生产状态
Enum.buildstate.rm=4  ---拆除
Enum.buildstate.eg=5  --急救中
Enum.buildstate.trSpeed =6 --农田加速状态
Enum.buildstate.trSpeed_bd =7  --农田加速状态和升级状态
Enum.buildstate.trSpeed_rm =8  --农田加速状态和拆除状态

Enum.buildstate.ok = 10

Enum.buildstate.bdok=12 --建筑完成
Enum.buildstate.pk=13  ---收兵或收粮状态
Enum.buildstate.rmok=14 --拆除完成
Enum.buildstate.egok=15 --急救完成
Enum.buildstate.trSpeedok =16

Enum.hireGold = 250 -- 雇佣需要花的金币
Enum.hireTimes = 172800 -- 雇佣的时间：单位秒
-------------------------------邮件类型的枚举-------------------------------
Enum.Mail_all = 0           --所有邮件
Enum.Mail_notice = 1        --公告类
Enum.Mail_system =2         --系统类
Enum.Mail_fight =3          --战斗类
Enum.Mail_resource =4       --采集类
Enum.Mail_monster =5        --怪物战斗类
Enum.Mail_castle =6         --城堡探险类
Enum.Mail_playerchat =7     --聊天类
Enum.Mail_event =8          --活动类
Enum.Mail_operation =9      --运营类/工作室

-------------------------------怪物战斗结果的枚举-------------------------------
Enum.monsterfight = Enum.monsterfight or {}
Enum.monsterfightwin = 0        --战斗胜利
Enum.monsterfightfail = 1       --战斗失败
Enum.monsterfirstblood = 2      --首杀

------------------------------瞭望塔-军情--------------------------
--目前服务器除了6,全部都是攻击
Enum.MilitaryInfo = Enum.MilitaryInfo or {}
Enum.MilitaryInfo.type_Attack = 1 --攻击
Enum.MilitaryInfo.type_Scout = 6 --侦察
--Enum.MilitaryInfo.type_Help = 3 --援兵
--Enum.MilitaryInfo.type_Res = 4 --资源帮助
--Enum.MilitaryInfo.type_Monster = 5 --怪物攻城
--20以下为其他子类型
Enum.MilitaryInfo.type_Science = 20 --科技
Enum.MilitaryInfo.type_Skill = 21 --技能

-------------------------------战斗报告的枚举-------------------------------
--战报类型。0-战斗胜利；1-战斗失败；2-攻城胜利；3-攻城失败；4-守城胜利；5-守城失败；6-侦查报告；7-黑骑士战报;8-扎营胜利；9-扎营失败
Enum.mail_fight_win = 0
Enum.mail_fight_fail = 1
Enum.mail_fight_gongchen_win = 2
Enum.mail_fight_gongchen_fail = 3
Enum.mail_fight_shouchen_win = 4
Enum.mail_fight_shouchen_fail = 5
Enum.mail_fight_zhencha = 6
Enum.mail_fighe_event_fail = 7	--黑骑士活动守城失败
Enum.mail_fighe_event_success = 8	--黑骑士活动守城成功
Enum.report_encamp_success = 9		-- 扎营战胜利
Enum.report_encamp_fail = 10		-- 扎营战失败
Enum.report_encamp = 11				-- 扎营报告
Enum.report_fight_draw = 12			-- 战斗平手
Enum.report_guildbuild_atk_success = 13 --联盟堡垒攻占胜利
Enum.report_guildbuild_atk_fail = 14    --联盟堡垒攻占失败
Enum.report_guildbuild_def_success	= 15	--联盟堡垒防守胜利
Enum.report_guildbuild_def_fail = 16	--联盟堡垒防守失败

-- 侦察目标枚举
Enum.scout_player = 0				-- 侦察城堡
Enum.scout_player_passive = 1		-- 城堡被侦察
Enum.scout_fail_tool = 2			-- 反侦察
Enum.scout_fail = 3					-- 侦察失败
Enum.scout_resource = 4				-- 侦察资源田
Enum.scout_resource_passive = 5		-- 资源田被侦察
Enum.scout_encamp = 6				-- 侦察扎营
Enum.scout_encamp_passive = 7		-- 营地被侦察
Enum.scout_guild = 8				-- 侦察联盟建筑
Enum.scout_guild_passive = 9		-- 联盟建筑被侦察

-----------------------------城墙防御
Enum.INT_LOSE_DEF = 1--减1城防每18秒
Enum.INT_LOSE_DEF_TIME = 18--减1城防每18秒
Enum.DockPos = 303


-----------------------------大地图
Enum.BigMap_building_type_wood = 1 -- 木材
Enum.BigMap_building_type_food = 2 -- 粮食
Enum.BigMap_building_type_iron = 3 -- 铁矿
Enum.BigMap_building_type_silver = 4 -- 秘银
Enum.BigMap_building_type_gold = 5 -- 金币
Enum.BigMap_building_type_relic = 6 -- 遗迹
Enum.BigMap_building_type_monster = 7 -- 怪物
Enum.BigMap_building_type_castle = 800 -- 城堡
Enum.BigMap_building_type_army = 801 -- 部队
Enum.BigMap_building_type_sapce = 1000 -- 空地
Enum.BigMap_building_type_move_army = 10000 -- 移动中的部队
Enum.BigMap_building_type_alliance_boundary = 10001 -- 联盟边界
Enum.BigMap_building_type_alliance_fortress = 901	-- 联盟堡垒
Enum.BigMap_building_type_alliance_tower = 902		-- 联盟箭塔
Enum.BigMap_building_type_alliance_wood = 903	-- 联盟伐木场
Enum.BigMap_building_type_alliance_food = 904	-- 联盟农田
Enum.BigMap_building_type_alliance_iron = 905	-- 联盟铁矿
Enum.BigMap_building_type_alliance_silver = 906	-- 联盟秘银
Enum.BigMap_building_type_alliance_storage = 907-- 联盟仓库
Enum.BigMap_building_type_throne = 1001          -- 王座
Enum.BigMap_building_type_mangonel = 1002		-- 投石机


-- 联盟建筑状态
Enum.Alliance_building_state_no_complete = 1 -- 未完成
Enum.Alliance_building_state_collect = 2 -- 采集中
Enum.Alliance_building_state_defense = 3 -- 防御中
Enum.Alliance_building_state_storage = 4 -- 存储中
Enum.Alliance_building_state_garrison = 5 -- 已驻防
Enum.Alliance_building_state_no_garrison = 6 -- 未驻防
Enum.Alliance_building_state_repair = 7 -- 修理中(未完成)
Enum.Alliance_building_state_destroy = 8 -- 被摧毁中(未完成)
Enum.Alliance_building_state_broken = 9 -- 破损(未完成)
Enum.Alliance_building_state_build = 10 -- 建造中
Enum.Alliance_building_state_no_collect = 11 -- 未采集
Enum.Alliance_building_state_repaired = 12 -- 修理中(已完成)
Enum.Alliance_building_state_destoryed = 13 -- 被摧毁中(已完成)
Enum.Alliance_building_state_brokened = 14 -- 破损(已完成)

-- 行军目的
Enum.BigMap_expedition_occupy_resource = 1 -- 占领资源
Enum.BigMap_expedition_attack_monster = 2  -- 打怪物
Enum.BigMap_expedition_relic_explore = 3 -- 遗迹探险
Enum.BigMap_expedition_occupy_space = 4 -- 占领空地
Enum.BigMap_expedition_attack_other = 5 -- 攻击其他玩家
Enum.BigMap_expedition_detect = 6 		-- 侦查
Enum.BigMap_expedition_detect_other = 7 -- 侦查其他（除城堡以外）
Enum.BigMap_expedition_business = 8 	-- 交易(资源援助)
Enum.BigMap_expedition_soldier_aid = 9   -- 士兵援助
Enum.BigMap_expedition_black_attack = 10 -- 黑骑士攻击玩家
Enum.BigMap_expedition_mass = 11 -- 集结
Enum.BigMap_expedition_build = 12 -- 建造
Enum.BigMap_expedition_attack_fortress = 13 -- 攻击堡垒
Enum.BigMap_expedition_repair = 14 -- 修复
Enum.BigMap_expedition_defend = 15 -- 驻守
Enum.BigMap_expedition_collect = 16 -- 采集
Enum.BigMap_expedition_storage = 17 -- 仓库存储 
Enum.BigMap_expedition_take = 18    -- 仓库取出
Enum.BigMap_expedition_king_battle = 20 -- 占领 攻击 支援（王座， 投石机）

-- 行军状态
Enum.BigMap_expedition_depart = 1	-- 出发
Enum.BigMap_expedition_stay = 2		-- 驻扎
Enum.BigMap_expedition_return = 3	-- 返回
Enum.BigMap_expedition_state_mass = 4		-- 集结中 	

-- 
Enum.Expedition_show_type_send = 100 -- 派遣
Enum.Expedition_show_type_mass = 101 -- 集结

-- 王座状态
Enum.Throne_status_protect = 1 -- 保护状态
Enum.Throne_status_fight = 2   -- 争夺状态


-------------------------------账号绑定平台-------------------------------
Enum.bindActPlatform = Enum.bindActPlatform or {}
Enum.bindActPlatform.facebook = 1        --Facebook
Enum.bindActPlatform.google = 2        --Google+

-------------------------------游戏支持的语言包枚举-------------------------------
Enum.gameLanguage = Enum.gameLanguage or {}
Enum.gameLanguage.EN = 1        --英语
Enum.gameLanguage.FR = 2        --法语
Enum.gameLanguage.DE = 3        --德语
Enum.gameLanguage.RU = 4        --俄语
Enum.gameLanguage.KR = 5        --韩语
Enum.gameLanguage.TH = 6        --泰语
Enum.gameLanguage.JP = 7        --日本语
Enum.gameLanguage.BrPr = 8        --葡萄牙语
Enum.gameLanguage.ES = 9        --西班牙语
Enum.gameLanguage.TR = 10        --土耳其
Enum.gameLanguage.ID = 11        --印度尼西亚语
Enum.gameLanguage.CNTW = 12        --繁体中文
Enum.gameLanguage.CN = 13        --简体中文
Enum.gameLanguage.IT = 14        --意大利语
Enum.gameLanguage.PL = 15        --波兰语
Enum.gameLanguage.LU = 16        --荷兰语
Enum.gameLanguage.AE = 17        --阿拉伯语

Enum.gameLanguage.DK = 18        --丹麦语
Enum.gameLanguage.GK = 19        --希腊语
Enum.gameLanguage.FH = 20        --芬兰语
Enum.gameLanguage.SH = 21        --瑞典语
Enum.gameLanguage.VE = 22        --越南语
Enum.gameLanguage.MA = 23        --马来语

--TemplateData:getTranslateKey(iLanguage)来获得各种语言对应的翻译类型

-------------------------------通知栏信息类型 枚举-------------------------------
Enum.noticeMessageType = Enum.noticeMessageType or {}
Enum.noticeMessageType.upgradeAndTrain = 1        --升级与训练
Enum.noticeMessageType.fightingAndArmy = 2        --战斗与部队
Enum.noticeMessageType.mail = 3        --邮件
Enum.noticeMessageType.alliance = 4        --联盟
Enum.noticeMessageType.activity = 5        --活动
Enum.noticeMessageType.resource = 6        --资源生产
Enum.noticeMessageType.chat = 7        --联盟聊天
Enum.noticeMessageType.award = 8        --奖励提醒

-------------------------------通知栏信息 枚举-------------------------------
Enum.noticeMessage = Enum.noticeMessage or {}
Enum.noticeMessage.buildingUpgrade = 1        --建筑升级
Enum.noticeMessage.buildBuilding = 2        --建筑建造
Enum.noticeMessage.armyTrain = 3        --建筑建造
Enum.noticeMessage.pitfallTrain = 4        --陷阱建造
Enum.noticeMessage.scienceStudy = 5        --科技研究
Enum.noticeMessage.investigation  = 6        --被侦查
Enum.noticeMessage.attack  = 7        --被攻击
Enum.noticeMessage.backCity  = 8        --部队回城
Enum.noticeMessage.personalEmail  = 9        --个人邮件
Enum.noticeMessage.allianceEmail  = 10        --联盟邮件
Enum.noticeMessage.blackKnight  = 11        --黑骑士开启
Enum.noticeMessage.fullWarehouse = 12        --资源满仓
Enum.noticeMessage.withR4Chat = 13        --盟主和R4成员聊天
Enum.noticeMessage.portGoods = 14        --港口物资

--铁匠铺锻造品质
Enum.forgeQuality1 = Enum.forgeQuality1 or {}
Enum.forgeQuality1 = {
[1] = {diff=0,min=1,minp1=0,minp2=0,minp3=0,minp4=0,minp5=0},
[2] = {diff=1,min=0.2,minp1=0.8,minp2=0,minp3=0,minp4=0,minp5=0},
[3] = {diff=2,min=0.143,minp1=0.2856,minp2=0.5714,minp3=0,minp4=0,minp5=0},
[4] = {diff=3,min=0,minp1=0.4,minp2=0.2,minp3=0.4,minp4=0,minp5=0},
[5] = {diff=4,min=0,minp1=0.3,minp2=0.2,minp3=0.2,minp4=0.3,minp5=0},
[6] = {diff=5,min=0,minp1=0.2,minp2=0.2,minp3=0.2,minp4=0.15,minp5=0.25}
} 

Enum.forgeQuality2 = Enum.forgeQuality2 or {}
Enum.forgeQuality2 = {
[1] = {level=1,e_amount=0,m_amount=2,e_weighting=0,m_weighting=1/2},
[5] = {level=5,e_amount=1,m_amount=2,e_weighting=3/8,m_weighting=5/16},
[10] = {level=10,e_amount=1,m_amount=3,e_weighting=3/8,m_weighting=5/24},
[15] = {level=15,e_amount=1,m_amount=3,e_weighting=3/8,m_weighting=5/24},
[20] = {level=20,e_amount=1,m_amount=3,e_weighting=3/8,m_weighting=5/24},
[25] = {level=25,e_amount=1,m_amount=4,e_weighting=3/8,m_weighting=5/32},
[30] = {level=30,e_amount=1,m_amount=4,e_weighting=3/8,m_weighting=5/32}
} 

----------科技加成类型
Enum.addType = Enum.addType or {}
Enum.addType.mult = 1--乘
Enum.addType.add = 2--加
Enum.addType.null = 3--不显示
Enum.addType.max = 4--减

------------------------联盟帮助------------------
--帮助类型
Enum.allianceHelp = Enum.allianceHelp or {}
Enum.allianceHelp.build = 100000--建筑(ID在此之前都是建筑)
Enum.allianceHelp.study = 100002--研究
Enum.allianceHelp.train = 100003--训练
Enum.allianceHelp.heal = 100004--治疗
Enum.allianceHelp.cast = 100005--铸造

Enum.firstaidArmy = 721000 -- 急救术id用于取出急救术伤兵增加的转换率

----------------------- 任务需求类型枚举
Enum.questType = Enum.questType or {}
Enum.questType.build = 1 			-- 1 建造建筑
Enum.questType.upgradeBuild = 2 	-- 2 升级建筑
Enum.questType.totalGet = 3    		-- 3 累计获得 - 根据关联建筑决定获得内容
Enum.questType.targetTo = 4			-- 4 产量到达 - 根据关联建筑决定产量内容
Enum.questType.lordUpgrade = 5 		-- 5 领主升级
Enum.questType.attack = 6 			-- 6 成功进攻
Enum.questType.defend = 7 			-- 7 成功防御
Enum.questType.killMonster = 8 		-- 8 杀怪
Enum.questType.killPlayer = 9 		-- 9 杀人
Enum.questType.cure = 10 			-- 10 伤兵治疗
Enum.questType.explore = 11 		-- 11 遗迹探险时间 /s
Enum.questType.plunder = 12 		-- 12 累计掠夺 - 统计总共掠夺资源数量
Enum.questType.totalArmy = 13 		-- 13 累计造兵 - 根据对应建筑决定兵种数量


-- 战斗类型枚举
--[[
enum.report_fight_success = 0		-- 战斗胜利
enum.report_fight_fail = 1			-- 战斗失败
enum.report_attackcity_success = 2	-- 攻城胜利
enum.report_attackcity_fail = 3		-- 攻城失败
enum.report_defendcity_success = 4	-- 守城胜利
enum.report_defendcity_fail = 5		-- 守城失败
enum.report_scout = 6				-- 侦查报告
enum.report_event = 7				-- 黑骑士活动战报
enum.report_encamp_success = 8		-- 扎营战胜利
enum.report_encamp_fail = 9			-- 扎营战失败
enum.report_encamp = 10				-- 扎营报告
enum.report_fight_draw = 11			-- 战斗平手]]


Enum.guildAuthority = Enum.guildAuthority or {}
Enum.guildAuthority.rank_name_edit = 1 --阶级称谓
Enum.guildAuthority.guild_flag_edit = 2 --联盟旗帜
Enum.guildAuthority.shorter_edit = 3 --联盟简称
Enum.guildAuthority.league_name_edit = 4 --联盟名称
Enum.guildAuthority.guild_dismiss = 5 --解散联盟
Enum.guildAuthority.leader_change = 6 --盟主转让
Enum.guildAuthority.kick_out = 7 --踢出联盟
Enum.guildAuthority.campaign_edit = 8 --联盟宣言
Enum.guildAuthority.recruit_edit = 9 --公开招募
Enum.guildAuthority.guild_invite = 10 --邀请入盟
Enum.guildAuthority.guild_notice = 11 --编辑联盟公告
Enum.guildAuthority.guild_language = 12 --联盟交流语言
Enum.guildAuthority.item_buy = 13 --从物品目录里面购置物品
Enum.guildAuthority.tech_reserch = 14 --研究联盟科技
Enum.guildAuthority.event_open = 15 --开启活动
Enum.guildAuthority.message_block = 16 --屏蔽联盟留言
Enum.guildAuthority.rank_reduce = 17 --降低成员阶级
Enum.guildAuthority.rank_promote = 18 --提升成员阶级
Enum.guildAuthority.guild_quit = 19 --退出联盟
Enum.guildAuthority.authority = 20 --查看权限详情
Enum.guildAuthority.help = 21 --联盟帮助
Enum.guildAuthority.resource_help = 22 --资源帮助
Enum.guildAuthority.member_check = 23 --查看联盟成员
Enum.guildAuthority.mail = 24 --全体邮件
Enum.guildAuthority.leader_replace = 25 --取代联盟
Enum.guildAuthority.agree_join = 26 --同意入盟
Enum.guildAuthority.refuse_join = 27 --拒绝入盟
Enum.guildAuthority.sets_change = 28 --修改堡垒名称

--服务器保存的设置选项的关键字
Enum.settingKey = Enum.settingKey or {}
Enum.settingKey.equipShow = "equipshow"
Enum.settingKey.selLanguage = "language"

Enum.AllianceNeedLev = 6
Enum.AllianceNeedGold = 200

--伤兵延迟两秒治疗
Enum.emergencyAddTimes = 0

Enum.unreadFlag = 0
Enum.readFlag = 1
Enum.canReceive = 1
Enum.nothingReceive = 0
Enum.replaceChairman = 1000
Enum.resCollect = 0			--资源采集类型
Enum.reshelp = 1			--资源援助类型
Enum.lockYes = 1
Enum.lockno = 0

Enum.MoveTime = 0.3
Enum.waitTime = 0.5

return Enum
