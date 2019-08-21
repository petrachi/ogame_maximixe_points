class BuilderAdvisor::Energy
  attr_accessor :player, :calculator

  def initialize player
    self.player = player
    self.calculator = ProductionCostsCalculator.new(player)
  end

  def call
    calculator
      .call
      .each_with_object([]) do |(planet, values), acc|
        if planet.produces[:energy] < 0
          name, index = values
            .slice(*%i[solar fusion])
            .min{ |(_, index)| index }

          building = planet.buildings["#{ name }_plant"]

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
