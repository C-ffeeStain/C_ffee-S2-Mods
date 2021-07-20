meta.name = "Fix TNT Texture - CoG and Duat"
meta.description = "Changes TNT to the proper texture in the City of Gold and Duat."
meta.version = "0.2"
meta.author = "C_ffeeStain"

set_callback(function ()
  if state.theme == THEME.DUAT or state.theme == THEME.CITY_OF_GOLD then
    pushblocks = get_entities_by_type(ENT_TYPE.ACTIVEFLOOR_POWDERKEG)
    for _, v in ipairs(pushblocks) do
      e = get_entity(v)
	  e:set_texture(TEXTURE.DATA_TEXTURES_FLOORMISC_0)
	  e.animation_frame = 0x12
    end
  end
end, ON.GAMEFRAME)
