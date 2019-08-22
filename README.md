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

- in advisor :
  - move 'index' calculation (actually in product_costs_calculator) into advisor
  - calculate an index for each buildings (production, energy, storage)
  - index for storage is costs / how much production is lost due to storage
  - index for energy is costs / how much production is lost due to lack of electricity
  - index for production buildings is infite if enery is negative on planet

- costs calculator
  - calc costs for each build
  - calc produces for each building
  - calc costs_for one for each building
    - storage produces is how much production is lost due to storage
    - energy produces is how much production is lost due to lack of electricity
    - building produces is basic produces taking account of amount of energy left on planet
- advisor
  - get buildings to build
    - production return all mines
    - energy return best building if planet needs energy
    - storage return storage building if needs storage
  - with costs_for_one
  - calc time index
  - order by time index
  - filter one building by planet
  - calc shippings
  - return shippings and recommended buildings
