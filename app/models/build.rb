class Build < ApplicationRecord
  store_accessor :costs

  def costs
    super.each_with_object({}) do |(ressource, cost), acc|
      acc[ressource.to_sym] = cost.to_f
    end
  end
end
