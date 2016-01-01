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
	setValue(obj, "Layer", 38, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_Frame = obj
	setValue(obj, "Image_Frame", 39, cc.size(586, 355), cc.p(651.7876, 361.5679), nil, nil, nil, nil, false)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(358.7876, 210.9321, 389.2124, 184.0679)
	roots.Image_Frame_1 = obj

	obj = ccui.Button:create()
	roots.Image_Frame_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_close = obj
	setValue(obj, "Button_close", 40, cc.size(18.9625, 15.9625), cc.p(556.0553, 327.6866), nil, nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(546.574, 19.3321, 20.4634, 319.7054)

	obj = ccui.ImageView:create()
	roots.Image_Frame_1:addChild(obj)
	roots.root.Image_title = obj
	setValue(obj, "Image_title", 41, cc.size(122, 34), cc.p(282.3684, 324.3719), nil, nil, nil, nil, false)
	obj:loadTexture("vip_shuoming/shuomiang_bt.png", 0)
	bind(obj).setMargin(221.3684, 13.6281, 242.6316, 307.3719)

	obj = ccui.Text:create()
	roots.Image_Frame_1:addChild(obj)
	roots.root.Text_warning = obj
	setValue(obj, "Text_warning", 42, cc.size(457, 26), cc.p(296.1779, 243.3767), nil, nil, nil, nil, nil)
	obj:setString([[您已经领取过今日的VIP礼包，请明天登陆继续领取]])
	obj:setFontSize(20)
	bind(obj).setMargin(67.6779, 98.6233, 61.3221, 230.3767)

	obj = ccui.ImageView:create()
	roots.Image_Frame_1:addChild(obj)
	roots.root.Image_3 = obj
	setValue(obj, "Image_3", 43, cc.size(81, 84), cc.p(293.4154, 168.8268), nil, nil, nil, nil, false)
	obj:loadTexture("4.png", 0)
	bind(obj).setMargin(252.9154, 144.1732, 252.0846, 126.8268)

	obj = ccui.Button:create()
	roots.Image_Frame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 10, 70, 13))
	roots.root.Button_ok = obj
	setValue(obj, "Button_ok", 44, cc.size(100, 33), cc.p(298.0151, 84.1508), nil, nil, nil, nil, false)
	obj:setScale(1.2, 1.2)
	obj:loadTextureNormal("qd.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(248.0151, 254.3492, 237.9849, 67.6508)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"image69.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"vip_shuoming/shuomiang_bt.png",
	"4.png",
	"qd.png",
}

return _M
