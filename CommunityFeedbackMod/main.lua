meta.name = "Community Feedback Mod"
meta.description = "Adds some of the community's feedback to the game."
meta.version = "WIP"
meta.author = "C_ffeeStain"

poison_cures = 0
has_elixir_cooldown = 0
poison_cure_heart_id, poison_cure_heart_width, poison_cure_heart_height = create_image("poision_cure_heart.png")
uids_sold = {}

-- guarenteed leprechaun in large levels
set_callback(function ()
    if state.width > 4 and state.height > 4 then
        local xmin, ymin, xmax, ymax = get_bounds()
        local no_air = true
        while no_air do
            x = math.random(math.floor(xmin), math.floor(xmax))
            y = math.random(math.floor(ymax), math.floor(ymin))
            wallcheck = get_entities_at(0, 0x180, x, y, 0, 0.5)
            if #wallcheck == 0 then
                no_air = false
            end
        end
        spawn(ENT_TYPE.MONS_LEPRECHAUN, x, y, 0, 0, 0)
    end
end, ON.LEVEL)

-- nice elixir buff
set_callback(function ()
    if has_elixir_cooldown > 0 then
        has_elixir_cooldown = has_elixir_cooldown - 1
        return
    end
    elixirs = get_entities_by_type(ENT_TYPE.ITEM_PICKUP_ELIXIR)
    if #elixirs == 0 then return end
    for i, v in ipairs(elixirs) do
        if get_entity(v):overlaps_with(players[1]) then
            has_elixir_cooldown = 300
            poison_cures = poison_cures + 3
            toast("You feel blessed!")
        end
    end
end, ON.FRAME)

set_callback(function ()
    for i, v in ipairs(players) do
        if v:is_poisoned() and poison_cures >= 1 then
            poison_cures = poison_cures - 1
            v:poison(-1)
        end
    end
end, ON.FRAME)

set_callback(function ()
    if players[1].state == 22 then return end
    if state.pause == 0 then return end
    -- x, y, l = get_position(players[1].uid)
    -- psx, psy = screen_position(x, y)
    draw_image(poison_cure_heart_id, -0.95, 0.8, -0.88, 0.68, 0, 0, 1, 1, rgba(255, 255, 255, 100))
    draw_text(-0.901, 0.755, 24, tostring(poison_cures), 0xffffffff)
end, ON.GUIFRAME)

set_callback(function ()
    poison_cures = 0
end, ON.RESET)

-- skellies have better hitbox
set_callback(function ()
    for _, v in ipairs(get_entities_by_type(ENT_TYPE.MONS_SKELETON)) do
        local mov = get_entity(v):as_movable()
        if mov.animation_frame == 32 then
            mov.hitboxy = 0.265
        else
            mov.hitboxy = 0.438
        end
    end
end, ON.GAMEFRAME)

-- sell idols to yang :D
set_callback(function ()
    if state.world == 1 then
        local yangs = get_entities_by_type(ENT_TYPE.MONS_YANG)
        if #yangs == 0 then return end
        for i, v in ipairs(yangs) do
            local mov = get_entity(v):as_movable()
            local yx, yy, yl = get_position(v)
            idols = get_entities_by_type(ENT_TYPE.ITEM_IDOL)
            for i1, v1 in ipairs(idols) do
                for i2, v2 in ipairs(uids_sold) do
                    if v1 == v2 then return end
                end
                local ix, iy, il = get_position(v1)
                local idol = get_entity(v1):as_movable()
                if math.abs(yx - ix) <= 2 and math.abs(yy - iy) <= 1 and idol.owner_uid == -1 and idol.standing_on_uid ~= -1 then
                    -- cb_id = set_timeout(function ()
                        generate_particles(PARTICLEEMITTER.TREASURE_SPARKLE_HIGH, v1)
                        get_sound(VANILLA_SOUND.UI_DEPOSIT):play()
                        idol.flags = setflag(idol.flags, 1)
                        idol.flags = clrflag(idol.flags, 18)
                        uids_sold[#uids_sold+1] = v1
                        say(v, "Thanks for the idol, friend!", 1, true)
                        players[1].inventory.money = players[1].inventory.money + 5000
                        set_timeout(function ()
                            move_entity(v1, 0, 0, 0, 0)
                        end, 20)
                        clear_callback(cb_id)
                    -- end, 10)
                end
            end
        end
    end
end, ON.FRAME)