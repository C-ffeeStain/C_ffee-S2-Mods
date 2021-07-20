module = {}

module.monsters = {ENT_TYPE.MONS_SNAKE, ENT_TYPE.MONS_SPIDER, ENT_TYPE.MONS_LEPRECHAUN, ENT_TYPE.MONS_HANGSPIDER, ENT_TYPE.MONS_SCORPION, ENT_TYPE.MONS_REDSKELETON, ENT_TYPE.MONS_SKELETON, ENT_TYPE.MONS_BAT, ENT_TYPE.MONS_TIKIMAN, ENT_TYPE.MONS_WITCHDOCTOR, ENT_TYPE.MONS_MANTRAP, ENT_TYPE.MONS_MOSQUITO, ENT_TYPE.MONS_FROG, ENT_TYPE.MONS_FIREFROG, ENT_TYPE.MONS_GRUB, ENT_TYPE.MONS_HORNEDLIZARD, ENT_TYPE.MONS_MOLE, ENT_TYPE.MONS_MONKEY, ENT_TYPE.MONS_MAGMAMAN, ENT_TYPE.MONS_ROBOT, ENT_TYPE.MONS_FIREBUG_UNCHAINED, ENT_TYPE.MONS_VAMPIRE, ENT_TYPE.MONS_IMP, ENT_TYPE.MONS_CROCMAN, ENT_TYPE.MONS_COBRA, ENT_TYPE.MONS_NECROMANCER, ENT_TYPE.MONS_SORCERESS, ENT_TYPE.MONS_JIANGSHI, ENT_TYPE.MONS_FEMALE_JIANGSHI, ENT_TYPE.MONS_FISH, ENT_TYPE.MONS_OCTOPUS, ENT_TYPE.MONS_HERMITCRAN, ENT_TYPE.MONS_UFO, ENT_TYPE.MONS_ALIEN, ENT_TYPE.MONS_YETI, ENT_TYPE.MONS_OLMITE_NAKED, ENT_TYPE.MONS_OLMITE_BODYARMORED, ENT_TYPE.MONS_OLMITE_HELMET, ENT_TYPE.MONS_BEE}
module.items = {ENT_TYPE.ITEM_PICKUP_COMPASS, ENT_TYPE.ITEM_PICKUP_SPECTACLES, ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, ENT_TYPE.ITEM_PICKUP_BOMBBAG, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_CAPE, ENT_TYPE.ITEM_PICKUP_SPIKESHOES, ENT_TYPE.ITEM_PICKUP_SPRINGSHOES, ENT_TYPE.ITEM_PICKUP_KAPALA, ENT_TYPE.ITEM_JETPACK, ENT_TYPE.ITEM_PICKUP_ALIENCOMPASS, ENT_TYPE.ITEM_PICKUP_ROPE, ENT_TYPE.ITEM_PICKUP_ROPEPILE, ENT_TYPE.ITEM_PICKUP_ROYALJELLY, ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY, ENT_TYPE.ITEM_PICKUP_CLOVER, ENT_TYPE.ITEM_PICKUP_PITCHERSMITT, ENT_TYPE.ITEM_PICKUP_PASTE, ENT_TYPE.ITEM_PICKUP_UDJATEYE, ENT_TYPE.ITEM_PICKUP_PARACHUTE, ENT_TYPE.ITEM_PICKUP_SKELETONKEY, ENT_TYPE.ITEM_PICKUP_PLAYERBAG, ENT_TYPE.ITEM_JETPACK, ENT_TYPE.ITEM_TELEPORTER_BACKPACK, ENT_TYPE.ITEM_POWERPACK, ENT_TYPE.ITEM_HOVERPACK, ENT_TYPE.ITEM_PLASMACANNON}
module.sentences = {"The world does not care about me.", "The world cares about me.", "I hate myself.", "I have no friends.", "I want you dead.", "My friend Airyn loves you.", "I want to die.", "I can do this.", "I'm gonna give up.", "I'm NEVER GONNA GIVE YOU UP!"} 

local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

--v 0.1

--- increases shoppie aggro by 5
module["Shopkeepers Hate U"] = function(_)
    state.shoppie_aggro = 5
end

--- increases tun aggro by 3
module["Tun Hates U"] = function(_)
    state.merchant_aggro = 3
end

--- stuns the player for 5 seconds
module["I'm a.. little sleepy"] = function(uid)
    local p = get_entity(uid):as_player()
    p.stun_timer = 300
    p.velocityx = math.random()
    p.velocityy = 0.05
    if not entity_has_item_type(uid, ENT_TYPE.FX_BIRDIES) then spawn_entity_over(ENT_TYPE.FX_BIRDIES, uid, 0, 0.75) end
end

--- spawns a boulder above the player
module["Indiana Jones"] = function(uid)
    local x, y, l = get_position(uid)
    spawn(ENT_TYPE.LOGICAL_BOULDERSPAWNER, x, y, l, 0, 0)
end

--- all shops in the current level are 50% off
module["Discount"] = function(_)
    for i, v in ipairs(get_entities_by_mask(MASK.ITEM)) do
        local mov = get_entity(v):as_movable()
        if testflag(mov.flags, 23) then mov.price = math.floor(mov.price / 2) end
    end
end

--- spawns apep on the far left side of the screen
module["Here He Comes!"] = function(uid)
    local x, y, l = get_position(uid)
    spawn(ENT_TYPE.MONS_APEP_HEAD, -10, y, l, 0, 0)
end

--- spawns a fireball on the player
module["Burn, Baby, Burn!"] = function(uid)
    local x, y, l = get_position(uid)
    spawn(ENT_TYPE.ITEM_HUNDUN_FIREBALL, x - 1, y, l, 0, 0)
end

--- freezes the player
module["Brainfreeze"] = function(uid)
    spawn_entity_over(ENT_TYPE.ITEM_FREEZERAYSHOT, uid, 0, 0)
end

--- sets player's bombs and ropes to 0
module["No Resources"] = function(uid)
    local p = get_entity(uid):as_player()
    p.inventory.bombs = 0
    p.inventory.ropes = 0
end

--- shops are 2x as expensive on this level
module["Expensive Shops"] = function(_)
    for i, v in ipairs(get_entities_by_mask(MASK.ITEM)) do
        local mov = get_entity(v):as_movable()
        if testflag(mov.flags, 23) then mov.price = mov.price * 2 end
    end
end

--- spawns a clone shopkeeper
module["Shopkeeper Mayhem"] = function(_)
    local num = math.random(2, 4)
    local x, y = math.random(3, 10), math.random(1, 5)
    spawn(ENT_TYPE.MONS_SHOPKEEPERCLONE, x, y, LAYER.PLAYER1, 0, 0)
end

--- decreases bombs by 1-4
module["Bombs Down"] = function(uid)
    local p = get_entity(uid):as_player()
    local bombs = p.inventory.bombs - math.random(1, 4)
    if bombs < 0 then bombs = 0 end
    p.inventory.bombs = bombs
end

--- decreases ropes by 1-4
module["Ropes Down"] = function(uid)
    local p = get_entity(uid):as_player()
    local ropes = p.inventory.ropes - math.random(1, 4)
    if ropes < 0 then ropes = 0 end
    p.inventory.ropes = ropes
end

--- decreases health by 1-4 (but it won't kill you)
module["Health Down"] = function(uid)
    local p = get_entity(uid):as_player()
    local health = p.health - math.random(1, 4)
    if health < 1 then health = 1 end
    p.health = health
end

--- increases bombs by 1-8
module["Bombs Up"] = function(uid)
    local p = get_entity(uid):as_player()
    local bombs = p.inventory.bombs + math.random(1, 8)
    if bombs > 99 then p.inventory.bombs = 99 return end
    p.inventory.bombs = bombs
end

--- increases ropes by 1-8
module["Ropes Up"] = function(uid)
    local p = get_entity(uid):as_player()
    local ropes = p.inventory.ropes + math.random(1, 8)
    if ropes > 99 then ropes = 99 end
    p.inventory.ropes = ropes
end

--- increases health by 1-8
module["Health Up"] = function(uid)
    local p = get_entity(uid):as_player()
    local health = p.health + math.random(1, 8)
    if health > 99 then health = 99 end
    p.health = health
end

--- sets player's money to 0
module["Broke"] = function(uid)
    get_entity(uid):as_player().inventory.money = 0
end

--- all monsters are invisible for 15 seconds
module["Invisible Monsters"] = function(_)
    for i, v in ipairs(get_entities_by_mask(MASK.MONSTER)) do
        local mov = get_entity(v):as_movable()
        mov.flags = setflag(mov.flags, 1)
    end
    ID = set_timeout(function ()
        for i, v in ipairs(get_entities_by_mask(MASK.MONSTER)) do
            local mov = get_entity(v):as_movable()
            mov.flags = clrflag(mov.flags, 1)
        end
        clear_callback(ID)
    end, 900)
end

--- spawns the ghost
module["A Terrible Chill"] = function(uid)
    spawn(ENT_TYPE.ITEM_CURSEDPOT, 0, 1, 0, 0, 0)
end

--- zooms in for 15 seconds
module["Low Render Distance"] = function(uid)
    zoom(8.5)
    local p = get_entity(uid):as_player()
    ID = set_timeout(function ()
        zoom(13.5)
        clear_callback(ID)
    end, 900)
end

-- disabled
module["Intermission Time"] = function(uid)
    local text1 = "Intermission"
    local w, h = draw_text_size(60, text1)
    local secs = 30
    local player = get_entity(uid):as_player()
    ID1 = set_callback(function ()
        if get_frame() % 60 == 0 then secs = secs - 1 end
        if secs <= 0 then clear_callback(ID1) end
    end, ON.FRAME)
    ID = set_callback(function ()
        player.flags = setflag(player.flags, 28)
        local text = tostring(secs)
        local w_secs, h_secs = draw_text_size(40, text)
        draw_rect_filled(-1, -1, 1, 1, 0, rgba(0, 0, 0, 255))
        draw_text(0 - w / 2, 0 - h / 2, 60, "Intermission", 0xffffffff)
        draw_text(0 - w_secs / 2, 0 - h_secs / 2-0.2, 40, text, 0xffffffff)
        if secs <= 0 then 
            player.flags = clrflag(player.flags, 28)
            clear_callback(ID)
        end
    end, ON.GUIFRAME)
end

--v 0.2

--- poisons the player
module["Poison Player"] = function(uid)
    local x, y, l = get_position(uid)
    spawn_entity_over(ENT_TYPE.ITEM_ACIDSPIT, uid, 0, 0)
end

--- curses the player
module["Curse Player"] = function(uid)
    local x, y, l = get_position(uid)
    spawn_entity_over(ENT_TYPE.ITEM_CURSING_CLOUD, uid, 0, 0)
end

--- spawns 2-4 turkeys
module["Turkey Gang"] = function(uid)
    local x, y, l = get_position(uid)
    local amount = math.random(2, 4)
    local i = 0
    while i < amount do
        local offsetx, offsety = math.random(-4, 4), math.random(-4, 4)
        spawn(ENT_TYPE.MOUNT_TURKEY, x + offsetx, y + offsety, l, 0, 0)
        i = i + 1
    end
end

--- spawns 2-4 rockdogs
module["Rockdog Gang"] = function(uid)
    local x, y, l = get_position(uid)
    local amount = math.random(2, 4)
    local i = 0
    while i < amount do
        local offsetx, offsety = math.random(-4, 4), math.random(-4, 4)
        spawn(ENT_TYPE.MOUNT_ROCKDOG, x + offsetx, y + offsety, l, 0, 0)
        i = i + 1
    end
end

--- spawns 2-4 axolotls
module["Axolotl Gang"] = function(uid)
    local x, y, l = get_position(uid)
    local amount = math.random(2, 4)
    local i = 0
    while i < amount do
        local offsetx, offsety = math.random(-4, 4), math.random(-4, 4)
        spawn(ENT_TYPE.MOUNT_AXOLOTL, x + offsetx, y + offsety, l, 0, 0)
        i = i + 1
    end
end

--- untames all mounts in the current level
module["All Mounts Go Wild"] = function(_)
    local ents = get_entities_by_mask(MASK.MOUNT)
    for i, v in ipairs(ents) do
        get_entity(v):as_mount():tame(false)
    end
end

--- tames all mounts in the current level
module["Tame All Mounts"] = function(_)
    local ents = get_entities_by_mask(MASK.MOUNT)
    for i, v in ipairs(ents) do
        get_entity(v):as_mount():tame(true)
    end
end

--- spawns a (almost worthless) elixir
module["Freelixir"] = function(uid)
    local x, y, l = get_position(uid)
    spawn(ENT_TYPE.ITEM_PICKUP_ELIXIR, x, y, l, 0, 0)
end

--- spawns some leprechauns
module["Thieves"] = function(uid)
    local x, y, l = get_position(uid)
    local amount = math.random(2, 3)
    local i = 0
    while i < amount do
        local offsetx, offsety = math.random(-4, 4), math.random(-4, 4)
        spawn(ENT_TYPE.MONS_LEPRECHAUN, x + offsetx, y + offsety, l, 0, 0)
        i = i + 1
    end
end

--- decreases shoppie aggro by 1-4
module["Shopkeepers Love You"] = function(_)
    if state.shoppie_aggro <= 0 then return end
    local amount = state.shoppie_aggro - math.random(1, 4)
    if amount < 0 then amount = 0 end
    state.shoppie_aggro = amount
end

--- decreases tun aggro by 1-4
module["Tun Loves You"] = function(_)
    if state.merchant_aggro <= 0 then return end
    local amount = state.merchant_aggro - math.random(1, 4)
    if amount < 0 then amount = 0 end
    state.merchant_aggro = amount
end

--- resets all arrow traps
module["Rearm All Arrow Traps"] = function(_)
    for i, v in ipairs(get_entities_by_type(ENT_TYPE.FLOOR_POISONED_ARROW_TRAP, ENT_TYPE.FLOOR_ARROW_TRAP)) do
        get_entity(v):as_arrowtrap():rearm()
    end
end

--- teleports the player to the first exit
module["Teleport to Exit"] = function(uid)
    local exits = get_entities_by_type(ENT_TYPE.FLOOR_DOOR_EXIT)
    if #exits == 0 then error("no exits in the current level, what??") end
    local ex, ey, el = get_position(exits[1])
    move_entity(uid, ex, ey, 0, 0)
end

--- teleports the player to the first entrance of the level
module["Teleport to Entrance"] = function(uid)
    local entrances = get_entities_by_type(ENT_TYPE.FLOOR_DOOR_ENTRANCE)
    if #entrances == 0 then error("no exits in the current level, what??") end
    local ex, ey, el = get_position(entrances[1])
    move_entity(uid, ex, ey, 0, 0)
end

--- spawns a jetpack and a plasma cannon
module["Derek Loves You"] = function(uid)
    local p = get_entity(uid):as_player()
    local x, y, l = get_position(uid)
    spawn(ENT_TYPE.ITEM_PLASMACANNON, x + 1, y, l , 0, 0)
    spawn(ENT_TYPE.ITEM_JETPACK, x - 1, y, l , 0, 0)
end

-- TODO: fix this later
-- module["Random Explosion"] = function(uid)
--     local xmin, ymin, xmax, ymax = get_bounds()
--     local x, y, l = math.random(math.floor(xmin), math.floor(xmax)), math.random(math.floor(ymax), math.floor(ymin))
--     spawn(ENT_TYPE.FX_EXPLOSION, x, y, l, 0, 0)
-- end

--- makes the player drop the item he is holding 
module["Drop Currently Held Item"] = function(uid)
    get_entity(uid):as_movable().holding_uid = -1
end

--- shuffles your current stats, can be helpful or harmful!
module["Shuffle Stats"] = function(uid)
    local p = get_entity(uid):as_player()
    local stats = {p.type.sprint_factor, p.type.jump, p.type.max_speed, p.type.acceleration, p.type.elasticity, p.type.friction}
    stats = shuffle(stats)
    p.type.sprint_factor, p.type.jump, p.type.max_speed, p.type.acceleration, p.type.elasticity, p.type.friction = table.unpack(stats)
end

--v 0.3

--- spawns a random monster
module["Random Monster Spawn"] = function(uid)
    local px, py, pl = get_position(uid)
    spawn(module.monsters[math.random(1, #module.monsters)], px + math.random(-4, 4), py + math.random(-2, 2), pl, 0, 0)
end

--- spawns a random item
module["Random Item Spawn"] = function(uid)
    local px, py, pl = get_position(uid)
    spawn(module.items[math.random(1, #module.items)], px + math.random(-4, 4), py + math.random(-2, 2), pl, 0, 0)
end

--- teleports the player to a random spot in the current level
module["Random Teleport"] = function(uid)
    local xmin, ymin, xmax, ymax = get_bounds()
    ::getair::
    local x = math.random(math.floor(xmin), math.floor(xmax))
    local y = math.random(math.floor(ymax), math.floor(ymin))
    local px, py, l = get_position(uid)
    local wallcheck = get_entities_at(0, 0x180, x, y, l, 0.5)
    if #wallcheck ~= 0 then goto getair end
    spawn_entity(ENT_TYPE.FX_TELEPORTSHADOW, px, py, l, 0, 0)
    move_entity(uid, x, y, 0, 0)
    local px, py, l = get_position(uid)
    spawn_entity(ENT_TYPE.FX_TELEPORTSHADOW, px, py, l, 0, 0)
end

--- spawn a plasma cannon that you can't shoot
module["Spawn Throwable Plasma Cannon"] = function(uid)
    local px, py, pl = get_position(uid)
    local PC = get_entity(spawn(ENT_TYPE.ITEM_PLASMACANNON, px, py, pl, 0, 0)):as_movable()
    PC.flags = clrflag(PC.flags, 19)
end

--- kills all monsters in the current level
module["Kill All Monsters"] = function(_)
    for i, v in ipairs(get_entities_by_mask(MASK.MONSTER)) do
        kill_entity(v)
    end
end

--- bullets have random velocity for 15 seconds
module["Wild Bullets"] = function(_)
    local frames_past = 0 
    ID = set_timeout(function()
        if frames_past >= 900 then clear_callback(ID) end
        for i, v in ipairs(get_entities_by_type(ENT_TYPE.ITEM_BULLET)) do
            get_entity(v):as_movable().velocityx = math.random()
            get_entity(v):as_movable().velocityx = math.random()
        end
        frames_past = frames_past + 1
    end, 1)
end

--- blows up all of kali's altars in the current level
module["Kali Wants You Dead"] = function(_)
    for i, v in ipairs(get_entities_by(ENT_TYPE.FLOOR_ALTAR, 0, 0)) do
        local x, y, l = get_position(v)
        spawn_entity(ENT_TYPE.FX_EXPLOSION, x, y, l, 0, 0)
    end
end

--- bombs replace bullets for 15 seconds
module["Bomb Bullets"] = function(_)
    local frames_past = 0
    ID = set_timeout(function ()
        if frames_past >= 900 then clear_callback(ID) end
        for i, v in ipairs(get_entities_by_type(ENT_TYPE.ITEM_BULLET)) do
            local x, y, l = get_position(v)
            local mov = get_entity(v):as_movable()
            local bomb = get_entity(spawn(ENT_TYPE.ITEM_BOMB, x, y, l, mov.velocityx, mov.velocityy)):as_movable()
            bomb.owner_uid = mov.owner_uid
            bomb.last_owner_uid = mov.last_owner_uid
            kill_entity(v)
        end
        frames_past = frames_past + 1
    end, 1)
end

--- spawn a present
module["Happy Birthday!"] = function(uid)
    local x, y, l = get_position(uid)
    spawn(ENT_TYPE.ITEM_PRESENT, x, y, l, 0, 0)
end

--- increase player's sprint factor by 0.025
module["Sprint Up"] = function(uid)
    local mov = get_entity(uid):as_movable()
    mov.type.sprint_factor = mov.type.sprint_factor + 0.025
end

--- increase player's jump power by 0.0175
module["Jump Power Up"] = function(uid)
    local mov = get_entity(uid):as_movable()
    mov.type.jump = mov.type.jump + 0.0175
end

--- increase player's max speed by 0.01
module["Max Speed Up"] = function(uid)
    local mov = get_entity(uid):as_movable()
    mov.type.max_speed = mov.type.max_speed + 0.01
end

--- increase player's acceleration by 0.025
module["Acceleration Up"] = function(uid)
    local mov = get_entity(uid):as_movable()
    mov.type.acceleration = mov.type.acceleration + 0.025
end

--- decrease player's sprint factor by 0.025
module["Sprint Down"] = function(uid)
    local mov = get_entity(uid):as_movable()
    mov.type.sprint_factor = mov.type.sprint_factor - 0.025
end

--- decrease player's jump power by 0.175
module["Jump Power Down"] = function(uid)
    local mov = get_entity(uid):as_movable()
    mov.type.jump = mov.type.jump - 0.175
end

--- decrease player's max speed by 0.01
module["Max Speed Down"] = function(uid)
    local mov = get_entity(uid):as_movable()
    mov.type.max_speed = mov.type.max_speed - 0.01
end

--- decrease player's acceleration by 0.025
module["Acceleration Down"] = function(uid)
    local mov = get_entity(uid):as_movable()
    mov.type.acceleration = mov.type.acceleration - 0.025
end

--- kill all monsters in the level
module["Kill All Monsters"] = function(_)
    for i, v in ipairs(get_entities_by_mask(0x4)) do
        kill_entity(v)
    end
end

--- spawn a random number of bomb bags/rope piles, and then kill the player
module["Suicide King"] = function(uid)
    local pickup = {ENT_TYPE.ITEM_PICKUP_ROPEPILE, ENT_TYPE.ITEM_PICKUP_BOMBBAG}
    for _, v in ipairs({3, 3, 3, 3, 3, 3, 3, 3, 3, 3}) do
        local x, y, l = get_position(uid)
        spawn(pickup[math.random(1, 2)], x + math.random(-3, 3), y, l, 0, 0)
    end
    kill_entity(uid)
end

--- use a lot of money for bombs ($800 = 1 bomb)
module["Exchange Money for Bombs"] = function(uid)
    local p = get_entity(uid):as_player() 
    local money_to_exchange = math.floor(p.inventory.money / 800)
    p.inventory.bombs = p.inventory.bombs + money_to_exchange
    p.inventory.money = p.inventory.money - money_to_exchange * 800
end

--- use a lot of money for bombs ($800 = 1 bomb)
module["Exchange Money for Ropes"] = function(uid)
    local p = get_entity(uid):as_player() 
    local money_to_exchange = math.floor(p.inventory.money / 800)
    p.inventory.ropes = p.inventory.ropes + money_to_exchange
    p.inventory.money = p.inventory.money - money_to_exchange * 800
end

--- use a lot of money for health ($1000 = 1 heart)
module["Exchange Money for Health"] = function(uid)
    local p = get_entity(uid):as_player() 
    local money_to_exchange = math.floor(p.inventory.money / 1000)
    p.health = p.health + money_to_exchange
    p.inventory.money = p.inventory.money - money_to_exchange * 1000
end

--- use a lot of money for bombs ($800 = 1 bomb)
module["Exchange Money for Bombs"] = function(uid)
    local p = get_entity(uid):as_player() 
    local money_to_exchange = math.floor(p.inventory.money / 800)
    p.inventory.bombs = p.inventory.bombs + money_to_exchange
    p.inventory.money = p.inventory.money - money_to_exchange * 800
end

--- use a lot of money for bombs ($800 = 1 bomb)
module["Exchange Money for Ropes"] = function(uid)
    local p = get_entity(uid):as_player() 
    local money_to_exchange = math.floor(p.inventory.money / 800)
    p.inventory.ropes = p.inventory.ropes + money_to_exchange
    p.inventory.money = p.inventory.money - money_to_exchange * 800
end

--- use a lot of money for health ($1000 = 1 heart)
module["Exchange Money for Health"] = function(uid)
    local p = get_entity(uid):as_player() 
    local money_to_exchange = math.floor(p.inventory.money / 1000)
    p.health = p.health + money_to_exchange
    p.inventory.money = p.inventory.money - money_to_exchange * 1000
end

--v 0.4

--- sell all your bombs for money ($800 = 1 bomb)
module["Sell Bombs for Money"] = function(uid)
    local p = get_entity(uid):as_player()
    p.inventory.money = p.inventory.money + (p.inventory.bombs * 1000)
    p.inventory.bombs = 0
end

--- sell all your ropes for money ($800 = 1 rope)
module["Sell Ropes for Money"] = function(uid)
    local p = get_entity(uid):as_player()
    p.inventory.money = p.inventory.money + (p.inventory.ropes * 1000)
    p.inventory.ropes = 0
end

--- sell all your health but 1 for money (1 heart = $1000)
module["Sell Health for Money"] = function(uid)
    local p = get_entity(uid):as_player()
    p.inventory.money = p.inventory.money + ((p.health - 1) * 1000)
    p.health = 1
end

module["#onlineshopping"] = function(uid)
    local x, y, l = get_position(uid)
    local player = get_entity(uid):as_player()
    module.widgetopen = true
    set_callback(function()
        if module.widgetopen then
            module.widgetopen = window("Online Shop##OnlineShopWidget", 0, 0, 0, 0, true, function ()
                win_text("Resources")
                local bomb_bag_purchase = win_button("Buy Bomb Bag ($2500)")
                local rope_pile_purchase = win_button("Buy Rope Pile ($2500)")
                local cooked_turkey_purchase = win_button("Buy Cooked Turkey ($1000)")
                win_text("Collectible Items")
                local compass_purchase = win_button("Buy Compass ($5000)")
                local specs_purchase = win_button("Buy Spectacles ($3000)")
                local paste_purchase = win_button("Buy Paste ($5000)")
                local pitchers_mitt_purchase = win_button("Buy Pitcher's Mitt ($5000)")
                local spike_shoes_purchase = win_button("Buy Spike Shoes ($5000)")
                local spring_shoes_purchase = win_button("Buy Spring Shoes ($5000)")
                local skeleton_key_purchase = win_button("Buy Skeleton Key ($3000)")
                local parachute_purchase = win_button("Buy Parachute ($1000)")
                win_text("Guns")
                local shotgun_purchase = win_button("Buy Shotgun ($15000)")
                local freeze_ray_purchase = win_button("Buy Freeze Ray ($10000)")
                local webgun_purchase = win_button("Buy Webgun ($2000)")
                local plasma_cannon_purchase = win_button("Buy Plasma Cannon ($45000)")
                win_text("Other Held Items")
                local gift_purchase = win_button("Buy Present ($8000)")
                local machete_purchase = win_button("Buy Machete ($3000)")
                win_text("Backpacks")
                local jetpack_purchase = win_button("Buy Jetpack ($20000)")
                local hoverpack_purchase = win_button("Buy Hoverpack ($12000)")
                local powerpack_purchase = win_button("Buy Powerpack ($16000)")
                local telepack_purchase = win_button("Buy Telepack ($12000)")

                if bomb_bag_purchase and player.inventory.money >= 2500 then
                    spawn(ENT_TYPE.ITEM_PICKUP_BOMBBAG, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 2500
                elseif rope_pile_purchase and player.inventory.money >= 2500 then
                    spawn(ENT_TYPE.ITEM_PICKUP_ROPEPILE, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 2500
                elseif rope_pile_purchase and player.inventory.money >= 1000 then
                    spawn(ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 1000
                elseif compass_purchase and player.inventory.money >= 5000 then
                    spawn(ENT_TYPE.ITEM_PICKUP_COMPASS, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 5000
                elseif specs_purchase and player.inventory.money >= 3500 then
                    spawn(ENT_TYPE.ITEM_PICKUP_SPECTACLES, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 3000
                elseif specs_purchase and player.inventory.money >= 5000 then
                    spawn(ENT_TYPE.ITEM_PICKUP_PASTE, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 5000
                elseif spike_shoes_purchase and player.inventory.money >= 5000 then
                    spawn(ENT_TYPE.ITEM_PICKUP_SPIKESHOES, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 5000
                elseif spring_shoes_purchase and player.inventory.money >= 5000 then
                    spawn(ENT_TYPE.ITEM_PICKUP_SPRINGSHOES, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 5000
                elseif shotgun_purchase and player.inventory.money >= 15000 then
                    spawn(ENT_TYPE.ITEM_SHOTGUN, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 15000
                elseif webgun_purchase and player.inventory.money >= 2000 then
                    spawn(ENT_TYPE.ITEM_WEBGUN, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 2000
                elseif freeze_ray_purchase and player.inventory.money >= 10000 then
                    spawn(ENT_TYPE.ITEM_FREEZERAY, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 10000
                elseif skeleton_key_purchase and player.inventory.money >= 3000 then
                    spawn(ENT_TYPE.ITEM_PICKUP_SKELETONKEY, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 3000
                elseif jetpack_purchase and player.inventory.money >= 20000 then
                    spawn(ENT_TYPE.ITEM_JETPACK, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 20000
                elseif hoverpack_purchase and player.inventory.money >= 12000 then
                    spawn(ENT_TYPE.ITEM_HOVERPACK, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 12000
                elseif powerpack_purchase and player.inventory.money >= 16000 then
                    spawn(ENT_TYPE.ITEM_POWERPACK, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 16000
                elseif telepack_purchase and player.inventory.money >= 12000 then
                    spawn(ENT_TYPE.ITEM_TELEPORTER_BACKPACK, x, y, l, 0, 0)
                    player.inventory.money = player.inventory.money - 12000
                end
            end)    
        end
    end, ON.GUIFRAME)
end

module["Hrid Friend :)"] = function(uid)
    local x, y, l = get_position()
    spawn(ENT_TYPE.ITEM_COFFIN, x, y, l, 0, 0)
end

return module