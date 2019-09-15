class ArtilleryCompiler < PlanetCompiler
  def type
    :artillery
  end

  def blueprint_name
    "#{ ressource }_artillery"
  end

  def uid
    "#{blueprint_name}, #{building.level}, #{ planet.buildings["metal_storage"].level }, #{ planet.buildings["cristal_storage"].level }, #{ planet.buildings["deuterium_storage"].level }"
  end

  def compile_produces
    building.sustains[:hull]
  end

  def compile_costs
    building.costs
  end

  DEFCON = 1
  ENEMY_TECH = 16

  def upto
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
    planet_stocks = planet.stocks.values.inject(0, &:+)

    mip_needed = planet_stocks / mip_costs
    mip_damages = Blueprint['interplanetary_rocket'].damages(level: 1, military_tech: ENEMY_TECH * 3)[:hull] * mip_needed
    artillery_mix_sustains = artillery_mix.sustains

    mip_damages / artillery_mix_sustains.to_f
  end

  def artillery_mix level: 1
    artillery_mix_ratio
      .each_with_object([]) do |(ressource, quantity), acc|
        acc << Building.new(
          blueprint: Blueprint["#{ressource}_artillery"],
          level: quantity,
          planet: planet,
        )
      end
      .tap do |acc|
        acc.class_eval do
          def sustains
            map{ |building| building.cumulative_sustains[:hull] }.inject(0, &:+)
          end
        end
      end
  end

  def compile_warnings! ratio:
    self.warnings << :too_many_artillery if building.level >= upto
  end
end
