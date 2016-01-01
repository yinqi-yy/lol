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
	setValue(obj, "Layer", 45, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 46, cc.size(898.4541, 543.7487), cc.p(681.0143, 381.8918), nil, nil, nil, nil, false)
	obj:loadTexture("image613.png", 0)
	bind(obj).setMargin(231.7872, 96.2338, 203.7587, 110.0175)
	roots.Image_1_1 = obj

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 47, cc.size(17, 14), cc.p(859.9156, 512.781), nil, nil, nil, nil, false)
	obj:setScale(1.5508, 1.8067)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(851.4156, 23.9677, 30.0385, 505.781)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_3 = obj
	setValue(obj, "Image_3", 49, cc.size(139.8251, 98.9655), cc.p(490.0806, 441.7959), nil, nil, nil, nil, false)
	obj:setScale(0.7754, 0.9034)
	obj:loadTexture("quanpanjiang/kp2.png", 0)
	bind(obj).setMargin(420.168, 52.4701, 338.4609, 392.3131)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_4 = obj
	setValue(obj, "Image_4", 50, cc.size(112.7842, 110.5688), cc.p(342.462, 403.303), nil, nil, nil, nil, false)
	obj:setScale(0.7754, 0.9034)
	obj:loadTexture("quanpanjiang/kp8.png", 0)
	bind(obj).setMargin(286.0699, 85.1613, 499.6, 348.0186)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_5 = obj
	setValue(obj, "Image_5", 51, cc.size(140.364, 107.6511), cc.p(640.0463, 414.5847), cc.p(0.4712, 0.5233), nil, nil, nil, false)
	obj:setScale(0.7754, 0.9034)
	obj:loadTexture("quanpanjiang/kp3.png", 0)
	bind(obj).setMargin(573.9068, 77.8467, 184.1833, 358.2509)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_6 = obj
	setValue(obj, "Image_6", 52, cc.size(148.296, 109.084), cc.p(342.8855, 252.7607), nil, nil, nil, nil, false)
	obj:setScale(0.7754, 0.9034)
	obj:loadTexture("quanpanjiang/kp7.png", 0)
	bind(obj).setMargin(268.7375, 236.446, 481.4206, 198.2187)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_7 = obj
	setValue(obj, "Image_7", 53, cc.size(153.9431, 114.084), cc.p(634.4064, 246.3694), nil, nil, nil, nil, false)
	obj:setScale(0.7754, 0.9034)
	obj:loadTexture("quanpanjiang/kp5.png", 0)
	bind(obj).setMargin(557.4348, 240.3373, 187.0762, 189.3274)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_8 = obj
	setValue(obj, "Image_8", 54, cc.size(156.7668, 115.9311), cc.p(492.4924, 201.5629), nil, nil, nil, nil, false)
	obj:setScale(0.7754, 0.9034)
	obj:loadTexture("quanpanjiang/kp6.png", 0)
	bind(obj).setMargin(414.109, 284.2203, 327.5783, 143.5974)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_10 = obj
	setValue(obj, "Image_10", 56, cc.size(142.6487, 103.2367), cc.p(194.5829, 331.0272), nil, nil, nil, nil, false)
	obj:setScale(0.7754, 0.9034)
	obj:loadTexture("quanpanjiang/kp4.png", 0)
	bind(obj).setMargin(123.2586, 161.1032, 632.5469, 279.4088)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_11 = obj
	setValue(obj, "Image_11", 57, cc.size(252.8265, 43.5421), cc.p(171.011, 176.8756), nil, nil, nil, nil, false)
	obj:setScale(0.7754, 0.9034)
	obj:loadTexture("quanpanjiang/jiqiquanpanj.png", 0)
	bind(obj).setMargin(44.5977, 345.1021, 601.0298, 155.1046)

	obj = ccui.Text:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Text_7 = obj
	setValue(obj, "Text_7", 223, cc.size(343, 26), cc.p(197.6257, 128.732), nil, nil, nil, nil, nil)
	obj:setString([[得进入“地精宝藏“，得百分百全盘奖]])
	obj:setFontSize(20)
	bind(obj).setMargin(26.1257, 402.0167, 529.3284, 115.732)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 19))
	roots.root.Button_26 = obj
	setValue(obj, "Button_26", 224, cc.size(154, 41), cc.p(507.89, 48.3705), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("vip_shuoming/kaiqibaozang.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(430.89, 474.8782, 313.5641, 27.8705)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_22 = obj
	setValue(obj, "Image_22", 807, cc.size(89, 81), cc.p(1014.9414, 448.1446), nil, nil, nil, nil, false)
	obj:setScale(1.2, 1.2)
	obj:loadTexture("kp1.png", 0)
	bind(obj).setMargin(970.4414, 261.3554, 274.5586, 407.6446)

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
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"quanpanjiang/kp2.png",
	"quanpanjiang/kp8.png",
	"quanpanjiang/kp3.png",
	"quanpanjiang/kp7.png",
	"quanpanjiang/kp5.png",
	"quanpanjiang/kp6.png",
	"quanpanjiang/kp4.png",
	"quanpanjiang/jiqiquanpanj.png",
	"vip_shuoming/kaiqibaozang.png",
	"kp1.png",
}

return _M
