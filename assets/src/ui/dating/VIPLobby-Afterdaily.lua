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
	setValue(obj, "Layer", 785, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 801, cc.size(1334, 750), cc.p(666.4734, 375.7466), nil, nil, nil, nil, false)
	obj:loadTexture("dating_bj.png", 0)
	bind(obj).setMargin(-0.5266, -0.7466, 0.5266, 0.7466)
	roots.Image_bg_1 = obj

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 223, 278))
	roots.root.Button_Level1 = obj
	setValue(obj, "Button_Level1", 802, cc.size(253, 300), cc.p(141.8585, 426.3591), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/wwxf1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(15.3585, 173.6409, 1065.6415, 276.3591)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 223, 278))
	roots.root.Button_Level3 = obj
	setValue(obj, "Button_Level3", 803, cc.size(253, 300), cc.p(824.4116, 426.561), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/lssb1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(697.9116, 173.439, 383.0884, 276.561)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 238, 278))
	roots.root.Button_Level4 = obj
	setValue(obj, "Button_Level4", 804, cc.size(268, 300), cc.p(1175.5493, 426.561), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/djzb2.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1041.5493, 173.439, 24.4507, 276.561)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 223, 278))
	roots.root.Button_Level2 = obj
	setValue(obj, "Button_Level2", 805, cc.size(253, 300), cc.p(473.2648, 426.5596), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/zjzd1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(346.7648, 173.4404, 734.2352, 276.5596)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_upperBar = obj
	setValue(obj, "Image_upperBar", 792, cc.size(1334, 46), cc.p(666.7601, 733.5908), nil, nil, nil, nil, false)
	obj:loadTexture("dating/shang_bj.png", 0)
	bind(obj).setMargin(-0.2399, -6.5908, 0.2399, 710.5908)
	roots.Image_upperBar_1 = obj

	obj = ccui.Button:create()
	roots.Image_upperBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_buy = obj
	setValue(obj, "Button_buy", 793, cc.size(41, 43), cc.p(977.2844, 28.4976), cc.p(0.5022, 0.6449), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTextureNormal("dating/shangdian12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(956.6929, 2.2351, 336.3071, 0.7649)

	obj = ccui.ImageView:create()
	roots.Image_upperBar_1:addChild(obj)
	roots.root.Image_MoneyIcon = obj
	setValue(obj, "Image_MoneyIcon", 794, cc.size(33, 29), cc.p(64.4218, 28.0983), cc.p(0.6082, 0.6533), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTexture("dating/baoshi_tb.png", 0)
	bind(obj).setMargin(44.3504, 7.8468, 1256.6495, 9.1532)

	obj = ccui.Button:create()
	roots.Image_upperBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Share = obj
	setValue(obj, "Button_Share", 795, cc.size(41, 43), cc.p(1044.1061, 25.5364), cc.p(0.4899, 0.5692), nil, nil, nil, false)
	obj:loadTextureNormal("dating/fenx1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1024.0205, 1.9376, 268.9795, 1.0624)

	obj = ccui.Button:create()
	roots.Image_upperBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_FAQ = obj
	setValue(obj, "Button_FAQ", 796, cc.size(41, 43), cc.p(1109.1421, 22.5624), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bangzbhu1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1088.6421, 1.9376, 204.3579, 1.0624)

	obj = ccui.Button:create()
	roots.Image_upperBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Back = obj
	setValue(obj, "Button_Back", 797, cc.size(41, 43), cc.p(1242.9402, 22.5624), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/fanhui12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1222.4402, 1.9376, 70.5598, 1.0624)

	obj = ccui.Button:create()
	roots.Image_upperBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Setting = obj
	setValue(obj, "Button_Setting", 798, cc.size(41, 43), cc.p(1178.7494, 22.5624), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/shezhi12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1158.2494, 1.9376, 134.7506, 1.0624)

	obj = ccui.Button:create()
	roots.Image_upperBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_Profile = obj
	setValue(obj, "Button_Profile", 799, cc.size(122, 40), cc.p(60.3604, -27.467), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/gerenzx_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(-0.6396, 53.467, 1212.6395, -47.467)

	obj = ccui.ImageView:create()
	roots.Image_upperBar_1:addChild(obj)
	roots.root.Image_bank = obj
	setValue(obj, "Image_bank", 800, cc.size(57, 74), cc.p(167.4861, -30.0727), cc.p(0.4185, 0.5675), nil, nil, nil, false)
	obj:loadTexture("dating/baoxianxiang_an12.png", 0)
	bind(obj).setMargin(143.6322, 44.0686, 1133.3678, -72.0686)

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_lowerbar = obj
	setValue(obj, "Panel_lowerbar", 786, cc.size(1319.6129, 100.8273), cc.p(662.3427, 56.0139), cc.p(0.4964, 0.4008), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 0, cc.c4b(150, 200, 255, 255), nil, nil, nil)
	bind(obj).setMargin(7.3218, 633.5701, 7.0653, 15.6026)
	roots.Panel_lowerbar_1 = obj

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 47, 51))
	roots.root.Button_daily = obj
	setValue(obj, "Button_daily", 787, cc.size(77, 73), cc.p(1194.4596, 53.895), cc.p(0.5013, 0.5246), nil, nil, nil, false)
	obj:loadTextureNormal("dating/meirilingqu_an121.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1155.8572, 12.2246, 86.7557, 15.6027)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 60))
	roots.root.Button_Competition = obj
	setValue(obj, "Button_Competition", 788, cc.size(75, 82), cc.p(200.5307, 56.1186), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bsph12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(163.0307, 3.7087, 1081.5823, 15.1186)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 46, 57))
	roots.root.Button_SystemNotice = obj
	setValue(obj, "Button_SystemNotice", 789, cc.size(76, 79), cc.p(309.9258, 56.1193), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/youxigonggao_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(271.9258, 5.208, 971.6871, 16.6193)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 54))
	roots.root.Button_VIP = obj
	setValue(obj, "Button_VIP", 790, cc.size(75, 76), cc.p(54.6709, 53.4179), nil, nil, nil, nil, false)
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
	setValue(obj, "Button_wealth", 791, cc.size(84, 77), cc.p(1043.2777, 52.593), cc.p(0.5322, 0.4804), nil, nil, nil, false)
	obj:loadTextureNormal("dating/caifubang_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(998.5766, 8.2246, 237.0364, 15.6027)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"dating_bj.png",
	"Default/Button_Disable.png",
	"dating/wwxf1.png",
	"dating/lssb1.png",
	"dating/djzb2.png",
	"dating/zjzd1.png",
	"dating/shang_bj.png",
	"dating/shangdian12.png",
	"dating/baoshi_tb.png",
	"dating/fenx1.png",
	"dating/bangzbhu1.png",
	"dating/fanhui12.png",
	"dating/shezhi12.png",
	"dating/gerenzx_an12.png",
	"dating/baoxianxiang_an12.png",
	"dating/meirilingqu_an121.png",
	"dating/bsph12.png",
	"dating/youxigonggao_an12.png",
	"Default/Button_Press.png",
	"dating/vip_1.png",
	"dating/caifubang_an12.png",
}

return _M
