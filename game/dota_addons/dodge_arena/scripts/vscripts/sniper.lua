local sniper = {}
local assassinateAbilities = {}
local positions = {Vector(1010, 1520, 300),Vector(2340, -320, 300) ,Vector(-1370, -520, 300) ,Vector(410, -1720, 300)}  
local numsniper = 4

function initSniper() 

	for i = 1, numsniper do
		sniper[i] = CreateUnitByName("sniper_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, sniper[i])
		assassinateAbilities[i] = sniper[i]:FindAbilityByName("assassinate_custom")
		assassinateAbilities[i]:SetLevel(1)
		print("sniper " .. i .. " created")
		ability = sniper[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end

	startPatrol_sniper()
end

function act_sniper(sniperNum)
	local units = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, sniper[sniperNum]:GetAbsOrigin(), nil, 4000, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

	if (sniper[sniperNum]:GetAbsOrigin() ~= positions[sniperNum]) then
		FindClearSpaceForUnit(sniper[sniperNum], positions[sniperNum], false)
	end
	sniper[sniperNum]:CastAbilityOnTarget(units[1],assassinateAbilities[sniperNum], 0)	
end

function patrol_sniper(sniperNum)
	Timers:CreateTimer(0, function()
		while sniper[sniperNum]:IsNull() == false do
			act_sniper(sniperNum)
			return 10
		end
	end
	)
end


function startPatrol_sniper()
	for i = 1, numsniper do	
		patrol_sniper(i)
	end
end