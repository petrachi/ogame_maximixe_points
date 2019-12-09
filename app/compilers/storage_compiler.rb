class StorageCompiler < PlanetCompiler
  STORAGE_WANTED_TIME = 24

  def type
    :storage
  end

  def ressource
    :cristal
  end

  def blueprint_name
    "#{ ressource }_storage"
  end

  def uid_buildings
    "#{ ressource }_mine"
  end

  def compile_produces
    produces = (
      planet.produces[ressource] *
      STORAGE_WANTED_TIME -
      building.stocks[ressource]
    ) / STORAGE_WANTED_TIME.to_f
    produces = 0.0 if produces < 0
    produces
  end

  def compile_costs
    building.costs modifiers: {level: 1}
  end

  def compile_warnings! **_
    self.warnings << :enough_storage if produces.zero?
  end
end
