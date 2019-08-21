class BuilderAdvisor::Storage
  attr_accessor :player, :calculator

  def initialize player
    self.player = player
    self.calculator = StorageCalculator.new(player)
  end

  def call
    calculator
      .call
      .each_with_object([]) do |(planet, values), acc|
        values.each do |(ressource, level_needed)|
          building = planet.buildings["#{ ressource }_storage"]

          (building.level + 1).upto(level_needed) do |level|
            acc << {
              planet: planet,
              building: building,
              level: level,
            }
          end
        end
    end
  end
end
