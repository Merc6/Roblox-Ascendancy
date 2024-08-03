local Paths = {}

--[[
format:

Paths['YOUR_PATH_NAME'] = {
	['Realms'] = {
	
	} -- 'REALM_NAME = SUBREALMS'
	['Multipliers'] = {
	
	}
}

]]

-- Multiplier format will always be: name(lower)..'Multi'

-- Standard Paths

Paths['Heavenly'] = {
	['Realms'] = {
		{['Qi Gathering'] = 10},
		{['Qi Compressing'] = 10},
		{['Qi Liquidation'] = 10},
		{['Foundation Setting'] = 10},
		{['Foundation Establishment'] = 10},
		{['Qi Solidifying'] = 10},
		{['Bronze Core Formation'] = 10},
		{['Silver Core Formation'] = 10},
		{['Gold Core Formation'] = 10},
		{['Core Smoothing'] = 10},
		{['Final Core Compression'] = 10},
		{['Core Breaking'] = 10},
		{['Nascent Soul Birth'] = 10},
		{['Nascent Soul Nurturing'] = 10},
		{['Nascent Soul Adolesence'] = 10},
		{['Soul-Body Alignment'] = 10},
		{['Soul-Body Fusion'] = 10},
		{['Fused Spirit'] = 10},
		{['Spirit Adjustment'] = 10},
		{['Spirit Mastery'] = 10},
		{['Void Peering'] = 10},
		{['Void Comprehension'] = 10},
		{['Void Spirit'] = 10},
		{['Pre-Divine Tribulation'] = 10},
		{['Divine Tribulation'] = 10},
		{['Mahayana Comprehension'] = 10},
		{['Mortal Shedding'] = 10},
		{['Immortal Gates'] = 10},
		{['True Immortal'] = 10},
		{['King of Immortals'] = 10},
	},
	['Multipliers'] = {
		['qiMulti'] = 1,
		['healthMulti'] = 1
	}
}

Paths['Demonic'] = {
	['Realms'] = {
		
	},
	['Multipliers'] = {
		['qiMulti'] = 1,
		['healthMulti'] = 1
	}
}

Paths['Beastly'] = {
	['Realms'] = {
		
	},
	['Multipliers'] = {
		['qiMulti'] = 1,
		['healthMulti'] = 1
	}
}

-- Unique Paths

Paths['DemonicProgenitor'] = { -- path for ThePrinceUndead729
	['Realms'] = {
		{['Shadow Emergence'] = 10},
		{['Essence Corruption'] = 10},
		{['Vein Infusion'] = 10},
		{['Dark Foundation'] = 10},
		{['Abyssal Core Initiation'] = 10},
		{['Eclipse Core Formation'] = 10},
		{['Crimson Core Stabilization'] = 10},
		{['Umbral Core Amplification'] = 10},
		{['Infernal Core Mastery'] = 10},
		{['Soul Desecration'] = 10},
		{['Soul-Shadow Meld'] = 10},
		{['Abyss Gaze'] = 10},
		{['Nether Soul Incarnation'] = 10},
		{['Netherworld Command'] = 10},
		{['Demonic Soul Transcendence'] = 10},
		{['Ethereal Corruption'] = 10},
		{['Void Resonance'] = 10},
		{['Chaos Spirit Emergence'] = 10},
		{['Spiritual Domination'] = 10},
		{['Hellfire Baptism'] = 10},
		{['Abyssal Overlord'] = 10},
		{['Demon King Ascension'] = 10},
		{['Eternal Damnation'] = 10},
		{['Pre-Apocalyptic Tribulation'] = 10},
		{['Apocalyptic Tribulation'] = 10},
		{['Demonic Sovereign'] = 10},
		{['Eclipse of Mortality'] = 10},
		{['Gatekeeper of the Fallen'] = 10},
		{['Supreme Demon Lord'] = 10},
		{['Overlord of the Nether'] = 10},
	},
	
	['Multipliers'] = {
		['qiMulti'] = 2,
		['healthMulti'] = 1.5,
		
	}
}

Paths.GetRealmInfo = function(pathName: string, realmInt: IntValue)
	local realm: string
	local subrealms: IntValue
	for name, val in pairs(Paths[pathName]['Realms'][realmInt]) do
		realm, subrealms = name, val
	end
	return realm, subrealms
end

local function pathTest()
	local playerPath = 'Heavenly'
	local playerRealmInt = 1
	
	-- Debug: Print the Paths table
	local function thouroughTest()
		if Paths then
			print("Paths table exists.")
			if Paths[playerPath] then
				print("Player path exists.")
				if Paths[playerPath]['Realms'] then
					print("Realms table exists.")
					print("First element in Realms:", Paths[playerPath]['Realms'][1])
				else
					print("Realms table does not exist.")
				end
			else
				print("Player path does not exist.")
			end
		else
			print("Paths table does not exist.")
		end
	end
	
	local realm
	for name in pairs(Paths[playerPath]['Realms'][playerRealmInt]) do
		realm = name
	end
	
	if realm then
		if realm == 'Qi Gathering' then
			print('pathTest: Pass')
		else
			thouroughTest()
			error('\npathTest: Fail\nExpected "Qi Gathering" and got: ' .. tostring(realm))
		end
	else
		thouroughTest()
		error("Realm is nil.")
	end
end

pathTest()

return Paths
