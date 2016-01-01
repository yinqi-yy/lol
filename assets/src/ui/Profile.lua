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
	setValue(obj, "Layer", 582, cc.size(1334, 750), nil, nil, nil, nil, nil, nil)
	roots.Layer_0 = obj

	obj = ccui.ImageView:create()
	roots.Layer_0:addChild(obj)
	roots.root.Image_BigPopWin = obj
	setValue(obj, "Image_BigPopWin", 583, cc.size(1255, 668), cc.p(672.162, 383.0198), nil, nil, nil, nil, false)
	obj:loadTexture("image613.png", 0)
	bind(obj).setMargin(44.662, 32.9802, 34.338, 49.0198)
	roots.Image_BigPopWin_1 = obj

	obj = ccui.Button:create()
	roots.Image_BigPopWin_1:addChild(obj)
	obj:setCapInsets(cc.rect(5, 4, 7, 6))
	roots.root.Button_Close = obj
	setValue(obj, "Button_Close", 607, cc.size(17, 14), cc.p(1221.3777, 643.3601), cc.p(0.5435, 0.5622), nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("image200.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(1212.1382, 18.5107, 25.8618, 635.4893)

	obj = ccui.Button:create()
	roots.Image_BigPopWin_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_BasicInfo = obj
	setValue(obj, "Button_BasicInfo", 585, cc.size(210, 72), cc.p(403.8946, 597.8258), nil, nil, nil, nil, false)
	obj:loadTextureNormal("gerenzhongx/BasicInfoNotInuse@2x.png", 0)
	obj:loadTexturePressed("gerenzhongx/BasicInfo@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(298.8946, 34.1742, 746.1054, 561.8258)
	roots.Button_BasicInfo_2 = obj

	obj = ccui.ImageView:create()
	roots.Button_BasicInfo_2:addChild(obj)
	roots.root.Image_BasicInfo = obj
	setValue(obj, "Image_BasicInfo", 587, cc.size(1094, 355), cc.p(337.3947, -245.4689), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/gerenzhongx_bj.png", 0)
	bind(obj).setMargin(-209.6053, 139.9689, -674.3947, -422.9689)
	roots.Image_BasicInfo_3 = obj

	obj = ccui.ImageView:create()
	roots.Image_BasicInfo_3:addChild(obj)
	roots.root.Image_nickname = obj
	setValue(obj, "Image_nickname", 588, cc.size(350, 40), cc.p(309.7958, 337.9606), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/shurukuang3.png", 0)
	bind(obj).setMargin(134.7958, -2.9606, 609.2042, 317.9606)
	roots.Image_nickname_4 = obj

	obj = ccui.TextField:create()
	roots.Image_nickname_4:addChild(obj)
	roots.root.TextField_Nickname = obj
	setValue(obj, "TextField_Nickname", 596, cc.size(140, 20), cc.p(167.5591, 18.3067), nil, nil, nil, nil, false)
	obj:setScale(2.3381, 1.7574)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	bind(obj).setMargin(97.5591, 11.6933, 112.4409, 8.3067)

	obj = ccui.ImageView:create()
	roots.Image_BasicInfo_3:addChild(obj)
	roots.root.Image_pw = obj
	setValue(obj, "Image_pw", 589, cc.size(350, 40), cc.p(309.1848, 264.1246), nil, nil, nil, nil, false)
	obj:setTouchEnabled(true)
	obj:loadTexture("gerenzhongx/shurukuang3.png", 0)
	bind(obj).setMargin(134.1848, 70.8754, 609.8152, 244.1246)
	roots.Image_pw_4 = obj

	obj = ccui.TextField:create()
	roots.Image_pw_4:addChild(obj)
	roots.root.TextField_PW = obj
	setValue(obj, "TextField_PW", 597, cc.size(140, 20), cc.p(169.8248, 18.4078), nil, nil, nil, nil, false)
	obj:setScale(2.3381, 1.7574)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(99.8248, 11.5922, 110.1752, 8.4078)

	obj = ccui.ImageView:create()
	roots.Image_BasicInfo_3:addChild(obj)
	roots.root.Image_ID = obj
	setValue(obj, "Image_ID", 590, cc.size(350, 40), cc.p(309.3971, 199.0585), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/shurukuang3.png", 0)
	bind(obj).setMargin(134.3971, 135.9415, 609.6029, 179.0585)
	roots.Image_ID_4 = obj

	obj = ccui.TextField:create()
	roots.Image_ID_4:addChild(obj)
	roots.root.TextField_Acct = obj
	setValue(obj, "TextField_Acct", 599, cc.size(140, 20), cc.p(171.1627, 19.3148), nil, nil, nil, nil, false)
	obj:setScale(2.3381, 1.7574)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(101.1627, 10.6852, 108.8373, 9.3148)

	obj = ccui.ImageView:create()
	roots.Image_BasicInfo_3:addChild(obj)
	roots.root.Image_realName = obj
	setValue(obj, "Image_realName", 591, cc.size(350, 40), cc.p(309.7088, 125.8854), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/shurukuang3.png", 0)
	bind(obj).setMargin(134.7088, 209.1146, 609.2912, 105.8854)
	roots.Image_realName_4 = obj

	obj = ccui.TextField:create()
	roots.Image_realName_4:addChild(obj)
	roots.root.TextField_RealName = obj
	setValue(obj, "TextField_RealName", 600, cc.size(140, 20), cc.p(171.0639, 22.4257), nil, nil, nil, nil, false)
	obj:setScale(2.3381, 1.7574)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(101.0639, 7.5743, 108.9361, 12.4257)

	obj = ccui.ImageView:create()
	roots.Image_BasicInfo_3:addChild(obj)
	roots.root.Image_IDnum = obj
	setValue(obj, "Image_IDnum", 592, cc.size(350, 40), cc.p(310.1841, 50.6954), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/shurukuang3.png", 0)
	bind(obj).setMargin(135.1841, 284.3046, 608.8159, 30.6954)
	roots.Image_IDnum_4 = obj

	obj = ccui.TextField:create()
	roots.Image_IDnum_4:addChild(obj)
	roots.root.TextField_IDNum = obj
	setValue(obj, "TextField_IDNum", 601, cc.size(140, 20), cc.p(161.9403, 16.2128), nil, nil, nil, nil, false)
	obj:setScale(2.3381, 1.7574)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(91.9403, 13.7872, 118.0597, 6.2128)

	obj = ccui.ImageView:create()
	roots.Image_BasicInfo_3:addChild(obj)
	roots.root.Image_SafePw = obj
	setValue(obj, "Image_SafePw", 593, cc.size(350, 40), cc.p(938.7808, 338.0831), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/shurukuang3.png", 0)
	bind(obj).setMargin(763.7808, -3.0831, -19.7808, 318.0831)
	roots.Image_SafePw_4 = obj

	obj = ccui.TextField:create()
	roots.Image_SafePw_4:addChild(obj)
	roots.root.TextField_safepw = obj
	setValue(obj, "TextField_safepw", 602, cc.size(140, 20), cc.p(171.9403, 16.3118), nil, nil, nil, nil, false)
	obj:setScale(2.3381, 1.7574)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(101.9403, 13.6882, 108.0597, 6.3118)

	obj = ccui.ImageView:create()
	roots.Image_BasicInfo_3:addChild(obj)
	roots.root.Image_CellPhone = obj
	setValue(obj, "Image_CellPhone", 594, cc.size(350, 40), cc.p(937.6202, 263.608), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/shurukuang3.png", 0)
	bind(obj).setMargin(762.6202, 71.392, -18.6201, 243.608)
	roots.Image_CellPhone_4 = obj

	obj = ccui.TextField:create()
	roots.Image_CellPhone_4:addChild(obj)
	roots.root.TextField_phone = obj
	setValue(obj, "TextField_phone", 603, cc.size(140, 20), cc.p(174.3734, 20.1985), nil, nil, nil, nil, false)
	obj:setScale(2.3381, 1.7574)
	obj:setString([[]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(20)
	obj:setPasswordEnabled(true)
	bind(obj).setMargin(104.3734, 9.8015, 105.6266, 10.1985)

	obj = ccui.ImageView:create()
	roots.Image_BasicInfo_3:addChild(obj)
	roots.root.Image_nickname_6 = obj
	setValue(obj, "Image_nickname_6", 595, cc.size(350, 40), cc.p(937.5229, 125.4885), nil, nil, nil, nil, false)
	obj:loadTexture("gerenzhongx/shurukuang3.png", 0)
	bind(obj).setMargin(762.5229, 209.5115, -18.5229, 105.4885)
	roots.Image_nickname_6_4 = obj

	obj = ccui.TextField:create()
	roots.Image_nickname_6_4:addChild(obj)
	roots.root.TextField_Code = obj
	setValue(obj, "TextField_Code", 604, cc.size(140, 20), cc.p(167.951, 19.8226), nil, cc.c4b(26, 26, 26, 255), 152, nil, false)
	obj:setScale(2.3381, 1.7574)
	obj:setString([[无需填写，请留空]])
	obj:setPlaceHolder([[]])
	obj:setFontSize(13)
	bind(obj).setMargin(97.951, 10.1774, 112.049, 9.8226)

	obj = ccui.Button:create()
	roots.Image_BasicInfo_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_Save = obj
	setValue(obj, "Button_Save", 605, cc.size(122, 40), cc.p(289.3203, -84.9031), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("gerenzhongx/baocun.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(228.3203, 419.9031, 743.6797, -104.9031)

	obj = ccui.Button:create()
	roots.Image_BasicInfo_3:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 92, 18))
	roots.root.Button_Cancel = obj
	setValue(obj, "Button_Cancel", 606, cc.size(122, 40), cc.p(779.0825, -83.8928), nil, nil, nil, nil, false)
	obj:setScale(1.5, 1.5)
	obj:loadTextureNormal("gerenzhongx/quxiao.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(718.0825, 418.8928, 253.9175, -103.8928)

	obj = ccui.Button:create()
	roots.Image_BigPopWin_1:addChild(obj)
	obj:setCapInsets(cc.rect(15, 11, 180, 50))
	roots.root.Button_BuyHistory = obj
	setValue(obj, "Button_BuyHistory", 586, cc.size(210, 72), cc.p(936.7045, 599.3879), nil, nil, nil, nil, false)
	obj:loadTextureNormal("gerenzhongx/TransferHistoryNotInuse@2x.png", 0)
	obj:loadTexturePressed("gerenzhongx/RechargeHistory@2x.png", 0)
	obj:loadTextureDisabled("Default/Button_Disable.png", 0)
	obj:setTitleColor(cc.c3b(65, 65, 70))
	obj:setTitleFontSize(14)
	bind(obj).setMargin(831.7045, 32.6121, 213.2954, 563.3879)

	animations = {}
	obj = ccs.ActionTimeline:create()
	animations.actionTimeline = obj 
	obj:setDuration(0)
	obj:setTimeSpeed(1.0000)

	roots.root.animations = animations

	return roots
end

_M.textures = {
	"image613.png",
	"Default/Button_Disable.png",
	"image200.png",
	"gerenzhongx/BasicInfo@2x.png",
	"gerenzhongx/BasicInfoNotInuse@2x.png",
	"gerenzhongx/gerenzhongx_bj.png",
	"gerenzhongx/shurukuang3.png",
	"gerenzhongx/baocun.png",
	"gerenzhongx/quxiao.png",
	"gerenzhongx/RechargeHistory@2x.png",
	"gerenzhongx/TransferHistoryNotInuse@2x.png",
}

return _M
