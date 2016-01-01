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
	setValue(obj, "Layer", 250, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 251, cc.size(923, 561), cc.p(645.4504, 378.1535), nil, nil, nil, nil, false)
	obj:loadTexture("vip_goumai/vipgoumai_bj.png", 0)
	bind(obj).setMargin(183.9504, 91.3465, 227.0496, 97.6535)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 252, cc.size(17, 14), cc.p(1083.8678, 636.1434), nil, nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1075.3678, 106.8566, 241.6322, 629.1434)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 253, cc.size(126, 34), cc.p(561.5795, 227.8313), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(498.5795, 505.1687, 709.4205, 210.8313)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_2_0 = obj
	setValue(obj, "Button_2_0", 254, cc.size(126, 34), cc.p(562.3809, 349.1752), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(499.3809, 383.8248, 708.6191, 332.1752)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_2_1 = obj
	setValue(obj, "Button_2_1", 255, cc.size(126, 34), cc.p(563.0037, 482.3939), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(500.0037, 250.6061, 707.9963, 465.3939)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_2_2 = obj
	setValue(obj, "Button_2_2", 256, cc.size(126, 34), cc.p(1007.6051, 482.6821), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(944.6051, 250.3179, 263.3949, 465.6821)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_2_3 = obj
	setValue(obj, "Button_2_3", 257, cc.size(126, 34), cc.p(1006.6423, 349.0386), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(943.6423, 383.9614, 264.3577, 332.0386)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_2_4 = obj
	setValue(obj, "Button_2_4", 258, cc.size(126, 34), cc.p(1006.6404, 228.0238), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(943.6404, 504.9762, 264.3596, 211.0238)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"vip_goumai/vipgoumai_bj.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"vip_goumai/lijigoumai.png",
}

return _M
