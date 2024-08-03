local CultivatorClass = {}
local Cultivators = {}
CultivatorClass.__index = CultivatorClass
local manager = require(game.ServerScriptService.DataHandling.Manager)
local TemplateData = require(game.ServerScriptService.DataHandling.Template)

-- local functions
local function getCultivatorProfile(player: Player) -- checks to make sure the player is a cultivator
	if not Cultivators[player.UserId] then
		return warn(player.Name.." is not a cultivator")
	else 
		local cultivatorProfile = Cultivators[player.UserId]
		return cultivatorProfile
	end
end

local function syncData(player: Player) -- syncs data with the manager, call whenever you modify data
	local profile = getCultivatorProfile(player)

	local clone = {}
	for key, value in pairs(profile) do
		if TemplateData[key] ~= nil then
			clone[key] = value
		end
	end
	manager.update(player, clone)
end

-- CultivatorClass functions
CultivatorClass.new = function(player: Player)
	local self = setmetatable({}, CultivatorClass)
	local ManagerProfile = manager.Profiles[player].Data

	for key, val in pairs(ManagerProfile) do
		self[key] = val
	end

	self['playerInstance'] = player
	self['isCultivating'] = false
	self['qiMultipliers'] = {}
	
	Cultivators[player.UserId] = self
	return self
end

CultivatorClass.getCultivatorFromPlayer = function(player: Player)
	return getCultivatorProfile(player)
end

-- Cultivator Methods
function CultivatorClass:Get(key)
	if self[key] ~= nil then
		return self[key]
	elseif key == 'profile' then
		return self
	else
		print(self)
		return error("The key: "..key.." doesn't exist")
	end
end

function CultivatorClass:ModifyKeyWithFunction(key, func)
	if self[key] and type(func) == 'function' then
		local modifiedData = func(self[key])
		if modifiedData ~= nil then
			self[key] = modifiedData
			print(key.." has been successfully written")
			syncData(self.playerInstance)
		else
			error(tostring(func)..' passed nil, no data rewrite.')
		end
	else
		error('Key not found / modifier is not function')
	end
end

function CultivatorClass:Set(key, value)
	if self[key] ~= nil then
		self[key] = value
		syncData(self.playerInstance)
	else
		return error("The key: "..tostring(key)..", doesn't exist")
	end
end

function CultivatorClass:Incriment(key, incriment)
	local keyValue = self:Get(key)
	self:Set(key, keyValue + incriment)
end

function CultivatorClass:AwardTitle(title: string)
	local ownedTitles = self.titleTable.OwnedTitles
	
	if not ownedTitles[title] then
		table.insert(ownedTitles, title)
	else
		error(self['playerInstance'].Name..'already has the title: '..title)
	end
end

function CultivatorClass:IncrimentTable(tableName: string, indexName: string, incriment: number)
	local dataTable = self:Get(tableName)
	
	if dataTable[indexName] then
		dataTable[indexName] += incriment
	else
		error('The index '..indexName..' does not exist for the table '..tableName)
	end
end

function CultivatorClass:SetTable(tableName: string, indexName: string, value: number)
	local dataTable = self:Get(tableName)

	if dataTable[indexName] then
		dataTable[indexName] = value
	else
		error('The index '..indexName..' does not exist for the table '..tableName)
	end
end

return CultivatorClass
