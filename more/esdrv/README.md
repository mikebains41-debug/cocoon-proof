# CMS's ESRD driver ESDRV212: the record sets

`direct.dat.gz` holds 14,119 record sets of 846 bytes each: ESDRV212's
records that vary from claim to claim, end to end, in the order of its
USING list. The driver in `cocoon/esdrv/cmsdirct_tap.cbl` reads them one by
one and calls ESDRV212 with them; ESDRV212 calls the calculators: ESCAL212, ESCAL202, ESCAL200, ESCAL191, ESCAL180, ESCAL171, ESCAL170, ESCAL160, ESCAL151, ESCAL140, ESCAL130, ESCAL122, ESCAL117, ESCAL100, ESCAL091, ESCAL080, ESCAL071, ESCAL070, ESCAL062, ESCAL056.

They were made by Cocoon's harness from ESDRV212's own conditions,
over several runs, each run starting from the sets the last one kept:

- each test ESDRV212 makes gives values to try: each side of every
  comparison, every date its ladders name, and the day either side;
- claims that set every field a whole path of nested tests looks at, at
  once, built on claims the calculators price;
- claims built from CMS's own wage tables, read out of ESDRV212: MSAs and
  CBSAs found at their entries, pairs of calls that carry a wage rate from
  one claim to the next, and supplemental wage indexes on the -5% edge of
  the bundled index;
- a set is kept when it reaches something no kept set had reached: a
  statement, or an outcome of a test.

`records.txt.gz` gives each set's reason, one line per set, by number.
`calls.txt` gives each call's verdict in the recorded run: C, clean under
GnuCOBOL's run-time checks, with the Java's bytes equal; S, stopped under
the checks, with the Java stopping in the same paragraph; after a stop, both
go on from the next set as a fresh load. `called.txt` lists the programs
ESDRV212 calls, built with it; `shown.txt`, the records the tap shows.
