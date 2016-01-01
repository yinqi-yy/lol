
local LoginView = class("LoginView",function()
	local node = util.createlua(ui.BackLogin)
    return node.root
end)


function LoginView.create(...)
    local node = LoginView.new(...)
    return node
end

function LoginView:ctor()
end


function LoginView:addEvents()
end


function LoginView:refresh()
	
end

function LoginView:resize()
end

function LoginView:onSelectItem(info)
end


function LoginView:removeEvents()


end


function LoginView:onLogin()
end


function LoginView:dispose()
end



return LoginView