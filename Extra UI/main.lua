kali_favor = {}
kali_favor.id, kali_favor.width, kali_favor.height = create_image("kali.png")

offsets = {
    present = {
        x1 = 0,
        x2 = 0.35, 
        y1 = 0, 
        y2 = 1
    }, 
    kapala = {
        x1 = 0.35,
        x2 = 0.65,
        y1 = 0,
        y2 = 1
    },
    royal_jelly = {
        x1 = 0.65,
        y1 = 0,
        x2 = 1,
        y2 = 1
    }
}

sizes = {
    present = { 
        x1 = 0.02,
        y1 = 0.22,
        x2 = 0.08,
        y2 = 0.12
    },
    kapala = {
        x1 = 0.02,
        y1 = 0.22,
        x2 = 0.075,
        y2 = 0.12
    },
    royal_jelly = {
        x1 = 0.02,
        y1 = 0.22,
        x2 = 0.075,
        y2 = 0.12
    }
}

set_callback(function ()
    if state.pause > 0 then return end
    statues = get_entities_by_type(ENT_TYPE.BG_KALI_STATUE)
    if #statues == 0 then return end
    statue = statues[1]
    if distance(players[1].uid, statue) <= 5 then
        x, y, l = get_position(players[1].uid)
        sx, sy = screen_position(x, y)
        text = 'Next Prize'
        w, h = draw_text_size(18, text)
        draw_text(sx - w/2, sy + 0.11 - h/2, 0, text, 0xffffffff)
        if state.kali_favor >= 16 then
            draw_image(kali_favor.id, sx - w/2 + sizes.royal_jelly.x1, (sy - h/2) + sizes.royal_jelly.y1, (sx - w / 2) + sizes.royal_jelly.x2, (sy - h / 2) + sizes.royal_jelly.y2, offsets.royal_jelly.x1, offsets.royal_jelly.y1, offsets.royal_jelly.x2, offsets.royal_jelly.y2, 0xffffffff)
        elseif state.kali_favor >= 8 then
            draw_image(kali_favor.id, sx - w/2 + sizes.kapala.x1, (sy - h/2) + sizes.kapala.y1, (sx - w / 2) + sizes.kapala.x2, (sy - h / 2) + sizes.kapala.y2, offsets.kapala.x1, offsets.kapala.y1, offsets.kapala.x2, offsets.kapala.y2, 0xffffffff)
        else
            draw_image(kali_favor.id, sx - w/2 + sizes.present.x1, (sy - h/2) + sizes.present.y1, (sx - w / 2) + sizes.present.x2, (sy - h / 2) + sizes.present.y2, offsets.present.x1, offsets.present.y1, offsets.present.x2, offsets.present.y2, 0xffffffff)
        end
    end
end, ON.GUIFRAME)