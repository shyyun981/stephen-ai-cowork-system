# stephen-ai-cowork

Production-ready scaffolding for Stephen's AI cowork system: a single repository that hosts the agent/skill operating layer, Python automation, and defense-AI example projects used for HII/DLA work, the GMU SEOR PhD, and portfolio delivery.

Positioning: Defense AI and decision systems data scientist who builds practical, trustworthy analytics platforms for operational risk, supply chain resilience, and executive decision-making.

## What this repo is

- Operating layer — `agents.md`, `memory.md`, `context/`, `skills/` define how the AI cowork system behaves.
- Automation layer — `src/cowork` and `src/automation` hold reusable Python utilities: config loading, I/O, logging, weekly manager report rendering, paper curation, email drafting.
- Projects layer — `src/projects/` contains production-shaped example projects. The current anchor example is Critical Materials Supply Chain Risk Scoring, aligned with the HII / DLA Strategic Materials mission theme.
- Delivery layer — `outputs/`, `reports/`, `dashboards/` collect the tangible artifacts the cowork system produces.

Everything is public-safe: synthetic/open-source data only, no government data, no controlled unclassified information.

## Quickstart

```bash
# 1. Clone and create a virtual env
git clone <your-remote> stephen-ai-cowork && cd stephen-ai-cowork
python -m venv .venv && source .venv/bin/activate   # Windows: .venv\Scripts\activate

# 2. Install
make dev                       # or: pip install -r requirements.txt && pip install -e ".[dev,viz,notebook]"
cp .env.example .env

# 3. Run the critical-materials example end-to-end
make sample                    # synthetic 25-material dataset → data/sample/
make risk                      # risk scores → outputs/risk_scores.csv
make scenario                  # rare-earths shock scenario → outputs/scenario_rare_earths.csv
make report                    # weekly manager report → reports/weekly_manager_report.md

# 4. Tests
make test
```

The same flow is available via the `cowork` CLI:

```bash
cowork --help
cowork sample --n 25 --out data/sample/critical_materials_sample.csv
cowork risk --input data/sample/critical_materials_sample.csv --out outputs/risk_scores.csv
cowork scenario --input data/sample/critical_materials_sample.csv --shock rare_earths --out outputs/scenario_rare_earths.csv
cowork report --out reports/weekly_manager_report.md
```

## Docker

```bash
make docker-build
make docker-run                # runs `cowork --help` inside the container
make jupyter                   # JupyterLab at http://localhost:8888 (no token)
```

`docker-compose.yml` mounts `data/`, `outputs/`, `reports/`, and `notebooks/` so generated artifacts persist on the host.

## Repository structure

```text
stephen-ai-cowork/
├── agents.md                    # AI cowork operating role
├── memory.md                    # persistent preferences
├── context/                     # background knowledge (identity, career, HII/DLA, PhD, stack)
├── skills/                      # repeatable workflows (career, repo builder, paper curator, etc.)
├── src/
│   ├── cowork/                  # core: config, io, logging, CLI
│   ├── automation/              # weekly report, paper curator, email drafts
│   ├── projects/
│   │   └── critical_materials/  # anchor example: risk model, scenario sim, dashboard spec
│   └── utils/
├── notebooks/                   # EDA and demo notebooks
├── data/
│   ├── raw/                     # gitignored
│   ├── processed/               # gitignored
│   └── sample/                  # small, public-safe synthetic data
├── outputs/                     # model outputs, CSVs, figures
├── reports/                     # rendered manager/seminar reports
├── dashboards/                  # Power BI design specs, mockups
├── tests/                       # pytest suite
├── docs/                        # problem_statement, architecture, methodology, etc.
├── scripts/                     # one-off shell/python helpers
├── Dockerfile
├── docker-compose.yml
├── Makefile
├── pyproject.toml
├── requirements.txt
├── .env.example
└── .github/workflows/ci.yml
```

## Anchor example — Critical Materials Supply Chain Risk Scoring

Mission framing (public-safe): How should a defense logistics decision-maker prioritize critical materials under supply concentration, price volatility, lead-time, and demand-criticality uncertainty?

Pipeline
1. `projects.critical_materials.data` — synthesize a realistic 25-material dataset (rare earths, titanium, cobalt, tungsten, etc.) with country concentration, HHI, price volatility, lead time, and demand criticality.
2. `projects.critical_materials.features` — build normalized component features and weights.
3. `projects.critical_materials.risk_model` — compute a transparent composite risk score + XGBoost uplift model for priority ranking.
4. `projects.critical_materials.scenario` — simulate supply shocks (e.g., rare-earth export ban) and re-rank materials.
5. `projects.critical_materials.dashboard_spec` — emit a Power BI dashboard design spec for executive review.

Outputs shipped by `make risk` and `make scenario` are the kind of artifact that belongs in a manager memo or a PhD pre-print.

## Skills and agent layer

`agents.md` and `memory.md` describe how the cowork system behaves in Claude projects. `skills/` contains repeatable workflows (career decision advisor, PhD idea builder, paper curator, weekly manager report, Power BI dashboard planner, GitHub repo builder, defense AI project builder, email response writer, paper summary for lab seminar, Docker project starter, job transition playbook).

If you are Stephen and you are reading this from inside a Claude project, the system loads `agents.md` → `memory.md` → relevant `context/` files → the requested skill file, in that order.

## Development

```bash
make lint      # ruff
make test      # pytest
make clean     # remove caches
```

CI runs lint + tests on Python 3.10 and 3.11 via `.github/workflows/ci.yml`.

## Assumptions (marked)

- The example dataset is fully synthetic and is not a proxy for any specific government program.
- The risk scoring weights are illustrative defaults and should be calibrated against a real decision context before use.
- The repo is designed to be public-safe; do not commit raw government data, CUI, or API keys.

## Roadmap

- v0.1 — This skeleton: operating layer + critical-materials example + CI + Docker.
- v0.2 — Maritime domain awareness example (AIS anomaly detection).
- v0.3 — Predictive maintenance example with XGBoost + decision-support ranking.
- v0.4 — Semantic data-dictionary assistant (embeddings + simple retrieval).
- v0.5 — Streamlit/FastAPI demo surface + one publishable workshop paper draft.

## License

MIT — see `LICENSE`.
