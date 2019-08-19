class ProductionCostsCalculator::ByRessource
  attr_accessor :planet

  def initialize planet
    self.planet = planet
  end

  def ressource
    raise NotImplementedError
  end

  def blueprint_name
    raise NotImplementedError
  end

  def call
    index
  end

  def index
    produces = planet.player.produces
    complete_costs
      .each_with_object({}) do |(ressource, cost), acc|
        acc[ressource] = cost / produces[ressource] * 3600
        acc
      end
      .values
      .inject(0, &:+)
  end

  def complete_costs
    costs = self.base_costs_next_level
    produces = self.base_produces_next_level
    dependencies = dependencies_for(produces)

    while dependencies.present?
      dependencies.each do |(ressource, quantity)|
        calculator = ProductionCostsCalculator::ByRessource
          .const_get(ressource.to_s.camelize)
          .new(planet)

        costs_to_add = calculator.costs_for quantity: -quantity
        produces_to_add = calculator.produces_for quantity: -quantity

        costs.merge!(costs_to_add){ |_, a, b| a + b }
        produces.merge!(produces_to_add){ |_, a, b| a + b }
      end
      dependencies = dependencies_for(produces)
    end

    costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / produces[self.ressource]
    end
  end

  def base_costs
    costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / produces[self.ressource]
    end
  end

  def base_costs_next_level
    costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / produces_next_level[self.ressource]
    end
  end

  def costs
    buildings
    .each_with_object({}) do |building, acc|
      acc.merge!(building.costs){ |_, a, b| a + b }
    end
  end

  def base_produces_next_level
    produces_next_level.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / produces_next_level[self.ressource]
    end
  end

  def produces_next_level
    produces = self.produces(modifiers: {level: 1})
      .merge(self.produces){ |_, a, b| a - b }
  end

  def base_produces
    produces.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / produces[self.ressource]
    end
  end

  def produces(modifiers: {})
    buildings
      .each_with_object({}) do |building, acc|
        acc.merge!(building.produces(modifiers: modifiers)){ |_, a, b| a + b }
      end
  end

  def buildings
    planet.buildings.includes(:blueprint).where(blueprints: {name: blueprint_name})
  end

  def dependencies_for produces
    produces.except(ressource).delete_if{ |_, quantity| quantity.abs <= 0.0001 }
  end

  def costs_for(quantity:)
    base_costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost * quantity
    end
  end

  def produces_for(quantity:)
    base_produces.each_with_object({}) do |(ressource, produce), acc|
      acc[ressource] = produce * quantity
    end
  end
end
