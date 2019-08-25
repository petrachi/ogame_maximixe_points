class ResearchCostsCalculator::ByRessource < BaseCostsCalculator::ByRessource
  Dir[Rails.root.join("app/costs_calculators/research_costs_calculator/by_ressource/*.rb")].each { |f| require_dependency f }

  attr_accessor :player

  def initialize player
    self.player = player
  end

  def type
    :research
  end

  def blueprint_name
    "#{ ressource }_tech"
  end

  def buildings
    player.researches.where_name(blueprint_name)
  end
  alias :researches :buildings

  def ressource
    self.class.name.demodulize.underscore.to_sym
  end

  def planet
    player.buildings.where_name('research_factory').max{|b| b.level}.planet
  end

  def costs
    researches.costs
  end
end
