class DeuteriumStorageCompiler < StorageCompiler
  def ressource
    :deuterium
  end

  def uid
    super << ", #{ planet.buildings['fusion_plant'].level }"
  end
end
