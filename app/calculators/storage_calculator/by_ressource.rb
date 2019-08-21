class StorageCalculator::ByRessource
  attr_accessor :player, :planet

  def initialize planet
    self.planet = planet
  end

  def ressource
    raise NotImplementedError
  end

  def storage_wanted_time
    30
  end

  def call
    needed_level
  end

  def needed_level
    needed_level = -1

    begin
      needed_level += 1
      storage_at_needed_level = Blueprint["#{ressource}_storage"]
        .stocks(level: needed_level, temperature: 0)
        .[](ressource)
    end while storage_at_needed_level < production_in_storage_wanted_time

    needed_level
  end

  def production_in_storage_wanted_time
    planet.produces[ressource] * storage_wanted_time
  end
end
