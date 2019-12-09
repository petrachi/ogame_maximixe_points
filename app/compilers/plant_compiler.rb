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

  def compile_warnings! **_
    self.warnings << :enough_energy if planet.produces[:energy] > 0
  end
end
