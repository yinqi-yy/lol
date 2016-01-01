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
	setValue(obj, "Layer", 831, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_lowerbar = obj
	setValue(obj, "Panel_lowerbar", 832, cc.size(1319.6129, 100.8273), cc.p(662.3427, 56.0139), cc.p(0.4964, 0.4008), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 0, cc.c4b(150, 200, 255, 255), nil, nil, nil)
	bind(obj).setMargin(7.3218, 633.5701, 7.0653, 15.6026)
	roots.Panel_lowerbar_1 = obj

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 47, 51))
	roots.root.Button_daily = obj
	setValue(obj, "Button_daily", 833, cc.size(77, 73), cc.p(1194.4596, 53.895), cc.p(0.5013, 0.5246), nil, nil, nil, false)
	obj:loadTextureNormal("dating/meirilingqu_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1155.8572, 12.2246, 86.7557, 15.6027)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 60))
	roots.root.Button_Competition = obj
	setValue(obj, "Button_Competition", 834, cc.size(75, 82), cc.p(200.5307, 56.1186), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bsph12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(163.0307, 3.7087, 1081.5823, 15.1186)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 46, 57))
	roots.root.Button_SystemNotice = obj
	setValue(obj, "Button_SystemNotice", 835, cc.size(76, 79), cc.p(309.9258, 56.1193), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/youxigonggao_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(271.9258, 5.208, 971.6871, 16.6193)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 54))
	roots.root.Button_VIP = obj
	setValue(obj, "Button_VIP", 836, cc.size(75, 76), cc.p(54.6709, 53.4179), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/vip_1.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(17.1709, 9.4094, 1227.442, 15.4179)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 54, 55))
	roots.root.Button_wealth = obj
	setValue(obj, "Button_wealth", 837, cc.size(84, 77), cc.p(1043.2777, 52.593), cc.p(0.5322, 0.4804), nil, nil, nil, false)
	obj:loadTextureNormal("dating/caifubang_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(998.5766, 8.2246, 237.0364, 15.6027)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_upperbar = obj
	setValue(obj, "Image_upperbar", 853, cc.size(1334, 46), cc.p(667.225, 725.3325), nil, nil, nil, nil, false)
	obj:loadTexture("dating/shang_bj.png", 0)
	bind(obj).setMargin(0.225, 1.6675, -0.225, 702.3325)
	roots.Image_upperbar_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_bank = obj
	setValue(obj, "Image_bank", 854, cc.size(57, 74), cc.p(190.3174, -32.0147), cc.p(0.4185, 0.5675), nil, nil, nil, false)
	obj:loadTexture("dating/baoxianxiang_an12.png", 0)
	bind(obj).setMargin(166.4635, 46.0106, 1110.5365, -74.0106)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_Profile = obj
	setValue(obj, "Button_Profile", 855, cc.size(122, 40), cc.p(83.1921, -29.4099), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/gerenzx_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(22.1921, 55.4099, 1189.8079, -49.4099)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Setting = obj
	setValue(obj, "Button_Setting", 856, cc.size(41, 43), cc.p(1201.5984, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/shezhi12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1181.0984, 3.8834, 111.9016, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Back = obj
	setValue(obj, "Button_Back", 857, cc.size(41, 43), cc.p(1265.7904, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/fanhui12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1245.2904, 3.8834, 47.7096, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_FAQ = obj
	setValue(obj, "Button_FAQ", 858, cc.size(41, 43), cc.p(1131.9803, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bangzbhu1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1111.4803, 3.8834, 181.5197, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Share = obj
	setValue(obj, "Button_Share", 859, cc.size(41, 43), cc.p(1066.943, 23.5887), cc.p(0.4899, 0.5692), nil, nil, nil, false)
	obj:loadTextureNormal("dating/fenx1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1046.8574, 3.8852, 246.1426, -0.8852)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_buy = obj
	setValue(obj, "Button_buy", 860, cc.size(41, 43), cc.p(1000.1219, 26.5582), cc.p(0.5022, 0.6449), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTextureNormal("dating/shangdian12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(979.5305, 4.1745, 313.4695, -1.1745)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_MoneyIcon = obj
	setValue(obj, "Image_MoneyIcon", 861, cc.size(33, 30.4771), cc.p(62.265, 28.97), cc.p(0.3486, 0.7411), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTexture("dating/baoshi_tb.png", 0)
	bind(obj).setMargin(50.7604, 9.1399, 1250.2396, 6.383)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"Default/Button_Disable.png",
	"dating/meirilingqu_an12.png",
	"dating/bsph12.png",
	"dating/youxigonggao_an12.png",
	"Default/Button_Press.png",
	"dating/vip_1.png",
	"dating/caifubang_an12.png",
	"dating/shang_bj.png",
	"dating/baoxianxiang_an12.png",
	"dating/gerenzx_an12.png",
	"dating/shezhi12.png",
	"dating/fanhui12.png",
	"dating/bangzbhu1.png",
	"dating/fenx1.png",
	"dating/shangdian12.png",
	"dating/baoshi_tb.png",
}

return _M
