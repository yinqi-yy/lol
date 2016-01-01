local ButtonGroup = class("ButtonGroup")


function ButtonGroup.create( ... )
	local bg = ButtonGroup.new(...)
	return bg
end


function ButtonGroup:ctor( buttons,pnls,callbackFuncs,skins,index,resType)
	assert(#buttons>1,"ButtonGroup must 2 button")

	self.buttons = buttons
	self.pnls = pnls or {}
	self.callbackFuncs = callbackFuncs or {}
	self.skins = skins or {}
    self.resType = resType or 1
	for k,v in pairs(self.buttons) do
		v:addClickEventListener(handler(self, self.onItemClick))
	end

	self:select(index or 1)
end

function ButtonGroup:select(index)
	local checkbox = self.buttons[index]
	self:onItemClick(checkbox,index)
end

function ButtonGroup:getValue()
	return self.value
end

function ButtonGroup:onItemClick(sender,value)
	local pnl 
	local cb 
	for k,v in ipairs(self.buttons) do
		pnl = self.pnls[k]
		cb = self.callbackFuncs[k] or self.callbackFuncs[1]
		if v == sender then 
			 v:setEnabled(false) --禁止点击2次触发
			if pnl then 
				pnl:setVisible(true)
			end
			if self.skins[1] then 
				v:loadTextureNormal(self.skins[1],self.resType)
			end
			self.value =  k
		else
			v:setEnabled(true)
			if self.skins[2] then 
				v:loadTextureNormal(self.skins[2],self.resType)
			end
			if pnl then 
				pnl:setVisible(false)
			end
		end 

		if v == sender and cb then 
			cb(k)
		end
	end
end

return ButtonGroup
