local CheckboxGroup = class("CheckboxGroup")


function CheckboxGroup.create( ... )
	local bg = CheckboxGroup.new(...)
	return bg
end

--callbackFuncs  可以为一个  也可以为多个
function CheckboxGroup:ctor( buttons,pnls,callbackFuncs )
	assert(#buttons>1,"CheckboxGroup must 2 button")

	self.buttons = buttons
	self.pnls = pnls or {}
	self.callbackFuncs = callbackFuncs or {}

	for k,v in pairs(self.buttons) do
		v:addEventListener(handler(self, self.onItemClick))
	end

	self:select(1)
end

function CheckboxGroup:select(index)
	local checkbox = self.buttons[index]
	checkbox:setSelected(true)
	self:onItemClick(checkbox,0)
end

function CheckboxGroup:onItemClick(sender,value)
	local index = 0
	local selected =  sender:isSelected()
	
	local pnl 
	local cb 
	for k,v in pairs(self.buttons) do
		index =  index + 1
		pnl = self.pnls[index]
		cb = self.callbackFuncs[index] or self.callbackFuncs[1]
		if v == sender and selected == true and cb then 
			cb(index)
		end

		if v == sender then 
			v:setEnabled(false)
			if pnl then 
				pnl:setVisible(selected)
			end
		else
			v:setEnabled(true)
			v:setSelected(not selected)
			if pnl then 
				pnl:setVisible(not selected)
			end
		end 
	end


end

return CheckboxGroup
