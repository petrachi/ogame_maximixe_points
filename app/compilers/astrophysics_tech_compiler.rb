class AstrophysicsTechCompiler < MilitaryTechCompiler
  def ressource
    :astrophysics
  end

  def uid_buildings
    /^.*$/
  end

  def compile_produces
    player.produces.values.inject(0, &:+) / planets_count / split_level_divider
  end

  def compile_costs
    player
      .cumulative_costs
      .each_with_object({}) do |(ressource, quantity), acc|
        acc[ressource] = quantity / planets_count / split_level_divider
      end
      .merge(building.costs(modifiers: {level: 1}), &merge_proc(:+))
  end

  def planets_count
    (building.level / 2).ceil + 1
  end

  def split_level_divider
    if building.level.even?
      1 / 2.75
    else
      1.75 / 2.75
    end
  end
end
