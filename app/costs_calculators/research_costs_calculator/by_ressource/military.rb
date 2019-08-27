class ResearchCostsCalculator::ByRessource::Military < ResearchCostsCalculator::ByRessource
  def produces
    actual_level = player
      .researches
      .where_name(/(weapon|shield|armor)_research/)
      .pluck(:level)
      .inject(0, &:+)

    artillery_costs = player
      .buildings
      .where_name(/.*_artillery/)
      .costs
      .values
      .inject(0, &:+)

    artillery_costs / (10.0 + actual_level)
  end
end
