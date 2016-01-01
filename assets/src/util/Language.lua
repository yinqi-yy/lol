local io = io 
local string = string
local pairs = pairs
local strgsub = string.gsub
local strmatch = string.match

local Language = {}

local keyvalue = {}

function Language.clear()
	keyvalue = {}
end

function Language.loadLanguageById( languageID )
    if languageID and languageID == 0 or languageID == Enum.gameLanguage.CN then
        return
    end
    Language.clear()

    local LanguageSet = TemplateData:getLanguageSetWithID( languageID )
    if type(LanguageSet)~= "table" then
        trace("Language.loadLanguageById get language fail,languageID = ".. tostring(languageID))
        return
    end
    local dataPath = LanguageSet.filename;
    if dataPath then
         Language.load( "local/"..dataPath..".ini",true)
    end
   
end


--Language.load("lang.txt")
function Language.load( path ,bCover)
	path = File.fullPath(path)
	if path then 
        local str = cc.FileUtils:getInstance():getStringFromFile(path)
        for line in string.gmatch(str,"(.-)\n") do
            local key,value = strmatch(line,"(.-)=(.*)")
			if key ~= nil then 
				if keyvalue[key] == nil or bCover  then 
					keyvalue[key] = strgsub(value,"[ \t\n\r]+$", "")
				else
					if key ~= "" then 
						print("Language key is repeat "..key)
					end
				end
			end
        end
    end
end

function Language.getFormat(key,...)
	return string.formatIndex( Language.get( key ),... )
end

function Language.getFormatBr(key,...)
	return string.formatIndex( Language.getBr( key ),... )
end

function Language.get( key )
    if key == nil then
        return "Not key"
    end
	local value = keyvalue[tostring(key)]
	if value ~=nil then 
		return value
	end
	return "Not find "..key
end

function Language.getBr(key)
	local value = keyvalue[tostring(key)]
	if value ~=nil then 
		return string.gsub(value,"\\n","\n")
	end
	return "Not find "..key
end

function Language.trace()
	-- for k,v in pairs(keyvalue) do
		-- trace(string.format("%-50s = %s",k,v))
	-- end
end

return Language