class ProductionCostsCalculator::ByRessource::Energy < ProductionCostsCalculator::ByRessource
  def blueprint_name
    [:solar_plant, :fusion_plant]
  end

  def compute_complete_costs_and_production
    self.costs = base_costs
    self.produces = 0
  end
end
