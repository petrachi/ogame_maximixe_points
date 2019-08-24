class ProductionCostsCalculator::ByRessource::Fusion < ProductionCostsCalculator::ByRessource
  def ressource
    :energy
  end

  def blueprint_name
    :fusion_plant
  end

  def compute_complete_costs_and_production
    if planet.produces[:deuterium] < -base_produces[:deuterium]
      self.costs = base_costs
      self.produces = 0
    else
      super
    end
  end

  # def compute_complete_costs_and_production
  #   if planet.produces[:energy] > 0
  #     self.costs = base_costs
  #     self.produces = 0
  #   else
  #     super
  #     self.produces = 1000000
  #
  #     # increase_energy = self.base_produces[:energy]
  #     # prod = planet.buildings.where_name(['solar_plant', 'fusion_plant']).produces[:energy]
  #     # total = planet.produces[:energy]
  #     # conso = prod - total
  #     #
  #     # actual_prod = planet.produces.each_with_object({}) do |(ressource, quantity), acc|
  #     #   acc[ressource] = quantity * (conso/prod)
  #     # end
  #     # future_prod = planet.produces.each_with_object({}) do |(ressource, quantity), acc|
  #     #   acc[ressource] = quantity * ((conso + increase_energy)/prod)
  #     # end
  #     # prod_increase = future_prod.merge(actual_prod, &merge_proc(:-))
  #     #
  #     # self.produces = prod_increase.values.inject(0, &:+)
  #
  #
  #
  #     # calculer l'augmentation de production grace à l'elec produite
  #   end
  # end
end
