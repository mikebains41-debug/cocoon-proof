000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID.    HHDRV213.                                         00020010
000300 DATE-COMPILED.                                                   00030000
000310******************************************************************00031000
000320* NATIONAL HHA PRICER EFFECTIVE JANUARY 1, 2020.                 *00032000
000330******************************************************************00033000
000332*                   CY2021.3 CHANGES                             *00033210
000333*                                                                *00033311
000334* -- UPDATED PROGRAM TO CALL HHCAL213                            *00033411
000335* -- UPDATED TO NOT GET THE CBSA FOR TOB-RAP WITH A              *00033513
000336*    HHA-SERV-FROM-DATE > '20201231'                             *00033613
000337******************************************************************00033712
000399******************************************************************00039900
000400* LUPA = LOW UTILIZATION PAYMENT ADJUSTMENT                      *00040000
000401******************************************************************00040100
000402******************************************************************00040207
000410*                      RETURN CODES                              *00041007
000420******************************************************************00042007
000600*  00 = FINAL PAYMENT                                             00060000
000700*       TOB = 327, 329, 32F, 32G, 32H, 32I, 32J,                  00070000
000800*             32K, 32M, 32Q, 32P                                  00080000
000900        WITH HRG,REVENUE CODE WHERE NO OUTLIER APPLIES            00090000
001000*  01 = FINAL PAYMENT                                             00100000
001100*       TOB = 327, 329, 32F, 32G, 32H, 32I, 32J,                  00110000
001200*             32K, 32M, 32Q, 32P                                  00120000
001300*       WITH HRG,REVENUE CODE WHERE OUTLIER APPLIES               00130000
001400*  03 = INITIAL HALF PAYMENT PAYMENT WILL BE ZERO                 00140000
001500*       TOB = 322                                                 00150000
001600*  04 = INITIAL HALF PAYMENT PAID AT 50%                          00160000
001700*       TOB = 322                                                 00170000
001800*       WITH INITIAL (FIRST) HRG AND NO REVENUE CODES             00180000
001900*  05 = INITIAL HALF PAYMENT PAID AT 60%                          00190000
002000*       TOB = 322                                                 00200000
002100*       WITH INITIAL (FIRST) HRG AND NO REVENUE CODES             00210000
002200*  06 = LUPA PAYMENT ONLY                                         00220000
002300*       TOB = 327, 329, 32F, 32G, 32H, 32I, 32J,                  00230000
002400*             32K, 32M, 32Q, 32P                                  00240000
002500*       WITH REVENUE CODES AND REVENUE QTYS < 5                   00250000
002600******************************************************************00260000
002700*                                                                 00270000
002800*            HHA-RTC   NO PAYMENTS RETURNED                       00280000
002900*                                                                 00290000
003000*  10 = INVALID TOB                                               00300000
003100*  15 = INVALID PEP DAYS FOR SHORTENED EPISODE                    00310000
003200*  20 = INVALID PEP INDICATOR                                     00320000
003300*  25 = INVALID MED REVIEW INDICATOR                              00330000
003400*  30 = INVALID CBSA CODE                                         00340000
003500*  31 = COUNTY CODE MISSING OR INVALID                            00350000
003600*  35 = INVALID INITIAL PAYMENT INDICATOR                         00360000
003700*       0 = MAKE NORMAL PERCENTAGE PAYMENT                        00370000
003800*       1 = PAY 0%                                                00380000
003900*       2 = MAKE FINAL PAYMENT REDUCED BY 2%                      00390000
004000*       3 = MAKE FINAL PAYMENT REDUCED BY 2%,                     00400000
004100*           PAY RAPS AT 0%                                        00410000
004200*  40 = ADMIT-DATE > SERV-FROM-DATE                               00420000
004300*  70 = INVALID OR NO HRG CODE PRESENT                            00430000
004400*  75 = REMOVED IN CY2020 RELEASE                                 00440000
004500*  80 = INVALID REVENUE CODE                                      00450000
004600*  85 = NO REVENUE CODE PRESENT                                   00460000
004700*       TOB = 327, 329, 32F, 32G, 32H, 32I, 32J,                  00470000
004800*             32K, 32M, 32Q, 32P                                  00480000
004900*                                                                 00490000
005000******************************************************************00500000
005100                                                                  00510000
005200 ENVIRONMENT                     DIVISION.                        00520000
005300 CONFIGURATION                   SECTION.                         00530000
005400 SOURCE-COMPUTER.                IBM-370.                         00540000
005500 OBJECT-COMPUTER.                IBM-370.                         00550000
005600                                                                  00560000
005700 INPUT-OUTPUT SECTION.                                            00570000
005800 FILE-CONTROL.                                                    00580000
005900                                                                  00590000
006000 DATA DIVISION.                                                   00600000
006100 FILE SECTION.                                                    00610000
006200 WORKING-STORAGE SECTION.                                         00620000
006300 01  FILLER                         PIC X(40)  VALUE              00630000
006400     'HHDRV    - W O R K I N G   S T O R A G E'.                  00640000
006500 01  DRV-VERSION                 PIC X(07)  VALUE 'D2021.3'.      00650010
006600 01  HHCAL200                    PIC X(08)  VALUE 'HHCAL200'.     00660000
006700 01  HHCAL213                    PIC X(08)  VALUE 'HHCAL213'.     00670010
006800 01  SUB1                        PIC 9(03)  VALUE 0.              00680000
006900 01  SS-REV                      PIC 9(01)  VALUE 0.              00690000
007000 01  TB-REV-DOLL-RATE-UNITS.                                      00700000
007100     05  WK-REV-DOLL-RATE-UNITS  PIC 9(07)V9(02)                  00710000
007200                                 OCCURS 6.                        00720000
007300 01  TB-STDV-DATA.                                                00730000
007400     05 TB-STDV-TABLE           OCCURS 6.                         00740000
007500        10  TB-STDV-REV-CODE           PIC X(04).                 00750000
007600        10  TB-STDV-REV-DOLL-RATE      PIC 9(07)V9(02).           00760000
007700                                                                  00770000
007800 01  L-HRG-THRESHOLD            PIC X(01).                        00780000
007900******************************************************************00790000
008000*    PASSED TO HHCAL PROGRAM                                     *00800000
008100******************************************************************00810000
008200 LINKAGE SECTION.                                                 00820000
008300                                                                  00830000
008400 01  WAGE-INDEX-DATA.                                             00840000
008500     02  WIR-MSA               PIC X(04).                         00850000
008600     02  WIR-EFFDATE           PIC X(08).                         00860000
008700     02  WIR-AREA-WAGEIND      PIC 9(02)V9(04).                   00870000
008800                                                                  00880000
008900 01  MSA-WI-TABLE.                                                00890000
009000     05  M-MSA-DATA        OCCURS 4000                            00900000
009100                           INDEXED BY MU1 MU2 MU3.                00910000
009200         10  TB-MSA        PIC X(04).                             00920000
009300         10  FILLER        PIC X(01).                             00930000
009400         10  TB-EFFDATE    PIC X(08).                             00940000
009500         10  FILLER        PIC X(01).                             00950000
009600         10  TB-WAGEIND    PIC 9(02)V9(04).                       00960000
009700                                                                  00970000
009800 01  CBSA-WAGE-INDEX-DATA.                                        00980000
009900     02  WIR-CBSA              PIC X(05).                         00990000
010000     02  WIR-CBSA-EFFDATE      PIC X(08).                         01000000
010100     02  WIR-CBSA-WAGEIND      PIC 9(02)V9(04).                   01010000
010200                                                                  01020000
010300 01  CBSA-WI-TABLE.                                               01030000
010400     05  T-CBSA-DATA        OCCURS 8000                           01040000
010500                           INDEXED BY MA1 MA2 MA3.                01050000
010600         10  T-CBSA            PIC X(05).                         01060000
010700         10  FILLER            PIC X(01).                         01070000
010800         10  T-CBSA-EFFDATE    PIC X(08).                         01080000
010900         10  FILLER            PIC X(01).                         01090000
011000         10  T-CBSA-WAGEIND    PIC 9(02)V9(04).                   01100000
011100                                                                  01110000
011200 01  HRG-TABLE.                                                   01120000
011300     05  TB-HRG-DATA       OCCURS 432                             01130000
011400                           INDEXED BY HU1 HU2 HU3.                01140000
011500         10  TB-HRG            PIC X(05).                         01150000
011600         10  FILLER            PIC X(01).                         01160000
011700         10  TB-HRG-EFFDATE    PIC X(08).                         01170000
011800         10  FILLER            PIC X(01).                         01180000
011900         10  TB-HRG-WGTS       PIC 9(02)V9(04).                   01190000
012000         10  FILLER            PIC X(01).                         01200000
012100         10  TB-HRG-THRESHOLD  PIC X(01).                         01210000
012200                                                                  01220000
012300 01  REVENUE-TABLE.                                               01230000
012400     05  M-REV-DATA        OCCURS 200                             01240000
012500                           INDEXED BY RU1 RU2 RU3.                01250000
012600         10  TB-REV-CODE.                                         01260000
012700             15  TB-REV-CODE-1ST.                                 01270000
012800                 88  TB-REV-CODE-RURAL-CHECK   VALUE '99'.        01280000
012900                 20  TB-REV-CODE-RURAL       PIC XX.              01290000
013000             15  TB-REV-CODE-2ND           PIC XX.                01300000
013100         10  FILLER                        PIC X(01).             01310000
013200         10  TB-REV-EFFDATE                PIC X(08).             01320000
013300         10  FILLER                        PIC X(01).             01330000
013400         10  TB-REV-DOLL-RATE-NRURAL       PIC 9(07)V9(02).       01340000
013500         10  FILLER                        PIC X(01).             01350000
013600         10  TB-REV-DOLL-RATE-RURAL        PIC 9(07)V9(02).       01360000
013700         10  FILLER                        PIC X.                 01370000
013800         10  TB-DOLL-RATE-NRURAL-NOSUBMIT  PIC 9(07)V9(02).       01380000
013900         10  FILLER                        PIC X.                 01390000
014000         10  TB-DOLL-RATE-RURAL-NOSUBMIT   PIC 9(07)V9(02).       01400000
014100         10  FILLER                        PIC X(01).             01410000
014200         10  TB-REV-UDOLL-RATE-NRURAL      PIC 9(07)V9(02).       01420000
014300         10  FILLER                        PIC X(01).             01430000
014400         10  TB-REV-UDOLL-RATE-RURAL       PIC 9(07)V9(02).       01440000
014500         10  FILLER                        PIC X.                 01450000
014600         10  TB-UDOLL-RATE-NRURAL-NOSUBMIT PIC 9(07)V9(02).       01460000
014700         10  FILLER                        PIC X.                 01470000
014800         10  TB-UDOLL-RATE-RURAL-NOSUBMIT  PIC 9(07)V9(02).       01480000
014900                                                                  01490000
015000*----------------------------------------------------------------*01500000
015100*  INPUT/OUTPUT RECORD LAYOUT - PIC X(650)                       *01510000
015200*  THIS RECORD WAS MODIFIED FOR THE 01/01/2020 RELEASE           *01520000
015300*----------------------------------------------------------------*01530000
015400 01  HHA-INPUT-DATA.                                              01540000
015500     05  HHA-DATA.                                                01550000
015600         10  HHA-NPI                 PIC X(10).                   01560000
015700         10  HHA-HIC                 PIC X(12).                   01570000
015800         10  HHA-PROV-NO             PIC X(06).                   01580000
015900         10  HHA-INIT-PAY-QRP-IND        PIC X(01).               01590000
016000             88  HHA-WITH-DATA-CHECK VALUE '0', '1'.              01600000
016100             88  HHA-NO-DATA-CHECK   VALUE '2', '3'.              01610000
016200         10  HHA-PROV-VBP-ADJ-FAC    PIC 9V9(5).                  01620000
016300         10  HHA-PROV-OUTLIER-PAY-TOTAL PIC 9(08)V9(02).          01630000
016400         10  HHA-PROV-PAYMENT-TOTAL  PIC 9(09)V9(02).             01640000
016500         10  HHA-TOB                 PIC X(03).                   01650000
016600             88 HHA-VALID-TOB-CLAIM  VALUE                        01660000
016700             '327', '329',                                        01670000
016800             '32F', '32G', '32H', '32I', '32J',                   01680000
016900             '32K', '32M', '32Q', '32P'.                          01690000
017000             88 HHA-VALID-TOB-RAP    VALUE                        01700000
017100             '322'.                                               01710000
017200         10  HHA-CBSA                PIC X(05).                   01720000
017300             88  HHA-CBSA-RURAL-CHECK-ALL VALUE                   01730000
017400             '50001', '50002', '50005', '50007', '50025',         01740000
017500             '50028', '50031', '50035', '50036', '50037',         01750000
017600             '50041', '50045', '50047', '50048', '50050',         01760000
017700             '50056', '50057', '50066', '50068', '50071',         01770000
017800             '50073', '50080', '50084', '50087', '50089',         01780000
017900             '50090', '50091', '50103', '50104', '50111',         01790000
018000             '50115', '50117', '50118', '50120', '50121',         01800000
018100             '50139', '50146', '50147', '50149', '50151',         01810000
018200             '50164', '50165', '50168', '50169', '50173',         01820000
018300             '50174', '50177', '50180', '50182', '50183'.         01830000
018400         10  FILLER  REDEFINES  HHA-CBSA.                         01840000
018500             15  HHA-CBSA-RURAL      PIC X(03).                   01850000
018600             88  HHA-CBSA-RURAL-CHECK  VALUE '999'.               01860000
018700             15  FILLER             PIC X(02).                    01870000
018800         10  HHA-COUNTY-CODE         PIC X(05).                   01880000
018900         10  HHA-SERV-FROM-DATE.                                  01890000
019000             15  HHA-FROM-CC         PIC XX.                      01900000
019100             15  HHA-FROM-YYMMDD.                                 01910000
019200                 25  HHA-FROM-YY     PIC XX.                      01920000
019300                 25  HHA-FROM-MM     PIC XX.                      01930000
019400                 25  HHA-FROM-DD     PIC XX.                      01940000
019500         10  HHA-SERV-THRU-DATE.                                  01950000
019600             15  HHA-THRU-CC         PIC XX.                      01960000
019700             15  HHA-THRU-YYMMDD.                                 01970000
019800                 25  HHA-THRU-YY     PIC XX.                      01980000
019900                 25  HHA-THRU-MM     PIC XX.                      01990000
020000                 25  HHA-THRU-DD     PIC XX.                      02000000
020100         10  HHA-ADMIT-DATE.                                      02010000
020200             15  HHA-ADMIT-CC        PIC XX.                      02020000
020300             15  HHA-ADMIT-YYMMDD.                                02030000
020400                 25  HHA-ADMIT-YY    PIC XX.                      02040000
020500                 25  HHA-ADMIT-MM    PIC XX.                      02050000
020600                 25  HHA-ADMIT-DD    PIC XX.                      02060000
020700         10  HHA-LUPA-SRC-ADM           PIC X.                    02070000
020800         10  HHA-ADJ-IND                PIC X.                    02080000
020900         10  HHA-PEP-IND             PIC X.                       02090000
021000         10  HHA-HRG-INPUT-CODE       PIC X(05).                  02100000
021100         10  HHA-HRG-NO-OF-DAYS       PIC 9(03).                  02110005
021200         10  HHA-HRG-WGTS             PIC 9(02)V9(04).            02120000
021300         10  HHA-HRG-PAY              PIC 9(07)V9(02).            02130000
021400         10  HHA-REVENUE-DATA     OCCURS 6.                       02140000
021500             15  HHA-REVENUE-CODE              PIC X(04).         02150000
021600             15  HHA-REVENUE-QTY-COV-VISITS    PIC 9(03).         02160000
021700             15  HHA-REVENUE-QTY-OUTL-UNITS    PIC 9(05).         02170000
021800             15  HHA-REVENUE-EARLIEST-DATE     PIC 9(08).         02180000
021900             15  HHA-REVENUE-DOLL-RATE         PIC 9(07)V9(02).   02190000
022000             15  HHA-REVENUE-COST              PIC 9(07)V9(02).   02200000
022100             15  HHA-REVENUE-ADD-ON-VISIT-AMT  PIC 9(07)V9(02).   02210000
022200         10  HHA-PAY-RTC                PIC 99.                   02220000
022300         10  HHA-REVENUE-SUM1-6-QTY-ALL PIC 9(05).                02230000
022400         10  HHA-OUTLIER-PAYMENT        PIC 9(07)V9(02).          02240000
022500         10  HHA-TOTAL-PAYMENT          PIC 9(07)V9(02).          02250000
022600         10  HHA-VBP-ADJ-AMT            PIC S9(7)V99.             02260000
022700         10  HHA-PPS-STD-VALUE          PIC 9(7)V99.              02270000
022800         10  HHA-RECEIPT-DATE           PIC X(8).                 02280000
022900         10  HHA-OVERRIDE-IND           PIC X(1).                 02290000
023000         10  HHA-LATE-SUB-PEN-AMT       PIC 9(7)V9(2).            02300000
023100         10  FILLER                     PIC X(188).               02310000
023200                                                                  02320000
023300*******************************************************           02330000
023400*    RETURNED BY HHCAL PROGRAM AND PASSED ON TO MGR   *           02340000
023500*******************************************************           02350000
023600 01  HOLD-VARIABLES-DATA.                                         02360000
023700     02  HOLD-VAR-DATA.                                           02370000
023800         05  PRICER-OPTION-SW              PIC X(01).             02380000
023900         05  HHOPN-VERSION                 PIC X(07).             02390000
024000         05  HHDRV-VERSION                 PIC X(07).             02400000
024100         05  HHCAL-VERSION                 PIC X(07).             02410000
024200         05  FILLER                        PIC X(20).             02420000
024300                                                                  02430000
024400*================================================================*02440000
024500                                                                  02450000
024600 PROCEDURE  DIVISION USING WAGE-INDEX-DATA                        02460000
024700                           MSA-WI-TABLE                           02470000
024800                           CBSA-WAGE-INDEX-DATA                   02480000
024900                           CBSA-WI-TABLE                          02490000
025000                           HRG-TABLE                              02500000
025100                           REVENUE-TABLE                          02510000
025200                           HHA-INPUT-DATA                         02520000
025300                           HOLD-VARIABLES-DATA.                   02530000
025400                                                                  02540000
025500 0000-MAINLINE  SECTION.                                          02550000
025600                                                                  02560000
025700 0100-PROCESS-RECORDS.                                            02570000
025800                                                                  02580000
025900     MOVE DRV-VERSION TO HHDRV-VERSION.                           02590000
026000                                                                  02600000
026100     INITIALIZE      CBSA-WAGE-INDEX-DATA.                        02610000
026200     INITIALIZE      TB-REV-DOLL-RATE-UNITS.                      02620000
026300                                                                  02630000
026400     IF HHA-VALID-TOB-CLAIM                                       02640000
026500     OR HHA-VALID-TOB-RAP                                         02650000
026600        NEXT SENTENCE                                             02660000
026700     ELSE                                                         02670000
026800        MOVE '10' TO HHA-PAY-RTC                                  02680000
026900        GOBACK.                                                   02690000
027000                                                                  02700000
027100     IF HHA-ADMIT-DATE > HHA-SERV-FROM-DATE                       02710000
027200        MOVE '40' TO HHA-PAY-RTC                                  02720000
027300        GOBACK.                                                   02730000
027400                                                                  02740000
027500     COMPUTE HHA-REVENUE-SUM1-6-QTY-ALL =                         02750000
027600             HHA-REVENUE-QTY-COV-VISITS (1) +                     02760000
027700             HHA-REVENUE-QTY-COV-VISITS (2) +                     02770000
027800             HHA-REVENUE-QTY-COV-VISITS (3) +                     02780000
027900             HHA-REVENUE-QTY-COV-VISITS (4) +                     02790000
028000             HHA-REVENUE-QTY-COV-VISITS (5) +                     02800000
028100             HHA-REVENUE-QTY-COV-VISITS (6).                      02810000
028200                                                                  02820000
028300     IF  HHA-VALID-TOB-CLAIM                                      02830000
028400     AND HHA-HRG-INPUT-CODE = SPACE                               02840000
028500         MOVE '70' TO HHA-PAY-RTC                                 02850000
028600         GOBACK.                                                  02860000
028700                                                                  02870000
028800     IF HHA-PAY-RTC NOT = '00'                                    02880000
028900        GOBACK.                                                   02890000
029000                                                                  02900000
029100     IF  ((HHA-VALID-TOB-CLAIM) AND                               02910000
029200         (HHA-REVENUE-CODE (1) = SPACE OR                         02920000
029300          HHA-REVENUE-CODE (2) = SPACE OR                         02930000
029400          HHA-REVENUE-CODE (3) = SPACE OR                         02940000
029500          HHA-REVENUE-CODE (4) = SPACE OR                         02950000
029600          HHA-REVENUE-CODE (5) = SPACE OR                         02960000
029700          HHA-REVENUE-CODE (6) = SPACE))                          02970000
029800         MOVE '85' TO HHA-PAY-RTC.                                02980000
029900                                                                  02990000
030000     IF HHA-PAY-RTC = '00'                                        03000000
030100        NEXT SENTENCE                                             03010000
030200     ELSE                                                         03020000
030300        GOBACK.                                                   03030000
030400                                                                  03040000
030500*================================================================*03050000
030600* -- GET THE CBSA DATA                                           *03060013
030610* -- DO NOT GET THE CBSA FOR A TOB-RAP WITH A                    *03061013
030620*    HHA-SERV-FROM-DATE > '20201231'                             *03062013
030700*================================================================*03070000
030710     IF HHA-VALID-TOB-RAP AND HHA-SERV-FROM-DATE > '20201231'     03071012
030720         NEXT SENTENCE                                            03072002
030730     ELSE                                                         03073002
030800         PERFORM 1250-GET-CBSA THRU 1250-EXIT                     03080002
030900         IF HHA-PAY-RTC = '00'                                    03090002
031000            PERFORM 1260-GET-CBSA-WAGE-INDEX THRU 1260-EXIT       03100002
031100            VARYING MA2 FROM MA1 BY 1 UNTIL                       03110002
031200            T-CBSA (MA2) NOT = HHA-CBSA.                          03120002
031300                                                                  03130000
031400*================================================================*03140000
031500*    GET THE HRG DATA                                            *03150000
031600*================================================================*03160000
031700     IF HHA-PAY-RTC = '00'                                        03170000
031800        PERFORM 2000-GET-HRG THRU 2000-EXIT                       03180000
031900     END-IF.                                                      03190000
032000                                                                  03200000
032100*================================================================*03210000
032200*    GET THE REVENUE DATA                                        *03220000
032300*================================================================*03230000
032400     IF HHA-PAY-RTC = '00'                                        03240000
032500        IF HHA-VALID-TOB-CLAIM                                    03250000
032600           PERFORM 2700-GET-REV THRU 2700-EXIT                    03260000
032700               VARYING SUB1 FROM 1 BY 1 UNTIL                     03270000
032800                SUB1 > 6.                                         03280000
032900                                                                  03290000
033000     IF HHA-PAY-RTC = '00'                                        03300000
033100        NEXT SENTENCE                                             03310000
033200     ELSE                                                         03320000
033300        GOBACK.                                                   03330000
033400                                                                  03340000
033500*================================================================*03350000
033600*    FY 2021 VERSION 3                                           *03360007
033700*================================================================*03370000
033810     IF HHA-SERV-THRU-DATE > 20201231                             03381004
           DISPLAY 'COCOON B HHA-INPUT-DATA '
               FUNCTION HEX-OF(HHA-INPUT-DATA)
           DISPLAY 'COCOON B HOLD-VARIABLES-DATA '
               FUNCTION HEX-OF(HOLD-VARIABLES-DATA)
           DISPLAY 'COCOON B CBSA-WAGE-INDEX-DATA '
               FUNCTION HEX-OF(CBSA-WAGE-INDEX-DATA)
           DISPLAY 'COCOON B TB-REV-DOLL-RATE-UNITS '
               FUNCTION HEX-OF(TB-REV-DOLL-RATE-UNITS)
           DISPLAY 'COCOON B TB-STDV-DATA '
               FUNCTION HEX-OF(TB-STDV-DATA)
           DISPLAY 'COCOON B L-HRG-THRESHOLD '
               FUNCTION HEX-OF(L-HRG-THRESHOLD)
033900        CALL HHCAL213 USING HHA-INPUT-DATA                        03390010
034000                            HOLD-VARIABLES-DATA                   03400000
034100                            CBSA-WAGE-INDEX-DATA                  03410000
034200                            TB-REV-DOLL-RATE-UNITS                03420000
034300                            TB-STDV-DATA                          03430000
034400                            L-HRG-THRESHOLD                       03440000
           DISPLAY 'COCOON A HHA-INPUT-DATA '
               FUNCTION HEX-OF(HHA-INPUT-DATA)
           DISPLAY 'COCOON A HOLD-VARIABLES-DATA '
               FUNCTION HEX-OF(HOLD-VARIABLES-DATA)
           DISPLAY 'COCOON A CBSA-WAGE-INDEX-DATA '
               FUNCTION HEX-OF(CBSA-WAGE-INDEX-DATA)
           DISPLAY 'COCOON A TB-REV-DOLL-RATE-UNITS '
               FUNCTION HEX-OF(TB-REV-DOLL-RATE-UNITS)
           DISPLAY 'COCOON A TB-STDV-DATA '
               FUNCTION HEX-OF(TB-STDV-DATA)
           DISPLAY 'COCOON A L-HRG-THRESHOLD '
               FUNCTION HEX-OF(L-HRG-THRESHOLD)
034500         GOBACK.                                                  03450000
034600*================================================================*03460000
034700*    FY 2020 VERSION 0                                           *03470000
034800*================================================================*03480000
034900     IF HHA-SERV-FROM-DATE > 20191231                             03490000
035000        CALL HHCAL200 USING HHA-INPUT-DATA                        03500000
035100                            HOLD-VARIABLES-DATA                   03510000
035200                            CBSA-WAGE-INDEX-DATA                  03520000
035300                            TB-REV-DOLL-RATE-UNITS                03530000
035400                            TB-STDV-DATA                          03540000
035500                            L-HRG-THRESHOLD                       03550000
035600         GOBACK.                                                  03560000
035700                                                                  03570000
035800*******************************************************           03580000
035900                                                                  03590000
036000     MOVE '40' TO HHA-PAY-RTC.                                    03600000
036100     GOBACK.                                                      03610000
036200                                                                  03620000
036300 0100-EXIT.  EXIT.                                                03630000
036400                                                                  03640000
036500*================================================================*03650000
036600*    GET THE CBSA DATA                                           *03660000
036700*================================================================*03670000
036800 1250-GET-CBSA.                                                   03680000
036900                                                                  03690000
037000     SET MA1 TO 1.                                                03700000
037100                                                                  03710000
037200     SEARCH T-CBSA-DATA VARYING MA1                               03720000
037300            AT END                                                03730000
037400               MOVE '30' TO HHA-PAY-RTC                           03740000
037500               GO TO 1250-EXIT                                    03750000
037600            WHEN T-CBSA (MA1) = HHA-CBSA                          03760000
037700               SET MA2 TO MA1.                                    03770000
037800                                                                  03780000
037900 1250-EXIT.  EXIT.                                                03790000
038000                                                                  03800000
038100*================================================================*03810000
038200*    GET THE CBSA WAGE INDEX                                     *03820000
038300*    SERV-THRU-DATA (CCYY) = CBSA-EFFECTIVE-DATE (CCYY)          *03830000
038400*================================================================*03840000
038500 1260-GET-CBSA-WAGE-INDEX.                                        03850000
038600                                                                  03860000
038700     IF HHA-VALID-TOB-CLAIM OR HHA-VALID-TOB-RAP                  03870000
038800       IF HHA-SERV-THRU-DATE (1:4) = T-CBSA-EFFDATE (MA2) (1:4)   03880000
038900         IF HHA-SERV-THRU-DATE NOT < T-CBSA-EFFDATE (MA2)         03890000
039000            MOVE T-CBSA       (MA2) TO WIR-CBSA                   03900000
039100            MOVE T-CBSA-EFFDATE (MA2) TO WIR-CBSA-EFFDATE         03910000
039200            MOVE T-CBSA-WAGEIND (MA2) TO WIR-CBSA-WAGEIND         03920000
039300            MOVE '00' TO HHA-PAY-RTC                              03930000
039400            GO TO 1260-EXIT.                                      03940000
039500                                                                  03950000
039600     IF WIR-CBSA-WAGEIND NOT NUMERIC                              03960000
039700           MOVE '30' TO HHA-PAY-RTC.                              03970000
039800                                                                  03980000
039900 1260-EXIT.  EXIT.                                                03990000
040000                                                                  04000000
040100*================================================================*04010000
040200*    GET THE HRG DATA                                            *04020000
040300*================================================================*04030000
040400 2000-GET-HRG.                                                    04040000
040500                                                                  04050000
040600     SET HU1 TO 1.                                                04060000
040700     SEARCH TB-HRG-DATA VARYING HU1                               04070000
040800            AT END                                                04080000
040900               MOVE '70' TO HHA-PAY-RTC                           04090000
041000            WHEN TB-HRG (HU1) = HHA-HRG-INPUT-CODE                04100000
041100               MOVE TB-HRG-WGTS (HU1) TO HHA-HRG-WGTS             04110000
041200               MOVE TB-HRG-THRESHOLD (HU1)                        04120000
041300                                     TO L-HRG-THRESHOLD           04130000
041400     END-SEARCH.                                                  04140000
041500                                                                  04150000
041600 2000-EXIT.  EXIT.                                                04160000
041700                                                                  04170000
041800*================================================================*04180000
041900*    GET THE REVENUE DATA                                        *04190000
042000*================================================================*04200000
042100 2700-GET-REV.                                                    04210000
042200                                                                  04220000
042300     IF HHA-REVENUE-CODE (SUB1) = SPACES                          04230000
042400        MOVE 6 TO SUB1                                            04240000
042500        GO TO 2700-EXIT.                                          04250000
042600                                                                  04260000
042700     SET RU1 TO 1.                                                04270000
042800     SEARCH M-REV-DATA VARYING RU1                                04280000
042900            AT END                                                04290000
043000               MOVE '80' TO HHA-PAY-RTC                           04300000
043100               MOVE 6 TO SUB1                                     04310000
043200               GO TO 2700-EXIT                                    04320000
043300            WHEN TB-REV-CODE (RU1) = HHA-REVENUE-CODE (SUB1)      04330000
043400               SET RU2 TO RU1                                     04340000
043500               PERFORM 2750-GET-REV-DOLLARS THRU 2750-EXIT.       04350000
043600                                                                  04360000
043700 2700-EXIT.  EXIT.                                                04370000
043800                                                                  04380000
043900 2750-GET-REV-DOLLARS.                                            04390000
044000                                                                  04400000
044100      PERFORM 2800-GET-REV-SEARCH THRU 2800-EXIT                  04410000
044200           VARYING RU2 FROM RU1 BY 1 UNTIL                        04420000
044300           TB-REV-CODE (RU2) NOT = HHA-REVENUE-CODE (SUB1).       04430000
044400                                                                  04440000
044500 2750-EXIT.   EXIT.                                               04450000
044600                                                                  04460000
044700 2800-GET-REV-SEARCH.                                             04470000
044800                                                                  04480000
044900     IF HHA-SERV-THRU-DATE NOT < TB-REV-EFFDATE (RU2)             04490000
045000         MOVE TB-REV-CODE             (RU2) TO                    04500000
045100              TB-STDV-REV-CODE      (SUB1)                        04510000
045200         MOVE TB-REV-DOLL-RATE-NRURAL (RU2) TO                    04520000
045300              TB-STDV-REV-DOLL-RATE (SUB1)                        04530000
045400         MOVE TB-REV-DOLL-RATE-NRURAL (RU2) TO                    04540000
045500              HHA-REVENUE-DOLL-RATE (SUB1)                        04550000
045600         MOVE TB-REV-UDOLL-RATE-NRURAL (RU2) TO                   04560000
045700              WK-REV-DOLL-RATE-UNITS (SUB1)                       04570000
045800     ELSE                                                         04580000
045900         GO TO 2800-EXIT.                                         04590000
046000                                                                  04600000
046100     IF HHA-CBSA-RURAL-CHECK                                      04610000
046200     OR HHA-CBSA-RURAL-CHECK-ALL                                  04620000
046300        MOVE TB-REV-CODE             (RU2) TO                     04630000
046400             TB-STDV-REV-CODE      (SUB1)                         04640000
046500        MOVE TB-REV-DOLL-RATE-NRURAL (RU2) TO                     04650000
046600             TB-STDV-REV-DOLL-RATE  (SUB1)                        04660000
046700        IF HHA-WITH-DATA-CHECK                                    04670000
046800            MOVE TB-REV-DOLL-RATE-RURAL (RU2) TO                  04680000
046900                 HHA-REVENUE-DOLL-RATE (SUB1)                     04690000
047000            MOVE TB-REV-UDOLL-RATE-RURAL (RU2) TO                 04700000
047100              WK-REV-DOLL-RATE-UNITS (SUB1)                       04710000
047200        ELSE                                                      04720000
047300            MOVE TB-DOLL-RATE-RURAL-NOSUBMIT (RU2) TO             04730000
047400                 HHA-REVENUE-DOLL-RATE (SUB1)                     04740000
047500            MOVE TB-UDOLL-RATE-RURAL-NOSUBMIT (RU2) TO            04750000
047600              WK-REV-DOLL-RATE-UNITS (SUB1)                       04760000
047700        END-IF                                                    04770000
047800     ELSE                                                         04780000
047900        MOVE TB-REV-CODE             (RU2) TO                     04790000
048000             TB-STDV-REV-CODE      (SUB1)                         04800000
048100        MOVE TB-REV-DOLL-RATE-NRURAL (RU2) TO                     04810000
048200             TB-STDV-REV-DOLL-RATE  (SUB1)                        04820000
048300        IF HHA-WITH-DATA-CHECK                                    04830000
048400           MOVE TB-REV-DOLL-RATE-NRURAL (RU2) TO                  04840000
048500                HHA-REVENUE-DOLL-RATE (SUB1)                      04850000
048600           MOVE TB-REV-UDOLL-RATE-NRURAL (RU2) TO                 04860000
048700              WK-REV-DOLL-RATE-UNITS (SUB1)                       04870000
048800        ELSE                                                      04880000
048900            MOVE TB-DOLL-RATE-NRURAL-NOSUBMIT (RU2) TO            04890000
049000                 HHA-REVENUE-DOLL-RATE (SUB1)                     04900000
049100            MOVE TB-UDOLL-RATE-NRURAL-NOSUBMIT (RU2) TO           04910000
049200              WK-REV-DOLL-RATE-UNITS (SUB1)                       04920000
049300        END-IF                                                    04930000
049400     END-IF.                                                      04940000
049500                                                                  04950000
049600 2800-EXIT.  EXIT.                                                04960000
