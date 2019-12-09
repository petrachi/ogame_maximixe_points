class DeuteriumStorageCompiler < StorageCompiler
  def ressource
    :deuterium
  end

  def uid
    super << " - #{ planet.temperature }"
  end
end
