#!/bin/sh
set -eu
cd "$(dirname $0)/.."
find . -name '*.md' -exec pandoc -f markdown+hard_line_breaks {} -t markdown+hard_line_breaks -so {} \;
find . -name '*.sh' -exec shfmt -i 2 -w {} +
find . \( -name '*.rels' -or -name '*.xml' \) -exec tidy -i -q -xml -utf8 -m {} +
