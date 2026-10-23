#!/bin/sh
# verify_files.sh - Cocoon's Java for seven COBOL programs that use files, against GnuCOBOL.
# Each program is compiled by GnuCOBOL and its Java (in files/java/) by javac; both are run in
# folders of their own on the same input file, with the same DD_ names for the files; the
# output, the exit status and every file written must be the same, byte for byte. An indexed
# file's own bytes are each handler's format, so it is compared through what the program
# reads back from it, in its output. SKIP names programs not to run (this phone's GnuCOBOL
# cannot open an indexed file). JAVAC names the Java compiler (javac unless set).
set -u
cd "$(dirname "$0")"
JAVAC=${JAVAC:-javac}
SKIP=${SKIP:-}
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
fail=0; n=0
for src in files/cobol/*.cbl; do
    p=$(basename "$src" .cbl)
    case " $SKIP " in *" $p "*) echo "$p: skipped here"; continue;; esac
    d="$work/$p"
    mkdir -p "$d/cob" "$d/java" "$d/classes"
    printf 'A00100012\nB00200345\nC00306789\n' > "$d/cob/in.txt"
    cp "$d/cob/in.txt" "$d/java/in.txt"
    if ! cobc -x -o "$d/prog" "$src" > "$d/cobc.log" 2>&1; then
        echo "$p: did not compile under GnuCOBOL"; cat "$d/cobc.log"; fail=1; continue
    fi
    cls=$(cd "files/java/$p" && ls *.java | head -1 | sed 's/\.java$//')
    if ! $JAVAC -nowarn -d "$d/classes" files/java/$p/cocoon/runtime/*.java "files/java/$p/$cls.java" > "$d/javac.log" 2>&1; then
        echo "$p: its Java did not compile"; cat "$d/javac.log"; fail=1; continue
    fi
    (cd "$d/cob" && DD_INFILE=in.txt DD_OUTFILE=out.txt DD_RECFILE=rec.dat DD_IDXFILE=idx.dat \
        timeout 60 "$d/prog" > "$d/cob.out" 2> /dev/null; echo $? > "$d/cob.rc")
    (cd "$d/java" && DD_INFILE=in.txt DD_OUTFILE=out.txt DD_RECFILE=rec.dat DD_IDXFILE=idx.dat \
        timeout 60 java -cp "$d/classes" "$cls" > "$d/java.out" 2> /dev/null; echo $? > "$d/java.rc")
    same=yes
    cmp -s "$d/cob.rc" "$d/java.rc" || { echo "$p: exit status $(cat "$d/cob.rc") under GnuCOBOL, $(cat "$d/java.rc") in Java"; same=no; }
    cmp -s "$d/cob.out" "$d/java.out" || { echo "$p: the output differs"; diff "$d/cob.out" "$d/java.out" | head -20; same=no; }
    for f in $( (ls "$d/cob"; ls "$d/java") | sort -u ); do
        case "$f" in idx*) continue;; esac
        cmp -s "$d/cob/$f" "$d/java/$f" || { echo "$p: file $f differs"; same=no; }
    done
    n=$((n + 1))
    if [ "$same" = yes ]; then
        echo "$p: same output, exit status $(cat "$d/cob.rc"), every file the same"
    else
        fail=1
    fi
done
if [ "$fail" = 0 ]; then
    echo "ALL: $n programs, GnuCOBOL and the Java the same"
else
    echo "FAILED"
fi
exit "$fail"
