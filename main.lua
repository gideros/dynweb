--[[ BOOT PROJECT contains a font and gideros logo, as well as utilities to fetch files from github
BOOTASSETS.LOGO_NAME : file name of the logo
BOOTASSETS.FONT_NAME : file name of the TT Font (Noto Sans)
DYNWEB.fetchFile(filename, callback) : fetch a file from github and call the 'callback' with fetched data as first parameter
DYNWEB.runLua(filename) : Run the specified lua file from github

-- screen is set up as letterbox 1024x768
]]

print("Hello world")
application:setBackgroundColor(0xFFFF00,0)

--Fetch screen bounds
local SCX,SCY,SCW,SCH=application:getLogicalBounds() SCW-=SCX SCH-=SCY
local logo=Pixel.new(Texture.new(BOOTASSETS.LOGO_NAME,true),300,300)
logo:setAnchorPoint(0.5,0.5)
logo:setPosition(SCX+SCW/2,SCY+SCH/2)
logo:setColorTransform(1,1,1,0)
stage:addChild(logo)

Core.asyncCall(function ()
	local steps=30
	for i=1,steps do
		logo:setColorTransform(1,1,1,i/steps)		
		Core.yield(true)
	end
	Core.yield(0.2)
	stage:addEventListener(Event.ENTER_FRAME,function ()
		logo:setRotation(logo:getRotation()+1)
	end)
end)


