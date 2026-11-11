#!/usr/bin/env bash
# Re-download the open-access arXiv PDFs of the research library (not redistributed here).
# Usage: scripts/fetch_pdfs.sh   (run from the repository root)
set -euo pipefail
dir="library/pdfs"
tail -n +2 "$dir/MANIFEST.tsv" | while IFS=$'\t' read -r file id url; do
  [ -f "$dir/$file" ] && continue
  echo "fetching $id"
  curl -sSfL -A "yang-mills-lean-library/0.2" "$url" -o "$dir/$file" || echo "  failed: $id"
  sleep 3
done
