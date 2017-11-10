FruitItem = import("app.scenes.fruit.FruitItem")

 local Test_Anim=class("Test_Anim", function()
	return display.newScene("Test_Anim")
end)
function Test_Anim:ctor()

	self.xCount = 8 -- 水平方向水果数
	self.yCount = 8 -- 垂直方向水果数
	self.fruitGap =0
	display.addSpriteFrames("fruit.plist", "fruit.png")
	-- 初始化随机数
	math.newrandomseed()


	self.matrixLBX=display.width-FruitItem.getWidth()*self.yCount-self.fruitGap*(self.yCount-1)/2
	self.matrixLBY=display.height-FruitItem.getWidth()*self.xCount-self.fruitGap*(self.xCount-1)/2-30

	--  计算水果矩阵左下角的x、y坐标：以矩阵中点对齐屏幕中点来计算，然后再做Y轴修正。

	-- 等待转场特效结束后再加载矩阵
	self:addNodeEventListener(cc.NODE_EVENT, function(event)
		if event.name == "enterTransitionFinish" then
			self:init()
		end
	end)
end

function Test_Anim:init()
	-- 创建空矩阵
	self.matrix = {}
	for x=1,self.xCount do
		for y=1,self.yCount do
			self:dropFruit(x,y)
		end
	end
end

function Test_Anim:dropFruit(x,y,fruitIndex)
	local newFruit=FruitItem.new(x,y,fruitIndex)
	-- local startPosition=cc.p(self.matrixLBX+(x-1)*FruitItem.getWidth(),self.matrixLBY+(y-1)*FruitItem.getWidth())
	-- local startPosition=self:positionOfStart(x, y)
	local endPosition=self:positionOfEnd(x,y)
	local startPosition = cc.p(endPosition.x, endPosition.y + display.height / 2)
	newFruit:setPosition(startPosition)
	local speed=10.0
	newFruit:runAction(cc.MoveTo:create(speed,endPosition))
	self.matrix[(y - 1) * self.xCount + x] = newFruit
    self:addChild(newFruit)
end

function Test_Anim:positionOfStart(x, y)
    local px = self.matrixLBX + (FruitItem.getWidth() + self.fruitGap) * (x - 1) + FruitItem.getWidth() / 2
    local py = self.matrixLBY + (FruitItem.getWidth() + self.fruitGap) * (self.yCount- 1) + FruitItem.getWidth() / 2
    return cc.p(px, py)
end

function Test_Anim:positionOfEnd(x, y)
    local px = self.matrixLBX + (FruitItem.getWidth() + self.fruitGap) * (x - 1) + FruitItem.getWidth() / 2
    local py = self.matrixLBY + (FruitItem.getWidth() + self.fruitGap) * (y - 1) + FruitItem.getWidth() / 2
    return cc.p(px, py)
end

function Test_Anim:anim()
local screen = cc.Director:getInstance():getRunningScene()  
local action1 = cc.ScaleTo:create(0.5, 1) --放大 参数:时间和缩放尺寸  
local action2 = cc.MoveTo:create(0.5, cc.p(300,330)) --移动到某位置  
local action3 = cc.ScaleTo:create(0.2, 0.6) --缩小 参数:时间和缩放尺寸  
local action4 = cc.FadeOut:create(2)--淡出  
local action5 = cc.MoveTo:create(2, cc.p(300,450)) --移动到某位置  
  
  
--复位 以便让动画重复  
local action6 = cc.FadeIn:create(0.01)--渐入  
local action7 = cc.MoveTo:create(0.01, cc.p(300,300)) --移动到某位置  
  
local sprite = display.newSprite("ball_1.png")  
-- sprite:setTextureRect(cc.rect(120, 0, 120, 28) )  
sprite:setPosition(300,300)  
sprite:setAnchorPoint(cc.p(0.5,0))  
sprite:setScale(0.6)  
-- sprite:runAction(action1)--runAction执行一个动作  
-- sprite:runAction(cc.Spawn:create(action1,action2))--cc.Spawn:create同时执行多个动作  
-- sprite:runAction(cc.Sequence:create(cc.Spawn:create(action1,action2),action3,cc.Spawn:create(action4,action5)))--cc.Sequence:create循序执行多个动作  
sprite:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(action1,action2),action3,cc.Spawn:create(action4,action5),cc.Spawn:create(action6,action7))))--cc.RepeatForever:create(某动作)重复执行某个动作  
screen:addChild(sprite)  
end

function Test_Anim:onEnter()
end

function Test_Anim:onExit()
end

return Test_Anim
