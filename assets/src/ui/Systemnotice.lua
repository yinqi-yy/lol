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
	setValue(obj, "Layer", 243, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_3 = obj
	setValue(obj, "Image_3", 699, cc.size(586, 355), cc.p(642.5359, 419.1003), nil, nil, nil, nil, false)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(349.5359, 153.3997, 398.4641, 241.6003)
	roots.Image_3_1 = obj

	obj = ccui.Button:create()
	roots.Image_3_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 10, 70, 13))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 700, cc.size(100, 33), cc.p(305.0771, 59.5229), nil, nil, nil, nil, false)
	obj:loadTextureNormal("qd.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(255.0771, 278.9771, 230.9229, 43.0229)

	obj = ccui.Button:create()
	roots.Image_3_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 701, cc.size(17, 14), cc.p(562.8923, 336.4414), cc.p(0.5392, 0.5051), nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(553.7259, 11.63, 15.2741, 329.37)

	obj = ccui.Text:create()
	roots.Image_3_1:addChild(obj)
	roots.root.Text_1 = obj
	setValue(obj, "Text_1", 702, cc.size(271, 160), cc.p(296.676, 207.6348), cc.p(0.5024, 0.5326), nil, nil, nil, nil)
	obj:setScale(1.1988, 1.1943)
	obj:setString([[各种赢大奖    各种赢大奖
各种赢大奖    各种赢大奖
各种赢大奖    各种赢大奖
各种赢大奖    各种赢大奖
各种赢大奖    各种赢大奖]])
	obj:setFontSize(24)
	bind(obj).setMargin(160.5256, 72.5812, 154.4744, 122.4188)

	obj = ccui.ImageView:create()
	roots.Image_3_1:addChild(obj)
	roots.root.Image_4 = obj
	setValue(obj, "Image_4", 703, cc.size(135, 34), cc.p(291.8641, 327.3101), nil, nil, nil, nil, false)
	obj:loadTexture("youxigonggao123.png", 0)
	bind(obj).setMargin(224.3641, 10.6899, 226.6359, 310.3101)

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
	"Default/Button_Press.png",
	"qd.png",
	"image200.png",
	"youxigonggao123.png",
}

return _M
