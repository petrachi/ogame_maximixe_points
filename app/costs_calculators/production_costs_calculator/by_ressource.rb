class ProductionCostsCalculator::ByRessource < BaseCostsCalculator::ByRessource
  Dir[Rails.root.join("app/costs_calculators/production_costs_calculator/by_ressource/*.rb")].each { |f| require_dependency f }

  attr_accessor :produces, :costs

  def initialize *args
    super
  end

  def call
    compute_complete_costs_and_production
    super
  end

  def compute_complete_costs_and_production
    compute_consumptions
    compute_energy_efficiency
  end

  def compute_consumptions
    self.produces = base_produces
    self.costs = base_costs

    while consumptions_to_compute.present?
      consumptions_to_compute.each do |(ressource, quantity)|
        calculator = ProductionCostsCalculator::ByRessource
          .const_get(ressource.to_s.camelize)
          .new(planet)

        costs_to_add = calculator.costs_for quantity: -quantity
        produces_to_add = calculator.produces_for quantity: -quantity

        costs.merge!(costs_to_add, &merge_proc(:+))
        produces.merge!(produces_to_add, &merge_proc(:+))
      end
    end
  end

  def base_produces
    buildings.produces(modifiers: {level: 1}).merge(buildings.produces, &merge_proc(:-))
  end

  def base_costs
    buildings.costs modifiers: {level: 1}
  end

  def consumptions_to_compute
    produces
      .except(ressource)
      .delete_if{ |_, quantity| quantity > -1 }
  end

  def costs_for(quantity:)
    base_costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost * (quantity / base_produces[self.ressource])
    end
  end

  def produces_for(quantity:)
    base_produces.each_with_object({}) do |(ressource, produce), acc|
      acc[ressource] = produce * (quantity / base_produces[self.ressource])
    end
  end

  def compute_energy_efficiency
    self.produces = if planet.produces[:energy] < 0
      if ressource == :energy
        base_production = planet.produces.except(:energy).values.inject(0, &:+)
        actual_production = base_production * planet.energy_efficiency
        next_production = base_production * planet.energy_efficiency(extra_consumption: -produces[:energy])
        next_production - actual_production
      else
        0
      end
    else
      if ressource == :energy
        0
      else
        produces[ressource]
      end
    end

    #
    # base_production = planet.produces.except(:energy).values.inject(0, &:+)
    # actual_production = base_production * planet.energy_efficiency
    #
    # next_production = if ressource == :energy
    #   base_production * planet.energy_efficiency(extra_consumption: -produces[:energy])
    # else
    #   (base_production + produces[ressource]) * planet.energy_efficiency(extra_consumption: -base_produces[:energy])
    # end
    #
    # # for deut: if there is not enought energy, the lost in production is usually bigger that the increase, so costs goes to infinite
    # # that means that deutmine will be shown susbtantialy less often
    # # It's a nice calc but I dont thuink it is very usefull
    # # Just set produces to 0 when energy is negative, and don't touch otherwise
    #
    #
    # self.produces = next_production - actual_production
    # p base_produces[:energy]
    # p planet.produces[:energy]
    # p produces
    # p "*"*45
    # self.produces = 0.0 if produces < 0
    # p produces
    # p "*"*45
    # if ressource == :energy && produces > 0 && base_produces[:energy] > -planet.produces[:energy]
    #   self.produces *= base_produces[:energy] / -planet.produces[:energy]
    # end
  end

  # def produces
  #   # produces = planet.produces[ressource] * STORAGE_WANTED_TIME - buildings.stocks[ressource]
  #   # produces = 0.0 if produces < 0
  #   # produces
  # end




  #
  #
  # attr_accessor :planet
  #
  # def initialize planet
  #   self.planet = planet
  # end
  #
  # def ressource
  #   raise NotImplementedError
  # end
  #
  # def blueprint_name
  #   raise NotImplementedError
  # end
  #
  # def call
  #   index
  # end
  #
  # def index
  #   produces = planet.player.produces
  #   complete_costs
  #     .each_with_object({}) do |(ressource, cost), acc|
  #       acc[ressource] = cost / produces[ressource] * 3600
  #       acc
  #     end
  #     .values
  #     .inject(0, &:+)
  # end
  #
  # def complete_costs
  #   costs = self.base_costs_next_level
  #   produces = self.base_produces_next_level
  #   dependencies = dependencies_for(produces)
  #
  #   while dependencies.present?
  #     dependencies.each do |(ressource, quantity)|
  #       calculator = ProductionCostsCalculator::ByRessource
  #         .const_get(ressource.to_s.camelize)
  #         .new(planet)
  #
  #       costs_to_add = calculator.costs_for quantity: -quantity
  #       produces_to_add = calculator.produces_for quantity: -quantity
  #
  #       costs.merge!(costs_to_add, &merge_proc(:+))
  #       produces.merge!(produces_to_add, &merge_proc(:+))
  #     end
  #     dependencies = dependencies_for(produces)
  #   end
  #
  #   costs.each_with_object({}) do |(ressource, cost), acc|
  #     acc[ressource] = cost / produces[self.ressource]
  #   end
  # end
  #
  # def base_costs
  #   costs.each_with_object({}) do |(ressource, cost), acc|
  #     acc[ressource] = cost / produces[self.ressource]
  #   end
  # end
  #
  # def base_costs_next_level
  #   costs.each_with_object({}) do |(ressource, cost), acc|
  #     acc[ressource] = cost / produces_next_level[self.ressource]
  #   end
  # end
  #
  # def costs **options
  #   buildings.costs **options
  # end
  #
  # def base_produces_next_level
  #   produces_next_level.each_with_object({}) do |(ressource, cost), acc|
  #     acc[ressource] = cost / produces_next_level[self.ressource]
  #   end
  # end
  #
  # def produces_next_level
  #   produces = self.produces(modifiers: {level: 1})
  #     .merge(self.produces, &merge_proc(:-))
  # end
  #
  # def base_produces
  #   produces.each_with_object({}) do |(ressource, cost), acc|
  #     acc[ressource] = cost / produces[self.ressource]
  #   end
  # end
  #
  # def produces **options
  #   buildings.produces **options
  # end
  #
  # def buildings
  #   planet.buildings.where_name(blueprint_name)
  # end
  #
  # def dependencies_for produces
  #   produces.except(ressource).delete_if{ |_, quantity| quantity.nan? || quantity.abs <= 0.0001 }
  # end
  #
  # def costs_for(quantity:)
  #   base_costs.each_with_object({}) do |(ressource, cost), acc|
  #     acc[ressource] = cost * quantity
  #   end
  # end
  #
  # def produces_for(quantity:)
  #   base_produces.each_with_object({}) do |(ressource, produce), acc|
  #     acc[ressource] = produce * quantity
  #   end
  # end
end
