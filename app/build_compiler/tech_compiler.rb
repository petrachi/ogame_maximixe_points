class TechCompiler < PlanetCompiler
  attr_accessor :player

  def initialize planet
    self.player = planet.player
    self.planet = planet
    self.building = player.researches[blueprint_name.to_s]

    self.build = Build.find_or_create_by(uid: uid)

    unless build.compiled?
      build.update compiled: true, **compile_produces_and_costs
    end

    self.index = 1.0 / 0
    self.percentage = 0
    self.warnings = []
  end

  def type
    :tech
  end

  def blueprint_name
    "#{ ressource }_tech"
  end

  def uid
    "#{ blueprint_name } #{ building.level }"
  end

  def compile_costs
    building.costs modifiers: {level: 1}
  end
end
