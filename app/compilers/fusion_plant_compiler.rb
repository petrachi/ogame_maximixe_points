class FusionPlantCompiler < PlantCompiler
  def blueprint_name
    "fusion_plant"
  end

  def uid
    super << " - #{ planet.temperature }"
  end
  
  def uid_buildings
    :deuterium_mine
  end
end
