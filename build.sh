#!/bin/sh

sphinx-intl update -p _build/locale
sphinx-intl build
rm -r _build/html
make -e SPHINXOPTS="-D language='ja'" html
mv _build/html _build/html-ja
make html
