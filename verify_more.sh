#!/bin/sh
# verify_more.sh - HHCAL213 on many more inputs than CMS's 21 claims, as
# COBOL and as Cocoon's Java, compared byte for byte the same way.
#
#   orders     CMS's 21 claims reversed, shuffled, each twice in a row and
#              shuffled three times over: working storage is carried from
#              call to call, so any value one claim leaves for the next
#              must be left the same way by both
#   generated  claims made from the calculator's own conditions - fields
#              set to exactly the values it tests, one more and one less -
#              run through CMS's whole chain
#   direct     record sets driven straight into the calculator by a
#              ten-line driver, reaching statements CMS's own driver never
#              calls it for
#
# Each set's inputs, and how it was made, are in more/. Each runs on the
# build its first run used: the orders on CMS's chain built with -debug,
# the other two without. Needs what verify.sh needs.
set -e
cd "$(dirname "$0")"

need() { command -v "$1" >/dev/null 2>&1 || { echo "verify_more.sh needs $1 ($2)"; exit 2; }; }
need cobc "GnuCOBOL 3.2"
need java "a Java runtime"
JC=""
for c in javac ecj; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -version >/dev/null 2>&1; then JC=$c; break; fi
done
[ -n "$JC" ] || { echo "verify_more.sh needs a Java compiler that runs: javac (any JDK) or ecj"; exit 2; }

rm -rf work_more && mkdir work_more && cd work_more
for f in hhmgr213 hhopn213; do
  sed -E '/SELECT +[A-Z]+ +ASSIGN TO UT-S-[A-Z]+ /a\           ORGANIZATION IS LINE SEQUENTIAL' "../cms/$f.cbl" > "${f}_ls.cbl"
done
cp ../cms/hhcal213.cbl ../cms/*.cpy .
for n in MSAFILE CBSAFILE HRGTABL REVTABL; do
  tr -d '\r\032' < "../cms/$n" > "UT-S-$n"
done

echo "Building CMS's chain with Cocoon's tap (with and without -debug), the direct driver, and the Java"
cobc -x -debug -I . -o chain_debug hhmgr213_ls.cbl ../cocoon/hhdrv213_tap.cbl hhopn213_ls.cbl hhcal213.cbl
cobc -x -I . -o chain hhmgr213_ls.cbl ../cocoon/hhdrv213_tap.cbl hhopn213_ls.cbl hhcal213.cbl
cobc -x -I . -o direct ../cocoon/hhdirect_tap.cbl hhcal213.cbl
mkdir cls
$JC -nowarn -d cls -cp ../cocoon/cocoon-runtime.jar ../cocoon/Hhcal213.java ../cocoon/CocoonEquiv.java

total_c=0; total_r=0; total_e=0; total_x=0; failed=0
one() {
  # one set: $1 its name, $2 the program that runs it
  rm -f UT-S-OUTFILE UT-S-PRTFILE
  "./$2" | grep '^COCOON ' > "cobol_$1.txt"
  java -cp "cls:../cocoon/cocoon-runtime.jar" CocoonEquiv Hhcal213 "cobol_$1.txt" > "java_$1.txt"
  if awk -f ../compare.awk "cobol_$1.txt" "java_$1.txt" > "compare_$1.txt"; then :; else failed=1; fi
  line=$(tail -1 "compare_$1.txt")
  printf '   %-10s %s\n' "$1" "$line"
  set -- $(echo "$line" | tr '=' ' ')
  total_c=$((total_c + $2)); total_r=$((total_r + $4)); total_e=$((total_e + $6)); total_x=$((total_x + $8))
}

echo "1. CMS's 21 claims in other orders"
cp ../more/orders/HHAFILE UT-S-HHAFILE
one orders chain_debug
echo "2. Claims generated from the calculator's own conditions, through CMS's whole chain"
cp ../more/generated/HHAFILE UT-S-HHAFILE
one generated chain
echo "3. Record sets driven straight into the calculator"
cp ../more/direct/direct.dat direct.dat
one direct direct

echo "ALL: CALLS=$total_c RECORDS=$total_r EQUAL=$total_e EXCEPTIONS=$total_x"
[ "$failed" = 0 ] && [ "$total_e" = "$total_r" ] && [ "$total_r" -gt 0 ] && [ "$total_x" = 0 ]
