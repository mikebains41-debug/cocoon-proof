# Cocoon proof

[![verify](https://github.com/mikebains41-debug/cocoon-proof/actions/workflows/verify.yml/badge.svg)](https://github.com/mikebains41-debug/cocoon-proof/actions/workflows/verify.yml)

Cocoon translates COBOL into Java. This repository lets anyone check, on
their own machine, that its Java for real Medicare pricing programs,
published by CMS, leaves exactly the same bytes as the COBOL they came from.

## In thirty seconds

| CMS programs | Calls | Records compared | Differences | Statements |
|---|---:|---:|---:|---|
| Home Health calculator HHCAL213 | 11,877 | 71,262 | 0 | 337 of 341 run; the other 4 cannot be reached by any input |
| 20 ESRD calculators, ESCAL056 to ESCAL212 | 60,000 | 276,000 | 0 | 7,742 of 8,250 reached; the other 508 proven unreachable |
| 28 LTCH calculators, LTCAL032 to LTCAL212 | 84,000 | 570,000 | 0 | 8,970 of 9,142 reached; the other 172 proven unreachable |
| CMS's ESRD driver ESDRV212, calling the 20 calculators as a claim reaches them | 14,119 | every record of every call that runs clean | 0 | 2,971 calls stop where CMS's COBOL reads outside a table, under GnuCOBOL's checks and in the Java alike; 400 planted bugs all caught or proven harmless |

The reference is GnuCOBOL 3.2, an independent COBOL compiler. GitHub re-runs
`verify.sh`, `verify_more.sh`, `verify_esrd.sh`, `verify_ltch.sh` and
`verify_esdrv.sh` from scratch on a fresh Ubuntu machine, with GnuCOBOL 3.2 built from GNU's
release, on every change and every week; the badge above shows the latest
result, and the run's full log is one click away. What this does not show -
IBM's own compiler first - is listed at the end. `EVIDENCE.md` gives the
detail behind every number.

The first check is HHCAL213, the calculator at the heart of CMS's Home Health
pricer for 2021, on the 21 test claims CMS ships with it.

## Run it

You need GnuCOBOL 3.2 (`cobc`), a Java compiler (`javac` from any JDK, or
`ecj`), `java`, and a POSIX shell. Then:

```
git clone https://github.com/mikebains41-debug/cocoon-proof
cd cocoon-proof
sh verify.sh
```

The last line should read:

```
CALLS=21 RECORDS=126 EQUAL=126 EXCEPTIONS=0
```

21 calls to HHCAL213, 6 records each, every one byte-identical, and no
exception from the Java. Any difference is printed by call and record, and
the script exits with a failure.

## More runs

`sh verify_more.sh` checks HHCAL213 the same way on 11,856 more calls: CMS's 21
claims in other orders (147), claims generated from the calculator's own
conditions and run through CMS's whole chain (1,759), and record sets driven
straight into the calculator (9,950), which reach checks CMS's driver never
calls it for. Its last line should read:

```
ALL: CALLS=11856 RECORDS=71136 EQUAL=71136 EXCEPTIONS=0
```

The inputs, and how each set was made, are in `more/`.

## The ESRD calculators

`sh verify_esrd.sh` checks CMS's 20 ESRD calculators, ESCAL056 to ESCAL212 from the
CY2021.2 mainframe package, the same way. CMS ships no test claims for them,
so each is driven directly: a short driver reads record sets made from the
calculator's own conditions, 3,000 per calculator, and calls it with them under
GnuCOBOL with Cocoon's tap; the Java is run on the same records; every record
is compared byte for byte. Its last line should read:

```
ALL: CALLS=60000 RECORDS=276000 EQUAL=276000 EXCEPTIONS=0
```

The record sets reach 7,742 of the 8,250 statements in the 20; each of the other
508 is proven unreachable, with its reason, in `more/esrd/unreachable.txt`.

The calculators are built as the recorded run built them, with
`-frelax-syntax-checks -frelax-level-hierarchy` and without `-debug`.
None of them needs a build-only change: GnuCOBOL compiles every file as CMS ships it. The inputs, and how they were made, are in `more/esrd/`.

## The LTCH calculators

`sh verify_ltch.sh` checks CMS's 28 LTCH calculators, LTCAL032 to LTCAL212 from the
FY2021.2 mainframe package, the same way. CMS ships no test claims for them,
so each is driven directly: a short driver reads record sets made from the
calculator's own conditions, 3,000 per calculator, and calls it with them under
GnuCOBOL with Cocoon's tap; the Java is run on the same records; every record
is compared byte for byte. Its last line should read:

```
ALL: CALLS=84000 RECORDS=570000 EQUAL=570000 EXCEPTIONS=0
```

The record sets reach 8,970 of the 9,142 statements in the 28; each of the other
172 is proven unreachable, with its reason, in `more/ltch/unreachable.txt`.

The calculators are built as the recorded run built them, with
`-frelax-syntax-checks -frelax-level-hierarchy` and without `-debug`.
For the 23 calculators from LTCAL063 on, GnuCOBOL 3.2 refuses a `REDEFINES` that names a redefinition ("is not the original definition"), even with those switches; IBM's compiler takes it to mean the original item.
`cms/ltch/build/` holds a copy of each of the 23 with those clauses made to name the original - the same bytes -
and nothing else changed, and the script builds those copies. CMS's own files are in `cms/ltch/` untouched. The inputs, and how they were made, are in `more/ltch/`.

## CMS's ESRD driver

`sh verify_esdrv.sh` checks CMS's ESRD driver, ESDRV212 from the CY2021.2
mainframe package, calling the 20 calculators as a claim reaches them: it
checks the claim, finds its wage index in CMS's tables, and calls the
calculator for the claim's date. A short driver reads 14,119 record sets,
made from ESDRV212's own conditions and from CMS's own wage tables
(`more/esdrv/README.md` says how), and calls ESDRV212 with them under GnuCOBOL
with Cocoon's tap; Cocoon's Java for ESDRV212 and the 20 calculators runs on
the same records; every record is compared byte for byte.

Some record sets make CMS's own ESDRV212 read outside a table - a subscript
of 0, or past a table's end. COBOL leaves what such a read gives undefined,
so nothing here rests on one: the COBOL is built with GnuCOBOL's run-time
checks on (`-debug`), and where a call stops, it is noted and the run goes
on from the next record set as a fresh load; the Java starts fresh at the
same points. Every call must be one of two things: clean, with the Java
leaving the same bytes in every record; or stopped under the checks, with
the Java stopping in the same paragraph. Each call's verdict must also be
the recorded run's (`more/esdrv/calls.txt`). Its last line should read:

```
ALL: CALLS=14119 CLEAN=11148 EQUAL=11148 STOPPED=2971 SAME-PARAGRAPH=2971 FAILED=0
```

**Planted bugs.** To show those calls would catch a real translation
mistake, 400 bugs were planted in the Java for ESDRV212, one at a time - a
comparison turned round, a statement deleted, a constant changed - and every
call run against each. 317 were caught. Each of the other 83 has a
written proof that it cannot change any result: a line no input can reach,
bytes no program reads, a value the field already holds, and so on. The
bugs and the proofs are in `more/esdrv/planted/`, to check against
`cocoon/esdrv/Esdrv212.java` and CMS's source.

## What it does

1. Copies CMS's files into `work/` and makes two build-only changes to the
   copies: `ORGANIZATION IS LINE SEQUENTIAL` on each `SELECT`, and CRLF and
   the DOS end-of-file mark removed from the inputs.
2. Builds CMS's pricer with GnuCOBOL and runs it on the 21 claims, and
   checks its output file against the one recorded in `expected/`.
3. Builds it again with Cocoon's tap on CMS's driver, which prints, as hex,
   every record passed to HHCAL213 before and after each call.
4. Compiles Cocoon's Java for HHCAL213 and runs it on the same before-records,
   one instance for all 21 calls, as one load of the COBOL program serves
   them. Working storage carries over between calls in both.
5. Compares every after-record, byte for byte.

## What is here

| | |
|---|---|
| `cms/` | CMS's files, unmodified: the COBOL, its copybooks, the test claims and tables (see NOTICE) |
| `cocoon/` | Cocoon's output: the Java for HHCAL213, the harness that feeds it, the tapped driver, and the runtime as a compiled jar |
| `expected/` | the pricer's output file as GnuCOBOL 3.2 produced it |
| `verify.sh`, `verify_more.sh`, `verify_esrd.sh`, `verify_ltch.sh`, `verify_esdrv.sh`, `compare.awk`, `esdrv_judge.awk` | the checks, readable before they run |
| `more/` | the inputs of the larger runs, and how each was made |
| `cms/esrd/` | CMS's 20 ESRD calculators, its ESRD driver ESDRV212, and their copybooks, unmodified |
| `cocoon/esrd/` | Cocoon's output for them: the Java for each, and each tapped driver |
| `more/esrd/` | each one's record sets, driver, how the kept sets were made, what was never reached, and why |
| `cocoon/esdrv/` | Cocoon's output for ESDRV212 and the 20 calculators it calls: the Java, the harness, the tapped driver, and the runtime the run used, as a compiled jar |
| `more/esdrv/` | ESDRV212's record sets, each one's reason, each call's verdict, and the planted bugs with the proof of each one not caught |
| `cms/ltch/` | CMS's 28 LTCH calculators and their copybooks, unmodified (`build/`: see above) |
| `cocoon/ltch/` | Cocoon's output for them: the Java for each, and each tapped driver |
| `more/ltch/` | each one's record sets, driver, how the kept sets were made, what was never reached, and why |
| `EVIDENCE.md`, `evidence/`, `analysis/` | the wider evidence, with its raw records |

Cocoon's own source is not here, and nothing in `verify.sh`, `verify_more.sh`,
`verify_esrd.sh`, `verify_ltch.sh` or `verify_esdrv.sh` needs it.

## What this does not show

- Agreement with IBM Enterprise COBOL on z/OS. The reference here is
  GnuCOBOL 3.2; IBM's results can differ with compiler options and with
  EBCDIC collation.
- Agreement with CMS's published payment amounts, beyond what CMS's own
  COBOL computes.
- The LTCH calculators called through CMS's own driver, LTDRV212, as a claim
  would reach them: here they are driven directly.
- Anything about CMS's other 12 pricers, or about speed.

`EVIDENCE.md` sets out what else has been measured, and what has not.

## Cocoon itself

Cocoon is available for evaluation. Open an issue here to get in touch.

## Files: seven programs, against GnuCOBOL

Cocoon's Java now reads and writes files. Seven small COBOL programs exercise it: a
line-sequential copy, the same copy failing on a record GnuCOBOL refuses to write
(status 71, the run ends), a fixed-length file written, extended, rewritten in place and
read past its end, a missing file with and without FILE STATUS, an indexed file written,
read by key, rewritten, deleted, started and read in key order, and DISPLAY of every kind
of number. `verify_files.sh` compiles each under GnuCOBOL and its Java with javac, runs
both on the same input file, and compares the output, the exit status and every file
written, byte for byte. GitHub runs it with GnuCOBOL 3.2 built with Berkeley DB, so the
indexed program is checked too.
