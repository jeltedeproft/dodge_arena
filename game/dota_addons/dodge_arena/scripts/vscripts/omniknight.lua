local omni = 0
local repelAbility = 0
local position = Vector(0, 4000, 300) 
local orientation = Vector(0, -1, 0)

function initOmni() 
	omni = CreateUnitByName("omni_custom", position, true, nil, nil, 1)
	repelAbility = omni:FindAbilityByName("omniknight_repel_datadriven")
	repelAbility:SetLevel(1)
	ability = omni:FindAbilityByName("Invulnerable") 
	ability:SetLevel(1)
end

function act_omni(omniNum)
	print("doing the repelling")
	local heroes = HeroList:GetAllHeroes()
	for k, hero in pairs(heroes) do
		print(hero:GetUnitName())
		print(hero:GetOwner())
		print(hero:GetOwnerEntity())
		print(hero:GetTeamNumber())
		print(hero:GetPlayerID())
		Timers:CreateTimer({
		  endTime = k + 1, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
		  callback = function()
		    omni:CastAbilityOnTarget(hero,repelAbility, 0)
		  end
		})		
	end
end

