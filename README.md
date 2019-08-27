# TODO

### Create

- shipping advisor

## improve

- add the 3 armor/shield/weapon researchs
  - todo: la production de ça est égale au cout des défenses * somme des trois recherches / 10
  - (chaque recher augmente le cout/prodcution de 10%)
- le calcul de la défense
  - au lieu de calculer combien on doit construire par rapport à une temps fixe de production
  - on pourrait calculer le coût en MIP pour détruire toute la défense, et construire autant de défense que le nombre de MIP équivalent à la moitié du stockage.
  - comme ça on calcule la "rentabilité" d'une attaque
- add hyperspace tech for shipping space

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
