class ProductionCostsCalculator::ByRessource < BaseCostsCalculator::ByRessource
  Dir[Rails.root.join("app/costs_calculators/production_costs_calculator/by_ressource/*.rb")].each { |f| require_dependency f }

  attr_accessor :produces, :costs

  def initialize *args
    super
  end

  def type
    :building
  end

  def call
    compute_complete_costs_and_production
    super
  end

  def compute_complete_costs_and_production
    compute_consumptions
    compute_energy_efficiency
  end

  def compute_consumptions
    self.produces = base_produces
    self.costs = base_costs

    while consumptions_to_compute.present?
      consumptions_to_compute.each do |(ressource, quantity)|
        calculator = ProductionCostsCalculator::ByRessource
          .const_get(ressource.to_s.camelize)
          .new(planet)

        costs_to_add = calculator.costs_for quantity: -quantity
        produces_to_add = calculator.produces_for quantity: -quantity

        costs.merge!(costs_to_add, &merge_proc(:+))
        produces.merge!(produces_to_add, &merge_proc(:+))
      end
    end
  end

  def base_produces
    buildings.produces(modifiers: {level: 1}).merge(buildings.produces, &merge_proc(:-))
  end

  def base_costs
    buildings.costs modifiers: {level: 1}
  end

  def consumptions_to_compute
    produces
      .except(ressource)
      .delete_if{ |_, quantity| quantity > -1 }
  end

  def costs_for(quantity:)
    base_costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost * (quantity / base_produces[self.ressource])
    end
  end

  def produces_for(quantity:)
    base_produces.each_with_object({}) do |(ressource, produce), acc|
      acc[ressource] = produce * (quantity / base_produces[self.ressource])
    end
  end

  def compute_energy_efficiency
    # if ressource == :energy
    #   base_production = planet.produces.except(:energy).values.inject(0, &:+)
    #   base_production_for_one = base_production / planet.buildings.where_name(%i[solar_plant fusion_plant]).produces[:energy]
    #   self.produces = produces[:energy] * base_production_for_one
    # else
    #   self.produces = produces[ressource]
    # end

    self.produces = if planet.produces[:energy] < 0
      if ressource == :energy
        base_production = planet.produces.except(:energy).values.inject(0, &:+)
        actual_production = base_production * planet.energy_efficiency
        next_production = base_production * planet.energy_efficiency(extra_consumption: -produces[:energy])
        next_production - actual_production
      else
        0
      end
    else
      if ressource == :energy
        0
      else
        produces[ressource]
      end
    end
  end
end
