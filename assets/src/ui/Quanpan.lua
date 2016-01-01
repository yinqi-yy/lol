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
	setValue(obj, "Layer", 75, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_bg = obj
	setValue(obj, "Panel_bg", 76, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(0, 0, 0, 255), nil, nil, nil)
	roots.Panel_bg_1 = obj

	obj = ccui.ImageView:create()
	roots.Panel_bg_1:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 77, cc.size(982, 476), cc.p(666.9999, 373.3562), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("bjz_03.png", 0)
	bind(obj).setMargin(175.9999, 138.6438, 176.0001, 135.3562)
	roots.Image_bg_2 = obj

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(14, 11, 15, 23))
	roots.root.Button_X = obj
	setValue(obj, "Button_X", 78, cc.size(43, 45), cc.p(944.2896, 418.0902), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(922.7896, 35.4098, 16.2104, 395.5902)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page1 = obj
	setValue(obj, "page1", 79, cc.size(123, 85), cc.p(470.4745, 378.8768), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("quanpanj_03.png", 0)
	bind(obj).setMargin(408.9745, 54.6232, 450.0255, 336.3768)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page2 = obj
	setValue(obj, "page2", 80, cc.size(123, 85), cc.p(313.4747, 328.1176), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("quanpanj_06.png", 0)
	bind(obj).setMargin(251.9747, 105.3824, 607.0253, 285.6176)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page3 = obj
	setValue(obj, "page3", 81, cc.size(123, 85), cc.p(622.2018, 332.3045), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("quanpanj_09.png", 0)
	bind(obj).setMargin(560.7018, 101.1955, 298.2982, 289.8045)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page4 = obj
	setValue(obj, "page4", 82, cc.size(123, 85), cc.p(157.475, 263.8773), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:setScale(1.01, 1.01)
	obj:loadTexture("quanpanj_13.png", 0)
	bind(obj).setMargin(95.975, 169.6227, 763.025, 221.3773)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page5 = obj
	setValue(obj, "page5", 83, cc.size(123, 85), cc.p(783.4744, 263.8809), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("quanpanj_16.png", 0)
	bind(obj).setMargin(721.9744, 169.6191, 137.0256, 221.3809)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page6 = obj
	setValue(obj, "page6", 84, cc.size(123, 85), cc.p(313.4747, 198.3921), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("quanpanj_20.png", 0)
	bind(obj).setMargin(251.9747, 235.1079, 607.0253, 155.8921)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page7 = obj
	setValue(obj, "page7", 85, cc.size(123, 85), cc.p(623.6319, 198.3921), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("quanpanj_21.png", 0)
	bind(obj).setMargin(562.1319, 235.1079, 296.8681, 155.8921)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page8 = obj
	setValue(obj, "page8", 86, cc.size(123, 85), cc.p(470.4745, 148.877), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("quanpanj_25.png", 0)
	bind(obj).setMargin(408.9745, 284.623, 450.0255, 106.377)

	obj = ccui.ImageView:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.page_des = obj
	setValue(obj, "page_des", 87, cc.size(139, 37), cc.p(106.4325, 84.9943), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("quanpanj_31.png", 0)
	bind(obj).setMargin(36.9325, 372.5057, 806.0675, 66.4943)

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(14, 11, 101, 26))
	roots.root.Button_open = obj
	setValue(obj, "Button_open", 88, cc.size(129, 48), cc.p(470.4746, 55.6748), nil, nil, nil, nil, false)
	obj:loadTextureNormal("quanpanj_35.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(405.9746, 396.3252, 447.0254, 31.6748)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"bjz_03.png",
	"vip_goumai_06.png",
	"quanpanj_03.png",
	"quanpanj_06.png",
	"quanpanj_09.png",
	"quanpanj_13.png",
	"quanpanj_16.png",
	"quanpanj_20.png",
	"quanpanj_21.png",
	"quanpanj_25.png",
	"quanpanj_31.png",
	"quanpanj_35.png",
}

return _M
