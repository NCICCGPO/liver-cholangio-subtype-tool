<h1 align="center">Liver Cholangiocarcinoma Subtyping Tool</h1>

<h4 align="center">This tool allows users to get liver cholangiocarcinoma subtypes calls for their dataset, along with the model confidence for each call.</h4>

## Table of contents

- [Getting Started](#getting-started)
- [Run Classifier Tool](#run-classifier-tool)
- [Troubleshooting](#troubleshooting)
- [Tutorials](#tutorials)
- [Maintainers](#maintainers)

## Getting Started

Assumes [Docker Desktop](https://docs.docker.com/get-started/get-docker/) is installed on your machine

1. Start up Docker Desktop Application

2. Sign into Applications
    Docker Sign In (if not already)

    ```bash
    docker login
    ```

3. Pull Docker image

    The containerized tool can be accessed directly from a pre-built Docker image file or by building one. *We recommend acessing directly from a pre-built Docker image file.*

    1. Download the pre-built Docker image file "lihcchol_classifier.tar.gz" from the Publication Page.

    2. Load image
        ```bash
        docker load -i lihcchol_classifier.tar.gz 
        ```

*Note: The Docker image only needs to be built once*

> Alternatively, instructions on how to build the Docker image are found on the [Build Docker Image Page](doc/pull_image.md).

## Run the Classifier Tool

### Data Prep

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

### Subtype Classification

The classifier has multiple parameter inputs: `filename`, `gene naming`, and `output folder`

+ The two modes for `gene naming` are **"ensembl"** and **"hugo"**

    ```bash
    docker run --rm -v ./:$(pwd) lihcchol_classifier $(pwd)/data/inputdata.tsv  ensembl  $(pwd)/results/outputfolder
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

And the `assignment_confidence.tsv` will consist of 6 columns: sample ID and the likelihood of each potential subtype:

| SampleID	| Beta catenin mutated	| CCA-like Progenitor	| HCC-like Progenitor	| Inflammatory | ClassTP53 mutated |
| :---        |    :----:   |     :----:    |   :----:   |  :----:   | ---: |
| sample1	| 0.0034	| 0.011866666666666666	| 0.9600248893065998	| 0.02185130116959065	| 0.002857142857142857 |
| sample2	| 0.9003633333333333	| 0.01425	| 0.0078	| 0.05711999999999999	| 0.020466666666666668 |
| sample3	| 0.7836335714285713	| 0.006083333333333333	| 0.005573333333333333	| 0.1763364285714286 | 0.028373333333333334 |
| sample4	| 0.8426014285714287	| 0.01125	| 0.0311	| 0.07573746031746031	| 0.03931111111111111 |
| sample5	| 0.405217987012987	| 0.024346666666666666	| 0.0819930303030303	| 0.1716708008658009 | 0.3167715151515152 |

## Tutorials

A guided walk through using TCGA data is found on the [Tutorial Page](doc/tutorial.md).

A quick example of using the tool with ICGC datasets are found on [Example Run Page](doc/icgc_example.md).

## Troubleshooting

For common issues, see [Troubleshooting](doc/debugging_classifier.md)

## Maintainers

Current maintainers:

+ Bahar Tercan (GitHub bhrtrcn)
+ Jordan Lee (GitHub jordan2lee)
