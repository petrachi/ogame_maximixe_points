class StorageCalculator
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def call
    player.planets.each_with_object({}) do |planet, acc|
      acc[planet.name] = StorageCalculator::ByPlanet.new(planet).call
    end
  end

  # def needed_storage_level
  #   player.planets.inject({}) do |needed_storage_level, planet|
  #     needed_storage_level[planet.name] = {
  #       metal: needed_storage_level_for(planet: planet, ressource: :metal),
  #       cristal: needed_storage_level_for(planet: planet, ressource: :cristal),
  #       deuterium: needed_storage_level_for(planet: planet, ressource: :deuterium),
  #     }
  #     needed_storage_level
  #   end
  # end
  #
  # def needed_storage_level_for planet:, ressource:
  #   needed_level = -1
  #
  #   begin
  #     needed_level += 1
  #     storage_at_needed_level = Blueprint["#{ressource}_storage"]
  #       .stocks(level: needed_level, temperature: 0)
  #       .[](ressource)
  #   end while storage_at_needed_level < production_in_storage_wanted_time(planet: planet)[ressource]
  #
  #   needed_level
  # end
  #
  # def production_in_storage_wanted_time planet:
  #   planet.produces.inject(Hash.new{0}) do |production_in_storage_wanted_time, (ressource, production)|
  #     production_in_storage_wanted_time[ressource] = production * storage_wanted_time
  #     production_in_storage_wanted_time
  #   end
  # end
end
