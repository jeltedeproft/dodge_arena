local gyro = {}
local rocketAbilities = {}
local positions = {Vector(2300, -300, 300) ,Vector(400, -1700, 300)}  
local numGyro = 2

function initGyro() 

	for i = 1, numGyro do
		gyro[i] = CreateUnitByName("gyrocopter_static", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, gyro[i])
		FindClearSpaceForUnit(gyro[i], positions[i], true)
		rocketAbilities[i] = gyro[i]:FindAbilityByName("gyrocopter_homing_missile_static")
		rocketAbilities[i]:SetLevel(1)
		print("gyro " .. i .. " created")
		ability = gyro[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end

	startPatrol_gyro()
end

function act_gyro(gyroNum)
	local units = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, gyro[gyroNum]:GetAbsOrigin(), nil, 4000, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

	if (gyro[gyroNum]:GetAbsOrigin() ~= positions[gyroNum]) then
		FindClearSpaceForUnit(gyro[gyroNum], positions[gyroNum], false)
	end
	gyro[gyroNum]:CastAbilityOnTarget(units[1],rocketAbilities[gyroNum], 0)	
end

function patrol_gyro(gyroNum)
	Timers:CreateTimer(0, function()
		while gyro[gyroNum]:IsNull() == false do
			act_gyro(gyroNum)
			return 15
		end
	end
	)
end


function startPatrol_gyro()
	for i = 1, numGyro do	
		patrol_gyro(i)
	end
end