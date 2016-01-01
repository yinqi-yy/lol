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
	setValue(obj, "Layer", 816, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_lowerbar = obj
	setValue(obj, "Panel_lowerbar", 818, cc.size(1319.6129, 100.8273), cc.p(662.3427, 56.0139), cc.p(0.4964, 0.4008), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 0, cc.c4b(150, 200, 255, 255), nil, nil, nil)
	bind(obj).setMargin(7.3218, 633.5701, 7.0653, 15.6026)
	roots.Panel_lowerbar_1 = obj

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 47, 51))
	roots.root.Button_daily = obj
	setValue(obj, "Button_daily", 819, cc.size(77, 73), cc.p(1194.4596, 53.895), cc.p(0.5013, 0.5246), nil, nil, nil, false)
	obj:loadTextureNormal("dating/meirilingqu_an121.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1155.8572, 12.2246, 86.7557, 15.6027)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 60))
	roots.root.Button_Competition = obj
	setValue(obj, "Button_Competition", 820, cc.size(75, 82), cc.p(200.5307, 56.1186), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bsph12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(163.0307, 3.7087, 1081.5823, 15.1186)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 46, 57))
	roots.root.Button_SystemNotice = obj
	setValue(obj, "Button_SystemNotice", 821, cc.size(76, 79), cc.p(309.9258, 56.1193), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/youxigonggao_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(271.9258, 5.208, 971.6871, 16.6193)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 54))
	roots.root.Button_VIP = obj
	setValue(obj, "Button_VIP", 822, cc.size(75, 76), cc.p(54.6709, 53.4179), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/vip_1.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(17.1709, 9.4094, 1227.442, 15.4179)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 54, 55))
	roots.root.Button_wealth = obj
	setValue(obj, "Button_wealth", 823, cc.size(84, 77), cc.p(1043.2777, 52.593), cc.p(0.5322, 0.4804), nil, nil, nil, false)
	obj:loadTextureNormal("dating/caifubang_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(998.5766, 8.2246, 237.0364, 15.6027)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"Default/Button_Disable.png",
	"dating/meirilingqu_an121.png",
	"dating/bsph12.png",
	"dating/youxigonggao_an12.png",
	"Default/Button_Press.png",
	"dating/vip_1.png",
	"dating/caifubang_an12.png",
}

return _M
