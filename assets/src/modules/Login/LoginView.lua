--
-- Author: Your Name
-- Date: 2015-07-14 14:14:30
--
local LoginView = class("LoginView",function()
	local node = util.createlua(ui.LoginView)
    return node.root
end)


function LoginView.create(...)
    local node = LoginView.new(...)
    return node
end

function LoginView:ctor()
	-- local skeletonNode = sp.SkeletonAnimation:create("Spine/Loading/loading_1.json", 
	-- 	"Loading/Loading_4.atlas", 1)
	-- self:addChild(skeletonNode,-2)
	-- skeletonNode:setPosition(320, 400)
	-- skeletonNode:setMix("renwu", "renwu", 1)
	-- skeletonNode:setAnimation(0, "renwu", true)
	-- skeletonNode:addAnimation(0, "renwu", true, 0)


	-- local skeletonNode = sp.SkeletonAnimation:create("Spine/World/Yeren.json", 
	-- 	"World/World_3.atlas", 1)
	-- self:addChild(skeletonNode)

	-- skeletonNode:setPosition(100, 500)

	-- --设置动画间过渡时间		  fromAnimation toAnimation duration
	-- skeletonNode:setMix("gj_0", "gj_0", 1)
	-- skeletonNode:setMix("dj", "dj", 0.2)

	-- --设置初始动画 是否循环播放  trackIndex  name  loop
	-- skeletonNode:setAnimation(0, "dj", true)

	-- --添加动画序列  			  trackIndex  name  loop   delay
	-- skeletonNode:addAnimation(0, "gj_0", true, 1)
	-- skeletonNode:addAnimation(0, "dj", true)



	-- local skeletonNode = sp.SkeletonAnimation:create("Spine/Loading/loading.json", 
	-- 	"Loading/Loading_5.atlas", 1)
	-- self:addChild(skeletonNode,-1)
	-- skeletonNode:setPosition(320, 400)
	-- skeletonNode:setMix("qizi", "qizi", 1)
	-- skeletonNode:setAnimation(0, "qizi", true)
	-- skeletonNode:addAnimation(0, "qizi", true, 0)




	local serverlist = {
		{ip="120.33.34.198",name="igg",port=9999},
		{ip="115.28.154.121",name="igg",port=9000},
		   
	}
	--获取登机记录
	local ip = util.getKey("serverip")
	local port = tonumber(util.getKey("server_port"))
	local username = util.getKey("username")
	if username then 
		self.tf_nickname:setString(username)
	end

	self.listItems={}

	local serverlistItem 
	local selectedServerInfo 
	for i,v in pairs(serverlist) do
		serverlistItem = util.createluaItem("ui.login.serverListItem")
		serverlistItem.data = v
		if ip == v.ip and port ==v.port then 
			print(ip,v.ip,port,v.port)
			selectedServerInfo = v
		end

		util.clickSelf(self,serverlistItem.img_bg,self.onSelectItem,v)
		util.listAddItem(self.lv_serverList,serverlistItem)
		table.insert(self.listItems,serverlistItem)
	end
	self:onSelectItem(selectedServerInfo or serverlist[1])
end


function LoginView:addEvents()
	util.clickSelf(self,self.btn_login,self.onLogin)
end


function LoginView:refresh()
	
end

function LoginView:resize()
	util.aptlist(self.lv_serverList)
	util.aptnode(self.btn_login)
	util.aptnode(self.tf_nickname)
end

function LoginView:onSelectItem(info)
	self.serverInfo = info

	for k,v in pairs(self.listItems) do
		if info.ip ==v.data.ip and info.port == v.data.port then 
			v.lbl_serverName:setString("# "..v.data.name.."  "..v.data.ip.." : "..v.data.port.." #")
		else
			v.lbl_serverName:setString(v.data.name.."  "..v.data.ip.." : "..v.data.port)
		end
	end

	util.setKey("serverip",self.serverInfo.ip)
	util.setKey("server_port",self.serverInfo.port)

	GameServerIP =  info.ip
    GameServerPort = info.port
end


function LoginView:removeEvents()


end


function LoginView:onLogin()
       --[[ local function downCallback(result)
        print(result.state)
            if result.state == 3 then -- 下载完成
                
            end
        end
        Loader:shared():setRemotePath("http://graph.facebook.com/1504749166487992/picture?type=small")
	    Loader:shared():load("", handler(self, downCallback))]]
        --[[local xhr = cc.XMLHttpRequest:new()
        xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
        xhr:open("GET", "http://graph.facebook.com/1504749166487992/picture?type=small")
        local function onReadyStateChange()
            if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                File.save(path,xhr.response,"wb")
                trace("sc")
            else
                trace("util.loadWebImg xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
                
            end
            
        end
        xhr:registerScriptHandler(onReadyStateChange)
        xhr:send()]]
        --cc.SimpleAudioEngine:getInstance():playEffect("sounds/effects/city_click.ogg")
        --local f = "sounds/effects/city_click.acc"
        --local f = "config.lua"--city_click.acc"

        --trace(f)
        --util.playSound(f)
--GameSound:onClickBuild()
	UserName = self.tf_nickname:getString()

	if UserName =="" or UserName ==nil then 
		return 
	end

	if UserName then 
		util.setKey("username",UserName)
	end

	if self.serverInfo then 
		util.changeUI(ui.BootView)
	end
end


function LoginView:dispose()
	self.listItems = nil

end



return LoginView