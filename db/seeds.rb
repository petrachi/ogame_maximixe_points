# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



me = Player.create(name: 'yoyo rapido')

my_planets = Planet.create([
  {player: me, name: 'Artemis', temperature: 81},
  {player: me, name: 'Cassini', temperature: 53},
  {player: me, name: 'Europe', temperature: 67},
  {player: me, name: 'Eris', temperature: 75},
  {player: me, name: 'Ariane', temperature: 28},
])

blueprints = Blueprint.create([
  {name: 'metal_mine'},
  {name: 'cristal_mine'},
  {name: 'deuterium_mine'},
  {name: 'solar_plant'},
  {name: 'fusion_plant'},
  {name: 'metal_storage'},
  {name: 'cristal_storage'},
  {name: 'deuterium_storage'},
])

building_effects = BuildingEffect.create([
  {
    blueprint: Blueprint['metal_mine'],
    effect: 'produces',
    ressource: 'metal',
    quantity: '210 * {level} * 1.1**{level}'
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
    quantity: '140 * {level} * 1.1**{level}'
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
    quantity: '(70 * {level} * 1.1**{level}) * (-0.004 * {temperature} + 1.44)'
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
    quantity: '900 * 1.5**({level} - 1)'
  },
  {
    blueprint: Blueprint['fusion_plant'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '360 * 1.5**({level} - 1)'
  },
  {
    blueprint: Blueprint['fusion_plant'],
    effect: 'costs',
    ressource: 'deuterium',
    quantity: '180 * 1.5**({level} - 1)'
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
])

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
  ].each_with_index do |name, index|
    Building.create(planet: planet, blueprint: Blueprint[name], level: levels[index])
  end
end

create_buildings_for 21, 17, 13, 22, 4, 7, 6, 4, planet: Planet['Artemis']
create_buildings_for 21, 17, 13, 21, 4, 7, 6, 4, planet: Planet['Cassini']
create_buildings_for 22, 17, 13, 22, 4, 7, 6, 3, planet: Planet['Europe']
create_buildings_for 20, 16, 12, 20, 4, 7, 5, 3, planet: Planet['Eris']
create_buildings_for 20, 16, 12, 20, 4, 7, 5, 3, planet: Planet['Ariane']
