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
	setValue(obj, "Layer", 36, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 37, cc.size(491, 405), cc.p(598, 352), nil, nil, nil, nil, false)
	obj:loadTexture("shezhi/Setting@2x.png", 0)
	bind(obj).setMargin(352.5, 195.5, 490.5, 149.5)

	obj = ccui.CheckBox:create()
	roots.Layer_0:addChild(obj)
	roots.root.CheckBox_1 = obj
	setValue(obj, "CheckBox_1", 39, cc.size(40.681, 39.6996), cc.p(599.0004, 439), nil, nil, nil, nil, nil)
	obj:loadTextureBackGround("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundSelected("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundDisabled("Default/CheckBox_Disable.png", 0)
	obj:loadTextureFrontCross("baoxiangui/dagou.png", 0)
	obj:loadTextureFrontCrossDisabled("Default/CheckBoxNode_Disable.png", 0)
	obj:setSelected(true)
	bind(obj).setMargin(578.6599, 291.1502, 714.6591, 419.1502)

	obj = ccui.CheckBox:create()
	roots.Layer_0:addChild(obj)
	roots.root.CheckBox_1_0 = obj
	setValue(obj, "CheckBox_1_0", 40, cc.size(40.681, 39.6996), cc.p(601.7456, 352.8169), nil, nil, nil, nil, nil)
	obj:loadTextureBackGround("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundSelected("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundDisabled("Default/CheckBox_Disable.png", 0)
	obj:loadTextureFrontCross("baoxiangui/dagou.png", 0)
	obj:loadTextureFrontCrossDisabled("Default/CheckBoxNode_Disable.png", 0)
	obj:setSelected(true)
	bind(obj).setMargin(581.4051, 377.3333, 711.9139, 332.9671)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 41, cc.size(17, 14), cc.p(813.7096, 529.0962), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(805.2096, 213.9038, 511.7904, 522.0962)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"shezhi/Setting@2x.png",
	"baoxiangui/fuxuankuang.png",
	"Default/CheckBox_Disable.png",
	"baoxiangui/dagou.png",
	"Default/CheckBoxNode_Disable.png",
	"Default/Button_Disable.png",
	"image200.png",
}

return _M
