-- WeatherModule.lua
-- Author : fang
-- Date   : 2015/7/31

local WeatherModule = class("WeatherModule")

function WeatherModule.create()
    return WeatherModule.new()
end

function WeatherModule:ctor()

end

-- 初始化天气效果
function WeatherModule:showWeather()
    self.weatherLayer = util.getWeatherLayer()
    -- 天气
    self.timeTickhireWorker = scheduler.scheduleGlobal(handler(self, self.onTimeTick), 10)
end

function WeatherModule:onTimeTick()
    local num = math.random(1000)
    self.weatherLayer:removeAllChildren()
    if num > 0 and num <300 then
        local rain = cc.ParticleSystemQuad:create("particle/rain.plist")
        self.weatherLayer:addChild(rain)
        local dropsWater = cc.ParticleSystemQuad:create("particle/DropsWater.plist")
        self.weatherLayer:addChild(dropsWater)
    elseif num > 300 and num < 600 then
        local sun = cc.ParticleSystemQuad:create("particle/sun.plist")
        self.weatherLayer:addChild(sun)
    end
end

return WeatherModule