-- margaret - starts with 6 bombs and 2 ropes, garebear had this idea
-- ana - gets a random item on 1-1
-- colin - starts with udjat eye
-- alto - gets 2 hrid hands on start
-- coco - starts with $5000
-- nekka - starts with boomerang
-- guy - starts with extra supplies
-- roffy - gets gloves instantly, also has no bombs and no ropes
-- valerie - nothing for now
-- airyn - starts with bonus health
-- classic guy - starts with shotgun

initfuncs = {}
initfuncs.items = {ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, ENT_TYPE.ITEM_PICKUP_PASTE, ENT_TYPE.ITEM_PICKUP_SKELETONKEY, ENT_TYPE.ITEM_PICKUP_COMPASS, ENT_TYPE.ITEM_PICKUP_SPRINGSHOES, ENT_TYPE.ITEM_PICKUP_SPIKESHOES, ENT_TYPE.ITEM_PICKUP_PARACHUTE, ENT_TYPE.ITEM_PICKUP_PITCHERSMITT, ENT_TYPE.ITEM_PICKUP_SPECTACLES}

initfuncs[ENT_TYPE.CHAR_GUY_SPELUNKY] = function(uid)
    p = get_entity(uid):as_player()
    p.inventory.bombs = p.inventory.bombs + math.random(0, 3)
    p.inventory.ropes = p.inventory.ropes + math.random(0, 3) 
end

initfuncs[ENT_TYPE.CHAR_COCO_VON_DIAMONDS] = function(uid) 
    v = get_entity(uid):as_player()
    v.inventory.money = v.inventory.money + 5000
end



initfuncs[ENT_TYPE.CHAR_MARGARET_TUNNEL] = function(uid)
    v = get_entity(uid):as_player()
    v.inventory.bombs = 6
    v.inventory.ropes = 2
end


initfuncs[ENT_TYPE.CHAR_ROFFY_D_SLOTH] = function(uid)
    v = get_entity(uid):as_player()
    x, y, l = get_position(uid)
    pick_up(uid, spawn(ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, x, y, l, 0, 0))
    v.inventory.bombs = 0
    v.inventory.ropes = 0
end

initfuncs[ENT_TYPE.CHAR_COLIN_NORTHWARD] = function(uid)
    x, y, l = get_position(uid)
    pick_up(uid, spawn(ENT_TYPE.ITEM_PICKUP_UDJATEYE, x, y, l, 0, 0))
end

initfuncs[ENT_TYPE.CHAR_MANFRED_TUNNEL] = function(uid)
    x, y, l = get_position(uid)
    id = set_timeout(function ()
        pick_up(uid, spawn(ENT_TYPE.ITEM_MATTOCK, x, y, l, 0, 0))
        clear_callback(id)
    end, 1)
end

initfuncs[ENT_TYPE.CHAR_ANA_SPELUNKY] = function(uid)
    x, y, l = get_position(uid)
    index = math.random(1, #initfuncs.items)
    item = initfuncs.items[index]
    if not item then return end
    id = set_timeout(function ()
        item = spawn(item, x, y, l, 0, 0)
        pick_up(uid, item) 
        clear_callback(id)
    end, 1)
end

initfuncs[ENT_TYPE.CHAR_BANDA] = function(uid)
    x, y, l = get_position(uid)
    spawn(ENT_TYPE.ITEM_COFFIN, x - 0.5, y, l, 0, 0)
    spawn(ENT_TYPE.ITEM_COFFIN, x + 0.5, y, l, 0, 0)
end

initfuncs[ENT_TYPE.CHAR_CLASSIC_GUY] = function(uid)
    x, y, l = get_position(uid)
    if get_entity(uid).holding_uid == -1 then
        pick_up(uid, spawn(ENT_TYPE.ITEM_SHOTGUN, x, y, l, 0, 0))
    else
        spawn(ENT_TYPE.ITEM_SHOTGUN, x, y, l, 0, 0)
    end
    
end

initfuncs[ENT_TYPE.CHAR_PRINCESS_AIRYN] = function(uid)
    p = get_entity(uid):as_player()
    p.health = math.random(5, 10)
end
return initfuncs