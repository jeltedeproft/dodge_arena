local riki = {}
local smokeAbilities = {}
local positions = {Vector(425, 1550, 300),Vector(2250,550, 300) ,Vector(-1350, 660, 300) ,Vector(700, -1650, 300)}  
local numriki = 4
local orientations = {Vector(0, -1, 0),Vector(-1, 0, 0) ,Vector(1, 0, 0) ,Vector(0, 1, 0)}

function initRiki() 

	for i = 1, numriki do
		riki[i] = CreateUnitByName("riki_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, riki[i])
		smokeAbilities[i] = riki[i]:FindAbilityByName("smoke_custom")
		smokeAbilities[i]:SetLevel(1)
		print("riki " .. i .. " created")
		ability = riki[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end

	startPatrol_riki()
end

function act_riki(rikiNum)
	local randomPosInField = Vector(RandomFloat(-800,1300),RandomFloat(-1300,800),300)
	riki[rikiNum]:CastAbilityOnPosition(randomPosInField, smokeAbilities[rikiNum], 0)
end

function patrol_riki(rikiNum)
	Timers:CreateTimer(0, function()
		while riki[rikiNum]:IsNull() == false do
			act_riki(rikiNum)
			return 6
		end
	end
	)
end


function startPatrol_riki()
	for i = 1, numriki do	
		patrol_riki(i)
	end
end