# More runs

`verify_more.sh` runs HHCAL213 on three more sets of inputs, as COBOL and as
Cocoon's Java, and compares every record byte for byte, the same way
`verify.sh` does for CMS's 21 claims.

| Set | Calls | Records | How it was made |
|---|---:|---:|---|
| orders | 147 | 882 | CMS's 21 claims reversed, shuffled, each twice in a row, and shuffled three times over, in one run: working storage carries from call to call, so whatever one claim leaves for the next must be left the same way by both |
| generated | 1,759 | 10,554 | each claim one of CMS's 21 with fields set to exactly the values the calculator's conditions test (and one more and one less), or equal to, lower and higher than the field they are compared with, then random mixes of two or three such changes; run through CMS's whole chain |
| direct | 9,950 | 59,700 | the six records of real captured calls, with fields changed the same way and more, read by a ten-line COBOL driver that calls HHCAL213 with each set: this reaches the checks CMS's driver makes itself and never calls the calculator for |

The inputs are exactly as first run: `orders/HHAFILE`, `generated/HHAFILE`,
and `direct/direct.dat` with its driver `direct/hhdirect.cbl`. Its tapped
form, `cocoon/hhdirect_tap.cbl`, prints each record before and after each
call. `direct/records.txt`, where present, says what was changed to make
each record set.

They were generated from the calculator's own source by tools in Cocoon's
private repository. Checking them does not need those tools: the inputs are
data.

Each set runs on the build its first run used: the orders on CMS's chain
built with `-debug`, as `verify.sh` builds it, and the other two without it.
