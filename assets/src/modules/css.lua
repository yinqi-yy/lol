local css = class("css")



css.green = RGB("00CD00")
css.red = RGB("FF0000")
css.black = RGB("000000")
css.white =RGB("FFFFFF")
css.green =RGB("00EE00")
css.blue = RGB("436EEE")
css.purple = RGB("7D26CD")
css.orange = RGB("EE7600")
css.artifact = RGB("EEEE00")

css.yellow = RGB("FFFF00")

css.color1 = RGB("8165a0")

css.blue1=RGB("00CCFF")

css.gray = RGB("8588AD")

css.Element = {}
css.Element.color1 = RGB("FF002D")
css.Element.color2 = RGB("FFD504")
css.Element.color3 = RGB("00CBFF")
css.Element.color4 = RGB("8588AD")

css.fontSize=20
css.fontColor = css.white
css.fontName=""

css.ttfConfig = {}
css.ttfConfig.fontFilePath = "ttf/font.ttf"
css.ttfConfig.fontSize     = 40
css.ttfConfig.glyphs       = cc.GLYPHCOLLECTION_DYNAMIC
css.ttfConfig.customGlyphs = nil
css.ttfConfig.distanceFieldEnabled = true

css.RichTextArea={}
css.RichTextArea.fontSize=css.fontSize
css.RichTextArea.fontName=css.fontName
css.RichTextArea.fontColor = css.fontColor
css.RichTextArea.width = 300
css.RichTextArea.height =300

css.chestColor={css.blue,css.purple,css.orange}

css.QucikTip={}

css.QucikTip.fontColor0 = ARGB("FF00CD00")
css.QucikTip.fontColor1 = ARGB("FF00CD00")
css.QucikTip.fontColor2 = ARGB("FFFF0000")
css.QucikTip.fontColor3 = ARGB("FF00CD00")
css.QucikTip.fontColor4 = ARGB("FFFF0000")
css.outline = ARGB("FF000000")

return css

