local daily_tasks={
[1] = {ID=1,single_scores=3,daily_times=5,number_demand=5000,lv=0,name=130000,name1="采集木头",description=130050,description1="采集25000木头，每采集5000木头获得一次积分",description1=130600,description2="你可以在世界中看到各级别的伐木场，采集他们可以为你的城堡提供木头。",skip=100,icon="item511"},
[2] = {ID=2,single_scores=3,daily_times=5,number_demand=5000,lv=0,name=130001,name1="采集粮食",description=130051,description1="采集25000粮食，每采集5000粮食获得一次积分",description1=130601,description2="你可以在世界中看到各级别的粮田，采集他们可以为你的城堡提供粮食。",skip=100,icon="item511"},
[3] = {ID=3,single_scores=3,daily_times=5,number_demand=1500,lv=10,name=130002,name1="采集铁矿",description=130052,description1="采集7500铁矿，每采集1500铁矿获得一次积分",description1=130602,description2="你可以在世界中看到各级别的铁矿场，采集他们可以为你的城堡提供铁。",skip=100,icon="item511"},
[4] = {ID=4,single_scores=3,daily_times=5,number_demand=375,lv=15,name=130003,name1="收集秘银",description=130053,description1="世界采集1875秘银，每采集375秘银可获得1次积分",description1=130603,description2="你可以在世界中看到各级别的秘银，采集他们可以为你的城堡提供秘银。",skip=100,icon="item511"},
[5] = {ID=5,single_scores=5,daily_times=5,number_demand=50,lv=0,name=130004,name1="收获步兵",description=130054,description1="训练250步兵，每训练50步兵获得一次积分",description1=130604,description2="在城堡内的兵营内训练步兵。",skip=13,icon="item511"},
[6] = {ID=6,single_scores=5,daily_times=5,number_demand=50,lv=0,name=130005,name1="收获骑兵",description=130055,description1="训练250骑兵，每训练50骑兵获得一次积分",description1=130605,description2="在城堡内的马厩内训练骑兵。",skip=14,icon="item511"},
[7] = {ID=7,single_scores=5,daily_times=5,number_demand=50,lv=0,name=130006,name1="收获弓兵",description=130056,description1="训练250弓兵，每训练50弓兵获得一次积分",description1=130606,description2="你可以在城堡中的靶场内训练弓兵。",skip=15,icon="item511"},
[8] = {ID=8,single_scores=5,daily_times=5,number_demand=50,lv=0,name=130007,name1="收获车兵",description=130057,description1="训练250车兵，每训练50车兵获得一次积分",description1=130607,description2="你可以在城堡中的战车工坊内训练战车。",skip=16,icon="item511"},
[9] = {ID=9,single_scores=30,daily_times=1,number_demand=1,lv=0,name=130008,name1="升级建筑",description=130058,description1="升级任意建筑1次",description1=130608,description2="在城堡中升级任意建筑都会提升你的战斗力。",skip=0,icon="item511"},
[10] = {ID=10,single_scores=10,daily_times=1,number_demand=30,lv=0,name=130009,name1="治疗伤兵",description=130059,description1="在急救帐篷治疗30伤兵",description1=130609,description2="城堡中的医院可以治疗伤兵，治疗伤兵可以快速恢复战斗力。",skip=18,icon="item511"},
[11] = {ID=11,single_scores=1,daily_times=20,number_demand=1,lv=0,name=130010,name1="联盟捐献",description=130060,description1="在联盟进行20次捐献",description1=130610,description2="在联盟中捐献联盟科技可以让联盟更加强大。",skip=104,icon="item511"},
[12] = {ID=12,single_scores=1,daily_times=25,number_demand=1,lv=0,name=130011,name1="联盟帮助",description=130061,description1="在联盟中帮助其他盟友25次",description1=130611,description2="在联盟中帮助盟友可以帮他们节省时间。",skip=104,icon="item511"},
[13] = {ID=13,single_scores=10,daily_times=1,number_demand=150000,lv=0,name=130012,name1="联盟交易",description=130062,description1="在联盟中交给盟友15000资源",description1=130612,description2="同联盟的盟友之间可以互相进行资源援助。",skip=104,icon="item511"},
[14] = {ID=14,single_scores=10,daily_times=1,number_demand=1000,lv=0,name=130013,name1="士兵援助",description=130063,description1="在联盟中援助盟友1000部队",description1=130613,description2="同联盟的盟友之间可以互相进行士兵援助。",skip=104,icon="item511"},
[15] = {ID=15,single_scores=2,daily_times=5,number_demand=1,lv=0,name=130014,name1="装卸货物",description=130064,description1="在码头领取货物5次",description1=130614,description2="在码头装卸货物，每隔一段时间你就会收到惊喜。",skip=28,icon="item511"},
[16] = {ID=16,single_scores=20,daily_times=1,number_demand=1,lv=0,name=130015,name1="研究科技",description=130065,description1="在学院研究1次科技",description1=130615,description2="研究科技可以整体提升你的实力。",skip=9,icon="item511"},
[17] = {ID=17,single_scores=2,daily_times=5,number_demand=1,lv=0,name=130016,name1="击杀怪物",description=130066,description1="在世界中击杀怪物5次",description1=130616,description2="击杀怪物可以获得丰富的奖励",skip=100,icon="item511"},
[18] = {ID=18,single_scores=20,daily_times=1,number_demand=1,lv=0,name=130017,name1="合成装备材料",description=130067,description1="在铁匠铺合成1次装备材料",description1=130617,description2="使用高级材料合成出的装备能力值会更高。",skip=23,icon="item511"},
[19] = {ID=19,single_scores=30,daily_times=1,number_demand=1,lv=0,name=130018,name1="制造装备",description=130068,description1="在铁匠铺打造1件装备",description1=130618,description2="穿着装备会提升相应属性。",skip=23,icon="item511"},
[20] = {ID=20,single_scores=4,daily_times=5,number_demand=30,lv=0,name=130019,name1="建造陷阱",description=130069,description1="在战争堡垒建造150陷阱，每建造30个获得一次积分",description1=130619,description2="建造陷阱可以增强城堡的防守能力。",skip=20,icon="item511"},
[21] = {ID=21,single_scores=5,daily_times=1,number_demand=1,lv=0,name=130020,name1="签到",description=130070,description1="进行签到1次",description1=130620,description2="进行每日签到，可免费获得奖励。",skip=303,icon="item511"},
[22] = {ID=22,single_scores=6,daily_times=5,number_demand=1,lv=0,name=130021,name1="幸运转盘",description=130071,description1="在酒馆内转动幸运转盘5次",description1=130621,description2="转动幸运轮盘将会获得各种惊喜奖励。",skip=300,icon="item511"},
[23] = {ID=23,single_scores=1,daily_times=20,number_demand=1,lv=0,name=130022,name1="许愿",description=130072,description1="在许愿池许愿20次",description1=130622,description2="许愿可以获得相应资源。",skip=11,icon="item511"},
[24] = {ID=24,single_scores=2,daily_times=10,number_demand=1,lv=0,name=130023,name1="旅行商人",description=130073,description1="在旅行商人购买10次道具",description1=130623,description2="旅行商人经常会出售一些超值的物品。",skip=301,icon="item511"},
[25] = {ID=25,single_scores=2,daily_times=5,number_demand=1,lv=0,name=130024,name1="使用资源道具",description=130074,description1="使用资源道具5次",description1=130624,description2="使用资源道具可以快速获得资源。",skip=102,icon="item511"},
[26] = {ID=26,single_scores=2,daily_times=5,number_demand=1,lv=0,name=130025,name1="提升粮食产量",description=130075,description1="使农田产量提升1次",description1=130625,description2="使用农田提升道具或金币可以提升城堡内农田的产量。",skip=102,icon="item511"},
[27] = {ID=27,single_scores=2,daily_times=5,number_demand=1,lv=0,name=130026,name1="提升木材产量",description=130076,description1="使伐木场产量提升1次",description1=130626,description2="使用伐木场提升道具或金币可以提升城堡内伐木场的产量。",skip=102,icon="item508"},
[28] = {ID=28,single_scores=2,daily_times=5,number_demand=1,lv=10,name=130027,name1="提升铁矿产量",description=130077,description1="使铁矿场产量提升1次",description1=130627,description2="使用铁矿场提升道具或金币可以提升城堡内铁矿场的产量。",skip=102,icon="item510"},
[29] = {ID=29,single_scores=2,daily_times=5,number_demand=1,lv=15,name=130028,name1="提升秘银产量",description=130078,description1="使秘银矿产量提升1次",description1=130628,description2="使用秘银矿场提升道具或金币可以提升城堡内秘银矿场的产量。",skip=102,icon="item509"}
}
return daily_tasks
