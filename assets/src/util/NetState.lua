--网络状态变化侦听   zj

local NetState = class("NetState")

---无法访问互联网
NetState.NO = kCCNetworkStatusNotReachable
--通过 WIFI
NetState.WIFI = kCCNetworkStatusReachableViaWiFi
--通过 3G 网络
NetState.WWAN = kCCNetworkStatusReachableViaWWAN

--网络状态切换到3G  需要提示收费的时候处理
NetState.STATE_WIFIToWWAN = "WIFI2WWAN"
--没有网络了 需要提示用户重新连接网络
NetState.STATE_WIFIToNO = "WLAN2NO"

function NetState.create()
    local state = NetState.new()
    return state
end

function NetState:ctor()
	EventProtocol.extend(self)
	scheduler.scheduleGlobal(handler(self,self.getDeviceState),0.5)
	self.state = NetState.NO
	self:getDeviceState()
end

--定时获取网络状态
function NetState:getDeviceState()
	local temp = cc.Network:getInternetConnectionStatus()

	if self.state ~= temp then
		if (self.state == NetState.WIFI or self.state == NetState.NO) and temp == NetState.kCCNetworkStatusReachableViaWWAN then 
			self:onStateChange(NetState.STATE_WIFIToWWAN)
		elseif (self.state == NetState.WIFI or self.state == NetState.WWAN) and temp == NetState.NO then
			self:onStateChange(NetState.STATE_WIFIToNO)
		end
		self.state = temp
	end
end


--网络状态改变的时候通知侦听对象 
function NetState:onStateChange( eventName )
	self:dispatchEvent({name=eventName})
end


return NetState