# Judging Cocoon's findings - a guide for an independent reviewer

Thank you for doing this. Cocoon is a static analyser for COBOL. Its default
report claims to hold findings that are almost always worth a programmer's
time. Your verdicts decide whether that claim is true. Nobody has judged
these findings before you, and the worksheet holds no one else's opinion.

## What you are given

`fp_worksheet_defect_independent.txt` - about 65 findings, sampled at random
from what Cocoon reports on five public codebases (CardDemo, the CICS
banking sample, NIST COBOL-85, dscobol tutorials, CMS Medicare pricers).
Each block shows the finding's class, its file and line, Cocoon's note, and
seven lines of the code around it.

## What to decide, for each finding

Write one word after `verdict:`

- **real** - a programmer maintaining this program would want to be told.
  The finding is true of the code, and worth a minute of their time.
- **noise** - they would not: either it is not true of the code, or it is
  true and could not matter.
- **unsure** - you cannot tell. Counted separately, and left out of the
  rate: a guess is not a label.

`why:` is optional, but please give a reason for every **noise**: that is
what gets fixed.

## Ground rules

- Judge the code, not the note. Cocoon's note is the claim being tested;
  treat it as an assertion, not as evidence.
- If seven lines are not enough, open the file - the path is on each block.
  If you still cannot tell, say **unsure**.
- A finding in test code (the NIST suite tests a compiler, and does odd
  things on purpose) is judged like any other: would someone maintaining
  that program want to see it?
- Please do not discuss the verdicts with the developer until you are done.

## How

Any text editor works: write the word after `verdict:` and save. Or, in a
terminal with the repository:

    python3 cocoon_benchmark.py label analysis/fp_worksheet_defect_independent.txt

which shows one finding at a time - press r, n or u, then Enter - and saves
each answer as it is given. It takes about one to two hours.

Return the file as it is. The result is published in `EVIDENCE.md` with your
verdicts in the repository, and with your name if you agree to it.
