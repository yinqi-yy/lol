--
-- Author: Your Name
--
local GeneralHelper = class("GeneralHelper")

function GeneralHelper.create(...)
    local obj = GeneralHelper.new(...)
    return obj
end

function GeneralHelper:ctor(param)
	
end

-- 获取行军时间
function GeneralHelper:getMarchTime(targetPos, targetBuildingType, purpose, armySpeed)
	-- 没有部队时 参数armySpeed设置为1 
	local obj = require("modules.WorldMap.MapShare").create({})
	local time1 = obj:getMarchTime(targetPos, targetBuildingType, purpose, armySpeed)
	obj = nil
	return time1 
end

-- 获取行军时间
function GeneralHelper:getMarchTime2(startPos, startBuildingType, targetPos, targetBuildingType, purpose, armySpeed)
	-- 没有部队时 参数armySpeed设置为1 
	local obj = require("modules.WorldMap.MapShare").create({})
	local time1 = obj:getMarchTime2(startPos, startBuildingType, targetPos, targetBuildingType, purpose, armySpeed)
	obj = nil
	return time1 
end

-- 进入大地图
function GeneralHelper:enterBigMap(country, x, y, isShowTilePop)
	local tab = {}
	tab.country = country
	tab.x = x
	tab.y = y
	if isShowTilePop then
		tab.oType = 1
	else
		tab.oType = 3
	end
	GameEvent:notifyView(GameEvent.mainSceneSwitch, tab)
end

-- 进入大地图 跳转到指定路线
function GeneralHelper:enterBigMapToLine(country, x, y, routeInfo)
	local isLoadMap = true
	if util.isOpenBigMap() then
		isLoadMap = false
	end
	local tab = {}
	tab.country = country
	tab.x = x
	tab.y = y
	tab.oType = 5
	tab.otherInfo = {route=routeInfo, isLoadMap=isLoadMap}
	GameEvent:notifyView(GameEvent.mainSceneSwitch, tab)
end

-- 放置
function GeneralHelper:palce(id, type, pos)
	if not pos then
		pos = PlayerData:getPlayerXY()
	end
	local towerTab = {}
	if TemplateData:isTower(id) then
		local towerArr = PlayerData:getGuildTower()
		if towerArr then
			for k,v in pairs(towerArr) do
				table.insert(towerTab, cc.p(v.x,v.y))
			end		
		end
	end	
	
	local tab = {}
	tab.country = 1
	tab.x = pos.x
	tab.y = pos.y
	tab.oType = 2
	tab.otherInfo = {buildingType=id, serialNumber=type, towerAreaArr=towerTab}
	GameEvent:notifyView(GameEvent.mainSceneSwitch, tab)
end

-- 拆除
function GeneralHelper:dismantle(paramObj)
	self.testObj = paramObj
	local sureDestory = function()
		local tab1 = {text=Language.get("10187"), func=function()
			GameTCP:sendRPC("mapDestoryGuildBuild",{x=paramObj.x, y=paramObj.y}, self, self.dismantleCallback)
		end}
		local tab2 = {text=Language.get("10188"), func=function() end}
		
		local str = ""
		if TemplateData:isFortress(paramObj.buildingType) then -- 是否是堡垒
			str = string.formatIndex(Language.get("43377"), paramObj.buildName, paramObj.buildName)
		else
			str = string.formatIndex(Language.get("43376"), paramObj.buildName, paramObj.buildName)
		end
		Alert.messageBox5(str, tab1, tab2)	
	end

	local tab1 = {text=Language.get("10187"), func=function() sureDestory() end}
	local tab2 = {text=Language.get("10188"), func=function() end}
	local str = string.formatIndex(Language.get("43375"), paramObj.buildName)
	Alert.messageBox5(str, tab1, tab2)
end

-- 拆除回包
function GeneralHelper:dismantleCallback(packet)
	trace("--------拆除操作回包-------")
	traceObj(packet)	
	if packet.result == 1 then
		util.popWin()
	end	
end

-- 行军加速
function GeneralHelper:marchSpeedUp(routeIndex, speedTypeId)
	GameTCP:sendRPC("mapSpeed",{index=routeIndex, itemID=speedTypeId},self,self.speedUpCallback)
end

-- 行军加速回包
function GeneralHelper:speedUpCallback(packet,sendData)
	if packet.result == 1 then
		local itemID = sendData.itemID
        PlayerData:useItemCount(itemID)
        GameEvent:notifyView(GameEvent.updateArmySpeed,itemID)
		GameEvent:notifyView(GameEvent.allianceDeclareSpeed, itemID)
	end
end

-- 邀请迁城
function GeneralHelper:inviteMoveCity(x,y, mailId)
	local tab = {}
	tab.country = 1
	tab.x = x
	tab.y = y
	tab.oType = 4
	tab.otherInfo = {mailId=mailId}
	GameEvent:notifyView(GameEvent.mainSceneSwitch, tab)
end

return GeneralHelper