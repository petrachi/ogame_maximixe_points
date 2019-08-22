class ProductionCostsCalculator < BaseCostsCalculator
  Dir[Rails.root.join("app/costs_calculators/production_costs_calculator/*.rb")]
    .each { |f| require_dependency f }

  #
  # require_dependency './production_costs_calculator/by_planet'
  # require_dependency './production_costs_calculator/by_ressource'
  # require_dependency './production_costs_calculator/by_ressource/'
  # attr_accessor :player
  #
  # def initialize player
  #   self.player = player
  # end
  #
  # def call
  #   # player.planets.each_with_object({}) do |planet, acc|
  #   #   acc[planet] = ProductionCostsCalculator::ByPlanet.new(planet).call
  #   # end
  #   {}
  # end
end
