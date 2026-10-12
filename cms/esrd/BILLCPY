000100******************************************************************
000200*   This is the BILL-RECORD that will be passed to and returned  *
000300*   from the ESCALxx program.                                    *
000400* 6-15-17 added B-PAYER-ONLY-VC-Q8 for FY18 and TDAPA            *
000500* 8-24-17 added TDAPA-RETURN for FY18 and TDAPA                  *
000600* 10-3-17 added comment about BUNDLED-TEST-INDIC                *
000700* 3-11-20 added the following for ETC HDPA model:                *
000800*   input field for the Data Code                                *
000900*     B-DATA-CODE PIC X(02)                                      *
001000*   output field - Adjusted Base Rate before bonus               *
001100*     ADJ-BASE-WAGE-BEFORE-ETC-HDPA  PIC 9(07)V9(04)             *
001200* 9-4-20 - added following:                                     *
001300*     TPNIES                                                     *
001400*         - TPNIES-RETURN                                        *
001500*     SUPPLEMENTAL-WAGE-INDEX                                    *
001600*         - P-SUPP-WI-IND                                        *
001700*         - P-SUPP-WI                                            *
001800*     NETWORK-REDUCTION                                          *
001900*         - NETWORK-REDUCTION-RETURN                             *
002000*         - B-PAYER-ONLY-VALUE-CODE                              *
002100*         - B-PAYER-ONLY-VC-QG-AMT                               *
002200*                                                                *
002300******************************************************************
002400*INPUT to the Calculating subroutine from the Driver subroutine. *
002500******************************************************************
002600
002700 01  BILL-NEW-DATA.
002800     05  BILL-PORTION.
002900         10  B-COND-CODE            PIC X(02).
003000         10  B-REV-CODE.
003100             15  B-REV-CODE3        PIC X(03).
003200             15  FILLER             PIC X(01).
003300         10  B-PATIENT-HGT          PIC 9(07)V9(02).
003400         10  B-PATIENT-HEIGHT  REDEFINES  B-PATIENT-HGT
003500                                    PIC 9(09).
003600         10  B-PATIENT-WGT          PIC 9(07)V9(02).
003700         10  B-PATIENT-WEIGHT  REDEFINES  B-PATIENT-WGT
003800                                    PIC 9(09).
003900         10  B-THRU-DATE.
004000             15  B-THRU-CCYY        PIC 9(04).
004100             15  B-THRU-MM          PIC 9(02).
004200             15  B-THRU-DD          PIC 9(02).
004300         10  B-DOB-DATE.
004400             15  B-DOB-CCYY         PIC 9(04).
004500             15  B-DOB-MM           PIC 9(02).
004600             15  B-DOB-DD           PIC 9(02).
004700         10  FILLER                 PIC X(20).
004800     05  PROVIDER-SPECIFIC-FILE-PORTION.
004900         10  P-NPI                  PIC X(08).
005000         10  P-NPI-FILLER           PIC X(02).
005100         10  P-PROV-OSCAR           PIC X(06).
005200         10  P-GEO-MSA              PIC X(04).
005300         10  P-GEO-CBSA             PIC X(05).
005400         10  P-SPEC-PYMT-IND        PIC X(01).
005500         10  P-PROV-TYPE            PIC X(02).
005600         10  P-SPEC-WAGE-INDX       PIC 9(02)V9(04).
005700         10  P-ESRD-RATE            PIC 9(07)V9(02).
005800         10  P-PROV-WAIVE-BLEND-PAY-INDIC
005900                                    PIC X(01).
006000         10  P-PROV-LOW-VOLUME-INDIC
006100                                    PIC X(01).
006200         10  P-PACIFIC-IS-TRUST-TERR
006300                                    PIC X(01).
006400         10  P-QIP-REDUCTION        PIC X(01).
006500         10  P-SUPP-WI-IND          PIC X(01).
006600         10  P-SUPP-WI              PIC 9(02)V9(04).
006700         10  FILLER                 PIC X(08).
006800         10  OLD-TEST-INDICATOR     PIC X(01).
006900             88  OLD-TEST-CASE               VALUE 'T'.
007000         10  FILLER                 PIC X(23).
007100     05  BUNDLED-BILL-PORTION.
007200         10  B-CLAIM-NUM-DIALYSIS-SESSIONS
007300                                    PIC 9(02).
007400         10  B-LINE-ITEM-DATE-SERVICE.
007500             15  B-LINE-ITEM-DT-SVC-CCYY
007600                                    PIC 9(04).
007700             15  B-LINE-ITEM-DT-SVC-MM
007800                                    PIC 9(02).
007900             15  B-LINE-ITEM-DT-SVC-DD
008000                                    PIC 9(02).
008100         10  B-DIALYSIS-START-DATE.
008200             15  B-DIALYSIS-START-DT-CCYY
008300                                    PIC 9(04).
008400             15  B-DIALYSIS-START-DT-MM
008500                                    PIC 9(02).
008600             15  B-DIALYSIS-START-DT-DD
008700                                    PIC 9(02).
008800         10  B-TOT-PRICE-SB-OUTLIER PIC 9(07)V9(02).
008900         10  B-PAYER-ONLY-VC-Q8     PIC 9(07)V9(04).
009000         10  B-DATA-CODE            PIC X(02).
009100         10  B-PAYER-ONLY-VALUE-CODE PIC X(02).
009200         10  B-PAYER-ONLY-VC-QG-AMT PIC 9(07)V9(04).
009300         10  FILLER                 PIC X(14).
009400     05  COMORBIDITIES-PORTION.
009500         10  COMORBID-DATA    OCCURS 6 TIMES
009600                INDEXED BY COMORBID-INDEX
009700                                    PIC X(02).
009800         10  COMORBID-RECURRENCE-COND-CODE
009900                                    PIC X(02).
010000         10  COMORBID-CWF-RETURN-CODE
010100                                    PIC X(02).
010200           88  VALID-COMORBID-CWF-RETURN-CD   VALUE '10',
010300                                                    '20',
010400                                                    '30',
010500                                                    '40',
010600                                                    '50',
010700                                                    '60',
010800                                                    '70'.
010900*  The following variables are from the old pricer and are used fo
011000*testing purposes, displaying within the manager main program what
011100*went on in the calculating subroutine.
011200*Ther were removed from their old location to simplify matters and
011300*are inserted here in the exact same order that they appeared in o
011400*pricers.  The variable names have been kept the same so as to min
011500*recoding when inserting this linkage section into the old pricers
011600*'bring them up to the 2011 record layout standards'.  They origin
011700*were redefining filler items (which they kind of still do, only n
011800*are inserted in the middle of the large filler area at the end of
011900*this record layout).  This filler area will eventually be used in
012000*up coming pricers, perhaps for the 25 ICD-10 procedure codes but
012100*hopefully after this bundled pricer gets settled down.
012200*Their level numbers have changed but nothing else.
012300*FISS does not receive these fields
012400     05  BILL-DATA-TEST.
012500         10  DRUG-ADD-ON-RETURN     PIC 9(01)V9(04).
012600         10  MSA-WAGE-ADJ           PIC 9(04)V9(02).
012700         10  COMP-CBSA-WAGE-ADJ   REDEFINES MSA-WAGE-ADJ
012800                                    PIC 9(04)V9(02).
012900         10  CBSA-WAGE-ADJ          PIC 9(04)V9(02).
013000         10  BUND-CBSA-WAGE-ADJ   REDEFINES CBSA-WAGE-ADJ
013100                                    PIC 9(04)V9(02).
013200         10  CBSA-WAGE-PMT-RATE     PIC 9(04)V9(02).
013300         10  COND-CD-73.
013400             15  FILLER             PIC X(01).
013500             15  AMT-INDIC          PIC X(01).
013600             15  FILLER             PIC X(01).
013700             15  BLOOD-DOLLAR       PIC 9(02).
013800             15  FILLER             PIC X(03).
013900         10  COND-CD-74           REDEFINES  COND-CD-73.
014000             15  HEMO-CCPD-CAPD     PIC 9(02)V9(06).
014100         10  AGE-RETURN             PIC 9(03).
014200         10  MSA-WAGE-AMT           PIC S9(04)V9(02).
014300         10  CBSA-WAGE-INDEX        PIC S9(02)V9(04).
014400         10  LABOR-PCT              PIC 9(01)V9(05).
014500         10  PPS-BMI                PIC 9(03)V9(04).
014600         10  PPS-BSA                PIC 9(03)V9(04).
014700         10  MSA-PCT                PIC 9(01)V9(02).
014800         10  CBSA-PCT               PIC 9(01)V9(02).
014900         10  COM-CBSA-PCT-BLEND     PIC 9(01)V9(02).
015000         10  BUN-CBSA-PCT-BLEND     PIC 9(01)V9(02).
015100         10  CASE-MIX-FCTR-ADJ-RATE PIC 9(07)V9(02).
015200* Bundled data (i.e. new PPS data)
015300         10  BUN-BSA                PIC 9(03)V9(04).
015400         10  BUN-BMI                PIC 9(03)V9(04).
015500         10  BUN-ONSET-FACTOR       PIC 9(01)V9(04).
015600         10  BUN-COMORBID-MULTIPLIER
015700                                    PIC 9(01)V9(03).
015800         10  BUN-WAGE-ADJ-TRAINING-AMT
015900                                    PIC 9(04)V9(04).
016000         10  BUN-LOW-VOL-MULTIPLIER PIC 9(01)V9(03).
016100         10  FILLER                 PIC X(18).
016200* Outlier data
016300         10  OUT-AGE-FACTOR         PIC 9(01)V9(03).
016400         10  OUT-BSA                PIC 9(03)V9(04).
016500         10  OUT-BSA-FACTOR         PIC 9(01)V9(04).
016600         10  OUT-BMI                PIC 9(03)V9(04).
016700         10  OUT-BMI-FACTOR         PIC 9(01)V9(04).
016800         10  OUT-ONSET-FACTOR       PIC 9(01)V9(04).
016900         10  OUT-COMORBID-MULTIPLIER
017000                                    PIC 9(01)V9(03).
017100         10  OUT-LOW-VOL-MULTIPLIER PIC 9(01)V9(03).
017200         10  OUT-ADJ-AVG-MAP-AMT    PIC 9(03)V9(02).
017300         10  OUT-LOSS-SHARING-PCT   PIC 9(01)V9(02).
017400         10  OUT-IMPUTED-MAP        PIC 9(04)V9(04).
017500         10  OUT-FIX-DOLLAR-LOSS    PIC 9(04)V9(02).
017600         10  OUT-PREDICTED-MAP      PIC 9(07)V9(04).
017700         10  OUT-PREDICTED-SERVICES-MAP
017800                                    PIC 9(02)V9(04).
017900
018000*ESRD PC PRICER NEEDS BUNDLED-TEST-INDIC SET TO "T" IN ORDER TO BE
018100*TO PASS VALUES FOR DISPLAYING DETAILED RESULTS FROM BILL-DATA-TES
018200*BUNDLED-TEST-INDIC IS NOT SET TO "T"  IN THE PRODUCTION SYSTEM (F
018300     05  BUNDLED-TEST-INDIC         PIC X(01).
018400       88  BUNDLED-TEST                       VALUE 'T'.
018500
018600******************************************************************
018700*OUTPUT from Calculating subroutine returned the Driver program. *
018800******************************************************************
018900
019000 01  PPS-DATA-ALL.
019100     05  PPS-RTC                    PIC 9(02).
019200     05  PPS-DATA.
019300         10  PPS-MSA                PIC X(04).
019400         10  PPS-CBSA               PIC X(05).
019500         10  PPS-WAGE-ADJ-RATE      PIC 9(04)V9(02).
019600         10  PPS-FINAL-PAY-AMT      PIC 9(07)V9(02).
019700         10  PPS-CALC-VERS-CD       PIC X(05).
019800         10  PPS-COND-CODE          PIC X(02).
019900         10  PPS-REV-CODE           PIC X(04).
020000         10  PPS-2011-WAGE-ADJ-RATE PIC 9(04)V9(02).
020100         10  PPS-2011-NAT-LABOR-PCT PIC 9(01)V9(05).
020200         10  PPS-2011-NAT-NONLABOR-PCT
020300                                    PIC 9(01)V9(05).
020400         10  FILLER                 PIC X(02).
020500     05  PPS-OTHER-DATA.
020600         10  PPS-NAT-LABOR-PCT      PIC 9(01)V9(05).
020700         10  PPS-NAT-NONLABOR-PCT   PIC 9(01)V9(05).
020800         10  PPS-AGE-FACTOR         PIC 9(01)V9(03).
020900         10  PPS-BSA-FACTOR         PIC 9(01)V9(04).
021000         10  PPS-BMI-FACTOR         PIC 9(01)V9(04).
021100         10  PPS-BDGT-NEUT-RATE     PIC 9(01)V9(04).
021200         10  PPS-2011-AGE-FACTOR    PIC 9(01)V9(03).
021300         10  PPS-2011-BSA-FACTOR    PIC 9(01)V9(04).
021400         10  PPS-2011-BMI-FACTOR    PIC 9(01)V9(04).
021500         10  PPS-2011-BDGT-NEUT-RATE
021600                                    PIC 9(01)V9(04).
021700         10  FILLER                 PIC X(01).
021800     05  PPS-BUNDLED-DATA.
021900         10  PPS-2011-COMORBID-DATA.
022000             15  PPS-2011-COMORBID-MA
022100                                    PIC X(02).
022200             15  PPS-2011-COMORBID-MA-CC
022300                                    PIC X(02).
022400             15  PPS-2011-COMORBID-PAY
022500                                    PIC X(02).
022600             15  FILLER             PIC X(24).
022700         10  PPS-2011-FULL-COMP-RATE
022800                                    PIC 9(07)V9(02).
022900         10  PPS-2011-BLEND-COMP-RATE
023000                                    PIC 9(07)V9(02).
023100         10  PPS-2011-FULL-PPS-RATE
023200                                    PIC 9(07)V9(02).
023300         10  PPS-2011-BLEND-PPS-RATE
023400                                    PIC 9(07)V9(02).
023500         10  PPS-2011-FULL-OUTLIER-RATE
023600                                    PIC 9(07)V9(02).
023700         10  PPS-2011-BLEND-OUTLIER-RATE
023800                                    PIC 9(07)V9(02).
023900     05  MSA-ADJ-YEAR-AMT           PIC 9(04)V9(02).
024000     05  PPS-LOW-VOL-AMT         REDEFINES MSA-ADJ-YEAR-AMT
024100                                    PIC 9(04)V9(02).
024200     05  OUT-CASE-MIX-PREDICTED-MAP PIC 9(04)V9(04).
024300     05  OUT-HEMO-EQUIV-DIAL-SESSIONS
024400                                    PIC 9(02)V9(04).
024500     05  OUT-SB-BSA                 PIC 9(01)V9(03).
024600     05  OUT-SB-BMI                 PIC 9(01)V9(03).
024700     05  A-49-CENT-DRUG-ADJ         PIC 9(01)V9(02).
024800     05  PPS-CM-BSA                 PIC 9(01)V9(03).
024900     05  PPS-CM-BMI-LT-18-5         PIC 9(01)V9(03).
025000     05  PPS-BUN-BASE-PMT-RATE      PIC 9(04)V9(02).
025100     05  BUN-ADJUSTED-BASE-WAGE-AMT PIC 9(07)V9(04).
025200     05  CR-BSA-MULTIPLIER          PIC 9(01)V9(03).
025300     05  CR-BMI-MULTIPLIER          PIC 9(01)V9(03).
025400     05  PPS-BUN-CBSA-W-INDEX       PIC 9(02)V9(04).
025500     05  PPS-BUN-WAGE-ADJ-TRAIN-AMT PIC 9(07)V9(04).
025600     05  PPS-TRAINING-ADD-ON-PMT-AMT
025700                                    PIC 9(02)V9(02).
025800     05  OUT-NON-PER-DIEM-PAYMENT   PIC 9(07)V9(04).
025900     05  COM-PAYMENT-RATE           PIC 9(04)V9(02).
026000     05  TDAPA-RETURN               PIC 9(07)V9(04).
026100     05  TPNIES-RETURN              PIC 9(07)V9(04).
026200     05  NETWORK-REDUCTION-RETURN   PIC 9(01)V9(02).
026300     05  ADJ-BASE-WAGE-BEFORE-ETC-HDPA
026400                                    PIC 9(07)V9(04).
026500     05  FILLER                     PIC X(066).
