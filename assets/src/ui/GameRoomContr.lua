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
	setValue(obj, "Layer", 509, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_upperbar = obj
	setValue(obj, "Image_upperbar", 510, cc.size(1334, 46), cc.p(667.2229, 725.4448), nil, nil, nil, nil, false)
	obj:loadTexture("dating/shang_bj.png", 0)
	bind(obj).setMargin(0.2229, 1.5552, -0.2229, 702.4448)
	roots.Image_upperbar_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_bank = obj
	setValue(obj, "Image_bank", 511, cc.size(57, 74), cc.p(190.4979, -21.6531), cc.p(0.4881, 0.6434), nil, nil, nil, false)
	obj:loadTexture("dating/baoxianxiang_an12.png", 0)
	bind(obj).setMargin(162.6762, 41.2647, 1114.3239, -69.2647)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_Profile = obj
	setValue(obj, "Button_Profile", 512, cc.size(122, 40), cc.p(83.1921, -29.4099), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/gerenzx_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(22.1921, 55.4099, 1189.8079, -49.4099)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Setting = obj
	setValue(obj, "Button_Setting", 513, cc.size(41, 43), cc.p(1201.5984, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/shezhi12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1181.0984, 3.8834, 111.9016, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Back = obj
	setValue(obj, "Button_Back", 514, cc.size(41, 43), cc.p(1265.7904, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/fanhui12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1245.2904, 3.8834, 47.7096, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_FAQ = obj
	setValue(obj, "Button_FAQ", 515, cc.size(41, 43), cc.p(1131.9803, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bangzbhu1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1111.4803, 3.8834, 181.5197, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Share = obj
	setValue(obj, "Button_Share", 516, cc.size(41, 43), cc.p(1066.943, 23.5887), cc.p(0.4899, 0.5692), nil, nil, nil, false)
	obj:loadTextureNormal("dating/fenx1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1046.8571, 3.8869, 246.1429, -0.8869)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_buy = obj
	setValue(obj, "Button_buy", 517, cc.size(41, 43), cc.p(1000.1219, 26.5582), cc.p(0.5022, 0.6449), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTextureNormal("dating/shangdian12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(979.5317, 4.1725, 313.4683, -1.1725)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_MoneyIcon = obj
	setValue(obj, "Image_MoneyIcon", 518, cc.size(33, 30.4771), cc.p(62.265, 28.97), cc.p(0.3486, 0.7411), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTexture("dating/baoshi_tb.png", 0)
	bind(obj).setMargin(50.7612, 9.1395, 1250.2388, 6.3834)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_MoneyCarried = obj
	setValue(obj, "Text_MoneyCarried", 519, cc.size(98, 26), cc.p(147.6945, 23.9471), nil, nil, nil, nil, nil)
	obj:setString([[12345678]])
	obj:setFontSize(20)
	bind(obj).setMargin(98.6945, 9.0529, 1137.3055, 10.9471)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_ID = obj
	setValue(obj, "Text_ID", 520, cc.size(62, 26), cc.p(367.9602, 24.6771), nil, nil, nil, nil, nil)
	obj:setString([[88888]])
	obj:setFontSize(20)
	bind(obj).setMargin(336.9602, 8.3229, 935.0398, 11.6771)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_MessageBg = obj
	setValue(obj, "Image_MessageBg", 521, cc.size(351, 40), cc.p(694.0069, -23.8304), cc.p(0.4999, 0.5415), nil, 79, nil, false)
	obj:setScale(2.1911, 1.0904)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(518.542, 51.4904, 464.458, -45.4904)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_IngameMessage = obj
	setValue(obj, "Text_IngameMessage", 522, cc.size(507, 26), cc.p(623.9014, -25.0923), nil, cc.c4b(255, 255, 0, 255), nil, nil, nil)
	obj:setString([[恭喜王大哈ID99999 在小玛丽中赢得相当于￥700的奖励]])
	obj:setFontSize(20)
	obj:setTextColor(cc.c4b(255, 255, 0, 255))
	bind(obj).setMargin(370.4014, 58.0923, 456.5986, -38.0923)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(7, 6, 10, 9))
	roots.root.Button_IngameMessage = obj
	setValue(obj, "Button_IngameMessage", 523, cc.size(24, 21), cc.p(275.3341, -27.9559), nil, nil, nil, nil, false)
	obj:loadTextureNormal("image326.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("image333.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(263.3341, 63.4559, 1046.6659, -38.4559)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_Number = obj
	setValue(obj, "Text_Number", 525, cc.size(49, 34), cc.p(1196.4858, -26.4237), cc.p(0.5145, 0.4653), cc.c4b(214, 158, 0, 255), nil, nil, nil)
	obj:setString([[005]])
	obj:setFontSize(26)
	obj:enableShadow(cc.c4b(127, 127, 127, 255), cc.size(-2, -2), 0)
	obj:setTextColor(cc.c4b(214, 158, 0, 255))
	bind(obj).setMargin(1171.2754, 54.2439, 113.7246, -42.2439)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_roomNo = obj
	setValue(obj, "Image_roomNo", 526, cc.size(62, 28), cc.p(1139.8943, -28.6793), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/fangjian_mc.png", 0)
	bind(obj).setMargin(1108.8943, 60.6793, 163.1057, -42.6793)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_ingamelowerbar = obj
	setValue(obj, "Image_ingamelowerbar", 527, cc.size(1333, 197), cc.p(669.2845, 97.635), nil, nil, nil, nil, false)
	obj:loadTexture("youxi_xia1_03.png", 0)
	bind(obj).setMargin(2.7845, 553.865, -1.7844, -0.865)
	roots.Image_ingamelowerbar_1 = obj

	obj = ccui.Button:create()
	roots.Image_ingamelowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 110))
	roots.root.Button_Start = obj
	setValue(obj, "Button_Start", 528, cc.size(154, 132), cc.p(1211.7434, 113.506), nil, nil, nil, nil, false)
	obj:loadTextureNormal("youxi/kaishiyouxi_an.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1134.7434, 17.494, 44.2566, 47.506)

	obj = ccui.Button:create()
	roots.Image_ingamelowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 153, 33))
	roots.root.Button_AutoPlay = obj
	setValue(obj, "Button_AutoPlay", 529, cc.size(183, 55), cc.p(925.4624, 65.7392), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTextureNormal("youxi/zidong.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(833.9624, 103.7608, 316.0376, 38.2392)

	obj = ccui.Button:create()
	roots.Image_ingamelowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 153, 33))
	roots.root.Button_Allin = obj
	setValue(obj, "Button_Allin", 530, cc.size(183, 55), cc.p(605.1821, 65.739), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTextureNormal("youxi/zuidayafen.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(513.6821, 103.761, 636.3179, 38.239)

	obj = ccui.ImageView:create()
	roots.Image_ingamelowerbar_1:addChild(obj)
	roots.root.Image_bettingcredits = obj
	setValue(obj, "Image_bettingcredits", 531, cc.size(193, 50), cc.p(211.2194, 68.1561), nil, nil, nil, nil, false)
	obj:loadTexture("yf.png", 0)
	bind(obj).setMargin(114.7194, 103.8439, 1025.2805, 43.1561)
	roots.Image_bettingcredits_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_bettingcredits_2:addChild(obj)
	roots.root.AtlasLabel_betperline = obj
	setValue(obj, "AtlasLabel_betperline", 532, cc.size(42, 18), cc.p(108.826, 26.7275), nil, cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[200]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(87.826, 14.2725, 63.174, 17.7275)

	obj = ccui.Button:create()
	roots.Image_bettingcredits_2:addChild(obj)
	obj:setCapInsets(cc.rect(10, 10, 13, 11))
	roots.root.Button_Down_0 = obj
	setValue(obj, "Button_Down_0", 533, cc.size(33, 31), cc.p(247.698, 23.5369), cc.p(0.5128, 0.4495), nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("youxi/xia_an5.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(230.7756, 9.3976, -70.7756, 9.6024)

	obj = ccui.Button:create()
	roots.Image_bettingcredits_2:addChild(obj)
	obj:setCapInsets(cc.rect(10, 10, 13, 11))
	roots.root.Button_Up_0 = obj
	setValue(obj, "Button_Up_0", 534, cc.size(33, 31), cc.p(-47.3374, 23.9195), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("youxi/shang_an5.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(-63.8374, 10.5805, 223.8374, 8.4195)

	obj = ccui.ImageView:create()
	roots.Image_ingamelowerbar_1:addChild(obj)
	roots.root.Image_TotalBeting = obj
	setValue(obj, "Image_TotalBeting", 535, cc.size(230, 40), cc.p(621.9366, 140.3822), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTexture("youxi/zongyafen.png", 0)
	bind(obj).setMargin(506.9366, 36.6178, 596.0634, 120.3822)
	roots.Image_TotalBeting_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_TotalBeting_2:addChild(obj)
	roots.root.AtlasLabel_betamount = obj
	setValue(obj, "AtlasLabel_betamount", 536, cc.size(56, 18), cc.p(136.8222, 14.3275), cc.p(0.5527, 0.3322), cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[1800]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(105.871, 13.6521, 68.129, 8.3479)

	obj = ccui.ImageView:create()
	roots.Image_ingamelowerbar_1:addChild(obj)
	roots.root.Image_ToralWinning = obj
	setValue(obj, "Image_ToralWinning", 537, cc.size(230, 40), cc.p(936.2433, 141.9973), cc.p(0.5351, 0.5351), nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTexture("youxi/defen.png", 0)
	bind(obj).setMargin(813.1703, 36.4067, 289.8297, 120.5933)
	roots.Image_ToralWinning_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_ToralWinning_2:addChild(obj)
	roots.root.AtlasLabel_winamount = obj
	setValue(obj, "AtlasLabel_winamount", 538, cc.size(14, 18), cc.p(118.1948, 19.3176), nil, cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[0]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(111.1948, 11.6824, 104.8052, 10.3176)

	obj = ccui.ImageView:create()
	roots.Image_ingamelowerbar_1:addChild(obj)
	roots.root.Image_TotalLinesBet = obj
	setValue(obj, "Image_TotalLinesBet", 539, cc.size(193, 50), cc.p(212.0682, 139.294), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/yaxian.png", 0)
	bind(obj).setMargin(115.5682, 32.706, 1024.4318, 114.294)
	roots.Image_TotalLinesBet_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_TotalLinesBet_2:addChild(obj)
	roots.root.AtlasLabel_totallinesbeton = obj
	setValue(obj, "AtlasLabel_totallinesbeton", 540, cc.size(14, 18), cc.p(106.9727, 25.2817), cc.p(0.5179, 0.6692), cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[9]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(99.7221, 18.7639, 79.2779, 13.2361)

	obj = ccui.Button:create()
	roots.Image_TotalLinesBet_2:addChild(obj)
	obj:setCapInsets(cc.rect(10, 10, 13, 11))
	roots.root.Button_Up = obj
	setValue(obj, "Button_Up", 541, cc.size(33, 31), cc.p(-48.0443, 28.7967), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("youxi/shang_an5.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(-64.5443, 5.7033, 224.5443, 13.2967)

	obj = ccui.Button:create()
	roots.Image_TotalLinesBet_2:addChild(obj)
	obj:setCapInsets(cc.rect(10, 10, 13, 11))
	roots.root.Button_Down = obj
	setValue(obj, "Button_Down", 542, cc.size(33, 31), cc.p(247.4864, 27.4133), cc.p(0.5128, 0.4495), nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("youxi/xia_an5.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(230.564, 5.5212, -70.564, 13.4788)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"dating/shang_bj.png",
	"dating/baoxianxiang_an12.png",
	"Default/Button_Disable.png",
	"dating/gerenzx_an12.png",
	"dating/shezhi12.png",
	"dating/fanhui12.png",
	"dating/bangzbhu1.png",
	"dating/fenx1.png",
	"dating/shangdian12.png",
	"dating/baoshi_tb.png",
	"denglu/dl_shuruk.png",
	"image333.png",
	"Default/Button_Press.png",
	"image326.png",
	"youxi/fangjian_mc.png",
	"youxi_xia1_03.png",
	"youxi/kaishiyouxi_an.png",
	"youxi/zidong.png",
	"youxi/zuidayafen.png",
	"yf.png",
	"Default/TextAtlas.png",
	"youxi/xia_an5.png",
	"youxi/shang_an5.png",
	"youxi/zongyafen.png",
	"youxi/defen.png",
	"youxi/yaxian.png",
}

return _M
