--[[ BOOT PROJECT contains a font and gideros logo, as well as utilities to fetch files from github
BOOTASSETS.LOGO_NAME : file name of the logo
BOOTASSETS.FONT_NAME : file name of the TT Font (Noto Sans)
DYNWEB.fetchFile(filename, callback) : fetch a file from github and call the 'callback' with fetched data as first parameter
DYNWEB.runLua(filename) : Run the specified lua file from github

-- screen is set up as letterbox 1024x768
]]

require "json"

print("Hello world")
application:setBackgroundColor(0xFFFF00,0)
--Fetch screen bounds
local SCX,SCY,SCW,SCH=application:getLogicalBounds() SCW-=SCX SCH-=SCY
local SCCS=application:getScreenDensity()/(96*application:getLogicalScaleX())
--Fetch on-screen lgog bounds
local bnds=json.decode(JS.eval("JSON.stringify(gd_logo.getBoundingClientRect())"))
local logosz,logox,logoy=bnds.width*SCCS,bnds.x*SCCS,bnds.y*SCCS

local logo=Pixel.new(Texture.new(BOOTASSETS.LOGO_NAME,true),logosz,logosz)
logo:setAnchorPoint(0.5,0.5)
logo:setPosition(SCX+logox+logosz/2,SCY+logoy+logosz/2)
stage:addChild(logo)

Core.asyncCall(function ()
Core.yield(true) -- Skip a frame
JS.eval("gd_logo.style=\"visibility: hidden;\"")
end)

Core.asyncCall(function ()
	local steps=15
	for i=1,steps do
		logo:setScale(1+0.1*(i/steps))		
		Core.yield(true)
	end
	for i=steps-1,0,-1 do
		logo:setScale(1+0.1*(i/steps))		
		Core.yield(true)
	end
	Core.yield(0.2)
	stage:addEventListener(Event.ENTER_FRAME,function ()
		logo:setRotation(logo:getRotation()+1)
	end)
end)


