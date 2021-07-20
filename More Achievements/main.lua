meta.name = "More Achievements"
meta.description = "More achievements for Spelunky 2 using a custom system."
meta.version = "0.1"
meta.author = "C_ffeeStain"

local function get_all_keys(tab)
    local keyset={}
    local n=0

    for k,v in pairs(tab) do
    n=n+1
    keyset[n]=k
    end
    return keyset
end

local achievements = {}
achievements["Cavepala"] = false
achievements["Triple Crown"] = false
achievements["Qilin to Sunken City"] = false
achievements["Golden Key to Tiamat"] = false
achievements["Volcana Junk to Tiamat"] = false
achievements["Eggplant to Tiamat"] = false

local show_achievement_gui = false

local achievement_descriptions = {}
achievement_descriptions["Cavepala"] = "Get the Kapala from sacrificing an alive caveman to Kali."
achievement_descriptions["Triple Crown"] = "Have the King's Crown, Eggplant Crown, and True Crown all at the same time."
achievement_descriptions["Qilin to Sunken City"] = "Bring Qilin to Sunken City."
achievement_descriptions["Golden Key to Tiamat"] = "Get the golden key from Dwelling to Tiamat's Throne."
achievement_descriptions["Volcana Junk to Tiamat"] = "Get a piece of Scrap from the \"metal clanking\" Volcana level to Tiamat's Throne."
achievement_descriptions["Eggplant to Tiamat"] = "Get an Eggplant to Tiamat's Throne."

local achievement_functions = require("achievement_funcs")

set_callback(function ()
    for i, func in pairs(achievement_functions) do
        if achievements[i] == false then
            local result = func()
            if result then
                message("unlocked " .. i)
                achievements[i] = true
                show_achievement_gui = true
                state.pause = 1
                ID = set_interval(function ()
                    show_achievement_gui = false
                    state.pause = 0
                    clear_callback(ID)
                end, 3)
            end
        end
    end
end, ON.FRAME)

set_callback(function(save_ctx)
    local save_data_str = json.encode(achievements)
    save_ctx:save(save_data_str)
end, ON.SAVE)

set_callback(function(load_ctx)
    local load_data_str = load_ctx:load()
    if load_data_str ~= "" then
        achievements = json.decode(load_data_str)
    end
end, ON.LOAD)

set_callback(function(draw_ctx)
    draw_ctx:draw_rect(0, 0, state.width, state.height, {r=0, g=0, b=0, a=255})
end, ON.GUIFRAME)