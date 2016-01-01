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
	setValue(obj, "Layer", 29, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_bg = obj
	setValue(obj, "Panel_bg", 30, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(0, 0, 0, 255), nil, nil, nil)
	roots.Panel_bg_1 = obj

	obj = ccui.ImageView:create()
	roots.Panel_bg_1:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 31, cc.size(429, 350), cc.p(667, 375), nil, nil, nil, nil, false)
	obj:loadTexture("tanchuang_03.png", 0)
	bind(obj).setMargin(452.5, 200, 452.5, 200)
	roots.Image_bg_2 = obj

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 82, 22))
	roots.root.Button_ok = obj
	setValue(obj, "Button_ok", 32, cc.size(112, 44), cc.p(114.9353, 35.8664), nil, nil, nil, nil, false)
	obj:loadTextureNormal("tanchuang_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(58.9353, 292.1336, 258.0647, 13.8664)

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 82, 20))
	roots.root.Button_cancel = obj
	setValue(obj, "Button_cancel", 33, cc.size(112, 42), cc.p(313.3405, 35.8663), nil, nil, nil, nil, false)
	obj:loadTextureNormal("qx.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(257.3405, 293.1337, 59.6595, 14.8663)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des = obj
	setValue(obj, "Text_des", 34, cc.size(234, 36), cc.p(215, 188), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[是否返回登陆?]])
	obj:setFontSize(36)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(98, 144, 97, 170)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"tanchuang_03.png",
	"tanchuang_06.png",
	"qx.png",
}

return _M
