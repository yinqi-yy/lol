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
	setValue(obj, "Layer", 558, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_GameRoomBg = obj
	setValue(obj, "Image_GameRoomBg", 575, cc.size(1334, 671), cc.p(668.041, 335.1458), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/youxi_bj1.png", 0)
	bind(obj).setMargin(1.041, 79.3542, -1.041, -0.3542)
	roots.Image_GameRoomBg_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_GameRoomBg_1:addChild(obj)
	roots.root.Image_roomNo. = obj
	setValue(obj, "Image_roomNo.", 576, cc.size(62, 28), cc.p(1137.6458, 693.1521), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/fangjian_mc.png", 0)
	bind(obj).setMargin(1106.6458, -36.1521, 165.3542, 679.1521)

	obj = ccui.Text:create()
	roots.Image_GameRoomBg_1:addChild(obj)
	roots.root.Text_Number = obj
	setValue(obj, "Text_Number", 577, cc.size(49, 34), cc.p(1194.2546, 695.3958), cc.p(0.5145, 0.4653), cc.c4b(214, 158, 0, 255), nil, nil, nil)
	obj:setString([[005]])
	obj:setFontSize(26)
	obj:enableShadow(cc.c4b(127, 127, 127, 255), cc.size(-2, -2), 0)
	obj:setTextColor(cc.c4b(214, 158, 0, 255))
	bind(obj).setMargin(1169.0442, -42.5756, 115.9558, 679.5756)

	obj = ccui.ImageView:create()
	roots.Image_GameRoomBg_1:addChild(obj)
	roots.root.Image_CardFrame = obj
	setValue(obj, "Image_CardFrame", 578, cc.size(928, 399), cc.p(668.4911, 415.6999), nil, nil, nil, nil, false)
	obj:loadTexture("kapiankuang_03.png", 0)
	bind(obj).setMargin(204.4911, 55.8001, 201.5089, 216.1999)
	roots.Image_CardFrame_2 = obj

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card1 = obj
	setValue(obj, "Sprite_card1", 579, cc.size(201, 132), cc.p(91.0453, 331.6186), nil, nil, nil, nil, nil)
	obj:setScale(0.7909, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(-9.4547, 1.3814, 736.4547, 265.6186)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card2 = obj
	setValue(obj, "Sprite_card2", 580, cc.size(201, 132), cc.p(90.6441, 189.726), nil, nil, nil, nil, nil)
	obj:setScale(0.7724, 0.7959)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(-9.8559, 143.274, 736.8559, 123.726)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card3 = obj
	setValue(obj, "Sprite_card3", 581, cc.size(201, 132), cc.p(91.8049, 56.5154), nil, nil, nil, nil, nil)
	obj:setScale(0.7838, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(-8.6951, 276.4846, 735.6951, -9.4846)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card4 = obj
	setValue(obj, "Sprite_card4", 582, cc.size(201, 132), cc.p(281.6025, 331.6186), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(181.1025, 1.3814, 545.8975, 265.6186)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card5 = obj
	setValue(obj, "Sprite_card5", 583, cc.size(201, 132), cc.p(281.3912, 190.4442), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(180.8912, 142.5558, 546.1088, 124.4442)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card6 = obj
	setValue(obj, "Sprite_card6", 584, cc.size(201, 132), cc.p(281.3891, 56.4074), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(180.8891, 276.5926, 546.1109, -9.5926)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card7 = obj
	setValue(obj, "Sprite_card7", 585, cc.size(201, 132), cc.p(470.8074, 330.7037), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(370.3074, 2.2963, 356.6926, 264.7037)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card8 = obj
	setValue(obj, "Sprite_card8", 586, cc.size(201, 132), cc.p(470.8014, 190.0493), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(370.3014, 142.9507, 356.6986, 124.0493)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card9 = obj
	setValue(obj, "Sprite_card9", 587, cc.size(201, 132), cc.p(470.8012, 55.2276), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(370.3012, 277.7724, 356.6988, -10.7724)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card10 = obj
	setValue(obj, "Sprite_card10", 588, cc.size(201, 132), cc.p(662.7795, 330.3331), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(562.2795, 2.6669, 164.7205, 264.3331)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card11 = obj
	setValue(obj, "Sprite_card11", 589, cc.size(201, 132), cc.p(855.3063, 329.7948), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(754.8063, 3.2052, -27.8063, 263.7948)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card12 = obj
	setValue(obj, "Sprite_card12", 590, cc.size(201, 132), cc.p(662.7872, 192.0216), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(562.2872, 140.9784, 164.7128, 126.0216)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card13 = obj
	setValue(obj, "Sprite_card13", 591, cc.size(201, 132), cc.p(662.7795, 55.6194), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(562.2795, 277.3806, 164.7205, -10.3806)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card14 = obj
	setValue(obj, "Sprite_card14", 592, cc.size(201, 132), cc.p(854.8752, 191.2307), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(754.3752, 141.7693, -27.3752, 125.2307)

	obj = cc.Sprite:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Sprite_card15 = obj
	setValue(obj, "Sprite_card15", 593, cc.size(201, 132), cc.p(854.8729, 55.3952), nil, nil, nil, nil, nil)
	obj:setScale(0.7606, 0.7958)
	obj:setTexture("youxi/kp1.png")
	bind(obj).setMargin(754.3729, 277.6048, -27.3729, -10.6048)

	obj = ccui.ImageView:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Image_Line2 = obj
	setValue(obj, "Image_Line2", 594, cc.size(976, 3), cc.p(475.7208, 336.1165), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian7.png", 0)
	bind(obj).setMargin(-12.2792, 61.3835, -35.7208, 334.6165)

	obj = ccui.ImageView:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Image_Line3 = obj
	setValue(obj, "Image_Line3", 595, cc.size(976, 3), cc.p(475.7208, 69.7628), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian8.png", 0)
	bind(obj).setMargin(-12.2792, 327.7372, -35.7208, 68.2628)

	obj = ccui.ImageView:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Image_line1 = obj
	setValue(obj, "Image_line1", 596, cc.size(976, 3), cc.p(480.0378, 197.2586), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian9.png", 0)
	bind(obj).setMargin(-7.9622, 200.2414, -40.0378, 195.7586)

	obj = ccui.ImageView:create()
	roots.Image_CardFrame_2:addChild(obj)
	roots.root.Image_line6 = obj
	setValue(obj, "Image_line6", 597, cc.size(972, 105), cc.p(473.7202, 257.8553), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian3.png", 0)
	bind(obj).setMargin(-12.2798, 88.6447, -31.7202, 205.3553)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_upperbar = obj
	setValue(obj, "Image_upperbar", 603, cc.size(1334, 46), cc.p(667.2247, 744.3318), nil, nil, nil, nil, false)
	obj:loadTexture("dating/shang_bj.png", 0)
	bind(obj).setMargin(0.2247, -17.3318, -0.2246, 721.3318)
	roots.Image_upperbar_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_bank = obj
	setValue(obj, "Image_bank", 604, cc.size(57, 74), cc.p(190.4979, -21.6531), cc.p(0.4881, 0.6434), nil, nil, nil, false)
	obj:loadTexture("dating/baoxianxiang_an12.png", 0)
	bind(obj).setMargin(162.6762, 41.2647, 1114.3239, -69.2647)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_Profile = obj
	setValue(obj, "Button_Profile", 605, cc.size(122, 40), cc.p(83.1921, -29.4099), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/gerenzx_an12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(22.1921, 55.4099, 1189.8079, -49.4099)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Setting = obj
	setValue(obj, "Button_Setting", 606, cc.size(41, 43), cc.p(1201.5984, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/shezhi12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1181.0984, 3.8834, 111.9016, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Back = obj
	setValue(obj, "Button_Back", 607, cc.size(41, 43), cc.p(1265.7904, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/fanhui12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1245.2904, 3.8834, 47.7096, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_FAQ = obj
	setValue(obj, "Button_FAQ", 608, cc.size(41, 43), cc.p(1131.9803, 20.6166), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating/bangzbhu1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1111.4803, 3.8834, 181.5197, -0.8834)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_Share = obj
	setValue(obj, "Button_Share", 609, cc.size(41, 43), cc.p(1066.943, 23.5887), cc.p(0.4899, 0.5692), nil, nil, nil, false)
	obj:loadTextureNormal("dating/fenx1.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1046.8571, 3.8869, 246.1429, -0.8869)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(13, 11, 15, 21))
	roots.root.Button_buy = obj
	setValue(obj, "Button_buy", 610, cc.size(41, 43), cc.p(1000.1219, 26.5582), cc.p(0.5022, 0.6449), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTextureNormal("dating/shangdian12.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(979.5317, 4.1725, 313.4683, -1.1725)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_MoneyIcon = obj
	setValue(obj, "Image_MoneyIcon", 611, cc.size(33, 30.4771), cc.p(62.265, 28.97), cc.p(0.3486, 0.7411), nil, nil, nil, false)
	obj:setScale(1.0028, 1)
	obj:loadTexture("dating/baoshi_tb.png", 0)
	bind(obj).setMargin(50.7612, 9.1395, 1250.2388, 6.3834)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_MoneyCarried = obj
	setValue(obj, "Text_MoneyCarried", 612, cc.size(98, 26), cc.p(147.6945, 23.9471), nil, nil, nil, nil, nil)
	obj:setString([[12345678]])
	obj:setFontSize(20)
	bind(obj).setMargin(98.6945, 9.0529, 1137.3055, 10.9471)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_ID = obj
	setValue(obj, "Text_ID", 613, cc.size(62, 26), cc.p(367.9602, 24.6771), nil, nil, nil, nil, nil)
	obj:setString([[88888]])
	obj:setFontSize(20)
	bind(obj).setMargin(336.9602, 8.3229, 935.0398, 11.6771)

	obj = ccui.ImageView:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Image_MessageBg = obj
	setValue(obj, "Image_MessageBg", 614, cc.size(351, 40), cc.p(694.0069, -23.8304), cc.p(0.4999, 0.5415), nil, 79, nil, false)
	obj:setScale(2.1911, 1.0904)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(518.542, 51.4904, 464.458, -45.4904)

	obj = ccui.Text:create()
	roots.Image_upperbar_1:addChild(obj)
	roots.root.Text_IngameMessage = obj
	setValue(obj, "Text_IngameMessage", 615, cc.size(507, 26), cc.p(623.9014, -25.0923), nil, cc.c4b(255, 255, 0, 255), nil, nil, nil)
	obj:setString([[恭喜王大哈ID99999 在小玛丽中赢得相当于￥700的奖励]])
	obj:setFontSize(20)
	obj:setTextColor(cc.c4b(255, 255, 0, 255))
	bind(obj).setMargin(370.4014, 58.0923, 456.5986, -38.0923)

	obj = ccui.Button:create()
	roots.Image_upperbar_1:addChild(obj)
	obj:setCapInsets(cc.rect(7, 6, 10, 9))
	roots.root.Button_IngameMessage = obj
	setValue(obj, "Button_IngameMessage", 616, cc.size(24, 21), cc.p(275.3341, -27.9559), nil, nil, nil, nil, false)
	obj:loadTextureNormal("image326.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("image333.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(263.3341, 63.4559, 1046.6659, -38.4559)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_IngameLowerBar = obj
	setValue(obj, "Image_IngameLowerBar", 559, cc.size(1333, 197), cc.p(669.0146, 99.9157), nil, nil, 218, nil, false)
	obj:loadTexture("youxi_xia1_03.png", 0)
	bind(obj).setMargin(2.5146, 551.5843, -1.5146, 1.4157)
	roots.Image_IngameLowerBar_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_IngameLowerBar_1:addChild(obj)
	roots.root.Image_TotalLinesBet = obj
	setValue(obj, "Image_TotalLinesBet", 560, cc.size(193, 50), cc.p(217.7004, 129.9063), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/yaxian.png", 0)
	bind(obj).setMargin(121.2004, 42.0937, 1018.7996, 104.9063)
	roots.Image_TotalLinesBet_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_TotalLinesBet_2:addChild(obj)
	roots.root.AtlasLabel_totallinesbeton = obj
	setValue(obj, "AtlasLabel_totallinesbeton", 561, cc.size(14, 18), cc.p(106.9727, 25.2817), cc.p(0.5179, 0.6692), cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[9]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(99.7221, 18.7639, 79.2779, 13.2361)

	obj = ccui.Button:create()
	roots.Image_TotalLinesBet_2:addChild(obj)
	obj:setCapInsets(cc.rect(10, 10, 13, 11))
	roots.root.Button_Up = obj
	setValue(obj, "Button_Up", 562, cc.size(33, 31), cc.p(-48.0443, 28.7967), nil, nil, nil, nil, false)
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
	setValue(obj, "Button_Down", 563, cc.size(33, 31), cc.p(247.4864, 27.4133), cc.p(0.5128, 0.4495), nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("youxi/xia_an5.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(230.564, 5.5212, -70.564, 13.4788)

	obj = ccui.ImageView:create()
	roots.Image_IngameLowerBar_1:addChild(obj)
	roots.root.Image_ToralWinning = obj
	setValue(obj, "Image_ToralWinning", 564, cc.size(230, 40), cc.p(941.8759, 132.6091), cc.p(0.5351, 0.5351), nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTexture("youxi/defen.png", 0)
	bind(obj).setMargin(818.8029, 45.7949, 284.197, 111.2051)
	roots.Image_ToralWinning_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_ToralWinning_2:addChild(obj)
	roots.root.AtlasLabel_winamount = obj
	setValue(obj, "AtlasLabel_winamount", 565, cc.size(14, 18), cc.p(118.1948, 19.3176), nil, cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[0]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(111.1948, 11.6824, 104.8052, 10.3176)

	obj = ccui.ImageView:create()
	roots.Image_IngameLowerBar_1:addChild(obj)
	roots.root.Image_TotalBeting = obj
	setValue(obj, "Image_TotalBeting", 566, cc.size(230, 40), cc.p(627.5697, 130.9944), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTexture("youxi/zongyafen.png", 0)
	bind(obj).setMargin(512.5697, 46.0056, 590.4303, 110.9944)
	roots.Image_TotalBeting_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_TotalBeting_2:addChild(obj)
	roots.root.AtlasLabel_betamount = obj
	setValue(obj, "AtlasLabel_betamount", 567, cc.size(56, 18), cc.p(136.8222, 14.3275), cc.p(0.5527, 0.3322), cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[1800]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(105.871, 13.6521, 68.129, 8.3479)

	obj = ccui.ImageView:create()
	roots.Image_IngameLowerBar_1:addChild(obj)
	roots.root.Image_bettingcredits = obj
	setValue(obj, "Image_bettingcredits", 568, cc.size(193, 50), cc.p(216.8519, 58.7683), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/yaxian.png", 0)
	bind(obj).setMargin(120.3519, 113.2317, 1019.6481, 33.7683)
	roots.Image_bettingcredits_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_bettingcredits_2:addChild(obj)
	roots.root.AtlasLabel_betperline = obj
	setValue(obj, "AtlasLabel_betperline", 569, cc.size(42, 18), cc.p(108.826, 26.7275), nil, cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[200]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(87.826, 14.2725, 63.174, 17.7275)

	obj = ccui.Button:create()
	roots.Image_bettingcredits_2:addChild(obj)
	obj:setCapInsets(cc.rect(10, 10, 13, 11))
	roots.root.Button_Down_0 = obj
	setValue(obj, "Button_Down_0", 570, cc.size(33, 31), cc.p(247.698, 23.5369), cc.p(0.5128, 0.4495), nil, nil, nil, false)
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
	setValue(obj, "Button_Up_0", 571, cc.size(33, 31), cc.p(-47.3374, 23.9195), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("youxi/shang_an5.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(-63.8374, 10.5805, 223.8374, 8.4195)

	obj = ccui.Button:create()
	roots.Image_IngameLowerBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 153, 33))
	roots.root.Button_Allin = obj
	setValue(obj, "Button_Allin", 572, cc.size(183, 55), cc.p(610.8147, 56.3509), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTextureNormal("youxi/zuidayafen.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(519.3147, 113.1491, 630.6853, 28.8509)

	obj = ccui.Button:create()
	roots.Image_IngameLowerBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 153, 33))
	roots.root.Button_AutoPlay = obj
	setValue(obj, "Button_AutoPlay", 573, cc.size(183, 55), cc.p(931.0951, 56.351), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTextureNormal("youxi/zidong.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(839.5951, 113.149, 310.4049, 28.851)

	obj = ccui.Button:create()
	roots.Image_IngameLowerBar_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 110))
	roots.root.Button_Start = obj
	setValue(obj, "Button_Start", 574, cc.size(154, 132), cc.p(1217.3752, 104.118), nil, nil, nil, nil, false)
	obj:loadTextureNormal("youxi/kaishiyouxi_an.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1140.3752, 26.882, 38.6248, 38.118)

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_1 = obj
	setValue(obj, "Panel_1", 622, cc.size(1330.9401, 800.0001), cc.p(625.4351, 383.3289), cc.p(0.4708, 0.482), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 164, cc.c4b(26, 26, 26, 255), nil, nil, nil)
	bind(obj).setMargin(-1.1715, -47.7289, 4.2314, -2.2712)
	roots.Panel_1_1 = obj

	obj = ccui.ImageView:create()
	roots.Panel_1_1:addChild(obj)
	roots.root.Image_28 = obj
	setValue(obj, "Image_28", 625, cc.size(319.2704, 145.4641), cc.p(233.3556, 358.309), nil, nil, nil, nil, false)
	obj:setRotationSkewY(-0.4371)
	obj:setRotationSkewX(-0.4555)
	obj:loadTexture("1_20150728155220.apk_000857.png", 0)
	bind(obj).setMargin(73.7204, 368.9591, 937.9493, 285.5769)

	obj = ccui.ImageView:create()
	roots.Panel_1_1:addChild(obj)
	roots.root.Image_28_0 = obj
	setValue(obj, "Image_28_0", 626, cc.size(319.2704, 145.4641), cc.p(240.5392, 328.4693), nil, nil, nil, nil, false)
	obj:setRotationSkewY(-0.4371)
	obj:setRotationSkewX(-0.4546)
	obj:loadTexture("1_20150728155220.apk_000857.png", 0)
	bind(obj).setMargin(80.904, 398.7988, 930.7657, 255.7372)

	obj = ccui.ImageView:create()
	roots.Panel_1_1:addChild(obj)
	roots.root.Image_28_1 = obj
	setValue(obj, "Image_28_1", 627, cc.size(319.2704, 145.4641), cc.p(371.4805, 306.2159), nil, nil, nil, nil, false)
	obj:setRotationSkewY(-0.4371)
	obj:setRotationSkewX(-0.4546)
	obj:loadTexture("1_20150728155220.apk_000857.png", 0)
	bind(obj).setMargin(211.8453, 421.0522, 799.8243, 233.4839)

	obj = ccui.ImageView:create()
	roots.Panel_1_1:addChild(obj)
	roots.root.Image_27 = obj
	setValue(obj, "Image_27", 624, cc.size(512, 256), cc.p(659.8811, 464.5834), nil, nil, nil, nil, false)
	obj:setScale(2, 2)
	obj:loadTexture("yingle.png", 0)
	bind(obj).setMargin(403.8811, 207.4167, 415.059, 336.5834)

	obj = ccui.Text:create()
	roots.Panel_1_1:addChild(obj)
	roots.root.Text_5 = obj
	setValue(obj, "Text_5", 623, cc.size(598, 100), cc.p(681.5463, 421.1022), nil, cc.c4b(255, 213, 77, 255), nil, nil, nil)
	obj:setString([[     恭喜您获得艾欧里亚全盘奖！
您将同时获得10次小玛丽的游戏机会!]])
	obj:setFontSize(36)
	obj:enableOutline(cc.c4b(226, 94, 94, 255), 0)
	obj:setTextColor(cc.c4b(255, 213, 77, 255))
	bind(obj).setMargin(383.0463, 330.8979, 350.8937, 373.1022)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"youxi/youxi_bj1.png",
	"youxi/fangjian_mc.png",
	"kapiankuang_03.png",
	"youxi/kp1.png",
	"youxi/xian7.png",
	"youxi/xian8.png",
	"youxi/xian9.png",
	"youxi/xian3.png",
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
	"youxi_xia1_03.png",
	"youxi/yaxian.png",
	"Default/TextAtlas.png",
	"youxi/shang_an5.png",
	"youxi/xia_an5.png",
	"youxi/defen.png",
	"youxi/zongyafen.png",
	"youxi/zuidayafen.png",
	"youxi/zidong.png",
	"youxi/kaishiyouxi_an.png",
	"1_20150728155220.apk_000857.png",
	"yingle.png",
}

return _M
