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

Où `nextcloud-app-1` est le container executant l'appli Nextcloud.

#### Configuration du format des numéros de téléphone

Dans la version 23 de Nextcloud, les numéros de téléphone ne sont pas configurés par défaut et provoquent une alerte.

```shell
docker exec -it -u www-data nextcloud-app-1 php occ config:system:set default_phone_region --value="FR"
```

Où `nextcloud-app-1` est le container executant l'appli Nextcloud.

#### Configuration de l'heure de début de maintenance planifiée

Dans la version 29 de Nextcloud, l'heure de début de maintenance planifiée n'est pas configurée et provoque une alerte.

```shell
docker exec -it -u www-data nextcloud-app-1 php occ config:system:set maintenance_window_start --type=integer --value=1
```

Où `nextcloud-app-1` est le container executant l'appli Nextcloud.

#### Réglage des trusted_domains et overwrite.cli.url

Se connecter à l'application  `nextcloud-app-1` via :

```shell
docker exec -it nextcloud-app-1 bash
```

Installer temporairement *nano*. Il disparaitra au prochain démarrage du container :

```shell
apt-get install nano
```

Éditer le fichier ``config/config.php``

```shell
nano config/config.php
```

Modifier la valeur de **trusted_domains** dans le tableau en remplaçant *localhost* par *web*.

Modifier la valeur de **overwrite.cli.url** de *http://localhost* par *http://web*.



## Maintenance

#### Mise à jour des index de la base de données

```shell
docker exec -it -u www-data nextcloud-app-1 php occ db:add-missing-indices
```

Où `nextcloud-app-1` est le container executant l'appli Nextcloud.



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



