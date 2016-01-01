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
	setValue(obj, "Layer", 22, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 31, cc.size(1334, 750), cc.p(668.2468, 373.7416), nil, nil, nil, nil, false)
	obj:loadTexture("denglu_bj.png", 0)
	bind(obj).setMargin(1.2468, 1.2584, -1.2468, -1.2584)
	roots.Image_1_1 = obj

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_4 = obj
	setValue(obj, "Button_4", 32, cc.size(41, 43), cc.p(1164.6565, 718.5616), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bangzbhu1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1144.1565, 9.9384, 148.8435, 697.0616)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_5 = obj
	setValue(obj, "Button_5", 33, cc.size(41, 43), cc.p(1252.9338, 718.0869), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/fanhui12.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1232.4338, 10.4131, 60.5662, 696.5869)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 23, cc.size(1223, 592), cc.p(686.9258, 293.8071), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/denglu_xbj.png", 0)
	bind(obj).setMargin(75.4258, 160.1929, 35.5742, -2.1929)
	roots.Image_2_1 = obj

	obj = ccui.Button:create()
	roots.Image_2_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 202, 28))
	roots.root.Button_Register = obj
	setValue(obj, "Button_Register", 24, cc.size(232, 50), cc.p(418.5428, 504.3177), nil, nil, nil, nil, false)
	obj:loadTextureNormal("mianfeizhuce.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(302.5428, 62.6823, 688.4572, 479.3177)

	obj = ccui.Button:create()
	roots.Image_2_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 202, 28))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 25, cc.size(232, 50), cc.p(774.0723, 504.3185), nil, nil, nil, nil, false)
	obj:loadTextureNormal("youke.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(658.0723, 62.6815, 332.9277, 479.3185)

	obj = ccui.Button:create()
	roots.Image_2_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 224, 32))
	roots.root.Button_3 = obj
	setValue(obj, "Button_3", 26, cc.size(254, 54), cc.p(591.4661, 243.1187), nil, nil, nil, nil, false)
	obj:loadTextureNormal("denglu/dengluyouxi.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(464.4661, 321.8813, 504.5339, 216.1187)

	obj = ccui.ImageView:create()
	roots.Image_2_1:addChild(obj)
	roots.root.Image_3 = obj
	setValue(obj, "Image_3", 27, cc.size(351, 40), cc.p(662.814, 411.2048), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(487.314, 160.7952, 384.686, 391.2048)
	roots.Image_3_2 = obj

	obj = ccui.TextField:create()
	roots.Image_3_2:addChild(obj)
	roots.root.TextField_1 = obj
	setValue(obj, "TextField_1", 28, cc.size(337.0133, 32.0924), cc.p(166.9901, 20.2443), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(-1.5166, 3.7095, 15.5032, 4.1981)

	obj = ccui.ImageView:create()
	roots.Image_2_1:addChild(obj)
	roots.root.Image_4 = obj
	setValue(obj, "Image_4", 29, cc.size(351, 40), cc.p(662.6521, 345.9048), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(487.1521, 226.0952, 384.8479, 325.9048)
	roots.Image_4_2 = obj

	obj = ccui.TextField:create()
	roots.Image_4_2:addChild(obj)
	roots.root.TextField_1_0 = obj
	setValue(obj, "TextField_1_0", 30, cc.size(337.0133, 32.0924), cc.p(167.1552, 24.1198), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(-1.3515, -0.166, 15.3381, 8.0736)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"denglu_bj.png",
	"Default/Button_Disable.png",
	"dating/bangzbhu1.png",
	"Default/Button_Press.png",
	"dating/fanhui12.png",
	"denglu/denglu_xbj.png",
	"mianfeizhuce.png",
	"youke.png",
	"denglu/dengluyouxi.png",
	"denglu/dl_shuruk.png",
}

return _M
