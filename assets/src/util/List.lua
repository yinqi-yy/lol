local List = class("List")

function List.create ()
	local list = List.new()
    return list
end

function List:ctor()
	self.first = 0
	self.last = -1
    self.size = 0
end
 
function List:pushleft ( value)
    local first = self.first - 1
    self.first = first
    self[first] = value
    self.size= self.size+1
end
 
function List:pushright ( value)
    local last = self.last + 1
    self.last = last
    self[last] = value
    self.size= self.size+1
end
 
function List:popleft ()
    local first = self.first
    if first > self.last then error("self is empty") end
    local value = self[first]
    self[first] = nil    -- to allow garbage collection
    self.first = first + 1
    self.size= self.size-1
    return value
end

function List:left()
    local first = self.first
    local value = self[first]
    return value
end

function List:num()
    return self.size
end
 
function List:popright ()
    local last = self.last
    if self.first > last then error("self is empty") end
    local value = self[last]
    self[last] = nil     -- to allow garbage collection
    self.last = last - 1
    self.size= self.size-1
    return value
end

return List