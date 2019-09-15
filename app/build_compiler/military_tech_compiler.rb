class MilitaryTechCompiler < TechCompiler
  def uid
    "#{ blueprint_name } #{ building.level }, #{ player.buildings.where_name(/^.*_artillery$/).pluck(:level) }"
  end

  def compile_produces
    player.cumulative_sustains(modifiers: {military_tech: 1})[:hull] - player.cumulative_sustains[:hull]
  end
end
