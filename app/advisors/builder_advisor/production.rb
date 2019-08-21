class BuilderAdvisor::Production
  attr_accessor :player, :calculator

  def initialize player
    self.player = player
    self.calculator = ProductionCostsCalculator.new(player)
  end

  def call
    calculator
      .call
      .each_with_object([]) do |(planet, values), acc|
        values
          .slice(*%i[metal cristal deuterium])
          .each do |(ressource, index)|
            building = planet.buildings["#{ ressource }_mine"]

            acc << {
              planet: planet,
              building: building,
              level: building.level + 1,
              index: index,
            }
          end
      end
      .sort_by{ |e| e[:index] }
  end
end
