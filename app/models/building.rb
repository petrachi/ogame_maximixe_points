class Building < ApplicationRecord
  belongs_to :planet
  belongs_to :blueprint
  has_many :building_effects, through: :blueprint

  def produces(modifiers: {})
    blueprint.produces(
      level: level + modifiers.fetch(:level, 0),
      temperature: planet.temperature,
      energy_tech: 8
    )
  end

  def stocks modifiers: {}
    blueprint.stocks(level: level + modifiers.fetch(:level, 0))
  end

  def costs modifiers: {}
    blueprint.costs(level: level + modifiers.fetch(:level, 0))
  end
end
