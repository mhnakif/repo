#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <target> <url> [url...]"
  echo "Targets: l|lora -> models/loras, u|unet -> models/unet,"
  echo "         c|clip -> models/clip, v|vae -> models/vae"
  exit 1
fi

target="$1"
shift

case "$target" in
  l|lora)
    dest_dir="./models/loras"
    ;;
  u|unet)
    dest_dir="./models/unet"
    ;;
  c|clip)
    dest_dir="./models/clip"
    ;;
  v|vae)
    dest_dir="./models/vae"
    ;;
  *)
    echo "Unknown target: $target"
    echo "Targets: l|lora, u|unet, c|clip, v|vae"
    exit 1
    ;;
esac

mkdir -p "$dest_dir"

for url in "$@"; do
  file_name="$(basename "${url%%\?*}")"
  aria2c -x16 -o "$file_name" -d "$dest_dir" "$url"
done
