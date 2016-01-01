local UpdateView = class("UpdateView",function()
	local node = util.createlua(ui.UpdateView)
    return node.root
end)
function UpdateView.create(...)
    local node = UpdateView.new(...)
    return node
end

function UpdateView:ctor(config)
	self.pro_time:setPercent(0)	
	self.lbl_time:setString("0%")	
	--调用系统更新
	SystemUpdate:checkVersion(config)


 	--监听进度条
 	GameEvent:addEventListener(GameEvent.SystemUpdateprogress, self, self.Updateprogress)
	GameEvent:addEventListener(GameEvent.closeSystemUpdateprogress, self, self.dispose)


 	--定时器监听是否更新解压完毕
 	self.scheduleId = scheduler.scheduleGlobal(function()
		if SystemUpdate:getIsUpdateComplete() then
			self.pro_time:setPercent(100)	
			self.lbl_time:setString("100%")	
			util.setTimeout(function ( ... )				
				self:initGame()
			end,0.5)		
		end			
	end, 1)
end

--更新下载进度条
function UpdateView:Updateprogress(progress)
	trace(progress.data)
	if progress.data > 0 then
		self.pro_time:setPercent(progress.data)	
		self.lbl_time:setString(tostring(progress.data).."%")
	end	
end

function UpdateView:refresh()

end


function UpdateView:addEvents()

end

--重新更新协议
function UpdateView:reloadProto()
	local proto = require("proto")
    local sproto = require("sproto")

    local host = sproto.new(proto.s2c):host "package"
    local request = host:attach(sproto.new(proto.c2s))
    SocketTCP.setHost(host,request)
end

--更新完成跳转到其他页面 
function UpdateView:initGame()
	self:dispose()

	--更新完毕   开始初始化lua文件
	self:reloadProto()
	require("util.init")

	util.changeUI(ui.LoginView)
end

function UpdateView:dispose()
	if self.scheduleId then
		scheduler.unscheduleGlobal(self.scheduleId)
		self.scheduleId = nil
	end	
end

function UpdateView:resize()

end





return UpdateView