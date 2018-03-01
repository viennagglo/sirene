# Scripts de traitement du fichier CSV de la base SIRENE

## Prérequis

Avoir préalablement installé les outils nécessaires à la bonne exécution du script SHELL

## Principe

Ce dépôt contient 2 scripts SHELL qui permettent de traiter les données brutes de la base SIRENE téléchargées en CSV sur la Plateforme ouverte des données publiques françaises : https://www.data.gouv.fr/fr/

Le premier traite le fichier de mise à jour mensuelle, l'autre le fichier stock.

On distingue 8 étapes de traitements + 1 étape d'insertion dans la BDD PostgreSQL :
- 1/8 : REPERTOIRE DE TRAVAIL - TELECHARGEMENT DU FICHIER SIRENE - MAJ MENSUELLE OU STOCK,
- 2/8 : DECOUPAGE DU FICHIER NATIONAL EN FICHIERS DEPARTEMENTAUX (LIGNE COMMENTEE) remplacée PAR UNE COMMANDE QUI FILTRE LES 2 DEPARTEMENTS QUI M'INTERESSENT (38 et 69) - GAIN DE TEMPS,
- 3/8 : FUSION DES 2 FICHIERS DEPARTEMENTAUX SUR LEQUEL SE TROUVE LE TERRITOIRE DE L'EPCI,
- 4/8 : REMBOURRAGE DE ZERO SUR LE CHAMP COMET (afin de construire le code INSEE ultérieurement),
- 5/8 : DECOUPAGE DU FICHIER REUNISSANT LE DEPARTEMENT 38 ET 69 EN FICHIER EPCI,
- 6/8 : FUSION DES FICHIERS EPCI EN UN SEUL FICHIER,
- 7/8 : DECOUPAGE DES FICHIERS EPCI EN FICHIER COMMUNAL,
- 8/8 : FUSION DES FICHIERS COMMUNAUX EN UN SEUL FICHIER AFIN DE CONSTRUIRE LE FICHIER DE L'EPCI,
- INSERTION DANS LA BASE DE DONNEES PGSQL.