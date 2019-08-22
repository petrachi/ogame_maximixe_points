class StorageCostsCalculator::ByPlanet < BaseCostsCalculator::ByPlanet
  def ressources
    %i[metal cristal deuterium]
  end
end
