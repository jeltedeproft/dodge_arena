local blood = {}
local riteAbilities = {}
local positions = {Vector(500, 1550, 300),Vector(2200, 500, 300) ,Vector(-1350, 500, 300) ,Vector(500, -1650, 300)}  
local numblood = 4
local orientations = {Vector(0, -1, 0),Vector(-1, 0, 0) ,Vector(1, 0, 0) ,Vector(0, 1, 0)}

function initBlood() 

	for i = 1, numblood do
		blood[i] = CreateUnitByName("bloodseeker_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, blood[i])
		riteAbilities[i] = blood[i]:FindAbilityByName("blood_rite_custom")
		riteAbilities[i]:SetLevel(1)
		print("blood " .. i .. " created")
		ability = blood[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end

	startPatrol_blood()
end

function act_blood(bloodNum)
	local randomPosInField = Vector(RandomFloat(-800,1300),RandomFloat(-1300,800),300)
	blood[bloodNum]:CastAbilityOnPosition(randomPosInField, riteAbilities[bloodNum], 0)
end

function patrol_blood(bloodNum)
	Timers:CreateTimer(0, function()
		while blood[bloodNum]:IsNull() == false do
			act_blood(bloodNum)
			return 6
		end
	end
	)
end


function startPatrol_blood()
	for i = 1, numblood do	
		patrol_blood(i)
	end
end