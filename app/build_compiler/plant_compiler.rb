class PlantCompiler < MineCompiler
  def ressource
    :energy
  end

  def type
    :plant
  end

  def blueprint_name
    raise NotImplementedError
  end

  def uid
    "#{ blueprint_name } #{ building.level }, #{ planet.buildings["deuterium_mine"].level }"
  end

  def compile_warnings! **_
    self.warnings << :enough_energy if planet.produces[:energy] > 0
  end
end
