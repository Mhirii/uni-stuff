
# Ex 2

+ Client ( *id* , nom, prenom, numTel, #addressId )

+ Transporteur ( *id*, name, nom, prenom, numTel, #addressId, coutParKlm )

+ Responsable ( *id*, name, nom, prenom, numTel)

==============================================

+ Livraison ( *id*, #transporteurId, #responsableId, dateLivraison, dateCommande, prix )
+ Commande ( *id*, #clientId, dateCommande, prix )
+ LivraisonCommande ( *id*, #livraisonId, #commandeId, prix )

Or

+ Livraison ( *id*, #transporteurId, #responsableId, dateLivraison, dateCommande, prix )
+ Commande ( *id*, #livraisonId, #clientId, dateCommande, prix )

==============================================


Address( *id*, #cityId, street, number )
City ( *id*, #countryId, name )
Country ( *id*, name )
