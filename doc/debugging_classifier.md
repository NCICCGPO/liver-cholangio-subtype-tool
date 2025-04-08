## Creating a Docker image

*Error Message*
```bash
[+] Building 2.6s (3/3) FINISHED                                                      docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                  0.0s
 => => transferring dockerfile: 670B                                                                  0.0s
 => ERROR [internal] load metadata for docker.io/bioconductor/bioconductor_docker:devel               2.6s
 => [auth] bioconductor/bioconductor_docker:pull token for registry-1.docker.io                       0.0s
------
 > [internal] load metadata for docker.io/bioconductor/bioconductor_docker:devel:
------
Dockerfile:1
--------------------
   1 | >>> FROM bioconductor/bioconductor_docker:devel
   2 |     
   3 |     RUN mkdir /home/analysis
--------------------
ERROR: failed to solve: bioconductor/bioconductor_docker:devel: failed to resolve source metadata for docker.io/bioconductor/bioconductor_docker:devel: failed to authorize: failed to fetch oauth token: Post "https://auth.docker.io/token": write tcp [fe80::a445...]:53258->[2600:1f18:2148...]:443: write: socket is not connected
```

While building the Docker image from the Dockerfile with `docker build` command, this error can occur if a VPN is blocking Docker processes. Try disabling the VPN and rerunning the `docker build` command

## Viewing Docker Images

*Error Message*
```bash
$ docker images

Cannot connect to the Docker daemon at unix:///Users/User/.docker/run/docker.sock. Is the docker daemon running?
```

Make sure to turn on Docker Desktop and try rerunning command

## Running the Subtyping Tool

*Error Message*
```bash
Error: 'data/inputdata.tsv' does not exist in current working directory ('/app').
```

Docker can't locate your input data. Check to make sure `$(pwd)` preceeds your input file - example ` $(pwd)/data/inputdata.tsv` for a file that is located on your machine at `data/inputdata.tsv`