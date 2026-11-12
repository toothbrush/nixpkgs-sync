# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`490e19a28ad2`](https://github.com/NixOS/nixpkgs/commit/490e19a28ad2881b7ed4a72ddbc32ed1b0afa1a1) | 2026-11-12 07:23 UTC | ✅ |
| `nixos-unstable` | [`177d0540942f`](https://github.com/NixOS/nixpkgs/commit/177d0540942fb205af6993b1d5fa0b57799e09f8) | 2026-11-12 07:23 UTC | ✅ |
| `nixos-26.05` | [`ac588ef1c914`](https://github.com/NixOS/nixpkgs/commit/ac588ef1c914865dad517b337ea0eb9694a4021c) | 2026-11-12 07:23 UTC | ✅ |
| `nixpkgs-unstable` | [`f6bf1059f025`](https://github.com/NixOS/nixpkgs/commit/f6bf1059f02576e0b913c7b49d5e4eb6dda9cc22) | 2026-11-12 07:23 UTC | ✅ |

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
