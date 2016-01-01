local GameRoomContr = class("GameRoomContr",function()
	local node = util.createlua(ui.GameRoomContr)
    return node.root
end)


function GameRoomContr.create(...)
    local node = GameRoomContr.new(...)
    return node
end

function GameRoomContr:ctor()
end


function GameRoomContr:addEvents()
end


function GameRoomContr:refresh()
	
end

function GameRoomContr:resize()
end

function GameRoomContr:removeEvents()
end


function GameRoomContr:onGameRoomContr()
end


function GameRoomContr:dispose()
end



return GameRoomContr