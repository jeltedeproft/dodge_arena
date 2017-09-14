-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('dodge_arena')

if CDodgeArena == nil then
  CDodgeArena = class({})
end

function Precache( context )
  DebugPrint("[BAREBONES] Performing pre-load precache")

  PrecacheResource("particle_folder","particles/units/heroes/hero_invoker", context)
  PrecacheResource("particle_folder","particles/units/heroes/hero_techies", context)


  -- Entire items can be precached by name
  -- Abilities can also be precached in this way despite the name
  PrecacheItemByNameSync("item_blink", context)
  PrecacheItemByNameSync("item_force_staff", context)
  PrecacheItemByNameSync("earthshaker_fissure", context)
  PrecacheItemByNameSync("techies_land_mines", context)

  PrecacheModel("models/heroes/meepo/meepo.vmdl", context)
  PrecacheModel("models/heroes/techies/fx_techiesfx_mine.vmdl", context)

  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  PrecacheUnitByNameSync("npc_dota_hero_mirana", context)
  PrecacheUnitByNameSync("npc_dota_hero_puck", context)
  PrecacheUnitByNameSync("npc_dota_hero_antimage", context)
  PrecacheUnitByNameSync("npc_dota_hero_queenofpain", context)
  PrecacheUnitByNameSync("npc_dota_hero_earthspirit", context)
  PrecacheUnitByNameSync("npc_dota_hero_gyrocopter", context)
  PrecacheUnitByNameSync("npc_dota_hero_invoker", context)
  PrecacheUnitByNameSync("npc_dota_hero_lina", context)
  PrecacheUnitByNameSync("npc_dota_hero_templar_assassin", context)
  PrecacheUnitByNameSync("npc_dota_hero_earthshaker", context)
  PrecacheUnitByNameSync("npc_dota_hero_pudge", context)
  PrecacheUnitByNameSync("npc_dota_hero_sniper", context)
  PrecacheUnitByNameSync("npc_dota_hero_rubick", context)
  PrecacheUnitByNameSync("npc_dota_hero_bloodseeker", context)
  PrecacheUnitByNameSync("npc_dota_hero_omniknight", context)
  PrecacheUnitByNameSync("npc_dota_hero_riki", context)
  PrecacheUnitByNameSync("npc_dota_hero_techies", context)
  PrecacheUnitByNameSync("npc_dota_hero_disruptor", context)
  PrecacheUnitByNameSync("npc_dota_hero_lich", context)
end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()
end