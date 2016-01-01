--
-- Author: Your Name
-- Date: 2015-07-13 14:03:00
--模板数据     所有模板数据这这边操作   不要加入玩家数据
local TemplateData = class("TemplateData")

function TemplateData.create()
	return TemplateData.new()
end

function TemplateData:ctor()

end

---------------------------------------建筑系列------------------------------------------
--得到建筑数据
function TemplateData:getBuilds()
    if self.builds ==nil then
        self.builds =  require( "config.building" )
    end
    return self.builds
end

--得到位置数据
function TemplateData:getPosition()
	if self.position ==nil then
		self.position =  require("config.position")
	end
	return self.position
end

--得到位置数据
function TemplateData:getPositionLock()
    if self.positionLock ==nil then
        self.positionLock =  require("config.position_unlock")
    end
    return self.positionLock
end


function TemplateData:getPositionInfo(pos)
    return self:getPosition()[pos]
end


--得到建筑
function TemplateData:getBuildWithType( buildType )
    if buildType == nil then
        return nil
    end

    if self.builds ==nil then
        self:getBuilds()
    end

    for k, v in pairs( self.builds ) do
        if k == buildType then
            return v
        end
    end

    printLog( "TemplateData:getBuildWithType", "建筑找不到:buildType = %d", buildType )
end

--得到建筑
function TemplateData:getBuildWithTypeLvl( buildType, buildLvl )
    if buildType == nil or buildLvl == nil then
        return nil
    end
    if buildLvl == nil or buildLvl <= 0 then
        buildLvl = 1
    end

    local builds = self:getBuildWithType( buildType )

    if buildLvl > #builds then
        return nil
    end
    local build = builds and builds[buildLvl]

    if build ~= nil then
        return build
    end

    printLog( "TemplateData:getBuildWithTypeLvl", "建筑找不到:buildType = %d buildLvl = %d", buildType, buildLvl )
end

--得到建筑名称
function TemplateData:getBuildName( buildType, buildLvl )
    if buildType == nil then
        return nil
    end

    if buildLvl == nil or buildLvl <= 0 then
        buildLvl = 1
    end

    local build = self:getBuildWithTypeLvl( buildType, buildLvl )
    return build and Language.get(build.name) or ""
end

-- 根据名称获得建筑类型
function TemplateData:getBuildTypeByName( nameID )
    nameID = tonumber(nameID)
    local builds = TemplateData:getBuilds()
    for buildType,v in pairs(builds) do
        if v[1].name == nameID then
            return buildType
        end
    end
end

--得到解锁的兵种ID
function TemplateData:getLockArmsID( buildType, buildLvl )
    if buildType == nil then
        return nil
    end

    if buildLvl == nil or buildLvl <= 0 then
        buildLvl = 1
    end

    local builds = self:getBuildWithType( buildType )

    local lockManArr = nil
    for i,v in ipairs( builds ) do
        if i > buildLvl then
            break
        end
        if  v.rman ~= nil and v.rman ~= 0 then
            if lockManArr == nil then lockManArr = {} end
            lockManArr[v.rman] = false
        end
    end

    if lockManArr ~= nil then
        return lockManArr
    end

    printLog( "TemplateData:getLockArmsID", "人物没解锁,该建筑:buildType = %d,buildLvl = %d", buildType, buildLvl )
end

--得到即将解锁的兵种（当前的不算）
--@param：buildType：建筑等级
--@param：buildLvl：当前建筑等级
--@return：nil or table：{buildLvl, armsInfo}
function TemplateData:getWillLockArms( buildType, buildLvl )
    if buildType == nil or buildLvl == nil then
        return nil
    end

    local tbl = nil
    local build = self:getBuildWithType( buildType )
    local lvlSum = #build
    for i = buildLvl + 1, lvlSum do
        local buildTempInfo = self:getBuildWithTypeLvl( buildType, i )
        local tmp = tonumber( buildTempInfo.rman )
        if tmp ~= 0 then
            tbl = {}
            tbl.buildLvl = i
            tbl.armsInfo = self:getArmsWithID( tmp )
            break
        end
    end

    if tbl == nil then
        printLog( "TemplateData:getWillLockArms", "没有找到将要解锁的兵种,是否已经最高等级？buildType = %d,buildLvl = %d", buildType, buildLvl )
    end

    return tbl
end


--根据解锁兵的ID得到建筑等级
function TemplateData:getLvlWithArmsID( buildType, armsID )
    if armsID == nil or buildType == nil then
        return
    end

    local builds = self:getBuildWithType( buildType )

    local lv = nil
    for i,v in ipairs( builds ) do
        if v.rman == armsID then
            lv = v.lv
            break
        end
    end

    if lv ~= nil then
        return lv
    end

    printLog( "TemplateData:getLvlWithArmsID", "buildType = %d 的 armsID = %d 找不到", buildType, armsID )
end

--得到单次最大训练量（仅限于：兵营、马厩、靶场、战车工坊）
function TemplateData:getMaxTrainOneWithBuild( buildType, buildLvl )
    if buildType == nil then
        return nil
    end

    if buildLvl == nil then
        buildLvl = 1
    end

    local build = self:getBuildWithTypeLvl( buildType, buildLvl )
    local trainMax = build.ntrain

    if trainMax ~= nil and trainMax ~= 0 then
        return trainMax
    end

    printLog( "TemplateData:getMaxTrainOneWithBuild", "buildType = %d 的 ntrain 异常", buildType )
end

--得到单个行军帐篷，最大容量（即：军队最大值）
function TemplateData:getMarchVolume( marchLvl )
    if marchLvl == nil then
        marchLvl = 1
    end

    local build = self:getBuildWithTypeLvl( Enum.type.march, marchLvl )
    local volume = build.soldiers

    if volume ~= nil and volume ~= 0 then
        return volume
    end

    printLog( "TemplateData:getMarchVolume", "行军帐篷 等级 = %d 的 soldiers 异常", marchLvl )
end

--得到单个急救帐篷，最大容量
function TemplateData:getEmergencyVolume( emergencyLvl )
    if emergencyLvl == nil then
        emergencyLvl = 1
    end

    local build = self:getBuildWithTypeLvl( Enum.type.emergency, emergencyLvl )
    local volume = build.wound

    if volume ~= nil and volume ~= 0 then
        return volume
    end

    printLog( "TemplateData:getEmergencyVolume", "急救帐篷 等级 = %d 的 wound 异常", emergencyLvl )
end

--得到单个急救帐篷，转化率
function TemplateData:getEmergencyRate( emergencyLvl )
    if emergencyLvl == nil then
        emergencyLvl = 1
    end

    local build = self:getBuildWithTypeLvl( Enum.type.emergency, emergencyLvl )
    local volume = build.atkwoundrate

    if volume ~= nil and volume ~= 0 then
        return volume
    end

    printLog( "TemplateData:getEmergencyVolume", "急救帐篷 等级 = %d 的 wound 异常", emergencyLvl )
end


--得到单次最大陷阱建造量（仅限于：战车工坊）
function TemplateData:getMaxPitfallOne( warfortLvl )
    if warfortLvl == nil then
        warfortLvl = 1
    end

    local build = self:getBuildWithTypeLvl( Enum.type.warfort, warfortLvl )
    local trainMax = build.ntrain
    local tMax = {}

    if trainMax ~= nil and trainMax ~= "" then
        local tmp = nil
        for w in string.gmatch( trainMax, "%d+" ) do
            if tmp == nil then
                tmp = tonumber( w )
            else
                tMax[tmp] = tonumber( w )
                tmp = nil
            end
        end
    else
        printLog( "TemplateData:getMaxTrainOneWithBuild", "战车工坊 等级 = %d 的 ntrain 异常", warfortLvl )
    end

    return tMax
end

--得到最大陷阱建造量（此数据在“城墙”的）
--@param：wallLvl：城墙等级
function TemplateData:getPitfallVolume( wallLvl )
    if wallLvl == nil then
        wallLvl = 1
    end

    local build = self:getBuildWithTypeLvl( Enum.type.wall, wallLvl )
    local volume = build.trap

    if volume ~= nil and volume ~= 0 then
        return volume
    end

    printLog( "TemplateData:getPitfallVolume", "城墙 等级 = %d 的 trap 异常", trap )
end

 --得到 单支部队 的 最大出征 人数（此数据在“校场”的）
--@param：assemblyPlaceLvl：校场等级
function TemplateData:getExpeditionVolume( assemblyPlaceLvl )
    if assemblyPlaceLvl == nil then
        assemblyPlaceLvl = 1
    end

    local build = self:getBuildWithTypeLvl( Enum.type.assemblyPlace, assemblyPlaceLvl )
    local volume = build.army

    if volume ~= nil and volume ~= 0 then
        return volume
    end

    printLog( "TemplateData:getExpeditionVolume", "校场 等级 = %d 的 volume 异常", assemblyPlaceLvl )
end

---------------------------------------建筑领域系列------------------------------------------
function TemplateData:getBuildsField()
    if self.buildsField ==nil then
        self.buildsField = require( "config.buildingfield" )
    end
    return self.buildsField
end

function TemplateData:getBuildsFieldWithType( buildType )
    if buildType == nil then
        return nil
    end

    if self.buildsField == nil then
        self:getBuildsField()
    end

    for i,v in ipairs( self.buildsField ) do
        if i and v then
            if v.buildingID == buildType then
                return v
            end
        end
    end

    printLog( "TemplateData:getBuildsField", "数据找不到,buildType = %d", buildType )
end

function TemplateData:getTextcnWithBuildsField( buildType )
    local data = self:getBuildsFieldWithType( buildType )
    local str = data.textcn
    if str == "" or str == nil then
        return nil
    end

    local textcn = {}
    for w in string.gmatch( str, "%d+" ) do
        textcn[#textcn + 1] = w
    end

    return textcn
end

function TemplateData:getDetailsuiWithBuildsField( buildType )
    local data = self:getBuildsFieldWithType( buildType )
    local str = data.detailsui
    if str == "" or str == nil then
        return nil
    end

    local detailsui = {}
    for w in string.gmatch( str, "%a+" ) do
        detailsui[#detailsui + 1] = w
    end

    return detailsui
end



function TemplateData:getOthWithBuildsField( buildType )
    local data = self:getBuildsFieldWithType( buildType )
    local str = data.oth
    if str == "" or str == nil then
        return nil
    end

    local oth = {}
    for lv,msg in string.gmatch( str, "(%d+),(%d+)" ) do
        oth[tonumber(lv)] = msg
    end

    return oth
end


function TemplateData:getInfuiWithBuildsField( buildType )
    local data = self:getBuildsFieldWithType( buildType )
    local str = data.infui
    if str == "" or str == nil then
        return nil
    end

    local infui = {}
    for w in string.gmatch( str, "%a+" ) do
        infui[#infui + 1] = w
    end

    return infui
end

function TemplateData:getInfuidesWithBuildsField( buildType )
    local data = self:getBuildsFieldWithType( buildType )
    local str = data.infuides
    if str == "" or str == nil then
        return nil
    end

    local infuides = {}
    for w in string.gmatch( str, "%d+" ) do
        infuides[#infuides + 1] = w
    end

    return infuides
end

---------------------------------------兵种系列------------------------------------------
--得到兵种数据
function TemplateData:getArms()
    if self.arms ==nil then
        self.arms =  require( "config.arms" )
    end
    return self.arms
end

--得到兵信息
function TemplateData:getArmsWithID( armsID )
    if armsID == nil then
        return
    end

    if self.arms ==nil then
        TemplateData:getArms()
    end

    -- for k, v in pairs( self.arms ) do
        -- if v.ID == armsID then
            -- return v
        -- end
    -- end

	if self.arms[armsID] then
		return self.arms[armsID]
	end

    printLog( "TemplateData:getArmsWithID", "兵种找不到:%d", armsID )
end

function TemplateData:getArmsName(id)
    return Language.get(self:getArmsWithID(id).name)
end

function TemplateData:getArmsIcon(id)
    return self:getArmsWithID(id) and self:getArmsWithID(id).icon
end
--得到兵种
function TemplateData:getArmsWithBuildType( buildType )
    if buildType == nil then
        return nil
    end

    if self.arms ==nil then
        TemplateData:getArms()
    end

    local armsArr = {}
    for k, v in pairs( self.arms ) do
        if v.btype == buildType then
            armsArr[#armsArr + 1] = v
        end
    end

    if #armsArr == 0 then
        printLog( "TemplateData:getArmsWithBuildType", "建筑对应兵种找不到:%d", buildType )
        return nil
    end

    table.sort( armsArr, function( a, b )
        return a.alv < b.alv  --等级排序
    end)

    return armsArr
end

---------------------------------------技能系列------------------------------------------
--得到技能数据
function TemplateData:getSkill()
    if self.skill ==nil then
        self.skill =  require( "config.skill" )
    end
    return self.skill
end

--得到技能信息
function TemplateData:getSkillWithID( skillID )
    if skillID == nil then
        return
    end

    if self.skill ==nil then
        TemplateData:getSkill()
    end

    for k, v in pairs( self.skill ) do
        if v.ID == tonumber( skillID ) then
            return v
        end
    end

    printLog( "TemplateData:getSkillWithID", "技能找不到:%d", skillID )
end

---------------------------------------设置语言------------------------------------------
--得到 语言的设置
function TemplateData:getLanguageSet()
    if self.languageSet == nil then
        self.languageSet =  require( "config.language" )
    end
    return self.languageSet
end

--得到 语言设置
--@return：nil or Enum.gameLanguage
function TemplateData:getLanguageSetWithID( languageID )
    if languageID == nil then
        return
    end

    self:getLanguageSet()

    for i, v in ipairs( self.languageSet ) do
        if i and v then
            if i == languageID then
                return v
            end
        end
    end

    printLog( "TemplateData:getLanguageSet", "语言设置找不到:%d", languageID )
    return nil
end

--得到 语言设置 是否存在
--@param：languageID：Enum.gameLanguage
--@param：type：0（查找所有类型，默认），1（语言包设置），2（翻译设置）
--@return：bool
function TemplateData:isLanguageSetWithID( languageID, type )
    if languageID == nil or languageID == "" then
        return false
    end

    local data = nil
    if type == nil or type == 0 then
        data = self:getLanguageSet()
    elseif type == 1 then
        data = self:getSwitchableLanguageSet()
    elseif type == 2 then
        data = self:getTranslateLanguageSet()
    end

    for i, v in ipairs( data ) do
        if i and v then
            if i == languageID then
                return true
            end
        end
    end

    return false
end

--得到 可切换的语言设置
function TemplateData:getSwitchableLanguageSet()
    self:getLanguageSet()

    data = {}
    for i, v in ipairs( self.languageSet ) do
        if i and v then
            if v.language_icon ~= nil and v.language_icon ~= "" then
                data[#data + 1] = v
            end
        end
    end

    if #data == 0 then
        printLog( "TemplateData:getSwitchableLanguageSet", "未找到可切换的语言" )
        return nil
    else
        table.sort( data, function( a, b )
            return a.id < b.id
        end )
        return data
    end
end

--得到 可翻译的语言设置
function TemplateData:getTranslateLanguageSet()
    self:getLanguageSet()

    data = {}
    for i, v in ipairs( self.languageSet ) do
        if i and v then
            if v.translation ~= nil or v.translation ~= "" then
                data[#data + 1] = v
            end
        end
    end

    if #data == 0 then
        printLog( "TemplateData:getTranslateLanguageSet", "未找到可翻译的语言" )
        return nil
    else
        table.sort( data, function( a, b )
            return a.translation < b.translation
        end )
        return data
    end
end

function TemplateData:getTranslateKey(iLanguage)
    local table = {
        [Enum.gameLanguage.EN] = "en",        --英语
        [Enum.gameLanguage.FR] = "fr",       --法语
        [Enum.gameLanguage.DE] = "de",      --德语
        [Enum.gameLanguage.RU] = "ru",       --俄语
        [Enum.gameLanguage.KR] = "ko",      --韩语
        [Enum.gameLanguage.TH] = "th",      --泰语
        [Enum.gameLanguage.JP] = "ja",       --日本语
        [Enum.gameLanguage.BrPr] = "pt",      --葡萄牙语
        [Enum.gameLanguage.ES] = "es",     --西班牙语
        [Enum.gameLanguage.TR] = "tr",      --土耳其
        [Enum.gameLanguage.ID] = "id",      --印度尼西亚语
        [Enum.gameLanguage.CNTW] = "zh-CHT",      --繁体中文
        [Enum.gameLanguage.CN] = "zh-CHS",     --简体中文
        [Enum.gameLanguage.IT] = "it",     --意大利语
        [Enum.gameLanguage.PL] = "pl",      --波兰语
        [Enum.gameLanguage.LU] = "nl",      --荷兰语
        [Enum.gameLanguage.AE] = "ar",     --阿拉伯语

        [Enum.gameLanguage.DK] = "da",      --丹麦语
        [Enum.gameLanguage.GK] = "el",     --希腊语
        [Enum.gameLanguage.FH] = "fi",      --芬兰语
        [Enum.gameLanguage.SH] = "sv",      --瑞典语
        [Enum.gameLanguage.VE] = "vi",      --越南语
        [Enum.gameLanguage.MA] = "ms",      --马来语
    }

    return iLanguage and table[iLanguage] or table[Enum.gameLanguage.CN]
end

---------------------------------------消息类型设置------------------------------------------
--得到 消息类型的设置
function TemplateData:getMessageType()
    if self.messageType == nil then
        self.messageType = require( "config.message_type" )
    end
    return self.messageType
end

--得到 消息类型的设置
function TemplateData:getMessageTypeWithID( messageTypeID )
    if messageTypeID == nil then
        return
    end

    self:getMessageType()

    for i, v in ipairs( self.messageType ) do
        if i and v then
            if v.id == messageTypeID then
                return v
            end
        end
    end

    printLog( "TemplateData:getMessageTypeWithID", "没找到消息类型：%d", messageTypeID )
end

---------------------------------------消息设置------------------------------------------
--得到 消息设置
function TemplateData:getMessage()
    if self.message == nil then
        self.message =  require( "config.message" )
    end
    return self.message
end

--得到 消息设置
function TemplateData:getMessageWithID( messageID )
    if messageID == nil then
        return
    end

    self:getMessage()

    for i, v in ipairs( self.message ) do
        if i and v then
            if v.id == messageID then
                return v
            end
        end
    end

    printLog( "TemplateData:getMessageWithID", "没找到消息：%d", messageID )
end

--得到 消息设置数组 根据 消息类型
function TemplateData:getMessageWithMessageTypeID( messageTypeID )
    if messageTypeID == nil then
        return
    end

    self:getMessage()

    local data = {}
    for i, v in ipairs( self.message ) do
        if i and v then
            if v.message_type == messageTypeID then
                data[#data + 1] = v
            end
        end
    end

    if #data == 0 then
        printLog( "TemplateData:getMessageWithMessageTypeID", "该组没找到任何消息：%d", messageTypeID )
    end

    return data
end

---------------------------------------邀请 奖励------------------------------------------
--得到 邀请奖励
function TemplateData:getInviteReward()
    if self.inviteReward == nil then
        self.inviteReward =  require( "config.invite_reward" )
    end
    return self.inviteReward
end

 --得到 邀请奖励
function TemplateData:getInviteRewardWithID( id )
    if id == nil then
        return
    end

    self:getInviteReward()

    for i,v in ipairs( self.inviteReward ) do
        if i and v then
            if v.id == id then
                return v
            end
        end
    end

    printLog( "TemplateData:getInviteRewardWithID", "id未找到:%d", id )
end

--得到 是否可以领取奖励
--@inviteNum：已经邀请的人数
--@return：flg：true or false
--@return：limId：flg == true 返回 奖励的ID，flg == false 返回 奖励最接近的ID
function TemplateData:getInviteIsReward( inviteNum )
    if inviteNum == nil or inviteNum <= 0 then
        return false, 0
    end

    self:getInviteReward()

    local minDt = 0xfffff
    local limId = 1

    for i, v in ipairs( self.inviteReward ) do
        if i and v then
            local str = v.invite_count
            local block = {}
            for w in string.gmatch( str, "%d+" ) do
                block[#block + 1] = w
            end

            if inviteNum == tonumber( block[1] ) then
                return true, v.id
            else
                local dt = inviteNum - block[1]
                if dt >= 0 then
                    if dt <= minDt then
                        limId = v.id
                        minDt = dt
                    end
                end
            end

        end
    end

    return false, limId
end

---------------------------------------城堡增益系列------------------------------------------

--得到增益数据
function TemplateData:getCityBuff()
    if self.citybuff ==nil then
        self.citybuff =  require( "config.citybuff" )
    end
    return self.citybuff
end

--得到增益信息
function TemplateData:getBuffWithType( buffType )
    if buffType == nil then
        return
    end

    if self.citybuff ==nil then
        TemplateData:getCityBuff()
    end

    if self.citybuff[buffType] == nil then
        printLog( "TemplateData:getBuffWithType", "城堡增益未找到:%d", buffType )
        return nil
    end
    return self.citybuff[buffType]

end

--数据解析

--获取增益名
function TemplateData:getBuffName(info)
    if type(info) ~= "table" then
        trace("TemplateData getBuffName unknow buff info")
        return
    end
    if info.item then
        local itemInfo =  TemplateData:getItem(info.item)
        return itemInfo and itemInfo.name and Language.get(itemInfo.name) or ("item"..info.item)
    end
    --具体增益直接获取，增益类别则从它的第一个子表中获取
    local strID = info[1] and info[1].name or info[1].name1
    if strID then
        return  Language.get(strID)
    end

    trace("TemplateData getBuffName get no buff info buffType = "..tostring(strID))
    return "buffName"
end


--获取增益描述
function TemplateData:getBuffDesc(info)
    if type(info) ~= "table" then
        trace("TemplateData getBuffDesc unknow buff info")
        return
    end
    if info.item then
        local itemInfo =  TemplateData:getItem(info.item)
        return itemInfo and itemInfo.describe and Language.get(itemInfo.describe)  or ("item"..info.item)
    end
    local strID = info[1] and info[1].describe

    if strID then
        return  Language.get(strID)
    end

    print("BuffData getBuffDesc get no buff info buffType = "..tostring(info))
    return "buffDesc"
end

--获取图标
function TemplateData:getBuffIcon(info)
    local itemID = info.item or info[1] and info[1].item
    if itemID then
        local itemInfo =  TemplateData:getItem(itemID)
        if itemInfo and itemInfo.icon then
            return itemInfo.icon..".png"
        end
    end

    print("BuffData getBuffIcon fail ")
    return ""
end


--获取类型
function TemplateData:getBuffType(info)
    local itemID = info.item or info[1] and info[1].item
    if itemID then
        local itemInfo =  TemplateData:getItem(itemID)
        if itemInfo and itemInfo.type then
            return itemInfo.type
        end
    end

    print("BuffData getBufftype fail ")
    return ""
end

--获取价格
function TemplateData:getBuffPrice(info)
    local itemID = info.item or info[1] and info[1].item
    if itemID then
        local itemInfo =  TemplateData:getItem(itemID)
        if itemInfo and itemInfo.price then
            return tostring(itemInfo.price)
        end
    end

    print("BuffData getBuffIcon fail ")
    return ""
end



--增益对应的物品名
function TemplateData:getBuffItemName(info)
    local itemInfo =  TemplateData:getItem(info.item)
    if itemInfo and itemInfo.name then
        return itemInfo.name
    end

    print("BuffData getBuffItemName get no buff info buffType = "..buffType.." index = "..index)
    return "buffItemName "..buffType
end

function TemplateData:getBuffItemDesc(info)
    local itemInfo =  TemplateData:getItem(info.item)
    if itemInfo and itemInfo.describe then
        return itemInfo.describe
    end

    print("BuffData getBuffItemName get no buff info buffType = "..buffType.." index = "..index)
    return "buffItemDescribe "..buffType
end


--物品是否是增益,返回增益类别
function TemplateData:isBuffItem(itemID)
    local buffs = TemplateData:getCityBuff()
    for i,j in pairs(buffs) do
        for _,buffItem in pairs(j) do
            if buffItem.item == itemID then
                return i
            end
        end
    end

    return nil
end


---------------------------------------------------------------------------------

function TemplateData:getBusinessmanBuyID(ID)
	if self.businessmanData ==nil then
		self.businessmanData =  require("config.businessman")
	end
    self.businessman = self.businessmanData[ID] or {}
    return self.businessman
end


---------------------------------获取物品信息-------------
function TemplateData:getItems()
    if self.item ==nil then
        self.item = require("config.item")
    end
end

function TemplateData:getItem(id)
    self:getItems()
    id = tonumber(id)

    local info = self.item[id]
    if info then
        return info
	else
		info = self.item[190001]
		return info
    end
    --print("getItem error 找不到对应id的道具或者装备 "..id)
    return nil
end


function TemplateData:getItemName(id)
    return Language.get(self:getItem(id).name)
end

function TemplateData:getItemIcon(id)
    local icon = self:getItem( id ).icon
    icon = icon .. ".png"
    return icon
end

function TemplateData:getItemPrice(id)
    local price = self:getItem( id ).price
    return tonumber(price)
end

function TemplateData:getSameItems(item)
   self:getItems()
   local temp = {}
   for k,v in pairs(self.item) do
       if v.type == item.type and v.param1 == item.param1 then

        table.insert(temp,v)
        end
   end

    table.sort( temp, function( a, b )
        return a.ID < b.ID  --等级排序
    end)

    return temp
end



function TemplateData:getSpeedUpItems()
    self:getItems()
    if self.speedUpItems == nil then
        self.speedUpItems ={}
        for k,v in pairs(self.item) do
            if v.type == 4 then
                table.insert(self.speedUpItems,v)
            end
        end
    end
    return self.speedUpItems
end

--行军加速物品
local ITEM_SPEEDUP = 200220  --行军加速物品ID
local ITEM_SPEEDUP_HIGH = 200221 --高级行军加速物品ID
function TemplateData:getArmSpeedUpItems()
    self:getItems()
    if self.armSpeedUpItems == nil then
        self.armSpeedUpItems ={}
        table.insert(self.armSpeedUpItems,self.item[ITEM_SPEEDUP])
        table.insert(self.armSpeedUpItems,self.item[ITEM_SPEEDUP_HIGH])
    end
    return self.armSpeedUpItems
end

--行军加速物品所加的速度 250和500
function TemplateData:getItemSpeed(itemID)
    self:getItems()
    if itemID == ITEM_SPEEDUP or itemID==ITEM_SPEEDUP_HIGH then
        return self.item[itemID].param2
    end

    return 0
end
--召回物品
function TemplateData:getCallBackArmyItemID()
    return 200004
end

--高级召回(解散)
function TemplateData:getDissolveItems()
    self:getItems()
    -- if self.armyCallBackItems == nil then
        local itemID = 200021
        self.armyCallBackItems ={}
        table.insert(self.armyCallBackItems,self.item[itemID])
    -- end
    return self.armyCallBackItems
end

function TemplateData:getCallBackArmyItems()
    self:getItems()
    if self.armyCallBackItems == nil then
        local itemID = self:getCallBackArmyItemID()
        self.armyCallBackItems ={}
        table.insert(self.armyCallBackItems,self.item[itemID])
    end
    return self.armyCallBackItems
end

function TemplateData:getQuickRes()
    if self.quickRes ==nil then
        self.quickRes = require("config.resource_use")
    end
    return self.quickRes
end

--获得联盟物品
function TemplateData:getAllianceGoods()
    self:getItems()
    if self.allianceItems == nil then
        self.allianceItems ={}
        for k,v in pairs(self.item) do
            if v.alliance_order ~= "" then
                table.insert(self.allianceItems,v)
            end
        end
    end

    table.sort( self.allianceItems, function( a, b )
        return a.alliance_order < b.alliance_order  --等级排序
    end)

    return self.allianceItems
end

--获得商城物品
function TemplateData:getShopGoods()
    self:getItems()
    if self.shopItems == nil then
        self.shopItems ={}
        for k,v in pairs(self.item) do
            if v.store_order ~= "" then
                table.insert(self.shopItems,v)
            end
        end
    end

    table.sort( self.shopItems, function( a, b )
        return a.store_order < b.store_order  --等级排序
    end)

    return self.shopItems
end

function TemplateData:getPlayerHead(id)

end

-------------------------------------玩家exp
function TemplateData:getPlayerExpByLv(lv)
    if self.exp ==nil then
        self.exp =  require( "config.exp" )
    end

    local info = self.exp[lv]
    if info then
        return info
    end
    print("exp 找不到对应等级需要的经验 "..(id or "nil"))
    return nil
end

---------------------------------------大地图 城堡 对应资源图
-- 获取兵种头像icon
function TemplateData:getSoldierHeadImg(btype, level)
	local str = "ico107"
	level = level-1
	if btype == 13 then
		level = "00"..level
	elseif btype == 14 then
		level = "10"..level
	elseif btype == 15 then
		level = "20"..level
	elseif btype == 16 then
		level = "30"..level
	end
	str = str..level.."_small.png"
	return str
end

-- 获取兵种等级icon
function TemplateData:getSoldierLevelImg(level)
	return "Roman_"..level..".png";
end

-- 城堡
function TemplateData:getCastle()
	if not self.castle then
		self.castle = require("config.castle")
	end
	return self.castle
end

-- 资源 木材 粮食 铁矿 秘银 金币
function TemplateData:getResource()
	if not self.resource then
		self.resource = require("config.resource")
	end
	return self.resource
end

function TemplateData:getResourceItem(id)
    self:getResource()
    id = tonumber(id)

    local info = self.resource[id]
    if info then
        return info
    end
    return nil
end

--@param：resType：资源类型（Enum.map_resource_type）
function TemplateData:getMapResourceWithType( resType )
    self:getResource()
    for i, v in ipairs( self.resource ) do
        if i and v then
            if v.resource_type == resType then
                return v
            end
        end
    end

    return nil
end


function TemplateData:getResourceAmount()
	if not self.resource_amount then
		self.resource_amount = require("config.resource_amount")
	end
	return self.resource_amount
end

function TemplateData:getResourceAmountItem(id)
    self:getResourceAmount()
    id = tonumber(id)

    local info = self.resource_amount[id]
    if info then
        return info
    end
    return nil
end

function TemplateData:getResourceType(resourceId)
	if resourceId >= 101 and resourceId <= 300 then -- 木材 粮食 铁矿 秘银 金币
		local tData = self:getResourceAmount()[resourceId]
		return tData.resource_type
	end
	return nil
end

function TemplateData:getResourceIcon(resourceId)
	local tData = self:getResourceAmount()[resourceId]
	local rType = tData.resource_type
	local imgId = ""
	if rType == 1 then
		imgId = "ui_wood.png"
	elseif rType == 2 then
		imgId = "ui_food.png"
	elseif rType == 3 then
		imgId = "ui_iron.png"
	elseif rType == 4 then
		imgId = "ui_stone.png"
	else
		imgId = "ui_gold.png"
	end
	return imgId
end

-- 怪物
function TemplateData:getMonster()
	if not self.monster then
		self.monster = require("config.monster")
	end
	return self.monster
end

function TemplateData:getMonsterItem(id)
    self:getMonster()
    id = tonumber(id)

    local info = self.monster[id]
    if info then
        return info
    end
    return nil
end

-- 怪物描述
function TemplateData:getMonsterDesc()
	if not self.monster_desc then
		self.monster_desc = require("config.monster_desc")
	end
	return self.monster_desc
end

-- 遗迹
function TemplateData:Ruin()
	if not self.ruin then
		self.ruin = require("config.ruin")
	end
	return self.ruin
end

-- 行军速度
function TemplateData:getUnitMarch()
	if not self.unit_march then
		self.unit_march = require("config.unit_march")
	end
	return self.unit_march
end

-- 获取行军速度倍数
function TemplateData:getMarchLandSpeed(purpose)
	local mType
	if purpose == Enum.BigMap_expedition_detect or purpose == Enum.BigMap_expedition_detect_other then -- 侦查
		mType = 2
	elseif purpose == Enum.BigMap_expedition_business then -- 资源援助
		mType = 4
	elseif purpose == Enum.BigMap_expedition_storage or purpose == Enum.BigMap_expedition_take then -- 仓库存储 取出
		mType = 5		
	elseif purpose == Enum.BigMap_expedition_attack_monster then -- 打怪
		mType = 3
	elseif purpose == Enum.BigMap_expedition_attack_other then -- 攻击其它玩家
		mType = 1
	else -- 普通
		mType = 1
	end
	if not self.unit_march then
		self:getUnitMarch()
	end
	local mud_rate = self.unit_march[1]["speed_mud_rate"]
	local tab = {100,1,100,1,1}
	if not self.marchSpeedStr then
		-- 普通 侦查 打怪
		self.marchSpeedStr = {
			"speed_normal",			-- 普通
			"speed_normal_scout",	-- 侦查
			"speed_normal_monster", -- 打怪
			"speed_reshelp", -- 资源援助
			"speed_deposit", -- 仓库存取
		}
	end
	local num = tab[mType]
	local newTab = {}
	local tempKey = self.marchSpeedStr[mType]
	table.insert(newTab, self.unit_march[1][tempKey]/num) -- 在普通土地上的速度
	table.insert(newTab, newTab[1]/mud_rate) -- 在黑土地上的速度
	return newTab
end

-- 通过出征目的获取兵种速度
function TemplateData:getArmSpeed2(purpose, armyTab)
	if purpose == Enum.BigMap_expedition_detect or
	   purpose == Enum.BigMap_expedition_detect_other or
	   purpose == Enum.BigMap_expedition_business or     -- 资源援助
	   purpose == Enum.BigMap_expedition_storage or -- 仓库存储
	   purpose == Enum.BigMap_expedition_take then  -- 仓库取出
		return 1
	else
		local tab = util.split(armyTab)
		local num
		for k,v in pairs(tab) do
			local march_speed = TemplateData:getArmSpeed(v[1])
			if not num then
				num = march_speed
			else
				if march_speed < num then
					num = march_speed
				end
			end
		end
		local num1 = num or 0
		return num1
	end
end

-- 获取兵种速度
function TemplateData:getArmSpeed(armsID)
	 self:getArms()
	 return self.arms[armsID].march_speed
end

-- 码头
function TemplateData:Rock()
	if not self.rock then
		self.rock = require("config.ship")
	end
	return self.rock
end

--获取装备
function TemplateData:getEquips()
    if self.equip ==nil then
        self.equip = require("config.equipment")
    end
end

function TemplateData:getEquip(id)
    self:getEquips()
    id = tonumber(id)

    local info = self.equip[id]
    if info then
        return info
    end
    print("getItem error 找不到对应id的装备 "..id)
    return nil
end

function TemplateData:getEquipName(id)
    return self:getEquip(id) and Language.get( self:getEquip(id).name)
end


--获取铁匠铺装备品种
function TemplateData:getSmithy(itype)
    if not self.Smithy then
        self.Smithy = require("config.equipment")
    end
    local temp = {}
    for k,v in pairs(self.Smithy) do
        if v.type == itype and v.quality == 6 then

            table.insert(temp,v)
        end
    end


    table.sort( temp, function( a, b )
        return a.lv > b.lv  --等级排序
    end)

    return temp
end

--获取铁匠铺装备
function TemplateData:getSmithyitem(id)
    if not self.Smithy then
        self.Smithy = require("config.equipment")
    end
    id = tonumber(id)

    local info = self.Smithy[id]
    if info then
        return info
    end

    print("getItem error 找不到对应id的装备 "..itype)
    return nil
end

--成就获取
function TemplateData:getAchieveByType(params)
    local require1 = params
    if self.achieve ==nil then
        self.achieve = require( "config.achieve" )
    end
    local dataList = {}
    for k,v in pairs(self.achieve) do
        if v.require1 == require1 then
            table.insert(dataList,v)
        end
    end
    return dataList
end

--成就获取
function TemplateData:getAchieve()
    if self.achieve ==nil then
        self.achieve = require( "config.achieve" )
    end
    return self.achieve
end

--学院研究类型
function TemplateData:getScienceType()
    if self.sciencetype ==nil then
        self.sciencetype = require( "config.sciencetype" )
    end
    return self.sciencetype
end

--学院研究
function TemplateData:getScienceStudyConfig()
    if self.science_study ==nil then
        self.science_study = require( "config.science_study" )
    end
    return self.science_study
end

--学院研究
function TemplateData:getScience()
    if self.science ==nil then
        self.science = require( "config.science" )
    end
    return self.science
end

--学院研究 --反向算出所有父节点和所有子节点
function TemplateData:CalculationScienceParent()
    local science = self:getScience()
	local t_science = {}
	for k,obj in pairs(science) do
		if(t_science[obj.ID] == nil) then
			t_science[obj.ID] = {}
			t_science[obj.ID].parent={}
			t_science[obj.ID].son={}
		end

		local strTab2 = {}
		local begin = string.find(obj.relation, ',')
		if(begin) then
			strTab2 = string.split(obj.relation, ",")
		else
			strTab2[1] = obj.relation
		end

		for sub_k,sub_obj in pairs(science) do
			local number1 = (obj.ID - math.mod(tonumber(obj.ID),10000))/10000
			local number2 = (sub_obj.ID - math.mod(tonumber(sub_obj.ID),10000))/10000
			if( number2 == number1) then
				local tab = nil
				if(tonumber(obj.ID) > tonumber(sub_obj.ID)) then
					tab = t_science[obj.ID].parent
					if( tab ) then
						local strTab1 = {}
						local begin = string.find(sub_obj.relation, ',')
						if(begin) then
							strTab1 = string.split(sub_obj.relation, ",")
						else
							strTab1[1] = sub_obj.relation
						end

						for i,sub2_obj in ipairs(strTab1) do
							if (sub2_obj == obj.position) then
								table.insert(tab,sub_obj.ID)
								break
							end
						end
					end
				elseif (tonumber(obj.ID) < tonumber(sub_obj.ID)) then
					tab = t_science[obj.ID].son
					for i,sub3_obj in ipairs(strTab2) do
						if (sub3_obj == sub_obj.position) then
							table.insert(tab,sub_obj.ID)
							--break
						end
					end
				end
			end
		end
    end
	return t_science
end
--获取科技战斗力
function TemplateData:getScienceFightingByID(id,level)
    local info = self:getScienceStudyConfig()
    if info and info[id] and info[id][level] then
        return info[id][level].fighting
    end
    return 0
end

--获取科技类型名
function TemplateData:getScienceTypeNameByID(typeID)
    local types = self:getScienceType()
    if types[typeID] and types[typeID].name then
        return Language.get(types[typeID].name)
    end
    return ""
end

--获取科技名
function TemplateData:getScienceName(id)
    local info = self:getScienceByID(id)
    return info and Language.get(info.name)
end

--获取科技类型
function TemplateData:getScienceTypeByID(id)
    local types = self:getScienceType()
    for _,info in pairs(types) do
        local ids = info.science
        if string.find(ids,id) then
            return info.ID
        end
    end
    return nil
end

function TemplateData:getScienceByID(id)
    local data = self:getScience()
    return self.science[id]
end

function TemplateData:getSciencesByLevel(level)
    local data = self:getScienceStudyConfig()
    local res = {}
    for i,j in pairs(data) do
        if j and j[1] and j[1].school_lv == level then
            table.insert(res,i)
        end
    end

    return res
end
-- 日常奖励
function TemplateData:getDailyReward()
    if self.daily_rewards ==nil then
        self.daily_rewards = require( "config.daily_rewards" )
    end

    local newTable = {}
    for k,v in pairs(self.daily_rewards) do
        if not newTable[v.stage] then
            newTable[v.stage] = {}
        end
        table.insert(newTable[v.stage], v)
    end
    return newTable

end

-- 日常任务
function TemplateData:getDailyTasks(taskID)
    if self.daily_tasks == nil then
        self.daily_tasks = require( "config.daily_tasks" )
    end

    local id = tonumber(taskID)

    local info = self.daily_tasks[id]
    if info then
        return info
    end
    print("getTask error 找不到对应id的任务 "..id)
    return nil
end

-- 幸运宝箱
function TemplateData:getTurntable()
    if self.tavern_turntable == nil then
        self.tavern_turntable = require( "config.tavern_turntable" )
    end
    return self.tavern_turntable
end

-- 活动
function TemplateData:getEventTable()
    if self.event == nil then
        self.event = require( "config.event" )
    end
    local eventTable = {}
    for k,v in pairs(self.event) do
        if not eventTable[v.type] then
            eventTable[v.type] = {}
        end
        eventTable[v.type][v.lv] = v
    end
    return eventTable
end

-- 限时活动奖励
function TemplateData:getEventReward()
    if self.eventreward == nil then
        self.eventreward = require( "config.eventreward" )
    end
    local eventrewardTable = {}
    for k,v in pairs(self.eventreward) do
        if not eventrewardTable[v.type] then
            eventrewardTable[v.type] = {}
        end
        eventrewardTable[v.type][v.rank] = v
    end
    return eventrewardTable
end

-- 限时活动积分获得方式
function TemplateData:getEventInt()
    if self.eventint == nil then
        self.eventint = require( "config.eventint" )
    end
    local eventInitTable = {}
    for i,v in ipairs(self.eventint) do
        if not eventInitTable[v.eventtype] then
            eventInitTable[v.eventtype] = {}
        end
        table.insert(eventInitTable[v.eventtype],v)
    end
    return eventInitTable
end

-- 黑骑士积分需求奖励
function TemplateData:getIntegralNeedReward()
    if self.point_reward == nil then
        self.point_reward = require( "config.point_reward" )
    end

    return self.point_reward
end

-- 黑骑士积分排名奖励
function TemplateData:getIntegralRankReward()
    if self.personal_reward == nil then
        self.personal_reward = require( "config.personal_reward" )
    end

    local rewardTab = {}
    for i,v in ipairs(self.personal_reward) do
        if not rewardTab[v.type] then
            rewardTab[v.type] = {}
        end
        rewardTab[v.type][v.ranking] = v
    end

    return rewardTab
end


--玩家详细信息枚举
function TemplateData:getDataByValue(params)
    if self.chamessage == nil then
        self.chamessage = require( "config.chamessage" )
    end

    for i,v in ipairs(self.chamessage) do
        if v["value"]==params then
            return v, i
        end
    end
end

function TemplateData:getDataByID(params)
    if self.chamessage == nil then
        self.chamessage = require( "config.chamessage" )
    end

    for i,v in ipairs(self.chamessage) do
        if v["ID"]==params then
            return v
        end
    end
end

-- 任务
function TemplateData:getQuest()
    if self.quest == nil then
        self.quest = require( "config.renwu" )
    end

    return self.quest
end

-- 获取任务信息
function TemplateData:getQuestInfo( id )
    self:getQuest()
    id = tonumber(id)

    local info = self.quest[id]
    if info then
        return info
    end
    print("getQuest error 找不到对应id的任务 "..id)
    return nil
end

--取出成就几星的template 参数1为星星个数，参数2为勋章（成就）类别
function TemplateData:getStarByHonor(starNum,honorType)
     for k,v in pairs(self.achieve) do
        if v["type"] == honorType and v["star"] == starNum then
            return v
        end
    end
end


--------------联盟科技
function TemplateData:getAllianceScience()
    self._allianceScience = self._allianceScience or require( "config.alliancescience" )

    return self._allianceScience
end


function TemplateData:getAllianceScienceByID(id)
    local data = self:getAllianceScience()

    return data[id]
end


function TemplateData:getAllianceScienceName(id)
    local data = self:getAllianceScienceByID(id)

    return data and data.name and Language.get(data.name)
end

function TemplateData:getScienceFloor(id)
    local data = self:getAllianceScienceByID(id)

    return data and data.floor
end

function TemplateData:getScienceMaxStar(id)
    local data = self:getAllianceScienceByID(id)

    return data and data.star
end

function TemplateData:getScienceIcon(id)
    local data = self:getAllianceScienceByID(id)

    return data and data.icon
end

function TemplateData:getScienceDesc(id)
    local data = self:getAllianceScienceByID(id)

    return data and data.description and Language.get(data.description)
end

function TemplateData:getScienceAddValue(id)
    local data = self:getAllianceScienceByID(id)

    return data and data.add_value or 0
end


function TemplateData:getScienceAddType(id)
    local data = self:getAllianceScienceByID(id)

    return data and data.add_type or 0
end

function TemplateData:getScienceMaxLevel(id)
    local data = self:getAllianceScienceByID(id)

    return data and data.max_lv or 0
end

function TemplateData:getScienceFloor(id)
    local data = self:getAllianceScienceByID(id)

    return data.floor or 1
end

--科技学习
function TemplateData:getAllianceScienceStudy()
    self._allianceScienceStudy = self._allianceScienceStudy or require( "config.alliancesciencestudy" )

    return self._allianceScienceStudy
end

function TemplateData:getScienceStudy(id,level)
    local data = self:getAllianceScienceStudy()

    return data and data[id] and data[id][level] or {}
end

function TemplateData:getScienceStudyExp(id,level,star)
    local data = self:getScienceStudy(id,level)
    local exp = data.exp or 0
    local add = data.add_exp or 0
    return exp + add * star
end


function TemplateData:getScienceStudyTime(id,level)
    local data = self:getScienceStudy(id,level)

    return data.time or 0
end

function TemplateData:getScienceMaxLevel(id)
    local data = self:getAllianceScienceStudy()

    return data and data[id] and table.nums(data[id]) or 0
end
--取联盟领地建筑根据type
function TemplateData:getAllianceterritoryBuyType(types)
    if self.allianceterritory == nil then
        self.allianceterritory = require( "config.allianceterritory" )
    end
    local tab={}
     for k, v in pairs(self.allianceterritory) do
         for ki, vi in pairs(v) do
             if vi["type2"] == types then      
                  vi["ID"] = k
                  table.insert(tab,vi)
             end
         end        
    end
    tab = sortByKey(tab, "type")
    if types == 2 then
        tab = sortByKey(tab, "ID")
    end
    return tab 
end

---------------------------------------------联盟领地
function TemplateData:getAllianceterritory()
    if self.allianceterritory ==nil then 
        self.allianceterritory = require( "config.allianceterritory" )
    end
    return self.allianceterritory	
end

function TemplateData:getAllianceBuildingById(id)
	self:getAllianceterritory()
	return self.allianceterritory[id]
end

function TemplateData:getAlliancebuff()
    if self.alliancebuff ==nil then 
        self.alliancebuff = require( "config.alliancebuff" )
    end
    return self.alliancebuff	
end

function TemplateData:getAllianceFlag()
    if self.allianceFlag == nil then 
        self.allianceFlag = require( "config.flag_image" )
    end
    return self.allianceFlag	
end

function TemplateData:getAllianceFlagById(id)
	self:getAllianceFlag()
	
	local info = self.allianceFlag[id]
	if info then
		return info.flag_image
	else
		trace("找不到联盟旗帜: "..id)
		return self.allianceFlag[1].flag_image
	end
end

function TemplateData:getFortressState(num)
	local str = ""
	if num == Enum.Alliance_building_state_no_complete then -- 未完成
		str = Language.get("43307")	
	elseif num == Enum.Alliance_building_state_collect then -- 采集中
		str = Language.get("43308")
	elseif num == Enum.Alliance_building_state_defense then -- 防御中
		str = Language.get("43309")
	elseif num == Enum.Alliance_building_state_storage then -- 存储中
		str = Language.get("43310")
	elseif num == Enum.Alliance_building_state_garrison then -- 已驻防
		str = Language.get("43303")
	elseif num == Enum.Alliance_building_state_no_garrison then -- 未驻防
		str = Language.get("43304")
	elseif num == Enum.Alliance_building_state_repair or 
		   num == Enum.Alliance_building_state_repaired then -- 修理中
		str = Language.get("43305")
	elseif num == Enum.Alliance_building_state_destroy or 
		   num == Enum.Alliance_building_state_destoryed then -- 被摧毁中
		str = Language.get("43306")
	elseif num == Enum.Alliance_building_state_broken or 
		   num == Enum.Alliance_building_state_brokened then -- 破损
		str = Language.get("43316")		
	elseif num == Enum.Alliance_building_state_build then -- 建造中		
		str = Language.get("43315")
	elseif num == Enum.Alliance_building_state_no_collect then -- 未采集		
		str = Language.get("43317")			
	end
	return str
end

function TemplateData:getNameFormat(simpleName, playerName)
	local str = ""
	if simpleName and playerName then
		str = string.formatIndex(Language.get("43513"), simpleName, playerName)
	else
		str = playerName
	end
	return str
end

-- 是否是堡垒
function TemplateData:isFortress(id)
	if id == Enum.BigMap_building_type_alliance_fortress then
		return true
	end
	return false
end

-- 是否是箭塔
function TemplateData:isTower(id)
	if id == Enum.BigMap_building_type_alliance_tower then
		return true
	end
	return false	
end

-- 是否是仓库
function TemplateData:isStorage(id)
	if id == Enum.BigMap_building_type_alliance_storage then
		return true
	end
	return false
end

-- 是否是超级矿
function TemplateData:isSuperOre(id)
	if id >= Enum.BigMap_building_type_alliance_wood and id <= Enum.BigMap_building_type_alliance_silver then
		return true
	end
end

function TemplateData:getGuildAuthority()
	if self.guildAuthority == nil then
		self.guildAuthority =  require( "config.guild_authority" )
	end
	return self.guildAuthority
end

function TemplateData:getGuildAuthorityByClass(Id)
	self:getGuildAuthority()
	return self.guildAuthority[Id]
end

function TemplateData:getSystemChat(  )
    if self.chat == nil then
        self.chat = require( "config.chat" )
    end

    return self.chat
end

-- 获取任务信息
function TemplateData:getSystemMsgByID( id )
    self:getSystemChat()

    local info = self.chat[id]
    if info then
        return info
    end
    print("getSystemMsgByID error 找不到对应id的系统消息 "..id)
    return nil
end

-- 宝藏
function TemplateData:getTavernChest()
    if self.tavern_chest == nil then
        self.tavern_chest = require( "config.tavern_chest" )
    end
    return self.tavern_chest
end

function TemplateData:getTavernInfoByLv( lv )
    self:getTavernChest()

    for k,v in pairs(self.tavern_chest) do
        if v.chestlv == lv then
            return v
        end
    end

    print("getTavernInfoByLv error 找不到对应lv的宝箱信息 "..lv)
    return nil 
end


--获取VIP 增益信息
function TemplateData:getVipAdd()
    if self.vip == nil then
        self.vip = require( "config.vip" )
    end

    return self.vip
 end 

--获取vip登陆点数
function TemplateData:getVipPoint()
    if self.vippoint == nil then
        self.vippoint = require( "config.vip_point" )
    end

    return self.vippoint
end

--获取今日登入vip登陆点数
function TemplateData:getTodayVipPoint(day)
   self:getVipPoint()
   for k,v in pairs(self.vippoint) do
        if  v.id <= 20 then
            if v.login_day == day then
                return v.vip_point
            end   
        else
            local str = string.split(v.login_day,",")
            if tonumber(str[1]) <= day and tonumber(str[2]) >= day then
                return v.vip_point
            end    
        end
   end
end

--获取vip等级经验
function TemplateData:getVipEx()
    if self.vipEx == nil then
        self.vipEx = require( "config.vip_level" )
    end

    return self.vipEx
end

--获取VIPitem 
function TemplateData:getVipItem(type)
    if self.vipItem == nil then
        self.vipItem = require( "config.vip_item" )
    end
    local dataTab = {}
    for k,v in pairs(self.vipItem) do
        if v.type == type then
            table.insert(dataTab,v)
        end    
    end

    -- 排序 
    table.sort( dataTab, function ( a,b )
       return a.id < b.id
    end )

    return dataTab
end

function TemplateData:getVipFreeTime(vipLevel)
    local data = self:getVipAdd()
    local def = 300
    if vipLevel and data and data[9] and data[9]["vip"..vipLevel] then
        return data[9]["vip"..vipLevel]*60
    end
    return def
end


function TemplateData:getGuildConfig()
    if self.guildConfig == nil then 
        self.guildConfig = require( "config.guide" )
		
		local guildObj = {}
		for k,v in pairs(self.guildConfig) do
			for ik,iv in pairs(v) do
				guildObj = iv
				local area_position = guildObj.area_position
				local result = {}
				string.gsub(area_position, '[^'..","..']+', function(w) table.insert(result, tonumber(w)) end )
				local imgRect = {}
				if(result[1]) then
					imgRect.x = tonumber(result[1])
					imgRect.y = tonumber(result[2])
					imgRect.w = tonumber(result[3]) 
					imgRect.h = tonumber(result[4]) 
				end
				guildObj.area_position = imgRect
			end
		end
	
    end
    return self.guildConfig	
end

function TemplateData:getNextStageStepId(guideID,stage)
    if self.guildConfig == nil then 
        self:getGuildConfig()
    end
	local stepId = 0
	if(stage ~= 0) then
		local nextStage = stage + 1
		for k,vArray in pairs(self.guildConfig) do
			if(guideID == k) then
				for i,Obj in ipairs(vArray) do
					if(Obj.grade == nextStage) then
						if(stepId == 0) then
							stepId = Obj.step
						end
						if Obj.step < stepId then
							stepId = Obj.step
						end
					end
				end
				stepId = stepId - 1
				break
			end
		end
	end
    return stepId	
end

function TemplateData:getGuideConfigData(guideID,stepID)
    if self.guildConfig == nil then 
        self:getGuildConfig()
    end
	local guildObj = {}
	for k,v in pairs(self.guildConfig) do
		if(guideID == k) then
			guildObj = v[stepID]
			break
		end
	end
    return guildObj	
end

function TemplateData:getGuideConfigSum(guideID)
    if self.guildConfig == nil then 
        self:getGuildConfig()
    end
	local num = 0
	for k,v in pairs(self.guildConfig) do
		if(guideID == k) then
			num = table.getn(v)
			break
		end
	end
    return num	
end
function TemplateData:getKingOfficialData(types)
    if self.kingdom ==nil then
        self.kingdom =  require("config.king")
    end

    local kingOfficial = {}
    local typeList = {}
    for key, n in pairs(self.kingdom) do
         if n["type"] == types then
             kingOfficial["name"] = n["name"]
             kingOfficial["image"] = n["image"]
             if not typeList[n["etype"]] then
                 typeList[n["etype"]] = {}
                 typeList[n["etype"]]["value"] = n["value"]
                 typeList[n["etype"]]["display"] = n["display"]
             end
         end     
    end  
    --加成的类型
    kingOfficial.typeList = typeList
    return kingOfficial
end

function TemplateData:getKingTreasure()
    if self.treasure ==nil then
        self.treasure =  require("config.treasure")
    end
    local kingGift = {200655,200656,200657}
    local index = 0
    local dataTable = {}
    for i=1,#kingGift do
         index = index+1
         for d, n in pairs(self.treasure) do
            if n["item"] == kingGift[index] then
                if not dataTable[kingGift[index]] then
                    dataTable[kingGift[index]] = {}
                end            
                table.insert(dataTable[kingGift[index]],n)
            end
        end   
    end
    return index, dataTable
end

function TemplateData:getLoadingTips()
    local key = "loadTipID"
    local lastID = tonumber(util.getKey(key)) or 0
    local tipsData = require("config.tips")
    if tipsData == nil then
        trace("TemplateData:getLoadingTips no tip data")
        return Language.get("10000")
    end

    local first
    for i,j in pairsKey(tipsData) do
        first = first or i
        if i>lastID then
            local lanID = j.textid
            if lanID then
                util.setKey(key,i)
                return Language.get(lanID)
            end
        end
    end

    util.setKey(key,first)
    return Language.get(tipsData[first].textid)
end

-- 新兵
function TemplateData:NewRecruits()
	if not self.newRecruits then
		self.newRecruits = require("config.recruit_reward")
	end
	return self.newRecruits
end

return TemplateData