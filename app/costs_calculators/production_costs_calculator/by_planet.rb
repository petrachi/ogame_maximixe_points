class ProductionCostsCalculator::ByPlanet
  attr_accessor :planet

  def initialize planet
    self.planet = planet
  end

  def call
    {
      metal: ProductionCostsCalculator::ByRessource::Metal.new(planet).call,
      cristal: ProductionCostsCalculator::ByRessource::Cristal.new(planet).call,
      deuterium: ProductionCostsCalculator::ByRessource::Deuterium.new(planet).call,
      solar: ProductionCostsCalculator::ByRessource::Solar.new(planet).call,
      fusion: ProductionCostsCalculator::ByRessource::Fusion.new(planet).call,
      energy: ProductionCostsCalculator::ByRessource::Energy.new(planet).call,
    }
  end
end