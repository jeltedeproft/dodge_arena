local disruptor = {}
local fieldAbilities = {}
local positions = {Vector(1000, 1550, 300),Vector(2200, 1000, 300) ,Vector(-1350, 1000, 300) ,Vector(1000, -1650, 300)}  
local numdisruptor = 2
local orientations = {Vector(0, -1, 0),Vector(1, 0, 0) ,}

function initDisruptor() 

	for i = 1, numdisruptor do
		disruptor[i] = CreateUnitByName("disruptor_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, disruptor[i])
		fieldAbilities[i] = disruptor[i]:FindAbilityByName("disruptor_field_custom")
		fieldAbilities[i]:SetLevel(1)
		print("disruptor " .. i .. " created")
		ability = disruptor[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end

	startPatrol_disruptor()
end

function act_disruptor(disruptorNum)
	local randomPosInField = Vector(RandomFloat(-800,1300),RandomFloat(-1300,800),300)
	disruptor[disruptorNum]:CastAbilityOnPosition(randomPosInField, fieldAbilities[disruptorNum], 0)
end

function patrol_disruptor(disruptorNum)
	Timers:CreateTimer(0, function()
		while disruptor[disruptorNum]:IsNull() == false do
			act_disruptor(disruptorNum)
			return 6
		end
	end
	)
end


function startPatrol_disruptor()
	for i = 1, numdisruptor do	
		patrol_disruptor(i)
	end
end
