#!/bin/sh
set -eu

# There must be at least one poem.
if [ $# -eq 0 ]; then
  echo "usage: $0 [poem.md ...]"
  exit 1
fi

output="${PWD}/$# Poems.docx"
templates="$(dirname $0)/../templates"

# Make the packet.
# For several reasons, we build the document zip ourselves.
scratch="$(mktemp)"
pandoc --template "${templates}/document.xml" \
  -f markdown+hard_line_breaks "$@" \
  -t docx -o "${scratch}"
(
  cd "${templates}/docx"
  rm -f word/document.xml
  unzip -q "${scratch}" word/document.xml
  rm -f "${output}"
  zip -qr "${output}" *
)

# Make the cover letter.
# The first Pandoc invocation normalizes the title formatting.
# The third fixes the numbers.
pandoc -f markdown+hard_line_breaks "$@" \
  -t markdown+hard_line_breaks |
  sed -n 's/"/"\\""/g;s/^# \(.*\)$/-V title="\1"/p' "$@" |
  xargs pandoc --template "${templates}/cover-letter.md" \
    -f markdown /dev/null \
    -t markdown |
  pandoc -f markdown \
    -t plain -o cover-letter.txt
