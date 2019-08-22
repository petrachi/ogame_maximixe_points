class StorageCostsCalculator < BaseCostsCalculator
  Dir[Rails.root.join("app/costs_calculators/storage_costs_calculator/*.rb")]
    .each { |f| require_dependency f }
  # attr_accessor :player
  #
  # def initialize player
  #   self.player = player
  # end
  #
  # def call
  #   player.planets.each_with_object({}) do |planet, acc|
  #     acc[planet] = StorageCalculator::ByPlanet.new(planet).call
  #   end
  # end
end
