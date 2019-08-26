class ArtilleryCostsCalculator::ByRessource < BaseCostsCalculator::ByRessource
  Dir[Rails.root.join("app/costs_calculators/artillery_costs_calculator/by_ressource/*.rb")].each { |f| require_dependency f }

  attr_accessor :invested_ressources

  def initialize invested_ressources, *args
    super *args
    self.invested_ressources = invested_ressources

    p invested_ressources
  end

  def blueprint_name
    "#{ ressource }_artillery"
  end

  def type
    :artillery
  end

  def produces
    if needs > 0
      1.0/0
    else
      0.0
    end
  end

  def costs
    if needs > 0
      buildings.costs modifiers: {level: needs}
    else
      base_costs
    end
  end

  def base_costs
    buildings.first.blueprint.costs level: 1
  end

  def upto
    invested_ressources
      .each_with_object([]) do |(ressource, quantity), acc|
        acc << if quantity > 0 && base_costs[ressource]
          quantity / base_costs[ressource]
        elsif base_costs[ressource]
          0
        else
          1.0/0
        end
      end
      .min
      .floor
  end

  def needs
    [upto - buildings.first.level, 0].max
  end
end
