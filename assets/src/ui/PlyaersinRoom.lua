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
	setValue(obj, "Layer", 492, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_Playerslist = obj
	setValue(obj, "Image_Playerslist", 493, cc.size(586, 355), cc.p(703.0933, 488.4321), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/fangjianrenshu12.png", 0)
	bind(obj).setMargin(410.0933, 84.0679, 337.9067, 310.9321)
	roots.Image_Playerslist_1 = obj

	obj = ccui.Text:create()
	roots.Image_Playerslist_1:addChild(obj)
	roots.root.Text_PlayerName1 = obj
	setValue(obj, "Text_PlayerName1", 577, cc.size(150, 26), cc.p(147.1159, 246.1406), nil, nil, nil, nil, nil)
	obj:setString([[游客387634095]])
	obj:setFontSize(20)
	bind(obj).setMargin(72.1159, 95.8594, 363.8841, 233.1406)

	obj = ccui.Button:create()
	roots.Image_Playerslist_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_22 = obj
	setValue(obj, "Button_22", 579, cc.size(17, 14), cc.p(557.326, 327.6487), cc.p(0.4863, 0.4971), nil, nil, nil, false)
	obj:setScale(1.3, 1.4377)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(549.0589, 20.3107, 19.9411, 320.6893)

	obj = ccui.Text:create()
	roots.Image_Playerslist_1:addChild(obj)
	roots.root.Text_Playerweath1 = obj
	setValue(obj, "Text_Playerweath1", 578, cc.size(147, 26), cc.p(440.0038, 244.8784), nil, nil, nil, nil, nil)
	obj:setString([[293776467294]])
	obj:setFontSize(20)
	bind(obj).setMargin(366.5038, 97.1216, 72.4962, 231.8784)

	obj = ccui.Text:create()
	roots.Image_Playerslist_1:addChild(obj)
	roots.root.Text_PlayerName1_0 = obj
	setValue(obj, "Text_PlayerName1_0", 580, cc.size(162, 26), cc.p(149.7065, 204.4304), nil, nil, nil, nil, nil)
	obj:setString([[游客3876340986]])
	obj:setFontSize(20)
	bind(obj).setMargin(68.7065, 137.5696, 355.2935, 191.4304)

	obj = ccui.Text:create()
	roots.Image_Playerslist_1:addChild(obj)
	roots.root.Text_Playerweath1_0 = obj
	setValue(obj, "Text_Playerweath1_0", 581, cc.size(146, 26), cc.p(439.6712, 205.124), nil, nil, nil, nil, nil)
	obj:setString([[845868738457]])
	obj:setFontSize(20)
	bind(obj).setMargin(366.6712, 136.876, 73.3288, 192.124)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"youxi/fangjianrenshu12.png",
	"Default/Button_Disable.png",
	"image200.png",
}

return _M
