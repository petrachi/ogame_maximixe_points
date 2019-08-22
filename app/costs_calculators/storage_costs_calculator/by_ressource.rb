class StorageCostsCalculator::ByRessource < BaseCostsCalculator::ByRessource
  STORAGE_WANTED_TIME = 30

  def blueprint_name
    "#{ ressource }_storage"
  end

  def produces
    produces = planet.produces[ressource] * STORAGE_WANTED_TIME - buildings.stocks[ressource]
    produces = 0.0 if produces < 0
    produces
  end
end
