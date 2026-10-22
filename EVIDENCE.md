# Cocoon: what is proven, what is not, and how to check

> **In this repository,** `verify.sh`, `verify_more.sh`, `verify_esrd.sh` and `verify_ltch.sh` reproduce the Home Health, ESRD and LTCH results below with no Cocoon software at all. The analyser figures are reproduced with Cocoon itself, which is available for evaluation; their raw records are in `evidence/` and `analysis/`. Commit hashes refer to Cocoon's private development repository.

As of 16 October 2026. Every figure below comes from a run anyone can repeat,
and names the commit that produced it. Where something has not been
measured, this page says so.

Cocoon has two parts: a static analyser for COBOL, and a transformer that
turns COBOL into Java.

## Proven: the transformer

**One CMS pricer, end to end.** CMS's Home Health calculator, HHCAL213
(CY2021.3), translated to Java by Cocoon, leaves exactly the same bytes as the
COBOL itself, compiled with GnuCOBOL 3.2, in every record passed to it:

| Input | Calls | Records compared | Differences |
|---|---:|---:|---:|
| CMS's own 21 test claims | 21 | 126 | 0 |
| Claims generated from the calculator's own conditions, run through CMS's whole chain | 1,759 | 10,554 | 0 |
| Record sets driven straight into the calculator | 9,950 | 59,700 | 0 |
| CMS's 21 claims reversed, shuffled and repeated | 147 | 882 | 0 |

The 21 claims are re-run by every installer that touches shared code, most
recently at `c5373a2`.

**Coverage.** Those calls execute 337 of HHCAL213's 341 statements. The other
four (lines 1531-1540, the RAP payment rules) cannot be reached by any input:
every RAP leaves the calculator at line 431 with return code 03, before them.

**20 ESRD calculators, driven directly, every statement accounted for.** CMS's
ESRD calculators ESCAL056 to ESCAL212, from its CY2021.2 mainframe package, each
translated to Java by Cocoon at `6c25895` with no statement refused, leave exactly
the same bytes as the COBOL compiled with GnuCOBOL 3.2 in every record of
every call. CMS ships no test claims for them, so each is driven directly on
record sets made from its own conditions (`more/esrd/README.md` says how).
`verify_esrd.sh` reproduces the calls, records and differences below; GitHub
runs it on every change.

| Calculator | Calls | Records compared | Differences | Statements reached | Proven unreachable |
|---|---:|---:|---:|---:|---:|
| ESCAL056 | 3,000 | 9,000 | 0 | 137 of 137 | 0 |
| ESCAL062 | 3,000 | 12,000 | 0 | 139 of 139 | 0 |
| ESCAL070 | 3,000 | 12,000 | 0 | 139 of 139 | 0 |
| ESCAL071 | 3,000 | 12,000 | 0 | 141 of 141 | 0 |
| ESCAL080 | 3,000 | 12,000 | 0 | 142 of 142 | 0 |
| ESCAL091 | 3,000 | 12,000 | 0 | 135 of 135 | 0 |
| ESCAL100 | 3,000 | 12,000 | 0 | 134 of 134 | 0 |
| ESCAL117 | 3,000 | 15,000 | 0 | 511 of 531 | 20 |
| ESCAL122 | 3,000 | 15,000 | 0 | 565 of 594 | 29 |
| ESCAL130 | 3,000 | 15,000 | 0 | 565 of 594 | 29 |
| ESCAL140 | 3,000 | 15,000 | 0 | 520 of 595 | 75 |
| ESCAL151 | 3,000 | 15,000 | 0 | 520 of 595 | 75 |
| ESCAL160 | 3,000 | 15,000 | 0 | 497 of 567 | 70 |
| ESCAL170 | 3,000 | 15,000 | 0 | 505 of 535 | 30 |
| ESCAL171 | 3,000 | 15,000 | 0 | 506 of 536 | 30 |
| ESCAL180 | 3,000 | 15,000 | 0 | 510 of 540 | 30 |
| ESCAL191 | 3,000 | 15,000 | 0 | 510 of 540 | 30 |
| ESCAL200 | 3,000 | 15,000 | 0 | 510 of 540 | 30 |
| ESCAL202 | 3,000 | 15,000 | 0 | 523 of 553 | 30 |
| ESCAL212 | 3,000 | 15,000 | 0 | 533 of 563 | 30 |
| **all 20** | **60,000** | **276,000** | **0** | **7,742 of 8,250** | **508** |

Statements reached is the harness's count on these record sets, on the phone.
Every statement they never reach is proven unreachable from CMS's own source:
`more/esrd/unreachable.txt` gives each, with its reason, from four patterns the
prover checks (CWF-RESET 220, CONST 180, FLAG-CONTRA 63, PATHS-CONTRA 45). Two of them are dead code in CMS's own programs: the
comorbidity branches, where the return code is blanked before the calculation
tests it, and the pediatric branches of the low-volume outlier payment, where
the low-volume flag is only ever set for adults.

**28 LTCH calculators, driven directly, every statement accounted for.** CMS's
LTCH calculators LTCAL032 to LTCAL212, from its FY2021.2 mainframe package, each
translated to Java by Cocoon at `6c25895` with no statement refused, leave exactly
the same bytes as the COBOL compiled with GnuCOBOL 3.2 in every record of
every call. CMS ships no test claims for them, so each is driven directly on
record sets made from its own conditions (`more/ltch/README.md` says how).
`verify_ltch.sh` reproduces the calls, records and differences below; GitHub
runs it on every change.

| Calculator | Calls | Records compared | Differences | Statements reached | Proven unreachable |
|---|---:|---:|---:|---:|---:|
| LTCAL032 | 3,000 | 15,000 | 0 | 150 of 150 | 0 |
| LTCAL042 | 3,000 | 15,000 | 0 | 169 of 169 | 0 |
| LTCAL043 | 3,000 | 15,000 | 0 | 169 of 169 | 0 |
| LTCAL058 | 3,000 | 15,000 | 0 | 185 of 185 | 0 |
| LTCAL059 | 3,000 | 15,000 | 0 | 194 of 194 | 0 |
| LTCAL063 | 3,000 | 18,000 | 0 | 199 of 201 | 2 |
| LTCAL064 | 3,000 | 18,000 | 0 | 199 of 201 | 2 |
| LTCAL072 | 3,000 | 21,000 | 0 | 331 of 338 | 7 |
| LTCAL075 | 3,000 | 21,000 | 0 | 339 of 346 | 7 |
| LTCAL080 | 3,000 | 21,000 | 0 | 340 of 347 | 7 |
| LTCAL087 | 3,000 | 21,000 | 0 | 346 of 353 | 7 |
| LTCAL091 | 3,000 | 21,000 | 0 | 325 of 331 | 6 |
| LTCAL094 | 3,000 | 21,000 | 0 | 339 of 345 | 6 |
| LTCAL095 | 3,000 | 21,000 | 0 | 339 of 345 | 6 |
| LTCAL103 | 3,000 | 21,000 | 0 | 339 of 345 | 6 |
| LTCAL105 | 3,000 | 21,000 | 0 | 339 of 345 | 6 |
| LTCAL111 | 3,000 | 21,000 | 0 | 327 of 334 | 7 |
| LTCAL123 | 3,000 | 21,000 | 0 | 327 of 334 | 7 |
| LTCAL130 | 3,000 | 21,000 | 0 | 349 of 355 | 6 |
| LTCAL141 | 3,000 | 21,000 | 0 | 360 of 368 | 8 |
| LTCAL152 | 3,000 | 21,000 | 0 | 358 of 367 | 9 |
| LTCAL154 | 3,000 | 21,000 | 0 | 366 of 375 | 9 |
| LTCAL162 | 3,000 | 24,000 | 0 | 500 of 509 | 9 |
| LTCAL170 | 3,000 | 24,000 | 0 | 460 of 469 | 9 |
| LTCAL183 | 3,000 | 24,000 | 0 | 397 of 408 | 11 |
| LTCAL190 | 3,000 | 24,000 | 0 | 397 of 408 | 11 |
| LTCAL202 | 3,000 | 24,000 | 0 | 413 of 424 | 11 |
| LTCAL212 | 3,000 | 24,000 | 0 | 414 of 427 | 13 |
| **all 28** | **84,000** | **570,000** | **0** | **8,970 of 9,142** | **172** |

Statements reached is the harness's count on these record sets, on the phone.
Every statement they never reach is proven unreachable from CMS's own source:
`more/ltch/unreachable.txt` gives each, with its reason. 170 follow from nine
patterns the prover checks; the last two, LTCAL212 lines 2401 and 2406, rest on
thirteen facts checked against LTCAL212's source and tables
(`more/ltch/LTCAL212_2401_2406.txt`).

**Storage.** Working-storage records start with exactly the bytes GnuCOBOL
gives them: 859 records compared directly (823 in 56 CMS pricers, 36 in the
Home Health calculator). The generated Java reproduces that layout for all
1,013 records in 62 programs.

**Control flow and searching.** Probe programs covering fall-through, every
form of GO TO and PERFORM, GOBACK from depth, SEARCH and SEARCH ALL
(including on an unsorted table) and date functions leave the same bytes
under GnuCOBOL and as Java.

**Conformance probe.** 90 cases of COBOL semantics - edited pictures such as
ZZ9.99, class tests, MULTIPLY and DIVIDE in all their forms, MOVE ALL, point
literals - all equal to GnuCOBOL.

**CMS's 61 pricers** all translate to Java that compiles with 0 errors. At
`6c25895`, 300 statements are refused - visibly, never translated in part - and 48
of the 61 translate whole: the 20 ESRD calculators and the 28 LTCH
calculators. That count looks up each copy member by the name its COPY
statement gives, in CMS's folders. HHCAL213's two copy members, ADDONTBL and ADXONTBL,
are there as `addontbl.txt` and `adxontbl.txt`, so there it refuses the two `SEARCH ALL`
statements on their tables; with the members named as in `cms/`, it
translates whole.

## Proven: the analyser

**It scales linearly, with exact counts.** Run by `scale.py` on real copies
of five public corpora - CBSA, CardDemo, NIST COBOL-85, dscobol and the 61
CMS pricers, 554,490 lines per set - on a Samsung Galaxy S25 Ultra, at
`f8e3aec`. Raw records of every run: `evidence/scale/`.

| Tree | Lines | Findings | Expected | Problems | Time | Throughput | Peak memory |
|---|---:|---:|---|---:|---:|---:|---:|
| one set | 554,490 | 4,138 | - | 0 | 3.1 min | 2,984 lines/s | 54 MB |
| 2M | 2,217,960 | 16,552 | 4 x 4,138, exact | 0 | 8.5 min | 4,335 lines/s | 90 MB |
| 5M | 5,544,900 | 41,380 | 10 x 4,138, exact | 0 | 19.5 min | 4,739 lines/s | 92 MB |

Throughput does not fall as the tree grows. It is measured in one session,
and the phone's speed varies with its temperature, so the ratio to one set
differs from run to run; it is the flat line that matters. The trees are
copies of public code, not 5.5 million distinct lines.

The test has found three faults, each fixed before the run above:
identical statements in different copies deduplicated before checking,
which gave wrong counts (apply_80); copy-member lookup slowing as the tree
grew, to 40% and then 50% of the one-set rate (apply_81, apply_82); and,
with several projects in one tree, a program taking a copybook from another
project that has one of the same name, eight extra findings per copy
(apply_88). "0 problems" means the audit re-read every finding against the
line it names: the verb is there, the handler it says is missing is
missing, the fields it names are declared.

**Precision, measured and published with its labels.** Findings were sampled
by class from the five corpora and each judged real or noise; the worksheets,
with every verdict and reason, are in `analysis/`.

| Report | Precision | Measured on | Commit |
|---|---:|---|---|
| All findings, October baseline | 10% | 265 judged, 35 classes | `263b650` |
| All findings, today | 11% | the same labels, rescored | `c5373a2` |
| **Default report (defect tier)** | **99%** | a fresh sample of 70 | `c5373a2` |

The defect tier (`cocoon_tiers.py`) holds the classes the labels found real
nearly every time: ALTER, CICS length overruns, PERFORM recursion, unbounded
units of work, and READ and WRITE on files whose declared status nothing
checks. Every other finding is reported for review; none is hidden. The fresh
sample first measured 95%; it exposed three faults, fixed in apply_86 and
apply_87, and two verdicts were corrected when evidence contradicted them.
The one false positive left is a NIST compiler test. An earlier figure, 40%
of a sample of 281 in September, was drawn and weighted differently and is
superseded.

How the labels were made, plainly: 12 of October's verdicts were given by
hand; the rest were accepted from written readings by an AI assistant
(Claude), each marked so in the worksheets. Labels from an independent COBOL
engineer, on a new defect-tier sample with no readings in it
(`analysis/fp_worksheet_defect_independent.txt`), are pending. Until then
99% is the developer's own measurement. For comparison, from the literature:
Google's Tricorder disabled analyses above 10% false positives; SonarQube has
been measured at 18% precision, Coverity at 37%.

## Not proven

- **Equivalence against IBM Enterprise COBOL on z/OS.** The reference here is
  GnuCOBOL 3.2. IBM's results can differ with compiler options (ARITH, TRUNC,
  NUMPROC) and with EBCDIC collation, where 'A' sorts before '1'.
- **Agreement with CMS's official answers.** CMS's own Java Home Health
  pricer is to be run on the same claims as an independent check.
- **The other 12 CMS pricers**; COMP-5 byte order; invalid numeric data
  (S0C7).
- **The ESRD and LTCH calculators through CMS's own drivers.** They are proven
  driven directly, on record sets made from their own conditions; not yet
  called through CMS's drivers, ESDRV212 and LTDRV212, as a claim would reach
  them.
- **Independent precision labels** (pending, above), and the review tier:
  most of its findings are noise today, chiefly running totals real data
  cannot overflow and MOVEs that cut report text.
- **Results off this one machine, for the analyser.** Its figures ran on one
  Android phone under Termux. The Home Health, ESRD and LTCH proofs no
  longer depend on it: GitHub runs them on a fresh Ubuntu machine, with GnuCOBOL 3.2
  built from GNU's release and the Java compiled by javac where the phone
  uses ecj, on every change (github.com/mikebains41-debug/cocoon-proof).
- **Speed of the translated Java at batch volume**, and any saving in time or
  cost. Not measured, and not claimed.

## Check it yourself

The transformer results need no Cocoon software at all. With GnuCOBOL 3.2
(`cobc`), a Java compiler (`javac` from any JDK, or `ecj`), `java` and a
POSIX shell:

```
git clone https://github.com/mikebains41-debug/cocoon-proof
cd cocoon-proof
sh verify.sh        # CALLS=21 RECORDS=126 EQUAL=126 EXCEPTIONS=0
sh verify_more.sh   # ALL: CALLS=11856 RECORDS=71136 EQUAL=71136 EXCEPTIONS=0
sh verify_esrd.sh   # ALL: CALLS=60000 RECORDS=276000 EQUAL=276000 EXCEPTIONS=0
sh verify_ltch.sh   # ALL: CALLS=84000 RECORDS=570000 EQUAL=570000 EXCEPTIONS=0
```

Each compares Cocoon's Java with GnuCOBOL byte for byte, prints any
difference it finds, and exits with a failure if there is one. The proof of
every statement never reached is in `more/esrd/unreachable.txt` and
`more/ltch/unreachable.txt`, each with its reason, to check against CMS's
source in `cms/`.

**With Cocoon itself, for evaluators.** The statement counts, the
conformance probe and the analyser's figures come from Cocoon's own tools,
which are not in this repository. With Cocoon's repository at `~/Cocoon`,
CMS's CY2021 Home Health pricer COBOL (from CMS's PC Pricer and COBOL Text
File Archive), Java 17 or later with `ecj`, and Python 3, copy
`verify/hh/*` into the directory holding CMS's pricer files, then:

```
./rebuild_baseline.sh     # the COBOL baseline from CMS's source
./equiv.sh                # CMS's 21 claims: CALLS=21 RECORDS=126 EQUAL=126 EXCEPTIONS=0
python3 coverage.py       # which statements the 21 claims execute
python3 hh_fuzz.py        # generated claims through CMS's whole chain
python3 hh_direct2.py     # the calculator driven directly, with coverage
python3 hh_order.py       # the 21 claims in other orders
cd ~/Cocoon && python3 cocoon_conform.py   # conformance against GnuCOBOL
```

For the analyser, with the five corpora in place:

```
python3 scale.py audit                                    # the scale test
python3 cocoon_benchmark.py rescore analysis/fp_worksheet_2026-10.txt <corpora>
python3 cocoon_benchmark.py precision analysis/fp_worksheet_defect_2026-10.txt
```

Each transformer script compares Cocoon's Java with GnuCOBOL byte for byte and
prints any difference it finds. A difference is a bug in Cocoon; a statement
Cocoon cannot translate is reported as refused, never translated in part.
