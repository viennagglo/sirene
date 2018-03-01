# Scripts de traitement du fichier CSV de la base SIRENE

## Prérequis

Avoir préalablement installé les outils nécessaires à la bonne exécution du script SHELL

## Principe

Ce dépôt contient 2 scripts SHELL qui permettent de traiter les données brutes de la base SIRENE téléchargées en CSV sur la Plateforme ouverte des données publiques françaises : https://www.data.gouv.fr/fr/

Ce traitement a pour objectif de créer un fichier CSV compatible avec le module d'import de la solution EUDONET utilisée par notre service "Développement économique"

Le premier script traite le fichier de mise à jour mensuelle, l'autre le fichier stock.

On distingue 8 étapes de traitements + 1 étape d'insertion dans la BDD PostgreSQL et d'export de la table en CSV :
- 1/8 : REPERTOIRE DE TRAVAIL - TELECHARGEMENT DU FICHIER SIRENE - MAJ MENSUELLE OU STOCK,
- 2/8 : DECOUPAGE DU FICHIER NATIONAL EN FICHIERS DEPARTEMENTAUX (LIGNE COMMENTEE) remplacée PAR UNE COMMANDE QUI FILTRE LES 2 DEPARTEMENTS QUI M'INTERESSENT (38 et 69) - GAIN DE TEMPS,
- 3/8 : FUSION DES 2 FICHIERS DEPARTEMENTAUX SUR LEQUEL SE TROUVE LE TERRITOIRE DE L'EPCI,
- 4/8 : REMBOURRAGE DE ZERO SUR LE CHAMP COMET (afin de construire le code INSEE ultérieurement),
- 5/8 : DECOUPAGE DU FICHIER REUNISSANT LE DEPARTEMENT 38 ET 69 EN FICHIER EPCI,
- 6/8 : FUSION DES FICHIERS EPCI EN UN SEUL FICHIER,
- 7/8 : DECOUPAGE DES FICHIERS EPCI EN FICHIER COMMUNAL,
- 8/8 : FUSION DES FICHIERS COMMUNAUX EN UN SEUL FICHIER AFIN DE CONSTRUIRE LE FICHIER DE L'EPCI,
- INSERTION DANS LA BASE DE DONNEES PGSQL ET EXPORT DU FICHIER POUR EUDONET EN CSV.

## Licence Ouverte
![Licence Ouverte ETALAB](/licence_ouverte.png)

[LICENCE OUVERTE / OPEN LICENCE - Version 2.0](https://www.etalab.gouv.fr/wp-content/uploads/2017/04/ETALAB-Licence-Ouverte-v2.0.pdf)