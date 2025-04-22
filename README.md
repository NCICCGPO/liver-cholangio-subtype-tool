<h1 align="center">Liver Cholangiocarcinoma Subtyping Tool</h1>

<h4 align="center">This tool allows users to get liver cholangiocarcinoma subtypes calls for their dataset, along with the model confidence for each call.</h4>

## Table of contents

- [Getting Started](#getting-started)
- [Run Classifier Tool](#run-classifier-tool)
- [Troubleshooting](#troubleshooting)
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

## Data Prep

The tool accepts gene expression data in any unit (count, TPM, etc.) because it leverages relative ranking within a dataset. No normalization is needed.

The input dataset needs to have samples as rows and genes as columns. Example shown below:

| 	| ENSG00000000003.10	| ENSG00000000005.5 | ... |
| :---        |    :----:   |     :----:    | ---: |
| sample1	| 19.5947009281013	| 0.01053742057394742 | ... |
| sample2	| 121.4580327943682	| 0 | ... |
| sample3	| 134.0595610623084	| 0.003288643633669 | ... |
| sample4	| 118.9105281119996	| NA | ... |
| sample5	| 120.2224933600993	| 0.00274814239449383 | ... |
| ...        |   ...    |    ...     | ...   |

## Subtype Classification

The classifier has multiple parameter inputs: `filename`, `gene naming`, and `output folder`

+ The two modes for `gene naming` are **ensembl** and **hugo**

    ```bash
    docker run --rm -v ./:$(pwd) lihcchol_classifier  $(pwd)/data/inputdata.tsv  ensembl  $(pwd)/results/outputfolder
    ```

This will result in two output files:

+ assignment.tsv
+ assignment_confidence.tsv

Where the `assignment.tsv` will consist of two columns: sample ID and the labeled subtype:

| SampleID	| Assignment |
| :---    | ---: |
| sample1	| HCC-like Progenitor |
| sample2	| Beta catenin mutated |
| sample3	| Beta catenin mutated |
| sample4	| Beta catenin mutated |
| sample5	| Beta catenin mutated |
| ...        |   ...    |

And the `assignment_confidence.tsv` will consist of 6 columns: sample ID and the likelihood of all potential subtype:

| SampleID	| Beta catenin mutated	| CCA-like Progenitor	| HCC-like Progenitor	| Inflammatory | ClassTP53 mutated |
| :---        |    :----:   |     :----:    |   :----:   |  :----:   | ---: |
| sample1	| 0.0034	| 0.011866666666666666	| 0.9600248893065998	| 0.02185130116959065	| 0.002857142857142857 |
| sample2	| 0.9003633333333333	| 0.01425	| 0.0078	| 0.05711999999999999	| 0.020466666666666668 |
| sample3	| 0.7836335714285713	| 0.006083333333333333	| 0.005573333333333333	| 0.1763364285714286 | 0.028373333333333334 |
| sample4	| 0.8426014285714287	| 0.01125	| 0.0311	| 0.07573746031746031	| 0.03931111111111111 |
| sample5	| 0.405217987012987	| 0.024346666666666666	| 0.0819930303030303	| 0.1716708008658009 | 0.3167715151515152 |

## Example with ICGC Datasets

> ```bash
> docker run --rm -v ./:$(pwd) lihcchol_classifier $(pwd)/data/LICA-FR_normalized_read_count.tsv ensembl $(pwd)/results/France
>```

> ```bash
> docker run --rm -v ./:$(pwd) lihcchol_classifier $(pwd)/data/LIRI-JP_normalized_read_count.tsv hugo $(pwd)/results/Japan
>```

## Troubleshooting

For common issues, see [Troubleshooting](doc/debugging_classifier.md)

## Maintainers

Current maintainers:

+ Bahar Tercan (GitHub bhrtrcn)
+ Jordan Lee (GitHub jordan2lee)
