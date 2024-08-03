local formulae = {}
local cultivatorHandler = require(game.ServerScriptService.GameHandling.CultivatorRelated.CultivatorHandling)
local pathsTable = require(game.ServerScriptService.GameHandling.CultivatorRelated.Paths)

formulae.BreakthroughRequirement = function(player: Player): IntValue
	local cultivator = cultivatorHandler.getCultivatorFromPlayer(player)
	local function BoundCalc(realmInt: IntValue)
		return 100 / math.exp(1) * math.exp(realmInt)
	end
	
	local realminfo = cultivator:Get('realmTable')
	local majorInt = realminfo['MajorRealm']
	
	print('major int: '..majorInt)
	
	local _, Subrealms = pathsTable.GetRealmInfo(cultivator:Get('path'), majorInt)
	local upperBound = BoundCalc(majorInt + 1)
	local lowerBound = BoundCalc(majorInt)
	local slope = (upperBound - lowerBound) / Subrealms
	
	local breakthroughReq = math.floor(slope * realminfo['MinorRealm'] + lowerBound)

	return breakthroughReq
end

formulae.QiPerTick = function(player: Player): IntValue
	local cultivator = cultivatorHandler.getCultivatorFromPlayer(player)
	
	local baseQiGain = math.sqrt(formulae.BreakthroughRequirement(player))
	-- just get whatever list of multipliers the player has
	local pathMulti = pathsTable[cultivator:Get('path')]['Multipliers']['qiMulti']
	
	-- get the other multipliers later
	return math.floor(baseQiGain * pathMulti)
end

formulae.ZoneMultiplier = function(zoneID, activePlayers): IntValue
	local MINIMUM_MULTIPLIER = 1
	
	local scalingFactor = 1 // math.max(activePlayers, 1)
	local multiplier = math.floor(math.exp(zoneID) * scalingFactor + MINIMUM_MULTIPLIER)
	return multiplier
end

formulae.CalculateHealth = function(player: Player): IntValue
	local cultivator = cultivatorHandler.getCultivatorFromPlayer(player)
	local baseHealth = 100
	local healthMultiplier = pathsTable[cultivator:Get('path')]['Multipliers']['healthMulti']

	local realmInfo = cultivator:Get('realmTable')
	local majorInt = realmInfo['MajorRealm']

	local growthFactor = 1.2

	local finalHealth = math.floor(baseHealth * math.exp(growthFactor * majorInt) * healthMultiplier)

	return finalHealth
end


return formulae
