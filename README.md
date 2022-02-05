# Docker-Nextcloud

Docker stack for Nextcloud

## Installation
Installation des fichiers à partir de [GitLab](https://gitlab.com/Slt/docker-nextcloud).

```
git clone git@gitlab.com:Slt/docker-nextcloud.git myNextcloudName
```

Renommer le fichier ``sample.env`` en ``.env``
Paramétrer le fichier ``.env`` avec les données souhaitées

Lancer une mise à jour et la création des containters

```
sh ./dockerUpdate.sh
```

#### Utilisation derrière un proxy

En cas d'utilisation derrière un proxy (ou un HAProxy), l'utilisation du protocole http à la place de https peut poser des problèmes de connexion, notamment avec l'outil de synchronisation. Dans ce cas là, il faudra forcer le protocole https.

```
docker exec -it -u www-data nextcloud-app-1 php occ config:system:set overwriteprotocol --value="https"
```

Où `nextcloud_app_1` est le container executant l'appli Nextcloud.

#### Configuration du format des numéros de téléphone

Dans la version 23 de Nextcloud, les numéros de téléphone ne sont pas configurés par défaut et provoquent une alerte.

```shell
docker exec -it -u www-data nextcloud-app-1 php occ config:system:set default_phone_region --value="FR"
```

Où `nextcloud_app_1` est le container executant l'appli Nextcloud.



## Utilisation locale en http

L'usage de https est forcé sur la configuration de Nginx. 
Pour utiliser la stack en local en http, il faut commenter la ligne suivante dans le fichier ``docker/web/nginx.conf`` :

```shell
fastcgi_param HTTPS on;
```

Ensuite, rebuilder la stack, ou lancer la commande suivante car la configuration Nginx est copiée dans le container au moment du build :

```shell
sh ./updateStack.sh
```



