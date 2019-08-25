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

  def type
    raise NotImplementedError
  end

  def produces
    raise NotImplementedError
  end

  def costs
    raise NotImplementedError
  end

  def call
    {
      ressource: ressource,
      produces: produces,
      costs: costs,
      buildings: buildings,
      type: type,
      planet: planet,
    }
  end
end
