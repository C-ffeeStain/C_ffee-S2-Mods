meta.name = 'Money per Kill'
meta.description = 'Gives you money at the end of the level for the amount of kills you got.'
meta.version = '0.1'
meta.author = 'C_ffeeStain'

--[[
  v0.4:
    added: gui size and hide UI options - note: gui size is not for my custom gui, it's the option labeled HUD Size in Options -> HUD and Text.
    added: changelog in file
    changed: kills ui shows throughout the level and transition, not just transition
    changed: UI shows kills as well as money you will get from them (in my opinion) 
  v0.5:
    added: growth to MPK (money per kill); it increases per world.
    changed: no longer show kills in basecamp
]]--


big = {x1 = -0.165, x2 = 0.025}
medium = {x1 = 0, x2 = 0.19}
small = {x1 = 0.11,x2 = 0.3}

register_option_int('start_mpk', 'The initial money you get per kill.', 250, 5, 1000000)
register_option_bool('mpk_grows', 'Does the money you get per kill grow?', true)
register_option_float('growth_rate', 'How fast the money per kill grows after each world.', 1.25, 1, 100)
--register_option_combo('level_or_world', 'Money per kill increases on world OR level?', 'World\0Level\0\0')
register_option_combo('gui_size', 'Size of the GUI', 'Small\0Medium\0Big\0\0')
register_option_bool('hide_on_pause', 'Hide the custom UI when the game is paused.', true)
register_option_bool('hide_on_transition', 'Hide the custom UI on the transition screen.', true)


start_mpk = options.start_mpk
kills = state.kills_level
money = 0

function reset()
	start_mpk = options.start_mpk
end
function decide_pos()
  if options.gui_size == 1 then
    return {small.x1, small.x2}
  elseif options.gui_size == 2 then
    return {medium.x1, medium.x2}
  else 
    return {big.x1, big.x2}
  end
end
set_callback(function ()
	if state.world_next > state.world and options.mpk_grows then
		start_mpk = math.floor(start_mpk * options.growth_rate)
  end
	k = players[1].inventory.kills_level
	m = k * start_mpk
	money = math.floor(m)
	if money > 0 then
		players[1].inventory.money = players[1].inventory.money + money
	end
end, ON.TRANSITION)

function show()
  for i, v in ipairs(players) do
    if v.state == 22 or (state.screen == ON.TRANSITION and options.hide_on_transition == true) then
      return false
    end
    if testflag(state.level_flags, 22) then
      return false
    end
  end
  return true
end

set_callback(function ()
  if state.world_next > state.world and options.mpk_grows then
		draw_rect_filled(-0.145, -0.91, 0.12, -0.98, 16, 0x77000000)
    draw_text(-0.13, -0.92, 0, 'MPK increased by ' .. options.growth_rate .. '%!', rgba(0, 250, 0, 255))
  end
  x1, x2 = 0, 0.19
  for i, v in ipairs(decide_pos()) do
    if i == 1 then
      x1 = v
    elseif i == 2 then
      x2 = v
    end
  end
	if options.hide_on_pause then
		if state.pause <= 0 then
      if show() and #players > 0 then
        money = math.floor(players[1].inventory.kills_level * start_mpk)
        draw_rect_filled(x1, 0.89, x2, 0.83, 16, 0x77000000)
        draw_text(x1 + 0.02, 0.887,
          0, 
          'Kills: $' .. tostring(money) .. ' (' .. players[1].inventory.kills_level .. ')',
          0xffffffff)
      end
		end
	else
    if show() then
	  	money = math.floor(players[1].inventory.kills_level * start_mpk)
	  	draw_rect_filled(x1, 0.89, x2, 0.83, 16, 0x77000000)
		  draw_text(x1 + 0.02, 0.887, 0, 'Kills: $' .. tostring(money) .. ' (' .. players[1].inventory.kills_level .. ')', 0xffffffff)
    end
  end
end, ON.GUIFRAME)

set_callback(reset, ON.START)
set_callback(reset, ON.RESET)
