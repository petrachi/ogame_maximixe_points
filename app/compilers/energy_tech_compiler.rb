class EnergyTechCompiler < TechCompiler
  def ressource
    :energy
  end

  def uid_buildings
    :fusion_plant
  end

  def compile_produces
    player.produces(modifiers: {energy_tech: 1})[:energy] - player.produces[:energy]
  end
end
