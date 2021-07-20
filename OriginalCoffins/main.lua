meta.name = 'Original Coffins'
meta.description = 'Sets all coffins to their original character.'
meta.version = '0.1'
meta.author = 'C_ffeeStain'

function is_wlt(w, l, t)
  if state.world == w and state.level == l and state.theme = t then return true else return false end
end

function value_in(value, options)
  for i, v in ipairs(options) do
    if value == v then
      return true
  end
  return false
end

set_callback(function ()
  if is_wlt(4, 2, THEME.TEMPLE) then
    coffins = get_entities_by_type(ENT_TYPE.ITEM_COFFIN)
    for i, v in ipairs(coffins) do
      set_contents(v, ENT_TYPE.CHAR_VALERIE_CRUMP)
    end
  elseif is_wlt(4, 2, THEME.TIDE_POOL) then
    coffins = get_entities_by_type(ENT_TYPE.ITEM_COFFIN)
    for i, v in ipairs(coffins) do
      set_contents(v, ENT_TYPE.CHAR_OTAKU)
    end
  elseif is_wlt(4, 2, THEME.TIDE_POOL) then
    coffins = get_entities_by_type(ENT_TYPE.ITEM_COFFIN)
    for i, v in ipairs(coffins) do
      set_contents(v, ENT_TYPE.CHAR_OTAKU)
  elseif is_wlt(1, 4, THEME.DWELLING) then
    coffins = get_entities_by_type(ENT_TYPE.ITEM_COFFIN)
    for i, v in ipairs(coffins) do
      set_contents(v, ENT_TYPE.CHAR_BANDA)
    end
  elseif state.world == 2 and #get_entities_by_type(ENT_TYPE.LOGICAL_BLACKMARKET_DOOR) > 0 then
    coffins = get_entities_by_type(ENT_TYPE.ITEM_COFFIN)
    for i, v in ipairs(coffins) do
      set_contents(v, ENT_TYPE.CHAR_AMAZON)
    end
end, ON.LEVEL)