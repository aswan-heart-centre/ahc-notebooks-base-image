# AHC Docker Base Image

This repo aims to serve as the parent image for child Docker images created in [`ahc-notebooks`](https://github.com/aswan-heart-centre/ahc-notebooks), [`ahc-data-import`](https://github.com/aswan-heart-centre/ahc-data-import), and [`ahc-analytics/flaskapi`](https://github.com/aswan-heart-centre/ahc-analytics).

Following the semantic vresioning approach, the image is tagged as `v*.*.*` for the image as a whole:

- Patch: added fixes only (backward-compatible)
- Minor: added new features (backward-compatible)
- Major: has breaking changes

## Smoke test

Run a quick image readiness check locally:

```bash
./scripts/smoke-test.sh
```

The smoke test verifies:
- container runs as expected user
- expected working directory exists
- Python and dependency integrity (`pip check`)
- critical imports used by downstream projects

This same smoke test runs automatically in GitHub Actions on pull requests and before image publishing on tagged releases.
