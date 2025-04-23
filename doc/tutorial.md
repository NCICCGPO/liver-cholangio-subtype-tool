# Tutorial

Copy contents of `data/example_caseids.txt` into the Repository Tab at GDC data portal. Select the following filters: 

Experimental Strategy `RNA-Seq`
Data Category `transcriptome profiling`
Data Type `Gene Expression Quantification`
Data Format `tsv`
Workflow Type `STAR - Counts`

The total number of files selected should show 8 files. Next select the Manifest button and save it as `data/gdc_manifest.txt`. And select the Sample Sheet button and save it as `data/gdc_sample_sheet.tsv`

Install [GDC Data Transfer Tool Client](https://gdc.cancer.gov/access-data/gdc-data-transfer-tool). For usage details, refer to the official [GDC Users Guide](https://docs.gdc.cancer.gov/Data_Transfer_Tool/Users_Guide/Getting_Started/)

Download gene expression data
```bash
gdc-client download -m src/gdc_manifest.txt --dir data/example_raw_data
```

Consolidate into 1 file
```bash
python scripts/merge_gdc_data.py --sample_sheet data/gdc_sample_sheet.tsv --dir data/example_raw_data --out data/example_data.tsv
```
 