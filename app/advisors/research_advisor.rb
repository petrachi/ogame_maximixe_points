class ResearchAdvisor < Advisor
  def calculators
    [
      ResearchCostsCalculator,
    ]
  end

  def call
    build_list
  end
end
