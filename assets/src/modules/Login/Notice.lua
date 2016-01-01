local Notice = class("Notice",function()
	local node = util.createlua(ui.Notice)
    return node.root
end)


function Notice.create(...)
    local node = Notice.new(...)
    return node
end

function Notice:ctor()
end


function Notice:addEvents()
    util.clickSelf(self,self.Button_ok,self.onClose)
    util.clickSelf(self,self.Button_X,self.onClose)
end


function Notice:refresh()
	
end

function Notice:resize()
end

function Notice:removeEvents()
end


function Notice:onNotice()
end


function Notice:dispose()
end

function Notice:onClose()
    util.popWin()
end



return Notice