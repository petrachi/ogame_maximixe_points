class ProductionCostsCalculator
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def call
    player.planets.each_with_object({}) do |planet, acc|
      acc[planet.name] = ProductionCostsCalculator::ByPlanet.new(planet).call
    end
  end
end
