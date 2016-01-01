
--动态Plist加载
--部分图片由程序手动加载，因此需要预先导入plist文件

local director = cc.Director:getInstance()
local textureCache = director:getTextureCache()
local spriteFrameCache = cc.SpriteFrameCache:getInstance()

local i = 0

local files = {
	"res/common/Common_1",
	"res/common/Common_2",
	"res/common/Common_6",
	"res/common/Common_7",
	"res/common/Common_5",
	"res/common/Common_204",
    "res/common/Common_205",
	"res/common/Common_208",
	"res/common/Common_206",
	"res/General/General_1",
	"res/General/General_2",
	"res/General/General_3",
	"res/General/General_100",
	"res/General/General_101",
    "res/common/Common_308",
	"res/common/Common_101",
	"res/common/Common_105",
}

for k,v in ipairs(files) do
	local path = v
	textureCache:addImageAsync(path..".png",function ()
		i = i+1
		spriteFrameCache:addSpriteFrames(path..".plist")
		if i >=#files then 
			print(textureCache:getCachedTextureInfo())
		end
	end)
end






