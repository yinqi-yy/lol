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
	setValue(obj, "Layer", 104, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_bg = obj
	setValue(obj, "Panel_bg", 105, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(0, 0, 0, 255), nil, nil, nil)
	roots.Panel_bg_1 = obj

	obj = ccui.ImageView:create()
	roots.Panel_bg_1:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 106, cc.size(491, 396), cc.p(667, 375), nil, nil, nil, nil, false)
	obj:loadTexture("vip_goumai_03.png", 0)
	bind(obj).setMargin(421.5, 177, 421.5, 177)
	roots.Image_bg_2 = obj

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(14, 11, 15, 23))
	roots.root.Button_X = obj
	setValue(obj, "Button_X", 107, cc.size(43, 45), cc.p(457.1545, 368.4589), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(435.6545, 3.0411, 8.3455, 345.9589)

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 82, 22))
	roots.root.Button_ok = obj
	setValue(obj, "Button_ok", 108, cc.size(112, 44), cc.p(243.5, 35.8664), nil, nil, nil, nil, false)
	obj:loadTextureNormal("tanchuang_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(187.5, 336.1336, 187.5, 13.8664)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des = obj
	setValue(obj, "Text_des", 109, cc.size(420, 230), cc.p(243.5, 208.8063), nil, cc.c4b(139, 105, 20, 255), nil, nil, false)
	obj:setString([[抱歉！你还不是VIP，不能参加每日领取。开通VIP可以参加每日领取活动，VIP等级越高每日领取越多，快点购买VIP礼包！]])
	obj:setFontSize(26)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(33.5, 70.1937, 33.5, 93.8063)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"vip_goumai_03.png",
	"vip_goumai_06.png",
	"tanchuang_06.png",
}

return _M
