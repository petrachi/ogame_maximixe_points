class ProductionCostsCalculator::ByRessource::SolarEnergy < ProductionCostsCalculator::ByRessource
  def ressource
    :energy
  end

  def blueprint_name
    :solar_plant
  end
end
