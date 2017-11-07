FruitItem = import("app.scenes.fruit.FruitItem")

local MainPlayScene = class("MainPlayScene", function()
	return display.newScene("MainPlayScene")
end)
function MainPlayScene:ctor()
	
	-- init value
	self.highSorce = 0 -- 最高分数
	self.stage = 1 -- 当前关卡
	self.target = 100 -- 通关分数
	self.curSorce = 0 -- 当前分数
	self.xCount = 8 -- 水平方向水果数
	self.yCount = 8 -- 垂直方向水果数
	self.fruitGap = 0 -- 水果间距
	self.scoreStart = 5 -- 水果基分
	self.scoreStep = 10 -- 加成分数
	self.activeScore = 0 -- 当前高亮的水果得分

	self:initUI()
	-- 初始化随机数
	math.newrandomseed()

	--  计算水果矩阵左下角的x、y坐标：以矩阵中点对齐屏幕中点来计算，然后再做Y轴修正。
	self.matrixLBX = (display.width - FruitItem.getWidth() * self.xCount - (self.yCount - 1) * self.fruitGap) / 2
	self.matrixLBY = (display.height - FruitItem.getWidth() * self.yCount - (self.xCount - 1) * self.fruitGap) / 2 - 30

	-- 等待转场特效结束后再加载矩阵
	self:addNodeEventListener(cc.NODE_EVENT, function(event)
		if event.name == "enterTransitionFinish" then
			-- self:initMartix()
			self.dropTest()
		end
	end)
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

function MainPlayScene:initMartix()
	-- 创建空矩阵
	self.matrix = {}
	-- 高亮水果
	self.actives = {}
	for y = 1, self.yCount do
		for x = 1, self.xCount do
			if 1 == y and 2 == x then
                -- 确保有可消除的水果
                self:createAndDropFruit(x, y, self.matrix[1].fruitIndex)
            else 
                self:createAndDropFruit(x, y)
			end
		end
	end
end

function MainPlayScene:createAndDropFruit(x, y, fruitIndex)
    local newFruit = FruitItem.new(x, y, fruitIndex)
    local endPosition = self:positionOfFruit(x, y)
    local startPosition = cc.p(endPosition.x, endPosition.y + display.height / 2)
    newFruit:setPosition(startPosition)
    local speed = startPosition.y / (2 * display.height)
    newFruit:runAction(cc.MoveTo:create(speed, endPosition))
    self.matrix[(y - 1) * self.xCount + x] = newFruit
    self:addChild(newFruit)

	-- 绑定触摸事件
	newFruit:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		if event.name == "ended" then
			if newFruit.isActive then
				self:removeActivedFruits()
				self:dropFruits()
			else
				self:inactive()
				self:activeNeighbor(newFruit)
				self:showActivesScore()
			end
		end

		if event.name == "began" then
			return true
		end
	end)
	newFruit:setTouchEnabled(true)
end

function MainPlayScene:positionOfFruit(x, y)
    local px = self.matrixLBX + (FruitItem.getWidth() + self.fruitGap) * (x - 1) + FruitItem.getWidth() / 2
    local py = self.matrixLBY + (FruitItem.getWidth() + self.fruitGap) * (y - 1) + FruitItem.getWidth() / 2
    return cc.p(px, py)
end

function MainPlayScene:dropTest()
local screen = cc.Director:getInstance():getRunningScene()  
local action1 = cc.ScaleTo:create(0.5, 1) --放大 参数:时间和缩放尺寸  
local action2 = cc.MoveTo:create(0.5, cc.p(300,330)) --移动到某位置  
local action3 = cc.ScaleTo:create(0.2, 0.6) --缩小 参数:时间和缩放尺寸  
local action4 = cc.FadeOut:create(2)--淡出  
local action5 = cc.MoveTo:create(2, cc.p(300,450)) --移动到某位置  
  
  
--复位 以便让动画重复  
local action6 = cc.FadeIn:create(0.01)--渐入  
local action7 = cc.MoveTo:create(0.01, cc.p(300,300)) --移动到某位置  
  
local sprite = display.newSprite("#high_score.png")  
sprite:setTextureRect(cc.rect(120, 0, 120, 28) )  
sprite:setPosition(300,300)  
sprite:setAnchorPoint(cc.p(0.5,0))  
sprite:setScale(0.6)  
-- sprite:runAction(action1)--runAction执行一个动作  
-- sprite:runAction(cc.Spawn:create(action1,action2))--cc.Spawn:create同时执行多个动作  
-- sprite:runAction(cc.Sequence:create(cc.Spawn:create(action1,action2),action3,cc.Spawn:create(action4,action5)))--cc.Sequence:create循序执行多个动作  
sprite:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(action1,action2),action3,cc.Spawn:create(action4,action5),cc.Spawn:create(action6,action7))))--cc.RepeatForever:create(某动作)重复执行某个动作  
  
screen:addChild(sprite)  
end

function MainPlayScene:onEnter()
end

function MainPlayScene:onExit()
end

return MainPlayScene