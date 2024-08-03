local Breakthrough = {}
local cultivatorHandling = require(game.ServerScriptService.GameHandling.CultivatorRelated.CultivatorHandling)
local pathTable = require(game.ServerScriptService.GameHandling.CultivatorRelated.Paths)
local formulae = require(game.ServerScriptService.GameHandling.Formulae)
local updateGUi = require(game.ServerScriptService.GameHandling.DisplayUpdating.UpdateGuis)

local function MinorBreaktrhough(player: Player)
	-- minor realm up one but not major
	local cultivator = cultivatorHandling.getCultivatorFromPlayer(player)
	cultivator:IncrimentTable('realmTable', 'MinorRealm', 1)
end

local function MajorBreakthrough(player: Player)
	-- minor realm set to zero and major up one
	local cultivator = cultivatorHandling.getCultivatorFromPlayer(player)
	cultivator:SetTable('realmTable', 'MinorRealm', 0)
	cultivator:IncrimentTable('realmTable', 'MajorRealm', 1)
end

Breakthrough.Breakthrough = function(player: Player)
	local cultivator = cultivatorHandling.getCultivatorFromPlayer(player)
	if cultivator:Get('isCultivating') then return end -- meaning the player is cultivating already
	
	local path = cultivator:Get('path')
	local realmInfo = cultivator:Get('realmTable')
	
	local RealmName, SubRealms = pathTable.GetRealmInfo(path, realmInfo['MajorRealm'])
	
	if realmInfo['MajorRealm'] == #pathTable[path] and realmInfo['MinorRealm'] == SubRealms then return end
	
	local breakthroughReq = formulae.BreakthroughRequirement(player)
	
	if cultivator:Get('currentQi') >= breakthroughReq then
		print('player can breakthrough')
		if realmInfo['MinorRealm'] >= SubRealms then
			print('player has performed a major breakthrough')
			MajorBreakthrough(player)
		else
			print('player has performed a minor breakthrough')
			MinorBreaktrhough(player)
		end
		cultivator:Incriment('currentQi', -breakthroughReq)
		updateGUi.updateAll(player)
	else
		print('player, you need '.. breakthroughReq - cultivator:Get('currentQi')..' more qi')
	end
end

return Breakthrough
