class BuildingsController < ApplicationController
  def increment_level
    set_building
    @building.update! level: @building.level + 1
    @building.planet.update_ressources! @building.costs.map{ |k, v| [k, -v] }.to_h
    redirect_to @building.planet.player
  end

  def set_building
    @building = Building.find_by id: params[:id]
  end
end
