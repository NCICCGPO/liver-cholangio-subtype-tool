# Pulling Docker Image

Instead of pulling the Docker image from the Synapse Docker Registry, the image can be built directly. Installing and logging into Synapse is not required for this method.


Build the liver cholangiocarcinoma subtyping Docker image

```bash
docker build -t lihcchol_classifier:latest -f .build/Dockerfile .
```

Check your build by running `docker images`. You should see the output:
```
REPOSITORY              TAG        IMAGE ID        CREATED       SIZE
lihcchol_classifier     latest     be8490fb9f6a    ...           ...
```

> The Docker Image only needs to be built once
