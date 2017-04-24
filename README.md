# Docker-compose-Project

# Debian 8.7 
Je vous conseille d'utiliser une debian 8.7 vierge pour réaliser ces installations

# Installation de git et de curl 

* `apt-get install git curl`

# Installation de Docker et Docker-Compose 

L'installation de docker et Docker-compose se fait directement de puis le script installation `install-docker-full.sh`

```
git clone https://github.com/gallardo93dotcom/docker-compose-project.git
cd docker-compose-project
chmod +x install-docker-full.sh
./install-docker-full.sh 
```
 
# Déploiement du Reverse Proxy Nginx et de Let’s Encrypt

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

# Deploiement de Wordpress + MariaDB

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

# Accès à l'interface via Https

Vous l’avez compris, vous allez pouvoir accéder à votre instance via https://wp.domain.com Facile, non ?

# Deployer une autre instance 

La procédure reste la même que pour Wordpress , cependant le docker-compose reste à modifier

```
environment:
    - VIRTUAL_HOST=monapp.domain.com
    - LETSENCRYPT_HOST=monapp.domain.com 
    - LETSENCRYPT_EMAIL=toto@yopmail.fr
```

