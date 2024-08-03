local Join = {}
local CultivatorHandler = require(game.ServerScriptService.GameHandling.CultivatorRelated.CultivatorHandling)
local rand = function() math.randomseed(os.time()) print('new random seed') end
local manager = require(game.ServerScriptService.DataHandling.Manager)
local updateGui = require(game.ServerScriptService.GameHandling.DisplayUpdating.UpdateGuis)

local testing = true

local function randomizeAuraColor(player: Player)
	rand()
	local cultivator = CultivatorHandler.getCultivatorFromPlayer(player)
	
	local newAura = {}
	for i = 1, 3 do
		newAura[i] = math.random(0, 255)
	end
	cultivator:Set('auraColorTable', newAura)
end

local function newPlayerJoin(player: Player)
	local cultivator = CultivatorHandler.getCultivatorFromPlayer(player)
	randomizeAuraColor(player)
	
	cultivator:AwardTitle('Alpha Tester')
end

Join.handlePlayerJoin = function(player: Player)
	repeat task.wait() until manager.Profiles[player]
	
	local cultivator = CultivatorHandler.new(player)
	if cultivator:Get('isFirstJoin') then
		newPlayerJoin(player)
		if not testing then
			cultivator:Set('isFirstJoin', false)
		else
			print('Testing state is enabled')
			cultivator:Set('isFirstJoin', true)
		end
	end
	updateGui.updateAll(player)
end

return Join
