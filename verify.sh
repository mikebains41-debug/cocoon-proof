#!/bin/sh
# verify.sh - CMS's Home Health calculator HHCAL213, as COBOL and as
# Cocoon's Java, on the 21 test claims CMS ships with it, compared byte
# for byte.
#
# Needs GnuCOBOL 3.2 (cobc), a Java compiler (javac from any JDK, or ecj),
# java, and a POSIX shell with sed, tr, grep, cmp and awk. Nothing from
# Cocoon runs here: its outputs are in cocoon/, and every step below can be
# read before it runs.
set -e
cd "$(dirname "$0")"

need() { command -v "$1" >/dev/null 2>&1 || { echo "verify.sh needs $1 ($2)"; exit 2; }; }
need cobc "GnuCOBOL 3.2"
need java "a Java runtime"
# The first Java compiler that runs: javac from a JDK, or ecj. On Android's
# Termux, javac is a wrapper around Android's own runtime and aborts, and
# ecj works.
JC=""
for c in javac ecj; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -version >/dev/null 2>&1; then JC=$c; break; fi
done
[ -n "$JC" ] || { echo "verify.sh needs a Java compiler that runs: javac (any JDK) or ecj"; exit 2; }

rm -rf work && mkdir work && cd work

echo "1. CMS's files, with two build-only changes made to copies here:"
echo "   ORGANIZATION IS LINE SEQUENTIAL on each SELECT; CRLF and ^Z removed from the inputs"
for f in hhmgr213 hhopn213; do
  sed -E '/SELECT +[A-Z]+ +ASSIGN TO UT-S-[A-Z]+ /a\           ORGANIZATION IS LINE SEQUENTIAL' "../cms/$f.cbl" > "${f}_ls.cbl"
done
cp ../cms/hhcal213.cbl ../cms/hhdrv213.cbl ../cms/*.cpy .
for n in HHAFILE MSAFILE CBSAFILE HRGTABL REVTABL; do
  tr -d '\r\032' < "../cms/$n" > "UT-S-$n"
done

echo "2. CMS's pricer, built from CMS's COBOL and run on CMS's 21 test claims"
cobc -x -debug -I . -o hhprice hhmgr213_ls.cbl hhdrv213.cbl hhopn213_ls.cbl hhcal213.cbl
rm -f UT-S-OUTFILE UT-S-PRTFILE
./hhprice > /dev/null
if cmp -s UT-S-OUTFILE ../expected/cobol_output.txt; then
  echo "   its output file is identical to the one recorded in expected/"
else
  echo "   note: its output file differs from the one recorded in expected/"
fi

echo "3. The same pricer with Cocoon's tap on CMS's driver: every record passed"
echo "   to HHCAL213, before and after each call, as hex"
cobc -x -debug -I . -o hhprice_tap hhmgr213_ls.cbl ../cocoon/hhdrv213_tap.cbl hhopn213_ls.cbl hhcal213.cbl
rm -f UT-S-OUTFILE UT-S-PRTFILE
./hhprice_tap | grep '^COCOON ' > capture_cobol.txt

echo "4. Cocoon's Java for HHCAL213, compiled here and run on the same records,"
echo "   one instance for all 21 calls, as one load of the COBOL program serves them"
mkdir cls
$JC -nowarn -d cls -cp ../cocoon/cocoon-runtime.jar ../cocoon/Hhcal213.java ../cocoon/CocoonEquiv.java
java -cp "cls:../cocoon/cocoon-runtime.jar" CocoonEquiv Hhcal213 capture_cobol.txt > capture_java.txt

echo "5. Every record COBOL left, against every record Java left, byte for byte"
awk -f ../compare.awk capture_cobol.txt capture_java.txt
