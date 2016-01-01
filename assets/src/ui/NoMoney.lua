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
	setValue(obj, "Layer", 189, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 190, cc.size(586, 355), cc.p(659.0726, 399.7652), nil, nil, nil, nil, false)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(366.0726, 172.7348, 381.9274, 222.2652)
	roots.Image_1_1 = obj

	obj = ccui.Text:create()
	roots.Image_1_1:addChild(obj)
	roots.root.Text_1 = obj
	setValue(obj, "Text_1", 191, cc.size(421, 40), cc.p(308.4135, 210.3549), cc.p(0.5316, 0.2403), nil, nil, nil, nil)
	obj:setString([[    抱 歉，您 的 宝 石 不 够 了！]])
	obj:setFontSize(30)
	bind(obj).setMargin(84.6099, 114.2571, 80.3901, 200.7429)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 96, 12))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 192, cc.size(126, 34), cc.p(308.7979, 98.5758), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("vip_goumai/lijigoumai.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(245.7979, 239.4242, 214.2021, 81.5758)

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 193, cc.size(17, 14), cc.p(539.1693, 327.3923), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(530.6693, 20.6077, 38.3307, 320.3923)

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
	"vip_goumai/lijigoumai.png",
	"Default/Button_Press.png",
	"image200.png",
}

return _M
