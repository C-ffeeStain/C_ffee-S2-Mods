meta.name = 'No Climbing Gloves Crates'
meta.description = 'Removes climbing gloves from all crates.'
meta.author = 'C_ffeeStain'
meta.version = '0.1'

function remove_gloves()
	crates = get_entities_by_type(ENT_TYPE.ITEM_CRATE)
	for i, v in ipairs(crates) do
		c = get_entity(v):as_container()
		if c.inside == ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES then
			new = math.random(0, 1)
			if new == 0 then
				c.inside = ENT_TYPE.ITEM_PICKUP_BOMBBAG
			else
				c.inside = ENT_TYPE.ITEM_PICKUP_ROPEPILE
			end
		end
	end
end

set_callback(remove_gloves, ON.FRAME)
