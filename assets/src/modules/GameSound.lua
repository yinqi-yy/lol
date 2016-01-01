--hzs


SOUNDEMU = {}

SOUNDEMU.TYPE = {}
SOUNDEMU.TYPE.MUSIC = 1--音乐
SOUNDEMU.TYPE.SOUND = 0--音效

SOUNDEMU.EFFECT = {}
SOUNDEMU.EFFECT.CLICK_SPACE = 0 --点击空白处
SOUNDEMU.EFFECT.CLICK_BTNOK = 1 --确认按钮
SOUNDEMU.EFFECT.CLICK_BTNCLOSE = 2 --取消/关闭按钮
SOUNDEMU.EFFECT.CHANGE_MAP = 3 --切换地图
SOUNDEMU.EFFECT.BUILD_SPACE = 4 --建造空位音效
SOUNDEMU.EFFECT.BUILD = 5 --建筑提示音效
SOUNDEMU.EFFECT.COLLDGE = 6 --收获兵种/陷阱/装备
SOUNDEMU.EFFECT.ARMY = 7 --军队出征
SOUNDEMU.EFFECT.WISHWELL = 8 --许愿池相关
SOUNDEMU.EFFECT.ROUND = 9 --幸运转盘/日常奖励
SOUNDEMU.EFFECT.PLAYER_LEVELUP = 10 --领主升级
SOUNDEMU.EFFECT.MAIL_GET = 11 --邮件收取与 获得邮件内物品
SOUNDEMU.EFFECT.MUSIC_BIGMAP = 12 --大地图背景音
SOUNDEMU.EFFECT.MUSIC_MAINSITY = 13 --城镇内背景音

--转盘相关
SOUNDEMU.BOX = {}
SOUNDEMU.BOX.TURN = 0 --转盘转动
SOUNDEMU.BOX.GETITEM = 1 --获得物品
SOUNDEMU.BOX.GETBOX = 2 --获得宝箱
SOUNDEMU.BOX.SHUFF = 3 --宝箱洗牌
SOUNDEMU.BOX.DRAW = 4 --宝箱内翻牌获得
SOUNDEMU.BOX.DAILYREWARD = 5 --日常奖励获得
SOUNDEMU.BOX.PROGRESS = 6 --进度条增加音效

--部队
SOUNDEMU.ARMY = {}
SOUNDEMU.ARMY.GO = 0 --部队出征
SOUNDEMU.ARMY.REACH = 1 --部队到达位置
SOUNDEMU.ARMY.FIGHT = 2 --部队发生战斗
SOUNDEMU.ARMY.BACKBOME = 3 --部队返回城镇

local GameSound = class("GameSound")


-----------------------------------
--public
-----------------------------------
--开启/关闭声音
function GameSound:enableSound(bEnable)
    self._enableSound = bEnable
end

--开启/关闭音乐
function GameSound:enableMusic(bEnable)
    self._enableMusic = bEnable
    if bEnable then
        if self._lastMusic then
            self:playMusic(self._lastMusic)
        end
    else
        util.stopMusic(true)
    end
end


--转盘相关,actionID 为SOUNDEMU.BOX下枚举
function GameSound:onBoxAction(actionID)
    self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.ROUND,box = actionID})
end

--城镇点击
function GameSound:onClickBuild(buildType)
    if buildType == nil then--空地
        self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.CLICK_SPACE})
    elseif  buildType<=0  then--建筑空位
        self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.BUILD_SPACE})
    else--建筑
        self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.BUILD,build=buildType})
    end
end

--确认按钮
function GameSound:onBtnOk()
    self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.CLICK_BTNOK})
end

--取消/关闭按钮
function GameSound:onBtnClose()
    self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.CLICK_BTNCLOSE})
end

--进入主城
function GameSound:onEnterCity()
    self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.MUSIC_MAINSITY})
end

--进入大地图
function GameSound:onEnterBigmap()
    self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.MUSIC_BIGMAP})
end

--军队出征
function GameSound:onArmy(armyAction)
    self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.ARMY,arms = armyAction})
end

--收获
function GameSound:onHarvest(buildType)
    self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.COLLDGE,build = buildType})
end

--许愿池获得
--[[
res
0 木材
1 粮食
2 铁矿
3 秘银
4 钢材]]
function GameSound:onWishHarvest(res)
    self:playSoundbyInfo({effectDesc = SOUNDEMU.EFFECT.WISHWELL,wish = res})
end
----------------------------
--private
----------------------------
function GameSound:ctor()
	cc.FileUtils:getInstance():addSearchPath("res/sounds/background/")
	cc.FileUtils:getInstance():addSearchPath("res/sounds/effects/")
	cc.FileUtils:getInstance():addSearchPath("res/sounds/push/")

    self:enableSound(true)
    self:enableMusic(true)
    if audio == nil then
        audio = require("cocos.framework.audio")
    end
end

function GameSound:getSoundData()
    if self._data then
        return self._data
    end
    self._data = require("config.sounds")
    return self._data
end

function GameSound:playSoundByID(id)
    local info = self:getSoundData() and  self:getSoundData()[id]
    if not info then
        trace("GameSound:playSoundByID no sound,id = "..tostring(id))
        return
    end

    local file = info.sound
    local soundtype = info.loop
    if soundtype == SOUNDEMU.TYPE.MUSIC then
        self:playMusic(file)
    elseif soundtype == SOUNDEMU.TYPE.SOUND then
        self:playSound(file)
    else
        trace("GameSound:playSoundByID unknown type,loop = "..tostring(soundtype))
    end
end

function GameSound:playSoundbyInfo(soundInfo)
    if self:getSoundData() == nil then
        trace("error:GameSound not SoundData")
        return false
    end
    for id,info in pairs(self:getSoundData()) do
        local find = true
        for key,value in pairs(soundInfo) do
            if info[key] ~= value then
                find = false
                break
            end
        end
        if find then
            self:playSoundByID(id)
            return true
        end
    end
    trace("error:GameSound:playSoundbyInfo unknown info")
    traceObj(soundInfo)
    return false
end



function GameSound:playSound(filename)
    if not self._enableSound then
        return
    end
    util.playSound(filename)
end

function GameSound:playMusic(filename)
    self._lastMusic = filename
    if not self._enableMusic then
        return
    end    
    
    util.playMusic(filename,true)
end


return GameSound
