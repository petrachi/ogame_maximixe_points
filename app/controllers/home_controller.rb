class HomeController < ApplicationController
  def index
    @player = Player.find_by(name: 'yoyo rapido')
  end
end
