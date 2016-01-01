
-- Author:zj
-- Date: 2015-07-02 18:04:51
--
local lfs = require("lfs")
require("cocos.cocos2d.functions")

--扫描目录  找到文件就回调
local function scanDir( path,depth,fileCallback)
	for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path..'/'..file
            local attr = lfs.attributes (f)
            if (type(attr) == "table") then 
                if attr.mode == "directory" and depth >0 then
                    scanDir(f,depth-1,fileCallback)
                else
                	fileCallback(f)
                end
            else
                print(attr,"error")
            end
        end
    end
end

local function convertCsd2Lua(path)
	local info = io.pathinfo(path)
	if info.extname == ".csd" then 
		local csdFile = path
		local luaFile = string.gsub(path, ".csd", ".lua")
		luaFile = string.gsub(luaFile,"cocosstudio","assets/src/ui")

		local luaPathInfo = io.pathinfo(luaFile)
		lfs.mkdir(luaPathInfo.dirname)
						
		-- print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
		-- print("【.csd】: " .. csdFile)
		-- print("【.lua】: " .. luaFile)
		
		require("ccext.csd2lua").new():csd2lua(csdFile, luaFile)
	end
end


--[[
    调试信息过渡
    添加util.functions 中trace 和traceObj的过滤

    1,在assets\src 中添加 debugFilter.txt 文件
    2,在文件中添加想要关注的模块名,如playerdata(大小写不敏感,一行写一个)
    3,运行游戏,此时,打印出来的调试信息,只有playerdata模块的
    4,如果想屏蔽某些模块的调试信息,则在模块名前加个'-'号,此时,除了加了负号的模块,其他模块全显示
    5,如果不想要此屏蔽功能,可删除txt所有内容,或直接删除debugFilter.txt
]]
local function addDebugFilter()
    s_moduleNames = s_moduleNames or  {}

    local function addTraceModules(name)
        if type(name) == "string" then
            s_moduleNames[string.lower(name)] = true
        elseif  type(name) == "table" then
            for i,j in pairs(name) do
                s_moduleNames[string.lower(i)] = true
            end
        end
    end

    local function delTraceModules(name)
        s_moduleNames["All"] = true
        if type(name) == "string" then
            s_moduleNames[string.lower(name)] = false
        elseif  type(name) == "table" then
            for i,j in pairs(name) do
                s_moduleNames[string.lower(i)] = false
            end
        end
    end

    local path = "../../assets/src/debugFilter.txt"
    local temTab
	if path then 
        local str = cc.FileUtils:getInstance():getStringFromFile(path)
        if str=="" then
            return
        end
        if string.sub(str,-1,1) ~= "\n" then
            str = str .. "\r\n"
        end
        for line in string.gmatch(str,"(.-)\r\n") do
            if line:gsub(" ","") ~= "" then
                if line:sub(1,1) == "-" then
                    delTraceModules(line:sub(2))
                else
                    addTraceModules(line)
                end
            end
        end
    end
end

-- 平台 0-window,1-linux,2-mac,3-android, 4-iphone,5-ipad
if __Platform__ == 2 or __Platform__ == 4 or __Platform==5 then
	scanDir("/Volumes/osxwork/opt/cok/client/trunk/coe/coe/cocosstudio/csb",10,convertCsd2Lua)
elseif __Platform__ == 0 then 
    addDebugFilter()
	scanDir("../../cocosstudio",10,convertCsd2Lua)
end