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
	setValue(obj, "Layer", 735, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_line8 = obj
	setValue(obj, "Image_line8", 736, cc.size(972, 157), cc.p(639.3884, 326.16), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian6.png", 0)
	bind(obj).setMargin(153.3884, 345.34, 208.6116, 247.66)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_line9 = obj
	setValue(obj, "Image_line9", 737, cc.size(972, 157), cc.p(639.3913, 411.9969), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian5.png", 0)
	bind(obj).setMargin(153.3913, 259.5031, 208.6086, 333.4969)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_line7 = obj
	setValue(obj, "Image_line7", 738, cc.size(972, 104), cc.p(639.3909, 316.0645), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian4.png", 0)
	bind(obj).setMargin(153.3909, 381.9355, 208.6091, 264.0645)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_line5 = obj
	setValue(obj, "Image_line5", 739, cc.size(972, 345), cc.p(639.3909, 374.1307), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian2.png", 0)
	bind(obj).setMargin(153.3909, 203.3693, 208.6091, 201.6307)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_line4 = obj
	setValue(obj, "Image_line4", 740, cc.size(972, 346), cc.p(639.3881, 369.0773), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian1.png", 0)
	bind(obj).setMargin(153.3881, 207.9227, 208.6118, 196.0773)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_line6 = obj
	setValue(obj, "Image_line6", 741, cc.size(972, 105), cc.p(639.3881, 427.1511), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian3.png", 0)
	bind(obj).setMargin(153.3881, 270.3489, 208.6118, 374.6511)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_line1 = obj
	setValue(obj, "Image_line1", 742, cc.size(976, 3), cc.p(645.7056, 366.5563), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian9.png", 0)
	bind(obj).setMargin(157.7056, 381.9437, 200.2944, 365.0563)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_Line3 = obj
	setValue(obj, "Image_Line3", 743, cc.size(976, 3), cc.p(641.3883, 239.0593), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian8.png", 0)
	bind(obj).setMargin(153.3883, 509.4407, 204.6117, 237.5593)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_Line2 = obj
	setValue(obj, "Image_Line2", 744, cc.size(976, 3), cc.p(641.3883, 505.4139), nil, nil, nil, nil, false)
	obj:loadTexture("youxi/xian7.png", 0)
	bind(obj).setMargin(153.3883, 243.0861, 204.6117, 503.9139)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"youxi/xian6.png",
	"youxi/xian5.png",
	"youxi/xian4.png",
	"youxi/xian2.png",
	"youxi/xian1.png",
	"youxi/xian3.png",
	"youxi/xian9.png",
	"youxi/xian8.png",
	"youxi/xian7.png",
}

return _M
