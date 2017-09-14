-- This file contains all barebones-registered events and has already set up the passed-in parameters for your use.
-- Do not remove the GameMode:_Function calls in these events as it will mess with the internal barebones systems.

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
  DebugPrint('[BAREBONES] Player Disconnected ' .. tostring(keys.userid))
  DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid

end
-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
  DebugPrint("[BAREBONES] GameRules State Changed")
  DebugPrintTable(keys)

  -- This internal handling is used to set up main barebones functions
  GameMode:_OnGameRulesStateChange(keys)

  local newState = GameRules:State_Get()
end

-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
        local npc = EntIndexToHScript(keys.entindex)
        if npc:IsRealHero() and npc.bFirstSpawned == nil then
          npc.bFirstSpawned = true
          GameMode:OnHeroInGame(npc)
        elseif npc:GetUnitName() == "npc_dota_neutral_kobold" then
          Timers:CreateTimer( 1.0 , function()
          npc:ForceKill(true)
       end)
    end
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
  --DebugPrint("[BAREBONES] Entity Hurt")
  --DebugPrintTable(keys)

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless
  if keys.entindex_attacker ~= nil and keys.entindex_killed ~= nil then
    local entCause = EntIndexToHScript(keys.entindex_attacker)
    local entVictim = EntIndexToHScript(keys.entindex_killed)

    -- The ability/item used to damage, or nil if not damaged by an item/ability
    local damagingAbility = nil

    if keys.entindex_inflictor ~= nil then
      damagingAbility = EntIndexToHScript( keys.entindex_inflictor )
    end
  end
end

-- An item was picked up off the ground
function GameMode:OnItemPickedUp(keys)
  print("item picked up")
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local itemname = keys.itemname

  local item = EntIndexToHScript( keys.ItemEntityIndex )
  local owner = EntIndexToHScript( keys.HeroEntityIndex )

  r = 100

  if keys.itemname == "item_bag_of_gold" then
    PlayerResource:ModifyGold( owner:GetPlayerID(), r, true, 0 )
    UTIL_Remove( item ) -- otherwise it pollutes the player inventory
  end
end

-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys)
  DebugPrint( '[BAREBONES] OnPlayerReconnect' )
  DebugPrintTable(keys) 
end

-- An item was purchased by a player
function GameMode:OnItemPurchased( keys )
  DebugPrint( '[BAREBONES] OnItemPurchased' )
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
  
end

-- An ability was used by a player
function GameMode:OnAbilityUsed(keys)
  DebugPrint('[BAREBONES] AbilityUsed')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityname = keys.abilityname
end

-- A non-player entity (necro-book, chen creep, etc) used an ability
function GameMode:OnNonPlayerUsedAbility(keys)
  DebugPrint('[BAREBONES] OnNonPlayerUsedAbility')
  DebugPrintTable(keys)

  local abilityname=  keys.abilityname
end

-- A player changed their name
function GameMode:OnPlayerChangedName(keys)
  DebugPrint('[BAREBONES] OnPlayerChangedName')
  DebugPrintTable(keys)

  local newName = keys.newname
  local oldName = keys.oldName
end

-- A player leveled up an ability
function GameMode:OnPlayerLearnedAbility( keys)
  DebugPrint('[BAREBONES] OnPlayerLearnedAbility')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local abilityname = keys.abilityname
end

-- A channelled ability finished by either completing or being interrupted
function GameMode:OnAbilityChannelFinished(keys)
  DebugPrint('[BAREBONES] OnAbilityChannelFinished')
  DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

-- A player leveled up
function GameMode:OnPlayerLevelUp(keys)
  DebugPrint('[BAREBONES] OnPlayerLevelUp')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local level = keys.level
end

-- A player last hit a creep, a tower, or a hero
function GameMode:OnLastHit(keys)
  DebugPrint('[BAREBONES] OnLastHit')
  DebugPrintTable(keys)

  local isFirstBlood = keys.FirstBlood == 1
  local isHeroKill = keys.HeroKill == 1
  local isTowerKill = keys.TowerKill == 1
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local killedEnt = EntIndexToHScript(keys.EntKilled)
end

-- A tree was cut down by tango, quelling blade, etc
function GameMode:OnTreeCut(keys)
  DebugPrint('[BAREBONES] OnTreeCut')
  DebugPrintTable(keys)

  local treeX = keys.tree_x
  local treeY = keys.tree_y
end

-- A rune was activated by a player
function GameMode:OnRuneActivated (keys)
  DebugPrint('[BAREBONES] OnRuneActivated')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local rune = keys.rune

  --[[ Rune Can be one of the following types
  DOTA_RUNE_DOUBLEDAMAGE
  DOTA_RUNE_HASTE
  DOTA_RUNE_HAUNTED
  DOTA_RUNE_ILLUSION
  DOTA_RUNE_INVISIBILITY
  DOTA_RUNE_BOUNTY
  DOTA_RUNE_MYSTERY
  DOTA_RUNE_RAPIER
  DOTA_RUNE_REGENERATION
  DOTA_RUNE_SPOOKY
  DOTA_RUNE_TURBO
  ]]
end

-- A player took damage from a tower
function GameMode:OnPlayerTakeTowerDamage(keys)
  DebugPrint('[BAREBONES] OnPlayerTakeTowerDamage')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local damage = keys.damage
end

-- A player picked a hero
function GameMode:OnPlayerPickHero(keys)
  DebugPrint('[BAREBONES] OnPlayerPickHero')
  DebugPrintTable(keys)

  local heroClass = keys.hero
  local heroEntity = EntIndexToHScript(keys.heroindex)
  local player = EntIndexToHScript(keys.player)
end

-- A player killed another player in a multi-team context
function GameMode:OnTeamKillCredit(keys)
  DebugPrint('[BAREBONES] OnTeamKillCredit')
  DebugPrintTable(keys)

  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
  local numKills = keys.herokills
  local killerTeamNumber = keys.teamnumber
end

-- An entity died
function GameMode:OnEntityKilled( keys )
  DebugPrint( '[BAREBONES] OnEntityKilled Called' )
  DebugPrintTable( keys )

  GameMode:_OnEntityKilled( keys )
  

  -- The Unit that was Killed
  local killedUnit = EntIndexToHScript( keys.entindex_killed )

  if killedUnit:IsHero() then
    nplayersalive = nplayersalive - 1

    if nplayersalive > 0 then
      FindClearSpaceForUnit(killedUnit,Vector(0,4000,300),true)
      table.insert(GameRules.dead_heroes, killedUnit)
      GameMode:MoveToOuterRing(killedUnit)
    else
      local number = killedUnit:GetTeamNumber()
      print(number)
      scores[number] = scores[number] + ROUND

      if scores[number] >= 30 then
        GameRules:SetSafeToLeave( true )
        GameRules:SetGameWinner( killedUnit:GetTeam() )
      end

      local player = killedUnit:GetPlayerOwner()
      local player_id = killedUnit:GetPlayerOwnerID()
      
      local broadcast_kill_event =
      {
          killer_id = player_id,
          team_id = number,
          team_kills = scores[number],
          kills_remaining = 30 - scores[number],
          victory = 0,
          close_to_victory = 0,
          very_close_to_victory = 0,
      }

      CustomGameEventManager:Send_ServerToAllClients( "kill_event", broadcast_kill_event )

      print(scores[number])
      CustomNetTables:SetTableValue( "score", tostring(number), {value = scores[number]} )
      
      killedUnit:RespawnHero(false, false, false)
      FindClearSpaceForUnit(killedUnit,Vector(0,0,300),true)
    end
    GameMode:EndRoundCheck()
  end

  -- -- The Killing entity
  -- local killerEntity = nil

  -- if keys.entindex_attacker ~= nil then
  --   killerEntity = EntIndexToHScript( keys.entindex_attacker )
  -- end

  -- -- The ability/item used to kill, or nil if not killed by an item/ability
  -- local killerAbility = nil

  -- if keys.entindex_inflictor ~= nil then
  --   killerAbility = EntIndexToHScript( keys.entindex_inflictor )
  -- end

  -- local damagebits = keys.damagebits -- This might always be 0 and therefore useless
end

function GameMode:MoveToOuterRing(killedUnit)
  local number = killedUnit:GetTeamNumber()
  scores[number] = scores[number] + ROUND
  local player = killedUnit:GetPlayerOwner()
  local player_id = killedUnit:GetPlayerOwnerID()


  local broadcast_kill_event =
  {
      killer_id = player_id,
      team_id = number,
      team_kills = scores[number],
      kills_remaining = 30 - scores[number],
      victory = 0,
      close_to_victory = 0,
      very_close_to_victory = 0,
  }

  CustomGameEventManager:Send_ServerToAllClients( "kill_event", broadcast_kill_event )

  CustomNetTables:SetTableValue( "score", tostring(number), {value = scores[number]} )

    Timers:CreateTimer({
      endTime = 3, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
      callback = function()
          puck_wall = CreateUnitByName("meepo_custom", Vector(205, 1670, 300), true, nil, player, 1)
          FindClearSpaceForUnit(puck_wall,Vector(205, 1670, 300),false)
          puck_wall:FindAbilityByName("mirana_arrow_custom"):SetLevel(4)
          puck_wall:FindAbilityByName("lina_light_strike_array_custom"):SetLevel(4)
          puck_wall:FindAbilityByName("Invulnerable"):SetLevel(1)
          puck_wall:FindAbilityByName("invoker_sun_strike_custom"):SetLevel(1)
          puck_wall:FindAbilityByName("invoker_exort"):SetLevel(1)
          puck_wall:FindAbilityByName("Passthrough"):SetLevel(1)
          puck_wall:FindAbilityByName("fissure_custom"):SetLevel(4)
          puck_wall:FindAbilityByName("hook_custom"):SetLevel(4)
          puck_wall:FindAbilityByName("blood_rite_custom"):SetLevel(4)
          table.insert(GameRules.my_unit_table, puck_wall)
          puck_wall:SetControllableByPlayer(player_id, true)
          PlayerResource:SetCameraTarget(player_id, puck_wall)
          Timers:CreateTimer(0.5, function()
            PlayerResource:SetCameraTarget(player_id  , nil)
          end)
      end
    })
end

function GameMode:EndRoundCheck()
  if nplayersalive == 0 then
    GameMode:Refresh()
  end
end

function GameMode:Refresh()
  local units = GameRules.my_unit_table
  local i = 0

  -- removing the units
  for k, unit2 in pairs(units) do
    if IsValidEntity(unit2) then
      unit2:ForceKill(false)
      unit2 = nil
    end
  end

  removetechies();

  ROUND = 0

  nplayersalive = total_amount_of_players

  local dead_heroes = GameRules.dead_heroes

  for number,unit in pairs(dead_heroes) do
    unit:RespawnHero(false, false, false)
    FindClearSpaceForUnit(unit,Vector(0,0,300),true)
  end
  act_omni(1)
end




-- This function is called 1 to 2 times as the player connects initially but before they 
-- have completely connected
function GameMode:PlayerConnect(keys)
  DebugPrint('[BAREBONES] PlayerConnect')
  DebugPrintTable(keys)
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)
  DebugPrint('[BAREBONES] OnConnectFull')
  DebugPrintTable(keys)

  GameMode:_OnConnectFull(keys)
  
  local entIndex = keys.index+1
  -- The Player entity of the joining user
  local ply = EntIndexToHScript(entIndex)
  
  -- The Player ID of the joining player
  local playerID = ply:GetPlayerID()
end

-- This function is called whenever illusions are created and tells you which was/is the original entity
function GameMode:OnIllusionsCreated(keys)
  DebugPrint('[BAREBONES] OnIllusionsCreated')
  DebugPrintTable(keys)

  local originalEntity = EntIndexToHScript(keys.original_entindex)
end

-- This function is called whenever an item is combined to create a new item
function GameMode:OnItemCombined(keys)
  DebugPrint('[BAREBONES] OnItemCombined')
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end
  local player = PlayerResource:GetPlayer(plyID)

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
end

-- This function is called whenever an ability begins its PhaseStart phase (but before it is actually cast)
function GameMode:OnAbilityCastBegins(keys)
  DebugPrint('[BAREBONES] OnAbilityCastBegins')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityName = keys.abilityname
end

-- This function is called whenever a tower is killed
function GameMode:OnTowerKill(keys)
  DebugPrint('[BAREBONES] OnTowerKill')
  DebugPrintTable(keys)

  local gold = keys.gold
  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local team = keys.teamnumber
end

-- This function is called whenever a player changes there custom team selection during Game Setup 
function GameMode:OnPlayerSelectedCustomTeam(keys)
  DebugPrint('[BAREBONES] OnPlayerSelectedCustomTeam')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.player_id)
  local success = (keys.success == 1)
  local team = keys.team_id
end

-- This function is called whenever an NPC reaches its goal position/target
function GameMode:OnNPCGoalReached(keys)
  DebugPrint('[BAREBONES] OnNPCGoalReached')
  DebugPrintTable(keys)

  local goalEntity = EntIndexToHScript(keys.goal_entindex)
  local nextGoalEntity = EntIndexToHScript(keys.next_goal_entindex)
  local npc = EntIndexToHScript(keys.npc_entindex)
end

-- This function is called whenever any player sends a chat message to team or All
function GameMode:OnPlayerChat(keys)
  local teamonly = keys.teamonly
  local userID = keys.userid
  local playerID = self.vUserIds[userID]:GetPlayerID()

  local text = keys.text
end