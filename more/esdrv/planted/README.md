# Planted bugs in the Java for ESDRV212

To show the calls would catch a real translation mistake, bugs were planted
in Cocoon's Java for ESDRV212 (`cocoon/esdrv/Esdrv212.java`), one at a time,
and every call run against each. A bug is caught when any record of any
call comes out different, or a call stops where it ran, or runs where it
stopped.

- `bugs_100.txt` and `bugs_300.txt`: the two samples, with each bug's kind,
  its line, the line as it was and as planted, and what the calls did with
  it; 81 and 236 caught.
- `proofs_100.txt` and `proofs_300.txt`: for each bug not caught (19 and
  64), the proof that it cannot change any result, written out against
  the Java, CMS's source and CMS's tables.

In all, 400 bugs planted: 317 caught, 83 proven unable to change a
result, none open.

| Proof | Bugs |
|---|---:|
| GUARD-TAKEN | 27 |
| UNREACHED | 21 |
| FLOW | 8 |
| OVERWRITTEN | 7 |
| DATE-LADDER | 6 |
| UNREAD-BYTES | 5 |
| TABLE-EDGE | 2 |
| LOOP-STEP | 2 |
| CAP-ROUND | 2 |
| REDUNDANT | 2 |
| VALUE-SET | 1 |

What each proof says:

- **UNREACHED**: no path through the program reaches the line.
- **GUARD-TAKEN**, **DATE-LADDER**: the one value the change adds is taken by
  an earlier test, which leaves first.
- **OVERWRITTEN**, **REDUNDANT**, **DEAD-STORE**: the changed store is
  overwritten before anything reads it, stores the value already there, or
  stores where nothing reads.
- **UNREAD-BYTES**: no program here reads the bytes changed.
- **VALUE-SET**: the field tested only ever holds constants the change cannot
  tell apart.
- **LOOP-STEP**: a search over a sorted constant table still stops inside it,
  and what it finds there is never read.
- **TABLE-EDGE**: the changed test matters only for a table entry CMS's
  table does not have.
- **CAP-ROUND**: the change decides differently only on an edge so thin that
  the capped value rounds back to the one already held.
- **FLOW**: the changed bytes, followed through every paragraph, PERFORM,
  loop and CALL, and inside the programs called, reach nothing the caller
  sees.

A bug caught can be planted again by hand in the Java, and `verify_esdrv.sh`
run: it fails.
