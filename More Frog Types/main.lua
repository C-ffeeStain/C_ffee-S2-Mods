meta.name = "More Frog Types"
meta.description = [[More frog types have been added in this mod.
There is currently just the Anubian frog, which shoots a normal Anubis shot upon death.]]
meta.version = "0.1"
meta.author = "C_ffeeStain"

local anubian_frog_texture = get_texture_definition(TEXTURE.DATA_TEXTURES_MONSTERS03_0)
anubian_frog_texture.texture_path = "anubian_frog.png"
local anubian_frog_texture_id = define_texture(anubian_frog_texture)

local all_anubian_frogs = {}

define_tile_code("anubian_frog")

set_pre_tile_code_callback(function(x, y, layer)
    local uid = spawn_entity(ENT_TYPE.MONS_FROG, x, y, layer, 0, 0)
    set_post_statemachine(uid, function (movable)
        movable:set_texture(anubian_frog_texture_id)
        all_anubian_frogs[#all_anubian_frogs+1] = {uid = movable.uid, x = x, y = y, layer = layer}
    end)
    
    return true
end, "anubian_frog")

set_callback(function()
    for i, v in ipairs(all_anubian_frogs) do
        if not get_entity(v.uid) then
            spawn(ENT_TYPE.ITEM_SCEPTER_ANUBISSHOT, all_anubian_frogs[i].x, all_anubian_frogs[i].y, all_anubian_frogs[i].layer, 0, 0)
            all_anubian_frogs[i] = nil
        else
            local frog_x, frog_y, frog_l = get_position(v.uid)
            all_anubian_frogs[i].x, all_anubian_frogs[i].y, all_anubian_frogs.layer = frog_x, frog_y, frog_l
        end
    end
end, ON.FRAME)