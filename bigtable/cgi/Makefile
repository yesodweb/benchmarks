all : string.cgi wai.cgi cgi-package.cgi bigtable-c.cgi bytestring.cgi hamlet.cgi text.cgi text-builder.cgi yesod.cgi hack.cgi blaze-builder.cgi

bigtable-c.cgi: bigtable.c
	gcc -O2 -o bigtable-c.cgi bigtable.c

cgi-package.cgi: cgi-package.hs
	ghc -O2 --make cgi-package.hs -o cgi-package.cgi

yesod.cgi: yesod.hs
	ghc -O2 --make yesod.hs -o yesod.cgi

wai.cgi: wai.hs
	ghc -O2 --make wai.hs -o wai.cgi

bytestring.cgi: bytestring.hs
	ghc -O2 --make bytestring.hs -o bytestring.cgi

hamlet.cgi: hamlet.hs
	ghc -O2 --make hamlet.hs -o hamlet.cgi

string.cgi: string.hs
	ghc -O2 --make string.hs -o string.cgi

text.cgi: text.hs
	ghc -O2 --make text.hs -o text.cgi

text-builder.cgi: text-builder.hs
	ghc -O2 --make text-builder.hs -o text-builder.cgi

hack.cgi: hack.hs
	ghc -O2 --make hack.hs -o hack.cgi

blaze-builder.cgi: blaze-builder.hs
	ghc -O2 --make blaze-builder.hs -o blaze-builder.cgi
