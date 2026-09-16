# lesson_19
ДЗ. Docker: основы работы с контейнеризацией

# Домашнее задание
Docker

# Исполнитель
Павел Смирнов

# Цель
Освоить базовые принципы работы с Docker, научиться создавать, настраивать и управлять контейнерами;

- Установите Docker на хост машину https://docs.docker.com/engine/install/ubuntu/
- Установите Docker Compose - как плагин, или как отдельное приложение
- Создайте свой кастомный образ nginx на базе alpine. После запуска nginx должен отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx)
- Определите разницу между контейнером и образом
Вывод опишите в домашнем задании.
- Ответьте на вопрос: Можно ли в контейнере собрать ядро?

Формат сдачи:
- Собранный образ необходимо запушить в docker hub и дать ссылку на ваш репозиторий.

# Среда выполнения
  Хост машина - OS Windows 10, VirtualBox 7.0.10, ВМ - Ubuntu 24.04

# Команды и описание действий
```
root@srv1:~#
root@srv1:~# apt update
Hit:1 http://ru.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://ru.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://ru.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:4 http://security.ubuntu.com/ubuntu noble-security InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
171 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@srv1:~# apt install ca-certificates curl
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
ca-certificates is already the newest version (20260601~24.04.1).
curl is already the newest version (8.5.0-2ubuntu10.13).
curl set to manually installed.
The following package was automatically installed and is no longer required:
  pigz
Use 'apt autoremove' to remove it.
0 upgraded, 0 newly installed, 0 to remove and 171 not upgraded.
root@srv1:~# install -m 0755 -d /etc/apt/keyrings
root@srv1:~# curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
root@srv1:~# ls -l /etc/apt/keyrings/
total 4
-rw-r--r-- 1 root root 3817 Sep 15 20:36 docker.asc
root@srv1:~# chmod a+r /etc/apt/keyrings/docker.asc
root@srv1:~# sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: noble
Components: stable
Architectures: amd64
Signed-By: /etc/apt/keyrings/docker.asc
root@srv1:~#
root@srv1:~# cat /etc/apt/sources.list.d/docker.sources
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: noble
Components: stable
Architectures: amd64
Signed-By: /etc/apt/keyrings/docker.asc
root@srv1:~# sudo apt update
Hit:1 http://ru.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://ru.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://ru.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:4 http://security.ubuntu.com/ubuntu noble-security InRelease
Get:5 https://download.docker.com/linux/ubuntu noble InRelease [48.5 kB]
Get:6 https://download.docker.com/linux/ubuntu noble/stable amd64 Packages [66.4 kB]
Fetched 115 kB in 1s (143 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
171 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@srv1:~# apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  docker-ce-rootless-extras
Suggested packages:
  cgroupfs-mount | cgroup-lite docker-model-plugin
The following NEW packages will be installed:
  containerd.io docker-buildx-plugin docker-ce docker-ce-cli docker-ce-rootless-extras docker-compose-plugin
0 upgraded, 6 newly installed, 0 to remove and 171 not upgraded.
Need to get 99.7 MB of archives.
After this operation, 381 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 https://download.docker.com/linux/ubuntu noble/stable amd64 containerd.io amd64 2.3.5-1~ubuntu.24.04~noble [22.4 MB]
Get:2 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce-cli amd64 5:29.8.1-1~ubuntu.24.04~noble [17.6 MB]
Get:3 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce amd64 5:29.8.1-1~ubuntu.24.04~noble [24.3 MB]
Get:4 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-buildx-plugin amd64 0.37.1-1~ubuntu.24.04~noble [17.3 MB]
Get:5 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce-rootless-extras amd64 5:29.8.1-1~ubuntu.24.04~noble [10.2 MB]
Get:6 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-compose-plugin amd64 5.5.1-1~ubuntu.24.04~noble [8,012 kB]
Fetched 99.7 MB in 12s (8,173 kB/s)
Selecting previously unselected package containerd.io.
(Reading database ... 136711 files and directories currently installed.)
Preparing to unpack .../0-containerd.io_2.3.5-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking containerd.io (2.3.5-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-ce-cli.
Preparing to unpack .../1-docker-ce-cli_5%3a29.8.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-ce-cli (5:29.8.1-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-ce.
Preparing to unpack .../2-docker-ce_5%3a29.8.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-ce (5:29.8.1-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-buildx-plugin.
Preparing to unpack .../3-docker-buildx-plugin_0.37.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-buildx-plugin (0.37.1-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-ce-rootless-extras.
Preparing to unpack .../4-docker-ce-rootless-extras_5%3a29.8.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-ce-rootless-extras (5:29.8.1-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-compose-plugin.
Preparing to unpack .../5-docker-compose-plugin_5.5.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-compose-plugin (5.5.1-1~ubuntu.24.04~noble) ...
Setting up docker-buildx-plugin (0.37.1-1~ubuntu.24.04~noble) ...
Setting up containerd.io (2.3.5-1~ubuntu.24.04~noble) ...
Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service > /usr/lib/systemd/system/containerd.service.
Setting up docker-compose-plugin (5.5.1-1~ubuntu.24.04~noble) ...
Setting up docker-ce-cli (5:29.8.1-1~ubuntu.24.04~noble) ...
Setting up docker-ce-rootless-extras (5:29.8.1-1~ubuntu.24.04~noble) ...
Setting up docker-ce (5:29.8.1-1~ubuntu.24.04~noble) ...
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service > /usr/lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/sockets.target.wants/docker.socket > /usr/lib/systemd/system/docker.socket.
Processing triggers for man-db (2.12.0-4build2) ...
Scanning processes...
Scanning linux images...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
root@srv1:~#
root@srv1:~#
root@srv1:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@srv1:~#
root@srv1:~# pwd
/root
root@srv1:~# mkdir docker && cd docker
root@srv1:~/docker# cat > index.html
<html>
<head>
<title>It's my custom page!</title>
</head>
<body>
<h1>Docker Home task!</h1>
<p>
<font color=red size=50>It's my custom page!</font>
</p>
<p>
<a href="https://docs.docker.com/engine/install/ubuntu/">Docker install</a>.
</p>
</body>
</html>
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker# cat > dockerfile
FROM nginx:stable-alpine
LABEL lbl="Lesson nginx:stable-alpine"
COPY index.html /usr/share/nginx/html
root@srv1:~/docker#
root@srv1:~/docker# docker build -t nginx-custom .
[+] Building 17.6s (7/7) FINISHED                                                                    docker:default
 => [internal] load build definition from dockerfile                                                           0.0s
 => => transferring dockerfile: 139B                                                                           0.0s
 => [internal] load metadata for docker.io/library/nginx:stable-alpine                                         2.1s
 => [internal] load .dockerignore                                                                              0.0s
 => => transferring context: 2B                                                                                0.0s
 => [internal] load build context                                                                              0.1s
 => => transferring context: 294B                                                                              0.0s
 => [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:dc5069ad14f19660b141b21236140b91656bf89bbc3e2417c  6.9s
 => => resolve docker.io/library/nginx:stable-alpine@sha256:dc5069ad14f19660b141b21236140b91656bf89bbc3e2417c  0.1s
 => => sha256:c39233542455bfb494d68089ebb1b8eb3f0104ef0f676e7bc78fc637a0bad7bf 20.33MB / 20.33MB               4.7s
 => => sha256:55afa1ecc21d2bb5e5045f32dafee56272ffd89860bac26f6c32123439af26a4 3.85MB / 3.85MB                 2.1s
 => => sha256:0bfd0ed0041486dd19ac2807088044b7b750d7ce008314ef49e75d92f42b9c19 1.40kB / 1.40kB                 1.1s
 => => sha256:6710fa5752a599abf4c9f536edfe5be7952768135b5050ac9afdefc0533834a2 1.21kB / 1.21kB                 0.6s
 => => sha256:33e5f432b4d0343ae580ca491ee35e51f51000f5694efd025a8af08e0be7c729 403B / 403B                     0.3s
 => => sha256:67ff5ce9d4e9e840b2a802e06f9db7aa2526032b11972f065750ca6082d06f2c 627B / 627B                     0.3s
 => => sha256:51ec9c021a5aa5f4b4e020396c3080d9434d71d75288c5f4b06bfc78104310fe 954B / 954B                     1.1s
 => => sha256:f45fdf63315816ec6bd937d40fb4450c1364e299cf7bdb48c14d19ee26ce32a0 4.35MB / 4.35MB                 3.2s
 => => extracting sha256:55afa1ecc21d2bb5e5045f32dafee56272ffd89860bac26f6c32123439af26a4                      0.5s
 => => extracting sha256:f45fdf63315816ec6bd937d40fb4450c1364e299cf7bdb48c14d19ee26ce32a0                      0.6s
 => => extracting sha256:67ff5ce9d4e9e840b2a802e06f9db7aa2526032b11972f065750ca6082d06f2c                      0.0s
 => => extracting sha256:51ec9c021a5aa5f4b4e020396c3080d9434d71d75288c5f4b06bfc78104310fe                      0.0s
 => => extracting sha256:33e5f432b4d0343ae580ca491ee35e51f51000f5694efd025a8af08e0be7c729                      0.0s
 => => extracting sha256:6710fa5752a599abf4c9f536edfe5be7952768135b5050ac9afdefc0533834a2                      0.0s
 => => extracting sha256:0bfd0ed0041486dd19ac2807088044b7b750d7ce008314ef49e75d92f42b9c19                      0.0s
 => => extracting sha256:c39233542455bfb494d68089ebb1b8eb3f0104ef0f676e7bc78fc637a0bad7bf                      1.1s
 => [2/2] COPY index.html /usr/share/nginx/html                                                                7.8s
 => exporting to image                                                                                         0.4s
 => => exporting layers                                                                                        0.1s
 => => exporting manifest sha256:7dbec17d3c5bc4455a63abb63eae5e635243f1bbbe818e42c1b969a175f15166              0.1s
 => => exporting config sha256:a2cefaf84be572129af7928ba5f7a5b18d1de2c6ac461f4bc837d798b5f3abd2                0.0s
 => => exporting attestation manifest sha256:5aae10294e3bd21a98837357479936c627a61f34dcfc2048c4c1fa1e704a042e  0.0s
 => => exporting manifest list sha256:e4be3b44359ade44d6740326d8aabf5174183143128b6ab71e7253601879e1d7         0.0s
 => => naming to docker.io/library/nginx-custom:latest                                                         0.0s
 => => unpacking to docker.io/library/nginx-custom:latest                                                      0.0s
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker# docker run -dt --name doc1 -p 777:80 nginx-custom
bd3c36bec34c955195fea44ec8a157766c1b15db7c54c285bff1bafb55ac9c57
root@srv1:~/docker# docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                   NAMES
bd3c36bec34c   nginx-custom   "/docker-entrypoint.…"   13 seconds ago   Up 12 seconds   0.0.0.0:777->80/tcp, [::]:777->80/tcp   doc1
root@srv1:~/docker# curl localhost:777
<html>
<head>
<title>It's my custom page!</title>
</head>
<body>
<h1>Docker Home task!</h1>
<p>
<font color=red size=50>It's my custom page!</font>
</p>
<p>
<a href="https://docs.docker.com/engine/install/ubuntu/">Docker install</a>.
</p>
</body>
</html>
root@srv1:~/docker#



========================

root@srv1:~# cd docker/
root@srv1:~/docker# ls
dockerfile  index.html
root@srv1:~/docker# docker images
                                                            i Info ?   U  In Use
IMAGE                 ID             DISK USAGE   CONTENT SIZE   EXTRA
nginx-custom:latest   e4be3b44359a        101MB         28.5MB    U
root@srv1:~/docker# docker build -t psmirnoff1975/nginx-custom:1.0.0 .
[+] Building 45.4s (7/7) FINISHED                                docker:default
 => [internal] load build definition from dockerfile                       0.2s
 => => transferring dockerfile: 139B                                       0.1s
 => [internal] load metadata for docker.io/library/nginx:stable-alpine     3.5s
 => [internal] load .dockerignore                                          0.1s
 => => transferring context: 2B                                            0.0s
 => [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:73c75df4075c  36.9s
 => => resolve docker.io/library/nginx:stable-alpine@sha256:73c75df4075c9  0.1s
 => => sha256:c54fe1bc3d0f7b98a9f073704ec44ed96642b9b65 20.34MB / 20.34MB  4.5s
 => => sha256:f709c26bfc6a0474abd2851641ff6b209dd577025f6 1.40kB / 1.40kB  1.3s
 => => sha256:aac3a72f1123b823f55acd996a59133f46feb86faa9 1.21kB / 1.21kB  1.3s
 => => sha256:da8b0d805e5c3713753e89ee1f9dfe90fb19eb0ff78e274 404B / 404B  1.1s
 => => sha256:16720f76a6c9de7581783bf4d55fead5d0360ebdb9fde07 956B / 956B  0.3s
 => => sha256:a9e7aa0bb73bd20b7931b7fa56d00becede0a777436b5ba 629B / 629B  0.7s
 => => sha256:d57a2d5adcf624d860440eda0751197834a37175fd5 4.35MB / 4.35MB  3.3s
 => => extracting sha256:d57a2d5adcf624d860440eda0751197834a37175fd555f9b  0.9s
 => => extracting sha256:a9e7aa0bb73bd20b7931b7fa56d00becede0a777436b5bab  0.2s
 => => extracting sha256:16720f76a6c9de7581783bf4d55fead5d0360ebdb9fde075  0.1s
 => => extracting sha256:da8b0d805e5c3713753e89ee1f9dfe90fb19eb0ff78e274c  0.1s
 => => extracting sha256:aac3a72f1123b823f55acd996a59133f46feb86faa909181  0.1s
 => => extracting sha256:f709c26bfc6a0474abd2851641ff6b209dd577025f696ed8  0.1s
 => => extracting sha256:c54fe1bc3d0f7b98a9f073704ec44ed96642b9b65259c0b  29.7s
 => [internal] load build context                                          0.1s
 => => transferring context: 32B                                           0.0s
 => [2/2] COPY index.html /usr/share/nginx/html                            2.8s
 => exporting to image                                                     0.9s
 => => exporting layers                                                    0.5s
 => => exporting manifest sha256:606da1ee641b0ec9b35c4822758a9ad01fa91658  0.0s
 => => exporting config sha256:1a43fbc02bdfce9dec33568664fb0b80bdc9e0385c  0.0s
 => => exporting attestation manifest sha256:0b496244f99dabe1b7021ac98b35  0.0s
 => => exporting manifest list sha256:13d0e28b29018c5e5183c9a8ee389038949  0.2s
 => => naming to docker.io/psmirnoff1975/nginx-custom:1.0.0                0.0s
 => => unpacking to docker.io/psmirnoff1975/nginx-custom:1.0.0             0.0s
root@srv1:~/docker# docker images
                                                            i Info ?   U  In Use
IMAGE                           ID             DISK USAGE   CONTENT SIZE   EXTRA
nginx-custom:latest             e4be3b44359a        101MB         28.5MB    U
psmirnoff1975/nginx-custom:1.0.0
                                13d0e28b2901        101MB         28.6MB
root@srv1:~/docker# docker run -dt --name doc2 -p 777:80 psmirnoff1975/nginx-cus                                         tom:1.0.0
11972e0dac0aba0ec3b9e2cd85dcf12f22c251ccf7bcbd496823f9e7ff3ca61e
root@srv1:~/docker# docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREAT                                         ED          STATUS          PORTS                                   NAMES
11972e0dac0a   psmirnoff1975/nginx-custom:1.0.0   "/docker-entrypoint.…"   12 se                                         conds ago   Up 11 seconds   0.0.0.0:777->80/tcp, [::]:777->80/tcp   doc2
root@srv1:~/docker# curl localhost:777
<html>
<head>
<title>It's my custom page!</title>
</head>
<body>
<h1>Docker Home task!</h1>
<p>
<font color=red size=50>It's my custom page!</font>
</p>
<p>
<a href="https://docs.docker.com/engine/install/ubuntu/">Docker install</a>.
</p>
</body>
</html>
root@srv1:~/docker# docker stop doc2
doc2
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#

```

# Протокол работы

```
root@srv1:~#
root@srv1:~# apt update
Hit:1 http://ru.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://ru.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://ru.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:4 http://security.ubuntu.com/ubuntu noble-security InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
171 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@srv1:~# apt install ca-certificates curl
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
ca-certificates is already the newest version (20260601~24.04.1).
curl is already the newest version (8.5.0-2ubuntu10.13).
curl set to manually installed.
The following package was automatically installed and is no longer required:
  pigz
Use 'apt autoremove' to remove it.
0 upgraded, 0 newly installed, 0 to remove and 171 not upgraded.
root@srv1:~# install -m 0755 -d /etc/apt/keyrings
root@srv1:~# curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
root@srv1:~# ls -l /etc/apt/keyrings/
total 4
-rw-r--r-- 1 root root 3817 Sep 15 20:36 docker.asc
root@srv1:~# chmod a+r /etc/apt/keyrings/docker.asc
root@srv1:~# sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: noble
Components: stable
Architectures: amd64
Signed-By: /etc/apt/keyrings/docker.asc
root@srv1:~#
root@srv1:~# cat /etc/apt/sources.list.d/docker.sources
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: noble
Components: stable
Architectures: amd64
Signed-By: /etc/apt/keyrings/docker.asc
root@srv1:~# sudo apt update
Hit:1 http://ru.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://ru.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://ru.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:4 http://security.ubuntu.com/ubuntu noble-security InRelease
Get:5 https://download.docker.com/linux/ubuntu noble InRelease [48.5 kB]
Get:6 https://download.docker.com/linux/ubuntu noble/stable amd64 Packages [66.4 kB]
Fetched 115 kB in 1s (143 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
171 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@srv1:~# apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  docker-ce-rootless-extras
Suggested packages:
  cgroupfs-mount | cgroup-lite docker-model-plugin
The following NEW packages will be installed:
  containerd.io docker-buildx-plugin docker-ce docker-ce-cli docker-ce-rootless-extras docker-compose-plugin
0 upgraded, 6 newly installed, 0 to remove and 171 not upgraded.
Need to get 99.7 MB of archives.
After this operation, 381 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 https://download.docker.com/linux/ubuntu noble/stable amd64 containerd.io amd64 2.3.5-1~ubuntu.24.04~noble [22.4 MB]
Get:2 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce-cli amd64 5:29.8.1-1~ubuntu.24.04~noble [17.6 MB]
Get:3 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce amd64 5:29.8.1-1~ubuntu.24.04~noble [24.3 MB]
Get:4 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-buildx-plugin amd64 0.37.1-1~ubuntu.24.04~noble [17.3 MB]
Get:5 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce-rootless-extras amd64 5:29.8.1-1~ubuntu.24.04~noble [10.2 MB]
Get:6 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-compose-plugin amd64 5.5.1-1~ubuntu.24.04~noble [8,012 kB]
Fetched 99.7 MB in 12s (8,173 kB/s)
Selecting previously unselected package containerd.io.
(Reading database ... 136711 files and directories currently installed.)
Preparing to unpack .../0-containerd.io_2.3.5-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking containerd.io (2.3.5-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-ce-cli.
Preparing to unpack .../1-docker-ce-cli_5%3a29.8.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-ce-cli (5:29.8.1-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-ce.
Preparing to unpack .../2-docker-ce_5%3a29.8.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-ce (5:29.8.1-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-buildx-plugin.
Preparing to unpack .../3-docker-buildx-plugin_0.37.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-buildx-plugin (0.37.1-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-ce-rootless-extras.
Preparing to unpack .../4-docker-ce-rootless-extras_5%3a29.8.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-ce-rootless-extras (5:29.8.1-1~ubuntu.24.04~noble) ...
Selecting previously unselected package docker-compose-plugin.
Preparing to unpack .../5-docker-compose-plugin_5.5.1-1~ubuntu.24.04~noble_amd64.deb ...
Unpacking docker-compose-plugin (5.5.1-1~ubuntu.24.04~noble) ...
Setting up docker-buildx-plugin (0.37.1-1~ubuntu.24.04~noble) ...
Setting up containerd.io (2.3.5-1~ubuntu.24.04~noble) ...
Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service > /usr/lib/systemd/system/containerd.service.
Setting up docker-compose-plugin (5.5.1-1~ubuntu.24.04~noble) ...
Setting up docker-ce-cli (5:29.8.1-1~ubuntu.24.04~noble) ...
Setting up docker-ce-rootless-extras (5:29.8.1-1~ubuntu.24.04~noble) ...
Setting up docker-ce (5:29.8.1-1~ubuntu.24.04~noble) ...
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service > /usr/lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/sockets.target.wants/docker.socket > /usr/lib/systemd/system/docker.socket.
Processing triggers for man-db (2.12.0-4build2) ...
Scanning processes...
Scanning linux images...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
root@srv1:~#
root@srv1:~#
root@srv1:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@srv1:~#
root@srv1:~# pwd
/root
root@srv1:~# mkdir docker && cd docker
root@srv1:~/docker# cat > index.html
<html>
<head>
<title>It's my custom page!</title>
</head>
<body>
<h1>Docker Home task!</h1>
<p>
<font color=red size=50>It's my custom page!</font>
</p>
<p>
<a href="https://docs.docker.com/engine/install/ubuntu/">Docker install</a>.
</p>
</body>
</html>
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker# cat > dockerfile
FROM nginx:stable-alpine
LABEL lbl="Lesson nginx:stable-alpine"
COPY index.html /usr/share/nginx/html
root@srv1:~/docker#
root@srv1:~/docker# docker build -t nginx-custom .
[+] Building 17.6s (7/7) FINISHED                                                                    docker:default
 => [internal] load build definition from dockerfile                                                           0.0s
 => => transferring dockerfile: 139B                                                                           0.0s
 => [internal] load metadata for docker.io/library/nginx:stable-alpine                                         2.1s
 => [internal] load .dockerignore                                                                              0.0s
 => => transferring context: 2B                                                                                0.0s
 => [internal] load build context                                                                              0.1s
 => => transferring context: 294B                                                                              0.0s
 => [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:dc5069ad14f19660b141b21236140b91656bf89bbc3e2417c  6.9s
 => => resolve docker.io/library/nginx:stable-alpine@sha256:dc5069ad14f19660b141b21236140b91656bf89bbc3e2417c  0.1s
 => => sha256:c39233542455bfb494d68089ebb1b8eb3f0104ef0f676e7bc78fc637a0bad7bf 20.33MB / 20.33MB               4.7s
 => => sha256:55afa1ecc21d2bb5e5045f32dafee56272ffd89860bac26f6c32123439af26a4 3.85MB / 3.85MB                 2.1s
 => => sha256:0bfd0ed0041486dd19ac2807088044b7b750d7ce008314ef49e75d92f42b9c19 1.40kB / 1.40kB                 1.1s
 => => sha256:6710fa5752a599abf4c9f536edfe5be7952768135b5050ac9afdefc0533834a2 1.21kB / 1.21kB                 0.6s
 => => sha256:33e5f432b4d0343ae580ca491ee35e51f51000f5694efd025a8af08e0be7c729 403B / 403B                     0.3s
 => => sha256:67ff5ce9d4e9e840b2a802e06f9db7aa2526032b11972f065750ca6082d06f2c 627B / 627B                     0.3s
 => => sha256:51ec9c021a5aa5f4b4e020396c3080d9434d71d75288c5f4b06bfc78104310fe 954B / 954B                     1.1s
 => => sha256:f45fdf63315816ec6bd937d40fb4450c1364e299cf7bdb48c14d19ee26ce32a0 4.35MB / 4.35MB                 3.2s
 => => extracting sha256:55afa1ecc21d2bb5e5045f32dafee56272ffd89860bac26f6c32123439af26a4                      0.5s
 => => extracting sha256:f45fdf63315816ec6bd937d40fb4450c1364e299cf7bdb48c14d19ee26ce32a0                      0.6s
 => => extracting sha256:67ff5ce9d4e9e840b2a802e06f9db7aa2526032b11972f065750ca6082d06f2c                      0.0s
 => => extracting sha256:51ec9c021a5aa5f4b4e020396c3080d9434d71d75288c5f4b06bfc78104310fe                      0.0s
 => => extracting sha256:33e5f432b4d0343ae580ca491ee35e51f51000f5694efd025a8af08e0be7c729                      0.0s
 => => extracting sha256:6710fa5752a599abf4c9f536edfe5be7952768135b5050ac9afdefc0533834a2                      0.0s
 => => extracting sha256:0bfd0ed0041486dd19ac2807088044b7b750d7ce008314ef49e75d92f42b9c19                      0.0s
 => => extracting sha256:c39233542455bfb494d68089ebb1b8eb3f0104ef0f676e7bc78fc637a0bad7bf                      1.1s
 => [2/2] COPY index.html /usr/share/nginx/html                                                                7.8s
 => exporting to image                                                                                         0.4s
 => => exporting layers                                                                                        0.1s
 => => exporting manifest sha256:7dbec17d3c5bc4455a63abb63eae5e635243f1bbbe818e42c1b969a175f15166              0.1s
 => => exporting config sha256:a2cefaf84be572129af7928ba5f7a5b18d1de2c6ac461f4bc837d798b5f3abd2                0.0s
 => => exporting attestation manifest sha256:5aae10294e3bd21a98837357479936c627a61f34dcfc2048c4c1fa1e704a042e  0.0s
 => => exporting manifest list sha256:e4be3b44359ade44d6740326d8aabf5174183143128b6ab71e7253601879e1d7         0.0s
 => => naming to docker.io/library/nginx-custom:latest                                                         0.0s
 => => unpacking to docker.io/library/nginx-custom:latest                                                      0.0s
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker# docker run -dt --name doc1 -p 777:80 nginx-custom
bd3c36bec34c955195fea44ec8a157766c1b15db7c54c285bff1bafb55ac9c57
root@srv1:~/docker# docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                   NAMES
bd3c36bec34c   nginx-custom   "/docker-entrypoint.…"   13 seconds ago   Up 12 seconds   0.0.0.0:777->80/tcp, [::]:777->80/tcp   doc1
root@srv1:~/docker# curl localhost:777
<html>
<head>
<title>It's my custom page!</title>
</head>
<body>
<h1>Docker Home task!</h1>
<p>
<font color=red size=50>It's my custom page!</font>
</p>
<p>
<a href="https://docs.docker.com/engine/install/ubuntu/">Docker install</a>.
</p>
</body>
</html>
root@srv1:~/docker#



========================

root@srv1:~# cd docker/
root@srv1:~/docker# ls
dockerfile  index.html
root@srv1:~/docker# docker images
                                                            i Info ?   U  In Use
IMAGE                 ID             DISK USAGE   CONTENT SIZE   EXTRA
nginx-custom:latest   e4be3b44359a        101MB         28.5MB    U
root@srv1:~/docker# docker build -t psmirnoff1975/nginx-custom:1.0.0 .
[+] Building 45.4s (7/7) FINISHED                                docker:default
 => [internal] load build definition from dockerfile                       0.2s
 => => transferring dockerfile: 139B                                       0.1s
 => [internal] load metadata for docker.io/library/nginx:stable-alpine     3.5s
 => [internal] load .dockerignore                                          0.1s
 => => transferring context: 2B                                            0.0s
 => [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:73c75df4075c  36.9s
 => => resolve docker.io/library/nginx:stable-alpine@sha256:73c75df4075c9  0.1s
 => => sha256:c54fe1bc3d0f7b98a9f073704ec44ed96642b9b65 20.34MB / 20.34MB  4.5s
 => => sha256:f709c26bfc6a0474abd2851641ff6b209dd577025f6 1.40kB / 1.40kB  1.3s
 => => sha256:aac3a72f1123b823f55acd996a59133f46feb86faa9 1.21kB / 1.21kB  1.3s
 => => sha256:da8b0d805e5c3713753e89ee1f9dfe90fb19eb0ff78e274 404B / 404B  1.1s
 => => sha256:16720f76a6c9de7581783bf4d55fead5d0360ebdb9fde07 956B / 956B  0.3s
 => => sha256:a9e7aa0bb73bd20b7931b7fa56d00becede0a777436b5ba 629B / 629B  0.7s
 => => sha256:d57a2d5adcf624d860440eda0751197834a37175fd5 4.35MB / 4.35MB  3.3s
 => => extracting sha256:d57a2d5adcf624d860440eda0751197834a37175fd555f9b  0.9s
 => => extracting sha256:a9e7aa0bb73bd20b7931b7fa56d00becede0a777436b5bab  0.2s
 => => extracting sha256:16720f76a6c9de7581783bf4d55fead5d0360ebdb9fde075  0.1s
 => => extracting sha256:da8b0d805e5c3713753e89ee1f9dfe90fb19eb0ff78e274c  0.1s
 => => extracting sha256:aac3a72f1123b823f55acd996a59133f46feb86faa909181  0.1s
 => => extracting sha256:f709c26bfc6a0474abd2851641ff6b209dd577025f696ed8  0.1s
 => => extracting sha256:c54fe1bc3d0f7b98a9f073704ec44ed96642b9b65259c0b  29.7s
 => [internal] load build context                                          0.1s
 => => transferring context: 32B                                           0.0s
 => [2/2] COPY index.html /usr/share/nginx/html                            2.8s
 => exporting to image                                                     0.9s
 => => exporting layers                                                    0.5s
 => => exporting manifest sha256:606da1ee641b0ec9b35c4822758a9ad01fa91658  0.0s
 => => exporting config sha256:1a43fbc02bdfce9dec33568664fb0b80bdc9e0385c  0.0s
 => => exporting attestation manifest sha256:0b496244f99dabe1b7021ac98b35  0.0s
 => => exporting manifest list sha256:13d0e28b29018c5e5183c9a8ee389038949  0.2s
 => => naming to docker.io/psmirnoff1975/nginx-custom:1.0.0                0.0s
 => => unpacking to docker.io/psmirnoff1975/nginx-custom:1.0.0             0.0s
root@srv1:~/docker# docker images
                                                            i Info ?   U  In Use
IMAGE                           ID             DISK USAGE   CONTENT SIZE   EXTRA
nginx-custom:latest             e4be3b44359a        101MB         28.5MB    U
psmirnoff1975/nginx-custom:1.0.0
                                13d0e28b2901        101MB         28.6MB
root@srv1:~/docker# docker run -dt --name doc2 -p 777:80 psmirnoff1975/nginx-cus                                         tom:1.0.0
11972e0dac0aba0ec3b9e2cd85dcf12f22c251ccf7bcbd496823f9e7ff3ca61e
root@srv1:~/docker# docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREAT                                         ED          STATUS          PORTS                                   NAMES
11972e0dac0a   psmirnoff1975/nginx-custom:1.0.0   "/docker-entrypoint.…"   12 se                                         conds ago   Up 11 seconds   0.0.0.0:777->80/tcp, [::]:777->80/tcp   doc2
root@srv1:~/docker# curl localhost:777
<html>
<head>
<title>It's my custom page!</title>
</head>
<body>
<h1>Docker Home task!</h1>
<p>
<font color=red size=50>It's my custom page!</font>
</p>
<p>
<a href="https://docs.docker.com/engine/install/ubuntu/">Docker install</a>.
</p>
</body>
</html>
root@srv1:~/docker# docker stop doc2
doc2
root@srv1:~/docker#
root@srv1:~/docker#
root@srv1:~/docker#

```
