class ResearchCostsCalculator < BaseCostsCalculator
  Dir[Rails.root.join("app/costs_calculators/research_costs_calculator/*.rb")]
    .each { |f| require_dependency f }

  def ressources
    %i[
      energy
      plasma
      astrophysics
      armor
      shield
      weapon
    ]
  end

  def call
    ressources.each_with_object([]) do |ressource, acc|
      acc << ResearchCostsCalculator::ByRessource.const_get(ressource.to_s.camelize).new(player).call
    end
  end
end
