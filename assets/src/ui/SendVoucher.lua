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
	setValue(obj, "Layer", 115, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.Layout:create()
	roots.Layer_0:addChild(obj)
	roots.root.Panel_bg = obj
	setValue(obj, "Panel_bg", 116, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	obj:setTouchEnabled(true)
	setBgColor(obj, 1, 102, cc.c4b(0, 0, 0, 255), nil, nil, nil)
	roots.Panel_bg_1 = obj

	obj = ccui.ImageView:create()
	roots.Panel_bg_1:addChild(obj)
	roots.root.Image_bg = obj
	setValue(obj, "Image_bg", 117, cc.size(496, 397), cc.p(667, 375), nil, nil, nil, nil, false)
	obj:loadTexture("zengspingz_03.png", 0)
	bind(obj).setMargin(419, 176.5, 419, 176.5)
	roots.Image_bg_2 = obj

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(14, 11, 15, 23))
	roots.root.Button_X = obj
	setValue(obj, "Button_X", 118, cc.size(43, 45), cc.p(457.1545, 368.4589), nil, nil, nil, nil, false)
	obj:loadTextureNormal("vip_goumai_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(435.6545, 3.0411, 8.3455, 345.9589)

	obj = ccui.Button:create()
	roots.Image_bg_2:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 82, 22))
	roots.root.Button_ok = obj
	setValue(obj, "Button_ok", 119, cc.size(112, 44), cc.p(243.5, 35.8664), nil, nil, nil, nil, false)
	obj:loadTextureNormal("tanchuang_06.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(187.5, 336.1336, 187.5, 13.8664)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des1 = obj
	setValue(obj, "Text_des1", 120, cc.size(121, 22), cc.p(119.5403, 323.7787), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[赠送人昵称:]])
	obj:setFontSize(22)
	obj:setTextHorizontalAlignment(2)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(59.0403, 62.2213, 315.9597, 312.7787)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des2 = obj
	setValue(obj, "Text_des2", 121, cc.size(99, 22), cc.p(130.5404, 286.2786), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[赠送人ID:]])
	obj:setFontSize(22)
	obj:setTextHorizontalAlignment(2)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(81.0404, 99.7214, 315.9596, 275.2786)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des3 = obj
	setValue(obj, "Text_des3", 122, cc.size(121, 22), cc.p(119.5403, 248.7787), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[接收人昵称:]])
	obj:setFontSize(22)
	obj:setTextHorizontalAlignment(2)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(59.0403, 137.2213, 315.9597, 237.7787)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des4 = obj
	setValue(obj, "Text_des4", 123, cc.size(99, 22), cc.p(130.5404, 211.2784), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[接收人ID:]])
	obj:setFontSize(22)
	obj:setTextHorizontalAlignment(2)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(81.0404, 174.7216, 315.9596, 200.2784)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des5 = obj
	setValue(obj, "Text_des5", 124, cc.size(99, 22), cc.p(130.5404, 173.7783), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[赠送金额:]])
	obj:setFontSize(22)
	obj:setTextHorizontalAlignment(2)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(81.0404, 212.2217, 315.9596, 162.7783)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des6 = obj
	setValue(obj, "Text_des6", 125, cc.size(77, 22), cc.p(141.5404, 136.2781), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[手续费:]])
	obj:setFontSize(22)
	obj:setTextHorizontalAlignment(2)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(103.0404, 249.7219, 315.9596, 125.2781)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des7 = obj
	setValue(obj, "Text_des7", 126, cc.size(99, 22), cc.p(130.5404, 98.7778), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[赠送日期:]])
	obj:setFontSize(22)
	obj:setTextHorizontalAlignment(2)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(81.0404, 287.2222, 315.9596, 87.7778)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des_1 = obj
	setValue(obj, "Text_des_1", 127, cc.size(33, 22), cc.p(293.3323, 323.5283), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[123]])
	obj:setFontSize(22)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(232.8323, 62.4717, 142.1677, 312.5283)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des_2 = obj
	setValue(obj, "Text_des_2", 128, cc.size(33, 22), cc.p(293.3323, 286.0281), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[123]])
	obj:setFontSize(22)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(243.8323, 99.9719, 153.1677, 275.0281)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des_3 = obj
	setValue(obj, "Text_des_3", 129, cc.size(33, 22), cc.p(293.3323, 248.5283), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[123]])
	obj:setFontSize(22)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(232.8323, 137.4717, 142.1677, 237.5283)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des_4 = obj
	setValue(obj, "Text_des_4", 130, cc.size(33, 22), cc.p(293.3323, 211.0278), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[123]])
	obj:setFontSize(22)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(243.8323, 174.9722, 153.1677, 200.0278)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des_5 = obj
	setValue(obj, "Text_des_5", 131, cc.size(33, 22), cc.p(293.3323, 173.5277), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[123]])
	obj:setFontSize(22)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(243.8323, 212.4723, 153.1677, 162.5277)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des_6 = obj
	setValue(obj, "Text_des_6", 132, cc.size(33, 22), cc.p(293.3322, 136.0275), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[123]])
	obj:setFontSize(22)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(254.8322, 249.9725, 164.1678, 125.0275)

	obj = ccui.Text:create()
	roots.Image_bg_2:addChild(obj)
	roots.root.Text_des_7 = obj
	setValue(obj, "Text_des_7", 133, cc.size(33, 22), cc.p(293.3323, 98.5271), nil, cc.c4b(139, 105, 20, 255), nil, nil, nil)
	obj:setString([[123]])
	obj:setFontSize(22)
	obj:setTextVerticalAlignment(1)
	obj:setTextColor(cc.c4b(139, 105, 20, 255))
	bind(obj).setMargin(243.8323, 287.4728, 153.1677, 87.5271)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"zengspingz_03.png",
	"vip_goumai_06.png",
	"tanchuang_06.png",
}

return _M
