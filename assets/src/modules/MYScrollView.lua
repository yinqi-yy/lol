
local MYScrollView = class("MYScrollView", function()
	return cc.ClippingRectangleNode:create()
end)

MYScrollView.BG_ZORDER 				= -100
MYScrollView.TOUCH_ZORDER 			= -99

MYScrollView.DIRECTION_BOTH			= 0
MYScrollView.DIRECTION_VERTICAL		= 1
MYScrollView.DIRECTION_HORIZONTAL	= 2

local actionManager = cc.Director:getInstance():getActionManager()
-- start --

--------------------------------
-- 滚动控件的构建函数
-- @function [parent=#MYScrollView] new
-- @param table params 参数表

--[[--

滚动控件的构建函数

可用参数有：

-   direction 滚动控件的滚动方向，默认为垂直与水平方向都可滚动
-   viewRect 列表控件的显示区域
-   scrollbarImgH 水平方向的滚动条
-   scrollbarImgV 垂直方向的滚动条
-   bgColor 背景色,nil表示无背景色
-   bgStartColor 渐变背景开始色,nil表示无背景色
-   bgEndColor 渐变背景结束色,nil表示无背景色
-   bg 背景图
-   bgScale9 背景图是否可缩放
-	capInsets 缩放区域

]]
-- end --

function MYScrollView:ctor(params)
	self.bBounce = true
	self.nShakeVal = 5
	self.direction = MYScrollView.DIRECTION_BOTH
	self.layoutPadding = {left = 0, right = 0, top = 0, bottom = 0}
	self.speed = {x = 0, y = 0}

	if not params then
		return
	end

	if params.viewRect then
		self:setViewRect(params.viewRect)
	end
	if params.direction then
		self:setDirection(params.direction)
	end
	if params.scrollbarImgH then
		self.sbH = cc.Scale9Sprite:createWithSpriteFrame(params.scrollbarImgH)
		self.sbH:setPositionX(100)
		self:addChild(self.sbH)
	end
	if params.scrollbarImgV then
		self.sbV = cc.Scale9Sprite:createWithSpriteFrame(params.scrollbarImgV)
		self.sbV:setPositionX(100)
		self:addChild(self.sbV)
	end
	-- touchOnContent true:当触摸在滚动内容上才有效 false:当触摸在显示区域(viewRect_)就有效
	-- 当内容小于显示区域时，两者就有区别了
	self:setTouchType(params.touchOnContent or true)

	self:addBgColorIf(params)
	self:addBgGradientColorIf(params)
	self:addBgIf(params)

	local listener1 = cc.EventListenerTouchOneByOne:create()
	listener1:setSwallowTouches(true)
	local function onTouch(t,event)
		self:update_()
	end

	listener1:registerScriptHandler(onTouch,cc.Handler.EVENT_TOUCH_BEGAN)
	listener1:registerScriptHandler(onTouch,cc.Handler.EVENT_TOUCH_MOVED)
	listener1:registerScriptHandler(onTouch,cc.Handler.EVENT_TOUCH_ENDED)

	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener1,self)

	self:scheduleUpdateWithPriorityLua(function ( ... )
		self:update_(...)
	end,0)

	self.args_ = {params}
end

function MYScrollView:addBgColorIf(params)
	if not params.bgColor then
		return
	end

	-- display.newColorLayer(params.bgColor)
	local bgLayer = cc.LayerColor:create(params.bgColor)
	bgLayer:setContentSize(params.viewRect.width, params.viewRect.height)
	bgLayer:setPosition(cc.p(params.viewRect.x, params.viewRect.y))
	bgLayer:setTouchEnabled(false)
	self:addChild(bgLayer, MYScrollView.BG_ZORDER)
end

function MYScrollView:addBgGradientColorIf(params)
	if not params.bgStartColor or not params.bgEndColor then
		return
	end

	local layer = cc.LayerGradient:create(params.bgStartColor, params.bgEndColor)
	layer:setContentSize(params.viewRect.width, params.viewRect.height)
	layer:setPosition(params.viewRect.x, params.viewRect.y)
	layer:setTouchEnabled(false)
	layer:setVector(params.bgVector)
	self:addChild(layer, MYScrollView.BG_ZORDER)
end

function MYScrollView:addBgIf(params)
	if not params.bg then
		return
	end

	local bg
	if params.bgScale9 then
		bg = cc.Scale9Sprite:createWithSpriteFrame(params.bg, nil, params.capInsets)
	else
		local filename = params.bg
		local t = type(filename)
   		if t == "userdata" then t = tolua.type(filename) end

   		if not filename then
	        bg = cc.Sprite:create()
	    elseif t == "string" then
	        if string.byte(filename) == 35 then -- first char is #
                if params and params.capInsets then
                    bg = cc.Sprite:createWithSpriteFrame(filename, params.capInsets)
                else
                    bg = cc.Sprite:createWithSpriteFrame(filename)
                end
	        else
                if params and params.capInsets then
                    bg = cc.Sprite:create(params.capInsets, filename)
                else
                    bg = cc.Sprite:create(filename)
                end
	        end
	    elseif t == "cc.SpriteFrame" then
	        bg = cc.Sprite:createWithSpriteFrame(filename)
	    end
	end

	bg:setContentSize(params.viewRect.width, params.viewRect.height)
	bg:setPosition(params.viewRect.x + params.viewRect.width/2,
			params.viewRect.y + params.viewRect.height/2)
	bg:setTouchEnabled(false)
	self:addChild(bg, MYScrollView.BG_ZORDER)
end

function MYScrollView:setViewRect(rect)
	self:setClippingRegion(rect)
	self.viewRect_ = rect
	self.viewRectIsNodeSpace = false

	return self
end

-- start --

--------------------------------
-- 得到滚动控件的显示区域
-- @function [parent=#MYScrollView] getViewRect
-- @return Rect#Rect 

-- end --

function MYScrollView:getViewRect()
	return self.viewRect_
end

-- start --

--------------------------------
-- 设置布局四周的空白
-- @function [parent=#MYScrollView] setLayoutPadding
-- @param number top 上边的空白
-- @param number right 右边的空白
-- @param number bottom 下边的空白
-- @param number left 左边的空白
-- @return MYScrollView#MYScrollView 

-- end --

function MYScrollView:setLayoutPadding(top, right, bottom, left)
	if not self.layoutPadding then
		self.layoutPadding = {}
	end
	self.layoutPadding.top = top
	self.layoutPadding.right = right
	self.layoutPadding.bottom = bottom
	self.layoutPadding.left = left

	return self
end

function MYScrollView:setActualRect(rect)
	self.actualRect_ = rect
end

-- start --

--------------------------------
-- 设置滚动方向
-- @function [parent=#MYScrollView] setDirection
-- @param number dir 滚动方向
-- @return MYScrollView#MYScrollView 

-- end --

function MYScrollView:setDirection(dir)
	self.direction = dir

	return self
end

-- start --

--------------------------------
-- 获取滚动方向
-- @function [parent=#MYScrollView] getDirection
-- @return number#number 

-- end --

function MYScrollView:getDirection()
	return self.direction
end

-- start --

--------------------------------
-- 设置滚动控件是否开启回弹功能
-- @function [parent=#MYScrollView] setBounceable
-- @param boolean bBounceable 是否开启回弹
-- @return MYScrollView#MYScrollView 

-- end --

function MYScrollView:setBounceable(bBounceable)
	self.bBounce = bBounceable

	return self
end

-- start --

--------------------------------
-- 设置触摸响应方式
-- true:当触摸在滚动内容上才有效 false:当触摸在显示区域(viewRect_)就有效
-- 内容大于显示区域时，两者无差别
-- 内容小于显示区域时，true:在空白区域触摸无效,false:在空白区域触摸也可滚动内容
-- @function [parent=#MYScrollView] setTouchType
-- @param boolean bTouchOnContent 是否触控到滚动内容上才有效
-- @return MYScrollView#MYScrollView 

-- end --

function MYScrollView:setTouchType(bTouchOnContent)
	self.touchOnContent = bTouchOnContent

	return self
end


local function getCascadeBoundingBox(node)
	local children = node:getChildren()
	local bound = {}
	if children then
		local maxPosX = nil
		local maxPosY = nil
		local minPosX = nil
		local minPosY = nil

		for k,child in pairs(children) do
			local anchorPoint = node:getAnchorPoint()
			local size = child:getContentSize()
			local x = child:getPositionX()
			local y = child:getPositionY()
			if maxPosX then
				maxPosX = x+size.width*(1-anchorPoint.x) > maxPosX and x+size.width*(1-anchorPoint.x) or maxPosX
			else
				maxPosX = x+size.width*(1-anchorPoint.x)
			end
		
			if maxPosY then
				maxPosY = y+size.height*(1-anchorPoint.y) > maxPosY and y+size.height*(1-anchorPoint.y) or maxPosY
			else
				maxPosY = y+size.height*(1-anchorPoint.y)
			end

			if minPosX then
				minPosX = x-size.width*anchorPoint.x < minPosX and x-size.width*anchorPoint.x or minPosX
			else
				minPosX = x-size.width*anchorPoint.x
			end
		
			if minPosY then
				minPosY = y-size.height*anchorPoint.y < minPosY and y-size.height*anchorPoint.y or minPosY
			else
				minPosY = y-size.height*anchorPoint.y
			end
		end

		bound.x = node:getPositionX() + minPosX
		bound.y = node:getPositionY() + minPosY
		bound.width = maxPosX - minPosX
		bound.height = maxPosY - minPosY
	else
		local anchorPoint = node:getAnchorPoint()
		bound.width = node:getContentSize().width
		bound.height = node:getContentSize().height
		bound.x = node:getPositionX() - node:getContentSize().width*anchorPoint.x
		bound.y = node:getPositionY() - node:getContentSize().height*anchorPoint.y
	end
	return bound

end
--[[--

重置位置,主要用在纵向滚动时

]]
function MYScrollView:resetPosition()
	if MYScrollView.DIRECTION_VERTICAL ~= self.direction then
		return
	end

	local x, y = self.scrollNode:getPosition()
	local bound = getCascadeBoundingBox(self.scrollNode)
	local disY = self.viewRect_.y + self.viewRect_.height - bound.y - bound.height
	y = y + disY
	self.scrollNode:setPosition(x, y)
end

-- start --

--------------------------------
-- 判断一个node是否在滚动控件的显示区域中
-- @function [parent=#MYScrollView] isItemInViewRect
-- @param node item scrollView中的项
-- @return boolean#boolean 

-- end --

function MYScrollView:isItemInViewRect(item)
	if "userdata" ~= type(item) then
		item = nil
	end

	if not item then
		print("MYScrollView - isItemInViewRect item is not right")
		return
	end

	local bound = getCascadeBoundingBox(item)
	return cc.rectIntersectsRect(self:getViewRectInWorldSpace(), bound)
end

-- start --

--------------------------------
-- 设置scrollview可触摸
-- @function [parent=#MYScrollView] setTouchEnabled
-- @param boolean bEnabled 是否开启触摸
-- @return MYScrollView#MYScrollView 

-- end --

function MYScrollView:setTouchEnabled(bEnabled)
	if not self.scrollNode then
		return
	end
	self.scrollNode:setTouchEnabled(bEnabled)

	return self
end

-- start --

--------------------------------
-- 将要显示的node加到scrollview中,scrollView只支持滚动一个node
-- @function [parent=#MYScrollView] addScrollNode
-- @param node node 要显示的项
-- @return MYScrollView#MYScrollView 

-- end --

function MYScrollView:addScrollNode(node)
	self:addChild(node)
	self.scrollNode = node

	if not self.viewRect_ then
		self.viewRect_ = getCascadeBoundingBox(self.scrollNode)
		self:setViewRect(self.viewRect_)
	end

	local listener1 = cc.EventListenerTouchOneByOne:create()
	listener1:setSwallowTouches(false)
	local function onTouch_Began(touch,event)
		local location = touch:getLocation()
		event.x = location.x
		event.y = location.y
		event.name = "began" 
		return self:isTouchInViewRect(event)
	end
	local function onTouch_Moved(touch,event)
		local location = touch:getLocation()
		event.x = location.x
		event.y = location.y
		event.name = "moved"
		return self:onTouchCapture_(event)
	end
	local function onTouch_Ended(touch,event)
		local location = touch:getLocation()
		event.x = location.x
		event.y = location.y
		event.name = "ended"
		return self:onTouchCapture_(event)
	end
	listener1:registerScriptHandler(onTouch_Began,cc.Handler.EVENT_TOUCH_BEGAN)
	listener1:registerScriptHandler(onTouch_Moved,cc.Handler.EVENT_TOUCH_MOVED)
	listener1:registerScriptHandler(onTouch_Ended,cc.Handler.EVENT_TOUCH_ENDED)

	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener1,node)

	self:addTouchNode()

    return self
end

-- start --

--------------------------------
-- 返回scrollView中的滚动node
-- @function [parent=#MYScrollView] getScrollNode
-- @return node#node  滚动node

-- end --

function MYScrollView:getScrollNode()
	return self.scrollNode
end

-- start --

--------------------------------
-- 注册滚动控件的监听函数
-- @function [parent=#MYScrollView] onScroll
-- @param function listener 监听函数
-- @return MYScrollView#MYScrollView 

-- end --

function MYScrollView:onScroll(listener)
	self.scrollListener_ = listener

    return self
end

-- private

function MYScrollView:calcLayoutPadding()
	local boundBox = getCascadeBoundingBox(self.scrollNode)

	self.layoutPadding.left = boundBox.x - self.actualRect_.x
	self.layoutPadding.right =
		self.actualRect_.x + self.actualRect_.width - boundBox.x - boundBox.width
	self.layoutPadding.top = boundBox.y - self.actualRect_.y
	self.layoutPadding.bottom =
		self.actualRect_.y + self.actualRect_.height - boundBox.y - boundBox.height
end

function MYScrollView:update_(dt)
	self:drawScrollBar()
end

function MYScrollView:onTouchCapture_(event)
	if ("began" == event.name or "moved" == event.name or "ended" == event.name)
		and self:isTouchInViewRect(event) then
		return true
	else
		return false
	end
end

function MYScrollView:onTouch_(event)
	if "began" == event.name and not self:isTouchInViewRect(event) then
		printInfo("MYScrollView - touch didn't in viewRect")
		return false
	end

	if "began" == event.name and self.touchOnContent then
		local cascadeBound = getCascadeBoundingBox(self.scrollNode)
		local newCascadeBound = self:convertToWorldSpace(cc.p(cascadeBound.x, cascadeBound.y))
		newCascadeBound.width = cascadeBound.width
		newCascadeBound.height = cascadeBound.height

		if not cc.rectContainsPoint(newCascadeBound, cc.p(event.x, event.y)) then
			return false
		end
	end

	if "began" == event.name then
		self.prevX_ = event.x
		self.prevY_ = event.y
		self.bDrag_ = false
		local x,y = self.scrollNode:getPosition()
		self.pos_ = {x = x, y = y}

		actionManager:removeAllActionsFromTarget(self.scrollNode)
		self:callListener_{name = "began", x = event.x, y = event.y}

		self:enableScrollBar()
		-- self:changeViewRectToNodeSpaceIf()

		self.scaleToWorldSpace_ = self:scaleToParent_()
		self.eventprevX = event.x
		self.eventprevY = event.y
		return true
	elseif "moved" == event.name then
		if self:isShake(event) then
			return
		end

		self.bDrag_ = true
		self.speed.x = event.x - self.eventprevX
		self.speed.y = event.y - self.eventprevY

		if self.direction == MYScrollView.DIRECTION_VERTICAL then
			self.speed.x = 0
		elseif self.direction == MYScrollView.DIRECTION_HORIZONTAL then
			self.speed.y = 0
		else
			-- do nothing
		end

		self:scrollBy(self.speed.x, self.speed.y)
		self:callListener_{name = "moved", x = event.x, y = event.y}
		self.eventprevX = event.x
		self.eventprevY = event.y
	elseif "ended" == event.name then
		if self.bDrag_ then

			self.bDrag_ = false
			self:scrollAuto()

			self:callListener_{name = "ended", x = event.x, y = event.y}

			self:disableScrollBar()
		else
			self:callListener_{name = "clicked", x = event.x, y = event.y}
		end
		self.eventprevX = 0
		self.eventprevY = 0
	end
end

function MYScrollView:isTouchInViewRect(event)
	-- dump(self.viewRect_, "viewRect:")
	local viewRect = self:convertToWorldSpace(cc.p(self.viewRect_.x, self.viewRect_.y))
	viewRect.width = self.viewRect_.width
	viewRect.height = self.viewRect_.height
	-- dump(viewRect, "new viewRect:")

	return cc.rectContainsPoint(viewRect, cc.p(event.x, event.y))
end

function MYScrollView:isTouchInScrollNode(event)
	local cascadeBound = self:getScrollNodeRect()
	return cc.rectContainsPoint(cascadeBound, cc.p(event.x, event.y))
end

function MYScrollView:scrollTo(p, y)
	local x_, y_
	if "table" == type(p) then
		x_ = p.x or 0
		y_ = p.y or 0
	else
		x_ = p
		y_ = y
	end

	self.pos_ = cc.p(x_, y_)
	self.scrollNode:setPosition(self.pos_)
end

function MYScrollView:moveXY(orgX, orgY, speedX, speedY)
	if self.bBounce then
		-- bounce enable
		return orgX + speedX, orgY + speedY
	end

	local cascadeBound = self:getScrollNodeRect()
	local viewRect = self:getViewRectInWorldSpace()
	local x, y = orgX, orgY
	local disX, disY

	if speedX > 0 then
		if cascadeBound.x < viewRect.x then
			disX = viewRect.x - cascadeBound.x
			disX = disX / self.scaleToWorldSpace_.x
			x = orgX + math.min(disX, speedX)
		end
	else
		if cascadeBound.x + cascadeBound.width > viewRect.x + viewRect.width then
			disX = viewRect.x + viewRect.width - cascadeBound.x - cascadeBound.width
			disX = disX / self.scaleToWorldSpace_.x
			x = orgX + math.max(disX, speedX)
		end
	end

	if speedY > 0 then
		if cascadeBound.y < viewRect.y then
			disY = viewRect.y - cascadeBound.y
			disY = disY / self.scaleToWorldSpace_.y
			y = orgY + math.min(disY, speedY)
		end
	else
		if cascadeBound.y + cascadeBound.height > viewRect.y + viewRect.height then
			disY = viewRect.y + viewRect.height - cascadeBound.y - cascadeBound.height
			disY = disY / self.scaleToWorldSpace_.y
			y = orgY + math.max(disY, speedY)
		end
	end

	return x, y
end

function MYScrollView:scrollBy(x, y)
	self.pos_.x, self.pos_.y = self:moveXY(self.pos_.x, self.pos_.y, x, y)
	-- self.pos_.x = self.pos_.x + x
	-- self.pos_.y = self.pos_.y + y
	self.scrollNode:setPosition(self.pos_)
	if self.actualRect_ then
		self.actualRect_.x = self.actualRect_.x + x
		self.actualRect_.y = self.actualRect_.y + y
	end
end

function MYScrollView:scrollAuto()
	if self:twiningScroll() then
		return
	end
	self:elasticScroll()
end

-- fast drag
function MYScrollView:twiningScroll()
	if self:isSideShow() then
		printInfo("MYScrollView - side is show, so elastic scroll")
		return false
	end

	if math.abs(self.speed.x) < 10 and math.abs(self.speed.y) < 10 then
		-- printInfo("#DEBUG, MYScrollView - isn't twinking scroll:"
		-- 	.. self.speed.x .. " " .. self.speed.y)
		return false
	end

	local disX, disY = self:moveXY(0, 0, self.speed.x*6, self.speed.y*6)

	local action = cc.EaseSineOut:create(cc.MoveBy:create(0.3,cc.p(disX,disY)))
	local onComplete = function()
			self:elasticScroll()
	end
	local sequence = cc.Sequence:create(action,cc.CallFunc:create(onComplete))
	self.scrollNode:runAction(sequence)

end

function MYScrollView:elasticScroll()
	local cascadeBound = self:getScrollNodeRect()
	local disX, disY = 0, 0
	local viewRect = self:getViewRectInWorldSpace()

	-- dump(cascadeBound, "MYScrollView - cascBoundingBox:")
	-- dump(viewRect, "MYScrollView - viewRect:")

	if cascadeBound.width < viewRect.width then
		disX = viewRect.x - cascadeBound.x
	else
		if cascadeBound.x > viewRect.x then
			disX = viewRect.x - cascadeBound.x
		elseif cascadeBound.x + cascadeBound.width < viewRect.x + viewRect.width then
			disX = viewRect.x + viewRect.width - cascadeBound.x - cascadeBound.width
		end
	end

	if cascadeBound.height < viewRect.height then
		disY = viewRect.y + viewRect.height - cascadeBound.y - cascadeBound.height
	else
		if cascadeBound.y > viewRect.y then
			disY = viewRect.y - cascadeBound.y
		elseif cascadeBound.y + cascadeBound.height < viewRect.y + viewRect.height then
			disY = viewRect.y + viewRect.height - cascadeBound.y - cascadeBound.height
		end
	end

	if 0 == disX and 0 == disY then
		return
	end

	local action = cc.EaseBackOut:create(cc.MoveBy:create(0.3,cc.p(disX,disY)))
	local onComplete = function()
			self:callListener_{name = "scrollEnd"}
	end
	local sequence = cc.Sequence:create(action,cc.CallFunc:create(onComplete))
	self.scrollNode:runAction(sequence)


end

function MYScrollView:getScrollNodeRect()
	local bound = getCascadeBoundingBox(self.scrollNode)

	-- local cascadeBound = getCascadeBoundingBox(self.scrollNode)
	local cascadeBound = self:convertToWorldSpace(cc.p(bound.x, bound.y))
	cascadeBound.width = bound.width
	cascadeBound.height = bound.height

	-- bound.x = bound.x - self.layoutPadding.left
	-- bound.y = bound.y - self.layoutPadding.bottom
	-- bound.width = bound.width + self.layoutPadding.left + self.layoutPadding.right
	-- bound.height = bound.height + self.layoutPadding.bottom + self.layoutPadding.top

	return cascadeBound
end

function MYScrollView:getViewRectInWorldSpace()
	local rect = self:convertToWorldSpace(
		cc.p(self.viewRect_.x, self.viewRect_.y))
	rect.width = self.viewRect_.width
	rect.height = self.viewRect_.height

	return rect
end

-- 是否显示到边缘
function MYScrollView:isSideShow()
	local bound = getCascadeBoundingBox(self.scrollNode)
    local localsetPosition = self:convertToNodeSpace(cc.p(bound.x, bound.y))
    local verticalSideShow = (localsetPosition.y > self.viewRect_.y) 
                           or (localsetPosition.y + bound.height < self.viewRect_.y + self.viewRect_.height)
    local horizontalSideShow = (localsetPosition.x > self.viewRect_.x)
                             or (localsetPosition.x + bound.width < self.viewRect_.x + self.viewRect_.width)
    if MYScrollView.DIRECTION_VERTICAL == self.direction then
        return verticalSideShow
    elseif MYScrollView.DIRECTION_HORIZONTAL == self.direction then
        return horizontalSideShow
    else
        return (verticalSideShow or horizontalSideShow)
    end

	return false
end

function MYScrollView:callListener_(event)
	if not self.scrollListener_ then
		return
	end
	event.scrollView = self

	self.scrollListener_(event)
end

function MYScrollView:enableScrollBar()
	local bound = getCascadeBoundingBox(self.scrollNode)
	if self.sbV then
		self.sbV:setVisible(false)
		actionManager:removeAllActionsFromTarget(self.sbV)
		self.sbV:setOpacity(128)
		local setContentSize = self.sbV:getContentSize()
		if self.viewRect_.height < bound.height then
			local barH = self.viewRect_.height*self.viewRect_.height/bound.height
			if barH < setContentSize.width then
				-- 保证bar不会太小
				barH = setContentSize.width
			end
			self.sbV:setContentSize(setContentSize.width, barH)
			self.sbV:setPosition(
				self.viewRect_.x + self.viewRect_.width - setContentSize.width/2, self.viewRect_.y + barH/2)
		end
	end
	if self.sbH then
		self.sbH:setVisible(false)
		actionManager:removeAllActionsFromTarget(self.sbH)
		self.sbH:setOpacity(128)
		local setContentSize = self.sbH:getContentSize()
		if self.viewRect_.width < bound.width then
			local barW = self.viewRect_.width*self.viewRect_.width/bound.width
			if barW < setContentSize.height then
				barW = setContentSize.height
			end
			self.sbH:setContentSize(barW, setContentSize.height)
			self.sbH:setPosition(self.viewRect_.x + barW/2,
				self.viewRect_.y + setContentSize.height/2)
		end
	end
end

function MYScrollView:disableScrollBar()
	if self.sbV then
		local action = cc.FadeOut:create(0.3,cc.p(disX,disY))
		local onComplete = function()
				self.sbV:setOpacity(128)
				self.sbV:setVisible(false)
		end
		local sequence = cc.Sequence:create(action,cc.CallFunc:create(onComplete))
		self.sbV:runAction(sequence)
	end
	if self.sbH then
		local action = cc.FadeOut:create(1.5,cc.p(disX,disY))
		local onComplete = function()
				self.sbH:setOpacity(128)
				self.sbH:setVisible(false)
		end
		local sequence = cc.Sequence:create(action,cc.CallFunc:create(onComplete))
		self.sbH:runAction(sequence)
	end
end

function MYScrollView:drawScrollBar()
	if not self.bDrag_ then
		return
	end
	if not self.sbV and not self.sbH then
		return
	end

	local bound = getCascadeBoundingBox(self.scrollNode)
	if self.sbV then
		self.sbV:setVisible(true)
		local setContentSize = self.sbV:getContentSize()

		local setPositionY = (self.viewRect_.y - bound.y)*(self.viewRect_.height - setContentSize.height)/(bound.height - self.viewRect_.height)
			+ self.viewRect_.y + setContentSize.height/2
		local x, y = self.sbV:getPosition()
		self.sbV:setPosition(x, setPositionY)
	end
	if self.sbH then
		self.sbH:setVisible(true)
		local setContentSize = self.sbH:getContentSize()

		local setPositionX = (self.viewRect_.x - bound.x)*(self.viewRect_.width - setContentSize.width)/(bound.width - self.viewRect_.width)
			+ self.viewRect_.x + setContentSize.width/2
		local x, y = self.sbH:getPosition()
		self.sbH:setPosition(setPositionX, y)
	end
end

function MYScrollView:addScrollBarIf()

	if not self.sb then
		self.sb = cc.DrawNode:create()
		self:addChild(self.sb)
	end

	drawNode = cc.DrawNode:create()
    drawNode:drawSegment(points[1], points[2], radius, borderColor)
end

function MYScrollView:changeViewRectToNodeSpaceIf()
	if self.viewRectIsNodeSpace then
		return
	end

	-- local nodePoint = self:convertToNodeSpace(cc.p(self.viewRect_.x, self.viewRect_.y))
	local setPositionX, setPositionY = self:getPosition()
	local ws = self:convertToWorldSpace(cc.p(setPositionX, setPositionY))
	self.viewRect_.x = self.viewRect_.x + ws.x
	self.viewRect_.y = self.viewRect_.y + ws.y
	self.viewRectIsNodeSpace = true
end

function MYScrollView:isShake(event)
	if math.abs(event.x - self.prevX_) < self.nShakeVal
		and math.abs(event.y - self.prevY_) < self.nShakeVal then
		return true
	end
end

function MYScrollView:scaleToParent_()
	local parent
	local node = self
	local scale = {x = 1, y = 1}

	while true do
		scale.x = scale.x * node:getScaleX()
		scale.y = scale.y * node:getScaleY()
		parent = node:getParent()
		if not parent then
			break
		end
		node = parent
	end

	return scale
end

--[[--

加一个大小为viewRect的touch node

]]
function MYScrollView:addTouchNode()
	local node

	if self.touchNode_ then
		node = self.touchNode_
	else
		node = cc.Node:create()
		self.touchNode_ = node

		node:setLocalZOrder(MYScrollView.TOUCH_ZORDER)
		-- node:setTouchSwallowEnabled(true)
		-- node:setTouchEnabled(true)
		-- node:registerScriptTouchHandler( function (event)
		-- 	dump(event)
	 --        return self:onTouch_(event)
	 --    end)

		local listener1 = cc.EventListenerTouchOneByOne:create()
		listener1:setSwallowTouches(true)
		local function onTouch_Began(touch,event)
			local location = touch:getLocation()
			event.x = location.x
			event.y = location.y
			event.name = "began" 
			return self:onTouch_(event)
		end
		local function onTouch_Moved(touch,event)
			local location = touch:getLocation()
			event.x = location.x
			event.y = location.y
			event.name = "moved"
			return self:onTouch_(event)
		end
		local function onTouch_Ended(touch,event)
			local location = touch:getLocation()
			event.x = location.x
			event.y = location.y
			event.name = "ended"
			return self:onTouch_(event)
		end
		listener1:registerScriptHandler(onTouch_Began,cc.Handler.EVENT_TOUCH_BEGAN)
		listener1:registerScriptHandler(onTouch_Moved,cc.Handler.EVENT_TOUCH_MOVED)
		listener1:registerScriptHandler(onTouch_Ended,cc.Handler.EVENT_TOUCH_ENDED)

		local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener1,node)


	    self:addChild(node)
	end

	node:setContentSize(self.viewRect_.width, self.viewRect_.height)
	node:setPosition(self.viewRect_.x, self.viewRect_.y)

    return self
end

--[[--

scrollView的填充方法，可以自动把一个table里的node有序的填充到scrollview里。

~~~ lua

--填充100个相同大小的图片。
    local view =  MYScrollView.new(
        {viewRect = cc.rect(100,100, 400, 400), direction = 2})
    self:addChild(view);

    local t = {}
    for i = 1, 100 do
        local png  = UIImage.new("GreenButton.png")
        t[#t+1] = png
        UILabel.new({text = i, setContentSize = 24, color = cc.c3b(100,100,100)})
            :align(display.CENTER, png:getContentSize().width/2, png:getContentSize().height/2)
            :addTo(png)
    end
    view:fill(t, {itemsetContentSize = (t[#t]):getContentSize()})
~~~

注意：参数nodes 是table结构，且一定要是{node1,node2,node3,...}不能是{a=node1,b=node2,c=node3,...}

@param nodes node集
@param params 参见fill函数头定义。  -- params = extend({ ...

]]

function MYScrollView:fill(nodes,params)
  --参数的继承用法,把param2的参数增加覆盖到param1中。
  local extend = function(param1,param2)
    if not param2 then
      return param1
    end
    for k , v in pairs(param2) do
      param1[k] = param2[k]
    end
    return param1
  end

  local params = extend({
    --自动间距
    autoGap = true,
    --宽间距
    widthGap = 0,
    --高间距
    heightGap = 0,
    --自动行列
    autoTable = true,
    --行数目
    rowCount = 3,
    --列数目
    cellCount = 3,
    --填充项大小
    itemsetContentSize = cc.size(50 , 50)
  },params)

  if #nodes == 0 then
    return nil
  end

  --基本坐标工具方法
  local setContentSize = function(node) return node:getContentSize() end
  local W = function(node) return node:getContentSize().width end
  local H = function(node) return node:getContentSize().height end
  local S_size = function(node , w , h) return node:setContentSize(cc.setContentSize(w , h)) end
  local S_XY = function(node , x , y) node:setPosition(x,y) end
  local AX = function(node) return node:getAnchorPoint().x end
  local AY = function(node) return node:getAnchorPoint().y end

  --创建一个容器node
  local innerContainer = cc.Node:create()
  --初始容器大小为视图大小
  S_size(innerContainer , self:getViewRect().width , self:getViewRect().height)
  self:addScrollNode(innerContainer)
  S_XY(innerContainer , self.viewRect_.x , self.viewRect_.y)

  --如果是纵向布局
  if self.direction == MYScrollView.DIRECTION_VERTICAL then

    --自动布局
    if params.autoTable then
      params.cellCount = math.floor(self.viewRect_.width / params.itemsetContentSize.width)
    end

    --自动间隔
    if params.autoGap then
      params.widthGap = (self.viewRect_.width - (params.cellCount * params.itemsetContentSize.width)) / (params.cellCount + 1)
      params.heightGap = params.widthGap
    end

    --填充量
    params.rowCount = math.ceil(#nodes / params.cellCount)
    --避免动态尺寸少于设计尺寸
    local v_h = (params.itemsetContentSize.height + params.heightGap) * params.rowCount + params.heightGap
    if v_h < self.viewRect_.height then v_h = self.viewRect_.height end
    S_size(innerContainer , self.viewRect_.width , v_h)

    for i = 1 , #nodes do

      local n = nodes[i]
      local x = 0.0
      local y = 0.0

      --不管描点如何，总是有标准居中方式设置坐标。
      x = params.widthGap + math.floor((i - 1) % params.cellCount) * (params.widthGap + params.itemsetContentSize.width)
      y = H(innerContainer) - (math.floor((i - 1) / params.cellCount) + 1) * (params.heightGap + params.itemsetContentSize.height)
      x = x + W(n) * AX(n)
      y = y + H(n) * AY(n)

      S_XY(n , x ,y)
      innerContainer:addChild(n)

    end
    --如果是横向布局
    --  elseif(self.direction==MYScrollView.DIRECTION_HORIZONTAL) then
  else
    if params.autoTable then
      params.rowCount = math.floor(self.viewRect_.height / params.itemsetContentSize.height)
    end

    if params.autoGap then
      params.heightGap = (self.viewRect_.height - (params.rowCount * params.itemsetContentSize.height)) / (params.rowCount + 1)
      params.widthGap = params.heightGap
    end

    params.cellCount = math.ceil(#nodes / params.rowCount)
    --避免动态尺寸少于设计尺寸。
    local v_w = (params.itemsetContentSize.width + params.widthGap) * params.cellCount + params.widthGap
    if v_w < self.viewRect_.width then v_h = self.viewRect_.width end
    S_size(innerContainer , v_w ,self.viewRect_.height)

    for i = 1, #nodes do

      local n = nodes[i]
      local x = 0.0
      local y = 0.0

      --不管描点如何，总是有标准居中方式设置坐标。
      x = params.widthGap +  math.floor((i - 1) / params.rowCount ) * (params.widthGap + params.itemsetContentSize.width)
      y = H(innerContainer) - (math.floor((i - 1) % params.rowCount ) +1 ) * (params.heightGap + params.itemsetContentSize.height)
      x = x + W(n) * AX(n)
      y = y + H(n) * AY(n)

      S_XY(n , x , y)
      innerContainer:addChild(n)

    end

  end

end

function MYScrollView:createCloneInstance_()
    return MYScrollView.new(unpack(self.args_))
end

function MYScrollView:copyClonedWidgetChildren_(node)
	local scrollNode = node:getScrollNode()
	local cloneScrollNode = scrollNode:clone()
	self:addScrollNode(cloneScrollNode)
end

function MYScrollView:copySpecialProperties_(node)
	self:setViewRect(node.viewRect_)
	self:setDirection(node:getDirection())
	self:setLayoutPadding(
		node.layoutPadding.top,
		node.layoutPadding.right,
		node.layoutPadding.bottom,
		node.layoutPadding.left)
	self:setBounceable(node.bBounce)
	self:setTouchType(node.touchOnContent)
end

return MYScrollView
