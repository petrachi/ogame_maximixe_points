class ProductionCostsCalculator::ByRessource::FusionEnergy < ProductionCostsCalculator::ByRessource
  def ressource
    :energy
  end

  def blueprint_name
    :fusion_plant
  end
end
