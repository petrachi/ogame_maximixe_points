class BaseCostsCalculator
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def call
    player.planets.each_with_object({}) do |planet, acc|
      acc[planet] = self.class::ByPlanet.new(planet).call
    end
  end
end
