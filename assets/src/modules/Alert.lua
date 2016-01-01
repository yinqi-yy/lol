--
-- Author: Your Name
-- Date: 2015-07-14 14:04:15
--

local Alert = class("Alert")

Alert.YES ="yes"
Alert.NO = "no"
Alert.OK = "ok"

function Alert.create()
    local messagebox = Alert.new()
    return messagebox
end

-- typ: message 表中类型,showFunc显示操作,typ=0则一定显示
function Alert.checkAndShowfloatingTip(typ, showFunc)
    if typ == 0 or PlayerData:getNoticeMessageEnabledWithID( typ ) then
        showFunc()
    end
end

-- typ: 1 单行文字 2 单行文字+icon 3 双行文字+icon 
function Alert.floatingTip(typ, lbl1, icon, lbl2, lbl3)
    if Alert.lastfloatingTip  and not tolua.isnull(Alert.lastfloatingTip) then
        Alert.lastfloatingTip:stopAllActions()
        Alert.lastfloatingTip:removeFromParent()
    end
    local tip = util.createluaItem("ui.tip.floatingtip")
    Alert.lastfloatingTip = tip
    if typ == 1 then
        tip.nd_icon:setVisible(false)
        tip.sp_bg:setVisible(false)
        tip.lbl_tip1:setString(lbl1)
        tip.lbl_tip2:setVisible(false)
        tip.lbl_tip3:setVisible(false)
    elseif typ == 2 then
        tip.nd_icon:addChild(icon)
        tip.lbl_tip1:setString(lbl1)
        tip.lbl_tip2:setVisible(false)
        tip.lbl_tip3:setVisible(false)
    elseif typ == 3 then
		if type(icon) == "string" then
			util.loadSprite(tip.sp_icon, icon)
			tip.sp_icon:setVisible(true)
		else
			tip.nd_icon:addChild(icon)
		end
        tip.lbl_tip1:setVisible(false)
        tip.lbl_tip2:setString(lbl2)
        tip.lbl_tip3:setString(lbl3)
    end
    local function removeSelf()
        tip:removeFromParent()
    end
    local delay = cc.DelayTime:create(2)
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(removeSelf))
    tip:runAction(sequence)

    util.addToPop(tip)
    return tip
end

function Alert.loadingTip(bHide)
    if Alert.lastloadingTip and not tolua.isnull(Alert.lastloadingTip) then
        Alert.lastloadingTip:stopAllActions()
        Alert.lastloadingTip:removeFromParent()
    end

    if bHide then
        return
    end
    local tip = util.createluaItem("ui.tip.loading")
    Alert.lastloadingTip = tip

    local function removeSelf()
        tip:removeFromParent()
    end
    local delay = cc.DelayTime:create(2)
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(removeSelf))
    tip:runAction(sequence)
    util.addToPop(tip)

    return tip
end

-- typ : 1 内容+ 按钮 2 内容 + 按钮 + 金币 3 内容 + 按钮 无金币和龙币图片
function Alert.confirmBox(sf, typ, msg, btnTitle, cdTime, gold, confirmFunc,spriteFlag)
    local tip = util.createluaItem("ui.tip.confirmbox")
    tip.lbl_message:setString(msg)

    local shedule
    local function update(dt)
        cdTime = cdTime - 1
        if cdTime >= 0 then
            tip.lbl_cdTime:setString(util.timeFormat(cdTime))
            tip.lbl_goldCount:setString(PlayerData:timeToGold(cdTime))
        else
            tip.lbl_cdTime:setVisible(false)
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(shedule)
        end
    end
    if cdTime then
        tip.lbl_cdTime:setString(util.timeFormat(cdTime))
        shedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(update, 1, false)
    else
        tip.lbl_cdTime:setVisible(false)
    end

	if typ == 1 then
		if gold then
			tip.lbl_goldCount:setString(gold)
		end
		tip.lbl_btnTitle1:setString(btnTitle)

        tip.lbl_goldCount:setVisible(false)
        tip.lbl_btnTitle2:setVisible(false)
        tip.sp_gold:setVisible(false)
    elseif typ == 2 then
        tip.lbl_goldCount:setString(gold)
        tip.lbl_btnTitle2:setString(btnTitle)

        tip.lbl_btnTitle1:setVisible(false)
        tip.sp_longbi:setVisible(false)
    elseif typ == 3 then
        tip.btn_confirm:setTitleText(btnTitle)
        
        tip.lbl_btnTitle1:setVisible(false)
        tip.sp_longbi:setVisible(false)
        tip.lbl_goldCount:setVisible(false)
        tip.lbl_btnTitle2:setVisible(false)
        tip.sp_gold:setVisible(false)
    end

    local function btnClick(...)
        if shedule then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(shedule)
        end
        util.tryRemove(tip)
        if confirmFunc then
            local backFun = handler(sf, confirmFunc)
            if confirmFunc then
                backFun()
            end
        end
    end

    util.clickSelf(self, tip.btn_confirm, btnClick)

    local function close()
        if shedule then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(shedule)
        end
        util.tryRemove(tip)
    end
    util.clickSelf(self, tip.pnl_close, close)   
    util.addToPop(tip)
	
	if(spriteFlag ~= nil) then
		trace("111111111")
		util.setEnabledBtn(tip.btn_confirm,spriteFlag)
	end
	
    return tip
end

-- 带箭头
-- 带箭头
function Alert.arrowTip(msg, bReverse)
    local tip = util.createluaItem("ui.tip.arrowtip")
    tip.lbl_message:setString(msg)

    if bReverse then
        tip.sp_balloons1:setVisible(false)
    else
        tip.sp_balloons2:setVisible(false)
    end

    return tip
end

-- 物品信息
function Alert.itemBox(name, count, detail, icon, msg)
    local tip = util.createluaItem("ui.tip.itembox")

    tip.lbl_name:setString(name)
    tip.lbl_count:setString("X" .. count)
    tip.lbl_message:setString(detail)
    local sprite = cc.Sprite:createWithSpriteFrameName(icon)

    local size = tip.sp_iconbg:getContentSize()
    sprite:setPositionY(size.height/2)
    sprite:setPositionX(size.width/2)

    tip.sp_iconbg:addChild(sprite)
    local function close()
        if shedule then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(shedule)
        end
        util.tryRemove(tip)
    end
    util.clickSelf(self, tip.pnl_close, close)
    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self, tip.pnl_close, close)

    util.addToPop(tip)
    return tip
end

-- 科技信息
function Alert.scienceBox(name, detail, icon)
    local tip = util.createluaItem("ui.tip.itembox")
    tip.lbl_name:setString(name)
    tip.lbl_message:setString(detail)
    tip.lbl_count:setString("") 
    tip.sp_iconbg:setSpriteFrame(icon)
    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self, tip.pnl_close, close)

    util.addToPop(tip)
    return tip
end

-- 购买窗
function Alert.ShoppingBox(sf, msg, dec, name, count, icon, confirmFunc, cost, pricetype,goldIcon,isNobuyBack)
    local tip = util.createluaItem("ui.tip.shoppingbox")
    tip.lbl_msg:setString(msg)
    tip.lbl_name:setString(name)
    tip.lbl_detail:setString(dec)
    tip.lbl_count:setString(count)
    tip.lbl_goldCount:setString(cost)
    local sprite = cc.Sprite:createWithSpriteFrameName(icon)
    local size = tip.sp_iconbg:getContentSize()
    sprite:setPositionY(size.height/2)
    sprite:setPositionX(size.width/2)
    tip.sp_iconbg:addChild(sprite)
    local playerInfo = PlayerData:getPlayer()
    local wood = playerInfo.wood
    local food = playerInfo.food
    local gold = playerInfo.gold
    local buy = true

    if goldIcon then
        util.loadImage(tip.img_goldIcon,goldIcon)
    end
    if pricetype == 1 then
        if gold < cost then
            buy = false
        end
    elseif pricetype == 2 then
        if food < cost then
            buy = false
        end
    else
        if wood < cost then
            buy = false
        end
    end

    if not buy then
        tip.lbl_goldCount:setColor( css.red )
        if not isNobuyBack then
            tip.btn_confirm:setEnabled(false)
        end      
    end

    local function btnClick(...)
        util.tryRemove(tip)
        --若无法购买，并且有相关回调函数，则跳转
        if isNobuyBack and  not buy then
            local nobackFun = handler(sf, isNobuyBack)
            if isNobuyBack then
                nobackFun()
            end
        else
            local backFun = handler(sf, confirmFunc)
            if confirmFunc then
                backFun()
            end
        end
    end
    util.clickSelf(self, tip.btn_confirm, btnClick)

    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self, tip.pnl_close, close)

    util.addToPop(tip)
    return tip
end

function Alert.messageBox1( msg,richText )
	local tip = util.createluaItem("ui.tip.messagebox1")
	local bgSize = tip.img_bg:getContentSize()

	if richText then
		richText:setAnchorPoint(cc.p(0,0.5))
		tip.nd_rich:setPositionY(tip.img_bg:getPositionY()+20)
		tip.nd_rich:addChild(richText)
        richText:formatText()
		local richSize = richText:getBodySize()
		local bgSize = tip.img_bg:getContentSize()
        trace(richSize.height,bgSize.height)
		tip.img_bg:setContentSize(bgSize.width, richSize.height+50)
		tip.lbl_message:setVisible(false)
	else
		tip.lbl_message:setString(msg)
		local tipSize = tip.lbl_message:getContentSize()
        local fontSize = tip.lbl_message:getFontSize()+5
        local newSize = math.ceil(tipSize.width/500)*fontSize
        tip.lbl_message:ignoreContentAdaptWithSize(false)
        tip.lbl_message:setTextAreaSize(cc.size(500,newSize))
        tip.lbl_message:setTextHorizontalAlignment(0)
		tip.img_bg:setContentSize(560,tip.lbl_message:getContentSize().height+50)
		tip.lbl_message:setPositionY(tip.img_bg:getPositionY() + 0)
	end

	local function close()
		util.tryRemove(tip)
	end
	util.clickSelf(self,tip.pnl_close,close)
	util.addToPop(tip)
    return tip
end

function Alert.messageBox3(msg, okFun, cancelFun,spriteFlag)
    local tip = util.createluaItem("ui.tip.messagebox3")
    tip.lbl_message:setString(msg)

    tip.btn_ok:setTitleText(Language.get("10153"))

    local function close()
        util.tryRemove(tip)
    end

    util.clickSelf(self, tip.pnl_close,
    function()
        if cancelFun ~= nil then
            cancelFun()
        end
        close()
    end
    )

    util.clickSelf(self, tip.btn_ok,
    function()
        if okFun ~= nil then
            okFun()
        end
        close()
    end
    )

    util.addToPop(tip)
	
	if(spriteFlag ~= nil) then
		--util.loadButton(tip.btn_ok,"Btn_grey.png",1)
		trace("111111111")
		util.setEnabledBtn(tip.btn_ok,spriteFlag)
	end
    return tip
end

--消息框4
--@param：sf：
--@param：type：1（msg1 标题红色，msg2普通文本），2（msg1普通文本，msg2普通文本），默认1
--@param：tab：其他参数
        --tab.msg1：文字1
        --tab.msg2：文字2
        --tab.btnTitle1：按钮1文本
        --tab.btnTitle2：按钮2文本
        --tab.defFun：仅关闭窗口回调
        --tab.btnFun1：按钮1回调
        --tab.btnFun2：按钮2回调
function Alert.messagebox4( sf, type, tab )
    if sf == nil or tab == nil then
        return
    end

    if type == nil then
        type = 1
    end
    
    local tip = util.createluaItem( "ui.tip.messagebox4" )

    if type == 1 then
        tip.nd_type1:setVisible( true )
        tip.nd_type2:setVisible( false )
        tip.lbl_message_1:setString( tab.msg1 or "" )
        tip.lbl_message_2:setString( tab.msg2 or "" )
    elseif type == 2 then
        tip.nd_type1:setVisible( false )
        tip.nd_type2:setVisible( true )
        tip.lbl_message_3:setString( tab.msg1 or "" )
        tip.lbl_message_4:setString( tab.msg2 or "" )
    else
        return
    end

    tip.btn_operate_1:setTitleText( tab.btnTitle1 or "" )
    tip.btn_operate_2:setTitleText( tab.btnTitle2 or "" )

    local function close()
        util.tryRemove( tip )
    end

    local function defClose( ... )
        close()
        if tab.defFun then
            local backFun = handler( sf, tab.defFun )
            backFun()
        end
    end

    local function operate1( ... )
        close()
        if tab.btnFun1 then
            local backFun = handler( sf, tab.btnFun1 )
            backFun()
        end
    end

    local function operate2( ... )
        close()
        if tab.btnFun2 then
            local backFun = handler( sf, tab.btnFun2 )
            backFun()
        end
    end

    util.clickSelf( self, tip.pnl_close, defClose )
    util.clickSelf( self, tip.btn_operate_1, operate1 )
    util.clickSelf( self, tip.btn_operate_2, operate2 )

    util.addToPop(tip)

    return tip
end

-- 
function Alert.messageBox5(msg, table1, table2)
    local tip = util.createluaItem("ui.tip.messagebox5")
 
	local richText = RichTextArea.create(450,0)
	tip.sv_list:addChild(richText)
	richText:appendText(msg)
	richText:formatText()
	local rSize = richText:getVirtualRendererSize()
	
	local listSize = tip.sv_list:getInnerContainerSize()
	richText:setPositionY(listSize.height - rSize.height)
	
	local fun1 = table1.func
	local fun2 = table2.func
	tip.btn_vip:setTitleText(table1.text)
	tip.btn_college:setTitleText(table2.text)
	
    local function close()
        util.tryRemove(tip)
    end
	local function btnFunc1()
        close()
        if table1.func then
          fun1()
        end
    end
    local function btnFunc2()
        close()
        if table2.func then
          fun2()
        end
    end 
	util.clickSelf(self, tip.pnl_close, close)	
    util.clickSelf(self, tip.btn_vip, btnFunc1)
    util.clickSelf(self, tip.btn_college, btnFunc2)
    util.addToPop(tip)
    return tip
end

function Alert.messageBox6(msg, fun1)
    local tip = util.createluaItem("ui.tip.messagebox6")
 
	tip.lbl_desc:setString(msg)
		
    local function close()
        util.tryRemove(tip)
    end
	
	if not fun1 then
		fun1 = function() end
	end
	local function btnFunc1()
		close()
		fun1()
	end
	util.clickSelf(self, tip.pnl_close, close)	
    util.clickSelf(self, tip.btn_sure, btnFunc1)
    util.addToPop(tip)
    return tip
end

function Alert.messageBox7(msg, table1, table2)
    local tip = util.createluaItem("ui.tip.messagebox7")
     
    tip.lbl_content:setString(msg)
    local fun1 = table1.func
    local fun2 = table2.func
    tip.btn_cancel:setTitleText(table1.text)
    tip.lbl_confirm:setString(table2.text)
    tip.lbl_num:setString(table2.num)
    
    local function close()
        util.tryRemove(tip)
    end
    local function btnFunc1()
        close()
        if fun1 then
          fun1()
        end
    end
    local function btnFunc2()
        close()
        if fun2 then
          fun2()
        end
    end 
    util.clickSelf(self, tip.pnl_close, close)  
    util.clickSelf(self, tip.btn_cancel, btnFunc1)
    util.clickSelf(self, tip.btn_confirm, btnFunc2)
    util.addToPop(tip)
    return tip
end
--能定时消失的 提示框
--@param：message：消息文本
--@param：closeFun：回调函数
--@param：time：消失时间
function Alert.timeDisappearTip( message, closeFun, time )
    local tip = util.createluaItem( "ui.tip.timeDisappearTip" )
    
    if message ~= nil then
        tip.lbl_desc:setString( message )
    end

    if time == nil then
        time = 1
    end

    local delayTime = cc.DelayTime:create( time )
    local funCall = cc.CallFunc:create( function() 
        util.tryRemove( tip ) 
        if closeFun ~= nil then
            closeFun()
        end
    end )
    local action = cc.Sequence:create( delayTime, funCall )
    tip:runAction( action )

    util.addToPop( tip )

    return tip
end

-- 物品信息
function Alert.messageBox2(title, msg)
    local tip = util.createluaItem("ui.tip.messagebox2")
    tip.lbl_title:setString(title)
    tip.lbl_message:setString(msg)

    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self, tip.pnl_close, close)
    util.addToPop(tip)
    return tip
end

-- 多项物品奖励
function Alert.rewardBox1(msg, itemTable)
    local tip = util.createluaItem("ui.tip.rewardbox1")
    tip.lbl_message:setString(msg)

    for i = 1, 3 do
        if i <= #itemTable then
            local sprite = cc.Sprite:createWithSpriteFrameName(itemTable[i].icon)
            tip["sp_iconbg" .. i]:addChild(sprite)
            tip["lbl_rewardCount" .. i]:setString(itemTable[i].count)
        else
            tip["sp_iconbg" .. i]:setVisible(false)
            tip["lbl_rewardCount" .. i]:setVisible(false)
        end
    end
    util.addToPop(tip)
    return tip
end

-- 物品领取
function Alert.rewardBox2(title, msg, icon, btnTitle, confirmFunc,sf)
    local tip = util.createluaItem("ui.tip.rewardbox2")
    tip.lbl_title:setString(title)
    tip.lbl_message:setString(msg)
    tip.btn_confirm:setTitleText(btnTitle)
    local sprite = cc.Sprite:createWithSpriteFrameName(icon)
    local size = tip.sp_iconbg:getContentSize()
    sprite:setPositionY(size.height/2)
    sprite:setPositionX(size.width/2)
    tip.sp_iconbg:addChild(sprite)
    local function btnClick(...)
        util.tryRemove(tip)
        local backFun = handler(sf, confirmFunc)
        if confirmFunc then
            backFun()
        end
    end
    util.clickSelf(self, tip.btn_confirm, btnClick)

    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self, tip.pnl_close, close)
    util.addToPop(tip)
    return tip
end

--物品使用
function Alert.gooduse( sf,msg,btnTitle,moreuse,max,confirmFunc)
	local tip = util.createluaItem("ui.tip.gooduse")
	tip.btn_use:setTitleText(btnTitle)

	local rich = RichTextArea.create(
        tip.pnl_title:getContentSize().width,
        tip.pnl_title:getContentSize().height
        )

    tip.pnl_title:addChild(rich)

    rich:appendText(msg)
   
 
    local min = 1
	if moreuse then
		tip.sld_num:setPercent((min/max)*100)
		tip.lbl_max:setString("/"..max)
		tip.tf_min:setString(min)
		tip.sld_num:addEventListener(function ( ... )
			min = math.ceil(max*((tip.sld_num:getPercent())/100))
			if min == 0 then 
				min = 1 
			end
			tip.tf_min:setString(min)
		end)
	else
		tip.pnl_silder:setVisible(false)
	end

	local function close()
		util.tryRemove(tip)
	end
	util.clickSelf(self,tip.pnl_close,close)

	local function btnClick( ... )
		util.tryRemove(tip)
		if confirmFunc then
             local backFun =  handler(sf, confirmFunc)
		     if confirmFunc then
                 backFun(min)
		     end
		end
	end
	util.clickSelf(self,tip.btn_use,btnClick)
    local function btnAdd( ... )
        if min < max then
            min = min +1
            tip.tf_min:setString(min)
        end
        tip.sld_num:setPercent((min/max)*100)
    end
    util.clickSelf(self,tip.btn_add,btnAdd)

    local function btnSub( ... )
        min = min-1
        if min == 0 then 
            min = 1 
        end
        tip.tf_min:setString(min)
        tip.sld_num:setPercent((min/max)*100)
    end
    util.clickSelf(self,tip.btn_subtract,btnSub)
    util.addToPop(tip)
    return tip
end

--宝箱使用
function Alert.Resourceuse( sf,msg,itemTable)
    local tip = util.createluaItem("ui.tip.useResourceBox")
    tip.lbl_title:setString(msg)
    local poy
    local key = 1
    for k,v in pairs(itemTable) do
        local goodInfo = TemplateData:getItem(v.itemID)
        local item = util.createluaItem("ui.tip.ResourceItems")
        local sprite = cc.Sprite:createWithSpriteFrameName(goodInfo.icon..".png")
        item.Node_1:addChild(sprite)
        item.lbl_name:setString(Language.get(goodInfo.name))
        item.lbl_count:setString("+"..v.num)
        item.Ima_goodbg:setVisible(false)
        if goodInfo.type == 16 then
            item.Ima_goodbg:setVisible(true)
            util.loadImage(item.Ima_goodbg,"tool_" .. goodInfo.quality .. ".png",1)
        end    
        item:setPosition(20,10+(key-1)*(item:getContentSize().height+10))
        tip.img_bg:addChild(item)
        poy =10+(key-1)*(item:getContentSize().height+10)+item:getContentSize().height
        key = key + 1
    end

    tip.sp_line:setPositionY(poy+20)
    tip.lbl_title:setPositionY(poy+35)


    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self,tip.pnl_close,close)

    util.addToPop(tip)
     return tip
end

-- 资源提示
function Alert.resTip()
    local tip = util.createluaItem("ui.tip.resTip")


    local function setString(node,str,res,resSave)
        if res<=0 and resSave<=0 then
            node:setVisible(false)
        else
            if res>resSave then
                str:setColor(cc.c4b(240,20,0,255))
            end
            str:setString(util.numberFormat(res,nil,1).."/"..util.numberFormat(resSave,nil,1))
        end

    end
    local function update()
        if tip == nil then
            return
        end
        local wood = PlayerData:getWood()
        local iron = PlayerData:getIron()
        local food = PlayerData:getFood()
        local silver = PlayerData:getSilver()

        local swood = PlayerData:getSavewood()
        local siron = PlayerData:getSaveiron()
        local sfood = PlayerData:getSavefood()
        local ssilver = PlayerData:getSavesilver()

        setString(tip.img_wood,tip.lbl_wood,wood,swood)
        setString(tip.img_food,tip.lbl_food,food,sfood)
        setString(tip.img_iron,tip.lbl_iron,iron,siron)
        setString(tip.img_silver,tip.lbl_silver,silver,ssilver)
    end
    update()
    GameEvent:addEventListener(GameEvent.updatePlayerInfo, tip,update)
    GameEvent:addEventListener(GameEvent.updateBuild, tip,update)
    
    local function close()
        GameEvent:revmoveTargetEvents(tip)
        util.tryRemove(tip)
    end
    util.clickSelf(self,tip.pnl_close,close)

    util.addToPop(tip)
    return tip
end

--购买物品
function Alert.buyitem( sf,Title,msg,cost,max,itype,icon,confirmFunc)
	local tip = util.createluaItem("ui.tip.buyitem")
	tip.lbl_title:setString(Title)

	local rich = RichTextArea.create(
        tip.pnl_title:getContentSize().width,
        tip.pnl_title:getContentSize().height
        )

    tip.pnl_title:addChild(rich)

    rich:appendText(msg)
   
    tip.lbl_goumai:setString(Language.get("43209"))
    tip.lbl_cost:setString(cost)

    local sprite = cc.Sprite:createWithSpriteFrameName(icon..".png")
    tip.nd_icon:addChild(sprite)

    if itype == 1 then
        tip.sp_allianceContributionSpr1:setVisible(false)
        tip.lbl_isGet:setString(string.formatIndex(Language.get("43210"),Title))
    else
        tip.sp_alliancePointSpr1:setVisible(false)
        tip.lbl_isGet:setString(Language.get("47006"))
    end    

    local min = 1
	tip.sld_num:setPercent((min/max)*100)
	tip.lbl_max:setString("/"..max)
	tip.tf_min:setString(min)
	tip.sld_num:addEventListener(function ( ... )
		min = math.ceil(max*((tip.sld_num:getPercent())/100))
		if min == 0 then 
			min = 1 
		end
		tip.tf_min:setString(min)
	end)

	local function close()
		util.tryRemove(tip)
	end
	util.clickSelf(self,tip.pnl_close,close)

	local function btnClick( ... )
		util.tryRemove(tip)
		if confirmFunc then
             local backFun =  handler(sf, confirmFunc)
		     if confirmFunc then
                 backFun(min)
		     end
		end
	end
	util.clickSelf(self,tip.btn_use,btnClick)

    local function btnAdd( ... )
        if min < max then
            min = min +1
            tip.tf_min:setString(min)
        end
        tip.sld_num:setPercent((min/max)*100)
    end
    util.clickSelf(self,tip.btn_add,btnAdd)

    local function btnSub( ... )
        min = min-1
        if min == 0 then 
			min = 1 
		end
        tip.tf_min:setString(min)
        tip.sld_num:setPercent((min/max)*100)
    end
    util.clickSelf(self,tip.btn_subtract,btnSub)

    util.addToPop(tip)
    return tip
end

--系统更新提示
function Alert.updateInfobox(title,msg,sf,sfHandler,typeBut)
    local tip = util.createluaItem("ui.tip.updateInfobox")

    tip.lbl_title:setString(title)

    local rich = RichTextArea.create(
        tip.pnl_detail:getContentSize().width,
        tip.pnl_detail:getContentSize().height
        )

    tip.pnl_detail:addChild(rich)

    rich:appendText(msg)


    if typeBut == Alert.OK then
        tip.btn_yes:setVisible(false)
        tip.btn_no:setVisible(false)

        local function btnOK( ... )
            util.tryRemove(tip)
            if sfHandler then
                 local backFun =  handler(sf, sfHandler)
                 if sfHandler then
                     backFun(Alert.OK)
                 end
            end 
        end 

        util.clickSelf(self,tip.btn_ok,btnOK)
    else
        tip.btn_ok:setVisible(false)
        local function btnYES( ... )
            util.tryRemove(tip)
            if sfHandler then
                 local backFun =  handler(sf, sfHandler)
                 if sfHandler then
                     backFun(Alert.YES)
                 end
            end 
        end
        util.clickSelf(self,tip.btn_yes,btnYES)
        local function btnNO( ... )
            util.tryRemove(tip)
            if sfHandler then
                 local backFun =  handler(sf, sfHandler)
                 if sfHandler then
                     backFun(Alert.NO)
                 end
            end 
        end
        util.clickSelf(self,tip.btn_no,btnNO)        
    end 


    util.addToPop(tip)
    return tip
end

--伤兵治疗资源不足提示
--1，self，2，描述，3，需要的资源表，4，回调
function Alert.treatTip(sf,msg,itemTable,confirmFunc,goldNum)
    local tip = util.createluaItem("ui.tip.treatTip")

    local userData={}
    userData["gold"] = PlayerData:getGold()
    userData["wood"] = PlayerData:getWood()
    userData["food"] = PlayerData:getFood()
    userData["iron"] = PlayerData:getIron()
    userData["silver"] = PlayerData:getSilver()


    for k,v in pairs(itemTable) do
        local cha =  v - userData[k]
        if cha>0 then
            tip["img_"..k]:setVisible(true)
            tip["lbl_"..k]:setVisible(true)      
            local str = util.numberFormat(cha)
            tip["lbl_"..k]:setString(str)
        else
            tip["img_"..k]:setVisible(false)
            tip["lbl_"..k]:setVisible(false)           
        end
    end

    local function btnClick(...)
        if not PlayerData:checkgold(goldNum) then
            GameHelper:noGoldTip()
            return
        end
        util.tryRemove(tip)
        if confirmFunc then
            local backFun = handler(sf, confirmFunc)
            if confirmFunc then
                backFun(sf)
            end
        end
    end

    util.clickSelf(self, tip.btn_confirm, btnClick)


    tip.lbl_goldNum:setString(goldNum)
    tip.lbl_message:setString(msg)
    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self,tip.pnl_close,close)

    util.addToPop(tip)
     return tip
end

--购买物品
function Alert.shoppingBox2( sf,name,msg,cost,max,icon,confirmFunc)
    local tip = util.createluaItem("ui.tip.shoppingBox2")
    tip.lbl_name:setString(name)

    local sprite = cc.Sprite:createWithSpriteFrameName(icon..".png")
    tip.nd_icon:addChild(sprite)

    tip.lbl_detail:setString(msg)
    tip.lbl_isGet:setString(Language.get("47006"))

    local min = 1
    tip.sld_num:setPercent((min/max)*100)
    tip.tf_min:setString(min)
    tip.lbl_goldCount:setString(cost*min)
    tip.sld_num:addEventListener(function ( ... )
        min = math.ceil(max*((tip.sld_num:getPercent())/100))
        if min == 0 then 
            min = 1 
        end
        tip.tf_min:setString(min)
        tip.lbl_goldCount:setString(cost*min)
        if cost*min > PlayerData:getGold() then
            tip.lbl_goldCount:setColor(css.red)
        else
            tip.lbl_goldCount:setColor(css.white)
        end
    end)

    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self,tip.pnl_close,close)

    local function btnClick( ... )
        util.tryRemove(tip)
        if confirmFunc then
             local backFun =  handler(sf, confirmFunc)
             if confirmFunc then
                if cost*min <= PlayerData:getGold() then
                    backFun(min)
                else
                    backFun(0)
                end
             end
        end     
    end
    util.clickSelf(self,tip.btn_confirm,btnClick)

    local function btnAdd( ... )
        if min < max then
            min = min +1
            tip.tf_min:setString(min)
        end
        tip.sld_num:setPercent((min/max)*100)
        tip.lbl_goldCount:setString(cost*min)
        if cost*min > PlayerData:getGold() then
            tip.lbl_goldCount:setColor(css.red)
        else
            tip.lbl_goldCount:setColor(css.white)
        end
    end
    util.clickSelf(self,tip.btn_add,btnAdd)

    local function btnSub( ... )
        min = min-1
        if min == 0 then 
            min = 1 
        end
        tip.tf_min:setString(min)
        tip.sld_num:setPercent((min/max)*100)
        tip.lbl_goldCount:setString(cost*min)
        if cost*min > PlayerData:getGold() then
            tip.lbl_goldCount:setColor(css.red)
        else
            tip.lbl_goldCount:setColor(css.white)
        end
    end
    util.clickSelf(self,tip.btn_subtract,btnSub)

    util.addToPop(tip)
    return tip
end


--错误窗口
local _nevetShowAgain = false
function Alert.debugWin(msg)
    msg = msg.."\r\n_____________________"
    if _nevetShowAgain then
        return
    end
    if Alert.showingDebug then
        Alert.showingDebug.addDebugMsg(msg)
        return
    end
    local tip =  util.createluaItem("ui.tip.debugWin")
    Alert.showingDebug = tip
    tip.addDebugMsg = function(text)
        util.listAddBugString(tip.ls_msg,text,20,cc.c4b(0,0,0,255))
    end
    tip.addDebugMsg(msg)
    local  close = function()
        util.tryRemove(tip)
        Alert.showingDebug = nil
    end
    util.clickSelf(self,tip.btn_close,function()
        close()
    end)

    util.clickSelf(self,tip.btn_neverShow,function()
        close()
        _nevetShowAgain = true
    end)
    

    util.addToPop(tip)
    return tip
end

-- 新兵多项奖励
function Alert.rewardBox3(msg, itemTable)
    local tip = util.createluaItem("ui.tip.rewardbox3")
    tip.lbl_message:setString(msg)
    
    for i, v in pairs(itemTable) do
 	    local item = util.createluaItem("ui.tip.rewardbox3Item")
		util.listAddItem(tip.ls_item, item)
        for a, b in pairs(v)do
            if a == 1 then
                local itemData = TemplateData:getItem(b)               
                item.lbl_name:setString(itemData.name1)
                if itemData.quality ~= "" then
                    local quality = itemData.quality
                    util.loadImage(item["img_tool"], "tool_" .. quality .. ".png")
                    util.loadImage(item["img_kuang"], "icon_kuang.png")         
                    util.loadImage(item["img_icon"], itemData.icon..".png")            
                end
            else
                item.lbl_num:setString("+"..b)
            end            
        end              
    end
    util.addToPop(tip)
    local function close()
        util.tryRemove(tip)
    end
    util.clickSelf(self,tip.pnl_close,close)
    return tip
end

return Alert