local _L = require("ccext.LuaResHelper")	

local _M = { CCSVER = "2.3.2.3" }

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
	setValue(obj, "Layer", 90, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_bg = obj
	setValue(obj, "Panel_bg", 91, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(0, 0, 0, 255), nil, nil, nil)
	roots.Panel_bg_1 = obj

	obj = ccui.ImageView:create()
	roots.Panel_bg_1:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 92, cc.size(489, 394), cc.p(666.9999, 373.3562), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("shezhi_03.png", 0)
	bind(obj).setMargin(422.4999, 179.6438, 422.5001, 176.3562)
	roots.Image_bg_2 = obj

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.music = obj
	setValue(obj, "music", 94, cc.size(101, 35), cc.p(251.3153, 256.1136), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("shezhi_06.png", 0)
	bind(obj).setMargin(200.8153, 120.3864, 187.1847, 238.6136)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.sound = obj
	setValue(obj, "sound", 95, cc.size(101, 35), cc.p(251.3153, 180.8173), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("shezhi_06.png", 0)
	bind(obj).setMargin(200.8153, 195.6827, 187.1847, 163.3173)

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(14, 11, 84, 22))
	roots.root.Button_ok = obj
	setValue(obj, "Button_ok", 103, cc.size(112, 44), cc.p(244.5, 28.7153), nil, nil, nil, nil, false)
	obj:loadTextureNormal("tanchuang_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(188.5, 343.2847, 188.5, 6.7153)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"shezhi_03.png",
	"shezhi_06.png",
	"tanchuang_06.png",
}

return _M
