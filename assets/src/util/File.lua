--[[
lfs.attributes (filepath [, attributename])
lfs.chdir (path)  This function changes the working (current) directory
lfs.currentdir ()
lfs.dir (path)
lfs.lock (fh, mode)
lfs.lock_dir (path)
lfs.mkdir (path)
lfs.rmdir (path)
lfs.setmode (filepath, mode)
lfs.symlinkattributes (filepath {, attributename}) -- thanks to Sam Roberts
lfs.touch (filepath {, atime {, mtime}})
--]]
local io = io 
local string = string
local lfs = require "lfs"
local File = {}
local fileinstance = cc.FileUtils:getInstance()

File.root = fileinstance:getWritablePath()
File.wirtePath = fileinstance:getWritablePath()


function File.fullPath( file )
    return fileinstance:fullPathForFilename(file)
end

function File.exists(path)
    return cc.FileUtils:getInstance():isFileExist(path)
end

function File.isDirExist(path)
	return cc.FileUtils:getInstance():isDirectoryExist(path)
end

function File.removeDir(path)
	if __Platform__ == 3 or __Platform__ ==4 or __Platform__==5 then
		File.rmdir(path)
	else
		if string.sub(path, -1) ~= '/' then
			path = path..'/'
		end
		trace("remove path:"..path)
		cc.FileUtils:getInstance():removeDirectory(path)
		while(File.isDirExist(path))
		do
		   trace("removeing.....")
		end		
	end
end

function File.removeFile(path)
	cc.FileUtils:getInstance():removeFile(path)
end

function File.createDir(path)
	trace("create path:"..path)
	local val = cc.FileUtils:getInstance():createDirectory(path)
	traceObj(val)
end

function File.copyDir(srcpath,tarpath)
    -- print(srcpath,tarpath)
    local srcfile 
    local tarfile
    for file in lfs.dir(srcpath) do
        if file ~= "." and file ~= ".." then
            local srcfile = srcpath..'/'..file
            local tarfile = tarpath..'/'..file
            -- print("copy",srcfile)
            local attr = lfs.attributes (srcfile)
            if (type(attr) == "table") then 
                if attr.mode == "directory" then
                    if not File.isDirExist(tarfile) then 
                        File.createDir(tarfile)
                    end
                    File.copyDir(srcfile,tarfile)
                else
                    File.copyFile(srcfile,tarfile)
                end
            else
               
            end
        end
    end
end

function File.copyFile(src,tar)
    -- print(src,tar)
    local data = File.read(src)
    File.save(tar,data,"w")
end


function File.save(path,content,mode)
    path = File.fullPath(path)
	mode = mode or "w+b"
    local file = io.open(path, mode)
    if file then
        if file:write(content) == nil then return false end
        io.close(file)
        return true
    else
        return false
    end
end

function File.readByteFile(path)
    return Path:getFileData(path)
end


function File.read(path)
    path = File.fullPath(path)
	local file = io.open(path, "rb")
    if file then
        local content = file:read("*a")
        io.close(file)
        return content
    end
    return nil
end

function File.mkdir(path)
    if not File.exists(path) then
        return lfs.mkdir(path)
    end
    return true
end

function File.rmdir(path)
    print("os.rmdir:", path)
    if File.exists(path) then
        local function _rmdir(path)
            local iter, dir_obj = lfs.dir(path)
            while true do
                local dir = iter(dir_obj)
                if dir == nil then break end
                if dir ~= "." and dir ~= ".." then
                    local curDir = path..dir
                    local mode = lfs.attributes(curDir, "mode") 
                    if mode == "directory" then
                        _rmdir(curDir.."/")
                    elseif mode == "file" then
                        os.remove(curDir)
                    end
                end
            end
            local succ, des = os.remove(path)
            if des then print(des) end
            return succ
        end
        _rmdir(path)
    end
    return true
end

function File.pathinfo(path)
    path = File.fullPath(path)
    local pos = string.len(path)
    local extpos = pos + 1
    while pos > 0 do
        local b = string.byte(path, pos)
        if b == 46 then -- 46 = char "."
            extpos = pos
        elseif b == 47 then -- 47 = char "/"
            break
        end
        pos = pos - 1
    end

    local dirname = string.sub(path, 1, pos)
    local filename = string.sub(path, pos + 1)
    extpos = extpos - pos
    local basename = string.sub(filename, 1, extpos - 1)
    local extname = string.sub(filename, extpos)
    return {
        dirname = dirname,
        filename = filename,
        basename = basename,
        extname = extname
    }
end

function File.filesize(path)
    path = File.fullPath(path)
    local size = false
    local file = io.open(path, "r")
    if file then
        local current = file:seek()
        size = file:seek("end")
        file:seek("set", current)
        io.close(file)
    end
    return size
end

return File

