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

+ The three modes for `gene naming` are **"ensembl"**, **"hugo"** and **entrez**

    ```bash
    docker run --rm -v ./:$(pwd) lihcchol_classifier $(pwd)/data/example_data.tsv ensembl $(pwd)/outputfolder
    ```

This will result in two output files:

+ assignment.tsv
+ assignment_confidence.tsv

Where the `assignment.tsv` will consist of two columns: sample ID and the labeled subtype:

| SampleID	| Assignment | Assignment_shortname |
| :---    |  :----:   |  ---: |
| sample1	| Focal genomic instability | FIST |
| sample2	| Hepatocyte like stem | Hep-like Stem |
| sample3	| Focal genomic instability | FIST |
| sample4	|  Focal genomic instability | FIST |
| sample5	| Inflammatory | Inflammatory |
| ...        |   ...    | ...    |


And the `assignment_confidence.tsv` will consist of 6 columns: sample ID and the likelihood of each potential subtype:


| SampleID              | Wnt pathway activated | Cholangiocyte like stem | Hepatocyte like stem | Inflammatory        | Focal genomic instability |
|-----------------------|----------------------|--------------------------|----------------------|--------------------|---------------------------|
| sample1      | 0.019491904761904762 | 0.0086                   | 0.004946666666666666 | 0.09395428571428573 | 0.8730071428571428        |
| sample2     | 0.010566666666666665 | 0.04947857142857142      | 0.8326445238095237   | 0.06576357142857144 | 0.04154666666666667       |
| sample3      | 0.020771904761904766 | 0.01                     | 0.012066666666666667 | 0.1007442857142857  | 0.856417142857143         |
| sample4     | 0.06094666666666667  | 0.019                    | 0.02449              | 0.06654333333333333 | 0.8290200000000001        |
| sample5      | 0.0302387034044387   | 0.010594285714285716     | 0.0022               | 0.9278027085169733  | 0.029164302364302366      |
| ...     | ...  | ...    | ... | ...   | ...       |


## Tutorials

A guided walk through using TCGA data is found on the [Tutorial Page](doc/tutorial.md).

A quick example of using the tool with ICGC datasets are found on [Example Run Page](doc/icgc_example.md).

## Troubleshooting

For common issues, see [Troubleshooting](doc/debugging_classifier.md)

## Maintainers

Current maintainers:

+ Bahar Tercan (GitHub bhrtrcn)
+ Jordan Lee (GitHub jordan2lee)
