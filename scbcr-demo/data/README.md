# scbcr-demo

Single-cell BCR (10x V(D)J) analysis demo aligned to JD priorities:
- Robust pipeline for **QC, annotation, prioritization** of heavy/light (±VHH).
- Reproducible (conda env, GitHub; Docker optional later).
- Outputs: 1H+1L pairing rates, clonotype stats, isotype usage, V–J maps, diversity, UMAP+clone overlays (if GEX available).

## Data layout
- `data/vdj/`: 10x VDJ outputs (`all_contig_annotations.csv`, `clonotypes.csv`)
- `data/gex/`: 10x GEX (`filtered_feature_bc_matrix.h5`)

## Data From
https://www.10xgenomics.com/datasets/human-b-cells-from-a-healthy-donor-1-k-cells-2-standard-6-0-0?utm_source
## Run
