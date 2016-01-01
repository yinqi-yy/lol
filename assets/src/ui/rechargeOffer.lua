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
	setValue(obj, "Layer", 621, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_1 = obj
	setValue(obj, "Panel_1", 631, cc.size(1178.703, 732.1306), cc.p(680.4003, 355.6017), cc.p(0.5112, 0.4797), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 0, cc.c4b(150, 200, 255, 255), nil, nil, nil)
	bind(obj).setMargin(77.7925, 13.4522, 77.5044, 4.4172)
	roots.Panel_1_1 = obj

	obj = ccui.ImageView:create()
	roots.Panel_1_1:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 622, cc.size(958, 447), cc.p(636.223, 355.9853), nil, nil, nil, nil, false)
	obj:loadTexture("chongzhi/baoshichongzhi_bj.png", 0)
	bind(obj).setMargin(157.223, 152.6452, 63.48, 132.4853)

	obj = ccui.Button:create()
	roots.Panel_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 285, 86))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 623, cc.size(315, 108), cc.p(316.8501, 629.9141), nil, nil, nil, nil, false)
	obj:loadTextureNormal("chongzhi/sclb_an1.png", 0)
	obj:loadTexturePressed("chongzhi/sclb_an.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(159.3501, 48.2165, 704.3529, 575.9141)

	obj = ccui.Button:create()
	roots.Panel_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 285, 86))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 624, cc.size(315, 108), cc.p(629.9113, 630.9153), nil, nil, nil, nil, false)
	obj:loadTextureNormal("chongzhi/bscz_an.png", 0)
	obj:loadTexturePressed("chongzhi/bscz_an1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(472.4113, 47.2152, 391.2917, 576.9153)

	obj = ccui.Button:create()
	roots.Panel_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_3 = obj
	setValue(obj, "Button_3", 625, cc.size(126, 34), cc.p(993.7391, 541.551), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(930.7391, 173.5796, 121.9639, 524.551)

	obj = ccui.Button:create()
	roots.Panel_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_3_0 = obj
	setValue(obj, "Button_3_0", 626, cc.size(126, 34), cc.p(993.2179, 464.6474), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(930.2179, 250.4832, 122.4851, 447.6474)

	obj = ccui.Button:create()
	roots.Panel_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_3_1 = obj
	setValue(obj, "Button_3_1", 627, cc.size(126, 34), cc.p(993.5313, 397.744), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(930.5313, 317.3865, 122.1718, 380.744)

	obj = ccui.Button:create()
	roots.Panel_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_3_2 = obj
	setValue(obj, "Button_3_2", 628, cc.size(126, 34), cc.p(993.3522, 320.7439), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(930.3522, 394.3867, 122.3508, 303.7439)

	obj = ccui.Button:create()
	roots.Panel_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_3_3 = obj
	setValue(obj, "Button_3_3", 629, cc.size(126, 34), cc.p(994.1101, 250.052), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(931.1101, 465.0785, 121.5929, 233.052)

	obj = ccui.Button:create()
	roots.Panel_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_3_4 = obj
	setValue(obj, "Button_3_4", 630, cc.size(126, 34), cc.p(993.2114, 176.8367), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(930.2114, 538.2939, 122.4916, 159.8367)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 632, cc.size(982.2474, 91.317), cc.p(715.5321, 91.1208), nil, nil, nil, nil, false)
	obj:loadTexture("youxi_xia1_03.png", 0)
	bind(obj).setMargin(224.4084, 613.2207, 127.3442, 45.4623)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_9 = obj
	setValue(obj, "Button_9", 633, cc.size(122, 40), cc.p(716.082, 87.7174), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("gerenzhongx/quxiao.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(655.082, 642.2827, 556.918, 67.7174)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"chongzhi/baoshichongzhi_bj.png",
	"Default/Button_Disable.png",
	"chongzhi/sclb_an.png",
	"chongzhi/sclb_an1.png",
	"chongzhi/bscz_an1.png",
	"chongzhi/bscz_an.png",
	"Default/Button_Press.png",
	"vip_goumai/lijigoumai.png",
	"youxi_xia1_03.png",
	"gerenzhongx/quxiao.png",
}

return _M
