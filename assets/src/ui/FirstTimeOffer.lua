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
	setValue(obj, "Layer", 613, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 614, cc.size(958, 447), cc.p(695.8171, 369.8784), nil, nil, nil, nil, false)
	obj:loadTexture("chongzhi/shouchong.png", 0)
	bind(obj).setMargin(216.8171, 156.6216, 159.1829, 146.3784)
	roots.Image_1_1 = obj

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 285, 86))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 615, cc.size(315, 108), cc.p(120.8165, 406.618), cc.p(0.5308, 0.5393), nil, nil, nil, false)
	obj:setScale(0.7, 0.7)
	obj:loadTextureNormal("chongzhi/sclb_an.png", 0)
	obj:loadTexturePressed("chongzhi/sclb_an1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(-46.3855, -9.3736, 689.3855, 348.3736)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 616, cc.size(126, 34), cc.p(809.8658, 260.9131), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(746.8658, 169.0869, 85.1342, 243.9131)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_3 = obj
	setValue(obj, "Button_3", 618, cc.size(17, 14), cc.p(930.6106, 419.4919), nil, nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(922.1106, 20.5081, 18.8894, 412.4919)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_3 = obj
	setValue(obj, "Image_3", 619, cc.size(121.395, 124.395), cc.p(814.7738, 165.8998), nil, nil, nil, nil, false)
	obj:loadTexture("4.png", 0)
	bind(obj).setMargin(754.0763, 218.9027, 82.5287, 103.7023)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 285, 86))
	roots.root.Button_4 = obj
	setValue(obj, "Button_4", 620, cc.size(315, 108), cc.p(330.7938, 403.7053), nil, nil, nil, nil, false)
	obj:setScale(0.7, 0.7)
	obj:loadTextureNormal("chongzhi/bscz_an1.png", 0)
	obj:loadTexturePressed("chongzhi/bscz_an.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(173.2938, -10.7053, 469.7062, 349.7053)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"chongzhi/shouchong.png",
	"Default/Button_Disable.png",
	"chongzhi/sclb_an1.png",
	"chongzhi/sclb_an.png",
	"vip_goumai/lijigoumai.png",
	"Default/Button_Press.png",
	"image200.png",
	"4.png",
	"chongzhi/bscz_an.png",
	"chongzhi/bscz_an1.png",
}

return _M
