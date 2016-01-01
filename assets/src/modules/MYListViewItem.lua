--------------------------------
-- @module MYListViewItem

--[[--

quick MYListViewItem控件

]]

-- local UIScrollView = import(".UIScrollView")

local MYListViewItem = class("MYListViewItem", function()
	return cc.Node:create()
end)

MYListViewItem.BG_TAG = 1
MYListViewItem.BG_Z_ORDER = 1
MYListViewItem.CONTENT_TAG = 11
MYListViewItem.CONTENT_Z_ORDER = 11
MYListViewItem.ID_COUNTER = 0

function MYListViewItem:ctor(item)
	self.width = 0
	self.height = 0
	self.margin_ = {left = 0, right = 0, top = 0, bottom = 0}
	MYListViewItem.ID_COUNTER = MYListViewItem.ID_COUNTER + 1
	self.id = MYListViewItem.ID_COUNTER
	self:setTag(self.id)
	self:addContent(item)
end

-- start --

--------------------------------
-- 将要内容加到列表控件项中
-- @function [parent=#MYListViewItem] addContent
-- @param node content 显示内容

-- end --

function MYListViewItem:addContent(content)
	if not content then
		return
	end

	self:addChild(content, MYListViewItem.CONTENT_Z_ORDER, MYListViewItem.CONTENT_TAG)
end

-- start --

--------------------------------
-- 获取列表控件项中的内容
-- @function [parent=#MYListViewItem] getContent
-- @return node#node 

-- end --

function MYListViewItem:getContent()
	return self:getChildByTag(MYListViewItem.CONTENT_TAG)
end

-- start --

--------------------------------
-- 设置列表项中的大小
-- @function [parent=#MYListViewItem] setItemSize
-- @param number w 列表项宽度
-- @param number h 列表项高度
-- @param boolean bNoMargin 是否不使用margin margin可调用setMargin赋值

-- end --

function MYListViewItem:setItemSize(w, h, bNoMargin)
	if not bNoMargin then
		if ccui.ScrollViewDir.vertical == self.lvDirection_ then
			h = h + self.margin_.top + self.margin_.bottom
		else
			w = w + self.margin_.left + self.margin_.right
		end
	end

	-- print("MYListViewItem - setItemSize w:" .. w .. " h:" .. h)

	local oldSize = {width = self.width, height = self.height}
	local newSize = {width = w, height = h}

	self.width = w or 0
	self.height = h or 0
	self:setContentSize(w, h)

	local bg = self:getChildByTag(MYListViewItem.BG_TAG)
	if bg then
		bg:setContentSize(w, h)
		bg:setPosition(cc.p(w/2, h/2))
	end

	self.listener(self, newSize, oldSize)
end

--[[--

设置列表项中的大小

@return number width
@return number height

]]
function MYListViewItem:getItemSize()
	return self.width, self.height
end

function MYListViewItem:setMargin(margin)
	self.margin_ = margin

	-- dump(self.margin_, "set margin:")
end

function MYListViewItem:getMargin()
	return self.margin_
end

function MYListViewItem:setBg(bg)
	local sp = nil
	local bgType = tolua.type(bg)
	if "string" == bgType then
		sp = cc.Scale9Sprite:createWithSpriteFrame(bg)
		sp:setAnchorPoint(cc.p(0.5, 0.5))
		sp:setPosition(cc.p(self.width/2, self.height/2))
	elseif "ccui.Scale9Sprite" == bgType or "cc.Sprite" == bgType then
		sp = bg
	elseif "cc.SpriteFrame" == bgType then
		sp = ccui.Scale9Sprite:createWithSpriteFrame(bg)
	end
	self:addChild(sp, MYListViewItem.BG_Z_ORDER, MYListViewItem.BG_TAG)
end

function MYListViewItem:onSizeChange(listener)
	self.listener = listener

	return self
end

-- just for listview invoke
function MYListViewItem:setDirction(dir)
	self.lvDirection_ = dir
end

return MYListViewItem
