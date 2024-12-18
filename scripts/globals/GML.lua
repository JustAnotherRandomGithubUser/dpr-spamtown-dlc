--cache these functions to decrease lookup time, not important in the grand scheme of things but nice to do
local cos = math.cos
local sin = math.sin
local toRad = math.rad

local GML = {}

--dir in degrees
function GML.lengthdir_x(len, dir)
  return len*cos(toRad(dir))
end

function GML.lengthdir_y(len, dir)
  return len*sin(toRad(dir))
end

--more gml functions here--

return GML