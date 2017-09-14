local invoker = {}
local sunstrikeAbilities = {}
local positions = {Vector(225, 1550, 300),Vector(2200, 50, 300) ,Vector(-1350, 50, 300) ,Vector(300, -1650, 300)}  
local numinvoker = 4
local orientations = {Vector(0, -1, 0),Vector(-1, 0, 0) ,Vector(1, 0, 0) ,Vector(0, 1, 0)}

function initInvoker() 

	for i = 1, numinvoker do
		invoker[i] = CreateUnitByName("invoker_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, invoker[i])
		sunstrikeAbilities[i] = invoker[i]:FindAbilityByName("invoker_sun_strike_custom")
		sunstrikeAbilities[i]:SetLevel(1)
		print("invoker " .. i .. " created")
		ability = invoker[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
		ability = invoker[i]:FindAbilityByName("invoker_exort") 
		ability:SetLevel(1)
	end

	startPatrol_invoker()
end

function act_invoker(invokerNum)
	local randomPosInField = Vector(RandomFloat(-800,1300),RandomFloat(-1300,800),300)
	invoker[invokerNum]:CastAbilityOnPosition(randomPosInField, sunstrikeAbilities[invokerNum], 0)
end

function patrol_invoker(invokerNum)
	Timers:CreateTimer(0, function()
		while invoker[invokerNum]:IsNull() == false do
			act_invoker(invokerNum)
			return 6
		end
	end
	)
end


function startPatrol_invoker()
	for i = 1, numinvoker do	
		patrol_invoker(i)
	end
end