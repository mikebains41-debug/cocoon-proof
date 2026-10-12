# compare.awk - the records COBOL left against the records Java left.
#
#   awk -f compare.awk capture_cobol.txt capture_java.txt
#
# Each file holds, for every call to HHCAL213, one line per record:
#   COCOON A <record> <bytes as hex>
# A record name seen again starts the next call. Java's run also prints
#   COCOON X <call> <what went wrong>
# for any exception. Prints CALLS, RECORDS, EQUAL, EXCEPTIONS; exits 0
# only when every record is byte-identical and nothing was thrown.
FNR == 1 { file++; call = 0; started = 0; split("", seen) }
/^COCOON X / { if (file == 2) exc++; next }
/^COCOON A / {
    name = $3
    hex = toupper(NF >= 4 ? $4 : "")
    if (!started || (name in seen)) { call++; split("", seen); started = 1 }
    seen[name] = 1
    key = call SUBSEP name
    if (file == 1) { cob[key] = hex; order[++n] = key; calls = call }
    else { jav[key] = hex }
}
END {
    for (i = 1; i <= n; i++) {
        k = order[i]
        rec++
        if ((k in jav) && jav[k] == cob[k]) eq++
        else {
            split(k, part, SUBSEP)
            printf "call %d: %s differs\n", part[1], part[2]
        }
    }
    printf "CALLS=%d RECORDS=%d EQUAL=%d EXCEPTIONS=%d\n", calls, rec, eq, exc
    exit (n > 0 && eq == rec && exc == 0) ? 0 : 1
}
