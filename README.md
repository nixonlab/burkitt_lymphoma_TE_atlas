# Burkit Lymphoma TE Atlas
TE quantification (Telescope) pipeline for Burkitt Lymphoma bulk RNA-seq samples

**Project:** Burkitt's Lymphoma (BLGSP)

**To get DAG:** 

``` snakemake --profile profiles/aws  --forceall --dag | dot -Tpdf > dag.pdf   ```

**To get rule graph:** 

``` snakemake --profile profiles/aws  --forceall --rulegraph | dot -Tpdf > rulegraph.pdf   ```

**To get file graph:** 

``` snakemake --profile profiles/aws  --forceall --filegraph | dot -Tpdf > filegraph.pdf   ```

**To run pipeline:**

``` snakemake --profile profiles/aws/ all ```

**To modify pipeline:**

Change sample download table. 
