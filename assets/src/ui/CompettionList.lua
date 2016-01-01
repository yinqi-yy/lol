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
	setValue(obj, "Layer", 231, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 232, cc.size(786.6417, 467.2846), cc.p(717.8871, 358.0243), nil, nil, nil, nil, false)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(324.5662, 158.3334, 222.792, 124.382)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 233, cc.size(631, 318), cc.p(711.4446, 339.6159), nil, nil, nil, nil, false)
	obj:loadTexture("paihangbang/paihangb.png", 0)
	bind(obj).setMargin(395.9446, 251.3841, 307.0554, 180.6159)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 234, cc.size(17, 14), cc.p(1071.3126, 557.7451), cc.p(0.4278, 0.5438), nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1064.0398, 185.8685, 252.9603, 550.1315)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 177, 35))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 235, cc.size(207, 57), cc.p(484.1152, 548.5398), nil, nil, nil, nil, false)
	obj:loadTextureNormal("paihangbang/Daily@2x.png", 0)
	obj:loadTexturePressed("paihangbang/DailyNotInuse@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(380.6152, 172.9602, 746.3848, 520.0398)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 177, 35))
	roots.root.Button_3 = obj
	setValue(obj, "Button_3", 236, cc.size(207, 57), cc.p(699.48, 548.5394), nil, nil, nil, nil, false)
	obj:loadTextureNormal("paihangbang/WeeklyNotinUse@2x.png", 0)
	obj:loadTexturePressed("paihangbang/Weekly@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(595.98, 172.9606, 531.02, 520.0394)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 177, 35))
	roots.root.Button_4 = obj
	setValue(obj, "Button_4", 237, cc.size(207, 57), cc.p(919.4493, 546.7791), nil, nil, nil, nil, false)
	obj:loadTextureNormal("paihangbang/MonthlyNotInUse@2x.png", 0)
	obj:loadTexturePressed("paihangbang/Monthly@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(815.9493, 174.7209, 311.0507, 518.2791)

	obj = ccui.ListView:create()
	roots.Layer_0:addChild(obj)
	roots.root.ListView_1 = obj
	setValue(obj, "ListView_1", 238, cc.size(602.4559, 264.2206), cc.p(701.3207, 319.3677), cc.p(0.4786, 0.5016), nil, nil, nil, nil)
	setBgColor(obj, 1, 0, cc.c4b(150, 150, 255, 255), nil, nil, nil)
	bind(obj).setMargin(412.9914, 298.9443, 318.5527, 186.835)

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
	"paihangbang/paihangb.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"paihangbang/DailyNotInuse@2x.png",
	"paihangbang/Daily@2x.png",
	"paihangbang/Weekly@2x.png",
	"paihangbang/WeeklyNotinUse@2x.png",
	"paihangbang/Monthly@2x.png",
	"paihangbang/MonthlyNotInUse@2x.png",
}

return _M
