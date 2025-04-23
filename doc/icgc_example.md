# ICGC Dataset Example

The two ICGC datasets that were used in the analysis can be downloaded from the publication page.


LICA-FR_normalized_read_count.tsv contains gene expression data using Ensembl IDs, whereas LIRI-JP_normalized_read_count.tsv uses Hugo gene symbols. Both can be ran by specifying the appropriate `gene naming` mode - either **"ensembl"** or **"hugo"**

Example 1:

```bash
docker run --rm -v ./:$(pwd) docker.synapse.org/syn29568296/lihcchol_classifier $(pwd)/data/LICA-FR_normalized_read_count.tsv ensembl $(pwd)/results/France
```

Example 2:

```bash
docker run --rm -v ./:$(pwd) docker.synapse.org/syn29568296/lihcchol_classifier $(pwd)/data/LIRI-JP_normalized_read_count.tsv hugo $(pwd)/results/Japan
```


> If image was built directly by following the instructions at [Docker Image Page](doc/pull_image.md) then replace "docker.synapse.org/syn29568296/lihcchol_classifier" with "lihcchol_classifier"