000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID.    HHCAL213.                                         00020028
000300 DATE-COMPILED.                                                   00030000
000400******************************************************************00040000
000500* NATIONAL HHA PRICER EFFECTIVE JANUARY 1, 2021.                 *00050000
000600******************************************************************00060000
000700*                   CY2021.3 CHANGES                             *00070030
000800*                                                                *00080032
000900* -- UPDATED COPY ADDONTBL TO ADD ADDITIONAL COUNTY CODES        *00090032
000910* -- UPDATED PARAGRAPH 9110-COMPUTE-LATE-SUB-PENALTY             *00091032
001000*    IF THE DAYS DIFFERENCE IS GREAT THAN 30 DAYS,               *00100032
001010*       USE 30 DAYS                                              *00101032
001020*    IF THE DAYS DIFFERENCE IS LESS THAN 31 DAYS,                *00102032
001030*       USE ACTUAL DAYS                                          *00103032
002600******************************************************************00260000
002700******************************************************************00270000
002800*    RETURN CODES                                                *00280000
002900******************************************************************00290000
003000*  00 = FINAL PAYMENT                                            *00300000
003100*       TOB = 327, 329, 32F, 32G, 32H, 32I, 32J,                 *00310000
003200*             32K, 32M, 32Q, 32P                                 *00320000
003300*       WITH HRG,REVENUE CODE WHERE NO OUTLIER APPLIES           *00330000
003400*  01 = FINAL PAYMENT                                            *00340000
003500*       TOB = 327, 329, 32F, 32G, 32H, 32I, 32J,                 *00350000
003600*             32K, 32M, 32Q, 32P                                 *00360000
003700*       WITH HRG,REVENUE CODE WHERE OUTLIER APPLIES              *00370000
003800*  03 = INITIAL HALF PAYMENT PAYMENT WILL BE ZERO                *00380000
003900*       TOB = 322                                                *00390000
004000*  04 = INITIAL HALF PAYMENT PAID AT 50%                         *00400000
004100*       TOB = 322                                                *00410000
004200*       WITH INITIAL (FIRST) HRG AND NO REVENUE CODES            *00420000
004300*  05 = INITIAL HALF PAYMENT PAID AT 60%                         *00430000
004400*       TOB = 322                                                *00440000
004500*       WITH INITIAL (FIRST) HRG AND NO REVENUE CODES            *00450000
004600*  06 = LUPA PAYMENT ONLY                                        *00460000
004700*       TOB = 327, 329, 32F, 32G, 32H, 32I, 32J,                 *00470000
004800*             32K, 32M, 32Q, 32P                                 *00480000
004900*       WITH REVENUE CODES AND REVENUE QTYS < 5                  *00490000
005000*  09 = FINAL PAYMENT, PEP = Y, NO OUTLIER                       *00500000
005100*  11 = FINAL PAYMENT, PEP = Y, WITH OUTLIER                     *00510000
005200******************************************************************00520000
005300*                                                                *00530000
005400*            HHA-RTC   NO PAYMENTS RETURNED                      *00540000
005500*                                                                *00550000
005600*  10 = INVALID TOB                                              *00560000
005700*  15 = INVALID HRG DAYS FOR SHORTENED EPISODE                   *00570000
005800*  16 = INVALID HRG DAYS, > 30 DAYS                              *00580000
005900*  20 = INVALID PEP INDICATOR                                    *00590000
006000*  25 = INVALID MED REVIEW INDICATOR                             *00600000
006100*  30 = INVALID CBSA CODE                                        *00610000
006200*  31 = COUNTY CODE MISSING OR INVALID                           *00620000
006300*  35 = INVALID INITIAL PAYMENT INDICATOR                        *00630000
006400*       0 = MAKE NORMAL PERCENTAGE PAYMENT                       *00640000
006500*       1 = PAY 0%                                               *00650000
006600*       2 = MAKE FINAL PAYMENT REDUCED BY 2%                     *00660000
006700*       3 = MAKE FINAL PAYMENT REDUCED BY 2%,                    *00670000
006800*           PAY RAPS AT 0%                                       *00680000
006900*  40 = ADMIT-DATE > SERV-FROM-DATE                              *00690000
007000*  70 = INVALID OR NO HRG CODE PRESENT                           *00700000
007100*  75 = REMOVED IN CY2020 RELEASE                                *00710000
007200*  80 = INVALID REVENUE CODE                                     *00720000
007300*  85 = NO REVENUE CODE PRESENT                                  *00730000
007400*       TOB = 327, 329, 32F, 32G, 32H, 32I, 32J,                 *00740000
007500*             32K, 32M, 32Q, 32P                                 *00750000
007600*                                                                *00760000
007700******************************************************************00770000
007800* QRP  = QUALITY REPORTING PROGRAM                               *00780000
007900* LUPA = LOW UTILIZATION PAYMENT ADJUSTMENT                      *00790000
008000* RAP  = REQUEST FOR ANTICIPATED PAYMENT                         *00800000
008100*------------ REVENUE CODES -------------------------------------*00810000
008200* 0420 = PHYSICAL THERAPY                                        *00820000
008300* 0430 = OCCUPATIONAL THERAPY                                    *00830000
008400* 0440 = SPEECH-LANGUAGE PATHOLOGY                               *00840000
008500* 0550 = SKILLED NURSING                                         *00850000
008600* 0560 = MEDICAL SOCIAL SERVICES                                 *00860000
008700* 0570 = HOME HEALTH AIDE                                        *00870000
008800******************************************************************00880000
008900                                                                  00890000
009000 ENVIRONMENT DIVISION.                                            00900000
009100 CONFIGURATION SECTION.                                           00910000
009200 SOURCE-COMPUTER.            IBM-370.                             00920000
009300 OBJECT-COMPUTER.            IBM-370.                             00930000
009400 INPUT-OUTPUT  SECTION.                                           00940000
009500 FILE-CONTROL.                                                    00950000
009600                                                                  00960000
009700 DATA DIVISION.                                                   00970000
009800 FILE SECTION.                                                    00980000
009900                                                                  00990000
010000 WORKING-STORAGE SECTION.                                         01000000
010100 01  FILLER                         PIC X(40)  VALUE              01010000
010200     'HHCAL    - W O R K I N G   S T O R A G E'.                  01020000
010300 01  CAL-VERSION                    PIC X(07)  VALUE 'C2021.3'.   01030028
010400 01  WS-INT-TO-DATE                 PIC  9(07)    VALUE 0.        01040000
010500 01  WS-INT-FROM-DATE               PIC  9(07)    VALUE 0.        01050000
010600 01  WS-DAYS-DIFFERENCE             PIC S9(07)    VALUE 0.        01060000
010602 01  WS-HRG-PENALTY                 PIC 9(7)V9(2) VALUE 0.        01060230
010603 01  WS-HRG-REDUCED                 PIC 9(7)V9(2) VALUE 0.        01060330
010604 01  WS-OUTL-PENALTY                PIC 9(7)V9(2) VALUE 0.        01060430
010605 01  WS-OUTL-REDUCED                PIC 9(7)V9(2) VALUE 0.        01060530
010700 01  CO1                            PIC S9(04)    VALUE 0.        01070000
010800 01  SS-QCV                         PIC S9(04)    VALUE 0.        01080000
010900 01  SS-ADJ                         PIC S9(04)    VALUE 0.        01090000
011000 01  WK-RTC-ADJ-IND                 PIC 9         VALUE 0.        01100000
011100 01  WS-STD-VALUE-NLUPA-AMT         PIC 9(7)V9(2) VALUE 0.        01110000
011200 01  WS-STD-VALUE-NLUPA-OUTL        PIC 9(7)V9(2) VALUE 0.        01120000
011300 01  WS-STDV-LUPA-ADDON-FAC         PIC 9(1)V9(4) VALUE 0.        01130000
011400 01  WS-STDV-RURAL-FAC              PIC 9V9999 VALUE 1.0010.      01140000
011500 01  WS-STDV-EPISODE-AMT            PIC 9(05)V9(02) VALUE 0.      01150000
011600*-------------------------------------------------------------*   01160000
011700*    RURAL ADD ON PERCENTAGES FOR CY2021                      *   01170000
011800*-------------------------------------------------------------*   01180000
011900 01  WS-RURAL-ADDON-A               PIC 9V999 VALUE 1.000.        01190000
012000 01  WS-RURAL-ADDON-B               PIC 9V999 VALUE 1.020.        01200000
012100 01  WS-RURAL-ADDON-C               PIC 9V999 VALUE 1.010.        01210000
012200 01  WS-RURAL-CATEGORY              PIC X     VALUE SPACE.        01220000
012300*-------------------------------------------------------------*   01230000
012400*    LABOR PERCENTAGES FOR CY2021                             *   01240000
012500*-------------------------------------------------------------*   01250000
012600 01  LABOR-NLABOR-PERCENT.                                        01260000
012700     05 LABOR-PERCENT        PIC 9V9(05)  VALUE 0.76100.          01270000
012800     05 NONLABOR-PERCENT     PIC 9V9(05)  VALUE 0.23900.          01280000
012900***************************************************************   01290000
013000*                NO CHANGE FOR CY2021                         *   01300000
013100***************************************************************   01310000
013200 01  LUPA-ADD-ON-SN4              PIC 9(01)V9(04) VALUE 00.8451.  01320000
013300 01  LUPA-ADD-ON-PT1              PIC 9(01)V9(04) VALUE 00.6700.  01330000
013400 01  LUPA-ADD-ON-SLT3             PIC 9(01)V9(04) VALUE 00.6266.  01340000
013500***************************************************************** 01350000
013600*                NO CHANGE FOR CY2021                         *   01360000
013700***    EXAMPLE    *********************************************** 01370000
013800*** FED-EPISODE-RATE-AMT TIMES 1.13 = OUTLIER-THRESHOLD-AMT ***** 01380000
013900******  2327.68 TIMES 0.65  = 1512.99  ROUNDED UP  ************** 01390000
014000***************************************************************** 01400000
014100 01  OUTL-LOSS-SHAR-RATIO-PERCENT PIC 9(01)V9(02) VALUE 0.80.     01410000
014200 01  LUPA-LABOR-ADJ               PIC 9(03)V9(02) VALUE 0.        01420000
014300 01  LUPA-NON-LABOR-ADJ           PIC 9(03)V9(02) VALUE 0.        01430000
014400 01  FED-EPISODE-RATE-AMT         PIC 9(05)V9(02) VALUE 0.        01440000
014500 01  OUTLIER-THRESHOLD-AMT        PIC 9(05)V9(02) VALUE 0.        01450000
014600 01  WK-HRG-NO-OF-DAYS            PIC 9(03)       VALUE 0.        01460000
014700 01  WK-HRG-NO-OF-DAYS-FAC        PIC 9V99        VALUE 0.        01470000
014800 01  WK-ALL-TOTALS.                                               01480000
014900     05  FED-ADJ                        PIC S9(07)V9(02).         01490000
015000     05  FED-ADJP                       PIC S9(07)V9(02).         01500000
015100     05  FED-ADJ1                       PIC S9(07)V9(02).         01510000
015200     05  FED-ADJ2                       PIC S9(07)V9(02).         01520000
015300     05  FED-ADJ3                       PIC S9(07)V9(02).         01530000
015400     05  FED-ADJ4                       PIC S9(07)V9(02).         01540000
015500     05  FED-ADJ5                       PIC S9(07)V9(02).         01550000
015600     05  FED-ADJ6                       PIC S9(07)V9(02).         01560000
015700     05  FED-LUPA-ADJ1                  PIC S9(07)V9(02).         01570000
015800     05  FED-LUPA-ADJ2                  PIC S9(07)V9(02).         01580000
015900     05  FED-LUPA-ADJ3                  PIC S9(07)V9(02).         01590000
016000     05  FED-LUPA-ADJ4                  PIC S9(07)V9(02).         01600000
016100     05  FED-LUPA-ADJ5                  PIC S9(07)V9(02).         01610000
016200     05  FED-LUPA-ADJ6                  PIC S9(07)V9(02).         01620000
016300     05  FED-LABOR-ADJ                  PIC S9(07)V9(02).         01630000
016400     05  FED-LABOR-ADJP                 PIC S9(07)V9(02).         01640000
016500     05  FED-LABOR-ADJ1                 PIC S9(07)V9(02).         01650000
016600     05  FED-LABOR-ADJ2                 PIC S9(07)V9(02).         01660000
016700     05  FED-LABOR-ADJ3                 PIC S9(07)V9(02).         01670000
016800     05  FED-LABOR-ADJ4                 PIC S9(07)V9(02).         01680000
016900     05  FED-LABOR-ADJ5                 PIC S9(07)V9(02).         01690000
017000     05  FED-LABOR-ADJ6                 PIC S9(07)V9(02).         01700000
017100     05  FED-LABOR-LUPA-ADJ1            PIC S9(07)V9(02).         01710000
017200     05  FED-LABOR-LUPA-ADJ2            PIC S9(07)V9(02).         01720000
017300     05  FED-LABOR-LUPA-ADJ3            PIC S9(07)V9(02).         01730000
017400     05  FED-LABOR-LUPA-ADJ4            PIC S9(07)V9(02).         01740000
017500     05  FED-LABOR-LUPA-ADJ5            PIC S9(07)V9(02).         01750000
017600     05  FED-LABOR-LUPA-ADJ6            PIC S9(07)V9(02).         01760000
017700     05  FED-NON-LABOR-ADJ              PIC S9(07)V9(02).         01770000
017800     05  FED-NON-LABOR-ADJP             PIC S9(07)V9(02).         01780000
017900     05  FED-NON-LABOR-ADJ1             PIC S9(07)V9(02).         01790000
018000     05  FED-NON-LABOR-ADJ2             PIC S9(07)V9(02).         01800000
018100     05  FED-NON-LABOR-ADJ3             PIC S9(07)V9(02).         01810000
018200     05  FED-NON-LABOR-ADJ4             PIC S9(07)V9(02).         01820000
018300     05  FED-NON-LABOR-ADJ5             PIC S9(07)V9(02).         01830000
018400     05  FED-NON-LABOR-ADJ6             PIC S9(07)V9(02).         01840000
018500     05  FED-NON-LABOR-LUPA-ADJ1        PIC S9(07)V9(02).         01850000
018600     05  FED-NON-LABOR-LUPA-ADJ2        PIC S9(07)V9(02).         01860000
018700     05  FED-NON-LABOR-LUPA-ADJ3        PIC S9(07)V9(02).         01870000
018800     05  FED-NON-LABOR-LUPA-ADJ4        PIC S9(07)V9(02).         01880000
018900     05  FED-NON-LABOR-LUPA-ADJ5        PIC S9(07)V9(02).         01890000
019000     05  FED-NON-LABOR-LUPA-ADJ6        PIC S9(07)V9(02).         01900000
019100     05  OUT-THRES-AMT-ADJ              PIC S9(07)V9(02).         01910000
019200     05  OUT-THRES-LABOR-ADJ            PIC S9(07)V9(02).         01920000
019300     05  OUT-THRES-NON-LABOR-ADJ        PIC S9(07)V9(02).         01930000
019400     05  WK-3000-PEP-N-PRETOT-PAY       PIC S9(07)V9(02).         01940000
019500     05  WK-3000-PEP-N-PAYMENT          PIC S9(07)V9(02).         01950000
019600     05  WK-4000-PEP-Y-PRETOT-PAY       PIC S9(07)V9(02).         01960000
019700     05  WK-4000-PEP-Y-PAYMENT          PIC S9(07)V9(02).         01970000
019800     05  WK-7000-OUTLIER-VALUE-A        PIC S9(07)V9(02).         01980000
019900     05  WK-7000-AB-DIFF                PIC S9(07)V9(02).         01990000
020000     05  WK-7000-CALC                   PIC S9(07)V9(02).         02000000
020100     05  WK-8000-OUTLIER-VALUE-B        PIC S9(07)V9(02).         02010000
020200     05  WK-8000-OUTLIER-LAB-NLAB       PIC S9(07)V9(02).         02020000
020300     05  WK-9100-TOTAL-PAYMENT          PIC 9(07)V9(02).          02030000
020400     05  WK-10000-OUTLIER-POOL-DIF      PIC S9(07)V9(02).         02040000
020500     05  WK-10000-OUTLIER-POOL-PERCENT  PIC S9(09)V9(02).         02050000
020600     05  WK-10000-OUTLIER-AVAIL-POOL    PIC S9(09)V9(02).         02060000
020700                                                                  02070000
020800*----------------------------------------------------------------*02080000
020900*    STATE & COUNTY CODE RURAL ADD ON TABLE                      *02090000
021000*----------------------------------------------------------------*02100000
021100     COPY ADDONTBL.                                               02110005
021200*----------------------------------------------------------------*02120000
021300*    EXTRA STATE & COUNTY CODE RURAL ADD ON TABLE FOR            *02130000
021400*    RURAL COUNTIES THAT GAIN URBAN STATUS                       *02140000
021500*----------------------------------------------------------------*02150000
021600     COPY ADXONTBL.                                               02160000
021700*----------------------------------------------------------------*02170000
021800*  INPUT/OUTPUT RECORD LAYOUT - PIC X(650)                       *02180000
021900*  THIS RECORD WAS MODIFIED FOR THE 01/01/2020 RELEASE           *02190000
022000*----------------------------------------------------------------*02200000
022100 01  HOLD-HHA-DATA.                                               02210000
022200     05  H-HHA-INPUT-DATA.                                        02220000
022300         10  H-HHA-NPI               PIC X(10).                   02230000
022400         10  H-HHA-HIC               PIC X(12).                   02240000
022500         10  H-HHA-PROV-NO           PIC X(06).                   02250000
022600         10  H-HHA-INIT-PAY-QRP-IND  PIC X(01).                   02260000
022700             88  H-HHA-WITH-DATA-CHECK VALUE '0', '1'.            02270000
022800             88  H-HHA-NO-DATA-CHECK VALUE '2', '3'.              02280000
022900         10  H-HHA-PROV-VBP-ADJ-FAC  PIC 9V9(5).                  02290000
023000         10  H-HHA-PROV-OUTLIER-PAY-TOTAL PIC 9(08)V9(02).        02300000
023100         10  H-HHA-PROV-PAYMENT-TOTAL PIC 9(09)V9(02).            02310000
023200         10  H-HHA-TOB               PIC X(03).                   02320000
023300             88 H-HHA-VALID-TOB-CLAIM VALUE                       02330000
023400             '327', '329',                                        02340000
023500             '32F', '32G', '32H', '32I', '32J',                   02350000
023600             '32K', '32M', '32Q', '32P'.                          02360000
023700             88 H-HHA-VALID-TOB-RAP  VALUE                        02370000
023800             '322'.                                               02380000
023900         10  H-HHA-CBSA              PIC X(05).                   02390000
024000             88  H-HHA-CBSA-RURAL-CHECK-ALL VALUE                 02400000
024100             '50001', '50002', '50005', '50007', '50025',         02410000
024200             '50028', '50031', '50035', '50036', '50037',         02420000
024300             '50041', '50045', '50047', '50048', '50050',         02430000
024400             '50056', '50057', '50066', '50068', '50071',         02440000
024500             '50073', '50080', '50084', '50087', '50089',         02450000
024600             '50090', '50091', '50103', '50104', '50111',         02460000
024700             '50115', '50117', '50118', '50120', '50121',         02470000
024800             '50139', '50146', '50147', '50149', '50151',         02480000
024900             '50164', '50165', '50168', '50169', '50173',         02490000
025000             '50174', '50177', '50180', '50182', '50183'.         02500000
025100         10  FILLER  REDEFINES  H-HHA-CBSA.                       02510000
025200             15  H-HHA-CBSA-RURAL    PIC X(03).                   02520000
025300             88  H-HHA-CBSA-RURAL-CHECK VALUE '999'.              02530000
025400             15  FILLER             PIC X(02).                    02540000
025500         10  H-HHA-COUNTY-CODE       PIC X(05).                   02550000
025600         10  H-HHA-SERV-FROM-DATE.                                02560000
025700             15  H-HHA-FROM-CC       PIC XX.                      02570000
025800             15  H-HHA-FROM-YYMMDD.                               02580000
025900                 25  H-HHA-FROM-YY   PIC XX.                      02590000
026000                 25  H-HHA-FROM-MM   PIC XX.                      02600000
026100                 25  H-HHA-FROM-DD   PIC XX.                      02610000
026200         10  H-HHA-SERV-FROM-DATE-N  REDEFINES                    02620000
026300             H-HHA-SERV-FROM-DATE    PIC 9(8).                    02630000
026400         10  H-HHA-SERV-THRU-DATE.                                02640000
026500             15  H-HHA-THRU-CC       PIC XX.                      02650000
026600             15  H-HHA-THRU-YYMMDD.                               02660000
026700                 25  H-HHA-THRU-YY   PIC XX.                      02670000
026800                 25  H-HHA-THRU-MM   PIC XX.                      02680000
026900                 25  H-HHA-THRU-DD   PIC XX.                      02690000
027000         10  H-HHA-ADMIT-DATE.                                    02700000
027100             15  H-HHA-ADMIT-CC      PIC XX.                      02710000
027200             15  H-HHA-ADMIT-YYMMDD.                              02720000
027300                 25  H-HHA-ADMIT-YY  PIC XX.                      02730000
027400                 25  H-HHA-ADMIT-MM  PIC XX.                      02740000
027500                 25  H-HHA-ADMIT-DD  PIC XX.                      02750000
027600         10  H-HHA-LUPA-SRC-ADM         PIC X.                    02760000
027700         10  H-HHA-ADJ-IND              PIC X.                    02770000
027800         10  H-HHA-PEP-IND           PIC X.                       02780000
027900         10  H-HHA-HRG-INPUT-CODE     PIC X(05).                  02790000
028000         10  H-HHA-HRG-NO-OF-DAYS     PIC 9(03).                  02800000
028100         10  H-HHA-HRG-WGTS           PIC 9(02)V9(04).            02810000
028200         10  H-HHA-HRG-PAY            PIC 9(07)V9(02).            02820000
028300         10  H-HHA-REVENUE-DATA   OCCURS 6.                       02830000
028400             15  H-HHA-REVENUE-CODE            PIC X(04).         02840000
028500             15  H-HHA-REVENUE-QTY-COV-VISITS  PIC 9(03).         02850000
028600             15  H-HHA-REVENUE-QTY-OUTL-UNITS  PIC 9(05).         02860000
028700             15  H-HHA-REVENUE-EARLIEST-DATE   PIC 9(08).         02870000
028800             15  H-HHA-REVENUE-DOLL-RATE       PIC 9(07)V9(02).   02880000
028900             15  H-HHA-REVENUE-COST            PIC 9(07)V9(02).   02890000
029000             15  H-HHA-REVENUE-ADD-ON-VISIT-AMT PIC 9(07)V9(02).  02900000
029100         10  H-HHA-PAY-RTC              PIC 99.                   02910000
029200         10  H-HHA-REVENUE-SUM1-6-QTY-ALL PIC 9(05).              02920000
029300         10  H-HHA-OUTLIER-PAYMENT      PIC 9(07)V9(02).          02930000
029400         10  H-HHA-TOTAL-PAYMENT        PIC 9(07)V9(02).          02940000
029500         10  H-HHA-VBP-ADJ-AMT          PIC S9(7)V99.             02950000
029600         10  H-HHA-PPS-STD-VALUE        PIC 9(7)V99.              02960000
029700         10  H-HHA-RECEIPT-DATE         PIC X(8).                 02970000
029800         10  H-HHA-RECEIPT-DATE-N       REDEFINES                 02980000
029900             H-HHA-RECEIPT-DATE         PIC 9(8).                 02990000
030000         10  H-HHA-OVERRIDE-IND         PIC X(1).                 03000000
030100*            VALID VALUES:                                        03010000
030200*            Y = EXCEPTION HAS BEEN GRANTED,                      03020000
030300*                NO LATE FILING PENALTY WILL BE CALCULATED        03030000
030400*            N = NO EXCEPTION APPLIES, CALCULATE                  03040000
030500*                LATE FILING PENALTY, IF APPLICABLE               03050000
030600         10  H-HHA-LATE-SUB-PEN-AMT     PIC 9(7)V9(2).            03060000
030700         10  FILLER                     PIC X(188).               03070000
030800 LINKAGE SECTION.                                                 03080000
030900*----------------------------------------------------------------*03090000
031000*  INPUT/OUTPUT RECORD LAYOUT - PIC X(650)                       *03100000
031100*  THIS RECORD WAS MODIFIED FOR THE 01/01/2020 RELEASE           *03110000
031200*----------------------------------------------------------------*03120000
031300 01  HHA-INPUT-DATA.                                              03130000
031400     05  HHA-DATA.                                                03140000
031500         10  HHA-NPI                 PIC X(10).                   03150000
031600         10  HHA-HIC                 PIC X(12).                   03160000
031700         10  HHA-PROV-NO             PIC X(06).                   03170000
031800         10  HHA-INIT-PAY-QRP-IND        PIC X(01).               03180000
031900             88  HHA-WITH-DATA-CHECK VALUE '0', '1'.              03190000
032000             88  HHA-NO-DATA-CHECK   VALUE '2', '3'.              03200000
032100         10  HHA-PROV-VBP-ADJ-FAC    PIC 9V9(5).                  03210000
032200         10  HHA-PROV-OUTLIER-PAY-TOTAL PIC 9(08)V9(02).          03220000
032300         10  HHA-PROV-PAYMENT-TOTAL  PIC 9(09)V9(02).             03230000
032400         10  HHA-TOB                 PIC X(03).                   03240000
032500             88 HHA-VALID-TOB-CLAIM  VALUE                        03250000
032600             '327', '329',                                        03260000
032700             '32F', '32G', '32H', '32I', '32J',                   03270000
032800             '32K', '32M', '32Q', '32P'.                          03280000
032900             88 HHA-VALID-TOB-RAP    VALUE                        03290000
033000             '322'.                                               03300000
033100         10  HHA-CBSA                PIC X(05).                   03310000
033200             88  HHA-CBSA-RURAL-CHECK-ALL VALUE                   03320000
033300             '50001', '50002', '50005', '50007', '50025',         03330000
033400             '50028', '50031', '50035', '50036', '50037',         03340000
033500             '50041', '50045', '50047', '50048', '50050',         03350000
033600             '50056', '50057', '50066', '50068', '50071',         03360000
033700             '50073', '50080', '50084', '50087', '50089',         03370000
033800             '50090', '50091', '50103', '50104', '50111',         03380000
033900             '50115', '50117', '50118', '50120', '50121',         03390000
034000             '50139', '50146', '50147', '50149', '50151',         03400000
034100             '50164', '50165', '50168', '50169', '50173',         03410000
034200             '50174', '50177', '50180', '50182', '50183'.         03420000
034300         10  FILLER  REDEFINES  HHA-CBSA.                         03430000
034400             15  HHA-CBSA-RURAL      PIC X(03).                   03440000
034500             88  HHA-CBSA-RURAL-CHECK  VALUE '999'.               03450000
034600             15  FILLER             PIC X(02).                    03460000
034700         10  HHA-COUNTY-CODE         PIC X(05).                   03470000
034800         10  HHA-SERV-FROM-DATE.                                  03480000
034900             15  HHA-FROM-CC         PIC XX.                      03490000
035000             15  HHA-FROM-YYMMDD.                                 03500000
035100                 25  HHA-FROM-YY     PIC XX.                      03510000
035200                 25  HHA-FROM-MM     PIC XX.                      03520000
035300                 25  HHA-FROM-DD     PIC XX.                      03530000
035400         10  HHA-SERV-THRU-DATE.                                  03540000
035500             15  HHA-THRU-CC         PIC XX.                      03550000
035600             15  HHA-THRU-YYMMDD.                                 03560000
035700                 25  HHA-THRU-YY     PIC XX.                      03570000
035800                 25  HHA-THRU-MM     PIC XX.                      03580000
035900                 25  HHA-THRU-DD     PIC XX.                      03590000
036000         10  HHA-ADMIT-DATE.                                      03600000
036100             15  HHA-ADMIT-CC        PIC XX.                      03610000
036200             15  HHA-ADMIT-YYMMDD.                                03620000
036300                 25  HHA-ADMIT-YY    PIC XX.                      03630000
036400                 25  HHA-ADMIT-MM    PIC XX.                      03640000
036500                 25  HHA-ADMIT-DD    PIC XX.                      03650000
036600         10  HHA-LUPA-SRC-ADM           PIC X.                    03660000
036700         10  HHA-ADJ-IND                PIC X.                    03670000
036800         10  HHA-PEP-IND             PIC X.                       03680000
036900         10  HHA-HRG-INPUT-CODE       PIC X(05).                  03690000
037000         10  HHA-HRG-NO-OF-DAYS       PIC 9(03).                  03700000
037100         10  HHA-HRG-WGTS             PIC 9(02)V9(04).            03710000
037200         10  HHA-HRG-PAY              PIC 9(07)V9(02).            03720000
037300         10  HHA-REVENUE-DATA     OCCURS 6.                       03730000
037400             15  HHA-REVENUE-CODE              PIC X(04).         03740000
037500             15  HHA-REVENUE-QTY-COV-VISITS    PIC 9(03).         03750000
037600             15  HHA-REVENUE-QTY-OUTL-UNITS    PIC 9(05).         03760000
037700             15  HHA-REVENUE-EARLIEST-DATE     PIC 9(08).         03770000
037800             15  HHA-REVENUE-DOLL-RATE         PIC 9(07)V9(02).   03780000
037900             15  HHA-REVENUE-COST              PIC 9(07)V9(02).   03790000
038000             15  HHA-REVENUE-ADD-ON-VISIT-AMT  PIC 9(07)V9(02).   03800000
038100         10  HHA-PAY-RTC                PIC 99.                   03810000
038200         10  HHA-REVENUE-SUM1-6-QTY-ALL PIC 9(05).                03820000
038300         10  HHA-OUTLIER-PAYMENT        PIC 9(07)V9(02).          03830000
038400         10  HHA-TOTAL-PAYMENT          PIC 9(07)V9(02).          03840000
038500         10  HHA-VBP-ADJ-AMT            PIC S9(7)V99.             03850000
038600         10  HHA-PPS-STD-VALUE          PIC 9(7)V99.              03860000
038700         10  HHA-RECEIPT-DATE           PIC X(8).                 03870000
038800         10  HHA-OVERRIDE-IND           PIC X(1).                 03880000
038900         10  HHA-LATE-SUB-PEN-AMT       PIC 9(7)V9(2).            03890000
039000         10  FILLER                     PIC X(188).               03900000
039100                                                                  03910000
039200 01  HOLD-VARIABLES-DATA.                                         03920000
039300     02  HOLD-VAR-DATA.                                           03930000
039400         05  PRICER-OPTION-SW                   PIC X(01).        03940000
039500         05  HHOPN-VERSION                      PIC X(07).        03950000
039600         05  HHDRV-VERSION                      PIC X(07).        03960000
039700         05  HHCAL-VERSION                      PIC X(07).        03970000
039800         05  FILLER                             PIC X(20).        03980000
039900                                                                  03990000
040000 01  CBSA-WAGE-INDEX-DATA.                                        04000000
040100     02  HOLD-WIR-DATA.                                           04010000
040200         05  WIR-CBSA                       PIC X(05).            04020000
040300         05  WIR-CBSA-EFFDATE               PIC X(08).            04030000
040400         05  WIR-CBSA-WAGEIND               PIC 9(02)V9(04).      04040000
040500                                                                  04050000
040600 01  TB-REV-DOLL-RATE-UNITS.                                      04060000
040700     05 WK-REV-DOLL-RATE-UNITS  PIC 9(07)V9(02)                   04070000
040800                                OCCURS 6.                         04080000
040900 01  TB-STDV-DATA.                                                04090000
041000     05 TB-STDV-TABLE           OCCURS 6.                         04100000
041100        10  TB-STDV-REV-CODE           PIC X(04).                 04110000
041200        10  TB-STDV-REV-DOLL-RATE      PIC 9(07)V9(02).           04120000
041300                                                                  04130000
041400 01  L-HRG-THRESHOLD       PIC 9(01).                             04140000
041500                                                                  04150000
041600 PROCEDURE DIVISION  USING HHA-INPUT-DATA                         04160000
041700                           HOLD-VARIABLES-DATA                    04170000
041800                           CBSA-WAGE-INDEX-DATA                   04180000
041900                           TB-REV-DOLL-RATE-UNITS                 04190000
042000                           TB-STDV-DATA                           04200000
042100                           L-HRG-THRESHOLD.                       04210000
042200                                                                  04220000
042300     MOVE CAL-VERSION    TO HHCAL-VERSION.                        04230000
042400                                                                  04240000
042500     MOVE HHA-INPUT-DATA TO HOLD-HHA-DATA.                        04250000
042600                                                                  04260000
042700     INITIALIZE      WK-ALL-TOTALS.                               04270000
042800     INITIALIZE      WK-RTC-ADJ-IND.                              04280000
042920                                                                  04292013
043000     PERFORM 400-CALC-THE-HHA     THRU 400-EXIT.                  04300000
043100                                                                  04310000
043200     MOVE HOLD-HHA-DATA  TO HHA-INPUT-DATA.                       04320000
043300                                                                  04330000
043400     GOBACK.                                                      04340000
043500                                                                  04350000
043600 400-CALC-THE-HHA.                                                04360000
043700                                                                  04370000
043800     IF H-HHA-VALID-TOB-RAP                                       04380000
043900        MOVE 0        TO H-HHA-TOTAL-PAYMENT                      04390000
044000        MOVE 0        TO H-HHA-HRG-PAY                            04400000
044100        MOVE '03'     TO H-HHA-PAY-RTC                            04410000
044200        GO   TO 400-EXIT.                                         04420000
044300                                                                  04430000
044400     IF H-HHA-VALID-TOB-CLAIM                                     04440000
044500         CONTINUE                                                 04450000
044600     ELSE                                                         04460000
044700         MOVE '10' TO H-HHA-PAY-RTC                               04470000
044800         GO TO 400-EXIT.                                          04480000
044900                                                                  04490000
045000     IF H-HHA-ADMIT-DATE > H-HHA-SERV-FROM-DATE                   04500000
045100         MOVE '40' TO H-HHA-PAY-RTC                               04510000
045200         GO TO 400-EXIT.                                          04520000
045300                                                                  04530000
045400*    DO THE RURAL COUNTY CODE LOOKUP                              04540000
045500                                                                  04550000
045600     IF H-HHA-CBSA-RURAL = '999'                                  04560000
045700        PERFORM 2000-TBL-SCC-SEARCH THRU 2000-EXIT                04570000
045800        IF H-HHA-PAY-RTC = '31'                                   04580000
045900           GO TO 400-EXIT                                         04590000
046000        END-IF                                                    04600000
046100     ELSE                                                         04610000
046200        PERFORM 2100-TBL-ECC-SEARCH THRU 2100-EXIT.               04620000
046300                                                                  04630000
046400     IF H-HHA-HRG-INPUT-CODE = SPACE                              04640000
046500         MOVE '70' TO H-HHA-PAY-RTC                               04650000
046600         GO TO 400-EXIT.                                          04660000
046700                                                                  04670000
046800     IF H-HHA-VALID-TOB-CLAIM                                     04680000
046900        IF H-HHA-REVENUE-CODE (1) = SPACE                         04690000
047000           MOVE '85' TO H-HHA-PAY-RTC                             04700000
047100           GO TO 400-EXIT.                                        04710000
047200                                                                  04720000
047300     IF H-HHA-VALID-TOB-CLAIM                                     04730000
047400        IF H-HHA-PEP-IND = 'Y'                                    04740000
047500           IF H-HHA-HRG-NO-OF-DAYS = ZEROES                       04750000
047600              MOVE '15' TO H-HHA-PAY-RTC                          04760000
047700              GO TO 400-EXIT.                                     04770000
047800                                                                  04780000
047900***************************************************************   04790000
048000*                 YEARCHANGE                                  *   04800000
048100*-------------------------------------------------------------*   04810000
048200* RATES AND THRESHOLDS ARE APPLIED FOR RURAL AND NON-RURAL    *   04820000
048300*-------------------------------------------------------------*   04830000
048400* OUTLIER-THRESHOLD-AMT = FED-EPISODE-RATE-AMT X .56          *   04840000
048500***************************************************************   04850000
048600*-------------------------------------------------------------*   04860000
048700*   STANDARDIZED PAYMENT AMOUNT                               *   04870000
048800*   ( SAVE FOR STANDARD VALUE CALCULATION )                   *   04880000
048900*-------------------------------------------------------------*   04890000
049000     MOVE 01901.12           TO  WS-STDV-EPISODE-AMT.             04900000
049100*-------------------------------------------------------------*   04910000
049200*   STANDARDIZED PAYMENT AMOUNT - QUALITY DATA                *   04920000
049300*-------------------------------------------------------------*   04930000
049400     IF HHA-WITH-DATA-CHECK                                       04940000
049500        MOVE 01901.12 TO   FED-EPISODE-RATE-AMT                   04950000
049600        MOVE 01064.63 TO   OUTLIER-THRESHOLD-AMT                  04960000
049700     END-IF.                                                      04970000
049800*-------------------------------------------------------------*   04980000
049900*   STANDARDIZED PAYMENT AMOUNT - NO QUALITY DATA             *   04990000
050000*-------------------------------------------------------------*   05000000
050100     IF HHA-NO-DATA-CHECK                                         05010000
050200        MOVE 01863.84 TO   FED-EPISODE-RATE-AMT                   05020000
050300        MOVE 01043.75 TO   OUTLIER-THRESHOLD-AMT                  05030000
050400     END-IF.                                                      05040000
050500                                                                  05050000
050600     IF WS-RURAL-CATEGORY = SPACE                                 05060000
050700        CONTINUE                                                  05070000
050800     ELSE                                                         05080000
050900     IF WS-RURAL-CATEGORY = 'A'                                   05090000
051000       COMPUTE FED-EPISODE-RATE-AMT ROUNDED =                     05100000
051100               FED-EPISODE-RATE-AMT  * WS-RURAL-ADDON-A           05110000
051200       COMPUTE OUTLIER-THRESHOLD-AMT ROUNDED =                    05120000
051300               OUTLIER-THRESHOLD-AMT * WS-RURAL-ADDON-A           05130000
051400     ELSE                                                         05140000
051500     IF WS-RURAL-CATEGORY = 'B'                                   05150000
051600       COMPUTE FED-EPISODE-RATE-AMT ROUNDED =                     05160000
051700               FED-EPISODE-RATE-AMT  * WS-RURAL-ADDON-B           05170000
051800       COMPUTE OUTLIER-THRESHOLD-AMT ROUNDED =                    05180000
051900               OUTLIER-THRESHOLD-AMT * WS-RURAL-ADDON-B           05190000
052000     ELSE                                                         05200000
052100     IF WS-RURAL-CATEGORY = 'C'                                   05210000
052200       COMPUTE FED-EPISODE-RATE-AMT ROUNDED =                     05220000
052300               FED-EPISODE-RATE-AMT  * WS-RURAL-ADDON-C           05230000
052400       COMPUTE OUTLIER-THRESHOLD-AMT ROUNDED =                    05240000
052500               OUTLIER-THRESHOLD-AMT * WS-RURAL-ADDON-C           05250000
052600     END-IF.                                                      05260000
052700                                                                  05270000
052800 PROCESS-PAYMENT.                                                 05280000
052900                                                                  05290000
053000* ADJUST REVENUE-DOLL-RATE IF RURAL                               05300000
053100     PERFORM 425-ADJ-REV-DOLL-RATE THRU 425-EXIT                  05310000
053200             VARYING SS-ADJ FROM 1 BY 1                           05320000
053300             UNTIL SS-ADJ > 6.                                    05330000
053400                                                                  05340000
053500     IF H-HHA-VALID-TOB-CLAIM                                     05350000
053600        PERFORM 1000-FINAL-PAYMENT THRU 1000-EXIT                 05360000
053700     END-IF.                                                      05370000
053800                                                                  05380000
053810*----------------------------------------------------------------*05381010
053820* CALCULATE THE H-HHA-LATE-SUB-PENALTY FOR NON LUPA CLAIMS ONLY  *05382010
053830*----------------------------------------------------------------*05383010
053840     PERFORM 9100-LATE-SUB-PENALTY   THRU 9100-EXIT.              05384010
055110*----------------------------------------------------------------*05511008
055120* CALCULATE THE HHA-VBP-ADJ-AMT                                  *05512008
055130*----------------------------------------------------------------*05513008
055140     PERFORM 9200-VBP-CALC           THRU 9200-EXIT.              05514020
055150*----------------------------------------------------------------*05515020
055160* CALCULATE THE HHA-PPS-STD-VALUE                                *05516020
055170*----------------------------------------------------------------*05517020
055180     PERFORM 9300-CALC-STD-VALUE     THRU 9300-EXIT.              05518020
055200                                                                  05520000
055300 400-EXIT.   EXIT.                                                05530000
055400                                                                  05540000
055500 425-ADJ-REV-DOLL-RATE.                                           05550000
055600                                                                  05560000
055700     IF WS-RURAL-CATEGORY = 'A'                                   05570000
055800         COMPUTE H-HHA-REVENUE-DOLL-RATE (SS-ADJ) ROUNDED =       05580000
055900                 H-HHA-REVENUE-DOLL-RATE (SS-ADJ) *               05590000
056000                 WS-RURAL-ADDON-A                                 05600000
056100     ELSE                                                         05610000
056200     IF WS-RURAL-CATEGORY = 'B'                                   05620000
056300         COMPUTE H-HHA-REVENUE-DOLL-RATE (SS-ADJ) ROUNDED =       05630000
056400                 H-HHA-REVENUE-DOLL-RATE (SS-ADJ) *               05640000
056500                 WS-RURAL-ADDON-B                                 05650000
056600     ELSE                                                         05660000
056700     IF WS-RURAL-CATEGORY = 'C'                                   05670000
056800         COMPUTE H-HHA-REVENUE-DOLL-RATE (SS-ADJ) ROUNDED =       05680000
056900                 H-HHA-REVENUE-DOLL-RATE (SS-ADJ) *               05690000
057000                 WS-RURAL-ADDON-C                                 05700000
057100     END-IF.                                                      05710000
057200                                                                  05720000
057300 425-EXIT.    EXIT.                                               05730000
057400                                                                  05740000
057500 1000-FINAL-PAYMENT.                                              05750000
057600                                                                  05760000
057700     COMPUTE H-HHA-REVENUE-SUM1-6-QTY-ALL ROUNDED =               05770000
057800             H-HHA-REVENUE-QTY-COV-VISITS (1) +                   05780000
057900             H-HHA-REVENUE-QTY-COV-VISITS (2) +                   05790000
058000             H-HHA-REVENUE-QTY-COV-VISITS (3) +                   05800000
058100             H-HHA-REVENUE-QTY-COV-VISITS (4) +                   05810000
058200             H-HHA-REVENUE-QTY-COV-VISITS (5) +                   05820000
058300             H-HHA-REVENUE-QTY-COV-VISITS (6).                    05830000
058400                                                                  05840000
058500     IF H-HHA-REVENUE-SUM1-6-QTY-ALL < L-HRG-THRESHOLD            05850000
058600       NEXT SENTENCE                                              05860000
058700     ELSE                                                         05870000
058800       GO TO PEP-CHECK.                                           05880000
058900                                                                  05890000
059000**   CHANGE MISSING DATES TO DEFAULT FOR EARLIEST DATE COMPARE ** 05900000
059100                                                                  05910000
059200     IF H-HHA-REVENUE-EARLIEST-DATE (1) = 0                       05920000
059300        MOVE 29990101 TO H-HHA-REVENUE-EARLIEST-DATE (1).         05930000
059400                                                                  05940000
059500     IF H-HHA-REVENUE-EARLIEST-DATE (3) = 0                       05950000
059600        MOVE 29990101 TO H-HHA-REVENUE-EARLIEST-DATE (3).         05960000
059700                                                                  05970000
059800     IF H-HHA-REVENUE-EARLIEST-DATE (4) = 0                       05980000
059900        MOVE 29990101 TO H-HHA-REVENUE-EARLIEST-DATE (4).         05990000
060000                                                                  06000000
060100*    IF REVENUE EARLIEST DATES = ALL 9'S THEN                     06010000
060200*    LUPA ADD ON DOES NOT CALCULATE                               06020000
060300                                                                  06030000
060400     IF (H-HHA-REVENUE-EARLIEST-DATE (1) = 99999999 AND           06040000
060500         H-HHA-REVENUE-EARLIEST-DATE (3) = 99999999 AND           06050000
060600         H-HHA-REVENUE-EARLIEST-DATE (4) = 99999999)              06060000
060700                                                                  06070000
060800           MOVE 0 TO  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1)          06080000
060900                      H-HHA-REVENUE-ADD-ON-VISIT-AMT (2)          06090000
061000                      H-HHA-REVENUE-ADD-ON-VISIT-AMT (3)          06100000
061100                      H-HHA-REVENUE-ADD-ON-VISIT-AMT (4)          06110000
061200                      H-HHA-REVENUE-ADD-ON-VISIT-AMT (5)          06120000
061300                                                                  06130000
061400           GO TO RTC-CHECK.                                       06140000
061500                                                                  06150000
061600*    IF  REVENUE EARLIEST DATES = DEFAULT THEN                    06160000
061700*    LUPA ADD ON DOES NOT CALCULATE                               06170000
061800                                                                  06180000
061900     IF (H-HHA-REVENUE-EARLIEST-DATE (1) = 29990101 AND           06190000
062000         H-HHA-REVENUE-EARLIEST-DATE (3) = 29990101 AND           06200000
062100         H-HHA-REVENUE-EARLIEST-DATE (4) = 29990101)              06210000
062200                                                                  06220000
062300         MOVE 0 TO  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1)            06230000
062400                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (2)            06240000
062500                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (3)            06250000
062600                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (4)            06260000
062700                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (5)            06270000
062800                                                                  06280000
062900           GO TO RTC-CHECK.                                       06290000
063000                                                                  06300000
063100*    IF PT OCCURS ON EARLIEST DATE THEN LUPA ADD ON APPLIES TO    06310000
063200*       PT                                                        06320000
063300                                                                  06330000
063400     IF (H-HHA-REVENUE-EARLIEST-DATE (1) <                        06340000
063500         H-HHA-REVENUE-EARLIEST-DATE (3)) AND                     06350000
063600        (H-HHA-REVENUE-EARLIEST-DATE (1) <                        06360000
063700         H-HHA-REVENUE-EARLIEST-DATE (4))                         06370000
063800        COMPUTE  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1) ROUNDED =     06380000
063900           H-HHA-REVENUE-DOLL-RATE (1) * LUPA-ADD-ON-PT1          06390000
064000        MOVE LUPA-ADD-ON-PT1     TO WS-STDV-LUPA-ADDON-FAC        06400000
064100        GO TO RTC-CHECK.                                          06410000
064200                                                                  06420000
064300*    IF SLT OCCURS ON EARLIEST DATE THEN LUPA ADD ON APPLIES TO   06430000
064400*       SLT                                                       06440000
064500                                                                  06450000
064600     IF (H-HHA-REVENUE-EARLIEST-DATE (3) <                        06460000
064700         H-HHA-REVENUE-EARLIEST-DATE (1)) AND                     06470000
064800        (H-HHA-REVENUE-EARLIEST-DATE (3) <                        06480000
064900         H-HHA-REVENUE-EARLIEST-DATE (4))                         06490000
065000        COMPUTE  H-HHA-REVENUE-ADD-ON-VISIT-AMT (3) ROUNDED =     06500000
065100           H-HHA-REVENUE-DOLL-RATE (3) * LUPA-ADD-ON-SLT3         06510000
065200        MOVE LUPA-ADD-ON-SLT3    TO WS-STDV-LUPA-ADDON-FAC        06520000
065300        GO TO RTC-CHECK.                                          06530000
065400                                                                  06540000
065500*    IF SN OCCURS ON EARLIEST DATE THEN LUPA ADD ON APPLIES TO    06550000
065600*       SN                                                        06560000
065700                                                                  06570000
065800     IF (H-HHA-REVENUE-EARLIEST-DATE (4) <                        06580000
065900         H-HHA-REVENUE-EARLIEST-DATE (1)) AND                     06590000
066000        (H-HHA-REVENUE-EARLIEST-DATE (4) <                        06600000
066100         H-HHA-REVENUE-EARLIEST-DATE (3))                         06610000
066200        COMPUTE  H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) ROUNDED =     06620000
066300           H-HHA-REVENUE-DOLL-RATE (4) * LUPA-ADD-ON-SN4          06630000
066400        MOVE LUPA-ADD-ON-SN4     TO WS-STDV-LUPA-ADDON-FAC        06640000
066500           GO TO RTC-CHECK.                                       06650000
066600                                                                  06660000
066700*    IF PT  EARLIEST DATE = SLT EARLIEST AND = SN EARLIEST        06670000
066800*    THEN LUPA ADD ON APPLIES TO SN                               06680000
066900*                                                                 06690000
067000     IF (H-HHA-REVENUE-EARLIEST-DATE (1) =                        06700000
067100         H-HHA-REVENUE-EARLIEST-DATE (3)) AND                     06710000
067200        (H-HHA-REVENUE-EARLIEST-DATE (1) =                        06720000
067300         H-HHA-REVENUE-EARLIEST-DATE (4))                         06730000
067400        COMPUTE  H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) ROUNDED =     06740000
067500           H-HHA-REVENUE-DOLL-RATE (4) * LUPA-ADD-ON-SN4          06750000
067600        MOVE LUPA-ADD-ON-SN4     TO WS-STDV-LUPA-ADDON-FAC        06760000
067700        GO TO RTC-CHECK.                                          06770000
067800                                                                  06780000
067900*    IF PT EARLIEST DATE = SN EARLIEST                            06790000
068000*    THEN LUPA ADD ON APPLIES TO SN                               06800000
068100                                                                  06810000
068200     IF (H-HHA-REVENUE-EARLIEST-DATE (1) =                        06820000
068300         H-HHA-REVENUE-EARLIEST-DATE (4))                         06830000
068400        COMPUTE  H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) ROUNDED =     06840000
068500           H-HHA-REVENUE-DOLL-RATE (4) * LUPA-ADD-ON-SN4          06850000
068600        MOVE LUPA-ADD-ON-SN4     TO WS-STDV-LUPA-ADDON-FAC        06860000
068700        GO TO RTC-CHECK.                                          06870000
068800                                                                  06880000
068900*    IF SLT EARLIEST DATE = SN EARLIEST                           06890000
069000*    THEN LUPA ADD ON APPLIES TO SN                               06900000
069100                                                                  06910000
069200     IF (H-HHA-REVENUE-EARLIEST-DATE (3) =                        06920000
069300         H-HHA-REVENUE-EARLIEST-DATE (4))                         06930000
069400        COMPUTE  H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) ROUNDED =     06940000
069500           H-HHA-REVENUE-DOLL-RATE (4) * LUPA-ADD-ON-SN4          06950000
069600        MOVE LUPA-ADD-ON-SN4     TO WS-STDV-LUPA-ADDON-FAC        06960000
069700        GO TO RTC-CHECK.                                          06970000
069800                                                                  06980000
069900*    IF PT  EARLIEST DATE = SLT EARLIEST                          06990000
070000*    THEN LUPA ADD ON APPLIES TO PT                               07000000
070100                                                                  07010000
070200     IF (H-HHA-REVENUE-EARLIEST-DATE (1) =                        07020000
070300         H-HHA-REVENUE-EARLIEST-DATE (3))                         07030000
070400        COMPUTE  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1) ROUNDED =     07040000
070500           H-HHA-REVENUE-DOLL-RATE (1) * LUPA-ADD-ON-PT1          07050000
070600        MOVE LUPA-ADD-ON-PT1     TO WS-STDV-LUPA-ADDON-FAC        07060000
070700        GO TO RTC-CHECK.                                          07070000
070800                                                                  07080000
070900 RTC-CHECK.                                                       07090000
071000************************************************************      07100000
071100* ZERO OUT LUPA ADD-ON PAYMENT WHEN CERTAIN CONDITIONS MET *      07110000
071200************************************************************      07120000
071300                                                                  07130000
071400     IF H-HHA-ADMIT-DATE NOT = H-HHA-SERV-FROM-DATE               07140000
071500         MOVE 0 TO  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1)            07150000
071600                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (2)            07160000
071700                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (3)            07170000
071800                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (4)            07180000
071900                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (5).           07190000
072000                                                                  07200000
072100     IF H-HHA-LUPA-SRC-ADM = 'B'                                  07210000
072200         MOVE 0 TO  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1)            07220000
072300                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (2)            07230000
072400                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (3)            07240000
072500                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (4)            07250000
072600                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (5).           07260000
072700                                                                  07270000
072800     IF H-HHA-ADJ-IND = '2'                                       07280000
072900         MOVE 0 TO  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1)            07290000
073000                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (2)            07300000
073100                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (3)            07310000
073200                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (4)            07320000
073300                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (5).           07330000
073400                                                                  07340000
073500     IF H-HHA-REVENUE-SUM1-6-QTY-ALL = 0                          07350000
073600         MOVE 0 TO  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1)            07360000
073700                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (2)            07370000
073800                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (3)            07380000
073900                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (4)            07390000
074000                    H-HHA-REVENUE-ADD-ON-VISIT-AMT (5).           07400000
074100                                                                  07410000
074200     PERFORM 1050-LUPA THRU 1050-EXIT.                            07420000
074300                                                                  07430000
074400     IF  H-HHA-REVENUE-ADD-ON-VISIT-AMT (1) > 0                   07440000
074500     OR  H-HHA-REVENUE-ADD-ON-VISIT-AMT (2) > 0                   07450000
074600     OR  H-HHA-REVENUE-ADD-ON-VISIT-AMT (3) > 0                   07460000
074700     OR  H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) > 0                   07470000
074800     OR  H-HHA-REVENUE-ADD-ON-VISIT-AMT (5) > 0                   07480000
074900         MOVE '14' TO H-HHA-PAY-RTC                               07490000
075000     ELSE                                                         07500000
075100         MOVE '06' TO H-HHA-PAY-RTC                               07510000
075200     END-IF.                                                      07520000
075300                                                                  07530000
075400**   CHANGE DATES WITH DEFAULT BACK TO ZERO FOR PASSBACK       ** 07540000
075500                                                                  07550000
075600     IF H-HHA-REVENUE-EARLIEST-DATE (1) = 29990101                07560000
075700        MOVE 0 TO H-HHA-REVENUE-EARLIEST-DATE (1).                07570000
075800                                                                  07580000
075900     IF H-HHA-REVENUE-EARLIEST-DATE (3) = 29990101                07590000
076000        MOVE 0 TO H-HHA-REVENUE-EARLIEST-DATE (3).                07600000
076100                                                                  07610000
076200     IF H-HHA-REVENUE-EARLIEST-DATE (4) = 29990101                07620000
076300        MOVE 0 TO H-HHA-REVENUE-EARLIEST-DATE (4).                07630000
076400                                                                  07640000
076500     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        07650000
076600             H-HHA-REVENUE-COST (1) +                             07660000
076700             H-HHA-REVENUE-ADD-ON-VISIT-AMT (1) +                 07670000
076800             H-HHA-REVENUE-COST (2) +                             07680000
076900             H-HHA-REVENUE-ADD-ON-VISIT-AMT (2) +                 07690000
077000             H-HHA-REVENUE-COST (3) +                             07700000
077100             H-HHA-REVENUE-ADD-ON-VISIT-AMT (3) +                 07710000
077200             H-HHA-REVENUE-COST (4) +                             07720000
077300             H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) +                 07730000
077400             H-HHA-REVENUE-COST (5) +                             07740000
077500             H-HHA-REVENUE-ADD-ON-VISIT-AMT (5) +                 07750000
077600             H-HHA-REVENUE-COST (6) +                             07760000
077700             H-HHA-REVENUE-ADD-ON-VISIT-AMT (6).                  07770000
077800                                                                  07780000
077900     GO TO 1000-EXIT.                                             07790000
078000                                                                  07800000
078100******************************************************************07810000
078200* PEP - PARTIAL EPISODE PAYMENT - Y/N                            *07820000
078300******************************************************************07830000
078400 PEP-CHECK.                                                       07840000
078500                                                                  07850000
078600     IF H-HHA-PEP-IND = 'Y' OR 'N'                                07860000
078700        CONTINUE                                                  07870000
078800     ELSE                                                         07880000
078900        MOVE '20' TO H-HHA-PAY-RTC                                07890000
079000        GO TO 1000-EXIT.                                          07900000
079100                                                                  07910000
079200     IF H-HHA-HRG-NO-OF-DAYS > 30                                 07920000
079300        MOVE '16' TO H-HHA-PAY-RTC                                07930000
079400        GO TO 1000-EXIT.                                          07940000
079500                                                                  07950000
079600*----------------------------------------------------------------*07960000
079700*       HRG  PAYMENT                                             *07970000
079800*----------------------------------------------------------------*07980000
079900                                                                  07990000
080000     IF H-HHA-PEP-IND = 'N'                                       08000000
080100        PERFORM 3000-PEP-N-ADJUST THRU 3000-EXIT                  08010000
080200        PERFORM 7000-OUTLIER-PAYMENT THRU 7000-EXIT.              08020000
080300                                                                  08030000
080400     IF H-HHA-PEP-IND = 'Y'                                       08040000
080500        PERFORM 4000-PEP-Y-ADJUST THRU 4000-EXIT                  08050000
080600        PERFORM 7000-OUTLIER-PAYMENT THRU 7000-EXIT.              08060000
080700                                                                  08070000
080800 1000-EXIT.  EXIT.                                                08080000
080900                                                                  08090000
081000 1050-LUPA.                                                       08100000
081100***************************************************************   08110000
081200*                    LUPA PAYMENT                                 08120000
081300***************************************************************   08130000
081400                                                                  08140000
081500     COMPUTE FED-ADJ1 ROUNDED =                                   08150000
081600            (H-HHA-REVENUE-QTY-COV-VISITS (1) *                   08160000
081700             H-HHA-REVENUE-DOLL-RATE (1)).                        08170000
081800                                                                  08180000
081900     COMPUTE FED-LUPA-ADJ1 ROUNDED =                              08190000
082000             H-HHA-REVENUE-ADD-ON-VISIT-AMT (1).                  08200000
082100                                                                  08210000
082200     COMPUTE FED-LABOR-ADJ1 ROUNDED =                             08220000
082300             WIR-CBSA-WAGEIND *                                   08230000
082400             LABOR-PERCENT *                                      08240000
082500             FED-ADJ1.                                            08250000
082600                                                                  08260000
082700     COMPUTE FED-LABOR-LUPA-ADJ1 ROUNDED =                        08270000
082800             WIR-CBSA-WAGEIND *                                   08280000
082900             LABOR-PERCENT *                                      08290000
083000             FED-LUPA-ADJ1.                                       08300000
083100                                                                  08310000
083200     COMPUTE FED-NON-LABOR-ADJ1 ROUNDED =                         08320000
083300             NONLABOR-PERCENT *                                   08330000
083400             FED-ADJ1.                                            08340000
083500                                                                  08350000
083600     COMPUTE FED-NON-LABOR-LUPA-ADJ1 ROUNDED =                    08360000
083700             NONLABOR-PERCENT *                                   08370000
083800             FED-LUPA-ADJ1.                                       08380000
083900                                                                  08390000
084000     COMPUTE H-HHA-REVENUE-COST (1) ROUNDED =                     08400000
084100             (FED-LABOR-ADJ1 + FED-NON-LABOR-ADJ1).               08410000
084200     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (1) ROUNDED =         08420000
084300             (FED-LABOR-LUPA-ADJ1 + FED-NON-LABOR-LUPA-ADJ1).     08430000
084400                                                                  08440000
084500     COMPUTE FED-ADJ2 ROUNDED =                                   08450000
084600            (H-HHA-REVENUE-QTY-COV-VISITS (2) *                   08460000
084700             H-HHA-REVENUE-DOLL-RATE (2)).                        08470000
084800                                                                  08480000
084900     COMPUTE FED-LABOR-ADJ2 ROUNDED =                             08490000
085000             WIR-CBSA-WAGEIND *                                   08500000
085100             LABOR-PERCENT *                                      08510000
085200             FED-ADJ2.                                            08520000
085300                                                                  08530000
085400     COMPUTE FED-NON-LABOR-ADJ2 ROUNDED =                         08540000
085500             NONLABOR-PERCENT *                                   08550000
085600             FED-ADJ2.                                            08560000
085700                                                                  08570000
085800     COMPUTE H-HHA-REVENUE-COST (2) ROUNDED =                     08580000
085900             (FED-LABOR-ADJ2 + FED-NON-LABOR-ADJ2).               08590000
086000                                                                  08600000
086100     COMPUTE FED-ADJ3 ROUNDED =                                   08610000
086200            (H-HHA-REVENUE-QTY-COV-VISITS (3) *                   08620000
086300             H-HHA-REVENUE-DOLL-RATE (3)).                        08630000
086400                                                                  08640000
086500     COMPUTE FED-LUPA-ADJ3 ROUNDED =                              08650000
086600             H-HHA-REVENUE-ADD-ON-VISIT-AMT (3).                  08660000
086700                                                                  08670000
086800     COMPUTE FED-LABOR-ADJ3 ROUNDED =                             08680000
086900             WIR-CBSA-WAGEIND *                                   08690000
087000             LABOR-PERCENT *                                      08700000
087100             FED-ADJ3.                                            08710000
087200                                                                  08720000
087300     COMPUTE FED-LABOR-LUPA-ADJ3 ROUNDED =                        08730000
087400             WIR-CBSA-WAGEIND *                                   08740000
087500             LABOR-PERCENT *                                      08750000
087600             FED-LUPA-ADJ3.                                       08760000
087700                                                                  08770000
087800     COMPUTE FED-NON-LABOR-ADJ3 ROUNDED =                         08780000
087900             NONLABOR-PERCENT *                                   08790000
088000             FED-ADJ3.                                            08800000
088100                                                                  08810000
088200     COMPUTE FED-NON-LABOR-LUPA-ADJ3 ROUNDED =                    08820000
088300             NONLABOR-PERCENT *                                   08830000
088400             FED-LUPA-ADJ3.                                       08840000
088500                                                                  08850000
088600     COMPUTE H-HHA-REVENUE-COST (3) ROUNDED =                     08860000
088700             (FED-LABOR-ADJ3 + FED-NON-LABOR-ADJ3).               08870000
088800                                                                  08880000
088900     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (3) ROUNDED =         08890000
089000             (FED-LABOR-LUPA-ADJ3 + FED-NON-LABOR-LUPA-ADJ3).     08900000
089100                                                                  08910000
089200     COMPUTE FED-ADJ4 ROUNDED =                                   08920000
089300            (H-HHA-REVENUE-QTY-COV-VISITS (4) *                   08930000
089400             H-HHA-REVENUE-DOLL-RATE (4)).                        08940000
089500                                                                  08950000
089600     COMPUTE FED-LUPA-ADJ4 ROUNDED =                              08960000
089700             H-HHA-REVENUE-ADD-ON-VISIT-AMT (4).                  08970000
089800                                                                  08980000
089900     COMPUTE FED-LABOR-ADJ4 ROUNDED =                             08990000
090000             WIR-CBSA-WAGEIND *                                   09000000
090100             LABOR-PERCENT *                                      09010000
090200             FED-ADJ4.                                            09020000
090300                                                                  09030000
090400     COMPUTE FED-LABOR-LUPA-ADJ4 ROUNDED =                        09040000
090500             WIR-CBSA-WAGEIND *                                   09050000
090600             LABOR-PERCENT *                                      09060000
090700             FED-LUPA-ADJ4.                                       09070000
090800                                                                  09080000
090900     COMPUTE FED-NON-LABOR-ADJ4 ROUNDED =                         09090000
091000             NONLABOR-PERCENT *                                   09100000
091100             FED-ADJ4.                                            09110000
091200                                                                  09120000
091300     COMPUTE FED-NON-LABOR-LUPA-ADJ4 ROUNDED =                    09130000
091400             NONLABOR-PERCENT *                                   09140000
091500             FED-LUPA-ADJ4.                                       09150000
091600                                                                  09160000
091700     COMPUTE H-HHA-REVENUE-COST (4) ROUNDED =                     09170000
091800             (FED-LABOR-ADJ4 + FED-NON-LABOR-ADJ4).               09180000
091900                                                                  09190000
092000     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) ROUNDED =         09200000
092100             (FED-LABOR-LUPA-ADJ4 + FED-NON-LABOR-LUPA-ADJ4).     09210000
092200                                                                  09220000
092300     COMPUTE FED-ADJ5 ROUNDED =                                   09230000
092400            (H-HHA-REVENUE-QTY-COV-VISITS (5) *                   09240000
092500             H-HHA-REVENUE-DOLL-RATE (5)).                        09250000
092600                                                                  09260000
092700     COMPUTE FED-LABOR-ADJ5 ROUNDED =                             09270000
092800             WIR-CBSA-WAGEIND *                                   09280000
092900             LABOR-PERCENT *                                      09290000
093000             FED-ADJ5.                                            09300000
093100                                                                  09310000
093200                                                                  09320000
093300     COMPUTE FED-NON-LABOR-ADJ5 ROUNDED =                         09330000
093400             NONLABOR-PERCENT *                                   09340000
093500             FED-ADJ5.                                            09350000
093600                                                                  09360000
093700     COMPUTE H-HHA-REVENUE-COST (5) ROUNDED =                     09370000
093800             (FED-LABOR-ADJ5 + FED-NON-LABOR-ADJ5).               09380000
093900                                                                  09390000
094000     COMPUTE FED-ADJ6 ROUNDED =                                   09400000
094100            (H-HHA-REVENUE-QTY-COV-VISITS (6) *                   09410000
094200             H-HHA-REVENUE-DOLL-RATE (6)).                        09420000
094300                                                                  09430000
094400     COMPUTE FED-LABOR-ADJ6 ROUNDED =                             09440000
094500             WIR-CBSA-WAGEIND *                                   09450000
094600             LABOR-PERCENT *                                      09460000
094700             FED-ADJ6.                                            09470000
094800                                                                  09480000
094900                                                                  09490000
095000     COMPUTE FED-NON-LABOR-ADJ6 ROUNDED =                         09500000
095100             NONLABOR-PERCENT *                                   09510000
095200             FED-ADJ6.                                            09520000
095300                                                                  09530000
095400     COMPUTE H-HHA-REVENUE-COST (6) ROUNDED =                     09540000
095500             (FED-LABOR-ADJ6 + FED-NON-LABOR-ADJ6).               09550000
095600                                                                  09560000
095700 1050-EXIT.   EXIT.                                               09570000
095800                                                                  09580000
095900******************************************************************09590000
096000*     RURAL COUNTY CODE TABLE LOOK UP                            *09600000
096100******************************************************************09610000
096200 2000-TBL-SCC-SEARCH.                                             09620000
096300                                                                  09630000
096400     MOVE SPACE TO  WS-RURAL-CATEGORY.                            09640000
096500                                                                  09650000
096600     IF H-HHA-COUNTY-CODE = SPACES                                09660000
096700        MOVE '31' TO H-HHA-PAY-RTC                                09670000
096800        GO TO 2000-EXIT                                           09680000
096900     END-IF.                                                      09690000
097000                                                                  09700000
097100     SEARCH ALL T-SCC-DATA                                        09710000
097200         AT END                                                   09720000
097300            MOVE '31' TO H-HHA-PAY-RTC                            09730000
097400            GO TO 2000-EXIT                                       09740000
097500         WHEN T-SCC-CODE (IX-SCC) = H-HHA-COUNTY-CODE             09750000
097600            MOVE T-SCC-CATEGORY (IX-SCC) TO WS-RURAL-CATEGORY     09760000
097700            MOVE '00' TO H-HHA-PAY-RTC                            09770000
097800     END-SEARCH.                                                  09780000
097900                                                                  09790000
098000 2000-EXIT.   EXIT.                                               09800000
098100                                                                  09810000
098200******************************************************************09820000
098300*     RURAL COUNTY CODE TABLE LOOK UP - EXTRA                    *09830000
098400******************************************************************09840000
098500 2100-TBL-ECC-SEARCH.                                             09850000
098600                                                                  09860000
098700     IF H-HHA-COUNTY-CODE = SPACES                                09870000
098800        GO  TO 2100-EXIT.                                         09880000
098900                                                                  09890000
099000     MOVE SPACE TO  WS-RURAL-CATEGORY.                            09900000
099100                                                                  09910000
099200     SEARCH ALL T-ECC-DATA                                        09920000
099300         AT END                                                   09930000
099400            GO  TO 2100-EXIT                                      09940000
099500         WHEN T-ECC-CODE (IX-ECC) = H-HHA-COUNTY-CODE             09950000
099600            MOVE T-ECC-CATEGORY (IX-ECC) TO WS-RURAL-CATEGORY     09960000
099700            MOVE '00' TO H-HHA-PAY-RTC                            09970000
099800     END-SEARCH.                                                  09980000
099900                                                                  09990000
100000 2100-EXIT.   EXIT.                                               10000000
100100                                                                  10010000
100200******************************************************************10020000
100300* PEP - PARTIAL EPISODE PAYMENT - NO                             *10030000
100400******************************************************************10040000
100500 3000-PEP-N-ADJUST.                                               10050000
100600                                                                  10060000
100700     MOVE H-HHA-HRG-NO-OF-DAYS  TO WK-HRG-NO-OF-DAYS.             10070000
100800                                                                  10080000
100900     COMPUTE FED-ADJ ROUNDED =                                    10090000
101000             H-HHA-HRG-WGTS  * FED-EPISODE-RATE-AMT.              10100000
101100                                                                  10110000
101200     COMPUTE FED-LABOR-ADJ ROUNDED =                              10120000
101300              (WIR-CBSA-WAGEIND *                                 10130000
101400               LABOR-PERCENT * FED-ADJ).                          10140000
101500                                                                  10150000
101600     COMPUTE FED-NON-LABOR-ADJ ROUNDED =                          10160000
101700              (NONLABOR-PERCENT * FED-ADJ).                       10170000
101800                                                                  10180000
101900     COMPUTE WK-3000-PEP-N-PAYMENT ROUNDED =                      10190000
102000          (FED-LABOR-ADJ + FED-NON-LABOR-ADJ).                    10200000
102100                                                                  10210000
102200     COMPUTE H-HHA-HRG-PAY ROUNDED =                              10220000
102300             WK-3000-PEP-N-PAYMENT.                               10230000
102400                                                                  10240000
102500     COMPUTE WK-3000-PEP-N-PRETOT-PAY ROUNDED =                   10250000
102600             WK-3000-PEP-N-PRETOT-PAY + WK-3000-PEP-N-PAYMENT.    10260000
102700                                                                  10270000
102800 3000-EXIT.   EXIT.                                               10280000
102900                                                                  10290000
103000******************************************************************10300000
103100* PEP - PARTIAL EPISODE PAYMENT - YES                            *10310000
103200******************************************************************10320000
103300 4000-PEP-Y-ADJUST.                                               10330000
103400                                                                  10340000
103500     MOVE 2 TO WK-RTC-ADJ-IND.                                    10350000
103600     MOVE H-HHA-HRG-NO-OF-DAYS TO WK-HRG-NO-OF-DAYS.              10360000
103700                                                                  10370000
103800     COMPUTE FED-ADJP ROUNDED =                                   10380000
103900             H-HHA-HRG-WGTS   * FED-EPISODE-RATE-AMT.             10390000
104000                                                                  10400000
104100     COMPUTE FED-LABOR-ADJP ROUNDED =                             10410000
104200               WIR-CBSA-WAGEIND *                                 10420000
104300               LABOR-PERCENT * FED-ADJP.                          10430000
104400                                                                  10440000
104500     COMPUTE FED-NON-LABOR-ADJP ROUNDED =                         10450000
104600               NONLABOR-PERCENT * FED-ADJP.                       10460000
104700                                                                  10470000
104800     COMPUTE WK-4000-PEP-Y-PAYMENT ROUNDED =                      10480000
104900         (FED-LABOR-ADJP + FED-NON-LABOR-ADJP).                   10490000
105000                                                                  10500000
105100     COMPUTE WK-HRG-NO-OF-DAYS-FAC ROUNDED =                      10510000
105200               (WK-HRG-NO-OF-DAYS / 30).                          10520000
105300                                                                  10530000
105400     COMPUTE WK-4000-PEP-Y-PAYMENT ROUNDED =                      10540000
105500             WK-4000-PEP-Y-PAYMENT *                              10550000
105600             WK-HRG-NO-OF-DAYS-FAC.                               10560000
105700                                                                  10570000
105800     COMPUTE H-HHA-HRG-PAY  ROUNDED =                             10580000
105900             WK-4000-PEP-Y-PAYMENT.                               10590000
106000                                                                  10600000
106100     COMPUTE WK-4000-PEP-Y-PRETOT-PAY ROUNDED =                   10610000
106200             WK-4000-PEP-Y-PRETOT-PAY + WK-4000-PEP-Y-PAYMENT.    10620000
106300                                                                  10630000
106400 4000-EXIT.   EXIT.                                               10640000
106500                                                                  10650000
106600***************************************************************   10660000
106700*                    OUTLIER PAYMENT                              10670000
106800***************************************************************   10680000
106900 7000-OUTLIER-PAYMENT.                                            10690000
107000                                                                  10700000
107100     COMPUTE OUT-THRES-LABOR-ADJ ROUNDED =                        10710000
107200               WIR-CBSA-WAGEIND *                                 10720000
107300               LABOR-PERCENT * OUTLIER-THRESHOLD-AMT.             10730000
107400                                                                  10740000
107500     COMPUTE OUT-THRES-NON-LABOR-ADJ ROUNDED =                    10750000
107600               NONLABOR-PERCENT * OUTLIER-THRESHOLD-AMT.          10760000
107700                                                                  10770000
107800     COMPUTE OUT-THRES-AMT-ADJ ROUNDED  =                         10780000
107900             (OUT-THRES-LABOR-ADJ +                               10790000
108000              OUT-THRES-NON-LABOR-ADJ).                           10800000
108100                                                                  10810000
108200      COMPUTE WK-7000-OUTLIER-VALUE-A ROUNDED =                   10820000
108300              OUT-THRES-AMT-ADJ +                                 10830000
108400             WK-3000-PEP-N-PRETOT-PAY +                           10840000
108500             WK-4000-PEP-Y-PRETOT-PAY.                            10850000
108600                                                                  10860000
108700      PERFORM 8000-ADD-REV-DOLL THRU 8000-EXIT                    10870000
108800                  VARYING CO1 FROM 1 BY 1 UNTIL                   10880000
108900                   CO1 > 6.                                       10890000
109000                                                                  10900000
109100      COMPUTE WK-7000-AB-DIFF ROUNDED =                           10910000
109200              WK-8000-OUTLIER-VALUE-B - WK-7000-OUTLIER-VALUE-A.  10920000
109300****===================                                           10930000
109400      IF WK-7000-AB-DIFF > ZERO                                   10940000
109500         COMPUTE WK-7000-CALC ROUNDED =                           10950000
109600               OUTL-LOSS-SHAR-RATIO-PERCENT * WK-7000-AB-DIFF     10960000
109700                                                                  10970000
109800*** ================== NEW OUTLIER CAP HERE ========              10980000
109900         PERFORM 10000-OUTLIER-CAP-CALC THRU 10000-EXIT           10990000
110000*** ================== NEW OUTLIER CAP HERE ========              11000000
110100                                                                  11010000
110200****===================                                           11020000
110300         COMPUTE H-HHA-OUTLIER-PAYMENT ROUNDED =                  11030000
110400               WK-7000-CALC                                       11040000
110500                                                                  11050000
110600****===================                                           11060000
110700         COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                    11070000
110800                (WK-7000-CALC +                                   11080000
110900                 WK-3000-PEP-N-PRETOT-PAY +                       11090000
111000                 WK-4000-PEP-Y-PRETOT-PAY )                       11100000
111100         PERFORM 9000-WHICH-RTC-OUTLIER THRU 9000-EXIT            11110000
111200      ELSE                                                        11120000
111300         COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                    11130000
111400                (WK-3000-PEP-N-PRETOT-PAY +                       11140000
111500                 WK-4000-PEP-Y-PRETOT-PAY)                        11150000
111600         PERFORM 9050-WHICH-RTC-NO-OUTLIER THRU 9050-EXIT.        11160000
111700                                                                  11170000
111800 7000-EXIT.   EXIT.                                               11180000
111900                                                                  11190000
112000 8000-ADD-REV-DOLL.                                               11200000
112100                                                                  11210000
112200***************************************************************   11220000
112300*        ADD ALL REVENUE DOLLARS                                  11230000
112400***************************************************************   11240000
112500     IF H-HHA-REVENUE-CODE (CO1) = SPACES                         11250000
112600        MOVE 6 TO CO1                                             11260000
112700        GO TO 8000-EXIT.                                          11270000
112800                                                                  11280000
112900     PERFORM 8100-ADJ-REV-DOLL    THRU 8100-EXIT.                 11290000
113000                                                                  11300000
113100     COMPUTE FED-ADJ ROUNDED =                                    11310000
113200             WK-REV-DOLL-RATE-UNITS (CO1) *                       11320000
113300             H-HHA-REVENUE-QTY-OUTL-UNITS (CO1).                  11330000
113400                                                                  11340000
113500     COMPUTE FED-LABOR-ADJ ROUNDED =                              11350000
113600               WIR-CBSA-WAGEIND *                                 11360000
113700               LABOR-PERCENT * FED-ADJ.                           11370000
113800                                                                  11380000
113900     COMPUTE FED-NON-LABOR-ADJ ROUNDED =                          11390000
114000               NONLABOR-PERCENT * FED-ADJ.                        11400000
114100                                                                  11410000
114200     COMPUTE WK-8000-OUTLIER-LAB-NLAB ROUNDED =                   11420000
114300           (FED-LABOR-ADJ + FED-NON-LABOR-ADJ).                   11430000
114400                                                                  11440000
114500     COMPUTE H-HHA-REVENUE-COST (CO1) ROUNDED =                   11450000
114600               WK-8000-OUTLIER-LAB-NLAB.                          11460000
114700                                                                  11470000
114800     COMPUTE WK-8000-OUTLIER-VALUE-B ROUNDED =                    11480000
114900             WK-8000-OUTLIER-VALUE-B + WK-8000-OUTLIER-LAB-NLAB.  11490000
115000                                                                  11500000
115100 8000-EXIT.   EXIT.                                               11510000
115200                                                                  11520000
115300*----------------------------------------------------------------*11530000
115400* ADJUST DOLLAR RATE USING THE RURAL ADD ON FACTOR               *11540000
115500*----------------------------------------------------------------*11550000
115600 8100-ADJ-REV-DOLL.                                               11560000
115700                                                                  11570000
115800     IF WS-RURAL-CATEGORY = 'A'                                   11580000
115900         COMPUTE WK-REV-DOLL-RATE-UNITS  (CO1) ROUNDED =          11590000
116000                 WK-REV-DOLL-RATE-UNITS  (CO1) *                  11600000
116100                 WS-RURAL-ADDON-A                                 11610000
116200     END-IF.                                                      11620000
116300     IF WS-RURAL-CATEGORY = 'B'                                   11630000
116400         COMPUTE WK-REV-DOLL-RATE-UNITS  (CO1) ROUNDED =          11640000
116500                 WK-REV-DOLL-RATE-UNITS  (CO1) *                  11650000
116600                 WS-RURAL-ADDON-B                                 11660000
116700     END-IF.                                                      11670000
116800     IF WS-RURAL-CATEGORY = 'C'                                   11680000
116900         COMPUTE WK-REV-DOLL-RATE-UNITS  (CO1) ROUNDED =          11690000
117000                 WK-REV-DOLL-RATE-UNITS  (CO1) *                  11700000
117100                 WS-RURAL-ADDON-C                                 11710000
117200     END-IF.                                                      11720000
117300                                                                  11730000
117400 8100-EXIT.   EXIT.                                               11740000
117500                                                                  11750000
117600 9000-WHICH-RTC-OUTLIER.                                          11760000
117700                                                                  11770000
117800     MOVE '01' TO H-HHA-PAY-RTC.                                  11780000
117900                                                                  11790000
118000     IF WK-RTC-ADJ-IND = 2  MOVE '11' TO H-HHA-PAY-RTC.           11800000
118100     IF WK-RTC-ADJ-IND = 4  MOVE '02' TO H-HHA-PAY-RTC.           11810000
118200                                                                  11820000
118300 9000-EXIT.   EXIT.                                               11830000
118400                                                                  11840000
118500 9050-WHICH-RTC-NO-OUTLIER.                                       11850000
118600                                                                  11860000
118700     MOVE '00' TO H-HHA-PAY-RTC.                                  11870000
118800                                                                  11880000
118900     IF WK-RTC-ADJ-IND = 2  MOVE '09' TO H-HHA-PAY-RTC.           11890000
119000                                                                  11900000
119100 9050-EXIT.   EXIT.                                               11910000
119200                                                                  11920000
145800                                                                  14580000
145900******************************************************************14590000
146100* CALCULATE THE LATE SUBMISSION PENALTY AMOUNT                   *14610009
146200******************************************************************14620000
146300 9100-LATE-SUB-PENALTY.                                           14630010
146310     INITIALIZE H-HHA-LATE-SUB-PEN-AMT.                           14631009
146311*----------------------------------------------------------------*14631109
146312* CALCULATE THE H-HHA-LATE-SUB-PENALTY FOR NON LUPA CLAIMS ONLY  *14631209
146313*----------------------------------------------------------------*14631309
146314     IF H-HHA-HRG-PAY > 0                                         14631409
146315        NEXT SENTENCE                                             14631509
146316     ELSE                                                         14631609
146317        GO  TO 9100-EXIT.                                         14631710
146318*----------------------------------------------------------------*14631809
146319* Y = EXCEPTION HAS BEEN GRANTED, NO LATE FILING PENALTY WILL BE *14631909
146320*     BE CALCULATED                                              *14632009
146321*----------------------------------------------------------------*14632109
146322     IF H-HHA-OVERRIDE-IND = 'Y'                                  14632208
146330        GO  TO 9100-EXIT.                                         14633010
146331*----------------------------------------------------------------*14633109
146332* IF NO RECEIPT DATE, DO NOT CALCULATE                           *14633209
146334*----------------------------------------------------------------*14633409
146350     IF H-HHA-RECEIPT-DATE = SPACES                               14635008
146360        GO TO 9100-EXIT.                                          14636010
146410*----------------------------------------------------------------*14641009
146420* COMPUTE THE DAYS DIFFERENCE --  FROM DATE THRU DATE            *14642009
146430*----------------------------------------------------------------*14643009
146500     INITIALIZE WS-DAYS-DIFFERENCE.                               14650009
146900                                                                  14690000
147000     COMPUTE WS-INT-FROM-DATE = FUNCTION                          14700000
147100             INTEGER-OF-DATE(H-HHA-SERV-FROM-DATE-N)              14710000
147200     END-COMPUTE.                                                 14720000
147300                                                                  14730000
147400     COMPUTE WS-INT-TO-DATE = FUNCTION                            14740000
147500             INTEGER-OF-DATE(H-HHA-RECEIPT-DATE-N)                14750000
147600     END-COMPUTE.                                                 14760000
147700                                                                  14770000
147800     COMPUTE WS-DAYS-DIFFERENCE =                                 14780000
147900             (WS-INT-TO-DATE - WS-INT-FROM-DATE)                  14790000
148000     END-COMPUTE.                                                 14800000
148003*----------------------------------------------------------------*14800309
148004* CALCULATE LATE SUBMISSION PENALTY IF DAYS DIFFERENCE IS        *14800409
148005* IS GREATER THAN 5 AND OVERRIDE INDICATOR IS N                  *14800509
148006*----------------------------------------------------------------*14800609
148010* N = NO EXCEPTION APPLIES, CALCULATE LATE FILING PENALTY        *14801009
148020*     IF APPLICABLE                                              *14802009
148030*----------------------------------------------------------------*14803009
148200     IF WS-DAYS-DIFFERENCE > +5 AND H-HHA-OVERRIDE-IND = 'N'      14820009
148300        PERFORM 9110-COMPUTE-LATE-SUB-PENALTY                     14830010
148310           THRU 9110-EXIT.                                        14831010
149300                                                                  14930000
149800 9100-EXIT.  EXIT.                                                14980010
149801                                                                  14980108
149802******************************************************************14980208
149804* CALCULATE THE LATE SUBMISSION PENALTY AMOUNT                   *14980409
149805******************************************************************14980508
149806 9110-COMPUTE-LATE-SUB-PENALTY.                                   14980610
149808     INITIALIZE WS-HRG-PENALTY, WS-OUTL-PENALTY.                  14980829
149809     INITIALIZE WS-HRG-REDUCED, WS-OUTL-REDUCED.                  14980929
149811*----------------------------------------------------------------*14981129
149812* IF THE DAYS DIFFERENCE IS GREAT THAN 30 DAYS, USE 30 DAYS.     *14981229
149813* IF THE DAYS DIFFERENCE IS LESS THAN 31 DAYS, USE ACTUAL DAYS.  *14981329
149814*----------------------------------------------------------------*14981429
149819     IF WS-DAYS-DIFFERENCE > +30                                  14981930
149820        MOVE 30 TO WS-DAYS-DIFFERENCE.                            14982029
149826*----------------------------------------------------------------*14982629
149827* COMPUTE HRG-PAY PENALTY AMOUNT                                 *14982729
149828*----------------------------------------------------------------*14982829
149829     COMPUTE WS-HRG-PENALTY ROUNDED =                             14982929
149830             H-HHA-HRG-PAY * WS-DAYS-DIFFERENCE / 30.             14983029
149831*----------------------------------------------------------------*14983129
149832* COMPUTE HRG-PAY REDUCED BY PENALTY                             *14983229
149833*----------------------------------------------------------------*14983329
149834     COMPUTE WS-HRG-REDUCED ROUNDED =                             14983429
149835             H-HHA-HRG-PAY - WS-HRG-PENALTY.                      14983529
149836*----------------------------------------------------------------*14983629
149837* MOVE HRG-PAY REDUCED TO OUTPUT RECORD                          *14983729
149838*----------------------------------------------------------------*14983829
149839     MOVE WS-HRG-REDUCED TO H-HHA-HRG-PAY.                        14983929
149841*----------------------------------------------------------------*14984129
149842* COMPUTE OUTLIER PENALTY AMOUNT                                 *14984229
149843*----------------------------------------------------------------*14984329
149845     COMPUTE WS-OUTL-PENALTY ROUNDED =                            14984529
149846             H-HHA-OUTLIER-PAYMENT * WS-DAYS-DIFFERENCE / 30.     14984629
149847*----------------------------------------------------------------*14984729
149848* COMPUTE OUTLIER REDUCED BY PENALTY                             *14984829
149849*----------------------------------------------------------------*14984929
149850     COMPUTE WS-OUTL-REDUCED ROUNDED =                            14985029
149851             H-HHA-OUTLIER-PAYMENT - WS-OUTL-PENALTY.             14985129
149852*----------------------------------------------------------------*14985229
149853* MOVE OUTLIER REDUCED TO OUTPUT RECORD                          *14985329
149854*----------------------------------------------------------------*14985429
149855     MOVE WS-OUTL-REDUCED TO H-HHA-OUTLIER-PAYMENT.               14985529
149857*----------------------------------------------------------------*14985729
149858* COMPUTE THE TOTAL-PAYMENT AMOUNT                               *14985829
149860*----------------------------------------------------------------*14986029
149861     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        14986117
149862             H-HHA-HRG-PAY + H-HHA-OUTLIER-PAYMENT.               14986217
149864*----------------------------------------------------------------*14986409
149865* COMPUTE LATE SUBMISSION PENALTY AMOUNT                         *14986517
149867*----------------------------------------------------------------*14986709
149870     COMPUTE H-HHA-LATE-SUB-PEN-AMT ROUNDED =                     14987017
149871             WS-HRG-PENALTY + WS-OUTL-PENALTY.                    14987117
149876                                                                  14987609
149877 9110-EXIT.  EXIT.                                                14987712
150141                                                                  15014120
150142******************************************************************15014220
150143* CALCULATES THE VALUE BASED PURCHASING ADJUSTMENT AMOUNT        *15014320
150144******************************************************************15014420
150145 9200-VBP-CALC.                                                   15014521
150149     INITIALIZE H-HHA-VBP-ADJ-AMT.                                15014920
150150     MOVE H-HHA-TOTAL-PAYMENT TO WK-9100-TOTAL-PAYMENT.           15015020
150151     MOVE 0                   TO H-HHA-TOTAL-PAYMENT.             15015120
150152                                                                  15015220
150154     IF H-HHA-HRG-PAY > 0                                         15015420
150155       COMPUTE H-HHA-HRG-PAY ROUNDED =                            15015520
150156               H-HHA-HRG-PAY * H-HHA-PROV-VBP-ADJ-FAC             15015620
150157       END-COMPUTE                                                15015720
150158       COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                      15015820
150159               H-HHA-TOTAL-PAYMENT + H-HHA-HRG-PAY                15015920
150160       END-COMPUTE                                                15016020
150161     END-IF.                                                      15016120
150162                                                                  15016220
150163* ONLY DO THIS FOR LUPA PAYMENTS                                  15016339
150164     IF H-HHA-HRG-PAY = 0                                         15016439
150165        IF H-HHA-PAY-RTC = '06' OR '14'                           15016539
150166           PERFORM 9210-VBP-REV-COST  THRU 9210-EXIT              15016639
150167        END-IF                                                    15016739
150168     END-IF.                                                      15016839
150169                                                                  15016939
150170     COMPUTE H-HHA-OUTLIER-PAYMENT ROUNDED =                      15017039
150171             H-HHA-OUTLIER-PAYMENT * H-HHA-PROV-VBP-ADJ-FAC       15017139
150172     END-COMPUTE.                                                 15017239
150173                                                                  15017339
150174     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15017439
150175             H-HHA-TOTAL-PAYMENT + H-HHA-OUTLIER-PAYMENT          15017539
150176     END-COMPUTE.                                                 15017639
150178                                                                  15017837
150179     COMPUTE H-HHA-VBP-ADJ-AMT ROUNDED =                          15017937
150180             H-HHA-TOTAL-PAYMENT - WK-9100-TOTAL-PAYMENT          15018037
150181     END-COMPUTE.                                                 15018137
150183                                                                  15018337
150184 9200-EXIT.   EXIT.                                               15018437
150185                                                                  15018537
150186 9210-VBP-REV-COST.                                               15018637
150187                                                                  15018737
150188     COMPUTE H-HHA-REVENUE-COST (1) ROUNDED =                     15018837
150189             H-HHA-REVENUE-COST (1) * H-HHA-PROV-VBP-ADJ-FAC      15018937
150190     END-COMPUTE.                                                 15019037
150191                                                                  15019137
150192     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15019237
150193             H-HHA-TOTAL-PAYMENT + H-HHA-REVENUE-COST (1)         15019337
150194     END-COMPUTE.                                                 15019437
150195                                                                  15019537
150196     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (1) ROUNDED =         15019637
150197             H-HHA-REVENUE-ADD-ON-VISIT-AMT (1) *                 15019737
150198             H-HHA-PROV-VBP-ADJ-FAC                               15019837
150199     END-COMPUTE.                                                 15019937
150200                                                                  15020037
150201     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15020137
150202             H-HHA-TOTAL-PAYMENT +                                15020237
150203             H-HHA-REVENUE-ADD-ON-VISIT-AMT (1)                   15020337
150204     END-COMPUTE.                                                 15020437
150205                                                                  15020537
150206     COMPUTE H-HHA-REVENUE-COST (2) ROUNDED =                     15020637
150207             H-HHA-REVENUE-COST (2) * H-HHA-PROV-VBP-ADJ-FAC      15020737
150208     END-COMPUTE.                                                 15020837
150209                                                                  15020937
150210     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15021037
150211             H-HHA-TOTAL-PAYMENT + H-HHA-REVENUE-COST (2)         15021137
150212     END-COMPUTE.                                                 15021237
150213                                                                  15021337
150214     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (2) ROUNDED =         15021437
150215             H-HHA-REVENUE-ADD-ON-VISIT-AMT (2) *                 15021537
150216             H-HHA-PROV-VBP-ADJ-FAC                               15021637
150217     END-COMPUTE.                                                 15021737
150218                                                                  15021837
150219     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15021937
150220             H-HHA-TOTAL-PAYMENT +                                15022037
150221             H-HHA-REVENUE-ADD-ON-VISIT-AMT (2)                   15022137
150222     END-COMPUTE.                                                 15022237
150223                                                                  15022337
150224     COMPUTE H-HHA-REVENUE-COST (3) ROUNDED =                     15022437
150225             H-HHA-REVENUE-COST (3) * H-HHA-PROV-VBP-ADJ-FAC      15022537
150226     END-COMPUTE.                                                 15022637
150227                                                                  15022737
150228     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15022837
150229             H-HHA-TOTAL-PAYMENT + H-HHA-REVENUE-COST (3)         15022937
150230     END-COMPUTE.                                                 15023037
150231                                                                  15023137
150232     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (3) ROUNDED =         15023237
150233             H-HHA-REVENUE-ADD-ON-VISIT-AMT (3) *                 15023337
150234             H-HHA-PROV-VBP-ADJ-FAC                               15023437
150235     END-COMPUTE.                                                 15023537
150236                                                                  15023637
150237     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15023737
150238             H-HHA-TOTAL-PAYMENT +                                15023837
150239             H-HHA-REVENUE-ADD-ON-VISIT-AMT (3)                   15023937
150240     END-COMPUTE.                                                 15024037
150241                                                                  15024137
150242     COMPUTE H-HHA-REVENUE-COST (4) ROUNDED =                     15024237
150243             H-HHA-REVENUE-COST (4) * H-HHA-PROV-VBP-ADJ-FAC      15024337
150244     END-COMPUTE.                                                 15024437
150245                                                                  15024537
150246     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15024637
150247             H-HHA-TOTAL-PAYMENT + H-HHA-REVENUE-COST (4)         15024737
150248     END-COMPUTE.                                                 15024837
150249                                                                  15024937
150250     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) ROUNDED =         15025037
150251             H-HHA-REVENUE-ADD-ON-VISIT-AMT (4) *                 15025137
150252             H-HHA-PROV-VBP-ADJ-FAC                               15025237
150253     END-COMPUTE.                                                 15025337
150254                                                                  15025437
150255     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15025537
150256             H-HHA-TOTAL-PAYMENT +                                15025637
150257             H-HHA-REVENUE-ADD-ON-VISIT-AMT (4)                   15025737
150258     END-COMPUTE.                                                 15025837
150259                                                                  15025937
150260     COMPUTE H-HHA-REVENUE-COST (5) ROUNDED =                     15026037
150261             H-HHA-REVENUE-COST (5) * H-HHA-PROV-VBP-ADJ-FAC      15026137
150262     END-COMPUTE.                                                 15026237
150263                                                                  15026337
150264     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15026437
150265             H-HHA-TOTAL-PAYMENT + H-HHA-REVENUE-COST (5)         15026537
150266     END-COMPUTE.                                                 15026637
150267                                                                  15026737
150268     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (5) ROUNDED =         15026837
150269             H-HHA-REVENUE-ADD-ON-VISIT-AMT (5) *                 15026937
150270             H-HHA-PROV-VBP-ADJ-FAC                               15027037
150271     END-COMPUTE.                                                 15027137
150272                                                                  15027237
150273     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15027337
150274             H-HHA-TOTAL-PAYMENT +                                15027437
150275             H-HHA-REVENUE-ADD-ON-VISIT-AMT (5)                   15027537
150276     END-COMPUTE.                                                 15027637
150277                                                                  15027737
150278     COMPUTE H-HHA-REVENUE-COST (6) ROUNDED =                     15027837
150279             H-HHA-REVENUE-COST (6) * H-HHA-PROV-VBP-ADJ-FAC      15027937
150280     END-COMPUTE.                                                 15028037
150281                                                                  15028137
150282     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15028237
150283             H-HHA-TOTAL-PAYMENT + H-HHA-REVENUE-COST (6)         15028337
150284     END-COMPUTE.                                                 15028437
150285                                                                  15028537
150286     COMPUTE H-HHA-REVENUE-ADD-ON-VISIT-AMT (6) ROUNDED =         15028637
150287             H-HHA-REVENUE-ADD-ON-VISIT-AMT (6) *                 15028737
150288             H-HHA-PROV-VBP-ADJ-FAC                               15028837
150289     END-COMPUTE.                                                 15028937
150290                                                                  15029037
150291     COMPUTE H-HHA-TOTAL-PAYMENT ROUNDED =                        15029137
150292             H-HHA-TOTAL-PAYMENT +                                15029237
150293             H-HHA-REVENUE-ADD-ON-VISIT-AMT (6)                   15029337
150294     END-COMPUTE.                                                 15029437
150295                                                                  15029537
150296 9210-EXIT.   EXIT.                                               15029637
150297                                                                  15029737
150298******************************************************************15029837
150299* CALCULATES THE STANDARDIZED ALLOWED AMOUNT                     *15029937
150300******************************************************************15030037
150301 9300-CALC-STD-VALUE.                                             15030137
150302                                                                  15030237
150303     MOVE 0                   TO H-HHA-PPS-STD-VALUE.             15030337
150304                                                                  15030437
150305     IF H-HHA-REVENUE-SUM1-6-QTY-ALL < 5 AND                      15030537
150306        H-HHA-TOB IS NOT EQUAL TO 322                             15030637
150307        PERFORM 9310-CALC-STD-VALUE-LUPA                          15030737
150308           THRU 9310-EXIT                                         15030837
150309     END-IF.                                                      15030937
150310                                                                  15031037
150311     IF H-HHA-REVENUE-SUM1-6-QTY-ALL > 4 OR                       15031137
150312        H-HHA-TOB IS EQUAL TO 322                                 15031237
150313        PERFORM 9320-CALC-STD-VALUE-NLUPA                         15031337
150314           THRU 9320-EXIT                                         15031437
150315     END-IF.                                                      15031537
150316                                                                  15031637
150317 9300-EXIT.  EXIT.                                                15031737
150318                                                                  15031837
150319******************************************************************15031937
150320* ADDED FOR CY2018 RELEASE                                       *15032037
150321* CALCULATES THE STANDARDIZED ALLOWED AMOUNT FOR LUPA CLAIMS     *15032137
150322******************************************************************15032237
150323 9310-CALC-STD-VALUE-LUPA.                                        15032337
150324                                                                  15032437
150325     MOVE 0                   TO SS-QCV.                          15032537
150326     PERFORM 6 TIMES                                              15032637
150327       ADD 1                  TO SS-QCV                           15032737
150328                                                                  15032837
150329       IF H-HHA-REVENUE-QTY-COV-VISITS (SS-QCV) > 0               15032937
150330                                                                  15033037
150331         COMPUTE H-HHA-PPS-STD-VALUE ROUNDED =                    15033137
150332                 H-HHA-PPS-STD-VALUE +                            15033237
150333                (H-HHA-REVENUE-QTY-COV-VISITS (SS-QCV) *          15033337
150334                 TB-STDV-REV-DOLL-RATE (SS-QCV))                  15033437
150335         END-COMPUTE                                              15033537
150336                                                                  15033637
150337       END-IF                                                     15033737
150338                                                                  15033837
150339       IF H-HHA-REVENUE-ADD-ON-VISIT-AMT (SS-QCV) > 0             15033937
150340                                                                  15034037
150341         COMPUTE H-HHA-PPS-STD-VALUE ROUNDED =                    15034137
150342                  H-HHA-PPS-STD-VALUE +                           15034237
150343                 (TB-STDV-REV-DOLL-RATE (SS-QCV) *                15034337
150344                      WS-STDV-LUPA-ADDON-FAC)                     15034437
150345         END-COMPUTE                                              15034537
150346                                                                  15034637
150347       END-IF                                                     15034737
150348     END-PERFORM.                                                 15034837
150349                                                                  15034937
150350     COMPUTE H-HHA-PPS-STD-VALUE ROUNDED =                        15035037
150351             H-HHA-PPS-STD-VALUE *                                15035137
150352             WS-STDV-RURAL-FAC                                    15035237
150353     END-COMPUTE.                                                 15035337
150354                                                                  15035437
150355 9310-EXIT.  EXIT.                                                15035537
150356                                                                  15035637
150357******************************************************************15035737
150358* ADDED FOR CY2018 RELEASE                                       *15035837
150359* CALCULATES THE STANDARDIZED ALLOWED AMOUNT FOR NON-LUPA CLAIMS *15035937
150360******************************************************************15036037
150361 9320-CALC-STD-VALUE-NLUPA.                                       15036137
150362                                                                  15036237
150363* HIPPS CALCULATION                                               15036337
150364                                                                  15036437
150365     COMPUTE WS-STD-VALUE-NLUPA-AMT ROUNDED =                     15036537
150366       ( ( H-HHA-HRG-WGTS * WS-STDV-EPISODE-AMT ) +               15036637
150367           0 )*                                                   15036737
150368           H-HHA-HRG-NO-OF-DAYS / 30 *                            15036837
150369           WS-STDV-RURAL-FAC * 1                                  15036937
150370     END-COMPUTE.                                                 15037037
150371                                                                  15037137
150372* OUTLIER CALCULATION                                             15037237
150373                                                                  15037337
150374     COMPUTE WS-STD-VALUE-NLUPA-OUTL ROUNDED =                    15037437
150375       H-HHA-OUTLIER-PAYMENT /                                    15037537
150376       ( (LABOR-PERCENT * WIR-CBSA-WAGEIND) +                     15037637
150377         (1 - LABOR-PERCENT) )                                    15037737
150378     END-COMPUTE.                                                 15037837
150379                                                                  15037937
150380* STANDARD VALUE CALCULATION                                      15038037
150381                                                                  15038137
150382     COMPUTE H-HHA-PPS-STD-VALUE ROUNDED =                        15038237
150383             WS-STD-VALUE-NLUPA-AMT +                             15038337
150384             WS-STD-VALUE-NLUPA-OUTL                              15038437
150385     END-COMPUTE.                                                 15038537
150386                                                                  15038637
150387     IF H-HHA-TOB = 322                                           15038737
150388        IF H-HHA-INIT-PAY-QRP-IND = '1' OR '3'                    15038837
150389           COMPUTE H-HHA-PPS-STD-VALUE ROUNDED =                  15038937
150390                   H-HHA-PPS-STD-VALUE * 0                        15039037
150391           END-COMPUTE                                            15039137
150392           GO TO 9320-EXIT                                        15039237
150393        END-IF                                                    15039337
150394     END-IF.                                                      15039437
150395                                                                  15039537
150396     IF H-HHA-TOB = 322                                           15039637
150397        COMPUTE H-HHA-PPS-STD-VALUE ROUNDED =                     15039737
150398                H-HHA-PPS-STD-VALUE * .20                         15039837
150399        END-COMPUTE                                               15039937
150400     END-IF.                                                      15040037
150401                                                                  15040137
150402 9320-EXIT.  EXIT.                                                15040237
150403                                                                  15040337
150404 10000-OUTLIER-CAP-CALC.                                          15040437
150405                                                                  15040537
150406     IF  HHA-PROV-PAYMENT-TOTAL = 0                               15040637
150407        GO TO 10000-EXIT.                                         15040737
150410                                                                  15041000
150500     IF  HHA-PROV-OUTLIER-PAY-TOTAL = 0                           15050000
150600        GO TO 10000-EXIT.                                         15060000
150700                                                                  15070000
150800     COMPUTE WK-10000-OUTLIER-POOL-PERCENT ROUNDED =              15080000
150900         HHA-PROV-PAYMENT-TOTAL * .1.                             15090000
151000                                                                  15100000
151100     COMPUTE WK-10000-OUTLIER-AVAIL-POOL ROUNDED =                15110000
151200      WK-10000-OUTLIER-POOL-PERCENT - HHA-PROV-OUTLIER-PAY-TOTAL. 15120000
151300                                                                  15130000
151400      COMPUTE WK-10000-OUTLIER-POOL-DIF ROUNDED =                 15140000
151500         WK-10000-OUTLIER-AVAIL-POOL - WK-7000-CALC.              15150000
151600                                                                  15160000
151700      IF WK-10000-OUTLIER-POOL-DIF > 0                            15170000
151800        GO TO 10000-EXIT.                                         15180000
151900                                                                  15190000
152000      IF WK-10000-OUTLIER-POOL-DIF < 0 OR                         15200000
152100         HHA-PROV-OUTLIER-PAY-TOTAL < 0                           15210000
152200        COMPUTE WK-7000-CALC ROUNDED = 0                          15220000
152300        MOVE 4 TO WK-RTC-ADJ-IND.                                 15230000
152400                                                                  15240000
152500 10000-EXIT.   EXIT.                                              15250000
