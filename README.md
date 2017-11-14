# cocos2dx-quick practice
> * 2017-11-02
## display
-   display.newScene( name ) ,创建普通场景
-   display.newSprite( name, x, y ) ,创建精灵
``` lua
 display.newSprite("mainBG.png")
		:pos(display.cx,display.cy)
		:addTo(self)
```
-   display.addSpriteFrames(plistFilename, image, handler) ，加载精灵帧
``` lua
display.addSpriteFrames("fruit.plist","fruit.png")
```
> * 2017-11-07
-   cc
cc.FadeIn:create(number) ,淡入
cc.FadeOut:create(number) ,淡出
cc.MoveTo:create(speed,position) ,移动
cc.ScaleTo:create(time,number) ,放大缩小
``` lua
local action1 = cc.ScaleTo:create(0.5, 1) --放大 参数:时间和缩放尺寸  
local action2 = cc.MoveTo:create(0.5, cc.p(300,330)) --移动到某位置  
local action3 = cc.ScaleTo:create(0.2, 0.6) --缩小 参数:时间和缩放尺寸  
local action4 = cc.FadeOut:create(2)--淡出  
local action5 = cc.MoveTo:create(2, cc.p(300,450)) --移动到某位置  
```
-  动画
local screen=display.Director.getInstance.getRunningScene() ,获取当前scene，注意，一定要在scene创建后调用：
``` lua
self:addNodeEventListener(cc.NODE_EVENT, function(event)
		if event.name == "enterTransitionFinish" then
			self:anim()
		end
	end)
```
动画举例：
``` lua
local ball=display.newSprite("ball_1.png")
local startPosition=cc.p(100,100)
local endPosition=cc.p(100,300)
ball:setPosition(startPosition)
local speed=0.2
ball:runAction(cc.MoveTo:create(speed,endPosition))
self:addChild(ball)
```
> * 2017-11-14
> * table
``` lua
fruit={"apple","banana","orange" }
table.insert(fruit,"mango")
print(fruit[4]);
print(table.concat(fruit,"-"));
table.remove(fruit,2)
print(fruit[1]);
print(fruit[2]);
print(fruit[3]);
print(fruit[4]);
```
以下是输出：
``` lua
mango
apple-banana-orange-mango
apple
orange
mango
nil
```
[详见菜鸟lua教程](http://www.runoob.com/lua/lua-tables.html)



