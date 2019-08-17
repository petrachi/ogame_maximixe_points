class EnergyCostsCalculator
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def energy_costs
    player.planets.inject({}) do |energy_costs, planet|
      energy_costs[planet.name] = {
        metal: energy_costs_for(planet: planet, ressource: :metal),
        cristal: energy_costs_for(planet: planet, ressource: :cristal),
        deuterium: energy_costs_for(planet: planet, ressource: :deuterium),
      }
      energy_costs
    end
  end

  def energy_costs_for planet:, ressource:

    # power_plant
    # fusion_plant


  end
end
