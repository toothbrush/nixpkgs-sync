# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`6c2a322ae874`](https://github.com/NixOS/nixpkgs/commit/6c2a322ae874008a3b347bf171dd6c31dbda013f) | 2026-11-22 19:49 UTC | ✅ |
| `nixos-unstable` | [`2786a2a72088`](https://github.com/NixOS/nixpkgs/commit/2786a2a72088ecf32aea5b3ec52099e6a7cff78f) | 2026-11-22 19:49 UTC | ✅ |
| `nixos-26.05` | [`94c3211b0ee8`](https://github.com/NixOS/nixpkgs/commit/94c3211b0ee8ba969a3f12eb4aff8ba0f72971dd) | 2026-11-22 19:49 UTC | ✅ |
| `nixpkgs-unstable` | [`93a9ed0a8660`](https://github.com/NixOS/nixpkgs/commit/93a9ed0a866099a230ed5146a5bb7d16fd5c9b14) | 2026-11-22 19:49 UTC | ✅ |

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
