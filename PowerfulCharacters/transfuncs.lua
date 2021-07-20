-- demi - gains two hearts instead of one from saving the damsel

transfuncs = {}

transfuncs[ENT_TYPE.CHAR_DEMI_VON_DIAMONDS] = function(uid)
    if get_entities_by_type(ENT_TYPE.MONS_PET_DOG, ENT_TYPE.MONS_PET_CAT, ENT_TYPE.MONS_PET_HAMSTER) ~= {} then
        get_entity(uid):as_player().health = get_entity(uid):as_player().health + 1 
    end
end

return transfuncs