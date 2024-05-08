#!/usr/bin/env bash

set -e
set -o pipefail

if ! command -v clang-format >/dev/null; then
  echo "Please install clang-format and try again." 1>&2
  exit 1
fi

# Working directory
WD="$(dirname "${BASH_SOURCE[0]}")/../"

SRC_DIRS=(src tests include examples)

function main {
  pushd "${WD}" >/dev/null
  for d in "${SRC_DIRS[@]}"; do
    # shellcheck disable=2038
    find "${d}" -iname '*.h' -o -iname '*.cpp' | xargs clang-format -i -style=file
  done
  popd >/dev/null
}

main "$@"
