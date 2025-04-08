# Set Up

Assumes you've installed Docker

Start up Docker/Docker Desktop
```bash
docker build -t lihcchol_classifier:latest -f .build/Dockerfile .
```

# Run Classifier

The classifier has multiple parameter inputs: `filename`, `gene naming`, and `output folder`

+ The two modes for `gene naming` are **ensembl** and **hugo**

```bash
docker run -v ./:$(pwd) lihcchol_classifier  $(pwd)/data/inputdata.tsv  ensembl  $(pwd)/results/outputfolder
```

This will result in two output files:

1. assignment.tsv
2. assignment_confidence.tsv

In the example below the input

> ```bash
> docker run -v ./:$(pwd) lihcchol_classifier $(pwd)/data/LICA-FR_normalized_read_count.tsv ensembl $(pwd)/results/France
>```

> ```bash
> docker run -v ./:$(pwd) lihcchol_classifier $(pwd)/data/LIRI-JP_normalized_read_count.tsv hugo $(pwd)/results/Japan
>```
