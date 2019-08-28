class BuildingAdvisor < Advisor
  def calculators
    [
      ProductionCostsCalculator,
      StorageCostsCalculator,
    ]
  end
end
