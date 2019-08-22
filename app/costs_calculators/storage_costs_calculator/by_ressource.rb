class StorageCostsCalculator::ByRessource < BaseCostsCalculator::ByRessource
  Dir[Rails.root.join("app/costs_calculators/storage_costs_calculator/by_ressource/*.rb")].each { |f| require_dependency f }

  STORAGE_WANTED_TIME = 30

  def blueprint_name
    "#{ ressource }_storage"
  end

  def produces
    produces = planet.produces[ressource] * STORAGE_WANTED_TIME - buildings.stocks[ressource]
    produces = 0.0 if produces < 0
    produces
  end

  def costs
    buildings.costs modifiers: {level: 1}
  end
end
