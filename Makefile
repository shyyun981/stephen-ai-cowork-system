.PHONY: help install dev lint test sample risk scenario report docker-build docker-run jupyter clean

PY ?= python
PIP ?= pip

help:
	@echo "Common targets:"
	@echo "  install       Install runtime dependencies"
	@echo "  dev           Install dev dependencies + editable install"
	@echo "  lint          Run ruff"
	@echo "  test          Run pytest"
	@echo "  sample        Generate synthetic critical-materials sample data"
	@echo "  risk          Run risk-scoring pipeline on sample data"
	@echo "  scenario      Run shock scenario simulation"
	@echo "  report        Render weekly manager report from outputs/"
	@echo "  docker-build  Build docker image"
	@echo "  docker-run    Run CLI in docker"
	@echo "  jupyter       Launch JupyterLab in docker on :8888"
	@echo "  clean         Remove caches, build artifacts"

install:
	$(PIP) install -r requirements.txt

dev:
	$(PIP) install -r requirements.txt
	$(PIP) install -e ".[dev,viz,notebook]"

lint:
	ruff check src tests

test:
	pytest -q

sample:
	$(PY) -m cowork.cli sample --n 25 --out data/sample/critical_materials_sample.csv

risk:
	$(PY) -m cowork.cli risk --input data/sample/critical_materials_sample.csv --out outputs/risk_scores.csv

scenario:
	$(PY) -m cowork.cli scenario --input data/sample/critical_materials_sample.csv --shock rare_earths --out outputs/scenario_rare_earths.csv

report:
	$(PY) -m cowork.cli report --out reports/weekly_manager_report.md

docker-build:
	docker build -t stephen-ai-cowork:latest .

docker-run:
	docker compose run --rm cowork cowork --help

jupyter:
	docker compose up jupyter

clean:
	rm -rf .pytest_cache .ruff_cache .mypy_cache htmlcov build dist *.egg-info
	find . -type d -name __pycache__ -prune -exec rm -rf {} +
