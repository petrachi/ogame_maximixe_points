# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



me = Player.create(name: 'yoyo rapido')

my_planets = Planet.create([
  {player: me, name: 'Artemis'},
  {player: me, name: 'Cassini'},
  {player: me, name: 'Europe'},
  {player: me, name: 'Eris'},
  {player: me, name: 'Ariane'},
])

buildings = Building.create([
  {name: 'metal_mine'},
])

building_effects = BuildingEffect.create([
  {
    building: Building['metal_mine'],
    effect: 'produces',
    ressource: 'metal',
    quantity: '210 * {level} * 1.1**{level}'
  },
  {
    building: Building['metal_mine'],
    effect: 'costs',
    ressource: 'metal',
    quantity: '60 * 1.5**({level} - 1)'
  },
  {
    building: Building['metal_mine'],
    effect: 'costs',
    ressource: 'cristal',
    quantity: '15 * 1.5**({level} - 1)'
  },
  {
    building: Building['metal_mine'],
    effect: 'costs',
    ressource: 'energy',
    quantity: '10 * {level} * 1.1**{level}'
  },
])

my_buildings = BuildingLevel.create([
  {
    planet: Planet['Artemis'],
    building: Building['metal_mine'],
    level: 20,
  },
])
