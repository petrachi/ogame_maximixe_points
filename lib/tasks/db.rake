namespace :db do
  desc "TODO"
  task dump: :environment do
    File.open(Rails.root.join("db", "seeds", 'fixtures.rb'), 'w+') do |f|
      Player.find_each do |player|
        f << %Q(
          player = Player.create(name: '#{ player.name }')
        )

        player.researches.order(:id).each do |research|
          f << %Q(
            player.researches.create(blueprint: Blueprint['#{ research.blueprint.name }'], level: #{ research.level })
          )
        end

        player.planets.order(:id).each do |planet|
          f << %Q(
            planet = player.planets.create(name: '#{ planet.name }', temperature: #{ planet.temperature }, size: #{ planet.size })
          )

          planet.buildings.order(:id).each do |building|
            f << %Q(
              planet.buildings.create(blueprint: Blueprint['#{ building.blueprint.name }'], level: #{ building.level })
            )
          end
        end
      end
    end

    # me = Player.create(name: 'yoyo rapido')
    #
    # my_planets = Planet.create([
    #   {player: me, name: 'Artemis', temperature: 81},
    #   {player: me, name: 'Cassini', temperature: 53},
    #   {player: me, name: 'Europe', temperature: 67},
    #   {player: me, name: 'Eris', temperature: 75},
    #   {player: me, name: 'Ariane', temperature: 28},
    #   {player: me, name: 'Nyx', temperature: 28},
    # ])
  end

end
