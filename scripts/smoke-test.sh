#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="${1:-ahc-base:test}"

echo "Building image: ${IMAGE_TAG}"
docker build -t "${IMAGE_TAG}" .

echo "Running smoke checks in container: ${IMAGE_TAG}"
docker run --rm "${IMAGE_TAG}" bash -lc '
  whoami &&
  test -d /home/jovyan/work/notebooks &&
  python --version &&
  {
    # This conflict is currently expected because plotly-calplot is installed with --no-deps.
    allowed_conflict_prefix="plotly-calplot 0.1.20 has requirement "

    set +e
    pip_output="$(pip check 2>&1)"
    pip_status=$?
    set -e

    if [ "$pip_status" -eq 0 ]; then
      echo "pip check passed"
    else
      echo "$pip_output"
      unexpected_conflicts="$(printf "%s\n" "$pip_output" | while IFS= read -r line; do
        case "$line" in
          "$allowed_conflict_prefix"*) ;;
          "") ;;
          *) printf "%s\n" "$line" ;;
        esac
      done)"

      if [ -n "$unexpected_conflicts" ]; then
        echo "$unexpected_conflicts"
        echo "Unexpected pip dependency conflicts detected"
        exit 1
      fi

      echo "Only known plotly-calplot dependency conflicts detected; continuing"
    fi
  } &&
  python - <<PY
import pandas, numpy, plotly, flask, sqlalchemy
import plotly_calplot
print("imports-ok")
PY
'

echo "Smoke test passed for ${IMAGE_TAG}"
