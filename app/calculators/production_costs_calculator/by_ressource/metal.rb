class ProductionCostsCalculator::ByRessource::Metal < ProductionCostsCalculator::ByRessource
  def ressource
    :metal
  end

  def blueprint_name
    :metal_mine
  end
end
