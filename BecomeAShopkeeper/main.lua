meta = {
    name = "Become a Shoppie",
    description = "You get to own a shop in this mod!",
    version = "0.1",
    author = "C_ffeeStain"
}

local customers = {}
local random_exit = -1

define_tile_code("random_exit")

local basement_start = {23, 107}
local basement_end = {33, 104}
local shop_start = {25, 112}
local shop_end = {33, 107}

local random_level_cur = 0

local themes = {THEME.DWELLING, THEME.VOLCANA, THEME.JUNGLE, THEME.TIDE_POOL, THEME.TEMPLE, THEME.ICE_CAVES, THEME.NEO_BABYLON, THEME.SUNKEN_CITY, THEME.COSMIC_OCEAN}

local function place_tiles(start_x, start_y, end_x, end_y)
   local x = start_x
   local y = start_y
   while y >= end_y do
        while x <= end_x do
            get_entity(spawn(ENT_TYPE.BG_SHOP, x, y, 0, 0, 0)).animation_frame = 0x7
            x = x + 1
        end
        x = start_x
        y = y - 1
    end
end

set_pre_tile_code_callback(function (x, y, layer)
    random_exit = door(x, y, layer, 1, 1, themes[math.random(1, #themes)])
    spawn(ENT_TYPE.BG_SHOP_BACKDOOR, x, y, layer, 0, 0)

    return true
end, "random_exit")

set_callback(function ()
    if state.world == 1 and state.level == 4 then
        local shoppie = get_entities_by_type(ENT_TYPE.MONS_SHOPKEEPER)[1]
        local sx, sy, sl = get_position(shoppie)

        place_tiles(sx + 1, sy + 2, sx + 5, sy + 2)
        place_tiles(basement_start[1], basement_start[2], basement_end[1], basement_end[2])
        place_tiles(shop_start[1], shop_start[2], shop_end[1], shop_end[2])

        move_entity(shoppie, 0, 0, 0, 0)
        move_entity(players[1].uid, sx, sy, 0, 0)

        get_entity(spawn(ENT_TYPE.BG_SHOP, 24.5, 108, 0, 0, 0)).animation_frame = 0x9
        get_entity(spawn(ENT_TYPE.BG_SHOP, sx - 1, sy - 0.2, sl, 0, 0)).animation_frame = 0x4A
    end
end, ON.LOADING)

set_callback(function ()
    if state.world == 1 and state.level == 4 then
        for _, v in ipairs(get_entities_by_type(ENT_TYPE.MIDBG_STYLEDDECORATION)) do kill_entity(v) end
    end
end, ON.LEVEL)

set_callback(function ()
    random_level_cur = random_level_cur + 1
    state.theme_next = themes[math.random(1, #themes)]
    state.world_next = 1
    state.level_next = state.level + 1
end, ON.TRANSITION)

set_callback(function ()
    if state.level == 4 and state.world == 1 then
        if players[1]:button_pressed()
        win_open
    end
end, ON.GUIFRAME)