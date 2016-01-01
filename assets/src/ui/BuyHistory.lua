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
	setValue(obj, "Layer", 610, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_BigPopWin = obj
	setValue(obj, "Image_BigPopWin", 99, cc.size(1255, 668), cc.p(672.162, 383.0198), nil, nil, nil, nil, false)
	obj:loadTexture("image613.png", 0)
	bind(obj).setMargin(44.662, 32.9802, 34.338, 49.0198)
	roots.Image_BigPopWin_1 = obj

	obj = ccui.Button:create()
	roots.Image_BigPopWin_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_Close = obj
	setValue(obj, "Button_Close", 100, cc.size(17, 14), cc.p(1221.3777, 643.3601), cc.p(0.5435, 0.5622), nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1212.1382, 18.5107, 25.8618, 635.4893)

	obj = ccui.Button:create()
	roots.Image_BigPopWin_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_BasicInfo = obj
	setValue(obj, "Button_BasicInfo", 101, cc.size(210, 72), cc.p(403.8946, 597.8258), nil, nil, nil, nil, false)
	obj:loadTextureNormal("gerenzhongx/BasicInfoNotInuse@2x.png", 0)
	obj:loadTexturePressed("gerenzhongx/BasicInfo@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(298.8946, 34.1742, 746.1054, 561.8258)

	obj = ccui.Button:create()
	roots.Image_BigPopWin_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_BuyHistory = obj
	setValue(obj, "Button_BuyHistory", 121, cc.size(210, 72), cc.p(936.7045, 599.3879), nil, nil, nil, nil, false)
	obj:loadTextureNormal("gerenzhongx/RechargeHistory@2x.png", 0)
	obj:loadTexturePressed("gerenzhongx/TransferHistoryNotInuse@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(831.7045, 32.6121, 213.2954, 563.3879)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_Record = obj
	setValue(obj, "Image_Record", 122, cc.size(1100, 496), cc.p(680.6803, 340.3398), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/chongzhijilu_bj.png", 0)
	bind(obj).setMargin(130.6803, 161.6602, 103.3197, 92.3398)
	roots.Image_Record_1 = obj

	obj = ccui.ListView:create()
	roots.Image_Record_1:addChild(obj)
	roots.root.ListView_Record = obj
	setValue(obj, "ListView_Record", 123, cc.size(1098.2024, 445.7115), cc.p(565.881, 213.3873), cc.p(0.5132, 0.4727), nil, nil, nil, nil)
	setBgColor(obj, 1, 0, cc.c4b(150, 150, 255, 255), nil, nil, nil)
	bind(obj).setMargin(2.2835, 47.5891, -0.4858, 2.6995)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"image613.png",
	"Default/Button_Disable.png",
	"image200.png",
	"gerenzhongx/BasicInfo@2x.png",
	"gerenzhongx/BasicInfoNotInuse@2x.png",
	"gerenzhongx/TransferHistoryNotInuse@2x.png",
	"gerenzhongx/RechargeHistory@2x.png",
	"gerenzhongx/chongzhijilu_bj.png",
}

return _M
