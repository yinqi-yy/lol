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
	setValue(obj, "Layer", 312, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 313, cc.size(1334, 750), cc.p(671.381, 375.0895), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/xml_bj.png", 0)
	bind(obj).setMargin(4.381, -0.0895, -4.381, 0.0895)
	roots.Image_1_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 314, cc.size(127, 106), cc.p(671.3718, 658.729), cc.p(0.5203, 0.4207), nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml1_an.png", 0)
	bind(obj).setMargin(605.2968, 29.869, 601.7032, 614.131)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_3 = obj
	setValue(obj, "Image_3", 315, cc.size(124, 80), cc.p(512.6336, 663.717), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml2_an.png", 0)
	bind(obj).setMargin(450.6336, 46.283, 759.3664, 623.717)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_4 = obj
	setValue(obj, "Image_4", 316, cc.size(124, 80), cc.p(357.4137, 664.0129), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml3_an.png", 0)
	bind(obj).setMargin(295.4137, 45.9871, 914.5863, 624.0129)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_5 = obj
	setValue(obj, "Image_5", 317, cc.size(93, 26), cc.p(201.3271, 661.6219), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml9_an.png", 0)
	bind(obj).setMargin(154.8271, 75.3781, 1086.1729, 648.6219)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_7 = obj
	setValue(obj, "Image_7", 318, cc.size(133, 80), cc.p(199.1375, 468.9519), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml5_an.png", 0)
	bind(obj).setMargin(132.6375, 241.0481, 1068.3625, 428.9519)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_8 = obj
	setValue(obj, "Image_8", 319, cc.size(126, 80), cc.p(201.272, 371.2233), cc.p(0.5256, 0.4826), nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml6_an.png", 0)
	bind(obj).setMargin(135.0425, 337.3832, 1072.9575, 332.6168)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_9 = obj
	setValue(obj, "Image_9", 320, cc.size(126, 80), cc.p(518.3776, 83.8303), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml6_an.png", 0)
	bind(obj).setMargin(455.3776, 626.1697, 752.6224, 43.8303)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_6 = obj
	setValue(obj, "Image_6", 321, cc.size(124.7049, 80), cc.p(193.0913, 564.2672), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml4_an.png", 0)
	bind(obj).setMargin(130.7388, 145.7328, 1078.5563, 524.2672)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_11 = obj
	setValue(obj, "Image_11", 322, cc.size(131, 80), cc.p(199.615, 276.1176), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml7_an.png", 0)
	bind(obj).setMargin(134.115, 433.8824, 1068.885, 236.1176)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_12 = obj
	setValue(obj, "Image_12", 323, cc.size(130, 80), cc.p(198.6949, 177.6385), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml8_an.png", 0)
	bind(obj).setMargin(133.6949, 532.3615, 1070.3052, 137.6385)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_13 = obj
	setValue(obj, "Image_13", 324, cc.size(133, 80), cc.p(668.2703, 81.6706), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml5_an.png", 0)
	bind(obj).setMargin(601.7703, 628.3293, 599.2297, 41.6706)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_14 = obj
	setValue(obj, "Image_14", 325, cc.size(124, 80), cc.p(355.4428, 81.8798), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml3_an.png", 0)
	bind(obj).setMargin(293.4428, 628.1202, 916.5572, 41.8798)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_15 = obj
	setValue(obj, "Image_15", 326, cc.size(126, 80), cc.p(1142.6708, 269.5233), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml6_an.png", 0)
	bind(obj).setMargin(1079.6708, 440.4767, 128.3292, 229.5233)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_16 = obj
	setValue(obj, "Image_16", 327, cc.size(93, 26), cc.p(197.0297, 86.9261), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml9_an.png", 0)
	bind(obj).setMargin(150.5297, 650.0739, 1090.4703, 73.9261)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_17 = obj
	setValue(obj, "Image_17", 328, cc.size(124, 80), cc.p(1140.0402, 560.9535), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml2_an.png", 0)
	bind(obj).setMargin(1078.0402, 149.0465, 131.9598, 520.9535)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_18 = obj
	setValue(obj, "Image_18", 329, cc.size(131, 80), cc.p(983.0468, 82.0891), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml7_an.png", 0)
	bind(obj).setMargin(917.5468, 627.9109, 285.4532, 42.0891)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_19 = obj
	setValue(obj, "Image_19", 330, cc.size(129.1848, 80), cc.p(1139.0405, 175.2021), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml4_an.png", 0)
	bind(obj).setMargin(1074.4481, 534.7979, 130.3671, 135.2021)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_20 = obj
	setValue(obj, "Image_20", 331, cc.size(93, 26), cc.p(1145.0854, 77.252), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml9_an.png", 0)
	bind(obj).setMargin(1098.5854, 659.748, 142.4146, 64.252)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_21 = obj
	setValue(obj, "Image_21", 332, cc.size(131, 80), cc.p(1135.4105, 371.1009), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml7_an.png", 0)
	bind(obj).setMargin(1069.9105, 338.8991, 133.0895, 331.1009)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_22 = obj
	setValue(obj, "Image_22", 333, cc.size(93, 26), cc.p(1142.6672, 666.1584), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml9_an.png", 0)
	bind(obj).setMargin(1096.1672, 70.8416, 144.8328, 653.1584)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_23 = obj
	setValue(obj, "Image_23", 334, cc.size(126, 80), cc.p(824.6349, 664.9493), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml6_an.png", 0)
	bind(obj).setMargin(761.6349, 45.0507, 446.3651, 624.9493)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_24 = obj
	setValue(obj, "Image_24", 335, cc.size(133, 80), cc.p(982.2574, 662.5311), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml5_an.png", 0)
	bind(obj).setMargin(915.7574, 47.4689, 285.2426, 622.5311)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_25 = obj
	setValue(obj, "Image_25", 336, cc.size(124, 80), cc.p(1138.412, 464.0044), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml3.png", 0)
	bind(obj).setMargin(1076.412, 245.9956, 133.588, 424.0044)

	obj = ccui.ImageView:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Image_26 = obj
	setValue(obj, "Image_26", 337, cc.size(124, 80), cc.p(825.6338, 80.6707), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml3_an.png", 0)
	bind(obj).setMargin(763.6338, 629.3293, 446.3662, 40.6707)

	obj = ccui.TextAtlas:create()
	roots.Image_1_1:addChild(obj)
	roots.root.AtlasLabel_1 = obj
	setValue(obj, "AtlasLabel_1", 338, cc.size(56, 18), cc.p(703.541, 409.5837), nil, nil, nil, nil, nil)
	obj:setProperty([[5000]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(675.541, 331.4163, 602.459, 400.5837)

	obj = ccui.TextAtlas:create()
	roots.Image_1_1:addChild(obj)
	roots.root.AtlasLabel_2 = obj
	setValue(obj, "AtlasLabel_2", 339, cc.size(28, 18), cc.p(467.9618, 165.3318), cc.p(0.5051, 0.4053), nil, nil, nil, nil)
	obj:setRotationSkewX(1.0632)
	obj:setRotationSkewY(1.0632)
	obj:setProperty([[10]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(453.8197, 573.9632, 852.1803, 158.0368)

	obj = ccui.TextAtlas:create()
	roots.Image_1_1:addChild(obj)
	roots.root.AtlasLabel_3 = obj
	setValue(obj, "AtlasLabel_3", 340, cc.size(112, 18), cc.p(741.6102, 167.8889), nil, nil, nil, nil, nil)
	obj:setProperty([[50000000]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(685.6102, 573.1111, 536.3898, 158.8889)

	obj = ccui.TextAtlas:create()
	roots.Image_1_1:addChild(obj)
	roots.root.AtlasLabel_4 = obj
	setValue(obj, "AtlasLabel_4", 341, cc.size(70, 18), cc.p(971.7622, 167.4369), nil, nil, nil, nil, nil)
	obj:setProperty([[10000]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(936.7622, 573.5631, 327.2378, 158.4369)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 342, cc.size(17, 14), cc.p(1284.8573, 724.1099), nil, nil, nil, nil, false)
	obj:setScale(2.5, 2.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1276.3573, 18.8901, 40.6427, 717.1099)

	obj = ccui.Layout:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Panel_1 = obj
	setValue(obj, "Panel_1", 343, cc.size(162.8942, 127.475), cc.p(312.3876, 208.9959), nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(26, 26, 26, 255), nil, nil, nil)
	bind(obj).setMargin(312.3876, 413.5291, 858.7181, 208.9959)

	obj = ccui.Layout:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Panel_1_1 = obj
	setValue(obj, "Panel_1_1", 344, cc.size(171.9986, 130.8891), cc.p(493.903, 204.4732), nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 207, cc.c4b(26, 26, 26, 255), nil, nil, nil)
	bind(obj).setMargin(493.903, 414.6377, 668.0984, 204.4732)
	roots.Panel_1_1_2 = obj

	obj = ccui.ImageView:create()
	roots.Panel_1_1_2:addChild(obj)
	roots.root.Image_28 = obj
	setValue(obj, "Image_28", 349, cc.size(151.021, 96.129), cc.p(86.9891, 61.8607), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml3.png", 0)
	bind(obj).setMargin(11.4786, 20.9639, 9.499, 13.7962)

	obj = ccui.Layout:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Panel_1_0 = obj
	setValue(obj, "Panel_1_0", 345, cc.size(162.8942, 127.475), cc.p(322.3877, 198.9959), nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(26, 26, 26, 255), nil, nil, nil)
	bind(obj).setMargin(322.3877, 423.5291, 848.7181, 198.9959)
	roots.Panel_1_0_2 = obj

	obj = ccui.ImageView:create()
	roots.Panel_1_0_2:addChild(obj)
	roots.root.Image_30 = obj
	setValue(obj, "Image_30", 346, cc.size(150, 100), cc.p(73.0511, 68.5005), nil, nil, nil, nil, false)
	obj:loadTexture("xiaomali/ml7.png", 0)
	bind(obj).setMargin(-1.9489, 8.9745, 14.843, 18.5005)

	obj = ccui.Layout:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Panel_1_2 = obj
	setValue(obj, "Panel_1_2", 347, cc.size(167.6679, 141.0964), cc.p(761.9683, 263.6711), cc.p(0.4768, 0.446), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(26, 26, 26, 255), nil, nil, nil)
	bind(obj).setMargin(682.0234, 408.1577, 484.3087, 200.7459)

	obj = ccui.Layout:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Panel_1_2_0 = obj
	setValue(obj, "Panel_1_2_0", 348, cc.size(167.6679, 141.0964), cc.p(942.6775, 261.6382), cc.p(0.4768, 0.446), nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(26, 26, 26, 255), nil, nil, nil)
	bind(obj).setMargin(862.7325, 410.1906, 303.5996, 198.713)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"xiaomali/xml_bj.png",
	"xiaomali/ml1_an.png",
	"xiaomali/ml2_an.png",
	"xiaomali/ml3_an.png",
	"xiaomali/ml9_an.png",
	"xiaomali/ml5_an.png",
	"xiaomali/ml6_an.png",
	"xiaomali/ml4_an.png",
	"xiaomali/ml7_an.png",
	"xiaomali/ml8_an.png",
	"xiaomali/ml3.png",
	"Default/TextAtlas.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"xiaomali/ml7.png",
}

return _M