# CLAUDE.md

<br/>

## Project Structure

- Composite GitHub Action (no Docker image — `runs.using: composite`)
- One-shot helm chart release: `helm package` → gh-pages publish → OCI registry push
- Two modes: `single` (one chart_path) and `multi` (charts_dir scan)
- Internally delegates OCI push to [somaz94/helm-oci-push-action](https://github.com/somaz94/helm-oci-push-action) — no code duplication

<br/>

## Key Files

- `action.yml` — composite action (17 inputs, 2 outputs). All logic is inline `shell: bash` steps + one `uses: somaz94/helm-oci-push-action@v1` step
- `cliff.toml` — git-cliff config for release notes
- `Makefile` — `lint` (dockerized yamllint), `fixtures`, `clean`

<br/>

## Build & Test

There is no local "build" — composite actions execute on the GitHub Actions runner.

```bash
make lint            # yamllint action.yml + workflows
make fixtures        # create local fixture chart for manual workflow_dispatch tests
make clean           # remove fixtures and helm-repo artifacts
```

To exercise the action locally with [`act`](https://github.com/nektos/act):

```bash
act -W .github/workflows/ci.yml workflow_dispatch
```

<br/>

## Workflows

- `ci.yml` — matrix(`single`/`multi`) dry-run verification with `enable_gh_pages: false`, `enable_oci_push: true`, `dry_run: true`, `registry_login: false`. Verifies `pushed_charts` is empty and `skipped_charts` contains the fixture
- `release.yml` — git-cliff release notes + `softprops/action-gh-release` + `somaz94/major-tag-action` for `v1` sliding tag
- `use-action.yml` — post-release smoke tests: real OCI push (single + multi) to `oci://ghcr.io/<owner>/test-helm-chart-release` + dry-run sanity check
- `gitlab-mirror.yml`, `changelog-generator.yml`, `contributors.yml`, `dependabot-auto-merge.yml`, `issue-greeting.yml`, `stale-issues.yml` — standard repo automation

<br/>

## Release

Push a `vX.Y.Z` tag → `release.yml` runs → GitHub Release published → `v1` major tag updated → `use-action.yml` smoke-tests the published version.

<br/>

## Action Inputs

Required: `mode` (`single` | `multi`).

Mode-specific: `chart_path` (single), `charts_dir` (multi).

gh-pages toggle: `enable_gh_pages` (default `true`), `gh_pages_url` (required when enabled), `gh_pages_branch`, `commit_message`, `git_user_name`, `git_user_email`.

OCI toggle: `enable_oci_push` (default `true`), `registry`, `registry_login`, `registry_username`, `registry_password`, `oci_continue_on_error`.

Other: `update_appversion`, `helm_version`, `dry_run`. See [README.md](README.md) for the full table.

<br/>

## Internal Flow

1. `azure/setup-helm@v5` installs Helm
2. (single + flag) `sed` updates `Chart.yaml` `appVersion` from `GITHUB_REF_NAME`
3. `helm package` → `helm-repo/`
4. Stage to `/tmp/helm-repo-staging/` so files survive the gh-pages branch switch
5. (gh-pages on) merge existing `index.yaml` → switch to `gh-pages` → restore staged files → commit + push
6. (oci on) call `somaz94/helm-oci-push-action@v1` with `tarballs: /tmp/helm-repo-staging/*.tgz`
