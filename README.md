# TODO

### Create

- shipping advisor

## improve

- add hyperspace tech for shipping space

- costs for military tech is broken
  - le 'produces' des tech militaires représente un stock fixe qu'on a pas à dépenser
  - il ne représente pas une 'production'; ce qui fait que l'index n'est pas du tout comparable aux autres
  - pour faire mieux il faudrait
  - calculer l'économie que fait faire la tech
  - calculer combien on pourrait produire grâce à cette économie
  - on peut aussi les traiter différement du reste des advisor
    - ça c'est une réflexion plus compléte qui concerne aussi les stockages et la défense. Mais possiblement ces batiments / recherches qui ne produisent pas directement, on pourrait vouloir les calculer autrement
  - pour l'instant je les enléve du calcul

- costs for astrophysics is broken
  - the costs of player actually calculated for mines is only the last level, not the addition of all levels
  - so the costs is underestimated

- We don't use 'metal/cristal/deut' on planets anymore, so we should delete these fields, and the 'holds' method, and the 'produces since last'

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
  - todo: calc shippings
  - todo: return shippings and recommended buildings
