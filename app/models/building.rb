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

  def cumulative_costs modifiers: {}
    1.upto(level + modifiers.fetch(:level, 0)).each_with_object({}) do |level, acc|
      acc.merge! blueprint.costs(level: level), &merge_proc(:+)
    end
  end

  def sustains modifiers: {}
    blueprint.sustains(
      level: level + modifiers.fetch(:level, 0),
      military_tech: player.researches['armor_tech'].level + player.researches['weapon_tech'].level + player.researches['shield_tech'].level + modifiers.fetch(:military_tech, 0),
    )
  end

  def cumulative_sustains modifiers: {}
    1.upto(level + modifiers.fetch(:level, 0)).each_with_object({}) do |level, acc|
      acc.merge!(
        blueprint.sustains(
          level: level,
          military_tech: player.researches['armor_tech'].level + player.researches['weapon_tech'].level + player.researches['shield_tech'].level + modifiers.fetch(:military_tech, 0),
        ),
        &merge_proc(:+)
      )
    end
  end

  def damages modifiers: {}
    blueprint.damages(
      level: level + modifiers.fetch(:level, 0),
      military_tech: player.researches['armor_tech'].level + player.researches['weapon_tech'].level + player.researches['shield_tech'].level + modifiers.fetch(:military_tech, 0),
    )
  end
end
