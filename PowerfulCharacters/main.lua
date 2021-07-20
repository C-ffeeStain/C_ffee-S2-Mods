meta.name = 'Powerful Characters'
meta.description = 'Now every character in S2 has their own unique \npower!'
meta.version = '0.2'
meta.author = 'C_ffeeStain'

initfuncs = require 'initfuncs'
levelfuncs = require 'levelfuncs'
transfuncs = require 'transfuncs'
framefuncs = require 'framefuncs'

function is_wlt(w, l, t)
    if state.world == w and state.level == l and state.theme == t then return true else return false end
end

set_callback(function()
    for i, v in ipairs(players) do
        func = transfuncs[v.type.id]
        if func then func(v.uid) end
    end
end, ON.TRANSITION)

set_callback(function ()
    -- if state.theme == THEME.BASECAMP then return end
    -- if state.level_count > 0 then return end
    for i, v in ipairs(players) do
        func = initfuncs[v.type.id]
        if func then func(v.uid) end
    end
end, ON.START)

set_callback(function ()
    if state.level_count == 0 then return end
    for i, v in ipairs(players) do
        func = levelfuncs[v.type.id]
        if func then func(v.uid) end
    end
end, ON.LEVEL)

set_callback(function()
    for i, v in ipairs(players) do
        func = framefuncs[v.type.id]
        if func then func(v.uid) end
    end
end, ON.FRAME)
