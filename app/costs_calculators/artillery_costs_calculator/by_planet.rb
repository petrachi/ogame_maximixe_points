class ArtilleryCostsCalculator::ByPlanet < BaseCostsCalculator::ByPlanet
  def artillery_mix_needed
    mip_costs = Blueprint['interplanetary_missile_artillery'].costs(level: 1).values.inject(0, &:+)
    produces = planet
      .produces
      .slice(:metal, :cristal, :deuterium)
      .each_with_object({}) do |(ressource, quantity), acc|
        acc[ressource] = quantity * StorageCostsCalculator::ByRessource::STORAGE_WANTED_TIME
      end
      .values
      .inject(0, &:+)

    mip_needed = produces / mip_costs
    mip_damages = Blueprint['interplanetary_missile_artillery'].damages(level: mip_needed)[:hull]
    artillery_mix_sustains = ArtilleryCostsCalculator.artillery_mix.sustains[:hull]

    mip_damages / artillery_mix_sustains
  end

  def call
    ArtilleryCostsCalculator
      .artillery_mix(level: artillery_mix_needed)
      .each_with_object([]) do |building, acc|
        acc << {
          ressource: :artillery,
          produces: produces(building),
          costs: building.costs,
          buildings: planet.buildings.where(blueprint_id: building.blueprint_id),
          type: :artillery,
          planet: planet,
          upto: building.level,
        }
      end
      .shuffle
  end

  def produces(building)
    planet_building = planet.buildings.find_by(blueprint_id: building.blueprint_id)
    if planet_building.level >= building.level
      0.0
    else
      1.0/0
    end
  end
end
