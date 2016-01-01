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
	roots.root.Scene = obj
	setValue(obj, "Scene", 206, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Scene_0 = obj

	obj = ccui.ImageView:create()
	roots.Scene_0:addChild(obj)
	roots.root.Image_LobbyBg = obj
	setValue(obj, "Image_LobbyBg", 227, cc.size(1334, 727), cc.p(667.6188, 343.2351), nil, nil, nil, nil, false)
	obj:loadTexture("bj6.png", 0)
	bind(obj).setMargin(0.6188, 43.2649, -0.6188, -20.2649)
	roots.Image_LobbyBg_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_LobbyBg_1:addChild(obj)
	roots.root.Image_roomInfoBg = obj
	setValue(obj, "Image_roomInfoBg", 228, cc.size(1334, 502), cc.p(667.0439, 364.7429), nil, nil, nil, nil, false)
	obj:loadTexture("fangjian/fangjian_bj.png", 0)
	bind(obj).setMargin(0.0439, 111.2571, -0.0439, 113.7429)
	roots.Image_roomInfoBg_2 = obj

	obj = cc.Sprite:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Sprite_NumberCount = obj
	setValue(obj, "Sprite_NumberCount", 229, cc.size(113, 24), cc.p(965.6843, 396.3531), nil, nil, nil, nil, nil)
	obj:setTexture("fangjian/renshu_1.png")
	bind(obj).setMargin(909.1843, 93.6469, 311.8157, 384.3531)
	roots.Sprite_NumberCount_3 = obj

	obj = cc.Sprite:create()
	roots.Sprite_NumberCount_3:addChild(obj)
	roots.root.Sprite_RoomFull = obj
	setValue(obj, "Sprite_RoomFull", 230, cc.size(113, 24), cc.p(56.005, 11.0163), nil, nil, nil, nil, nil)
	obj:setTexture("fangjian/renshu_4.png")
	bind(obj).setMargin(-0.495, 0.9837, 0.495, -0.9837)

	obj = cc.Sprite:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Sprite_NumberCount = obj
	setValue(obj, "Sprite_NumberCount", 231, cc.size(113, 24), cc.p(965.7332, 343.3323), nil, nil, nil, nil, nil)
	obj:setTexture("fangjian/renshu_3.png")
	bind(obj).setMargin(909.2332, 146.6677, 311.7668, 331.3323)
	roots.Sprite_NumberCount_3 = obj

	obj = cc.Sprite:create()
	roots.Sprite_NumberCount_3:addChild(obj)
	roots.root.Sprite_LessthanHalf = obj
	setValue(obj, "Sprite_LessthanHalf", 232, cc.size(29, 24), cc.p(13.9587, 11.3696), nil, nil, nil, nil, nil)
	obj:setTexture("fangjian/renshu_2.png")
	bind(obj).setMargin(-0.5413, 0.6304, 84.5413, -0.6304)

	obj = ccui.Button:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 166, 30))
	roots.root.Button_Spot = obj
	setValue(obj, "Button_Spot", 233, cc.size(196, 52), cc.p(1209.9893, 221.8681), nil, nil, nil, nil, false)
	obj:loadTextureNormal("fangjian/chazhaokongwei.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1111.9893, 254.1319, 26.0107, 195.8681)

	obj = ccui.Button:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 166, 30))
	roots.root.Button_QuickStart = obj
	setValue(obj, "Button_QuickStart", 234, cc.size(196, 52), cc.p(1210.772, 348.4102), nil, nil, nil, nil, false)
	obj:loadTextureNormal("fangjian/kuaisukaishi.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1112.772, 127.5898, 25.228, 322.4102)

	obj = ccui.Text:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Text_room# = obj
	setValue(obj, "Text_room#", 235, cc.size(38, 26), cc.p(115.9141, 405.2881), nil, nil, nil, nil, nil)
	obj:setString([[001]])
	obj:setFontSize(20)
	bind(obj).setMargin(96.9141, 83.7119, 1199.0859, 392.2881)

	obj = ccui.Text:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Text_AvgReturn = obj
	setValue(obj, "Text_AvgReturn", 236, cc.size(56, 26), cc.p(371.5105, 404.4188), nil, nil, nil, nil, nil)
	obj:setString([[2,567]])
	obj:setFontSize(20)
	bind(obj).setMargin(343.5105, 84.5812, 934.4895, 391.4188)

	obj = ccui.Text:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Text_BiggestWin = obj
	setValue(obj, "Text_BiggestWin", 237, cc.size(80, 26), cc.p(725.4262, 406.9139), cc.p(0.4964, 0.5636), nil, nil, nil, nil)
	obj:setString([[234,567]])
	obj:setFontSize(20)
	bind(obj).setMargin(685.7116, 83.7405, 568.2884, 392.2595)

	obj = ccui.Text:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Text_room#_0 = obj
	setValue(obj, "Text_room#_0", 238, cc.size(38, 26), cc.p(114.985, 353.9232), nil, nil, nil, nil, nil)
	obj:setString([[002]])
	obj:setFontSize(20)
	bind(obj).setMargin(95.985, 135.0768, 1200.015, 340.9232)

	obj = ccui.Text:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Text_AvgReturn_0 = obj
	setValue(obj, "Text_AvgReturn_0", 239, cc.size(57, 26), cc.p(370.6114, 353.8041), nil, nil, nil, nil, nil)
	obj:setString([[1,234]])
	obj:setFontSize(20)
	bind(obj).setMargin(342.1114, 135.1959, 934.8887, 340.8041)

	obj = ccui.Text:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Text_BiggestWin_0 = obj
	setValue(obj, "Text_BiggestWin_0", 240, cc.size(80, 26), cc.p(725.9041, 355.4609), cc.p(0.4964, 0.5636), nil, nil, nil, nil)
	obj:setString([[678,902]])
	obj:setFontSize(20)
	bind(obj).setMargin(686.1895, 135.1936, 567.8105, 340.8064)

	obj = ccui.Text:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Text_BiggestWininLevel1 = obj
	setValue(obj, "Text_BiggestWininLevel1", 241, cc.size(152, 26), cc.p(479.2555, 51.8863), nil, nil, nil, nil, nil)
	obj:setString([[12,345,678,900]])
	obj:setFontSize(20)
	bind(obj).setMargin(403.2555, 437.1137, 778.7445, 38.8863)

	obj = ccui.Text:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Text_TotalNumofPpl = obj
	setValue(obj, "Text_TotalNumofPpl", 242, cc.size(39, 26), cc.p(863.481, 55.7036), nil, nil, nil, nil, nil)
	obj:setString([[234]])
	obj:setFontSize(20)
	bind(obj).setMargin(843.981, 433.2964, 451.019, 42.7036)

	obj = ccui.ImageView:create()
	roots.Image_roomInfoBg_2:addChild(obj)
	roots.root.Image_Level2 = obj
	setValue(obj, "Image_Level2", 243, cc.size(153, 38), cc.p(1219.6611, 521.5032), nil, nil, nil, nil, false)
	obj:loadTexture("fangjian/fm1.png", 0)
	bind(obj).setMargin(1143.1611, -38.5032, 37.8389, 502.5032)

	obj = ccui.Layout:create()
	roots.Image_LobbyBg_1:addChild(obj)
	roots.root.Panel_lowerbar = obj
	setValue(obj, "Panel_lowerbar", 221, cc.size(1319.6129, 100.8273), cc.p(666.0419, 51.2175), cc.p(0.4964, 0.4008), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 0, cc.c4b(150, 200, 255, 255), nil, nil, nil)
	bind(obj).setMargin(10.986, 615.3668, 3.4011, 10.8059)
	roots.Panel_lowerbar_2 = obj

	obj = ccui.Button:create()
	roots.Panel_lowerbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 47, 51))
	roots.root.Button_daily = obj
	setValue(obj, "Button_daily", 222, cc.size(77, 73), cc.p(1194.4596, 53.895), cc.p(0.5013, 0.5246), nil, nil, nil, false)
	obj:loadTextureNormal("dating/meirilingqu_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1155.8595, 12.2281, 86.7534, 15.5992)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 60))
	roots.root.Button_Competition = obj
	setValue(obj, "Button_Competition", 223, cc.size(75, 82), cc.p(200.5307, 56.1186), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bsph12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(163.0307, 3.7087, 1081.5823, 15.1186)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 46, 57))
	roots.root.Button_SystemNotice = obj
	setValue(obj, "Button_SystemNotice", 224, cc.size(76, 79), cc.p(309.9258, 56.1193), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/youxigonggao_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(271.9258, 5.208, 971.6871, 16.6193)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 45, 54))
	roots.root.Button_VIP = obj
	setValue(obj, "Button_VIP", 225, cc.size(75, 76), cc.p(54.6709, 53.4179), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/vip_1.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(17.1709, 9.4094, 1227.442, 15.4179)

	obj = ccui.Button:create()
	roots.Panel_lowerbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 54, 55))
	roots.root.Button_wealth = obj
	setValue(obj, "Button_wealth", 226, cc.size(84, 77), cc.p(1043.2777, 52.593), cc.p(0.5322, 0.4804), nil, nil, nil, false)
	obj:loadTextureNormal("dating/caifubang_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(998.5729, 8.2251, 237.04, 15.6022)

	obj = ccui.ImageView:create()
	roots.Image_LobbyBg_1:addChild(obj)
	roots.root.Image_upperbar = obj
	setValue(obj, "Image_upperbar", 207, cc.size(1334, 46), cc.p(667.2247, 744.3318), nil, nil, nil, nil, false)
	obj:loadTexture("dating/shang_bj.png", 0)
	bind(obj).setMargin(0.2247, -40.3318, -0.2246, 721.3318)
	roots.Image_upperbar_2 = obj

	obj = ccui.ImageView:create()
	roots.Image_upperbar_2:addChild(obj)
	roots.root.Image_bank = obj
	setValue(obj, "Image_bank", 208, cc.size(57, 74), cc.p(190.3174, -32.0147), cc.p(0.4185, 0.5675), nil, nil, nil, false)
	obj:loadTexture("dating/baoxianxiang_an12.png", 0)
	bind(obj).setMargin(166.4629, 46.0097, 1110.5371, -74.0097)

	obj = ccui.Button:create()
	roots.Image_upperbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_Profile = obj
	setValue(obj, "Button_Profile", 209, cc.size(122, 40), cc.p(83.1921, -29.4099), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/gerenzx_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(22.1921, 55.4099, 1189.8079, -49.4099)

	obj = ccui.Button:create()
	roots.Image_upperbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Setting = obj
	setValue(obj, "Button_Setting", 210, cc.size(41, 43), cc.p(1201.5984, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/shezhi12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1181.0984, 3.8834, 111.9016, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Back = obj
	setValue(obj, "Button_Back", 211, cc.size(41, 43), cc.p(1265.7904, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/fanhui12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1245.2904, 3.8834, 47.7096, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_FAQ = obj
	setValue(obj, "Button_FAQ", 212, cc.size(41, 43), cc.p(1131.9803, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bangzbhu1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1111.4803, 3.8834, 181.5197, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Share = obj
	setValue(obj, "Button_Share", 213, cc.size(41, 43), cc.p(1066.943, 23.5887), cc.p(0.4899, 0.5692), nil, nil, nil, false)
	obj:loadTextureNormal("dating/fenx1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1046.8571, 3.8869, 246.1429, -0.8869)

	obj = ccui.Button:create()
	roots.Image_upperbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_buy = obj
	setValue(obj, "Button_buy", 214, cc.size(41, 43), cc.p(1000.1219, 26.5582), cc.p(0.5022, 0.6449), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTextureNormal("dating/shangdian12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(979.5317, 4.1725, 313.4683, -1.1725)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_2:addChild(obj)
	roots.root.Image_MoneyIcon = obj
	setValue(obj, "Image_MoneyIcon", 215, cc.size(33, 30.4771), cc.p(62.265, 28.97), cc.p(0.3486, 0.7411), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTexture("dating/baoshi_tb.png", 0)
	bind(obj).setMargin(50.7612, 9.1395, 1250.2388, 6.3834)

	obj = ccui.Text:create()
	roots.Image_upperbar_2:addChild(obj)
	roots.root.Text_MoneyCarried = obj
	setValue(obj, "Text_MoneyCarried", 216, cc.size(98, 26), cc.p(147.6945, 23.9471), nil, nil, nil, nil, nil)
	obj:setString([[12345678]])
	obj:setFontSize(20)
	bind(obj).setMargin(98.6945, 9.0529, 1137.3055, 10.9471)

	obj = ccui.Text:create()
	roots.Image_upperbar_2:addChild(obj)
	roots.root.Text_ID = obj
	setValue(obj, "Text_ID", 217, cc.size(62, 26), cc.p(367.9602, 24.6771), nil, nil, nil, nil, nil)
	obj:setString([[88888]])
	obj:setFontSize(20)
	bind(obj).setMargin(336.9602, 8.3229, 935.0398, 11.6771)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_2:addChild(obj)
	roots.root.Image_MessageBg = obj
	setValue(obj, "Image_MessageBg", 218, cc.size(351, 40), cc.p(682.7983, -52.9748), cc.p(0.4999, 0.5415), nil, 79, nil, false)
	obj:setScale(2.1911, 1.0904)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(507.3347, 80.6336, 475.6653, -74.6336)

	obj = ccui.Text:create()
	roots.Image_upperbar_2:addChild(obj)
	roots.root.Text_IngameMessage = obj
	setValue(obj, "Text_IngameMessage", 219, cc.size(507, 26), cc.p(627.7129, -52.5462), nil, cc.c4b(255, 255, 0, 255), nil, nil, nil)
	obj:setString([[恭喜王大哈ID99999 在小玛丽中赢得相当于￥700的奖励]])
	obj:setFontSize(20)
	obj:setTextColor(cc.c4b(255, 255, 0, 255))
	bind(obj).setMargin(374.2129, 85.5462, 452.7871, -65.5462)

	obj = ccui.Button:create()
	roots.Image_upperbar_2:addChild(obj)
	obj:setCapInsets(cc.rect(7, 6, 10, 9))
	roots.root.Button_IngameMessage = obj
	setValue(obj, "Button_IngameMessage", 220, cc.size(24, 21), cc.p(276.0958, -54.6474), nil, nil, nil, nil, false)
	obj:loadTextureNormal("image326.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("image333.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(264.0958, 90.1474, 1045.9042, -65.1474)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"bj6.png",
	"fangjian/fangjian_bj.png",
	"fangjian/renshu_1.png",
	"fangjian/renshu_4.png",
	"fangjian/renshu_3.png",
	"fangjian/renshu_2.png",
	"Default/Button_Disable.png",
	"fangjian/chazhaokongwei.png",
	"fangjian/kuaisukaishi.png",
	"fangjian/fm1.png",
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
	"denglu/dl_shuruk.png",
	"image333.png",
	"image326.png",
}

return _M
