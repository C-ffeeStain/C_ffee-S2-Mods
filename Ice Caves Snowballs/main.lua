meta.name = 'Ice Caves Snowballs'
meta.description = [[This mod turns all the rocks in the Ice Caves into the unused snowball texture.
This had to be done with Lua so the rocks in other areas don't look like snowballs.]]
meta.author = 'C_ffeeStain'
meta.version = '0.1'

set_callback(function ()
	if state.theme == THEME.ICE_CAVES then
		rocks = get_entities_by_type(ENT_TYPE.ITEM_ROCK)
		for i, v in ipairs(rocks) do
			rock = get_entity(v):as_movable()
			rock.animation_frame = 222
			rock.width = 0.75
			rock.height = 0.75
		end
	end
end, ON.FRAME)
