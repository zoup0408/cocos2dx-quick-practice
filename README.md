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
-   ccui
