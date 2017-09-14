local invoker2 = {}
local blastAbilities = {}
local positions = {Vector(2190, 90, 300) ,Vector(-1330, 90, 300)}  
local numinvoker2 = 2
local orientations = {Vector(-1, 0, 0) ,Vector(1, 0, 0)}

function initInvoker2() 

	for i = 1, numinvoker2 do
		invoker2[i] = CreateUnitByName("invoker_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, invoker2[i])
		blastAbilities[i] = invoker2[i]:FindAbilityByName("invoker_deafening_blast_datadriven")
		blastAbilities[i]:SetLevel(1)
		print("invoker2 " .. i .. " created")
		ability = invoker2[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
		ability = invoker2[i]:FindAbilityByName("invoker_exort") 
		ability:SetLevel(1)
		ability = invoker2[i]:FindAbilityByName("invoker_quas") 
		ability:SetLevel(1)
		ability = invoker2[i]:FindAbilityByName("invoker_wex") 
		ability:SetLevel(1)
	end
	startPatrol_invoker2()
end

function act_invoker2(invoker2Num)
	if invoker2Num == 1 then
		invoker2[invoker2Num]:SetForwardVector(orientations[invoker2Num])
		invoker2[invoker2Num]:CastAbilityOnPosition(invoker2[invoker2Num]:GetAbsOrigin() + Vector(-200,0,300), blastAbilities[invoker2Num], 0)
	elseif invoker2Num == 2 then
		invoker2[invoker2Num]:SetForwardVector(orientations[invoker2Num])
		invoker2[invoker2Num]:CastAbilityOnPosition(invoker2[invoker2Num]:GetAbsOrigin() + Vector(800,0,300), blastAbilities[invoker2Num], 0)
	end
end

function patrol_invoker2(invoker2Num)
	Timers:CreateTimer(0.3, function()
		while invoker2[invoker2Num]:IsNull() == false do
			act_invoker2(invoker2Num)
			return 1
		end
	end
	)
end


function startPatrol_invoker2()
	for i = 1, numinvoker2 do	
		patrol_invoker2(i)
	end
end