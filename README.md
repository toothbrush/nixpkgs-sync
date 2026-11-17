# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`fad97717054f`](https://github.com/NixOS/nixpkgs/commit/fad97717054f1026c954054ec8f29b53ac86309a) | 2026-11-17 21:03 UTC | ✅ |
| `nixos-unstable` | [`d5cc68339997`](https://github.com/NixOS/nixpkgs/commit/d5cc6833999746cffdfe0598f7bc801a57b887a9) | 2026-11-17 21:03 UTC | ✅ |
| `nixos-26.05` | [`f68407657ad2`](https://github.com/NixOS/nixpkgs/commit/f68407657ad294471eb4b2e65d193df26edf729f) | 2026-11-17 21:03 UTC | ✅ |
| `nixpkgs-unstable` | [`1c872b8c508b`](https://github.com/NixOS/nixpkgs/commit/1c872b8c508bbbfebc1b0b74777ff391ce0a574c) | 2026-11-17 21:03 UTC | ✅ |

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
