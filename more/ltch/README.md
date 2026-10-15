# The LTCH calculators, driven directly

`verify_ltch.sh` runs CMS's 28 LTCH calculators, LTCAL032 to LTCAL212, as COBOL and as
Cocoon's Java, and compares every record byte for byte, the same way
`verify.sh` does for HHCAL213.

CMS ships no test claims for its LTCH pricers: besides its README and a
MANIFEST, the package holds the 77 members its README lists - programs,
copybooks, tables and wage indexes - and none holds claims.
Each calculator's record sets were made from its own source: every field of
every record it is called with set to a valid empty value (spaces, zeros,
packed and binary zero), then fields set to exactly the values the
calculator's conditions test, one more and one less, and mixes of those. Sets
were found by climbing: each round kept the ones that reached a statement, or
a step between statements, that none before them reached, or that ran further
than the set they came from, and changed those next. Statement coverage,
measured on these record sets, is in the table in EVIDENCE.md.

For each calculator here:

| File | What it is |
|---|---|
| `<PROGRAM>.dat.gz` | its record sets, 3,000 calls each: one frame per call, the USING records back to back in order, as the driver reads them |
| `<PROGRAM>_direct.cbl` | the short driver that reads the frames and calls the calculator; its tapped form, which prints every record before and after each call, is `cocoon/ltch/<PROGRAM>_direct_tap.cbl` |
| `<PROGRAM>.kept.txt` | how each kept set was made, step by step |
| `<PROGRAM>.never.txt` | the statements no set reached, with their source; absent where every statement was reached |

And for all of them:

| File | What it is |
|---|---|
| `unreachable.txt` | every statement no set reaches, 172 in all, with the reason no input can run it |
| `LTCAL212_2401_2406.txt` | the proof for two of them: thirteen facts, each checked against LTCAL212's source and tables |

## Every statement accounted for

The record sets reach 8,970 of the 28 calculators' 9,142 statements. Each of the
other 172 is proven unreachable from CMS's own source: 170 follow from nine
patterns (DSH-ZERO 42, DRG-FOUND 30, DRG-NUMERIC 30, DSH-CAP 21, RTC-NEVER 15, PMT-TYPE 12, SHADOWED 12, IPPS-WI 4, SSRFBN 4), and each row of `unreachable.txt` gives its reason in full,
with the lines it rests on. The last two, LTCAL212 lines 2401 and 2406, rest on
the thirteen facts in `LTCAL212_2401_2406.txt`.

The record sets and the proofs were made by tools in Cocoon's private
repository. Checking them does not need those tools: the record sets are
data, and each proof names the source lines it rests on.

Each calculator runs on the build its recorded run used: `cobc -x -frelax-syntax-checks -frelax-level-hierarchy`,
without `-debug`.
