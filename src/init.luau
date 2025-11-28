--!native
--[=[
	@class MathUtil

	`MathUtil` 모듈은 다양한 수학 유틸리티 함수를 제공합니다.
	
]=]
local HUGE = math.huge

local abs = math.abs
local clamp = math.clamp
local floor = math.floor
local max = math.max
local min = math.min
local round = math.round

local MathUtil = {}

--[=[
	@within MathUtil
	@function map

	입력 값 `x`를 `[inMin, inMax]` 범위에서 `[outMin, outMax]` 범위로 선형 매핑합니다.

	@param x number -- 원본 범위의 값
	@param inMin number -- 원본 범위 하한
	@param inMax number -- 원본 범위 상한
	@param outMin number -- 대상 범위 하한
	@param outMax number -- 대상 범위 상한
	@return number -- 매핑된 값
]=]
function MathUtil.map(
	
	x: number, 
	inMin: number, 
	inMax: number, 
	outMin: number, 
	outMax: number
	
): number
	
	
	return (x - inMin)*(outMax - outMin)/(inMax - inMin) + outMin
end

--[=[
	@within MathUtil
	@function mapClamp

	`map`과 동일한 계산을 수행한 뒤 결과를 `[min(outMin, outMax), max(outMin, outMax)]` 범위로 클램프합니다.

	@param x number -- 원본 범위의 값
	@param inMin number -- 원본 범위 하한
	@param inMax number -- 원본 범위 상한
	@param outMin number -- 대상 범위 하한
	@param outMax number -- 대상 범위 상한
	@return number -- 매핑되고 클램프된 값
]=]
function MathUtil.mapClamp(x: number, inMin: number, inMax: number, outMin: number, outMax: number): number
	return clamp(
		(x - inMin)*(outMax - outMin)/(inMax - inMin) + outMin,
		min(outMin, outMax),
		max(outMin, outMax)
	)
end

--[=[
	@within MathUtil
	@function roundToIncrement

	주어진 `value`를 `increment`의 배수로 반올림합니다. `increment`가 제공되지 않으면 일반 반올림을 수행합니다.

	@param value number -- 반올림할 값
	@param increment number? -- 반올림 기준이 되는 간격
	@return number -- 반올림된 값
]=]
function MathUtil.roundToIncrement(value: number, increment: number?): number
	if increment then
		return round(value / increment) * increment
	else
		return round(value)
	end
end

--[=[
	@within MathUtil
	@function roundToPlaces

	`value`를 `decimalPlaces` 자리까지 반올림합니다.

	@param value number -- 반올림할 값
	@param decimalPlaces number -- 반올림할 소수 자릿수
	@return number -- 지정 자릿수까지 반올림된 값
]=]
function MathUtil.roundToPlaces(value: number, decimalPlaces: number): number
	local scaleFactor = 10 ^ decimalPlaces
	return floor(value * scaleFactor + 0.5) / scaleFactor
end


--[=[
	@within MathUtil
	@function isFinite

	`math.huge` 및 `-math.huge`와 비교해 유한한 숫자인지 확인합니다.

	@param value number -- 확인할 숫자
	@return boolean -- 유한하면 	rue`
]=]
function MathUtil.isFinite(value: number): boolean
	return value == value and value ~= HUGE and value ~= -HUGE
end

--[=[
	@within MathUtil
	@function fuzzyEqual

	두 숫자 `a`, `b`가 기본 `0.0001` 또는 전달된 `epsilon` 오차 이내로 거의 같은지 검사합니다.

	@param a number -- 비교할 첫 번째 값
	@param b number -- 비교할 두 번째 값
	@param epsilon number? -- 허용 오차
	@return boolean -- 허용 오차 이내면 	rue`
]=]
function MathUtil.fuzzyEqual(a: number, b: number, epsilon: number?): boolean
	epsilon = if epsilon then epsilon else 0.0001
	return abs(a - b) < epsilon
end

--[=[
	@within MathUtil
	@function wrap

	`a`를 `(min, max]` 범위 안으로 감싸 반복되는 값을 반환합니다.
	블렌더의 [wrap 노드](https://github.com/blender/blender/blob/main/source/blender/nodes/shader/nodes/node_shader_math.cc)를 참고합니다.
	
	:::info 예시
	| a      | min | max | wrap(a, min, max) |
	| ------ | --- | --- | ----------------- |
	| 0      | 0   | 10  | 10                |
	| 0.0001 | 0   | 10  | 0.0001            |
	| 2.5    | 0   | 10  | 2.5               |
	| 7.5    | 0   | 10  | 7.5               |
	| 10     | 0   | 10  | 10                |
	| 12.5   | 0   | 10  | 2.5               |
	| 17.5   | 0   | 10  | 7.5               |
	| 20     | 0   | 10  | 10                |
	:::
	
	@param a number -- 래핑할 값
	@param min number -- 범위 하한
	@param max number -- 범위 상한
	@return number -- 래핑된 값
]=]
function MathUtil.wrap(a: number, min: number, max: number): number
	local range = min - max
	
	return a - (range * math.floor((a - max) / range))
end

--[=[
	@within MathUtil
	@function pingpong

	값 `a`를 `[0, scale]` 범위에서 왕복하도록 변환합니다.
	
	:::info 예시
	| a    | scale | pingpong(a, scale) |
	| ---- | ----- | ------------------ |
	| 0    | 10    | 0                  |
	| 2.5  | 10    | 2.5                |
	| 7.5  | 10    | 7.5                |
	| 10   | 10    | 10                 |
	| 12.5 | 10    | 7.5                |
	| 17.5 | 10    | 2.5                |
	| 20   | 10    | 0                  |
	:::
	
	@param a number -- 입력 값
	@param scale number -- 왕복 범위의 최댓값
	@return number -- 왕복 변환된 값
]=]
function MathUtil.pingpong(a: number, scale: number): number
	local fractPart = (a - scale) / (scale * 2.0)
	return math.abs(((fractPart - math.floor(fractPart)) * scale * 2.0) - scale)
end


MathUtil.easing = require("./easing")

local easingsByStyleAndDirection = require("./easingsByStyleAndDirection")
--[=[
	@within MathUtil
	@prop easingsByStyleAndDirection {[string]: {[string]: (progress: number) -> number}}

	easing 스타일과 방향에 따른 easing 함수를 제공하는 `easingsByStyleAndDirection` 딕셔너리.  
	
	```lua
	local cubicInOutEasing = MathUtil.easingsByStyleAndDirection["Cubic"]["InOut"]
	
	print(cubicInOutEasing(.5))
	```
]=]
MathUtil.easingsByStyleAndDirection = easingsByStyleAndDirection

--[=[
	@type EasingStyle string
	@within MathUtil

	이징 스타일 타입.
]=]
export type EasingStyle = easingsByStyleAndDirection.EasingStyle

--[=[
	@type EasingDirection "In" | "Out" | "InOut" | "OutIn"
	@within MathUtil

	이징 방향 타입.
]=]
export type EasingDirection = easingsByStyleAndDirection.EasingDirection

return table.freeze(MathUtil)
