# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`8dfa64a4c67c`](https://github.com/NixOS/nixpkgs/commit/8dfa64a4c67cb6c6c3782cba310fff3decebf089) | 2026-11-10 07:28 UTC | ✅ |
| `nixos-unstable` | [`f4a03c008967`](https://github.com/NixOS/nixpkgs/commit/f4a03c008967841f2a0b3cb7c436fc6fc31671f6) | 2026-11-10 07:28 UTC | ✅ |
| `nixos-26.05` | [`ac588ef1c914`](https://github.com/NixOS/nixpkgs/commit/ac588ef1c914865dad517b337ea0eb9694a4021c) | 2026-11-10 07:28 UTC | ✅ |
| `nixpkgs-unstable` | [`4fe25e12eb9f`](https://github.com/NixOS/nixpkgs/commit/4fe25e12eb9f4c744966dd3de5a05246cf098601) | 2026-11-10 07:28 UTC | ✅ |

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
