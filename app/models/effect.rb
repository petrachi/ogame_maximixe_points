class Effect < ApplicationRecord
  belongs_to :blueprint
  has_many :buildings, through: :blueprint

  def ressource
    self[:ressource].to_sym
  end

  def effect
    self[:effect].to_sym
  end

  def quantity_for **options
    quantity = self.quantity.dup
    quantity.gsub!(/{(\w*)}/){ |match| options.with_indifferent_access.fetch($1, 0) }
    eval quantity
  end
end
