util = class("utill")



----------------------------------------------
--工具方法
----------------------------------------------
--打印
local debugUI = false
local socket = require "socket"
   
function util.exit()
    cc.Director:getInstance():endToLua()
end

function util.getKey(key)
    return cc.UserDefault:getInstance():getStringForKey(key,"")
end

function util.setKey( key,str )
    cc.UserDefault:getInstance():setStringForKey(key,str)
    cc.UserDefault:getInstance():flush()
end

function util.merge(dest,src)
    for k,v in pairs(src) do
        dest[k]=v
    end
end

function util.clone(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
				return object
		elseif lookup_table[object] then
				return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for key, value in pairs(object) do
				new_table[_copy(key)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	 end
	return _copy(object)
end

-----------------------------------------------
--界面创建
-----------------------------------------------

--从csb创建界面
-- function util.createcsb(filePath)
--     local startTime = os.clock()
--     local node = cc.CSLoader:createNode(filePath)
--     print("cost time "..filePath.." "..(os.clock()-startTime))
--     return node
-- end

-- function util.createCsbItem(file)
--     local item = cc.CSLoader:createNode(file)
--     local itemwarp = ccui.Widget:create()
--     itemwarp:addChild(item)
--     itemwarp:setContentSize(item:getContentSize())
--     return itemwarp
-- end

--从csd界面转lua的界面创建
function util.createlua(obj)
    local temp = require(obj.uipath)
    local node = temp.create()
    node.textures = temp.textures
    return node
end

--加载列
function util.createluaItem(uipath)
    local temp = require(uipath)
    local item = temp.create()
    -- local itemwarp = ccui.Widget:create()
    -- itemwarp.textures = temp.textures
    -- itemwarp:addChild(item.root)
    -- itemwarp:setContentSize(item.root:getContentSize())
    -- itemwarp.node=item.root
    -- return itemwarp,item.root
     return item.root
end

--从cbs中获取节点 添加点击事件  func要处理回调事件的类型  参考 clickMain
function util.addEvent(root,name,func)
	local node = getnode(root,name)
	if node then
        if debugUI then 
            trace("util.addEvent "..name)
        end 
	    node:addClickEventListener(func)
	else
        trace("util.addEvent not find "..name)
    end
end

--延迟初始化列表   see Task.lua   line:42
--type 为itemSetFun 第二个参数
function util.listview(list,tb,itemCreateFun,itemSetFun,type )
    if tb ==nil or #tb ==0 then 
        list:removeAllItems()
        list.items={}
        return 
    end 
    if list.items ==nil then 
        list.items={}
    end
    local lastLen = list.lastLen or 0

    local itr = list_iter(tb)
    
    --清除上次未完成的  防止快速切换
    util.listviewclear(list)
    list.index = 1
    -- print("setlen",#tb,list.lastLen)

    --清楚多余项
    local crrLen = #tb
    if lastLen >0 and lastLen > crrLen then 
        -- print("remove",crrLen,lastLen)
        for i=crrLen+1,lastLen do
            table.remove(list.items,crrLen+1)
            list:removeItem(crrLen)
        end
    end
    list.lastLen = crrLen

    local tickFun = function ()
        for i=1,10 do
            local v = itr()
            if v then 
				if list.items then
					local item = list.items[list.index]
					if tolua.isnull(item) then 
						item = itemCreateFun()
						list:pushBackCustomItem(item)
						list.items[list.index]=item
					end
					itemSetFun(item,v,type)
					list.index = list.index +1								
				else
					trace("list.items found nil")
				end
            else
                util.listviewclear(list)
                break
            end
        end
    end
    list.tick = scheduler.scheduleGlobal(tickFun,0.001)
end

--延迟处理函数,同一个node中,根据添加的顺序,执行func
function util.addSchedulerFuns(node,func)
    node._scheduleFuns = node._scheduleFuns or {}
    table.insert(node._scheduleFuns,func)
    local sharedScheduler = cc.Director:getInstance():getScheduler()
    node._schedulehandle = node._schedulehandle or sharedScheduler:scheduleScriptFunc(function()
        local fun = (not tolua.isnull(node)) and node._scheduleFuns and table.remove(node._scheduleFuns,1)
        if fun then
            fun()
        elseif node._schedulehandle then
            sharedScheduler:unscheduleScriptEntry(node._schedulehandle)
            node._schedulehandle = nil
        end
    end,0,false)

    node:registerScriptHandler(function(state)
	    if state == "exit" then
	        if node._schedulehandle then
                sharedScheduler:unscheduleScriptEntry(node._schedulehandle)
                node._schedulehandle = nil
            end
	    end
	end)
end

--dispose  记得调用  预付被清理
function util.listviewclear(list)
    if list.tick then 
        scheduler.unscheduleGlobal(list.tick)
        list.tick =nil
    end
end

--点击全屏窗口  
--util.clickMain(self,"login_button",ui.gameLoading,self.checkSeclet)
function util.clickMain( root,name,uipath,funcheckClick)
    util.click(root,name,util.changeMainUI,uipath,funcheckClick)
end

--点击弹窗
function util.clickWin( root,name,uipath,funcheckClick,parameter2 )
    assert(uipath,"check ui path is nil")
    util.click(root,name,util.pushWin,uipath,funcheckClick,parameter2)
end

--点处理函数  funDot  util.m       funcheckClick class:m
--root 查找的根节点   
--name 查找对象名称
--funDot  root.functionName  
--parameter1 funDot参数
--funcheckClick  检查是否可以点击
--parameter2 funDot参数
function util.click( root,name,funDot,parameter1,funcheckClick,parameter2 )
    local node = getnode(root,name)
    if node then
        local touch = function ( cnode ,event )
            -- check can click
            if funcheckClick then 
                local hd = handler(root,funcheckClick)
                if hd()==false then 
                    if debugUI then 
                        trace("util.click false "..name)
                    end 
                    return
                end
            end
           funDot(parameter1,parameter2)
        end
        node:addClickEventListener(touch)
    else
        trace("util.click not find "..name)
    end
end

--点击函数class内部处理
---- util.clickSelf(self,"login_button",self.checkSeclet)
function util.clickSelf( root,name,funcheckClick,parameters )
    local node = getnode(root,name)
    if node then
        node:setTouchEnabled(true)
        local touch = function ( cnode ,event )
           local hd = handler(root,funcheckClick)
           hd(parameters)
        end
        node:addClickEventListener(touch)
    else
        trace("util.click not find "..(name or ""))
    end
end


--checkbox 事件侦听
function util.ckeckboxSelf( root,name,funcheckClick,parameters  )
    local node = getnode(root,name)
    if node then
        local touch = function ( ... )
           local hd = handler(root,funcheckClick)
           hd(...,parameters)
        end
        node:addEventListener(touch)
    else
        trace("util.click not find "..name)
    end
end


----------------------------------------
--界面管理
----------------------------------------
util.ID_BG    = 1
util.ID_Main  = 2
util.ID_Menu  = 4
util.ID_Modal = 5
util.ID_Win   = 6
util.ID_Tip   = 7
util.ID_Debug = 8

--天气
util.ID_Weather = 3
util.ID_Guild = 9

local scenes = {}
local lastMainLayer = nil
local lastName = ""
local lastWinLayer = {}

function util.init( )
    util.initScene()
end

--初始化场景  全局只有一个scene在跑      禁止重新建立场景
function util.initScene()
    util.getsize()
    local sc = cc.Director:getInstance():getRunningScene()
    if sc == nil then
        sc = cc.Scene:create()
        sc:setTag(1)
        cc.Director:getInstance():runWithScene(sc)
    else
        if sc:getTag() == -1 then 
            sc = cc.Scene:create()
            sc:setTag(1)
            cc.Director:getInstance():replaceScene(sc)
        end
    end
    --  主界面层   弹出窗口层   tip层
    scenes.fixLayer     = cc.Layer:create()
    scenes.mainLayer    = cc.Layer:create()
    scenes.menuLayer    = cc.Layer:create()
    scenes.modalLayer   = cc.Layer:create()
    scenes.winPopLayer  = cc.Layer:create()
    scenes.tipPopLyaer  = cc.Layer:create()
    scenes.debugLayer   = cc.Layer:create()

    scenes.weatherLayer   = cc.Layer:create()
	scenes.guildLayer   = cc.Layer:create()
    
    sc:addChild(scenes.fixLayer    ,util.ID_BG   ,util.ID_BG)
    sc:addChild(scenes.mainLayer    ,util.ID_Main   ,util.ID_Main)
    sc:addChild(scenes.menuLayer    ,util.ID_Menu   ,util.ID_Menu)
    sc:addChild(scenes.modalLayer   ,util.ID_Modal  ,util.ID_Modal)
    sc:addChild(scenes.winPopLayer  ,util.ID_Win    ,util.ID_Win)
    sc:addChild(scenes.tipPopLyaer  ,util.ID_Tip    ,util.ID_Tip)
    sc:addChild(scenes.debugLayer   ,util.ID_Debug  ,util.ID_Debug)
    
    sc:addChild(scenes.weatherLayer   ,util.ID_Weather  ,util.ID_Weather)
	sc:addChild(scenes.guildLayer   ,util.ID_Guild  ,util.ID_Guild)

    --设备适配位置
    util.aptdown(scenes.fixLayer)
    util.aptdown(scenes.mainLayer)
    util.aptdown(scenes.menuLayer)
    util.aptdown(scenes.modalLayer)
    util.aptdown(scenes.winPopLayer)
    util.aptdown(scenes.tipPopLyaer)
    util.aptdown(scenes.weatherLayer)
    util.aptdown(scenes.debugLayer)
	util.aptdown(scenes.guildLayer)
	-- 返回键监听
	util.addKeyBack()
end

function util.setBackEnabled(state)
	if state then -- 添加返回
		if not util.keyBackListener then
			trace("添加返回监听")
			util.addKeyBack()
		end
	else -- 移除返回
		if util.keyBackListener then
			trace("移除返回监听")
			local eventDispatcher = scenes.winPopLayer:getEventDispatcher()
			eventDispatcher:removeEventListener(util.keyBackListener)
			util.keyBackListener = nil
		end	
	end
end

-- 返回键监听
function util.addKeyBack()
	local function onKeyReleased(keyCode, event)
		if keyCode == cc.KeyCode.KEY_BACK then
			trace("click return")
			local childCount = scenes.winPopLayer:getChildrenCount()
			if childCount > 0 then
				util.popWin()
				return
			end
			if scenes.isExitGameing then
				return
			end		
			local tag = scenes.mainLayer:getChildrenCount()
			local win = scenes.mainLayer:getChildByTag(tag-1)
			if win and win:getName() == ui.BigMap.path then -- 在大地图界面
				GameEvent:notifyView(GameEvent.mainSceneSwitch)
			else -- 退出游戏
				scenes.isExitGameing = true
				local obj = Alert.messageBox6(Language.get("10331"), function() SystemUpdate:exitGame() end)
				util.clickSelf(obj, obj.pnl_close, function()
					util.tryRemove(obj)
					scenes.isExitGameing = false
				end)
			end
		-- elseif keyCode == cc.KeyCode.KEY_MENU  then
			-- trace("click menu")
		end
	end
	local listener = cc.EventListenerKeyboard:create()
	listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )
	local eventDispatcher = scenes.winPopLayer:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, scenes.winPopLayer)
	util.keyBackListener = listener
end

function util.aptdown(node)
    if node == nil then
        trace("error:util.aptdown node is nil")
        return
    end
    node:setPositionY(node:getPositionY()-util.display.offy)
end


--底部节点适配
function util.aptnode(node)
    if node == nil then
        trace("error:util.aptnode node is nil")
        return
    end
    node:setPositionY(node:getPositionY()+util.display.offy)
end

--整窗口屏幕适配
--node为全屏窗口
--oldlayoutHeight 为递归使用,调用时不用填
function util.aptSelf(node,oldlayoutHeight,oldlayoutWidth)
    if node ==nil then
        trace("error:util.aptSelf node is nil")
        return
    end
    local director = cc.Director:getInstance()
    local view = director:getOpenGLView()
    local viewsize = director:getWinSize()
    local size = node:getContentSize()
    local layoutHeight =  oldlayoutHeight or size.height
    local layoutWidth =  oldlayoutWidth or size.width
    local scaleY = viewsize.height / layoutHeight
    local scaleX = viewsize.width / layoutWidth
  
    for _,child in pairs( node:getChildren()) do  
        local oldanchor = util.changeAnchor(child,cc.p(0.5,1))
        local pos = cc.p(child:getPosition())
        if oldlayoutHeight then
            pos.y = scaleY*pos.y
        else
            pos.y = pos.y + util.display.offy*(size.height/layoutHeight)*(size.height-pos.y)/size.height
        end
        if oldlayoutWidth then
            pos.x = scaleX*pos.x
        else
            pos.x = pos.x + util.display.offx*(size.width/layoutWidth)*(size.width-pos.x)/size.width
        end

        child:setPosition(pos.x,pos.y)
        if iskindof(child,"ccui.Button") then
        elseif  iskindof(child,"cc.Sprite") then
            child:setScaleY(scaleY)
        elseif  iskindof(child,"ccui.ListView") then
            local size = child:getContentSize()
            size.height = size.height*scaleY
            child:setContentSize(size)
        else
            local size = child:getContentSize()
            size.height = size.height*scaleY
            child:setContentSize(size)
            util.aptSelf(child,layoutHeight,layoutWidth)
       end
       util.changeAnchor(child,oldanchor)
   end
end

--改变锚点,不移动位置
function util.changeAnchor(node,newAnchor)
    local oldAnchor = node:getAnchorPoint()
    if newAnchor == nil or (oldAnchor.y == newAnchor.y and oldAnchor.x == newAnchor.x) then
        return oldAnchor
    end

    local pos = cc.p(node:getPosition())
    local size = node:getContentSize()

    pos.x = pos.x + (newAnchor.x-oldAnchor.x)*size.width*node:getScaleX()
    pos.y = pos.y + (newAnchor.y-oldAnchor.y)*size.height*node:getScaleY()

    node:setPosition(pos.x,pos.y)
    if iskindof(node,"ccui.RichText") then
        node:setAnchorPoint(newAnchor)
    else
        node:setAnchorPoint(newAnchor.x,newAnchor.y)
    end

    return oldAnchor
end


function util.aptsize(node)
    local size = node:getContentSize()
    size.width = size.width + util.display.offx
    size.height = size.height - util.display.offy
    node:setContentSize(size)
   
    size = node:getAnchorPoint()

    if size.y== 0 then 
        util.aptnode(node)
    end

end

--重设控件大小,并且子节点顶部适配,igonTab忽略列表
--主要用于Listview子控件的伸缩
function util.setSizeandAptTop(node,size,igonTab)
    local oldSize = node:getContentSize()
    node:setContentSize(size)
    local xoff = size.width - oldSize.width
    local yoff = size.height - oldSize.height
    local children = node:getChildren()
    for _,child in pairs(children) do
        if not igonTab  or igonTab[child] == nil then
            local x,y = child:getPosition()
            child:setPosition(x+xoff,y+yoff)
        end
    end
end

function util.setaddHight(node,hight,igonTab)
    local size = node:getContentSize()
    if node._defHeight == nil then
        node._defHeight = size.height
    end
    size.height = node._defHeight + hight
    util.setSizeandAptTop(node,size,igonTab)
end

--列表重新设置位置
function util.aptlist(node)

    local size = node:getContentSize()
    size.width = size.width + util.display.offx
    size.height = size.height - util.display.offy
    node:setContentSize(size)


    size = node:getInnerContainerSize()
    size.width = size.width + util.display.offx
    size.height = size.height + util.display.offy
    node:setInnerContainerSize(size)

    size = node:getAnchorPoint()

    if size.y== 0 then 
        util.aptnode(node)
    end
    
end


--stackType
util.ST_Main = 0
util.ST_Win  = 1
util.ST_Alter= 2 



--尝试用统一的销毁接口    销毁对象   然后再移除操作（全局精致调用node移除操作）
function util.tryDispose(node)
	if not  tolua.isnull(node) then 
        if GameTCP then 
            GameTCP:revmoveTargetEvents(node)
        end
        if GameEvent then 
            GameEvent:revmoveTargetEvents(node)
        end
        node:dispose()
	end
    util.tryRemove(node,cleanup)
end

--尝试从父辈移除   是否销毁
function util.tryRemove(node)
	if not  tolua.isnull(node) and node:getParent() then 
        if debugUI then 
            trace("removed :"..node:getName().."  count:"..node:getParent():getChildrenCount())
        end
        node:removeFromParent()
	end
end


local checkSlotKeys = {"create","dispose","getStackType","show","hide","isInStage","refresh","addEvents","removeEvents"}
--检查模块接口
function util.checkSlot(name,...)
    local cl = require(name.path)
    local node = cl.create(...)
    util.aptSelf(node)
    node:resize()
    node:addEvents()
    node:refresh()
    return node
end

--获取最后一次添加的层
function util.lastLayer()
    return nil
end

--获取根场景
function util.getRoot()
    return cc.Director:getInstance():getRunningScene()
end

--获取主界面
function util.getMainLayer()
    return scenes.mainLayer
end

function util.addToMain(node)
    scenes.mainLayer:addChild(node)
end

--获取菜单界面
function util.getMenuLayer()
    return scenes.menuLayer
end

function util.addToMenu(node)
    scenes.menuLayer:addChild(node,1,util.ID_Menu)
end

function util.isOpenBigMap()
	local menu = util.hasMenu()
	if menu then
		return menu:isOpenBigMap()
	else
		return false
	end
end

function util.hasMenu()
    return scenes.menuLayer:getChildByTag(util.ID_Menu)
end

function util.clearTheGuide(luaRequirePath,...)
	scenes.guildLayer:removeAllChildren()
end

function util.pushToGuide(luaRequirePath,...)
	
	local win = util.checkSlot(luaRequirePath,...)
	scenes.guildLayer:addChild(win)
end
--获取弹出界面层
function util.getWinLayer()
    return scenes.winPopLayer
end

function util.addToWin(node)
    scenes.winPopLayer:addChild(node)
end

function util.addToPop(node)
    scenes.tipPopLyaer:addChild(node)
end


--获取提示界面层
function util.getTipLayer()
	return scenes.tipPopLyaer
end

--获取天气层
function util.getWeatherLayer()
    return scenes.weatherLayer
end

--全部界面切换
function util.changeUI(obj,...)
    if obj.type == util.ID_BG then 
        util.__changeFixUI(obj,...)
    elseif obj.type == util.ID_Main then 
        util.__changeMainUI(obj,...)
    elseif obj.type == util.ID_Menu then 
        if util.hasMenu() ==nil then 
            util.addToMenu(util.checkSlot(obj,...))
        end
    elseif obj.type == util.ID_Win then 
        util.__pushWin(obj,...)
    end
end

function util.__changeFixUI(luaRequirePath,...)
    local layer = util.checkSlot(luaRequirePath,...)
    layer:setName(luaRequirePath.path)
    scenes.fixLayer:addChild(layer)
    util.fixPath = luaRequirePath.path
    util.fixLayer = layer
end

--切换界面
function util.__changeMainUI(luaRequirePath,...)
    if lastName== luaRequirePath then 
        return 
    end
    local temp = os.clock()
    
    if lastMainLayer then 
        util.tryDispose(lastMainLayer)
    end

    if luaRequirePath.path ~= util.fixPath then 
        if util.fixLayer then 
            util.fixLayer:hide()
        end

        local layer = util.checkSlot(luaRequirePath,...)
        layer:setName(luaRequirePath.path)
        layer:setTag(util.getMainLayer():getChildrenCount())
        util.addToMain(layer)
 
        lastName = luaRequirePath.path
        lastMainLayer = layer
        if debugUI then 
            trace("mainLayer count:"..scenes.mainLayer:getChildrenCount(),"add time ",os.clock()-temp)
        end
    else
        lastName = ""
        if util.fixLayer then 
            util.fixLayer:show()
        end
    end
end



--推入窗口 缓动效果
function util.__pushWin(luaRequirePath,...)
    
    local win = util.checkSlot(luaRequirePath,...)
    util.addToWin(win)
    win:setName(luaRequirePath.path)
    win:setTag(scenes.winPopLayer:getChildrenCount())

    --自动添加窗口关闭
    if win.btn_back then 
        util.click(win,win.btn_back,util.popWin)
        -- util.aptup(win.btn_back)
    end

    --点击遮罩层关闭
    if win.sp_mask then 
        win.sp_mask:setTouchEnabled(true)
        util.click(win,win.sp_mask,util.popWin)
    end

    -- util.click(win,"btn_help",function ()
    --     util.pushWin(ui.gameHelp, ui.map[luaRequirePath.path])
    -- end)

    if debugUI then 
        trace("win count:"..scenes.winPopLayer:getChildrenCount())
    end
    return win
end

--刷新当前场景
function util.refreshMain(executeFun)
    if executeFun then
        if lastMainLayer[executeFun] then
            lastMainLayer[executeFun](lastMainLayer)
        end
    else
        lastMainLayer:refresh()
    end
end

function util.refreshBottomWin()
    -- local tag = scenes.winPopLayer:getChildrenCount()
    -- local win = scenes.winPopLayer:getChildByTag(tag-1)
    -- win:refresh()
end

function util.getBottomWin()
    local tag = scenes.winPopLayer:getChildrenCount()
    local win = scenes.winPopLayer:getChildByTag(tag-1)
    return win
end

--推出窗口 缓动效果
function util.popWin()
	local childTab = scenes.winPopLayer:getChildren() or {}
	local count = table.nums(childTab)
	if count < 1 then -- 空表 直接return
		return
	end
	local tempTab = {}
	for k,v in pairs(childTab) do
		local c_tag = v:getTag()
		local c_zorder = v:getLocalZOrder()
		table.insert(tempTab, {zorder=c_zorder, tag=c_tag, win=v})
	end
	sortByDoubleKey(tempTab, "zorder", "tag", true)
    util.tryDispose(tempTab[1].win)
end

function util.popWinByName(name)
    local win = scenes.winPopLayer:getChildByName(name)
    util.tryDispose(win)
end

--退出全部窗口
function util.popAllWin()
	local childTab = scenes.winPopLayer:getChildren() or {}
	for k,v in pairs(childTab) do
		util.tryDispose(v)
	end
end

--显示模态窗口  缓动效果
function util.showModal()
    scenes.modalLayer:setVisible(true)
end

--隐藏模态窗口  缓动效果
function util.hideModal()
    scenes.modalLayer:setVisible(false)
end


--定时函数
function util.setTimeout(func,time)
    scheduler.performWithDelayGlobal(func,time)
end

function util.loadSprite(node, path)
	node:setSpriteFrame(path)
end

function util.loadImage( node,path,resType )
    if not  tolua.isnull(node) then 
        node:loadTexture(path,resType or 1)
    end
end

function util.loadButton( node,path ,resType)
    if not  tolua.isnull(node) then 
        node:loadTextureNormal(path,resType or 1)
    end
end

function util.listAddItem(node,item)
    if not  tolua.isnull(node) then 
        node:pushBackCustomItem(item)
    end
end

--每行多个Item
function util.listAddLineItem(node,item,numPerLine)
    if not  tolua.isnull(node) then 
        local lineItem = node._lastLineItem
        if  not lineItem or (lineItem._itemNum >= numPerLine) then
            lineItem = ccui.Layout:create()
            lineItem:setLayoutType(ccui.LayoutType.HORIZONTAL)
            lineItem:setContentSize(cc.size(node:getContentSize().width,item:getContentSize().height))
            node:pushBackCustomItem(lineItem)
            lineItem._itemNum = 0
            node._lastLineItem = lineItem
        end

        lineItem._itemNum = lineItem._itemNum + 1
        lineItem:addChild(item)
    end
end

--添加文本
function util.listAddString(node,text,fontSize,color4b,bStrMid)
    color4b = color4b or cc.c4b(255,255,255,255)
    local item = ccui.Layout:create()
    local laber = ccui.Text:create()
    item:addChild(laber)
    item.laber = laber
    if type(fontSize) == "number" then
        laber:setFontSize(fontSize) 
    end
    laber:setString(text)
    laber:setTextColor(color4b)
    laber:setAnchorPoint(0,0)   
    if bStrMid then
        laber:setTextHorizontalAlignment(1)
    end

    local width = node:getInnerContainerSize().width
    local height = laber:getContentSize().height * math.ceil(laber:getContentSize().width/width)
    item:setContentSize(cc.size(width,height+10))
    laber:ignoreContentAdaptWithSize(false)
    laber:setTextAreaSize(cc.size(width,height))

    if not  tolua.isnull(node) then 
        node:pushBackCustomItem(item)
        return item
    end
end

function util.listAddBugString(node,text,fontSize,color4b)
    color4b = color4b or cc.c4b(255,255,255,255)
    local item = ccui.Layout:create()
	local tab = stringToChars(text)
	local textTab = {}
	local maxLen = 60
	local len = 0
	local str = ""
	for k,v in pairs(tab) do
		local tLen = string.len(v)
		len = len+tLen
		if len > maxLen then -- 换行
			table.insert(textTab, str)
			str = v
			len = tLen
		else
			str = str..v
		end
	end
	if string.len(str) > 0 then
		table.insert(textTab, str)
	end
	local str = table.concat(textTab, "\n")
    local ttf = cc.LabelTTF:create(str, "Helvetica", fontSize, cc.size(0, 0), cc.TEXT_ALIGNMENT_LEFT)	
	item:addChild(ttf)
	ttf:setAnchorPoint(cc.p(0,0))
	ttf:setColor(color4b)
	item:setContentSize(ttf:getContentSize())
	
    if not  tolua.isnull(node) then 
        node:pushBackCustomItem(item)
        return item
    end	
end

function util.listRemoveAll(node)
    if not  tolua.isnull(node) then 
        node:removeAllItems()
    end
end

--设置按钮是否可用
function util.setEnabled(btn,v)
    btn:setEnabled(v)
    btn:setBright(v)
end


function util.bar( node,min,max )
    node.mixcount = min
    if max then 
        node.maxcount = max
    else
        max = node.maxcount
    end
    if not  tolua.isnull(node) then 
        node:setPercent(min/max*100)
    end
end

function util.getPS(path)
    -- 平台 0-window,1-linux,2-mac,3-android, 4-iphone,5-ipad
    if __Platform__ == 2 or __Platform__ == 4 or __Platform__==5 then
        path = path..".aac"
    elseif __Platform__ == 3 then 
        path = path..".ogg"
    end
    return path
end

function util.playSound(path,isLoop)
    path =  util.getPS(path)
    return audio.playSound(path,isLoop)
end

function util.stopSound(handle)
    audio.stopSound(handle)
end

function util.playMusic(path,isLoop)
    path =  util.getPS(path)
    audio.preloadMusic(path)
    audio.playMusic(path,isLoop)
end 

function util.stopMusic(isReleaseData)
    audio.stopMusic(isReleaseData)
end


function util.effect(path,loop,autoremove)
    local eff = SuperAnimNode:create(path,1)
    if eff then 
        if eff:HasSection("s6") then 
            eff:PlaySection("s6", loop)
        end
        if eff:HasSection("s1") then 
            eff:PlaySection("s1", loop)
        end

        if autoremove then 
            local time = eff:GetSectionTime("s6") or eff:GetSectionTime("s1")
            util.setTimeout(function()
                util.tryRemove(eff)
            end,time)
        end
    else
        print(path .."is not find !")
    end
    return eff
end


function util.sp(josn,atlas)

end


function util.time()
    return socket.gettime()
end

--格式转换为：年-月-日 时：分：秒
function util.timeTostr(time)
    local year = os.date("%Y",time)
    local month = os.date("%m",time)
    local day = os.date("%d",time)
    local times = os.date("%X",time)
    local timestr = ""
    timestr = year.."-"..month.."-"..day.." "..times
    return timestr
end

--传入时间戳，计算时间差
function util.timeDifference(time)
    local timeDif = socket.gettime() - time
    if timeDif < 0 then
        timeDif = 0
    end
    local timestr =""
    local day = math.floor(timeDif/(60*60*24))
    if day > 1 then
        local month = os.date("%m",time)
        local day = os.date("%d",time)
        timestr = month.."-"..day
        return timestr
    elseif day > 0 then
        timestr = Language.get("28036")
        return timestr
    end

    timeDif = timeDif % (60*60*24)
    local hour = math.floor(timeDif/(60*60))
    if hour > 0 then
        timestr = hour..Language.get("28035")
        return timestr
    end
    timeDif = timeDif % (60*60)
    local minute = math.floor(timeDif/60)
    timestr = minute..Language.get("28034")
    return timestr
    
end

-- 传入秒数计算时间格式为 
--str 本地化文本 小时：分钟：秒
--format 显示时间 "%D%H%M%S"
function util.timeFormat(time,str,format)
    local day = math.floor(time/(60*60*24))
    time = time % (60*60*24)
    local hour = math.floor(time/(60*60))
    time = time % (60*60)
    local minute = math.floor(time/60)
    time = time%60
    local second = math.floor(time)
    str = str or Language.get("10154")
    format = format or "%D%H%M%S"
    local tip =  string.split(str,"|")

    local hasDay = format:find("D")
    local hasHour = format:find("H")
    local hasMinute = format:find("M")
    local hasSecond = format:find("S")

    local timestr =""
    -- if hasSecond then 
        timestr =string.format("%02d", second)..(tip[#tip] or "")
    -- end
    -- if minute > 0 or hour > 0 and hasMinute then 
        timestr = string.format("%02d", minute)..(tip[#tip-1] or "")..timestr
    -- end 
    -- if hour >0 or day >0 and hasHour then 
        timestr = string.format("%02d", hour)..(tip[#tip-2] or "")..timestr
    -- end
    if day >0 and hasDay then 
        timestr = string.format("%02d", day)..(tip[#tip-3] or "")..timestr
    end

    return timestr
end

function util.getLastName()
	return lastName
end

--数值 格式化
--@param：number：数值
--@param：formatFlg："short" or ","，默认为"short"
--@param：idot：数值 表示小数点后显示几位,默认为2
--@return example：999 or 9.99K or 9.99M or 9,999,999
function util.numberFormat( number, formatFlg ,idot)
    if type( number ) ~= "number" then
        printLog( "util.numberFormat", "非数值" )
        return number
    end
    
    if formatFlg == nil then
        formatFlg = "short"
    end

    if math.abs( number ) <= 999 then
        return tostring(number)
    end

    if formatFlg == "short" then
        local numberStr = ""
        local tmp = math.abs( number )
        if tmp ~= number then
            numberStr = "-"
        end
        idot = idot or 2
        if tmp / 1000000 >= 1 then
            numberStr = numberStr .. string.format( "%."..idot.."f", tmp / 1000000 ) .. "M"
        elseif tmp / 1000 >= 1 then
            numberStr = numberStr .. string.format( "%."..idot.."f", tmp / 1000 ) .. "K"
        end
        return numberStr
    end

    if formatFlg == "," then 
        local str = string.reverse( tostring( number ) )
        local count
        repeat
            str,count = string.gsub( str, "(%d%d%d)(%d)", "%1,%2", 1 )
        until count == 0
        return string.reverse( str )
    end
    
    return number
end

--得到罗马数字精灵帧
function util.getRomanNumSpFrame( number )
    if number == nil or number <= 0 or number >= 11 then
        printLog( "util.getRomanNumPic", "number must [1,10]" )
        return
    end

    local picName = "Roman_" .. number ..".png"

    return picName
end

--解析"1|2,3|23"
function util.split_two( value )
    local item_list={}
    for str in string.gmatch(value,"[^,]+") do
        for k,v in string.gmatch(str,"([^|]+)|([^|]+)") do
             item_list[tonumber(k)]=tonumber(v)
         end
    end
    return item_list
end

function util.split( value )
    local item_list={}
    for str in string.gmatch(value,"[^,]+") do
        for k,v in string.gmatch(str,"([^|]+)|([^|]+)") do
            table.insert(item_list,{tonumber(k),tonumber(v)})
         end
    end
    return item_list
end

--解析"1|2|3|4"
function util.split1(value)
    local result = {}
	string.gsub(value, '[^'.."|"..']+', function(w) table.insert(result, tonumber(w)) end )
	return result
    
end

--解析"a|2,b|23"
function util.splitString( value )
    local item_list={}
    for str in string.gmatch(value,"[^,]+") do
        for k,v in string.gmatch(str,"([^|]+)|([^|]+)") do
            table.insert(item_list,{k,v})
         end
    end
    return item_list
end

---按钮禁用
function util.setEnabledBtn(btn,isenabled)
    btn:setBright(isenabled);
    btn:setEnabled(isenabled);
    btn:setTouchEnabled(isenabled);
end

------------------------------------
--  界面适配
------------------------------------

--界面位置适配
function util.getsize()
    local display = {}
    util.display = display
    local director = cc.Director:getInstance()
    local view = director:getOpenGLView()
    local sizeInPixels = view:getFrameSize()    --设备大小
    local viewsize = director:getWinSize()      --适配后大小
    local scaleX, scaleY = sizeInPixels.width / CC_DESIGN_RESOLUTION.width, sizeInPixels.height / CC_DESIGN_RESOLUTION.height

    display.sizeInPixels = {width = sizeInPixels.width, height = sizeInPixels.height}
    display.offx = (viewsize.width - CC_DESIGN_RESOLUTION.width)/2
    display.offy =  CC_DESIGN_RESOLUTION.height -viewsize.height
    display.contentScaleFactor = director:getContentScaleFactor()
    display.size               = {width = viewsize.width, height = viewsize.height}
    display.width              = display.size.width
    display.height             = display.size.height
    display.cx                 = display.width / 2
    display.cy                 = display.height / 2
    display.c_left             = -display.width / 2
    display.c_right            = display.width / 2
    display.c_top              = display.height / 2
    display.c_bottom           = -display.height / 2
    display.left               = 0
    display.right              = display.width
    display.top                = display.height
    display.bottom             = 0
    display.center             = cc.p(display.cx, display.cy)
    display.left_top           = cc.p(display.left, display.top)
    display.left_bottom        = cc.p(display.left, display.bottom)
    display.left_center        = cc.p(display.left, display.cy)
    display.right_top          = cc.p(display.right, display.top)
    display.right_bottom       = cc.p(display.right, display.bottom)
    display.right_center       = cc.p(display.right, display.cy)
    display.top_center         = cc.p(display.cx, display.top)
    display.top_bottom         = cc.p(display.cx, display.bottom)
	display.scaleX 			   = scaleX
	display.scaleY 			   = scaleY
    trace(string.format("# display.offx                 = %s", display.offx))
    trace(string.format("# display.offy                 = %s", display.offy))
    trace(string.format("# display.scaleX               = %s", scaleX))
    trace(string.format("# display.scaleY               = %s", scaleY))
    trace(string.format("# display.sizeInPixels         = {width = %0.2f, height = %0.2f}", display.sizeInPixels.width, display.sizeInPixels.height))
    trace(string.format("# display.size                 = {width = %0.2f, height = %0.2f}", display.size.width, display.size.height))
    trace(string.format("# display.contentScaleFactor   = %0.2f", display.contentScaleFactor))
    trace(string.format("# display.width                = %0.2f", display.width))
    trace(string.format("# display.height               = %0.2f", display.height))
    trace(string.format("# display.cx                   = %0.2f", display.cx))
    trace(string.format("# display.cy                   = %0.2f", display.cy))
    trace(string.format("# display.left                 = %0.2f", display.left))
    trace(string.format("# display.right                = %0.2f", display.right))
    trace(string.format("# display.top                  = %0.2f", display.top))
    trace(string.format("# display.bottom               = %0.2f", display.bottom))
    trace(string.format("# display.c_left               = %0.2f", display.c_left))
    trace(string.format("# display.c_right              = %0.2f", display.c_right))
    trace(string.format("# display.c_top                = %0.2f", display.c_top))
    trace(string.format("# display.c_bottom             = %0.2f", display.c_bottom))
    trace(string.format("# display.center               = {x = %0.2f, y = %0.2f}", display.center.x, display.center.y))
    trace(string.format("# display.left_top             = {x = %0.2f, y = %0.2f}", display.left_top.x, display.left_top.y))
    trace(string.format("# display.left_bottom          = {x = %0.2f, y = %0.2f}", display.left_bottom.x, display.left_bottom.y))
    trace(string.format("# display.left_center          = {x = %0.2f, y = %0.2f}", display.left_center.x, display.left_center.y))
    trace(string.format("# display.right_top            = {x = %0.2f, y = %0.2f}", display.right_top.x, display.right_top.y))
    trace(string.format("# display.right_bottom         = {x = %0.2f, y = %0.2f}", display.right_bottom.x, display.right_bottom.y))
    trace(string.format("# display.right_center         = {x = %0.2f, y = %0.2f}", display.right_center.x, display.right_center.y))
    trace(string.format("# display.top_center           = {x = %0.2f, y = %0.2f}", display.top_center.x, display.top_center.y))
    trace(string.format("# display.top_bottom           = {x = %0.2f, y = %0.2f}", display.top_bottom.x, display.top_bottom.y))
    trace("#")

end

function util.setGray(node)
    local vertDefaultSource = "\n"..
    "attribute vec4 a_position; \n" ..
    "attribute vec2 a_texCoord; \n" ..
    "attribute vec4 a_color; \n"..                                                    
    "#ifdef GL_ES  \n"..
    "varying lowp vec4 v_fragmentColor;\n"..
    "varying mediump vec2 v_texCoord;\n"..
    "#else                      \n" ..
    "varying vec4 v_fragmentColor; \n" ..
    "varying vec2 v_texCoord;  \n"..
    "#endif    \n"..
    "void main() \n"..
    "{\n" ..
    "gl_Position = CC_PMatrix * a_position; \n"..
    "v_fragmentColor = a_color;\n"..
    "v_texCoord = a_texCoord;\n"..
    "}"
     
    local pszFragSource = "#ifdef GL_ES \n" ..
    "precision mediump float; \n" ..
    "#endif \n" ..
    "varying vec4 v_fragmentColor; \n" ..
    "varying vec2 v_texCoord; \n" ..
    "void main(void) \n" ..
    "{ \n" ..
    "vec4 c = texture2D(CC_Texture0, v_texCoord); \n" ..
    "gl_FragColor.xyz = vec3(0.4*c.r + 0.4*c.g +0.4*c.b); \n"..
    "gl_FragColor.w = c.w; \n"..
    "}"

    if tolua.type(node) == "ccui.ImageView" then
        local image = node:getVirtualRenderer()
        node = image:getSprite()
    end

    local pProgram = cc.GLProgram:createWithByteArrays(vertDefaultSource,pszFragSource)
     
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pProgram:link()
    pProgram:updateUniforms()
    node:setGLProgram(pProgram)
end

function util.setnoGray(node)
    if tolua.type(node) == "ccui.ImageView" then
        local image = node:getVirtualRenderer()
        node = image:getSprite()
    end    
    node:setGLProgramState(cc.GLProgramState:getOrCreateWithGLProgram(cc.GLProgramCache:getInstance():getGLProgram("ShaderPositionTextureColor_noMVP")))
end

--消息穿透区域 跟 提示图标区域
--状态 引导开启  正在引导中 引导结束
---由通知消息来跳转下一步
--注册事件

--- 1 不在区域内消息 吞噬掉   	--自己通知下一步
--- 2 区域内消息 穿透 传递		--模块通知下一步
--- 3 区域内外消息都穿透  传递	--模块通知下一步
local function gotoguilding(guideID,stepID)
	util.clearTheGuide()
	local dataObj = TemplateData:getGuideConfigData(guideID,stepID)
	if(not dataObj) then
		Alert.floatingTip(1,strText)
		return
	end
	local nType = dataObj.type
	if(1 == nType) then
		util.pushToGuide(ui.guideWait,guideID,stepID)
	elseif(2 == nType or 5 == nType) then
		util.pushToGuide(ui.guideNext,guideID,stepID)
	elseif(4 == nType) then
		util.pushToGuide(ui.guideFingerNext,guideID,stepID)
	elseif(3 == nType) then
		util.pushToGuide(ui.guideRect,guideID,stepID)
	elseif(6 == nType) then
		util.pushToGuide(ui.guideWait,guideID,stepID)
	elseif(7 == nType) then
		util.pushToGuide(ui.guideNext,guideID,stepID)
	end
end

local ourflag = false

function util.setGuideFlag(flag)
	ourflag = flag
end

function util.getGuideFlag()
	return ourflag
end


function util.encodeURL(s)
    return (string.gsub(s, "([^A-Za-z0-9_])", function(c)
        return string.format("%%%02x", string.byte(c))
    end))
end

--加载网络图片,Url图片地址,bForceRefer删除缓存强制刷新,callback回调,参数:成功与否,本地图片存放地址

local loadingImg = {}

function util.loadWebImg(Url,bForceRerfer,callback)
    if loadingImg[Url] then
        table.insert(loadingImg[Url],callback)
        return
    end
    loadingImg[Url] = {callback}
    local function doCallbacks(...)
        if loadingImg[Url] then
            for i,j in pairs(loadingImg[Url]) do
                j(...)
            end
        end
        loadingImg[Url] = nil
    end

    local File = require("util.File")
	local path = File.wirtePath
    path = path.."webImg/"
    File.mkdir(path)
    path = path..util.encodeURL(Url)
    if not File.exists(path) or bForceRerfer then
        --GET手机端无法下载Facebook头像,原因未知
        local xhr = cc.XMLHttpRequest:new()
        xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
        xhr:open("GET", Url)
        local function onReadyStateChange()
            if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                File.save(path,xhr.response,"wb")
                doCallbacks(true,path)
            else
                trace("util.loadWebImg xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
                doCallbacks(false)
            end
        end
        xhr:registerScriptHandler(onReadyStateChange)
        xhr:send()

        --[[改为用Loader
        local function downCallback(result)
            if result.state == 3 then -- 下载完成
                
            end
        end
        Loader:shared():setRemotePath(Url)
	    Loader:shared():load("", handler(self, downCallback))]]
    else
        doCallbacks(true,path)
    end
end

util.init()