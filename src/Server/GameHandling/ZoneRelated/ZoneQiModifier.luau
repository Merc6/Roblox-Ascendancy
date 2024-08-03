local module = {}

local ZoneHandling = require(script.Parent.Zone)
local formulae = require(game.ServerScriptService.GameHandling.Formulae)
local zones = workspace.Zones
-- lets run with the assumption that every zone is a singular part

local playerZonePairs = {}
module.playerCount = {} -- [zoneId] = count

module.findPlayerZone = function(player: Player, zoneID)
	return playerZonePairs[player.UserId]
end

for i, zone in ipairs(zones:GetChildren()) do
	local newZone = ZoneHandling.new(zone)
	module.playerCount[i] = 0
	
	newZone.playerEntered:Connect(function(player)
		playerZonePairs[player.UserId] = i
		module.playerCount[i] += 1
	end)
	
	newZone.playerExited:Connect(function(player)
		playerZonePairs[player.UserId] = nil
		module.playerCount[i] -= 1
	end)
end

return module
