class ResearchesController < ApplicationController
  def increment_level
    set_research
    # set_planet

    params[:increment].to_i.times &method(:increment_one_level)

    redirect_back(fallback_location: player_path(@research.player))
  end

  def upto_level
    set_research
    # set_planet

    (@research.level + 1).upto params[:upto].to_i, &method(:increment_one_level)

    redirect_back(fallback_location: player_path(@research.player))
  end

  def set_research
    @research = Research.find_by id: params[:id]
  end

  # def set_planet
  #   @planet = Planet.find_by id: params[:planet_id]
  # end

  def increment_one_level *_
    @research.update! level: @research.level + 1
    # @planet.update_ressources! @research.costs.map{ |k, v| [k, -v] }.to_h
  end
end
