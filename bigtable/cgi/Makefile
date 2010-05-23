all : bigtable-c.cgi bytestring.cgi hamlet.cgi text.cgi

bigtable-c.cgi: bigtable.c
	gcc -O2 -o bigtable-c.cgi bigtable.c

bytestring.cgi: bytestring.hs
	ghc -O2 --make bytestring.hs -o bytestring.cgi

hamlet.cgi: hamlet.hs
	ghc -O2 --make hamlet.hs -o hamlet.cgi

text.cgi: text.hs
	ghc -O2 --make text.hs -o text.cgi
