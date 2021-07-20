meta.name = 'Arena Cheats'
meta.description = 'Cheats for arena.'
meta.version = '0.1'
meta.author = 'C_ffeeStain'

player = 1
health = math.random(1, 99)
bombs = math.random(0, 99)
ropes = math.random(0, 99)

open = true
kill_all = false
player_opts = {'All', 'All but you', 'Player 1', 'Player 2', 'Player 3', 'Player 4'}

register_option_button('open', 'Open Arena Cheats window', function ()
    open = true
end)

function show()
    if open == true then
        window('Arena Cheats##Cheats', 0, 0, 0, 0, true, function ()
            player = win_combo('Player(s)', player, table.concat(player_opts, '\0') .. '\0\0') 
            win_separator()
            kill = win_button('Kill')
            freeze = win_button('Freeze')
            health = win_slider_int('Health', health, 1, 99)
            win_inline()
            set_health = win_button('Set health')
            bombs = win_slider_int('Bombs', bombs, 0, 99)
            win_inline()
            set_bombs = win_button('Set bombs')
            ropes = win_slider_int('Ropes', ropes, 0, 99)
            win_inline()
            set_ropes = win_button('Set ropes')
            close = win_button('Close')

            if close then
                open = false
            end
            
            if kill == true then
                if player == 1 then
                    for i, v in ipairs(players) do
                        kill_entity(v.uid)
                    end
                elseif player == 2 then
                    for i, v in ipairs(players) do
                        if i ~= 1 then
                            kill_entity(v.uid)
                        end
                    end
                elseif player == 3 and players[1] ~= nil then kill_entity(players[1].uid)
                elseif player == 4 and players[2] ~= nil then kill_entity(players[2].uid)
                elseif player == 5 and players[3] ~= nil then kill_entity(players[3].uid)
                elseif player == 6 and players[4] ~= nil then kill_entity(players[4].uid)
                end
            end
            if freeze == true then
                if player == 1 then
                    for i, v in ipairs(players) do
                        x, y, l = get_position(v.uid)
                        spawn(ENT_TYPE.ITEM_FREEZERAYSHOT, x, y, l, 0, 0)
                    end
                elseif player == 2 then
                    for i, v in ipairs(players) do
                        if i ~= 1 then
                            x, y, l = get_position(v.uid)
                            spawn(ENT_TYPE.ITEM_FREEZERAYSHOT, x, y, l, 0, 0)
                        end
                    end
                elseif player == 3 then
                    if players[1] ~= nil then
                        x, y, l = get_position(players[1].uid)
                        spawn(ENT_TYPE.ITEM_FREEZERAYSHOT, x, y, l, 0, 0)
                    end
                elseif player == 4 then
                    if players[2] ~= nil then
                        x, y, l = get_position(players[2].uid)
                        spawn(ENT_TYPE.ITEM_FREEZERAYSHOT, x, y, l, 0, 0)
                    end
                elseif player == 5 then
                    if players[3] ~= nil then
                        x, y, l = get_position(players[3].uid)
                        spawn(ENT_TYPE.ITEM_FREEZERAYSHOT, x, y, l, 0, 0)
                    end
                elseif player == 6 then
                    if players[4] ~= nil then
                        x, y, l = get_position(players[4].uid)
                        spawn(ENT_TYPE.ITEM_FREEZERAYSHOT, x, y, l, 0, 0)
                    end
                end
            end
            if set_health == true then
                if player == 1 then
                    for i, v in ipairs(players) do v.health = health end
                elseif player == 2 then
                    for i, v in ipairs(players) do
                        if i ~= 1 then v.health = health end
                    end
                elseif player == 3 and players[1] ~= nil then players[1].health = health 
                elseif player == 4 and players[2] ~= nil then players[2].health = health 
                elseif player == 5 and players[3] ~= nil then players[3].health = health 
                elseif player == 6 and players[4] ~= nil then players[4].health = health end
            end
            if set_ropes == true then
                if player == 1 then
                    for i, v in ipairs(players) do v.inventory.ropes = ropes end
                elseif player == 2 then
                    for i, v in ipairs(players) do
                        if i ~= 1 then v.inventory.ropes = ropes end
                    end
                elseif player == 3 and players[1] ~= nil then players[1].inventory.ropes = ropes 
                elseif player == 4 and players[2] ~= nil then players[2].inventory.ropes = ropes 
                elseif player == 5 and players[3] ~= nil then players[3].inventory.ropes = ropes 
                elseif player == 6 and players[4] ~= nil then players[4].inventory.ropes = ropes end
            end
            if set_bombs == true then
                if player == 1 then
                    for i, v in ipairs(players) do v.inventory.bombs = bombs end
                elseif player == 2 then
                    for i, v in ipairs(players) do
                        if i ~= 1 then v.inventory.bombs = bombs end
                    end
                elseif player == 3 and players[1] ~= nil then players[1].inventory.bombs = bombs 
                elseif player == 4 and players[2] ~= nil then players[2].inventory.bombs = bombs 
                elseif player == 5 and players[3] ~= nil then players[3].inventory.bombs = bombs 
                elseif player == 6 and players[4] ~= nil then players[4].inventory.bombs = bombs end
            end
        end)
    end
end
set_callback(show, ON.GUIFRAME)