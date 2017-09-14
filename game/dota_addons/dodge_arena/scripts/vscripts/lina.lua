local lina = {}
local lightAbilities = {}
local positions = {Vector(210, 1520, 300),Vector(2150, -500, 300) ,Vector(-1420, 80, 300) ,Vector(360, -1610, 300)}  
local numlina = 4
local orientations = {Vector(0, -1, 0),Vector(-1, 0, 0) ,Vector(1, 0, 0) ,Vector(0, 1, 0)}

function initLina() 

	for i = 1, numlina do
		lina[i] = CreateUnitByName("lina_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, lina[i])
		lightAbilities[i] = lina[i]:FindAbilityByName("lina_light_strike_array_custom")
		lightAbilities[i]:SetLevel(1)
		print("lina " .. i .. " created")
		ability = lina[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end

	startPatrol_lina()
end

function act_lina(linaNum)
	local randomPosInField = Vector(RandomFloat(-800,1300),RandomFloat(-1300,800),300)
	lina[linaNum]:CastAbilityOnPosition(randomPosInField, lightAbilities[linaNum], 0)
end

function patrol_lina(linaNum)
	Timers:CreateTimer(0, function()
		while lina[linaNum]:IsNull() == false do
			act_lina(linaNum)
			return 6
		end
	end
	)
end


function startPatrol_lina()
	for i = 1, numlina do	
		patrol_lina(i)
	end
end