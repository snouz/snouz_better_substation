
local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require ("__base__.prototypes.entity.sounds")

local graphics = "__snouz_better_substation__/graphics"
local ENTITYPATH = graphics .. "/entity/"


data:extend(
{
  {
    type = "item",
    name = "snouz_better_substation",
    icon = graphics .. "/icons/snouz_better_substation.png",
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-dda[snouz_better_substation]",
    inventory_move_sound = item_sounds.electric_large_inventory_move,
    pick_sound = item_sounds.electric_large_inventory_pickup,
    drop_sound = item_sounds.electric_large_inventory_move,
    place_result = "snouz_better_substation",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust,
    weight = 40 * kg
  },

  {
    type = "recipe",
    name = "snouz_better_substation",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {type = "item", name = "substation", amount = 4},
      {type = "item", name = "steel-plate", amount = 15}
    },
    results = {{type="item", name="snouz_better_substation", amount=1}}
  },

  {
    type = "technology",
    name = "snouz_better_substation_tech",
    icon = graphics .. "/technology/snouz_better_substation_tech.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "snouz_better_substation"
      }
    },
    prerequisites = {"electric-energy-distribution-2", "utility-science-pack"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
  },

  {
    type = "electric-pole",
    name = "snouz_better_substation",
    icon = graphics .. "/icons/snouz_better_substation.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.4, result = "snouz_better_substation"},
    fast_replaceable_group = "substation3x3",
    max_health = 300,
    corpse = "snouz_better_substation-remnants",
    dying_explosion = "substation-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 95
      }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity({{-0.5, -2.5}, {0.5, 0.5}}),
    drawing_box_vertical_extension = 2,
    maximum_wire_distance = 29,
    supply_area_distance = 14.5,
    auto_connect_up_to_n_wires = 6,
    --maximum_wire_distance = 18,
    --supply_area_distance = 9,
    pictures =
    {
      layers =
      {
        {
          filename = ENTITYPATH .. "snouz_better_substation.png",
          priority = "high",
          width = 300,
          height = 300,
          direction_count = 1,
          scale = 0.5,
        },
        {
          filename = ENTITYPATH .. "snouz_better_substation_shadow.png",
          priority = "high",
          width = 300,
          height = 300,
          direction_count = 1,
          scale = 0.5,
          shift = util.by_pixel(20, 0),
          draw_as_shadow = true,
        }
      }
    },
    impact_category = "metal",
    open_sound = sounds.electric_network_open,
    close_sound = sounds.electric_network_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/substation.ogg",
        volume = 0.4
      },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.32,
      fade_in_ticks = 30,
      fade_out_ticks = 40,
      use_doppler_shift = false
    },
    connection_points = {
      {
        shadow = {
          copper = util.by_pixel(80, 12),
          green = util.by_pixel(83, 8),
          red = util.by_pixel(57, 21)
        },
        wire = {
          copper = util.by_pixel(0, -68),
          green = util.by_pixel(12, -71),
          red = util.by_pixel(-12, -52)
        }
      },
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      width = 12,
      height = 12,
      priority = "extra-high-no-scale"
    },
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/substation/substation-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 28,
        shift = util.by_pixel(-5, 65),
        variation_count = 1,
        scale = 7
      },
      rotate = false,
      orientation_to_variation = false
    }
  },


  {
    type = "corpse",
    name = "snouz_better_substation-remnants",
    icon = graphics .. "/icons/snouz_better_substation.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "energy-pipe-distribution-remnants",
    order = "a-d-a",
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = {
      filename = ENTITYPATH .. "snouz_better_substation_remnant.png",
      line_length = 1,
      width = 256,
      height = 256,
      frame_count = 1,
      direction_count = 1,
      shift = {0,0},
      scale = 0.5
    }
  },
})

if mods["space-age"] then
  table.insert(data.raw["technology"]["snouz_better_substation_tech"].prerequisites, "electromagnetic-science-pack")
  table.insert(data.raw["technology"]["snouz_better_substation_tech"].unit.ingredients, {"electromagnetic-science-pack", 1})
  table.insert(data.raw["recipe"]["snouz_better_substation"].ingredients, {type = "item", name = "supercapacitor", amount = 2})
  data.raw["item"]["snouz_better_substation"].default_import_location = "fulgora"
end
  