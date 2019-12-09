class PlasmaTechCompiler < TechCompiler
  def ressource
    :plasma
  end

  def uid_buildings
    /^.*_mine$/
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
