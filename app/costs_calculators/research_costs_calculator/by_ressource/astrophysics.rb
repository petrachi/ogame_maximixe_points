class ResearchCostsCalculator::ByRessource::Astrophysics < ResearchCostsCalculator::ByRessource
  def produces
    produces = player
      .produces
      .values
      .inject(0, &:+)

    produces / technology_divider
  end

  def costs
    one_planet_costs = player.costs.each_with_object({}) do |(ressource, quantity), acc|
      acc[ressource] = quantity / technology_divider
    end
    super.merge(one_planet_costs, &merge_proc(:+))
  end

  def technology_divider
    if researches.first.level.even?
      (1.5 * player.planets.count)
    else
      (3.0 * player.planets.count)
    end
  end
end
