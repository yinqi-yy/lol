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
	setValue(obj, "Layer", 634, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_1 = obj
	setValue(obj, "Image_1", 635, cc.size(667, 559), cc.p(692.1825, 365.799), nil, nil, nil, nil, false)
	obj:loadTexture("baoxiangui/pingtiao1.png", 0)
	bind(obj).setMargin(358.6825, 104.701, 308.3175, 86.299)
	roots.Image_1_1 = obj

	obj = ccui.Button:create()
	roots.Image_1_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_1 = obj
	setValue(obj, "Button_1", 636, cc.size(17, 14), cc.p(996.9657, 620.4287), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(988.4657, -68.4287, -338.4657, 613.4287)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 637, cc.size(380, 40), cc.p(787.3557, 557.4363), nil, cc.c4b(174, 174, 193, 255), nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(597.3557, 172.5637, 356.6443, 537.4363)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2_0 = obj
	setValue(obj, "Image_2_0", 638, cc.size(380, 40), cc.p(730.6749, 420.2222), nil, cc.c4b(174, 174, 193, 255), nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(540.6749, 309.7778, 413.3251, 400.2222)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2_1 = obj
	setValue(obj, "Image_2_1", 639, cc.size(380, 40), cc.p(787.3557, 467.0129), nil, cc.c4b(174, 174, 193, 255), nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(597.3557, 262.9871, 356.6443, 447.0129)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2_2 = obj
	setValue(obj, "Image_2_2", 640, cc.size(380, 40), cc.p(787.3557, 512.2257), nil, cc.c4b(174, 174, 193, 255), nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(597.3557, 217.7743, 356.6443, 492.2257)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2_3 = obj
	setValue(obj, "Image_2_3", 641, cc.size(380, 40), cc.p(787.3557, 377.2381), nil, cc.c4b(174, 174, 193, 255), nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(597.3557, 352.7619, 356.6443, 357.2381)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2_4 = obj
	setValue(obj, "Image_2_4", 642, cc.size(380, 40), cc.p(787.3557, 329.9575), nil, cc.c4b(174, 174, 193, 255), nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(597.3557, 400.0425, 356.6443, 309.9575)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2_5 = obj
	setValue(obj, "Image_2_5", 643, cc.size(380, 40), cc.p(787.3557, 284.9639), nil, cc.c4b(174, 174, 193, 255), nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(597.3557, 445.0361, 356.6443, 264.9639)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_2_6 = obj
	setValue(obj, "Image_2_6", 644, cc.size(380, 40), cc.p(787.3622, 241.1106), nil, cc.c4b(174, 174, 193, 255), nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(597.3622, 488.8894, 356.6378, 221.1106)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_2 = obj
	setValue(obj, "Button_2", 645, cc.size(17, 14), cc.p(995.7379, 618.5972), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(987.2379, 124.4028, 329.7621, 611.5972)

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.TextField_1 = obj
	setValue(obj, "TextField_1", 646, cc.size(328.7795, 27.6262), cc.p(758.9285, 561.8624), nil, cc.c4b(163, 255, 0, 255), nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[王大哈]])
	obj:setFontSize(20)
	bind(obj).setMargin(594.5388, 174.3245, 410.6817, 548.0493)

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.TextField_1_0 = obj
	setValue(obj, "TextField_1_0", 647, cc.size(328.7795, 27.6262), cc.p(758.9276, 511.181), nil, cc.c4b(176, 255, 0, 255), nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[999999]])
	obj:setFontSize(20)
	bind(obj).setMargin(594.5378, 225.0059, 410.6826, 497.3679)

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.TextField_1_1 = obj
	setValue(obj, "TextField_1_1", 648, cc.size(328.7795, 27.6262), cc.p(758.9285, 464.1887), nil, cc.c4b(198, 255, 0, 255), nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[穷困潦倒]])
	obj:setFontSize(20)
	bind(obj).setMargin(594.5388, 271.9982, 410.6817, 450.3756)

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.TextField_1_2 = obj
	setValue(obj, "TextField_1_2", 649, cc.size(328.7795, 27.6262), cc.p(759.7076, 418.6255), nil, cc.c4b(170, 255, 0, 255), nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[34645643768]])
	obj:setFontSize(20)
	bind(obj).setMargin(595.3178, 317.5614, 409.9026, 404.8124)

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.TextField_1_3 = obj
	setValue(obj, "TextField_1_3", 650, cc.size(328.7795, 27.6262), cc.p(758.9276, 373.6358), nil, cc.c4b(202, 255, 0, 255), nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[2000000]])
	obj:setFontSize(20)
	bind(obj).setMargin(594.5378, 362.5511, 410.6826, 359.8227)

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.TextField_1_4 = obj
	setValue(obj, "TextField_1_4", 651, cc.size(328.7795, 27.6262), cc.p(758.9285, 331.4558), nil, cc.c4b(162, 207, 12, 255), nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[2000]])
	obj:setFontSize(20)
	bind(obj).setMargin(594.5388, 404.7311, 410.6817, 317.6427)

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.TextField_1_5 = obj
	setValue(obj, "TextField_1_5", 652, cc.size(328.7795, 27.6262), cc.p(758.9276, 288.512), nil, cc.c4b(162, 217, 12, 255), nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[1998000]])
	obj:setFontSize(20)
	bind(obj).setMargin(594.5378, 447.6749, 410.6826, 274.6989)

	obj = ccui.TextField:create()
	roots.Layer_0:addChild(obj)
	roots.root.TextField_1_6 = obj
	setValue(obj, "TextField_1_6", 653, cc.size(328.7795, 27.6262), cc.p(758.9276, 244.2809), nil, cc.c4b(175, 229, 3, 255), nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[2015-12-21]])
	obj:setFontSize(24)
	bind(obj).setMargin(594.5378, 491.906, 410.6826, 230.4678)

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_10 = obj
	setValue(obj, "Image_10", 654, cc.size(132.0168, 135.0162), cc.p(853.9689, 505.1367), nil, nil, nil, nil, false)
	obj:loadTexture("4.png", 0)
	bind(obj).setMargin(787.9604, 177.3552, 414.0227, 437.6286)

	obj = ccui.Text:create()
	roots.Layer_0:addChild(obj)
	roots.root.Text_1 = obj
	setValue(obj, "Text_1", 656, cc.size(160, 40), cc.p(865.3033, 434.2779), nil, nil, nil, nil, nil)
	obj:setString([[赠送成功！]])
	obj:setFontSize(36)
	obj:enableOutline(cc.c4b(255, 115, 0, 255), 0)
	bind(obj).setMargin(785.8033, 296.7221, 389.1967, 415.2779)

	obj = ccui.Button:create()
	roots.Layer_0:addChild(obj)
	obj:setCapInsets(cc.rect(15, 10, 70, 13))
	roots.root.Button_3 = obj
	setValue(obj, "Button_3", 657, cc.size(100, 33), cc.p(689.5774, 182.0298), nil, nil, nil, nil, false)
	obj:setScale(1.2, 1.2)
	obj:loadTextureNormal("qd.png", 0)
	obj:loadTexturePressed("Default/Button_Press.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(639.5774, 551.4702, 594.4226, 165.5298)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"baoxiangui/pingtiao1.png",
	"Default/Button_Disable.png",
	"Default/Button_Press.png",
	"image200.png",
	"baoxiangui/xianshikuang.png",
	"4.png",
	"qd.png",
}

return _M
