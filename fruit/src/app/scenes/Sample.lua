local AnimDemo=class("AnimDemo", function ()
	return display.newScene("AnimDemo")
end)
function AnimDemo:ctor()
	self.anim()
end

function AnimDemo:anim()
end
function AnimDemo:onEnter()
end

function AnimDemo:onExit()
end

return AnimDemo
