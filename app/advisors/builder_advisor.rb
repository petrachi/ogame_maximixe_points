class BuilderAdvisor
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def call

  end

  def build_list
    [
      StorageCostsCalculator,
    ]
      .inject([]) do |acc, calculator|
        acc + calculator.new(player).call
      end
      .each(&method(:add_costs_for_one))
      .each(&method(:add_time_for_one))
      .each(&method(:add_time_index))
  end

  def add_costs_for_one build
    build[:costs_for_one] = build[:costs].each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / build[:produces]
      acc
    end
  end

  def add_time_for_one build
    build[:time_for_one] = build[:costs_for_one].each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / player.produces[ressource] * 3600
      acc
    end
  end

  def add_time_index build
    build[:time_index] = build[:time_for_one].values.inject(0, &:+)
  end

  # 50 / 100*3600
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
