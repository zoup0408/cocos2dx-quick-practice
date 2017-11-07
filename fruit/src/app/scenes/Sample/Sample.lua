local Sample=class("Sample", function ()
	return display.newScene("Sample")
end)
function Sample:ctor()
	self.anim()
end

function Sample:anim()
end
function Sample:onEnter()
end

function Sample:onExit()
end

return Sample
