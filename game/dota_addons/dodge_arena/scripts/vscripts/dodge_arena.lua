-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode


-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false 

if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end

-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')
-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')
-- This library can be used for performing "Frankenstein" attachments on units
require('libraries/attachments')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')

require('mirana')
require('earth_spirit')
require('gyrocopter')
require('invoker')
require('lina')
require('earthshaker')
require('pudge')
require('sniper')
require('invoker2')
require('bloodseeker')
require('riki')
require('omniknight')
require('techies')
require('disruptor')
require('lich')


--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  DebugPrint("[BAREBONES] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[BAREBONES] First Player has loaded")
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  DebugPrint("[BAREBONES] All Players have loaded into the game")
  total_amount_of_players = PlayerResource:GetTeamPlayerCount()
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)
  DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

  nplayersalive = nplayersalive + 1

  local player = hero:GetPlayerOwner()
  local playerId = player:GetPlayerID()
  PlayerResource:SetGold(playerId, 0, false)
  

  -- These lines will create an item and add it to the player, effectively ensuring they start with the item
  local item_blink = CreateItem("item_blink", hero, hero)
  local item_force = CreateItem("item_force_staff_custom", hero, hero)
  hero:AddItem(item_blink)
  hero:AddItem(item_force)

  local ability_zero = hero:GetAbilityByIndex(0)
  local ability_one = hero:GetAbilityByIndex(1)
  local ability_two = hero:GetAbilityByIndex(2)
  local ability_three = hero:GetAbilityByIndex(3)
  local ability_four = hero:GetAbilityByIndex(4)
  local ability_five = hero:GetAbilityByIndex(5)
  ability_zero:SetLevel(4)
  ability_one:SetLevel(4)
  ability_two:SetLevel(4)
  ability_three:SetLevel(4)
  ability_four:SetLevel(4)
  ability_five:SetLevel(4)
  hero:SetAbilityPoints(0)
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
  DebugPrint("[BAREBONES] The game has officially begun")

  Timers:CreateTimer(10,
    function()
      ROUND = ROUND + 1
      GameMode:StartNewRound(RandomInt(1,13))

      EmitGlobalSound("Item.PickUpGemWorld")
      local spawnPoint = Vector(RandomFloat(-800,1300),RandomFloat(-1300,800),300)
      local newItem = CreateItem( "item_bag_of_gold", nil, nil )
      local drop = CreateItemOnPositionForLaunch( spawnPoint, newItem )
      newItem:LaunchLootInitialHeight( false, 0, 500, 0.75, spawnPoint + RandomVector( 50 ) )
      newItem:SetContextThink( "KillLoot", function() return self:KillLoot( newItem, drop ) end, 20 )

      return 7.0  
  end)
end

--Removes Bags of Gold after they expire
function GameMode:KillLoot( item, drop )

  if drop:IsNull() then
    return
  end

  local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, drop )
  ParticleManager:SetParticleControl( nFXIndex, 0, drop:GetOrigin() )
  ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
  ParticleManager:ReleaseParticleIndex( nFXIndex )
  EmitGlobalSound("Item.PickUpWorld")

  UTIL_Remove( item )
  UTIL_Remove( drop )
end

function GameMode:StartNewRound(round)
  if round == 1 then
    initMirana()
    Notifications:TopToAll({text="Adding Mirana!", duration=5.0})
  end
  if round == 2 then
    initEarthSpirit()
    Notifications:TopToAll({text="Adding Earth Spirit!", duration=5.0})
  end
  if round == 3 then
    initGyro()
    Notifications:TopToAll({text="Adding Gyrocopter!", duration=5.0})
  end
  if round == 4 then
    initInvoker()
    Notifications:TopToAll({text="Adding Invoker!", duration=5.0})
  end
  if round == 5 then
    initLina() 
    Notifications:TopToAll({text="Adding Lina!", duration=5.0})
  end
  if round == 6 then
    initEarth()
    Notifications:TopToAll({text="Adding Earthshaker!", duration=5.0}) 
  end
  if round == 7 then
    initPudge()
    Notifications:TopToAll({text="Adding Pudge!", duration=5.0}) 
  end
  if round == 8 then
    initSniper()
    Notifications:TopToAll({text="Adding Sniper!", duration=5.0})
  end
  if round == 9 then
    initBlood()
    Notifications:TopToAll({text="Adding Blood!", duration=5.0})
  end
  if round == 10 then
    initRiki()
    Notifications:TopToAll({text="Adding Riki!", duration=5.0}) 
  end
  if round == 11 then
    initTechies()
    Notifications:TopToAll({text="Adding Techies!", duration=5.0}) 
  end
  if round == 12 then
    initDisruptor()
    Notifications:TopToAll({text="Adding Disruptor!", duration=5.0}) 
  end
  if round == 13 then
    initLich()
    Notifications:TopToAll({text="Adding Lich!", duration=5.0}) 
  end
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')
  

  GameMode:_InitGameMode()

  GameRules.my_unit_table = {}
  GameRules.dead_heroes = {}
  roundGoing = true
  ROUND = 0
  nplayersalive = 0

  scores = {}
  for i=1, 20 do
    scores[i] = 0
  end
  max_score = 0

  initOmni()

  GameRules:SetHeroSelectionTime(0)
  GameRules:SetPreGameTime(0)
  GameRules:SetSameHeroSelectionEnabled(true)
  GameRules:SetGoldPerTick(0)
  GameRules:SetUseBaseGoldBountyOnHeroes(true)
  GameRules:SetFirstBloodActive(false)
  --GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_SHOP, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_COURIER, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_QUICKBUY, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_SHOP_SUGGESTEDITEMS, false )
  --GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_GOLD, false )
  GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )

  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
end


