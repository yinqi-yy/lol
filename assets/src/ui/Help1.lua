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
	setValue(obj, "Layer", 802, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 804, cc.size(1255, 668), cc.p(675.1414, 379.564), nil, nil, nil, nil, false)
	obj:loadTexture("image613.png", 0)
	bind(obj).setMargin(47.6414, 36.436, 31.3586, 45.564)
	roots.Image_2_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_2_1:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 803, cc.size(1131, 506), cc.p(618.6099, 307.958), nil, nil, nil, nil, false)
	obj:loadTexture("bangzhu1.png", 0)
	bind(obj).setMargin(53.1099, 107.042, 70.8901, 54.958)

	obj = ccui.Button:create()
	roots.Image_2_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 805, cc.size(17, 14), cc.p(1212.0463, 638.1484), cc.p(0.4403, 0.6791), nil, nil, nil, false)
	obj:setScale(2, 2)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1204.5604, 25.3588, 33.4396, 628.6412)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"image613.png",
	"bangzhu1.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
}

return _M
