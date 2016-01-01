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
	setValue(obj, "Layer", 227, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_BankingFrame = obj
	setValue(obj, "Image_BankingFrame", 228, cc.size(586, 355), cc.p(653.7982, 379.6852), nil, nil, nil, nil, false)
	obj:setScale(2, 2)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(360.7982, 192.8148, 387.2018, 202.1852)
	roots.Image_BankingFrame_1 = obj

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_MoneyTransfer = obj
	setValue(obj, "Button_MoneyTransfer", 229, cc.size(210, 72), cc.p(271.859, 323.473), nil, nil, nil, nil, false)
	obj:setScale(0.5, 0.5)
	obj:loadTextureNormal("baoxiangui/TransferNotpushed@2x.png", 0)
	obj:loadTexturePressed("baoxiangui/T-6-copy@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(166.859, -4.473, 209.141, 287.473)

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_TransferRecord = obj
	setValue(obj, "Button_TransferRecord", 230, cc.size(210, 72), cc.p(454.0475, 323.4733), nil, nil, nil, nil, false)
	obj:setScale(0.5, 0.5)
	obj:loadTextureNormal("baoxiangui/TransferHistoryNotinUse@2x.png", 0)
	obj:loadTexturePressed("baoxiangui/TransferHistory-2@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(349.0475, -4.4733, 26.9525, 287.4733)
	roots.Button_TransferRecord_2 = obj

	obj = ccui.ImageView:create()
	roots.Button_TransferRecord_2:addChild(obj)
	roots.root.Image_2 = obj
	setValue(obj, "Image_2", 233, cc.size(1108.1244, 547.3457), cc.p(-218.3761, -292.8669), nil, nil, nil, nil, false)
	obj:loadTexture("baoxiangui/jilu_bj01.png", 0)
	bind(obj).setMargin(-772.4383, 91.194, -125.6861, -566.5397)

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_savings = obj
	setValue(obj, "Button_savings", 231, cc.size(210, 72), cc.p(96.8357, 323.473), nil, nil, nil, nil, false)
	obj:setScale(0.5, 0.5)
	obj:loadTextureNormal("baoxiangui/savingNotpushed@2x.png", 0)
	obj:loadTexturePressed("baoxiangui/copy6@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(-8.1643, -4.473, 384.1643, 287.473)

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_close = obj
	setValue(obj, "Button_close", 232, cc.size(17, 13.9998), cc.p(564.5015, 334.1121), cc.p(0.4667, 0.4704), nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(556.5679, 13.4737, 12.4321, 327.5266)

	obj = ccui.ListView:create()
	roots.Layer_0:addChild(obj)
	roots.root.ListView_1 = obj
	setValue(obj, "ListView_1", 234, cc.size(1090.3462, 430.8383), cc.p(657.6859, 321.9064), cc.p(0.5049, 0.4481), nil, nil, nil, nil)
	setBgColor(obj, 1, 0, cc.c4b(150, 150, 255, 255), nil, nil, nil)
	bind(obj).setMargin(107.128, 190.328, 136.5259, 128.8337)

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
	"baoxiangui/T-6-copy@2x.png",
	"baoxiangui/TransferNotpushed@2x.png",
	"baoxiangui/TransferHistory-2@2x.png",
	"baoxiangui/TransferHistoryNotinUse@2x.png",
	"baoxiangui/jilu_bj01.png",
	"baoxiangui/copy6@2x.png",
	"baoxiangui/savingNotpushed@2x.png",
	"image200.png",
}

return _M
