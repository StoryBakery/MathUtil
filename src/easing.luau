--!native
--[=[
	@within MathUtil
	@prop easing {[string]: (progress: number) -> number}

	지원하는 스타일에는 `"Linear"`, `"Quad"`, `"Cubic"`, `"Quart"`, `"Quint"`, `"Sine"`, `"Expo"`, `"Circ"`, `"Elastic"`, `"Back"`, `"Bounce"`가 있으며,
		
	각 스타일은 `"In"`, `"Out"`, `"InOut"`, `"OutIn"` 방향으로 동작하는 easing 함수들을 포함합니다.
	
	```
	MathUtil.
	```
]=]

local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local asin = math.asin

local function linear(progress: number): number
	return progress
end

local function inQuad(progress: number): number
	progress = progress
	return pow(progress, 2)
end

local function outQuad(progress: number): number
	progress = progress
	return -progress * (progress - 2)
end

local function inOutQuad(progress: number): number
	progress = progress * 2
	if progress < 1 then
		return 0.5 * pow(progress, 2)
	else
		return -0.5 * ((progress - 1) * (progress - 3) - 1)
	end
end

local function outInQuad(progress: number): number
	if progress < 0.5 then
		return outQuad(progress * 2) * 0.5
	else
		return inQuad((progress * 2) - 1) * 0.5 + 0.5
	end
end

local function inCubic(progress: number): number
	progress = progress
	return pow(progress, 3)
end

local function outCubic(progress: number): number
	progress = progress - 1
	return pow(progress, 3) + 1
end

local function inOutCubic(progress: number): number
	progress = progress * 2
	if progress < 1 then
		return 0.5 * pow(progress, 3)
	else
		progress = progress - 2
		return 0.5 * (pow(progress, 3) + 2)
	end
end

local function outInCubic(progress: number): number
	if progress < 0.5 then
		return outCubic(progress * 2) * 0.5
	else
		return inCubic((progress * 2) - 1) * 0.5 + 0.5
	end
end

local function inQuart(progress: number): number
	progress = progress
	return pow(progress, 4)
end

local function outQuart(progress: number): number
	progress = progress - 1
	return -(pow(progress, 4) - 1)
end

local function inOutQuart(progress: number): number
	progress = progress * 2
	if progress < 1 then
		return 0.5 * pow(progress, 4)
	else
		progress = progress - 2
		return -0.5 * (pow(progress, 4) - 2)
	end
end

local function outInQuart(progress: number): number
	if progress < 0.5 then
		return outQuart(progress * 2) * 0.5
	else
		return inQuart((progress * 2) - 1) * 0.5 + 0.5
	end
end

local function inQuint(progress: number): number
	progress = progress
	return pow(progress, 5)
end

local function outQuint(progress: number): number
	progress = progress - 1
	return pow(progress, 5) + 1
end

local function inOutQuint(progress: number): number
	progress = progress * 2
	if progress < 1 then
		return 0.5 * pow(progress, 5)
	else
		progress = progress - 2
		return 0.5 * (pow(progress, 5) + 2)
	end
end

local function outInQuint(progress: number): number
	if progress < 0.5 then
		return outQuint(progress * 2) * 0.5
	else
		return inQuint((progress * 2) - 1) * 0.5 + 0.5
	end
end

local function inSine(progress: number): number
	return -cos(progress * (pi / 2)) + 1
end

local function outSine(progress: number): number
	return sin(progress * (pi / 2))
end

local function inOutSine(progress: number): number
	return -0.5 * (cos(pi * progress) - 1)
end

local function outInSine(progress: number): number
	if progress < 0.5 then
		return outSine(progress * 2) * 0.5
	else
		return inSine((progress * 2) - 1) * 0.5 + 0.5
	end
end

local function inExpo(progress: number): number
	if progress == 0 then
		return 0
	else
		return pow(2, 10 * (progress - 1)) - 0.001
	end
end

local function outExpo(progress: number): number
	if progress == 1 then
		return 1
	else
		return 1.001 * (-pow(2, -10 * progress) + 1)
	end
end

local function inOutExpo(progress: number): number
	if progress == 0 then return 0 end
	if progress == 1 then return 1 end
	progress = progress * 2
	if progress < 1 then
		return 0.5 * pow(2, 10 * (progress - 1)) - 0.0005
	else
		progress = progress - 1
		return 0.5 * 1.0005 * (-pow(2, -10 * progress) + 2)
	end
end

local function outInExpo(progress: number): number
	if progress < 0.5 then
		return outExpo(progress * 2) * 0.5
	else
		return inExpo((progress * 2) - 1) * 0.5 + 0.5
	end
end

local function inCirc(progress: number): number
	progress = progress
	return -(sqrt(1 - pow(progress, 2) - 1))
end

local function outCirc(progress: number): number
	progress = progress - 1
	return sqrt(1 - pow(progress, 2))
end

local function inOutCirc(progress: number): number
	progress = progress * 2
	if progress < 1 then
		return -0.5 * (sqrt(1 - progress * progress) - 1)
	else
		progress = progress - 2
		return 0.5 * (sqrt(1 - progress * progress) + 1)
	end
end

local function outInCirc(progress: number): number
	if progress < 0.5 then
		return outCirc(progress * 2) * 0.5
	else
		return inCirc((progress * 2) - 1) * 0.5 + 0.5
	end
end

local function inElastic(progress: number, amplitude: number?, period: number?): number
	if progress == 0 then return 0 end

	progress = progress

	if progress == 1 then return 1 end

	local period = period or 0.3

	local overshoot

	if not amplitude or amplitude < 1 then
		amplitude = 1
		overshoot = period / 4
	else
		overshoot = period / (2 * pi) * asin(1 / amplitude)
	end

	progress = progress - 1

	return -(amplitude * pow(2, 10 * progress) * sin((progress - overshoot) * (2 * pi) / period))
end

local function outElastic(progress: number, amplitude: number?, period: number?): number
	if progress == 0 then return 0 end

	progress = progress

	if progress == 1 then return 1 end

	local period = period or 0.3

	local overshoot

	if not amplitude or amplitude < 1 then
		amplitude = 1
		overshoot = period / 4
	else
		overshoot = period / (2 * pi) * asin(1 / amplitude)
	end

	return amplitude * pow(2, -10 * progress) * sin((progress - overshoot) * (2 * pi) / period) + 1
end

local function inOutElastic(progress: number, amplitude: number?, period: number?): number
	if progress == 0 then return 0 end

	progress = progress * 2

	if progress == 2 then return 1 end

	local period = period or 0.45
	local amplitude = amplitude or 0

	local overshoot

	if not amplitude or amplitude < 1 then
		amplitude = 1
		overshoot = period / 4
	else
		overshoot = period / (2 * pi) * asin(1 / amplitude)
	end

	if progress < 1 then
		progress = progress - 1
		return -0.5 * (amplitude * pow(2, 10 * progress) * sin((progress - overshoot) * (2 * pi) / period))
	else
		progress = progress - 1
		return amplitude * pow(2, -10 * progress) * sin((progress - overshoot) * (2 * pi) / period) * 0.5 + 1
	end
end

local function outInElastic(progress: number, amplitude: number?, period: number?): number
	if progress < 0.5 then
		return outElastic(progress * 2, amplitude, period) * 0.5
	else
		return inElastic((progress * 2) - 1, amplitude, period) * 0.5 + 0.5
	end
end

local function inBack(progress: number, overshoot: number?): number
	local overshoot = overshoot or 1.70158
	progress = progress
	return progress * progress * ((overshoot + 1) * progress - overshoot)
end

local function outBack(progress: number, overshoot: number?): number
	local overshoot = overshoot or 1.70158
	progress = progress - 1
	return (progress * progress * ((overshoot + 1) * progress + overshoot) + 1)
end

local function inOutBack(progress: number, overshoot: number?): number
	local overshoot = overshoot or 1.70158
	overshoot = overshoot * 1.525
	progress = progress * 2
	if progress < 1 then
		return 0.5 * (progress * progress * ((overshoot + 1) * progress - overshoot))
	else
		progress = progress - 2
		return 0.5 * (progress * progress * ((overshoot + 1) * progress + overshoot) + 2)
	end
end

local function outInBack(progress: number, overshoot: number?): number
	if progress < 0.5 then
		return outBack(progress * 2, overshoot) * 0.5
	else
		return inBack((progress * 2) - 1, overshoot) * 0.5 + 0.5
	end
end

local function outBounce(progress: number): number
	progress = progress
	if progress < 1 / 2.75 then
		return 7.5625 * progress * progress
	elseif progress < 2 / 2.75 then
		progress = progress - (1.5 / 2.75)
		return 7.5625 * progress * progress + 0.75
	elseif progress < 2.5 / 2.75 then
		progress = progress - (2.25 / 2.75)
		return 7.5625 * progress * progress + 0.9375
	else
		progress = progress - (2.625 / 2.75)
		return 7.5625 * progress * progress + 0.984375
	end
end

local function inBounce(progress: number): number
	return 1 - outBounce(1 - progress)
end

local function inOutBounce(progress: number): number
	if progress < 0.5 then
		return inBounce(progress * 2) * 0.5
	else
		return outBounce(progress * 2 - 1) * 0.5 + 0.5
	end
end

local function outInBounce(progress: number): number
	if progress < 0.5 then
		return outBounce(progress * 2) * 0.5
	else
		return inBounce((progress * 2) - 1) * 0.5 + 0.5
	end
end

return table.freeze({
	linear = linear,
	inQuad = inQuad,
	outQuad = outQuad,
	inOutQuad = inOutQuad,
	outInQuad = outInQuad,
	inCubic = inCubic,
	outCubic = outCubic,
	inOutCubic = inOutCubic,
	outInCubic = outInCubic,
	inQuart = inQuart,
	outQuart = outQuart,
	inOutQuart = inOutQuart,
	outInQuart = outInQuart,
	inQuint = inQuint,
	outQuint = outQuint,
	inOutQuint = inOutQuint,
	outInQuint = outInQuint,
	inSine = inSine,
	outSine = outSine,
	inOutSine = inOutSine,
	outInSine = outInSine,
	inExpo = inExpo,
	outExpo = outExpo,
	inOutExpo = inOutExpo,
	outInExpo = outInExpo,
	inCirc = inCirc,
	outCirc = outCirc,
	inOutCirc = inOutCirc,
	outInCirc = outInCirc,
	inElastic = inElastic,
	outElastic = outElastic,
	inOutElastic = inOutElastic,
	outInElastic = outInElastic,
	inBack = inBack,
	outBack = outBack,
	inOutBack = inOutBack,
	outInBack = outInBack,
	inBounce = inBounce,
	outBounce = outBounce,
	inOutBounce = inOutBounce,
	outInBounce = outInBounce,
})
