# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`40b2e2b91c32`](https://github.com/NixOS/nixpkgs/commit/40b2e2b91c3283b33a82aea4421574688a441bc2) | 2026-11-16 22:17 UTC | ✅ |
| `nixos-unstable` | [`d5cc68339997`](https://github.com/NixOS/nixpkgs/commit/d5cc6833999746cffdfe0598f7bc801a57b887a9) | 2026-11-16 22:17 UTC | ✅ |
| `nixos-26.05` | [`b349185bb79c`](https://github.com/NixOS/nixpkgs/commit/b349185bb79c7cf7ad8ea8c097931730bf473c71) | 2026-11-16 22:17 UTC | ✅ |
| `nixpkgs-unstable` | [`5d2b81a7a3be`](https://github.com/NixOS/nixpkgs/commit/5d2b81a7a3be3e2f832879028e4d60abbf58e9a0) | 2026-11-16 22:17 UTC | ✅ |

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
