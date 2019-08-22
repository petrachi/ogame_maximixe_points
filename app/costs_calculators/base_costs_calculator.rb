class BaseCostsCalculator
  Dir[Rails.root.join("app/costs_calculators/base_costs_calculator/*.rb")].each { |f| require_dependency f }

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
