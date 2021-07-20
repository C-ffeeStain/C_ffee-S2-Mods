meta.name = 'Infinite Shopkeeper Robbing'
meta.description = 'This allows you to practice robbing shopkeepers without any consequences.'
meta.version = '0.1'
meta.author = 'C_ffeeStain'

register_option_bool('reset_shoppie_aggro', 'Reset shoppie aggro', true)
register_option_bool('move_player', 'Move the player to the shopkeeper', true)
register_option_bool('reset_stats', 'Reset on every level like an instant restart', true)

function reset()
	state.world_start = 1
	state.level_start = 2
	state.theme_start = THEME.DWELLING

	state.world_next = 1
	state.level_next = 2
	state.theme_next = THEME.DWELLING

	doors = get_entities_by_type(ENT_TYPE.FLOOR_DOOR_EXIT)
	for i, v in ipairs(doors) do
		set_door(v, 1, 2, THEME.DWELLING)
	end
end

set_callback(reset, ON.CAMP)
set_callback(function ()
	reset()
	id = set_interval(function ()
		if options.move_player then
			shoppies = get_entities_by_type(ENT_TYPE.MONS_SHOPKEEPER)
			if #shoppies == 0 then
				state.screen = ON.TRANSITION
				state.loading = 1
			end
			for i, v in ipairs(shoppies) do
				sk = shoppies[i]
				x, y, l = get_position(sk)
				if get_entity(sk):as_movable().holding_uid == -1 then move_entity(players[1].uid, x, y, 0, 0) end
			end
		end
		clear_callback(id)
	end, 5)
end, ON.LEVEL)
set_callback(function ()
	if options.reset_stats then
		state.quest_flags = setflag(state.quest_flags, 1)
	end
end, ON.LOADING)
set_callback(reset, ON.START)
