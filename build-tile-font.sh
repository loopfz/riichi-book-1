#!/bin/bash

# Need to install:
# texlive (obviously !)
# nkf
# bzip2
# fontforge
# mftrace

TEXDIR=/usr/share/texmf

TEMPDIR=/tmp/mahjong-tile-font

[[ -d "$TEMPDIR" ]] || mkdir -p $TEMPDIR
cd $TEMPDIR

wget http://riichi.dynaman.net/RiichiBooks/piemf-2.0.2.tar.bz2

tar xjvf piemf-2.0.2.tar.bz2

cd piemf-2.0.2/macros
mkdir work
for f in *.sty
do
    nkf $f > work/$f
    mv work/$f .
done

cd ..

mkdir -p $TEXDIR/{fonts/{source,tfm,type1,map/dvips},tex/latex}/piemf

cp src/*.mf $TEXDIR/fonts/source/piemf/
cp macros/*.{sty,fd} $TEXDIR/tex/latex/piemf/
mktexlsr

mkdir -p type1
cd type1
mftrace --magnification=4000 --encoding=tex256.enc pie
t1binary pie.pfa pie.pfb

cat > pie.map <<EOF
pie pie <pie.pfb
EOF

cp pie.pfb $TEXDIR/fonts/type1/piemf/
cp pie.map $TEXDIR/fonts/map/dvips/piemf/
mktexlsr

updmap-sys --enable Map=pie.map

cd -
rm -rf "$TEMPDIR"
