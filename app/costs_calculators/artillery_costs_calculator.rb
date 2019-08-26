class ArtilleryCostsCalculator < BaseCostsCalculator
  Dir[Rails.root.join("app/costs_calculators/artillery_costs_calculator/*.rb")]
    .each { |f| require_dependency f }
end
