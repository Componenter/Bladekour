-- Compiled with roblox-ts v3.0.0
-- Grapple rope
local GrappleRope
do
	GrappleRope = setmetatable({}, {
		__tostring = function()
			return "GrappleRope"
		end,
	})
	GrappleRope.__index = GrappleRope
	function GrappleRope.new(...)
		local self = setmetatable({}, GrappleRope)
		return self:constructor(...) or self
	end
	function GrappleRope:constructor()
	end
end
return {
	GrappleRope = GrappleRope,
}
