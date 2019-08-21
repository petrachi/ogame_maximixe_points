class BuilderAdvisor
  attr_accessor :player, :holds, :planets_holds

  def initialize player
    self.player = player
    self.holds = player.holds
    self.planets_holds = player.planets.each_with_object({}) do |planet, acc|
      acc[planet] = planet.holds
    end
  end

  def call
    {
      shipments: shipments,
      advises: advises,
    }
  end

  def advises
    @build_list ||= build_list.each_with_object([], &method(:costs_status))
  end

  def build_list
    [
      BuilderAdvisor::Storage,
      BuilderAdvisor::Energy,
      BuilderAdvisor::Production,
    ].map{ |advisor|
      advisor.new(player).call
    }.inject([], &:+)
  end

  def costs_status build, acc
    costs = build[:building]
      .costs(modifiers: {
        level: build[:level] - build[:building].level
      })

    status = if holds.merge(costs, &merge_proc(:-)).all?{ |_, hold| hold > 0 }
      holds.merge!(costs, &merge_proc(:-))
      :ok
    else
      :not_enought_money
    end
    acc << build.merge({status: status, costs: costs})
  end

  def shipments
    ships_cargo = 5_000
    advises.each do |advise|
      if advise[:status] == :ok
        planets_holds[advise[:planet]].merge!(advise[:costs], &merge_proc(:-))
      end
    end

    planets_needs = planets_holds.each_with_object({}) do |(planet, holds), acc|
      acc[planet] = holds
        .select{ |_, quantity| quantity < 0 }
        .each_with_object({}){ |(ressource, quantity) ,acc| acc[ressource] = -quantity }
    end

    shipments = []

    planets_needs.each do |(planet, needs)|
      needs.each do |(ressource, quantity)|

        p "planet need: #{planet.name}, #{ressource}:#{quantity}"

        shipped_quantity = 0

        while shipped_quantity < quantity
          from = planets_holds.find{ |_, v| v[ressource] > 0 }
          quantity_to_ship = [from[1][ressource], quantity].min
          shipped_quantity += quantity_to_ship
          planets_holds[from[0]][ressource] -= quantity_to_ship
          planets_holds[planet][ressource] += quantity_to_ship

          p "add a shipment from #{from[0].name}:#{quantity_to_ship}"
          shipments << {
            from: from[0],
            to: planet,
            ressource: ressource,
            quantity: quantity_to_ship,
          }
        end
      end
    end
  end
end
