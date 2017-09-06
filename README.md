# Docker-compose-Project

### Tested sur ###
 * [x] Debian 8.X
 * [x] Debian 9.X
 
## Debian 8.X 
Je vous conseille d'utiliser une debian 8.7 vierge pour réaliser ces installations

## Installation de git et de curl 

* `apt-get install git curl sudo`

## Installation de Docker et Docker-Compose 

L'installation de docker et Docker-compose se fait directement de puis le script installation `install-docker-full.sh`

```
git clone https://github.com/gallardo93dotcom/docker-compose-project.git
cd docker-compose-project
chmod +x install-docker-full.sh && ./install-docker-full.sh 
```

## Debian 9.X 
L'installation se fera sur un debian 9.1 , ce script vous permettra d'installer docker-ce ainsi que docker-compose dans leur dernière version stable

```
git clone https://github.com/gallardo93dotcom/docker-compose-project.git
cd docker-compose-project
chmod +x install-dockerdebian9.sh && ./install-dockerdebian9.sh 
```
 
## Déploiement du Reverse Proxy Nginx et de Let’s Encrypt

Pour mettre en place un reverse proxy nginx sur Docker et supportant les connexions SSL, nous utiliserons les images `jwilder-nproxy` et `jrcs/letsencrypt-nginx-proxy-companion`.

Le docker compose se situe dans `/docker-compose-project/cont_proxy/docker-compose.yml`

Que fait-il ce docker-compose ?
- Il lance une instance d'nginx-proxy et lui indique d’écouter sur les ports 80 et 443
- Il indique le répertoire dans lequel se situeront les certificats générés par Let’s encrypt Companion soit `/srv/docker/nginx/certs`

- Il instancie nginx-proxy-companion et lui précise le répertoire dans lequel placer les certificats 
- Il le relie à nginx-proxy

Se placer dans `/docker-compose-project/cont_proxy/`
puis `docker-compose up -d`

- Vous disposez maintenant de nginx qui fonctionne en reverse proxy SSL et de son companion qui génèrera puis renouvellera automatiquement les certificats SSL.

## Déploiement de Wordpress + MariaDB

Pour déployer un instance Wordpress avec MariaDB qui soit signé par letsencrypt , il est impératif de préciser 3 variables d’environnement : 

- Par Exemple :

```
environment:
    - VIRTUAL_HOST=wp.domain.com
    - LETSENCRYPT_HOST=wp.domain.com 
    - LETSENCRYPT_EMAIL=toto@yopmail.fr
```

Le docker compose se situe dans `/docker-compose-project/cont_wp/`

Entrer : `docker-compose up -d`

## Accès à l'interface via Https

Vous l’avez compris, vous allez pouvoir accéder à votre instance via https://wp.domain.com Facile, non ?

## Déployer une autre instance 

La procédure reste la même que pour Wordpress , cependant le docker-compose reste à modifier

```
environment:
    - VIRTUAL_HOST=monapp.domain.com
    - LETSENCRYPT_HOST=monapp.domain.com 
    - LETSENCRYPT_EMAIL=toto@yopmail.fr
```
## Nettoyage des Images et Conteneurs non-taggés 

Ce script permets de nettoyer automatiquement les images ainsi que les conteneurs non-taggés

```
chmod +x docker-cleanup.sh && ./docker-cleanup.sh
```
### Que fait ce script?

- Il se positionne dans le répertoire `/tmp`
- Puis exécute un git clone de `https://gist.github.com/wdullaer/76b450a0c986e576e98b` (Code source , merci à l'auteur)
- Se place dans le répertoire créer 
- Exécute un déplacement de docker-cleanup vers `/usr/local/bin/docker-cleanup`
- Enfin il donne les droits d'exécution sur `/usr/local/bin/docker-cleanup`

## Maintenance des Images Docker 

Si vous souhaitez mettre à jour toutes vos images docker , il est nécessaire de lancer le script `update-images-full.sh`

```
chmod +x update-images-full.sh && ./update-images-full.sh
```
