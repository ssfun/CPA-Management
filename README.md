# Quota persistence customization

This directory contains everything needed to apply this project's quota persistence changes on top of upstream `router-for-me/Cli-Proxy-API-Management-Center`.

## Layout

- `overlay/` — new files copied directly into the upstream checkout.
- `quota-persistence.patch` — minimal patch for upstream-owned files.
- `apply.sh` — applies the overlay and patch to an upstream checkout.

## Local usage

```bash
./apply.sh /path/to/Cli-Proxy-API-Management-Center
```

From this repository, the local sync wrapper can also be used:

```bash
npm run sync:upstream -- --check
npm run sync:upstream -- --apply
```

## GitHub Actions

`.github/workflows/release.yml` compares the current repository latest release with the upstream latest release, ignoring this repository's `-plus` suffix for comparison. Only when upstream is newer does it check out the upstream release tag, apply this customization, run `npm ci`, build the all-in-one HTML, and publish `management.html` to a GitHub Release named after the upstream tag plus `-plus` (for example, `v1.7.41-plus`).
