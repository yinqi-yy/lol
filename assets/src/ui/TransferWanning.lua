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
	setValue(obj, "Layer", nil, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 2, cc.size(667, 354), cc.p(663.9987, 342.1465), nil, nil, nil, nil, false)
	obj:loadTexture("baoxiangui/xitongtishi_bj.png", 0)
	bind(obj).setMargin(330.4987, 230.8535, 336.5013, 165.1465)
	roots.Image_1_1 = obj

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_close = obj
	setValue(obj, "Button_close", 3, cc.size(22.3613, 19.3614), cc.p(639.1493, 331.5153), cc.p(0.5399, 0.6984), nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(627.0764, 16.6453, 17.5623, 317.9933)

	obj = ccui.Text:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Text_acct = obj
	setValue(obj, "Text_acct", 4, cc.size(63, 26), cc.p(385.1588, 219.8463), nil, nil, nil, nil, nil)
	obj:setString([[王大哈]])
	obj:setFontSize(20)
	bind(obj).setMargin(353.6588, 121.1537, 250.3412, 206.8463)

	obj = ccui.Text:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Text_ID = obj
	setValue(obj, "Text_ID", 5, cc.size(146, 26), cc.p(426.5775, 170.401), nil, nil, nil, nil, nil)
	obj:setString([[905468490345]])
	obj:setFontSize(20)
	bind(obj).setMargin(353.5775, 170.599, 167.4225, 157.401)

	obj = ccui.Text:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Text_money = obj
	setValue(obj, "Text_money", 6, cc.size(110, 26), cc.p(409.3734, 121.8119), nil, nil, nil, nil, nil)
	obj:setString([[20,000,000]])
	obj:setFontSize(20)
	bind(obj).setMargin(354.3734, 219.1881, 202.6266, 108.8119)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 22))
	roots.root.Button_Yes = obj
	setValue(obj, "Button_Yes", 7, cc.size(154, 44), cc.p(212.8046, 48.5), nil, nil, nil, nil, false)
	obj:loadTextureNormal("baoxiangui/shi.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleText([[Button]])
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(135.8046, 283.5, 377.1954, 26.5)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 22))
	roots.root.Button_No = obj
	setValue(obj, "Button_No", 8, cc.size(154, 44), cc.p(469.4103, 48.3353), nil, nil, nil, nil, false)
	obj:loadTextureNormal("baoxiangui/fou.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(392.4103, 283.6647, 120.5897, 26.3353)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 9, cc.size(127, 99), cc.p(133.8661, 171.5509), nil, nil, nil, nil, false)
	obj:loadTexture("sch.png", 0)
	bind(obj).setMargin(70.3661, 132.9491, 469.6339, 122.0509)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"baoxiangui/xitongtishi_bj.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"baoxiangui/shi.png",
	"baoxiangui/fou.png",
	"sch.png",
}

return _M
