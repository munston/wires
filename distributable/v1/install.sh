#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
TARBALL="${1:-}"

if [ -z "$TARBALL" ]; then
  TARBALL=$(find "$SCRIPT_DIR" -maxdepth 1 -type f \( -name '*.tar' -o -name '*.tar.gz' -o -name '*.tgz' -o -name '*.tar.xz' -o -name '*.tar.bz2' \) | head -n 1)
fi

if [ -z "$TARBALL" ]; then
  echo "no tarball found beside install.sh" >&2
  exit 1
fi

case "$TARBALL" in
  /*) ;;
  *) TARBALL="$SCRIPT_DIR/$TARBALL" ;;
esac

WORK="$SCRIPT_DIR/work"

rm -rf "$WORK"
mkdir -p "$WORK"

tar -xf "$TARBALL" -C "$WORK"

cd "$WORK/ollama.wires"
sh installer.sh
