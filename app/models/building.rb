class Building < ApplicationRecord
  has_many :building_effects
  has_many :building_levels
  has_many :planets, through: :building_levels

  def self.[] value
    find_by(name: value)
  end
end
