#!/usr/bin/env bash
# 01_download_sra.sh — simple SRA downloader with logging
# Edit SRR below, then run: ./workflow/scripts/01_download_sra.sh
PROJECT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$PROJECT_DIR"   # <-- always start in project root
SAMPLES=("ERR1898482" "ERR1898484" "ERR13935197")         # <-- change this if you want another run
RAW_DIR="data/raw"         # where FASTQs will be saved

mkdir -p "$RAW_DIR" workflow/logs

for SRR in "${SAMPLES[@]}";do
	LOG="workflow/logs/01_download_${SRR}.log"
	echo "[INFO] Downloading $SRR" | tee "$LOG"

	# 1) fetch from SRA
	prefetch "$SRR" 2>&1 | tee -a "$LOG"

	# 2) convert to FASTQ
	fasterq-dump --split-files -O "$RAW_DIR" "$SRR" 2>&1 | tee -a "$LOG"

	# 3) compress (optional, ignore errors if pigz not installed)
	pigz -f "$RAW_DIR/${SRR}_1.fastq" 2>>"$LOG" || true
	pigz -f "$RAW_DIR/${SRR}_2.fastq" 2>>"$LOG" || true

	echo "[DONE] FASTQs are in $RAW_DIR" | tee -a "$LOG"
done
	
ls -lh "$RAW_DIR"/*.fastq.gz | tee -a "workflow/logs/01_download_summary.log"

