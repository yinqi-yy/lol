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
	setValue(obj, "Layer", 723, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 724, cc.size(586, 355), cc.p(681.6003, 381.1792), nil, nil, nil, nil, false)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(388.6003, 191.3208, 359.3997, 203.6792)
	roots.Image_1_1 = obj

	obj = ccui.Text:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Text_1 = obj
	setValue(obj, "Text_1", 725, cc.size(375, 37), cc.p(305.0007, 209.9714), nil, nil, nil, nil, nil)
	obj:setString([[帐 号 或 密 码 错 误，请 重 试]])
	obj:setFontSize(28)
	bind(obj).setMargin(117.5007, 126.5286, 93.4993, 191.4714)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 10, 70, 13))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 726, cc.size(100, 33), cc.p(305.2679, 96.9095), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTextureNormal("qd.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(255.2679, 241.5905, 230.7321, 80.4095)

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
