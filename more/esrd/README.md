# The ESRD calculators, driven directly

`verify_esrd.sh` runs CMS's 20 ESRD calculators, ESCAL056 to ESCAL212, as COBOL and as
Cocoon's Java, and compares every record byte for byte, the same way
`verify.sh` does for HHCAL213.

CMS ships no test claims for its ESRD pricers: the package's README lists its
34 members - programs, copybooks, tables, the README and a MANIFEST - and none
holds claims. Each calculator's record sets
were made from its own source: every field of every record it is called with
set to a valid empty value (spaces, zeros, packed and binary zero), then
fields set to exactly the values the calculator's conditions test, one more
and one less, and mixes of those. Sets were found by climbing: each round kept the ones
that reached a statement, or a step between statements, that none before them
reached, or that ran further than the set they came from, and changed those
next. Statement coverage, measured when the sets were made, is in the table
in EVIDENCE.md.

For each calculator here:

| File | What it is |
|---|---|
| `<PROGRAM>.dat.gz` | its record sets, 3,000 calls each: one frame per call, the USING records back to back in order, as the driver reads them |
| `<PROGRAM>_direct.cbl` | the short driver that reads the frames and calls the calculator; its tapped form, which prints every record before and after each call, is `cocoon/esrd/<PROGRAM>_direct_tap.cbl` |
| `<PROGRAM>.kept.txt` | how each kept set was made, step by step |
| `<PROGRAM>.never.txt` | the statements no set reached, with their source; absent where every statement was reached |

They were generated from the calculators' own source by tools in Cocoon's
private repository. Checking them does not need those tools: the inputs are
data.

Each calculator runs on the build its recorded run used: `cobc -x -frelax-syntax-checks -frelax-level-hierarchy`,
without `-debug`.
