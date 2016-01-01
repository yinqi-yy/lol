local sprotoparser = require "sprotoparser"

local proto = {}

proto.c2s = sprotoparser.parse [[
.package {
	type 0 : integer
	session 1 : integer
}

#客户端配置
register 1 {
	request {
		userName	 	0:string
		passWord     	1:string
        email           2:string
	}
	response {
		config 			0:string
	}
}

.ServerInfo{
	serverName 		0 :string
	serverIP 		1:string
	serverPort 		2:string
	serverID 		3:integer
}

#最近登陆服务器列表
lastLogin 2 {
	request {
		platformID 		0:integer
		account 		1:string
	}
	response {
		lastLoginServer 		0:*ServerInfo
		newServer 		1:*ServerInfo
	}
}

#请求其它服务器列表
otherServerList 3 {
	request {
		platformID 		0:integer  	#平台ID 
		firstID 			1:integer	#起始服务器ID  1为开始
		lastID 			2:integer	#终止服务器ID 	
	}
	response {
		lastLoginServer 		0:*ServerInfo
	}
}

#确认要登陆哪一台服务器
checkLogin 4{
	request {
		account 		0:string
		platformID 		1:integer  	#平台ID
		serverID 		2:integer  	#服务器ID
	}
}

#调试命令
gmdebug 40 {
	request {
		cmd    		0:string   # add goodTID num 
	}
	response {
		status 		0:integer # 1成功  2失败
	}
}

#心跳包
handshake 41 {
	request {
		clientTime 0 :integer
	}
	response {
		clientTime 0  : integer
		serverTime 1 : integer
	}
}

#------------------------50-100 玩家信息相关
#登陆到服务器
loginToServer 50 {
	request {
		account 		1 : string
		password 		2 : string
	}
	response {
		state 			0 : integer  	# 1 登陆成功   2 服务器满  3 账号错误   4 登陆超时 5 角色未创建 6 账号不存在 99其它错误
		playerID		1 : string
	}
}

#创建角色
createPlayer 51 {
	request {

	}
	response {
		result 			0 :integer  	# 1  角色创建成功  2角色已存在
		playerID   		1 :string
	}
}

#请求玩家信息
requestPlayer 52 {
	request {
		playerID   		0:string
	}	
}

#领取成就奖励
getAchieveReward 53 {
	request {
		achieveID   		0:integer
	}	
	response {
		result 			0 :integer 
		achieveID		1 :integer #佩章变更
	}
}

#重命名
rename 54 {
	request {
		renameType	0:integer#1改名卡2金币
		newName		1:string
	}	
	response {
		result 			0 :integer 
	}
}

#佩戴勋章
wearMedal 55 {
	request {
		achieveID   		0:integer
	}	
	response {
		result 			0 :integer 
	}
}

#请求其他玩家信息
requestOtherPlayer 56 {
	request {
		playerID   		0:string
		serverid 		1:integer #服务器id
	}	
}

.skillInfo {
	skillID		0:integer
	lv 			1:integer
}
#请求技能点信息
refreshSkillPoints 57 {
	request {
	}
	response {
		skillinfo 		0:*skillInfo
	}
}
#设置技能点
setSkillPoints 58 {
	request {
		skillID 			0:integer
	}
	response {
		result 			0 :integer 
	}
}

.activeskillInfo {
	skillID				0:integer
	coolingTime 		1:integer
}

#请求技能书
refreshActiveSkill 59 {
	request {
	}
	response {
		activeskillinfo 	0:*activeskillInfo
	}
}
#主动技能使用
useActiveSkill 60 {
	request {
		skillID 			0:integer
	}
	response {
		result 			0 :integer 
	}
}

#重置技能点
resetSkillPoints 61 {
	request {
	}
	response {
		result 		0:integer
	}
}

#更换形象
changeImage 62 {
	request {
		changeType		0:integer#1道具2金币
		newImage		1:string
	}	
	response {
		result 			0 :integer 
	}
}

# 请求其他玩家市场等级
requestOtherMarket 63 {
	request {
		playerID   		0:string
	}	
	response {
		result 			0:integer 
		lv				1:integer # 市场等级
		x 				2:integer
		y 				3:integer
		name			4:string
		castle_lv  		5:integer
	}
}


#玩家系统设置
systemSettingUp 64 {
	request {
		namevalue 		0:string
		setvalue 		1:integer
	}
	response {
		result 		0:integer
	}
}

#领主搜索
.playerSearchInfo {
	playerID 		0:string
	name 			1:string
	head_image 		2:string
	power 	 		3:integer
	language 		4:integer
	is_online		5:integer
}
#搜索
systemSearch 65 {
	request {
		name		0:string 	#模糊搜索关键字
		operation 	1:integer 	#1刷新2递增
	}
	response {
	    searchInfo  	0:*playerSearchInfo(playerID)
	    operation 	1:integer 	#1刷新2递增
	    result 		2:integer
	}
}

#绑定帐号
bindAccount 66 {
	request {
		platformAccount 	0:string #平台帐号
		platformID 			1:integer #平台ID
		platformUserID 		2:string #平台用户ID
	}
	response {
	    result 		0:integer
	}
}

#解除绑定帐号
releaseBindAccount 67 {
	request {
		platformID 			0:integer #平台ID
	}
	response {
	    result 		0:integer
	}
}

#切换帐号
switchAccount 68 {
	request {
		platformAccount 	0:string #平台帐号
		platformID 			1:integer #平台ID
	}
	response {
	    result 		0:integer
	    account 	1:string #新帐号
	    name 		2:string #名字
	    lv 			3:integer #等级
	}
}

#删除帐号
deleteAccount 69 {
	request {
	
	}
	response {
	    result 		0:integer
	}
}

#邀请好友界面
inviteMenu 70 {
	request {

	}
	response {
		inviteNum 		0:integer  #邀请的好友达到六级以上城堡人数
		inviteStatus	1:integer  #邀请状态 0:未被邀请 1:已被邀请
	}	
}


#领取邀请奖励
getInviteGift 71 {
	request {
		giftID 		0:integer
	}
	response {
		result 		0:integer
	}
}

#复制邀请码
copyInviteCode 72 {
	request {

	}
	response {
		inviteCode 		0:string    #邀请码
	}
}

#接受邀请
acceptInvite 73 {
	request {
		inviteCode 		0:string		#邀请码
	}
	response {
		inviteplayerID 	0:string      #邀请方ID
		inviteName 		1:string 	#邀请方名字
		serverID 		2:string 	#服务器ID
		result 			3:integer
	}
}


#hotfixTest
hotfixAccount 98 {
	request {
		account 	0:string
		hotfixFunction 1:string
	}
	response {
	    result 		0:integer
	}
}

#hotfixTest
hotfixService 99 {
	request {
		service 	0:string
		hotfixFunction 1:string
	}
	response {
	    result 		0:integer
	}
}

#------------------------100-200 通用 建筑物 升级 提速 等通用

#建筑物相关操作
building 100 {
	request {
		position 		0:integer 	#位置
		operation 		1:integer 	#哪种操作 1建造  2升级 3立即升级   4取消升级 5训练  6 取消训练 7建筑升级道具加速 8建筑拆除 9建筑生产加速 10立即训练 11收取训练结果 12强制训练 13解雇/拆除 16vip立即建造加速
		param			2:integer 	#参数1 	重要参数优先 比如:　训练的兵种　研究的类型　如果操作类别为9，则参数1值=1代表金币，2代表道具。参数2代表道具ID。
		param2 		3:integer 	#参数2　次要参数　比如：　训练人数　　
	}
	response {
		result 			0 :integer
	}
}

#雇佣工人
hireWorker 101 {
	request {
	}
	response {
		result 			0 :integer
	}
}

#产量与消耗
productionConsume 102 {
	request {
	}
	response {
		wood 			0:integer	#木材产量
		food 			1:integer	#粮食产量
		iron 			2:integer	#铁矿产量
		silver 			3:integer	#银矿产量
		consume 		4:integer 	#消耗
	}
}


#------------------------201-230 兵营 训练兵种


#------------------------231-260 城墙 箭塔 瞭望塔
#灭火
wallOutfire 231 {
	request {
	}
	response {
		result 			0 :integer
	}
}

#增加城防值
wallAddDefence 232 {
	request {
	}
	response {
		result 			0 :integer
	}
}

#移动建筑
moveBuild 233 {
	request {
		from			0:integer #起始位置
		to			1:integer #目标位置
	}
	response {
		result 			0:integer
	}
}

#增加城市增益信息
addCityBuff 234 {
	request {
		index 			0:integer #大类型
		childIndex 		1:integer #小类型
	}
	response {
		result 			0:integer 
	}
}

#新开土地
openLand 235 {
	request {
		index 			0:integer #土地块索引
	}
	response {
		result 			0:integer
	}
}

#------------------------261-290 急救帐篷
.needTreat{
	armyType			0:integer#类型
	treatNum			1:integer #治疗数目
}

#治疗
treatArmy 261 {
	request {
		list 			0:*needTreat(armyType)
		treattype 		1:integer
	}
	response {
		result 			0:integer
		emergencyTime 	1:integer
	}
}

#放弃治疗
abandonTreat 262 {
	request {

	}
	response {
		result 			0:integer
	}
}

#立即治疗
immediatelyTreat 263 {
	request {
		list 			0:*needTreat(armyType)
	}
	response {
		result 			0:integer
	}
}

#解雇伤兵
fireWoundedArmy 264 {
	request {
		armyType		0:integer#类型
		num			1:integer#数目
	}
	response {
		result 			0:integer
	}
}

#收获伤兵
harvestTreatArmy 265 {
	request {
	}
	response {
		result 			0:integer
	}
}

#------------------------291-320 酒馆 - 日常奖励
#日常任务信息
.stateReward{
	functionID 			0:integer#日常任务ID
	count 				1:integer#日常任务已完成次数
}
messageReward 291 {
	response {
		stateReward 	0:*stateReward
		stage			1:integer#奖励已领取阶段
	}
}
#领取奖励
tasksReward 292 {
	request {
		stage		0:integer#阶段
	}
	response {
		result		0:integer
	}
}
#------------------------321-350 酒馆 - 转盘
#幸运转盘信息
.stateTurn{
	id			0:integer#随机物品ID
	num 		1:integer#随机物品数量
	order			2:integer#已翻牌的顺序
	position 		3:integer#物品的位置
}
messageTurn 321 {
	response {
		stateTurn 			0:*stateTurn
		count 				1:integer#转盘免费次数
		mul 				2:integer#下次翻牌得到物品的倍数
		shuffle				3:integer#0未洗牌1洗牌
	}
}

#幸运转盘请求
turnBegin 322 {
	response {
		id 			0:integer#物品ID
		count 			1:integer#数量
	}
}

#洗牌
shuffle 323 {
}

#翻牌
clickpoker 324 {
	request {
		position		0:integer#位置
	}
	response {
		id 			0:integer#物品ID
		count 			1:integer#数量
		back 			2:integer#已经打开牌的数量	
	}
}

#放弃翻牌
quitpoker 325 {
}

#换钱
goldchange 326 {
	request {
		id		0:integer
		use		1:integer#0-购买使用 1-使用
		item 	2:integer#0-铜币 1-龙币
	}
}
#------------------------351-380 酒馆 - 宝藏
.recordInfo {
	name 			0:string
	helpTime		1:integer
}

#宝藏界面
treasure 351 {
	request {
		
	}
	response {
		helpNum  		0:integer #已帮助你的玩家人数
		treasureLv 		1:integer #宝箱等级
		coolingTime 	2:integer #宝箱冷却时间
		askperson 		3:*string #可帮助玩家FB列表
	}
}

#请求帮助
askhelp 352 {
	request {
		personList 		2:*string  #请求帮助玩家FB列表ID
	}
	response {
		result 			0:integer
	}
}

#帮助
help 353 {
	request {
		askfbAccount 	0:string #请求你帮助的玩家FB Account
	}
	response {
		result 			0:integer
	}
}

#获取宝藏
getTreasure 354 {
	request {
		treasureLv 		0:integer #宝箱等级
	}
	response {
		coolingTime 		0:integer #宝箱冷却时间
	}
}

#获取帮助记录 
gethelpRecord 355 {
	request {
		
	}
	response {
		recordinfo 		0:*recordInfo
	}
}

#------------------------381-450 铁匠铺 - 锻造 储物箱 
.itemInfo{
	itemID					0:integer # 物品ID
	number					1:integer # 物品数量
}

#锻造
forge 381 {
	request {
		ID			0:integer 
		require		1:string #下位装备 为0则无
		material1	2:integer #材料1
		material2	3:integer #材料2
		material3	4:integer #材料3
		material4	5:integer #材料4
		speedUp 	6:integer #是否直接完成0否1是
	}
	response {
		effectTime	0:integer #锻造到期时间
		effectType 1:integer #锻造物品
	}
}

#合成材料
compositeMaterial 382 {
	request {
		material	0:integer
	}
	response {
		result		0:integer
	}
}

#分解
decompose 383 {
	request {
		equipmentID	0:string
	}
	response {
		result		0:*itemInfo(itemID)
	}
}

#装备
equipment 384 {
	request {
		equipmentID	0:string
	}
	response {
		result		0:integer
	}
}

#脱装备
unequipment 385 {
	request {
		equipmentID	0:string
	}
	response {
		result		0:integer
	}
}

#------------------------451-460 许愿池
.resourceInfo{
	basevalue		0:integer	#基础值
	goldnum			1:integer	#需要消耗的金币
}
#可获取许愿资源列表
requestwishingwellList 451 {
	request {
	}
	response {
		freewishnum 	0:integer #免费许愿次数
		baseinfo		1:*resourceInfo
		totalwishnum     2:integer #总许愿次数
	}
}
#获取许愿资源
getResource 452 {
	request {	
		ID		0:integer
	}
	response {
		multinum		0:integer #许愿倍率
		currentbase		1:integer #当前资源获取基础值
		nextbase		2:integer #下一次资源获取基础值
		freewishnum 	3:integer #剩余许愿次数
		goldnum			4:integer #下一阶段需要消耗的金币数量
		totalwishnum    5:integer #总许愿次数
	}
}

#------------------------461-490 学院

#------------------------491-520 邮件
# 奖励信息，战利品信息
.rewardInfo{
	itemID					0:integer # 物品ID
	number					1:integer # 物品数量
}

# 战斗状态信息
.fight_struct{
	title					0:string # 标题
	iconID					1:string # 形象ID
	screenX					2:integer # 坐标X
	screenY					3:integer # 坐标Y
	power					4:integer # 战斗力增益
	kills					5:integer # 击杀
	loss					6:integer # 损失
	wound					7:integer # 受伤
	survive					8:integer # 存活
	traploss				9:integer # 陷阱损失
	troopMax				10:integer # 征兵上限加成，千分比
	infantryInfo 			11:string # 步兵属性加成。攻击|防御|血量|减伤
	cavalryInfo 			12:string # 骑兵属性加成。攻击|防御|血量|伤害
	archerInfo				13:string # 弓兵属性加成。攻击|防御|血量|伤害
	chariotInfo 			14:string # 车兵属性加成。攻击|防御|血量|伤害
	trapInfo 				15:string # 陷阱属性加成。攻击|克步|克骑|克弓
}

# 战斗兵种信息
.fight_troop_info{
	id						0:integer # 兵种ID
	kill					1:integer # 击杀
	loss					2:integer # 损失
	wound					3:integer # 受伤
	survive					4:integer # 存活
}

# 战斗详情
.fight_info{
	title					0:string # 标题
	number					1:integer # 兵种数量
	troopInfo				2:*fight_troop_info # 部队信息
}

# 资源信息
.resource_info{
	id						0:integer # 资源ID
	own						1:integer # 拥有
}

# 兵种信息
.troop_info{
	id						0:integer # 兵种ID
	number					1:integer # 兵种数量
}

# 科技信息
.add_buff_info{
	id						0:integer # 科技/buff ID
	lv						1:integer # 等级
}

# 援军领主信息
.reinforce_info{
	name 					0:string # 援军领主名称
	iconID 					1:string # 形象ID
	lv 						2:integer # 援军领主等级
	reinforcementInfo		3:*troop_info # 援军信息
}

# 侦查信息
.fight_scout{
	scoutTarge				0:integer # 侦查状态，0：侦查别人；1：被侦查；2：侦查联盟堡垒；3：侦查失败
	title					1:string # 侦查目标，（公会名）玩家名
	iconID					2:string # 形象ID
	screenX					3:integer # 坐标X
	screenY					4:integer # 坐标Y
	resourceInfo			5:*resource_info # 资源信息
	defenceCity				6:integer # 城防值
	defenceCityMax			7:integer # 城防满值
	defenceTroopNum 		8:integer # 防守部队总数
	trapNum 				9:integer # 陷阱数量
	reinforcementNum 		10:integer # 援军数量
	defenceTroopInfo		11:*troop_info # 防守部队信息
	trapInfo				12:*troop_info # 陷阱信息
	reinforceName 			13:*reinforce_info # 援军领主信息
	archerTower1Lv			14:integer # 箭塔1等级
	archerTower2Lv			15:integer # 箭塔2等级
	technologyInfo			16:*add_buff_info # 科技增加属性信息
	abilityInfo				17:*add_buff_info # 领主能力信息
	skillInfo				18:*integer # 领主技能ID
}

# 公告类型邮件
.mail_notice{
	subjectType				0:integer # 公告类型
	rewardTitleID			1:integer # 奖励邮件标题
	rewardNum				2:integer # 物品数量
	rewards					3:*rewardInfo # 奖励信息
}

# 系统类型邮件
.mail_system{
	subjectType 			0:integer # 系统邮件类型
	rewardTitleID			1:integer # 奖励邮件标题
	rewardNum				2:integer # 物品数量
	rewards					3:*rewardInfo # 奖励信息
	parameter				4:string # 附加参数集合(1|"",2|"")
}

# 战斗报告类型邮件
.mail_fight{
	subjectType				0:integer # 战斗主题类型
	rewardNum				1:integer # 获得物品数量
	rewards 				2:*rewardInfo # 奖励信息
	liftStruct				3:fight_struct # 攻击方信息
	rightStruct				4:fight_struct # 防守方信息
	attackNum 				5:integer # 攻击方参战数量
	attackFightInfo			6:*fight_info # 攻击方战斗详情
	defendNum 				7:integer # 防守方参战数量
	defendFightInfo			8:*fight_info # 防守方战斗详情
	scoutStruct				9:fight_scout # 侦查信息
}

# 资源采集邮件
.mail_resource{
	subjectType				0:integer # 战斗结果。0：资源采集；1：市场交易
	resourceID				1:integer # 采集的资源ID
	resource 				2:string # 资源标题内容，当ID无效时。比如市场交易
	screenX					3:integer # 坐标X
	screenY					4:integer # 坐标Y
	rewardNum				5:integer # 获得物品数量
	rewards					6:*rewardInfo # 获得物品信息
}

# 怪物报告邮件
.mail_monster{
	subjectType				0:integer # 战斗结果。1：成功；2：失败；3：首杀
	monsterID				1:integer # 怪物ID
	screenX					2:integer # 坐标X
	screenY					3:integer # 坐标Y
	rewardNum				4:integer # 战利品数量
	rewards					5:*rewardInfo # 战利品信息
	power					6:integer # 战斗力增益
	troop					7:integer # 部队总数
	wound					8:integer # 受伤数量
	dead					9:integer # 死亡数量
}

# 城堡探险邮件
.mail_ruins{
	screenX					0:integer # 坐标X
	screenY					1:integer # 坐标Y
	time_point				2:integer # 时间戳，探索时间(秒数)
	rewardNum				3:integer # 战利品数量
	rewards					4:*rewardInfo # 战利品信息
	lossNum					5:integer # 部队损失种类
	losses					6:*troop_info # 部队损失信息
}

# 玩家聊天邮件
.mail_im{
	playerID			0:string # 发送方玩家ID
	playerName			1:string # 发送方玩家名字
	playerIcon			2:string # 发送方玩家头像
	playerServerID		3:integer # 发送方玩家服务器
	guildName 			4:string # 发送方玩家公会
	imID				5:string # 聊天ID
	targetID			6:string # 接收方玩家ID
	recordID			7:integer # 记录ID
	content				8:string # 内容
	isAll 				9:integer #是否群聊0否1是
}

# 活动类型邮件
.mail_event{
	eventID		 			0:integer # 活动ID
	rewardTitleID			1:integer # 奖励邮件标题
	rewardNum				2:integer # 物品数量
	rewards					3:*rewardInfo # 奖励信息
	parameter				4:string # 附加参数集合(1|"",2|"")
}

# 运营/工作室类型邮件
.mail_operation{
	rewardTitleID			1:integer # 奖励邮件标题
	rewardNum				2:integer # 物品数量
	rewards					3:*rewardInfo # 奖励信息
}

.mail{
	mailID					0:string # 邮件ID
	mailType				1:integer # 邮件类别；1-公告；2-系统；3-采集；4-战斗；5-怪物；6-城堡；7-玩家
	subjectID				2:integer # 邮件主题资源ID
	titleID					3:integer # 邮件标题资源ID，如果为0则读取内容
	title					4:string # 邮件标题内容
	senderID				5:string # 发信目标ID。0-无；1-系统；2-NPC；玩家ID>10
	senderName				6:string # 发信目标名称
	iconID					7:string # 发件人图标ID
	contentID				8:integer # 邮件内容资源ID
	explainID				9:integer # 邮件说明资源ID
	time_point				10:integer # 时间戳
	attach					11:integer # 是否有关联附件。0-没有；1-有 
	readstatus				12:integer # 标记是否已读。0-未读；1-已读
	receive					13:integer # 标记是否有物品未领取。0-无；1-未领取
	locked 					14:integer # 标记是否锁定邮件, 0-不锁定;1-锁定
	attach_notice			15:mail_notice # 公告 类型附件
	attach_system			16:mail_system # 系统 类型附件
	attach_resource			17:mail_resource # 采集/交易 类型附件
	attach_fight				18:mail_fight # 战斗类型附件
	attach_monster			19:mail_monster # 怪物类型附件
	attach_ruins 			20:mail_ruins # 城堡探险类型附件
	attach_im 				21:mail_im # 玩家聊天附件
	attach_event				22:mail_event # 活动类型邮件
	attach_operation			23:mail_operation # 运营/工作室类型邮件
}

.mail_struct{
		num 			0:integer # 获取到的数量
		mails 			1:*mail   # 邮件信息
		unread			2:integer # 未读邮件数量
		sum 			3:integer # 该类型邮件总数
		mailType		4:integer # 邮件类别；1-公告；2-系统；3-采集；4-战斗；5-怪物；6-城堡；7-玩家
}
# 获取邮件列表
# 首次打开时获取所有邮件，邮件类别为0，返回所有邮件前8封
mailPage 491 {
	request {
	}
	response {
		mailtypes			0:integer # 邮件类别数量
		mailInfo 			1:*mail_struct # 邮件结构
	}
}

#获取邮件内的奖励
mailGetAward 492 {
	request {
		mailID    		0:string
	}
	response {
		result 			0:integer
	}
}

#删除邮件
mailDel 493 {
	request {
		mailtype		0:integer # 删除邮件类别。
		mailnum			1:integer # 删除邮件数量，删除该类别所有则传入0
		maillist		2:*string # 删除邮件列表的ID
		mailsecond 		3:integer # 删除邮件资源类别 0:资源采集 1:资源援助
	}
	response {
		result 			0:integer
		dellist 			1:*string # 已删除邮件列表的ID
	}
}

#获取下一页邮件
mailUpdate 494 {
	request {
		mailtype		0:integer # 邮件类别
		page			1:string  #上一组最后一个邮件的ID  如果有被删除  点击下一页的用最后一个
		count			2:integer #请求数量，限制一次不超过10
	}
	response {
		num 			0:integer # 获取到的数量
		mails 			1:*mail   # 邮件信息
		unread			2:integer # 未读邮件数量
	}
}

#更新邮件读取状态
mailUpdateRead 495 {
	request {
		mailID     		0:string
	}
	response {
		result 			0:integer
	}
}

#添加邮件，测试
mailAdd 497 {
	request {
		mailtype		0:integer
		senderName		1:string
	}
	response {
		result 			0:integer
	}
}

.delInfo {
	mailtype 	0:integer  			#邮件类型
	dellist 	1:*string  			#邮件列表
}

#删除全部邮件
mailDelAll 498 {
	request {
		mailtype	0:*integer 		#删除邮件类别列表
	}
	response {
		result 		0:integer 
		dellist 		1:*delInfo		#已删除邮件列表
	}
}

#锁定和解锁邮件
mailLock 499 {
	request {
		mailtype 		0:integer 		#需要锁定和解锁的邮件类型
		mailID 			1:string 		#需要锁定和解锁的邮件ID
		resourcetype	2:integer 		#若是资源类型需提供第二个参数
	}
	response {
		result 		0:integer 		
	}
}

#------------------------521-530 聊天

# 聊天接收消息格式.个人聊天以邮件的方式展现。
# 由于三种类型聊天有略微差异，所以分开三种消息格式
# 国家聊天，接收聊天记录格式
.im_world_record{
	recordID			0:string # 时间戳作为记录ID，精确到毫秒
	playerID			1:string # 玩家ID
	playerName			2:string # 玩家名称
	playerIcon			3:string # 玩家图标
	playerVip			4:integer # 玩家激活的vip等级。为0则未激活
	guildID				5:integer # 联盟ID
	guildName			6:string # 玩家所在联盟名
	imtype				7:integer # 消息类型。0：文本；1：战报 2:语音 3:公会邀请 4:系统
	imsign				8:integer # 消息标记，0：普通消息；1：系统消息；2：喇叭消息
	content 			9:string # 文本消息内容
	languagetype 		10:integer # 消息语言版本，0-英语；1-汉语
}

# 联盟聊天，接收格式
.im_guild_record{
	recordID			0:string # 时间戳作为记录ID，精确到毫秒
	playerID			1:string # 玩家ID
	playerName			2:string # 玩家名称
	playerIcon			3:string # 玩家图标
	playerVip			4:integer # 玩家激活的vip等级。为0则未激活
	imtype				5:integer # 消息类型。0：文本；1：战报
	imsign 				6:integer # 消息标记。0：普通消息；1：系统消息
	content				7:string # 消息内容。如果是战报，则为战报标题
	fightID				8:string # 战报ID，如果有
	languagetype		9:integer # 消息语言版本，0-英语；1-汉语
}

# 个人聊天接收格式
.im_own_record{
	playerID			0:string # 玩家ID
	playerName			1:string # 玩家名称
	playerIcon			2:string # 玩家图标
	playerVip			3:integer # 玩家激活的vip等级。为0则未激活
	guildName			4:string # 玩家公会名
	recordID 			5:string # 时间戳，精确到毫秒
	imID 				6:string # 聊天ID
	content				7:string # 消息内容
	languagetype 		8:integer # 消息语言版本，0-英语；1-汉语
	isAll 				9:integer # 是否群聊0否1是
}
	
# 获取下一页聊天记录，一次最多20条
imUpdate 521 {
	request {
		imtype 			0:integer # 获取记录的类型，0：国家；1：联盟；2：玩家
		param1			1:string # 联盟ID/玩家ID
		recordID 		2:string # 最新的记录ID，如果没有则为0
	}
	response {
		result 				0:integer # 如果失败，则没有联盟/玩家 的聊天记录
	}
}

# 发送信息时，客户端预处理。服务端给所有目标发送会有延迟
# 战报，客户端操作为分享。
# 发送聊天信息
imSendInfo 522 {
	request {
		imtype 				0:integer #记录的类型，0：国家；1：联盟；2：玩家
		param1				1:string # 发送目标，全体联盟为1/玩家ID
		content 			2:string # 聊天信息
		languagetype 		3:integer # 消息语言版本，0-英语；1-汉语
	}
	response {
		result 				0:integer # 如果失败，则没有联盟/玩家 的聊天记录
	}
}

# 分享战报
imFreeFight 523 {
	request {
		fightID 			0:string # 邮件ID
	}
	response {
		result 			0:integer
	}
}

# 屏蔽玩家信息
imShieldPlayer 524 {
	request {
		playerID 			0:string # 玩家ID
		playerName 			1:string # 玩家名字
	}
	response {
		result 				0:integer # 如果失败，则没有玩家
	}
}

# 喇叭消息
imSendTrumpet 525 {
	request {
		content 			0:string # 聊天信息
		languagetype 		1:integer # 消息语言版本，0-英语；1-汉语
	}
	response {
		result 				0:integer # 如果失败，则物品不足或者金币不足
	}
}

# 公告邀请
imSendInvite 526 {
	request {
		languagetype 		0:integer # 消息语言版本，0-英语；1-汉语
	}
	response {
		result 				0:integer # 如果失败，则金币不足。或者没有联盟
	}
}

# 跨越发送聊天信息
imSendServerInfo 527 {
	request {
		playerID			0:string # 发送目标，玩家ID
		serverID 			1:integer #目标服务器
		content 			2:string # 聊天信息
		languagetype 		3:integer # 消息语言版本，0-英语；1-汉语
	}
	response {
		result 				0:integer # 如果失败，则没有联盟/玩家 的聊天记录
	}
}

# 查看战报
imSeeFight 528 {
	request {
		fightID 			0:string # 战报ID
	}
	response {
		mail 			0:mail   
		result 			1:integer
	}
}

# 标记为已读
imRead 529 {
	request {
		playerID 		0:string # 玩家ID
	}
	response { 
		result 			1:integer
	}
}

#------------------------531-550 码头 - 旅行商人 
#旅行商人物品列表
requestBusinessmanList 531 {
	request {

	}
	response {
		specialgoods	0:integer
		goods 			1:*integer
		times 			2:integer #刷新次数
		nextTime		3:integer #下次秒数
	}
}

#购买旅行商人物品
buyBusinessmanItem 532 {
	request {
		ID		0:integer
	}
	response {
		goods	0:integer
	}
}

#刷新旅行商人物品列表
refreshBusinessmanList 533 {
	request {
		
	}
	response {
		goods	0:*integer
	}
}

#领取码头货物奖励
fetchWharfAwards 534 {
	request {
		isFetch		0:integer #是否领取
	}
	response {
		pierFetchTime	0:integer #下次领取时间
		awardsID	1:integer	#奖励id
		awardsNum	2:integer	#奖励数量
	}
}

#货船签到
shipSignIn 535 {
	request {
		
	}
	response {
		result	0:integer #0失败1成功
	}
}

#领取任务奖励
taskAwards 536 {
	request {
		taskID	0:integer
	}
	response {
		result	0:integer #0失败1成功
	}
}

#领取新兵奖励
recruitGift 537 {
	request {
		
	}
	response {
		result	0:integer #0失败1成功
	}
}

#------------------------551-600 活动中心
#限时比赛个人积分，本阶段排名，个人总排名
eventperson 551 {
	response {
	    goal 0:integer
	    rank 1:integer
	    ranks 2:integer
	}	
}

#限时比赛历史阶段排名10
.eventrank{
	stage		0:integer 
	name 		1:string		#玩家名字
	rank 			2:integer		#排名
}
eventRanking 552 {
	response {
		eventrank        	0:*eventrank
			}
}

#历史排名
.eventrankPast{
	time 		0:integer		#时间
	name 		1:string		#最强领主名字
	rank 		2:integer		#排名
}	
eventrankstr 553 {
	request {
		id  0:integer  #12限时比赛历史13黑骑士个人历史14黑骑士联盟历史
	}
	response {
		eventrankPast        	0:*eventrankPast
			}
}


#黑骑士人物信息
blackpow 554 {
	response {
	    status 0:integer		#0未开启1进行中2已开启
	    BeginTime 1:integer		#开启时间
		count 2:integer		#波次
		x 3:integer		#黑骑士x坐标
		y 4:integer		#黑骑士y坐标
		index 5:integer		#部队索引个数
	}	
}

#黑骑士开始迎战
blackwar 555 {
	response {
	    result 0:integer		#0失败 1成功
	}
}

#个人积分，联盟积分
blackgoal 556 {
	response {
	    Pgoal 0:integer		#个人积分
	    Mgoal 1:integer		#联盟积分
		Prank 2:integer		#个人排名
		Mrank 3:integer		#联盟排名
	}	
}

#排行榜
.ranks{
	Mid 		0:integer		#联盟id		
	Mname 		1:string		#联盟名字
	Sname 		2:string 		#联盟简称
	playerID    3:string		#玩家id，如果是联盟排行榜则为0	
	name 		4:string		#领主排行榜代表玩家名字，联盟排行榜代表盟主名字
	rank 		5:integer		#排名
	goal  		6:integer 		#数值
	icon 		7:string		#头像
}
personrank 557 {
	request {
		id  0:integer  #1战力2杀敌3城堡4等级5联盟战力6联盟杀敌
	}
	response {
		rank 0:integer		#排名
		ranks 1:*ranks		
			}
}

#------------------------601-602 物品 背包
#物品使用
itemuse 601 {
	request {
		itemID  0:integer  #物品ID
		count   1:integer  #使用数量
	}
	response {
	    result 0:integer
	}	
}

#------------------------900-1000 联盟
#简易公会信息
.guildSimple{
	guildID		 		0:integer #联盟ID
	guildName			1:string #联盟名字
	simpleName			2:string #联盟简称
	announce			3:string #联盟宣言
	ownerID				4:string #盟主id
	ownerName			5:string #盟主名字
	language 			6:integer #联盟语言
	guildFlag			7:integer #联盟旗帜
	guildPower			8:integer #联盟战力
	memberNum 			9:integer #联盟人数
	memberMaxNum 		10:integer #最大联盟人数
	openInvite			11:integer #公开招募
}

#创建联盟
creatGuild 901 {
	request {
		guildName  0:string  #联盟名字
		announce   1:string  #联盟宣言
	}
	response {
	    result 0:integer
	}	
}

#联盟列表
guildList 902 {
	request {
		operation	 0:integer #操作类型 1自己2递增3刷新4其他公会(keyWord发公会ID)5其他公会列表
		keyWord		 1:string  #关键字
	}
	response {
	   	guild		0:*guildSimple(guildID)
		operation 	1:integer #操作类型 1自己2递增3刷新4其他公会
	}	
}

#联盟留言
.GuildMessage{
	time 			0:integer    #消息时间
	content 		1:string	#文本消息内容
	name 			2:string	#玩家名字
	icon 			3:string 	#玩家图标id
	playerID 		4:string 	#玩家ID
	GID 			5:integer   #玩家公会id
	own 			6:integer   #0非本人，1本人
}

#添加留言
creatGuildMessage 903 {
	request {
		guildID  	  0:integer  #联盟ID
		content 	  1:string	#文本消息内
	}
	response {
		result 0:integer   #0留言失败，成功返回时间戳
	}
}

#获取留言板内容
getGuildMessage 904 {
	request {
		guildID  	  0:integer  #联盟ID
	}
	response {
	    result 0:*GuildMessage
	}	
}

#屏蔽留言
noGuildMessage 905 {
	request {
		id   		  0:string 
	}
	response {
	    result 0:integer #1成功
	}
}

#解除屏蔽
canGuildMessage 906 {
	request {
		id  		  0:string   
	}
	response {
	    result 0:integer #1成功
	}
}

#联盟科技信息
.guildscienceInfo {
	scienceID 		0:integer
	lv 				1:integer
	star 			2:integer
	researchTime 	3:integer
}

#联盟层级信息
.guildscience_struct {
	floorID 			0:integer
	scienceinfo 		1:*guildscienceInfo
}

#联盟科技列表
guildScienceList 907 {
	request {
	
	}
	response {
		totalstar 				0:integer
		guildscienceinfo 		1:*guildscience_struct#联盟科技层级信息结构
	}
}

#捐献窗口
contributeList	908 {
	request {
		scienceID 		0:integer   #贡献科技ID
	}
	response {
		resttime 			0:integer 	#冷却剩余时间
		commontype 			1:integer 	#普通捐献资源类型,-1:粮食 1:木材 2:铁矿 3:秘银
		commoncost 			2:integer	#普通捐献
		leftbuttoncost		3:integer 	#是否开启5倍奖励按钮,资源或金币,0:未开启 非0:开启 1:普通资源 10:金币
		rightbuttoncost 	4:integer   	#是否开启25倍奖励按钮,资源或金币,0:未开启 非0:开启 1:普通资源 20:金币
		integral 			5:integer   	#当前科技经验
		cancontribute 		6:integer     #是否可捐献
	}
}

#联盟科技贡献
contributeScience 909 {
	request {
		scienceID 			0:integer   	#贡献科技ID
		sciencelv 			1:integer 	#贡献科技等级
		commontype 			2:integer 	#普通捐献资源类型
		commoncost 			3:integer	#普通捐献
		leftbuttoncost		4:integer 	#是否开启5倍奖励按钮,资源或金币,0:未开启 非0:开启 1:普通资源 10:金币
		rightbuttoncost 	5:integer   	#是否开启25倍奖励按钮,资源或金币,0:未开启 非0:开启 1:普通资源 20:金币	
	}
	response {
		resttime 			0:integer 	#冷却剩余时间
		commontype 			1:integer 	#普通捐献资源类型,-1:粮食 1:木材 2:铁矿 3:秘银
		commoncost 			2:integer	#普通捐献
		leftbuttoncost		3:integer 	#是否开启5倍奖励按钮,资源或金币,0:未开启 非0:开启 1:普通资源 10:金币
		rightbuttoncost 	4:integer   	#是否开启25倍奖励按钮,资源或金币,0:未开启 非0:开启 1:普通资源 20:金币	
		integral	 		5:integer   	#当前科技经验
		guildhonor 			6:integer    #联盟荣誉
		guildintegral 		7:integer    #联盟积分
		sciencestar 		8:integer    #科技星数
		result 				9:integer    #结果
	}
}

#联盟科技研究
researchScience 910 {
	request {
		scienceID  			0:integer
		sciencelv       		1:integer
	}
	response {
		researchTime 		0:integer
		result 				1:integer   
	}
}

#获取联盟详细信息
getGuildData 911 {
	request {
		guildID	 0:integer #公会ID 
	}
	response {
	    result 0:integer
	}
}

#联盟事件
.GuildEvent{
	time 	0:integer   #事件时间
	type 	1:integer 	#1加入联盟2退出联盟3放置建筑4开始研究5被掠夺6被占领   
	name 	2:string	#事件主角名字
	x 		3:integer	#主角X坐标
	y 		4:integer	#主角y坐标
	dname 	5:string	#敌人名字
	param   6:integer   #如联盟建筑id、联盟科技id、资源id
}

#获取联盟事件
getGuildEvent 912 {
	request {
		num	 0:integer #请求返回事件的个数
	}
	response {
	    result 0:*GuildEvent
	}	
}


#购买联盟商店物品
buyGuildShop 913 {
	request {
		itemID 		0:integer
		num 			1:integer
	}
	response {
		guildhonor 		0:integer
		result 			1:integer
	}
}

#添加联盟商店物品
buyGuildItem 914 {
	request {
		itemID 		0:integer
		num 			1:integer
	}
	response {
		guildintegral	0:integer
		result 			1:integer
	}
}

#清空联盟科技贡献冷却时间
clearContributeTime 915 {
	request {
		goldnum 		0:integer
	}
	response {
		result 		0:integer
	}
}

#贡献信息
.contributeInfo {
	playerID 		0:string	#玩家ID
	dayintegral 		1:integer	#每天贡献值
	weekintegral 	2:integer	#每周贡献值
	historyintegral 3:integer	#历史贡献值
	dayhonor 		4:integer	#每天荣誉值
	weekhonor 		5:integer	#每周荣誉值
	historyhonor 	6:integer	#历史荣誉值
}


#联盟贡献排行信息
getContributeData 916 {
	request {
	}
	response {
		contributeinfo 		0:*contributeInfo
	}
}

#查看申请信息
readGuildApplyInfo 947 {
	request {
		playerID	 0:string #玩家ID
	}
	response {
	    applyInfo  	 0:string
	}
}

#遣返援兵
helpArmyBack 948 {
	request {
		playerID	 0:string #玩家ID
	}
	response {
	    result  	 0:integer
	}
}

#援兵信息
.armyList {
	playerID 		0:string #援军玩家ID
	name 			1:string #玩家名字
	head_image 		2:string #玩家头像
	power 			3:integer #战斗力
	army 			4:string #armyType|armyNum,...
}
helpArmyInfo 949 {
	request {
		x	 0:integer #x坐标
		y	 1:integer #y坐标
	}
	response {
	    maxHelpArmyNum 0:integer #可援军数量
	    armyList 	   1:*armyList(playerID) #援军信息
	}
}

#请求帮助
requestHelp 950 {
	request {
		helpType	 0:integer #请求帮助类型
		helpValue	 1:integer #请求帮助事物
	}
	response {
	    result 0:integer
	}
}

#帮助列表
helpList 951 {
	request {
		
	}
	response {
	    result 0:integer
	}
}


#帮助玩家
helpGuildPlayer 952 {
	request {
		helpID 0:*string #帮助ID号
	}
	response {
	    result 0:integer
	}
}

#公会操作
guildOperation 953 {
	request {
		operation 		0:integer 	#哪种操作
		param			1:string 	#参数 	 比如:　玩家ID
	}
	response {
	    result 0:integer
	}
}

#公会邀请搜索
.playerSerchInfo {
	playerID 		0:string
	name 			1:string
	head_image 		2:string
	power 	 		3:integer
	language 		4:integer
	is_online		5:integer
}
guildInviteSerch 954 {
	request {
		name		0:string 	#模糊搜索关键字
		operation 	1:integer 	#1刷新2递增
	}
	response {
	    serchInfo  	0:*playerSerchInfo(playerID)
	    operation 	1:integer 	#1刷新2递增
	}
}

#申请/撤销入会
guildApply 955 {
	request {
		guildID		0:integer 	#公会ID
		applyInfo 	1:string 	#申请信息
	}
	response {
	    result 0:integer
	    guildID 1:integer
	}
}

#加入/拒绝入会
guildInviteReply 956 {
	request {
		guildID		0:integer 	#公会ID
		operation 	1:integer 	#0拒绝1加入
		mailID 		2:string 	#邮件ID
	}
	response {
	    result 0:integer
	}
}

#获取联盟成员列表
guildMemberList 957 {
	request {
		guildID	 0:integer #联盟ID
	}
	response {
		result 0:integer
	   	memberInfo  	1:*playerSerchInfo
	}	
}

.fortInfo{
	id					0:integer # 领地编号
	name				1:string # 领地名称
	buildstatus 		2:integer # 领地状态。0：未完成。1：未驻防。2：已驻防
	buildvalue 			3:integer # 建筑值
	x 					4:integer # 坐标
	y 					5:integer
	buildtime 			6:integer # 建筑结算时间
	buildspeed 			7:string # 建造/拆除速度
}

.guildResourceInfo{
	id 					0:integer # 资源类型，0农田，1木场，2矿场，3秘银
	name				1:string # 领地名称
	buildstatus 		2:integer # 资源状态。0：未完成。1：未驻防。2：已驻防
	buildvalue 			3:integer # 建筑值
	x 					4:integer # 坐标
	y 					5:integer
	buildtime 			6:integer # 建筑结算时间
	buildspeed 			7:string # 建造/采集速度
}

.guildArcherTower{
	id 					0:integer # 箭塔编号
	name				1:string # 领地名称
	buildstatus 		2:integer # 箭塔状态。0：未完成。1：未驻防。2：已驻防
	buildvalue 			3:integer # 建筑值
	x 					4:integer # 坐标X
	y 					5:integer
	buildtime 			6:integer # 建筑结算时间
	buildspeed 			7:string # 建造速度
}

.guildWarehouse{
	id 					0:integer
	name				1:string # 领地名称
	buildstatus 		2:integer # 仓库状态。0：未完成。1：未驻防。2：已驻防
	buildvalue 			3:integer # 建筑值
	x 					4:integer 
	y 					5:integer 
	buildtime 			6:integer # 建筑结算时间
	buildspeed 			7:string # 建造速度
}

# 联盟领地信息
guildTerritoryInfo 958 {
	request {
	}
	response {
		result			0:integer
		number 			1:integer # 当前联盟人数
		power 			2:integer # 当前联盟战斗力
		star 			3:integer # 当前联盟科技星数
		guildforts 		4:*fortInfo # 联盟堡垒信息
		guildresource 	5:guildResourceInfo # 联盟资源矿信息
		guildtower 		6:*guildArcherTower # 联盟箭塔信息
		guildwarehouse 	7:guildWarehouse # 联盟仓库
	}
}

#联盟屏蔽留言id表
.GuildDisMessage{  
	id 				2:string   #玩家id
	name 			0:string	#名字
	icon 			1:string 	#图标id
}

#获取屏蔽留言id表
getGuildDisMessage 959 {
	request {
		guildID  	  0:integer  #联盟ID
	}
	response {
	    result 0:*GuildDisMessage
	}	
}

#------------------------1001-1100 大地图
#地图上资源信息
.map_info{
	x 			0:integer    #坐标X
	y 			1:integer    #坐标Y
	ID 			2:integer    #资源ID
	value 			3:integer    #值
	playerID 		4:string	#玩家ID  以下字段主要针对玩家城堡
	name 			5:string	#玩家名字
	castle_lv 		6:integer #主城等级
	warGuard 		7:integer #战争守护值为未来到期时间
	counterReconn 		8:integer #反侦察，值为未来到期时间
	lv 			9:integer#玩家等级
	fireTime 	10:integer # 点火结束时间
	delayMove 			11:integer # 技能，遍地泥浆结束时间
	guildID 			12:integer # 联盟ID
	simpleName 			13:string # 联盟简称
	guildFlag 			14:integer # 联盟旗帜
	buildName			15:string # 联盟建筑名字
	status 				16:integer # 联盟建筑状态
	head_image 			17:string # 玩家头像ID
	buildtime 			18:integer # 联盟建筑结算时间点
	buildspeed 			19:string # 联盟建筑建造/拆除/采集速率
}

#请求地图周边资源情况
mapScope 1001 {
	request {
		x 		0:integer 	#中心点x y 
		y 		1:integer
		w 		3:integer	#宽度
		h 		4:integer	#长度
		serverid 	5:integer #服务器id
	}
	response {
		list 		0:*map_info 	#附近资源及玩家
	}
}

#玩家随机放置主城
mapSettleRandom 1002 {
	request {

	}
	response {
		result 		0:integer
		x 		1:integer
		y 		2:integer
	}
}


#玩家军队信息
.army{
	armyType 		0:integer
	armyNum 		1:integer
}

#玩家行动--初始行军，专指从自己城堡出发的行动
mapInitAction 1003 {
	request {
		purpose 	0:integer#目的
		x 		1:integer
		y 		2:integer
		armys 		3:*army #出征的军队
		index 		4:integer #额外参数，比如遗迹选择的时间索引(1,2,3,4)
	}
	response {
		result 		0:integer
	}
}

#玩家改变行动
mapChangeAction 1004 {
	request {
		change 		0:integer#改变类型
		index 		1:integer#改变的线路
	}
	response {
		result 		0:integer
	}
}

#玩家退出地图
mapPlayerExit 1005 {
	request {
	}
}

.collection{
	tag 		0:integer 	#标签类型
	kingdomxy	1:string		#国王-X-Y
	name 		2:string 		#保存名字
}

#收藏地点或者修改
mapCollection 1006 {
	request {
		op 		0:integer 	#操作选项 1增加　２修改　３删除
		tag 		1:integer 	#标签类型
		kingdomxy	2:string		#国王-X-Y
		name 		3:string 		#保存名字
	}
	response {
		result  		0:integer
	}
}

#请求收藏地点
mapGetCollection 1007 {
	request {
	}
	response {
		collections 		0:*collection(kingdomxy)
	}
}

#放置主城
mapSettleCity 1008 {
	request {
		x 			0:integer
		y 			1:integer
		userItem 	2:boolean #是否使用物品
	}
	response {
		result 		0:integer 
	}
}

#加速行军
mapSpeed 1009 {
	request {
		index  		0:integer #行军路线索引
		itemID 		1:integer #物品ID
	}
	response {
		result 		0:integer
	}
}

#请求别人向你行军信息
mapTowerMarch 1010 {
	request {
	}
}

#玩家战斗力
.ServerList{
	serverID		0:integer #服务器id
	kingdomName		1:string #国王
}

#世界地图
worldMap 1011 {
	request {
	}
	response {
		serverList 		0:*ServerList 
	}
}

#获取遗迹探险记录
mapRuinExplore 1012 {
	request {
		index 			0:integer	#队伍索引
	}
	response {
		result 			0:*string #结果 itemID|num，军队类型|损失数目
	}
}

#探索怪物
mapSearchMonster 1013 {
	request {
		x 			0:integer #当前中心坐标
		y 			1:integer
	}
	response {
		monsters 		0:*map_info
	}
}

#多少队出征
mapRouteNum 1014 {
	request {
	}
	response {
		num 			0:integer
	}
}

# 放置联盟建筑
mapSettleGuildBuild 1015 {
	request {
		x 		0:integer
		y 		1:integer
		id 		2:integer
		type	3:integer
	}
	response {
		result 		0:integer 
	}
}

# 主动销毁联盟建筑
mapDestoryGuildBuild 1016 {
	request {
		x 		0:integer
		y 		1:integer
	}
	response {
		result 		0:integer 
	}
}

# 集结
mapGuildRallyFight 1017 {
	request {
		x 					0:integer # 坐标
		y 					1:integer
		armys 				2:*army #出征的军队
		rallyType 			3:integer # 集结类型。1-5分钟；2-
	}
	response {
		result 				0:integer 
		rallyID 			1:integer
		maxPosition 		2:integer
		maxTroops 			3:integer
	}
}

# 解散集结
mapGuildRallyCancel 1018 {
	request {
		rallyID 			0:integer # 集结ID
	}
	response {
		result 				0:integer 
	}
}

# 普通攻击数据
.RouteObj{
	targetType  			0:integer # 攻击目标类型
	atkPlayerID 			1:string # 攻击方玩家ID
	atkPlayerName 			2:string # 攻击方玩家名称
	atkPlayerIcon 			3:string # 攻击方图标ID
	atkGuildID 				4:integer # 攻击方联盟ID
	atkSimpleName 			5:string # 攻击方联盟简称
	atkScreenX 				6:integer # 攻击方坐标
	atkScreenY 				7:integer
	defPlayerID 			8:string # 防守方玩家ID
	defPlayerName 			9:string # 防守方玩家名称
	defPlayerIcon 			10:string # 防守方玩家图标
	defGuildID 				11:integer # 防守方联盟ID
	defSimpleName 			12:string # 防守方联盟简称
	defScreenX 				13:integer 
	defScreenY 				14:integer
	startTime 				15:integer
	endTime 				16:integer
}

# 集结玩家行军信息
.RallyInfo{
	playerID 				0:string # 玩家ID
	playerName 				1:string # 玩家名称
	playerIcon 				2:string # 玩家图标
	route_index 			3:integer # 行军ID
	troopsNum 				4:integer # 玩家部队数量
	rallyStatus 			5:integer # 行军状态
	rallyStartTime 			6:integer # 行军开始时间
	rallyEndTime 			7:integer # 行军结束时间
	troopsInfo 				8:string # 军队信息
}
# 集结数据
.RallyObj{
	rallyID 				0:integer # 集结编号
	rallyType 				1:integer # 集结类别
	route_status 			2:integer # 集结状态
	nowPosition 			3:integer # 当前参与人数
	maxPosition 			4:integer # 最大参与人数
	nowTroops 				5:integer # 当前参与兵力
	maxTroops 				6:integer # 最大参与兵力
	atkPlayerID 			7:string # 集结发起人玩家ID
	atkPlayerName 			8:string # 发起人玩家名称
	atkGuildID 				9:integer # 发起人联盟ID
	atkSimpleName 			10:string # 发起人联盟简称
	atkScreenX 				11:integer # 发起人坐标
	atkScreenY 				12:integer
	defPlayerID 			13:string # 防守方玩家ID
	defPlayerName 			14:string # 防守方玩家名称/联盟堡垒名称
	defGuildID 				15:integer # 防守方联盟ID
	defSimpleName 			16:string # 简称
	defCitylv 				17:integer # 防守方城堡等级/联盟堡垒ID/怪物ID
	defScreenX 				18:integer # 防守方坐标
	defScreenY 				19:integer
	startTime 				20:integer # 集结行军开始时间
	endTime 				21:integer # 集结行军结束时间
	rallyStartTime 			22:integer # 集结出发时间
	rallyEndTime 			23:integer # 集结到达时间
	rallyInfos 				24:*RallyInfo # 集结队伍信息
	defInfos				25:*RallyInfo # 防守队伍信息
}

# 集结数据
.Routedata{
	recordID 				0:integer # 行军编号
	fightType 				1:integer # 行军类别。1:1v1战斗;3:集结战斗
	objectRoute 			2:RouteObj # 普通行军对象信息
	objectRally				3:RallyObj # 集结对象信息
}

.blackdata{
	recordID 				0:integer #
	fightType 				1:integer # 行军类别。5:黑暗骑士战斗;7:黑暗领主战斗
	objectRoute 			2:RouteObj
	objectRally				3:RallyObj # 集结对象信息
}

# 获取联盟战争数据
getGuildRallyInfo 1019 {
	request {
		fightType 			0:integer # 0-获取所有;1-普通战斗;5-活动战斗
		recordID 			1:integer # 最后一个记录ID
	}
	response {
		result 				0:integer 
		route_data 			1:*Routedata
		black_data 			2:*blackdata
	}
}

# 联盟战争记录
.GuildFightRecord{
	ID 						0:string # 战争记录编号
	fightType 				1:integer # 战争类型。1-普通攻击；3-集结攻击；5-黑骑士攻击
	atkPlayerID				2:string # 攻击方玩家ID
	atkPlayerName 			3:string # 攻击方玩家名称
	atkGuildID 				4:integer # 攻击方联盟ID
	atkSimpleName 			5:string # 攻击方联盟简称
	defPlayerID 			6:string # 防守方玩家ID
	defPlayerName 			7:string # 防守方玩家名称
	defGuildID 				8:integer # 防守方联盟ID
	defSimpleName 			9:string # 防守方联盟简称
	win 					10:integer # 胜利方。0-攻击方；1-防守方
	time_point 				11:integer # 战斗时间戳
}
# 获取战争记录
getGuildFightRecord 1020 {
	request {
		recordID 			0:integer # 记录编号，第一次获取发0
	}
	response {
		result 				0:integer 
		fightrecord 		1:*GuildFightRecord
	}
}

# 获取个人联盟仓库信息
getGuildWarehouseInfo 1021 {
	request {
	}
	response {
		result 				0:integer 
		sumStorage 			1:integer # 玩家总存储量，重量
		dayStorage 			2:integer # 今日存储量
		wood 				3:integer # 木材总存储值，数量
		food 				4:integer # 食物总存储值
		iron 				5:integer # 铁矿总存储值
		silver 				6:integer # 银总存储值
	}
}

# 玩家部队视图信息
.routeViewObj{
	playerID 				0:string # 玩家ID
	playerName 				1:string # 玩家名称
	playerIcon 				2:string # 玩家图标ID
	army 					3:string # 部队信息/被消灭部队信息
	resource_speed			4:string # 资源采集速度
	startTime 				5:integer # 开始时间
	endTime 				6:integer # 结束时间
}
# 玩家存储信息
.storageViewObj{
	playerID 				0:string # 玩家ID
	playerName 				1:string # 玩家名称
	playerIcon 				2:string # 玩家图标ID
	sumStorage 				3:integer # 存储总量
	wood 					4:integer # 木材存储量
	food 					5:integer
	iron 					6:integer
	silver 					7:integer
}

# 查看联盟建筑信息
guildBuildViewInfo 1022 {
	request {
		x 					0:integer
		y 					1:integer
	}
	response {
		result 				0:integer # 查看其它联盟返回失败
		guildID 			1:integer # 联盟ID
		simpleName 			2:string # 联盟简称
		buildName 			3:string # 建筑名称
		status 				4:integer # 建筑状态
		value 				5:integer # 建筑值/资源量/存储量
		nowRouteNum			6:integer # 当前驻防部队数量/建筑人数/存储人数/消灭敌人数
		maxRouteNum			7:integer # 最大驻防数量/建筑空位
		nowArmys 			8:integer # 当前兵力
		maxArmys 			9:integer # 总共可容纳兵力
		routeList 			10:*routeViewObj # 驻防/建筑/消灭部队信息
		storageList 		11:*storageViewObj # 存储信息
	}
}

#接受/拒绝迁移城市
guildMoveReply 1023 {
	request {
		mailID 		0:string 	#邮件ID
		result 		1:integer #0拒绝1接受
	}
	response {
	    result 0:integer
	}
}

#寻找附近可迁移城市
guildMovePosition 1024 {
	request {
		mailID 		0:string 	#邮件ID
	}
	response {
	    result 0:integer
	    x 1:integer
	    y 2:integer
	}
}

#多少队行军意图
mapPurposeNum 1025 {
	request {
		purpose 		0:integer
		x 				1:integer
		y 				2:integer
	}
	response {
		num 			0:integer
	}
}

# 玩家部队视图信息
.armyViewObj{
	playerID 				0:string # 玩家ID
	playerName 				1:string # 玩家名称
	playerIcon 				2:string # 玩家图标ID
	army 					3:string # 部队信息
}
# 获取地图集结部队信息
mapGetRallyInfo 1026 {
	request {
		rallyID 		0:integer
	}
	response {
		result 			0:integer
		routeList 		1:*armyViewObj # 集结部队信息
	}
}

#遣返联盟建筑部队
guildBuildRouteCallback 1027 {
	request {
		x 				0:integer # 坐标
		y 				1:integer
		playerID 		2:string # 玩家ID
	}
	response {
		result 			0:integer
	}
}

#探索最近距离的指定空闲资源
mapSearchResource 1028 {
	request {
		x 				0:integer #当前中心坐标
		y 				1:integer
		resourceType 	2:integer # 资源类型
	}
	response {
		resourceObj		0:map_info
	}
}

#------------------------1100-1110 新手引导
guideFinish 1101 {
	request {
		guideID 		0:integer #引导ID
		stage 			1:integer #已完成阶段
		finish 			2:integer #0未完成1完成
	}
	response {
		result 			0:integer #0失败1成功
	}
}
#------------------------1110-1200 商城
#买物品
mallBuyItem 1111 {
	request {
		itemID 		0:integer #物品id
		num 		1:integer #购买数量
	}
	response {
		result 			0:integer #0金币不足1成功2物品不存在3购买数量小于1
	}
}

#买金币
mallBuyGold 1112 {
	request {
		goldID 		0:integer #金币id
		num 		1:integer #购买数量
	}
	response {
		result 			0:integer #0支付失败1成功2物品不存在3购买数量小于一4限购
	}
}

#买礼包
mallBuyGift 1113 {
	request {
		giftID 		0:integer #礼包id
		stage 		1:integer #礼包阶段
		num 		2:integer #购买数量
	}
	response {
		result 			0:integer #0支付失败1成功2物品不存在3购买数量小于1
	}
}

#买月卡
mallBuyCard 1114 {
	response {
		result 			0:integer #0支付失败1成功
	}
}

#领取月卡奖励
cardGift 1115 {
	response {
		result 			0:integer #0领取月卡奖励失败1领取月卡成功
	}
}

#------------------------1200-1300 王座相关
#请求官职信息
.official {
	official 		0:integer #官职
	playerID 		1:string #玩家ID
	name 			2:string #玩家名字
	head_image 		3:string #玩家头像
	reTime 			4:string #重新任命时间
}
requestOfficial 1201 {
	request {
	}
	response {
		officials			0:*official #官职信息
	}
}

#设置官职
setOfficial 1202 {
	request {
		playerID 		0:string #取消官职为0
		official 		1:integer #官职
	}
	response {
		result			0:integer 
		official		1:official #官职信息
	}
}

#请求国王礼包信息
.kingGift {
	giftID 			0:integer #礼包id
	playerID 		1:string #玩家ID
	name 			2:string #玩家名字
	head_image 		3:string #玩家头像
	guildName 		4:string #公会简称
}
requestKingGift 1203 {
	request {
		operation 		0:integer #1数量2详细信息
	}
	response {
		num  				0:*integer #各类型礼包数量
		kingGifts			1:*kingGift #征服者礼包
	}
}

#分配国王礼包
distributeKingGift 1204 {
	request {
		playerID 		0:string #玩家ID
		giftType 		1:integer #礼包ID
	}
	response {
		result			0:integer
	}
}

]]

proto.s2c = sprotoparser.parse [[
.package {
	type 0 : integer
	session 1 : integer
}

#有重复登陆时，强制下线
kickoffline 1 {
	request {
			
	}
}


#玩家基本属性
.Player{
	playerID 		0:string
	account 		1:string
	head_image		2:string
	name 			3:string
	lv 			4:integer
	viplv 			5:integer
	gold 			6:integer
	dragonGold 			7:integer
	food 			8:integer
	wood 			9:integer
	iron 			10:integer
	silver 			11:integer
	steel 			12:integer
	exp 			13:integer
	copper 			14:integer
	worker 			15:integer #普通工人工作位置
	hireWorker 		16:integer #雇佣工人工作位置
	hireTime 		17:integer #雇佣工人工作未来的截止时间
	defenceCity 		18:integer #城防值
	defenceCDTime 		19:integer #下次可增加城防的时间
	fireTime		20:integer #火烧至未来的时间
	atkSuccessTimes	21:integer #进攻胜利次数
	atkFailTimes	22:integer #进攻失败次数
	defSuccessTimes	23:integer #防御胜利次数
	defFailTimes	24:integer #防御失败次数
	detectTimes		25:integer #侦查次数
	killArmyNum		26:integer #击杀部队数量
	beKillArmyNum	27:integer #部队损失数量
	cureArmyNum		28:integer #部队治疗数量
	x 			29:integer
	y 			30:integer
	tili 			31:integer #玩家体力
	pierFetchTime	32:integer #码头货物领取时间
	ship			33:integer #连登签到记录 个位0今日没签到1今日已签到 其他位连续签到次数
	totalSkillPoint 34:integer #玩家总技能点
	skillUsedPoint	35:integer #已使用技能点
	medal			36:integer #勋章
	power 			37:integer #总战斗力
	monster_lv 		38:integer#已打败的怪物的等级
	ifTurntable 	39:integer#幸运转盘or翻牌界面
	guildID			40:integer #公会ID
	language 		41:integer #语言
	fireStartTime 	42:integer # 点火结算时间
	emergencyTime 	43:integer # 急救帐篷到期时间
	kill_monster 	44:string  #击杀怪物{等级|数量,...}
	explore_time 	45:integer #遗迹探索时间
	guildhonor 		46:integer #联盟荣誉
	vipTime 		47:integer #vip时间
	cardTime		48:integer #月卡时间
	cardDraw		49:integer #是否领取月卡奖励0未领取1已领取
	inviteCode 		50:string #邀请码
	isgetGift 		51:integer #邀请好友时已领取阶段
	fireSpeed		52:integer # 着火速率
}

#玩家战斗力
.Power{
	lordPower		0:integer #领主战斗力
	armyPower		1:integer #部队战斗力
	buildPower		2:integer #建筑战斗力
	sciencePower	3:integer #科技战斗力
	trapPower		4:integer #陷阱战斗力
	equipPower		5:integer #装备战斗力
}

#军事
.Military{
	armyNum			0:integer #行军部队总数
	perArmyMaxLimit	1:integer #单支部队兵力上限增加
	perTrainNumAdd	2:integer #单次训练士兵数量增加
	trainArmySpeed	3:integer #训练士兵加速
	armyMoveSpeed	4:integer #部队行军加速
	warriorAtkAdd	5:integer #步兵攻击增加
	warriorDefAdd	6:integer #步兵防御增加
	warriorLifeAdd	7:integer #步兵生命增加
	warriorHarmReduce	8:integer #步兵受到伤害减少
	riderAtkAdd		9:integer #骑兵攻击增加
	riderDefAdd		10:integer #骑兵防御增加
	riderLifeAdd	11:integer #骑兵生命增加
	riderDamageAdd	12:integer #骑兵冲锋伤害增加
	archerAtkAdd	13:integer #弓兵攻击增加
	archerDefAdd	14:integer #弓兵防御增加
	archerLifeAdd	15:integer #弓兵生命增加
	archerDamageAdd	16:integer #弓兵伤害增加
	chariotsAtkAdd	17:integer #车兵攻击增加
	chariotsDefAdd	18:integer #车兵防御增加
	chariotsLifeAdd	19:integer #车兵生命增加
	chariotsDamageAdd	20:integer #车兵攻城战斗攻击力增加
}

#资源
.Resources{
	woodProduceAdd	0:integer #木材产量提高
	woodCollectAdd	1:integer #木材采集加速
	foodProduceAdd	2:integer #粮食产量提高
	foodCollectAdd	3:integer #粮食采集加速
	ironProduceAdd	4:integer #铁矿产量提高
	ironCollectAdd	5:integer #铁矿采集加速
	silverProduceAdd	6:integer #秘银产量提高
	silverCollectAdd	7:integer #秘银采集加速
	goldCollectAdd		8:integer #金币采集加速
	cellarMaxLimitAdd	9:integer #地窖上限提升
}

#城市发展
.CityGrow{
	buildingSpeedUp		0:integer #建筑建造加速
	scienceSpeedUp		1:integer #科技研究加速
	foodConsumeReduce	2:integer #口粮消耗降低
	armyWeightAdd		3:integer #部队负重提高
	emergencyCapacityAdd	4:integer #急救帐篷容量增加
	emergencyCureSpeedUp	5:integer #急救帐篷治疗加速
	cureCostReduce		6:integer #治疗费用降低
	AtkMonsterMoveSpeedUp	7:integer #攻击怪物行军加速
	tiliRecoverSpeedUp	8:integer #体力恢复加快
	firstaidArmy  9:integer #出征战斗中，损失的士兵一定比例转化为伤兵
}

#城防
.CityDefence{
	cityDefAdd				0:integer #城防值增加
	trapAtkAdd				1:integer #陷阱攻击增加
	trapBuildSpeedUp		2:integer #陷阱制造加速
	trapMaxLimitAdd			3:integer #陷阱上限增加
	warriorTrapDamageAdd	4:integer #陷阱克步兵伤害增加
	riderTrapDamageAdd		5:integer #陷阱克骑兵伤害增加
	archerTrapDamageAdd		6:integer #陷阱克弓兵伤害增加
	defenceArmyAtkAdd		7:integer #守军攻击增加
	defenceArmyDefAdd		8:integer #守军防御增加
}

#玩家扩展信息
.PlayerEx{
	playerID				0:string
	tasks 					1:string  #任务
	firstBind 				2:integer #首次绑定
	vipExp 					3:integer #vip经验
	landDay 				4:integer #连续登录天数
	recruitGift 			5:integer #新兵礼物 十位数可领取天数，个位数已领取天数
}

#玩家的其他加成属性
.PlayerRelated {
	towerAtkAdd 			0:integer  #箭塔的攻击提升
   	towerSpeedUp 			1:integer  #箭塔的攻速提升
   	perArmyMaxLimitPre 		2:integer  #单支部队兵力上限增加
	perTrainNumAddPre 		3:integer  #单次训练士兵数量增加百分比
	emergencyCapacityAddPre	4:integer  #急救帐篷容量增加百分比
	trapMaxLimitAddPre 		5:integer  #陷阱上限增加百分比
	trapLossReduce 			6:integer  #减少陷阱的损失
	rallyArmySpeedUp 		7:integer  #增加集结军队的行军速度
	marketArmySpeedUp    	8:integer  #增加交易商队的行军速度
	reinForceSpeedUp 		9:integer  #增加援军行军速度
	cellarMaxLimitAddPre 	10:integer #地窖上限提升百分比
}

#建筑物信息
.building{
	position 		0:integer 		#位置
	buildType 		1:integer		#建筑物类型
	lv 			2:integer		#建筑物等级
	completeTime 		3:integer		#建造完成时间
	effectTime 		4:integer 		#功能到期时间
	effectType 		5:integer		#功效类型 effectType -1为拆除
	effectValue 		6:integer		#功效数量
}

#玩家物品信息
.item{
	itemID 			0:integer
	num 			1:integer
}

#玩家军队信息
.army{
	armyType 		0:integer
	armyNum 		1:integer #在家人数
	woundedNum		2:integer#伤员人数
	treatNum		3:integer #治疗人数
	routeNum 		4:integer #出征人数
	totalNum 		5:integer #获得过人数
}

#城主增益信息
.citybuff{
	buffType		0:integer
	futureTime		1:integer #未来到期时间
	buffValue		2:integer #数值
	startTime 		3:integer #开始的时间　
}

#科研信息
.science{
	scienceID		 	0:integer
	lv    				1:integer
}

#成就信息
.achieve{
	requireID		 	0:integer
	requireType		 	1:integer
	requireNum    		2:integer
	fetchedAchieve		3:string #1,2,3,格式代表当前条件为第一条件的已领取成就
}

#装备信息
.equipment{
	equipmentID		 	0:string
	templateID    		1:integer
	position 			2:integer
}

#技能信息
.skill{
	skillID 				0:integer
	lv 					1:integer
}

#更新玩家基本信息
updatePlayer 2 {
	request {
		player          	0:Player  
		power				1:Power
		military 			2:Military
		resources 			3:Resources
		cityGrow 			4:CityGrow
		cityDefence 		5:CityDefence
		playerEx 			6:PlayerEx	
		playerRelated 		7:PlayerRelated	
	}
}

#更新玩家建筑物信息
updateBuild 3 {
	request {
		build        	0:*building(position)  		
	}
}

#更新玩家物品
updateItem 4 {
	request {
		items 		0:*item(itemID)
	}
}

#更新玩家军队信息
updateArmy 5 {
	request {
		armys 		0:*army(armyType)
	}
}

#更新玩家城市增益信息
updateCityBuff	6 {
	request {
		citybuff 	0:*citybuff(buffType)
	}
}

#科研信息
updateScience	7 {
	request {
		science		0:*science(scienceID)
	}
}

#成就信息
updateAchieve	8 {
	request {
		achieve		0:*achieve(requireID)
	}
}

#装备信息
updateEquipment	9 {
	request {
		equipment		0:*equipment(equipmentID)
		operation		1:integer #0删除1增加
	}
}


#行军信息
.route{
	playerID 		0:string			#玩家ID
	route_index		1:integer		#出征队伍索引
	x_from 			2:integer		#起始点X
	y_from 			3:integer		#起始点Y
	x_to 			4:integer		#终点X
	y_to			5:integer		#终点Y
	army 			6:string			#派出的军队
	purpose 		7:integer		#出征的意图   添加集结意图，黑骑士活动意图
	route_state		8:integer		#出征状态 1出发，2驻扎，3返回
	startTime		9:integer		#开始时间
	endTime		10:integer		#结束时间
	resource_value 		11:integer		#开始行动时的资源量
	speed_value 		12:string 		#加速值250 500
	resource_speed 		13:string 		# 当前采集资源速度/s
	total_weight 		14:integer 	# 部队负重
	target_guildID		15:integer 	# 攻击目标联盟ID
	tile_num 			16:integer 	# 攻击方与目标建筑所占格子
}
.map_info{
	playerID 		4:string	#玩家ID  以下字段主要针对玩家城堡
	name 			5:string	#玩家名字
	castle_lv 		6:integer #主城等级
	warGuard 		7:integer #战争守护值为未来到期时间
	counterReconn 		8:integer #反侦察，值为未来到期时间
	lv 			9:integer
}

#更新地图上玩家行军路线
updateRoute 10 {
	request {
		route 		0:*route
		player_info 	1:*map_info(playerID)
	}
}


#敌人行军信息
updateMarch 11 {
	request {
		warn 		0:integer #1警报　０取消警报
	}
}
 
#开宝箱
updateShowItem 12 {
	request {
		items 		0:*item(itemID)
	}
}


#敌人向你进发
.march{
	name 			0:string
	purpose 		1:integer		#行军目的
	x_from 			2:integer		#起始点X
	y_from 			3:integer		#起始点Y
	endTime		4:integer		#结束时间
	army_num 		5:integer 		#总兵力
	lv 			6:integer		#玩家等级
	army_type 		7:*integer		#哪些兵种
	army 			8:string			#派出的军队"type|num , type|num"
	science			9:*science(scienceID)
	startTime 		10:integer 		#行军开始时间　
	head_image 		11:string		#玩家头像 
	skill 			12:*skill(skillID) 		#技能
}

#行军详细信息
updateMarchIno 13 {
	request {
		march 		0:*march
	}
}

#更新其他玩家基本信息
updateOtherPlayer 14 {
	request {
		player          	0:Player  
		equipment			1:*equipment(equipmentID)	
		achieve				2:*achieve(requireID)
	}
}

#更新技能信息
updateSkill 15 {
	request {
		skill		0:*skill(skillID)
	}
}

# 奖励信息，战利品信息
.rewardInfo{
	itemID					0:integer # 物品ID
	number					1:integer # 物品数量
}

# 战斗状态信息
.fight_struct{
	title					0:string # 标题
	iconID					1:string # 形象ID
	screenX					2:integer # 坐标X
	screenY					3:integer # 坐标Y
	power					4:integer # 战斗力增益
	kills					5:integer # 击杀
	loss					6:integer # 损失
	wound					7:integer # 受伤
	survive					8:integer # 存活
	traploss				9:integer # 陷阱损失
	troopMax				10:integer # 征兵上限加成，千分比
	infantryInfo 			11:string # 步兵属性加成。攻击|防御|血量|减伤
	cavalryInfo 			12:string # 骑兵属性加成。攻击|防御|血量|伤害
	archerInfo				13:string # 弓兵属性加成。攻击|防御|血量|伤害
	chariotInfo 			14:string # 车兵属性加成。攻击|防御|血量|伤害
	trapInfo 				15:string # 陷阱属性加成。攻击|克步|克骑|克弓
}

# 战斗兵种信息
.fight_troop_info{
	id						0:integer # 兵种ID
	kill					1:integer # 击杀
	loss					2:integer # 损失
	wound					3:integer # 受伤
	survive					4:integer # 存活
}

# 战斗详情
.fight_info{
	title					0:string # 标题
	number					1:integer # 兵种数量
	troopInfo				2:*fight_troop_info # 部队信息
}

# 资源信息
.resource_info{
	id						0:integer # 资源ID
	own						1:integer # 拥有
}

# 兵种信息
.troop_info{
	id						0:integer # 兵种ID
	number					1:integer # 兵种数量
}

# 科技信息
.add_buff_info{
	id						0:integer # 科技/buff ID
	lv						1:integer # 等级
}

# 援军领主信息
.reinforce_info{
	name 					0:string # 援军领主名称
	iconID 					1:string # 形象ID
	lv 						2:integer # 援军领主等级
	reinforcementInfo		3:*troop_info # 援军信息
}

# 侦查信息
.fight_scout{
	scoutTarge				0:integer # 侦查状态，0：侦查别人；1：被侦查；2：侦查联盟堡垒；3：侦查失败
	title					1:string # 侦查目标，（公会名）玩家名
	iconID					2:string # 形象ID
	screenX					3:integer # 坐标X
	screenY					4:integer # 坐标Y
	resourceInfo			5:*resource_info # 资源信息
	defenceCity				6:integer # 城防值
	defenceCityMax			7:integer # 城防满值
	defenceTroopNum 		8:integer # 防守部队总数
	trapNum 				9:integer # 陷阱数量
	reinforcementNum 		10:integer # 援军数量
	defenceTroopInfo		11:*troop_info # 防守部队信息
	trapInfo				12:*troop_info # 陷阱信息
	reinforceName 			13:*reinforce_info # 援军领主信息
	archerTower1Lv			14:integer # 箭塔1等级
	archerTower2Lv			15:integer # 箭塔2等级
	technologyInfo			16:*add_buff_info # 科技增加属性信息
	abilityInfo				17:*add_buff_info # 领主能力信息
	skillInfo				18:*integer # 领主技能ID
}

# 公告类型邮件
.mail_notice{
	subjectType				0:integer # 公告类型
	rewardTitleID			1:integer # 奖励邮件标题
	rewardNum				2:integer # 物品数量
	rewards					3:*rewardInfo # 奖励信息
}

# 系统类型邮件
.mail_system{
	subjectType 			0:integer # 系统邮件类型
	rewardTitleID			1:integer # 奖励邮件标题
	rewardNum				2:integer # 物品数量
	rewards					3:*rewardInfo # 奖励信息
	parameter				4:string # 附加参数集合(1|"",2|"")
}

# 战斗报告类型邮件
.mail_fight{
	subjectType				0:integer # 战斗主题类型
	rewardNum				1:integer # 获得物品数量
	rewards 				2:*rewardInfo # 奖励信息
	liftStruct				3:fight_struct # 攻击方信息
	rightStruct				4:fight_struct # 防守方信息
	attackNum 				5:integer # 攻击方参战数量
	attackFightInfo			6:*fight_info # 攻击方战斗详情
	defendNum 				7:integer # 防守方参战数量
	defendFightInfo			8:*fight_info # 防守方战斗详情
	scoutStruct				9:fight_scout # 侦查信息
}

# 资源采集邮件
.mail_resource{
	subjectType				0:integer # 战斗结果。0：资源采集；1：市场交易
	resourceID				1:integer # 采集的资源ID
	resource 				2:string # 资源标题内容，当ID无效时。比如市场交易
	screenX					3:integer # 坐标X
	screenY					4:integer # 坐标Y
	rewardNum				5:integer # 获得物品数量
	rewards					6:*rewardInfo # 获得物品信息
}

# 怪物报告邮件
.mail_monster{
	subjectType				0:integer # 战斗结果。1：成功；2：失败；3：首杀
	monsterID				1:integer # 怪物ID
	screenX					2:integer # 坐标X
	screenY					3:integer # 坐标Y
	rewardNum				4:integer # 战利品数量
	rewards					5:*rewardInfo # 战利品信息
	power					6:integer # 战斗力增益
	troop					7:integer # 部队总数
	wound					8:integer # 受伤数量
	dead					9:integer # 死亡数量
}

# 城堡探险邮件
.mail_ruins{
	screenX					0:integer # 坐标X
	screenY					1:integer # 坐标Y
	time_point				2:integer # 时间戳，探索时间(秒数)
	rewardNum				3:integer # 战利品数量
	rewards					4:*rewardInfo # 战利品信息
	lossNum					5:integer # 部队损失种类
	losses					6:*troop_info # 部队损失信息
}

# 玩家聊天邮件
.mail_im{
	playerID			0:string # 对方玩家ID
	playerName			1:string # 对方玩家名字
	playerIcon			2:string # 对方玩家头像
	playerServerID		3:integer # 对方玩家服务器
	guildName 			4:string # 对方玩家公会
	imID				5:string # 聊天ID
	targetID			6:string # 己方玩家ID
	time_point			7:integer # 时间
	content				8:string # 内容
	isAll 				9:integer #是否群聊0否1是
}

# 活动类型邮件
.mail_event{
	eventID		 			0:integer # 活动ID
	rewardTitleID			1:integer # 奖励邮件标题
	rewardNum				2:integer # 物品数量
	rewards					3:*rewardInfo # 奖励信息
	parameter				4:string # 附加参数集合(1|"",2|"")
}

# 运营/工作室类型邮件
.mail_operation{
	rewardTitleID			1:integer # 奖励邮件标题
	rewardNum				2:integer # 物品数量
	rewards					3:*rewardInfo # 奖励信息
}

.mail{
	mailID					0:string # 邮件ID
	mailType				1:integer # 邮件类别；1-公告；2-系统；3-采集；4-战斗；5-怪物；6-城堡；7-玩家
	subjectID				2:integer # 邮件主题资源ID
	titleID					3:integer # 邮件标题资源ID，如果为0则读取内容
	title					4:string # 邮件标题内容
	senderID				5:string # 发信目标ID。0-无；1-系统；2-NPC；玩家ID>10
	senderName				6:string # 发信目标名称
	iconID					7:string # 发件人图标ID
	contentID				8:integer # 邮件内容资源ID
	explainID				9:integer # 邮件说明资源ID
	time_point				10:integer # 时间戳
	attach					11:integer # 是否有关联附件。0-没有；1-有 
	readstatus				12:integer # 标记是否已读。0-未读；1-已读
	receive					13:integer # 标记是否有物品未领取。0-无；1-未领取
	attach_notice			14:mail_notice # 公告 类型附件
	attach_system			15:mail_system # 系统 类型附件
	attach_resource			16:mail_resource # 采集/交易 类型附件
	attach_fight			17:mail_fight # 战斗类型附件
	attach_monster			18:mail_monster # 怪物类型附件
	attach_ruins 			19:mail_ruins # 城堡探险类型附件
	attach_im 				20:mail_im # 玩家聊天附件
	attach_event			21:mail_event # 活动类型邮件
	attach_operation		22:mail_operation # 运营/工作室类型邮件
}

#新邮件推送
mailNew 16 {
	request {
		mail 			1:mail   # 邮件信息
	}
}

# 国家聊天，接收聊天记录格式
.im_world_record{
	recordID			0:string # 时间戳作为记录ID，精确到毫秒
	playerID			1:string # 玩家ID
	playerName			2:string # 玩家名称
	playerIcon			3:string # 玩家图标
	playerVip			4:integer # 玩家激活的vip等级。为0则未激活
	guildID				5:integer # 联盟ID
	guildName			6:string # 玩家所在联盟名
	imtype				7:integer # 消息类型。0：文本；1：战报 2:语音 3:公会邀请
	imsign				8:integer # 消息标记，0：普通消息；1：系统消息；2：喇叭消息
	content 			9:string # 文本消息内容
	languagetype 		10:integer # 消息语言版本，0-英语；1-汉语
}

# 联盟聊天，接收格式
.im_guild_record{
	recordID			0:string # 时间戳作为记录ID，精确到毫秒
	playerID			1:string # 玩家ID
	playerName			2:string # 玩家名称
	playerIcon			3:string # 玩家图标
	playerVip			4:integer # 玩家激活的vip等级。为0则未激活
	imtype				5:integer # 消息类型。0：文本；1：战报
	imsign 				6:integer # 消息标记。0：普通消息；1：系统消息
	content				7:string # 消息内容。如果是战报，则为战报标题
	languagetype		9:integer # 消息语言版本，0-英语；1-汉语
}

# 个人聊天接收格式
.im_own_record{
	playerID			0:string # 玩家ID
	playerName			1:string # 玩家名称
	playerIcon			2:string # 玩家图标
	playerVip			3:integer # 玩家激活的vip等级。为0则未激活
	guildName			4:string # 玩家公会名
	recordID 			5:string # 时间戳，精确到毫秒
	imID 				6:string # 聊天ID
	content				7:string # 消息内容
	languagetype 		8:integer # 消息语言版本，0-英语；1-汉语
	isAll 				9:integer # 是否群聊0否1是
}

# 新消息推送
imInfoNew 17 {
	request {
		imtype 				0:integer # 获取记录的类型，0：国家；1：联盟；2：玩家
		worldRecords		1:im_world_record # 国家聊天记录信息
		guildRecords		2:im_guild_record # 联盟聊天记录信息
		ownRecords 			3:im_own_record # 个人聊天记录信息		
	}
}

#城堡位置发生改变
updateCityChange 18 {
	request {
		x_to 			0:integer #目标位置
		y_to 			1:integer
		x_from 			2:integer #可能为空新玩家进入
		y_from 			3:integer
		playerID 		4:string
		name 			5:string
		castle_lv 		6:integer
		warGuard 		7:integer #战争守护值为未来到期时间
		counterReconn 	8:integer #反侦察，值为未来到期时间
		lv 				9:integer#玩家等级
		fireTime 		10:integer # 点火结束时间
		delayMove 		11:integer # 技能，遍地泥浆结束时间
	}
}

#活动中心主界面
.eventlimt{
	begin	0:integer	#0未开启1进行中
	stage	1:integer	#活动处于第几阶段
	id 	2:integer	#当前阶段id
	stageall 	3:integer #限时活动总阶段	 	
}
updateEventcenter 19 {
	request {
		eventlimt  0:eventlimt #限时活动信息
		eventblack 1:integer #0未开启1进行中
			}
}

#简易公会信息
.guildSimple{
	guildID		 		0:integer #联盟ID
	guildName			1:string #联盟名字
	simpleName			2:string #联盟简称
	announce			3:string #联盟宣言
	ownerID				4:string #盟主id
	ownerName			5:string #盟主名字
	language 			6:integer #联盟语言
	guildFlag			7:integer #联盟旗帜
	guildPower			8:integer #联盟战力
	memberNum 			9:integer #联盟人数
	memberMaxNum 		10:integer #最大联盟人数
	openInvite			11:integer #公开招募
	guildIntegral		12:integer #联盟积分
}
.guildEx{
	guildID		 	0:integer #联盟ID
	class1				1:string #阶职1
	class2				2:string #阶职2
	class3				3:string #阶职3
	class4				4:string #阶职4
	class5				5:string #阶职5
	building_name1 		6:string #堡垒名称1
	building_name2 		7:string #堡垒名称2
	building_name3 		8:string #堡垒名称3
	building_name4 		9:string #堡垒名称4
	building_name5 		10:string #堡垒名称5
	simpleNameTimes 	11:integer #简称修改次数
	guildNotice 		12:string #联盟公告
}
.guildMember{
	guildID		 	0:integer #联盟ID
	playerID		1:string #玩家ID
	guildClass		2:integer #阶职
	guildhonor 		3:integer #玩家荣誉
	guildintegral 	4:integer #玩家积分
	playerName		5:string #玩家名字
	power 			6:integer #玩家战力
	head_image		7:string #玩家头像
	online			8:integer #是否在线 1是0否
	pos_x			9:integer #坐标X
	pos_y			10:integer #坐标Y
	lastLoginTime	11:integer #登录时间		
}

updateGuildSimple 20 {
	request {
		guild		0:*guildSimple(guildID)
		operation 	1:integer #操作类型 1自己2递增3刷新
	}
}

updateGuild 21 {
	request {
		guildSimple		0:guildSimple(guildID)
		guildEx			1:guildEx(guildID)
	}
}

.GuildHelp{
	helpID 			0:string #帮助ID
	playerName		1:string #玩家名字
	head_image		2:string #玩家头像
	helpType 		3:integer #帮助类型
	helpValue		4:integer #帮助事物 
	helpValueNum	5:integer #帮助事物数量
	helpNum			6:integer #帮助数量
	helpMaxNum		7:integer #帮助最大数量
	isHelp 			8:integer #是否帮助过
}
updateGuildHelp 22 {
	request {
		guildHelps		0:*GuildHelp
		operation 		1:integer #1寻求帮助推送2查看3被帮助推送4自己需要帮助列表
	}
}

updateGuildMember 23 {
	request {
		guildMembers		0:*guildMember
		operation 			1:integer #1更新
	}
}

#添加联盟物品信息的推送
updateGuildItem 26 {
	request {
		guilditems 		1:*item(itemID)
	}
}


#城堡信息改变
updateCityStatus 27 {
	request {
		x 				0:integer #目标位置
		y 				1:integer
		playerID 		2:string
		name 			3:string
		castle_lv 		4:integer
		warGuard 		5:integer #战争守护值为未来到期时间
		counterReconn 	6:integer #反侦察，值为未来到期时间
		lv 				7:integer#玩家等级
		fireTime 		8:integer # 点火结束时间
		delayMove 		9:integer # 技能，遍地泥浆结束时间
	}
}

updateGuildApply 28 {
	request {
		guildIDs		0:*integer
		operation 		1:integer #0删除1添加
	}
}

.map_terr_info{
	guildID 			0:integer # 联盟ID
	terrID 				1:integer # 联盟领地编号
	x 					2:integer # 坐标
	y					3:integer
	tileData 			4:string #领地信息。x,y,seat|x,y,seat。seat(位置，0中间1上2右3下4左)
}

#请求地图周边资源情况
mapTerritory 29 {
	request {
		terrlist 		0:*map_terr_info 	#附近领地信息
	}
}

#联盟科技信息
.guildscienceInfo {
	scienceID 		0:integer
	lv 				1:integer
	star 			2:integer
	researchTime 	3:integer
}

#联盟层级信息
.guildscience_struct {
	floorID 			0:integer
	scienceinfo 		1:*guildscienceInfo
}

#更新联盟科技
updateGuildScience 30 {
	request {
		totalstar 				0:integer
		guildscienceinfo 		1:*guildscience_struct#联盟科技层级信息结构
	}
}

#联盟建筑信息
.guildbuildinfo{
	x 					0:integer
	y 					1:integer
	buildName 			2:string
	number	 			3:integer # 建筑编号
	status 				4:integer
}
.guildfortinfo{
	x 					0:integer
	y 					1:integer
	buildName 			2:string
	number	 			3:integer # 建筑编号
	status 				4:integer
	tileData 			5:string #领地信息。x,y,seat|x,y,seat。seat(位置，0中间1上2右3下4左)
}


# 更新联盟建筑信息
updateGuildBuild 31 {
	request {
		guildfort 		0:*guildfortinfo # 堡垒，领地信息
		guildtower 		1:*guildbuildinfo # 箭塔信息
		guildresource 	2:*guildbuildinfo # 联盟资源田信息
		guildwarehouse 	3:*guildbuildinfo # 联盟仓库信息
	}
}

.shield{
	shieldID 		0:string
	shieldName 		1:string 
	power 			2:integer
	head_image 		3:string
	guildName 		4:string #联盟简称
}

# 屏蔽列表
updateShield 32 {
	request {
		shield 			0:*shield #屏蔽信息		
	}
}

# 主动发送邮件数量
sendMailInfo 33 {
	request {
		mailtypes			0:integer # 邮件类别数量
#		mailInfo 			1:*mail_struct # 邮件结构
	}
}

.map_guildbuild{
	x 					0:integer    #坐标X
	y 					1:integer    #坐标Y
	ID 					2:integer    #资源ID
	value 				3:integer    #值
	guildID 			4:integer # 联盟ID
	simpleName 			5:string # 联盟简称
	guildFlag 			6:integer # 联盟旗帜
	buildName			7:string # 联盟建筑名字
	status 				8:integer # 联盟建筑状态
	buildtime 			9:integer # 联盟建筑结算时间点
	buildspeed 			10:string # 联盟建筑建造/拆除/采集速率
}

.map_obj{
		status 			0:integer # 建筑状态。0-添加；1-更新；2-删除
		mapObj 			1:map_guildbuild #联盟建筑信息
		tileData 		2:string #领地信息。x,y,seat|x,y,seat。seat(位置，0中间1上2右3下4左)
}

# 更新大地图联盟资源信息
updateMapResource 34 {
	request {
		maplist 		0:*map_obj
	}
}

.unread{
	playerID 		0:string
	unread 			1:integer
}
# 未读消息
imInfoUnread 35 {
	request {
		unreads 			0:*unread #未读消息		
	}
}

.accounts{
	platformAccount 	0:string #平台帐号
	platformID 			1:integer #平台ID
	platformUserID 		2:string #平台用户ID
}
# 绑定帐号	
updateAccounts 36 {
	request {
		accounts 			0:*accounts #绑定帐号		
	}
}

# 联盟战争数量
updateGuildFightNum 37 {
	request {
		count 			0:integer #正在进行的战斗数量		
	}
}


# 帮助信息
updateHelp 38 {
	request {
		askplayerAccount 		0:string
	}
}

.guide{
	guideID 		0:integer #引导ID
	finish 			1:integer #引导是否完成0未完成1完成
	stage 			2:integer #引导已完成阶段	
}
# 新手引导
updateGuide 39 {
	request {
		guide 			0:*guide(guideID)	
	}
}

.mallGold{
	Gid 			0:integer #礼包id
	buy 			1:integer #0未购买1已购买	
}
# 商城金币礼包
updatemallGold 40 {
	request {
		gold 			0:*mallGold(Gid)	
	}
}

.mallGoldMod{
	ID 				0:integer #id
	type 			1:integer #类型0不限购1每日限购2终身限购
	number 			2:integer #金币数量	
	gold_add 		3:integer #额外金币
	price 			4:integer #价格
}
# 商城金币礼包模版表
updatemallGoldMod 41 {
	request {
		goldmod 			0:*mallGoldMod	
	}
}

.mallGift{
	Gid 		    0:integer #礼包id
	stage 			1:integer #阶段
	buy 			2:integer #0未购买1已购买
}
# 商城礼包
updatemallGift 42 {
	request {
		gift 			0:*mallGift(Gid)	
	}
}

.mallGiftMod{
	ID   			0:integer #流水ID
	giftid 		    1:integer #礼包id
	stage 			2:integer #阶段
	type 			3:integer #礼包类型
	hot 			4:integer #是否热卖	
	name 			5:string #礼包名称
	name1 			6:string #礼包名称1
	price_list 		7:string #原始价格
	price 			8:integer #价格
	datefrom 		9:string #礼包上架时间
	dateto 			10:string #礼包下架时间
	gold 			11:integer #礼包内金币数量
	item 			12:string #礼包物品
	item_desc 		13:string #物品描述
}
# 商城礼包模版表
updatemallGiftMod 43 {
	request {
		giftmod 	0:*mallGiftMod	
	}
}

# 公会解散
guildNew 44 {
	request {
		operation 			0:integer #1解散2踢出
	}
}

#更新帮助记录
updateHelpRecord 45 {
	request {
		result 				0:integer #1:有帮助
	}
}

#聊天记录
imUpdateInfo 46 {
	request {
		result 				0:integer # 如果失败，则没有联盟/玩家 的聊天记录
		num 				1:integer # 获取到的数量
		worldRecords		2:*im_world_record # 国家聊天记录信息
		guildRecords		3:*im_guild_record # 联盟聊天记录信息
		ownRecords 			4:*im_own_record # 个人聊天记录信息
	}
}

.GuildEvent{
	time 	0:integer   #事件时间
	type 	1:integer 	#1加入联盟2退出联盟3放置建筑4开始研究5被掠夺6被占领   
	name 	2:string	#事件主角名字
	x 		3:integer	#主角X坐标
	y 		4:integer	#主角y坐标
	dname 	5:string	#敌人名字
	param   6:integer   #如联盟建筑id、联盟科技id、资源id
}
#联盟事件推送
updateGuildEvent 47 {
	request {
		result 0:GuildEvent
	}	
}

#更新官职
updateOfficial 48 {
	request {
		official 				0:integer #官职0则取消
	}
}

#更新国王
updateKing 49 {
	request {
		playerID 				0:string #国王ID
		guildID 				1:integer #公会ID
		head_image 				2:string #头像
		name 					3:string #名字
		guildName 				4:string #公会简称
	}
}

.map_kinginfo{
	x 				0:integer
	y 				1:integer
	ID 				2:integer
	value 			3:integer
	status 			4:integer
	guildID 		5:integer
	simpleName		6:string
	name 			7:string
}

# 更新大地图基础资源信息
updateMapInfo 50 {
	request {
		list 		0:*map_kinginfo
	}
}

]]



return proto
