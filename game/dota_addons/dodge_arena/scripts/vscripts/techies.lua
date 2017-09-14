local techies = {}
local mineAbilities = {}
local positions = {Vector(700, 1550, 300),Vector(2200, 700, 300) ,Vector(-1350, 700, 300) ,Vector(700, -1650, 300)}  
local numtechies = 4
local orientations = {Vector(0, -1, 0),Vector(-1, 0, 0) ,Vector(1, 0, 0) ,Vector(0, 1, 0)}

function initTechies() 

	for i = 1, numtechies do
		techies[i] = CreateUnitByName("techies_custom", positions[i], true, nil, nil, 1)
		table.insert(GameRules.my_unit_table, techies[i])
		mineAbilities[i] = techies[i]:FindAbilityByName("techies_mine_custom")
		mineAbilities[i]:SetLevel(1)
		print("techies " .. i .. " created")
		ability = techies[i]:FindAbilityByName("Invulnerable") 
		ability:SetLevel(1)
	end

	startPatrol_techies()
end

function act_techies(techiesNum)
	local randomPosInField = Vector(RandomFloat(-800,1300),RandomFloat(-1300,800),300)
	techies[techiesNum]:CastAbilityOnPosition(randomPosInField, mineAbilities[techiesNum], 0)
end

function patrol_techies(techiesNum)
	Timers:CreateTimer(0, function()
		while techies[techiesNum]:IsNull() == false do
			act_techies(techiesNum)
			return 12
		end
	end
	)
end


function startPatrol_techies()
	for i = 1, numtechies do	
		patrol_techies(i)
	end
end

function removetechies()
	local mines = Entities:FindAllByClassname("npc_dota_techies_mines")

    for _,mine in pairs(mines) do
        if mine:GetUnitName() == "npc_dota_techies_land_mine" then
            UTIL_Remove(mine)
        end
    end
end
