--翻页按钮
--Author: hzs
--Date: 2015-10-12
--

local PageBtns = class("PageBtns")


function PageBtns.create( ... )
	local pg = PageBtns.new(...)
	return pg
end

--添加按钮
function PageBtns:ctor(midBtn,leftBtn,rightBtn)
    self._pages = {}
    self._selectPage = 1
    self._leftBtn = leftBtn
    self._rightBtn = rightBtn
    self._midBtn = midBtn

    if self._midBtn then
        util.clickSelf(self,self._midBtn,self.onPageClick)
    end
    if self._leftBtn then
        util.clickSelf(self,self._leftBtn,self.pageDown)
    end
    if self._rightBtn then
        util.clickSelf(self,self._rightBtn,self.pageUp)
    end

    self:update()
end

--添加页面,图标,点击时回调
function PageBtns:addPage(pic,clickCallback)
    if not string.find( pic,".png") then
        pic = pic..".png"
    end
    table.insert(self._pages,{pic = pic,clickCallback = clickCallback})
end

function PageBtns:delPages()
    self._pages = {}
    self:upadate()
end

--选择页面
function PageBtns:selectPage(index)
    if index == self._selectPage then
        return
    end
    self._selectPage = index
    self:update()
end

------------------------------------
--private

------------------------------------
function PageBtns:pageUp()
    self._selectPage = self._selectPage + 1
    self:update()
end

function PageBtns:pageDown()
    self._selectPage = self._selectPage - 1
    self:update()
end

function PageBtns:onPageClick()
    if self._pages[self._selectPage] and self._pages[self._selectPage].clickCallback then
        self._pages[self._selectPage].clickCallback()
    end
end


function PageBtns:update()
    if self._selectPage > #self._pages then
        self._selectPage = #self._pages
    end

    if self._selectPage<1 then
        self._selectPage=1
    end

    if self._selectPage <= 1 then
        if self._leftBtn then
            self._leftBtn:setVisible(false)
        end
    else
        if self._leftBtn then
            self._leftBtn:setVisible(true)
        end
    end

    if self._selectPage >= #self._pages then
        if self._rightBtn then
            self._rightBtn:setVisible(false)
        end
    else
        if self._rightBtn then
            self._rightBtn:setVisible(true)
        end
    end

    if self._midBtn then
        if self._pages[self._selectPage] then
            self._midBtn:setVisible(true)
            self._midBtn:loadTextureNormal(self._pages[self._selectPage].pic,1)
            self._midBtn:loadTexturePressed(self._pages[self._selectPage].pic,1)
        else
            self._midBtn:setVisible(false)
        end
    end
end

return PageBtns