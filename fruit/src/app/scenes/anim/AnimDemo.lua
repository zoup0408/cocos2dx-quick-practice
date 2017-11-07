local AnimDemo=class("AnimDemo", function()
	return display.newScene("AnimDemo")
end)
function AnimDemo:ctor()
	-- 等待转场特效结束后再加载矩阵
	self:addNodeEventListener(cc.NODE_EVENT, function(event)
		if event.name == "enterTransitionFinish" then
			self:anim()
		end
	end)
end

function AnimDemo:anim()
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

function AnimDemo:onEnter()
end

function AnimDemo:onExit()
end

return AnimDemo
