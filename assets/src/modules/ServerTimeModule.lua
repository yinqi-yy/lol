--region ServerTimeModule.lua
--Author : Administrator
--Date   : 2015/7/24
local ServerTimeModule = class("ServerTimeModule")

function ServerTimeModule.create()
	return ServerTimeModule.new()
end

function ServerTimeModule:ctor()

end

--心跳
function ServerTimeModule:startHeartbeat()
    local live = function()
        GameTCP:sendRPC("handshake",{clientTime=os.time()}, ServerTimeModule, ServerTimeModule.onServerTime)
    end
     GameTCP:sendRPC("handshake",{clientTime=os.time()}, ServerTimeModule, ServerTimeModule.onServerTime)
    scheduler.scheduleGlobal(live,5)
end

--接收心跳时间
function ServerTimeModule:onServerTime(result)
     local sendTime = result.clientTime
    local serverTime = result.serverTime
    local revTime = os.time()
    local ping = math.floor((revTime-sendTime)/2)
    self.loseTime = serverTime+ping-revTime
end

function ServerTimeModule:getServerTime()
    if self.loseTime then
        -- printLog( "ServerTimeModule:getServerTime", "获取到服务器时间" )
		-- trace("服务器时间:"..(os.time()+self.loseTime))
        return os.time()+self.loseTime
    end
    -- printLog( "ServerTimeModule:getServerTime", "获取到客户端时间" )
    return os.time()
end

--lua 时间   年日期 
function ServerTimeModule:getTime()
    return os.date("!*t",self:getServerTime())
end

function ServerTimeModule:timeFormat(times)
	local tab = {}
	tab.day = math.modf(times / 86400)
	tab.hour = math.modf((times % 86400) / 3600)
	tab.min = math.modf((times % 3600) / 60)
	tab.sec = math.modf((times % 60))
	return tab
end

--字符时间转化
function ServerTimeModule:stringToTime( times )
	local year_ = os.date("*t", os.time()).year
    local month_ = os.date("*t", os.time()).month
    local day_ = os.date("*t", os.time()).day

	return os.time({year=year_, month=month_, day=day_,
							    hour=times,min=0})
end

return ServerTimeModule