class MilitaryTechCompiler < TechCompiler
  def uid_buildings
    /^.*_artillery$/
  end

  def compile_produces
    player.cumulative_sustains(modifiers: {military_tech: 1})[:hull] - player.cumulative_sustains[:hull]
  end
end
