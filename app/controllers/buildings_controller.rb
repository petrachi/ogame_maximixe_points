class BuildingsController < ApplicationController
  def increment_level
    set_building

    @building.update! level: @building.level + params[:increment].to_i
    # params[:increment].to_i.times &method(:increment_one_level)

    # do
    #   @building.update! level: @building.level + 1
    #   @building.planet.update_ressources! @building.costs.map{ |k, v| [k, -v] }.to_h
    # end

    redirect_back(fallback_location: player_path(@building.planet.player))
  end

  def upto_level
    set_building

    @building.update! level: params[:upto].to_i

    # (@building.level + 1).upto params[:upto].to_i, &method(:increment_one_level)

    # do
    #   @building.update! level: @building.level + 1
    #   @building.planet.update_ressources! @building.costs.map{ |k, v| [k, -v] }.to_h
    # end

    redirect_back(fallback_location: player_path(@building.planet.player))
  end

  def set_building
    @building = Building.find_by id: params[:id]
  end

  # def increment_one_level *_
  #   @building.update! level: @building.level + 1
  #   # @building.planet.update_ressources! @building.costs.map{ |k, v| [k, -v] }.to_h
  # end
end
