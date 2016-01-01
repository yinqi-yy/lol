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
	setValue(obj, "Layer", 225, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_3 = obj
	setValue(obj, "Image_3", 228, cc.size(594.7479, 457.59), cc.p(625.1828, 377.2955), nil, nil, nil, nil, false)
	obj:loadTexture("image613.png", 0)
	bind(obj).setMargin(327.8088, 143.9095, 411.4432, 148.5005)
	roots.Image_3_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_3_1:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 226, cc.size(469, 361), cc.p(293.6736, 248.9138), nil, nil, nil, nil, false)
	obj:loadTexture("paihangbang/caifupaih_bj.png", 0)
	bind(obj).setMargin(59.1736, 28.1761, 66.5743, 68.4138)
	roots.Image_1_2 = obj

	obj = ccui.ListView:create()
	roots.Image_1_2:addChild(obj)
	roots.root.ListView_1 = obj
	setValue(obj, "ListView_1", 230, cc.size(512.971, 358.1824), cc.p(221.9974, 146.1869), cc.p(0.4648, 0.5062), nil, nil, nil, nil)
	setBgColor(obj, 1, 0, cc.c4b(150, 150, 255, 255), nil, nil, nil)
	bind(obj).setMargin(-16.4239, 37.9427, -27.5471, -35.1251)

	obj = ccui.Button:create()
	roots.Image_3_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 229, cc.size(17, 15.5759), cc.p(564.5378, 430.2432), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(556.0378, 19.5588, 21.7101, 422.4552)

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
	"paihangbang/caifupaih_bj.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
}

return _M
