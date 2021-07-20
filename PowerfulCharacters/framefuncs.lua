-- manfred - has mattock all the time
-- tina - eggplants deal 3 damage instead of 1
-- classic guy - bullets deal 5 damage instead of 4
-- pilot - wakes up from stuns faster
-- lise - she walks 1.5x faster than everyone else, but her sprint doesn't change

framefuncs = {}
framefuncs.val_cooldown = 0
framefuncs.au_money = {ENT_TYPE.ITEM_SAPPHIRE, ENT_TYPE.ITEM_RUBY, ENT_TYPE.ITEM_EMERALD}


framefuncs[ENT_TYPE.CHAR_VALERIE_CRUMP] = function(uid)
    p = get_entity(uid):as_player()
    x, y, l = get_position(uid)
    if testflag(p.buttons, 6) and p.movey > 0 and framefuncs.val_cooldown == 0 then
        -- if testflag(p.flags, 17) then
        bubble = get_entity(spawn(ENT_TYPE.ITEM_AXOLOTL_BUBBLESHOT, x, y, l, 0, 0)):as_movable()
        bubble.color.r = 255 / 255
        bubble.color.g = 100 / 255
        bubble.color.b = 184 / 255
        framefuncs.val_cooldown = 180
    end
    if framefuncs.val_cooldown ~= 0 then framefuncs.val_cooldown = framefuncs.val_cooldown - 1 end
end

framefuncs[ENT_TYPE.CHAR_CLASSIC_GUY] = function(uid)
    bullets = get_entities_by_type(ENT_TYPE.ITEM_BULLET)
    for i, v in ipairs(bullets) do
        bullet = get_entity(v):as_movable()
        if bullet.last_owner_uid == uid then
            bullet.type.damage = 5
        end 
    end
end

framefuncs[ENT_TYPE.CHAR_LISE_SYSTEM] = function(uid)
    p = get_entity(uid):as_player()
    p.type.max_speed = 0.09625
    p.type.sprint_factor = 1.5
end  

framefuncs[ENT_TYPE.CHAR_TINA_FLAN] = function(uid)
    eggplants = get_entities_by_type(ENT_TYPE.ITEM_EGGPLANT)
    for i, v in ipairs(eggplants) do
        get_entity(v):as_movable().type.damage = 3
    end
end

framefuncs[ENT_TYPE.CHAR_PILOT] = function(uid)
    p = get_entity(uid):as_player()
    if p == nil then return end
    if p.stun_timer >= 75 then
      p.stun_timer = math.floor(p.stun_timer / 3)
    end
end

-- framefuncs[ENT_TYPE.CHAR_AU] = function(uid)
--     if state.level ~= 4 then return end
--     for i, v in ipairs(get_entities_by_type(framefuncs.au_money)) do
--         if get_entity(v):as_movable().overlay == nil then
--             replace(v, ENT_TYPE.ITEM_DIAMOND, 1, 1)
--         end
--     end
-- end

return framefuncs