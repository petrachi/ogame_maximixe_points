class BaseCostsCalculator::ByPlanet
  attr_accessor :planet

  def initialize planet
    self.planet = planet
  end

  def ressources
    raise NotImplementedError
  end

  def call
    ressources.each_with_object([]) do |ressource, acc|
      acc << self.class.parent::ByRessource.const_get(ressource.to_s.camelize).new(planet).call
    end
  end
end
