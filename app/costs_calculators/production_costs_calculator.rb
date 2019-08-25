class ProductionCostsCalculator < BaseCostsCalculator
  Dir[Rails.root.join("app/costs_calculators/production_costs_calculator/*.rb")]
    .each { |f| require_dependency f }
end
