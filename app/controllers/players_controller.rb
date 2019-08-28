class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def create
    player = Player.create player_params
    redirect_to player
  end

  def show
    set_player
  end

  def advisor
    set_player
    @advisor = Advisor.new(@player)
  end

  def building_advisor
    set_player
    @advisor = BuildingAdvisor.new(@player)
    render :advisor
  end

  def research_advisor
    set_player
    @advisor = ResearchAdvisor.new(@player)
    render :advisor
  end

  def artillery_advisor
    set_player
    @advisor = ArtilleryAdvisor.new(@player)
    render :advisor
  end

  def set_player
    @player = Player
      .includes(
        planets: {buildings: :blueprint}
      )
      .find_by id: params[:id]
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
