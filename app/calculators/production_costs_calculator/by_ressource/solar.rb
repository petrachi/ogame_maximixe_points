class ProductionCostsCalculator::ByRessource::Solar < ProductionCostsCalculator::ByRessource
  def ressource
    :energy
  end

  def blueprint_name
    :solar_plant
  end
end
