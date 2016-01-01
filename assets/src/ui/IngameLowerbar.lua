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
	setValue(obj, "Scene", 320, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Scene_0 = obj

	obj = ccui.ImageView:create()
	roots.Scene_0:addChild(obj)
	roots.root.Image_10 = obj
	setValue(obj, "Image_10", 415, cc.size(1333, 197), cc.p(670.2846, 97.635), nil, nil, nil, nil, false)
	obj:loadTexture("youxi_xia1_03.png", 0)
	bind(obj).setMargin(3.7846, 553.865, -2.7847, -0.865)
	roots.Image_10_1 = obj

	obj = ccui.Button:create()
	roots.Image_10_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 110))
	roots.root.Button_Start = obj
	setValue(obj, "Button_Start", 400, cc.size(154, 132), cc.p(1211.7434, 113.506), nil, nil, nil, nil, false)
	obj:loadTextureNormal("youxi/kaishiyouxi_an.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1134.7434, 17.494, 44.2566, 47.506)

	obj = ccui.Button:create()
	roots.Image_10_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 153, 33))
	roots.root.Button_AutoPlay = obj
	setValue(obj, "Button_AutoPlay", 401, cc.size(183, 55), cc.p(925.4624, 65.7392), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTextureNormal("youxi/zidong.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(833.9624, 103.7608, 316.0376, 38.2392)

	obj = ccui.Button:create()
	roots.Image_10_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 153, 33))
	roots.root.Button_Allin = obj
	setValue(obj, "Button_Allin", 402, cc.size(183, 55), cc.p(605.1821, 65.739), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTextureNormal("youxi/zuidayafen.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(513.6821, 103.761, 636.3179, 38.239)

	obj = ccui.ImageView:create()
	roots.Image_10_1:addChild(obj)
	roots.root.Image_bettingcredits = obj
	setValue(obj, "Image_bettingcredits", 403, cc.size(193, 50), cc.p(211.2194, 68.1561), nil, nil, nil, nil, false)
	obj:loadTexture("yf.png", 0)
	bind(obj).setMargin(114.7194, 103.8439, 1025.2805, 43.1561)
	roots.Image_bettingcredits_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_bettingcredits_2:addChild(obj)
	roots.root.AtlasLabel_betperline = obj
	setValue(obj, "AtlasLabel_betperline", 404, cc.size(42, 18), cc.p(108.826, 26.7275), nil, cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[200]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(87.826, 14.2725, 63.174, 17.7275)

	obj = ccui.Button:create()
	roots.Image_bettingcredits_2:addChild(obj)
	obj:setCapInsets(cc.rect(10, 10, 13, 11))
	roots.root.Button_Down_0 = obj
	setValue(obj, "Button_Down_0", 405, cc.size(33, 31), cc.p(247.698, 23.5369), cc.p(0.5128, 0.4495), nil, nil, nil, false)
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
	setValue(obj, "Button_Up_0", 406, cc.size(33, 31), cc.p(-47.3374, 23.9195), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("youxi/shang_an5.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(-63.8374, 10.5805, 223.8374, 8.4195)

	obj = ccui.ImageView:create()
	roots.Image_10_1:addChild(obj)
	roots.root.Image_TotalBeting = obj
	setValue(obj, "Image_TotalBeting", 407, cc.size(230, 40), cc.p(621.9366, 140.3822), nil, nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTexture("youxi/zongyafen.png", 0)
	bind(obj).setMargin(506.9366, 36.6178, 596.0634, 120.3822)
	roots.Image_TotalBeting_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_TotalBeting_2:addChild(obj)
	roots.root.AtlasLabel_betamount = obj
	setValue(obj, "AtlasLabel_betamount", 408, cc.size(56, 18), cc.p(136.8222, 14.3275), cc.p(0.5527, 0.3322), cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[1800]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(105.871, 13.6521, 68.129, 8.3479)

	obj = ccui.ImageView:create()
	roots.Image_10_1:addChild(obj)
	roots.root.Image_ToralWinning = obj
	setValue(obj, "Image_ToralWinning", 409, cc.size(230, 40), cc.p(936.2433, 141.9973), cc.p(0.5351, 0.5351), nil, nil, nil, false)
	obj:setScale(1.3, 1.3)
	obj:loadTexture("youxi/defen.png", 0)
	bind(obj).setMargin(813.1703, 36.4067, 289.8297, 120.5933)
	roots.Image_ToralWinning_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_ToralWinning_2:addChild(obj)
	roots.root.AtlasLabel_winamount = obj
	setValue(obj, "AtlasLabel_winamount", 410, cc.size(14, 18), cc.p(118.1948, 19.3176), nil, cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[0]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(111.1948, 11.6824, 104.8052, 10.3176)

	obj = ccui.ImageView:create()
	roots.Image_10_1:addChild(obj)
	roots.root.Image_TotalLinesBet = obj
	setValue(obj, "Image_TotalLinesBet", 411, cc.size(193, 50), cc.p(212.0682, 139.294), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/yaxian.png", 0)
	bind(obj).setMargin(115.5682, 32.706, 1024.4318, 114.294)
	roots.Image_TotalLinesBet_2 = obj

	obj = ccui.TextAtlas:create()
	roots.Image_TotalLinesBet_2:addChild(obj)
	roots.root.AtlasLabel_totallinesbeton = obj
	setValue(obj, "AtlasLabel_totallinesbeton", 412, cc.size(14, 18), cc.p(106.9727, 25.2817), cc.p(0.5179, 0.6692), cc.c4b(255, 165, 0, 255), nil, nil, nil)
	obj:setProperty([[9]], "Default/TextAtlas.png", 14, 18, [[.]])
	bind(obj).setMargin(99.7221, 18.7639, 79.2779, 13.2361)

	obj = ccui.Button:create()
	roots.Image_TotalLinesBet_2:addChild(obj)
	obj:setCapInsets(cc.rect(10, 10, 13, 11))
	roots.root.Button_Up = obj
	setValue(obj, "Button_Up", 413, cc.size(33, 31), cc.p(-48.0443, 28.7967), nil, nil, nil, nil, false)
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
	setValue(obj, "Button_Down", 414, cc.size(33, 31), cc.p(247.4864, 27.4133), cc.p(0.5128, 0.4495), nil, nil, nil, false)
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
	"youxi_xia1_03.png",
	"Default/Button_Disable.png",
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
