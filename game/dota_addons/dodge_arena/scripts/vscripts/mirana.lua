local mirana = {}
local arrowAbilities = {}
local positions = {Vector(250, 1600, 300),Vector(2200, 0, 300) ,Vector(-1400, 0, 300) ,Vector(350, -1700, 300)}  
local numMirana = 4
local orientations = {Vector(0, -1, 0),Vector(-1, 0, 0) ,Vector(1, 0, 0) ,Vector(0, 1, 0)}

function initMirana() 

	for i = 1, numMirana do
		mirana[i] = CreateUnitByName("arrow_mirana", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, mirana[i])
		arrowAbilities[i] = mirana[i]:FindAbilityByName("mirana_arrow_custom")
		arrowAbilities[i]:SetLevel(1)
		print("mirana " .. i .. " created")
		ability = mirana[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end
	startPatrol_mirana()
end

function act_mirana(miranaNum)
	if miranaNum == 1 then
		local randomAngle = RandomFloat(1,2.1)
		mirana[miranaNum]:SetForwardVector(orientations[miranaNum])
		mirana[miranaNum]:CastAbilityOnPosition(mirana[miranaNum]:GetAbsOrigin() + Vector(math.cos(randomAngle),math.sin(-0.5),300), arrowAbilities[miranaNum], 0)
	elseif miranaNum == 2 then
		local randomAngle = RandomFloat(-0.5,0.5)
		mirana[miranaNum]:SetForwardVector(orientations[miranaNum])
		mirana[miranaNum]:CastAbilityOnPosition(mirana[miranaNum]:GetAbsOrigin() + Vector(math.cos(2.1),math.sin(randomAngle),300), arrowAbilities[miranaNum], 0)
	elseif miranaNum == 3 then
		local randomAngle = RandomFloat(-0.5,0.5)
		mirana[miranaNum]:SetForwardVector(orientations[miranaNum])
		mirana[miranaNum]:CastAbilityOnPosition(mirana[miranaNum]:GetAbsOrigin() + Vector(0.5,math.sin(randomAngle),300), arrowAbilities[miranaNum], 0)
	elseif miranaNum == 4 then
		local randomAngle = RandomFloat(1,2.1)
		mirana[miranaNum]:SetForwardVector(orientations[miranaNum])
		mirana[miranaNum]:CastAbilityOnPosition(mirana[miranaNum]:GetAbsOrigin() + Vector(math.cos(randomAngle),math.sin(0.5),300), arrowAbilities[miranaNum], 0)
	end
end

function patrol_mirana(miranaNum)
	Timers:CreateTimer(0, function()
		while mirana[miranaNum]:IsNull() == false do
			act_mirana(miranaNum)
			return 6
		end
	end
	)
end


function startPatrol_mirana()
	for i = 1, numMirana do	
		patrol_mirana(i)
	end
end