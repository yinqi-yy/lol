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
	setValue(obj, "Layer", 726, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_register = obj
	setValue(obj, "Image_register", 727, cc.size(1223, 592), cc.p(657.139, 297.5361), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/bb@2x.png", 0)
	bind(obj).setMargin(45.639, 156.4639, 65.361, 1.5361)
	roots.Image_register_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_register_1:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 728, cc.size(351, 40), cc.p(673.3409, 468.932), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(497.8409, 103.068, 374.1591, 448.932)
	roots.Image_2_2 = obj

	obj = ccui.TextField:create()
	roots.Image_2_2:addChild(obj)
	roots.root.TextField_acct = obj
	setValue(obj, "TextField_acct", 731, cc.size(317.1544, 44.4681), cc.p(162.4839, 21.814), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(3.9067, -4.0481, 29.9388, -0.42)

	obj = ccui.ImageView:create()
	roots.Image_register_1:addChild(obj)
	roots.root.Image_3 = obj
	setValue(obj, "Image_3", 729, cc.size(351, 40), cc.p(673.9163, 402.1106), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(498.4163, 169.8894, 373.5837, 382.1106)
	roots.Image_3_2 = obj

	obj = ccui.TextField:create()
	roots.Image_3_2:addChild(obj)
	roots.root.TextField_pw = obj
	setValue(obj, "TextField_pw", 732, cc.size(337.0133, 32.0924), cc.p(166.9901, 20.2443), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(-1.5165, 3.7095, 15.5032, 4.1981)

	obj = ccui.ImageView:create()
	roots.Image_register_1:addChild(obj)
	roots.root.Image_4 = obj
	setValue(obj, "Image_4", 730, cc.size(305.0215, 40), cc.p(697.268, 334.0015), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(544.7573, 237.9985, 373.2213, 314.0015)
	roots.Image_4_2 = obj

	obj = ccui.TextField:create()
	roots.Image_4_2:addChild(obj)
	roots.root.TextField_pw2 = obj
	setValue(obj, "TextField_pw2", 733, cc.size(294.7144, 32.0924), cc.p(157.6647, 20.2443), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(10.3075, 3.7095, -0.0004, 4.1981)

	obj = ccui.Button:create()
	roots.Image_register_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_save = obj
	setValue(obj, "Button_save", 734, cc.size(122, 40), cc.p(502.8585, 232.0575), nil, nil, nil, nil, false)
	obj:loadTextureNormal("gerenzhongx/baocun.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(441.8585, 339.9425, 659.1415, 212.0575)

	obj = ccui.Button:create()
	roots.Image_register_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_cancle = obj
	setValue(obj, "Button_cancle", 735, cc.size(122, 40), cc.p(751.3658, 231.7708), nil, nil, nil, nil, false)
	obj:loadTextureNormal("gerenzhongx/quxiao.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(690.3658, 340.2292, 410.6342, 211.7708)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"denglu/bb@2x.png",
	"denglu/dl_shuruk.png",
	"Default/Button_Disable.png",
	"gerenzhongx/baocun.png",
	"gerenzhongx/quxiao.png",
}

return _M
