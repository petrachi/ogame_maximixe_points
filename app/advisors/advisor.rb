class Advisor
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def build_list_by **options
    build_list
      .select{ |build| options.all?{ |(k, v)| build.send(k) == v } }
  end

  def best_build
    build_list
      .select{ |build| build.warnings.blank? }
      .max_by{ |a| a.percentage }
  end

  def compilers
    raise NotImplementedError
  end

  def build_list
    @build_list ||= player
      .planets
      .includes(buildings: :blueprint)
      .each_with_object([]) do |planet, acc|
        compilers.each do |compiler|
          acc << compiler.new(planet)
        end
      end
      .each{ |build| build.compile_index!(total_produces) }
      .tap do |temp_build_list|
        temp_build_list.each do |build|
          build.compile_percentage! min_index(temp_build_list)
        end
      end
      .each{ |build| build.compile_warnings! ratio: differential_ratio }
  end

  def total_produces
    @total_produces ||= player.produces
  end

  def min_index build_list
    @min_index = build_list
      .map{ |build| build.index }
      .delete_if{ |index| index == 0 || index.nan? }
      .min
  end

  def differential_ratio
    @differential_ratio ||= actual_ratio.merge(ideal_ratio, &merge_proc(:-))
  end

  def ideal_ratio
    ratio_for player.cumulative_costs
  end

  def actual_ratio
    ratio_for player.produces.slice(:metal, :cristal, :deuterium)
  end

  def ratio_for ressources
    total_ressources = ressources.values.inject(0, &:+)

    ressources.each_with_object(Hash.new(0)) do |(ressource, quantity), acc|
      acc[ressource] = quantity / total_ressources
    end
  end


  # attr_accessor :player
  #
  # def initialize player
  #   self.player = player
  # end
  #
  # def player_costs
  #   player
  #     .costs(modifiers: {level: 1})
  #     .merge(
  #       player.buildings.where_name(/.*_artillery/).costs,
  #       &merge_proc(:-)
  #     )
  #     .merge(
  #       ArtilleryCostsCalculator.artillery_mix(level: player.planets.count).costs,
  #       &merge_proc(:+)
  #     )
  # end
  #
  # def ideal_ratio
  #   ratio_for player_costs
  # end
  #
  # def actual_ratio
  #   ratio_for player.produces.slice(:metal, :cristal, :deuterium)
  # end
  #
  # def differential_ratio
  #   @differential_ratio ||= actual_ratio.merge(ideal_ratio, &merge_proc(:-))
  # end
  #
  # def ratio_for ressources
  #   total_ressources = ressources.values.inject(0, &:+)
  #
  #   ressources.each_with_object(Hash.new(0)) do |(ressource, quantity), acc|
  #     acc[ressource] = quantity / total_ressources
  #   end
  # end
  #
  # def calculators
  #   [
  #     ArtilleryCostsCalculator,
  #     ProductionCostsCalculator,
  #     ResearchCostsCalculator,
  #     StorageCostsCalculator,
  #   ]
  # end
  #
  # def build_list
  #   @build_list ||= calculators
  #     .inject([]) do |acc, calculator|
  #       acc + calculator.new(player).call
  #     end
  #     .each(&method(:add_costs_for_one))
  #     .each(&method(:add_time_for_one))
  #     .each(&method(:add_time_index))
  #     .each(&method(:add_ratio_index))
  #     .tap do |temp_build_list|
  #       min_index = temp_build_list
  #         .map{ |build| build[:time_index] }
  #         .delete_if{ |index| index == 0 || index.nan? }
  #         .min
  #
  #       temp_build_list.each do |build|
  #         add_percentage_index build, min_index: min_index
  #       end
  #     end
  #     .delete_if{ |build| build[:time_index] == 1.0/0 }
  #     .sort_by{ |build| build[:ratio_index] }
  # end
  #
  # def best_build
  #   build_list.find{ |build| build[:type] == :building }
  # end
  #
  # def best_reaserch
  #   build_list.find{ |build| build[:type] == :research }
  # end
  #
  # def call
  #   build_list
  #     # .uniq{ |build| [build[:planet], build[:type]] }
  # end
  #
  # def add_costs_for_one build
  #   build[:costs_for_one] = build[:costs].each_with_object({}) do |(ressource, cost), acc|
  #     acc[ressource] = cost / build[:produces]
  #     acc
  #   end
  # end
  #
  # def total_produces
  #   @total_produces ||= player.produces
  # end
  #
  # def add_time_for_one build
  #   build[:time_for_one] = build[:costs_for_one].each_with_object({}) do |(ressource, cost), acc|
  #     acc[ressource] = cost / total_produces[ressource] * 3600
  #     acc
  #   end
  # end
  #
  # def add_time_index build
  #   build[:time_index] = build[:time_for_one].values.inject(0, &:+)
  # end
  #
  # def add_ratio_index build
  #   ratio = differential_ratio.fetch(build[:ressource], nil)
  #
  #   # p build[:ressource]
  #   # p differential_ratio[build[:ressource]]
  #   # p differential_ratio.fetch(build[:ressource], nil)
  #   # raise if build[:buildings].first.blueprint.name == 'fusion_plant'
  #
  #
  #   build[:ratio_index] = if ratio
  #     if ratio >= 0
  #       1.0/0
  #     else
  #       build[:time_index]
  #     end
  #   else
  #     build[:time_index]
  #   end
  # end
  #
  # def add_percentage_index build, min_index:
  #   build[:percentage_index] = 1 / (build[:time_index] / min_index)
  # end

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
