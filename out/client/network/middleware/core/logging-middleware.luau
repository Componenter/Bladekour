-- Compiled with roblox-ts v3.0.0
local LoggingMiddleware = {
	name = "Logging",
	onSend = function(self, packet)
		print(`[SEND] -> Packet sent`)
		return true
	end,
	onReceive = function(self, packet)
		print(`[RECV] <- Packet received`)
	end,
}
return {
	LoggingMiddleware = LoggingMiddleware,
}
