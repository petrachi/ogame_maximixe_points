class PlasmaTechCompiler < TechCompiler
  def ressource
    :plasma
  end

  def uid
    "#{ blueprint_name } #{ building.level }, #{ player.buildings.where_name(%i[metal_mine cristal_mine deuterium_mine]).pluck(:level) }"
  end

  def compile_produces
    player
      .produces(modifiers: {plasma_tech: 1})
      .merge(player.produces, &merge_proc(:-))
      .slice(:metal, :cristal, :deuterium)
      .values
      .inject(0, &:+)
  end
end
