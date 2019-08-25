class ProductionCostsCalculator::ByPlanet < BaseCostsCalculator::ByPlanet
  def ressources
    %i[metal cristal deuterium solar fusion]
  end
end
