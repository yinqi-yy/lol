local _L = require("ccext.LuaResHelper")	

local _M = { CCSVER = "2.3.2.3" }

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
	setValue(obj, "Layer", 155, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 156, cc.size(1308, 95), cc.p(667.0001, 704.9695), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("dating_03.png", 0)
	bind(obj).setMargin(13.0001, -2.4695, 13, 657.4695)
	roots.Image_bg_1 = obj

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 157, cc.size(52, 55), cc.p(404.6102, 52.8038), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_07.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(378.6102, 14.6962, 877.3898, 25.3038)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 158, cc.size(52, 55), cc.p(491.6109, 52.8038), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_09.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(465.6109, 14.6962, 790.3891, 25.3038)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_3 = obj
	setValue(obj, "Button_3", 159, cc.size(52, 55), cc.p(855.7034, 52.8036), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_11.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(829.7034, 14.6964, 426.2966, 25.3036)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_4 = obj
	setValue(obj, "Button_4", 160, cc.size(52, 55), cc.p(932.4688, 52.8037), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_13.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(906.4688, 14.6963, 349.5312, 25.3037)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_5 = obj
	setValue(obj, "Button_5", 161, cc.size(52, 55), cc.p(1009.2343, 52.8037), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_15.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(983.2343, 14.6963, 272.7656, 25.3037)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_6 = obj
	setValue(obj, "Button_6", 162, cc.size(52, 55), cc.p(1085.9998, 52.8037), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_17.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1059.9998, 14.6963, 196.0002, 25.3037)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_7 = obj
	setValue(obj, "Button_7", 163, cc.size(52, 55), cc.p(1162.765, 52.8037), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_19.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1136.765, 14.6963, 119.235, 25.3037)

	obj = ccui.ImageView:create()
	roots.Image_bg_1:addChild(obj)
	roots.root.Image_Diamonds = obj
	setValue(obj, "Image_Diamonds", 164, cc.size(32, 23), cc.p(148.6054, 50.9368), nil, nil, nil, nil, false)
	obj:loadTexture("dating_22.png", 0)
	bind(obj).setMargin(132.6054, 32.5632, 1143.3945, 39.4368)

	obj = ccui.TextAtlas:create()
	roots.Image_bg_1:addChild(obj)
	roots.root.AtlasLabel_money = obj
	setValue(obj, "AtlasLabel_money", 165, cc.size(100, 15), cc.p(220.8648, 52.3621), nil, nil, nil, nil, nil)
	obj:setProperty([[9999999999]], "dating_26.png", 10, 15, [[0]])
	bind(obj).setMargin(170.8648, 35.1379, 1037.1353, 44.8621)

	obj = ccui.Text:create()
	roots.Image_bg_1:addChild(obj)
	roots.root.Text_1 = obj
	setValue(obj, "Text_1", 166, cc.size(72, 24), cc.p(658, 57), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[王大哈]])
	obj:setFontSize(24)
	obj:setTextHorizontalAlignment(1)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(628, 28, 620, 47)

	obj = ccui.Text:create()
	roots.Image_bg_1:addChild(obj)
	roots.root.Text_2 = obj
	setValue(obj, "Text_2", 167, cc.size(100, 20), cc.p(658.0001, 33), nil, nil, nil, nil, nil)
	obj:setString([[1234567890]])
	obj:setFontSize(20)
	bind(obj).setMargin(608.0001, 52, 599.9999, 23)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"dating_03.png",
	"dating_07.png",
	"dating_09.png",
	"dating_11.png",
	"dating_13.png",
	"dating_15.png",
	"dating_17.png",
	"dating_19.png",
	"dating_22.png",
	"dating_26.png",
}

return _M
