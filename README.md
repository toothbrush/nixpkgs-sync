# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`11a69ecd225a`](https://github.com/NixOS/nixpkgs/commit/11a69ecd225a081a44ed1950cd540e98ca47e6df) | 2026-11-07 06:10 UTC | ✅ |
| `nixos-unstable` | [`1d060086d60c`](https://github.com/NixOS/nixpkgs/commit/1d060086d60cb76a40cf37109f979d88a5bd6396) | 2026-11-07 06:10 UTC | ✅ |
| `nixos-26.05` | [`c56a87d8e41c`](https://github.com/NixOS/nixpkgs/commit/c56a87d8e41ce69bd2af57eb35dcc117a9dfca33) | 2026-11-07 06:10 UTC | ✅ |
| `nixpkgs-unstable` | [`6dadaf4375be`](https://github.com/NixOS/nixpkgs/commit/6dadaf4375be35033e1c84395adbd53ff5fded96) | 2026-11-07 06:10 UTC | ✅ |

Every 6 hours, this repo mirrors the branches in `branches.txt` from [NixOS/nixpkgs](https://github.com/NixOS/nixpkgs) to [`/et/toothbrush/nixpkgs`](https://entire.io/et/toothbrush/nixpkgs) on Entire, as `upstream/<branch>`.

Clone with `git clone entire://aws-ap-southeast-2.entire.io/et/toothbrush/nixpkgs`.

## Run your own

The workflow stores no secret. [`entireio/setup-entire`](https://github.com/entireio/setup-entire) trades the job's GitHub OIDC token for a short-lived Entire token. [git-sync](https://github.com/entireio/git-sync) then pushes the branches over `entire://`.

1. Install [`entire`](https://github.com/entireio/cli) v0.13.1 or later.
2. Create a service account that can write to the target repo. Bind it to the GitHub repo that runs the workflow:

   ```bash
   entire sa create toothbrush nixpkgs-sync
   entire sa grant toothbrush/nixpkgs-sync --repo nixpkgs --role writer
   entire sa bind toothbrush/nixpkgs-sync --provider github-actions \
     --pin repository=toothbrush/nixpkgs-sync --pin ref=refs/heads/main
   ```

   The `ref` pin gives a token only to runs on `main`.
3. Put the `svc_` ID that `create` prints in `service-account:` in [`.github/workflows/sync.yml`](.github/workflows/sync.yml).
4. Set `SOURCE` and `TARGET` in the workflow, and list your branches in `branches.txt`.

The job needs `permissions: id-token: write` to get an OIDC token. It needs `contents: write` only to commit this README.

<sub>This file is generated from `README.md.template`; edit that instead.</sub>
