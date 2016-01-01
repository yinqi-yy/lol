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
	roots.root.Scene = obj
	setValue(obj, "Scene", 176, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Scene_0 = obj

	obj = ccui.ImageView:create()
	roots.Scene_0:addChild(obj)
	roots.root.Image_BankingFrame = obj
	setValue(obj, "Image_BankingFrame", 61, cc.size(586, 355), cc.p(650.011, 369.5859), nil, nil, nil, nil, false)
	obj:setScale(2, 2)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(357.011, 202.9141, 390.989, 192.0859)
	roots.Image_BankingFrame_1 = obj

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_MoneyTransfer = obj
	setValue(obj, "Button_MoneyTransfer", 62, cc.size(210, 72), cc.p(271.859, 323.473), nil, nil, nil, nil, false)
	obj:setScale(0.5, 0.5)
	obj:loadTextureNormal("baoxiangui/T-6-copy@2x.png", 0)
	obj:loadTexturePressed("baoxiangui/T-6-copy@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(166.859, -4.473, 209.141, 287.473)

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_TransferRecord = obj
	setValue(obj, "Button_TransferRecord", 63, cc.size(210, 72), cc.p(454.0475, 323.4733), nil, nil, nil, nil, false)
	obj:setScale(0.5, 0.5)
	obj:loadTextureNormal("baoxiangui/TransferHistoryNotinUse@2x.png", 0)
	obj:loadTexturePressed("baoxiangui/TransferHistory-2@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(349.0475, -4.4733, 26.9525, 287.4733)

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_savings = obj
	setValue(obj, "Button_savings", 64, cc.size(210, 72), cc.p(96.8357, 323.473), nil, nil, nil, nil, false)
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
	setValue(obj, "Button_close", 65, cc.size(17, 13.9998), cc.p(564.5015, 334.1121), cc.p(0.4667, 0.4704), nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(556.5676, 13.4736, 12.4324, 327.5266)

	obj = ccui.ImageView:create()
	roots.Scene_0:addChild(obj)
	roots.root.Image_transferFrame = obj
	setValue(obj, "Image_transferFrame", 41, cc.size(1050, 512), cc.p(644.1613, 344.8619), nil, nil, nil, nil, false)
	obj:loadTexture("baoxiangui/zengsong_bj12.png", 0)
	bind(obj).setMargin(119.1613, 149.1381, 164.8386, 88.8619)
	roots.Image_transferFrame_1 = obj

	obj = ccui.ImageView:create()
	roots.Image_transferFrame_1:addChild(obj)
	roots.root.Image_10 = obj
	setValue(obj, "Image_10", 42, cc.size(380, 40), cc.p(765.672, 458.551), nil, nil, nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(575.672, 33.449, 94.328, 438.551)
	roots.Image_10_2 = obj

	obj = ccui.TextField:create()
	roots.Image_10_2:addChild(obj)
	roots.root.TextField_5 = obj
	setValue(obj, "TextField_5", 43, cc.size(332.583, 32.9214), cc.p(174.2169, 15.2758), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[46354765756]])
	obj:setFontSize(20)
	bind(obj).setMargin(7.9254, 8.2635, 39.4916, -1.1849)

	obj = ccui.ImageView:create()
	roots.Image_transferFrame_1:addChild(obj)
	roots.root.Image_10_0 = obj
	setValue(obj, "Image_10_0", 44, cc.size(380, 40), cc.p(770.9491, 400.7645), nil, nil, nil, nil, false)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(580.9491, 91.2355, 89.0509, 380.7645)
	roots.Image_10_0_2 = obj

	obj = ccui.TextField:create()
	roots.Image_10_0_2:addChild(obj)
	roots.root.TextField_6 = obj
	setValue(obj, "TextField_6", 45, cc.size(384.2678, 36.1517), cc.p(196.5386, 14.4181), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[54575472365324]])
	obj:setFontSize(20)
	bind(obj).setMargin(4.4047, 7.5061, -8.6725, -3.6577)

	obj = ccui.ImageView:create()
	roots.Image_transferFrame_1:addChild(obj)
	roots.root.Image_12 = obj
	setValue(obj, "Image_12", 46, cc.size(351, 40), cc.p(616.7193, 312.981), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(441.2193, 179.019, 257.7807, 292.981)
	roots.Image_12_2 = obj

	obj = ccui.TextField:create()
	roots.Image_12_2:addChild(obj)
	roots.root.TextField_7 = obj
	setValue(obj, "TextField_7", 47, cc.size(364.8867, 42.6123), cc.p(188.1777, 18.658), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(5.7344, 0.0359, -19.621, -2.6481)

	obj = ccui.ImageView:create()
	roots.Image_transferFrame_1:addChild(obj)
	roots.root.Image_12_0 = obj
	setValue(obj, "Image_12_0", 48, cc.size(351, 40), cc.p(616.4934, 251.9661), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(440.9934, 240.0339, 258.0066, 231.9661)
	roots.Image_12_0_2 = obj

	obj = ccui.TextField:create()
	roots.Image_12_0_2:addChild(obj)
	roots.root.TextField_7_0 = obj
	setValue(obj, "TextField_7_0", 49, cc.size(327.9883, 42.6123), cc.p(164.3924, 20.5452), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(0.3982, -1.8513, 22.6135, -0.761)

	obj = ccui.ImageView:create()
	roots.Image_transferFrame_1:addChild(obj)
	roots.root.Image_12_1 = obj
	setValue(obj, "Image_12_1", 50, cc.size(351, 40), cc.p(617.941, 188.1497), nil, nil, nil, nil, false)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(442.441, 303.8503, 256.559, 168.1497)
	roots.Image_12_1_2 = obj

	obj = ccui.TextField:create()
	roots.Image_12_1_2:addChild(obj)
	roots.root.TextField_7_0_0 = obj
	setValue(obj, "TextField_7_0_0", 51, cc.size(327.9883, 42.6123), cc.p(162.9442, 19.3307), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(-1.05, -0.6368, 24.0616, -1.9755)

	obj = ccui.Button:create()
	roots.Image_transferFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_0.1Bi = obj
	setValue(obj, "Button_0.1Bi", 52, cc.size(129, 40), cc.p(912.3156, 130.6423), nil, nil, nil, nil, false)
	obj:setScale(1.0504, 1.1428)
	obj:loadTextureNormal("baoxiangui/1yi.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(847.8156, 361.3577, 73.1844, 110.6423)

	obj = ccui.Button:create()
	roots.Image_transferFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_50mil = obj
	setValue(obj, "Button_50mil", 53, cc.size(129, 40), cc.p(741.1075, 130.6423), nil, nil, nil, nil, false)
	obj:setScale(1.0504, 1.1428)
	obj:loadTextureNormal("baoxiangui/5000wan.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(676.6075, 361.3577, 244.3925, 110.6423)

	obj = ccui.Button:create()
	roots.Image_transferFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_10,mil = obj
	setValue(obj, "Button_10,mil", 54, cc.size(129, 40), cc.p(560.264, 130.6423), nil, nil, nil, nil, false)
	obj:setScale(1.0504, 1.1428)
	obj:loadTextureNormal("baoxiangui/1000wan.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(495.764, 361.3577, 425.236, 110.6423)

	obj = ccui.Button:create()
	roots.Image_transferFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_5mil = obj
	setValue(obj, "Button_5mil", 55, cc.size(129, 40), cc.p(383.8426, 130.6423), nil, nil, nil, nil, false)
	obj:setScale(1.0504, 1.1428)
	obj:loadTextureNormal("baoxiangui/500wan.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(319.3426, 361.3577, 601.6574, 110.6423)

	obj = ccui.Button:create()
	roots.Image_transferFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_1mil = obj
	setValue(obj, "Button_1mil", 56, cc.size(129, 40), cc.p(211.1703, 130.4587), nil, nil, nil, nil, false)
	obj:setScale(1.0504, 1.1428)
	obj:loadTextureNormal("baoxiangui/100wan.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(146.6703, 361.5413, 774.3297, 110.4587)

	obj = ccui.Button:create()
	roots.Image_transferFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 22))
	roots.root.Button_17 = obj
	setValue(obj, "Button_17", 57, cc.size(154, 44), cc.p(572.924, 56.0595), cc.p(0.6232, 0.3819), nil, nil, nil, false)
	obj:loadTextureNormal("baoxiangui/zengs_an.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(476.9512, 428.7441, 419.0488, 39.2559)

	obj = ccui.CheckBox:create()
	roots.Image_transferFrame_1:addChild(obj)
	roots.root.CheckBox_6 = obj
	setValue(obj, "CheckBox_6", 58, cc.size(24, 24), cc.p(912.8653, 308.1761), nil, nil, nil, nil, nil)
	obj:loadTextureBackGround("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundSelected("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundDisabled("Default/CheckBox_Disable.png", 0)
	obj:loadTextureFrontCross("baoxiangui/dagou.png", 0)
	obj:loadTextureFrontCrossDisabled("Default/CheckBoxNode_Disable.png", 0)
	obj:setSelected(true)
	bind(obj).setMargin(900.8653, 191.8239, 125.1347, 296.1761)

	obj = ccui.ImageView:create()
	roots.Image_transferFrame_1:addChild(obj)
	roots.root.Image_21 = obj
	setValue(obj, "Image_21", 59, cc.size(81.3614, 62.8694), cc.p(69.4673, 397.5399), nil, nil, nil, nil, false)
	obj:setScale(1.0322, 1.0982)
	obj:loadTexture("sch.png", 0)
	bind(obj).setMargin(28.7866, 83.0254, 939.852, 366.1052)

	obj = ccui.ImageView:create()
	roots.Image_transferFrame_1:addChild(obj)
	roots.root.Image_20 = obj
	setValue(obj, "Image_20", 60, cc.size(81, 84), cc.p(127.7121, 427.5146), nil, nil, nil, nil, false)
	obj:setScale(1.0322, 1.0982)
	obj:loadTexture("4.png", 0)
	bind(obj).setMargin(87.2121, 42.4854, 881.7879, 385.5146)

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
	"baoxiangui/TransferHistory-2@2x.png",
	"baoxiangui/TransferHistoryNotinUse@2x.png",
	"baoxiangui/copy6@2x.png",
	"baoxiangui/savingNotpushed@2x.png",
	"image200.png",
	"baoxiangui/zengsong_bj12.png",
	"baoxiangui/xianshikuang.png",
	"denglu/dl_shuruk.png",
	"baoxiangui/1yi.png",
	"baoxiangui/5000wan.png",
	"baoxiangui/1000wan.png",
	"baoxiangui/500wan.png",
	"baoxiangui/100wan.png",
	"baoxiangui/zengs_an.png",
	"baoxiangui/fuxuankuang.png",
	"Default/CheckBox_Disable.png",
	"baoxiangui/dagou.png",
	"Default/CheckBoxNode_Disable.png",
	"sch.png",
	"4.png",
}

return _M
