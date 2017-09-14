local pudge = {}
local hookAbilities = {}
local positions = {Vector(205, 1520, 300),Vector(2190, 90, 300) ,Vector(-1330, 90, 300) ,Vector(360, -1690, 300)}  
local numpudge = 4
local orientations = {Vector(0, -1, 0),Vector(-1, 0, 0) ,Vector(1, 0, 0) ,Vector(0, 1, 0)}

function initPudge() 

	for i = 1, numpudge do
		pudge[i] = CreateUnitByName("pudge_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, pudge[i])
		FindClearSpaceForUnit(pudge[i], positions[i], true)
		hookAbilities[i] = pudge[i]:FindAbilityByName("hook_custom")
		hookAbilities[i]:SetLevel(1)
		print("pudge " .. i .. " created")
		ability = pudge[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end
	startPatrol_pudge()
end

function act_pudge(pudgeNum)
	if pudgeNum == 1 then
		local randomAngle = RandomFloat(1,2.1)
		pudge[pudgeNum]:SetForwardVector(orientations[pudgeNum])
		pudge[pudgeNum]:CastAbilityOnPosition(pudge[pudgeNum]:GetAbsOrigin() + Vector(math.cos(randomAngle),math.sin(-0.5),0), hookAbilities[pudgeNum], 0)
	elseif pudgeNum == 2 then
		local randomAngle = RandomFloat(-0.5,0.5)
		pudge[pudgeNum]:SetForwardVector(orientations[pudgeNum])
		pudge[pudgeNum]:CastAbilityOnPosition(pudge[pudgeNum]:GetAbsOrigin() + Vector(math.cos(2.1),math.sin(randomAngle),0), hookAbilities[pudgeNum], 0)
	elseif pudgeNum == 3 then
		local randomAngle = RandomFloat(-0.5,0.5)
		pudge[pudgeNum]:SetForwardVector(orientations[pudgeNum])
		pudge[pudgeNum]:CastAbilityOnPosition(pudge[pudgeNum]:GetAbsOrigin() + Vector(0.5,math.sin(randomAngle),0), hookAbilities[pudgeNum], 0)
	elseif pudgeNum == 4 then
		local randomAngle = RandomFloat(1,2.1)
		pudge[pudgeNum]:SetForwardVector(orientations[pudgeNum])
		pudge[pudgeNum]:CastAbilityOnPosition(pudge[pudgeNum]:GetAbsOrigin() + Vector(math.cos(randomAngle),math.sin(0.5),0), hookAbilities[pudgeNum], 0)
	end
end

function patrol_pudge(pudgeNum)
	Timers:CreateTimer(0, function()
		while pudge[pudgeNum]:IsNull() == false do
			act_pudge(pudgeNum)
			return 6
		end
	end
	)
end


function startPatrol_pudge()
	for i = 1, numpudge do	
		patrol_pudge(i)
	end
end