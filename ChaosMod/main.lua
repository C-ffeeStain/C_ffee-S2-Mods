meta.name = "Chaotic Events"
meta.description = "A chaos mod similar to that of the GTA V Chaos Mod."
meta.version = "WIP"
meta.author = "C_ffeeStain"

local names = {"All Mounts Go Wild", "Shopkeeper Mayhem", "Discount", "Expensive Shops", "Low Render Distance", "Indiana Jones", "Brainfreeze", "Here He Comes!", "I'm a.. little sleepy", "No Resources", "Shopkeepers Hate U", "Tun Hates U", "Burn, Baby, Burn!", "Bombs Down", "Ropes Down", "Health Down", "Bombs Up", "Ropes Up", "Health Up", "Broke", "Invisible Monsters", "A Terrible Chill", "Freelixer", "Axolotl Gang", "Turkey Gang", "Rockdog Gang", "Thieves", "Tame All Mounts", "All Mounts Go Wild", "Shopkeepers Love You", "Tun Loves You", "Derek Loves You", "Curse Player", "Poison Player", "Shuffle Stats", "Drop Currently Held Item", "Teleport to Entrance", "Teleport to Exit", "Kali Wants You Dead", "Random Item Spawn", "Random Monster Spawn", "Random Teleport", "Wild Bullets", "Kill All Monsters", "Spawn Throwable Plasma Cannon", "Hey!", "Happy Birthday!", "Max Speed Up", "Jump Power Up", "Acceleration Up", "Sprint Up", "Sprint Down", "Acceleration Down", "Jump Power Down", "Max Speed Down", "Suicide King", "Exchange Money for Bombs", "Exchange Money for Ropes", "Exchange Money for Health"}

register_option_int("cooldown", "Cooldown (in seconds) between events", 30, 1, 300)
register_option_bool("countdown", "Show countdown to the next event?", true)
register_option_bool("toast_event", "Show the events like a level feeling?", false)

local events = require "events"

local game = {}
game.secs_left = options.cooldown
game.last_event = "Test Event"
game.last_event_big = false

set_callback(function ()
    if game.secs_left == 0 then
        local name = names[math.random(1, #names)]
        game.last_event = name
        game.last_event_big = true
        ID = set_timeout(function ()
            game.last_event_big = false
            clear_callback(ID)
        end, 180)
        local func = events[name]
        if options.toast_event then
            toast(name)
        end
        if func then func(players[1].uid) end
        game.secs_left = options.cooldown
    end
end, ON.FRAME)

set_callback(function ()
    if get_frame() % 60 == 0 then game.secs_left = game.secs_left - 1 end
end, ON.FRAME)

set_callback(function ()
    local text_size = 18
    local offset = 0.95
    for i, v in ipairs(players) do if v.state == 22 then return end end
    if game.last_event_big then 
        text_size = 40
        offset = 0.87
    end
    local w, h = draw_text_size(text_size, game.last_event)
    draw_text(0 - w / 2, -1 * offset, text_size, tostring(game.last_event), 0xffffffff)
    if options.countdown then
        w, h = draw_text_size(30, tostring(game.secs_left))
        draw_text(0 - w / 2, 1, 30, tostring(game.secs_left), 0xffffffff)
    end
end, ON.GUIFRAME)

set_callback(function ()
    game.frames_past = 0
    game.secs_left = options.cooldown
end, ON.LOADING)
set_callback(function ()
    game.frames_past = options.cooldown
end, ON.RESET)

set_callback(function ()
    for i, v in ipairs(players) do
        v.type.max_speed = 0.075
        v.type.acceleration = 0.032
        v.type.sprint_factor = 2
        v.type.jump = 0.18
    end
end, ON.START)

set_callback(function ()
    for i, v in ipairs(players) do
        v.type.max_speed = 0.075
        v.type.acceleration = 0.032
        v.type.sprint_factor = 2
        v.type.jump = 0.18
    end
end, ON.RESET)