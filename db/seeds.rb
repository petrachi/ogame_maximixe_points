# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

blueprints = Blueprint.create([
  {name: 'metal_mine'},
  {name: 'cristal_mine'},
  {name: 'deuterium_mine'},
  {name: 'solar_plant'},
  {name: 'fusion_plant'},
  {name: 'metal_storage'},
  {name: 'cristal_storage'},
  {name: 'deuterium_storage'},
  {name: 'robots_factory'},
  {name: 'ships_factory'},
  {name: 'research_factory'},
  {name: 'nanite_factory'},
  {name: 'energy_tech'},
  {name: 'laser_tech'},
  {name: 'ion_tech'},
  {name: 'hyperspace_tech'},
  {name: 'plasma_tech'},
  {name: 'combustion_engine_tech'},
  {name: 'impulsion_engine_tech'},
  {name: 'hyperspace_engine_tech'},
  {name: 'spy_tech'},
  {name: 'computer_tech'},
  {name: 'astrophysics_tech'},
  {name: 'intergalactic_tech'},
  {name: 'weapon_tech'},
  {name: 'shield_tech'},
  {name: 'armor_tech'},
  {name: 'missile_artillery'},
  {name: 'laser_artillery'},
  {name: 'heavy_laser_artillery'},
  {name: 'gauss_artillery'},
  {name: 'ion_artillery'},
  {name: 'plasma_artillery'},
])

effects = Effect.create([
  {
    blueprint: Blueprint['metal_mine'],
    effect: 'produces',
    ressource: 'metal',
    quantity: '210 + (210 * {level} * 1.1**{level} * (1 + {plasma_tech}/100.0))'
  },
  {
    blueprint: Blueprint['metal_mine'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '60 * 1.5**({level} - 1)'
  },
  {
    blueprint: Blueprint['metal_mine'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '15 * 1.5**({level} - 1)'
  },
  {
    blueprint: Blueprint['metal_mine'],
    effect: 'produces',
    ressource: 'energy',
    quantity: '-10 * {level} * 1.1**{level}'
  },
  {
    blueprint: Blueprint['cristal_mine'],
    effect: 'produces',
    ressource: 'cristal',
    quantity: '105 + (140 * {level} * 1.1**{level} * (1 + {plasma_tech} * 0.66 / 100.0))'
  },
  {
    blueprint: Blueprint['cristal_mine'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '48 * 1.6**({level} - 1)'
  },
  {
    blueprint: Blueprint['cristal_mine'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '24 * 1.6**({level} - 1)'
  },
  {
    blueprint: Blueprint['cristal_mine'],
    effect: 'produces',
    ressource: 'energy',
    quantity: '-10 * {level} * 1.1**{level}'
  },
  {
    blueprint: Blueprint['deuterium_mine'],
    effect: 'produces',
    ressource: 'deuterium',
    quantity: '(70 * {level} * 1.1**{level}) * (-0.004 * {temperature} + 1.44) * (1 + {plasma_tech} * 0.33 / 100.0)'
  },
  {
    blueprint: Blueprint['deuterium_mine'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '225 * 1.5**({level} - 1)'
  },
  {
    blueprint: Blueprint['deuterium_mine'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '75 * 1.5**({level} - 1)'
  },
  {
    blueprint: Blueprint['deuterium_mine'],
    effect: 'produces',
    ressource: 'energy',
    quantity: '-20 * {level} * 1.1**{level}'
  },
  {
    blueprint: Blueprint['solar_plant'],
    effect: 'produces',
    ressource: 'energy',
    quantity: '20 * {level} * 1.1**{level}'
  },
  {
    blueprint: Blueprint['solar_plant'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '75 * 1.5**({level} - 1)'
  },
  {
    blueprint: Blueprint['solar_plant'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '30 * 1.5**({level} - 1)'
  },
  {
    blueprint: Blueprint['fusion_plant'],
    effect: 'produces',
    ressource: 'energy',
    quantity: '30 * {level} * (1.05 + {energy_tech}/100.0)**{level}'
  },
  {
    blueprint: Blueprint['fusion_plant'],
    effect: 'produces',
    ressource: 'deuterium',
    quantity: '-70 * {level} * 1.1**{level}'
  },
  {
    blueprint: Blueprint['fusion_plant'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '900 * 1.8**({level} - 1)'
  },
  {
    blueprint: Blueprint['fusion_plant'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '360 * 1.8**({level} - 1)'
  },
  {
    blueprint: Blueprint['fusion_plant'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '180 * 1.8**({level} - 1)'
  },
  {
    blueprint: Blueprint['metal_storage'],
    effect: 'stocks',
    ressource: 'metal',
    quantity: '5000 * (2.5 * 2.71828**(20 * {level} / 33.0)).floor'
  },
  {
    blueprint: Blueprint['metal_storage'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '500 * 2**{level}'
  },
  {
    blueprint: Blueprint['cristal_storage'],
    effect: 'stocks',
    ressource: 'cristal',
    quantity: '5000 * (2.5 * 2.71828**(20 * {level} / 33.0)).floor'
  },
  {
    blueprint: Blueprint['cristal_storage'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '500 * 2**{level}'
  },
  {
    blueprint: Blueprint['cristal_storage'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '250 * 2**{level}'
  },
  {
    blueprint: Blueprint['deuterium_storage'],
    effect: 'stocks',
    ressource: 'deuterium',
    quantity: '5000 * (2.5 * 2.71828**(20 * {level} / 33.0)).floor'
  },
  {
    blueprint: Blueprint['deuterium_storage'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '500 * 2**{level}'
  },
  {
    blueprint: Blueprint['deuterium_storage'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '500 * 2**{level}'
  },
  {
    blueprint: Blueprint['robots_factory'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '200 * 2**{level}'
  },
  {
    blueprint: Blueprint['robots_factory'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '60 * 2**{level}'
  },
  {
    blueprint: Blueprint['robots_factory'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['ships_factory'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '200 * 2**{level}'
  },
  {
    blueprint: Blueprint['ships_factory'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['ships_factory'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '50 * 2**{level}'
  },
  {
    blueprint: Blueprint['research_factory'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['research_factory'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '200 * 2**{level}'
  },
  {
    blueprint: Blueprint['research_factory'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['nanite_factory'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '500_000 * 2**{level}'
  },
  {
    blueprint: Blueprint['nanite_factory'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '250_000 * 2**{level}'
  },
  {
    blueprint: Blueprint['nanite_factory'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '50_000 * 2**{level}'
  },
  {
    blueprint: Blueprint['energy_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '400 * 2**{level}'
  },
  {
    blueprint: Blueprint['energy_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '200 * 2**{level}'
  },
  {
    blueprint: Blueprint['laser_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['laser_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '50 * 2**{level}'
  },
  {
    blueprint: Blueprint['ion_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '500 * 2**{level}'
  },
  {
    blueprint: Blueprint['ion_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '150 * 2**{level}'
  },
  {
    blueprint: Blueprint['ion_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '50 * 2**{level}'
  },
  {
    blueprint: Blueprint['hyperspace_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '2000 * 2**{level}'
  },
  {
    blueprint: Blueprint['hyperspace_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '1000 * 2**{level}'
  },
  {
    blueprint: Blueprint['plasma_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '1000 * 2**{level}'
  },
  {
    blueprint: Blueprint['plasma_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '2000 * 2**{level}'
  },
  {
    blueprint: Blueprint['plasma_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '500 * 2**{level}'
  },
  {
    blueprint: Blueprint['combustion_engine_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '200 * 2**{level}'
  },
  {
    blueprint: Blueprint['combustion_engine_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '300 * 2**{level}'
  },
  {
    blueprint: Blueprint['impulsion_engine_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '1000 * 2**{level}'
  },
  {
    blueprint: Blueprint['impulsion_engine_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '2000 * 2**{level}'
  },
  {
    blueprint: Blueprint['impulsion_engine_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '300 * 2**{level}'
  },
  {
    blueprint: Blueprint['hyperspace_engine_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '5000 * 2**{level}'
  },
  {
    blueprint: Blueprint['hyperspace_engine_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '10_000 * 2**{level}'
  },
  {
    blueprint: Blueprint['hyperspace_engine_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '3000 * 2**{level}'
  },
  {
    blueprint: Blueprint['spy_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['spy_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '500 * 2**{level}'
  },
  {
    blueprint: Blueprint['spy_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['computer_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '200 * 2**{level}'
  },
  {
    blueprint: Blueprint['computer_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '300 * 2**{level}'
  },
  {
    blueprint: Blueprint['astrophysics_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '4000 * 1.75**({level} - 1)'
  },
  {
    blueprint: Blueprint['astrophysics_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '8000 * 1.75**({level} - 1)'
  },
  {
    blueprint: Blueprint['astrophysics_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '4000 * 1.75**({level} - 1)'
  },
  {
    blueprint: Blueprint['intergalactic_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '120_000 * 2**{level}'
  },
  {
    blueprint: Blueprint['intergalactic_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '200_000 * 2**{level}'
  },
  {
    blueprint: Blueprint['intergalactic_tech'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '80_000 * 2**{level}'
  },
  {
    blueprint: Blueprint['weapon_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '400 * 2**{level}'
  },
  {
    blueprint: Blueprint['weapon_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['shield_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '100 * 2**{level}'
  },
  {
    blueprint: Blueprint['shield_tech'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '300 * 2**{level}'
  },
  {
    blueprint: Blueprint['armor_tech'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '500 * 2**{level}'
  },
  {
    blueprint: Blueprint['missile_artillery'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '2000 * {level}'
  },
  {
    blueprint: Blueprint['laser_artillery'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '1500 * {level}'
  },
  {
    blueprint: Blueprint['laser_artillery'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '500 * {level}',
  },
  {
    blueprint: Blueprint['heavy_laser_artillery'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '6000 * {level}'
  },
  {
    blueprint: Blueprint['heavy_laser_artillery'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '2000 * {level}'
  },
  {
    blueprint: Blueprint['gauss_artillery'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '20_000 * {level}'
  },
  {
    blueprint: Blueprint['gauss_artillery'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '15_000 * {level}'
  },
  {
    blueprint: Blueprint['gauss_artillery'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '2000 * {level}'
  },
  {
    blueprint: Blueprint['ion_artillery'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '2000 * {level}'
  },
  {
    blueprint: Blueprint['ion_artillery'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '6000 * {level}'
  },
  {
    blueprint: Blueprint['plasma_artillery'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '50_000 * {level}'
  },
  {
    blueprint: Blueprint['plasma_artillery'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '50_000 * {level}'
  },
  {
    blueprint: Blueprint['plasma_artillery'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '30_000 * {level}'
  },
])

me = Player.create(name: 'yoyo rapido')

my_planets = Planet.create([
  {player: me, name: 'Artemis', temperature: 81},
  {player: me, name: 'Cassini', temperature: 53},
  {player: me, name: 'Europe', temperature: 67},
  {player: me, name: 'Eris', temperature: 75},
  {player: me, name: 'Ariane', temperature: 28},
  {player: me, name: 'Nyx', temperature: 28},
])

def create_research_for *levels, player:
  %i[
    energy_tech
    laser_tech
    ion_tech
    hyperspace_tech
    plasma_tech
    combustion_engine_tech
    impulsion_engine_tech
    hyperspace_engine_tech
    spy_tech
    computer_tech
    astrophysics_tech
    intergalactic_tech
    weapon_tech
    shield_tech
    armor_tech
  ].each_with_index do |name, index|
    Research.create(player: player, blueprint: Blueprint[name], level: levels[index])
  end
end

create_research_for 8, 10, 5, 8, 8, 6, 7, 0, 5, 10, 9, 0, 4, 6, 0, player: me

def create_buildings_for *levels, planet:
  %i[
    metal_mine
    cristal_mine
    deuterium_mine
    solar_plant
    fusion_plant
    metal_storage
    cristal_storage
    deuterium_storage
    robots_factory
    ships_factory
    research_factory
    nanite_factory
  ].each_with_index do |name, index|
    Building.create(planet: planet, blueprint: Blueprint[name], level: levels[index])
  end
end

create_buildings_for 26, 20, 15, 24, 10, 9, 7, 4, 10, 6, 7, 1, planet: Planet['Artemis']
create_buildings_for 25, 20, 15, 24, 8, 9, 7, 4, 10, 7, 0, 1, planet: Planet['Cassini']
create_buildings_for 25, 20, 15, 24, 8, 9, 7, 5, 10, 8, 8, 1, planet: Planet['Europe']
create_buildings_for 24, 20, 14, 23, 9, 8, 7, 4, 10, 8, 0, 1, planet: Planet['Eris']
create_buildings_for 25, 21, 14, 24, 8, 9, 7, 4, 10, 8, 0, 1, planet: Planet['Ariane']
create_buildings_for 20, 16, 0, 19, 0, 7, 6, 0, 10, 8, 0, 1, planet: Planet['Nyx']

def create_defenses_for *levels, planet:
  %i[
    missile_artillery
    laser_artillery
    heavy_laser_artillery
    gauss_artillery
    ion_artillery
    plasma_artillery
  ].each_with_index do |name, index|
    Building.create(planet: planet, blueprint: Blueprint[name], level: levels[index])
  end
end

create_defenses_for 1200, 0, 20, 0, 50, 0, planet: Planet['Artemis']
create_defenses_for 1550, 25, 30, 0, 50, 0, planet: Planet['Cassini']
create_defenses_for 1080, 0, 100, 0, 60, 0, planet: Planet['Europe']
create_defenses_for 1025, 50, 0, 0, 15, 0, planet: Planet['Eris']
create_defenses_for 900, 100, 0, 0, 0, 0, planet: Planet['Ariane']
create_defenses_for 0, 0, 25, 0, 0, 0, planet: Planet['Nyx']
