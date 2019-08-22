class BaseCostsCalculator
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def call
    player
      .planets
      .inject([]) do |acc, planet|
        acc + self.class::ByPlanet.new(planet).call
      end
  end
end
