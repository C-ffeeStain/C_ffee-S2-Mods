meta.name = 'Shoppie Ghosts'
meta.version = 'WIP'
meta.description = 'Spawns shopkeeper ghosts if you have too much shoppie aggro.'
meta.author = 'C_ffeeStain'

sks = {}
shotguns = {}
register_option_int('level', 'Least amount of aggro needed to summon shoppie ghosts', 5, 0, 9999)
register_option_int('time', 'Time (in seconds) before shoppie ghosts can spawn in the level.', 30, 1, 240)
set_callback(function ()
x, y, l = get_position(get_entities_by_type(ENT_TYPE.FLOOR_DOOR_ENTRANCE)[1])

if state.shoppie_aggro >= options.level then
toast('The spirits of the shopkeepers you hurt are angry!')
id = set_timeout(function ()
    spawn(ENT_TYPE.FX_TELEPORTSHADOW, x, y, l, 0, 0)
    sks[1] = get_entity(spawn(ENT_TYPE.MONS_SHOPKEEPERCLONE, x, y, l, 0, 0)):as_movable()
    id1 = set_timeout(function ()
      shotguns[1] = get_entity(sks[#sks].holding_uid):as_movable()
      shotguns[1].color.a = 0.5
      sks[1].color.a = 0.5
      clear_callback(id1)
  end, 1)
  clear_callback(id)
end, 60 * options.time)
end
end, ON.LEVEL)

set_callback(function ()
  if shotguns[1] and sks[1].holding_uid == -1 then
    kill_entity(shotguns[1].uid)
    shotguns = {}
  end
  if sks[1] and sks[1].health == 0 then
    kill_entity(sks[1].uid)
    sks = {}
  end
end, ON.FRAME)
