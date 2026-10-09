# 3-tiers-architecture
3 tiers architecture using terraform

Ce projet a pour objectif la mise en place d'une infrastructure AWS en architecture 3-tiers (web, applicatif, données), entièrement décrite et déployée sous forme de code d'infrastructure (Infrastructure as Code) avec Terraform.
L'objectif du projet est de fournir une infrastructure hautement disponible, sécurisée et reproductible, répartie sur deux zones de disponibilité (AZ), avec une séparation stricte des niveaux réseau, une protection applicative par pare-feu web (WAF), et une base de données relationnelle résiliente.

Le code a été organisé en fichiers distincts par domaine fonctionnel (réseau, sécurité, niveau web, niveau applicatif, base de données), afin de faciliter la lecture, la maintenance et les revues de code. Chaque paramètre variable (tailles d'instances, capacités, CIDR, rétention des journaux, etc.) a été externalisé dans un fichier de variables afin de permettre une adaptation rapide à d'autres environnements (dev, staging, prod).

L'infrastructure déployée répond aux exigences d'une architecture 3-tiers résiliente et sécurisée sur AWS : répartition multi-AZ à tous les niveaux, séparation stricte des flux réseau, protection applicative par WAF, et base de données hautement disponible avec sauvegardes automatiques sur 7 jours.
Le caractère entièrement codifié (Infrastructure as Code) de ce déploiement garantit sa reproductibilité, sa traçabilité via le contrôle de version, et sa capacité à être répliqué rapidement sur d'autres environnements (dev, staging) ou d'autres régions AWS en cas de besoin de reprise après sinistre.
Il est recommandé de planifier un exercice périodique de bascule Multi-AZ et de test de charge WAF afin de maintenir la confiance dans la résilience de la plateforme dans le temps.
