local lpeg = require "lpeg"

local P = lpeg.P
local S = lpeg.S
local R = lpeg.R
local C = lpeg.C
local V = lpeg.V

local Ct = lpeg.Ct
local Cg = lpeg.Cg
local Cc = lpeg.Cc

local function count_lines(_,pos, parser_state)
	if parser_state.pos < pos then
		parser_state.line = parser_state.line + 1
		parser_state.pos = pos
	end
	return pos
end

local exception = lpeg.Cmt( lpeg.Carg(1) , function ( _ , pos, parser_state)
	error(string.format("syntax error at [%s] line (%d) pos %d", parser_state.file or "", parser_state.line,pos))
	return pos
end)

local eof = P(-1)
local newline = lpeg.Cmt((P"\n" + "\r\n") * lpeg.Carg(1) ,count_lines)
local blank = S" \t" + newline
local blank0 = blank ^ 0
local blanks = blank ^ 1
local alpha = R"az" + R"AZ"
local alnum = alpha + R"09"
local num = (R"09")^1
local word = alpha * alnum ^ 0
local name = C(word)
local colorHex = R("09","AF","af")^1



local function multipat(pat)
	return Ct(blank0 * (pat * blanks) ^ 0 * pat^0 * blank0)
end

local function namedpat(name, pat)
	return Ct(Cg(Cc(name), "type") * Cg(pat))
end

local colorStart = P"[#"*C(colorHex)*(P"|"*C(num))^0*P"]"
local colorEnd = P"[end]"
local colorWord = (P(1) - colorStart- colorEnd)^0

local defaultWord =  (P(1)-colorEnd-P"[#")^1

local typedef = P{
	"ALL",
	WORD = namedpat("Word",defaultWord),
	COLORTEXT = namedpat("colorWord",colorStart*C(colorWord)*colorEnd),
	ALL = multipat(V"WORD"+V"COLORTEXT")
}

local proto = blank0 * typedef * blank0

local RichTextFormat = {}

function RichTextFormat.format(text,...)
	local state = { file = "", pos = 0, line = 1 }
	local r = lpeg.match(proto * -1 + exception , text , 1, state )
	return r
end

return RichTextFormat