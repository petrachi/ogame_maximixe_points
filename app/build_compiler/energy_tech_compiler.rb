class EnergyTechCompiler < TechCompiler
  def ressource
    :energy
  end

  def uid
    "#{ blueprint_name } #{ building.level }, #{ player.buildings.where_name(:fusion_plant).pluck(:level) }"
  end

  def compile_produces
    player.produces(modifiers: {energy_tech: 1})[:energy] - player.produces[:energy]
  end
end
