local _L = require("ccext.LuaResHelper")	

local _M = { CCSVER = "2.3.1.1" }

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
	setValue(obj, "Layer", 270, cc.size(640, 1136), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.tf_nickname = obj
	setValue(obj, "tf_nickname", 281, cc.size(300, 50), cc.p(319.6144, 343.9359), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[请输入用户名]])
	obj:setFontSize(36)
	bind(obj).setMargin(169.6144, 767.0641, 170.3856, 318.9359)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	ccspc:addSpriteFrames("common/Common_1.plist")
	obj:setCapInsets(cc.rect(15, 11, 214, 52))
	roots.root.btn_login = obj
	setValue(obj, "btn_login", 282, cc.size(244, 74), cc.p(314.9785, 243.61), nil, nil, nil, nil, false)
	obj:loadTextureNormal("btn_green3.png", 1)
	obj:loadTexturePressed("btn_green3.png", 1)
	obj:loadTextureDisabled("Btn_grey.png", 1)
	obj:setTitleText([[Login]])
	obj:setTitleColor(cc.c3b(229, 229, 229))
	obj:setTitleFontSize(36)
	bind(obj).setMargin(192.9785, 855.39, 203.0215, 206.61)

	obj = cc.Node:create()
	roots.Layer_0:addChild(obj)
	roots.root.nd_up = obj
	setValue(obj, "nd_up", 39, nil, cc.p(0, 525.3942), nil, nil, nil, nil, nil)
	bind(obj).setMargin(nil, 610.6058, 640, 525.3942).setPosition(nil, 0.4625, nil, true)
	roots.nd_up_1 = obj

	obj = ccui.ListView:create()
	roots.nd_up_1:addChild(obj)
	roots.root.lv_serverList = obj
	setValue(obj, "lv_serverList", 283, cc.size(400, 400), cc.p(122.1871, -22.3612), nil, nil, nil, nil, nil)
	setBgColor(obj, 1, 102, cc.c4b(150, 150, 255, 255), nil, nil, nil)
	obj:setBounceEnabled(true)
	bind(obj).setMargin(122.1871, -377.6388, -522.1871, -22.3612)

	obj = ccui.Text:create()
	roots.nd_up_1:addChild(obj)
	roots.root.Text_2 = obj
	setValue(obj, "Text_2", 54, cc.size(252, 36), cc.p(309.6493, 419.5891), nil, nil, nil, nil, nil)
	obj:setString([[选择服务器列表]])
	obj:setFontSize(36)
	bind(obj).setMargin(183.6493, -437.5891, -435.6493, 401.5891)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"common/Common_1.plist",
}

return _M
