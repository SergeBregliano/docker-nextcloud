# Docker-Nextcloud

Docker stack for Nextcloud

## Installation
Installation des fichiers à partir de [GitLab](https://gitlab.com/Slt/docker-nextcloud).

```
git clone https://gitlab.com/Slt/docker-nextcloud.git myWebSiteName
```

Renommer le fichier ``sample.env`` en ``.env``
Paramétrer le fichier ``.env`` avec les données souhaitées

Lancer une mise à jour et la création des containters

```
sh ./dockerUpdate.sh
```

En cas d'utilisation derrière un proxy (ou un HAProxy), l'utilisation du protocole http à la place de https peut poser des problèmes de connexion, notamment avec l'outil de synchronisation. Dans ce cas là, il faudra forcer le protocole https.

```
docker exec -it -u www-data nextcloud_app_1 php occ config:system:set overwriteprotocol --value="https"
```

Où `nextcloud_app_1` est le container executant l'appli Nextcloud.

