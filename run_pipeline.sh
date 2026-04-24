#!/usr/bin/env bash
# End-to-end pipeline for the critical-materials example.
set -euo pipefail

cd "$(dirname "$0")/.."
cowork sample   --n 25   --out data/sample/critical_materials_sample.csv
cowork risk     --input data/sample/critical_materials_sample.csv --out outputs/risk_scores.csv
cowork scenario --input data/sample/critical_materials_sample.csv --shock rare_earths --out outputs/scenario_rare_earths.csv
cowork report   --out reports/weekly_manager_report.md
echo "Pipeline complete. See outputs/ and reports/."
