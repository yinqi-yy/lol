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
	setValue(obj, "Layer", 37, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_BankingFrame = obj
	setValue(obj, "Image_BankingFrame", 131, cc.size(586, 355), cc.p(650.011, 369.5859), nil, nil, nil, nil, false)
	obj:setScale(2, 2)
	obj:loadTexture("image69.png", 0)
	bind(obj).setMargin(357.011, 202.9141, 390.989, 192.0859)
	roots.Image_BankingFrame_1 = obj

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_MoneyTransfer = obj
	setValue(obj, "Button_MoneyTransfer", 126, cc.size(210, 72), cc.p(271.859, 323.473), nil, nil, nil, nil, false)
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
	setValue(obj, "Button_TransferRecord", 127, cc.size(210, 72), cc.p(454.0475, 323.4733), nil, nil, nil, nil, false)
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
	setValue(obj, "Button_savings", 125, cc.size(210, 72), cc.p(96.8357, 323.473), nil, nil, nil, nil, false)
	obj:setScale(0.5, 0.5)
	obj:loadTextureNormal("baoxiangui/savingNotpushed@2x.png", 0)
	obj:loadTexturePressed("baoxiangui/copy6@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(-8.1643, -4.473, 384.1643, 287.473)
	roots.Button_savings_2 = obj

	obj = ccui.ImageView:create()
	roots.Button_savings_2:addChild(obj)
	roots.root.Image_Saving&withdraw = obj
	setValue(obj, "Image_Saving&withdraw", 128, cc.size(2178.4482, 1090.5626), cc.p(495.7038, -285.9893), nil, nil, nil, nil, false)
	obj:setScale(0.5, 0.5)
	obj:loadTexture("baoxiangui/cunqu_bj1.png", 0)
	bind(obj).setMargin(-593.5203, -187.292, -1374.928, -831.2706)
	roots.Image_Saving&withdraw_3 = obj

	obj = ccui.ImageView:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.Image_MoneyCarriedTextField_1 = obj
	setValue(obj, "Image_MoneyCarriedTextField_1", 133, cc.size(380, 40), cc.p(1554.1672, 992.3696), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(1364.1672, 78.1931, 434.281, 972.3696)
	roots.Image_MoneyCarriedTextField_1_4 = obj

	obj = ccui.TextField:create()
	roots.Image_MoneyCarriedTextField_1_4:addChild(obj)
	roots.root.TextField_MoneyCarried = obj
	setValue(obj, "TextField_MoneyCarried", 165, cc.size(369.2544, 37.0054), cc.p(195.7557, 21.598), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[2385648690]])
	obj:setFontSize(24)
	bind(obj).setMargin(11.1285, -0.1007, -0.3829, 3.0953)

	obj = ccui.ImageView:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.Image_Savings = obj
	setValue(obj, "Image_Savings", 157, cc.size(380, 40), cc.p(1554.1672, 861.3644), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTexture("baoxiangui/xianshikuang.png", 0)
	bind(obj).setMargin(1364.1672, 209.1982, 434.281, 841.3644)
	roots.Image_Savings_4 = obj

	obj = ccui.TextField:create()
	roots.Image_Savings_4:addChild(obj)
	roots.root.TextField_MoneyInSavings = obj
	setValue(obj, "TextField_MoneyInSavings", 166, cc.size(369.254, 37.0056), cc.p(199.463, 19.8437), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[1,000,000,000]])
	obj:setFontSize(24)
	bind(obj).setMargin(14.8359, 1.6536, -4.09, 1.3409)

	obj = ccui.ImageView:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.Image_amountofMoney = obj
	setValue(obj, "Image_amountofMoney", 158, cc.size(343.4899, 40), cc.p(1210.7561, 658.5092), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(1039.0112, 412.0534, 795.9473, 638.5092)
	roots.Image_amountofMoney_4 = obj

	obj = ccui.TextField:create()
	roots.Image_amountofMoney_4:addChild(obj)
	roots.root.TextField_amountofMoney = obj
	setValue(obj, "TextField_amountofMoney", 167, cc.size(326.7401, 34.1713), cc.p(165.7179, 21.0235), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(2.3479, 1.8909, 14.4019, 3.9379)

	obj = ccui.ImageView:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.Image_SafePW = obj
	setValue(obj, "Image_SafePW", 159, cc.size(351, 40), cc.p(1217.7566, 399.6943), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTexture("denglu/dl_shuruk.png", 0)
	bind(obj).setMargin(1042.2566, 670.8683, 785.1917, 379.6943)
	roots.Image_SafePW_4 = obj

	obj = ccui.TextField:create()
	roots.Image_SafePW_4:addChild(obj)
	roots.root.TextField_safePW = obj
	setValue(obj, "TextField_safePW", 168, cc.size(329.5753, 37.0055), cc.p(163.0583, 19.5987), nil, nil, nil, nil, false)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(-1.7293, 1.8985, 23.154, 1.096)

	obj = ccui.Button:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_1mil = obj
	setValue(obj, "Button_1mil", 160, cc.size(129, 40), cc.p(264.692, 519.293), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureNormal("baoxiangui/100wan.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(200.192, 551.2696, 1849.2562, 499.293)

	obj = ccui.Button:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_5mil = obj
	setValue(obj, "Button_5mil", 161, cc.size(129, 40), cc.p(596.4595, 519.6245), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureNormal("baoxiangui/500wan.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(531.9595, 550.9381, 1517.4888, 499.6245)

	obj = ccui.Button:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_10,mil = obj
	setValue(obj, "Button_10,mil", 162, cc.size(129, 40), cc.p(935.4328, 519.6245), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureNormal("baoxiangui/1000wan.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(870.9328, 550.9381, 1178.5154, 499.6245)

	obj = ccui.Button:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_50mil = obj
	setValue(obj, "Button_50mil", 163, cc.size(129, 40), cc.p(1282.8962, 519.6245), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureNormal("baoxiangui/5000wan.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1218.3962, 550.9381, 831.052, 499.6245)

	obj = ccui.Button:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 99, 18))
	roots.root.Button_0.1Bi = obj
	setValue(obj, "Button_0.1Bi", 164, cc.size(129, 40), cc.p(1611.825, 519.6245), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureNormal("baoxiangui/1yi.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1547.325, 550.9381, 502.1233, 499.6245)

	obj = ccui.CheckBox:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.CheckBox_TakeAll = obj
	setValue(obj, "CheckBox_TakeAll", 169, cc.size(24, 24), cc.p(1874.5105, 688.8323), nil, nil, nil, nil, nil)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureBackGround("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundSelected("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundDisabled("Default/CheckBox_Disable.png", 0)
	obj:loadTextureFrontCross("baoxiangui/dagou.png", 0)
	obj:loadTextureFrontCrossDisabled("Default/CheckBoxNode_Disable.png", 0)
	obj:setSelected(true)
	bind(obj).setMargin(1862.5105, 389.7303, 291.9377, 676.8323)

	obj = ccui.CheckBox:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.CheckBox_SaveAll = obj
	setValue(obj, "CheckBox_SaveAll", 170, cc.size(24, 24), cc.p(1878.5752, 624.2895), nil, nil, nil, nil, nil)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureBackGround("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundSelected("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundDisabled("Default/CheckBox_Disable.png", 0)
	obj:loadTextureFrontCross("baoxiangui/dagou.png", 0)
	obj:loadTextureFrontCrossDisabled("Default/CheckBoxNode_Disable.png", 0)
	bind(obj).setMargin(1866.5752, 454.2731, 287.873, 612.2895)

	obj = ccui.CheckBox:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.CheckBox_RememberPW = obj
	setValue(obj, "CheckBox_RememberPW", 171, cc.size(24, 24), cc.p(1898.1172, 410.4785), cc.p(0.5991, 0.5253), nil, nil, nil, nil)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureBackGround("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundSelected("baoxiangui/fuxuankuang.png", 0)
	obj:loadTextureBackGroundDisabled("Default/CheckBox_Disable.png", 0)
	obj:loadTextureFrontCross("baoxiangui/dagou.png", 0)
	obj:loadTextureFrontCrossDisabled("Default/CheckBoxNode_Disable.png", 0)
	obj:setSelected(true)
	bind(obj).setMargin(1883.739, 668.6924, 270.7092, 397.8702)

	obj = ccui.Button:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 22))
	roots.root.Button_Save = obj
	setValue(obj, "Button_Save", 172, cc.size(154, 44), cc.p(717.5381, 145.0811), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureNormal("baoxiangui/cunkuan_an.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(640.5381, 923.4815, 1383.9102, 123.0811)

	obj = ccui.Button:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 124, 22))
	roots.root.Button_Withdraw = obj
	setValue(obj, "Button_Withdraw", 173, cc.size(154, 44), cc.p(1370.9324, 145.0811), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTextureNormal("baoxiangui/qukuan_an.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1293.9324, 923.4815, 730.5159, 123.0811)

	obj = ccui.ImageView:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.Image_20 = obj
	setValue(obj, "Image_20", 174, cc.size(81, 84), cc.p(305.1389, 921.1819), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTexture("4.png", 0)
	bind(obj).setMargin(264.6389, 127.3807, 1832.8093, 879.1819)

	obj = ccui.ImageView:create()
	roots.Image_Saving&withdraw_3:addChild(obj)
	roots.root.Image_21 = obj
	setValue(obj, "Image_21", 175, cc.size(81.3614, 62.8694), cc.p(191.2627, 864.9419), nil, nil, nil, nil, false)
	obj:setScale(2.0182, 2.0602)
	obj:loadTexture("sch.png", 0)
	bind(obj).setMargin(150.582, 194.186, 1946.5049, 833.5072)

	obj = ccui.Button:create()
	roots.Image_BankingFrame_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_close = obj
	setValue(obj, "Button_close", 132, cc.size(17, 13.9998), cc.p(564.5015, 334.1121), cc.p(0.4667, 0.4704), nil, nil, nil, false)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(556.5679, 13.4737, 12.4321, 327.5266)

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
	"baoxiangui/copy6@2x.png",
	"baoxiangui/savingNotpushed@2x.png",
	"baoxiangui/cunqu_bj1.png",
	"baoxiangui/xianshikuang.png",
	"denglu/dl_shuruk.png",
	"baoxiangui/100wan.png",
	"baoxiangui/500wan.png",
	"baoxiangui/1000wan.png",
	"baoxiangui/5000wan.png",
	"baoxiangui/1yi.png",
	"baoxiangui/fuxuankuang.png",
	"Default/CheckBox_Disable.png",
	"baoxiangui/dagou.png",
	"Default/CheckBoxNode_Disable.png",
	"baoxiangui/cunkuan_an.png",
	"baoxiangui/qukuan_an.png",
	"4.png",
	"sch.png",
	"image200.png",
}

return _M
