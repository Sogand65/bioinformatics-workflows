#! /usr/bin/env bash
# 02_run_trust4.sh — run TRUST4 on multiple paired-end FASTQs with logging

PROJECT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$PROJECT_DIR"   # <-- always start in project root

SAMPLES=("ERR1898482" "ERR1898484" "ERR13935197")   # runs you downloaded
REF_DIR="$HOME/Desktop/bioinformatics/TRUST4"       # adjust if TRUST4 is elsewhere
RAW_DIR="data/raw"
OUT_DIR="data/processed"

mkdir -p "$OUT_DIR" workflow/logs

for SRR in "${SAMPLES[@]}"; do
    LOG="workflow/logs/02_trust4_${SRR}.log"
    FQ1="$RAW_DIR/${SRR}_1.fastq.gz"
    FQ2="$RAW_DIR/${SRR}_2.fastq.gz"
    OUT_PREFIX="${OUT_DIR}/${SRR}"   # <-- unique prefix per sample

    echo "[INFO] Running TRUST4 on $SRR" | tee "$LOG"

    run-trust4 \
        -f "${REF_DIR}/hg38_bcrtcr.fa" \
        --ref "${REF_DIR}/human_IMGT+C.fa" \
        -1 "$FQ1" \
        -2 "$FQ2" \
        -o "$OUT_PREFIX" 2>&1 | tee -a "$LOG"

    echo "[DONE] TRUST4 finished. Outputs in $OUT_PREFIX" | tee -a "$LOG"
done
