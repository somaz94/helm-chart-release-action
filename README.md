# helm-chart-release-action

[![CI](https://github.com/somaz94/helm-chart-release-action/actions/workflows/ci.yml/badge.svg)](https://github.com/somaz94/helm-chart-release-action/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Latest Tag](https://img.shields.io/github/v/tag/somaz94/helm-chart-release-action)](https://github.com/somaz94/helm-chart-release-action/tags)
[![Top Language](https://img.shields.io/github/languages/top/somaz94/helm-chart-release-action)](https://github.com/somaz94/helm-chart-release-action)
[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Helm%20Chart%20Release-blue?logo=github)](https://github.com/marketplace/actions/helm-chart-release)

A composite GitHub Action that packages Helm charts, publishes them to a `gh-pages` branch as a Helm repo, and pushes them to an OCI registry — all in one step. Internally delegates OCI push to [somaz94/helm-oci-push-action](https://github.com/somaz94/helm-oci-push-action).

<br/>

## Features

- One action for the full release pipeline: **`helm package`** → **gh-pages index merge + publish** → **OCI registry push**
- Two modes: `single` (one chart_path) and `multi` (scan every subdirectory of `charts_dir`)
- Independent **toggles**: `enable_gh_pages`, `enable_oci_push`
- **`dry_run`** for PR validation (no gh-pages commit, no OCI push)
- Automatic `appVersion` bump from the release tag (single mode)
- Ships with `azure/setup-helm@v5` (helm v3.16.4 by default, configurable)

<br/>

## Quick Start

### Single chart (most common — one chart per repo)

```yaml
name: Helm Chart Release
on:
  push:
    tags:
      - "v[0-9]+.[0-9]+.[0-9]+"
  workflow_dispatch:

permissions:
  contents: write
  packages: write

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 0
          token: ${{ secrets.PAT_TOKEN }}

      - uses: somaz94/helm-chart-release-action@v1
        with:
          mode: single
          chart_path: ./helm/my-app
          gh_pages_url: https://somaz94.github.io/my-app/helm-repo
          registry_password: ${{ secrets.GITHUB_TOKEN }}
```

<br/>

### Multi-chart (a `charts/` directory with several charts)

```yaml
- uses: somaz94/helm-chart-release-action@v1
  with:
    mode: multi
    charts_dir: charts
    gh_pages_url: https://somaz94.github.io/my-charts/helm-repo
    registry_password: ${{ secrets.GITHUB_TOKEN }}
```

<br/>

## Usage

### Skip gh-pages, OCI only

```yaml
- uses: somaz94/helm-chart-release-action@v1
  with:
    mode: single
    chart_path: ./helm/my-app
    enable_gh_pages: false
    registry_password: ${{ secrets.GITHUB_TOKEN }}
```

<br/>

### Skip OCI, gh-pages only

```yaml
- uses: somaz94/helm-chart-release-action@v1
  with:
    mode: single
    chart_path: ./helm/my-app
    gh_pages_url: https://somaz94.github.io/my-app/helm-repo
    enable_oci_push: false
```

<br/>

### Dry-run for PR validation

```yaml
- uses: somaz94/helm-chart-release-action@v1
  with:
    mode: single
    chart_path: ./helm/my-app
    gh_pages_url: https://somaz94.github.io/my-app/helm-repo
    dry_run: true
    registry_password: ${{ secrets.GITHUB_TOKEN }}
```

<br/>

### Idempotent release (skip charts already in the registry)

```yaml
- uses: somaz94/helm-chart-release-action@v1
  with:
    mode: multi
    charts_dir: charts
    gh_pages_url: https://somaz94.github.io/my-charts/helm-repo
    skip_existing: true
    registry_password: ${{ secrets.GITHUB_TOKEN }}
```

<br/>

### Charts with subchart dependencies

```yaml
- uses: somaz94/helm-chart-release-action@v1
  with:
    mode: single
    chart_path: ./helm/my-app
    update_dependencies: true   # runs `helm dependency update` first
    gh_pages_url: https://somaz94.github.io/my-app/helm-repo
    registry_password: ${{ secrets.GITHUB_TOKEN }}
```

<br/>

### Override version with `helm package` extra args

```yaml
- uses: somaz94/helm-chart-release-action@v1
  with:
    mode: single
    chart_path: ./helm/my-app
    helm_package_args: --version 1.2.3 --app-version 1.2.3
    gh_pages_url: https://somaz94.github.io/my-app/helm-repo
    registry_password: ${{ secrets.GITHUB_TOKEN }}
```

<br/>

### Push to a different registry (Harbor / ECR / GAR)

Pass a full OCI URL. If you've already authenticated via a provider-specific action, set `registry_password` empty and toggle login off via the underlying action — or use `helm-oci-push-action` directly for more control.

```yaml
- uses: somaz94/helm-chart-release-action@v1
  with:
    mode: multi
    charts_dir: charts
    enable_gh_pages: false
    registry: oci://harbor.example.com/charts
    registry_username: ${{ secrets.HARBOR_USER }}
    registry_password: ${{ secrets.HARBOR_TOKEN }}
```

<br/>

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `mode` | `single` or `multi` | Yes | — |
| `chart_path` | Chart directory (mode=single) | single | `''` |
| `charts_dir` | Directory with chart subdirectories (mode=multi) | multi | `''` |
| `update_appversion` | Bump Chart.yaml `appVersion` from `GITHUB_REF_NAME` | No | `true` |
| `update_dependencies` | Run `helm dependency update` before packaging (for charts with subchart dependencies) | No | `false` |
| `helm_package_args` | Extra CLI args forwarded to `helm package` (e.g., `--version 1.2.3 --app-version 1.2.3`) | No | `''` |
| `enable_gh_pages` | Publish to gh-pages branch | No | `true` |
| `enable_oci_push` | Push to OCI registry | No | `true` |
| `gh_pages_url` | Helm repo base URL (required when `enable_gh_pages=true`) | conditional | `''` |
| `gh_pages_branch` | gh-pages branch name | No | `gh-pages` |
| `commit_message` | gh-pages commit message | No | `chore: update helm chart repository` |
| `git_user_name` | gh-pages commit author name | No | `GitHub Actions` |
| `git_user_email` | gh-pages commit author email | No | `actions@github.com` |
| `registry` | Target OCI registry URL | No | `oci://ghcr.io/${{ github.repository_owner }}/charts` |
| `registry_login` | Forwarded to helm-oci-push-action: log in inside the action | No | `true` |
| `registry_username` | OCI username | No | `${{ github.actor }}` |
| `registry_password` | OCI token (typically `secrets.GITHUB_TOKEN` for GHCR) | No | `''` |
| `skip_existing` | Forwarded to helm-oci-push-action: skip chart@version already in registry (idempotent) | No | `false` |
| `helm_version` | Helm CLI version for `azure/setup-helm` | No | `v3.16.4` |
| `dry_run` | Skip actual commit/push (both gh-pages and OCI) | No | `false` |
| `oci_continue_on_error` | Forwarded to `helm-oci-push-action` | No | `true` |

<br/>

## Outputs

| Output | Description |
|--------|-------------|
| `pushed_charts` | Comma-separated `name:version` pairs pushed to OCI |
| `skipped_charts` | Comma-separated `name:version` pairs skipped (dry-run or already exists) |

<br/>

## Permissions

Caller workflow needs:

```yaml
permissions:
  contents: write   # for gh-pages commit
  packages: write   # for GHCR push
```

And `actions/checkout` with `fetch-depth: 0` + a PAT token (so the action can push to `gh-pages`):

```yaml
- uses: actions/checkout@v6
  with:
    fetch-depth: 0
    token: ${{ secrets.PAT_TOKEN }}
```

<br/>

## How It Works

1. **`azure/setup-helm`** installs Helm (`helm_version`, default v3.16.4).
2. **`update_appversion`** (single mode): rewrites `Chart.yaml` `appVersion` from `GITHUB_REF_NAME`.
3. **`helm package`** produces `.tgz`(s) in `helm-repo/`.
4. **Stage**: tarballs are copied to `/tmp/helm-repo-staging/` so they survive the branch switch.
5. **gh-pages** (`enable_gh_pages=true`): pulls existing `index.yaml`, merges, switches to the `gh-pages` branch, restores staged files, commits, and pushes.
6. **OCI push** (`enable_oci_push=true`): delegates to `somaz94/helm-oci-push-action@v1` with `tarballs: /tmp/helm-repo-staging/*.tgz`.

<br/>

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
