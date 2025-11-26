-- Compiled with roblox-ts v3.0.0
-- Position sync
local PositionSync
do
	PositionSync = setmetatable({}, {
		__tostring = function()
			return "PositionSync"
		end,
	})
	PositionSync.__index = PositionSync
	function PositionSync.new(...)
		local self = setmetatable({}, PositionSync)
		return self:constructor(...) or self
	end
	function PositionSync:constructor()
	end
end
return {
	PositionSync = PositionSync,
}
