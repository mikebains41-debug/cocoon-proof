#!/bin/sh
# verify_esrd.sh - CMS's 20 ESRD calculators, ESCAL056 to ESCAL212, as COBOL
# and as Cocoon's Java, each driven directly on the same record sets and
# compared byte for byte, the way verify.sh compares HHCAL213.
#
# CMS ships no test claims for its ESRD pricers, so the record sets in
# more/esrd/ were made from each calculator's own conditions; more/esrd/README.md
# says how. For each calculator a short driver reads its record sets and
# calls it with its USING records; Cocoon's tap on that driver prints every
# record before and after each call, as hex. The Java is fed the same
# before-records, one instance per calculator for all its calls, as one load
# of the COBOL program serves them.
#
# Each calculator is built as the recorded run built it: cobc -x with
# -frelax-syntax-checks -frelax-level-hierarchy and without -debug. Where
# cms/esrd/build/ holds a copy of a file, that copy is built instead; the
# README says what differs in it and why. Needs what verify.sh needs, and
# gzip. Nothing from Cocoon runs here.
set -e
cd "$(dirname "$0")"

need() { command -v "$1" >/dev/null 2>&1 || { echo "verify_esrd.sh needs $1 ($2)"; exit 2; }; }
need cobc "GnuCOBOL 3.2"
need java "a Java runtime"
need gzip "to unpack the record sets"
JC=""
for c in javac ecj; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -version >/dev/null 2>&1; then JC=$c; break; fi
done
[ -n "$JC" ] || { echo "verify_esrd.sh needs a Java compiler that runs: javac (any JDK) or ecj"; exit 2; }

rm -rf work_esrd && mkdir work_esrd && cd work_esrd

echo "Compiling Cocoon's Java for the $(ls ../cocoon/esrd/*.java | wc -l | tr -d ' ') calculators"
mkdir cls
$JC -nowarn -d cls -cp ../cocoon/cocoon-runtime.jar ../cocoon/esrd/*.java ../cocoon/CocoonEquiv.java

echo "Each calculator: built with GnuCOBOL and run on its record sets with Cocoon's"
echo "tap, then the Java on the same records, then every record compared"
total_c=0; total_r=0; total_e=0; total_x=0; failed=0
for src in ../cms/esrd/ESCAL*.cbl; do
  p=$(basename "$src" .cbl)
  j="$(printf '%s' "$p" | cut -c1)$(printf '%s' "$p" | cut -c2- | tr 'A-Z' 'a-z')"
  mkdir "$p" && cd "$p"
  inc="-I ../../cms/esrd"
  [ -d ../../cms/esrd/build ] && inc="-I ../../cms/esrd/build $inc"
  cob="../../cms/esrd/$p.cbl"
  [ -f "../../cms/esrd/build/$p.cbl" ] && cob="../../cms/esrd/build/$p.cbl"
  tap="../../cocoon/esrd/${p}_direct_tap.cbl"
  cobc -x -frelax-syntax-checks -frelax-level-hierarchy $inc -o run "$tap" "$cob"
  gzip -dc "../../more/esrd/$p.dat.gz" > direct.dat
  frame=$(grep -o 'RECORD CONTAINS [0-9]*' "$tap" | head -1 | tr -dc 0-9)
  sets=$(( $(wc -c < direct.dat) / frame ))
  ./run | grep '^COCOON ' > cobol.txt
  java -cp "../cls:../../cocoon/cocoon-runtime.jar" CocoonEquiv "$j" cobol.txt > java.txt
  ok=1
  if awk -f ../../compare.awk cobol.txt java.txt > compare.txt; then :; else ok=0; fi
  line=$(tail -1 compare.txt)
  printf '   %-9s %s\n' "$p" "$line"
  set -- $(echo "$line" | tr '=' ' ')
  if [ "$2" != "$sets" ]; then
    echo "   $p: $sets record sets in more/esrd/$p.dat.gz but COBOL made $2 calls"; ok=0
  fi
  if [ "$ok" = 0 ]; then
    failed=1
    if [ "$(wc -l < compare.txt)" -gt 1 ]; then head -5 compare.txt | sed 's/^/      /'; fi
  fi
  total_c=$((total_c + $2)); total_r=$((total_r + $4)); total_e=$((total_e + $6)); total_x=$((total_x + $8))
  cd ..
done

echo "ALL: CALLS=$total_c RECORDS=$total_r EQUAL=$total_e EXCEPTIONS=$total_x"
[ "$failed" = 0 ] && [ "$total_e" = "$total_r" ] && [ "$total_r" -gt 0 ] && [ "$total_x" = 0 ]
