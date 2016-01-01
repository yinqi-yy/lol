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
	setValue(obj, "Layer", 862, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 863, cc.size(1334, 502), cc.p(669.0436, 376.1873), nil, nil, nil, nil, false)
	obj:loadTexture("fangjian/fangjian_bj.png", 0)
	bind(obj).setMargin(2.0436, 122.8127, -2.0436, 125.1873)
	roots.Image_1_1 = obj

	obj = cc.Sprite:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Sprite_NumberCount = obj
	setValue(obj, "Sprite_NumberCount", 880, cc.size(113, 24), cc.p(966.9435, 406.4498), nil, nil, nil, nil, nil)
	obj:setTexture("fangjian/renshu_1.png")
	bind(obj).setMargin(910.4435, 83.5502, 310.5565, 394.4498)
	roots.Sprite_NumberCount_2 = obj

	obj = cc.Sprite:create()
	roots.Sprite_NumberCount_2:addChild(obj)
	roots.root.Sprite_RoomFull = obj
	setValue(obj, "Sprite_RoomFull", 883, cc.size(113, 24), cc.p(56.005, 11.0163), nil, nil, nil, nil, nil)
	obj:setTexture("fangjian/renshu_4.png")
	bind(obj).setMargin(-0.495, 0.9837, 0.495, -0.9837)

	obj = cc.Sprite:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Sprite_NumberCount = obj
	setValue(obj, "Sprite_NumberCount", 881, cc.size(113, 24), cc.p(966.9927, 353.4302), nil, nil, nil, nil, nil)
	obj:setTexture("fangjian/renshu_3.png")
	bind(obj).setMargin(910.4927, 136.5698, 310.5073, 341.4302)
	roots.Sprite_NumberCount_2 = obj

	obj = cc.Sprite:create()
	roots.Sprite_NumberCount_2:addChild(obj)
	roots.root.Sprite_LessthanHalf = obj
	setValue(obj, "Sprite_LessthanHalf", 882, cc.size(29, 24), cc.p(13.9587, 11.3696), nil, nil, nil, nil, nil)
	obj:setTexture("fangjian/renshu_2.png")
	bind(obj).setMargin(-0.5413, 0.6304, 84.5413, -0.6304)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_upperbar = obj
	setValue(obj, "Image_upperbar", 864, cc.size(1334, 46), cc.p(667.225, 725.3325), nil, nil, nil, nil, false)
	obj:loadTexture("dating/shang_bj.png", 0)
	bind(obj).setMargin(0.225, 1.6675, -0.225, 702.3325)
	roots.Image_upperbar_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_bank = obj
	setValue(obj, "Image_bank", 865, cc.size(57, 74), cc.p(190.3174, -32.0147), cc.p(0.4185, 0.5675), nil, nil, nil, false)
	obj:loadTexture("dating/baoxianxiang_an12.png", 0)
	bind(obj).setMargin(166.4629, 46.0097, 1110.5371, -74.0097)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_Profile = obj
	setValue(obj, "Button_Profile", 866, cc.size(122, 40), cc.p(83.1921, -29.4099), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/gerenzx_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(22.1921, 55.4099, 1189.8079, -49.4099)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Setting = obj
	setValue(obj, "Button_Setting", 867, cc.size(41, 43), cc.p(1201.5984, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/shezhi12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1181.0984, 3.8834, 111.9016, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Back = obj
	setValue(obj, "Button_Back", 868, cc.size(41, 43), cc.p(1265.7904, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/fanhui12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1245.2904, 3.8834, 47.7096, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_FAQ = obj
	setValue(obj, "Button_FAQ", 869, cc.size(41, 43), cc.p(1131.9803, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bangzbhu1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1111.4803, 3.8834, 181.5197, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Share = obj
	setValue(obj, "Button_Share", 870, cc.size(41, 43), cc.p(1066.943, 23.5887), cc.p(0.4899, 0.5692), nil, nil, nil, false)
	obj:loadTextureNormal("dating/fenx1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1046.8571, 3.8869, 246.1429, -0.8869)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_buy = obj
	setValue(obj, "Button_buy", 871, cc.size(41, 43), cc.p(1000.1219, 26.5582), cc.p(0.5022, 0.6449), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTextureNormal("dating/shangdian12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(979.5317, 4.1725, 313.4683, -1.1725)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_MoneyIcon = obj
	setValue(obj, "Image_MoneyIcon", 872, cc.size(33, 30.4771), cc.p(62.265, 28.97), cc.p(0.3486, 0.7411), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTexture("dating/baoshi_tb.png", 0)
	bind(obj).setMargin(50.7612, 9.1395, 1250.2388, 6.3834)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_MoneyCarried = obj
	setValue(obj, "Text_MoneyCarried", 40, cc.size(98, 26), cc.p(147.6945, 23.9471), nil, nil, nil, nil, nil)
	obj:setString([[12345678]])
	obj:setFontSize(20)
	bind(obj).setMargin(98.6945, 9.0529, 1137.3055, 10.9471)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_ID = obj
	setValue(obj, "Text_ID", 41, cc.size(62, 26), cc.p(367.9602, 24.6771), nil, nil, nil, nil, nil)
	obj:setString([[88888]])
	obj:setFontSize(20)
	bind(obj).setMargin(336.9602, 8.3229, 935.0398, 11.6771)

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_lowerbar = obj
	setValue(obj, "Panel_lowerbar", 873, cc.size(1319.6129, 100.8273), cc.p(662.3427, 56.0139), cc.p(0.4964, 0.4008), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 0, cc.c4b(150, 200, 255, 255), nil, nil, nil)
	bind(obj).setMargin(7.2869, 633.5704, 7.1002, 15.6023)
	roots.Panel_lowerbar_1 = obj

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 47, 51))
	roots.root.Button_daily = obj
	setValue(obj, "Button_daily", 874, cc.size(77, 73), cc.p(1194.4596, 53.895), cc.p(0.5013, 0.5246), nil, nil, nil, false)
	obj:loadTextureNormal("dating/meirilingqu_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1155.8595, 12.2281, 86.7534, 15.5992)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 60))
	roots.root.Button_Competition = obj
	setValue(obj, "Button_Competition", 875, cc.size(75, 82), cc.p(200.5307, 56.1186), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bsph12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(163.0307, 3.7087, 1081.5823, 15.1186)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 46, 57))
	roots.root.Button_SystemNotice = obj
	setValue(obj, "Button_SystemNotice", 876, cc.size(76, 79), cc.p(309.9258, 56.1193), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/youxigonggao_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(271.9258, 5.208, 971.6871, 16.6193)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 54))
	roots.root.Button_VIP = obj
	setValue(obj, "Button_VIP", 877, cc.size(75, 76), cc.p(54.6709, 53.4179), nil, nil, nil, nil, false)
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
	setValue(obj, "Button_wealth", 878, cc.size(84, 77), cc.p(1043.2777, 52.593), cc.p(0.5322, 0.4804), nil, nil, nil, false)
	obj:loadTextureNormal("dating/caifubang_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(998.5729, 8.2251, 237.04, 15.6022)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 36, cc.size(153, 38), cc.p(668.4634, 663.3519), nil, nil, nil, nil, false)
	obj:loadTexture("fangjian/fm4.png", 0)
	bind(obj).setMargin(591.9634, 67.6481, 589.0366, 644.3519)
	roots.Image_2_1 = obj

	obj = ccui.Button:create()
	roots.Image_2_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 166, 30))
	roots.root.Button_Spot = obj
	setValue(obj, "Button_Spot", 35, cc.size(196, 52), cc.p(620.0726, -277.9048), nil, nil, nil, nil, false)
	obj:loadTextureNormal("fangjian/chazhaokongwei.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(522.0726, 289.9048, -565.0726, -303.9048)

	obj = ccui.Button:create()
	roots.Image_2_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 166, 30))
	roots.root.Button_QuickStart = obj
	setValue(obj, "Button_QuickStart", 879, cc.size(196, 52), cc.p(620.8511, -151.3646), nil, nil, nil, nil, false)
	obj:loadTextureNormal("fangjian/kuaisukaishi.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(522.8511, 163.3646, -565.8511, -177.3646)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_room# = obj
	setValue(obj, "Text_room#", 37, cc.size(38, 26), cc.p(119.5933, 531.4744), nil, nil, nil, nil, nil)
	obj:setString([[001]])
	obj:setFontSize(20)
	bind(obj).setMargin(100.5933, 205.5256, 1195.4067, 518.4744)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_AvgReturn = obj
	setValue(obj, "Text_AvgReturn", 38, cc.size(56, 26), cc.p(375.187, 530.6044), nil, nil, nil, nil, nil)
	obj:setString([[2,567]])
	obj:setFontSize(20)
	bind(obj).setMargin(347.187, 206.3956, 930.813, 517.6044)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_BiggestWin = obj
	setValue(obj, "Text_BiggestWin", 39, cc.size(80, 26), cc.p(729.1028, 533.0988), cc.p(0.4964, 0.5636), nil, nil, nil, nil)
	obj:setString([[234,567]])
	obj:setFontSize(20)
	bind(obj).setMargin(689.3882, 205.5557, 564.6118, 518.4443)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_room#_0 = obj
	setValue(obj, "Text_room#_0", 42, cc.size(38, 26), cc.p(118.6641, 480.1104), nil, nil, nil, nil, nil)
	obj:setString([[002]])
	obj:setFontSize(20)
	bind(obj).setMargin(99.6641, 256.8896, 1196.3359, 467.1104)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_AvgReturn_0 = obj
	setValue(obj, "Text_AvgReturn_0", 43, cc.size(57, 26), cc.p(374.2869, 479.9919), nil, nil, nil, nil, nil)
	obj:setString([[1,234]])
	obj:setFontSize(20)
	bind(obj).setMargin(345.7869, 257.0081, 931.2131, 466.9919)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_BiggestWin_0 = obj
	setValue(obj, "Text_BiggestWin_0", 44, cc.size(80, 26), cc.p(729.5804, 481.6465), cc.p(0.4964, 0.5636), nil, nil, nil, nil)
	obj:setString([[678,902]])
	obj:setFontSize(20)
	bind(obj).setMargin(689.8658, 257.008, 564.1342, 466.992)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_BiggestWininLevel1 = obj
	setValue(obj, "Text_BiggestWininLevel1", 45, cc.size(152, 26), cc.p(476.621, 180.5973), nil, nil, nil, nil, nil)
	obj:setString([[12,345,678,900]])
	obj:setFontSize(20)
	bind(obj).setMargin(400.621, 556.4027, 781.379, 167.5973)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_TotalNumofPpl = obj
	setValue(obj, "Text_TotalNumofPpl", 46, cc.size(39, 26), cc.p(860.8387, 184.4147), nil, nil, nil, nil, nil)
	obj:setString([[234]])
	obj:setFontSize(20)
	bind(obj).setMargin(841.3387, 552.5853, 453.6613, 171.4147)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"fangjian/fangjian_bj.png",
	"fangjian/renshu_1.png",
	"fangjian/renshu_4.png",
	"fangjian/renshu_3.png",
	"fangjian/renshu_2.png",
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
	"dating/meirilingqu_an12.png",
	"dating/bsph12.png",
	"dating/youxigonggao_an12.png",
	"Default/Button_Press.png",
	"dating/vip_1.png",
	"dating/caifubang_an12.png",
	"fangjian/fm4.png",
	"fangjian/chazhaokongwei.png",
	"fangjian/kuaisukaishi.png",
}

return _M
