
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
   display.newSprite("mainBG.png")
		:pos(display.cx,display.cy)
		:addTo(self)
		
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene