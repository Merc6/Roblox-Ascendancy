local UpdateGuis = {}
local cultivatorHandling = require(game.ServerScriptService.GameHandling.CultivatorRelated.CultivatorHandling)

local formulae = require(game.ServerScriptService.GameHandling.Formulae)
local serverMainEvent = game.ReplicatedStorage.Events.ServerMain

UpdateGuis.updateQi = function(player: Player): nil
	local cultivator = cultivatorHandling.getCultivatorFromPlayer(player)
	local currentQi = cultivator:Get('currentQi')
	local maxQi = cultivator:Get('maxQi')
	serverMainEvent:FireClient(player, currentQi, maxQi)
end

UpdateGuis.updateHealth = function(player: Player): nil
	local newHealth = formulae.CalculateHealth(player)
	
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid: Humanoid = character:WaitForChild('Humanoid')
	
	humanoid.MaxHealth = newHealth
end

UpdateGuis.updateAll = function(player: Player): nil
	UpdateGuis.updateQi(player)
	UpdateGuis.updateHealth(player)
end

return UpdateGuis
