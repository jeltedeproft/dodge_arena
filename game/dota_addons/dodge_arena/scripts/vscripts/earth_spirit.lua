local earth_spirit = {}
local kickAbilities = {}
local placeAbilities = {}
local positions = {Vector(750, 1600, 300),Vector(2250, 320, 300) ,Vector(-1350, -200, 300) ,Vector(-150, -1700, 300)} 
local orientations = {Vector(-0.5, -0.5, 0),Vector(-0.6, -0.4, 0) ,Vector(0.6, 0.4, 0) ,Vector(0.5, 0.5, 0)}
local kick_directions = {Vector(-0.55, -0.45, 0),Vector(-0.5, -0.5, 0) ,Vector(0.55, 0.45, 0) ,Vector(0.5, 0.5, 0)}   
local numEarth = 4

function initEarthSpirit() 
	for i = 1, numEarth do
		earth_spirit[i] = CreateUnitByName("kicker_earth_spirit", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, earth_spirit[i])
		FindClearSpaceForUnit(earth_spirit[i], positions[i], true)
		kickAbilities[i] = earth_spirit[i]:FindAbilityByName("earth_spirit_boulder_smash_custom")
		kickAbilities[i]:SetLevel(1)
		placeAbilities[i] = earth_spirit[i]:FindAbilityByName("earth_spirit_stone_caller_custom")
		placeAbilities[i]:SetLevel(1)
		print("earth spirit top" .. i .. " created")
		ability = earth_spirit[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
		Timers:CreateTimer(0.06, function()
			earth_spirit[i]:CastAbilityOnPosition(positions[i], placeAbilities[i], 0)
			return
		end
		)
	end
	
	startPatrol_earthSpirit()
end

function act_earthSpirit(earthSpiritNum)
	earth_spirit[earthSpiritNum]:SetForwardVector(orientations[earthSpiritNum])

	earth_spirit[earthSpiritNum]:CastAbilityOnPosition(earth_spirit[earthSpiritNum]:GetAbsOrigin() + kick_directions[earthSpiritNum], kickAbilities[earthSpiritNum], 0)	
end

function patrol_earthSpirit(earthSpiritNum)
	Timers:CreateTimer(0, function()
		while earth_spirit[earthSpiritNum]:IsNull() == false do
			act_earthSpirit(earthSpiritNum)
			return 6
		end
	end
	)
end


function startPatrol_earthSpirit()
	for i = 1, numEarth do	
		patrol_earthSpirit(i)
	end
end