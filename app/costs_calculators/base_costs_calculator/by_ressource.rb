class BaseCostsCalculator::ByRessource
  attr_accessor :planet

  def initialize planet
    self.planet = planet
  end

  def blueprint_name
    raise NotImplementedError
  end

  def buildings
    planet.buildings.where_name(blueprint_name)
  end

  def ressource
    self.class.name.demodulize.underscore.to_sym
  end

  def produces
    buildings.produces(modifiers: {level: 1}).merge(buildings.produces, &merge_proc(:-))
  end

  def costs
    buildings.costs modifiers: {level: 1}
  end

  def call
    {
      produces: produces,
      costs: costs,
    }
  end
end
