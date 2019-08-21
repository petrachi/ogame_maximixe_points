class ProductionCostsCalculator::ByRessource::Fusion < ProductionCostsCalculator::ByRessource
  def ressource
    :energy
  end

  def blueprint_name
    :fusion_plant
  end
end
