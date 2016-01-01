require("json")
local Translator = class("Translator")



--text翻译内容
--language目标语言,默认为中文zh-CHS,其他语言详见https://msdn.microsoft.com/en-us/library/hh456380.aspx
--callbackfun 翻译成功后的回调,(bSuccess,resultText)
function Translator:translate(text,language,callbackfun)
   --[[ if self._access_token == nil then
        callbackfun(false)
        return false
    end]]
    local table = {
        text = text,
        to = language or "zh-CHS",
        appId = "DF9E54CA96F73F2E289AEC059F407DE8295A6515",--"Bearer "..self._access_token,
        content_type = "text/plain",
    }
    --appId 要在 http://www.bing.com/toolbox/bingdeveloper/ 申请,但是没申请成功,这里使用的是别人的ID
    local str = self:encodeTab(table)
   self:get("http://api.microsofttranslator.com/V2/Http.svc/Translate?"..str,function(suc,data)
        if suc then
            local text = string.match(data,".+\">(.*)</string>")
            callbackfun(true,text)
        end
   end)
end

--------------------------------------


--------------------------------------


function Translator:encodeURI(s)
    return (string.gsub(s, "([^A-Za-z0-9_])", function(c)
        return string.format("%%%02x", string.byte(c))
    end))
end

function Translator:encodeTab(tab)
    local str = ""
    for key,value in pairs(tab) do
        str = str..key.."="..self:encodeURI(value).."&"
    end

    str = string.sub(str,0,-2)

    return str
end

function Translator:tab2String(tab)
    local str = ""
    for key,value in pairs(tab) do
        str = str..key.."="..value.."&"
    end

    str = string.sub(str,0,-2)

    return str
end

function Translator:postJson(url,arg,callbackfun)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:open("POST", url)

    local function onReadyStateChange()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            local response   = xhr.response
            local output = json.decode(response,1)
            callbackfun(true,output)
            --print("post suc:")
        else
            --print("post fail")
            callbackfun(false,{readyState= xhr.readyState, status=xhr.status})
        end
    end

    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send(arg)
end

function Translator:get(url,callbackfun)
    --print("get:"..url)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", url)

    local function onReadyStateChange()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            callbackfun(true,xhr.response)
            --print("get succ"..xhr.response)
        else
            callbackfun(false,{readyState= xhr.readyState, status=xhr.status})
            --print("get fail"..xhr.response)
        end
    end
    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send()
end

function Translator.create(...)
    local obj = Translator.new(...)
    return obj
end

function Translator:showDemo()
    local layer = cc.Layer:create()       
    local menuRequest = cc.Menu:create()
    menuRequest:setPosition(cc.p(0,0))
    layer:addChild(menuRequest)
    local winSize = cc.Director:getInstance():getWinSize()
    
    local label = ccui.Text:create():setFontSize(36):setString("waiting..."):setVisible(false)
    label:setAnchorPoint(cc.p(0.5, 0.5))
    label:setPosition(cc.p(winSize.width / 2, winSize.height/2 + 150))
    layer:addChild(label, 0)

    local text = "click here to translate this text"
    local labelGet  = ccui.Text:create():setFontSize(36):setString(text)
    labelGet:setAnchorPoint(cc.p(0.5, 0.5))
    local itemGet  =  cc.MenuItemLabel:create(labelGet)
    itemGet:registerScriptTapHandler(function()
        self:translate(text,nil,function(success,data)
            if success then
                labelGet:setString(data)
            else
                labelGet:setString("fail")
            end
        end)
    end)
    itemGet:setPosition(cc.p(winSize.width / 2, winSize.height/2))
    menuRequest:addChild(itemGet)



    local scene = cc.Scene:create()
    scene:addChild(layer)
    --scene:addChild(CreateBackMenuItem())
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(scene)
    else
        cc.Director:getInstance():runWithScene(scene)
    end
    
    self._DemotitileText = label
    self._ClickMe = labelGet
end

function Translator:XMLHttpRequestLayer()
    local layer = cc.Layer:create()
    local winSize = cc.Director:getInstance():getWinSize()
    local margin = 40
    local space  = 35

    local function init()
        --local label = cc.Label:createWithTTF(css.ttfConfig,"XML Http Request Test")
        local label = cc.Label:create():setString("XML Http Request Test")
        label:setAnchorPoint(cc.p(0.5, 0.5))
        label:setPosition(cc.p(winSize.width / 2, winSize.height - margin))
        layer:addChild(label, 0)

        --Response Code Label
        local labelStatusCode = cc.Label:create():setString("HTTP Status Code")--cc.Label:createWithTTF(css.ttfConfig,"HTTP Status Code")
        labelStatusCode:setAnchorPoint(cc.p(0.5, 0.5))
        labelStatusCode:setPosition(cc.p(winSize.width / 2,  winSize.height - margin - 6 * space))
        layer:addChild(labelStatusCode)

        local menuRequest = cc.Menu:create()
        menuRequest:setPosition(cc.p(0,0))
        layer:addChild(menuRequest)

        --Get
        local function onMenuGetClicked()
            if not self.access_token then
                print("access_token is nill")
                return
            end
            local table = {
                text = "hello",
                to = "zh-CHS",
                appId = "Bearer "..self.access_token,
            }
            local str = self:encodeTab(table)
            --str = str.."&appId="..encodeURI("Bearer "..self.access_token)
            --str = str.."&appId="..encodeURI("Bearer "..self.access_token)
            --str = str.."&from=".."en"
            --str = str.."&to=".."fa"
            --str = str.."&maxTranslations=".."10"
            
            local xhr = cc.XMLHttpRequest:new()
            xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
            --xhr.ContentType="application/x-www-form-urlencoded"
            xhr:open("GET", "http://api.microsofttranslator.com/V2/Http.svc/Translate?"..str)
            print("http://api.microsofttranslator.com/V2/Http.svc/Translate?"..str)

            local function onReadyStateChange()
                if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                    labelStatusCode:setString("Http Status Code:"..xhr.statusText)
                    print(xhr.response)
                    --for i,j in pairs(xhr.response) do
                    --    print(i,j)
                    --end
                else
                    print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
                end
            end
            xhr:registerScriptHandler(onReadyStateChange)
            xhr:send()
            
            labelStatusCode:setString("waiting...")
        end

        local labelGet  = cc.Label:create():setString("trans")--cc.Label:createWithTTF(css.ttfConfig,"Test Get")
        labelGet:setAnchorPoint(cc.p(0.5, 0.5))
        local itemGet  =  cc.MenuItemLabel:create(labelGet)
        itemGet:registerScriptTapHandler(onMenuGetClicked)
        itemGet:setPosition(cc.p(winSize.width / 2, winSize.height - margin - space))
        menuRequest:addChild(itemGet)

        --Post
        local function onMenuPostClicked()
            local xhr = cc.XMLHttpRequest:new()
            xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
            xhr:open("POST", url)
            local function onReadyStateChange()
                if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                    labelStatusCode:setString("Http Status Code:"..xhr.statusText)
                    print(xhr.response)
                else
                    print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
                end
            end
            xhr:registerScriptHandler(onReadyStateChange)	
            --local arg = "grant_type=client_credentials&client_id=cd1b420a-a888-47d6-b844-6bd2855e3d21&client_secret=y+/wsgRh90/2OUpwS/ZoUxdvAegvjTyT+LIkCrEZeGU&scope=http://api.microsofttranslator.com"
            --arg = "grant_type=client_credentials&client_id=cd1b420a-a888-47d6-b844-6bd2855e3d21&client_secret=y%2B%2FwsgRh90%2F2OUpwS%2FZoUxdvAegvjTyT%2BLIkCrEZeGU&scope=http%3A%2F%2Fapi.microsofttranslator.com"

            --print(encodeTab(tbl))
            --[[local core = require "sproto.core"
            
            print(core.encode("playerSearchInfo", tbl))]]
            --print(encodeURIComponent(arg))
            --print(encodeURI(arg))
           -- xhr:send(core.encode("playerSearchInfo", tbl))
           -- xhr:send(arg)
            xhr:send(self:encodeTab(tbl))
            labelStatusCode:setString("waiting...")
        end

        local labelPost = cc.Label:create():setString("Test Post")--cc.Label:createWithTTF(css.ttfConfig,"Test Post")
        labelPost:setAnchorPoint(cc.p(0.5, 0.5))
        local itemPost =  cc.MenuItemLabel:create(labelPost)
        itemPost:registerScriptTapHandler(onMenuPostClicked)
        itemPost:setPosition(cc.p(winSize.width / 2, winSize.height - margin - 2 * space))
        menuRequest:addChild(itemPost)

        --Post Binary
        local function onMenuPostBinaryClicked()
            local xhr = cc.XMLHttpRequest:new()
            xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_ARRAY_BUFFER
            xhr:open("POST", "http://httpbin.org/post")

            local function onReadyStateChange()
                if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                    local response   = xhr.response
                    local size     = table.getn(response)
                    local strInfo = ""
                
                    for i = 1,size do
                        if 0 == response[i] then
                            strInfo = strInfo.."\'\\0\'"
                        else
                            strInfo = strInfo..string.char(response[i])
                        end 
                    end
                    labelStatusCode:setString("Http Status Code:"..xhr.statusText)
                    --print(strInfo)
                else
                    --print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
                end
            end

            xhr:registerScriptHandler(onReadyStateChange)
            xhr:send()
            
            labelStatusCode:setString("waiting...")
        end

        local labelPostBinary = cc.Label:create():setString("Test Post Binary")--cc.Label:createWithTTF(css.ttfConfig,"Test Post Binary")
        labelPostBinary:setAnchorPoint(cc.p(0.5, 0.5))
        local itemPostBinary = cc.MenuItemLabel:create(labelPostBinary)
        itemPostBinary:registerScriptTapHandler(onMenuPostBinaryClicked)
        itemPostBinary:setPosition(cc.p(winSize.width / 2, winSize.height - margin - 3 * space))
        menuRequest:addChild(itemPostBinary)

        --Post Json

        local function onMenuPostJsonClicked()
            local xhr = cc.XMLHttpRequest:new()
            xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
            xhr:open("POST", "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13")

            local function onReadyStateChange()
                if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                    labelStatusCode:setString("Http Status Code:"..xhr.statusText)
                    local response   = xhr.response
                    local output = json.decode(response,1)
                    --table.foreach(output,function(i, v) print (i, v) end)
                    print("headers are")
                    self.access_token = output.access_token
                    --print(access_token)
                    table.foreach(output,print)
                else
                    print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
                end
            end
                local tbl = {
        grant_type="client_credentials",
        client_id="cd1b420a-a888-47d6-b844-6bd2855e3d21",
        client_secret="y+/wsgRh90/2OUpwS/ZoUxdvAegvjTyT+LIkCrEZeGU",
        scope="http://api.microsofttranslator.com",
    }
            xhr:registerScriptHandler(onReadyStateChange)
            xhr:send(self:encodeTab(tbl))
            
            labelStatusCode:setString("waiting...")
        end

        local labelPostJson = cc.Label:create():setString("Test Post Json")--cc.Label:createWithTTF(css.ttfConfig,"Test Post Json")
        labelPostJson:setAnchorPoint(cc.p(0.5, 0.5))
        local itemPostJson = cc.MenuItemLabel:create(labelPostJson)
        itemPostJson:registerScriptTapHandler(onMenuPostJsonClicked)
        itemPostJson:setPosition(cc.p(winSize.width / 2, winSize.height - margin - 4 * space))
        menuRequest:addChild(itemPostJson)
    end

    local function onNodeEvent(eventName)
        if "enter" == eventName then
            init()
        end
    end

    layer:registerScriptHandler(onNodeEvent)

    return layer
end

function Translator:XMLHttpRequestTestMain()
    local scene = cc.Scene:create()
    scene:addChild(self:XMLHttpRequestLayer())
    --scene:addChild(CreateBackMenuItem())
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(scene)
    else
        cc.Director:getInstance():runWithScene(scene)
    end
    return scene
end


function Translator:ctor()
    --self:XMLHttpRequestTestMain()

    --self:showDemo()
    --self:initTrans()
end

--不再使用这函数初始化了,这个方法只有偶尔才能成功
function Translator:initTrans()
    local tbl = {
        grant_type="client_credentials",
        client_id="7c097ac4-ce28-4891-b86e-32c1843297f4",
        client_secret="yg2Ja9GZ+iu5EO7ccLrnR9dykeL1XsHR+JG2w6sgG1s",
        scope="http://api.microsofttranslator.com",
    }
    self:postJson("https://datamarket.accesscontrol.windows.net/v2/OAuth2-13",self:encodeTab(tbl),function(success,data)
        if success then
            self._access_token = data.access_token
            print("access_token="..self._access_token)
            --demo
            self._DemotitileText:setString("init suc")
            self._ClickMe:setVisible(true)
        else
            --demo
            self._DemotitileText:setString("init fail")
        end
    end)
end


return Translator
