# Docker nginx with a self-signed cert and fail2ban

This is a child of https://github.com/linuxserver/docker-letsencrypt and https://github.com/MarvAmBass/docker-nginx-ssl-secure .

This container will create a self-signed cert that will be used in nginx. Fail2ban is also setup. It's basically linuxserver/docker-letsencrypt with the letsencrypt bit stripped out and the self-signed cert bits of MarvAmBass/docker-nginx-ssl-secure jammed in there.


## Usage

```
docker create \
  --cap-add=NET_ADMIN \
  --name=letsencrypt \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -e DH_SIZE=2048 \
  -p 80:80 -p 443:443 \
  -e TZ=<timezone> \
  mcgriddle/docker-nginx-self-cert
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 80 -p 443` - the port(s)
* `-v /config` - all the config files including the webroot reside here
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` - timezone ie. `America/New_York`  
  

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


## Versions

+ **03.26.18:** Initial Release
