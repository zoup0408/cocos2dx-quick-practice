FruitItem = import("app.scenes.fruit.FruitItem")

local MainPlayScene = class("MainPlayScene", function()
	return display.newScene("MainPlayScene")
end)
function MainPlayScene:ctor()
	
	-- init value
	self.highSorce = 0 -- 最高分数
	self.stage = 1 -- 当前关卡
	self.target = 123 -- 通关分数
	self.curSorce = 0 -- 当前分数
	self.xCount = 8 -- 水平方向水果数
	self.yCount = 8 -- 垂直方向水果数
	self.fruitGap = 0 -- 水果间距
	self.scoreStart = 5 -- 水果基分
	self.scoreStep = 10 -- 加成分数
	self.activeScore = 0 -- 当前高亮的水果得分

	self:initUI()
end
function MainPlayScene:initUI()
	display.addSpriteFrames("fruit.plist", "fruit.png")
	-- 背景图片
	display.newSprite("playBG.png")
		:pos(display.cx, display.cy)
		:addTo(self)

	-- high sorce
	display.newSprite("#high_score.png")
		:align(display.LEFT_CENTER, display.left + 15, display.top - 30)
		:addTo(self)

	display.newSprite("#highscore_part.png")
		:align(display.LEFT_CENTER, display.cx + 10, display.top - 26)
		:addTo(self)

	self.highSorceLabel = display.newTTFLabel({text =  tostring(self.highSorce),size = 25,color = cc.c3b(0, 0, 0)})
		:align(display.CENTER, display.cx + 105, display.top - 24)
		:addTo(self)

	-- 声音
	display.newSprite("#sound.png")
		:align(display.CENTER, display.right - 60, display.top - 30)
		:addTo(self)

	-- stage
	display.newSprite("#stage.png")
		:align(display.LEFT_CENTER, display.left + 15, display.top - 80)
		:addTo(self)

	display.newSprite("#stage_part.png")
		:align(display.LEFT_CENTER, display.left + 170, display.top - 80)
		:addTo(self)

	self.highStageLabel =  display.newTTFLabel({text = tostring(self.stage), size = 25,color = cc.c3b(0, 0, 0)})
		:align(display.CENTER, display.left + 214, display.top - 78)
        :addTo(self)
	
	-- target
	display.newSprite("#tarcet.png")
		:align(display.LEFT_CENTER, display.cx - 50, display.top - 80)
		:addTo(self)

	display.newSprite("#tarcet_part.png")
		:align(display.LEFT_CENTER, display.cx + 130, display.top - 78)
		:addTo(self)

	self.highTargetLabel =  display.newTTFLabel({text = tostring(self.target), size = 25,color = cc.c3b(0, 0, 0)})
		:align(display.CENTER, display.cx + 195, display.top - 76)
        :addTo(self)

	-- current sorce
	display.newSprite("#score_now.png")
		:align(display.CENTER, display.cx, display.top - 150)
		:addTo(self)

	self.curSorceLabel =  display.newTTFLabel({text = tostring(self.curSorce), size = 25,color = cc.c3b(0, 0, 0)})
		:align(display.CENTER, display.cx, display.top - 150)
        :addTo(self)
	
	-- 选中水果分数
	self.activeScoreLabel = display.newTTFLabel({text = "", size = 30})
		:pos(display.width / 2, 120)
		:addTo(self)
	self.activeScoreLabel:setColor(display.COLOR_WHITE)
end

function MainPlayScene:onEnter()
end

function MainPlayScene:onExit()
end

return MainPlayScene