--Facebook google+相关
--hzs

local accountBinding = class("accountBinding")

function accountBinding:ctor()

end


--登录成功后绑定,platformID = 平台 ID
function accountBinding:bindAccount(platformID)
    self:LoginSDK(platformID,self.onLogin)
end


--切换账号 
function accountBinding:switchAccount(platformID)
    self:LoginSDK(platformID,self.onSwitchAccount)
end

--开始新游戏 
function accountBinding:restartGame()
    self:setNewAccountName("")
    self:delAccount()
end

--解除绑定
function accountBinding:sendReleaseBinding(platformID)
    GameTCP:sendRPC("releaseBindAccount", {platformID = platformID}, self, self.onReleaseBindAccount)	
end


--获取Facebook好友,已登录直接返回好友列表,未登录则先登录,登录成功后将通知GameEvent.updateFacebookFriend
function accountBinding:getFacebookFriends()
    if self._fbfriends then
        return self._fbfriends
    end
    self:LoginSDK(Enum.bindActPlatform.facebook,self.onGetFrined)
    return nil
end

--邀请好友
function accountBinding:inviteFriends()
    self:inviteSDK(function() trace("邀请好友回调") end)
end
--------------------------
--private


---------------------------
--登录平台SDK,callBackFunc 为登录成功后返回信息,其中callBackFunc第一个参数为平台ID,第二个参数为返回的Json如:"{\"uid\":\"116511199275348934507\",\"account\":\"testName\"}"
function accountBinding:inviteSDK(callBackFunc)
    local fun = function(...)
        callBackFunc(self,platformID,...)
    end

    if  __Platform__ == 3 then--安卓平台
        self:inviteAndriodSDK(fun)
    else
        trace("当前平台未做邀请好友SDK")
    end
end

--调用安卓的登录接口(平台,回调)
function accountBinding:inviteAndriodSDK(callBackFunc)
    local funName = "inviteFriends"

    self:callJavaScript(funName,callBackFunc)
end


--登录平台SDK,callBackFunc 为登录成功后返回信息,其中callBackFunc第一个参数为平台ID,第二个参数为返回的Json如:"{\"uid\":\"116511199275348934507\",\"account\":\"testName\"}"
function accountBinding:LoginSDK(platformID,callBackFunc)
    local fun = function(...)
        callBackFunc(self,platformID,...)
    end

    if  __Platform__ == 3 then--安卓平台
        self:LoginAndriodSDK(platformID,fun)
    else
        --其他平台先直接返回结果
        --TODO:
        local testName
        if platformID == Enum.bindActPlatform.facebook then
            testName = "facebookName"
        elseif platformID == Enum.bindActPlatform.google then
            testName = "googleName"
        end
        local res = "{\"uid\":\"116511199275348934507\",\"account\":\""..testName.."\",\"friends\":[{\"name\":\"any sun\",\"id\":\"1612981012289121\"},{\"name\":\"hzs\",\"id\":\"1504749166487992\"}]}"
        trace("当前平台未做登录 SDK 测试数据: "..res)
        fun(res)
    end
end

--调用安卓的登录接口(平台,回调)
function accountBinding:LoginAndriodSDK(platformID,callBackFunc)
    local funName
    if platformID == Enum.bindActPlatform.facebook then
        funName = "bindFbAccount"
    elseif platformID == Enum.bindActPlatform.google then
        funName = "bindGoogleAccount"
    else
        trace("error:LoginAndriodSDK login ,unknow platformID"..tostring(platformID))
        return
    end

    self:callJavaScript(funName,callBackFunc)
end

--调用安卓接口
function accountBinding:callJavaScript(funName,callBackFunc)
    if  __Platform__ == 3 then    --安卓平台
    	local luaj = require "cocos.cocos2d.luaj"
		local className = "org/cocos2dx/lua/AppActivity"
		local args = {callBackFunc}
        local sigs = "(I)V"
		local state, ret = luaj.callStaticMethod(className,funName,args,sigs)
    else
        trace("error:accountBinding:callJavaScript only can call in android platform")
    end
end

--好友列表回调
function accountBinding:onGetFrined(platformID,res)
    if res == nil then
        trace("error:onLogin not res")
        return
    end

    local resData = json.decode(res)
    if not (resData and resData.uid and resData.account) then
        trace("error:onGetFrined invalid res"..tostring(res))
        return
    end

    local friendsData = resData.friends

    if friendsData == nil then
        trace("onGetFrined not friendsData")
        return
    end

    if type(friendsData) == "table" then
        self._fbfriends = friendsData
        GameEvent:notifyView(GameEvent.updateFacebookFriend,friendsData)
    else
        trace("error:onGetFrined res  not a json data,res = "..tostring(friendsData))
    end
end


--登录成功回调
function accountBinding:onLogin(platformID,res)
    if res == nil then
        trace("error:onLogin not res")
        return
    end

    local resData = json.decode(res)
    if not (resData and resData.uid and resData.account) then
        trace("error:onLoginFacebook invalid res"..tostring(res))
        return
    end

    self:sendBindingAccount(platformID,resData.uid,resData.account)
    self:onGetFrined(platformID,res)
end

--发送绑定
function accountBinding:sendBindingAccount(platformID,platformUserID,platformAccount)
    GameTCP:sendRPC("bindAccount", {platformID = platformID,platformUserID = platformUserID,platformAccount = platformAccount}, self, self.onBindingRes)	
end

function accountBinding:onBindingRes(result,sendData)
    if result.result == 1 then
        PlayerData:UpdateBindAccountsData(sendData)
    else
        trace("error:accountBinding onBindingRes result = "..tostring(result.result))
        GameHelper:serverTip(result.result)
    end	
end



function accountBinding:onReleaseBindAccount(result,sendData)
    if result.result == 1 then
        PlayerData:delBindAccountsData(sendData.platformID)
    else
        trace("error:accountBinding onReleaseBindAccount result = "..tostring(result.result))
        GameHelper:serverTip(result.result)
    end	
end

function accountBinding:onSwitchAccount(platformID,res)
    if res == nil then
        trace("error:onSwitchFacebook not res")
        return
    end

    local resData = json.decode(res)
    if not (resData and resData.uid and resData.account) then
        trace("error:onSwitchAccount invalid res"..tostring(res))
        return
    end

    self:sendswitchAccount(platformID,resData.account)
end


--发送切换账号
function accountBinding:sendswitchAccount(platformID,platformAccount)
    GameTCP:sendRPC("switchAccount", {platformID = platformID,platformAccount=platformAccount}, self, self.onSendSwitchAccount)	
end

function accountBinding:onSendSwitchAccount(result,sendData)
    if result.result == 1 then
        self:warningCheckSwitch(result)
    else
        trace("error:accountBinding onSwitchAccount result = "..tostring(result.result))
        GameHelper:serverTip(result.result)
    end	
end

--切换完账号需要删除本账号
function accountBinding:delAccount()
     GameTCP:sendRPC("deleteAccount", {}, self, self.onDelAccount)	
end 

function accountBinding:onDelAccount(result)
    if result.result == 1 then
        --TODO:
        --重启
        trace("切换账号成功,重启")
        --os.exit()
        
    else
        trace("error:accountBinding onSwitchAccount result = "..tostring(result.result))
        GameHelper:serverTip(result.result)
    end	
end

--切换账号时提示窗
function accountBinding:warningCheckSwitch( result )
    if result.name and result.lv and result.account then
        local function cancelFun()
        end
        local function okFun()
            local str = Language.get( "41049" )
            Alert.messageBox3( str, function() 
                self:setNewAccountName(result.account) 
                self:delAccount() 
                end, 
            cancelFun
            )
        end

        local str = string.formatIndex( Language.getFormatBr( "41048" ),result.name, result.lv )
        Alert.messageBox3( str, okFun, cancelFun )
    else
        trace("error:warningCheckSwitch")
        traceObj(result)
    end
end

function accountBinding:setNewAccountName(UserName)
    util.setKey("username",UserName)
end


return accountBinding