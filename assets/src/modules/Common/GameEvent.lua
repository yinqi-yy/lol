--
-- Author: Your Name
-- Date: 2015-07-13 14:16:38
--
local GameEvent = class("GameEvent")

function GameEvent.create()
	return GameEvent.new()
end

function GameEvent:ctor()
	EventProtocol.extend(self)
	self.newState = {}
end


function GameEvent:notifyView( name ,data,isNew)
	if isNew then 
		self:setState(name)
	end
	self:dispatchEvent({name=name,data=data})
end

--读取状态
function GameEvent:readState( name )
	self.newState[name] = nil
	self:notifyView(name, nil, false)
end

--获取状态
function GameEvent:getState( name )
	return self.newState[name] and self.newState[name] == true
end

--设置状态
function GameEvent:setState( name )
	self.newState[name] = true
end

--界面消息传递事件
GameEvent.addBuild = "addBuild"
GameEvent.removeBuild = "removeBuild"
GameEvent.mainMenuEvent = "mainMenuEvent"
GameEvent.jumpMap ="jumpMap"
GameEvent.jumpMapCenter ="jumpMapCenter"
GameEvent.jumpBack ="jumpBack"
GameEvent.moveBuild = "moveBuild"
GameEvent.endMoveBuild = "endMoveBuild"
GameEvent.jumpMapNearly ="jumpMapNearly"
GameEvent.cityScale ="cityScale"
GameEvent.changeName ="changeName"
GameEvent.gotoBigMap ="gotoBigMap"
GameEvent.gotoMapPos ="gotoMapPos"
--点击小地图
GameEvent.miniMapClick = "miniMapClick"
--玩家界面装备刷新
GameEvent.updatePlayerEquip = "updatePlayerEquip"
--主界面显示雇佣工人剩余时间
GameEvent.showHireTimes = "showHireTimes"

--更新当前在建造建筑的列表
GameEvent.updateBuildList = "updateBuildList"

--更新界面
GameEvent.updateStudy = "updateStudy"
GameEvent.StudyOver = "StudyOver"
GameEvent.StudyBegin = "StudyBegin"

GameEvent.AllianceApplyResult = "AllianceApplyResult"
GameEvent.AllianceMemberChange = "AllianceMemberChange"

GameEvent.updateScienceView = "updateScienceView"

--更新玩家形象
GameEvent.updatePlayerHeadImg = "updatePlayerHeadImg"

--指向任务
GameEvent.updateTaskToMenu = "updateTaskToMenu"
GameEvent.updateQuest = "updateQuest"

--服务器更新事件
GameEvent.updateBuild ="updateBuild"
GameEvent.updateItems ="updateItems"
GameEvent.updatePlayerInfo = "updatePlayerInfo"
GameEvent.updateArmy = "updateArmy"
GameEvent.updateCityBuff = "updateCityBuff"
GameEvent.updateMarchLine = "updateMarchLine"
GameEvent.updateEquipment = "updateEquipment"
GameEvent.updateArmySpeed = "updateArmySpeed"
GameEvent.closeArmyPopView = "closeArmyPopView"
GameEvent.closeCallBackArmyFrame = "closeCallBackArmyFrame"
GameEvent.closeSwitchCountryView = "closeSwitchCountryView"
GameEvent.cityLocationChange = "cityLocationChange"
GameEvent.updateMarchIno = "updateMarchIno"
GameEvent.openWarProtect = "openWarProtect"
--邮件数据消息
GameEvent.UpdateMailCount = "UpdateMailCount"
GameEvent.updateMailUi = "updateMailUi"
GameEvent.UpdateMailGive = "UpdateMailGive"

GameEvent.updateSkillPoint = "updateSkillPoint"
GameEvent.promoteArmyLimit = "promoteArmyLimit" 
GameEvent.moveWarProtect = "moveWarProtect" 
GameEvent.updateEventcenter = "updateEventcenter"
GameEvent.closeSceneTransition = "closeSceneTransition" 
GameEvent.mainSceneSwitch = "mainSceneSwitch" 
GameEvent.enterCastle = "enterCastle" 
GameEvent.enterBigMap = "enterBigMap" 
GameEvent.searchMap = "searchMap" 
GameEvent.updateBurning = "updateBurning" 
GameEvent.updateCityStatus = "updateCityStatus" 
GameEvent.updateGuildHelpList = "updateGuildHelpList"
GameEvent.updateCompleteTasks = "updateCompleteTasks" 
GameEvent.updateBuildUpdateItem = "updateBuildUpdateItem" 
GameEvent.updatePlayerGuildInfo = "updatePlayerGuildInfo" 
GameEvent.mapTerritory = "mapTerritory"
GameEvent.addChatRecord = "addChatRecord"
GameEvent.newTrumpetRecord = "newTrumpetRecord"
GameEvent.imUpdateInfo = "imUpdateInfo"
GameEvent.allianceBuildChange = "allianceBuildChange"
GameEvent.updateShieldList = "updateShieldList"
GameEvent.updateAllianceNum = "updateAllianceNum"
GameEvent.updateAllianceTotalNum = "updateAllianceTotalNum"
GameEvent.taskHintShow = "taskHintShow"
GameEvent.allianceDeclareSpeed = "allianceDeclareSpeed"

-- 更新王座
GameEvent.updateThoneGuise = "updateThoneGuise"
GameEvent.updateThoneShow = "updateThoneShow"

--更新联盟信息
GameEvent.updateGuildBase = "updateGuildBase"
GameEvent.updateMailReceiveStatus = "updateMailReceiveStatus"
GameEvent.updateGuildNoteModify = "updateGuildNoteModify"
GameEvent.notifyGuildEventList = "notifyGuildEventList"
GameEvent.notifyMailShare = "notifyMailShare"

GameEvent.updateTreatBuild = "updateTreatBuild"
GameEvent.updateBindAccounts = "updateBindAccounts"
GameEvent.updateVipView = "updateVipView"
GameEvent.updateFacebookFriend = "updateFacebookFriend"
GameEvent.updateHelp = "updateHelp"
GameEvent.updateHelpRecord = "updateHelpRecord"

--跟新商城信息
GameEvent.updateMallGold = "updateMallGold"

GameEvent.guideEvents2 = "guideEvents2"

GameEvent.updateGuildItems ="updateGuildItems"

--更新官职信息
GameEvent.updataStepAppoint = "updataStepAppoint"

return GameEvent