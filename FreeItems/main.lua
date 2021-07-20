set_callback(function ()
    for i, v in ipairs(get_entities_by_mask(0x8)) do
		e = get_entity(v)
		if e then
			e = e:as_movable()
			if testflag(e.flags, 23) and get_entity_type(e.uid) ~= ENT_TYPE.MONS_PET_DOG then
				e.price = 0
			end
		end
	end
end, ON.LEVEL)
