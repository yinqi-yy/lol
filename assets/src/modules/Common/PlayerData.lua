--
-- Author: Your Name
-- Date: 2015-07-13 14:01:06
--
local PlayerData = class("PlayerData")

function PlayerData.create()
    local data = PlayerData.new()
    return data
end

function PlayerData:ctor()
    self:initData()
end

-------------------------------------------几个默认数值--------------------------------------
--默认训练最大值（无 行军帐篷 时）
function PlayerData:getDefaultTrainMax()
    return 500
end

--默认出兵最大值（无 校场 时）
function PlayerData:getDefaultExpeditionMax()
    return 500
end

 -------------------------------------------几个计算公式--------------------------------------
function PlayerData:foodToGold( food )
    if food == nil or food <= 0 then
        return 0
    end

    local value = math.floor( 0.0158 * food ^ 0.8508 )
    if value <= 0 then
        value = 1
    end

    return value
end

function PlayerData:woodToGold( wood )
    if wood == nil or wood <= 0 then
        return 0
    end

    local value = math.floor( 0.0158 * wood ^ 0.8508 )
    if value <= 0 then
        value = 1
    end

    return value
end

function PlayerData:ironToGold( iron )
    if iron == nil or iron <= 0 then
        return 0
    end

    local value = math.floor( 0.0948 * iron ^ 0.8508 )
    if value <= 0 then
        value = 1
    end

    return value
end

function PlayerData:silverToGold( silver )
    if silver == nil or silver <= 0 then
        return 0
    end

    local value = math.floor( 0.3792 * silver ^ 0.8508 )
    if value <= 0 then
        value = 1
    end
    
    return value
end

--快速训练兑换成金币
--@tbl：tbl = { trainSumTime(训练总时间), 
--                      lackFood(缺少的粮食量), lackWood(缺少的木头量), lackIron(缺少的银矿量), lackSilver(缺少的秘银量) 
--                      }
function PlayerData:quickTrainToGold( tbl )
    if tbl == nil then
        return 0
    end

    --dump( tbl )

    local data = nil
    local value = 0

    data = tbl.trainSumTime
    if data ~= nil then
        value = value + self:timeToGold( data )
    end

    data = tbl.lackFood
    if data ~= nil then
        value = value + self:foodToGold( data )
    end

    data = tbl.lackWood
    if data ~= nil then
        value = value + self:woodToGold( data )
    end
    
    data = tbl.lackIron
    if data ~= nil then
        value = value + self:ironToGold( data )
    end

    data = tbl.lackSilver
    if data ~= nil then
        value = value + self:silverToGold( data )
    end

    return value
end

--时间转金币
function PlayerData:timeToGold( time )
    if time == nil or time == 0 then
        return 0
    end
    local gold = math.floor( time / 24 )
    if gold <= 0 then
        gold = 1
    end
    return gold
end

function PlayerData:speedToGold( buildType, buildLvl )
    if buildType == nil or buildLvl == nil then
        return nil
    end

    if buildType == Enum.type.logging then  --伐木场
        return buildLvl * 2
    elseif buildType == Enum.type.farmland then  --农田
        return buildLvl * 2
    elseif buildType == Enum.type.ironore then  --铁矿场
        return buildLvl * 3
    elseif buildType == Enum.type.mystrile then  --秘银矿
        return buildLvl * 4
    end

    return nil
end

function PlayerData:initData()
    self.player = { }
    self.builds = { }
    self.army = { }
    self.items = { }
    self.citybuff = { }

    self.power = { }
    self.military = { }
    self.resources = { }
    self.cityGrow = { }
    self.cityDefence = { }
    self.playerEx = { }

    self.eventlimt = {}

    --邮件
	self.allMaillist = {}

    self.achieve = {}

    --初始化码头
    self:updateDock(0)
    -- self.

    --产出时间
    self.resTime =os.time()
    self.equipment = {}
	
	-- 我的行军路线
	self.myRouteLineData = {}


    self.marchInfo = {}
    self._guidHelp = {}
    -- 引导任务
    self.quests = {}
    self.GuildItems = {}
    --玩家联盟信息
    self.playerGuildInfo = {}
    self.playerRelated = {}

    self.newTrumpetRecord = {}
    self.chatRecord = {}
    self.chatUnread = {}
    self.newChat = {}

    --商城金币礼包
    self.mallGold = {}
    self.mallGoldMod = {}
    self.mallGift = {}
    self.mallGiftMod = {}

    --宝藏帮助
    self.helps = ""
    self.helpRecord = 0
    ----------------------------------------用户XML本地数据-------------------------------------
    --用户选择的 游戏语言
    self.GameLanguageID = nil

    --语言翻译可用性
    self.translateEnabled = {}
    self:initTranslateEnabled() --初始化数据
    
    --音效可用性
    self.soundEffectEnabled = nil
    self:initSoundEffectEnabled() --初始化数据

    --音乐可用性
    self.soundMusicEnabled = nil
    self:initSoundMusicEnabled() --初始化数据

    --任务智能提示
    self.taskHintShowEnabled = nil
    self:initTaskHintShowEnabled() --初始化数据

    --通知栏信息（不存XML由 self.NoticeMessageType 推导）
    self.NoticeMessageEnabled = {}

    --通知栏信息类型
    self.NoticeMessageTypeEnabled = {}
    self:initNoticeMessageTypeEnabled()  --初始化数据

    self.otherPlayerData = {}
	
	--标志位 用于区分服务端发下来的是更新数据,还是首次下发的数据
	self.science_first = true
	--联盟信息
	self.alliance = {}
	self.alliance.baseInfo = {}
	self.alliance.memberList = {}
	self.alliance.guildEx = {}
	self.alliance.applyList = {}

	--联盟科技信息
    self.guildScienceData = {}
	-- trace("-------------初始化联盟数据----------------------")
    self.shieldList = {}--屏蔽列表
	
	self.allianceNumList = {}

    --账号绑定信息
    self.bindAccounts = {}
	self.guide = {}
	
	---------------------初始化 王座-------------
	self.throneData = {}
	
	self.guideflag = true
	self.eventList = {}
end

-- 添加服务器更新
function PlayerData:addEvents()
    GameTCP:addDataHandler("updatePlayer", self, self.updatePlayer)
    GameTCP:addDataHandler("updateBuild", self, self.updateBuilds)

    GameTCP:addDataHandler("updateItem", self, self.updateItem)
    GameTCP:addDataHandler("updateArmy", self, self.updateArmy)

    GameTCP:addDataHandler("updateCityBuff", self, self.updateCityBuff)
    GameTCP:addDataHandler("updateAchieve", self, self.updateAchieve)
    GameTCP:addDataHandler("updateEquipment", self, self.updateEquipment)
    GameTCP:addDataHandler("updateRoute", self, self.updateRoute)
    -- GameTCP:addDataHandler("updatePlayer", self, self.updatePlayer)
    -- GameTCP:addDataHandler("updateBuild", self, self.updateBuild)
	GameTCP:addDataHandler("updateScience", self, self.updateScience)
    GameTCP:addDataHandler("updateOtherPlayer", self, self.updateOtherPlayer)
    GameTCP:addDataHandler("updateMarchIno", self, self.updateMarchIno)
    GameTCP:addDataHandler("updateCityChange", self, self.updateCityChange)
    GameTCP:addDataHandler("updateEventcenter", self, self.updateEventcenter)
    GameTCP:addDataHandler("updateCityStatus", self, self.updateCityStatus)
    GameTCP:addDataHandler("mailNew", self, self.AddMail)
    GameTCP:addDataHandler("imInfoUnread", self, self.updateChatUnRead)
    GameTCP:addDataHandler("imInfoNew", self, self.imInfoNew)
    GameTCP:addDataHandler("imUpdateInfo", self, self.imUpdateInfo)
    GameTCP:addDataHandler("updateGuildHelp", self, self.updateGuildHelp)
    GameTCP:addDataHandler("updateShield", self, self.updateShield)
    GameTCP:addDataHandler("updateProduction", self, self.updateProductionConsume)
	
	
	-- 有重复登陆时，强制下线
	GameTCP:addDataHandler("kickoffline", self, self.kickoffline)	
	
	GameTCP:addEventListener(SocketTCP.EVENT_CONNECTED,self,self.onServerState)
    GameTCP:addEventListener(SocketTCP.EVENT_CLOSED,self,self.onServerState)
    GameTCP:addEventListener(SocketTCP.EVENT_CONNECT_FAILURE,self,self.onServerState)
	
	GameTCP:addDataHandler("updateGuildSimple", self, self.updateGuildInfo)
	GameTCP:addDataHandler("updateGuildMember", self, self.updateGuildMember)
	GameTCP:addDataHandler("updateGuild", self, self.updateGuild)
	GameTCP:addDataHandler("updateGuildApply", self, self.updateGuildApply)
	GameTCP:addDataHandler("updateGuildEvent", self, self.updateGuildEvent)
	
    GameTCP:addDataHandler("updateGuildItem", self, self.updateGuildItem)

    --获取联盟科技列表(因为别处也要用到数据,所以不能打开联盟科技页后再获取)
    GameTCP:addDataHandler("updateGuildScience", self, self.onGuildScienceList)
	
	GameTCP:addDataHandler("mapTerritory", self, self.mapTerritory)
	
	GameTCP:addDataHandler("updateGuildBuild", self, self.updateGuildBuild)
	
	GameTCP:addDataHandler("updateMapResource", self, self.allianceBuildChange)
	
	GameTCP:addDataHandler("updateGuildFightNum", self, self.updateGuildFightNum)
	GameTCP:addDataHandler("updateAccounts", self, self.onUpdateBindAccounts)

    GameTCP:addDataHandler("updatemallGold", self, self.updateMallGold)
    GameTCP:addDataHandler("updatemallGoldMod", self, self.updatemallGoldMod)
    GameTCP:addDataHandler("updatemallGift", self, self.updatemallGift)
    GameTCP:addDataHandler("updatemallGiftMod", self, self.updatemallGiftMod)
    
    GameTCP:addDataHandler("updateHelp", self, self.updateHelp)
    GameTCP:addDataHandler("updateHelpRecord", self, self.updateHelpRecord)
    
	GameTCP:addDataHandler("updateGuide", self, self.updateGuide)
	GameEvent:addEventListener(GameEvent.updateMailReceiveStatus,self,self.updateMailReceiveStatus)
	GameEvent:addEventListener(GameEvent.jumpMapNearly,self,self.jumpMapNearly)
	--更新公会成员数据
	GameTCP:addDataHandler("guildNew", self, self.updateGuildMemberData)
	
	GameTCP:addDataHandler("updateKing", self, self.updateKing)
	GameTCP:addDataHandler("updateMapInfo", self, self.updateMapInfo)
end
---------------------接收服务器更新包-----------------
function PlayerData:updatePlayer(result)
    if result then
        --util.merge(self.player, result.player)

        --数据会单独刷新
        if result.player then
            util.merge(self.player, result.player)
			if 0 ~= result.player.guildID and nil ~= result.player.guildID then
				self:resetApplyList()
			end

            if result.player[Enum.settingKey.selLanguage] then
                self:initLanguage(result.player[Enum.settingKey.selLanguage])
            end
        end
        
        if result.power then
            util.merge(self.power, result.power)
        end

        if result.military then
            util.merge(self.military, result.military)
        end

        if result.resources then
            util.merge(self.resources, result.resources)
        end

        if result.cityGrow then
            util.merge(self.cityGrow, result.cityGrow)
        end

        if result.cityDefence then
            util.merge(self.cityDefence, result.cityDefence)
        end

        if result.playerEx then
            util.merge(self.playerEx, result.playerEx)
        end

        --util.merge(self.playerAllData, result)
        if result.playerRelated then
            util.merge(self.playerRelated, result.playerRelated)
        end

        --码头信息
        if result.player and result.player.pierFetchTime then 
            self:updateDock(result.player.pierFetchTime)
        end


        GameEvent:notifyView(GameEvent.updatePlayerInfo)
    end
end

function PlayerData:initLanguage(id)
    if self.hasInitLan then
        return
    end

    self.hasInitLan = true

    Language.loadLanguageById( id )
end
---------------------城墙防御----------------------
--多少秒扣一点防
function PlayerData:getFireSpeed()
    return self.player.fireSpeed or Enum.INT_LOSE_DEF_TIME
end

--火焰熄灭时间
function PlayerData:getFireTime()
    return self.player.fireTime or 0
end

--联盟ID
function PlayerData:getAllianceID()
    return self.player.guildID or 0
end

--初始化联盟ID
function PlayerData:setAllianceID(ID)
    self.player.guildID = ID
	
	self.alliance = {}
	self.alliance.baseInfo = {}
	self.alliance.memberList = {}
	self.alliance.guildEx = {}
	self.alliance.applyList = {}

    --退盟时清空数据
    if ID == 0 then
        self:clearGuildScienceData()
    end
end

-- 是否有联盟
function PlayerData:isHasAlliance()
	if self.player.guildID and self.player.guildID > 0 then
		return true
	else
		return false
	end
end

-- 是否是自己的联盟
function PlayerData:isMyAlliance(id)
	if self.player.guildID == tonumber(id) then
		return true
	else
		return false
	end
end
-----------------------------------------联盟战争
-- 更新联盟战争数量
function PlayerData:updateGuildFightNum(result)
	self:updateGuildNum(1,result.count)
end

function PlayerData:updateGuildNum(index,num)
	local count = 0
	self.allianceNumList[index] = num
	for k,v in pairs(self.allianceNumList) do
		count = count + v
	end
	local tab = {}
	tab.index = index
	tab.num = num
	GameEvent:notifyView(GameEvent.updateAllianceNum, tab)
	GameEvent:notifyView(GameEvent.updateAllianceTotalNum)
end

-- 
function PlayerData:getGuildNumByIndex(index)
	return self.allianceNumList[index] or 0
end

function PlayerData:getGuildTotalNum()
	local count = 0
	for k,v in pairs(self.allianceNumList) do
		count = count + v
	end

    count = count
	return count
end

-----------------------------------------联盟领地
function PlayerData:mapTerritory(result)
	-- trace("------------------联盟领地回包")

	GameEvent:notifyView(GameEvent.mapTerritory, result)
end

function PlayerData:allianceBuildChange(result)
	GameEvent:notifyView(GameEvent.allianceBuildChange, result)
end

function PlayerData:updateGuildBuild(result)
	trace("------------联盟建筑信息")
	traceObj(result)
	self.fortressArea = {}
	if result then
		self.guildfort = result.guildfort or {}
		self.guildtower = result.guildtower or {}
		self.guildresource = result.guildresource or {}
 		self.guildwarehouse = result.guildwarehouse or {}
		for k,v in pairs(self.guildfort) do
			if v.status == Enum.Alliance_building_state_garrison or
			   v.status == Enum.Alliance_building_state_no_garrison then
				local tempTab = string.split(v.tileData, "|")
				for k,v in pairs(tempTab) do
					local tab = string.split(v, ",")
					local x = tonumber(tab[1])
					local y = tonumber(tab[2])
					local index = x+(y*1201)+1
					self.fortressArea[index] = true
				end
			end
		end
	end
end

function PlayerData:updateFortressArea(info)
	local boolVal
	if info.status == Enum.Alliance_building_state_garrison or info.status == Enum.Alliance_building_state_no_garrison then
		boolVal = true
	else
		boolVal = false
	end
	local fortressArea = self.fortressArea
	local fortressData = self.guildfort
	local tileData
	if string.len(info.tileData) > 0 then
		tileData = info.tileData
	else
		for k,v in pairs(fortressData) do
			if v.x == info.x and v.y == info.y then
				tileData = v.tileData
				v.status = info.status
				break
			end
		end	
	end
	local tempTab = string.split(tileData, "|")
	for k1,v1 in pairs(tempTab) do
		local tab = string.split(v1, ",")
		local x = tonumber(tab[1])
		local y = tonumber(tab[2])
		local index = x+(y*1201)+1
		fortressArea[index] = boolVal
	end	
end

function PlayerData:isForstressArea(index)
	return self.fortressArea[index]
end

function PlayerData:getGuildFort()
	return self.guildfort or {}
end

function PlayerData:getGuildTower()
	return self.guildtower or {}
end

function PlayerData:getGuildResource()
	return self.guildresource or {}
end

function PlayerData:getGuildWarehouse()
	return self.guildresource or {}
end

--是否处于着火状态
function PlayerData:getIsInFire()
    local fireTime = self:getFireTime()
    local now = self:getServerTime()
    return  fireTime > now
end


--获取实时防御值
function PlayerData:getDefance()
    --注意，self.player.defenceCity不是实时的，需要根据updateDefanceTime计算更新时间之后燃烧掉的防御值
    local defenceCity = self.player.defenceCity or 0
    --获取燃烧扣掉的
    if self.player.fireTime and self.player.fireStartTime then
        local timePass = math.min( self:getServerTime(),self.player.fireTime) - self.player.fireStartTime
        if timePass>0 then
            defenceCity = defenceCity - math.floor( timePass/self:getFireSpeed()) * Enum.INT_LOSE_DEF
        end
    end
    if defenceCity<0 then
        defenceCity = 0
    end
    return math.min(defenceCity,self:getMaxDefence())
end

--获取总防御值

--该等级城墙的总城防
function PlayerData:getDefalutDefence()
    local buildType = Enum.type.wall
    local buildLvl = self:getBuildByType(buildType) and self:getBuildByType(buildType).lv or 1
    local buildinfo  = TemplateData:getBuildWithTypeLvl( buildType, buildLvl )
    local def = buildinfo and buildinfo.de or 0
    return def
end

--加上学院加成
function PlayerData:getMaxDefence()
    return self.cityDefence and self.cityDefence.cityDefAdd or 0
end



--是否满防御
function PlayerData:isDefenceFull()
    return self:getDefance() >= self:getMaxDefence()
end

--是否满防御,着火状态改变
function PlayerData:isWallStateChange()
    self._wallState = self._wallState or {}
    if self._wallState._isDefFull == nil then
        self._wallState._isDefFull = self:isDefenceFull()
    end

    if self._wallState._isFire == nil then
        self._wallState._isFire = self:getIsInFire()
    end

    local bRes = (self._wallState._isDefFull ~= self:isDefenceFull()) or (self._wallState._isFire ~= self:getIsInFire())
    self._wallState._isDefFull = self:isDefenceFull()
    self._wallState._isFire = self:getIsInFire()
    return bRes
end


--下次加防时间
function PlayerData:setDefanceCD(defenceCDTime)
    self.player.defenceCDTime = defenceCDTime
end

function PlayerData:getDefanceCD()
    return self.player.defenceCDTime
end


--学院增加后的陷阱值
function PlayerData:getMaxTrap()
    return self.cityDefence and self.cityDefence.trapMaxLimitAdd or 0
end
-----------------------------------------------------


-- 更新建筑物信息
function PlayerData:updateBuilds(result)
    if result.build then
        for k, v in pairs(result.build) do
            if self.builds[v.position] == nil then
                self.builds[v.position] = v
            else
                util.merge(self.builds[v.position], v)
            end
        end
        GameEvent:notifyView(GameEvent.updateBuild, result.build)      
    end
end


function PlayerData:updateItem(result)
    --dump(self.items)
    if result.items then
        for k, v in pairs(result.items) do
            if self.items[v.itemID] == nil then
                self.items[v.itemID] = v
            else
                util.merge(self.items[v.itemID], v)
            end
        end
        GameEvent:notifyView(GameEvent.updateItems, result.items)
    end
    --dump(result)
end

function PlayerData:updateArmy(result)
    if result.armys then
        for k, v in pairs(result.armys) do
            if self.army[v.armyType] == nil then
                self.army[v.armyType] = v
            else
                util.merge(self.army[v.armyType], v)
            end
        end
        GameEvent:notifyView(GameEvent.updateArmy, result.armys)
        -- dump( self.army )
    end
end

--添加兵
function PlayerData:addArmy(armsID, armsAddCout)
    if self.army == nil then
        self.army = { }
    end

    local oneArms = self.army[armsID]
    if oneArms == nil then
        local data = { }
        data.armyType = armsID
        data.armyNum = armsAddCout
        data.woundedNum = 0
        data.treatNum = 0
        data.routeNum = 0
        data.totalNum = armsAddCout
        self.army[armsID] = data
    else
        oneArms.armyNum = oneArms.armyNum + armsAddCout
        if armsAddCout > 0 then
            oneArms.totalNum = oneArms.totalNum + armsAddCout
        end
    end
    GameEvent:notifyView(GameEvent.updateQuest)
end

--设置 出征 的兵的人数
function PlayerData:addRouteArmy(armsID, routeCout)
    if self.army == nil then
        printLog( "PlayerData:setRouteArmy", "数据未初始化" )
    end

    local oneArms = self.army[armsID]
    if oneArms == nil then
        printLog( "PlayerData:setRouteArmy", "该兵不在军队中" )
    else
        if routeCout == nil then
            routeCout = 0
        end
        if oneArms.armyNum < routeCout or routeCout < 0 then
            printLog( "PlayerData:setRouteArmy", "人数越界：%d，%d", oneArms.armyNum, routeCout )
        end
        oneArms.routeNum = oneArms.routeNum + routeCout
        oneArms.armyNum = oneArms.armyNum - routeCout
    end
end

function PlayerData:updateEquipment(result)
    if result.equipment then
        for k, v in pairs(result.equipment) do
            if self.equipment[v.equipmentID] == nil then
                self.equipment[v.equipmentID] = v
            else
                util.merge(self.equipment[v.equipmentID], v)
            end
        end
        GameEvent:notifyView(GameEvent.updateEquipment, result.equipment)
    end
end

function PlayerData:getArms(armsID)
    if self.army == nil then
        return nil
    end

    return self.army[armsID]
end

-- 得到 军队/陷阱
-- @param：type：1 = 军队， 2 = 陷阱
-- @return：nil or table
function PlayerData:getArmyOrTrap(type)
    if self.army == nil or type == nil then
        return
    end

    if type ~= 1 and type ~= 2 then
        return nil
    end

    -- 军队、陷阱的分界线
    local sel = 2120

    local data = { }
    for k, v in pairs(self.army) do
        if k and v then
            local isNeed = false
            if type == 1 then
                isNeed = tonumber(v.armyType) < sel
            elseif type == 2 then
                isNeed = tonumber(v.armyType) >= sel
            end
            if isNeed == true then
                data[#data + 1] = v
            end
        end
    end

    return data
end

-- 得到 军队/陷阱 人数总个数
-- @param：type：1 = 军队， 2 = 陷阱
-- @return：int
function PlayerData:getArmyOrTrapSum(type)
    if self.army == nil or type == nil then
        return 0
    end

    if type ~= 1 and type ~= 2 then
        return 0
    end

    local data = self:getArmyOrTrap(type)
    if data == nil or #data == 0 then
        return 0
    end

    local sum = 0
    for i, v in ipairs( data ) do
        if i and v then
            sum = sum + v.armyNum + v.routeNum
        end
    end

    return sum
end

-- 得到 所有急救帐篷等级 和人数
-- @return：nil or table
function PlayerData:getAllEmergencyLvl()
    if self.builds == nil then
        return nil
    end
    
    local tData = {}
    --医疗总人数
    local emergencyVolume = 0
    for k, v in pairs( self.builds ) do
        if k and v then
            if v.buildType == Enum.type.emergency then
                tData[#tData + 1] = v.lv
                emergencyVolume = emergencyVolume+TemplateData:getEmergencyVolume(v.lv)
            end
        end
    end

    return tData, emergencyVolume
end

-- 得到 所有急救帐篷增加的人数
-- @return：nil or table
function PlayerData:getEmergencyAdd()
    if self.builds == nil then
        return nil
    end
    
    --医疗总人数
    local emergencyVolume = 0
    for k, v in pairs( self.builds ) do
        if k and v then
            if v.buildType == Enum.type.emergency then
                emergencyVolume = emergencyVolume+TemplateData:getEmergencyVolume(v.lv)
            end
        end
    end
    local addNum = self.cityGrow["emergencyCapacityAdd"] - emergencyVolume
    return addNum
end

-- 得到 所有急救帐篷转化率
-- @return：nil or table
function PlayerData:getEmergencyAddRate()
    if self.builds == nil then
        return nil
    end
    
    local emergencyVolume = 0
    for k, v in pairs( self.builds ) do
        if k and v then
            if v.buildType == Enum.type.emergency then
                emergencyVolume = emergencyVolume+TemplateData:getEmergencyRate(v.lv)
            end
        end
    end
    return emergencyVolume
end

-- 得到 所有行军帐篷等级
-- @return：nil or table
function PlayerData:getAllMarchLvl()
    if self.builds == nil then
        return nil
    end
    
    local tData = {}
    for k, v in pairs( self.builds ) do
        if k and v then
            if v.buildType == Enum.type.march then
                tData[#tData + 1] = v.lv              
            end
        end
    end

    if #tData == 0 then
        return nil
    end

    return tData
end

--得到部队总量
-- @return：num
function PlayerData:getMarchVolume()
    local allMarchLvl = self:getAllMarchLvl()
    if allMarchLvl == nil then
        return 0
    end
    local num = 0
    for i, v in ipairs( allMarchLvl) do
         num = num + TemplateData:getMarchVolume( v )
    end

    return num
end
            
--得到 单支部队 出征最大值
function PlayerData:getExpeditionVolume()
    local assemblyPlace = nil

    for k, v in pairs( self.builds ) do
        if k and v then
            if v.buildType == Enum.type.assemblyPlace then
                assemblyPlace = v
                break
            end
        end
    end

    if assemblyPlace == nil then
        return self:getDefaultExpeditionMax()
    else
        local lvl = assemblyPlace.lv
        return TemplateData:getExpeditionVolume( lvl )
    end
 end

function PlayerData:updateCityBuff(result)
    local result = result.citybuff
    local now = self:getServerTime()
    if result then
        for k, v in pairs(result) do
            if self.citybuff[v.buffType] == nil then
                self.citybuff[v.buffType] = v
            else
                util.merge(self.citybuff[v.buffType], v)
            end
			
			if v.buffType == 14 or v.buffType == 19 then
				GameEvent:notifyView(GameEvent.promoteArmyLimit)
			end
        end
        GameEvent:notifyView(GameEvent.updateCityBuff)
    end
end

-- 添加城市BUFF
function PlayerData:addCityBuff(itemID)
    local item = TemplateData:getItem(itemID)
    if item and item.type and item.param1 and item.param2 then
        local buffType = item.type
        local startTime = ServerTimeModule:getServerTime()
        local futureTime = startTime + item.param1
        local value = item.param2
        local data = {
            citybuff =
            {
                [buffType] =
                {
                    buffType = buffType,
                    startTime = startTime,
                    futureTime = futureTime,
                    buffValue = value
                }
            }
        }



        self:updateCityBuff(data)
    end
end
--获取某个增益的信息
function PlayerData:getCityBuffInfo(type)
    return self.citybuff[type]
end

function PlayerData:setCityBuffInfo(type)
	if self.citybuff[type] then
		self.citybuff[type] = nil
	end
end

--获取是否有某个增益
function PlayerData:hasCityBuff(type)
    local buffInfo = self:getCityBuffInfo(type)
    return buffInfo and buffInfo.futureTime and buffInfo.futureTime > self:getServerTime()
end

function PlayerData:addSkillBuff( type, continueTime, value )
    local startTime = ServerTimeModule:getServerTime()
    local futureTime = startTime + continueTime
    local data = {
            citybuff =
            {
                [type] =
                {
                    buffType = type,
                    startTime = startTime,
                    futureTime = futureTime,
                    buffValue = value
                }
            }
        }

    self:updateCityBuff(data)
end

---------------------------------------科技加成-------------------------------

function PlayerData:updateScience(result)
	---do return end
	if(self.science_first == true) then
		if(result.science == nil) then
			result.science = {}
		end
	
		self.science = {}
		
		local staticScience = TemplateData:getScience()
		for k,obj in pairs(staticScience) do
			local t = {}
			t.scienceID = obj.ID
			t.lv = 0
			self.science[obj.ID]=t
		end
		for k2,obj2 in pairs(result.science) do
			self.science[k2].lv=obj2.lv
		end
	else
		for k2,obj2 in pairs(result.science) do
			self.science[k2].lv=obj2.lv
		end
		
		GameEvent:notifyView(GameEvent.StudyOver)
	end
		
	if(self.science_first) then
		self.science_first = false
	end
end

--建筑详情的绿字加成值
--buildType 建筑类型,detailsui为属性关键字,详见表buildingfield
function PlayerData:getScienceandBuffAdd(buildType,detailsui)
    --add 数值,Enum.addType.null 不显示加成,Enum.addType.add表示add为额外加多少数值,Enum.addType.max表示add为总数值
    local value = {add = 0, type = Enum.addType.null}
    if buildType == Enum.type.logging then--伐木场
        value.add =  self:getResources().woodProduceAdd
        value.type =  Enum.addType.mult
    elseif buildType == Enum.type.farmland then--农田
        value.add =  self:getResources().foodProduceAdd
        value.type =  Enum.addType.mult
    elseif buildType == Enum.type.ironore then--铁矿
        value.add =  self:getResources().ironProduceAdd
        value.type =  Enum.addType.mult
    elseif buildType == Enum.type.mystrile then--秘银
        value.add =  self:getResources().silverProduceAdd
        value.type =  Enum.addType.mult
    elseif buildType == Enum.type.cellar then--地窖
        value.add =  self:getResources().cellarMaxLimitAdd
        value.type =  Enum.addType.add
    elseif buildType == Enum.type.assemblyPlace then--校场
        value.add =  self:getMilitary().perArmyMaxLimit
        value.type =  Enum.addType.max
    elseif buildType == Enum.type.wall then--城墙
        if detailsui == "de"  then--城防
            value.add =  self:getMaxDefence()
        elseif detailsui == "trap" then--陷阱
            value.add =  self:getMaxTrap()
        end
        value.type =  Enum.addType.max
    elseif buildType == Enum.type.emergency then
        if detailsui == "atkwoundrate"  then-- 转换率
            --local types, add = self:getScienceBuff(Enum.firstaidArmy)
            --value.add = add
            --value.type = Enum.addType.mult
        elseif detailsui == "wound" then--上限
            --value.add =  self:getEmergencyAdd()
            --value.type =  Enum.addType.add
        end
	elseif buildType == Enum.type.warhall then -- 战争大厅
        value.add = self:getGuildScienceValue(250300) -- 从联盟科技获取扩充队伍值
        value.type = Enum.addType.add
    elseif buildType == Enum.type.embassy then
        if "help" == detailsui then
            value.add = self:getGuildScienceValue(252600)--大使馆帮助次数
        elseif "cut" == detailsui then
            value.add =  self:getHelpReduceTimeScience()--大使馆帮助减少时间
        elseif "man" == detailsui then
            value.add =  self:getGuildScienceValue(252500)--增加援军数量上限
        end
        value.type =  Enum.addType.add
    elseif buildType == Enum.type.market then
        if "bear" == detailsui then--
            value.add = self:getGuildScienceValue(252300)--商队负重
            value.type =  Enum.addType.add
        end
    elseif buildType == Enum.type.arrowTower then
        if detailsui == "dps" then
            value.add = self:getTowerAtkAdd()
        elseif detailsui == "dpm" then
            value.add = self:getTowerSpeedUp()
        end
        value.type = Enum.addType.mult
    end
    return value
end

-- 玩家的其他加成属性
function PlayerData:getPlayerRelated()
    return self.playerRelated
end

--箭塔攻击提升
function PlayerData:getTowerAtkAdd()
    return self.playerRelated.towerAtkAdd
end

--箭塔攻速提升
function PlayerData:getTowerSpeedUp()
    return self.playerRelated.towerSpeedUp
end
---------------------- 引导任务 -----------------------
function PlayerData:getPlayerEx(  )
    return self.playerEx
end

function PlayerData:getQuest()
    local quests={}
    for k,v in string.gmatch(self.playerEx.tasks,"[^,]+") do
        table.insert(quests,tonumber(k))
    end
    return quests
end

-- 计算任务完成值
function PlayerData:getValueByQuestID( questid )
    local questInfo = TemplateData:getQuestInfo(questid)
    local typ = questInfo.require
    local buildTyp = questInfo.target
    local value = 0
    if typ == Enum.questType.build then             -- 1 建造建筑
        for k,v in pairs(self.builds) do
            local limitLv = tonumber(questInfo.value2)
            if v.buildType == buildTyp and v.lv >= limitLv then
                value = value + 1
            end
        end
    elseif typ == Enum.questType.upgradeBuild then  -- 2 升级建筑
        for k,v in pairs(self.builds) do
            if v.buildType == buildTyp and v.lv >= value then
                value = v.lv
            end
        end
    elseif typ == Enum.questType.totalGet then      -- 3 累计获得 - 根据关联建筑决定获得内容
        for k,v in pairs(self.achieve) do
            if v.requireID == 2 then
                value = v.requireNum
            end
        end
    elseif typ == Enum.questType.targetTo then      -- 4 产量到达 - 根据关联建筑决定产量内容
        if buildTyp == 5 then
            value = self:getWoodPor()
        elseif buildTyp == 6 then
            value = self:getfoodPor()
        elseif buildTyp == 7 then
            value = self:getironPor()
        elseif buildTyp == 8 then
            value = self:getsilverPor()
        end
    elseif typ == Enum.questType.lordUpgrade then   -- 5 领主升级
        value = self.player.lv
    elseif typ == Enum.questType.attack then        -- 6 成功进攻
        value = self:getAtkSuccessTimes()
    elseif typ == Enum.questType.defend then        -- 7 成功防御
        value = self:getDefSuccessTimes()
    elseif typ == Enum.questType.killMonster then   -- 8 杀怪
        local killMonster = util.split(self:getKillMonster()) 
        if questInfo.value2 == 0 then
            for k,v in pairs(killMonster) do
                value = value + v[2]
            end
        else
            for k,v in pairs(killMonster) do
                if v[1] == questInfo.value2 then
                    value = v[2]
                end
            end
        end
    elseif typ == Enum.questType.killPlayer then    -- 9 杀人
        value = self:getKillArmyNum()
    elseif typ == Enum.questType.cure then          -- 10 伤兵治疗
        value = self:getCureArmyNum()
    elseif typ == Enum.questType.explore then       -- 11 遗迹探险时间 /s
        value = PlayerData:getExploreTime(  )
    elseif typ == Enum.questType.plunder then       -- 12 累计掠夺 - 统计总共掠夺资源数量
        for k,v in pairs(self.achieve) do
            if v.requireID == 15 then
                value = v.requireNum
            end
        end
    elseif typ == Enum.questType.totalArmy then       -- 13 累计造兵 - 根据对应建筑决定兵种数量
        local armsType = questInfo.value2
        value = self.army[armsType] and self.army[armsType].totalNum or 0
    end

    return value
end

-------------------数据获取----------------------------

function PlayerData:getScience()
	return self.science
end

--获取科技加成的数值 --返回加成类型和数值, 1百分比,2实际值
function PlayerData:getScienceBuff(Id)
	local lv = self.science[Id].lv
	local staticScience = TemplateData:getScience()
	local currInfo = staticScience[Id]
	local value = 0
	if(currInfo.show == 1) then
		value = currInfo.add* lv
	elseif(currInfo.show == 2) then
		--增加百分比 实际增长
		value = currInfo.add * lv
	end
	return currInfo.show ,value
end

function PlayerData:getWorker1()
    return self.player.worker or 0
end

function PlayerData:getWorker2()
    return self.player.hireWorker or 0
end

function PlayerData:getCopper()
    return self.player.copper
end

function PlayerData:getDragonGold()
    return self.player.dragonGold
end

function PlayerData:getBuilds()
    return self.builds
end

function PlayerData:getPlayer()
    return self.player
end

function PlayerData:getPower()
    return self.power
end

function PlayerData:getMilitary()
    return self.military
end

-- 获取部队行军速度加成
function PlayerData:getArmyMoveSpeed()
    local num
    if self.military and self.military.armyMoveSpeed then
        num = self.military.armyMoveSpeed/100/100
    else
        num = 0
    end
    return num
end

-- 获取单支部队兵力上限增加
function PlayerData:getPerArmyMaxLimit()
    local num
    if self.military and self.military.perArmyMaxLimit then
        num = self.military.perArmyMaxLimit
    else
        num = 0
    end
    return num
end

function PlayerData:getResources()
    return self.resources
end

function PlayerData:getCityGrow()
    return self.cityGrow
end

-- 获取部队负重加成
function PlayerData:getArmyWeightAdd()
    local num
    if self.cityGrow and self.cityGrow.armyWeightAdd then
        num = self.cityGrow.armyWeightAdd/10000
    else
        num = 0
    end
    return num
end

-- 获取攻击怪物行军加速
function PlayerData:getAtkMonsterMoveSpeedUp()
	traceObj(self.cityGrow)
	local num
	if self.cityGrow.AtkMonsterMoveSpeedUp and self.cityGrow.AtkMonsterMoveSpeedUp then
		num = self.cityGrow.AtkMonsterMoveSpeedUp/10000
    else
        num = 0
    end	
	return num
end

function PlayerData:getCityDefence()
    return self.cityDefence
end

function PlayerData:getArmy()
    return self.army
end

function PlayerData:settArmy(data)
    self.army = data
end

function PlayerData:getCityBuff()
    return self.citybuff
end
function PlayerData:getItems()
    return self.items
end

function PlayerData:GetMail()
    return self.allMaillist
end

function PlayerData:GetMailCounts(mailType)
	local counts = 0
	if self.allMaillist[mailType] then
		counts = table.getn(self.allMaillist[mailType].mails)
	else
		
	end
	return counts
end

function PlayerData:GetMailByType(mailType)
	local mails = nil
	if self.allMaillist[mailType] then
		mails = self.allMaillist[mailType]
	else
		trace("mailType =" .. mailType .. "该类型邮件不存在")
	end
	return mails
end

function PlayerData:GetMailObjByType(mailType)
	local mails = {}
	if self.allMaillist[mailType] then
		--mails = self.allMaillist[mailType]
		if self.allMaillist[mailType].mails then
			mails = self.allMaillist[mailType].mails
		else
			trace("mailType =" .. mailType .. "该类型邮件内容不存在")
		end
	else
		trace("mailType =" .. mailType .. "该类型邮件不存在")
	end
	return mails
end

function PlayerData:getEquips()
    return self.equipment
end

-- 获取体力
function PlayerData:getTiLi()
	return self.player.tili or 0
end

--得到 城堡 等级
function PlayerData:getCastleLvl()
    local builds = self.builds
    for i, v in ipairs( builds ) do
        if i and v then
            if v.buildType  == Enum.type.castle then
                return v.lv
            end
        end
    end
    printLog( "PlayerData:getCastleLvl", "城堡找不到？" )
end

--得到 城堡 等级
function PlayerData:getBuildTypeNum(nType)
	local num = 0
    local builds = self.builds
    for i, v in pairs( builds ) do
        if i and v then
            if v.buildType  ==  nType then
				if v.lv >= 1 then
					num = num + 1
				end
            end
        end
    end
    return num
end

-- 获取部队集结上限
function PlayerData:getArmyMassLimit()
	local lv = self:getwarhall()
	local tab = self:getScienceandBuffAdd(Enum.type.warhall)
	local num = 0
	if lv > 0 then
		local tempInfo = TemplateData:getBuildWithTypeLvl( Enum.type.warhall, lv )
		num = tempInfo and tempInfo.set or 0
	end
	num = num + tab.add
	return num
end

-- 获取集结空位
function PlayerData:getMassVacancy()
	local tab = PlayerData:getScienceandBuffAdd(Enum.type.warhall)
	local val = 3+tab.add
	return val
end

-- 获取战争大厅等级
function PlayerData:getwarhall()
    local builds = self.builds
    for i, v in ipairs( builds ) do
        if i and v then
            if v.buildType  == Enum.type.warhall then
                return v.lv
            end
        end
    end
	return 0
end

--得到 瞭望塔 等级
function PlayerData:getwatchtowerLvl()
    local builds = self.builds
    for i, v in ipairs( builds ) do
        if i and v then
            if v.buildType  == Enum.type.watchtower then
                return v.lv
            end
        end
    end
    printLog( "PlayerData:getCastleLvl", "瞭望塔找不到？" )
end

--得到 市场 等级
function PlayerData:getMarketLvl()
    local builds = self.builds
    for i, v in ipairs( builds ) do
        if i and v then
            if v.buildType  == Enum.type.market then
                return v.lv
            end
        end
    end
    printLog( "PlayerData:getMarketLvl", "市场找不到？" )
    return 0
end

--得到 铁匠铺 等级
function PlayerData:getForgeShopLvl()
    local builds = self.builds
    for i, v in ipairs( builds ) do
        if i and v then
            if v.buildType  == Enum.type.forgeShop then
                return v.lv
            end
        end
    end
    printLog( "PlayerData:getForgeShopLvl", "铁匠铺找不到？" )
    return 0
end

--判断 城堡 等级 是否足够
function PlayerData:checkCastleLvl( lvl )
    if lvl == nil or lvl <= 0 then
        return false
    end

    local castleLvl = self:getCastleLvl()

    return castleLvl >= lvl
end

-- 获取建筑物状态
function PlayerData:getBuildState(pos)
    local info = self.builds[pos]
    if info then
        --急救帐篷        
        if info.effectTime == nil then
            info.effectTime = 0
        end

        if info.completeTime == 0 and info.effectTime > 0 and self:isEmergency(info.buildType) then 
            if info.effectTime > self:getServerTime() then 
                return Enum.buildstate.eg  --特殊情况急救状态
            elseif info.effectTime == 0 then
                 return Enum.buildstate.nt
            else
                 return Enum.buildstate.egok     
            end
        end

        --农田状态
        if self:isResBuild(info.buildType) then 
            if info.effectTime>0 and info.completeTime >self:getServerTime() then 
                if info.effectType == -1 then
                    return Enum.buildstate.trSpeed_rm--农田加速状态和拆除状态
                end
                return Enum.buildstate.trSpeed_bd  --农田加速状态和升级状态
            end
            if info.completeTime == 0 and info.effectTime>0 then 
                if info.effectTime > self:getServerTime() then 
                    --traceObj(info,"trSpeed")
                    return Enum.buildstate.trSpeed  --农田加速状态
                else
                    return Enum.buildstate.trSpeedok  --农田加速状态完成
                end
            end
        end

        --建筑升级状态 
        if info.completeTime > 0 then 
            if info.effectType >-1 then 
                if info.completeTime > self:getServerTime() then 
                    return Enum.buildstate.bd
                else
                    return Enum.buildstate.bdok
                end
            else   --拆除建筑物状态
                if info.completeTime > self:getServerTime() then 
                    return Enum.buildstate.rm
                else
                    return Enum.buildstate.rmok
                end
            end
        end
 
        --训练或者生产状态
        if info.completeTime == 0 and info.effectTime > 0 then
            if info.effectTime > self:getServerTime() then 
                info.hasnotifyViewPk = false
                return Enum.buildstate.tr
            else
                return Enum.buildstate.pk
            end
        end

        --常态
        if info.completeTime == 0 and info.effectType == 0 then
            return Enum.buildstate.nt
        end

    end

    -- if pos == 303 then--码头特殊添加
    --     return Enum.buildstate.tr
    -- end

    return Enum.buildstate.nt
end

function PlayerData:getServerTime()
    return ServerTimeModule:getServerTime()
end

function PlayerData:getItemCount(id)
    if self.items[id] then
        return self.items[id].num
    end
    return 0
end
function PlayerData:checkItemCount(id,num)
    return self:getItemCount(id)>=num
end


function PlayerData:setItemCount(id, count)
    if self.items[id] then
        self.items[id].num = count
        GameEvent:notifyView(GameEvent.updateItems, self.items)
    end
end

--使用物品个数
function PlayerData:addItemCount(id, usecount)
    usecount = usecount or 1
    if self.items[id] then
        self.items[id].num = self.items[id].num + usecount
        GameEvent:notifyView(GameEvent.updateItems, self.items)
    else
        trace("error userItemCount",id,usecount)
    end
end

--使用物品个数
function PlayerData:useItemCount(id, usecount)
    usecount = usecount or 1
    if self.items[id] and self.items[id].num >= usecount then
        self.items[id].num = self.items[id].num - usecount
        GameEvent:notifyView(GameEvent.updateItems, self.items)
        return true
    else
        trace("error userItemCount",id,usecount)
    end
    return false
end

--装备分解
function PlayerData:resolveEquip(id)
    if self.equipment[id]  then
        self.equipment[id]= nil
       -- GameEvent:notifyView(GameEvent.updateEquipment, self.equipment)
    else
        trace("error EquipID",id)
    end
end

--获取锻造所需装备
function PlayerData:getForgeNeeditem(item)
    local temp = {}
    for k,v in pairs(self.equipment) do
        local tInfo = TemplateData:getEquip(v.templateID)
        if (v.position == 0) then
            if (tInfo.lv <= item.lv) and tInfo.lv >= (item.lv -5) then
                tInfo.equipmentID = v.equipmentID
                local tab = {}
                for k1,v1 in pairs(tInfo) do
                    tab[k1] = v1
                end
                table.insert(temp,tab)
            end    
        end    
    end
    return temp
end    

function PlayerData:checkItem(itemtable)
    for k,v in pairs(self.items) do
        local tInfo1 = TemplateData:getItem(v.itemID)
        local tInfo2 = TemplateData:getItem(tonumber(itemtable[1]))
        if tInfo1 and tInfo2 then
            if (tInfo1.param1 == tInfo2.param1) and (v.num >= tonumber(itemtable[2])) then
                return true
            end
        end    
    end
    return false 
end

function PlayerData:hasBuildType(buildType)
    local count = 0
    for k, v in pairs(self.builds) do
        if v.buildType == buildType then
            count = count + 1
        end
    end
    return count
end

--空地还能建东西
function PlayerData:canBuildHere(buildPos)
	local building = TemplateData:getBuilds()
	local position = TemplateData:getPosition()
	local tempBuilds = self:getBuilds()
	local canBuilds = string.split(position[buildPos].type,",")
	
	for i,v in ipairs(canBuilds) do
		v = tonumber(v)
		local buildNum = self:hasBuildType(v)
		local buildMaxNum = building[v][1].num

		--大于可建个数不添加
		if buildNum < buildMaxNum then
            return true
		end
	end

    return false
end
--默认位置,找不到可建空地时
function PlayerData:getBuildDefPos(buildType)
    --if buildType == Enum.type.barracks  then--兵营
    --    return 14
    --end
    if self:isInsideBuild(buildType) then
        return 14
    elseif self:isOutsideBuild(buildType) then
        return 106
    end
end

--获取根据建筑物类型获取位置
function PlayerData:getBuildPosByType(buildType)
    return self:getBuildByType(buildType) and self:getBuildByType(buildType).position or self:getBuildDefPos(buildType)
end

--获取根据建筑物类型获取位置
function PlayerData:getBuildByType(buildType)
    for k,v in pairs(self.builds) do
        if v.buildType == buildType then 
            return v
        end
    end
    return self:getBuildNil(buildType)
end 

--没有建筑时
function PlayerData:getBuildNil(buildType)
    local firstPos = {12,11}--优先默认位置
    for _,pos in pairs(firstPos) do
        local v = self.builds[pos]
        if v then
            if self:isOutsideBuild(buildType) and v.position >= 100 and v.buildType==0 then 
                return v
            end
            if self:isInsideBuild(buildType) and v.position < 100 and v.buildType==0 then 
                return v
            end
        end
    end


    for k,v in pairs(self.builds) do
        if self:isOutsideBuild(buildType) and v.position >= 100 and v.buildType==0 then 
            return v
        end
        if self:isInsideBuild(buildType) and v.position < 100 and v.buildType==0 then 
            return v
        end
    end
    return nil
end

--获取下一等级建筑总时间
function PlayerData:getBuildTime(buildinfo)
	local buildTempInfo = TemplateData:getBuildWithTypeLvl(buildinfo.buildType,buildinfo.lv+1)
    if buildTempInfo == nil then
        return 0
    end
	return buildTempInfo.time * (1 - PlayerData:getBuildSpeed()/10000)
end

--获取移除建筑总时间
function PlayerData:getRemoveBuildTime(buildinfo)
	local buildTempInfo = TemplateData:getBuildWithTypeLvl(buildinfo.buildType,buildinfo.lv)
    if buildTempInfo == nil then
        return 0
    end
	return buildTempInfo.time/2
end

function PlayerData:costGold(value)
    self.player.gold = self.player.gold - value
    if self.player.gold < 0 then
        self.player.gold = 0
    end
end

function PlayerData:getGold()
    return self.player.gold
end

function PlayerData:getFood()
    return math.floor(self.player.food or 0)
end

function PlayerData:getIron()
    return math.floor(self.player.iron or 0)
end

function PlayerData:getSilver()
    return math.floor(self.player.silver or 0)
end

function PlayerData:getWood()
    return math.floor(self.player.wood or 0)
end

function PlayerData:getSteel()
    return math.floor(self.player.steel or 0)
end

function PlayerData:getLv()
    return self.player.lv
end

function PlayerData:getPlayerID()
	return self.player.playerID
end

function PlayerData:getPlayerName()
    return self.player.name
end

function PlayerData:setPlayerName(name)
    self.player.name = name
end

function PlayerData:getPlayerIconID()
    --TODO 用户头像图标ID
    local id = self.player.head_image
    -- printLog( "PlayerData:getPlayerIconID", "用户头像ID:%d", id )
    return id
end

function PlayerData:getPlayerBigPic()
    local id = self:getPlayerIconID()
    return R.userHeadPic[tonumber(id)]
end

function PlayerData:getPlayerIcon()
    local id = self:getPlayerIconID()
    return R.userHeadIcon[tonumber(id)]
end

function PlayerData:getLanguage()
    return self:getGameLanguageID()
end

function PlayerData:getVIPlv()
    return self.player.viplv
end

function PlayerData:getVipTime()
    return self.player.vipTime
end


--建筑免费升级时间
function PlayerData:getVipFreeTime()
    local vipLevel = self:getVipTime()>self:getServerTime() and self:getVIPlv() or 0
    return TemplateData:getVipFreeTime(vipLevel)
end

--------------Player check value---------------
function PlayerData:isUnLock(pos)
    return not (self.builds[pos]==nil)
end

--新解锁区域更新
function PlayerData:unLockPos(pos)
    if self.builds[pos] == nil then
        local info = {lv=0, position=pos ,completeTime=0, buildType=0 ,effectTime=0, effectType=0 ,effectValue=0 }
        self.builds[pos] = info
    end
end

-- 检查食物是否足够足够
function PlayerData:checkfood(v)
    local t = self.player.food - v
    if t>=0 then 
        return true,0,0
    end
    t = v-self.player.food
    return false,t,self:foodToGold( t )
end

function PlayerData:checkgold(v)
    return self.player.gold >= v
end


function PlayerData:checkwood(v)
    local t = self.player.wood - v
    if t>=0 then 
        return true,0,0
    end
    t = v-self.player.wood
    return false,t,self:woodToGold( t )
end


function PlayerData:checkiron(v)
    local t = self.player.iron - v
    if t>=0 then 
        return true,0,0
    end
    t = v-self.player.iron
    return false,t,self:ironToGold(t)
end


function PlayerData:checksilver(v)
   local t = self.player.silver - v
    if t>=0 then 
        return true,0,0
    end
    t = v-self.player.silver
    return false,t,self:silverToGold( t )
end

-- 铜币
function PlayerData:checkcopper(v)
    return self.player.copper >= v
end

-- 检查建筑物等级
function PlayerData:checkbuildlv(buildType, lv)
    for k, v in pairs(self.builds) do
        if v.buildType == buildType and v.lv >= lv then
            return true
        end
    end
    return false
end

-- 检查是否有足够的建筑工人时间
function PlayerData:checkworker(time)
    -- trace("工人有时间",self.player.worker,self.player.hireWorker,"remain",self.player.hireTime)
    local remainTime1,remainTime2=0,0
    local pos 
    if self.player.worker == nil or self.player.worker == 0 then
        return true, 1
    else
        remainTime1 = self:getBuildInfo(self.player.worker).completeTime - self:getServerTime()
    end
    if self.player.hireWorker == 0  then
        if self.player.hireTime - self:getServerTime() - time >= 0 then
            return true, 2
        elseif self.player.hireTime > 0 then--有金锤子时间,但不足
            return false,nil, self.player.hireTime - self:getServerTime()
        end
    end
    return false,self.player.worker,remainTime1
end

--建筑工人结束
function PlayerData:overworker(pos)
    if self.player.worker == pos then
        self.player.worker = 0
        print("结束建筑工人1 ",pos)
    end
    if self.player.hireWorker == pos then
        self.player.hireWorker = 0
        print("结束建筑工人2 ",pos)
    end
    local info = self:getBuildInfo(pos)
    GameEvent:notifyView(GameEvent.updateBuild, { info })
end

-- 检查雇佣的工人剩余时间
function PlayerData:checkRemainWorker()
    local remainTime = (self.player.hireTime or 0) - ServerTimeModule:getServerTime()
    return remainTime
end


function PlayerData:setHireWorkerTimes()
    if self.player.hireTime - ServerTimeModule:getServerTime() > 0 then
        self.player.hireTime = self.player.hireTime + Enum.hireTimes
    else
        self.player.hireTime = ServerTimeModule:getServerTime() + Enum.hireTimes
    end
end
--资源更新直接从服务端获取,因为还有消耗,这里计算是不准的.
--[[
local SplitTime = 1/60
--资源产出计算
function PlayerData:checkResOutput(time)
    if time ==nil then 
        return 
    end
    --60秒计算一次
    if os.time() - self.resTime < 60 then 
        return 
    end

    self.resTime = os.time()

    local buildinfo 
    local rate
    local count = 0
    local savelv = self:getBuildInfo(self:getBuildPosByType(Enum.type.warehouse)).lv
    local saveBuildInfo = TemplateData:getBuildWithTypeLvl(Enum.type.warehouse,savelv)
    for k, v in pairs(self.builds) do
        if self:isResBuild(v.buildType) then 
            if v.lv >0 then 
                buildinfo = TemplateData:getBuildWithTypeLvl(v.buildType,v.lv)
                if buildinfo.output > 0 then 
                    count = count + 1
                    if buildinfo.effectTime and buildinfo.effectTime > self:getServerTime() then 
                        rate = 1.5
                    else
                        rate = 1 
                    end
                    local key = Enum.resType[v.buildType-Enum.type.watchtower]
                    if saveBuildInfo["s"..key]>self.player[key] then --检查是否到达仓库上限
                        self.player[key] = self.player[key] + buildinfo.output*SplitTime*rate
                    end
                end
                -- print(key,self.player[key],buildinfo.output,buildinfo.output*SplitTime*rate)
            end
        end
        if count>0 then 
            GameEvent:notifyView(GameEvent.updatePlayerInfo)
        end
    end
end
]]
--检查建筑物是否可以升级
function PlayerData:checkBuildCanLvUp()
    local buildTempInfo  
    for k, v in pairs(self.builds) do
        if v.lv and v.lv > 0 and v.buildType and v.buildType>0 then  
            local canLvUp = true
            buildTempInfo = TemplateData:getBuildWithTypeLvl(v.buildType,v.lv+1)
            if buildTempInfo == nil then
                canLvUp = false
            else
                ok= self:checkworker(buildTempInfo.time+self:getServerTime())
                if not ok then 
                    canLvUp = false
                end

                local cond = buildTempInfo.condition1
                cond = util.split_two(cond)

                for m,n in pairs(cond) do
                    if m > 10000 then 
                        ok = self:checkItemCount(m,n)
                    else
                        ok = self:checkbuildlv(m,n)
                    end
                    if not ok then 
                        canLvUp = false
                        break
                    end
                end

                for i,v in ipairs(Enum.resType) do
                    if buildTempInfo[v]>0 then 
                        if self.player[v]<buildTempInfo[v] then 
                            canLvUp =false
                            break
                        end
                    end
                end
            end
            
            if canLvUp ~= v.canLvUp then 
                v.canLvUp = canLvUp
                GameEvent:notifyView(GameEvent.updateBuild, { v })
            end
        end
    end
end


-- 检查建筑物是否建完
function PlayerData:checkbuilds(time)
    if self.checkTick == nil then
        self.checkTick = scheduler.scheduleGlobal(handler(self, self.checkbuilds), 1)
    end
    --self:checkResOutput(time)
    self:checkBuildCanLvUp()

    local time
    local state
    for k, v in pairs(self.builds) do
        state = self:getBuildState(v.position)
        -- 如果是结束状态
        if state > Enum.buildstate.nt then
            if state == Enum.buildstate.bdok or state == Enum.buildstate.rmok then
                --经常出现建筑未升级,但工人也闲着的问题
                if self.player.worker ~= v.position and  self.player.hireWorker ~=v.position then
                    self:checkbuildOK(v.position)
                end
                -- 检查第一个建筑工
                if self.player.worker > 0 then
                    self.player.worker = self:checkbuildOK(self.player.worker)
                end
                -- 检查第二个建筑工
                if self.player.hireWorker > 0 then
                    self.player.hireWorker = self:checkbuildOK(self.player.hireWorker)
                end
            elseif state == Enum.buildstate.pk and not v.hasnotifyViewPk then
                v.hasnotifyViewPk = true
                GameEvent:notifyView(GameEvent.updateBuild, { v })
            elseif state == Enum.buildstate.egok or state == Enum.buildstate.trSpeedok then
                self:endEffectUpdateBuild(v.position)               
                trace("客户端治疗完成")           
                GameEvent:notifyView(GameEvent.updateTreatBuild)
            end
            
        -- 城墙状态改变
        elseif v.buildType == Enum.type.wall and self:isWallStateChange() then
            GameEvent:notifyView(GameEvent.updateBuild, { v })
        end
    end
end

-- 检查建筑物是否完成
function PlayerData:checkbuildOK(pos)
    if pos == 0 then
        return 0, 0
    end
    local info = self:getBuildInfo(pos)
    local time = 0
    if info and info.completeTime > 0 then
        time = info.completeTime - self:getServerTime()
        if time < 0 then
            if info.effectType > -1 then    --升级
                self:buildLvUp(info)
            else                            --拆除
                self:removeBuild(info.position)
            end
            return 0, 0
        end
    end
    return pos, time
end

-- 开始雇佣工人升级/拆除建筑物
function PlayerData:updateBuild(v)
    if v.completeTime>0 then
        local hasworker, pos = self:checkworker(v.completeTime - self:getServerTime())
        if hasworker then
            if pos and pos == 1 then
                self.player.worker = v.position
            else
                self.player.hireWorker = v.position
            end
            trace("开始建筑",v.position)
            GameEvent:notifyView(GameEvent.updateBuild, { v })
            return true
        else
            trace("没有足够的建筑时间")
        end
        
    end
    GameEvent:notifyView(GameEvent.updateBuild, { v })
    return false
end

--建筑能免费回事
function PlayerData:buildCanFreeSpeedUp(position)
    return self:getBuildLevelUpTime(position)>0 and self:getBuildTimeToGold(position)==0
end
--建筑免费加速升级
function PlayerData:buildFreeSpeedUp(position)
    local buildinfo = self:getBuildInfo(position)
    if self:buildCanFreeSpeedUp(position) then
        local tData = {
		    position = position, --在大地图上的位置
		    operation = Enum.op.vipFreeBuild,	-- 16vip立即建造加速
		    param = buildinfo.buildType, --建筑物type
	    }
        local isRemove = self:getBuildIsRemoveing(position)
	    GameTCP:sendRPC("building", tData, self,function(...)
            self:onUpdateNowRes(isRemove,...)
        end)

        return true
    end

    return false
end

--立即建造/升级结果
function PlayerData:onUpdateNowRes(bIsRemove,_,res,senddata)
	if res.result == Enum.success then
		local buildinfo = self:getBuildInfo(senddata.position)
        if bIsRemove then
            self:removeBuild(buildinfo.position)
        else
		    self:buildLvUp(buildinfo)
        end
	else
		GameHelper:serverTip(res.result)
	end
end

--建筑升级完成
function PlayerData:buildLvUp(info,lv)
    info.completeTime = 0
    info.lv = info.lv + 1
    self:overworker(info.position)
    GameEvent:notifyView(GameEvent.updateBuild, { info })
    GameHelper:buildLvUpTip( info )
	--检测是否开启引导
	
	--GameEvent:notifyView(GameEvent.updateBuild, { info })
    trace("建筑物完成",self:getBuildState(info.position))
end

--取消升级
function PlayerData:cancelBuild(position)
    local info = self:getBuildInfo(position)
    if info then
        info.completeTime = 0
        --取消建造时,把内容全部清空
        if info.lv == 0 then
            info = TemplateData:getPositionInfo(position)
            self:removeBuild(position)
        end
        self:overworker(info.position)
        GameEvent:notifyView(GameEvent.updateBuild, { info })
    end
end

function PlayerData:startBuild(position,time)
    local info = self:getBuildInfo(position)
    if info then
        info.completeTime = time
        self:updateBuild(info)
        -- print("建筑物开始中",self:getBuildState(info.position))
        -- traceObj(info)
    end

end


--开始拆除建筑物
function PlayerData:startRemoveBuild(position,time)
    local info = self:getBuildInfo(position)
    if info then
        info.completeTime = time
        info.effectType = -1
        self:updateBuild(info)
        -- print("建筑物拆除中",self:getBuildState(info.position))
        -- traceObj(info)
    end
end

--移除建筑物
function PlayerData:removeBuild(pos)
    local info = self:getBuildInfo(pos)
    if info then
        if info.lv >0 then 
            GameHelper:buildRmTip( info )
        end
        info.buildType = 0
        info.effectTime = 0
        info.effectType = 0
        info.effectValue = 0
        info.completeTime = 0
        self:overworker(info.position)
        info.lv = 0
        GameEvent:notifyView(GameEvent.updateBuild, { info })
        -- print("建筑物拆除完成",self:getBuildState(info.position))
    end
end




--建筑物道具加速时间
function PlayerData:buildOutSpeedUp(info,time)
    info.effectTime = self:getServerTime()+time
end


--加速时间
function PlayerData:buildTimeSpeedUp(pos,time)
    local info = self:getBuildInfo(pos)
    if info then 
        if info.completeTime>0 then 
            info.completeTime =  info.completeTime - time
            self:checkbuildOK(pos)
        end
        if info.effectTime>0 then 
            info.effectTime =  info.effectTime - time
        end
        --增加医疗加速处理方法，取出所有医疗帐篷更新时间
        if info.buildType == Enum.type.emergency then
            local builds = self:getBuilds()
            for i, v in pairs(builds) do
                if v.buildType == Enum.type.emergency then
                    --v.effectTime = info.effectTime
                    --GameEvent:notifyView(GameEvent.updateBuild, { v })
                    self:addEffectUpdateBuild(
                        v.position,
                        info.effectTime,
                        Enum.buildstate.eg
                    )
                end
            end           
        else
            GameEvent:notifyView(GameEvent.updateBuild, { info })
        end    
    end
end

--加速训练（训练时，再次进入训练界面后的一个“加速”按钮）
function PlayerData:buildTimeSpeedTrain( pos )
    local info = self:getBuildInfo(pos)
    if info then 
        if info.effectTime > 0 then 
            info.effectTime = self:getServerTime()
        end
        GameEvent:notifyView(GameEvent.updateBuild, { info })
    end
end

function PlayerData:getBuildInfo(pos)
    local info = self.builds[pos]
    if info then
        return info
    end
    trace("error build [", pos,"]"--[[, debug.traceback()]])
    return nil

end

function PlayerData:getBuildCompleteTime(pos)
    local info = self:getBuildInfo(pos)
    return info and info.completeTime or 0
end

function PlayerData:setBuildCompleteTime(pos,time)
    local info = self:getBuildInfo(pos)
    if info then
        info.completeTime = time

        GameEvent:notifyView(GameEvent.updateBuild, {info})  
    end
end


function PlayerData:getBuildEffectTime(pos)
    local info = self:getBuildInfo(pos)
    return info and info.effectTime or 0
end

function PlayerData:setBuildEffectTime(pos,time)
    local info = self:getBuildInfo(pos)
    if info then
        info.effectTime = time

        GameEvent:notifyView(GameEvent.updateBuild, {info})  
    end
end

--是否已是最高级
function PlayerData:isBuildLevelMax(pos)
    local buildType = self:getBuildInfo(pos) and self:getBuildInfo(pos).buildType
    if not buildType or buildType == 0 then
        return false
    end
    local level = self:getBuildInfo(pos) and self:getBuildInfo(pos).lv
    local levelMax = TemplateData:getBuildWithType(buildType) and #TemplateData:getBuildWithType(buildType)
    return levelMax and (level == levelMax)
end

--金币农田加速花费
function PlayerData:getResGoldSpeedCost(position)
    local buildinfo = self:getBuildInfo(position)
    local gold
    if buildinfo.buildType == Enum.type.logging then 
        gold = buildinfo.lv*2
    elseif buildinfo.buildType == Enum.type.farmland then 
        gold = buildinfo.lv*2
    elseif buildinfo.buildType == Enum.type.ironore then 
        gold = buildinfo.lv*3
    elseif buildinfo.buildType == Enum.type.mystrile then 
        gold = buildinfo.lv*4
    end
    return gold
end

--获取道具提高产量一天的道具id
function PlayerData:getResToolSpeedID(buildType)
     local toolID  = 0
    if buildType == Enum.type.logging then 
        toolID = Enum.outspeed_wood
    elseif buildType == Enum.type.farmland then 
        toolID = Enum.outspeed_food
    elseif buildType == Enum.type.ironore then 
        toolID = Enum.outspeed_iron
    elseif buildType == Enum.type.mystrile then 
        toolID = Enum.outspeed_silver
    end
    return toolID
end

--建筑物升级还需时间
function PlayerData:getBuildLevelUpTime(position)
    local buildinfo = self:getBuildInfo(position)
    if buildinfo then 
        if buildinfo.completeTime>0 then 
            return buildinfo.completeTime - self:getServerTime()
        end
    end
    return 0
end

--建筑物拆除还需时间
function PlayerData:getBuildIsRemoveing(position)
    local buildinfo = self:getBuildInfo(position)
    if buildinfo then 
        return buildinfo.effectType == -1
    end
    return false
end


--建筑物升级时间转金币
function PlayerData:getBuildTimeToGold(position)
    local buildinfo = self:getBuildInfo(position)
    if buildinfo then 
        local time = 0
        if buildinfo.completeTime>0 then 
            time = buildinfo.completeTime - self:getServerTime()
            if time<= self:getVipFreeTime() then--建筑5分钟内免费
                time =  0
            end
        elseif buildinfo.effectTime>0 then 
            time  = buildinfo.effectTime - self:getServerTime()
            if time<= self:getVipFreeTime() and buildinfo.effectType == -1 then--拆除5分钟内免费
                time =  0
            end
        end 
        return self:timeToGold(time)
    end
    return 0
end

function PlayerData:swapBuild(pos1,pos2)
    local buildForm = self.builds[pos1]
    local buildTo = self.builds[pos2]

    buildForm.position =  pos2
    buildTo.position = pos1
    
    self.builds[pos2] = buildForm
    self.builds[pos1] = buildTo

    self.player.worker = (self.player.worker == pos1 and pos2) or (self.player.worker == pos2 and pos1) or self.player.worker
    self.player.hireWorker = (self.player.hireWorker == pos1 and pos2) or (self.player.hireWorker == pos2 and pos1) or self.player.hireWorker
    
    GameEvent:notifyView(GameEvent.updateBuild, { buildForm,buildTo })
end

-- 是否为训练型建筑物
function PlayerData:isTrainBuild(buildType)
    if buildType == Enum.type.barracks or buildType == Enum.type.stable or buildType == Enum.type.range or
        buildType == Enum.type.chariot or buildType == Enum.type.warfort then
        return true
    end
    return false
end

--是否为可移动建筑物
function PlayerData:isCanMove(buildType)
    if buildType >= Enum.type.logging and buildType <=Enum.type.assemblyPlace then 
        return true
    end
    return false

end

--城内可移动建筑物
function PlayerData:isInsideBuild(buildType)
    if buildType >= Enum.type.college and buildType <=Enum.type.assemblyPlace and buildType ~= Enum.type.march and buildType ~= Enum.type.emergency  then 
        return true
    end
    return false
end

--是否还有建筑移动道具
function PlayerData:hasMoveItem()
    local item = 200019
    local num = self:getItemCount(item)
    return num>=1
end


--城内位置
function PlayerData:isInsidePos(buildinfo)
    if buildinfo.position<100 then 
        return true
    end
    return false
end

--城外位置
function PlayerData:isOutsidePos(buildinfo)
    if buildinfo.position>=100 then 
        return true
    end
    return false
end

-- 是否城外建筑物
function PlayerData:isOutsideBuild(buildType)
    if buildType == Enum.type.farmland or buildType == Enum.type.ironore or
     buildType == Enum.type.mystrile or buildType == Enum.type.logging  or
     buildType == Enum.type.march or buildType == Enum.type.emergency  then
        return true
    end
    return false
end
-- 是否为资源生产建筑物
function PlayerData:isResBuild(buildType)
    if buildType == Enum.type.farmland or buildType == Enum.type.ironore or
     buildType == Enum.type.mystrile or buildType == Enum.type.logging  then
        return true
    end
    return false
end
--是否为可拆除建筑物
function PlayerData:isRemoveBuild(buildType)
    if buildType == Enum.type.farmland or buildType == Enum.type.ironore or 
        buildType == Enum.type.mystrile or buildType == Enum.type.march or 
        buildType == Enum.type.emergency or buildType == Enum.type.logging then 
        return true
    end
    return false

end

-- 是否城墙
function PlayerData:isWall(buildType)
    if buildType == Enum.type.wall then
        return true
    end
    return false
end

-- 是否急救帐篷
function PlayerData:isEmergency(buildType)
    if buildType == Enum.type.emergency then
        return true
    end
    return false
end

-- 是否大使馆
function PlayerData:isEmbassy(buildType)
    if buildType == Enum.type.embassy then
        return true
    end
    return false
end
--是否为学院
function PlayerData:isSearch(buildType)
    if buildType == Enum.type.college then
        return true
    end
    return false
end

--是否为铁匠铺
function PlayerData:isForgeShop(buildType)
    if buildType == Enum.type.forgeShop then
        return true
    end
    return false
end

function PlayerData:isStudyCollage(buildType)
    if buildType == Enum.type.college then
        return true
    end
    return false
end

--是否为战争堡垒
function PlayerData:isWarfort(buildType)
    if buildType == Enum.type.warfort then
        return true
    end
    return false
end

function  PlayerData:isMarch( buildType )
    if buildType == 0 then
        return true
    end
    return false
end

--获取加速道具类型
function PlayerData:getSpeedUpType(buildType,state)
    if state == Enum.buildstate.bd then
        return 6
    end
    if self:isEmergency(buildType) then 
        return 2
    elseif self:isSearch(buildType) then
        return 3
    elseif self:isForgeShop(buildType) then 
        return 5
    elseif self:isWarfort(buildType) then 
        return 7
    elseif self:isTrainBuild(buildType) then 
        return 4
    elseif self:isMarch(buildType) then 
        return 8
    else
        return 6
    end
    return 1
end

--是否有建筑训练提速道具
function PlayerData:getSpeedDataSource(buildinfo)
    local buildType = buildinfo.buildType
    local items =  TemplateData:getSpeedUpItems()
    local dataSource ={}
    local fl = self:getSpeedUpType(buildType,buildinfo.state)
    for k,v in pairs(items) do
        if (v.param1 ==1 or v.param1 ==fl) and self:getItemCount(v.ID)>0 then 
            table.insert(dataSource,{data=v,num=self:getItemCount(v.ID)})
        end
    end

    --先按类型排序,再按时间排序
    local sortFun = function ( a,b )
        local type1 = a.data.param1
        local type2 = b.data.param1
        local value1 = a.data.param2
        local value2 = b.data.param2
		if type1 == type2 then
		    return value1 < value2
        else
            return type1 < type2
		end
	end	
    table.sort(dataSource,sortFun)
    return dataSource
end

function PlayerData:getSpeedUpBuildNum(t)
    return #self:getSpeedDataSource(t)
end

--获取道具提高产量个数
function PlayerData:getOutSpeedUpWood()
    return self:getItemCount(Enum.outspeed_wood)
end

function PlayerData:getOutSpeedUpFood()
    return self:getItemCount(Enum.outspeed_food)
end

function PlayerData:getOutSpeedUpIron()
    return self:getItemCount(Enum.outspeed_iron)
end

function PlayerData:getOutSpeedUpSilver()
    return self:getItemCount(Enum.outspeed_silver)
end


--建筑加速加成
function PlayerData:getBuildSpeed()
    local speed = self:getCityGrow() and self:getCityGrow().buildingSpeedUp 
    return speed or 0
end

--获取成功进攻次数
function PlayerData:getAtkSuccessTimes()
    return self.player.atkSuccessTimes
end

--获取防御成功次数
function PlayerData:getDefSuccessTimes()
    return self.player.defSuccessTimes
end

--获取击杀部队数量
function PlayerData:getKillArmyNum()
    return self.player.killArmyNum
end

function PlayerData:getCureArmyNum()
    return self.player.cureArmyNum
end

function PlayerData:getKillMonster(  )
    return self.player.kill_monster
end

function PlayerData:getExploreTime(  )
    return self.player.explore_time
end

function PlayerData:getGuildhonor( )
    return self.Player.guildhonor
end
-------------------------------训练-----------------------------
--急救状态   endTime   effectType = Enum.buildstate.eg


-- 开始训练  更新建筑物状态
function PlayerData:addEffectUpdateBuild(position, endTime, effectType, effectValue)
    if endTime<=self:getServerTime() then
        self:endEffectUpdateBuild(position)
        return
    end
    local info = self:getBuildInfo(position)
    if info then
        info.effectTime = endTime
        info.effectType = effectType
        info.effectValue = effectValue or 0
        self:setbuildCanHelp(position)
        GameEvent:notifyView(GameEvent.updateBuild, { info })
    end
end


-- 结束训练  更新建筑物状态
function PlayerData:endEffectUpdateBuild(position)
    local info = self:getBuildInfo(position)
    if info then
        info.effectTime = 0
        info.effectType = 0
        info.effectValue = 0
        self:setbuildHelped(position)
        GameEvent:notifyView(GameEvent.updateBuild, { info })
    end
end
-------------------------------大地图-----------------------------
function PlayerData:getMonsterLv()
	return self.player.monster_lv
end

-- 获取玩家坐标
function PlayerData:getPlayerXY()
    return cc.p(self.player.x, self.player.y)
end

function PlayerData:setPlayerXY(x,y)
	self.player.x = x
	self.player.y = y
end

-- 行军路线
function PlayerData:updateRoute(result)
	trace("-----------接收线路更新------")
	-- traceObj(result)   
	GameEvent:notifyView(GameEvent.updateMarchLine, result)
	self:armyMarchEndRemind(result)
	
    local temp = {}
    for k,v in pairs(self.myRouteLineData) do
        if v.route_state == 99 or v.route_state == 98 then
            table.insert(temp,k)
        end
    end
    for k,v in pairs(temp) do
         self.myRouteLineData[v]= nil  
    end    	
end

-- 我的部队达到目的地 或者 返回到城堡
function PlayerData:armyMarchEndRemind(result)
	local passRemindTab = {} --已提醒过列表
	for k,v in pairs(result.route) do
		if v.playerID == tostring(self:getPlayerID()) then
			if not passRemindTab[v.route_index] then -- 防止重复提醒
				if v.route_state == 99 then -- 到家了
					passRemindTab[v.route_index] = true
					Alert.floatingTip(1,Language.get("31206"), true)
					self.myRouteLineData[v.route_index] = nil
				else
					local data = self.myRouteLineData[v.route_index]
					if data then -- 线路之前存在
						if data.route_state == 1 and v.route_state ~= data.route_state then
							local isShowTip = false
							if v.route_state == 2 then
								isShowTip = true
							elseif v.route_state == 3 and data.endTime == v.startTime then
								isShowTip = true
							end
							if isShowTip then
								passRemindTab[v.route_index] = true
								if v.purpose == Enum.BigMap_expedition_soldier_aid then
									local str = string.formatIndex(Language.get("31051"), "")
									Alert.floatingTip(3,Language.get("31206"), "march_icon.png", Language.get("31050"), str)
								end
							end
						end
					else
						if v.route_state == 2 or v.route_state == 3 then
							local currTime = ServerTimeModule:getServerTime()
							if currTime == v.startTime then
								passRemindTab[v.route_index] = true
							end
						end				
					end
				end			
			end
			self.myRouteLineData[v.route_index] = v
		end
	end
	passRemindTab = {}
end

--根据ID获取行军路线数据
function PlayerData:getRouteLineData( itype )
    for k,v in pairs(self.myRouteLineData) do
        if v.purpose == itype then
            return v
        end    
    end
    return nil
end

-- 城堡位置发生改变
function PlayerData:updateCityChange(packet)
	GameEvent:notifyView(GameEvent.cityLocationChange, packet)
end

-- 更新城堡状态
function PlayerData:updateCityStatus(packet)
    GameEvent:notifyView(GameEvent.updateCityStatus, packet)
end

-- 获取战争守护时间
function PlayerData:getWarGuard()
	local info = self:getCityBuffInfo(7)
	if info then
		return info.futureTime
	else
		return 0
	end
end

--------------------码头信息变更-----------------------------
function PlayerData:setShipData(param)
     self.player.ship = param
end

--添加码头
function PlayerData:updateDock(time)
    local info
    if self.builds[Enum.ps.dock]==nil then
        info ={}
        info.position = Enum.ps.dock
        info.buildType = Enum.type.dock
        info.completeTime = 0
        info.effectTime =0 
        info.effectValue =0
        self.builds[Enum.ps.dock] = info
    end
    info = self.builds[Enum.ps.dock]
    info.effectTime = time
    if time == 1 then
        info.effectTime = 0
    end  
    GameEvent:notifyView(GameEvent.updateBuild, { info })
end


-------------------------------邮件-----------------------------
--插入邮件 first = true
function PlayerData:insertMailList(mails,first)
	
	if(first) then
		self.maillist = mails
	else
		--获得更多列表
	end
end

function PlayerData:UpdateMail(mails)
	if(type(mails.mailInfo) ~= "table") then
		trace("UpdateMail =" .. "数据下发为空")
		return
	end
	self.allMaillist = mails.mailInfo
	for i,v in pairs(self.allMaillist) do
		if v.mails then
			table.sort(v.mails,function(a,b) return a.time_point>b.time_point end )
			-- for j, mail in pairs(v.mails) do
				-- mail.bLock = false
			-- end
		else
			v.mails = {}
		end
		v.num = nil
		if v.mailType == Enum.Mail_resource then
			local flag = math.mod(v.unread,10000)
			v.unread = (v.unread - flag)/10000
			v.unread_res = flag
			v.unread_help = v.unread - flag
		end
	end
	
	local mailCount = self:getMailUnReadCount()
	GameEvent:notifyView(GameEvent.UpdateMailCount)
end

function PlayerData:updateMailReceiveStatus(result)
	local t = result.data
	for i,v in pairs(self.allMaillist) do
		for j, mail in pairs(v.mails) do
			if(mail.mailID == t.mailID) then
				mail.receive = t.value
			end
		end
	end
end

function PlayerData:getMailReceiveStatus(mailType,mailID)
	local receive = Enum.nothingReceive
	local vMails = self:GetMailObjByType(mailType)
		for j, mail in pairs(vMails) do
			if(mail.mailID == mailID) then
				receive = mail.receive
				break
			end
		end

	return receive
end

function PlayerData:UpdateMailLock(mailParam,mailType,block)

	local mailBlockFlag = Enum.lockno
	if( block == true) then
		mailBlockFlag = Enum.lockYes
	end

	local vMails = self:GetMailObjByType(mailType)
    for i,v in pairs(vMails) do
		
		if mailType == Enum.Mail_resource then
			local secType = v.attach_resource.subjectType
			if(mailParam == secType) then
				v.locked = mailBlockFlag
			end
		elseif mailType == Enum.Mail_monster then
			v.locked = mailBlockFlag
		else
			if(mailParam == v.mailID) then
				v.locked = mailBlockFlag
				break
			end
		end
    end
end

function PlayerData:checkMailExist(mailID,mailType)
	local exist = false
	local vMails = self:GetMailObjByType(mailType)
    for i,v in pairs(vMails) do
        if v.mailID == mailID then
			exist = true
            break
        end
    end
	return exist
end

function PlayerData:CheckBlock(mailID,mailType)
	local vMails = self:GetMailObjByType(mailType)
    for i,v in pairs(vMails) do
        if v.mailID == mailID then
            return v.bLock
        end
    end
    return false

end

--subType--mailId
function PlayerData:updateMailToRead(mailType,tempID)
	local mailInfo = self.allMaillist[mailType]
	if mailType == Enum.Mail_monster then
		mailInfo.unread = 0
	elseif mailType == Enum.Mail_resource then
		local subType = tempID
		local delNum = 0
		if(subType == Enum.resCollect) then
			delNum = mailInfo.unread_res
			mailInfo.unread_res = 0
		elseif(subType == Enum.reshelp) then
			delNum = mailInfo.unread_help
			mailInfo.unread_help = 0
		end
		mailInfo.unread = mailInfo.unread - delNum
	else
		local changeFlag = false
		local mailID = tempID
		for i,vObj in pairs(mailInfo.mails) do
			if vObj.mailID == mailID then
				if(vObj.readstatus == Enum.unreadFlag) then--未读
					vObj.readstatus = Enum.readFlag
					changeFlag = true
				end
				break
			end
		end
		if(changeFlag) then
			mailInfo.unread = mailInfo.unread - 1
		end
	end
end

function PlayerData:DeleteSingleMail(mailID,mailType,unreadFlag)
	self:updateMailToRead(mailType,mailID)
	self:DelMailPrivate(mailType,mailID)
    -- if unreadFlag then
        -- self.allMaillist[mailType].unread = self.allMaillist[mailType].unread -1
        -- if self.allMaillist[mailType].unread < 0 then
            -- self.allMaillist[mailType].unread = 0
        -- end
    -- end

    -- for i,v in pairs(self.allMaillist[mailType].mails) do
        -- if v.mailID == mailID then
            -- table.remove(self.allMaillist[mailType].mails,i)
            -- break
        -- end
    -- end
    -- local items_count = table.nums(self.allMaillist[mailType].mails)
    -- return items_count
end

function PlayerData:AddMails(mails,mailType,num)
	local t_mails = {}
	local vMails = self:GetMailObjByType(mailType)
    if vMails then
        for i,v in pairs(mails) do
			--避免重复
			local isIn = false
			for i2,v2 in pairs (self.allMaillist[mailType].mails) do
				if (v2.mailID == v.mailID) then
					isIn = true
					--v2 = v 更新
					break
				end
			end
			if(not isIn) then
				table.insert(self.allMaillist[mailType].mails,v)
				table.insert(t_mails,v)
				trace("insert mailId = [" .. v.mailID .. "]")
			end
			table.sort(self.allMaillist[mailType].mails,function(a,b) return a.time_point>b.time_point end )
        end
    else
        self.allMaillist[mailType].mails = mails
    end
	return t_mails
end
----数据处理接口---
--邮件过滤，首杀不记录总数
function PlayerData:mailFilterPrivate(nType,mail)
	local mailObj = self.allMaillist[nType]
	if nType == Enum.Mail_monster then
		if mail.attach_monster.subjectType == Enum.monsterfirstblood then  --首杀奖励,不记录为已读
			if mailObj.sum == 0 then
				mailObj.mails = {}
			end
			table.insert(mailObj.mails,mail) --数目未读和总数
		end
	end
end
	
--增加邮件 插入单条数据 数据接口
function PlayerData:addMailPrivate(nType,mail)
	local mailObj = self.allMaillist[nType]
	if(mailObj) then
		if mailObj.sum == 0 then
			mailObj.mails = {}
		end
		table.insert(mailObj.mails,mail)
		mailObj.sum = mailObj.sum + 1
		
		if mailObj.mailType == Enum.Mail_resource then
			local secType = mail.attach_resource.subjectType
			if(0 == secType) then
				mailObj.unread_res = mailObj.unread_res + 1
			else
				mailObj.unread_help = mailObj.unread_help + 1
			end
		end
		mailObj.unread = mailObj.unread + 1
	else
		trace("类型邮件 nType = " .. nType .. "数据为空")
	end
end

function PlayerData:addMaiList(nType,mailList)
end

--删除某类型邮件 数据接口
function PlayerData:DelMailList(nType)
	local mailObj = self.allMaillist[nType]
	if mailObj.sum > 0 then -- mailObj.nums
		mailObj.mails = {}
		--mailObj.num = 0
		mailObj.sum = 0
		mailObj.unread = 0
		--local mailCount = self:getMailUnReadCount()
	end
end
	
--删除邮件 数据接口
function PlayerData:DelMailPrivate(nType,mailID)
	local mailObj = self.allMaillist[nType]
	local changeFlag = false
	for i,vObj in pairs(mailObj.mails) do
		if vObj.mailID == mailID then
			table.remove(mailObj.mails,i)
			mailObj.sum = mailObj.sum - 1
			break
		end
	end
end

--获取邮件未读数目 0
function PlayerData:getMailUnReadCount()
	local count = 0
	local mailObjSet = self.allMaillist
    if mailObjSet then 
        for i,mailObj in pairs(mailObjSet) do
			if(mailObj.mailType == Enum.Mail_playerchat) then
				count = count + self:getUnreadCount()
				-- 聊天特殊处理
			else
				count = count + mailObj.unread
			end
        end
    end
	return count
end
-------------------------------------------------------------

function PlayerData:AddMail(result)
	self:mailFilterPrivate(result.mail.mailType,result.mail)
	self:addMailPrivate(result.mail.mailType,result.mail)
	
    local mail = result.mail
    local mailType = mail.mailType
    
    if mailType == Enum.Mail_fight then
        local ItemInfo = mail
        local strTip = ""
        --战报类型。0-战斗胜利；1-战斗失败；2-攻城胜利；3-攻城失败；4-守城胜利；5-守城失败；6-侦查报告；7-黑骑士战报
        if ItemInfo.attach_fight.subjectType == Enum.mail_fight_win then
            strTip = Language.get("28010")
            strTip = strTip..Language.get("28030")..": "
            local killnum = ItemInfo.attach_fight.liftStruct.kills
            strTip = strTip..killnum..", "
            strTip = strTip..Language.get("28019")..": "
            local lossnum = ItemInfo.attach_fight.liftStruct.loss
            strTip = strTip..lossnum

        elseif ItemInfo.attach_fight.subjectType == Enum.mail_fight_fail then
            strTip = Language.get("28009")
            strTip = strTip..Language.get("28030")..": "
            local killnum = ItemInfo.attach_fight.liftStruct.kills
            strTip = strTip..killnum..", "
            strTip = strTip..Language.get("28019")..": "
            local lossnum = ItemInfo.attach_fight.liftStruct.loss
            strTip = strTip..lossnum
        elseif ItemInfo.attach_fight.subjectType == Enum.mail_fight_gongchen_win then
            strTip = Language.get("28026")
            strTip = strTip..Language.get("28030")..": "
            local killnum = ItemInfo.attach_fight.liftStruct.kills
            strTip = strTip..killnum..", "
            strTip = strTip..Language.get("28019")..": "
            local lossnum = ItemInfo.attach_fight.liftStruct.loss
            strTip = strTip..lossnum
        elseif ItemInfo.attach_fight.subjectType == Enum.mail_fight_gongchen_fail then
            strTip = Language.get("28067")
            strTip = strTip..Language.get("28030")..": "
            local killnum = ItemInfo.attach_fight.liftStruct.kills
            strTip = strTip..killnum..", "
            strTip = strTip..Language.get("28019")..": "
            local lossnum = ItemInfo.attach_fight.liftStruct.loss
            strTip = strTip..lossnum
        elseif ItemInfo.attach_fight.subjectType == Enum.mail_fight_shouchen_win then
            strTip = Language.get("28083")
            strTip = strTip..Language.get("28030")..": "
            local killnum = ItemInfo.attach_fight.liftStruct.kills
            strTip = strTip..killnum..", "
            strTip = strTip..Language.get("28019")..": "
            local lossnum = ItemInfo.attach_fight.liftStruct.loss
            strTip = strTip..lossnum
        elseif ItemInfo.attach_fight.subjectType == Enum.mail_fight_shouchen_fail then
            strTip = Language.get("28084")
            strTip = strTip..Language.get("28030")..": "
            local killnum = ItemInfo.attach_fight.liftStruct.kills
            strTip = strTip..killnum..", "
            strTip = strTip..Language.get("28019")..": "
            local lossnum = ItemInfo.attach_fight.liftStruct.loss
            strTip = strTip..lossnum
        elseif ItemInfo.attach_fight.subjectType == Enum.mail_fight_zhencha then
            if ItemInfo.attach_fight.scoutStruct.scoutTarge == 0 then
                strTip = Language.get("28037")
            elseif ItemInfo.attach_fight.scoutStruct.scoutTarge == 1 then
                strTip = Language.get("28077")
            end
        elseif ItemInfo.attach_fight.subjectType == Enum.report_encamp_fail then
            --strTip = Language.get("28009")
        elseif ItemInfo.attach_fight.subjectType == Enum.report_encamp_success then
            --strTip = Language.get("28088")
        end
        --Alert.floatingTip(1, strTip)
		local strTip1 = Language.get("28005")
		local sp = cc.Sprite:createWithSpriteFrameName("icon_suxing.png")
		Alert.floatingTip(3, "",sp,strTip1,strTip)
	elseif mailType == Enum.mail_monster then
		local strTip1 = Language.get("28005")
		local strTip2 = ""
		local id = mail.attach_monster.monsterID
		local monster = TemplateData:getMonsterItem(id)
		local strTip3 = Language.get(monster.monster_name)
		if(mail.attach_monster.subjectType == 0) then
			strTip2 = Language.get("28010")
		elseif(mail.attach_monster.subjectType == 1) then
			strTip2 = Language.get("28009")--"战斗失败"
		end
		local sp = cc.Sprite:createWithSpriteFrameName("icon_suxing.png")
		Alert.floatingTip(3, "",sp,strTip1,strTip3 .. "       " .. strTip2)
    end
    local mailCount = self:getMailUnReadCount()
	GameEvent:notifyView(GameEvent.UpdateMailCount)
end

function PlayerData:getPlayerPowerValue()
    local power = 0
    for i, v in pairs(self.power) do
        power=power+v
    end
    return power
end

------------------------成就----------------------------------
function PlayerData:updateAchieve(result)
    if result.achieve then
        util.merge(self.achieve, result.achieve)
    end
end

function PlayerData:getAchieve()
    return self.achieve
end

function PlayerData:setAchieve(achieveLists)
    util.merge(self.achieve, achieveLists)
end

function PlayerData:getAchievePercent()
    local achieveComplete = 0
    for i, v in pairs(self.achieve) do
        local item = util.createluaItem("ui.player.playerDetailedItem")
        item.lbl_name:setString(Language.get(test[i]))
        item.lbl_num:setString(v)
        util.listAddItem(self.ls_detailed, item)
    end
end

------------------------城市信息-------------------------------
--刷新
function PlayerData:updateProductionConsume(result)
    dump(result)
    self.ProductionConsume = result
    GameEvent:notifyView(GameEvent.updateQuest)
end
--获取木材产量
function PlayerData:getWoodPor()
    return self.ProductionConsume and self.ProductionConsume.wood or 0
end

--获取粮食产量
function PlayerData:getfoodPor()
    return self.ProductionConsume and self.ProductionConsume.food or 0
end

--获取粮食消耗
function PlayerData:getfoodconsume()
    return self.ProductionConsume and self.ProductionConsume.consume or 0
end

--获取铁矿产量
function PlayerData:getironPor()
    return self.ProductionConsume and self.ProductionConsume.iron or 0
end
--获取银矿产量
function PlayerData:getsilverPor()
    return self.ProductionConsume and self.ProductionConsume.silver or 0
end

----------------------军情----------------------------------------
function PlayerData:updateMarchIno(result)
   if result.march then
        self.marchInfo = result.march
   else
        self.marchInfo = {}
   end
   GameEvent:notifyView(GameEvent.updateMarchIno)
end

function PlayerData:getMarchIno()
   return self.marchInfo
end

function PlayerData:getArmyInfo(armyTab)--"type|num , type|num"
   local tempTab = {}
   local info = {}
   local strInfo = armyTab and armyTab.army
   local army_type = armyTab and armyTab.army_type
   if strInfo then
        strInfo = string.gsub(strInfo," ","")
        tempTab = string.split(strInfo,",")
   elseif army_type then--表示只有类型,没有具体数量
       for i,j in pairs(army_type) do
          table.insert(info,{id = j})
       end
       return info
   end

   for i,j in pairs(tempTab) do
       local armyType,armyNum = string.match(j,"(.+)|(.+)")
       armyType = tonumber(armyType)
       armyNum = tonumber(armyNum)
       if armyNum > 0 then
           table.insert(info,{id = armyType,num = armyNum})
       end
   end
   
   return info
end
-------------------------------------------------------------------------------
--得到 装备展示设置
function PlayerData:getEquipShow()
    return self:getSettingValue(Enum.settingKey.equipShow,1) == 1
end

--设置 装备展示设置
--@param：flg：开关状态，默认“开 == true”
function PlayerData:setEquipShow( flg )
    local value = flg and 1 or 0

    self:setSettingValue(Enum.settingKey.equipShow,value,true)
end

--保存设置到服务器,value为数字
function PlayerData:saveSettingToServer(key,value)
    GameTCP:sendRPC("systemSettingUp", {namevalue = key,setvalue = value})
end

function PlayerData:setSettingValue(key,value,bSaveToServer)
    self.player[key] = value 
    if bSaveToServer then
        self:saveSettingToServer(key,value)
    end
end

function PlayerData:getSettingValue(key,default)
    if self.player[key] == nil then
        self.player[key] = default 
    end
    return self.player[key]
end
-------------------------仓库------------------------------
--获取仓库数据
--buileLevel 为仓库等级,默认为当前服务器获取到的等级

function PlayerData:getWareHouseBuildLv()
    local buildType = Enum.type.warehouse
    local buildLvl = self:getBuildByType(buildType) and self:getBuildByType(buildType).lv or 1
    return buildLvl
end

function PlayerData:getWareHouseData(buileLevel)
    local buildType = Enum.type.warehouse
    local buildLvl = buileLevel or self:getWareHouseBuildLv()
    local buildinfo  = TemplateData:getBuildWithTypeLvl( buildType, buildLvl )
    return buildinfo
end

--仓库的储存上限
function PlayerData:getSavefood(buileLevel)
    local info = self:getWareHouseData(buileLevel)
    return info and info.sfood or 0
end

function PlayerData:getSavewood(buileLevel)
    local info = self:getWareHouseData(buileLevel)
    return info and info.swood or 0
end

function PlayerData:getSaveiron(buileLevel)
    local info = self:getWareHouseData(buileLevel)
    return info and info.siron or 0
end

function PlayerData:getSavesilver(buileLevel)
    local info = self:getWareHouseData(buileLevel)
    return info and info.ssilver or 0
end
------------------------用户设置的信息-------------------------------

--得到 用户选择的 游戏语言
--@return：Enum：Enum.gameLanguage
function PlayerData:getGameLanguageID()
    local id =  self:getSettingValue(Enum.settingKey.selLanguage,Enum.gameLanguage.CN) --self.GameLanguageID
    if id == 0 then
        id = Enum.gameLanguage.CN
    end

    return id
end

--设置 用户选择的 游戏语言
--@param：gameLanguageID：Enum.gameLanguage
function PlayerData:setGameLanguageID( gameLanguageID )
    if gameLanguageID == nil then
        return
    end
    --self.GameLanguageID = gameLanguageID
    --util.setKey( "gameLanguageID", gameLanguageID )
    self:setSettingValue(Enum.settingKey.selLanguage,gameLanguageID,true)
end

 --初始化 所有语言翻译可用性
function PlayerData:initTranslateEnabled()
    local translateData = TemplateData:getTranslateLanguageSet()
    for i, v in ipairs( translateData ) do
        if i and v then
            local id = v.id
            local key = "Translate_" .. id
            local flg = tonumber( util.getKey( key ) )
            if flg == 1 then
                self.translateEnabled[id] = true
            elseif flg == 0 then
                self.translateEnabled[id] = false
            else
                self:setTranslateLanguageEnabled( id, true )
            end
        end
    end
end

--得到 所有语言翻译可用性
--@param：languageID：Enum.gameLanguage
--@return：bool
function PlayerData:getTranslateEnabled( languageID )
    return self.translateEnabled[languageID]
end

--设置 语言翻译可用性
--@param：languageID：Enum.gameLanguage
--@param：flg：开关状态，默认“开 == true”
function PlayerData:setTranslateLanguageEnabled( languageID, flg )
    if languageID == nil then
        return 
    end

    if flg == nil then
       flg = true 
    end
    
    local key = "Translate_" .. languageID
    local value = nil

    if flg == true then
        flg = true
        value = 1
    else
        flg = false
        value = 0
    end

    self.translateEnabled[languageID] = flg

    util.setKey( key, value )
end

--初始化 音效可用性
function PlayerData:initSoundEffectEnabled()
    local flg = tonumber( util.getKey( "SoundEffect" ) )
    if flg == 1 then
        self.soundEffectEnabled = true
    elseif flg == 0 then
        self.soundEffectEnabled = false
        GameSound:enableSound(false)
    else
        self:setSoundEffectEnabled( true )
    end
end

--得到 音效可用性
function PlayerData:getSoundEffectEnabled()
    return self.soundEffectEnabled
end

--设置 音效可用性
--@param：flg：开关状态，默认“开 == true”
function PlayerData:setSoundEffectEnabled( flg )
    if flg == nil then
       flg = true 
    end
    
    local value = nil

    if flg == true then
        flg = true
        value = 1
        
    else
        flg = false
        value = 0
    end

    self.soundEffectEnabled = flg
    GameSound:enableSound(flg)
    util.setKey( "SoundEffect", value )
end

--初始化 音乐可用性
function PlayerData:initSoundMusicEnabled()
    local flg = tonumber( util.getKey( "SoundMusic" ) )
    if flg == 1 then
        self.soundMusicEnabled = true
    elseif flg == 0 then
        self.soundMusicEnabled = false
        GameSound:enableMusic(false)
    else
        self:setSoundMusicEnabled( true )
    end
end

--得到 音乐可用性
function PlayerData:getSoundMusicEnabled()
    return self.soundMusicEnabled
end

--设置 音乐可用性
--@param：flg：开关状态，默认“开 == true”
function PlayerData:setSoundMusicEnabled( flg )
    if flg == nil then
       flg = true 
    end
    
    local value = nil

    if flg == true then
        flg = true
        value = 1
    else
        flg = false
        value = 0
    end

    self.soundMusicEnabled = flg
    GameSound:enableMusic(flg)
    util.setKey( "SoundMusic", value )
end

--初始化 任务智能提示
function PlayerData:initTaskHintShowEnabled()
    local flg = tonumber( util.getKey( "TaskHintShow" ) )
    if flg == 1 then
        self.taskHintShowEnabled = true
    elseif flg == 0 then
        self.taskHintShowEnabled = false
    else
        self:setTaskHintShowEnabled( true )
    end
end

--得到 任务智能提示
function PlayerData:getTaskHintShowEnabled()
    return self.taskHintShowEnabled
end

--设置 任务智能提示
--@param：flg：开关状态，默认“开 == true”
function PlayerData:setTaskHintShowEnabled( flg )
    if flg == nil then
       flg = true 
    end
    
    local value = nil

    if flg == true then
        flg = true
        value = 1
    else
        flg = false
        value = 0
    end

    self.taskHintShowEnabled = flg
    util.setKey( "TaskHintShow", value )
    GameEvent:notifyView(GameEvent.taskHintShow)
end

 --初始化 通知栏信息类型 可用性
function PlayerData:initNoticeMessageTypeEnabled()
    local data = TemplateData:getMessageType()
    for i, v in ipairs( data ) do
        if i and v then
            local type = v.id
            local key = "NoticeMessageType_" .. type
            local value = tonumber( util.getKey( key ) )

            if value == 1 then
                self.NoticeMessageTypeEnabled[type] = true
                self:setNoticeMessageEnabledWithType( type, true )
            elseif value == 0 then
                self.NoticeMessageTypeEnabled[type] = false
                self:setNoticeMessageEnabledWithType( type, false )
            else
                self:setNoticeMessageTypeEnabled( type, true )
            end
        end
    end
end

--得到 通知栏信息类型 可用性
function PlayerData:getNoticeMessageTypeEnabled()
    return self.NoticeMessageTypeEnabled
end

--设置 通知栏信息类型 可用性
--@param：type：Enum.noticeMessageType
--@param：flg：开关状态，默认“开 == true”
function PlayerData:setNoticeMessageTypeEnabled( type, flg )
    if type == nil then
        return
    end

    if flg == nil or flg == true then
        flg = true
    else
        flg = false
    end

    local value = nil
    if flg == true then
        flg = true
        value = 1
    else
        flg = false
        value = 0
    end

    self.NoticeMessageTypeEnabled[type] = flg
    self:setNoticeMessageEnabledWithType( type, flg )
    print("setNoticeMessageTypeEnabled",type, value)
    util.setKey( "NoticeMessageType_" .. type, value )
end

--得到 通知栏信息 可用性
function PlayerData:getNoticeMessageEnabledWithID( id )
    if id == nil then
        return
    end
    print(id,self.NoticeMessageEnabled[id])
    return self.NoticeMessageEnabled[id]
end

--设置 通知栏信息 可用性
--@param：type：Enum.noticeMessageType
--@param：flg：开关状态，默认“开 == true”
function PlayerData:setNoticeMessageEnabledWithType( type, flg )
    if type == nil then
        return
    end

    if flg == nil or flg == true then
        flg = true
    else
        flg = false
    end

    local data = TemplateData:getMessageWithMessageTypeID( type )
    for i, v in ipairs( data ) do
        if i and v then
            self.NoticeMessageEnabled[v.id] = flg
        end
    end
end

-------------------------------------------------------------------------------

function PlayerData:updateOtherPlayer(result)
    if result then
        self.otherPlayerData = {}
        util.merge(self.otherPlayerData, result)
    end
end

function PlayerData:getOtherPlayer()
    return self.otherPlayerData
end

-- 有重复登陆时，强制下线
function PlayerData:kickoffline()
	trace("有重复登陆时，强制下线")
	GameTCP:disconnect()
	Alert.messageBox3("有重复登陆时，强制下线", function() os.exit() end, function() os.exit() end)
end

---------------------------------------技能-------------------------------
-- 剩余技能点
function PlayerData:getRemainSkillPoint()
    return self.player.totalSkillPoint
end

-- 已使用技能点
function PlayerData:getSkillUsePoint()
    return self.player.skillUsedPoint
end

function PlayerData:setRemainSkillPoint( totalSkillPoint )
   self.player.totalSkillPoint = totalSkillPoint
   GameEvent:notifyView(GameEvent.updateSkillPoint)
end

-- 技能加点
function PlayerData:setSkillPoints()
    self:setRemainSkillPoint(self.player.totalSkillPoint - 1)
    self.player.skillUsedPoint = self.player.skillUsedPoint + 1 
end

-- 重置技能点
function PlayerData:resetSkillPoints()
    self:setRemainSkillPoint(self.player.totalSkillPoint + self.player.skillUsedPoint)
    self.player.skillUsedPoint = 0
end


-------------

--帮助的名字和类型名字
function PlayerData:getHelpNameAndType(helpType,id)
    local name,typeName
    if helpType <= Enum.allianceHelp.build then
        typeName = Language.get("10114")--建造
        name = TemplateData:getBuildName(helpType)
    elseif  helpType == Enum.allianceHelp.study then
        typeName = Language.get("10112")--研究
        name = TemplateData:getScienceName(id)
    elseif  helpType == Enum.allianceHelp.train then
        typeName = Language.get("10113")--训练
        name = TemplateData:getArmsName(id)
    elseif  helpType == Enum.allianceHelp.heal then
        typeName = Language.get("10116")--治疗
        name = Language.get("43003")--伤兵
    elseif  helpType == Enum.allianceHelp.cast then
        typeName = Language.get("43005")--铸造
        name = TemplateData:getEquipName(id)
    else
        name = "ivalid desc"
    end

    return name,typeName
end

--获取大使馆
function PlayerData:getEmbassy()
    for i,j in pairs(self:getBuilds()) do
        if Enum.type.embassy == j.buildType then
            return j
        end
    end

    return nil
end


--请求帮助列表详情
function PlayerData:callHelpList()
    GameTCP:sendRPC("helpList", {})--会得到updateGuildHelp数据,operation=2
end

--帮助个数变化
function PlayerData:onHelpNumChange()
    GameEvent:notifyView(GameEvent.updateBuild,{self:getEmbassy()})--更新大使馆
    self:updateGuildNum(5,self:getHelpsNum())
end

--联盟帮助相关数据
function PlayerData:updateGuildHelp(result)
    if result.operation  then
        self._guidHelp[result.operation] = result.guildHelps
        if result.operation == 2 then--获取帮助列表
            self._guidHelp[1] = {}--全部列表已更新掉了,就把之前推送的不完整数据清除
            GameEvent:notifyView(GameEvent.updateGuildHelpList)
            self:onHelpNumChange()
        elseif result.operation == 3 and self._guidHelp[3] and self._guidHelp[3][1] then --被帮助推送
            local info = result.guildHelps[1]
            local helpType = info.helpType
            local helpValueNum = info.helpValueNum
            local helpName = info.playerName
            local itemName,TypeName = self:getHelpNameAndType(helpType,helpValueNum)
            local icon = info.head_image and R.userHeadIcon[tonumber(info.head_image)]
            local sp = cc.Sprite:createWithSpriteFrameName(icon)
            local lv = helpType < Enum.allianceHelp.build and info.helpValueNum>0 and tostring(info.helpValueNum)..Language.get("43004") or ""--级--只有建筑有等级

            local str = string.formatIndex(Language.get("43221"),helpName,TypeName,lv,itemName)--{1}帮助你{2}{3}{4}
            Alert.floatingTip(2, str,sp)
            self:onHelp(self._guidHelp[3][1])
        elseif result.operation == 1 then --别人寻求帮助推送
            self:onHelpNumChange()
        elseif result.operation == 4 and result.guildHelps then --自己已经申请过帮助的列表
            for i,j in pairs(result.guildHelps) do
                local helpType = result.guildHelps[i].helpType
                local helpValue = result.guildHelps[i].helpValue
                local buildPosition = helpValue

                if buildPosition then
                    self:setbuildHelped(buildPosition)
                end
            end
        end  
    end
end

function PlayerData:getHelpReduceTimeScience()
    return self:getGuildScienceValue(250400) + self:getGuildScienceValue(252900)
end

--被帮助减少时间
function PlayerData:getHelpReduceTime()
    local buildType = Enum.type.embassy
    local buildLvl = self:getBuildByType(buildType) and self:getBuildByType(buildType).lv or 0
    if buildLvl>0 then
        local buildinfo = TemplateData:getBuildWithTypeLvl( buildType, buildLvl )
        return buildinfo and (buildinfo.cut + self:getHelpReduceTimeScience() )or 0
    end

    return 0
end

--被帮助
function PlayerData:onHelp(info)
    local helpType = info.helpType
    local helpValueNum = info.helpValueNum
    local helpName = info.playerName
    local itemName,TypeName = self:getHelpNameAndType(helpType,helpValueNum)
    local reduceTime = self:getHelpReduceTime()
    local buildPos = info.helpValue
    if not self:getBuildInfo(buildPos) then
        trace("PlayerData:onHelp(info) not build in pos:"..buildPos)
        return
    end
    
    if helpType < Enum.allianceHelp.build then--建筑加速后时间减少
        local time = self:getBuildCompleteTime(buildPos)
        if time> self:getServerTime() then
            self:setBuildCompleteTime(buildPos,time - self:getHelpReduceTime() )
        end
    else
        local time = self:getBuildEffectTime(buildPos)
        if time> self:getServerTime() then
            if helpType == Enum.allianceHelp.heal then
                self:setemergencyTime(time - self:getHelpReduceTime())
            else
                self:setBuildEffectTime(buildPos,time - self:getHelpReduceTime() )
            end
        end
    end
end

--急救时间
function PlayerData:getemergencyTime()
    return  self:getPlayer().emergencyTime
end

function PlayerData:setemergencyTime(time)
    self:getPlayer().emergencyTime = time

    local builds = self:getBuilds()
    local data = {}
    for i, v in pairs(builds) do
        if v.buildType == Enum.type.emergency then
            v.effectTime = time
            table.insert(data,v)
        end
    end
    GameEvent:notifyView(GameEvent.updateBuild, data)
    
end

--获取详细帮助列表
function PlayerData:getGuildHelp()
    return  self._guidHelp[2] or {}
end

--获取推送帮助列表
function PlayerData:getGuildHelpPush()
    return  self._guidHelp[1] or {}
end

--自己需求帮助列表
function PlayerData:addMyHelp(pos)
    self._guidHelp[4] = self._guidHelp[4] or {}
    self._guidHelp[4][pos] = true
end

--有请求
function PlayerData:hasHelp()
    for i,j in pairs(self:getGuildHelp()) do
        if j.isHelp == 0 then
            return true
        end
    end

    for i,j in pairs(self:getGuildHelpPush()) do
       if j.isHelp == 0 then
            return true
        end
    end

    return false
end


--请求个数
function PlayerData:getHelpsNum()
    local num = 0
    for i,j in pairs(self:getGuildHelp()) do
        if j.isHelp == 0 then
            num = num + 1
        end
    end

    for i,j in pairs(self:getGuildHelpPush()) do
       if j.isHelp == 0 then
            num = num + 1
        end
    end

    return num
end

--帮助所有
function PlayerData:helpAll()
    local data = {helpID={}}
    for i,j in pairs(self:getGuildHelp()) do
        table.insert(data.helpID,j.helpID)
    end

    for i,j in pairs(self:getGuildHelpPush()) do
        table.insert(data.helpID,j.helpID)
    end
    GameTCP:sendRPC("helpGuildPlayer",data,self,self.helpAllRes)
end

function PlayerData:helpAllRes(result)
    local suc = result and result.result
    if suc~=1 then--失败
        trace("helpAll失败"..result.result)
        return
    end
    --清空列表
    self._guidHelp = {}
    self:onHelpNumChange()
end

--获取帮助类型
function PlayerData:getHelpType(position)
    if self:getAllianceID()== 0 or not self:getEmbassy() then
        return 0
    end
    local buildInfo = self:getBuildInfo(position)
    if buildInfo.helpType then
        return buildInfo.helpType
    end
    local buildType = buildInfo.buildType
    if buildInfo.completeTime and buildInfo.completeTime > self:getServerTime() and buildInfo.state~=-1 then
        return buildType
    end
    if buildInfo.effectTime ==nil or buildInfo.effectTime <= self:getServerTime() then
        return 0
    end
    if self:isForgeShop(buildType) then
        return Enum.allianceHelp.cast
    elseif self:isSearch(buildType) then
        return Enum.allianceHelp.study
    elseif self:isTrainBuild(buildType) then
        return Enum.allianceHelp.train
    elseif self:isEmergency(buildType) and not self:getEmergencyHelped() then
        return Enum.allianceHelp.heal
    end

    return 0
end


--添加此建筑可帮助标志
function PlayerData:setbuildCanHelp(pos)
    local info = self.builds[pos]
    if info then
        info.helpType = nil
        GameEvent:notifyView(GameEvent.updateBuild, { info })
    end
end

--去除此建筑可帮助标志
function PlayerData:setbuildHelped(pos)
    local info = self.builds[pos]
    if info then
        if info.buildType == Enum.type.emergency then
            self:setEmergencyHelped(true)
            return
        end
        info.helpType = 0
        GameEvent:notifyView(GameEvent.updateBuild, { info })
    else
        self.builds[pos] = {}
        self.builds[pos].helpType = 0
    end
end

--去所有治疗账篷帮助标志(治疗只要帮一个,全部都不能再帮)
function PlayerData:setEmergencyHelped(bHelped)
    local builds = self:getBuilds()
    local data = {}
    for i, v in pairs(builds) do
        if v.buildType == Enum.type.emergency then
            v.helpType = bHelped and 0 or nil
            table.insert(data,v)
        end
    end
    GameEvent:notifyView(GameEvent.updateBuild, data)
end

function PlayerData:getEmergencyHelped()
    local builds = self:getBuilds()
    for i, v in pairs(builds) do
        if v.buildType == Enum.type.emergency then
            if v.helpType then
                return true
            end
        end
    end

    return false
end


------------------------------------
--联盟
-----------------------------------
--荣誉
function PlayerData:getPlayerGuildInfo()
    return self:getAllianceMember(self:getPlayerID()) or {}
end

function PlayerData:getGuildhonor()
    --return self:getPlayerGuildInfo().guildhonor or 0
    return self.player.guildhonor or 0
end

function PlayerData:setGuildhonor(value)
    --[[if self:getPlayerGuildInfo() then
        self:getPlayerGuildInfo().guildhonor = value
        GameEvent:notifyView(GameEvent.updatePlayerGuildInfo, {guildhonor = value})
    end]]
    self.player.guildhonor = value
    GameEvent:notifyView(GameEvent.updatePlayerGuildInfo, {guildhonor = value})
end
--积分
function PlayerData:getGuildintegral()
    return self:getPlayerGuildInfo().guildintegral or 0
end
--阶级
function PlayerData:getGuildClass()
    return self:getPlayerGuildInfo().guildClass or 0
end

function PlayerData:setGuildintegral(value)
    if self:getPlayerGuildInfo() then
        self:getPlayerGuildInfo().guildintegral = value
        GameEvent:notifyView(GameEvent.updatePlayerGuildInfo, {guildintegral = value})
    end
end

function PlayerData:isRank45()
    local guildClass = self:getGuildClass()
    return guildClass == 4 or guildClass ==5
end

--获取科技加成值
function PlayerData:getGuildScienceValue(scienceID,level)
    level = level or self:getSciencelv(scienceID)
    local addValue = TemplateData:getScienceAddValue(scienceID)

    return level*addValue
end

function PlayerData:getGuildScienceValueString(scienceID,level)
    level = level or self:getSciencelv(scienceID)
    local addValue = TemplateData:getScienceAddValue(scienceID)
    local addType = TemplateData:getScienceAddType(scienceID)
    local unit = ""
    if addType == 2 then
        addValue = addValue/100
        unit = "%"
    elseif addType == 3 then
        unit = Language.get("12004")--秒
    end
    local str = tostring(level*addValue)

    return str..unit
end

--获取联盟加成
function PlayerData:getGuildScienceData()
    return self.guildScienceData
end

function PlayerData:haveGuildScienceData(scienceID)
    return self.guildScienceData[scienceID]~=nil
end


function PlayerData:getGuildScience(scienceID)
    return self.guildScienceData[scienceID] or {}
end

function PlayerData:getScienceStar(scienceID)
    return self:getGuildScience(scienceID).star or 0
end

function PlayerData:setScienceStar(scienceID,star)
    if star == self:getScienceStar(scienceID) then
        return false
    end
    self.guildScienceData[scienceID].star = star
    return true
end

function PlayerData:isScienceStarMax(scienceID)
    return self:getScienceStar(scienceID) == TemplateData:getScienceMaxStar(scienceID)
end

function PlayerData:getScienceresearchTime(scienceID)
    return self.guildScienceData[scienceID] and self.guildScienceData[scienceID].researchTime or 0
end

function PlayerData:setScienceresearchTime(scienceID,time)
    self.guildScienceData[scienceID].researchTime  = time
end


function PlayerData:getSciencelv(scienceID)
	if self.guildScienceData then
		 return self.guildScienceData[scienceID] and self.guildScienceData[scienceID].lv or 0
	else
		return 0
	end
end


function PlayerData:scienceLevelUp(scienceID)
    local level =  self:getSciencelv(scienceID)
    self.guildScienceData[scienceID].lv  = level + 1
    self:setScienceresearchTime(scienceID,0)
end

--科技总星数
function PlayerData:getSciencetotalStar()
    return self._guildSciencetotalstar or 0
end

--科技总等级
function PlayerData:getSciencetotalLevel()
    local level =  0
    if self.guildScienceData then
        for id,info in pairs(self.guildScienceData) do
            level = level + self:getSciencelv(id)
        end
    end

    return level
end


function PlayerData:addSciencetotalStar(num)
    self._guildSciencetotalstar  = self._guildSciencetotalstar + num
    GameEvent:notifyView(GameEvent.updatePlayerGuildInfo, {sciencestar = self._guildSciencetotalstar})
end

--收到服务器数据后更新数据
function PlayerData:onGuildScienceList(result)
    self._guildSciencetotalstar = result.totalstar
     
    if result.guildscienceinfo then
        for _,floorInfo in pairs(result.guildscienceinfo) do
            if floorInfo.scienceinfo then
                for i,info in pairs(floorInfo.scienceinfo) do
                    local star = info.star
                    local lv = info.lv
                    local scienceID = info.scienceID
                    local researchTime = info.researchTime
                    self.guildScienceData[scienceID] = info
                end
            end
        end
        GameEvent:notifyView(GameEvent.updatePlayerGuildInfo, {guildscienceinfo = result.guildscienceinfo})
    end
end

--清空数据,在退盟时要用
function PlayerData:clearGuildScienceData()
    self._guildSciencetotalstar = 0
    self.guildScienceData = {}
end

-------------------------------------服务器链接状态--------------------------------
-- 服务器链接状态
function PlayerData:onServerState(eventSockct)
	if eventSockct.name == SocketTCP.EVENT_CONNECTED then
	
	elseif eventSockct.name == SocketTCP.EVENT_CLOSED  then
		trace("服务器被关闭")
		Alert.messageBox6(Language.get("10330"), function() SystemUpdate:exitGame() end)
	elseif eventSockct.name == SocketTCP.EVENT_CONNECT_FAILURE  then
		trace("服务器被关闭")
		Alert.messageBox6(Language.get("10330"), function() SystemUpdate:exitGame() end)		
	end
end
function PlayerData:getIfTurn()
    return self.player.ifTurntable
end

function PlayerData:updateEventcenter( result )
    util.merge(self.eventlimt, result.eventlimt)
    self.eventblack = result.eventblack
    GameEvent:notifyView(GameEvent.updateEventcenter)      
end

function PlayerData:getEventLimit()
    return self.eventlimt
end

function PlayerData:getEventBlack()
    return self.eventblack
end

--更换玩家形象
function PlayerData:setPlayerIconID(params)
    self.player.head_image = params
end

--受伤总人数
function PlayerData:getArmyWoundeds()
    local woundedTNum = 0
    for i, v in pairs(self.army) do
        if v.woundedNum~=0 then
            woundedTNum = woundedTNum+v.woundedNum
        end
    end
    return woundedTNum
end

--伤兵总转化率
function PlayerData:getArmyWoundedrate()
    local woundedTNum = 0
    for i, v in pairs(self.army) do
        if v.woundedNum~=0 then
            woundedTNum = woundedTNum+v.woundedNum
        end
    end
    return woundedTNum
end

--治疗客户端计算增加
function PlayerData:setArmy(args)
    self.army = args
end

--加速治疗
function PlayerData:buildTimeSpeedTreat( pos )
    local info = self:getBuildInfo(pos)
    if info then 
        if info.effectTime > 0 then 
            info.effectTime = self:getServerTime()
        end
        if info.buildType == Enum.type.emergency then
            local builds = self:getBuilds()
            for i, v in pairs(builds) do
                if v.buildType == Enum.type.emergency then
                    v.effectTime = info.effectTime
                    GameEvent:notifyView(GameEvent.updateBuild, { v })
                end
            end           
        else
            GameEvent:notifyView(GameEvent.updateBuild, { info })
        end  
    end
end
---------------------------------联盟--------------------------------------------------
--[[
--联盟信息结构
self.alliance = 
{
	baseInfo = {}
	memberList = {}
	guildEx
}
]]

function PlayerData:resetApplyList()
	self.alliance.applyList = {}
end

function PlayerData:removeToGuildApply(id)
	for k, vObj in pairs(self.alliance.applyList) do
		if(vObj == id) then
			table.remove(self.alliance.applyList,k)
		end
	end
end

function PlayerData:addToGuildApply(id)
	if(not self.alliance.applyList) then
		self.alliance.applyList = {}
	end
	table.insert(self.alliance.applyList,id)
end

function PlayerData:updateGuildApply(result)
	if(result.operation == 0) then
		for k, vObj in pairs(result.guildIDs) do
			self:removeToGuildApply(vObj)
		end
	else
		self.alliance.applyList = result.guildIDs
	end
end

function PlayerData:updateGuildEvent(result)
	local t = result.result
	if self:getAllianceReqTime() then
		table.insert(self.eventList,t)
		table.sort(self.eventList,function(a,b) return tonumber(a.time)>tonumber(b.time) end)
	end
	
	GameEvent:notifyView(GameEvent.notifyGuildEventList,t)
end

function PlayerData:getAllianceApplyList()
	return self.alliance.applyList
end

function PlayerData:JudgeInApplyList(applyId)
	local isIn = false
	if(self.alliance.applyList) then
		for k, vObj in pairs(self.alliance.applyList) do
			if(applyId == vObj) then
				isIn = true
				break
			end
		end
	end
	return isIn
end

function PlayerData:updateGuild(result)
	if(result.guildSimple) then
		local guildId = self:getAllianceID()
		if(result.guildSimple.guildID == guildId) then
			--自身联盟信息保存
			self.alliance.guildEx = result.guildEx
			self.alliance.baseInfo = result.guildSimple
			trace("自身联盟信息保存")
			GameEvent:notifyView(GameEvent.updateGuildBase)
		else--if(result.guildSimple.guildID ~= nil and result.guildSimple.guildID ~= guildId) then -- guildId~=0 and 
			--临时的其他联盟信息
			trace("临时的其他联盟信息")
			self.otheralliance = {}
			self.otheralliance.guildEx = result.guildEx
			self.otheralliance.guildId = result.guildSimple.guildID
			self.otheralliance.baseInfo = result.guildSimple
		end
	end
end

function PlayerData:ChangeGuildClass(playerID,Add)
	local classLev = self.alliance.memberList[playerID].guildClass
	self.alliance.memberList[playerID].guildClass = classLev + Add
end

function PlayerData:setGuildClass(playerID,Add)
	--local classLev = self.alliance.memberList[playerID].guildClass
	if(self.alliance.memberList[playerID]) then
		self.alliance.memberList[playerID].guildClass = Add
	else
		trace("数据有误:玩家id playerID = " .. playerID .. "不存在")
	end
end

function PlayerData:setEnterModuleFlag(flag)
	self.ModuleFlag = flag
end

function PlayerData:updateGuildMemberData(result)
	--1 公会解散 2被T出联盟
	if(1 == result.operation or 2 == result.operation) then
		self:setAllianceID(0)
		
		local function cancelFun()
		end
		local function okFun()
			if(self.ModuleFlag) then
				util.popAllWin()
			end
		end
		local strText = ""
		if(1 == result.operation) then
			strText = Language.get("43537")
			Alert.messageBox3( strText, okFun, cancelFun )
		elseif (2 == result.operation) then
			strText = Language.get("43538")
			Alert.floatingTip(1,strText)
		end
		
	end
end

function PlayerData:updateGuildMember(result)
	trace("联盟成员----------------")
	if(result.guildMembers) then
		local guildId = self:getAllianceID()
		
		if(result.guildMembers[1].guildID == guildId) then
			--自身联盟成员列表
            if result.operation~=1 then
                self.alliance.memberList = {}
            end			
			if(result.guildMembers) then
				for k, vObj in pairs(result.guildMembers) do
					if self.alliance.memberList[vObj.playerID] == nil then
						self.alliance.memberList[vObj.playerID] = vObj
					else
						util.merge(self.alliance.memberList[vObj.playerID], vObj)
					end
				end
			end
		else
			--其他联盟成员列表
			self.otheralliance.memberList = {}
			if(result.guildMembers) then
				for k, vObj in pairs(result.guildMembers) do
					if self.otheralliance.memberList[vObj.playerID] == nil then
						self.otheralliance.memberList[vObj.playerID] = vObj
					else
						util.merge(self.otheralliance.memberList[vObj.playerID], vObj)
					end
				end
			end
		end
	end
end

function PlayerData:removeGuildMember(playerID)
	for k, vObj in pairs(self.alliance.memberList) do
		if playerID == vObj.playerID then
			--table.remove(self.alliance.memberList,k)
			self.alliance.memberList[playerID] = nil
		end
	end
end

function PlayerData:setGuildMemberData(playerID,obj)
	for k, vObj in pairs(self.alliance.memberList) do
		if playerID == vObj.playerID then
			vObj = obj
		end
	end
end

--获取联盟简易信息
function PlayerData:getAllianceInfo()
    return self.alliance.baseInfo
end

--获取联盟阶级的信息
function PlayerData:getguildEx()
    return self.alliance.guildEx
end



--获取临时公会成员列表
function PlayerData:getOtherAllianceData(allianceId)
	if(self.otheralliance.guildId == allianceId) then
		return self.otheralliance
	else
		local otheralliance = {}
		return otheralliance
	end
end

--获取成员信息
function PlayerData:getAllianceMember(playerId)
	return self.alliance.memberList[playerId]
end

--获取盟主离线时间
function PlayerData:getChairmanoffTime()
	local ownerID = self.alliance.baseInfo.ownerID 
	return self.alliance.memberList[ownerID].lastLoginTime
end

-- 是否是联盟成员
function PlayerData:checkAllianceMember(playerId)
	-- guildClass = 0为申请但未批准的
	if self.alliance.memberList[playerId] and (self.alliance.memberList[playerId].guildClass ~= 0)  then
		return true
	else
		return false
	end
end

-- 获取联盟职位
function PlayerData:getAllianceMemberPost(playerId)
	if self.alliance.memberList[playerId] then
		return self.alliance.memberList[playerId].guildClass
	end
	trace("找不到 playerId 对应的职位,联盟中无此成员 == [" .. playerId .. "]")
	return -1
end

function PlayerData:getAllianceLevTitle()
	return self.alliance.guildEx
end

--获取成员列表
function PlayerData:getAllianceMemberList()
	return self.alliance.memberList
end
--保存联盟积分
function PlayerData:setguildhonor(playerId,guildhonor)
    self.alliance.memberList[playerId].guildhonor = guildhonor
end

--保存联盟荣誉
function PlayerData:setguildintegral(guildintegral)
    self.alliance.baseInfo.guildIntegral = guildintegral
end

--获取联盟的宣言
function PlayerData:getAlliacenannounce()
    return self.alliance.baseInfo.announce
end

--获取联盟公开招募状态
function PlayerData:getAlliacenopenInvite()
    return self.alliance.baseInfo.openInvite
end

--获得自己联盟的阶职
function PlayerData:getAllianceclass( playerId )
	if(self.alliance.memberList[playerId]) then
		return self.alliance.memberList[playerId].guildClass
	else
		trace("未发现改成员 playerId = " .. playerId)
		return 0
	end
end

--获取联盟名称
function PlayerData:getAllianceName()
    return self.alliance.baseInfo.guildName
end

-- 获取联盟简称
function PlayerData:getAllianceSimpleName()
	return self.alliance.baseInfo.simpleName or ""
end

function PlayerData:updateGuildInfo(data)	
	--联盟信息
	if(data.operation == 1) then
		local id = self:getAllianceID()
		if(data.guild and data.guild[id]) then
			self.alliance.baseInfo = data.guild[id]
		end
		GameEvent:notifyView(GameEvent.updateGuildBase)
	end
end


function PlayerData:updateGuildItem( result )
    if result.guilditems then
        for k, v in pairs(result.guilditems) do
            if self.GuildItems[v.itemID] == nil then
                self.GuildItems[v.itemID] = v
            else
                util.merge(self.GuildItems[v.itemID], v)
            end
        end 
        GameEvent:notifyView(GameEvent.updateGuildItems)
    end
end


function PlayerData:getGuildItem()
    return self.GuildItems
end

function PlayerData:setGuildItem()
    self.GuildItems = {}
end

--使用联盟物品个数
function PlayerData:useGuildItemCount(id, usecount)
    usecount = usecount or 1
    if self.GuildItems[id] and self.GuildItems[id].num >= usecount then
        self.GuildItems[id].num = self.GuildItems[id].num - usecount
    else
        trace("error useGuildItemCount",id,usecount)
    end
end

--改变玩家佩戴的勋章
function PlayerData:setMedal(id)
     self.player.medal = id
end

---------------------------------------- 聊天 ------------------------------------------------
function PlayerData:updateChatUnRead( result )
    if result.unreads then
        for k, v in pairs(result.unreads) do
            if self.chatUnread[v.playerID] == nil then
                self.chatUnread[v.playerID] = v
            else
                util.merge(self.chatUnread[v.playerID], v)
            end
        end
    end
end

function PlayerData:getChatUnReads()
    return self.chatUnread
end

-- 未读取总数量
function PlayerData:getUnreadCount()
    local count = 0
    for k,v in pairs(self.chatUnread) do
        count = count + v.unread
    end
    return count 
end

-- 未读取总数量
function PlayerData:getUnreadResCount(ntype)
	local mailInfo = self:GetMailByType(Enum.Mail_resource)
	if(ntype == Enum.resCollect) then
		return mailInfo.unread_res
	elseif(ntype == Enum.reshelp) then
		return mailInfo.unread_help
	end
end

-- 玩家未读取数量
function PlayerData:getUnreadCountByPlayerID(playerID)
    return self.chatUnread[playerID] and self.chatUnread[playerID].unread or 0
end

-- 新的未读消息
function PlayerData:addNewUnRead( playerID )
    if self.chatUnread[playerID] then
        self.chatUnread[playerID].unread = self.chatUnread[playerID].unread + 1
    else
        self.chatUnread[playerID] = {
                       playerID = playerID,
                       unread = 1 
                    }
    end
end

--已读或邮件删除
function PlayerData:clearReadByID( playerID )
    self.chatUnread[playerID] = {
                       playerID = playerID,
                       unread = 0 
                    }
    GameEvent:notifyView(GameEvent.UpdateMailCount)
end

function PlayerData:imUpdateInfo( result )
    if result.result == 1 then
        local records
        local imType
        if result.worldRecords then
            records = result.worldRecords
            imType = 1
        elseif result.guildRecords then            
            records = result.guildRecords
            imType = 2
        elseif result.ownRecords then           
            records = result.ownRecords
            imType = 3
        end
        --排除相同的recordID
        if records.isAll == 1 then
            local imID = tostring(records.playerID)..tostring(records.playerID)
            if records.imID ~= imID then
                return 
            end 
        end 
        if not self.chatRecord[imType] then
            self.chatRecord[imType] = {}
        end        
        for i,v in ipairs(records) do
            table.insert(self.chatRecord[imType],v) 
        end
        local data = {imType = imType, records = records}
        GameEvent:notifyView(GameEvent.imUpdateInfo,data)
    end
end

function PlayerData:imInfoNew( result )
    if result then
        local record
        if result.imtype == 0 then
            record = result.worldRecords
        elseif result.imtype == 1 then            
            record = result.guildRecords
        elseif result.imtype == 2 then           
            record = result.ownRecords
            
            if record.playerID ~= self:getPlayerID() then    
                self:addNewUnRead(record.playerID)
                GameEvent:notifyView(GameEvent.UpdateMailCount)
            end
        end
        --排除相同的recordID
        if record.isAll == 1 then
            local imID = tostring(record.playerID)..tostring(record.playerID)
            if record.imID ~= imID then
                return 
            end 
        end       
        self:addChatRecord(result.imtype+1, record)
        local data = {imType = result.imtype + 1, record = record}
        GameEvent:notifyView(GameEvent.addChatRecord,data)
    end
end

function PlayerData:getTrumpetRecord()
    return self.newTrumpetRecord
end

-- 添加新消息记录
function PlayerData:addChatRecord( type, record )
    if record.imsign == 2 then
        GameEvent:notifyView(GameEvent.newTrumpetRecord, record)
    end
    if not self.chatRecord[type] then
        self.chatRecord[type] = {}
    end
    table.insert(self.chatRecord[type],record)
end

function PlayerData:resetRecord( record,type )
    for i,v in ipairs(self.chatRecord[type]) do
        if v.recordID == record.recordID then
            self.chatRecord[type][i] = record
            return
        end
    end
end

-- 更新聊天记录
function PlayerData:setChatRecord( type,record )
    self.chatRecord[type] = record
end

-- 获得聊天记录
function PlayerData:getChatRecord()
    return self.chatRecord
end

function PlayerData:getScienceStudyConfig()
    local science_study1 = TemplateData:getScienceStudyConfig()
	local science_study = util.clone(science_study1)
	local playerCityGrow = self:getCityGrow()
	--trace("playerCityGrow.scienceSpeedUp" .. playerCityGrow.scienceSpeedUp)
	local percent = (10000 - playerCityGrow.scienceSpeedUp)/10000
	trace("percent = " .. percent)
	for k,vObj in pairs(science_study) do
		for ik,ivObj in pairs(vObj) do
			ivObj.time = math.floor(ivObj.time * percent)
		end
	end
	return science_study
end

--屏蔽列表
function PlayerData:updateShield(result)
    self.shieldList = result.shield or {}
    GameEvent:notifyView(GameEvent.updateShieldList) 
end

--解除屏蔽
function PlayerData:delShield(playerID)    
    for i,j in pairs(self:getShield()) do
        if j.shieldID == playerID then
            table.remove(self:getShield(),i)
            GameEvent:notifyView(GameEvent.updateShieldList) 
            return
        end
    end
end

function PlayerData:getShield()
    return self.shieldList
end


function PlayerData:DeleteAllMailResult(result,sendData)
	local AllDellist = result.dellist
	if(type(AllDellist) == "table") then
		for i,v in pairs(AllDellist) do
			local result ={}
			result.result = Enum.success
			result.dellist = v.dellist
			local sendData ={}
			sendData.mailtype = v.mailtype
			self:DeleteMailResult(result,sendData)
		end
	end
	if(result.result == 30)then
		Alert.floatingTip(1, Language.get("28118"))
	elseif(result.result == 28)then
		Alert.floatingTip(1, Language.get("28121"))
	end
end

function PlayerData:updateMailStatusRet(result,sendData)

end

function PlayerData:updateMailLockRet(result,sendData)
end

function PlayerData:DeleteMailResult(result,sendData)
	if result.result == Enum.success then
		maillist = result.dellist
		local nType = sendData.mailtype
		if("table" ~= type(maillist)) then
			trace("删除无返回数据")
			GameEvent:notifyView(GameEvent.updateMailUi)
			return
		end
	    local items_count = table.getn(maillist)

		--删除本地数据
		local mailInfo = self:GetMailByType(nType)
		local counts = mailInfo.sum
		for j=1,items_count  do
			for i,v in pairs(mailInfo.mails) do
				if maillist[j] == v.mailID then
					if(items_count ~= counts) then
						self:DeleteSingleMail(v.mailID,v.mailType,v.readstatus)
					end
					--聊天特殊处理
					if nType == Enum.Mail_playerchat then
						local vItem = self:GetMailByType(nType)
						for ii,iv in pairs(vItem.mails) do
							self:clearReadByID( iv.attach_im.playerID )
						end
					end
				end
			end
		end
		if(items_count == counts) then
			self:DelMailList(nType)
		end
		GameEvent:notifyView(GameEvent.UpdateMailCount)
		GameEvent:notifyView(GameEvent.updateMailUi)
	end
end

---账号绑定
function PlayerData:onUpdateBindAccounts(data)
    if data.accounts then
        for i,platformDate in pairs(data.accounts) do
            if platformDate.platformID then
                self.bindAccounts[platformDate.platformID] = platformDate
            end
        end
    end
    
    GameEvent:notifyView(GameEvent.updateBindAccounts)
end

function PlayerData:UpdateBindAccountsData(platformDate)
    if platformDate.platformID then
        self.bindAccounts[platformDate.platformID] = platformDate
    end
    
    GameEvent:notifyView(GameEvent.updateBindAccounts)
end

function PlayerData:delBindAccountsData(platformID)
    if self:getBindAccounts()[platformID] then
        self:getBindAccounts()[platformID] = nil
        GameEvent:notifyView(GameEvent.updateBindAccounts)
    end
end


function PlayerData:getBindAccounts()
    return self.bindAccounts
end

function PlayerData:getFacebookBindAccountName()
    return self:getBindAccounts()[Enum.bindActPlatform.facebook] and self:getBindAccounts()[Enum.bindActPlatform.facebook].platformAccount
end

function PlayerData:getGoogleBindAccountName()
    return self:getBindAccounts()[Enum.bindActPlatform.google] and self:getBindAccounts()[Enum.bindActPlatform.google].platformAccount
end

function PlayerData:isFirtBind()
    return self.playerEx and  self.playerEx.firstBind == 1
end

----------------------------- 商城 -----------------------------------------------
function PlayerData:updateMallGold( result )
    if result.gold then
        util.merge(self.mallGold, result.gold)
    end 
    GameEvent:notifyView(GameEvent.updateMallGold)
end

function PlayerData:updatemallGoldMod( result )
    if result.goldmod then
        util.merge(self.mallGoldMod, result.goldmod)
    end
    GameEvent:notifyView(GameEvent.updateMallGold)
end

function PlayerData:updatemallGift( result )
    if result.gift then
        util.merge(self.mallGift, result.gift)
    end
    GameEvent:notifyView(GameEvent.updateMallGold)
end

function PlayerData:updatemallGiftMod( result )
    if result.giftmod then
        util.merge(self.mallGiftMod, result.giftmod)
    end
    GameEvent:notifyView(GameEvent.updateMallGold)
end

function PlayerData:setMallGold( gid )
    local index
    for i,v in ipairs(self.mallGold) do
        if v.Gid == gid then
            index = i
        end
    end
    if index then
        self.mallGold[index] = {Gid = gid, buy = 1}
    else
        local info = {Gid = gid, buy = 1}
        table.insert(self.mallGold,info)
    end
    GameEvent:notifyView(GameEvent.updateMallGold)
end

function PlayerData:setMallGift( gid,stage  )
    local index
    for i,v in ipairs(self.mallGift) do
        if v.Gid == gid then
            index = i
        end
    end
    if index then
        self.mallGift[index] = {Gid = gid, stage = stage or 1, buy = 1}
    else
        local info = {Gid = gid, stage = 1, buy = 1}
        table.insert(self.mallGift,info)
    end
    GameEvent:notifyView(GameEvent.updateMallGold)
end

function PlayerData:getMallGold()
    return self.mallGold
end

function PlayerData:getMallGoldMod()
    return self.mallGoldMod
end

function PlayerData:getMallGift()
    return self.mallGift
end

function PlayerData:getMallGiftMod()
    return self.mallGiftMod
end

function PlayerData:updateGuide(result)
    if not result or not result.guide then
		return
	end
	self.guide = {}
	--util.merge(self.guide, result.guide)
	for k,v in pairs(result.guide) do
		--table.insert(self.guide,v)
		v.stepID = TemplateData:getNextStageStepId(v.guideID,v.stage)
		self.guide[v.guideID]=v
		--if v.guideID == 7 or v.guideID == 6 or v.guideID == 5  or v.guideID ==  10 or v.guideID ==  11 or v.guideID ==  8 then
			--v.finish = 0
			--v.stage = 0
			--v.finish = false
		--end
	end
end


-- 宝藏
function PlayerData:updateHelp( result )
   if result.askplayerAccount then
        self.helps = result.askplayerAccount
    end
    GameEvent:notifyView(GameEvent.updateHelp)
end

function PlayerData:getHelps()
    return self.helps
end

function PlayerData:updateHelpRecord( result )
   if result.result then
        self.helpRecord = result.result
    end
    GameEvent:notifyView(GameEvent.updateHelpRecord)
end

function PlayerData:getHelpRecord()
    return self.helpRecord
end

function PlayerData:resetHelpRecord()
    self.helpRecord = 0
end
----------------------------新手引导接口-------------------------------- begin
--获得引导数据
function PlayerData:getGuildCurrData(idx)
	if(not self.guide) then
		return
	end
	local guildObj = {}
	for k,v in pairs(self.guide) do
		if(idx == v.guideID) then
			guildObj = v
			break
		end
	end
	return guildObj
end

function PlayerData:judgeGuideFinish(idx)
	if("table" ~= type(self.guide)) then
		return
	end
	local finish = true
	for k,v in pairs(self.guide) do
		if(idx == tonumber(v.guideID)) then
			if(0 == v.finish) then
				finish = false
			end
			break
		end
	end
	return finish
end

function PlayerData:isInguiding()
	local flag = true
	if not self.guideID or self.guideID == 0 then
		flag = false
	end
	return flag
end

function PlayerData:getGuideID()
	return self.guideID
end

function PlayerData:getGuideStepID(idx)
	if(not idx) then
		idx = self.guideID
	end
	local guideObj = self:getGuildCurrData(idx)
	if guideObj.stepID then
		return guideObj.stepID
	end
end

function PlayerData:setGuideFinish(idx)
	if(not self.guide) then
		return
	end
	for k,v in pairs(self.guide) do
		if(idx == v.guideID) then
			v.finish = 1
			break
		end
	end
end

function PlayerData:setGuideNext(idx)
	if(not idx) then
		idx = self.guideID
	end
	local guideObj = self:getGuildCurrData(idx)
	if guideObj.stepID then
		guideObj.stepID = guideObj.stepID + 1
	end
end

function PlayerData:SaveCurrStepToServerRet(result)

end

function PlayerData:SaveCurrStepToServer()
	local stepID = self:getGuideStepID()
	local dataObj = TemplateData:getGuideConfigData(self.guideID,stepID)
	if type(dataObj) == "table" then
		if(dataObj.record > 0) then
			local finishFlag = 0
			if(dataObj.record == 2) then
				finishFlag=1
			end
			--通知服务端引导完成  -- 但客户端不一定完成
			GameTCP:sendRPC("guideFinish", {guideID = self.guideID,stage = dataObj.grade,finish=finishFlag}, self, self.SaveCurrStepToServerRet)
			--保存当前引导步奏
		end
		
		local num = TemplateData:getGuideConfigSum(self.guideID)
		if(self.guideID == 2) then
			num = 13
		end
		if(self.guideID == 4) then
			num = 2
		end
		
		if(stepID == num)then
			self:setGuideFinish(self.guideID)
			self:initGuideValue()
			return true
		end
	end
	return false
end

function PlayerData:initGuideValue()
	--当前正在引导的ID 步骤
	self.guideID = 0
end

--开始引导
function PlayerData:beginToGuide(idx)
	if(not util.getGuideFlag()) then
		return
	end
	 --引导已经完成
	if(self:judgeGuideFinish(idx)) then
		return
	end
	if(not self:isInguiding()) then
		self.guideID = idx --设置开启引导标志
		util.NotifyToNextGuiding()
	end
end

----------------------------新手引导接口--------------------------------end

----------------------------- 王座 -------------------------
-- 更新王座
function PlayerData:updateKing(packet)	
	self.throneData.playerID = packet.playerID
	self.throneData.guildID = packet.guildID
	self.throneData.head_image = packet.head_image
    self.throneData.name=packet.name
    self.throneData.guildName = packet.guildName
end

-- 更新王座
function PlayerData:updateMapInfo(packet)
	GameEvent:notifyView(GameEvent.updateThoneShow, packet)
end

-- 是否是国王
function PlayerData:isKingByPlayerId(playerId)
	if self.throneData.playerID == playerId then
		return true
	else
		return false
	end
end

-- 获取国王所在联盟id
function PlayerData:getKingAllianceId()
	return self.throneData.guildID or 0
end

-- 获取王座外观
function PlayerData:getThroneGuise()
	return self.throneData.head_image
end

--获得国王信息
function PlayerData:getKingData()
	return self.throneData
end

----------------------------------------
--获取已经获得的邀请奖励数
function PlayerData:getGiftNum()
	return self.player.isgetGift or 0
end

function PlayerData:setGiftNum(num)
	self.player.isgetGift  = num
end

function PlayerData:jumpMapNearlyRet(result)
	local resourceObj = result.resourceObj
	local country = 1
	GeneralHelper:enterBigMap(country, resourceObj.x, resourceObj.y)
end

function PlayerData:jumpMapNearly(event)
	local t = event.data
	GameTCP:sendRPC("mapSearchResource",{x=t.x,y=t.y,resourceType=t.resourceType},self,self.jumpMapNearlyRet)
end

function PlayerData:setGuideOpen(flag)
	self.guideflag = flag
end

function PlayerData:getGuideOpenParam()
	return self.guideflag
end

function PlayerData:getAllianceReqTime()
	return self.reqTime
end

function PlayerData:setAllianceReqTime(currTime)
	self.reqTime = currTime
end

function PlayerData:getAllianceData()
	return self.eventList
end

return PlayerData