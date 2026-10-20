# Changelog

All notable changes to this project will be documented in this file.

## [v1.0.5](https://github.com/somaz94/helm-chart-release-action/compare/v1.0.4...v1.0.5) (2026-10-20)

### Bug Fixes

- keep previously published charts on gh-pages instead of wiping helm-repo ([3958b04](https://github.com/somaz94/helm-chart-release-action/commit/3958b044af847bc7de347cd20ffc44d1f74607a5))

### Continuous Integration

- adopt the shared git-cliff template to skip changelog commits and duplicate lines ([484b58c](https://github.com/somaz94/helm-chart-release-action/commit/484b58cffcfd1c6e6525af17731f7d3f56c732d0))
- trim redundant comments in gitlab-mirror workflow ([e5cd6ad](https://github.com/somaz94/helm-chart-release-action/commit/e5cd6adbff23fe88ced1cd07daa704b2e5e5a438))
- retry mirror pushes on transient remote failures ([3250a73](https://github.com/somaz94/helm-chart-release-action/commit/3250a73b52943523916b65bdb7bb67db23b1e1b4))
- drop the dead issue-close trigger from changelog generation ([63ed1d9](https://github.com/somaz94/helm-chart-release-action/commit/63ed1d90995bda0c24e721940ecb10dd45f7860e))
- remove DCO workflow ([f89241d](https://github.com/somaz94/helm-chart-release-action/commit/f89241dd2bb1764313d1de6cd016395b8acf87fe))
- adopt semantic-pr, labels, lock-threads, PR size, and auto-assign reusables ([b653930](https://github.com/somaz94/helm-chart-release-action/commit/b653930075ad05a3591ea030c0e6ff41f2c9df95))
- use reusable stale-issues workflow ([83cb05b](https://github.com/somaz94/helm-chart-release-action/commit/83cb05b02d42a1f39eab0795799f832ddc2270de))
- use reusable issue-greeting workflow ([c54728b](https://github.com/somaz94/helm-chart-release-action/commit/c54728b49acb0798894c52d2df5130629b8795a2))
- use reusable dependabot-auto-merge workflow ([0b00c90](https://github.com/somaz94/helm-chart-release-action/commit/0b00c90320fdc1cd6e1b06ff12a86e47d11c8022))
- use reusable contributors workflow ([bbe287f](https://github.com/somaz94/helm-chart-release-action/commit/bbe287f986f7dc1ddd4dd2d6bef836603da9deaa))
- add ok-to-test workflow stub ([1486404](https://github.com/somaz94/helm-chart-release-action/commit/1486404b6ae15006860da2ac3b36509341ed35eb))
- add PR welcome workflow stub ([541c883](https://github.com/somaz94/helm-chart-release-action/commit/541c883114b6183c1280d84283940fc10b97acaf))
- add DCO check via shared reusable workflow ([e4c1883](https://github.com/somaz94/helm-chart-release-action/commit/e4c1883a966f0422bfd8ca4092097f7a180f2a00))

### Chores

- drop Node.js boilerplate from .gitignore ([6e1f174](https://github.com/somaz94/helm-chart-release-action/commit/6e1f1747005fa74564c73dbedda65eddadcd87ab))
- trim redundant comments in CODEOWNERS ([e974c3d](https://github.com/somaz94/helm-chart-release-action/commit/e974c3d3fd42c90e27c9455d49dad5c913bfe804))
- **deps:** bump actions/checkout from 6 to 7 (#2) ([#2](https://github.com/somaz94/helm-chart-release-action/pull/2)) ([b64bac4](https://github.com/somaz94/helm-chart-release-action/commit/b64bac4da44ac87f6cdd90d7f506b1744f1769df))

### Contributors

- somaz

<br/>

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

