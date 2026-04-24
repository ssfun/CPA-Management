#!/usr/bin/env bash
set -euo pipefail

CUSTOMIZATION_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
PATCH_FILE="$CUSTOMIZATION_DIR/quota-persistence.patch"
OVERLAY_DIR="$CUSTOMIZATION_DIR/overlay"

if [[ ! -d "$TARGET_DIR/src" || ! -f "$TARGET_DIR/package.json" ]]; then
  echo "Target directory does not look like the upstream project: $TARGET_DIR" >&2
  exit 1
fi

if [[ ! -f "$PATCH_FILE" ]]; then
  echo "Patch file not found: $PATCH_FILE" >&2
  exit 1
fi

if [[ ! -d "$OVERLAY_DIR" ]]; then
  echo "Overlay directory not found: $OVERLAY_DIR" >&2
  exit 1
fi

rsync -a "$OVERLAY_DIR/" "$TARGET_DIR/"
patch --dry-run -p0 -d "$TARGET_DIR" < "$PATCH_FILE" >/dev/null
patch -p0 -d "$TARGET_DIR" < "$PATCH_FILE" >/dev/null

echo "OK: quota persistence customization applied to $TARGET_DIR"
