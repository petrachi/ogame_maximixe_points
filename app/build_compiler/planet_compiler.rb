class PlanetCompiler
  attr_accessor :index, :percentage, :warnings
  attr_accessor :planet, :building, :build

  def initialize planet
    self.planet = planet
    self.building = planet.buildings[blueprint_name.to_s]
    self.build = Build.find_or_create_by(uid: uid)

    unless build.compiled?
      build.update compiled: true, **compile_produces_and_costs
    end

    self.index = 1.0 / 0
    self.percentage = 0
    self.warnings = []
  end

  def type
    raise NotImplementedError
  end

  def ressource
    raise NotImplementedError
  end

  def blueprint_name
    raise NotImplementedError
  end

  def uid
    raise NotImplementedError
  end

  def upto
    building.level + 1
  end

  def increment
    upto - building.level
  end

  delegate :produces, :costs, to: :build

  def compile_produces_and_costs
    {produces: compile_produces, costs: compile_costs}
  end

  def compile_produces
    raise NotImplementedError
  end

  def compile_costs
    raise NotImplementedError
  end

  def costs_for_one
    costs.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource] = cost / produces
    end
  end

  def add_time_index build
    build[:time_index] = build[:time_for_one].values.inject(0, &:+)
  end

  def compile_index! total_produces
    self.index = costs_for_one
      .each_with_object({}) do |(ressource, cost), acc|
        acc[ressource] = cost / total_produces[ressource] * 3600
      end
      .values
      .inject(0, &:+)
  end

  def compile_percentage! min_index
    self.percentage = 1 / (index / min_index)
  end

  def compile_warnings!(**_) end
end
