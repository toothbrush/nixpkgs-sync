# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`e63e1c7947e0`](https://github.com/NixOS/nixpkgs/commit/e63e1c7947e0c45cb88c126566f94b6cf0263863) | 2026-11-28 07:59 UTC | ✅ |
| `nixos-unstable` | [`58d0d3e9d527`](https://github.com/NixOS/nixpkgs/commit/58d0d3e9d527ca7263be6a45d1f86eacdc700dab) | 2026-11-28 07:59 UTC | ✅ |
| `nixos-26.05` | [`5b31ff946309`](https://github.com/NixOS/nixpkgs/commit/5b31ff946309736077f0c4ee23bb85d0a0a1c181) | 2026-11-28 07:59 UTC | ✅ |
| `nixpkgs-unstable` | [`619c39f6eac5`](https://github.com/NixOS/nixpkgs/commit/619c39f6eac5d1ed6b8f073a9414baf7034b2356) | 2026-11-28 07:59 UTC | ✅ |

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
