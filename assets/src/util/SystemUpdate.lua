--系统更新 zj

local SystemUpdate = class("SystemUpdate")

local device = require("util.device")

local File = require("util.File")

local lfs = require("lfs")

--版本跟新进度条事件
SystemUpdate.SystemUpdateprogress = "SystemUpdateprogress"
SystemUpdate.SystemZipprogress = "SystemZipprogress"
SystemUpdate.closeSystemUpdateprogress = "closeSystemUpdateprogress" 


function SystemUpdate.create()
    local state = SystemUpdate.new()
    return state
end

function SystemUpdate:ctor()
	EventProtocol.extend(self)

	
end

function SystemUpdate:updateInfobox(title,msg,sf,sfHandler,typeBut)
	local temp = require("ui.tip.updateInfobox")
    local item = temp.create()
	local tip = item.root

    tip.lbl_title:setString(title)
    List = require("util.List")
    RichTextFormat = require("util.RichTextFormat")
	RichTextArea = require("util.RichTextArea")
	css =  require("modules.Common.css")

    local rich = RichTextArea.create(
        tip.pnl_detail:getContentSize().width,
        tip.pnl_detail:getContentSize().height
        )

    tip.pnl_detail:addChild(rich)

    rich:appendText(msg)

    if typeBut == "ok" then
        tip.btn_yes:setVisible(false)
        tip.btn_no:setVisible(false)

        local function btnOK( ... )
            tryRemove(tip)
            if sfHandler then
                 local backFun =  handler(sf, sfHandler)
                 if sfHandler then
                     backFun("ok")
                 end
            end 
        end 

        clickSelf(self,tip.btn_ok,btnOK)
    else
        tip.btn_ok:setVisible(false)
        local function btnYES( ... )
            tryRemove(tip)
            if sfHandler then
                 local backFun =  handler(sf, sfHandler)
                 if sfHandler then
                     backFun("yes")
                 end
            end 
        end
        clickSelf(self,tip.btn_yes,btnYES)
        local function btnNO( ... )
            tryRemove(tip)
            if sfHandler then
                 local backFun =  handler(sf, sfHandler)
                 if sfHandler then
                     backFun("no")
                 end
            end 
        end
        clickSelf(self,tip.btn_no,btnNO)        
    end 

    cc.Director:getInstance():getRunningScene():addChild(tip)
    return tip
end


--检查版本
function SystemUpdate:checkVersion(configtab)
	--traceObj(configtab["config"])
	local tab = json.decode(configtab["config"])
	tab.Version = tonumber(tab.Version)
	tab.isForceUpdate = tonumber(tab.isForceUpdate)
	tab.smallVersionMd5 = tonumber(tab.smallVersionMd5)
	--traceObj(tab)
	-- local temp = {}
	-- tab = {}
	-- local tempTab1 = string.split(configtab["config"],",")
	-- for k,v in pairs(tempTab1) do
	-- 	local  tempTab2 = string.split(v,":")
	-- 	temp[1+#temp] = tempTab2[2]
	-- end
	-- tab.Version = tonumber(temp[1]) -- 当前版本号
	-- tab.packVersionCode = temp[2] -- 包的版本号
	-- tab.resurl = temp[3] -- 服务器更新地址
	-- tab.newPackDownLoadUrl = temp[4] -- 新包下载地址
	-- tab.isForceUpdate = tonumber(temp[5])	 -- 强制更新  
	-- tab.operateConfigData = temp[6]	-- 运营配置数据
	-- tab.smallVersionMd5 = temp[7] -- 当前小版本包MD5
	
	-- self.minDownLoadVersion = 1
	-- self.maxDownLoadVersion = 20
	-- info.resurl = "http://resmobi.dc2.aiyounet.cn/v22/"
	-- local downFileName = "config_swiuc_android.xml"
	-- info.resurl = "http://resmobi.dc2.aiyounet.cn/v22/data_swiuc_android/"
	-- local downFileName = "1-19.zip"	
	-- info.resurl = "http://res.ugh.dc2m.gamedp.com/v22/data_ughhd_android/"
	-- local downFileName = "1-22.zip"	

	self.isUpdateComplete = false
	self.versionFaild = ""
	
	self.configInfo = tab
	
	-- 初始化数据
	trace("rootPath:"..File.root)
	self.tempVersionDirName = "tempVersionDir"
	self.historyVersionDirName = "historyVersionDir"
	self.versionFilePath = File.root.."version.txt"
	self.historyVersionFilePath = File.root.."version_history.txt"
	self.tempVersionDirPath = File.root..self.tempVersionDirName
	self.historyVersionDirPath = File.root..self.historyVersionDirName
		
	-- 1 是否需要换包
	local isReplacePack, isJumpUpdate = self:isChangePackage()
	if isReplacePack then 
		-- 移除两个目录下所有文件
		self:reCreateDir(self.tempVersionDirPath)
		self:reCreateDir(self.historyVersionDirPath)
			
		-- Version重置为1
		self:saveLocalVesion(1)
		self:saveHistoryVersion(1)
		
		-- 提醒玩家去下载新包
		self:updateInfobox(Language.get("10001"), Language.get("10002"), self, self.changePackage, "ok")
		return
	end
	
	-- 判断本地版本文件是否存在
	local localVersion = 1
	if File.exists(self.versionFilePath) then -- 非首次进游戏
		localVersion = self:getVersion(self.versionFilePath)
	else
		self:reCreateDir(self.tempVersionDirPath)
		self:reCreateDir(self.historyVersionDirPath)
		
		self:saveLocalVesion(1)
		self:saveHistoryVersion(1)
	end
	trace("new   version:"..tab.Version)
	trace("local version:"..localVersion)
	
	-- 本地包版本号高于线上配置的包版本号 直接跳过更新
	if isJumpUpdate then
		trace("---本地包版本号高于线上包版本号 jump update--------")
		self:setIsUpdateComplete(true, false)
		return
	end	
	
	-- 2 是否需要更新
	self.localVersion = localVersion
	if tab.Version > localVersion then -- 增量更新
		self.updateType = 1		
		local isExcuteForce = false
		if tab.isForceUpdate > 0 and tab.isForceUpdate < tab.Version then -- 强制更新
			if tab.isForceUpdate == localVersion then
				-- 1更新到最新版本 2不更新
				self:updateInfobox(Language.get("10001"), Language.get("10004"), self, self.forceUpdateVersion1)
			elseif tab.isForceUpdate > localVersion then
				-- 1更新到最新版本 2更新到可靠版本
				self:updateInfobox(Language.get("10001"), Language.get("10005"), self, self.forceUpdateVersion2)
			else
				-- 错误的强制更新
				isExcuteForce = true
			end		
		else
			isExcuteForce = true
		end
		if isExcuteForce then
			self.minDownLoadVersion = localVersion
			self.maxDownLoadVersion = tab.Version
			self:updateInfobox(Language.get("10001"), Language.get("10003"), self, self.updateNewVersion, "ok")			
		end		
	elseif tab.Version < localVersion then -- 版本回退
		self.maxDownLoadVersion = tab.Version
		local localHistoryVersion = self:getVersion(self.historyVersionFilePath)
		if tab.Version == localHistoryVersion then
			self:updateInfobox(Language.get("10001"), Language.get("10009"), self, self.fallBackVersion, "ok")
		elseif tab.Version > localHistoryVersion then -- 回退多个版本 下载部分资源
			self.updateType = 2
			self.minDownLoadVersion = localHistoryVersion
			self:updateInfobox(Language.get("10001"), Language.get("10010"), self, self.updateNewVersion, "ok")
		else -- 回退多个版本 重新下载全部资源
			trace("版本回退异常")
			self.updateType = 3
			self.minDownLoadVersion = 1
			self.maxDownLoadVersion = tab.Version
			self:updateInfobox(Language.get("10001"), Language.get("10011"), self, self.updateNewVersion, "ok")
		end
	else
		trace("不更新 进入游戏")
		self:setIsUpdateComplete(true, false)
	end
end

function SystemUpdate:setIsUpdateComplete(bool, isReLoad)
	if isReLoad then
		-- 清理 lua
		local clearTab = {}
		for k,v in pairs(package.loaded) do
			if not G_Loaded[k] then
				table.insert(clearTab, k)
			end
		end
		trace("clear count:"..#clearTab)
		for k,v in pairs(clearTab) do
			package.loaded[v] = nil
			trace("clear:"..v)		
		end
		self:dispatchEvent({name=SystemUpdate.closeSystemUpdateprogress})

		cc.FileUtils:getInstance():purgeCachedEntries() -- 资源缓存	
		
		-- 重启游戏
		reloadGame()
	end
	self.isUpdateComplete = bool
end

function SystemUpdate:getIsUpdateComplete()
	return self.isUpdateComplete
end

function SystemUpdate:setVersionFaild(val)
	self.versionFaild = val
end

function SystemUpdate:getVersionFaild()
	return versionFaild
end

function SystemUpdate:forceUpdateVersion1(param)
	local info = self.configInfo
	if param == "yes" then
		self.minDownLoadVersion = self.localVersion
		self.maxDownLoadVersion = info.Version
		self:updateNewVersion()
	elseif param == "no" then
		trace("不更新 进入游戏")
		self:setIsUpdateComplete(true, false)
	end
end

function SystemUpdate:forceUpdateVersion2(param)
	local info = self.configInfo
	if param == "yes" then -- 1更新到最新版本
		self.minDownLoadVersion = self.localVersion
		self.maxDownLoadVersion = info.Version	
	elseif param == "no" then -- 2更新到可靠版本
		self.minDownLoadVersion = self.localVersion
		self.maxDownLoadVersion = info.isForceUpdate	
	end
	self:updateNewVersion()	
end

function SystemUpdate:getVersion(path)
	local fileStr = File.read(path)	-- 读取文件内容
	local tempTab = string.split(fileStr, "=")
	local versionCode
	if tempTab and tempTab[2] then
		versionCode = tonumber(tempTab[2])
	end
	if not versionCode then
		versionCode = 1
	end
	return versionCode
end

-- 换包 跳转到页面下载
function SystemUpdate:changePackage( ... )

end

-- 更新到新版本
function SystemUpdate:updateNewVersion()
	trace("更新到新版本")
	local info = self.configInfo	
	self.downFileName = self.minDownLoadVersion.."-"..self.maxDownLoadVersion..".zip"
	Loader:shared():setRemotePath(info.resurl)
	Loader:shared():load(self.downFileName, handler(self, self.downCallback))
end

function SystemUpdate:downCallback(result)
	traceObj(result)
	self.downSize = result.downsize
	self.totalSize = result.totalsize
	self.gprogress = result.gprogress
	if result.state == 0 then
	elseif result.state == 1 then
	elseif result.state == 2 then -- 下载中 更新显示
		trace("已下载："..result.gprogress)
		self:dispatchEvent({name=SystemUpdate.SystemUpdateprogress,data=result.gprogress})
	elseif result.state == 3 then -- 下载完成
		trace("下载完成")
		if self.updateType == 1 then
			-- 拷贝目录
			self:copyTempToHistory()
			self:reCreateDir(self.tempVersionDirPath)
		elseif self.updateType == 2 then
			-- 重新创建
			self:reCreateDir(self.tempVersionDirPath)
		elseif self.updateType == 3 then
			-- 重新创建
			self:reCreateDir(self.tempVersionDirPath)
			self:reCreateDir(self.historyVersionDirPath)
		end
		-- 解压文件
		self:unpackFile()
	elseif result.state == 4 then
		trace("下载失败")
		self:setVersionFaild("n_4")
		self:updateInfobox(Language.get("10001"), string.formatIndex(Language.get("10008"), self.versionFaild), self, self.exitGame, "ok")
	else
		trace("下载异常")
		self:setVersionFaild("n_"..result.state)
		self:updateInfobox(Language.get("10001"), string.formatIndex(Language.get("10008"), self.versionFaild), self, self.exitGame, "ok")
	end
end

-- 版本回退
function SystemUpdate:fallBackVersion()
	trace("版本回退")
	self:reCreateDir(self.tempVersionDirPath)
	local info = self.configInfo	
	self:saveLocalVesion(self.maxDownLoadVersion)
	trace("更新完成 进入游戏")
	self:setIsUpdateComplete(true, true)
end

-- 将temp目录下文件拷贝到history目录下
function SystemUpdate:copyTempToHistory()
	trace("拷贝开始 temp 到 history")
	local rootPath2 = ""
	local copyCmd = ""
	local cmdOption = ""
	local copyTempPath = ""
	if __Platform__ == 3 or __Platform__ ==4 or __Platform__==5 then -- linux
		--ios下会出问题
		rootPath2 = File.root
		copyTempPath = rootPath2..self.tempVersionDirName
	else -- window
		rootPath2 = string.gsub(File.root, "/", "\\")
		copyTempPath = rootPath2..self.tempVersionDirName
	end
	local copyHistoryPath = rootPath2..self.historyVersionDirName
	trace("拷贝完成")
	File.copyDir(copyTempPath,copyHistoryPath)
	trace("拷贝完成")
	-- local ret = os.execute(cmd)
	-- if ret == 0 then
	-- 	
	-- else
	-- 	trace("拷贝失败:"..ret)
	-- 	self:setVersionFaild("c_"..ret)
	-- end
end

-- 解压文件到temp文件夹
function SystemUpdate:unpackFile()
	trace("解压开始")
	self.localZipPath = File.root..self.downFileName
	AsynZip:unpack(handler(self, self.unpackFileCallback), self.localZipPath, self.tempVersionDirPath.."/")
end

-- 解压文件回调
function SystemUpdate:unpackFileCallback(result)
	traceObj(result)
	if result.state == "completed" then -- 解压完成
		if result.msg == "ok" then
			trace("解压完成")
			-- 删除下载包
			if File.exists(self.localZipPath) then
				File.removeFile(self.localZipPath)
			end
			trace("删除下载包")				
			if self.updateType == 1 then
				-- 保存版本号
				self:saveLocalVesion(self.maxDownLoadVersion)
				self:saveHistoryVersion(self.minDownLoadVersion)			
			elseif self.updateType == 2 then
				-- 拷贝目录
				self:copyTempToHistory()
				-- 保存版本号
				self:saveLocalVesion(self.maxDownLoadVersion)
				self:saveHistoryVersion(self.maxDownLoadVersion)
			elseif self.updateType == 3 then
				-- 保存版本号
				self:saveLocalVesion(self.maxDownLoadVersion)
				self:saveHistoryVersion(self.minDownLoadVersion)
			end	
			trace("更新完成 进入游戏")
			self:setIsUpdateComplete(true, true)
		else
			trace("解压失败:"..result.msg)
			self:setVersionFaild("u_"..result.msg)
		end
	else
		trace("解压中:"..result.m_cur.."/"..result.m_max)
		self:dispatchEvent({name=SystemUpdate.SystemZipprogress,data={index=result.m_cur,total=result.m_max}})
	end			
end

-- 保存版本号到本地
function SystemUpdate:saveLocalVesion(num)
	trace("保存版本号 ："..num)
	File.save(self.versionFilePath, "Version="..num)	
end

-- 保存history版本号
function SystemUpdate:saveHistoryVersion(num)
	trace("保存history版本号 ："..num)
	File.save(self.historyVersionFilePath, "HistoryVersion="..num)
end

-- 是否需要换包
function SystemUpdate:isChangePackage()
	local info = self.configInfo
	local packVersionCode = ""
	if __Platform__ == 3 then
		local luaj = require "cocos.cocos2d.luaj"
		local className = "com/cocos2dx/sample/LuaJavaBridgeTest/LuaJavaBridgeTest"
		local args = {}
		local sigs = "()I"
		local state, ret = luaj.callStaticMethod(className,"getVersion",args,sigs)
		traceObj(state, "state")
		traceObj(ret, "ret")
		packVersionCode = tostring(ret)
	elseif __Platform__ ==4 or __Platform__==5 then
		-- local luaoc = require "cocos.cocos2d.luaoc"
		-- local className = "LuaObjectCBridgeTest"
		-- local state,ret  = luaoc.callStaticMethod(className,"getBuildVersion")
		-- traceObj(state, "state")
		-- traceObj(ret, "ret")		
		-- packVersionCode = tostring(ret)
		--TODO 
		return false
	else
		return false
	end
	-- info.packVersionCode = 1
	-- packVersionCode = 2
	local linePackVerison = string.split(info.packVersionCode, ".") 
	local localPackVerison = string.split(packVersionCode, ".")
	local line_tab = {}
	local ver_tab = {}
	for k,v in pairs(linePackVerison) do
		local num = tonumber(v) or 0
		table.insert(line_tab, num)
	end
	for k,v in pairs(localPackVerison) do
		local num = tonumber(v) or 0
		table.insert(ver_tab, num)
	end	
	local len1 = #line_tab
	local len2 = #ver_tab
	local len = 0
	local tmpTab = {}
	local diffNum = 0
	if len1 > len2 then
		diffNum = len1-len2
		len = len1
		tmpTab = ver_tab
	elseif len1 < len2 then
		diffNum = len2-len1
		len = len2
		tmpTab = line_tab
	else
		len = len1
	end
	for i=1, diffNum do
		table.insert(tmpTab, 0)
	end
	traceObj(line_tab, "line_tab")
	traceObj(ver_tab, "ver_tab")
	trace("len："..len)
	local isReplacePack = false -- 是否换包
	local isJumpUpdate = false -- 是否跳过更新
	for i=1, len do
		if line_tab[i] > ver_tab[i] then
			isReplacePack = true
			break
		elseif line_tab[i] < ver_tab[i] then
			isReplacePack = false
			isJumpUpdate = true
			break
		end
	end
	trace("isReplacePack:", isReplacePack)
	trace("isJumpUpdate:", isJumpUpdate)

	return isReplacePack, isJumpUpdate
end

-- 删除目录并且重建目录
function SystemUpdate:reCreateDir(path)
	if File.isDirExist(path) then
		File.removeDir(path)
	end
	File.createDir(path)
end

function SystemUpdate:getTotalSize()
	return self.totalSize or 0
end

function SystemUpdate:getDownSize()
	return self.downSize or 0
end

function SystemUpdate:getProgress()
	return self.gprogress or 0
end

function SystemUpdate:exitGame()
	trace("退出游戏")
	os.exit()
end

--更新下载状态 dispath
function SystemUpdate:updateDownState( ... )
	
end

--设置版本更新内容   这个按项目来配置来 
function SystemUpdate:setVersionInfo( xmlContent )
	
end

--获取当前服务器配置
function SystemUpdate:getState()
	
end


return SystemUpdate