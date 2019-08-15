class BuildingEffect < ApplicationRecord
  belongs_to :building

  def quantity_for level: 0
    eval quantity.gsub('{level}', level.to_s)
  end
end
