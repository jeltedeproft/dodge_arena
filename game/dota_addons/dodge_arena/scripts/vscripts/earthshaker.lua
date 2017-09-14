local earth = {}
local fissureAbilities = {}
local positions = {Vector(215, 1540, 300),Vector(2180, 80, 300) ,Vector(-1320, 70, 300) ,Vector(330, -1680, 300)}  
local numearth = 4
local orientations = {Vector(0, -1, 0),Vector(-1, 0, 0) ,Vector(1, 0, 0) ,Vector(0, 1, 0)}

function initEarth() 

	for i = 1, numearth do
		earth[i] = CreateUnitByName("earthshaker_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, earth[i])
		FindClearSpaceForUnit(earth[i], positions[i], true)
		fissureAbilities[i] = earth[i]:FindAbilityByName("fissure_custom")
		fissureAbilities[i]:SetLevel(1)
		print("earthshaker " .. i .. " created")
		ability = earth[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end
	startPatrol_earth()
end

function act_earth(earthNum)
	if earthNum == 1 then
		local randomAngle = RandomFloat(1,2.1)
		earth[earthNum]:SetForwardVector(orientations[earthNum])
		earth[earthNum]:CastAbilityOnPosition(earth[earthNum]:GetAbsOrigin() + Vector(math.cos(randomAngle),math.sin(-0.5),300), fissureAbilities[earthNum], 0)
	elseif earthNum == 2 then
		local randomAngle = RandomFloat(-0.5,0.5)
		earth[earthNum]:SetForwardVector(orientations[earthNum])
		earth[earthNum]:CastAbilityOnPosition(earth[earthNum]:GetAbsOrigin() + Vector(math.cos(2.1),math.sin(randomAngle),300), fissureAbilities[earthNum], 0)
	elseif earthNum == 3 then
		local randomAngle = RandomFloat(-0.5,0.5)
		earth[earthNum]:SetForwardVector(orientations[earthNum])
		earth[earthNum]:CastAbilityOnPosition(earth[earthNum]:GetAbsOrigin() + Vector(0.5,math.sin(randomAngle),300), fissureAbilities[earthNum], 0)
	elseif earthNum == 4 then
		local randomAngle = RandomFloat(1,2.1)
		earth[earthNum]:SetForwardVector(orientations[earthNum])
		earth[earthNum]:CastAbilityOnPosition(earth[earthNum]:GetAbsOrigin() + Vector(math.cos(randomAngle),math.sin(0.5),300), fissureAbilities[earthNum], 0)
	end
end

function patrol_earth(earthNum)
	Timers:CreateTimer(0, function()
		while earth[earthNum]:IsNull() == false do
			act_earth(earthNum)
			return 6
		end
	end
	)
end


function startPatrol_earth()
	for i = 1, numearth do	
		patrol_earth(i)
	end
end