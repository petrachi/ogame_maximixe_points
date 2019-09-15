class MineCompiler < PlanetCompiler
  def type
    :mine
  end

  def blueprint_name
    "#{ ressource }_mine"
  end

  def uid
    "#{ blueprint_name } #{ building.level }, #{ planet.buildings["solar_plant"].level }, #{ planet.buildings["fusion_plant"].level }, #{ planet.buildings["deuterium_mine"].level }"
  end

  def compile_produces_and_costs
    produces = simple_produces
    costs = simple_costs

    while consumptions_to_compute(produces).present?
      consumptions_to_compute(produces).each do |(ressource, quantity)|
        compiler = "#{ ressource.to_s.camelize }MineCompiler"
          .constantize
          .new(planet)

        costs_to_add = compiler.costs_for quantity: -quantity
        produces_to_add = compiler.produces_for quantity: -quantity

        costs_to_add.delete_if { |_, quantity| quantity.nan? }
        produces_to_add.delete_if { |_, quantity| quantity.nan? }

        produces.delete_if { |ressource, quantity| quantity < 0 && produces_to_add[ressource].blank? }

        costs.merge!(costs_to_add, &merge_proc(:+))
        produces.merge!(produces_to_add, &merge_proc(:+))
      end
    end

    {produces: produces[ressource], costs: costs}
  end

  def simple_produces
    @simple_produces ||= building.produces(modifiers: {level: 1}).merge(building.produces, &merge_proc(:-))
  end

  def simple_costs
    @simple_costs ||= building.costs modifiers: {level: 1}
  end

  def consumptions_to_compute(produces)
    produces
      .except(ressource)
      .delete_if{ |_, quantity| quantity > -1 || quantity.nan? }
  end

  def costs_for(quantity:)
    simple_costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost * (quantity / simple_produces[self.ressource])
    end
  end

  def produces_for(quantity:)
    simple_produces.each_with_object({}) do |(ressource, produce), acc|
      acc[ressource] = produce * (quantity / simple_produces[self.ressource])
    end
  end

  def compile_warnings! ratio:
    self.warnings << :not_enough_energy if planet.produces[:energy] < 0
    self.warnings << :too_much_production if ratio[ressource] > 0
  end
end
