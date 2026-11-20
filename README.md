# nixpkgs-sync

| Branch | Upstream commit | Last sync | Status |
|---|---|---|---|
| `master` | [`366a331bb0e9`](https://github.com/NixOS/nixpkgs/commit/366a331bb0e947921775e79dc27a6d55b1b1be3a) | 2026-11-20 07:28 UTC | ✅ |
| `nixos-unstable` | [`0bb8272318b4`](https://github.com/NixOS/nixpkgs/commit/0bb8272318b4ca41bf0edc6224df3e3e3046b70d) | 2026-11-20 07:28 UTC | ✅ |
| `nixos-26.05` | [`3457b69ac4ab`](https://github.com/NixOS/nixpkgs/commit/3457b69ac4aba6d9ea9a743370af160fb502db29) | 2026-11-20 07:28 UTC | ✅ |
| `nixpkgs-unstable` | [`19cfded70b91`](https://github.com/NixOS/nixpkgs/commit/19cfded70b91ca0981373973c5b1efffdd4d6647) | 2026-11-20 07:28 UTC | ✅ |

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
