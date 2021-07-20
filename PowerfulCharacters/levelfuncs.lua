-- coco - gets diamond every two levels, demi is always in IC coffin
-- tina - gets one heart per level
-- jay - cheaper shop prices except in BM
-- nekka - no snap traps in jungle
-- classic guy - starts with shotgun
-- dirk - robbing is less punishing

levelfuncs = {}
levelfuncs.au_money = {ENT_TYPE.ITEM_SAPPHIRE, ENT_TYPE.ITEM_RUBY, ENT_TYPE.ITEM_EMERALD}

-- this is a modified version of trix's replace function, thanks trix!
function replace(ent1, ent2, x_mod, y_mod)
     ex, ey, el = get_position(ent1)
     e = get_entity(ent1):as_movable()
   
     s = spawn(ent2, ex, ey, el, 0, 0)
     se = get_entity(s):as_movable()
     se.velocityx = e.velocityx*x_mod
     se.velocityy = e.velocityy*y_mod
   
     kill_entity(ent1)
     return se
end

-- thanks trix!
-- levelfuncs[ENT_TYPE.CHAR_AU] = function(uid)
--     set_interval(function()
--         x, y, l = get_position(uid)
--         local extra_dir = math.rad(math.random(360))
--         local newx = x + math.sin(extra_dir)*0.6
--         local newy = y + math.cos(extra_dir)*0.6
--         local wallcheck = get_entities_at(0, 0x180, newx, newy, l, 0.5)
--         if #wallcheck == 0 then
--             spawn(ENT_TYPE.ITEM_NUGGET_SMALL, newx, newy, l, (newx - x)*0.2, (newy - y)*0.2)
--         end
--     end, 45) -- every 45 frames
-- end

levelfuncs[ENT_TYPE.CHAR_MANFRED_TUNNEL] = function(uid)
    mov = get_entity(uid):as_movable()
    x, y, l = get_position(uid)
    if mov.holding_uid ~= -1 then
        holding_id = get_entity(mov.holding_uid):as_movable().type.id
        if holding_id ~= ENT_TYPE.ITEM_MATTOCK then
            id = set_timeout(function ()
                spawn(ENT_TYPE.ITEM_MATTOCK, x, y, l, 0, 0)
                clear_callback(id)
            end, 1)
        end
    else 
        id = set_timeout(function ()
            pick_up(uid, spawn(ENT_TYPE.ITEM_MATTOCK, x, y, l, 0, 0))
            clear_callback(id)
        end, 1) 
    end
end

levelfuncs[ENT_TYPE.CHAR_COCO_VON_DIAMONDS] = function(uid)
    x, y, l = get_position(uid)
    if state.level_count ~= 0 and state.level_count % 2 == 0  then
        spawn(ENT_TYPE.ITEM_DIAMOND, x, y, l, 0, 0)
    end
end

levelfuncs[ENT_TYPE.CHAR_AMAZON] = function(uid)
    if state.theme == THEME.JUNGLE then
        snaptraps = get_entities_by_type(ENT_TYPE.ITEM_SNAP_TRAP)
        for i, v in ipairs(snaptraps) do kill_entity(v) end
    end
end

levelfuncs[ENT_TYPE.CHAR_COCO_VON_DIAMONDS] = function(uid)
    if state.theme ~= THEME.ICE_CAVES then return end
    coffins = get_entities_by_type(ENT_TYPE.ITEM_COFFIN)
    for i, v in ipairs(coffins) do set_contents(v, ENT_TYPE.CHAR_DEMI_VON_DIAMONDS) end
end

levelfuncs[ENT_TYPE.CHAR_OTAKU] = function(uid)
    ents = get_entities_by_type(ENT_TYPE.LOGICAL_BLACKMARKET_DOOR)
    if #ents > 0 then return end
    for i, v in ipairs(get_entities_by_layer(LAYER.FRONT)) do
        e = get_entity(v)
        if get_entity(v) then
            mov = e:as_movable()
            if testflag(mov.flags, 23) then
                mov.price = math.floor(mov.price / 2)
            end
        end
    end
end

levelfuncs[ENT_TYPE.CHAR_TINA_FLAN] = function(uid) spawn_entity_over(ENT_TYPE.ITEM_COOKEDTURKEY, uid, 0, 0) end

levelfuncs[ENT_TYPE.CHAR_DIRK_YAMAOKA]  = function(uid)
    if state.shoppie_aggro == 0 then return end
    state.shoppie_aggro = state.shoppie_aggro - 1
end

levelfuncs[ENT_TYPE.CHAR_AU] = function(uid)
    for i, v in ipairs(get_entities_by_mask(MASK.ITEM)) do
        e = get_entity(v)
        if e then
            mov = e:as_movable()
            if testflag(mov.flags, 23) then
                mov.price = math.random(0, 15000)
            end
        end
    end
end

levelfuncs[ENT_TYPE.CHAR_GREEN_GIRL] = function (uid)
    if state.shoppie_aggro > 0 then
        state.shoppie_aggro = state.shoppie_aggro + 2
    end

    if (state.level == 4 and state.theme ~= THEME.COSMIC_OCEAN) or (state.theme == THEME.COSMIC_OCEAN and (state.level + 5) % 15 == 0) then
        local exits = get_entities_by_type(ENT_TYPE.FLOOR_DOOR_EXIT)
        local px, py, pl = get_position(uid)
        local exit1_x, exit1_y, exit1_l = get_position(exits[1])
        local sparrow = get_entity(spawn(ENT_TYPE.MONS_THIEF, exit1_x, exit1_y, exit1_l, 0, 0))
        local sx, sy, _ = get_position(sparrow.uid)
        if math.abs(px - sx) < 4 and math.abs(py - sy) < 2 then
            say(sparrow.uid, "Here's something I found in a shop a few days ago. I hope you find it useful", 1, false)
    end
end

return levelfuncs