class EnergyMineCompiler
  attr_accessor :planet

  def initialize planet
    self.planet = planet
  end

  def ressource
    :energy
  end

  def buildings
    planet.buildings.where_name(%i[solar_plant fusion_plant])
  end

  def simple_produces
    @simple_produces ||= buildings.produces
  end

  def simple_costs
    @simple_costs ||= buildings.cumulative_costs
  end

  def costs_for(quantity:)
    simple_costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost * (quantity / simple_produces[self.ressource])
    end
  end

  def produces_for(quantity:)
    simple_produces.each_with_object({}) do |(ressource, produce), acc|
      acc[ressource] = produce * (quantity / simple_produces[self.ressource])
    end
  end
end
