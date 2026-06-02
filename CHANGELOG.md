# Changelog

All notable changes to this project will be documented in this file.

## [v1.0.4](https://github.com/somaz94/helm-chart-release-action/compare/v1.0.3...v1.0.4) (2026-06-02)

### Bug Fixes

- harden gh-pages staging dir cleanup and dotfile copy ([c4c3ff6](https://github.com/somaz94/helm-chart-release-action/commit/c4c3ff69f0598192e7157648537d516947d40ed9))

### Continuous Integration

- add concurrency guards to recurring workflows ([fc789aa](https://github.com/somaz94/helm-chart-release-action/commit/fc789aa0206f6b4a7e76f4c61d20576b594c1ba7))

### Contributors

- somaz

<br/>

## [v1.0.3](https://github.com/somaz94/helm-chart-release-action/compare/v1.0.2...v1.0.3) (2026-05-04)

### Bug Fixes

- gate appVersion override by GITHUB_REF_TYPE to skip non-tag triggers ([a8b91fc](https://github.com/somaz94/helm-chart-release-action/commit/a8b91fcf6fe2c7d1e0a7ba82c08b1d9b891d5275))

### Chores

- drop unused docker dependabot ecosystem (composite action, no Dockerfile) ([c77df68](https://github.com/somaz94/helm-chart-release-action/commit/c77df685c076ab1ceb7282d18d34c08527f8970f))
- set CODEOWNERS to @somaz94 ([b66a14d](https://github.com/somaz94/helm-chart-release-action/commit/b66a14dd8a4f8c2acd29b3ea13aa26ed0dd05d9d))

### Contributors

- somaz

<br/>

## [v1.0.2](https://github.com/somaz94/helm-chart-release-action/compare/v1.0.1...v1.0.2) (2026-04-21)

### Bug Fixes

- use 'latest' string for helm_version (azure/setup-helm v5 rejects empty) ([062ccac](https://github.com/somaz94/helm-chart-release-action/commit/062ccac5fd0a8614d2abb771b8b59babbf73a2a4))

### Contributors

- somaz

<br/>

## [v1.0.1](https://github.com/somaz94/helm-chart-release-action/compare/v1.0.0...v1.0.1) (2026-04-21)

### Code Refactoring

- drop helm_version pin, use azure/setup-helm latest by default ([0411642](https://github.com/somaz94/helm-chart-release-action/commit/04116427867103e9091e85a3437a3fab6225465a))

### Contributors

- somaz

<br/>

## [v1.0.0](https://github.com/somaz94/helm-chart-release-action/releases/tag/v1.0.0) (2026-04-21)

### Features

- add update_dependencies/helm_package_args/skip_existing inputs and harden shell ([13fe12f](https://github.com/somaz94/helm-chart-release-action/commit/13fe12ff020a2d9b2552549cef770cd4e3587f0e))
- implement helm chart release composite action ([f75c773](https://github.com/somaz94/helm-chart-release-action/commit/f75c77347b38c70f6542793990f7247e7b177d9f))

### Bug Fixes

- move OCI push before gh-pages and use workspace path (Docker action cannot see /tmp) ([b9d6739](https://github.com/somaz94/helm-chart-release-action/commit/b9d67392c8759d08b588f2da0fc4cb91afd4b375))

### Continuous Integration

- add release, mirror, and changelog workflows ([d73651c](https://github.com/somaz94/helm-chart-release-action/commit/d73651c8fdbf948625e442a93de828e276cc6bbc))

### Chores

- remove unused container-action template files ([599e011](https://github.com/somaz94/helm-chart-release-action/commit/599e011ebc36cc6216f1b813ea69fa6fba2cdb61))

### Contributors

- somaz

<br/>

