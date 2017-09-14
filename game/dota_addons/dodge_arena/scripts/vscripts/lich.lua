local lich = {}
local frostAbilities = {}
local positions = {Vector(1210, 1520, 300)}  
local numlich = 1

function initLich() 

	for i = 1, numlich do
		lich[i] = CreateUnitByName("lich_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, lich[i])
		frostAbilities[i] = lich[i]:FindAbilityByName("frost_custom")
		frostAbilities[i]:SetLevel(1)
		print("lich " .. i .. " created")
		ability = lich[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end

	startPatrol_lich()
end

function act_lich(lichNum)
	local units = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, lich[lichNum]:GetAbsOrigin(), nil, 4000, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

	if (lich[lichNum]:GetAbsOrigin() ~= positions[lichNum]) then
		FindClearSpaceForUnit(lich[lichNum], positions[lichNum], false)
	end
	lich[lichNum]:CastAbilityOnTarget(units[1],frostAbilities[lichNum], 0)	
end

function patrol_lich(lichNum)
	Timers:CreateTimer(0, function()
		while lich[lichNum]:IsNull() == false do
			act_lich(lichNum)
			return 10
		end
	end
	)
end


function startPatrol_lich()
	for i = 1, numlich do	
		patrol_lich(i)
	end
end