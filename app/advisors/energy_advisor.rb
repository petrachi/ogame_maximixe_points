class EnergyAdvisor < Advisor
  def compilers
    [
      SolarPlantCompiler,
      FusionPlantCompiler,
      EnergyTechCompiler,
    ]
  end
end
