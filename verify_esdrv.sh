#!/bin/sh
# verify_esdrv.sh - CMS's ESRD driver ESDRV212, calling the 20 ESRD
# calculators as a claim reaches them, as COBOL and as Cocoon's Java, on the
# same record sets, compared byte for byte.
#
# The record sets in more/esdrv/ were made from ESDRV212's own conditions and
# CMS's own wage tables; more/esdrv/README.md says how. A short driver reads
# them and calls ESDRV212 with its USING records; Cocoon's tap on that driver
# prints every record before and after each call, as hex.
#
# Some of CMS's record sets make ESDRV212 read outside a table, which COBOL
# leaves undefined: GnuCOBOL built as usual reads on, into whatever memory
# lies there, and the Java stops with an exception. So nothing here rests on
# such a read: the COBOL is built with GnuCOBOL's run-time checks on
# (-debug), and the record sets are run in order; where it stops, the call
# is noted, and the run goes on from the next set as a fresh load. The Java
# is fed the same before-records, one instance per fresh load as one load of
# the COBOL serves those calls, starting fresh - every class loaded anew -
# where the COBOL did. Every call must then be one of two things: clean, with
# the Java leaving the same bytes in every record; or stopped, with the Java
# stopping in the same paragraph of the same program. And each call's
# verdict must be the one the recorded run gave it (more/esdrv/calls.txt).
#
# The programs are built as the recorded run built its checked build: cobc
# -x -debug -frelax-syntax-checks -frelax-level-hierarchy. The Java runs on
# cocoon/esdrv/cocoon-runtime.jar, the runtime the recorded run used. Needs
# what verify_esrd.sh needs. Nothing from Cocoon runs here.
set -e
cd "$(dirname "$0")"

need() { command -v "$1" >/dev/null 2>&1 || { echo "verify_esdrv.sh needs $1 ($2)"; exit 2; }; }
need cobc "GnuCOBOL 3.2"
need java "a Java runtime"
need gzip "to unpack the record sets"
JC=""
for c in ecj javac; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -version >/dev/null 2>&1; then JC=$c; break; fi
done
[ -n "$JC" ] || { echo "verify_esdrv.sh needs a Java compiler that runs: javac (any JDK) or ecj"; exit 2; }

rm -rf work_esdrv && mkdir work_esdrv && cd work_esdrv
M=../more/esdrv
# each program as CMS ships it, or its copy in cms/esrd/build/ where there is one
src=""
for p in ESDRV212 $(cat $M/called.txt); do
  if [ -f "../cms/esrd/build/$p.cbl" ]; then src="$src ../cms/esrd/build/$p.cbl"; else src="$src ../cms/esrd/$p.cbl"; fi
done
inc="-I ../cms/esrd"
[ -d ../cms/esrd/build ] && inc="-I ../cms/esrd/build $inc"
tap=../cocoon/esdrv/cmsdirct_tap.cbl
RT=../cocoon/esdrv/cocoon-runtime.jar

echo "Compiling Cocoon's Java for ESDRV212 and the $(wc -w < $M/called.txt | tr -d ' ') programs it calls"
mkdir cls
$JC -nowarn -d cls -cp $RT ../cocoon/esdrv/*.java

echo "Building ESDRV212 and the calculators with GnuCOBOL, its run-time checks on"
cobc -x -debug -frelax-syntax-checks -frelax-level-hierarchy $inc -o check $tap $src
gzip -dc $M/direct.dat.gz > direct.dat
frame=$(grep -o 'RECORD CONTAINS [0-9]*' $tap | head -1 | tr -dc 0-9)
sets=$(( $(wc -c < direct.dat) / frame ))
first=$(head -1 $M/shown.txt)
echo "$sets record sets"

echo "GnuCOBOL through the tap, going on from the next set after each stop"
: > stops.txt
: > cobol.txt
k=0
while :; do
  set +e
  COCOON_SHOW=Y COCOON_SKIP=$k ./check > out.txt 2> err.txt
  rc=$?
  set -e
  grep '^COCOON ' out.txt >> cobol.txt || true
  done_n=$(grep -c "^COCOON A $first " out.txt || true)
  if [ "$rc" = 0 ] && [ $((k + done_n)) = "$sets" ]; then break; fi
  n=$((k + done_n + 1))
  if [ "$n" -gt "$sets" ]; then
    echo "GnuCOBOL ended with code $rc after the last record set:"; tail -3 err.txt; exit 1
  fi
  at=$(cat err.txt out.txt | grep -o '[A-Za-z0-9_./-]*\.cbl:[0-9]*' | head -1)
  [ -n "$at" ] || at="unknown:0"
  echo "$n $at" >> stops.txt
  printf 'COCOON S %s\nCOCOON R\n' "$n" >> cobol.txt
  k=$n
done
echo "   $(wc -l < stops.txt | tr -d ' ') stops"

echo "The Java on the same records, fresh where the COBOL was"
# the Java prints its own verdicts; some Java runtimes end with a non-zero status after a clean run,
# so the judge reads what it printed rather than how it exited. Stack traces are kept whole
# (-XX:-OmitStackTraceInFastThrow): each exception must say where it was thrown.
java -XX:-OmitStackTraceInFastThrow -cp cls CocoonEquivR Esdrv212 cobol.txt "cls:$RT" > java.txt || true

echo "Every call judged"
ok=1
awk -f ../esdrv_judge.awk -v calls=calls.txt $src stops.txt cobol.txt java.txt > judge.txt || ok=0
if [ "$(tail -1 judge.txt | cut -d' ' -f2)" != "CALLS=$sets" ]; then ok=0; fi
if [ "$ok" = 1 ] && ! cmp -s calls.txt $M/calls.txt; then
  echo "   the verdicts differ from the recorded run's (more/esdrv/calls.txt):"
  diff calls.txt $M/calls.txt | head -10 | sed 's/^/      /'
  ok=0
fi
[ "$ok" = 1 ] || head -20 judge.txt | sed 's/^/   /'
tail -1 judge.txt
[ "$ok" = 1 ]
