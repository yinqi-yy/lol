local Register = class("Register",function()
	local node = util.createlua(ui.Register)
    return node.root
end)


function Register.create(...)
    local node = Register.new(...)
    return node
end

function Register:ctor()
end


function Register:addEvents()
    util.clickSelf(self,self.Button_save,self.onSaveClick)
    util.clickSelf(self,self.Button_cancle,self.onCancle)
end


function Register:refresh()
	
end

function Register:resize()
end

function Register:removeEvents()
end


function Register:onRegister()
end


function Register:dispose()
end

function Register:onSaveClick()
    GameTCP:sendRPC("register",{userName="textName",passWord="123456"},self,self.onSaveRes)
end

function Register:onSaveRes(result)
    traceObj(result)
end

function Register:onCancle()
    util.popWin()
end

return Register