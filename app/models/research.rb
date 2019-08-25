class Research < ApplicationRecord
  belongs_to :player
  belongs_to :blueprint

  def produces(modifiers: {})
    blueprint.produces(level: level + modifiers.fetch(:level, 0))
  end

  def stocks modifiers: {}
    blueprint.stocks(level: level + modifiers.fetch(:level, 0))
  end

  def costs modifiers: {}
    blueprint.costs(level: level + modifiers.fetch(:level, 0))
  end
end
