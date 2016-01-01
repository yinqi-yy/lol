local RichTextArea = class("RichTextArea",function()
	return ccui.RichText:create()
end)

function RichTextArea.create(w,h,fontSize,fontColor,fontName)
	local text = RichTextArea.new(w,h,fontSize,fontColor,fontName)
	return text
end

function RichTextArea:ctor(w,h,fontSize,fontColor,fontName)
	self.tagName = 0 
	self.width = w or css.RichTextArea.width
	if w then 
		self.width = self.width - 30
	end
	self.height = h or css.RichTextArea.height
	self.fontSize = fontSize or css.RichTextArea.fontSize
	self.fontColor = fontColor or css.RichTextArea.fontColor
	self.fontName = fontName or css.RichTextArea.fontName
    self:ignoreContentAdaptWithSize(false)
    self:setAnchorPoint({0,0})
    self:setContentSize(cc.size(self.width,self.height))
    self:setPosition(-self.width/2,-self.height/2)
    self.items = List.create()
end

--获取大小
function RichTextArea:getBodySize( )
	return self:getVirtualRendererSize()
end

--换行
function RichTextArea:newline()
	self:br()
end

--插入空行
function RichTextArea:emptyline()
	self:appendTextBr(" ")
end

--设置单行刷新行文本
function RichTextArea:setString(text)
	self:removeAll()
	self:appendText(text)
end

function RichTextArea:setKeepScreen( value )
	if value > 1 then 
		self.keepScreen = value
	end
end

function RichTextArea:removeLast()
	local obj = self.items:popright()
	if obj then 
		self:removeElement(obj)
	end
end

--移除所有行
function RichTextArea:removeAll()
	while self.items:num()>0 do 
		local obj = self.items:popleft()
		if obj then 
			self:removeElement(obj)
		end
	end
	self.tagName = 0 
end

--设置html标签
function RichTextArea:appendText(text)
	local tick 
	if text:find("[end]") then 
		local res = RichTextFormat.format(text)
		for k,v in pairs(res) do
			if v.type == "Word" then 
				tick = self:appendBr(self.fontColor,v[1])
			elseif v.type =="colorWord"    then 
				-- traceObj(v)
				if v[3] == nil  then 
					tick = self:appendBr(v[1],v[2])
				else
					tick = self:appendBr(v[1],v[3],v[2])
				end
			end
		end
	else
		tick = self:appendBr(self.fontColor,text)
	end
	return tick
end

function RichTextArea:checkScreen( )
	if self.keepScreen then 
		--内容大于屏幕高度的倍数的时候移除掉最开始的部分类容
		-- while self:getBodySize().height>self.height*self.keepScreen do
		-- 	local obj = self.items:popleft()
		-- 	if obj then 
		-- 		self:removeElement(obj)
		-- 	end
		--  	self:formatText()
		-- end
		if self:getBodySize().height>self.height*self.keepScreen then
			self:removeAll()
		end
	end
end

--设置html标签   在换行
function RichTextArea:appendTextBr(text)
	local tick = self:appendText(text)
	self:br()
	return tick
end

--检查是否有换行符号
function RichTextArea:appendBr(color,text,fontSize)
	local tick
	if text:find("[br]") then 
		local brs = string.split(text, "[br]")
		local count = #brs
		for k,v in pairs(brs) do
			tick = self:append(color,v,fontSize)
			if k ~= count then
				self:br()
			end
		end
	else
		tick = self:append(color,text,fontSize)
	end
	return tick
end

function RichTextArea:append(color,text,fontSize)
    if type(color) == "string" then 
		color = RGB(color)
	end
	-- print(color,text,fontSize)
	-- print(self.tagName ,color,255,text,self.fontName,tonumber(fontSize) or self.fontSize)
	local tick = ccui.RichElementText:create(self.tagName ,color,255,text,self.fontName,tonumber(fontSize) or self.fontSize)
	self:pushBackElement(tick)
	self.items:pushright(tick)
    self.tagName = self.tagName +1
    return tick
end

function RichTextArea:appendImage(imagePath)
    local tick = ccui.RichElementImage:create(self.tagName ,cc.c3b(1,1,1),255,imagePath)
    self:pushBackElement(tick)
    self.items:pushright(tick)
    self.tagName = self.tagName +1
end

function RichTextArea:appendNode(node)
    local tick = ccui.RichElementCustomNode:create(self.tagName ,cc.c3b(1,1,1),255,node)
    self:pushBackElement(tick)
    self.items:pushright(tick)
    self.tagName = self.tagName +1
end

return RichTextArea