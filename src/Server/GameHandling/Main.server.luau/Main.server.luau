local JoinMod = require(script:WaitForChild('JoinModule'))
local serverMainEvent = game.ReplicatedStorage.Events.ServerMain
local manager = require(game.ServerScriptService.DataHandling.Manager)
local cultivatorHandler = require(game.ServerScriptService.GameHandling.CultivatorRelated.CultivatorHandling)
local updateDisplay = require(game.ServerScriptService.GameHandling.DisplayUpdating.UpdateGuis)
local clientMain = game.ReplicatedStorage.Events.ClientMain

-- Modules that have to be called for the game to function
local GH = game.ServerScriptService.GameHandling
require(GH.ZoneRelated.ZoneQIModifier)
require(script.Francis)

game.Players.PlayerAdded:Connect(function(player)
	JoinMod.handlePlayerJoin(player)
end)

serverMainEvent.OnServerEvent:Connect(function(player: Player)
	repeat task.wait() until manager.Profiles[player]
	print(player.Name..' has requested their data')
	local cultivator = cultivatorHandler.getCultivatorFromPlayer(player)
	local refac = cultivator:Get('profile')
	print(refac)
	clientMain:FireClient(player, refac)
end)
