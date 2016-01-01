local Storage = {}

local userConfig = {}
local json = require("util.json")

local file = require("util.File")

Storage.path = jfile.wirtePath


function Storage.load()
	Storage.path = Storage.path .."config.byte"

	if file.exists(Storage.path) then 
		local jsondata = file.read(Storage.path)
		userConfig = json.decode(jsondata)
	else
		print("sysconfig is nil and create new !!")
		Storage.save()
	end
end

function Storage.getkey(key)
	return userConfig[key]
end

function Storage.setkey(key)
	userConfig[key]=value
end

function Storage.save()
	file.save(Storage.path,json.encode(userConfig))
end

function Storage.trace()
	print(json.encode(userConfig))
end

return Storage

