local display = require("cocos.framework.display")

local DragScale = class("DragScale",function ()
    local layer = cc.Layer:create()
    return layer
end)

function DragScale:ctor(home_layer)
    self._scale=1--0.9

    self._dragLayer = home_layer
    self._dragLayer:setScale(self._scale)
    self:addDrag()
    self._savePos = {}
    EventProtocol.extend(self)
end

local _beganPos={x=0,y=0}
local _movingPos = {}

local touch_dis = 20
local MAX_SCALE_MOVEED = 2.2
local MIN_SCALE_MOVEED = 0.8
local MAX_SCALE_MOVEING = MAX_SCALE_MOVEED*1.1
local MIN_SCALE_MOVEING = MIN_SCALE_MOVEED*0.9
local TIME_AUTOMOVE = 1--惯性自动移动时间
local TIME_MOVE = 0.02--产生惯性最小时间
local TIME_JUMP = 0.3

function DragScale:addDrag()
    local function onTouchBegan(touch, event)
       if touch:getId() == 0 then
            _beganPos = touch:getLocation()
       end
       self:stopMove()
       return true
    end
    
    local function onTouchEnded(touch, event)
        self._beganSubPos = nil
        _movingPos[touch:getId()+1] = nil
        
        --所有点击取消后,恢复部分缩放
        if table.nums(_movingPos)== 0 then
            self:setScaleback()
        end
        --建筑响应
        if touch:getId() == 0  and cc.pGetDistance(touch:getLocation(),_beganPos) <= touch_dis then
            self:notifyClick(touch)
            return
        end
        --缩放终止
        if (touch:getId() == 0 or touch:getId() == 1) then
            self._oldDistance = nil
            self._oldPosDelta = nil
        end
        --惯性运动
        if touch:getId() == 0 and table.nums(_movingPos)==0 and #self._savePos>0 and not touch._isScale then
            local now = os.clock()
            local index = 1
            for i = #self._savePos,1,-1 do
                if now - self._savePos[i].time >= TIME_MOVE then
                    index = i
                    break
                end
            end
            local lastMovePos = cc.pSub(touch:getLocation(),self._savePos[index].pos)
            local movePos = cc.pMul(lastMovePos,TIME_AUTOMOVE/(os.clock() - self._savePos[index].time)/2)
            local tagPos = cc.pAdd(cc.p(self._dragLayer:getPosition()),movePos)
            self:startMove(tagPos,TIME_AUTOMOVE)
            self._savePos = {}--清数据
        end
    end

    local function onTouchMove(touch, event)
       if not self:isPosInScreen(touch:getLocation()) then
           if not touch._hasOut then
                touch._hasOut = true
                onTouchEnded(touch, event)
           end

           return
       elseif touch._hasOut then
            return
       end
       _movingPos[touch:getId()+1] = touch:getLocation()

       local pos1 = _movingPos[1]
       local pos2 = _movingPos[2]
       if pos1 and pos2 then
            touch._isScale = true
            local iDistance = cc.pGetDistance(pos1,pos2)
            local posMid = cc.pMidpoint(pos1,pos2)
            --缩放
            if self._oldDistance and self._oldDistance ~= iDistance then
                local scale = iDistance/self._oldDistance * self._scale;
		        scale = math.min(MAX_SCALE_MOVEING,math.max(MIN_SCALE_MOVEING, scale));
                self:setScaleAndMove(scale,posMid)
            end
            self._oldDistance = iDistance
       elseif pos1 then
            --保存下移动路径,以做惯性方向
            if self._beganSubPos == nil then
                self._beganSubPos = cc.pSub(touch:getLocation(),cc.p(self._dragLayer:getPosition()))
            else
                local savePos = {time = os.clock(),pos = pos1}
                if self._savePos[#self._savePos] and self._savePos[#self._savePos].pos == pos1   then
                    return
                end
                table.insert(self._savePos,savePos)
                self:setXY(cc.pSub(pos1,self._beganSubPos))
            end
       end
    end

   
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMove,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    self._dragLayer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self._dragLayer)
    self:fixPosition()
end

--坐标是否在屏幕内
function DragScale:isPosInScreen(pos)
    if pos == nil then
        return false
    end
    local rect = cc.rect(0,0,util.display.width,util.display.height)
    return cc.rectContainsPoint(rect,pos)
end
function DragScale:stopMove()
    self._dragLayer:stopAllActions()
    self._scale = self._dragLayer:getScale()
    if self.schedule then
	    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedule)
        self.schedule = nil
    end
end

--使用time时间,匀减速移动到tagPos的位置
function DragScale:startMove(tagPos,time)
    self:stopMove()
    if time ==nil or time ==0 then
        self:setXYbyScale(tagPos)
        return
    end
    local nowTime = os.clock()
    local stopTime = nowTime + time
    local lastPos = cc.p(self._dragLayer:getPosition())
    if tagPos.x == lastPos.x and tagPos.y == lastPos.y then
        return
    end

    local function setNewPos()
        local now = os.clock()
        if now == nowTime then
            return
        end
        local posDelta = cc.pSub(tagPos,lastPos)
        --这里做匀减速运动
        local timePass = now - nowTime
        posDelta = cc.pMul(posDelta,math.min(1,timePass*(2*time - timePass)/time/time))
        self:setXYbyScale(cc.pAdd(lastPos,posDelta))
    end

    self.schedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
        if not (self and self._dragLayer) then
            return
        end
        if os.clock() > stopTime then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedule)
            self.schedule = nil
            setNewPos()
            return
        end
        setNewPos()
    end,0, false)
end

function DragScale:notifyClick(touch)
    local pos = self._dragLayer:convertToNodeSpace(touch:getLocation())
    -- print("点击结束 ",math.floor(pos.x),math.floor(pos.y),touch:getLocation().x,touch:getLocation().y)
    self:dispatchEvent({name="touchMap",data = {x=math.floor(pos.x),y=math.floor(pos.y)}})
end

function DragScale:fixPosition()
    -- print("fixPosition()")
    self:setXY(self:getFixPosition(self._dragLayer:getScale(),cc.p(self._dragLayer:getPosition())))
end

--这个来跳转可能出现黑边,用来显示建筑详情用
function DragScale:setXY(pos,time)
    self:setXYbyScale(pos,time,self._scale)
end

--这个跳转用来移动地图用 scale 为空
function DragScale:setXYbyScale(pos,time,scale)
    scale =  scale or self._dragLayer:getScale()
    pos = self:getFixPosition(scale,pos)
    if time then
        self._dragLayer:runAction(cc.MoveTo:create(time,pos))
    else
        self._dragLayer:setPosition(pos)
    end
end

function DragScale:getPosition()
    local x,y = self._dragLayer:getPosition()
    local scale = 1--self._dragLayer:getScale()
    return cc.p(x*scale,y*scale - util.display.offy/2)
end

function DragScale:getFixPosition(scale,new_point)
    local size = self._dragLayer:getContentSize()
    size.width = size.width*scale
    size.height = size.height*scale
    local achor_point = self._dragLayer:getAnchorPoint()
    local win_size = cc.size(util.display.width,util.display.height)
    
    local min_x = win_size.width -size.width *(1-achor_point.x)-self._dragLayer:getAnchorPoint().x
    local max_x = 0+size.width*achor_point.x-self._dragLayer:getAnchorPoint().x

    local min_y = win_size.height - size.height * (1-achor_point.y) -self._dragLayer:getAnchorPoint().y+ util.display.offy
    local max_y = 0 +size.height* achor_point.y-self._dragLayer:getAnchorPoint().y + util.display.offy

    if new_point.x < min_x then
        new_point.x = min_x
    end
    if new_point.x > max_x then
        new_point.x = max_x
    end
    if new_point.y < min_y then
        new_point.y = min_y
    end
    if new_point.y > max_y then
        new_point.y = max_y
    end
    return new_point
end

function DragScale:jumpBack(notJumppos)
   self._dragLayer:runAction(cc.ScaleTo:create(TIME_JUMP,self._scale))
    if self._oldPos then
        if not notJumppos then
            self._dragLayer:runAction(cc.MoveTo:create(TIME_JUMP,self._oldPos))
        end
        self._oldPos = nil
    end  
end

--保持中心位置不变的缩放
function DragScale:doScaleAction(scale)
    if type(scale) ~= "number" then
        trace("error:DragScale:doScaleAction wrong scale"..tostring(scale))
        return
    end
    
    self:setScaleAndMove(scale,nil,TIME_JUMP)
end

function DragScale:jumpPosition(new_x, new_y,center)
     if not center then
        if self._oldPos then
            return
        end

        self._oldPos = cc.p(self._dragLayer:getPosition())
        self._dragLayer:runAction(cc.ScaleTo:create(TIME_JUMP,1))
        self._dragLayer:runAction(cc.MoveTo:create(TIME_JUMP,cc.p(new_x, new_y+ util.display.offy/2)))
    else
        self:setXY(cc.p(new_x*self._scale, new_y*self._scale+ util.display.offy/2),TIME_JUMP)
     end
end

function DragScale:setTouchSwallow(bSwallow)
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(bSwallow)
end

function DragScale:setScaleback(posCenter)
    local scale = math.min(MAX_SCALE_MOVEED,math.max(MIN_SCALE_MOVEED, self._scale));
    
    self:setScaleAndMove(scale,posCenter,0.5)
end

--保持posCenter位置在两指之间的缩放
function DragScale:setScaleAndMove(scale,posCenter,time)
    if scale == self._scale then
        return
    end
    if posCenter == nil then
        posCenter = util.display.center
    end
    local posDelta = cc.pSub(posCenter,cc.p(self._dragLayer:getPosition()))
    posDelta = cc.pMul( posDelta,scale/self._scale)
    if time then
        local actoinScale = cc.ScaleTo:create(time,scale)
        local actoinMove = cc.MoveTo:create(time,self:getFixPosition(scale,cc.pSub(posCenter,posDelta)))
        local action = cc.Spawn:create( actoinMove, actoinScale )
        self._dragLayer:runAction(action)
    else
        self._dragLayer:setScale(scale)
        self:setXY(cc.pSub(posCenter,posDelta))
    end

    self._scale = scale
end

return DragScale