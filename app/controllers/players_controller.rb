class PlayersController < ApplicationController
  def index
    render :index, locals: {players: Player.all}
  end

  def create
    player = Player.create player_params
    planet = player.planets.create(name: "Planète mére", temperature: 81, size: 193)
    Blueprint.where('name ~* ?', /^.*_tech$/.source).each do |blueprint|
      player.researches.create(blueprint: blueprint, level: 0)
    end
    Blueprint.where('name ~* ?', /^((?!tech|rocket).)*$/.source).each do |blueprint|
      planet.buildings.create(blueprint: blueprint, level: 0)
    end

    redirect_to player
  end

  def show
    render :show, locals: {player: find_player}
  end

  def edit
    render :edit, locals: {player: find_player}
  end

  def update
    player = find_player
    player.update! player_params

    player.researches.includes(:blueprint).each do |research|
      research.update level: params[research.blueprint.name].to_i
    end

    redirect_to player
  end

  def advisor
    @player = find_player
    @advisor = Advisor.new(@player)
  end

  def building_advisor
    @player = find_player
    @advisor = BuildingAdvisor.new(@player)
    render :advisor
  end

  def research_advisor
    @player = find_player
    @advisor = ResearchAdvisor.new(@player)
    render :advisor
  end

  def artillery_advisor
    @player = find_player
    @advisor = ArtilleryAdvisor.new(@player)
    render :advisor
  end

  def find_player
    Player.find_by id: params[:id]
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
