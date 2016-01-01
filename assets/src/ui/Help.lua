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
	setValue(obj, "Layer", 17, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_bg = obj
	setValue(obj, "Panel_bg", 18, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(0, 0, 0, 255), nil, nil, nil)
	roots.Panel_bg_1 = obj

	obj = ccui.ImageView:create()
	roots.Panel_bg_1:addChild(obj)
	roots.root.Image_help = obj
	setValue(obj, "Image_help", 19, cc.size(1334, 750), cc.p(667, 375), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("bangzhu1.png", 0)
	roots.Image_help_2 = obj

	obj = ccui.Button:create()
	roots.Image_help_2:addChild(obj)
	obj:setCapInsets(cc.rect(14, 11, 15, 23))
	roots.root.Button_X = obj
	setValue(obj, "Button_X", 83, cc.size(43, 45), cc.p(1276.46, 626.2185), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1254.96, 101.2815, 36.04, 603.7185)

	obj = ccui.ImageView:create()
	roots.Image_help_2:addChild(obj)
	roots.root.page1 = obj
	setValue(obj, "page1", 84, cc.size(80, 80), cc.p(600.4255, 121.9122), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:setScale(0.54, 0.54)
	obj:loadTexture("1.png", 0)
	bind(obj).setMargin(560.4255, 588.0878, 693.5745, 81.9122)

	obj = ccui.ImageView:create()
	roots.Image_help_2:addChild(obj)
	roots.root.page2 = obj
	setValue(obj, "page2", 85, cc.size(80, 80), cc.p(644.6989, 121.9122), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:setScale(0.54, 0.54)
	obj:loadTexture("1.png", 0)
	bind(obj).setMargin(604.6989, 588.0878, 649.3011, 81.9122)

	obj = ccui.ImageView:create()
	roots.Image_help_2:addChild(obj)
	roots.root.page3 = obj
	setValue(obj, "page3", 86, cc.size(80, 80), cc.p(688.9717, 121.9122), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:setScale(0.54, 0.54)
	obj:loadTexture("1.png", 0)
	bind(obj).setMargin(648.9717, 588.0878, 605.0283, 81.9122)

	obj = ccui.ImageView:create()
	roots.Image_help_2:addChild(obj)
	roots.root.page4 = obj
	setValue(obj, "page4", 87, cc.size(80, 80), cc.p(734.5388, 121.9122), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:setScale(0.54, 0.54)
	obj:loadTexture("1.png", 0)
	bind(obj).setMargin(694.5388, 588.0878, 559.4612, 81.9122)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"bangzhu1.png",
	"vip_goumai_06.png",
	"1.png",
}

return _M
