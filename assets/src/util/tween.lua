local assert = assert
local tween = {}

local ACTION_EASING = {}
ACTION_EASING["BACKIN"]           = {cc.EaseBackIn, 1}
ACTION_EASING["BACKINOUT"]        = {cc.EaseBackInOut, 1}
ACTION_EASING["BACKOUT"]          = {cc.EaseBackOut, 1}
ACTION_EASING["BOUNCE"]           = {cc.EaseBounce, 1}
ACTION_EASING["BOUNCEIN"]         = {cc.EaseBounceIn, 1}
ACTION_EASING["BOUNCEINOUT"]      = {cc.EaseBounceInOut, 1}
ACTION_EASING["BOUNCEOUT"]        = {cc.EaseBounceOut, 1}
ACTION_EASING["ELASTIC"]          = {cc.EaseElastic, 2, 0.3}
ACTION_EASING["ELASTICIN"]        = {cc.EaseElasticIn, 2, 0.3}
ACTION_EASING["ELASTICINOUT"]     = {cc.EaseElasticInOut, 2, 0.3}
ACTION_EASING["ELASTICOUT"]       = {cc.EaseElasticOut, 2, 0.3}
ACTION_EASING["EXPONENTIALIN"]    = {cc.EaseExponentialIn, 1}
ACTION_EASING["EXPONENTIALINOUT"] = {cc.EaseExponentialInOut, 1}
ACTION_EASING["EXPONENTIALOUT"]   = {cc.EaseExponentialOut, 1}
ACTION_EASING["IN"]               = {cc.EaseIn, 2, 1}
ACTION_EASING["INOUT"]            = {cc.EaseInOut, 2, 1}
ACTION_EASING["OUT"]              = {cc.EaseOut, 2, 1}
ACTION_EASING["RATEACTION"]       = {cc.EaseRateAction, 2, 1}
ACTION_EASING["SINEIN"]           = {cc.EaseSineIn, 1}
ACTION_EASING["SINEINOUT"]        = {cc.EaseSineInOut, 1}
ACTION_EASING["SINEOUT"]          = {cc.EaseSineOut, 1}


local actionManager = cc.Director:getInstance():getActionManager()

local keyMap = {"x","y","scale","scaleX","scaleY","alpha","offx","offy","rotate",
				"time","delay","callback","ease","easeParams","count",
				"reversed","repeatDelay","yoyo"} --no super now

--[[
tween.to(node,0.5,{delay=2,scale=0.6,x=20})
]]
--执行单个时间短的多个参数变化
function tween.to( target , time , vars ,repeatCount)
	local actions = tween.new(target,time,vars)
	tween.run(target,actions,vars.count or repeatCount)
end

--[[
tween.list(node,{
                {delay=1 ,time= 0.6,scale=0.6},
                {time= 0.4,scale=2,callback=funHandler}
            })
]]
--顺序动画  sequence timeline
function tween.list(target, vars ,repeatCount)
	local preAction
	for k,v in pairs(vars) do
		if preAction then 
			local preDelay = preAction.delay or 0
			local delay = v.delay or 0
			v.delay = delay + preDelay + preAction.time
		end
		tween.to(target,v.time or 0,v,repeatCount)
		preAction = v
	end
end

--组播放 
function tween.group(target, vars ,repeatCount)
	for k,v in pairs(vars) do
		tween.to(target,v.time or 0,v,repeatCount)
	end
end

--停止所有动画
function tween.stop(target)
    if not tolua.isnull(target) then
        actionManager:removeAllActionsFromTarget(target)
    end
end


-- 暂停显示对象上所有正在执行的动作
-- @function [parent=#transition] pauseTarget
-- @param mixed target
function tween.pause(target)
    if not tolua.isnull(target) then
        actionManager:pauseTarget(target)
    end
end

-- 恢复显示对象上所有暂停的动作
-- @function [parent=#transition] resumeTarget
-- @param mixed target
function tween.resume(target)
    if not tolua.isnull(target) then
        actionManager:resumeTarget(target)
    end
end


-------------------------------private function ------------------------

function tween.run( target , actions ,repeatCount)
	for k,action in pairs(actions) do
		if repeatCount then 
			if repeatCount == 0 then
				target:runAction(cc.RepeatForever:create(action))
			else
				target:runAction(cc.Repeat:create(action,repeatCount))
			end
		else
			target:runAction(action)
		end
	end
end

--创建    
function tween.new( target , time , vars  )
	assert(not tolua.isnull(target), "tween.new() - target is not cc.Node")
	assert(time or vars.time,"tween.new() - must has time ")
	
	local actions = {}

	if vars.x or vars.y then 
		local tx, ty = target:getPosition()
	    local x = vars.x or tx
	    local y = vars.y or ty
	    local ac = cc.MoveTo:create(vars.time or time, cc.p(x, y))
	    if vars.ease then 
	    	ac = tween.newEasing(ac,vars.ease,vars.easeParams)
	    end

	    if vars.delay then 
			local delayAction=cc.DelayTime:create(vars.delay)
	    	ac = cc.Sequence:create(delayAction,ac)
	    end
	    table.insert(actions,ac)
	end

	if vars.offx or vars.offy then 
		local x = vars.offx or 0
	    local y = vars.offy or 0
	    local ac = cc.MoveBy:create(vars.time or time, cc.p(x, y))
	    if vars.ease then 
	    	ac = tween.newEasing(ac,vars.ease,vars.easeParams)
	    end

	    if vars.delay then 
	    	local delayAction=cc.DelayTime:create(vars.delay)
	    	ac = cc.Sequence:create(delayAction,ac)
	    end
	    table.insert(actions,ac)
	end

	if vars.rotate then 
	    local ac = cc.RotateTo:create(vars.time, vars.rotate)
	    if vars.ease then 
	    	ac = tween.newEasing(ac,vars.ease,vars.easeParams)
	    end

	    if vars.delay then 
	    	local delayAction=cc.DelayTime:create(vars.delay)
	    	ac = cc.Sequence:create(delayAction,ac)
	    end
	    table.insert(actions,ac)
	end

	if vars.scale or vars.scaleX or vars.scaleY then 
		local ac
	    if vars.scale then
	        ac = cc.ScaleTo:create(tonumber(vars.time or time), tonumber(vars.scale))
	    elseif vars.scaleX or vars.scaleY then
	        local scaleX, scaleY
	        if vars.scaleX then
	            scaleX = tonumber(vars.scaleX)
	        else
	            scaleX = target:getScaleX()
	        end
	        if vars.scaleY then
	            scaleY = tonumber(vars.scaleY)
	        else
	            scaleY = target:getScaleY()
	        end
	        ac = cc.ScaleTo:create(tonumber(vars.time or time), scaleX, scaleY)
	    end
	    if vars.ease then 
	    	ac = tween.newEasing(ac,vars.ease,vars.easeParams)
	    end

	   	if vars.delay then 
	    	local delayAction=cc.DelayTime:create(vars.delay)
	    	ac = cc.Sequence:create(delayAction,ac)
	    end
	    table.insert(actions,ac)
	end

	if vars.alpha then 
		local ac 
		if vars.alpha >= 0.5 then 
			ac = cc.FadeIn:create(vars.time or time)
		else
			ac = cc.FadeOut:create(vars.time or time)
		end
		if vars.ease then 
	    	ac = tween.newEasing(ac,vars.ease,vars.easeParams)
	    end
		if vars.delay then 
			local delayAction=cc.DelayTime:create(vars.delay)
	    	ac = cc.Sequence:create(delayAction,ac)
	    end
		table.insert(actions,ac)
	end

	if vars.callback then 
		local onComplete = vars.callback
		local ac 
	    if type(onComplete) ~= "function" then onComplete = nil end
	    if onComplete then
	        ac = cc.CallFunc:create(onComplete)
	        -- total time 
	        local total = time
	        if vars.delay then 
	        	total =  total + vars.delay 
	        end

	        local timeDelayAction=cc.DelayTime:create(total)
	        ac = cc.Sequence:create(timeDelayAction,ac)
		    
	    end

	    if ac then 
		    table.insert(actions,ac)
		end
	end
	return actions
end


--缓动
function tween.newEasing(action, easingName, more)
    local key = string.upper(tostring(easingName))
    if string.sub(key, 1, 6) == "CCEASE" then
        key = string.sub(key, 7)
    end
    local easing
    if ACTION_EASING[key] then
        local cls, count, default = unpack(ACTION_EASING[key])
        if count == 2 then
            easing = cls:create(action, more or default)
        else
            easing = cls:create(action)
        end
    end
    return easing or action
end




return tween


