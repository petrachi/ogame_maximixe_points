# TODO

### Create

- energy advisor
- shipping advisor
- defense advisor
- research advisor

## improve

- add enrgy production in calc for production
- add plasma tech for production effects
- add hyperspace tech for shipping space
- allow to research reasearchs on planets

- costs calculator
  - OK: calc costs for each build
  - ok: calc produces for each building
    - ok: storage produces is how much production is lost due to storage
    - ok: energy produces is how much production is lost due to lack of electricity
    - ok: building produces is basic produces taking account of amount of energy left on planet
    - todo: building produces is basic produces taking account of amount of amount of storage available

- problem:
  - if we have amout od production == storage
  - then mine production will be at 0 cause it will not be able to stock
  - but storage production will be at 0 cause there is no lost production to stock
  - so none of these buildings will be recommended to build

  - i think there is something similar with energy
  - if energy_total == 0
  - cause mine production will be none if there is not enought energy (like crsital mine)
  - but energy production will be 0 too cause nothing demands more energy
  - (today, only metal mine icrease production when there is not energy, but it is a very small gain, so it seems a not very good investment)

- advisor
  - ok: get buildings to build
  - ok: calc costs_for_one
  - ok: calc time index
  - ok: order by time index
  - todo: filter one building by planet
  - todo: calc shippings
  - todo: return shippings and recommended buildings
