
local MenuScene = class("MenuScene", function()
    return display.newScene("MenuScene")
end)

function MenuScene:ctor()
	-- 1.加载精灵帧
    display.addSpriteFrames("fruit.plist", "fruit.png")

    -- 2.背景图片
	display.newSprite("mainBG.png")
		:pos(display.cx,display.cy)
		:addTo(self)

	local startBtnImages = {
		normal = "#startBtn_N.png",
		pressed = "#startBtn_S.png",
	}
    
	-- 3.开始按钮
  --   cc.ui.UIPushButton.new(startBtnImages, {scale9 = false})
		-- :onButtonClicked(function(event)
		-- 	print("TODO: switch to PlayScene!")
		-- end)
		-- :align(display.CENTER, display.cx, display.cy - 80)
		-- :addTo(self)
end

function MenuScene:onEnter()
end

function MenuScene:onExit()
end

return MenuScene
