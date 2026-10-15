000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID.     LTCAL111.                                        00020000
000400*REMARKS.        CMS.                                             00040000
000500*                EFFECTIVE OCTOBER 1, 2010.                       00050000
000600 DATE-COMPILED.                                                   00060000
000700 ENVIRONMENT DIVISION.                                            00070000
000800 CONFIGURATION SECTION.                                           00080000
000900 SOURCE-COMPUTER.            IBM-370.                             00090000
001000 OBJECT-COMPUTER.            IBM-370.                             00100000
001100 INPUT-OUTPUT  SECTION.                                           00110000
001200 FILE-CONTROL.                                                    00120000
001300                                                                  00130000
001400 DATA DIVISION.                                                   00140000
001500 FILE SECTION.                                                    00150000
001600                                                                  00160000
001700 WORKING-STORAGE SECTION.                                         00170000
001800 01  W-STORAGE-REF                  PIC X(46)  VALUE              00180000
001900     'LTCAL111      - W O R K I N G   S T O R A G E'.             00190000
002000 01  CAL-VERSION                    PIC X(05)  VALUE 'V11.1'.     00200000
002100 01  PROGRAM-CONSTANTS.                                           00210000
002200     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.     00220000
002300     05  FED-FY-BEGIN-04            PIC 9(08) VALUE 20031001.     00230000
002400     05  FED-FY-BEGIN-05            PIC 9(08) VALUE 20041001.     00240000
002500     05  FED-FY-BEGIN-06            PIC 9(08) VALUE 20051001.     00250000
002600     05  FED-FY-BEGIN-07            PIC 9(08) VALUE 20061001.     00260000
002700                                                                  00270000
002800                                                                  00280000
002900***************************************************************   00290000
003000*    LAYUP TABLE AREA FOR FY2011 LTC-DRG                      *   00300000
003100*    EFFECTIVE DATE OF OCTOBER 1, 2010                        *   00310000
003200***************************************************************   00320000
003300 COPY LTDRG110.                                                   00330000
003400                                                                  00340000
003500                                                                  00350000
003600***************************************************************   00360000
003700*    LAYUP TABLE AREA FOR FY2011 IPPS-DRG                     *   00370000
003800*    EFFECTIVE DATE OF OCTOBER 1, 2010                        *   00380000
003900***************************************************************   00390000
004000 COPY IPDRG110.                                                   00400000
004100                                                                  00410000
004200                                                                  00420000
004300***************************************************************   00430000
004400*    LAYUP TABLE AREA FOR FY2011 IPPS STATE SPECIFIC RFBNS    *   00440000
004500*    EFFECTIVE DATE OF OCTOBER 1, 2010 - NO TBL FOR FY 2011   *   00450000
004600***************************************************************   00460000
004700*COPY IRFBN***.                                                   00470000
004800                                                                  00480000
004900                                                                  00490000
005000***************************************************************   00500000
005100*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *   00510000
005200***************************************************************   00520000
005300 01  HOLD-PPS-COMPONENTS.                                         00530000
005400     05  H-LOS                        PIC 9(03).                  00540000
005500     05  H-REG-DAYS                   PIC 9(03).                  00550000
005600     05  H-TOTAL-DAYS                 PIC 9(05).                  00560000
005700     05  H-SSOT                       PIC 9(02)V9(01).            00570000
005800     05  H-BLEND-RTC                  PIC 9(02).                  00580000
005900     05  H-BLEND-FAC                  PIC 9(01)V9(01).            00590000
006000     05  H-BLEND-PPS                  PIC 9(01)V9(01).            00600000
006100     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).            00610000
006200     05  H-SS-COST                    PIC 9(07)V9(02).            00620000
006300     05  H-LABOR-PORTION              PIC 9(07)V9(06).            00630000
006400     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).            00640000
006500     05  H-FIXED-LOSS-AMT             PIC 9(07)V9(02).            00650000
006600     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).            00660000
006700     05  H-LOS-RATIO                  PIC 9(01)V9(05).            00670000
006800                                                                  00680000
006900*** --------------------------------------------------- ***       00690000
007000*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***       00700000
007100*** --------------------------------------------------- ***       00710000
007200     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).            00720000
007300     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).            00730000
007400     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).            00740000
007500     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).            00750000
007600     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).            00760000
007700     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).            00770000
007800     05  H-INTERN-RATIO               PIC 9(01)V9(04).            00780000
007900     05  H-CAPI-IME-RATIO             PIC 9V9999.                 00790000
008000     05  H-BED-SIZE                   PIC 9(05).                  00800000
008100     05  H-OPER-DSH-PCT               PIC V9(04).                 00810000
008200     05  H-SSI-RATIO                  PIC V9(04).                 00820000
008300     05  H-MEDICAID-RATIO             PIC V9(04).                 00830000
008400     05  H-OPER-DSH                   PIC 9(01)V9(04).            00840000
008500     05  H-CAPI-DSH                   PIC 9(01)V9(04).            00850000
008600     05  H-GEO-CLASS                  PIC X(01).                  00860000
008700     05  H-URBAN-IND                  PIC X(01).                  00870000
008800           88 URBAN-CBSA           VALUE '1'.                     00880000
008900           88 RURAL-CBSA           VALUE '0'.                     00890000
009000     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).            00900000
009100     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).            00910000
009200     05  H-CAPI-PMT                   PIC 9(07)V9(02).            00920000
009300     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).            00930000
009400     05  H-CAPI-GAF                   PIC 9(05)V9(04).            00940000
009500     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).            00950000
009600     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).            00960000
009700     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).            00970000
009800     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).            00980000
009900     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).            00990000
010000     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).            01000000
010100     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).            01010000
010200     05  H-OPER-COLA                  PIC 9(01)V9(03).            01020000
010300     05  H-CAPI-COLA                  PIC 9(01)V9(03).            01030000
010400     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).            01040000
010500     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).            01050000
010600     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).            01060000
010700     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).            01070000
010800     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).            01080000
010900     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).            01090000
011000     05  H-IPPS-DAYS-CUTOFF           PIC 9(02).                  01100000
011100     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).            01110000
011200     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).            01120000
011300     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).            01130000
011400     05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).            01140000
011500     05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).            01150000
011600     05  H-COUNTER                    PIC 9(02).                  01160000
011700     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).            01170000
011800                                                                  01180000
011900*** --------------------------------------------------- ***       01190000
012000*** VARIABLES FOR PC PRICER                             ***       01200000
012100*** --------------------------------------------------- ***       01210000
012200     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).            01220000
012300     05  H-SS-COST-IND                PIC X.                      01230000
012400     05  H-SS-PERDIEM-IND             PIC X.                      01240000
012500     05  H-SS-BLEND-IND               PIC X.                      01250000
012600     05  H-SS-IPPSCOMP-IND            PIC X.                      01260000
012700                                                                  01270000
012800                                                                  01280000
012900                                                                  01290000
013000                                                                  01300000
013100 LINKAGE SECTION.                                                 01310000
013200**************************************************************    01320000
013300*      THIS IS THE BILL-RECORD THAT WILL BE PASSED FROM      *    01330000
013400*      THE LTDRV___ PROGRAM                                  *    01340000
013500**************************************************************    01350000
013600 01  BILL-NEW-DATA.                                               01360000
013700     10  B-NPI10.                                                 01370000
013800         15  B-NPI8             PIC X(08).                        01380000
013900         15  B-NPI-FILLER       PIC X(02).                        01390000
014000     10  B-PROVIDER-NO          PIC X(06).                        01400000
014100     10  B-PATIENT-STATUS       PIC X(02).                        01410000
014200     10  B-DRG-CODE             PIC 9(03).                        01420000
014300     10  B-LOS                  PIC 9(03).                        01430000
014400     10  B-COV-DAYS             PIC 9(03).                        01440000
014500     10  B-LTR-DAYS             PIC 9(02).                        01450000
014600     10  B-DISCHARGE-DATE.                                        01460000
014700         15  B-DISCHG-CC        PIC 9(02).                        01470000
014800         15  B-DISCHG-YY        PIC 9(02).                        01480000
014900         15  B-DISCHG-MM        PIC 9(02).                        01490000
015000         15  B-DISCHG-DD        PIC 9(02).                        01500000
015100     10  B-COV-CHARGES          PIC 9(07)V9(02).                  01510000
015200     10  B-SPEC-PAY-IND         PIC X(01).                        01520000
015300     10  FILLER                 PIC X(13).                        01530000
015400                                                                  01540000
015500                                                                  01550000
015600***************************************************************   01560000
015700***************************************************************   01570000
015800*                                                             *   01580000
015900*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *   01590000
016000*    AND PASSED BACK TO THE CALLING PROGRAM                   *   01600000
016100*    RETURN CODE VALUES (PPS-RTC)                             *   01610000
016200*                                                             *   01620000
016300*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *   01630000
016400*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *   01640000
016500*                                                             *   01650000
016600*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *   01660000
016700*                                                             *   01670000
016800*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   01680000
016900*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   01690000
017000*                                                             *   01700000
017100*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   01710000
017200*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *   01720000
017300*                                                             *   01730000
017400*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   01740000
017500*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *   01750000
017600*                                                             *   01760000
017700*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   01770000
017800*                  20% SHORT STAY PAYMENT WITH OUTLIER        *   01780000
017900*                                                             *   01790000
018000*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   01800000
018100*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   01810000
018200*                                                             *   01820000
018300*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   01830000
018400*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *   01840000
018500*                                                             *   01850000
018600*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   01860000
018700*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *   01870000
018800*                                                             *   01880000
018900*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   01890000
019000*                  40% SHORT STAY PAYMENT WITH OUTLIER        *   01900000
019100*                                                             *   01910000
019200*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   01920000
019300*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   01930000
019400*                                                             *   01940000
019500*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   01950000
019600*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *   01960000
019700*                                                             *   01970000
019800*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   01980000
019900*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *   01990000
020000*                                                             *   02000000
020100*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   02010000
020200*                  60% SHORT STAY PAYMENT WITH OUTLIER        *   02020000
020300*                                                             *   02030000
020400*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   02040000
020500*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   02050000
020600*                                                             *   02060000
020700*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   02070000
020800*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *   02080000
020900*                                                             *   02090000
021000*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   02100000
021100*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *   02110000
021200*                                                             *   02120000
021300*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   02130000
021400*                  80% SHORT STAY PAYMENT WITH OUTLIER        *   02140000
021500*                                                             *   02150000
021600*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *   02160000
021700*                  WITHOUT OUTLIER                            *   02170000
021800*                                                             *   02180000
021900*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *   02190000
022000*                  DIEM WITHOUT OUTLIER                       *   02200000
022100*                                                             *   02210000
022200*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *   02220000
022300*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *   02230000
022400*                  AMOUNT WITHOUT OUTLIER                     *   02240000
022500*                                                             *   02250000
022600*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *   02260000
022700*                  DIEM WITH OUTLIER                          *   02270000
022800*                                                             *   02280000
022900*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *   02290000
023000*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *   02300000
023100*                  AMOUNT WITH OUTLIER                        *   02310000
023200*                                                             *   02320000
023300*                                                             *   02330000
023400*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *   02340000
023500*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *   02350000
023600*            FOR IPPS COMPARABLE PER DIEM)                    *   02360000
023700*                                                             *   02370000
023800*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *   02380000
023900*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *   02390000
024000*                                                             *   02400000
024100*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *   02410000
024200*                  COMPARABLE THRESHOLD WITH OUTLIER          *   02420000
024300*                                                             *   02430000
024400*                                                             *   02440000
024500*                                                             *   02450000
024600*      ****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *   02460000
024700*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *   02470000
024800*             51 = PROVIDER RECORD TERMINATED                 *   02480000
024900*             52 = INVALID WAGE INDEX                         *   02490000
025000*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *   02500000
025100*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *   02510000
025200*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *   02520000
025300*                                     OR                      *   02530000
025400*                  DISCHARGE DATE < CBSA EFF START DATE       *   02540000
025500*                  FOR PPS                                    *   02550000
025600*             56 = INVALID LENGTH OF STAY                     *   02560000
025700*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *   02570000
025800*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *   02580000
025900*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *   02590000
026000*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *   02600000
026100*                  OR BILL-LTR-DAYS > 60                      *   02610000
026200*             62 = INVALID NUMBER OF COVERED DAYS             *   02620000
026300*                  OR BILL-LTR-DAYS > COVERED DAYS            *   02630000
026400*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *   02640000
026500*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *   02650000
026600*                  OR COST OUTLIER THRESHOLD CALCULATION      *   02660000
026700*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *   02670000
026800*             72 = INVALID BLEND INDICATOR (NOT 1 THRU 5)     *   02680000
026900*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *   02690000
027000*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *   02700000
027100*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *   02710000
027200*                                                             *   02720000
027300***************************************************************   02730000
027400***************************************************************   02740000
027500                                                                  02750000
027600                                                                  02760000
027700***************************************************************   02770000
027800* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *   02780000
027900* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *   02790000
028000***************************************************************   02800000
028100 01  PPS-DATA-ALL.                                                02810000
028200     05  PPS-RTC                       PIC 9(02).                 02820000
028300     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).           02830000
028400     05  PPS-DATA.                                                02840000
028500         10  PPS-MSA                   PIC X(04).                 02850000
028600         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).           02860000
028700         10  PPS-AVG-LOS               PIC 9(02)V9(01).           02870000
028800         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).           02880000
028900         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).           02890000
029000         10  PPS-LOS                   PIC 9(03).                 02900000
029100         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).           02910000
029200         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).           02920000
029300         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).           02930000
029400         10  PPS-FAC-COSTS             PIC 9(07)V9(02).           02940000
029500         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).           02950000
029600         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).           02960000
029700         10  PPS-SUBM-DRG-CODE         PIC X(03).                 02970000
029800         10  PPS-CALC-VERS-CD          PIC X(05).                 02980000
029900         10  PPS-REG-DAYS-USED         PIC 9(03).                 02990000
030000         10  PPS-LTR-DAYS-USED         PIC 9(03).                 03000000
030100         10  PPS-BLEND-YEAR            PIC 9(01).                 03010000
030200         10  PPS-COLA                  PIC 9(01)V9(03).           03020000
030300         10  FILLER                    PIC X(04).                 03030000
030400     05  PPS-OTHER-DATA.                                          03040000
030500         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).           03050000
030600         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).           03060000
030700         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).           03070000
030800         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).           03080000
030900*        10  PPS-IPTHRESH              PIC 9(03)V9(01).           03090000
031000         10  FILLER                    PIC X(16).                 03100000
031100     05  PPS-PC-DATA.                                             03110000
031200         10  PPS-COT-IND               PIC X(01).                 03120000
031300         10  H-PC-IND                  PIC X(02).                 03130000
031400               88  PC-PRICER               VALUE 'PC'.            03140000
031500         10  FILLER                    PIC X(18).                 03150000
031600                                                                  03160000
031700 01 PPS-CBSA                           PIC X(05).                 03170000
031800                                                                  03180000
031900                                                                  03190000
032000******************************************************************03200000
032100*            THESE ARE THE VERSIONS OF THE LTDRV___              *03210000
032200*           PROGRAMS THAT WILL BE PASSED BACK----                *03220000
032300*          ASSOCIATED WITH THE BILL BEING PROCESSED              *03230000
032400******************************************************************03240000
032500 01  PRICER-OPT-VERS-SW.                                          03250000
032600     05  PRICER-OPTION-SW          PIC X(01).                     03260000
032700         88  ALL-TABLES-PASSED          VALUE 'A'.                03270000
032800         88  PROV-RECORD-PASSED         VALUE 'P'.                03280000
032900     05  PPS-VERSIONS.                                            03290000
033000         10  PPDRV-VERSION         PIC X(05).                     03300000
033100                                                                  03310000
033200                                                                  03320000
033300**************************************************************    03330000
033400*      THIS IS THE PROV-RECORD THAT WILL BE PASSED BY        *    03340000
033500*      THE LTCAL___ PROGRAM (FROM PROGRAM LTDRV___)          *    03350000
033600**************************************************************    03360000
033700 01  PROV-NEW-HOLD.                                               03370000
033800     02  PROV-NEWREC-HOLD1.                                       03380000
033900         05  P-NEW-NPI10.                                         03390000
034000             10  P-NEW-NPI8             PIC X(08).                03400000
034100             10  P-NEW-NPI-FILLER       PIC X(02).                03410000
034200         05  P-NEW-PROVIDER-NO.                                   03420000
034300             10  P-NEW-STATE            PIC 9(02).                03430000
034400             10  FILLER                 PIC X(04).                03440000
034500         05  P-NEW-DATE-DATA.                                     03450000
034600             10  P-NEW-EFF-DATE.                                  03460000
034700                 15  P-NEW-EFF-DT-CC    PIC 9(02).                03470000
034800                 15  P-NEW-EFF-DT-YY    PIC 9(02).                03480000
034900                 15  P-NEW-EFF-DT-MM    PIC 9(02).                03490000
035000                 15  P-NEW-EFF-DT-DD    PIC 9(02).                03500000
035100             10  P-NEW-FY-BEGIN-DATE.                             03510000
035200                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).                03520000
035300                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).                03530000
035400                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).                03540000
035500                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).                03550000
035600             10  P-NEW-REPORT-DATE.                               03560000
035700                 15  P-NEW-REPORT-DT-CC PIC 9(02).                03570000
035800                 15  P-NEW-REPORT-DT-YY PIC 9(02).                03580000
035900                 15  P-NEW-REPORT-DT-MM PIC 9(02).                03590000
036000                 15  P-NEW-REPORT-DT-DD PIC 9(02).                03600000
036100             10  P-NEW-TERMINATION-DATE.                          03610000
036200                 15  P-NEW-TERM-DT-CC   PIC 9(02).                03620000
036300                 15  P-NEW-TERM-DT-YY   PIC 9(02).                03630000
036400                 15  P-NEW-TERM-DT-MM   PIC 9(02).                03640000
036500                 15  P-NEW-TERM-DT-DD   PIC 9(02).                03650000
036600         05  P-NEW-WAIVER-CODE          PIC X(01).                03660000
036700             88  P-NEW-WAIVER-STATE       VALUE 'Y'.              03670000
036800         05  P-NEW-INTER-NO             PIC 9(05).                03680000
036900         05  P-NEW-PROVIDER-TYPE        PIC X(02).                03690000
037000         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).                03700000
037100         05  P-NEW-CURRENT-DIV   REDEFINES                        03710000
037200                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).         03720000
037300         05  P-NEW-MSA-DATA.                                      03730000
037400             10  P-NEW-CHG-CODE-INDEX       PIC X.                03740000
037500             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT. 03750000
037600             10  P-NEW-GEO-LOC-MSA9   REDEFINES                   03760000
037700                             P-NEW-GEO-LOC-MSAX  PIC 9(04).       03770000
037800             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT. 03780000
037900             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT. 03790000
038000             10  P-NEW-STAND-AMT-LOC-MSA9                         03800000
038100                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.               03810000
038200                 15  P-NEW-RURAL-1ST.                             03820000
038300                     20  P-NEW-STAND-RURAL  PIC XX.               03830000
038400                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.    03840000
038500                 15  P-NEW-RURAL-2ND        PIC XX.               03850000
038600         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.                    03860000
038700         05  P-NEW-LUGAR                    PIC X.                03870000
038800         05  P-NEW-TEMP-RELIEF-IND          PIC X.                03880000
038900         05  P-NEW-FED-PPS-BLEND-IND        PIC X.                03890000
039000         05  FILLER                         PIC X(05).            03900000
039100     02  PROV-NEWREC-HOLD2.                                       03910000
039200         05  P-NEW-VARIABLES.                                     03920000
039300             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).        03930000
039400             10  P-NEW-COLA              PIC  9(01)V9(03).        03940000
039500             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).        03950000
039600             10  P-NEW-BED-SIZE          PIC  9(05).              03960000
039700             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).        03970000
039800             10  P-NEW-CMI               PIC  9(01)V9(04).        03980000
039900             10  P-NEW-SSI-RATIO         PIC  V9(04).             03990000
040000             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).             04000000
040100             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).              04010000
040200             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).        04020000
040300             10  P-NEW-DSH-PERCENT       PIC  V9(04).             04030000
040400             10  P-NEW-FYE-DATE          PIC  X(08).              04040000
040500         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).             04050000
040600         05  FILLER                        PIC X(01).             04060000
040700         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.  04070000
040800         05  P-NEW-GEO-LOC-CBSA9 REDEFINES                        04080000
040900                       P-NEW-GEO-LOC-CBSAX PIC 9(05).             04090000
041000         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES                     04100000
041100                       P-NEW-GEO-LOC-CBSAX.                       04110000
041200             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.                 04120000
041300             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.                 04130000
041400             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.                 04140000
041500             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.                 04150000
041600             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.                 04160000
041700         05  FILLER                        PIC X(10).             04170000
041800         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).       04180000
041900     02  PROV-NEWREC-HOLD3.                                       04190000
042000         05  P-NEW-PASS-AMT-DATA.                                 04200000
042100             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.          04210000
042200             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.          04220000
042300             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.          04230000
042400             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.          04240000
042500         05  P-NEW-CAPI-DATA.                                     04250000
042600             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.                 04260000
042700             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.          04270000
042800             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.          04280000
042900             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.        04290000
043000             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.             04300000
043100             15  P-NEW-CAPI-NEW-HOSP       PIC X.                 04310000
043200             15  P-NEW-CAPI-IME            PIC 9V9999.            04320000
043300             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.          04330000
043400             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.             04340000
043500         05  FILLER                        PIC X(18).             04350000
043600                                                                  04360000
043700                                                                  04370000
043800******************************************************************04380000
043900*                THIS IS THE LTCH WAGE-INDEX                     *04390000
044000*          ASSOCIATED WITH THE BILL BEING PROCESSED              *04400000
044100*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *04410000
044200******************************************************************04420000
044300 01  WAGE-NEW-INDEX-RECORD.                                       04430000
044400     05  W-CBSA                        PIC X(5).                  04440000
044500     05  W-EFF-DATE                    PIC X(8).                  04450000
044600     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).          04460000
044700     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).          04470000
044800     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).          04480000
044900                                                                  04490000
045000                                                                  04500000
045100******************************************************************04510000
045200*                THIS IS THE IPPS WAGE-INDEX                     *04520000
045300*          ASSOCIATED WITH THE BILL BEING PROCESSED              *04530000
045400******************************************************************04540000
045500 01  WAGE-NEW-IPPS-INDEX-RECORD.                                  04550000
045600     05  W-CBSA-IPPS.                                             04560000
045700         10 CBSA-IPPS-123              PIC X(3).                  04570000
045800         10 CBSA-IPPS-45               PIC X(2).                  04580000
045900     05  W-CBSA-IPPS-SIZE              PIC X.                     04590000
046000         88  LARGE-URBAN       VALUE 'L'.                         04600000
046100         88  OTHER-URBAN       VALUE 'O'.                         04610000
046200         88  ALL-RURAL         VALUE 'R'.                         04620000
046300     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).                  04630000
046400     05  FILLER                        PIC X.                     04640000
046500     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).          04650000
046600     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).          04660000
046700                                                                  04670000
046800                                                                  04680000
046900                                                                  04690000
047000 PROCEDURE DIVISION  USING BILL-NEW-DATA                          04700000
047100                           PPS-DATA-ALL                           04710000
047200                           PPS-CBSA                               04720000
047300                           PRICER-OPT-VERS-SW                     04730000
047400                           PROV-NEW-HOLD                          04740000
047500                           WAGE-NEW-INDEX-RECORD                  04750000
047600                           WAGE-NEW-IPPS-INDEX-RECORD.            04760000
047700                                                                  04770000
047800                                                                  04780000
047900***************************************************************   04790000
048000*                                                             *   04800000
048100*    PROCESSING:                                              *   04810000
048200*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *   04820000
048300*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *   04830000
048400*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *   04840000
048500*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *   04850000
048600*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *   04860000
048700*           GOBACK.                                           *   04870000
048800*        D. ASSEMBLE PRICING COMPONENTS.                      *   04880000
048900*        E. CALCULATE THE PRICE.                              *   04890000
049000*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *   04900000
049100*                                                             *   04910000
049200***************************************************************   04920000
049300                                                                  04930000
049400                                                                  04940000
049500***************************************************************   04950000
049600 0000-MAINLINE-CONTROL.                                           04960000
049700***************************************************************   04970000
049800                                                                  04980000
049900     PERFORM 0100-INITIAL-ROUTINE                                 04990000
050000        THRU 0100-EXIT.                                           05000000
050100                                                                  05010000
050200     PERFORM 1000-EDIT-THE-BILL-INFO                              05020000
050300        THRU 1000-EXIT.                                           05030000
050400                                                                  05040000
050500     IF PPS-RTC = 00                                              05050000
050600        PERFORM 1700-EDIT-DRG-CODE                                05060000
050700           THRU 1700-EXIT.                                        05070000
050800                                                                  05080000
050900     IF PPS-RTC = 00                                              05090000
051000        PERFORM 1800-EDIT-IPPS-DRG-CODE                           05100000
051100           THRU 1800-EXIT                                         05110000
051200           VARYING DX5 FROM 1 BY 1 UNTIL DX5 > 1.                 05120000
051300                                                                  05130000
051400     IF PPS-RTC = 00                                              05140000
051500        PERFORM 2000-ASSEMBLE-PPS-VARIABLES                       05150000
051600           THRU 2000-EXIT.                                        05160000
051700                                                                  05170000
051800     IF PPS-RTC = 00                                              05180000
051900        PERFORM 3000-CALC-PAYMENT                                 05190000
052000           THRU 3000-EXIT                                         05200000
052100        PERFORM 7000-CALC-OUTLIER                                 05210000
052200           THRU 7000-EXIT.                                        05220000
052300                                                                  05230000
052400     IF PPS-RTC < 50                                              05240000
052500        PERFORM 8000-BLEND                                        05250000
052600           THRU 8000-EXIT.                                        05260000
052700                                                                  05270000
052800     PERFORM 9000-MOVE-RESULTS                                    05280000
052900        THRU 9000-EXIT.                                           05290000
053000                                                                  05300000
053100     GOBACK.                                                      05310000
053200                                                                  05320000
053300                                                                  05330000
053400***************************************************************   05340000
053500 0100-INITIAL-ROUTINE.                                            05350000
053600***************************************************************   05360000
053700                                                                  05370000
053800     MOVE ZEROS TO PPS-RTC.                                       05380000
053900     INITIALIZE PPS-DATA.                                         05390000
054000     INITIALIZE PPS-OTHER-DATA.                                   05400000
054100     INITIALIZE PPS-CBSA.                                         05410000
054200     INITIALIZE HOLD-PPS-COMPONENTS.                              05420000
054300                                                                  05430000
054400     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.                        05440000
054500                                                                  05450000
054600*** -----------------------------------------------------***      05460000
054700*** ADJUST IPPS WAGE INDEX BY THE STATE SPECIFIC RFBN    ***      05470000
054800*** -----------------------------------------------------***      05480000
054900     PERFORM 1900-APPLY-SSRFBN                                    05490000
055000        THRU 1900-EXIT.                                           05500000
055100                                                                  05510000
055200     IF PPS-RTC NOT = 00                                          05520000
055300        GO TO 0100-EXIT                                           05530000
055400     END-IF.                                                      05540000
055500                                                                  05550000
055600*** ---------------------------------------------------- ***      05560000
055700*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***      05570000
055800*** ---------------------------------------------------- ***      05580000
055900     MOVE .75271   TO PPS-NAT-LABOR-PCT.                          05590000
056000     MOVE .24729   TO PPS-NAT-NONLABOR-PCT.                       05600000
056100     MOVE 39599.95 TO PPS-STD-FED-RATE.                           05610000
056200     MOVE 18785.00 TO H-FIXED-LOSS-AMT.                           05620000
056300     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.                         05630000
056400                                                                  05640000
056500*** ---------------------------------------------------- ***      05650000
056600*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***      05660000
056700*** ---------------------------------------------------- ***      05670000
056800     MOVE 420.01 TO H-IPPS-CAPI-STD-FED-RATE.                     05680000
056900     MOVE 197.66 TO H-IPPS-CAPI-STD-PR-RATE.                      05690000
057000     MOVE 0.75   TO H-NAT-IPPS-PMT-PCT.                           05700000
057100     MOVE 0.25   TO H-PR-IPPS-PMT-PCT.                            05710000
057200                                                                  05720000
057300     IF H-IPPS-WAGE-INDEX > 1                                     05730000
057400        MOVE 3552.91 TO H-IPPS-NAT-LABOR-SHR                      05740000
057500        MOVE 1611.20 TO H-IPPS-NAT-NONLABOR-SHR                   05750000
057600     ELSE                                                         05760000
057700        MOVE 3201.75 TO H-IPPS-NAT-LABOR-SHR                      05770000
057800        MOVE 1962.36 TO H-IPPS-NAT-NONLABOR-SHR                   05780000
057900     END-IF.                                                      05790000
058000                                                                  05800000
058100     IF W-IPPS-PR-WAGE-INDEX > 1                                  05810000
058200        MOVE 1518.14 TO H-IPPS-PR-LABOR-SHR                       05820000
058300        MOVE  926.53 TO H-IPPS-PR-NONLABOR-SHR                    05830000
058400     ELSE                                                         05840000
058500        MOVE 1515.70 TO H-IPPS-PR-LABOR-SHR                       05850000
058600        MOVE  928.97 TO H-IPPS-PR-NONLABOR-SHR                    05860000
058700     END-IF.                                                      05870000
058800                                                                  05880000
058900                                                                  05890000
059000 0100-EXIT.                                                       05900000
059100      EXIT.                                                       05910000
059200                                                                  05920000
059300                                                                  05930000
059400***************************************************************   05940000
059500*    BILL DATA EDITS - IF ANY FAIL SET PPS-RTC                *   05950000
059600*    AND DO NOT ATTEMPT TO PRICE.                             *   05960000
059700***************************************************************   05970000
059800 1000-EDIT-THE-BILL-INFO.                                         05980000
059900***************************************************************   05990000
060000                                                                  06000000
060100     IF (B-LOS NUMERIC) AND (B-LOS > 0)                           06010000
060200        MOVE B-LOS TO H-LOS                                       06020000
060300     ELSE                                                         06030000
060400        MOVE 56 TO PPS-RTC.                                       06040000
060500                                                                  06050000
060600     IF PPS-RTC = 00                                              06060000
060700       IF P-NEW-COLA NOT NUMERIC                                  06070000
060800          MOVE 50 TO PPS-RTC.                                     06080000
060900                                                                  06090000
061000     IF PPS-RTC = 00                                              06100000
061100       IF P-NEW-WAIVER-STATE                                      06110000
061200          MOVE 53 TO PPS-RTC.                                     06120000
061300                                                                  06130000
061400     IF PPS-RTC = 00                                              06140000
061500         IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR               06150000
061600            (B-DISCHARGE-DATE < W-EFF-DATE))                      06160000
061700            MOVE 55 TO PPS-RTC.                                   06170000
061800                                                                  06180000
061900     IF PPS-RTC = 00                                              06190000
062000         IF P-NEW-TERMINATION-DATE > 00000000                     06200000
062100            IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE         06210000
062200               MOVE 51 TO PPS-RTC.                                06220000
062300                                                                  06230000
062400     IF PPS-RTC = 00                                              06240000
062500         IF B-COV-CHARGES NOT NUMERIC                             06250000
062600            MOVE 58 TO PPS-RTC.                                   06260000
062700                                                                  06270000
062800     IF PPS-RTC = 00                                              06280000
062900        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60              06290000
063000           MOVE 61 TO PPS-RTC.                                    06300000
063100                                                                  06310000
063200     IF PPS-RTC = 00                                              06320000
063300        IF (B-COV-DAYS NOT NUMERIC) OR                            06330000
063400           (B-COV-DAYS = 0 AND H-LOS > 0)                         06340000
063500           MOVE 62 TO PPS-RTC.                                    06350000
063600                                                                  06360000
063700     IF PPS-RTC = 00                                              06370000
063800        IF B-LTR-DAYS > B-COV-DAYS                                06380000
063900           MOVE 62 TO PPS-RTC.                                    06390000
064000                                                                  06400000
064100     IF PPS-RTC = 00                                              06410000
064200        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS              06420000
064300        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.           06430000
064400                                                                  06440000
064500     IF PPS-RTC = 00                                              06450000
064600        PERFORM 1200-DAYS-USED                                    06460000
064700           THRU 1200-DAYS-USED-EXIT.                              06470000
064800                                                                  06480000
064900                                                                  06490000
065000*** -----------------------------------------------------------   06500000
065100*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION    06510000
065200*** -----------------------------------------------------------   06520000
065300     IF PPS-RTC = 00                                              06530000
065400        IF P-NEW-CAPI-IME NUMERIC                                 06540000
065500           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO                06550000
065600        ELSE                                                      06560000
065700           MOVE ZEROS TO H-CAPI-IME-RATIO                         06570000
065800        END-IF                                                    06580000
065900     END-IF.                                                      06590000
066000                                                                  06600000
066100     IF PPS-RTC = 00                                              06610000
066200        IF P-NEW-INTERN-RATIO NUMERIC                             06620000
066300           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO              06630000
066400        ELSE                                                      06640000
066500           MOVE ZEROS TO H-INTERN-RATIO                           06650000
066600        END-IF                                                    06660000
066700     END-IF.                                                      06670000
066800                                                                  06680000
066900     IF PPS-RTC = 00                                              06690000
067000        IF P-NEW-BED-SIZE NUMERIC                                 06700000
067100           MOVE P-NEW-BED-SIZE TO H-BED-SIZE                      06710000
067200        ELSE                                                      06720000
067300           MOVE ZEROS TO H-BED-SIZE                               06730000
067400        END-IF                                                    06740000
067500     END-IF.                                                      06750000
067600                                                                  06760000
067700     IF PPS-RTC = 00                                              06770000
067800        IF P-NEW-SSI-RATIO NUMERIC                                06780000
067900           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO                    06790000
068000        ELSE                                                      06800000
068100           MOVE ZEROS TO H-SSI-RATIO                              06810000
068200        END-IF                                                    06820000
068300     END-IF.                                                      06830000
068400                                                                  06840000
068500     IF PPS-RTC = 00                                              06850000
068600        IF P-NEW-MEDICAID-RATIO NUMERIC                           06860000
068700           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO          06870000
068800        ELSE                                                      06880000
068900           MOVE ZEROS TO H-MEDICAID-RATIO                         06890000
069000        END-IF                                                    06900000
069100     END-IF.                                                      06910000
069200                                                                  06920000
069300                                                                  06930000
069400 1000-EXIT.                                                       06940000
069500      EXIT.                                                       06950000
069600                                                                  06960000
069700                                                                  06970000
069800***************************************************************   06980000
069900 1200-DAYS-USED.                                                  06990000
070000***************************************************************   07000000
070100                                                                  07010000
070200     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)                     07020000
070300        IF B-LTR-DAYS > H-LOS                                     07030000
070400           MOVE H-LOS TO PPS-LTR-DAYS-USED                        07040000
070500        ELSE                                                      07050000
070600           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED                   07060000
070700     ELSE                                                         07070000
070800        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)                  07080000
070900           IF H-REG-DAYS > H-LOS                                  07090000
071000              MOVE H-LOS TO PPS-REG-DAYS-USED                     07100000
071100           ELSE                                                   07110000
071200              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED                07120000
071300        ELSE                                                      07130000
071400           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)               07140000
071500              IF H-REG-DAYS > H-LOS                               07150000
071600                 MOVE H-LOS TO PPS-REG-DAYS-USED                  07160000
071700                 MOVE 0 TO PPS-LTR-DAYS-USED                      07170000
071800              ELSE                                                07180000
071900                 IF H-TOTAL-DAYS > H-LOS                          07190000
072000                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED          07200000
072100                    COMPUTE PPS-LTR-DAYS-USED =                   07210000
072200                            H-LOS - H-REG-DAYS                    07220000
072300                 ELSE                                             07230000
072400                    IF H-TOTAL-DAYS <= H-LOS                      07240000
072500                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED       07250000
072600                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED       07260000
072700                    ELSE                                          07270000
072800                       NEXT SENTENCE                              07280000
072900           ELSE                                                   07290000
073000              NEXT SENTENCE.                                      07300000
073100                                                                  07310000
073200 1200-DAYS-USED-EXIT.                                             07320000
073300      EXIT.                                                       07330000
073400                                                                  07340000
073500                                                                  07350000
073600***************************************************************   07360000
073700*    FINDS THE LTCH DRG CODE IN THE TABLE                     *   07370000
073800***************************************************************   07380000
073900 1700-EDIT-DRG-CODE.                                              07390000
074000***************************************************************   07400000
074100                                                                  07410000
074200     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.                        07420000
074300     IF PPS-RTC = 00                                              07430000
074400        SEARCH ALL WWM-ENTRY                                      07440000
074500           AT END                                                 07450000
074600             MOVE 54 TO PPS-RTC                                   07460000
074700        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE               07470000
074800             PERFORM 1750-FIND-VALUE                              07480000
074900                THRU 1750-EXIT                                    07490000
075000        END-SEARCH.                                               07500000
075100                                                                  07510000
075200 1700-EXIT.                                                       07520000
075300      EXIT.                                                       07530000
075400                                                                  07540000
075500                                                                  07550000
075600***************************************************************   07560000
075700*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *   07570000
075800***************************************************************   07580000
075900 1750-FIND-VALUE.                                                 07590000
076000***************************************************************   07600000
076100                                                                  07610000
076200      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.           07620000
076300      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.                07630000
076400*     MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.               07640000
076500                                                                  07650000
076600 1750-EXIT.                                                       07660000
076700      EXIT.                                                       07670000
076800                                                                  07680000
076900                                                                  07690000
077000***************************************************************   07700000
077100*    FINDS THE IPPS DRG CODE IN THE TABLE                     *   07710000
077200***************************************************************   07720000
077300 1800-EDIT-IPPS-DRG-CODE.                                         07730000
077400***************************************************************   07740000
077500                                                                  07750000
077600     IF B-DRG-CODE NOT NUMERIC                                    07760000
077700        MOVE 54 TO PPS-RTC                                        07770000
077800        GO TO 1800-EXIT                                           07780000
077900     END-IF.                                                      07790000
078000                                                                  07800000
078100     IF B-DISCHARGE-DATE NOT < DRGX-EFF-DATE(DX5) AND PPS-RTC = 0 07810000
078200        SET DX6                       TO B-DRG-CODE               07820000
078300        MOVE DRG-WT (DX5 DX6)         TO H-IPPS-DRG-WGT           07830000
078400        MOVE DRG-ALOS (DX5 DX6)       TO H-IPPS-DRG-ALOS          07840000
078500        MOVE ZEROES                   TO H-IPPS-DAYS-CUTOFF       07850000
078600        MOVE DRG-ARITH-ALOS (DX5 DX6) TO H-IPPS-ARITH-ALOS        07860000
078700     END-IF.                                                      07870000
078800                                                                  07880000
078900 1800-EXIT.                                                       07890000
079000      EXIT.                                                       07900000
079100                                                                  07910000
079200                                                                  07920000
079300***************************************************************   07930000
079400*    ADJUST THE IPPS WAGE INDEX BY THE STATE SPECIFIC         *   07940000
079500*    RURAL FLOOR BUDGET NEUTRALITY FACTOR (SSRFBN)            *   07950000
079600***************************************************************   07960000
079700 1900-APPLY-SSRFBN.                                               07970000
079800***************************************************************   07980000
079900                                                                  07990000
080000     MOVE W-IPPS-WAGE-INDEX    TO H-IPPS-WAGE-INDEX.              08000000
080100*    MOVE P-NEW-STATE          TO MES-PPS-STATE.                  08010000
080200                                                                  08020000
080300*    PERFORM 1950-FIND-SSRFBN                                     08030000
080400*       THRU 1950-EXIT.                                           08040000
080500                                                                  08050000
080600*    IF PPS-RTC = 00                                              08060000
080700*       IF  P-NEW-SPECIAL-PAY-IND = '1' OR '2'                    08070000
080800*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =                   08080000
080900*                   H-IPPS-WAGE-INDEX * 1                         08090000
081000*       ELSE                                                      08100000
081100*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =                   08110000
081200*                   H-IPPS-WAGE-INDEX * MES-SSRFBN-RATE           08120000
081300*       END-IF                                                    08130000
081400*    END-IF.                                                      08140000
081500                                                                  08150000
081600 1900-EXIT.                                                       08160000
081700      EXIT.                                                       08170000
081800                                                                  08180000
081900                                                                  08190000
082000***************************************************************   08200000
082100*    FIND THE IPPS STATE SPECIFIC RURAL FLOOR BUDGET          *   08210000
082200*    NEUTRALITY FACTOR (SSRFBN)                               *   08220000
082300***************************************************************   08230000
082400*1950-FIND-SSRFBN.                                                08240000
082500***************************************************************   08250000
082600                                                                  08260000
082700*    SET SSRFBN-IDX TO 1.                                         08270000
082800*    SEARCH SSRFBN-TAB VARYING SSRFBN-IDX                         08280000
082900                                                                  08290000
083000*        AT END                                                   08300000
083100*          MOVE 68 TO PPS-RTC                                     08310000
083200*          GO TO 1950-EXIT                                        08320000
083300                                                                  08330000
083400*        WHEN WK-SSRFBN-STATE(SSRFBN-IDX) = MES-PPS-STATE         08340000
083500*          MOVE WK-SSRFBN-REASON-ALL (SSRFBN-IDX) TO MES-SSRFBN.  08350000
083600                                                                  08360000
083700*1950-EXIT.                                                       08370000
083800*     EXIT.                                                       08380000
083900                                                                  08390000
084000                                                                  08400000
084100***************************************************************   08410000
084200***  GET THE PROVIDER SPECIFIC VARIABLES AND WAGE INDEX       *   08420000
084300*                                                             *   08430000
084400*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *   08440000
084500*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *   08450000
084600*    OF THAT VARIABLE.                                        *   08460000
084700*                                                             *   08470000
084800***************************************************************   08480000
084900 2000-ASSEMBLE-PPS-VARIABLES.                                     08490000
085000***************************************************************   08500000
085100                                                                  08510000
085200                                                                  08520000
085300*------------------------------------------------------*          08530000
085400* WAGE INDEX BLEND TABLE                               *          08540000
085500*------------------------------------------------------*          08550000
085600*                                                      *          08560000
085700*  BLEND YEAR   FEDERAL FY                BLEND        *          08570000
085800*  ----------   ----------------------    -----        *          08580000
085900*      1        10/01/2002 - 09/30/2003    1/5         *          08590000
086000*      2        10/01/2003 - 09/30/2004    2/5         *          08600000
086100*      3        10/01/2004 - 09/30/2005    3/5         *          08610000
086200*      4        10/01/2005 - 09/30/2006    4/5         *          08620000
086300*      5        10/01/2006 - INDEFINITE    5/5 (FULL)  *          08630000
086400*                                                      *          08640000
086500*------------------------------------------------------*          08650000
086600*                                                      *          08660000
086700* A PROVIDER WILL RECEIVE THE APPLICABLE BLEND FOR A   *          08670000
086800* GIVEN FEDERAL FY FOR CLAIMS DISCHARGED ON & AFTER    *          08680000
086900* ITS FY BEGIN DATE THAT FALLS WITHIN THAT FEDERAL FY. *          08690000
087000*                                                      *          08700000
087100*------------------------------------------------------*          08710000
087200                                                                  08720000
087300                                                                  08730000
087400***************************************************************   08740000
087500* ASSIGN FULL (5/5) WAGE INDEX TO ALL CLAIMS DISCHARGED ON    *   08750000
087600* AND AFTER 7/1/2008 (NEW FOR VERSION 2008.0)                 *   08760000
087700***************************************************************   08770000
087800     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0               08780000
087900        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX                      08790000
088000     ELSE                                                         08800000
088100        MOVE 52 TO PPS-RTC                                        08810000
088200        GO TO 2000-EXIT                                           08820000
088300     END-IF.                                                      08830000
088400                                                                  08840000
088500                                                                  08850000
088600***************************************************************   08860000
088700* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *   08870000
088800* (ALWAYS FED-FY-BEGIN-03)                                    *   08880000
088900***************************************************************   08890000
089000      IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03                    08900000
089100         MOVE 74 TO PPS-RTC                                       08910000
089200         GO TO 2000-EXIT                                          08920000
089300      END-IF.                                                     08930000
089400                                                                  08940000
089500                                                                  08950000
089600***************************************************************   08960000
089700* USE SPECIAL WAGE INDEX WHEN INDICATED                       *   08970000
089800***************************************************************   08980000
089900     IF P-NEW-SPECIAL-PAY-IND = '1'                               08990000
090000        IF P-NEW-SPECIAL-WAGE-INDEX NUMERIC AND                   09000000
090100           P-NEW-SPECIAL-WAGE-INDEX > 0                           09010000
090200           MOVE P-NEW-SPECIAL-WAGE-INDEX TO PPS-WAGE-INDEX        09020000
090300        ELSE                                                      09030000
090400           MOVE 52 TO PPS-RTC                                     09040000
090500           GO TO 2000-EXIT                                        09050000
090600        END-IF                                                    09060000
090700     END-IF.                                                      09070000
090800                                                                  09080000
090900                                                                  09090000
091000***************************************************************   09100000
091100* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *   09110000
091200***************************************************************   09120000
091300     IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC                       09130000
091400        MOVE 65 TO PPS-RTC.                                       09140000
091500                                                                  09150000
091600                                                                  09160000
091700***************************************************************   09170000
091800* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *   09180000
091900***************************************************************   09190000
092000     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.              09200000
092100                                                                  09210000
092200     IF PPS-BLEND-YEAR > 0 AND PPS-BLEND-YEAR < 6                 09220000
092300        NEXT SENTENCE                                             09230000
092400     ELSE                                                         09240000
092500        MOVE 72 TO PPS-RTC                                        09250000
092600        GO TO 2000-EXIT.                                          09260000
092700                                                                  09270000
092800     MOVE 0 TO H-BLEND-FAC.                                       09280000
092900     MOVE 1 TO H-BLEND-PPS.                                       09290000
093000     MOVE 0 TO H-BLEND-RTC.                                       09300000
093100                                                                  09310000
093200     IF PPS-BLEND-YEAR = 1                                        09320000
093300        MOVE .8 TO H-BLEND-FAC                                    09330000
093400        MOVE .2 TO H-BLEND-PPS                                    09340000
093500        MOVE 4 TO H-BLEND-RTC                                     09350000
093600     ELSE                                                         09360000
093700       IF PPS-BLEND-YEAR = 2                                      09370000
093800          MOVE .6 TO H-BLEND-FAC                                  09380000
093900          MOVE .4 TO H-BLEND-PPS                                  09390000
094000          MOVE 8 TO H-BLEND-RTC                                   09400000
094100       ELSE                                                       09410000
094200         IF PPS-BLEND-YEAR = 3                                    09420000
094300            MOVE .4 TO H-BLEND-FAC                                09430000
094400            MOVE .6 TO H-BLEND-PPS                                09440000
094500            MOVE 12 TO H-BLEND-RTC                                09450000
094600         ELSE                                                     09460000
094700           IF PPS-BLEND-YEAR = 4                                  09470000
094800              MOVE .2 TO H-BLEND-FAC                              09480000
094900              MOVE .8 TO H-BLEND-PPS                              09490000
095000              MOVE 16 TO H-BLEND-RTC.                             09500000
095100                                                                  09510000
095200 2000-EXIT.                                                       09520000
095300      EXIT.                                                       09530000
095400                                                                  09540000
095500                                                                  09550000
095600***************************************************************   09560000
095700*    IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)           *   09570000
095800*        CALCULATE THE STANDARD PAYMENT AMOUNT.               *   09580000
095900*        CALCULATE THE SHORT-STAY OUTLIER AMOUNT.             *   09590000
096000***************************************************************   09600000
096100 3000-CALC-PAYMENT.                                               09610000
096200***************************************************************   09620000
096300                                                                  09630000
096400*** -------------------------------------------------- ***        09640000
096500*** FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII) ***        09650000
096600*** -------------------------------------------------- ***        09660000
096700     IF (P-NEW-STATE = 02 OR 12)                                  09670000
096800        MOVE P-NEW-COLA TO PPS-COLA                               09680000
096900     ELSE                                                         09690000
097000        MOVE 1.000 TO PPS-COLA                                    09700000
097100     END-IF.                                                      09710000
097200                                                                  09720000
097300                                                                  09730000
097400     COMPUTE PPS-FAC-COSTS ROUNDED =                              09740000
097500         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.                 09750000
097600                                                                  09760000
097700     COMPUTE H-LABOR-PORTION ROUNDED =                            09770000
097800         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)                   09780000
097900          * PPS-WAGE-INDEX.                                       09790000
098000                                                                  09800000
098100     COMPUTE H-NONLABOR-PORTION ROUNDED =                         09810000
098200         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)                09820000
098300          * PPS-COLA.                                             09830000
098400                                                                  09840000
098500     COMPUTE PPS-FED-PAY-AMT ROUNDED =                            09850000
098600         (H-LABOR-PORTION + H-NONLABOR-PORTION).                  09860000
098700                                                                  09870000
098800     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =                        09880000
098900         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).                    09890000
099000                                                                  09900000
099100                                                                  09910000
099200*** -------------------------------------------------------- ***  09920000
099300*** FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY ***  09930000
099400*** -------------------------------------------------------- ***  09940000
099500     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.         09950000
099600                                                                  09960000
099700*** --------------------------------------------- ***             09970000
099800*** DETERMINE WHETHER THE CLAIM IS A SHORT STAY   ***             09980000
099900*** --------------------------------------------- ***             09990000
100000*** H-SSOT ROUNDED AND EXPANDED TO 1 DECIMAL      ***             10000000
100100*** PLACE FOR RELEASE 07.1                        ***             10010000
100200*** --------------------------------------------- ***             10020000
100300     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.              10030000
100400     IF H-LOS <= H-SSOT                                           10040000
100500        PERFORM 3400-SHORT-STAY                                   10050000
100600           THRU 3400-SHORT-STAY-EXIT.                             10060000
100700                                                                  10070000
100800 3000-EXIT.                                                       10080000
100900      EXIT.                                                       10090000
101000                                                                  10100000
101100                                                                  10110000
101200***************************************************************   10120000
101300*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *   10130000
101400*      OF THE AVG. LENGTH OF STAY THEN:                       *   10140000
101500*      - CALCULATE THE SHORT-STAY COST.                       *   10150000
101600*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *   10160000
101700*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *   10170000
101800*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *   10180000
101900*      - PAY THE LEAST OF:                                    *   10190000
102000*          1)SHORT STAY COST                                  *   10200000
102100*          2)SHORT STAY PAYMENT AMOUNT                        *   10210000
102200*          3)DRG ADJUSTED PAYMENT AMOUNT                      *   10220000
102300*          4)SHORT STAY BLENDED PAYMENT -OR-                  *   10230000
102400*          5)IPPS COMPARABLE AMOUNT                           *   10240000
102500*      - SET RETURN CODE TO INDICATE SHORT STAY PAYMENT TYPE  *   10250000
102600***************************************************************   10260000
102700 3400-SHORT-STAY.                                                 10270000
102800***************************************************************   10280000
102900                                                                  10290000
103000**************************************************************    10300000
103100*                                                            *    10310000
103200*   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *    10320000
103300*                                                            *    10330000
103400**************************************************************    10340000
103500     IF P-NEW-PROVIDER-NO = '332006'                              10350000
103600        PERFORM 4000-SPECIAL-PROVIDER                             10360000
103700           THRU 4000-SPECIAL-PROVIDER-EXIT                        10370000
103800                                                                  10380000
103900     ELSE                                                         10390000
104000                                                                  10400000
104100                                                                  10410000
104200**************************************************************    10420000
104300*                                                            *    10430000
104400*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *    10440000
104500* ---------------------------------------------------------- *    10450000
104600*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *    10460000
104700*                                                            *    10470000
104800**************************************************************    10480000
104900        MOVE PPS-FAC-COSTS TO H-SS-COST                           10490000
105000                                                                  10500000
105100                                                                  10510000
105200**************************************************************    10520000
105300*                                                            *    10530000
105400*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *    10540000
105500* ---------------------------------------------------------- *    10550000
105600*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *    10560000
105700*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *    10570000
105800*     THE LENGTH OF STAY IS CORRECT                          *    10580000
105900*                                                            *    10590000
106000**************************************************************    10600000
106100        COMPUTE H-SS-PAY-AMT ROUNDED =                            10610000
106200         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2      10620000
106300                                                                  10630000
106400                                                                  10640000
106500**************************************************************    10650000
106600*                                                            *    10660000
106700*   SHORT STAY PROVISION #4 (BLEND OF SS PMT & IPPS          *    10670000
106800*   COMPARABLE PER DIEM AMT)                                 *    10680000
106900* ---------------------------------------------------------- *    10690000
107000*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *    10700000
107100*   REMOVED FROM VERSION 09.0 BECAUSE CLAIMS DISCHARGED ON   *    10710000
107200*   AND AFTER 12/29/2008 ARE NOT ELIGIBLE FOR PROVISION #5.  *    10720000
107300*                                                            *    10730000
107400**************************************************************    10740000
107500        IF H-IPPS-WAGE-INDEX NUMERIC AND                          10750000
107600           H-IPPS-WAGE-INDEX > 0                                  10760000
107700           PERFORM 3600-SS-BLENDED-PMT                            10770000
107800              THRU 3600-SS-BLENDED-PMT-EXIT                       10780000
107900        ELSE                                                      10790000
108000           MOVE 52 TO PPS-RTC                                     10800000
108100           GO TO 3400-SHORT-STAY-EXIT                             10810000
108200        END-IF                                                    10820000
108300     END-IF.                                                      10830000
108400                                                                  10840000
108500                                                                  10850000
108600**************************************************************    10860000
108700*                                                            *    10870000
108800*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *    10880000
108900*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *    10890000
109000* ---------------------------------------------------------- *    10900000
109100*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *    10910000
109200*                                                            *    10920000
109300**************************************************************    10930000
109400                                                                  10940000
109500     MOVE 'N' TO H-SS-COST-IND.                                   10950000
109600     MOVE 'N' TO H-SS-PERDIEM-IND.                                10960000
109700     MOVE 'N' TO H-SS-BLEND-IND.                                  10970000
109800     MOVE 'N' TO H-SS-IPPSCOMP-IND.                               10980000
109900                                                                  10990000
110000*---------------------------------------------------------        11000000
110100*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%          11010000
110200*   OF PER DIEM) AND DRG ADJUSTED PMT AMT                         11020000
110300*---------------------------------------------------------        11030000
110400     IF H-SS-COST < H-SS-PAY-AMT                                  11040000
110500        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT                        11050000
110600           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT                  11060000
110700           MOVE 20 TO PPS-RTC                                     11070000
110800           MOVE 'Y' TO H-SS-COST-IND                              11080000
110900        ELSE                                                      11090000
111000           NEXT SENTENCE                                          11100000
111100        END-IF                                                    11110000
111200     ELSE                                                         11120000
111300        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT                     11130000
111400           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT               11140000
111500           MOVE 21 TO PPS-RTC                                     11150000
111600           MOVE 'Y' TO H-SS-PERDIEM-IND                           11160000
111700        ELSE                                                      11170000
111800           NEXT SENTENCE                                          11180000
111900        END-IF                                                    11190000
112000     END-IF.                                                      11200000
112100                                                                  11210000
112200*---------------------------------------------------------        11220000
112300*   USE THE BLENDED PMT IF LESS THAN THE OTHER SHORT STAY         11230000
112400*   OPTIONS                                                       11240000
112500*---------------------------------------------------------        11250000
112600     IF P-NEW-PROVIDER-NO NOT = '332006'                          11260000
112700        IF H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT                 11270000
112800           MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT           11280000
112900           MOVE 22 TO PPS-RTC                                     11290000
113000           MOVE 'Y' TO H-SS-BLEND-IND                             11300000
113100           MOVE 'N' TO H-SS-COST-IND                              11310000
113200           MOVE 'N' TO H-SS-PERDIEM-IND                           11320000
113300           MOVE 'N' TO H-SS-IPPSCOMP-IND                          11330000
113400        END-IF                                                    11340000
113500     END-IF.                                                      11350000
113600                                                                  11360000
113700 3400-SHORT-STAY-EXIT.                                            11370000
113800      EXIT.                                                       11380000
113900                                                                  11390000
114000                                                                  11400000
114100***************************************************************   11410000
114200*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *   11420000
114300*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *   11430000
114400*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *   11440000
114500*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *   11450000
114600***************************************************************   11460000
114700 3600-SS-BLENDED-PMT.                                             11470000
114800***************************************************************   11480000
114900                                                                  11490000
115000*** ------------------------------------------------------ ***    11500000
115100*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***    11510000
115200*** ------------------------------------------------------ ***    11520000
115300     IF H-SSOT < 25                                               11530000
115400        COMPUTE H-LTCH-BLEND-PCT ROUNDED =                        11540000
115500          H-LOS / H-SSOT                                          11550000
115600     ELSE                                                         11560000
115700        COMPUTE H-LTCH-BLEND-PCT ROUNDED =                        11570000
115800          H-LOS / 25                                              11580000
115900     END-IF.                                                      11590000
116000                                                                  11600000
116100     IF H-LTCH-BLEND-PCT > 1                                      11610000
116200        MOVE 1 TO H-LTCH-BLEND-PCT                                11620000
116300     END-IF.                                                      11630000
116400                                                                  11640000
116500                                                                  11650000
116600*** ------------------------------------------------------ ***    11660000
116700*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***    11670000
116800*** ------------------------------------------------------ ***    11680000
116900     COMPUTE H-LTCH-BLEND-AMT ROUNDED =                           11690000
117000        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.                          11700000
117100                                                                  11710000
117200                                                                  11720000
117300*** ------------------------------------------------------ ***    11730000
117400*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***    11740000
117500*** ------------------------------------------------------ ***    11750000
117600     PERFORM 3650-SS-IPPS-COMP-PMT                                11760000
117700        THRU 3650-SS-IPPS-COMP-PMT-EXIT.                          11770000
117800                                                                  11780000
117900                                                                  11790000
118000*** ------------------------------------------------------ ***    11800000
118100*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***    11810000
118200*** ------------------------------------------------------ ***    11820000
118300     COMPUTE H-IPPS-BLEND-PCT ROUNDED =                           11830000
118400       1 - H-LTCH-BLEND-PCT.                                      11840000
118500                                                                  11850000
118600                                                                  11860000
118700*** ------------------------------------------------------ ***    11870000
118800*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***    11880000
118900*** ------------------------------------------------------ ***    11890000
119000     COMPUTE H-IPPS-BLEND-AMT ROUNDED =                           11900000
119100       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.                        11910000
119200                                                                  11920000
119300                                                                  11930000
119400*** ------------------------------------------------------ ***    11940000
119500*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***    11950000
119600*** ------------------------------------------------------ ***    11960000
119700     COMPUTE H-SS-BLENDED-PMT ROUNDED =                           11970000
119800       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.                       11980000
119900                                                                  11990000
120000                                                                  12000000
120100 3600-SS-BLENDED-PMT-EXIT.                                        12010000
120200      EXIT.                                                       12020000
120300                                                                  12030000
120400                                                                  12040000
120500***************************************************************   12050000
120600*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *   12060000
120700*   PER DIEM PAYMENT AMOUNT                                   *   12070000
120800***************************************************************   12080000
120900 3650-SS-IPPS-COMP-PMT.                                           12090000
121000***************************************************************   12100000
121100                                                                  12110000
121200*** -------------------------------------------------------       12120000
121300*** OPERATING TEACHING ADJUSTMENT                                 12130000
121400*** -------------------------------------------------------       12140000
121500     COMPUTE H-OPER-IME-TEACH ROUNDED =                           12150000
121600        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).                12160000
121700                                                                  12170000
121800                                                                  12180000
121900*** -------------------------------------------------------       12190000
122000*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)              12200000
122100*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%        12210000
122200*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL       12220000
122300***              THIS CHANGE IS RETROACTIVE TO 10/01/2008         12230000
122400*** -------------------------------------------------------       12240000
122500     IF H-CAPI-IME-RATIO > 1.5000                                 12250000
122600        MOVE 1.5000 TO H-CAPI-IME-RATIO.                          12260000
122700                                                                  12270000
122800     COMPUTE H-CAPI-IME-TEACH ROUNDED =                           12280000
122900        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).             12290000
123000                                                                  12300000
123100                                                                  12310000
123200*** -------------------------------------------------------       12320000
123300*** OPERATING DSH ADJUSTMENT                                      12330000
123400*** -------------------------------------------------------       12340000
123500                                                                  12350000
123600*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL              12360000
123700*---------------------------------------------------              12370000
123800     IF ALL-RURAL                                                 12380000
123900        SET RURAL-CBSA TO TRUE                                    12390000
124000     ELSE                                                         12400000
124100        SET URBAN-CBSA TO TRUE                                    12410000
124200     END-IF.                                                      12420000
124300                                                                  12430000
124400                                                                  12440000
124500*2) CALCULATE THE OPERATING DSH PERCENT                           12450000
124600*--------------------------------------                           12460000
124700     COMPUTE H-OPER-DSH-PCT ROUNDED =                             12470000
124800        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.                   12480000
124900                                                                  12490000
125000                                                                  12500000
125100*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION            12510000
125200*-----------------------------------------------------            12520000
125300                                                                  12530000
125400*    URBAN, < 100 BEDS                                            12540000
125500*    -----------------                                            12550000
125600     IF URBAN-CBSA AND H-BED-SIZE < 100 AND                       12560000
125700        H-OPER-DSH-PCT >= .15                                     12570000
125800          MOVE '3' TO H-GEO-CLASS                                 12580000
125900     ELSE                                                         12590000
126000                                                                  12600000
126100                                                                  12610000
126200*   URBAN, >= 100 BEDS                                            12620000
126300*   ------------------                                            12630000
126400       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND                    12640000
126500          H-OPER-DSH-PCT >= .15                                   12650000
126600            MOVE '2' TO H-GEO-CLASS                               12660000
126700       ELSE                                                       12670000
126800                                                                  12680000
126900                                                                  12690000
127000*   RURAL, >= 500 BEDS                                            12700000
127100*   ------------------                                            12710000
127200         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND                  12720000
127300            H-OPER-DSH-PCT >= .15                                 12730000
127400              MOVE '2' TO H-GEO-CLASS                             12740000
127500         ELSE                                                     12750000
127600                                                                  12760000
127700                                                                  12770000
127800*   RURAL, < 500 BEDS                                             12780000
127900*   -----------------                                             12790000
128000           IF RURAL-CBSA AND H-BED-SIZE < 500 AND                 12800000
128100              H-OPER-DSH-PCT >= .15                               12810000
128200                MOVE '3' TO H-GEO-CLASS                           12820000
128300           ELSE                                                   12830000
128400                                                                  12840000
128500                                                                  12850000
128600*   OTHER                                                         12860000
128700*   -----------------                                             12870000
128800              MOVE '4' TO H-GEO-CLASS                             12880000
128900                                                                  12890000
129000           END-IF                                                 12900000
129100         END-IF                                                   12910000
129200       END-IF                                                     12920000
129300     END-IF.                                                      12930000
129400                                                                  12940000
129500                                                                  12950000
129600*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS      12960000
129700*-----------------------------------------------------------      12970000
129800     EVALUATE H-GEO-CLASS                                         12980000
129900                                                                  12990000
130000*      GEOGRAPHIC CLASS 2                                         13000000
130100*      ------------------                                         13010000
130200       WHEN '2'                                                   13020000
130300          IF (H-OPER-DSH-PCT >= .15 AND <= .202)                  13030000
130400             COMPUTE H-OPER-DSH ROUNDED =                         13040000
130500               ((H-OPER-DSH-PCT - .15) * .65) + .025              13050000
130600          ELSE                                                    13060000
130700             IF H-OPER-DSH-PCT > .202                             13070000
130800                COMPUTE H-OPER-DSH ROUNDED =                      13080000
130900                  ((H-OPER-DSH-PCT - .202) * .825) + .0588        13090000
131000             ELSE                                                 13100000
131100                MOVE ZEROS TO H-OPER-DSH                          13110000
131200             END-IF                                               13120000
131300          END-IF                                                  13130000
131400                                                                  13140000
131500*      GEOGRAPHIC CLASS 3                                         13150000
131600*      ------------------                                         13160000
131700       WHEN '3'                                                   13170000
131800          IF (H-OPER-DSH-PCT >= .15 AND <= .202)                  13180000
131900             COMPUTE H-OPER-DSH ROUNDED =                         13190000
132000               ((H-OPER-DSH-PCT - .15) * .65) + .025              13200000
132100             IF H-OPER-DSH > .12                                  13210000
132200                MOVE .12 TO H-OPER-DSH                            13220000
132300             END-IF                                               13230000
132400          ELSE                                                    13240000
132500             IF H-OPER-DSH-PCT > .202                             13250000
132600                COMPUTE H-OPER-DSH ROUNDED =                      13260000
132700                  ((H-OPER-DSH-PCT - .202) * .825) + .0588        13270000
132800                IF H-OPER-DSH > .12                               13280000
132900                   MOVE .12 TO H-OPER-DSH                         13290000
133000                END-IF                                            13300000
133100             ELSE                                                 13310000
133200               MOVE ZEROS TO H-OPER-DSH                           13320000
133300             END-IF                                               13330000
133400          END-IF                                                  13340000
133500                                                                  13350000
133600*      GEOGRAPHIC CLASS 4                                         13360000
133700*      ------------------                                         13370000
133800       WHEN '4'                                                   13380000
133900          MOVE ZEROS TO H-OPER-DSH                                13390000
134000                                                                  13400000
134100     END-EVALUATE.                                                13410000
134200                                                                  13420000
134300                                                                  13430000
134400*** -------------------------------------------------------       13440000
134500*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)                   13450000
134600*** -------------------------------------------------------       13460000
134700     IF URBAN-CBSA AND H-BED-SIZE >= 100                          13470000
134800        COMPUTE H-CAPI-DSH ROUNDED =                              13480000
134900          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1                  13490000
135000     ELSE                                                         13500000
135100        MOVE ZEROS TO H-CAPI-DSH                                  13510000
135200     END-IF.                                                      13520000
135300                                                                  13530000
135400                                                                  13540000
135500*** -------------------------------------------------------       13550000
135600*** OPERATING PAYMENT (STANDARD AMOUNT)                           13560000
135700*** -------------------------------------------------------       13570000
135800     IF (P-NEW-STATE = 02 OR 12)                                  13580000
135900        MOVE P-NEW-COLA TO H-OPER-COLA                            13590000
136000     ELSE                                                         13600000
136100        MOVE 1.000 TO H-OPER-COLA                                 13610000
136200     END-IF.                                                      13620000
136300                                                                  13630000
136400     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =                       13640000
136500       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +             13650000
136600         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *              13660000
136700         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).   13670000
136800                                                                  13680000
136900                                                                  13690000
137000*** -------------------------------------------------------       13700000
137100*** CAPITAL PAYMENT (CAPITAL RATE)                                13710000
137200*** -------------------------------------------------------       13720000
137300     COMPUTE H-CAPI-COLA ROUNDED =                                13730000
137400       (.3152 * (H-OPER-COLA - 1) + 1).                           13740000
137500                                                                  13750000
137600*--------------------------------------------------------------*  13760000
137700*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *  13770000
137800*   LATER (CHANGED FROM 1.03 TO 1.00)                          *  13780000
137900*--------------------------------------------------------------*  13790000
138000     IF LARGE-URBAN                                               13800000
138100        MOVE 1.00 TO H-LRGURB-ADD-ON                              13810000
138200     ELSE                                                         13820000
138300        MOVE 1.00 TO H-LRGURB-ADD-ON                              13830000
138400     END-IF.                                                      13840000
138500                                                                  13850000
138600     COMPUTE H-CAPI-GAF ROUNDED =                                 13860000
138700       (H-IPPS-WAGE-INDEX ** .6848).                              13870000
138800                                                                  13880000
138900     COMPUTE H-CAPI-PMT ROUNDED =                                 13890000
139000       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *   13900000
139100       H-LRGURB-ADD-ON *  H-CAPI-COLA *                           13910000
139200       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).                       13920000
139300                                                                  13930000
139400                                                                  13940000
139500*** -------------------------------------------------------       13950000
139600*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)           13960000
139700*** -------------------------------------------------------       13970000
139800     COMPUTE H-IPPS-PAY-AMT ROUNDED =                             13980000
139900       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.                         13990000
140000                                                                  14000000
140100                                                                  14010000
140200*** -------------------------------------------------------       14020000
140300*** IPPS COMPARABLE PER DIEM PAYMENT                              14030000
140400*** -------------------------------------------------------       14040000
140500     COMPUTE H-IPPS-PER-DIEM ROUNDED =                            14050000
140600       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.                14060000
140700                                                                  14070000
140800     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT                          14080000
140900        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM                    14090000
141000     END-IF.                                                      14100000
141100                                                                  14110000
141200*** -------------------------------------------------------       14120000
141300*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS                   14130000
141400*** -------------------------------------------------------       14140000
141500     IF P-NEW-STATE = 40                                          14150000
141600        PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT           14160000
141700     END-IF.                                                      14170000
141800                                                                  14180000
141900                                                                  14190000
142000 3650-SS-IPPS-COMP-PMT-EXIT.                                      14200000
142100      EXIT.                                                       14210000
142200                                                                  14220000
142300                                                                  14230000
142400***************************************************************   14240000
142500 3675-SS-IPPS-COMP-PR-PMT.                                        14250000
142600***************************************************************   14260000
142700                                                                  14270000
142800*** -------------------------------------------------------       14280000
142900*** PUERTO RICO OPERATING PAYMENT (STANDARD AMOUNT)               14290000
143000*** -------------------------------------------------------       14300000
143100     COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =                    14310000
143200        ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +          14320000
143300          (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *              14330000
143400          H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).  14340000
143500                                                                  14350000
143600                                                                  14360000
143700*** -------------------------------------------------------       14370000
143800*** PUERTO RICO CAPITAL PAYMENT (CAPITAL RATE)                    14380000
143900*** -------------------------------------------------------       14390000
144000     COMPUTE H-PR-CAPI-GAF ROUNDED =                              14400000
144100        (W-IPPS-PR-WAGE-INDEX ** .6848).                          14410000
144200                                                                  14420000
144300     COMPUTE H-PR-CAPI-PMT ROUNDED =                              14430000
144400        H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *14440000
144500        H-LRGURB-ADD-ON * H-CAPI-COLA *                           14450000
144600        (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).                      14460000
144700                                                                  14470000
144800                                                                  14480000
144900*** -------------------------------------------------------       14490000
145000*** PR IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)        14500000
145100*** -------------------------------------------------------       14510000
145200     COMPUTE H-IPPS-PR-PAY-AMT ROUNDED =                          14520000
145300        H-PR-STAND-AMT-OPER-PMT + H-PR-CAPI-PMT.                  14530000
145400                                                                  14540000
145500                                                                  14550000
145600*** -------------------------------------------------------       14560000
145700*** PUERTO RICO IPPS COMPARABLE PER DIEM PAYMENT                  14570000
145800*** -------------------------------------------------------       14580000
145900     COMPUTE H-IPPS-PR-PER-DIEM ROUNDED =                         14590000
146000        (H-IPPS-PR-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.            14600000
146100                                                                  14610000
146200     IF H-IPPS-PR-PER-DIEM > H-IPPS-PR-PAY-AMT                    14620000
146300        MOVE H-IPPS-PR-PAY-AMT TO H-IPPS-PR-PER-DIEM              14630000
146400     END-IF.                                                      14640000
146500                                                                  14650000
146600                                                                  14660000
146700*** -------------------------------------------------------       14670000
146800*** BLEND FEDERAL PER DIEM AND PUERTO RICO PER DIEM               14680000
146900*** -------------------------------------------------------       14690000
147000     COMPUTE H-IPPS-PER-DIEM ROUNDED =                            14700000
147100        (H-IPPS-PER-DIEM    * H-NAT-IPPS-PMT-PCT) +               14710000
147200        (H-IPPS-PR-PER-DIEM * H-PR-IPPS-PMT-PCT ).                14720000
147300                                                                  14730000
147400                                                                  14740000
147500 3675-EXIT.                                                       14750000
147600      EXIT.                                                       14760000
147700                                                                  14770000
147800                                                                  14780000
147900***************************************************************   14790000
148000 4000-SPECIAL-PROVIDER.                                           14800000
148100***************************************************************   14810000
148200                                                                  14820000
148300*** PROCESS FOR CY2003                                            14830000
148400*** ------------------                                            14840000
148500     IF (B-DISCHARGE-DATE >= 20030701) AND                        14850000
148600        (B-DISCHARGE-DATE <  20040101)                            14860000
148700        COMPUTE H-SS-COST ROUNDED =                               14870000
148800            (PPS-FAC-COSTS * 1.95)                                14880000
148900        COMPUTE H-SS-PAY-AMT ROUNDED =                            14890000
149000         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95     14900000
149100     END-IF                                                       14910000
149200                                                                  14920000
149300                                                                  14930000
149400*** PROCESS FOR CY2004                                            14940000
149500*** ------------------                                            14950000
149600     IF (B-DISCHARGE-DATE >= 20040101) AND                        14960000
149700        (B-DISCHARGE-DATE <  20050101)                            14970000
149800        COMPUTE H-SS-COST ROUNDED =                               14980000
149900            (PPS-FAC-COSTS * 1.93)                                14990000
150000        COMPUTE H-SS-PAY-AMT ROUNDED =                            15000000
150100          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93    15010000
150200     END-IF                                                       15020000
150300                                                                  15030000
150400                                                                  15040000
150500*** PROCESS FOR CY2005                                            15050000
150600*** ------------------                                            15060000
150700     IF (B-DISCHARGE-DATE >= 20050101) AND                        15070000
150800        (B-DISCHARGE-DATE <  20060101)                            15080000
150900        COMPUTE H-SS-COST ROUNDED =                               15090000
151000            (PPS-FAC-COSTS * 1.65)                                15100000
151100        COMPUTE H-SS-PAY-AMT ROUNDED =                            15110000
151200          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65    15120000
151300     END-IF                                                       15130000
151400                                                                  15140000
151500                                                                  15150000
151600*** PROCESS FOR CY2006                                            15160000
151700*** ------------------                                            15170000
151800     IF (B-DISCHARGE-DATE >= 20060101) AND                        15180000
151900        (B-DISCHARGE-DATE <  20070101)                            15190000
152000        COMPUTE H-SS-COST ROUNDED =                               15200000
152100            (PPS-FAC-COSTS * 1.36)                                15210000
152200        COMPUTE H-SS-PAY-AMT ROUNDED =                            15220000
152300          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36    15230000
152400     END-IF                                                       15240000
152500                                                                  15250000
152600                                                                  15260000
152700*** PROCESS FOR CY2007 AND AFTER                                  15270000
152800*** ----------------------------                                  15280000
152900     IF (B-DISCHARGE-DATE >= 20070101)                            15290000
153000        COMPUTE H-SS-COST ROUNDED =                               15300000
153100            (PPS-FAC-COSTS * 1.2)                                 15310000
153200        COMPUTE H-SS-PAY-AMT ROUNDED =                            15320000
153300          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2     15330000
153400     END-IF.                                                      15340000
153500                                                                  15350000
153600 4000-SPECIAL-PROVIDER-EXIT.                                      15360000
153700      EXIT.                                                       15370000
153800                                                                  15380000
153900                                                                  15390000
154000***************************************************************   15400000
154100*   CALCULATE THE OUTLIER THRESHOLD                           *   15410000
154200*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *   15420000
154300*     IS GREATER THAN THE OUTLIER THRESHOLD                   *   15430000
154400*   SET RETURN CODE TO INDICATE OUTLIER PAYMENT METHOD        *   15440000
154500***************************************************************   15450000
154600 7000-CALC-OUTLIER.                                               15460000
154700***************************************************************   15470000
154800                                                                  15480000
154900     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =                      15490000
155000         PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT.                  15500000
155100                                                                  15510000
155200     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD                     15520000
155300        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =                     15530000
155400         ((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)           15540000
155500           * PPS-BDGT-NEUT-RATE * H-BLEND-PPS.                    15550000
155600                                                                  15560000
155700     IF B-SPEC-PAY-IND = '1'                                      15570000
155800        MOVE 0 TO PPS-OUTLIER-PAY-AMT.                            15580000
155900                                                                  15590000
156000     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 21                  15600000
156100        MOVE 24 TO PPS-RTC.                                       15610000
156200                                                                  15620000
156300     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 22                  15630000
156400        MOVE 25 TO PPS-RTC.                                       15640000
156500                                                                  15650000
156600     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 26                  15660000
156700        MOVE 27 TO PPS-RTC.                                       15670000
156800                                                                  15680000
156900     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 00                  15690000
157000        MOVE 01 TO PPS-RTC.                                       15700000
157100                                                                  15710000
157200     IF (PPS-RTC = 00 OR 20 OR 21 OR 22 OR 26)                    15720000
157300        IF PPS-REG-DAYS-USED > H-SSOT                             15730000
157400           MOVE 0 TO PPS-LTR-DAYS-USED                            15740000
157500        ELSE                                                      15750000
157600           NEXT SENTENCE.                                         15760000
157700                                                                  15770000
157800     IF (PPS-RTC = 01 OR 24 OR 25 OR 27) OR                       15780000
157900        (PPS-COT-IND = 'Y')                                       15790000
158000                                                                  15800000
158100        IF (B-COV-DAYS < H-LOS) OR                                15810000
158200           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)15820000
158300           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =                   15830000
158400             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO      15840000
158500                                                                  15850000
158600*** ------------------------------------------------------- ***   15860000
158700*** SET PPS-RTC TO 67 IN MAINFRAME PRICER, NOT IN PC PRICER ***   15870000
158800*** (IN PC PRICER, PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS)   ***   15880000
158900*** ------------------------------------------------------- ***   15890000
159000           IF NOT PC-PRICER                                       15900000
159100              MOVE 67 TO PPS-RTC                                  15910000
159200           END-IF                                                 15920000
159300                                                                  15930000
159400        ELSE                                                      15940000
159500           NEXT SENTENCE                                          15950000
159600        END-IF                                                    15960000
159700     ELSE                                                         15970000
159800        NEXT SENTENCE                                             15980000
159900     END-IF.                                                      15990000
160000                                                                  16000000
160100                                                                  16010000
160200 7000-EXIT.                                                       16020000
160300      EXIT.                                                       16030000
160400                                                                  16040000
160500                                                                  16050000
160600***************************************************************   16060000
160700*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *   16070000
160800*   SET RTC FOR SPECIFIED BLEND YEAR INDICATOR.               *   16080000
160900***************************************************************   16090000
161000 8000-BLEND.                                                      16100000
161100***************************************************************   16110000
161200                                                                  16120000
161300     COMPUTE H-LOS-RATIO ROUNDED = H-LOS / PPS-AVG-LOS.           16130000
161400                                                                  16140000
161500     IF H-LOS-RATIO > 1                                           16150000
161600        COMPUTE H-LOS-RATIO = ((H-LOS-RATIO - 1) * .8) + 1.       16160000
161700                                                                  16170000
161800     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =                        16180000
161900           (PPS-DRG-ADJ-PAY-AMT * PPS-BDGT-NEUT-RATE)             16190000
162000             * H-BLEND-PPS.                                       16200000
162100                                                                  16210000
162200     COMPUTE PPS-NEW-FAC-SPEC-RATE ROUNDED =                      16220000
162300            (P-NEW-FAC-SPEC-RATE * PPS-BDGT-NEUT-RATE)            16230000
162400              * H-BLEND-FAC * H-LOS-RATIO.                        16240000
162500                                                                  16250000
162600     COMPUTE PPS-FINAL-PAY-AMT =                                  16260000
162700          PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT               16270000
162800              + PPS-NEW-FAC-SPEC-RATE.                            16280000
162900                                                                  16290000
163000                                                                  16300000
163100*----------------------------------------------------------*      16310000
163200* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/O OUTLIER *      16320000
163300*----------------------------------------------------------*      16330000
163400     IF (PPS-RTC = 20 OR 21 OR 22 OR 26) AND (H-BLEND-RTC > 0)    16340000
163500          COMPUTE PPS-RTC = H-BLEND-RTC + 2                       16350000
163600                                                                  16360000
163700*----------------------------------------------------------*      16370000
163800* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/ OUTLIER  *      16380000
163900*----------------------------------------------------------*      16390000
164000     ELSE                                                         16400000
164100        IF (PPS-RTC = 24 OR 25 OR 27) AND (H-BLEND-RTC > 0)       16410000
164200           COMPUTE PPS-RTC = H-BLEND-RTC + 3                      16420000
164300                                                                  16430000
164400*----------------------------------------------------------*      16440000
164500* CALCULATE RETURN CODE FOR ALL OTHER BILLS                *      16450000
164600*----------------------------------------------------------*      16460000
164700        ELSE                                                      16470000
164800           ADD H-BLEND-RTC TO PPS-RTC                             16480000
164900                                                                  16490000
165000        END-IF                                                    16500000
165100     END-IF.                                                      16510000
165200                                                                  16520000
165300 8000-EXIT.                                                       16530000
165400      EXIT.                                                       16540000
165500                                                                  16550000
165600                                                                  16560000
165700***************************************************************   16570000
165800 9000-MOVE-RESULTS.                                               16580000
165900***************************************************************   16590000
166000                                                                  16600000
166100     IF PPS-RTC < 50                                              16610000
166200        MOVE H-LOS TO PPS-LOS                                     16620000
166300        MOVE CAL-VERSION TO PPS-CALC-VERS-CD                      16630000
166400     ELSE                                                         16640000
166500       INITIALIZE PPS-DATA                                        16650000
166600       INITIALIZE PPS-OTHER-DATA                                  16660000
166700                                                                  16670000
166800*** ----------------------------------- ***                       16680000
166900*** ADDED FOR JULY 2006 RELEASE (V07.1) ***                       16690000
167000*** ----------------------------------- ***                       16700000
167100       INITIALIZE PPS-CBSA                                        16710000
167200       INITIALIZE HOLD-PPS-COMPONENTS                             16720000
167300                                                                  16730000
167400       MOVE CAL-VERSION TO PPS-CALC-VERS-CD                       16740000
167500     END-IF.                                                      16750000
167600                                                                  16760000
167700                                                                  16770000
167800*** *************************************************** ***       16780000
167900*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***       16790000
168000*** *************************************************** ***       16800000
168100*                                                                 16810000
168200*    IF (B-PROVIDER-NO = '191101' OR                              16820000
168300*                        '191102' OR                              16830000
168400*                        '371103' OR                              16840000
168500*                        '361104' OR                              16850000
168600*                        '371105' OR                              16860000
168700*                        '401106')                                16870000
168900*                                                                 16880000
169000*     DISPLAY '---------------------------------------------'     16890000
169100*     DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO           16900000
169200*     DISPLAY 'PPS-RTC '                  PPS-RTC                 16910000
169300*     DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT       16920000
169400*     DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE        16930000
169500*     DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES           16940000
169600*     DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD   16950000
169700*     DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT         16960000
169800*     DISPLAY 'PPS-CBSA '                 PPS-CBSA                16970000
169900*     DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX          16980000
170000*     DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX       16990000
170100*     DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX       17000000
170200*     DISPLAY 'MES-SSRFBN-RATE '          MES-SSRFBN-RATE         17010000
170300*     DISPLAY 'MES-SSRFBN-STATE '         MES-SSRFBN-STATE        17020000
170400*     DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX    17030000
170500*     DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT     17040000
170600*     DISPLAY 'B-DRG-CODE '               B-DRG-CODE              17050000
170700*     DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS             17060000
170800*     DISPLAY 'H-SSOT '                   H-SSOT                  17070000
170900*     DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT        17080000
171000**    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH            17090000
171100*     DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT     17100000
171200*     DISPLAY 'H-LOS '                    H-LOS                   17110000
171300*     DISPLAY 'H-REG-DAYS '               H-REG-DAYS              17120000
171400*     DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS            17130000
171500*     DISPLAY 'H-SSOT '                   H-SSOT                  17140000
171600*     DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC             17150000
171700*     DISPLAY 'H-BLEND-FAC '              H-BLEND-FAC             17160000
171800*     DISPLAY 'H-BLEND-PPS '              H-BLEND-PPS             17170000
171900*     DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT            17180000
172000*     DISPLAY 'H-SS-COST '                H-SS-COST               17190000
172100*     DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION         17200000
172200*     DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION      17210000
172300*     DISPLAY 'H-FIXED-LOSS-AMT '         H-FIXED-LOSS-AMT        17220000
172400*     DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE     17230000
172500*     DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO             17240000
172600*     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO          17250000
172700*     DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH        17260000
172800*     DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH        17270000
172900*     DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT        17280000
173000*     DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT        17290000
173100*     DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT        17300000
173200*     DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT        17310000
173300*     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO          17320000
173400*     DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO        17330000
173500*     DISPLAY 'H-BED-SIZE '               H-BED-SIZE              17340000
173600*     DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT          17350000
173700*     DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO             17360000
173800*     DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO        17370000
173900*     DISPLAY 'H-OPER-DSH '               H-OPER-DSH              17380000
174000*     DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH              17390000
174100*     DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS             17400000
174200*     DISPLAY 'H-URBAN-IND '              H-URBAN-IND             17410000
174300*     DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT    17420000
174400*     DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT 17430000
174500*     DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT              17440000
174600*     DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT           17450000
174700*     DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF              17460000
174800*     DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF           17470000
174900*     DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON         17480000
175000*     DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT          17490000
175100*     DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT       17500000
175200*     DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM         17510000
175300*     DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM      17520000
175400*     DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT        17530000
175500*     DISPLAY 'H-OPER-COLA '              H-OPER-COLA             17540000
175600*     DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA             17550000
175700*     DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR    17560000
175800*     DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR 17570000
175900*     DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR     17580000
176000*     DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR  17590000
176100*     DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT          17600000
176200*     DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS         17610000
176300*     DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF      17620000
176400*     DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS       17630000
176500*     DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE17640000
176600*     DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE 17650000
176700*     DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT      17660000
176800*     DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT       17670000
176900*     DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT 17680000
177000*     DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND           17690000
177100*     DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND        17700000
177200*     DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND          17710000
177300*     DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND       17720000
177400*                                                                 17730000
177500*    END-IF.                                                      17740000
177600*                                                                 17750000
177700 9000-EXIT.                                                       17760000
177800      EXIT.                                                       17770000
177900                                                                  17780000
178000******        L A S T   S O U R C E   S T A T E M E N T   *****   17790000
