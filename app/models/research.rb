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

  def cumulative_costs modifiers: {}
    1.upto(level + modifiers.fetch(:level, 0)).each_with_object({}) do |level, acc|
      acc.merge! blueprint.costs(level: level), &merge_proc(:+)
    end
  end
end
