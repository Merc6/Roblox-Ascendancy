local manager = {}

manager.Profiles = {}
local template = require(script.Parent.Template)

local function getProfile(player: Player)
	local profile = manager.Profiles[player]
	if not profile then
		return warn("Profile could not be found for: " .. player.Name)
	else
		return profile
	end
end

manager.update = function(player: Player, newTable)
	if not newTable then
		return error("Attempt to rewrite data to nil (newTable Var not provided)")
	elseif type(newTable) ~= 'table' then
		return error("Variable provided is not a table")
	end
	
	local profile = getProfile(player)
	local clone = {}
	
	for indexName, value in newTable do
		if template[indexName] ~= nil then
			clone[indexName] = value
		else
			warn('extra data found in '..player.Name.."'s profile, removing it temporarily")
		end
	end
	profile.Data = clone
end

return manager
