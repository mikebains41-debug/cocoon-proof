# Cocoon proof

[![verify](https://github.com/mikebains41-debug/cocoon-proof/actions/workflows/verify.yml/badge.svg)](https://github.com/mikebains41-debug/cocoon-proof/actions/workflows/verify.yml)

GitHub runs `verify.sh` on a fresh Ubuntu machine, with GnuCOBOL 3.2 built from GNU's release, on every change and every week. The badge shows the latest result; the run's full log is one click away.

Cocoon translates COBOL into Java. This repository lets you check, on your
own machine, that its Java for a real Medicare pricing program leaves
exactly the same bytes as the COBOL it came from.

The program is HHCAL213, the calculator at the heart of CMS's Home Health
pricer for 2021. The inputs are the 21 test claims CMS ships with it.

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
| `verify.sh`, `compare.awk` | the check, readable before it runs |
| `EVIDENCE.md`, `evidence/`, `analysis/` | the wider evidence, with its raw records |

Cocoon's own source is not here, and nothing in `verify.sh` needs it.

## What this does not show

- Agreement with IBM Enterprise COBOL on z/OS. The reference here is
  GnuCOBOL 3.2; IBM's results can differ with compiler options and with
  EBCDIC collation.
- Agreement with CMS's published payment amounts, beyond what CMS's own
  COBOL computes.
- Anything about CMS's other pricers, or about speed.

`EVIDENCE.md` sets out what else has been measured, and what has not.

## Cocoon itself

Cocoon is available for evaluation. Open an issue here to get in touch.
