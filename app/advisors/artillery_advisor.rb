class ArtilleryAdvisor < Advisor
  def calculators
    [
      ArtilleryCostsCalculator,
    ]
  end

  def call
    build_list.sort_by{ |build| build[:planet].id }
  end
end
