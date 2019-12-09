# TODO

Attack
-1:5
-1:9
-1:14

-3:216
-3:264 (big)
-3:277

-5:391 (meduim x3)
-5:395
-5:399
-5:400 (medium)
-5:401 (medium)
-5:404 (medium)
-5:406 (medium)
-5:407
-5:408
-5:409
-5:412 (medium)
-5:413
-5:415
-5:417
-5:420
-5:421 (meduim)
-5:422 (meduim)
-5:425
-5:437
-5:448 (medium)

## improve

- les défenses ne se recalculent pas quand on améliore les military tech (elles devraient)

- ajouter les small/big shield dans les blueprints
- Et ajouter le silo de missile et les missiles dans les blueprints
- Pour pouvoir les construire et qu'ils soient pris en compte dans le ratio global (même si la diff sera pas énorme)

- perf :
- il y a encore des 'planet.produces' qui sont call au moment du best_builds
- ils semblent être liés au production advisor, sans doute au moment du calcul des warnings
- '--'
- on pourrait precompiler (à la maniere des 'builds') le ratio/differential_ratio du player. ça ferait gagner environ 2sec
- '--'
- Le cumulative costs peut être amélioré :
- au lieu de faire itérativement calcul.lvl1 + calcul.lvl2 + calcul.lvl3
- on peut utiliser la formule : x = 1.5; p (12*x**0 + 12*x**1 + 12*x**2 + 12*x**3); p 12*((1-x**4) / (1-x))
- https://en.wikipedia.org/wiki/Geometric_series
- pour directement calculer le coût total
- on peut vouloir le faire dans le code
- ou bien écrire un nouveau type d'effet ? (et intégrer cumulative comme tout les autres)

- probleme avec le calcul des mines
- si j'ai 1 bat 'M' qui coute 100 de metal et produit 100 de metal
- et 1 bat 'C' qui coute 100 de cristal et produit 100 de cristal
- le player produit 100 de metal et 50 de cristal
- le bat 'M' aura un time index de 1, pour une prod de 100
- alors que le bat 'C' aura un time index de 2 pour une prod de 100
- donc le nat 'M' sera avantagé alors que l'investissement est de 1:1 dans les deux cas
- autre exemple, les bat 'M' et 'C' poutent 100 metal + 100 cristal
- ils auront le même time index
- mais le ratio du player est à 60%/30%/10%
- donc le cristal est une ressource 'plus rare' que le metal
- donc le bat 'C' qui produit 100 de cristal devrait être favorisé au bat 'M' qui produit 100 de metal
- actuellement ça n'est pas le cas
- pour corriger :
- on pourrait calculer le taux d'échange des ressources à partir du ratio actuel (est-ce qu'on doit se baser sur le cumulative_costs ou sur le produces ???)
- et augmenter les ressources 'plus rare'
- dans l'exemple précédent, on a un ratio de 6/3/1 de production
- donc 1/2/6 de ratio d'échange
- donc les 100 de cristal produit valent 200 de metal
- '--'
- Le probléme précédent peut aussi être appliqué sur l'astrphisique
- car si je produit beaucoup de metal, le 'produces' des planetes va augmenter, favorisant l'index de la recherche
- et la recherche astro pourrait être préférable à une mine de cristal
- alors que, pour le cristal, l'index total de l'astro ne reflete pas l'intérêt réel d'une planet en plus, car il est boosté par la prod de metal
- '--'
- même remarque pour la recherche 'plasma'; et en gros tout ce qui concerne le production advisor

- il faut faire le CSS des inputs des ships

- controllers building & research can be simplified now that we don't calculate planet holds
- We don't use 'metal/cristal/deut' on planets anymore, so we should delete these fields, and the 'holds' method, and the 'produces since last'

- add hyperspace tech for shipping space

- add level for 'sustains' & 'damages'; only costs can be cumulated
- so a level 4 missile launcher will sustain 2_000 * 4; but costs M2000; just like mines, it chows its total benefice, but only this level cost

- for the uid, use more inteligent method
- either use a building list
- or best, use things like 'planet.stocks' (for artillery), 'player.produces.slice(:metal)' etc
- with this last proposition, we could also benefit from memoizing these methods in player and planet models
