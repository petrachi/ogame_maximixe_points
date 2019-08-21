class StorageCalculator::ByPlanet
  attr_accessor :planet

  def initialize planet
    self.planet = planet
  end

  def storage_wanted_time
    24
  end

  def call
    {
      metal: StorageCalculator::ByRessource::Metal.new(planet).call,
      cristal: StorageCalculator::ByRessource::Cristal.new(planet).call,
      deuterium: StorageCalculator::ByRessource::Deuterium.new(planet).call,
    }
  end
end
