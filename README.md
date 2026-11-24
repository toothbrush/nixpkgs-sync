# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`b25594d191fb`](https://github.com/NixOS/nixpkgs/commit/b25594d191fbfc0c42b2f128817a07c9ad9d1347) | 2026-11-24 00:01 UTC | ✅ |
| `nixos-unstable` | [`2786a2a72088`](https://github.com/NixOS/nixpkgs/commit/2786a2a72088ecf32aea5b3ec52099e6a7cff78f) | 2026-11-24 00:01 UTC | ✅ |
| `nixos-26.05` | [`0dc498bfe49b`](https://github.com/NixOS/nixpkgs/commit/0dc498bfe49baeb18b0f9891e800b53bb2603193) | 2026-11-24 00:01 UTC | ✅ |
| `nixpkgs-unstable` | [`619c39f6eac5`](https://github.com/NixOS/nixpkgs/commit/619c39f6eac5d1ed6b8f073a9414baf7034b2356) | 2026-11-24 00:01 UTC | ✅ |

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
