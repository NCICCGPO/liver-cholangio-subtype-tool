<h1 align="center">Liver Cholangiocarcinoma Subtyping Tool</h1>

<h4 align="center">This tool allows users to get liver cholangiocarcinoma subtypes calls for their dataset, along with the model confidence for each call.</h4>

## Table of contents

- [Getting Started](#getting-started)
- [Run Classifier Tool](#run-classifier-tool)
- [Documentation](#documentation)
- [Maintainers](#maintainers)

## Getting Started

Assumes [Docker Desktop](https://docs.docker.com/get-started/get-docker/) is installed on your machine

1. Start up Docker Desktop Application

2. Build the liver cholangiocarcinoma subtyping Docker image
    ```bash
    docker build -t lihcchol_classifier:latest -f .build/Dockerfile .
    ```

    Check your build by running `docker images`. You should see the output:
    ```
    REPOSITORY              TAG        IMAGE ID        CREATED       SIZE
    lihcchol_classifier     latest     be8490fb9f6a    ...           ...
    ```

    > The Docker Image only needs to be built once

## Run Classifier Tool

The classifier has multiple parameter inputs: `filename`, `gene naming`, and `output folder`

+ The two modes for `gene naming` are **ensembl** and **hugo**

    ```bash
    docker run --rm -v ./:$(pwd) lihcchol_classifier  $(pwd)/data/inputdata.tsv  ensembl  $(pwd)/results/outputfolder
    ```

This will result in two output files:

+ assignment.tsv
+ assignment_confidence.tsv

In the example below the input

> ```bash
> docker run --rm -v ./:$(pwd) lihcchol_classifier $(pwd)/data/LICA-FR_normalized_read_count.tsv ensembl $(pwd)/results/France
>```

> ```bash
> docker run --rm -v ./:$(pwd) lihcchol_classifier $(pwd)/data/LIRI-JP_normalized_read_count.tsv hugo $(pwd)/results/Japan
>```

## Documentation

For common troubleshooting issues, see [Troubleshooting](doc/debugging_classifier.md)

## Maintainers

Current maintainers:

+ Bahar Tercan (GitHub bhrtrcn)
+ Jordan Lee (GitHub jordan2lee)
