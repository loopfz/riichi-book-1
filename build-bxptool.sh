#!/bin/bash

TEXDIR=/usr/share/texmf

TEMPDIR=/tmp/bxptool

[[ -d "$TEMPDIR" ]] || mkdir -p $TEMPDIR
cd $TEMPDIR

wget https://github.com/zr-tex8r/BXptool/archive/master.zip
unzip master.zip
cd BXptool-master

mkdir -p $TEXDIR/tex/latex/BXptool

cp *.{sty,def} $TEXDIR/tex/latex/BXptool
mktexlsr

cd -
rm -rf "$TEMPDIR"
