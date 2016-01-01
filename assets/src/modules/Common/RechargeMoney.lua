-- 充值

local RechargeMoney = class("accountBinding")

function RechargeMoney:ctor()

end

function RechargeMoney:getMoney( productid,price )
	self:rechargeSDK(productid,price,self.onRecharge)
end

function RechargeMoney:rechargeSDK( productid,price,callBackFunc )
	local fun = function ( ... )
		callBackFunc(self,...)
	end
	if __Platform__ == 3 then -- 安卓平台
		self:rechargeAndroidSDK(productid,price,fun)
	else
		fun()
	end
end

--调用安卓的充值接口(平台,回调)
function RechargeMoney:rechargeAndroidSDK( productid,price,callBackFunc )
	local funName = "showGameCoin"
	local uid = PlayerData:getPlayer().account
	local sid = "101"
	local rolename = PlayerData:getPlayerName()
	local args = {
			uid = uid,
			sid = sid,
			rolename = rolename,
			productid = productid,
			price = price,
		}
	local sig = "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V"

	self:callJavaScript(funName,args,sigs,callBackFunc)
end

--调用安卓接口
function RechargeMoney:callJavaScript(funName,args,sigs,callBackFunc)
    if  __Platform__ == 3 then    --安卓平台
    	local luaj = require "cocos.cocos2d.luaj"
		local className = "org/cocos2dx/lua/AppActivity"
		local state, ret = luaj.callStaticMethod(className,funName,args,sigs)
    else
        trace("error:accountBinding:callJavaScript only can call in android platform")
    end
end

function RechargeMoney:onRecharge( callBackFunc )
	if callBackFunc then
		callBackFunc()
	end

end

return RechargeMoney