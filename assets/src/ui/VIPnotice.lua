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
	setValue(obj, "Layer", 34, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 35, cc.size(667, 353), cc.p(602.2084, 366.4039), nil, nil, nil, nil, false)
	obj:loadTexture("vipLB.png", 0)
	bind(obj).setMargin(268.7084, 207.0961, 398.2916, 189.9039)
	roots.Image_1_1 = obj

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_close = obj
	setValue(obj, "Button_close", 36, cc.size(17, 14), cc.p(633.923, 328.7612), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(625.423, 17.2388, 24.577, 321.7612)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_buy = obj
	setValue(obj, "Button_buy", 37, cc.size(126, 34), cc.p(359.8894, 74.4252), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(296.8894, 261.5748, 244.1106, 57.4252)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"vipLB.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"vip_goumai/lijigoumai.png",
}

return _M
