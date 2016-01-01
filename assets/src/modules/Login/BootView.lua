local BootView = class("BootView",function()
	local node = util.createlua(ui.BootView)
    return node.root
end)
function BootView.create(...)
    local node = BootView.new(...)
    return node
end

function BootView:ctor()
	self:reloadProto()
	self:initNetWork()

	self:updateVersion()
end

function BootView:refresh()
    local tip = TemplateData:getLoadingTips()
	self.lbl_tip:setString(tip)
	--self.lbl_tip:runAction(self.animations.actionTimeline);
	--self.animations.actionTimeline:play("animation0",true) 
end


function BootView:initNetWork()
	GameTCP = SocketTCP.create(
    GameServerIP,
    GameServerPort,false)

    GameTCP:connect()
    GameTCP:addEventListener(SocketTCP.EVENT_CONNECTED,self,self.onServerState)
    GameTCP:addEventListener(SocketTCP.EVENT_CLOSED,self,self.onServerState)
    GameTCP:addEventListener(SocketTCP.EVENT_CONNECT_FAILURE,self,self.onServerState)


end

-- 服务器链接状态
function BootView:onServerState(eventSockct)
	if eventSockct.name == SocketTCP.EVENT_CONNECTED then
		self:initGame()
	elseif eventSockct.name == SocketTCP.EVENT_CLOSED  then
		self.lbl_tip:setString(eventSockct.name)
	elseif eventSockct.name == SocketTCP.EVENT_CONNECT_FAILURE  then
		self.lbl_tip:setString(eventSockct.name..
			GameServerIP..":"..GameServerPort)
	end
end


--更新游戏版本
function BootView:updateVersion()



end

--重新更新协议
function BootView:reloadProto()
	local proto = require("proto")
    local sproto = require("sproto")

    local host = sproto.new(proto.s2c):host "package"
    local request = host:attach(sproto.new(proto.c2s))
    SocketTCP.setHost(host,request)
end

--初始化游戏
function BootView:initGame()
	
	-- 添加服务器全局侦听
	PlayerData:addEvents()
	GameTCP:sendRPC("loginToServer", {account=UserName,password=""}, self, self.onLoginRes)
    
    
end

--登陆包处理
function BootView:onLoginRes(result)
	--添加心跳
    ServerTimeModule:startHeartbeat()
	if result.state == 5 then 
		GameTCP:sendRPC("createPlayer", {}	, self, self.onCreatePlayerRes)
	elseif result.state == 1 then
		GameTCP:sendRPC("requestPlayer", {playerID=result.playerID}, self, self.onPlayerRes)
	end
end

--创建角色处理
function BootView:onCreatePlayerRes(result)
	if result.result == 1 then 
		GameTCP:sendRPC("requestPlayer", {playerID=result.playerID}, self, self.onPlayerRes)
	elseif result.result==2 then 
		print("player has create")
	end
end

--请求玩家数据处理
function BootView:onPlayerRes(result)
	trace("--请求玩家数据处理")
    --登陆成功后做一次邮件的接收
    GameTCP:sendRPC("mailPage",{},self,self.ReceiveMail)
    GameTCP:sendRPC("productionConsume", {}, self,self.updateProductionConsume)--城市收益信息
	util.changeUI(ui.MainCity)
  	--初始化天气
    WeatherModule:showWeather()
end

function BootView:updateProductionConsume( result )
	local suc = result and result.wood
    if suc == nil then--失败
        trace("updateProductionConsume 失败")
    else
        PlayerData:updateProductionConsume(result)
    end
end

function BootView:ReceiveMail(mailpage)
	trace("--ReceiveMail")
    PlayerData:UpdateMail(mailpage)

end

function BootView:addEvents()

end


function BootView:dispose()
	
	
end

function BootView:resize()
	util.aptnode(self.lbl_tip)
	util.aptnode(self.lb_loadstate)
end





return BootView