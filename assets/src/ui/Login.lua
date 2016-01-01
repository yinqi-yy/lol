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
	setValue(obj, "Layer", 3, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 4, cc.size(1334, 750), cc.p(667, 375), nil, nil, nil, nil, false)
	obj:loadTexture("dbj.png", 0)
	roots.Image_bg_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_bg_1:addChild(obj)
	roots.root.Image_bg2 = obj
	setValue(obj, "Image_bg2", 5, cc.size(1094, 544), cc.p(667, 375), nil, nil, nil, nil, false)
	obj:loadTexture("denglu_bj_03.png", 0)
	bind(obj).setMargin(120, 103, 120, 103)
	roots.Image_bg2_2 = obj

	obj = ccui.Button:create()
	roots.Image_bg2_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 156, 41))
	roots.root.Button_Tourist = obj
	setValue(obj, "Button_Tourist", 8, cc.size(186, 63), cc.p(369, 396.7483), nil, nil, nil, nil, false)
	obj:loadTextureNormal("zhmm_03.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(276, 115.7517, 632, 365.2483)

	obj = ccui.Button:create()
	roots.Image_bg2_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 156, 41))
	roots.root.Button_Free = obj
	setValue(obj, "Button_Free", 9, cc.size(186, 63), cc.p(725, 396.7482), nil, nil, nil, nil, false)
	obj:loadTextureNormal("zhmm_05.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(632, 115.7518, 276, 365.2482)

	obj = ccui.Button:create()
	roots.Image_bg2_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 159, 48))
	roots.root.Button_Start = obj
	setValue(obj, "Button_Start", 10, cc.size(189, 70), cc.p(547, 82.6214), nil, nil, nil, nil, false)
	obj:loadTextureNormal("zhmm_20.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(452.5, 426.3786, 452.5, 47.6214)

	obj = ccui.ImageView:create()
	roots.Image_bg2_2:addChild(obj)
	roots.root.Image_acc = obj
	setValue(obj, "Image_acc", 11, cc.size(90, 28), cc.p(329.7814, 280.4198), nil, nil, nil, nil, false)
	obj:loadTexture("zhmm_13.png", 0)
	bind(obj).setMargin(284.7814, 249.5802, 719.2186, 266.4198)
	roots.Image_acc_3 = obj

	obj = ccui.ImageView:create()
	roots.Image_acc_3:addChild(obj)
	roots.root.Image_di = obj
	setValue(obj, "Image_di", 15, cc.size(413, 68), cc.p(345, 14), nil, nil, nil, nil, false)
	obj:loadTexture("zhmm_10.png", 0)
	bind(obj).setMargin(138.5, -20, -461.5, -20)
	roots.Image_di_4 = obj

	obj = ccui.TextField:create()
	roots.Image_di_4:addChild(obj)
	roots.root.TextField = obj
	setValue(obj, "TextField", 13, cc.size(400, 40), cc.p(210, 34), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[请输入账号]])
	obj:setFontSize(36)
	bind(obj).setMargin(10, 14, 3, 14)

	obj = ccui.ImageView:create()
	roots.Image_bg2_2:addChild(obj)
	roots.root.Image_key = obj
	setValue(obj, "Image_key", 16, cc.size(90, 28), cc.p(329.7814, 188.4073), nil, nil, nil, nil, false)
	obj:loadTexture("zhmm_17.png", 0)
	bind(obj).setMargin(284.7814, 341.5927, 719.2186, 174.4073)
	roots.Image_key_3 = obj

	obj = ccui.ImageView:create()
	roots.Image_key_3:addChild(obj)
	roots.root.Image_di = obj
	setValue(obj, "Image_di", 17, cc.size(413, 68), cc.p(345, 14), nil, nil, nil, nil, false)
	obj:loadTexture("zhmm_10.png", 0)
	bind(obj).setMargin(138.5, -20, -461.5, -20)
	roots.Image_di_4 = obj

	obj = ccui.TextField:create()
	roots.Image_di_4:addChild(obj)
	roots.root.TextField = obj
	setValue(obj, "TextField", 18, cc.size(400, 40), cc.p(210, 34), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[请输入密码]])
	obj:setFontSize(36)
	obj:setMaxLengthEnabled(true)
	obj:setMaxLength(16)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(10, 14, 3, 14)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_help = obj
	setValue(obj, "Button_help", 6, cc.size(52, 55), cc.p(1177.8369, 702.5555), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_13.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1151.8369, 19.9445, 130.1631, 675.0555)

	obj = ccui.Button:create()
	roots.Image_bg_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 22, 33))
	roots.root.Button_end = obj
	setValue(obj, "Button_end", 7, cc.size(52, 55), cc.p(1264.5165, 702.5555), nil, nil, nil, nil, false)
	obj:loadTextureNormal("dating_19.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1238.5165, 19.9445, 43.4835, 675.0555)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"dbj.png",
	"denglu_bj_03.png",
	"zhmm_03.png",
	"zhmm_05.png",
	"zhmm_20.png",
	"zhmm_13.png",
	"zhmm_10.png",
	"zhmm_17.png",
	"dating_13.png",
	"dating_19.png",
}

return _M
