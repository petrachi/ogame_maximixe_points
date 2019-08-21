class BuildingsController < ApplicationController
  def increment_level
    set_building

    (@building.level + 1).upto(params[:upto].to_i) do
      @building.update! level: @building.level + 1
      @building.planet.update_ressources! @building.costs.map{ |k, v| [k, -v] }.to_h
    end

    redirect_back(fallback_location: player_path(@building.planet.player))
  end

  def set_building
    @building = Building.find_by id: params[:id]
  end
end
