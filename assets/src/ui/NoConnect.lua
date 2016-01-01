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
	setValue(obj, "Layer", 185, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 186, cc.size(586, 355), cc.p(625.3086, 383.5586), nil, nil, nil, nil, false)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(332.3086, 188.9414, 415.6914, 206.0586)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_1 = obj
	setValue(obj, "Text_1", 187, cc.size(329, 42), cc.p(629.786, 421.9167), nil, nil, nil, nil, nil)
	obj:setString([[无 法 连 接 到 服 务 器]])
	obj:setFontSize(32)
	bind(obj).setMargin(465.286, 307.0833, 539.714, 400.9167)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 10, 70, 13))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 188, cc.size(100, 33), cc.p(633.8378, 304.4182), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("qd.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(583.8378, 429.0818, 650.1622, 287.9182)

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
	"Default/Button_Disable.png",
	"qd.png",
}

return _M
