local eventHandling = {}
local ClientMainEvent = game.ReplicatedStorage.Events.ClientMain
local cultivate = require(game.ServerScriptService.GameHandling.CultivatorRelated.CultivationStuff.Cultivate)
local breakthrough = require(game.ServerScriptService.GameHandling.CultivatorRelated.CultivationStuff.Breakthrough)

ClientMainEvent.OnServerEvent:Connect(function(player, eventId)
	if eventId == 1 then
		cultivate.Cultivate(player)
	elseif eventId == 2 then
		breakthrough.Breakthrough(player)
	end
end)

return eventHandling
