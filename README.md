# user-injector
Adaptation pour deux fichiers CSV et deux OU : 
modification du script pour traiter séparément les utilisateurs et les administrateurs en utilisant deux fichiers CSV (importUSERS.csv, importADMIN.csv) et en ciblant deux OU distinctes (OU=USER,..., OU=ADMIN,...)

Définition des chemins et OU : 
définition des variables $csvPathUsers, $csvPathAdmins, $ouPathUsers, et $ouPathAdmins pour spécifier les emplacements des fichiers et des OU

Ce qui doit être amélioré pour que le script fonctionne correctement :

Correction des chemins de fichiers CSV : L'erreur principale est que le script ne trouve pas les fichiers CSV.
