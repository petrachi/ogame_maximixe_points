class StorageCostsCalculator < BaseCostsCalculator
  Dir[Rails.root.join("app/costs_calculators/storage_costs_calculator/*.rb")]
    .each { |f| require_dependency f }
end
