local QucikTip = class("QucikTip",function()
	return cc.Label:createWithTTF(css.ttfConfig,"",cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
end)


function QucikTip.create(...)
	local tip = QucikTip.new(...)
	return tip
end

QucikTip.Type_UP = 0  	--绿色向上走
QucikTip.Type_Tip = 1 	--普通提示
QucikTip.Type_Warn = 2 	--红色闪动警告
QucikTip.Type_UPS = 3   --绿色向上队列
QucikTip.Type_UPSRED = 4   --红色向上队列

QucikTip.queue = {}


function QucikTip:ctor(str,showType,index,len)
	showType = showType or QucikTip.Type_Tip

	self:setString(str)
	self:setAnchorPoint(cc.p(0.5, 0.5))

	self:setOpacity(0)
	self:setPosition(util.display.cx-util.display.offx,util.display.height/3-50)
	self:setScale(1.5)
	tween.group(self,{
		{time=0.1,offy=50,alpha=1,scale=0.8,ease="SINEIN"},
		{time=0.3,delay=2,alpha=0,callback=handler(self, self.onRemove)}
		})

	self:adjustPos()
	table.insert(QucikTip.queue, self)

	self:setTextColor(css.QucikTip["fontColor"..showType])
	self:enableOutline(css.outline, 2)
end

function QucikTip:adjustPos()
	for k,v in pairs(QucikTip.queue) do
		v:setPositionY(v:getPositionY()+v:getContentSize().height)
	end
end


function QucikTip:onRemove()
	table.remove(QucikTip.queue,1)
	util.tryRemove(self)
end

return QucikTip