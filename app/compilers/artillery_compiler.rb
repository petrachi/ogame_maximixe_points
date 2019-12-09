class ArtilleryCompiler < PlanetCompiler
  def type
    :artillery
  end

  def blueprint_name
    "#{ ressource }_artillery"
  end

  def uid_buildings
    /^.*_(storage|ship)$/
  end

  def compile_produces
    building.sustains[:hull]
  end

  def compile_costs
    building.costs
  end

  DEFCON = 1

  def compile_upto
    (artillery_mix_ratio[ressource] * artillery_mix_needed * DEFCON).ceil
  end

  def artillery_mix_ratio
    {
      missile: 500,
      laser: 100,
      heavy_laser: 25,
      gauss: 4,
      ion: 8,
      plasma: 1,
    }
  end

  def artillery_mix_needed
    mip_costs = Blueprint['interplanetary_rocket'].costs(level: 1).values.inject(0, &:+)
    planet_stocks = planet.buildings.where_name(/.*_storage/).stocks.values.inject(0, &:+)
    planet_ships = planet.buildings.where_name(/.*_ship/).cumulative_costs.values.inject(0, &:+)
    planet_value = planet_stocks + planet_ships

    mip_needed = planet_value / mip_costs
    mip_damages = Blueprint['interplanetary_rocket'].damages[:hull] * mip_needed

    mip_damages / artillery_mix_sustains.to_f
  end

  def artillery_mix_sustains

    artillery_mix_ratio.inject(0) do |acc, (ressource, quantity)|
      acc + (Blueprint["#{ressource}_artillery"].sustains[:hull] * quantity)
    end
  end

  def compile_warnings! ratio:
    self.warnings << :too_many_artillery if building.level >= upto
  end
end
