meta.name = "Sell Items"
meta.description = "You can now sell items to shops!"
meta.version = "WIP"
meta.author = "C_ffeeStain"

function get_keys(table)
    local keyset = {}
    local n = 0

    for k,v in pairs(table) do
        n = n + 1
        keyset[n] = k
    end
    return keyset
end

local sellable_items_and_prices = {}
local sellable_items = {}

local function get_price_floor(original_price, multiplier)
    return math.floor(0.8 * (original_price + (multiplier * state.level_count)))
end

set_callback(function ()
    sellable_items_and_prices[ENT_TYPE.ITEM_SHOTGUN] = get_price_floor(13500, 1500)
    sellable_items_and_prices[ENT_TYPE.ITEM_WEBGUN] = get_price_floor(1800, 200)
    sellable_items_and_prices[ENT_TYPE.ITEM_FREEZERAY] = get_price_floor(9000, 1000)
    sellable_items_and_prices[ENT_TYPE.ITEM_CROSSBOW] = get_price_floor(7200, 800)
    sellable_items_and_prices[ENT_TYPE.ITEM_CAMERA] = get_price_floor(4500, 500)
    sellable_items_and_prices[ENT_TYPE.ITEM_TELEPORTER] = get_price_floor(9000, 1000)
    sellable_items_and_prices[ENT_TYPE.ITEM_MACHETE] = get_price_floor(2700, 300)
    sellable_items_and_prices[ENT_TYPE.ITEM_BOOMERANG] = get_price_floor(2700, 300)
    sellable_items_and_prices[ENT_TYPE.ITEM_MATTOCK] = get_price_floor(6300, 700)
    sellable_items_and_prices[ENT_TYPE.ITEM_METAL_SHIELD] = get_price_floor(10800, 1200)
    sellable_items_and_prices[ENT_TYPE.ITEM_CAPE] = get_price_floor(10800, 1200)
    sellable_items_and_prices[ENT_TYPE.ITEM_TELEPORTER_BACKPACK] = get_price_floor(10800, 1200)
    sellable_items_and_prices[ENT_TYPE.ITEM_HOVERPACK] = get_price_floor(10800, 1200)
    sellable_items_and_prices[ENT_TYPE.ITEM_JETPACK] = get_price_floor(18000, 2000)
    sellable_items_and_prices[ENT_TYPE.ITEM_POWERPACK] = get_price_floor(14400, 600)
    sellable_items = get_keys(sellable_items_and_prices)
end, ON.LEVEL)

set_callback(function (draw_ctx)
    if state.shoppie_aggro > 0 then return end
    for _, v in ipairs(get_entities_by_mask(MASK.ITEM)) do
        local ent = get_entity(v)
        local valid_item = false
        for i, v in ipairs(sellable_items) do
            if ent.type.id == v then
                valid_item = true
                break
            end
        end
        if not valid_item then goto entity_get end
        
        if ent.standing_on_uid == -1 then goto entity_get end
        if testflag(ent.flags, ENT_FLAG.SHOP_ITEM) then goto entity_get end
        if not testflag(get_entity(ent.standing_on_uid).flags, ENT_FLAG.SHOP_FLOOR) then goto entity_get end
        local price = sellable_items_and_prices[ent.type.id]
        local sx, sy = screen_position(ent.x, ent.y)
        draw_ctx:draw_text(sx, sy + 0.05, 20, F"${price}", 0xFFFFFFFF)
        print("Entity: " .. tostring(ent.uid))
        if players[1].button_down(BUTTON.DOOR) then
            move_entity(ent, 0, 0, 0, 0)
            players[1].inventory.money = players[1].inventory.money + price
        end
        ::entity_get::
    end
end, ON.GUIFRAME)