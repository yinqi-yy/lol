--
-- Author: Your Name
-- Date: 2015-07-13 14:24:44
--
local GameHelper = class("GameHelper")

function GameHelper.create(...)
    local help = GameHelper.new(...)
    return help
end



-- 服务器错误码  提示
-- 错误码1-3 必须自己负责提示  
function GameHelper:serverTip(code)
    local code = 10200 + code
    local tip = Language.get(code)
    Alert.floatingTip(1, tip)
end



function GameHelper:tip(content)
    Alert.floatingTip(1, content)
end

--建筑物升级提示
function GameHelper:buildLvUpTip( info )
    local name = TemplateData:getBuildName(info.buildType)
    --self:tip(Language.getFormat("10185",name ,info.lv))
    Alert.checkAndShowfloatingTip(1,function() Alert.floatingTip(1, Language.getFormat("10185",name ,info.lv)) end)
end

--建筑物移除提示
function GameHelper:buildRmTip( info )
    local name = TemplateData:getBuildName(info.buildType)
    self:tip(Language.getFormat("10186",name))
end



-- 雇佣工人或者使用雇佣工人时间不足时调用 （ isShowOtherTip：建造时间太长，需要购买）
function GameHelper:hireWork(params, isShowOtherTip,remainTime,NeedTime)
    if params == 1 and PlayerData:getWorker1() > 0 then
        -- 已建造的跳转
        if not PlayerData:buildFreeSpeedUp(PlayerData:getWorker1()) then
            GameEvent:notifyView(GameEvent.jumpMapCenter, PlayerData:getWorker1())
        end
    else
        -- 执行可建造跳转

    end

    -- 雇佣的工人
    if params == 2 then
        -- 雇佣工人是否在工作
        if PlayerData:getWorker2() <= 0 then
            -- 是否有剩余时间>0表示还有剩余时间
            if PlayerData:checkRemainWorker() > 0 then
                if isShowOtherTip then
                    local desc = Language.get("23020").."\n"
                    desc = desc..Language.get("23024")..util.timeFormat(remainTime).."\n"
                    desc = desc..Language.get("23025")..util.timeFormat(NeedTime).."\n"
                    Alert.confirmBox(self, 2,desc , Language.get("23015"), nil, Enum.hireGold, self.hireWorkStc)
                else
                    -- 执行可建造跳转,并且提示剩余时间
                    GameEvent:notifyView(GameEvent.showHireTimes)
                end
            else
                --已无时间需要购买
                Alert.confirmBox(self, 2, Language.get("23014"), Language.get("23015"), nil, Enum.hireGold, self.hireWorkStc)
            end
        else
            -- 测试跳转
            if not PlayerData:buildFreeSpeedUp(PlayerData:getWorker2()) then
                GameEvent:notifyView(GameEvent.jumpMapCenter, PlayerData:getWorker2())
            end
        end
    end

    --显示提示
    if params == 3 then
        Alert.confirmBox(self,3, Language.get("23023"), Language.get("24115"), nil, nil, nil)
    end
end

function GameHelper:hireWorkStc()
    if PlayerData:checkgold(Enum.hireGold) then
        GameTCP:sendRPC("hireWorker", { }, self, self.callBackFun)
    else
        GameHelper:noGoldTip()
    end
end

function GameHelper:callBackFun(result)
    local code = result.result
    if code > 3 then
        GameHelper:serverTip(code)
    end

    if code == 1 then
        -- 抛出雇佣成功 并且雇佣时间增加
         PlayerData:setHireWorkerTimes()          
    end
end

--资源 转 金币 弹窗
--@param：tbl：数据{ "wood" = value,  "food" = value, "iron" = value, "silver" = value } , 
--                                  value == nil or value == 0：表示充足，否则表示缺失多少
--@param：labelText：标签文本
--@param：buttonText：按钮文本
--@param：okFun：确认回调
--@param：cancelFun：取消回调
function GameHelper:ResToGoldPopup( tbl, labelText, buttonText, okFun, cancelFun )
    util.changeUI( ui.GoldTrainPopup, tbl, labelText, buttonText, okFun, cancelFun )
end

--金币不足提示
function GameHelper:noGoldTip()
    local desc = Language.get("23019")
    Alert.confirmBox(
            self,
            3,
            desc,
            Language.get("10153"),
            nil,self.gold,self.onGoldNoEnough)


end

function GameHelper:onGoldNoEnough()
    -- print("购买窗口")

end


--建筑物升级金币加速
function GameHelper:onClickBuildGoldSpeedUpNow(position)
    local gold = PlayerData:getBuildTimeToGold(position)
    local info = PlayerData:getBuildInfo(position)
    local name = TemplateData:getBuildName(info.buildType)

    self.position = position

    if PlayerData:checkgold(gold) then 
        --提示金币消耗

        if Enum.buildstate.bd == info.state or Enum.buildstate.trSpeed_bd == info.state  then  --建筑
            Alert.confirmBox(self,2,Language.getFormat("10162",name),
                Language.get("10135"),
                nil,gold,self.sendBuildUpdateNow)
        elseif Enum.buildstate.rm == info.state or Enum.buildstate.trSpeed_rm == info.state then  --拆除
               Alert.confirmBox(self,2,Language.getFormat("10194",name),
                Language.get("10193"),
                nil,gold,self.sendBuildRemoveNow)
        elseif Enum.buildstate.tr == info.state or Enum.buildstate.eg == info.state then  --训练
			local str = ""
			if (PlayerData:isTrainBuild(info.buildType)) then
				str = TemplateData:getArmsName( info.effectType )
			end
            local str1 = nil
            local str2 = nil
            if info.buildType == Enum.type.warfort then  --战争堡垒
                str1 = Language.get("10190")
                str2 = Language.get("21004")
            elseif info.buildType == Enum.type.forgeShop then -- 铁匠铺
                str1 = Language.get("40025")
                str2 = Language.get("10109") 
            elseif  info.buildType == Enum.type.college then -- 学院
                str1 = Language.get("40025")
                str2 = Language.get("10109")
            elseif  info.buildType == Enum.type.emergency then -- 急救帐篷
                str1 = Language.get("40025")
                str2 = Language.get("10109")                                                          
            else
                str1 = Language.get("10189")
                str2 = Language.get("21002")
            end

            Alert.confirmBox(self,2,string.formatIndex( str1, str ),
                str2,nil,gold,self.sendBuildUpdateNow)
        else
            printLog( "GameHelper:onClickBuildGoldSpeedUpNow","该状态下有操作？：%d", info.state )
        end

    else
        self:noGoldTip(Language.get("10171"))
    end
end

--发送
function GameHelper:sendBuildRemoveNow()
        local gold = PlayerData:getBuildTimeToGold(self.position)
        local op = gold == 0 and Enum.op.vipFreeBuild or  Enum.op.buildDemolishNow
        GameTCP:sendRPC("building",{
            position = self.position,
            operation = op,
            param = 1,--金币
            param2 = 0
        },
        self,self.onRecBuildRemove
        )
end

function GameHelper:onRecBuildRemove(res,sendData)
    if res.result == Enum.success then
        PlayerData:removeBuild(sendData.position)
    else
        GameHelper:serverTip(res.result)
    end
end

function GameHelper:sendBuildUpdateNow()
    local op
    local state =  PlayerData:getBuildState(self.position)
    local gold = PlayerData:getBuildTimeToGold(self.position)
    if state ==Enum.buildstate.bd  or Enum.buildstate.trSpeed_bd == state or state == Enum.buildstate.rm then 
        op = gold == 0 and Enum.op.vipFreeBuild or  Enum.op.lvUpNow
    elseif state == Enum.buildstate.tr or state == Enum.buildstate.eg then 
        op = Enum.op.produceSpeed
    end
	local tData = {
            position = self.position,
            operation = op,
            param = 1,--金币
            param2 = 0
        }	
	local info = PlayerData:getBuildInfo(self.position)
	if (PlayerData:isStudyCollage(info.buildType)) then
		tData.param2 = info.buildType
	end
    GameTCP:sendRPC("building",tData,
        self,self.onRecBuildSpeepUp
        )
end

--金币提速建筑结果
function GameHelper:onRecBuildSpeepUp(res,sendData)
   if res.result == Enum.success then
   
		if (PlayerData:isStudyCollage(sendData.param2)) then
			local building = PlayerData:getBuildByType(Enum.type.college)
			building.effectTime = 0
			building.effectType = 0
			PlayerData:addEffectUpdateBuild( sendData.position, building.effectTime, building.effectType, 0 )
		end
		
		
        local operation = sendData.operation
        if operation == Enum.op.lvUpNow or operation == Enum.op.vipFreeBuild then
            local buildinfo = PlayerData:getBuildInfo(sendData.position)
            PlayerData:buildLvUp(buildinfo)
            PlayerData:updateBuild(buildinfo)
        elseif operation == Enum.op.produceSpeed then
            local buildinfo = PlayerData:getBuildInfo(sendData.position)
            if PlayerData:isTrainBuild( buildinfo.buildType ) == true then -- 训练
                PlayerData:buildTimeSpeedTrain( sendData.position )
            elseif PlayerData:isForgeShop( buildinfo.buildType ) == true then --铁匠铺
                PlayerData:buildTimeSpeedTrain( sendData.position )
            elseif buildinfo.buildType == Enum.type.emergency then --医疗帐篷
                PlayerData:buildTimeSpeedTreat( sendData.position )
            else  --非训练的
                printLog( "GameHelper:onRecBuildSpeepUp", "TODO" )
            end
        end
    else
        GameHelper:serverTip(res.result)
    end

end



--使用金币农田产量提高
function GameHelper:onClickGoldOutSpeedUp(position)
    self.position = position
    local buildinfo = PlayerData:getBuildInfo(position)
    local gold = PlayerData:getResGoldSpeedCost(position)

    if PlayerData:checkgold(gold) then 
        --提示金币消耗
        local name = TemplateData:getBuildName(buildinfo.buildType)
        Alert.confirmBox(self,2,Language.getFormat("10170",name),
            Language.get("10192"),
            nil,gold,self.sendUpdateNow)

    else
        self:noGoldTip(Language.get("10171"))
    end
end

--发送
function GameHelper:sendUpdateNow()
    GameTCP:sendRPC("building",{
            position = self.position,
            operation = Enum.op.produceSpeed,
            param = 1,--金币
            param2 = 0
        },
        self,self.onRecSpeepUp
        )

end

--使用道具农田产量提高
function GameHelper:onClickToolOutSpeedUp(position)
    local buildinfo = PlayerData:getBuildInfo(position)
    local toolID  = PlayerData:getResToolSpeedID(buildinfo.buildType)
    self.position = position
   
    GameTCP:sendRPC("building",{
            position = position,
            operation = Enum.op.produceSpeed,
            param = 2,--道具
            param2 = toolID
        },
        self,self.onRecSpeepUp
        )
end

--提高产量结果
function GameHelper:onRecSpeepUp(res,sendData)
    if res.result == Enum.success then 
        if sendData.param ~= 2 then--道具加速不需要在这里加上状态,服务器会返回数据后自动加上
            local buildinfo = PlayerData:getBuildInfo(sendData.position)
            PlayerData:buildOutSpeedUp(buildinfo,86400)
            PlayerData:updateBuild(buildinfo)
        end

        local buildinfo = PlayerData:getBuildInfo(sendData.position)
        local name = TemplateData:getBuildName(buildinfo.buildType)
        GameHelper:tip(Language.getFormat("10172",name))

        if sendData.param2 >0 then 
            PlayerData:useItemCount(sendData.param2)
        end

    else
        GameHelper:serverTip(res.result)
    end
end

function GameHelper:showShipWin()
    GameTCP:sendRPC("fetchWharfAwards", { isFetch = 0 }, self, self.callBackShowWin)
end

function GameHelper:callBackShowWin(result)
    local data = result
    local rewardItem = data.awardsID

    if rewardItem == 0 then
    --新曾次数限制功能
      self:tip(Language.get("29012"))
      return
    end


    if data.pierFetchTime <= PlayerData:getServerTime() then        
        local itemTData = TemplateData:getItem(rewardItem)
        local icon = itemTData.icon .. ".png"
        self.icon = icon
        local btnTitle = Language.get("29010")
        Alert.rewardBox2(itemTData.name1 .. "x" .. data.awardsNum, itemTData.describe1, icon, btnTitle, self.confirmFunc, self)
    else
        self:tip(Language.get("29011"))
    end
end

function GameHelper:confirmFunc()
    GameTCP:sendRPC("fetchWharfAwards", { isFetch = 1 }, self, self.getBackShowWin)
end

function GameHelper:getBackShowWin(result)
    local Menu = require("modules.MainCity.Menu")
    local pos = Menu.getBagPos()
    pos.x = pos.x+30
    GameHelper.itemEffect(self.icon, result.awardsNum,pos)
    PlayerData:updateDock(result.pierFetchTime)
end



--物品掉落
function GameHelper.itemEffect(item,num,pos)
     local sprite = cc.Sprite:createWithSpriteFrameName(item)
     local getcountlab = cc.LabelTTF:create("x"..num, css.fontName, 40)
     local nodeSptrite = cc.Node:create()
     nodeSptrite:addChild(sprite)
     getcountlab:setPositionY(-80)
     nodeSptrite:addChild(getcountlab)

     local layer = util:getTipLayer()
     layer:addChild(nodeSptrite)
     nodeSptrite:setPositionX(util.display.width/2)
     nodeSptrite:setPositionY(util.display.height/2)
	 local ScaleTo = cc.ScaleTo:create(0.5,1.2)
     local ScaleTo2 = cc.ScaleTo:create(1.2,0.5)
	 local fadeout =  cc.MoveTo:create(1,cc.p(pos.x,pos.y))
	 local callfunc1  = cc.CallFunc:create(function ( ... )
	 	nodeSptrite:removeFromParent(true)
	 end)
	 local sequence = cc.Sequence:create(ScaleTo,ScaleTo2,fadeout,callfunc1,nil)
	 nodeSptrite:runAction(sequence)	
end

function GameHelper:setAppoint(id)
    self.appoint = id
end

function GameHelper:getAppoint()
     return self.appoint
end

function GameHelper:setKingGiftID(id)
    self.kingGiftID = id
end

function GameHelper:getKingGiftID()
     return self.kingGiftID
end

function GameHelper:setKingGiftWorkflow (id)
    self.kingGiftWorkflowID = id
end

function GameHelper:getKingGiftWorkflow ()
     return self.kingGiftWorkflowID
end

--从礼包界面去联盟还是从官职界面进联盟 1为礼包 2为官职
function GameHelper:setIsGiftView(id)
    self.kingIsGiftView = id
end

function GameHelper:getIsGiftView()
     return self.kingIsGiftView
end

function GameHelper:showDockWin(types)
    local lv = PlayerData:getCastleLvl()
    if lv >2 then
        util.changeUI( ui.DockWin, Enum.type.NewRecruits)
    else
        Alert.timeDisappearTip(Language.get("29024"), nil, 2)
    end
end


return GameHelper