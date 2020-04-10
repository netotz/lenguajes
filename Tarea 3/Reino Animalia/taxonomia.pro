tipo('pandion haliaetus', especie).
tipo('gypaetus barbatus', especie).
tipo('aix galericulata', especie).
tipo('crocodylus porosus', especie).
tipo('melanosuchus niger', especie).
tipo('chamaeleo calyptratus', especie).
tipo('boa constrictor', especie).
tipo('hiatella arctica', especie).
tipo('margaritifera margaritifera', especie).
tipo('hedleya macleayi', especie).
tipo('haliotis pourtalesii', especie).
tipo('nautilus belauensis', especie).
tipo('doryteuthis pealeii', especie).
tipo('androctonus bicolor', especie).
tipo('scorpio maurus', especie).
tipo('heptathela kimurai', especie).
tipo('loxosceles laeta', especie).
tipo('apis mellifera', especie).
tipo('solenopsis invicta', especie).
tipo('adalia bipunctata', especie).
tipo(adalia, genero).
tipo(solenopsis, genero).
tipo(apis, genero).
tipo(loxosceles, genero).
tipo(heptathela, genero).
tipo(pandion, genero).
tipo(gypaetus, genero).
tipo(aix, genero).
tipo(crocodylus, genero).
tipo(melanosuchus, genero).
tipo(chamaeleo, genero).
tipo(boa, genero).
tipo(hiatella, genero).
tipo(margaritifera, genero).
tipo(hedleya, genero).
tipo(haliotis, genero).
tipo(nautilus, genero).
tipo(doryteuthis, genero).
tipo(androctonus, genero).
tipo(scorpio, genero).
tipo(coccinellidae, familia).
tipo(formicidae, familia).
tipo(apidae, familia).
tipo(sicariidae, familia).
tipo(liphistiidae, familia).
tipo(scorpionidae, familia).
tipo(buthidae, familia).
tipo(loliginidae, familia).
tipo(nautilidae, familia).
tipo(haliotidae, familia).
tipo(pupinidae, familia).
tipo(margaritiferidae, familia).
tipo(hiatellidae, familia).
tipo(boidae, familia).
tipo(chamaeleonidae, familia).
tipo(alligatoridae, familia).
tipo(pandionidae, familia).
tipo(accipitridae, familia).
tipo(anatidae, familia).
tipo(crocodylidae, familia).
tipo(coleoptera, orden).
tipo(hymenoptera, orden).
tipo(araneae, orden).
tipo(scorpiones, orden).
tipo(myopsida, orden).
tipo(nautilida, orden).
tipo(archaeogastropoda, orden).
tipo(mesogastropoda, orden).
tipo(unionoida, orden).
tipo(myoida, orden).
tipo(accipitriformes, orden).
tipo(anseriformes, orden).
tipo(crocodylia, orden).
tipo(squamata, orden).
tipo(insecta, clase).
tipo(arachnida, clase).
tipo(cephalopoda, clase).
tipo(gastropoda, clase).
tipo(bivalvia, clase).
tipo(aves, clase).
tipo(sauropsida, clase).
tipo(arthropoda, filo).
tipo(mollusca, filo).
tipo(chordata, filo).
tipo(animalia, reino).

subdivision('pandion haliaetus',pandion).
 subdivision(pandion,pandionidae).
  subdivision(pandionidae,accipitriformes).
subdivision('gypaetus barbatus',gypaetus).
 subdivision(gypaetus,accipitridae).
  subdivision(accipitridae,accipitriformes).
   subdivision(accipitriformes, aves).
subdivision('aix galericulata', aix).
 subdivision(aix, anatidae).
  subdivision(anatidae, anseriformes).
   subdivision(anseriformes, aves).
    subdivision(aves, chordata).
subdivision('crocodylus porosus', crocodylus).
 subdivision(crocodylus, crocodylidae).
  subdivision(crocodylidae, crocodylia).
subdivision('melanosuchus niger', melanosuchus).
 subdivision(melanosuchus, alligatoridae).
  subdivision(alligatoridae, crocodylia).
   subdivision(crocodylia, sauropsida).
subdivision('chamaeleo calyptratus', chamaeleo).
 subdivision(chamaeleo, chamaeleonidae).
  subdivision(chamaeleonidae, squamata).
subdivision('boa constrictor', boa).
 subdivision(boa, boidae).
  subdivision(boidae, squamata).
   subdivision(squamata, sauropsida).
    subdivision(sauropsida, chordata).
     subdivision(chordata, animalia).
subdivision('hiatella arctica', hiatella).
 subdivision(hiatella, hiatellidae).
  subdivision(hiatellidae, myoida).
   subdivision(myoida, bivalvia).
subdivision('margaritifera margaritifera', margaritifera).
 subdivision(margaritifera, margaritiferidae).
  subdivision(margaritiferidae, unionoida).
   subdivision(unionoida, bivalvia).
    subdivision(bivalvia, mollusca).
subdivision('hedleya macleayi', hedleya).
 subdivision(hedleya, pupinidae).
  subdivision(pupinidae, mesogastropoda).
   subdivision(mesogastropoda, gastropoda).
subdivision('haliotis pourtalesii', haliotis).
 subdivision(haliotis, haliotidae).
  subdivision(haliotidae, archaeogastropoda).
   subdivision(archaeogastropoda, gastropoda).
    subdivision(gastropoda, mollusca).
subdivision('nautilus belauensis', nautilus).
 subdivision(nautilus, nautilidae).
  subdivision(nautilidae, nautilida).
   subdivision(nautilida, cephalopoda).
subdivision('doryteuthis pealeii', doryteuthis).
 subdivision(doryteuthis, loliginidae).
  subdivision(loliginidae, myopsida).
   subdivision(myopsida, cephalopoda).
    subdivision(cephalopoda, mollusca).
     subdivision(mollusca, animalia).
subdivision('androctonus bicolor', androctonus).
 subdivision(androctonus, buthidae).
  subdivision(buthidae, scorpiones).
subdivision('scorpio maurus', scorpio).
 subdivision(scorpio, scorpionidae).
  subdivision(scorpionidae, scorpiones).
   subdivision(scorpiones, arachnida).
subdivision('heptathela kimurai', heptathela).
 subdivision(heptathela, liphistiidae).
  subdivision(liphistiidae, araneae).
subdivision('loxosceles laeta', loxosceles).
 subdivision(loxosceles, sicariidae).
  subdivision(sicariidae, araneae).
   subdivision(araneae, arachnida).
    subdivision(arachnida, arthropoda).
subdivision('apis mellifera', apis).
 subdivision(apis, apidae).
  subdivision(apidae, hymenoptera).
subdivision('solenopsis invicta', solenopsis).
 subdivision(solenopsis, formicidae).
  subdivision(formicidae, hymenoptera).
   subdivision(hymenoptera, insecta).
subdivision('adalia bipunctata', adalia).
 subdivision(adalia, coccinellidae).
  subdivision(coccinellidae, coleoptera).
   subdivision(coleoptera, insecta).
    subdivision(insecta, arthropoda).
     subdivision(arthropoda, animalia).

sup(A,B) :- subdivision(B,A).
sup(A,C) :- subdivision(B,A), sup(B,C).
inf(X,Y) :- subdivision(X,Y).
inf(X,Y) :- subdivision(X,Y), inf(X,Y).

pertenecen(A,B) :- subdivision(A,X), subdivision(B,X).

coinciden(A,B) :-
	A == B, write("Solo buscar entre diferentes individuos"), !;
    sup(X,A), sup(X,B),
    write("\n\tCoinciden en "),
    tipo(X,Y), write(Y), write(" "),
    write(X), nl, !.