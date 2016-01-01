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
	setValue(obj, "Layer", 64, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 66, cc.size(486, 396), cc.p(667, 375), nil, nil, nil, nil, false)
	obj:loadTexture("xgmima_03.png", 0)
	bind(obj).setMargin(424, 177, 424, 177)
	roots.Image_bg_1 = obj

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(14, 11, 15, 23))
	roots.root.Button_cancel_0 = obj
	setValue(obj, "Button_cancel_0", 82, cc.size(43, 45), cc.p(456.9191, 370.7036), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(435.4191, 2.7964, 7.5809, 348.2036)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 82, 22))
	roots.root.Button_ok = obj
	setValue(obj, "Button_ok", 67, cc.size(112, 44), cc.p(113, 37.8143), nil, nil, nil, nil, false)
	obj:loadTextureNormal("tanchuang_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(57, 336.1857, 317, 15.8143)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 82, 20))
	roots.root.Button_cancel = obj
	setValue(obj, "Button_cancel", 68, cc.size(112, 42), cc.p(370, 37.8144), nil, nil, nil, nil, false)
	obj:loadTextureNormal("qx.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(314, 337.1855, 60, 16.8144)

	obj = ccui.ImageView:create()
	roots.Image_bg_1:addChild(obj)
	roots.root.Image_di1 = obj
	setValue(obj, "Image_di1", 69, cc.size(249, 34), cc.p(332.1111, 290.6191), nil, nil, nil, nil, false)
	obj:loadTexture("xgmima_06.png", 0)
	bind(obj).setMargin(207.6111, 88.3809, 29.3889, 273.6191)
	roots.Image_di1_2 = obj

	obj = ccui.TextField:create()
	roots.Image_di1_2:addChild(obj)
	roots.root.TextField = obj
	setValue(obj, "TextField", 70, cc.size(240, 40), cc.p(123, 17.0001), nil, cc.c4b(0, 0, 0, 255), nil, nil, false)
	obj:setString([[12312311333]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(36)
	bind(obj).setMargin(3, -3.0001, 6, -2.9999)

	obj = ccui.Text:create()
	roots.Image_di1_2:addChild(obj)
	roots.root.Text_1 = obj
	setValue(obj, "Text_1", 79, cc.size(102, 34), cc.p(-70, 17), nil, nil, nil, nil, nil)
	obj:setString([[原密码]])
	obj:setFontSize(34)
	bind(obj).setMargin(-121, nil, 268, nil)

	obj = ccui.ImageView:create()
	roots.Image_bg_1:addChild(obj)
	roots.root.Image_di2 = obj
	setValue(obj, "Image_di2", 71, cc.size(249, 34), cc.p(332.1111, 215.1961), nil, nil, nil, nil, false)
	obj:loadTexture("xgmima_06.png", 0)
	bind(obj).setMargin(207.6111, 163.8039, 29.3889, 198.1961)
	roots.Image_di2_2 = obj

	obj = ccui.TextField:create()
	roots.Image_di2_2:addChild(obj)
	roots.root.TextField = obj
	setValue(obj, "TextField", 72, cc.size(240, 40), cc.p(123, 17), nil, cc.c4b(0, 0, 0, 255), nil, nil, false)
	obj:setString([[12312311333]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(36)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(3, -3, 6, -3)

	obj = ccui.Text:create()
	roots.Image_di2_2:addChild(obj)
	roots.root.Text_1_0 = obj
	setValue(obj, "Text_1_0", 80, cc.size(102, 34), cc.p(-70, 17), nil, nil, nil, nil, nil)
	obj:setString([[新密码]])
	obj:setFontSize(34)
	bind(obj).setMargin(-121, nil, 268, nil)

	obj = ccui.ImageView:create()
	roots.Image_bg_1:addChild(obj)
	roots.root.Image_di3 = obj
	setValue(obj, "Image_di3", 73, cc.size(249, 34), cc.p(332.1111, 139.774), nil, nil, nil, nil, false)
	obj:loadTexture("xgmima_06.png", 0)
	bind(obj).setMargin(207.6111, 239.226, 29.3889, 122.774)
	roots.Image_di3_2 = obj

	obj = ccui.TextField:create()
	roots.Image_di3_2:addChild(obj)
	roots.root.TextField = obj
	setValue(obj, "TextField", 74, cc.size(240, 40), cc.p(123, 17), nil, cc.c4b(0, 0, 0, 255), nil, nil, false)
	obj:setString([[12312311333]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(36)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(3, -3, 6, -3)

	obj = ccui.Text:create()
	roots.Image_di3_2:addChild(obj)
	roots.root.Text_1_1 = obj
	setValue(obj, "Text_1_1", 81, cc.size(170, 34), cc.p(-103.9997, 16.9991), nil, nil, nil, nil, nil)
	obj:setString([[确定新密码]])
	obj:setFontSize(34)
	bind(obj).setMargin(-188.9997, 0.0009, 267.9997, -0.0009)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"xgmima_03.png",
	"vip_goumai_06.png",
	"tanchuang_06.png",
	"qx.png",
	"xgmima_06.png",
}

return _M
