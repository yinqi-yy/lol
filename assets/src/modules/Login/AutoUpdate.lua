local AutoUpdate = class("AutoUpdate",function()
    local temp = require("ui.login.UpdateView")
    local node = temp.create()
    return node.root
end)

function AutoUpdate.create()
    local layer = AutoUpdate.new()
    return layer
end

function AutoUpdate:ctor()

	self:initSmall()

	self.pro_time:setPercent(0)	
	self.lbl_time:setString("0%")
end

--重新更新协议
function AutoUpdate:reloadProto()
	local proto = require("proto")
    local sproto = require("sproto")

    local host = sproto.new(proto.s2c):host "package"
    local request = host:attach(sproto.new(proto.c2s))
    SocketTCP.setHost(host,request)
end

--最小初始化
function AutoUpdate:initSmall()
	--初始最少的lua文件
	require("util.functions")

	File = require("util.File")
	Language = require("util.Language")

	Language.load("local/text_zh_CN_UI.ini")
	Language.load("local/text_zh_CN_data.ini")
	scheduler = require("util.scheduler")
	EventProtocol = require "util.EventProtocol"
	SystemUpdate = require("util.SystemUpdate").create()

    SocketTCP = require("util.SocketTCP")
    self:reloadProto()

    GameTCP = SocketTCP.create(
    GameServerIP,
    GameServerPort,false)

    GameTCP:connect()
    GameTCP:addEventListener(SocketTCP.EVENT_CONNECTED,self,self.onServerState)
    GameTCP:addEventListener(SocketTCP.EVENT_CLOSED,self,self.onServerState)
    GameTCP:addEventListener(SocketTCP.EVENT_CONNECT_FAILURE,self,self.onServerState)

end

--更新提示
function AutoUpdate:alert()

end




-- 解析配置文件  更新内容
function AutoUpdate:updateVersion( eventSockct )
	--调用系统更新
	SystemUpdate:checkVersion(eventSockct)

	if SystemUpdate:getIsUpdateComplete() then 
		require("util.init")
		util.changeUI(ui.LoginView)
	else
	 	--监听进度条
	 	SystemUpdate:addEventListener(SystemUpdate.SystemUpdateprogress, self, self.Updateprogress)
	 	SystemUpdate:addEventListener(SystemUpdate.SystemZipprogress, self, self.Updateprogress)
		SystemUpdate:addEventListener(SystemUpdate.closeSystemUpdateprogress, self, self.dispose)
	end
end

-- 服务器链接状态
function AutoUpdate:onServerState(eventSockct)
	if eventSockct.name == SocketTCP.EVENT_CONNECTED then
    	--添加捕获配置文件信息
		GameTCP:sendRPC("getClientConfig",{platformID="3",version="alpha"},self,self.updateVersion)

	elseif eventSockct.name == SocketTCP.EVENT_CLOSED  then
		trace(eventSockct.name)
		-- Alert.confirmBox(self,3,eventSockct.name,Language.get("10153"))
	elseif eventSockct.name == SocketTCP.EVENT_CONNECT_FAILURE  then
		trace(eventSockct.name..GameServerIP..":"..GameServerPort)
		-- Alert.confirmBox(self,3,eventSockct.name,Language.get("10153"))
	end
end

--更新下载进度条
function AutoUpdate:Updateprogress(progress)
	if type(progress.data)=="table"  then
		local pro = math.floor(progress.data.index/progress.data.total*100)
		self.pro_time:setPercent(pro)	
		self.lbl_time:setString("zip:"..pro.."%")
	else
		if progress.data > 0 then 
			self.pro_time:setPercent(progress.data)	
			self.lbl_time:setString(tostring(progress.data).."%")
		end
	end
end


--该界面为被管理无法调用dispose  需要手动清理
function AutoUpdate:dispose()
	GameTCP:revmoveTargetEvents(self)
	SystemUpdate:revmoveTargetEvents(self)
end


--重启游戏  这里必须手动销毁创建的全部东西
function AutoUpdate:reloadGame()
	Data:dispose()
	self:dispose()
	reloadGame()
end


return AutoUpdate