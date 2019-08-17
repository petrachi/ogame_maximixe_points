class ProductionCostsCalculator
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def production_costs
    player.planets.inject({}) do |production_costs, planet|
      production_costs[planet.name] = {
        metal: production_costs_for(planet: planet, ressource: :metal),
        cristal: production_costs_for(planet: planet, ressource: :cristal),
        deuterium: production_costs_for(planet: planet, ressource: :deuterium),
      }
      production_costs
    end
  end

  def production_costs_for planet:, ressource:
    mine = planet.buildings.includes(:blueprint).find_by(blueprints: {name: "#{ressource}_mine"})
    mine ||= Building.new(planet: planet, blueprint: Blueprint['metal_mine'], level: 0)
    actual_production = mine.produces
    next_production = mine.produces modifiers: {level: 1}
    increase_in_production = next_production.merge(actual_production){ |_, a, b| a - b }

    increase_in_energy = -increase_in_production.delete(:energy)

    total_increase_in_production = increase_in_production.values.inject(0, &:+)

    costs = mine.costs modifiers: {level: 1}
    costs_for_one = costs.map{|k, v| [k, v/total_increase_in_production]}.to_h

    player_production = player.produces

    # in seconds
    time_to_produce = costs_for_one.inject({}) do |time_to_produce, (ressource, cost)|
      time_to_produce[ressource] = cost / player_production[ressource] * 3600
      time_to_produce
    end

    time_to_produce[:energy] = increase_in_energy / total_increase_in_production
    time_to_produce


    # need to calculate costs of energy

    # TODO :
    # - here, calculate the costs in ressource for 1 production
    # - create a new calculator to convert ressources into time to produce
    # TODO :
    # - diviser les calculator en : un général; un par planéte; un par ressource
    # - ajouter l'énergie comme une ressource où on peut calculuer le cout
    # TODO :
    # - rendre les calculator indépendant des planete/buildings,
    # - permettre de passer un lvl de building
    # - comme ça on pourra calculer facilement pour n'importe quel niveau et mieux anticiper l'avenir de plusieurs constructions dépendantes


  end
end
