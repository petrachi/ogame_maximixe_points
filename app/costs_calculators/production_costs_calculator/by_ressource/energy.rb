class ProductionCostsCalculator::ByRessource::Energy < ProductionCostsCalculator::ByRessource
  def blueprint_name
    [:solar_plant, :fusion_plant]
  end
end
