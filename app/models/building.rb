class Building < ApplicationRecord
  belongs_to :planet
  has_one :player, through: :planet
  belongs_to :blueprint

  def produces(modifiers: {})
    blueprint.produces(
      level: level + modifiers.fetch(:level, 0),
      temperature: planet.temperature + modifiers.fetch(:temperature, 0),
      energy_tech: player.researches['energy_tech'].level + modifiers.fetch(:energy_tech, 0),
      plasma_tech: player.researches['plasma_tech'].level + modifiers.fetch(:plasma_tech, 0),
    )
  end

  def stocks modifiers: {}
    blueprint.stocks(level: level + modifiers.fetch(:level, 0))
  end

  def costs modifiers: {}
    blueprint.costs(
      level: level + modifiers.fetch(:level, 0),
    )
  end
end
