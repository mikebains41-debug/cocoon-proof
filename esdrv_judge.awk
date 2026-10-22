# esdrv_judge.awk - judges every call of verify_esdrv.sh.
#
#   awk -f esdrv_judge.awk -v calls=calls.txt SOURCES... stops.txt cobol.txt java.txt
#
# SOURCES are the COBOL files built (each named NAME.cbl); stops.txt has one
# line per call where GnuCOBOL, built with its run-time checks on (-debug),
# stopped: "CALL FILE.cbl:LINE"; cobol.txt is what that COBOL printed
# through Cocoon's tap (COCOON B before a call, COCOON A after it, as hex),
# with COCOON S n for call n, which stopped, and COCOON R where the next
# run started fresh; java.txt is what Cocoon's Java printed on the same
# before-records, with COCOON X for a call where the Java threw.
#
# Hex is compared as bytes: GnuCOBOL's HEX-OF writes A to F in capitals,
# Cocoon's runtime in small letters.
#
# A call is one of:
#   C  ran clean under GnuCOBOL's checks, and the Java left the same bytes
#      in every record;
#   S  stopped under GnuCOBOL's checks, and the Java threw in the same
#      paragraph of the same program;
#   F  anything else - printed in full.
# Writes "CALL KIND" for each call to calls; the last line printed is
#   ALL: CALLS=n CLEAN=n EQUAL=n STOPPED=n SAME-PARAGRAPH=n FAILED=n
function norm(s) { s = tolower(s); gsub(/[^a-z0-9]/, "", s); return s }
function base(p) { sub(/.*\//, "", p); return p }
FNR == 1 { file = base(FILENAME); para = "?" }
# the COBOL sources: the paragraph each line belongs to - the last name in
# area A, followed by a full stop, at or above it
file ~ /\.cbl$/ {
    l = $0; sub(/\r$/, "", l)
    c7 = substr(l, 7, 1)
    if (length(l) > 7 && c7 != "*" && c7 != "/" && c7 != "$" && substr(l, 8, 1) != " ") {
        code = toupper(substr(l, 8, 65)); sub(/^ +/, "", code)
        if (match(code, /^[A-Z0-9][A-Z0-9-]*[ ]*\./)) {
            nm = substr(code, 1, RLENGTH); sub(/[ ]*\.$/, "", nm)
            if (nm != "FD" && nm != "SD" && nm != "COPY") para = nm
        }
    }
    P[file, FNR] = para
    next
}
file == "stops.txt" {
    split($2, w, ":")
    stopfile[$1] = base(w[1]); stopline[$1] = w[2] + 0
    next
}
file == "cobol.txt" {
    if ($1 != "COCOON") next
    if ($2 == "B") { nb++; inafter = 0; next }
    if ($2 == "S") {
        # a call GnuCOBOL stopped: its before-records, and no after-records
        ccall++; inafter = 0
        if ($3 + 0 != ccall) { print "the capture numbers a stopped call " $3 " where " ccall " was due"; bad = 1 }
        if (!nb) { print "call " ccall ": its before-records were not captured"; bad = 1 }
        nb = 0
        next
    }
    if ($2 == "R") next
    if ($2 == "A") {
        if (!inafter) { ccall++; inafter = 1; nb = 0 }
        h = $4; sub(/\r$/, "", h)
        na++; acall[na] = ccall; aname[na] = $3; ahex[na] = toupper(h)
    }
    next
}
file == "java.txt" {
    if ($1 != "COCOON") next
    if ($2 == "X") {
        n = $3; t = $0
        threw[n] = 1
        if (match(t, / at [A-Za-z0-9_$]+\.[A-Za-z0-9_$]+\(/)) {
            s = substr(t, RSTART + 4, RLENGTH - 5)
            k = index(s, "."); jcls[n] = substr(s, 1, k - 1); jm = substr(s, k + 1)
            if (jm ~ /^p[A-Z0-9]/) jm = substr(jm, 2)
            jmeth[n] = jm
        }
        xtext[n] = t
        next
    }
    if ($2 == "S") next
    if ($2 == "A") {
        nj++
        if (nj > na || $3 != aname[nj]) { if (!lined) print "the Java's after-record " nj " is " $3 ", not the COBOL's " aname[nj]; lined = 1; bad = 1; next }
        h = $4; sub(/\r$/, "", h)
        if (toupper(h) != ahex[nj]) diff[acall[nj]] = diff[acall[nj]] " " $3
    }
    next
}
END {
    if (nj != na) print "the Java's records do not line up with the COBOL's: " nj " against " na " after-records"
    if (nj != na || bad) exit 1
    for (n = 1; n <= ccall; n++) {
        if (n in stopfile) {
            f = stopfile[n]
            cp = ((f, stopline[n]) in P) ? P[f, stopline[n]] : "?"
            jf = toupper(jcls[n]) ".cbl"
            if (threw[n] && jf == f && norm(jmeth[n]) == norm(cp)) { kind = "S"; same++ }
            else {
                kind = "F"
                print "call " n ": GnuCOBOL stopped in " f " line " stopline[n] " (" cp "); " \
                      (threw[n] ? "the Java threw elsewhere: " xtext[n] : "the Java did not stop")
            }
            stopped++
        } else {
            if (!threw[n] && !(n in diff)) { kind = "C"; equal++ }
            else {
                kind = "F"
                print "call " n ": GnuCOBOL ran clean; " (threw[n] ? "the Java threw: " xtext[n] : "records differ:" diff[n])
            }
            clean++
        }
        if (kind == "F") failed++
        print n, kind > calls
    }
    printf "ALL: CALLS=%d CLEAN=%d EQUAL=%d STOPPED=%d SAME-PARAGRAPH=%d FAILED=%d\n", ccall, clean, equal, stopped, same, failed
    exit (failed > 0 || ccall == 0)
}
