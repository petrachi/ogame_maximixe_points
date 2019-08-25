class ResearchCostsCalculator::ByRessource::Plasma < ResearchCostsCalculator::ByRessource
  def produces
    player
      .produces(modifiers: {plasma_tech: 1})
      .merge(player.produces, &merge_proc(:-))
      .values
      .inject(0, &:+)
  end
end
