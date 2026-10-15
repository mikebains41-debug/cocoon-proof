000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID.     LTCAL095.                                        00020001
000400*REMARKS.        CMS.                                             00040000
000500*                EFFECTIVE JUNE 3, 2009.                          00050006
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
001900     'LTCAL095      - W O R K I N G   S T O R A G E'.             00190001
002000 01  CAL-VERSION                    PIC X(05)  VALUE 'V09.5'.     00200001
002100 01  PROGRAM-CONSTANTS.                                           00210000
002200     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.     00220000
002300     05  FED-FY-BEGIN-04            PIC 9(08) VALUE 20031001.     00230000
002400     05  FED-FY-BEGIN-05            PIC 9(08) VALUE 20041001.     00240000
002500     05  FED-FY-BEGIN-06            PIC 9(08) VALUE 20051001.     00250000
002600     05  FED-FY-BEGIN-07            PIC 9(08) VALUE 20061001.     00260000
002700                                                                  00270000
002800                                                                  00280000
002900***************************************************************   00290000
003000*    LAYUP TABLE AREA FOR FY2009 LTC-DRG                      *   00300000
003100*    EFFECTIVE DATE OF JUNE 3, 2009                           *   00310006
003200***************************************************************   00320000
003300 COPY LTDRG095.                                                   00330002
003400                                                                  00340000
003500                                                                  00350000
003600***************************************************************   00360000
003700*    LAYUP TABLE AREA FOR FY2009 IPPS-DRG                     *   00370000
003800*    EFFECTIVE DATE OF OCTOBER 1, 2008                        *   00380000
003900***************************************************************   00390000
004000 COPY IPDRG090.                                                   00400000
004100                                                                  00410000
004200                                                                  00420000
004300***************************************************************   00430000
004400*    LAYUP TABLE AREA FOR FY2009 IPPS STATE SPECIFIC RFBNS    *   00440000
004500*    EFFECTIVE DATE OF OCTOBER 1, 2008                        *   00450000
004600***************************************************************   00460000
004700 COPY IRFBN091.                                                   00470000
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
055700*** RATES FOR LTCH PAYMENT: CHANGE IN JULY               ***      05570000
055800*** ---------------------------------------------------- ***      05580000
055900     MOVE .75662   TO PPS-NAT-LABOR-PCT.                          05590000
056000     MOVE .24338   TO PPS-NAT-NONLABOR-PCT.                       05600000
056100     MOVE 39114.36 TO PPS-STD-FED-RATE.                           05610000
056200     MOVE 22960.00 TO H-FIXED-LOSS-AMT.                           05620000
056300     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.                         05630000
056400                                                                  05640000
056500*** ---------------------------------------------------- ***      05650000
056600*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***      05660000
056700*** ---------------------------------------------------- ***      05670000
056800     MOVE 424.17 TO H-IPPS-CAPI-STD-FED-RATE.                     05680000
056900     MOVE 198.77 TO H-IPPS-CAPI-STD-PR-RATE.                      05690000
057000     MOVE 0.75   TO H-NAT-IPPS-PMT-PCT.                           05700000
057100     MOVE 0.25   TO H-PR-IPPS-PMT-PCT.                            05710000
057200                                                                  05720000
057300     IF H-IPPS-WAGE-INDEX > 1                                     05730000
057400        MOVE 3574.50 TO H-IPPS-NAT-LABOR-SHR                      05740000
057500        MOVE 1553.91 TO H-IPPS-NAT-NONLABOR-SHR                   05750000
057600     ELSE                                                         05760000
057700        MOVE 3179.61 TO H-IPPS-NAT-LABOR-SHR                      05770000
057800        MOVE 1948.80 TO H-IPPS-NAT-NONLABOR-SHR                   05780000
057900     END-IF.                                                      05790000
058000                                                                  05800000
058100     IF W-IPPS-PR-WAGE-INDEX > 1                                  05810000
058200        MOVE 1507.82 TO H-IPPS-PR-LABOR-SHR                       05820000
058300        MOVE  924.15 TO H-IPPS-PR-NONLABOR-SHR                    05830000
058400     ELSE                                                         05840000
058500        MOVE 1427.57 TO H-IPPS-PR-LABOR-SHR                       05850000
058600        MOVE 1004.40 TO H-IPPS-PR-NONLABOR-SHR                    05860000
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
080100     MOVE P-NEW-STATE          TO MES-PPS-STATE.                  08010000
080200                                                                  08020000
080300     PERFORM 1950-FIND-SSRFBN                                     08030000
080400        THRU 1950-EXIT.                                           08040000
080500                                                                  08050000
080600     IF PPS-RTC = 00                                              08060000
080650        IF  P-NEW-SPECIAL-PAY-IND = '1' OR '2'                    08070000
080700            COMPUTE H-IPPS-WAGE-INDEX ROUNDED =                   08080000
080800                    H-IPPS-WAGE-INDEX * 1                         08090000
080825        ELSE                                                      08091000
080850            COMPUTE H-IPPS-WAGE-INDEX ROUNDED =                   08092000
080875                    H-IPPS-WAGE-INDEX * MES-SSRFBN-RATE           08093000
080885        END-IF                                                    08094000
080900     END-IF.                                                      08095000
081000                                                                  08096000
081100 1900-EXIT.                                                       08097000
081200      EXIT.                                                       08098000
081300                                                                  08099000
081400                                                                  08100000
081500***************************************************************   08110000
081600*    FIND THE IPPS STATE SPECIFIC RURAL FLOOR BUDGET          *   08120000
081700*    NEUTRALITY FACTOR (SSRFBN)                               *   08130000
081800***************************************************************   08140000
081900 1950-FIND-SSRFBN.                                                08150000
082000***************************************************************   08160000
082100                                                                  08170000
082200     SET SSRFBN-IDX TO 1.                                         08180000
082300     SEARCH SSRFBN-TAB VARYING SSRFBN-IDX                         08190000
082400                                                                  08200000
082500         AT END                                                   08210000
082600           MOVE 68 TO PPS-RTC                                     08220000
082700           GO TO 1950-EXIT                                        08230000
082800                                                                  08240000
082900         WHEN WK-SSRFBN-STATE(SSRFBN-IDX) = MES-PPS-STATE         08250000
083000           MOVE WK-SSRFBN-REASON-ALL (SSRFBN-IDX) TO MES-SSRFBN.  08260000
083100                                                                  08270000
083200 1950-EXIT.                                                       08280000
083300      EXIT.                                                       08290000
083400                                                                  08300000
083500                                                                  08310000
083600***************************************************************   08320000
083700***  GET THE PROVIDER SPECIFIC VARIABLES AND WAGE INDEX       *   08330000
083800*                                                             *   08340000
083900*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *   08350000
084000*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *   08360000
084100*    OF THAT VARIABLE.                                        *   08370000
084200*                                                             *   08380000
084300***************************************************************   08390000
084400 2000-ASSEMBLE-PPS-VARIABLES.                                     08400000
084500***************************************************************   08410000
084600                                                                  08420000
084700                                                                  08430000
084800*------------------------------------------------------*          08440000
084900* WAGE INDEX BLEND TABLE                               *          08450000
085000*------------------------------------------------------*          08460000
085100*                                                      *          08470000
085200*  BLEND YEAR   FEDERAL FY                BLEND        *          08480000
085300*  ----------   ----------------------    -----        *          08490000
085400*      1        10/01/2002 - 09/30/2003    1/5         *          08500000
085500*      2        10/01/2003 - 09/30/2004    2/5         *          08510000
085600*      3        10/01/2004 - 09/30/2005    3/5         *          08520000
085700*      4        10/01/2005 - 09/30/2006    4/5         *          08530000
085800*      5        10/01/2006 - INDEFINITE    5/5 (FULL)  *          08540000
085900*                                                      *          08550000
086000*------------------------------------------------------*          08560000
086100*                                                      *          08570000
086200* A PROVIDER WILL RECEIVE THE APPLICABLE BLEND FOR A   *          08580000
086300* GIVEN FEDERAL FY FOR CLAIMS DISCHARGED ON & AFTER    *          08590000
086400* ITS FY BEGIN DATE THAT FALLS WITHIN THAT FEDERAL FY. *          08600000
086500*                                                      *          08610000
086600*------------------------------------------------------*          08620000
086700                                                                  08630000
086800                                                                  08640000
086900***************************************************************   08650000
087000* ASSIGN FULL (5/5) WAGE INDEX TO ALL CLAIMS DISCHARGED ON    *   08660000
087100* AND AFTER 7/1/2008 (NEW FOR VERSION 2008.0)                 *   08670000
087200***************************************************************   08680000
087300     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0               08690000
087400        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX                      08700000
087500     ELSE                                                         08710000
087600        MOVE 52 TO PPS-RTC                                        08720000
087700        GO TO 2000-EXIT                                           08730000
087800     END-IF.                                                      08740000
087900                                                                  08750000
088000                                                                  08760000
088100***************************************************************   08770000
088200* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *   08780000
088300* (ALWAYS FED-FY-BEGIN-03)                                    *   08790000
088400***************************************************************   08800000
088500      IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03                    08810000
088600         MOVE 74 TO PPS-RTC                                       08820000
088700         GO TO 2000-EXIT                                          08830000
088800      END-IF.                                                     08840000
088900                                                                  08850000
089000                                                                  08860000
089100***************************************************************   08870000
089200* USE SPECIAL WAGE INDEX WHEN INDICATED                       *   08880000
089300***************************************************************   08890000
089400     IF P-NEW-SPECIAL-PAY-IND = '1'                               08900000
089500        IF P-NEW-SPECIAL-WAGE-INDEX NUMERIC AND                   08910000
089600           P-NEW-SPECIAL-WAGE-INDEX > 0                           08920000
089700           MOVE P-NEW-SPECIAL-WAGE-INDEX TO PPS-WAGE-INDEX        08930000
089800        ELSE                                                      08940000
089900           MOVE 52 TO PPS-RTC                                     08950000
090000           GO TO 2000-EXIT                                        08960000
090100        END-IF                                                    08970000
090200     END-IF.                                                      08980000
090300                                                                  08990000
090400                                                                  09000000
090500***************************************************************   09010000
090600* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *   09020000
090700***************************************************************   09030000
090800     IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC                       09040000
090900        MOVE 65 TO PPS-RTC.                                       09050000
091000                                                                  09060000
091100                                                                  09070000
091200***************************************************************   09080000
091300* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *   09090000
091400***************************************************************   09100000
091500     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.              09110000
091600                                                                  09120000
091700     IF PPS-BLEND-YEAR > 0 AND PPS-BLEND-YEAR < 6                 09130000
091800        NEXT SENTENCE                                             09140000
091900     ELSE                                                         09150000
092000        MOVE 72 TO PPS-RTC                                        09160000
092100        GO TO 2000-EXIT.                                          09170000
092200                                                                  09180000
092300     MOVE 0 TO H-BLEND-FAC.                                       09190000
092400     MOVE 1 TO H-BLEND-PPS.                                       09200000
092500     MOVE 0 TO H-BLEND-RTC.                                       09210000
092600                                                                  09220000
092700     IF PPS-BLEND-YEAR = 1                                        09230000
092800        MOVE .8 TO H-BLEND-FAC                                    09240000
092900        MOVE .2 TO H-BLEND-PPS                                    09250000
093000        MOVE 4 TO H-BLEND-RTC                                     09260000
093100     ELSE                                                         09270000
093200       IF PPS-BLEND-YEAR = 2                                      09280000
093300          MOVE .6 TO H-BLEND-FAC                                  09290000
093400          MOVE .4 TO H-BLEND-PPS                                  09300000
093500          MOVE 8 TO H-BLEND-RTC                                   09310000
093600       ELSE                                                       09320000
093700         IF PPS-BLEND-YEAR = 3                                    09330000
093800            MOVE .4 TO H-BLEND-FAC                                09340000
093900            MOVE .6 TO H-BLEND-PPS                                09350000
094000            MOVE 12 TO H-BLEND-RTC                                09360000
094100         ELSE                                                     09370000
094200           IF PPS-BLEND-YEAR = 4                                  09380000
094300              MOVE .2 TO H-BLEND-FAC                              09390000
094400              MOVE .8 TO H-BLEND-PPS                              09400000
094500              MOVE 16 TO H-BLEND-RTC.                             09410000
094600                                                                  09420000
094700 2000-EXIT.                                                       09430000
094800      EXIT.                                                       09440000
094900                                                                  09450000
095000                                                                  09460000
095100***************************************************************   09470000
095200*    IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)           *   09480000
095300*        CALCULATE THE STANDARD PAYMENT AMOUNT.               *   09490000
095400*        CALCULATE THE SHORT-STAY OUTLIER AMOUNT.             *   09500000
095500***************************************************************   09510000
095600 3000-CALC-PAYMENT.                                               09520000
095700***************************************************************   09530000
095800                                                                  09540000
095900*** -------------------------------------------------- ***        09550000
096000*** FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII) ***        09560000
096100*** -------------------------------------------------- ***        09570000
096200     IF (P-NEW-STATE = 02 OR 12)                                  09580000
096300        MOVE P-NEW-COLA TO PPS-COLA                               09590000
096400     ELSE                                                         09600000
096500        MOVE 1.000 TO PPS-COLA                                    09610000
096600     END-IF.                                                      09620000
096700                                                                  09630000
096800                                                                  09640000
096900     COMPUTE PPS-FAC-COSTS ROUNDED =                              09650000
097000         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.                 09660000
097100                                                                  09670000
097200     COMPUTE H-LABOR-PORTION ROUNDED =                            09680000
097300         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)                   09690000
097400          * PPS-WAGE-INDEX.                                       09700000
097500                                                                  09710000
097600     COMPUTE H-NONLABOR-PORTION ROUNDED =                         09720000
097700         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)                09730000
097800          * PPS-COLA.                                             09740000
097900                                                                  09750000
098000     COMPUTE PPS-FED-PAY-AMT ROUNDED =                            09760000
098100         (H-LABOR-PORTION + H-NONLABOR-PORTION).                  09770000
098200                                                                  09780000
098300     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =                        09790000
098400         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).                    09800000
098500                                                                  09810000
098600                                                                  09820000
098700*** -------------------------------------------------------- ***  09830000
098800*** FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY ***  09840000
098900*** -------------------------------------------------------- ***  09850000
099000     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.         09860000
099100                                                                  09870000
099200*** --------------------------------------------- ***             09880000
099300*** DETERMINE WHETHER THE CLAIM IS A SHORT STAY   ***             09890000
099400*** --------------------------------------------- ***             09900000
099500*** H-SSOT ROUNDED AND EXPANDED TO 1 DECIMAL      ***             09910000
099600*** PLACE FOR RELEASE 07.1                        ***             09920000
099700*** --------------------------------------------- ***             09930000
099800     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.              09940000
099900     IF H-LOS <= H-SSOT                                           09950000
100000        PERFORM 3400-SHORT-STAY                                   09960000
100100           THRU 3400-SHORT-STAY-EXIT.                             09970000
100200                                                                  09980000
100300 3000-EXIT.                                                       09990000
100400      EXIT.                                                       10000000
100500                                                                  10010000
100600                                                                  10020000
100700***************************************************************   10030000
100800*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *   10040000
100900*      OF THE AVG. LENGTH OF STAY THEN:                       *   10050000
101000*      - CALCULATE THE SHORT-STAY COST.                       *   10060000
101100*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *   10070000
101200*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *   10080000
101300*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *   10090000
101400*      - PAY THE LEAST OF:                                    *   10100000
101500*          1)SHORT STAY COST                                  *   10110000
101600*          2)SHORT STAY PAYMENT AMOUNT                        *   10120000
101700*          3)DRG ADJUSTED PAYMENT AMOUNT                      *   10130000
101800*          4)SHORT STAY BLENDED PAYMENT -OR-                  *   10140000
101900*          5)IPPS COMPARABLE AMOUNT                           *   10150000
102000*      - SET RETURN CODE TO INDICATE SHORT STAY PAYMENT TYPE  *   10160000
102100***************************************************************   10170000
102200 3400-SHORT-STAY.                                                 10180000
102300***************************************************************   10190000
102400                                                                  10200000
102500**************************************************************    10210000
102600*                                                            *    10220000
102700*   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *    10230000
102800*                                                            *    10240000
102900**************************************************************    10250000
103000     IF P-NEW-PROVIDER-NO = '332006'                              10260000
103100        PERFORM 4000-SPECIAL-PROVIDER                             10270000
103200           THRU 4000-SPECIAL-PROVIDER-EXIT                        10280000
103300                                                                  10290000
103400     ELSE                                                         10300000
103500                                                                  10310000
103600                                                                  10320000
103700**************************************************************    10330000
103800*                                                            *    10340000
103900*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *    10350000
104000* ---------------------------------------------------------- *    10360000
104100*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *    10370000
104200*                                                            *    10380000
104300**************************************************************    10390000
104400        MOVE PPS-FAC-COSTS TO H-SS-COST                           10400000
104500                                                                  10410000
104600                                                                  10420000
104700**************************************************************    10430000
104800*                                                            *    10440000
104900*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *    10450000
105000* ---------------------------------------------------------- *    10460000
105100*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *    10470000
105200*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *    10480000
105300*     THE LENGTH OF STAY IS CORRECT                          *    10490000
105400*                                                            *    10500000
105500**************************************************************    10510000
105600        COMPUTE H-SS-PAY-AMT ROUNDED =                            10520000
105700         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2      10530000
105800                                                                  10540000
105900                                                                  10550000
106000**************************************************************    10560000
106100*                                                            *    10570000
106200*   SHORT STAY PROVISION #4 (BLEND OF SS PMT & IPPS          *    10580000
106300*   COMPARABLE PER DIEM AMT)                                 *    10590000
106400* ---------------------------------------------------------- *    10600000
106500*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *    10610000
106600*   REMOVED FROM VERSION 09.0 BECAUSE CLAIMS DISCHARGED ON   *    10620000
106700*   AND AFTER 12/29/2008 ARE NOT ELIGIBLE FOR PROVISION #5.  *    10630000
106800*                                                            *    10640000
106900**************************************************************    10650000
107000        IF H-IPPS-WAGE-INDEX NUMERIC AND                          10660000
107100           H-IPPS-WAGE-INDEX > 0                                  10670000
107200           PERFORM 3600-SS-BLENDED-PMT                            10680000
107300              THRU 3600-SS-BLENDED-PMT-EXIT                       10690000
107400        ELSE                                                      10700000
107500           MOVE 52 TO PPS-RTC                                     10710000
107600           GO TO 3400-SHORT-STAY-EXIT                             10720000
107700        END-IF                                                    10730000
107800     END-IF.                                                      10740000
107900                                                                  10750000
108000                                                                  10760000
108100**************************************************************    10770000
108200*                                                            *    10780000
108300*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *    10790000
108400*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *    10800000
108500* ---------------------------------------------------------- *    10810000
108600*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *    10820000
108700*                                                            *    10830000
108800**************************************************************    10840000
108900                                                                  10850000
109000     MOVE 'N' TO H-SS-COST-IND.                                   10860000
109100     MOVE 'N' TO H-SS-PERDIEM-IND.                                10870000
109200     MOVE 'N' TO H-SS-BLEND-IND.                                  10880000
109300     MOVE 'N' TO H-SS-IPPSCOMP-IND.                               10890000
109400                                                                  10900000
109500*---------------------------------------------------------        10910000
109600*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%          10920000
109700*   OF PER DIEM) AND DRG ADJUSTED PMT AMT                         10930000
109800*---------------------------------------------------------        10940000
109900     IF H-SS-COST < H-SS-PAY-AMT                                  10950000
110000        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT                        10960000
110100           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT                  10970000
110200           MOVE 20 TO PPS-RTC                                     10980000
110300           MOVE 'Y' TO H-SS-COST-IND                              10990000
110400        ELSE                                                      11000000
110500           NEXT SENTENCE                                          11010000
110600        END-IF                                                    11020000
110700     ELSE                                                         11030000
110800        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT                     11040000
110900           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT               11050000
111000           MOVE 21 TO PPS-RTC                                     11060000
111100           MOVE 'Y' TO H-SS-PERDIEM-IND                           11070000
111200        ELSE                                                      11080000
111300           NEXT SENTENCE                                          11090000
111400        END-IF                                                    11100000
111500     END-IF.                                                      11110000
111600                                                                  11120000
111700*---------------------------------------------------------        11130000
111800*   USE THE BLENDED PMT IF LESS THAN THE OTHER SHORT STAY         11140000
111900*   OPTIONS                                                       11150000
112000*---------------------------------------------------------        11160000
112100     IF P-NEW-PROVIDER-NO NOT = '332006'                          11170000
112200        IF H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT                 11180000
112300           MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT           11190000
112400           MOVE 22 TO PPS-RTC                                     11200000
112500           MOVE 'Y' TO H-SS-BLEND-IND                             11210000
112600           MOVE 'N' TO H-SS-COST-IND                              11220000
112700           MOVE 'N' TO H-SS-PERDIEM-IND                           11230000
112800           MOVE 'N' TO H-SS-IPPSCOMP-IND                          11240000
112900        END-IF                                                    11250000
113000     END-IF.                                                      11260000
113100                                                                  11270000
113200 3400-SHORT-STAY-EXIT.                                            11280000
113300      EXIT.                                                       11290000
113400                                                                  11300000
113500                                                                  11310000
113600***************************************************************   11320000
113700*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *   11330000
113800*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *   11340000
113900*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *   11350000
114000*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *   11360000
114100***************************************************************   11370000
114200 3600-SS-BLENDED-PMT.                                             11380000
114300***************************************************************   11390000
114400                                                                  11400000
114500*** ------------------------------------------------------ ***    11410000
114600*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***    11420000
114700*** ------------------------------------------------------ ***    11430000
114800     IF H-SSOT < 25                                               11440000
114900        COMPUTE H-LTCH-BLEND-PCT ROUNDED =                        11450000
115000          H-LOS / H-SSOT                                          11460000
115100     ELSE                                                         11470000
115200        COMPUTE H-LTCH-BLEND-PCT ROUNDED =                        11480000
115300          H-LOS / 25                                              11490000
115400     END-IF.                                                      11500000
115500                                                                  11510000
115600     IF H-LTCH-BLEND-PCT > 1                                      11520000
115700        MOVE 1 TO H-LTCH-BLEND-PCT                                11530000
115800     END-IF.                                                      11540000
115900                                                                  11550000
116000                                                                  11560000
116100*** ------------------------------------------------------ ***    11570000
116200*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***    11580000
116300*** ------------------------------------------------------ ***    11590000
116400     COMPUTE H-LTCH-BLEND-AMT ROUNDED =                           11600000
116500        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.                          11610000
116600                                                                  11620000
116700                                                                  11630000
116800*** ------------------------------------------------------ ***    11640000
116900*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***    11650000
117000*** ------------------------------------------------------ ***    11660000
117100     PERFORM 3650-SS-IPPS-COMP-PMT                                11670000
117200        THRU 3650-SS-IPPS-COMP-PMT-EXIT.                          11680000
117300                                                                  11690000
117400                                                                  11700000
117500*** ------------------------------------------------------ ***    11710000
117600*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***    11720000
117700*** ------------------------------------------------------ ***    11730000
117800     COMPUTE H-IPPS-BLEND-PCT ROUNDED =                           11740000
117900       1 - H-LTCH-BLEND-PCT.                                      11750000
118000                                                                  11760000
118100                                                                  11770000
118200*** ------------------------------------------------------ ***    11780000
118300*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***    11790000
118400*** ------------------------------------------------------ ***    11800000
118500     COMPUTE H-IPPS-BLEND-AMT ROUNDED =                           11810000
118600       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.                        11820000
118700                                                                  11830000
118800                                                                  11840000
118900*** ------------------------------------------------------ ***    11850000
119000*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***    11860000
119100*** ------------------------------------------------------ ***    11870000
119200     COMPUTE H-SS-BLENDED-PMT ROUNDED =                           11880000
119300       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.                       11890000
119400                                                                  11900000
119500                                                                  11910000
119600 3600-SS-BLENDED-PMT-EXIT.                                        11920000
119700      EXIT.                                                       11930000
119800                                                                  11940000
119900                                                                  11950000
120000***************************************************************   11960000
120100*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *   11970000
120200*   PER DIEM PAYMENT AMOUNT                                   *   11980000
120300***************************************************************   11990000
120400 3650-SS-IPPS-COMP-PMT.                                           12000000
120500***************************************************************   12010000
120600                                                                  12020000
120700*** -------------------------------------------------------       12030000
120800*** OPERATING TEACHING ADJUSTMENT                                 12040000
120900*** -------------------------------------------------------       12050000
121000     COMPUTE H-OPER-IME-TEACH ROUNDED =                           12060000
121100        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).                12070000
121200                                                                  12080000
121300                                                                  12090000
121400*** -------------------------------------------------------       12100000
121500*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)              12110000
121600*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%        12120000
121650*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL       12130000
121675***              THIS CHANGE IS RETROACTIVE TO 10/01/2008         12140000
121700*** -------------------------------------------------------       12150000
121800     IF H-CAPI-IME-RATIO > 1.5000                                 12160000
121900        MOVE 1.5000 TO H-CAPI-IME-RATIO.                          12170000
122000                                                                  12180000
122100     COMPUTE H-CAPI-IME-TEACH ROUNDED =                           12190000
122200        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).             12200000
122300                                                                  12210000
122400                                                                  12220000
122500*** -------------------------------------------------------       12230000
122600*** OPERATING DSH ADJUSTMENT                                      12240000
122700*** -------------------------------------------------------       12250000
122800                                                                  12260000
122900*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL              12270000
123000*---------------------------------------------------              12280000
123100     IF ALL-RURAL                                                 12290000
123200        SET RURAL-CBSA TO TRUE                                    12300000
123300     ELSE                                                         12310000
123400        SET URBAN-CBSA TO TRUE                                    12320000
123500     END-IF.                                                      12330000
123600                                                                  12340000
123700                                                                  12350000
123800*2) CALCULATE THE OPERATING DSH PERCENT                           12360000
123900*--------------------------------------                           12370000
124000     COMPUTE H-OPER-DSH-PCT ROUNDED =                             12380000
124100        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.                   12390000
124200                                                                  12400000
124300                                                                  12410000
124400*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION            12420000
124500*-----------------------------------------------------            12430000
124600                                                                  12440000
124700*    URBAN, < 100 BEDS                                            12450000
124800*    -----------------                                            12460000
124900     IF URBAN-CBSA AND H-BED-SIZE < 100 AND                       12470000
125000        H-OPER-DSH-PCT >= .15                                     12480000
125100          MOVE '3' TO H-GEO-CLASS                                 12490000
125200     ELSE                                                         12500000
125300                                                                  12510000
125400                                                                  12520000
125500*   URBAN, >= 100 BEDS                                            12530000
125600*   ------------------                                            12540000
125700       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND                    12550000
125800          H-OPER-DSH-PCT >= .15                                   12560000
125900            MOVE '2' TO H-GEO-CLASS                               12570000
126000       ELSE                                                       12580000
126100                                                                  12590000
126200                                                                  12600000
126300*   RURAL, >= 500 BEDS                                            12610000
126400*   ------------------                                            12620000
126500         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND                  12630000
126600            H-OPER-DSH-PCT >= .15                                 12640000
126700              MOVE '2' TO H-GEO-CLASS                             12650000
126800         ELSE                                                     12660000
126900                                                                  12670000
127000                                                                  12680000
127100*   RURAL, < 500 BEDS                                             12690000
127200*   -----------------                                             12700000
127300           IF RURAL-CBSA AND H-BED-SIZE < 500 AND                 12710000
127400              H-OPER-DSH-PCT >= .15                               12720000
127500                MOVE '3' TO H-GEO-CLASS                           12730000
127600           ELSE                                                   12740000
127700                                                                  12750000
127800                                                                  12760000
127900*   OTHER                                                         12770000
128000*   -----------------                                             12780000
128100              MOVE '4' TO H-GEO-CLASS                             12790000
128200                                                                  12800000
128300           END-IF                                                 12810000
128400         END-IF                                                   12820000
128500       END-IF                                                     12830000
128600     END-IF.                                                      12840000
128700                                                                  12850000
128800                                                                  12860000
128900*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS      12870000
129000*-----------------------------------------------------------      12880000
129100     EVALUATE H-GEO-CLASS                                         12890000
129200                                                                  12900000
129300*      GEOGRAPHIC CLASS 2                                         12910000
129400*      ------------------                                         12920000
129500       WHEN '2'                                                   12930000
129600          IF (H-OPER-DSH-PCT >= .15 AND <= .202)                  12940000
129700             COMPUTE H-OPER-DSH ROUNDED =                         12950000
129800               ((H-OPER-DSH-PCT - .15) * .65) + .025              12960000
129900          ELSE                                                    12970000
130000             IF H-OPER-DSH-PCT > .202                             12980000
130100                COMPUTE H-OPER-DSH ROUNDED =                      12990000
130200                  ((H-OPER-DSH-PCT - .202) * .825) + .0588        13000000
130300             ELSE                                                 13010000
130400                MOVE ZEROS TO H-OPER-DSH                          13020000
130500             END-IF                                               13030000
130600          END-IF                                                  13040000
130700                                                                  13050000
130800*      GEOGRAPHIC CLASS 3                                         13060000
130900*      ------------------                                         13070000
131000       WHEN '3'                                                   13080000
131100          IF (H-OPER-DSH-PCT >= .15 AND <= .202)                  13090000
131200             COMPUTE H-OPER-DSH ROUNDED =                         13100000
131300               ((H-OPER-DSH-PCT - .15) * .65) + .025              13110000
131400             IF H-OPER-DSH > .12                                  13120000
131500                MOVE .12 TO H-OPER-DSH                            13130000
131600             END-IF                                               13140000
131700          ELSE                                                    13150000
131800             IF H-OPER-DSH-PCT > .202                             13160000
131900                COMPUTE H-OPER-DSH ROUNDED =                      13170000
132000                  ((H-OPER-DSH-PCT - .202) * .825) + .0588        13180000
132100                IF H-OPER-DSH > .12                               13190000
132200                   MOVE .12 TO H-OPER-DSH                         13200000
132300                END-IF                                            13210000
132400             ELSE                                                 13220000
132500               MOVE ZEROS TO H-OPER-DSH                           13230000
132600             END-IF                                               13240000
132700          END-IF                                                  13250000
132800                                                                  13260000
132900*      GEOGRAPHIC CLASS 4                                         13270000
133000*      ------------------                                         13280000
133100       WHEN '4'                                                   13290000
133200          MOVE ZEROS TO H-OPER-DSH                                13300000
133300                                                                  13310000
133400     END-EVALUATE.                                                13320000
133500                                                                  13330000
133600                                                                  13340000
133700*** -------------------------------------------------------       13350000
133800*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)                   13360000
133900*** -------------------------------------------------------       13370000
134000     IF URBAN-CBSA AND H-BED-SIZE >= 100                          13380000
134100        COMPUTE H-CAPI-DSH ROUNDED =                              13390000
134200          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1                  13400000
134300     ELSE                                                         13410000
134400        MOVE ZEROS TO H-CAPI-DSH                                  13420000
134500     END-IF.                                                      13430000
134600                                                                  13440000
134700                                                                  13450000
134800*** -------------------------------------------------------       13460000
134900*** OPERATING PAYMENT (STANDARD AMOUNT)                           13470000
135000*** -------------------------------------------------------       13480000
135100     IF (P-NEW-STATE = 02 OR 12)                                  13490000
135200        MOVE P-NEW-COLA TO H-OPER-COLA                            13500000
135300     ELSE                                                         13510000
135400        MOVE 1.000 TO H-OPER-COLA                                 13520000
135500     END-IF.                                                      13530000
135600                                                                  13540000
135700     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =                       13550000
135800       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +             13560000
135900         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *              13570000
136000         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).   13580000
136100                                                                  13590000
136200                                                                  13600000
136300*** -------------------------------------------------------       13610000
136400*** CAPITAL PAYMENT (CAPITAL RATE)                                13620000
136500*** -------------------------------------------------------       13630000
136600     COMPUTE H-CAPI-COLA ROUNDED =                                13640000
136700       (.3152 * (H-OPER-COLA - 1) + 1).                           13650000
136800                                                                  13660000
136900*--------------------------------------------------------------*  13670000
137000*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *  13680000
137100*   LATER (CHANGED FROM 1.03 TO 1.00)                          *  13690000
137200*--------------------------------------------------------------*  13700000
137300     IF LARGE-URBAN                                               13710000
137400        MOVE 1.00 TO H-LRGURB-ADD-ON                              13720000
137500     ELSE                                                         13730000
137600        MOVE 1.00 TO H-LRGURB-ADD-ON                              13740000
137700     END-IF.                                                      13750000
137800                                                                  13760000
137900     COMPUTE H-CAPI-GAF ROUNDED =                                 13770000
138000       (H-IPPS-WAGE-INDEX ** .6848).                              13780000
138100                                                                  13790000
138200     COMPUTE H-CAPI-PMT ROUNDED =                                 13800000
138300       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *   13810000
138400       H-LRGURB-ADD-ON *  H-CAPI-COLA *                           13820000
138500       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).                       13830000
138600                                                                  13840000
138700                                                                  13850000
138800*** -------------------------------------------------------       13860000
138900*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)           13870000
139000*** -------------------------------------------------------       13880000
139100     COMPUTE H-IPPS-PAY-AMT ROUNDED =                             13890000
139200       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.                         13900000
139300                                                                  13910000
139400                                                                  13920000
139500*** -------------------------------------------------------       13930000
139600*** IPPS COMPARABLE PER DIEM PAYMENT                              13940000
139700*** -------------------------------------------------------       13950000
139800     COMPUTE H-IPPS-PER-DIEM ROUNDED =                            13960000
139900       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.                13970000
140000                                                                  13980000
140100     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT                          13990000
140200        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM                    14000000
140300     END-IF.                                                      14010000
140400                                                                  14020000
140500*** -------------------------------------------------------       14030000
140600*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS                   14040000
140700*** -------------------------------------------------------       14050000
140800     IF P-NEW-STATE = 40                                          14060000
140900        PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT           14070000
141000     END-IF.                                                      14080000
141100                                                                  14090000
141200                                                                  14100000
141300 3650-SS-IPPS-COMP-PMT-EXIT.                                      14110000
141400      EXIT.                                                       14120000
141500                                                                  14130000
141600                                                                  14140000
141700***************************************************************   14150000
141800 3675-SS-IPPS-COMP-PR-PMT.                                        14160000
141900***************************************************************   14170000
142000                                                                  14180000
142100*** -------------------------------------------------------       14190000
142200*** PUERTO RICO OPERATING PAYMENT (STANDARD AMOUNT)               14200000
142300*** -------------------------------------------------------       14210000
142400     COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =                    14220000
142500        ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +          14230000
142600          (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *              14240000
142700          H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).  14250000
142800                                                                  14260000
142900                                                                  14270000
143000*** -------------------------------------------------------       14280000
143100*** PUERTO RICO CAPITAL PAYMENT (CAPITAL RATE)                    14290000
143200*** -------------------------------------------------------       14300000
143300     COMPUTE H-PR-CAPI-GAF ROUNDED =                              14310000
143400        (W-IPPS-PR-WAGE-INDEX ** .6848).                          14320000
143500                                                                  14330000
143600     COMPUTE H-PR-CAPI-PMT ROUNDED =                              14340000
143700        H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *14350000
143800        H-LRGURB-ADD-ON * H-CAPI-COLA *                           14360000
143900        (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).                      14370000
144000                                                                  14380000
144100                                                                  14390000
144200*** -------------------------------------------------------       14400000
144300*** PR IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)        14410000
144400*** -------------------------------------------------------       14420000
144500     COMPUTE H-IPPS-PR-PAY-AMT ROUNDED =                          14430000
144600        H-PR-STAND-AMT-OPER-PMT + H-PR-CAPI-PMT.                  14440000
144700                                                                  14450000
144800                                                                  14460000
144900*** -------------------------------------------------------       14470000
145000*** PUERTO RICO IPPS COMPARABLE PER DIEM PAYMENT                  14480000
145100*** -------------------------------------------------------       14490000
145200     COMPUTE H-IPPS-PR-PER-DIEM ROUNDED =                         14500000
145300        (H-IPPS-PR-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.            14510000
145400                                                                  14520000
145500     IF H-IPPS-PR-PER-DIEM > H-IPPS-PR-PAY-AMT                    14530000
145600        MOVE H-IPPS-PR-PAY-AMT TO H-IPPS-PR-PER-DIEM              14540000
145700     END-IF.                                                      14550000
145800                                                                  14560000
145900                                                                  14570000
146000*** -------------------------------------------------------       14580000
146100*** BLEND FEDERAL PER DIEM AND PUERTO RICO PER DIEM               14590000
146200*** -------------------------------------------------------       14600000
146300     COMPUTE H-IPPS-PER-DIEM ROUNDED =                            14610000
146400        (H-IPPS-PER-DIEM    * H-NAT-IPPS-PMT-PCT) +               14620000
146500        (H-IPPS-PR-PER-DIEM * H-PR-IPPS-PMT-PCT ).                14630000
146600                                                                  14640000
146700                                                                  14650000
146800 3675-EXIT.                                                       14660000
146900      EXIT.                                                       14670000
147000                                                                  14680000
147100                                                                  14690000
147200***************************************************************   14700000
147300 4000-SPECIAL-PROVIDER.                                           14710000
147400***************************************************************   14720000
147500                                                                  14730000
147600*** PROCESS FOR CY2003                                            14740000
147700*** ------------------                                            14750000
147800     IF (B-DISCHARGE-DATE >= 20030701) AND                        14760000
147900        (B-DISCHARGE-DATE <  20040101)                            14770000
148000        COMPUTE H-SS-COST ROUNDED =                               14780000
148100            (PPS-FAC-COSTS * 1.95)                                14790000
148200        COMPUTE H-SS-PAY-AMT ROUNDED =                            14800000
148300         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95     14810000
148400     END-IF                                                       14820000
148500                                                                  14830000
148600                                                                  14840000
148700*** PROCESS FOR CY2004                                            14850000
148800*** ------------------                                            14860000
148900     IF (B-DISCHARGE-DATE >= 20040101) AND                        14870000
149000        (B-DISCHARGE-DATE <  20050101)                            14880000
149100        COMPUTE H-SS-COST ROUNDED =                               14890000
149200            (PPS-FAC-COSTS * 1.93)                                14900000
149300        COMPUTE H-SS-PAY-AMT ROUNDED =                            14910000
149400          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93    14920000
149500     END-IF                                                       14930000
149600                                                                  14940000
149700                                                                  14950000
149800*** PROCESS FOR CY2005                                            14960000
149900*** ------------------                                            14970000
150000     IF (B-DISCHARGE-DATE >= 20050101) AND                        14980000
150100        (B-DISCHARGE-DATE <  20060101)                            14990000
150200        COMPUTE H-SS-COST ROUNDED =                               15000000
150300            (PPS-FAC-COSTS * 1.65)                                15010000
150400        COMPUTE H-SS-PAY-AMT ROUNDED =                            15020000
150500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65    15030000
150600     END-IF                                                       15040000
150700                                                                  15050000
150800                                                                  15060000
150900*** PROCESS FOR CY2006                                            15070000
151000*** ------------------                                            15080000
151100     IF (B-DISCHARGE-DATE >= 20060101) AND                        15090000
151200        (B-DISCHARGE-DATE <  20070101)                            15100000
151300        COMPUTE H-SS-COST ROUNDED =                               15110000
151400            (PPS-FAC-COSTS * 1.36)                                15120000
151500        COMPUTE H-SS-PAY-AMT ROUNDED =                            15130000
151600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36    15140000
151700     END-IF                                                       15150000
151800                                                                  15160000
151900                                                                  15170000
152000*** PROCESS FOR CY2007 AND AFTER                                  15180000
152100*** ----------------------------                                  15190000
152200     IF (B-DISCHARGE-DATE >= 20070101)                            15200000
152300        COMPUTE H-SS-COST ROUNDED =                               15210000
152400            (PPS-FAC-COSTS * 1.2)                                 15220000
152500        COMPUTE H-SS-PAY-AMT ROUNDED =                            15230000
152600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2     15240000
152700     END-IF.                                                      15250000
152800                                                                  15260000
152900 4000-SPECIAL-PROVIDER-EXIT.                                      15270000
153000      EXIT.                                                       15280000
153100                                                                  15290000
153200                                                                  15300000
153300***************************************************************   15310000
153400*   CALCULATE THE OUTLIER THRESHOLD                           *   15320000
153500*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *   15330000
153600*     IS GREATER THAN THE OUTLIER THRESHOLD                   *   15340000
153700*   SET RETURN CODE TO INDICATE OUTLIER PAYMENT METHOD        *   15350000
153800***************************************************************   15360000
153900 7000-CALC-OUTLIER.                                               15370000
154000***************************************************************   15380000
154100                                                                  15390000
154200     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =                      15400000
154300         PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT.                  15410000
154400                                                                  15420000
154500     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD                     15430000
154600        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =                     15440000
154700         ((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)           15450000
154800           * PPS-BDGT-NEUT-RATE * H-BLEND-PPS.                    15460000
154900                                                                  15470000
155000     IF B-SPEC-PAY-IND = '1'                                      15480000
155100        MOVE 0 TO PPS-OUTLIER-PAY-AMT.                            15490000
155200                                                                  15500000
155300     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 21                  15510000
155400        MOVE 24 TO PPS-RTC.                                       15520000
155500                                                                  15530000
155600     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 22                  15540000
155700        MOVE 25 TO PPS-RTC.                                       15550000
155800                                                                  15560000
155900     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 26                  15570000
156000        MOVE 27 TO PPS-RTC.                                       15580000
156100                                                                  15590000
156200     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 00                  15600000
156300        MOVE 01 TO PPS-RTC.                                       15610000
156400                                                                  15620000
156500     IF (PPS-RTC = 00 OR 20 OR 21 OR 22 OR 26)                    15630000
156600        IF PPS-REG-DAYS-USED > H-SSOT                             15640000
156700           MOVE 0 TO PPS-LTR-DAYS-USED                            15650000
156800        ELSE                                                      15660000
156900           NEXT SENTENCE.                                         15670000
157000                                                                  15680000
157100     IF (PPS-RTC = 01 OR 24 OR 25 OR 27) OR                       15690000
157200        (PPS-COT-IND = 'Y')                                       15700000
157300                                                                  15710000
157400        IF (B-COV-DAYS < H-LOS) OR                                15720000
157500           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)15730000
157600           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =                   15740000
157700             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO      15750000
157800                                                                  15760000
157900*** ------------------------------------------------------- ***   15770000
158000*** SET PPS-RTC TO 67 IN MAINFRAME PRICER, NOT IN PC PRICER ***   15780000
158100*** (IN PC PRICER, PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS)   ***   15790000
158200*** ------------------------------------------------------- ***   15800000
158300           IF NOT PC-PRICER                                       15810000
158400              MOVE 67 TO PPS-RTC                                  15820000
158500           END-IF                                                 15830000
158600                                                                  15840000
158700        ELSE                                                      15850000
158800           NEXT SENTENCE                                          15860000
158900        END-IF                                                    15870000
159000     ELSE                                                         15880000
159100        NEXT SENTENCE                                             15890000
159200     END-IF.                                                      15900000
159300                                                                  15910000
159400                                                                  15920000
159500 7000-EXIT.                                                       15930000
159600      EXIT.                                                       15940000
159700                                                                  15950000
159800                                                                  15960000
159900***************************************************************   15970000
160000*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *   15980000
160100*   SET RTC FOR SPECIFIED BLEND YEAR INDICATOR.               *   15990000
160200***************************************************************   16000000
160300 8000-BLEND.                                                      16010000
160400***************************************************************   16020000
160500                                                                  16030000
160600     COMPUTE H-LOS-RATIO ROUNDED = H-LOS / PPS-AVG-LOS.           16040000
160700                                                                  16050000
160800     IF H-LOS-RATIO > 1                                           16060000
160900        COMPUTE H-LOS-RATIO = ((H-LOS-RATIO - 1) * .8) + 1.       16070000
161000                                                                  16080000
161100     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =                        16090000
161200           (PPS-DRG-ADJ-PAY-AMT * PPS-BDGT-NEUT-RATE)             16100000
161300             * H-BLEND-PPS.                                       16110000
161400                                                                  16120000
161500     COMPUTE PPS-NEW-FAC-SPEC-RATE ROUNDED =                      16130000
161600            (P-NEW-FAC-SPEC-RATE * PPS-BDGT-NEUT-RATE)            16140000
161700              * H-BLEND-FAC * H-LOS-RATIO.                        16150000
161800                                                                  16160000
161900     COMPUTE PPS-FINAL-PAY-AMT =                                  16170000
162000          PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT               16180000
162100              + PPS-NEW-FAC-SPEC-RATE.                            16190000
162200                                                                  16200000
162300                                                                  16210000
162400*----------------------------------------------------------*      16220000
162500* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/O OUTLIER *      16230000
162600*----------------------------------------------------------*      16240000
162700     IF (PPS-RTC = 20 OR 21 OR 22 OR 26) AND (H-BLEND-RTC > 0)    16250000
162800          COMPUTE PPS-RTC = H-BLEND-RTC + 2                       16260000
162900                                                                  16270000
163000*----------------------------------------------------------*      16280000
163100* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/ OUTLIER  *      16290000
163200*----------------------------------------------------------*      16300000
163300     ELSE                                                         16310000
163400        IF (PPS-RTC = 24 OR 25 OR 27) AND (H-BLEND-RTC > 0)       16320000
163500           COMPUTE PPS-RTC = H-BLEND-RTC + 3                      16330000
163600                                                                  16340000
163700*----------------------------------------------------------*      16350000
163800* CALCULATE RETURN CODE FOR ALL OTHER BILLS                *      16360000
163900*----------------------------------------------------------*      16370000
164000        ELSE                                                      16380000
164100           ADD H-BLEND-RTC TO PPS-RTC                             16390000
164200                                                                  16400000
164300        END-IF                                                    16410000
164400     END-IF.                                                      16420000
164500                                                                  16430000
164600 8000-EXIT.                                                       16440000
164700      EXIT.                                                       16450000
164800                                                                  16460000
164900                                                                  16470000
165000***************************************************************   16480000
165100 9000-MOVE-RESULTS.                                               16490000
165200***************************************************************   16500000
165300                                                                  16510000
165400     IF PPS-RTC < 50                                              16520000
165500        MOVE H-LOS TO PPS-LOS                                     16530000
165600        MOVE CAL-VERSION TO PPS-CALC-VERS-CD                      16540000
165700     ELSE                                                         16550000
165800       INITIALIZE PPS-DATA                                        16560000
165900       INITIALIZE PPS-OTHER-DATA                                  16570000
166000                                                                  16580000
166100*** ----------------------------------- ***                       16590000
166200*** ADDED FOR JULY 2006 RELEASE (V07.1) ***                       16600000
166300*** ----------------------------------- ***                       16610000
166400       INITIALIZE PPS-CBSA                                        16620000
166500       INITIALIZE HOLD-PPS-COMPONENTS                             16630000
166600                                                                  16640000
166700       MOVE CAL-VERSION TO PPS-CALC-VERS-CD                       16650000
166800     END-IF.                                                      16660000
166900                                                                  16670000
167000                                                                  16680000
167100*** *************************************************** ***       16690000
167200*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***       16700000
167300*** *************************************************** ***       16710000
167400                                                                  16720004
167500*    IF (B-PROVIDER-NO = '09501A' OR                              16730008
167510*                        '09501B' OR                              16731008
167600*                        '095002' OR                              16740008
167700*                        '095003' OR                              16750008
167800*                        '09504A' OR                              16760008
167900*                        '09504B' OR                              16770008
167910*                        '095005' OR                              16780008
167920*                        '095006' OR                              16790008
168000*                        '120795' OR                              16800008
168100*                        '400795' OR                              16810008
168110*                        '095008'  )                              16811008
168200*                                                                 16820008
168300*     DISPLAY '---------------------------------------------'     16830008
168400*     DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO           16840008
168500*     DISPLAY 'PPS-RTC '                  PPS-RTC                 16850008
168600*     DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT       16860008
168700*     DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE        16870008
168800*     DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES           16880008
168900*     DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD   16890008
169000*     DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT         16900008
169100*     DISPLAY 'PPS-CBSA '                 PPS-CBSA                16910008
169200*     DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX          16920008
169300*     DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX       16930008
169400*     DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX       16940008
169500*     DISPLAY 'MES-SSRFBN-RATE '          MES-SSRFBN-RATE         16950008
169600*     DISPLAY 'MES-SSRFBN-STATE '         MES-SSRFBN-STATE        16960008
169700*     DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX    16970008
169800*     DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT     16980008
169900*     DISPLAY 'B-DRG-CODE '               B-DRG-CODE              16990008
170000*     DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS             17000008
170100*     DISPLAY 'H-SSOT '                   H-SSOT                  17010008
170200*     DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT        17020008
170300**    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH            17030000
170400*     DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT     17040008
170500*     DISPLAY 'H-LOS '                    H-LOS                   17050008
170600*     DISPLAY 'H-REG-DAYS '               H-REG-DAYS              17060008
170700*     DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS            17070008
170800*     DISPLAY 'H-SSOT '                   H-SSOT                  17080008
170900*     DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC             17090008
171000*     DISPLAY 'H-BLEND-FAC '              H-BLEND-FAC             17100008
171100*     DISPLAY 'H-BLEND-PPS '              H-BLEND-PPS             17110008
171200*     DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT            17120008
171300*     DISPLAY 'H-SS-COST '                H-SS-COST               17130008
171400*     DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION         17140008
171500*     DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION      17150008
171600*     DISPLAY 'H-FIXED-LOSS-AMT '         H-FIXED-LOSS-AMT        17160008
171700*     DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE     17170008
171800*     DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO             17180008
171900*     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO          17190008
172000*     DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH        17200008
172100*     DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH        17210008
172200*     DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT        17220008
172300*     DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT        17230008
172400*     DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT        17240008
172500*     DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT        17250008
172600*     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO          17260008
172700*     DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO        17270008
172800*     DISPLAY 'H-BED-SIZE '               H-BED-SIZE              17280008
172900*     DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT          17290008
173000*     DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO             17300008
173100*     DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO        17310008
173200*     DISPLAY 'H-OPER-DSH '               H-OPER-DSH              17320008
173300*     DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH              17330008
173400*     DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS             17340008
173500*     DISPLAY 'H-URBAN-IND '              H-URBAN-IND             17350008
173600*     DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT    17360008
173700*     DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT 17370008
173800*     DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT              17380008
173900*     DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT           17390008
174000*     DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF              17400008
174100*     DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF           17410008
174200*     DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON         17420008
174300*     DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT          17430008
174400*     DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT       17440008
174500*     DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM         17450008
174600*     DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM      17460008
174700*     DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT        17470008
174800*     DISPLAY 'H-OPER-COLA '              H-OPER-COLA             17480008
174900*     DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA             17490008
175000*     DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR    17500008
175100*     DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR 17510008
175200*     DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR     17520008
175300*     DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR  17530008
175400*     DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT          17540008
175500*     DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS         17550008
175600*     DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF      17560008
175700*     DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS       17570008
175800*     DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE17580008
175900*     DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE 17590008
176000*     DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT      17600008
176100*     DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT       17610008
176200*     DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT 17620008
176300*     DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND           17630008
176400*     DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND        17640008
176500*     DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND          17650008
176600*     DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND       17660008
176700*                                                                 17670008
176800*    END-IF.                                                      17680008
176900                                                                  17690000
177000 9000-EXIT.                                                       17700000
177100      EXIT.                                                       17710000
177200                                                                  17720000
177300******        L A S T   S O U R C E   S T A T E M E N T   *****   17730000
