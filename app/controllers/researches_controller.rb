class ResearchesController < ApplicationController
  def increment_level
    set_research
    set_planet

    (@research.level + 1).upto(params[:upto].to_i) do
      @research.update! level: @research.level + 1
      @planet.update_ressources! @research.costs.map{ |k, v| [k, -v] }.to_h
    end

    redirect_back(fallback_location: player_path(@planet.player))
  end

  def set_research
    @research = Research.find_by id: params[:id]
  end

  def set_planet
    @planet = Planet.find_by id: params[:planet_id]
  end
end
