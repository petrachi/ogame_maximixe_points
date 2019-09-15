# TODO

### Create

- shipping advisor

## improve

- controllers building & research can be simplified now that we don't calculate planet holds

- add military tech to artillery advisor

- astrphysics tech could also benefit from these cumulative costs

- add ships for defense costs

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
