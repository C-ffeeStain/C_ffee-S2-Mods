meta.name = "Push Block Bridge"
meta.description = "Makes a push block bridge across a gap."
meta.author = "C_ffeeStain"
meta.version = "WIP"

max = 8
movedir = 0.05
id = 0

set_callback(function ()
    if state.world == 1 and state.level == 4 then
        local x, y, l = get_position(players[1].uid)
        pb = get_entity(spawn(ENT_TYPE.ACTIVEFLOOR_PUSHBLOCK, x + 4, y - 1, l, 0, 0)):as_movable()
        pb.flags = setflag(pb.flags, 10)
        frames_past = 0
        id = set_callback(function ()
            frames_past = frames_past + 1
            pbx, pby, pbl = get_position(pb.uid)
            if pbx == x + max then
                movedir = -0.05
            elseif pbx == x + 4 then
                movedir = 0.05
            end
            move_entity(pb.uid, pbx + movedir, pby, 0, 0)
            frames_past = 0
        end, ON.FRAME)
    end
end, ON.LEVEL)

set_callback(function ()
    clear_callback(id)
end, ON.RESET)