local Cultivate = {}
local DebounceTable = {}
local cultivatorHandler = require(game.ServerScriptService.GameHandling.CultivatorRelated.CultivatorHandling)
local formulae = require(game.ServerScriptService.GameHandling.Formulae)
local updateDisplay = game.ReplicatedStorage.Events.UpdateGui

local COOLDOWN_TIME = 1 -- in seconds

local function generateQi(player)
	task.spawn(function()
		local cultivator = cultivatorHandler.getCultivatorFromPlayer(player)
		local qiPerTick = formulae.QiPerTick(player)
		
		while cultivator:Get('isCultivating') do
			if not game.Players[player.Name] then return end
			local currentQi = cultivator:Get('currentQi')
			local maxQi = cultivator:Get('maxQi')
			local breakthroughAmount = formulae.BreakthroughRequirement(player)
			
			-- maxQi system --
			--[[
			If it's less than the max qi then the gain is sped up.
			qi is gained passively but the passive gain never goes above the max amount.
			]]
			
			if currentQi >= maxQi then
				local stuntedQi = math.floor(qiPerTick ^ (2/3))
				cultivator:Incriment('currentQi', stuntedQi)
				cultivator:Incriment('maxQi', stuntedQi)
			else
				if maxQi - currentQi > 0 then
					local cappedQiPerTick = math.min(qiPerTick, maxQi - currentQi)
					cultivator:Incriment('currentQi', cappedQiPerTick)
				else
					cultivator:Incriment('currentQi', qiPerTick)
				end
			end
			updateDisplay:FireClient(player)
			wait(COOLDOWN_TIME)
		end
	end)
end

Cultivate.Cultivate = function(player)
	if DebounceTable[player] then return print('At least you tried') end
	DebounceTable[player] = true
	
	print('your trying was successful')
	
	local cultivator = cultivatorHandler.getCultivatorFromPlayer(player)
	
	if cultivator:Get('isCultivating') then
		cultivator:Set('isCultivating', false)
	else
		cultivator:Set('isCultivating', true)
		generateQi(player)
	end
	task.spawn(function()
		wait(1)
		DebounceTable[player] = false
	end)
end

return Cultivate
