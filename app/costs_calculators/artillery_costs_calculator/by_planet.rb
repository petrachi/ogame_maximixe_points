class ArtilleryCostsCalculator::ByPlanet < BaseCostsCalculator::ByPlanet
  ARTILLERY_INVESTMENT_TIME = 120.0

  attr_accessor :invested_ressources

  def initialize *args
    super
    self.invested_ressources = planet
      .produces
      .slice(:metal, :cristal, :deuterium)
      .each_with_object({}) do |(ressource, quantity), acc|
        acc[ressource] = quantity * ARTILLERY_INVESTMENT_TIME
      end
  end

  def ressources
    %i[
      plasma
      gauss
      ion
      heavy_laser
      laser
      missile
    ]
  end

  def call
    ressources.each_with_object([]) do |ressource, acc|
      calculator = self.class.parent::ByRessource.const_get(ressource.to_s.camelize).new(invested_ressources, planet)
      acc << calculator.call
      self.invested_ressources = invested_ressources.merge(calculator.costs, &merge_proc(:-))
    end
  end
end
