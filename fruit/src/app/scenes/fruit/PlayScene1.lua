FruitItem = import("app.scenes.fruit.FruitItem")

local PlayScene1 = class("PlayScene1", function()
	return display.newScene("PlayScene1")
	end)
function PlayScene1:ctor()

	self.xCount = 8 -- 水平方向水果数
	self.yCount = 8 -- 垂直方向水果数
	self.fruitGap = 0 -- 水果间距
	
	self:initUI()

	--  计算水果矩阵左下角的x、y坐标：以矩阵中点对齐屏幕中点来计算，然后再做Y轴修正。
	self.matrixLBX = (display.width - FruitItem.getWidth() * self.xCount - (self.yCount - 1) * self.fruitGap) / 2
	self.matrixLBY = (display.height - FruitItem.getWidth() * self.yCount - (self.xCount - 1) * self.fruitGap) / 2 - 30

	-- 等待转场特效结束后再加载矩阵
	self:addNodeEventListener(cc.NODE_EVENT, function(event)
		if event.name == "enterTransitionFinish" then
			self:initMartix()
		end
		end)
end
function PlayScene1:initUI()
	display.addSpriteFrames("fruit.plist", "fruit.png")
end

function PlayScene1:initMartix()
	for y = 1, self.yCount do
		for x = 1, self.xCount do
			self:createAndDropFruit(x, y)
		end
	end
end

function PlayScene1:createAndDropFruit(x, y, fruitIndex)
	local newFruit = FruitItem.new(x, y, fruitIndex)
	local endPosition = self:positionOfFruit(x, y)
	local startPosition = cc.p(endPosition.x, endPosition.y + display.height / 2)
	newFruit:setPosition(startPosition)
	local speed = startPosition.y / (2 * display.height)
	newFruit:runAction(cc.MoveTo:create(speed, endPosition))
	self:addChild(newFruit)
end

function PlayScene1:positionOfFruit(x, y)
	local px = self.matrixLBX + (FruitItem.getWidth() + self.fruitGap) * (x - 1) + FruitItem.getWidth() / 2
	local py = self.matrixLBY + (FruitItem.getWidth() + self.fruitGap) * (y - 1) + FruitItem.getWidth() / 2
	return cc.p(px, py)
end

function PlayScene1:onEnter()
end

function PlayScene1:onExit()
end

return PlayScene1