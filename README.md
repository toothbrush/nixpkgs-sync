# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`3fd18a2ba295`](https://github.com/NixOS/nixpkgs/commit/3fd18a2ba2958d828bdfcee16ca9d75b9d3199da) | 2026-11-14 06:40 UTC | ✅ |
| `nixos-unstable` | [`d4f25a3e5620`](https://github.com/NixOS/nixpkgs/commit/d4f25a3e562008648d45bcf2d70bcc7422cad84e) | 2026-11-14 06:40 UTC | ✅ |
| `nixos-26.05` | [`f1e5c356f35d`](https://github.com/NixOS/nixpkgs/commit/f1e5c356f35d07e7b71a6b5e6c9338e0b029e0c0) | 2026-11-14 06:40 UTC | ✅ |
| `nixpkgs-unstable` | [`2074cc672349`](https://github.com/NixOS/nixpkgs/commit/2074cc672349f14240fb7ea90d509e0b643e9dd4) | 2026-11-14 06:40 UTC | ✅ |

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
