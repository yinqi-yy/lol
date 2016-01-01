local _L = require("ccext.LuaResHelper")	

local _M = { CCSVER = "2.3.3.0" }

function _M.create(callBackProvider)
	local cc, ccui, ccs = cc, ccui, ccs
	local ccspc = cc.SpriteFrameCache:getInstance()
	local ccsam = ccs.ArmatureDataManager:getInstance()
	
	local setValue, bind = _L.setValue, _L.bind
	local setBgColor, setBgImage = _L.setBgColor, _L.setBgImage
	local setClickEvent, setTouchEvent = _L.setClickEvent, _L.setTouchEvent
	
	local roots, obj, inc = {}

	obj = cc.Node:create()
	roots.root = obj
	roots.root.Layer = obj
	setValue(obj, "Layer", 244, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 245, cc.size(586, 355), cc.p(697.2302, 399.6362), nil, nil, nil, nil, false)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(404.2302, 172.8638, 343.7698, 222.1362)
	roots.Image_1_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 246, cc.size(122, 34), cc.p(280.6073, 325.9472), nil, nil, nil, nil, false)
	obj:loadTexture("vip_shuoming/shuomiang_bt.png", 0)
	bind(obj).setMargin(219.6073, 12.0528, 244.3927, 308.9472)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 247, cc.size(17, 14), cc.p(965.3816, 556.2932), nil, nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(956.8816, 186.7068, 360.1184, 549.2932)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_1 = obj
	setValue(obj, "Text_1", 248, cc.size(471, 52), cc.p(706.4218, 448.0468), nil, nil, nil, nil, nil)
	obj:setString([[抱歉，您还不是VIP，不可以领取每日VIP奖励。赶紧
点击“购买”成为VIP。]])
	obj:setFontSize(20)
	bind(obj).setMargin(470.9218, 275.9532, 392.0782, 422.0468)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_Buy = obj
	setValue(obj, "Button_Buy", 249, cc.size(126, 34), cc.p(714.7083, 337.1899), nil, nil, nil, nil, false)
	obj:setScale(1.4, 1.4)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(651.7083, 395.8101, 556.2917, 320.1899)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"image69.png",
	"vip_shuoming/shuomiang_bt.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"vip_goumai/lijigoumai.png",
}

return _M
