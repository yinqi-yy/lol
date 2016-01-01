--
-- Author: zj
-- Date: 2015-07-03 15:09:57
--
ui = class("ui")
ui.map = {}
--type 界面类型 :底图锁定1(界面不销毁) 主界面 2  天气层3 菜单4  模态5  弹出窗口6  提示层7  

ui.Login 	={type=2,path="modules.Login.Login"		,uipath="ui.MainScene"}
ui.BackLogin 	={type=2,id=10000,path="modules.Login.BackLogin"		,uipath="ui.BackLogin"}
ui.Register 	={type=6,path="modules.Login.Register"		,uipath="ui.Register"}
ui.GameRoomContr 	={type=2,path="modules.GameRoom.GameRoomContr"		,uipath="ui.GameRoomContr"}--主大厅
ui.Notice 	={type=5,path="modules.Login.Notice"		,uipath="ui.Notice"}

