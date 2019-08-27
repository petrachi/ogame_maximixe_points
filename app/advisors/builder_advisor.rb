class BuilderAdvisor
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def player_costs
    player
      .costs
      .merge(
        player.buildings.where_name(/.*_artillery/).costs,
        &merge_proc(:-)
      )
      .merge(
        ArtilleryCostsCalculator.artillery_mix(level: player.planets.count).costs,
        &merge_proc(:+)
      )
  end

  def ideal_ratio
    ratio_for player_costs
  end

  def actual_ratio
    ratio_for player.produces.slice(:metal, :cristal, :deuterium)
  end

  def differential_ratio
    @differential_ratio ||= actual_ratio.merge(ideal_ratio, &merge_proc(:-))
  end

  def ratio_for ressources
    total_ressources = ressources.values.inject(0, &:+)

    ressources.each_with_object({}) do |(ressource, quantity), acc|
      acc[ressource] = quantity / total_ressources
    end
  end

  def call

  end

  def build_list
    [
      ArtilleryCostsCalculator,
      ProductionCostsCalculator,
      ResearchCostsCalculator,
      StorageCostsCalculator,
    ]
      .inject([]) do |acc, calculator|
        acc + calculator.new(player).call
      end
      .each(&method(:add_costs_for_one))
      .each(&method(:add_time_for_one))
      .each(&method(:add_time_index))
      .each(&method(:add_ratio_index))
      .delete_if{ |build| build[:ratio_index] == 1.0/0 }
      .sort_by{ |build| build[:ratio_index] }
      .uniq do |build|
        if build[:type] == :artillery
          [build[:planet], build[:type], build[:ressource]]
        else
          [build[:planet], build[:type]]
        end
      end
  end

  def add_costs_for_one build
    build[:costs_for_one] = build[:costs].each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / build[:produces]
      acc
    end
  end

  def add_time_for_one build
    produces = player.produces
    build[:time_for_one] = build[:costs_for_one].each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / produces[ressource] * 3600
      acc
    end
  end

  def add_time_index build
    build[:time_index] = build[:time_for_one].values.inject(0, &:+)
  end

  def add_ratio_index build
    ratio = differential_ratio[build[:ressource]]
    build[:ratio_index] = if ratio
      if ratio > 0.01
        1.0/0
      else
        build[:time_index]
      end
    else
      build[:time_index]
    end
  end

  # def costs_status build, acc
  #   costs = build[:building]
  #     .costs(modifiers: {
  #       level: build[:level] - build[:building].level
  #     })
  #
  #   status = if holds.merge(costs, &merge_proc(:-)).all?{ |_, hold| hold > 0 }
  #     holds.merge!(costs, &merge_proc(:-))
  #     :ok
  #   else
  #     :not_enought_money
  #   end
  #   acc << build.merge({status: status, costs: costs})
  # end
  #
  # def shipments
  #   ships_cargo = 5_000
  #   advises.each do |advise|
  #     if advise[:status] == :ok
  #       planets_holds[advise[:planet]].merge!(advise[:costs], &merge_proc(:-))
  #     end
  #   end
  #
  #   planets_needs = planets_holds.each_with_object({}) do |(planet, holds), acc|
  #     acc[planet] = holds
  #       .select{ |_, quantity| quantity < 0 }
  #       .each_with_object({}){ |(ressource, quantity) ,acc| acc[ressource] = -quantity }
  #   end
  #
  #   shipments = []
  #
  #   planets_needs.each do |(planet, needs)|
  #     needs.each do |(ressource, quantity)|
  #
  #       p "planet need: #{planet.name}, #{ressource}:#{quantity}"
  #
  #       shipped_quantity = 0
  #
  #       while shipped_quantity < quantity
  #         from = planets_holds.find{ |_, v| v[ressource] > 0 }
  #         quantity_to_ship = [from[1][ressource], quantity].min
  #         shipped_quantity += quantity_to_ship
  #         planets_holds[from[0]][ressource] -= quantity_to_ship
  #         planets_holds[planet][ressource] += quantity_to_ship
  #
  #         p "add a shipment from #{from[0].name}:#{quantity_to_ship}"
  #         shipments << {
  #           from: from[0],
  #           to: planet,
  #           ressource: ressource,
  #           quantity: quantity_to_ship,
  #         }
  #       end
  #     end
  #   end
  # end
end
