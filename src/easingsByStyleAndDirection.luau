local easing = require(script.Parent.easing)

local easingsByStyleAndDirection = {}

export type EasingStyle = 
	| "Linear" | "Quad" | "Cubic" | "Quart"
	| "Quint" | "Sine" | "Expo" | "Circ"
	| "Elastic" | "Back" | "Bounce"
	
export type EasingDirection = "In" | "Out" | "InOut" | "OutIn"

easingsByStyleAndDirection.Linear = {
	In = easing.linear,
	Out = easing.linear,
	InOut = easing.linear,
	OutIn = easing.linear,
}

easingsByStyleAndDirection.Quad = {
	In = easing.inQuad,
	Out = easing.outQuad,
	InOut = easing.inOutQuad,
	OutIn = easing.outInQuad,
}

easingsByStyleAndDirection.Cubic = {
	In =  easing.inCubic,
	Out =  easing.outCubic,
	InOut =  easing.inOutCubic,
	OutIn =  easing.outInCubic,
}

easingsByStyleAndDirection.Quart = {
	In =  easing.inQuart,
	Out =  easing.outQuart,
	InOut =  easing.inOutQuart,
	OutIn =  easing.outInQuart,
}

easingsByStyleAndDirection.Quint = {
	In = easing.inQuint,
	Out = easing.outQuint,
	InOut = easing.inOutQuint,
	OutIn = easing.outInQuint,
}

easingsByStyleAndDirection.Sine = {
	In = easing.inSine,
	Out = easing.outSine,
	InOut = easing.inOutSine,
	OutIn = easing.outInSine,
}

easingsByStyleAndDirection.Expo = {
	In = easing.inExpo,
	Out = easing.outExpo,
	InOut = easing.inOutExpo,
	OutIn = easing.outInExpo,
}


easingsByStyleAndDirection.Circ = {
	In = easing.inCirc,
	Out = easing.outCirc,
	InOut = easing.inOutCirc,
	OutIn = easing.outInCirc,
}

easingsByStyleAndDirection.Elastic = {
	In = easing.inElastic,
	Out = easing.outElastic,
	InOut = easing.inOutElastic,
	OutIn = easing.outInElastic,
}

easingsByStyleAndDirection.Back = {
	In = easing.inBack,
	Out = easing.outBack,
	InOut = easing.inOutBack,
	OutIn = easing.outInBack,
}

easingsByStyleAndDirection.Bounce = {
	In = easing.inBounce,
	Out = easing.outBounce,
	InOut = easing.inOutBounce,
	OutIn = easing.outInBounce,
}

return table.freeze(easingsByStyleAndDirection)
