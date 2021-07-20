achievement_functions = {}
achievement_functions["Cavepala"] = function ()
    for _, v in ipairs(get_entities_by_type(ENT_TYPE.MONS_CAVEMAN)) do
        local caveman  = get_entity(v)
        if caveman.health > 0 and caveman.stun_timer > 0 then
            local floor = get_entity(caveman.standing_on_uid)
            if floor and floor.type.id == ENT_TYPE.FLOOR_ALTAR then
                if state.kali_favor == 14 or state.kali_favor == 15 then
                    return true
                end
            end
        end
    end
end

achievement_functions["Triple Crown"] = function ()
    if entity_has_item_type(players[1].uid, ENT_TYPE.ITEM_POWERUP_CROWN) then
        if entity_has_item_type(players[1].uid, ENT_TYPE.ITEM_POWERUP_EGGPLANTCROWN) then
            if entity_has_item_type(players[1].uid, ENT_TYPE.ITEM_POWERUP_TRUECROWN) then
                return true
            end
        end
    end
end

achievement_functions["Qilin To Sunken City"] = function ()
    if state.theme == THEME.SUNKEN_CITY then
        if #get_entities_by_type(ENT_TYPE.MOUNT_QILIN) >= 1 then
            return true
        end
    end
end

achievement_functions["Golden Key to Tiamat"] = function ()
    if state.theme == THEME.TIAMAT and state.world == 6 then
        if get_entity_type(players[1].holding_uid) == ENT_TYPE.ITEM_LOCKEDCHEST_KEY and players[1].state == CHAR_STATE.STANDING then
            return true
        end
    end
end

achievement_functions["Volcana Junk to Tiamat"] = function ()
    if state.theme == THEME.TIAMAT then
        if get_entity_type(players[1].holding_uid) == ENT_TYPE.ITEM_SCRAP and players[1].state == CHAR_STATE.STANDING then
            return true
        end
    end
end

achievement_functions["Eggplant to Tiamat"] = function ()
    if state.theme == THEME.TIAMAT then
        if get_entity_type(players[1].holding_uid) == ENT_TYPE.ITEM_EGGPLANT and players[1].state == CHAR_STATE.STANDING then
            return true
        end
    end
end

return achievement_functions