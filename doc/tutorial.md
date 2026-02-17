# Tutorial

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

## Download TCGA Gene Expression data
Copy contents of `data/example_caseids.txt` into the Repository Tab at GDC data portal. Select the following filters: 

Experimental Strategy `RNA-Seq`
Data Category `transcriptome profiling`
Data Type `Gene Expression Quantification`
Data Format `tsv`
Workflow Type `STAR - Counts`

The total number of files selected should show 8 files. Next select the Manifest button and save it as `data/gdc_manifest.txt`. And select the Sample Sheet button and save it as `data/gdc_sample_sheet.tsv`

Install [GDC Data Transfer Tool Client](https://gdc.cancer.gov/access-data/gdc-data-transfer-tool). For usage details, refer to the official [GDC Users Guide](https://docs.gdc.cancer.gov/Data_Transfer_Tool/Users_Guide/Getting_Started/)

Download gene expression data and merge into one gene expression file
```bash
gdc-client download -m src/gdc_manifest.txt --dir data/example_raw_data

python scripts/merge_gdc_data.py --sample_sheet data/gdc_sample_sheet.tsv --dir data/example_raw_data --out data/example_data.tsv
```

This creates the file `data/example_data.tsv` that will be used directly by the classifier tool.

 ## Run tool: Obtain LIHCCHOL Subtype Classifications
 Subtype classifications can now be assigned to each sample. We will use the TCGA gene expression file `data/example_data.tsv`.

 ```bash
 docker run --rm -v ./:$(pwd) lihcchol_classifier $(pwd)/data/example_data.tsv   ensembl  $(pwd)/outputfolder
 ```

 The last three arguments are the gene expression data, gene feature mode (`ensembl` or `hugo` are accepted), and the output folder name.

### Inspect results

Two output files are created. The first contains the assigned subtype classification for each sample.
```bash
cat outputfolder/assignment.tsv 
```

| SampleID	| Assignment | Assignment_shortname |
| :---    |  :----:   |  ---: |
| sample1	| Focal genomic instability | FIST |
| sample2	| Hepatocyte like stem | Hep-like Stem |
| sample3	| Focal genomic instability | FIST |
| sample4	|  Focal genomic instability | FIST |
| sample5	| Inflammatory | Inflammatory |
| ...        |   ...    |


The second file contains information on model confidence for each sample. The subtype with the highest confidence is the assigned sutype found in the first file.
```bash
cat outputfolder/assignment_confidence.tsv
```

| SampleID              | Wnt pathway activated | Cholangiocyte like stem | Hepatocyte like stem | Inflammatory        | Focal genomic instability |
|-----------------------|----------------------|--------------------------|----------------------|--------------------|---------------------------|
| sample1      | 0.019491904761904762 | 0.0086                   | 0.004946666666666666 | 0.09395428571428573 | 0.8730071428571428        |
| sample2     | 0.010566666666666665 | 0.04947857142857142      | 0.8326445238095237   | 0.06576357142857144 | 0.04154666666666667       |
| sample3      | 0.020771904761904766 | 0.01                     | 0.012066666666666667 | 0.1007442857142857  | 0.856417142857143         |
| sample4     | 0.06094666666666667  | 0.019                    | 0.02449              | 0.06654333333333333 | 0.8290200000000001        |
| sample5      | 0.0302387034044387   | 0.010594285714285716     | 0.0022               | 0.9278027085169733  | 0.029164302364302366      |
| ...     | ...  | ...    | ... | ...   | ...       |
