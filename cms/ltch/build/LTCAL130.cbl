000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID.     LTCAL130.                                        00020000
000300*AUTHOR.         CMS.                                             00030000
000400*REMARKS.        EFFECTIVE OCTOBER 1, 2013.                       00040025
000500 DATE-COMPILED.                                                   00050002
000600 ENVIRONMENT DIVISION.                                            00060002
000700 CONFIGURATION SECTION.                                           00070002
000800 SOURCE-COMPUTER.            IBM-370.                             00080002
000900 OBJECT-COMPUTER.            IBM-370.                             00090002
001000 INPUT-OUTPUT  SECTION.                                           00100002
001100 FILE-CONTROL.                                                    00110002
001200                                                                  00120002
001300 DATA DIVISION.                                                   00130002
001400 FILE SECTION.                                                    00140002
001500                                                                  00150002
001600 WORKING-STORAGE SECTION.                                         00160002
001700 01  W-STORAGE-REF                  PIC X(46)  VALUE              00170002
001800     'LTCAL130      - W O R K I N G   S T O R A G E'.             00180002
001900 01  CAL-VERSION                    PIC X(05)  VALUE 'V13.0'.     00190002
002000 01  PROGRAM-CONSTANTS.                                           00200002
002100     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.     00210002
002200     05  FED-FY-BEGIN-04            PIC 9(08) VALUE 20031001.     00220002
002300     05  FED-FY-BEGIN-05            PIC 9(08) VALUE 20041001.     00230002
002400     05  FED-FY-BEGIN-06            PIC 9(08) VALUE 20051001.     00240002
002500     05  FED-FY-BEGIN-07            PIC 9(08) VALUE 20061001.     00250002
002600                                                                  00260002
002700                                                                  00270002
002800***************************************************************   00280002
002900*    LAYUP TABLE AREA FOR FY2013 LTC-DRG                      *   00290002
003000*    EFFECTIVE DATE OF OCTOBER 1, 2013                        *   00300025
003100***************************************************************   00310002
003200 COPY LTDRG130.                                                   00320002
003300                                                                  00330002
003400                                                                  00340002
003500***************************************************************   00350002
003600*    LAYUP TABLE AREA FOR FY2013 IPPS-DRG                     *   00360002
003700*    EFFECTIVE DATE OF OCTOBER 1, 2013                        *   00370025
003800***************************************************************   00380002
003900 COPY IPDRG130.                                                   00390002
004000                                                                  00400002
004100                                                                  00410002
004200***************************************************************   00420002
004300*    LAYUP TABLE AREA FOR FY2013 IPPS STATE SPECIFIC RFBNS    *   00430002
004400*    EFFECTIVE DATE OF OCTOBER 1, 2012 - NO TBL FOR FY 2013   *   00440002
004500***************************************************************   00450002
004600*COPY IRFBN***.                                                   00460002
004700                                                                  00470002
004800                                                                  00480002
004900***************************************************************   00490002
005000*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *   00500002
005100***************************************************************   00510002
005200 01  HOLD-PPS-COMPONENTS.                                         00520002
005300     05  H-LOS                        PIC 9(03).                  00530002
005400     05  H-REG-DAYS                   PIC 9(03).                  00540002
005500     05  H-TOTAL-DAYS                 PIC 9(05).                  00550002
005600     05  H-SSOT                       PIC 9(02)V9(01).            00560002
005700     05  H-BLEND-RTC                  PIC 9(02).                  00570002
005800     05  H-BLEND-FAC                  PIC 9(01)V9(01).            00580002
005900     05  H-BLEND-PPS                  PIC 9(01)V9(01).            00590002
006000     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).            00600002
006100     05  H-SS-COST                    PIC 9(07)V9(02).            00610002
006200     05  H-LABOR-PORTION              PIC 9(07)V9(06).            00620002
006300     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).            00630002
006400     05  H-FIXED-LOSS-AMT             PIC 9(07)V9(02).            00640002
006500     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).            00650002
006600     05  H-LOS-RATIO                  PIC 9(01)V9(05).            00660002
006700                                                                  00670002
006800*** --------------------------------------------------- ***       00680002
006900*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***       00690002
007000*** --------------------------------------------------- ***       00700002
007100     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).            00710002
007200     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).            00720002
007300     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).            00730002
007400     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).            00740002
007500     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).            00750002
007600     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).            00760002
007700     05  H-INTERN-RATIO               PIC 9(01)V9(04).            00770002
007800     05  H-CAPI-IME-RATIO             PIC 9V9999.                 00780002
007900     05  H-BED-SIZE                   PIC 9(05).                  00790002
008000     05  H-OPER-DSH-PCT               PIC V9(04).                 00800002
008100     05  H-SSI-RATIO                  PIC V9(04).                 00810002
008200     05  H-MEDICAID-RATIO             PIC V9(04).                 00820002
008300     05  H-OPER-DSH                   PIC 9(01)V9(04).            00830002
008400     05  H-CAPI-DSH                   PIC 9(01)V9(04).            00840002
008500     05  H-GEO-CLASS                  PIC X(01).                  00850002
008600     05  H-URBAN-IND                  PIC X(01).                  00860002
008700           88 URBAN-CBSA           VALUE '1'.                     00870002
008800           88 RURAL-CBSA           VALUE '0'.                     00880002
008900     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).            00890002
009000     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).            00900002
009100     05  H-CAPI-PMT                   PIC 9(07)V9(02).            00910002
009200     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).            00920002
009300     05  H-CAPI-GAF                   PIC 9(05)V9(04).            00930002
009400     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).            00940002
009500     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).            00950002
009600     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).            00960002
009700     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).            00970002
009800     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).            00980002
009900     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).            00990002
010000     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).            01000002
010100     05  H-OPER-COLA                  PIC 9(01)V9(03).            01010002
010200     05  H-CAPI-COLA                  PIC 9(01)V9(03).            01020002
010300     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).            01030002
010400     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).            01040002
010500     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).            01050002
010600     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).            01060002
010700     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).            01070002
010800     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).            01080002
010900     05  H-IPPS-DAYS-CUTOFF           PIC 9(02).                  01090002
011000     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).            01100002
011100     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).            01110002
011200     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).            01120002
011300     05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).            01130002
011400     05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).            01140002
011500     05  H-COUNTER                    PIC 9(02).                  01150002
011600     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).            01160002
011700                                                                  01170002
011800*** --------------------------------------------------- ***       01180002
011900*** VARIABLES FOR PC PRICER                             ***       01190002
012000*** --------------------------------------------------- ***       01200002
012100     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).            01210002
012200     05  H-SS-COST-IND                PIC X.                      01220002
012300     05  H-SS-PERDIEM-IND             PIC X.                      01230002
012400     05  H-SS-BLEND-IND               PIC X.                      01240002
012500     05  H-SS-IPPSCOMP-IND            PIC X.                      01250002
012600                                                                  01260002
012700                                                                  01270002
012800                                                                  01280002
012900                                                                  01290002
013000 LINKAGE SECTION.                                                 01300002
013100**************************************************************    01310002
013200*      THIS IS THE BILL-RECORD THAT WILL BE PASSED FROM      *    01320002
013300*      THE LTDRV___ PROGRAM                                  *    01330002
013400**************************************************************    01340002
013500 01  BILL-NEW-DATA.                                               01350002
013600     10  B-NPI10.                                                 01360002
013700         15  B-NPI8             PIC X(08).                        01370002
013800         15  B-NPI-FILLER       PIC X(02).                        01380002
013900     10  B-PROVIDER-NO          PIC X(06).                        01390002
014000     10  B-PATIENT-STATUS       PIC X(02).                        01400002
014100     10  B-DRG-CODE             PIC 9(03).                        01410002
014200     10  B-LOS                  PIC 9(03).                        01420002
014300     10  B-COV-DAYS             PIC 9(03).                        01430002
014400     10  B-LTR-DAYS             PIC 9(02).                        01440002
014500     10  B-DISCHARGE-DATE.                                        01450002
014600         15  B-DISCHG-CC        PIC 9(02).                        01460002
014700         15  B-DISCHG-YY        PIC 9(02).                        01470002
014800         15  B-DISCHG-MM        PIC 9(02).                        01480002
014900         15  B-DISCHG-DD        PIC 9(02).                        01490002
015000     10  B-COV-CHARGES          PIC 9(07)V9(02).                  01500002
015100     10  B-SPEC-PAY-IND         PIC X(01).                        01510002
015200     10  FILLER                 PIC X(13).                        01520002
015300                                                                  01530002
015400                                                                  01540002
015500***************************************************************   01550002
015600***************************************************************   01560002
015700*                                                             *   01570002
015800*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *   01580002
015900*    AND PASSED BACK TO THE CALLING PROGRAM                   *   01590002
016000*    RETURN CODE VALUES (PPS-RTC)                             *   01600002
016100*                                                             *   01610002
016200*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *   01620002
016300*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *   01630002
016400*                                                             *   01640002
016500*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *   01650002
016600*                                                             *   01660002
016700*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   01670002
016800*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   01680002
016900*                                                             *   01690002
017000*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   01700002
017100*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *   01710002
017200*                                                             *   01720002
017300*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   01730002
017400*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *   01740002
017500*                                                             *   01750002
017600*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   01760002
017700*                  20% SHORT STAY PAYMENT WITH OUTLIER        *   01770002
017800*                                                             *   01780002
017900*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   01790002
018000*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   01800002
018100*                                                             *   01810002
018200*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   01820002
018300*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *   01830002
018400*                                                             *   01840002
018500*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   01850002
018600*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *   01860002
018700*                                                             *   01870002
018800*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   01880002
018900*                  40% SHORT STAY PAYMENT WITH OUTLIER        *   01890002
019000*                                                             *   01900002
019100*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   01910002
019200*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   01920002
019300*                                                             *   01930002
019400*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   01940002
019500*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *   01950002
019600*                                                             *   01960002
019700*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   01970002
019800*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *   01980002
019900*                                                             *   01990002
020000*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   02000002
020100*                  60% SHORT STAY PAYMENT WITH OUTLIER        *   02010002
020200*                                                             *   02020002
020300*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   02030002
020400*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   02040002
020500*                                                             *   02050002
020600*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   02060002
020700*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *   02070002
020800*                                                             *   02080002
020900*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   02090002
021000*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *   02100002
021100*                                                             *   02110002
021200*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   02120002
021300*                  80% SHORT STAY PAYMENT WITH OUTLIER        *   02130002
021400*                                                             *   02140002
021500*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *   02150002
021600*                  WITHOUT OUTLIER                            *   02160002
021700*                                                             *   02170002
021800*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *   02180002
021900*                  DIEM WITHOUT OUTLIER                       *   02190002
022000*                                                             *   02200002
022100*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *   02210002
022200*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *   02220002
022300*                  AMOUNT WITHOUT OUTLIER                     *   02230002
022400*                                                             *   02240002
022500*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *   02250002
022600*                  DIEM WITH OUTLIER                          *   02260002
022700*                                                             *   02270002
022800*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *   02280002
022900*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *   02290002
023000*                  AMOUNT WITH OUTLIER                        *   02300002
023100*                                                             *   02310002
023200*                                                             *   02320002
023300*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *   02330002
023400*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *   02340002
023500*            FOR IPPS COMPARABLE PER DIEM)                    *   02350002
023600*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *   02360001
023700*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *   02370001
023800*            FOR IPPS COMPARABLE PER DIEM)                    *   02380001
023900*                                                             *   02390000
024000*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *   02400000
024100*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *   02410000
024200*                                                             *   02420000
024300*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *   02430000
024400*                  COMPARABLE THRESHOLD WITH OUTLIER          *   02440000
024500*                                                             *   02450000
024600*                                                             *   02460000
024700*                                                             *   02470000
024800*      ****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *   02480000
024900*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *   02490000
025000*             51 = PROVIDER RECORD TERMINATED                 *   02500000
025100*             52 = INVALID WAGE INDEX                         *   02510000
025200*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *   02520000
025300*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *   02530000
025400*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *   02540000
025500*                                     OR                      *   02550000
025600*                  DISCHARGE DATE < CBSA EFF START DATE       *   02560000
025700*                  FOR PPS                                    *   02570000
025800*             56 = INVALID LENGTH OF STAY                     *   02580000
025900*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *   02590000
026000*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *   02600000
026100*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *   02610000
026200*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *   02620000
026300*                  OR BILL-LTR-DAYS > 60                      *   02630000
026400*             62 = INVALID NUMBER OF COVERED DAYS             *   02640000
026500*                  OR BILL-LTR-DAYS > COVERED DAYS            *   02650000
026600*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *   02660000
026700*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *   02670000
026800*                  OR COST OUTLIER THRESHOLD CALCULATION      *   02680000
026900*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *   02690000
027000*             72 = INVALID BLEND INDICATOR (NOT 1 THRU 5)     *   02700000
027100*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *   02710000
027200*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *   02720000
027300*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *   02730000
027400*                                                             *   02740000
027500***************************************************************   02750000
027600***************************************************************   02760000
027700                                                                  02770000
027800                                                                  02780000
027900***************************************************************   02790000
028000* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *   02800000
028100* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *   02810000
028200***************************************************************   02820000
028300 01  PPS-DATA-ALL.                                                02830000
028400     05  PPS-RTC                       PIC 9(02).                 02840000
028500     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).           02850000
028600     05  PPS-DATA.                                                02860000
028700         10  PPS-MSA                   PIC X(04).                 02870000
028800         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).           02880000
028900         10  PPS-AVG-LOS               PIC 9(02)V9(01).           02890000
029000         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).           02900000
029100         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).           02910000
029200         10  PPS-LOS                   PIC 9(03).                 02920000
029300         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).           02930000
029400         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).           02940000
029500         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).           02950000
029600         10  PPS-FAC-COSTS             PIC 9(07)V9(02).           02960000
029700         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).           02970000
029800         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).           02980000
029900         10  PPS-SUBM-DRG-CODE         PIC X(03).                 02990000
030000         10  PPS-CALC-VERS-CD          PIC X(05).                 03000000
030100         10  PPS-REG-DAYS-USED         PIC 9(03).                 03010000
030200         10  PPS-LTR-DAYS-USED         PIC 9(03).                 03020000
030300         10  PPS-BLEND-YEAR            PIC 9(01).                 03030000
030400         10  PPS-COLA                  PIC 9(01)V9(03).           03040000
030500         10  FILLER                    PIC X(04).                 03050000
030600     05  PPS-OTHER-DATA.                                          03060000
030700         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).           03070000
030800         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).           03080000
030900         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).           03090000
031000         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).           03100000
031100         10  PPS-IPTHRESH              PIC 9(03)V9(01).           03110003
031200         10  FILLER                    PIC X(16).                 03120000
031300     05  PPS-PC-DATA.                                             03130000
031400         10  PPS-COT-IND               PIC X(01).                 03140000
031500         10  H-PC-IND                  PIC X(02).                 03150000
031600               88  PC-PRICER               VALUE 'PC'.            03160000
031700         10  FILLER                    PIC X(18).                 03170000
031800                                                                  03180000
031900 01 PPS-CBSA                           PIC X(05).                 03190000
032000                                                                  03200000
032100                                                                  03210000
032200******************************************************************03220000
032300*            THESE ARE THE VERSIONS OF THE LTDRV___              *03230000
032400*           PROGRAMS THAT WILL BE PASSED BACK----                *03240000
032500*          ASSOCIATED WITH THE BILL BEING PROCESSED              *03250000
032600******************************************************************03260000
032700 01  PRICER-OPT-VERS-SW.                                          03270000
032800     05  PRICER-OPTION-SW          PIC X(01).                     03280000
032900         88  ALL-TABLES-PASSED          VALUE 'A'.                03290000
033000         88  PROV-RECORD-PASSED         VALUE 'P'.                03300000
033100     05  PPS-VERSIONS.                                            03310000
033200         10  PPDRV-VERSION         PIC X(05).                     03320000
033300                                                                  03330000
033400                                                                  03340000
033500**************************************************************    03350000
033600*      THIS IS THE PROV-RECORD THAT WILL BE PASSED BY        *    03360000
033700*      THE LTCAL___ PROGRAM (FROM PROGRAM LTDRV___)          *    03370000
033800**************************************************************    03380000
033900 01  PROV-NEW-HOLD.                                               03390000
034000     02  PROV-NEWREC-HOLD1.                                       03400000
034100         05  P-NEW-NPI10.                                         03410000
034200             10  P-NEW-NPI8             PIC X(08).                03420000
034300             10  P-NEW-NPI-FILLER       PIC X(02).                03430000
034400         05  P-NEW-PROVIDER-NO.                                   03440000
034500             10  P-NEW-STATE            PIC 9(02).                03450000
034600             10  FILLER                 PIC X(04).                03460000
034700         05  P-NEW-DATE-DATA.                                     03470000
034800             10  P-NEW-EFF-DATE.                                  03480000
034900                 15  P-NEW-EFF-DT-CC    PIC 9(02).                03490000
035000                 15  P-NEW-EFF-DT-YY    PIC 9(02).                03500000
035100                 15  P-NEW-EFF-DT-MM    PIC 9(02).                03510000
035200                 15  P-NEW-EFF-DT-DD    PIC 9(02).                03520000
035300             10  P-NEW-FY-BEGIN-DATE.                             03530000
035400                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).                03540000
035500                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).                03550000
035600                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).                03560000
035700                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).                03570000
035800             10  P-NEW-REPORT-DATE.                               03580000
035900                 15  P-NEW-REPORT-DT-CC PIC 9(02).                03590000
036000                 15  P-NEW-REPORT-DT-YY PIC 9(02).                03600000
036100                 15  P-NEW-REPORT-DT-MM PIC 9(02).                03610000
036200                 15  P-NEW-REPORT-DT-DD PIC 9(02).                03620000
036300             10  P-NEW-TERMINATION-DATE.                          03630000
036400                 15  P-NEW-TERM-DT-CC   PIC 9(02).                03640000
036500                 15  P-NEW-TERM-DT-YY   PIC 9(02).                03650000
036600                 15  P-NEW-TERM-DT-MM   PIC 9(02).                03660000
036700                 15  P-NEW-TERM-DT-DD   PIC 9(02).                03670000
036800         05  P-NEW-WAIVER-CODE          PIC X(01).                03680000
036900             88  P-NEW-WAIVER-STATE       VALUE 'Y'.              03690000
037000         05  P-NEW-INTER-NO             PIC 9(05).                03700000
037100         05  P-NEW-PROVIDER-TYPE        PIC X(02).                03710000
037200         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).                03720000
037300         05  P-NEW-CURRENT-DIV   REDEFINES                        03730000
037400                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).         03740000
037500         05  P-NEW-MSA-DATA.                                      03750000
037600             10  P-NEW-CHG-CODE-INDEX       PIC X.                03760000
037700             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT. 03770000
037800             10  P-NEW-GEO-LOC-MSA9   REDEFINES                   03780000
037900                             P-NEW-GEO-LOC-MSAX  PIC 9(04).       03790000
038000             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT. 03800000
038100             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT. 03810000
038200             10  P-NEW-STAND-AMT-LOC-MSA9                         03820000
038300                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.               03830000
038400                 15  P-NEW-RURAL-1ST.                             03840000
038500                     20  P-NEW-STAND-RURAL  PIC XX.               03850000
038600                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.    03860000
038700                 15  P-NEW-RURAL-2ND        PIC XX.               03870000
038800         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.                    03880000
038900         05  P-NEW-LUGAR                    PIC X.                03890000
039000         05  P-NEW-TEMP-RELIEF-IND          PIC X.                03900000
039100         05  P-NEW-FED-PPS-BLEND-IND        PIC X.                03910000
039200         05  FILLER                         PIC X(05).            03920000
039300     02  PROV-NEWREC-HOLD2.                                       03930000
039400         05  P-NEW-VARIABLES.                                     03940000
039500             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).        03950000
039600             10  P-NEW-COLA              PIC  9(01)V9(03).        03960000
039700             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).        03970000
039800             10  P-NEW-BED-SIZE          PIC  9(05).              03980000
039900             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).        03990000
040000             10  P-NEW-CMI               PIC  9(01)V9(04).        04000000
040100             10  P-NEW-SSI-RATIO         PIC  V9(04).             04010000
040200             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).             04020000
040300             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).              04030000
040400             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).        04040000
040500             10  P-NEW-DSH-PERCENT       PIC  V9(04).             04050000
040600             10  P-NEW-FYE-DATE          PIC  X(08).              04060000
040700         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).             04070000
040800         05  FILLER                        PIC X(01).             04080000
040900         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.  04090000
041000         05  P-NEW-GEO-LOC-CBSA9 REDEFINES                        04100000
041100                       P-NEW-GEO-LOC-CBSAX PIC 9(05).             04110000
041200         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES                     04120000
041300                       P-NEW-GEO-LOC-CBSAX.                       04130000
041400             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.                 04140000
041500             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.                 04150000
041600             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.                 04160000
041700             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.                 04170000
041800             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.                 04180000
041900         05  FILLER                        PIC X(10).             04190000
042000         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).       04200000
042100     02  PROV-NEWREC-HOLD3.                                       04210000
042200         05  P-NEW-PASS-AMT-DATA.                                 04220000
042300             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.          04230000
042400             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.          04240000
042500             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.          04250000
042600             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.          04260000
042700         05  P-NEW-CAPI-DATA.                                     04270000
042800             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.                 04280000
042900             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.          04290000
043000             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.          04300000
043100             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.        04310000
043200             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.             04320000
043300             15  P-NEW-CAPI-NEW-HOSP       PIC X.                 04330000
043400             15  P-NEW-CAPI-IME            PIC 9V9999.            04340000
043500             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.          04350000
043600             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.             04360000
043700         05  FILLER                        PIC X(18).             04370000
043800                                                                  04380000
043900                                                                  04390000
044000******************************************************************04400000
044100*                THIS IS THE LTCH WAGE-INDEX                     *04410000
044200*          ASSOCIATED WITH THE BILL BEING PROCESSED              *04420000
044300*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *04430000
044400******************************************************************04440000
044500 01  WAGE-NEW-INDEX-RECORD.                                       04450000
044600     05  W-CBSA                        PIC X(5).                  04460000
044700     05  W-EFF-DATE                    PIC X(8).                  04470000
044800     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).          04480000
044900     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).          04490000
045000     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).          04500000
045100                                                                  04510000
045200                                                                  04520000
045300******************************************************************04530000
045400*                THIS IS THE IPPS WAGE-INDEX                     *04540000
045500*          ASSOCIATED WITH THE BILL BEING PROCESSED              *04550000
045600******************************************************************04560000
045700 01  WAGE-NEW-IPPS-INDEX-RECORD.                                  04570000
045800     05  W-CBSA-IPPS.                                             04580000
045900         10 CBSA-IPPS-123              PIC X(3).                  04590000
046000         10 CBSA-IPPS-45               PIC X(2).                  04600000
046100     05  W-CBSA-IPPS-SIZE              PIC X.                     04610000
046200         88  LARGE-URBAN       VALUE 'L'.                         04620000
046300         88  OTHER-URBAN       VALUE 'O'.                         04630000
046400         88  ALL-RURAL         VALUE 'R'.                         04640000
046500     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).                  04650000
046600     05  FILLER                        PIC X.                     04660000
046700     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).          04670000
046800     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).          04680000
046900                                                                  04690000
047000                                                                  04700000
047100                                                                  04710000
047200 PROCEDURE DIVISION  USING BILL-NEW-DATA                          04720000
047300                           PPS-DATA-ALL                           04730000
047400                           PPS-CBSA                               04740000
047500                           PRICER-OPT-VERS-SW                     04750000
047600                           PROV-NEW-HOLD                          04760000
047700                           WAGE-NEW-INDEX-RECORD                  04770000
047800                           WAGE-NEW-IPPS-INDEX-RECORD.            04780000
047900                                                                  04790000
048000                                                                  04800000
048100***************************************************************   04810000
048200*                                                             *   04820000
048300*    PROCESSING:                                              *   04830000
048400*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *   04840000
048500*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *   04850000
048600*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *   04860000
048700*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *   04870000
048800*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *   04880000
048900*           GOBACK.                                           *   04890000
049000*        D. ASSEMBLE PRICING COMPONENTS.                      *   04900000
049100*        E. CALCULATE THE PRICE.                              *   04910000
049200*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *   04920000
049300*                                                             *   04930000
049400***************************************************************   04940000
049500                                                                  04950000
049600                                                                  04960000
049700***************************************************************   04970000
049800 0000-MAINLINE-CONTROL.                                           04980000
049900***************************************************************   04990000
050000                                                                  05000000
050100     PERFORM 0100-INITIAL-ROUTINE                                 05010000
050200        THRU 0100-EXIT.                                           05020000
050300                                                                  05030000
050400     PERFORM 1000-EDIT-THE-BILL-INFO                              05040000
050500        THRU 1000-EXIT.                                           05050000
050600                                                                  05060000
050700     IF PPS-RTC = 00                                              05070000
050800        PERFORM 1700-EDIT-DRG-CODE                                05080000
050900           THRU 1700-EXIT.                                        05090000
051000                                                                  05100000
051100     IF PPS-RTC = 00                                              05110000
051200        PERFORM 1800-EDIT-IPPS-DRG-CODE                           05120000
051300           THRU 1800-EXIT                                         05130000
051400           VARYING DX5 FROM 1 BY 1 UNTIL DX5 > 1.                 05140000
051500                                                                  05150000
051600     IF PPS-RTC = 00                                              05160000
051700        PERFORM 2000-ASSEMBLE-PPS-VARIABLES                       05170000
051800           THRU 2000-EXIT.                                        05180000
051900                                                                  05190000
052000     IF PPS-RTC = 00                                              05200000
052100        PERFORM 3000-CALC-PAYMENT                                 05210000
052200           THRU 3000-EXIT                                         05220000
052300        PERFORM 7000-CALC-OUTLIER                                 05230000
052400           THRU 7000-EXIT.                                        05240000
052500                                                                  05250000
052600     IF PPS-RTC < 50                                              05260000
052700        PERFORM 8000-BLEND                                        05270000
052800           THRU 8000-EXIT.                                        05280000
052900                                                                  05290000
053000     PERFORM 9000-MOVE-RESULTS                                    05300000
053100        THRU 9000-EXIT.                                           05310000
053200                                                                  05320000
053300     GOBACK.                                                      05330000
053400                                                                  05340000
053500                                                                  05350000
053600***************************************************************   05360000
053700 0100-INITIAL-ROUTINE.                                            05370000
053800***************************************************************   05380000
053900                                                                  05390000
054000     MOVE ZEROS TO PPS-RTC.                                       05400000
054100     INITIALIZE PPS-DATA.                                         05410000
054200     INITIALIZE PPS-OTHER-DATA.                                   05420000
054300     INITIALIZE PPS-CBSA.                                         05430000
054400     INITIALIZE HOLD-PPS-COMPONENTS.                              05440000
054500                                                                  05450000
054600     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.                        05460000
054700                                                                  05470000
054800*** -----------------------------------------------------***      05480000
054900*** ADJUST IPPS WAGE INDEX BY THE STATE SPECIFIC RFBN    ***      05490000
055000*** -----------------------------------------------------***      05500000
055100     PERFORM 1900-APPLY-SSRFBN                                    05510000
055200        THRU 1900-EXIT.                                           05520000
055300                                                                  05530000
055400     IF PPS-RTC NOT = 00                                          05540000
055500        GO TO 0100-EXIT                                           05550000
055600     END-IF.                                                      05560000
055700                                                                  05570000
055800*** ---------------------------------------------------- ***      05580000
055900*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***      05590000
056000*** ---------------------------------------------------- ***      05600000
056100     MOVE .63096   TO PPS-NAT-LABOR-PCT.                          05610000
056200     MOVE .36904   TO PPS-NAT-NONLABOR-PCT.                       05620000
056300     IF B-DISCHARGE-DATE >= 20121229                              05630000
056400        MOVE 40397.96 TO PPS-STD-FED-RATE                         05640000
056500     ELSE                                                         05650000
056600        MOVE 40915.95 TO PPS-STD-FED-RATE.                        05660000
056700     MOVE 15408.00 TO H-FIXED-LOSS-AMT.                           05670000
056800     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.                         05680000
056900                                                                  05690000
057000*** ---------------------------------------------------- ***      05700000
057100*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***      05710000
057200*** ---------------------------------------------------- ***      05720000
057300     MOVE 425.49 TO H-IPPS-CAPI-STD-FED-RATE.                     05730000
057400     MOVE 207.25 TO H-IPPS-CAPI-STD-PR-RATE.                      05740000
057500     MOVE 0.75   TO H-NAT-IPPS-PMT-PCT.                           05750000
057600     MOVE 0.25   TO H-PR-IPPS-PMT-PCT.                            05760000
057700                                                                  05770000
057800     IF H-IPPS-WAGE-INDEX > 1                                     05780000
057900        MOVE 3679.95 TO H-IPPS-NAT-LABOR-SHR                      05790000
058000        MOVE 1668.81 TO H-IPPS-NAT-NONLABOR-SHR                   05800000
058100     ELSE                                                         05810000
058200        MOVE 3316.23 TO H-IPPS-NAT-LABOR-SHR                      05820000
058300        MOVE 2032.53 TO H-IPPS-NAT-NONLABOR-SHR                   05830000
058400     END-IF.                                                      05840000
058500                                                                  05850000
058600     IF W-IPPS-PR-WAGE-INDEX > 1                                  05860000
058700        MOVE 1564.17 TO H-IPPS-PR-LABOR-SHR                       05870009
058800        MOVE  954.62 TO H-IPPS-PR-NONLABOR-SHR                    05880000
058900     ELSE                                                         05890000
059000        MOVE 1561.65 TO H-IPPS-PR-LABOR-SHR                       05900000
059100        MOVE  957.14 TO H-IPPS-PR-NONLABOR-SHR                    05910000
059200     END-IF.                                                      05920000
059300                                                                  05930000
059400                                                                  05940000
059500 0100-EXIT.                                                       05950000
059600      EXIT.                                                       05960000
059700                                                                  05970000
059800                                                                  05980000
059900***************************************************************   05990000
060000*    BILL DATA EDITS - IF ANY FAIL SET PPS-RTC                *   06000000
060100*    AND DO NOT ATTEMPT TO PRICE.                             *   06010000
060200***************************************************************   06020000
060300 1000-EDIT-THE-BILL-INFO.                                         06030000
060400***************************************************************   06040000
060500                                                                  06050000
060600     IF (B-LOS NUMERIC) AND (B-LOS > 0)                           06060000
060700        MOVE B-LOS TO H-LOS                                       06070000
060800     ELSE                                                         06080000
060900        MOVE 56 TO PPS-RTC.                                       06090000
061000                                                                  06100000
061100     IF PPS-RTC = 00                                              06110000
061200       IF P-NEW-COLA NOT NUMERIC                                  06120000
061300          MOVE 50 TO PPS-RTC.                                     06130000
061400                                                                  06140000
061500     IF PPS-RTC = 00                                              06150000
061600       IF P-NEW-WAIVER-STATE                                      06160000
061700          MOVE 53 TO PPS-RTC.                                     06170000
061800                                                                  06180000
061900     IF PPS-RTC = 00                                              06190000
062000         IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR               06200000
062100            (B-DISCHARGE-DATE < W-EFF-DATE))                      06210000
062200            MOVE 55 TO PPS-RTC.                                   06220000
062300                                                                  06230000
062400     IF PPS-RTC = 00                                              06240000
062500         IF P-NEW-TERMINATION-DATE > 00000000                     06250000
062600            IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE         06260000
062700               MOVE 51 TO PPS-RTC.                                06270000
062800                                                                  06280000
062900     IF PPS-RTC = 00                                              06290000
063000         IF B-COV-CHARGES NOT NUMERIC                             06300000
063100            MOVE 58 TO PPS-RTC.                                   06310000
063200                                                                  06320000
063300     IF PPS-RTC = 00                                              06330000
063400        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60              06340000
063500           MOVE 61 TO PPS-RTC.                                    06350000
063600                                                                  06360000
063700     IF PPS-RTC = 00                                              06370000
063800        IF (B-COV-DAYS NOT NUMERIC) OR                            06380000
063900           (B-COV-DAYS = 0 AND H-LOS > 0)                         06390000
064000           MOVE 62 TO PPS-RTC.                                    06400000
064100                                                                  06410000
064200     IF PPS-RTC = 00                                              06420000
064300        IF B-LTR-DAYS > B-COV-DAYS                                06430000
064400           MOVE 62 TO PPS-RTC.                                    06440000
064500                                                                  06450000
064600     IF PPS-RTC = 00                                              06460000
064700        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS              06470000
064800        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.           06480000
064900                                                                  06490000
065000     IF PPS-RTC = 00                                              06500000
065100        PERFORM 1200-DAYS-USED                                    06510000
065200           THRU 1200-DAYS-USED-EXIT.                              06520000
065300                                                                  06530000
065400                                                                  06540000
065500*** -----------------------------------------------------------   06550000
065600*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION    06560000
065700*** -----------------------------------------------------------   06570000
065800     IF PPS-RTC = 00                                              06580000
065900        IF P-NEW-CAPI-IME NUMERIC                                 06590000
066000           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO                06600000
066100        ELSE                                                      06610000
066200           MOVE ZEROS TO H-CAPI-IME-RATIO                         06620000
066300        END-IF                                                    06630000
066400     END-IF.                                                      06640000
066500                                                                  06650000
066600     IF PPS-RTC = 00                                              06660000
066700        IF P-NEW-INTERN-RATIO NUMERIC                             06670000
066800           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO              06680000
066900        ELSE                                                      06690000
067000           MOVE ZEROS TO H-INTERN-RATIO                           06700000
067100        END-IF                                                    06710000
067200     END-IF.                                                      06720000
067300                                                                  06730000
067400     IF PPS-RTC = 00                                              06740000
067500        IF P-NEW-BED-SIZE NUMERIC                                 06750000
067600           MOVE P-NEW-BED-SIZE TO H-BED-SIZE                      06760000
067700        ELSE                                                      06770000
067800           MOVE ZEROS TO H-BED-SIZE                               06780000
067900        END-IF                                                    06790000
068000     END-IF.                                                      06800000
068100                                                                  06810000
068200     IF PPS-RTC = 00                                              06820000
068300        IF P-NEW-SSI-RATIO NUMERIC                                06830000
068400           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO                    06840000
068500        ELSE                                                      06850000
068600           MOVE ZEROS TO H-SSI-RATIO                              06860000
068700        END-IF                                                    06870000
068800     END-IF.                                                      06880000
068900                                                                  06890000
069000     IF PPS-RTC = 00                                              06900000
069100        IF P-NEW-MEDICAID-RATIO NUMERIC                           06910000
069200           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO          06920000
069300        ELSE                                                      06930000
069400           MOVE ZEROS TO H-MEDICAID-RATIO                         06940000
069500        END-IF                                                    06950000
069600     END-IF.                                                      06960000
069700                                                                  06970000
069800                                                                  06980000
069900 1000-EXIT.                                                       06990000
070000      EXIT.                                                       07000000
070100                                                                  07010000
070200                                                                  07020000
070300***************************************************************   07030000
070400 1200-DAYS-USED.                                                  07040000
070500***************************************************************   07050000
070600                                                                  07060000
070700     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)                     07070000
070800        IF B-LTR-DAYS > H-LOS                                     07080000
070900           MOVE H-LOS TO PPS-LTR-DAYS-USED                        07090000
071000        ELSE                                                      07100000
071100           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED                   07110000
071200     ELSE                                                         07120000
071300        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)                  07130000
071400           IF H-REG-DAYS > H-LOS                                  07140000
071500              MOVE H-LOS TO PPS-REG-DAYS-USED                     07150000
071600           ELSE                                                   07160000
071700              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED                07170000
071800        ELSE                                                      07180000
071900           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)               07190000
072000              IF H-REG-DAYS > H-LOS                               07200000
072100                 MOVE H-LOS TO PPS-REG-DAYS-USED                  07210000
072200                 MOVE 0 TO PPS-LTR-DAYS-USED                      07220000
072300              ELSE                                                07230000
072400                 IF H-TOTAL-DAYS > H-LOS                          07240000
072500                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED          07250000
072600                    COMPUTE PPS-LTR-DAYS-USED =                   07260000
072700                            H-LOS - H-REG-DAYS                    07270000
072800                 ELSE                                             07280000
072900                    IF H-TOTAL-DAYS <= H-LOS                      07290000
073000                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED       07300000
073100                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED       07310000
073200                    ELSE                                          07320000
073300                       NEXT SENTENCE                              07330000
073400           ELSE                                                   07340000
073500              NEXT SENTENCE.                                      07350000
073600                                                                  07360000
073700 1200-DAYS-USED-EXIT.                                             07370000
073800      EXIT.                                                       07380000
073900                                                                  07390000
074000                                                                  07400000
074100***************************************************************   07410000
074200*    FINDS THE LTCH DRG CODE IN THE TABLE                     *   07420000
074300***************************************************************   07430000
074400 1700-EDIT-DRG-CODE.                                              07440000
074500***************************************************************   07450000
074600                                                                  07460000
074700     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.                        07470000
074800     IF PPS-RTC = 00                                              07480000
074900        SEARCH ALL WWM-ENTRY                                      07490000
075000           AT END                                                 07500000
075100             MOVE 54 TO PPS-RTC                                   07510000
075200        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE               07520000
075300             PERFORM 1750-FIND-VALUE                              07530000
075400                THRU 1750-EXIT                                    07540000
075500        END-SEARCH.                                               07550000
075600                                                                  07560000
075700 1700-EXIT.                                                       07570000
075800      EXIT.                                                       07580000
075900                                                                  07590000
076000                                                                  07600000
076100***************************************************************   07610000
076200*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *   07620000
076300***************************************************************   07630000
076400 1750-FIND-VALUE.                                                 07640000
076500***************************************************************   07650000
076600                                                                  07660000
076700      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.           07670000
076800      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.                07680000
076900      MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.               07690001
077000                                                                  07700000
077100 1750-EXIT.                                                       07710000
077200      EXIT.                                                       07720000
077300                                                                  07730000
077400                                                                  07740000
077500***************************************************************   07750000
077600*    FINDS THE IPPS DRG CODE IN THE TABLE                     *   07760000
077700***************************************************************   07770000
077800 1800-EDIT-IPPS-DRG-CODE.                                         07780000
077900***************************************************************   07790000
078000                                                                  07800000
078100     IF B-DRG-CODE NOT NUMERIC                                    07810000
078200        MOVE 54 TO PPS-RTC                                        07820000
078300        GO TO 1800-EXIT                                           07830000
078400     END-IF.                                                      07840000
078500                                                                  07850000
078600     IF B-DISCHARGE-DATE NOT < DRGX-EFF-DATE(DX5) AND PPS-RTC = 0 07860000
078700        SET DX6                       TO B-DRG-CODE               07870000
078800        MOVE DRG-WT (DX5 DX6)         TO H-IPPS-DRG-WGT           07880000
078900        MOVE DRG-ALOS (DX5 DX6)       TO H-IPPS-DRG-ALOS          07890000
079000        MOVE ZEROES                   TO H-IPPS-DAYS-CUTOFF       07900000
079100        MOVE DRG-ARITH-ALOS (DX5 DX6) TO H-IPPS-ARITH-ALOS        07910000
079200     END-IF.                                                      07920000
079300                                                                  07930000
079400 1800-EXIT.                                                       07940000
079500      EXIT.                                                       07950000
079600                                                                  07960000
079700                                                                  07970000
079800***************************************************************   07980000
079900*    ADJUST THE IPPS WAGE INDEX BY THE STATE SPECIFIC         *   07990000
080000*    RURAL FLOOR BUDGET NEUTRALITY FACTOR (SSRFBN)            *   08000000
080100***************************************************************   08010000
080200 1900-APPLY-SSRFBN.                                               08020000
080300***************************************************************   08030000
080400                                                                  08040000
080500     MOVE W-IPPS-WAGE-INDEX    TO H-IPPS-WAGE-INDEX.              08050000
080600*    MOVE P-NEW-STATE          TO MES-PPS-STATE.                  08060000
080700                                                                  08070000
080800*    PERFORM 1950-FIND-SSRFBN                                     08080000
080900*       THRU 1950-EXIT.                                           08090000
081000                                                                  08100000
081100*    IF PPS-RTC = 00                                              08110000
081200*       IF  P-NEW-SPECIAL-PAY-IND = '1' OR '2'                    08120000
081300*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =                   08130000
081400*                   H-IPPS-WAGE-INDEX * 1                         08140000
081500*       ELSE                                                      08150000
081600*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =                   08160000
081700*                   H-IPPS-WAGE-INDEX * MES-SSRFBN-RATE           08170000
081800*       END-IF                                                    08180000
081900*    END-IF.                                                      08190000
082000                                                                  08200000
082100 1900-EXIT.                                                       08210000
082200      EXIT.                                                       08220000
082300                                                                  08230000
082400                                                                  08240000
082500***************************************************************   08250000
082600*    FIND THE IPPS STATE SPECIFIC RURAL FLOOR BUDGET          *   08260000
082700*    NEUTRALITY FACTOR (SSRFBN)                               *   08270000
082800***************************************************************   08280000
082900*1950-FIND-SSRFBN.                                                08290000
083000***************************************************************   08300000
083100                                                                  08310000
083200*    SET SSRFBN-IDX TO 1.                                         08320000
083300*    SEARCH SSRFBN-TAB VARYING SSRFBN-IDX                         08330000
083400                                                                  08340000
083500*        AT END                                                   08350000
083600*          MOVE 68 TO PPS-RTC                                     08360000
083700*          GO TO 1950-EXIT                                        08370000
083800                                                                  08380000
083900*        WHEN WK-SSRFBN-STATE(SSRFBN-IDX) = MES-PPS-STATE         08390000
084000*          MOVE WK-SSRFBN-REASON-ALL (SSRFBN-IDX) TO MES-SSRFBN.  08400000
084100                                                                  08410000
084200*1950-EXIT.                                                       08420000
084300*     EXIT.                                                       08430000
084400                                                                  08440000
084500                                                                  08450000
084600***************************************************************   08460000
084700***  GET THE PROVIDER SPECIFIC VARIABLES AND WAGE INDEX       *   08470000
084800*                                                             *   08480000
084900*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *   08490000
085000*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *   08500000
085100*    OF THAT VARIABLE.                                        *   08510000
085200*                                                             *   08520000
085300***************************************************************   08530000
085400 2000-ASSEMBLE-PPS-VARIABLES.                                     08540000
085500***************************************************************   08550000
085600                                                                  08560000
085700                                                                  08570000
085800*------------------------------------------------------*          08580000
085900* WAGE INDEX BLEND TABLE                               *          08590000
086000*------------------------------------------------------*          08600000
086100*                                                      *          08610000
086200*  BLEND YEAR   FEDERAL FY                BLEND        *          08620000
086300*  ----------   ----------------------    -----        *          08630000
086400*      1        10/01/2002 - 09/30/2003    1/5         *          08640000
086500*      2        10/01/2003 - 09/30/2004    2/5         *          08650000
086600*      3        10/01/2004 - 09/30/2005    3/5         *          08660000
086700*      4        10/01/2005 - 09/30/2006    4/5         *          08670000
086800*      5        10/01/2006 - INDEFINITE    5/5 (FULL)  *          08680000
086900*                                                      *          08690000
087000*------------------------------------------------------*          08700000
087100*                                                      *          08710000
087200* A PROVIDER WILL RECEIVE THE APPLICABLE BLEND FOR A   *          08720000
087300* GIVEN FEDERAL FY FOR CLAIMS DISCHARGED ON & AFTER    *          08730000
087400* ITS FY BEGIN DATE THAT FALLS WITHIN THAT FEDERAL FY. *          08740000
087500*                                                      *          08750000
087600*------------------------------------------------------*          08760000
087700                                                                  08770000
087800                                                                  08780000
087900***************************************************************   08790000
088000* ASSIGN FULL (5/5) WAGE INDEX TO ALL CLAIMS DISCHARGED ON    *   08800000
088100* AND AFTER 7/1/2008 (NEW FOR VERSION 2008.0)                 *   08810000
088200***************************************************************   08820000
088300     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0               08830000
088400        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX                      08840000
088500     ELSE                                                         08850000
088600        MOVE 52 TO PPS-RTC                                        08860000
088700        GO TO 2000-EXIT                                           08870000
088800     END-IF.                                                      08880000
088900                                                                  08890000
089000                                                                  08900000
089100***************************************************************   08910000
089200* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *   08920000
089300* (ALWAYS FED-FY-BEGIN-03)                                    *   08930000
089400***************************************************************   08940000
089500      IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03                    08950000
089600         MOVE 74 TO PPS-RTC                                       08960000
089700         GO TO 2000-EXIT                                          08970000
089800      END-IF.                                                     08980000
089900                                                                  08990000
090000                                                                  09000000
090100***************************************************************   09010000
090200* USE SPECIAL WAGE INDEX WHEN INDICATED                       *   09020000
090300***************************************************************   09030000
090400     IF P-NEW-SPECIAL-PAY-IND = '1'                               09040000
090500        IF P-NEW-SPECIAL-WAGE-INDEX NUMERIC AND                   09050000
090600           P-NEW-SPECIAL-WAGE-INDEX > 0                           09060000
090700           MOVE P-NEW-SPECIAL-WAGE-INDEX TO PPS-WAGE-INDEX        09070000
090800        ELSE                                                      09080000
090900           MOVE 52 TO PPS-RTC                                     09090000
091000           GO TO 2000-EXIT                                        09100000
091100        END-IF                                                    09110000
091200     END-IF.                                                      09120000
091300                                                                  09130000
091400                                                                  09140000
091500***************************************************************   09150000
091600* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *   09160000
091700***************************************************************   09170000
091800     IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC                       09180000
091900        MOVE 65 TO PPS-RTC.                                       09190000
092000                                                                  09200000
092100                                                                  09210000
092200***************************************************************   09220000
092300* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *   09230000
092400***************************************************************   09240000
092500     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.              09250000
092600                                                                  09260000
092700     IF PPS-BLEND-YEAR > 0 AND PPS-BLEND-YEAR < 6                 09270000
092800        NEXT SENTENCE                                             09280000
092900     ELSE                                                         09290000
093000        MOVE 72 TO PPS-RTC                                        09300000
093100        GO TO 2000-EXIT.                                          09310000
093200                                                                  09320000
093300     MOVE 0 TO H-BLEND-FAC.                                       09330000
093400     MOVE 1 TO H-BLEND-PPS.                                       09340000
093500     MOVE 0 TO H-BLEND-RTC.                                       09350000
093600                                                                  09360000
093700     IF PPS-BLEND-YEAR = 1                                        09370000
093800        MOVE .8 TO H-BLEND-FAC                                    09380000
093900        MOVE .2 TO H-BLEND-PPS                                    09390000
094000        MOVE 4 TO H-BLEND-RTC                                     09400000
094100     ELSE                                                         09410000
094200       IF PPS-BLEND-YEAR = 2                                      09420000
094300          MOVE .6 TO H-BLEND-FAC                                  09430000
094400          MOVE .4 TO H-BLEND-PPS                                  09440000
094500          MOVE 8 TO H-BLEND-RTC                                   09450000
094600       ELSE                                                       09460000
094700         IF PPS-BLEND-YEAR = 3                                    09470000
094800            MOVE .4 TO H-BLEND-FAC                                09480000
094900            MOVE .6 TO H-BLEND-PPS                                09490000
095000            MOVE 12 TO H-BLEND-RTC                                09500000
095100         ELSE                                                     09510000
095200           IF PPS-BLEND-YEAR = 4                                  09520000
095300              MOVE .2 TO H-BLEND-FAC                              09530000
095400              MOVE .8 TO H-BLEND-PPS                              09540000
095500              MOVE 16 TO H-BLEND-RTC.                             09550000
095600                                                                  09560000
095700 2000-EXIT.                                                       09570000
095800      EXIT.                                                       09580000
095900                                                                  09590000
096000                                                                  09600000
096100***************************************************************   09610000
096200*    IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)           *   09620000
096300*        CALCULATE THE STANDARD PAYMENT AMOUNT.               *   09630000
096400*        CALCULATE THE SHORT-STAY OUTLIER AMOUNT.             *   09640000
096500***************************************************************   09650000
096600 3000-CALC-PAYMENT.                                               09660000
096700***************************************************************   09670000
096800                                                                  09680000
096900*** -------------------------------------------------- ***        09690000
097000*** FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII) ***        09700000
097100*** -------------------------------------------------- ***        09710000
097200     IF (P-NEW-STATE = 02 OR 12)                                  09720000
097300        MOVE P-NEW-COLA TO PPS-COLA                               09730000
097400     ELSE                                                         09740000
097500        MOVE 1.000 TO PPS-COLA                                    09750000
097600     END-IF.                                                      09760000
097700                                                                  09770000
097800                                                                  09780000
097900     COMPUTE PPS-FAC-COSTS ROUNDED =                              09790000
098000         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.                 09800000
098100                                                                  09810000
098200     COMPUTE H-LABOR-PORTION ROUNDED =                            09820000
098300         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)                   09830000
098400          * PPS-WAGE-INDEX.                                       09840000
098500                                                                  09850000
098600     COMPUTE H-NONLABOR-PORTION ROUNDED =                         09860000
098700         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)                09870000
098800          * PPS-COLA.                                             09880000
098900                                                                  09890000
099000     COMPUTE PPS-FED-PAY-AMT ROUNDED =                            09900000
099100         (H-LABOR-PORTION + H-NONLABOR-PORTION).                  09910000
099200                                                                  09920000
099300     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =                        09930000
099400         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).                    09940000
099500                                                                  09950000
099600                                                                  09960000
099700*** -------------------------------------------------------- ***  09970000
099800*** FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY ***  09980000
099900*** -------------------------------------------------------- ***  09990000
100000     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.         10000000
100100                                                                  10010000
100200*** --------------------------------------------- ***             10020000
100300*** DETERMINE WHETHER THE CLAIM IS A SHORT STAY   ***             10030000
100400*** --------------------------------------------- ***             10040000
100500*** H-SSOT ROUNDED AND EXPANDED TO 1 DECIMAL      ***             10050000
100600*** PLACE FOR RELEASE 07.1                        ***             10060000
100700*** --------------------------------------------- ***             10070000
100800     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.              10080000
100900     IF H-LOS <= H-SSOT                                           10090000
101000        PERFORM 3400-SHORT-STAY                                   10100000
101100           THRU 3400-SHORT-STAY-EXIT.                             10110000
101200                                                                  10120000
101300 3000-EXIT.                                                       10130000
101400      EXIT.                                                       10140000
101500                                                                  10150000
101600                                                                  10160000
101700***************************************************************   10170000
101800*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *   10180000
101900*      OF THE AVG. LENGTH OF STAY THEN:                       *   10190000
102000*      - CALCULATE THE SHORT-STAY COST.                       *   10200000
102100*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *   10210000
102200*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *   10220000
102300*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *   10230000
102400*      - PAY THE LEAST OF:                                    *   10240000
102500*          1)SHORT STAY COST                                  *   10250000
102600*          2)SHORT STAY PAYMENT AMOUNT                        *   10260000
102700*          3)DRG ADJUSTED PAYMENT AMOUNT                      *   10270000
102800*          4)SHORT STAY BLENDED PAYMENT -OR-                  *   10280000
102900*          5)IPPS COMPARABLE AMOUNT                           *   10290000
103000*      - SET RETURN CODE TO INDICATE SHORT STAY PAYMENT TYPE  *   10300000
103100***************************************************************   10310000
103200                                                                  10320002
103300 3400-SHORT-STAY.                                                 10330000
103400**************************************************************    10340000
103500*   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *    10350000
103600**************************************************************    10360000
103700     IF P-NEW-PROVIDER-NO = '332006'                              10370000
103800        PERFORM 4000-SPECIAL-PROVIDER                             10380000
103900           THRU 4000-SPECIAL-PROVIDER-EXIT                        10390000
104000     ELSE                                                         10400000
104100                                                                  10410002
104200**************************************************************    10420000
104300*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *    10430000
104400* ---------------------------------------------------------- *    10440000
104500*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *    10450000
104600**************************************************************    10460000
104700        MOVE PPS-FAC-COSTS TO H-SS-COST                           10470000
104800                                                                  10480000
104900**************************************************************    10490000
105000*                                                            *    10500000
105100*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *    10510000
105200* ---------------------------------------------------------- *    10520000
105300*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *    10530000
105400*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *    10540000
105500*     THE LENGTH OF STAY IS CORRECT                          *    10550000
105600*                                                            *    10560000
105700**************************************************************    10570000
105800        COMPUTE H-SS-PAY-AMT ROUNDED =                            10580000
105900         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2      10590000
106000                                                                  10600000
106100**************************************************************    10610000
106200*                                                            *    10620000
106300*   SHORT STAY PROVISION #4 (BLEND OF SS PMT & IPPS          *    10630000
106400*   COMPARABLE PER DIEM AMT)                                 *    10640000
106500* ---------------------------------------------------------- *    10650000
106600*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *    10660000
106700*   REMOVED FROM VERSION 09.0 BECAUSE CLAIMS DISCHARGED ON   *    10670000
106800*   AND AFTER 12/29/2008 ARE NOT ELIGIBLE FOR PROVISION #5.  *    10680000
106900*                                                            *    10690000
107000*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *    10700001
107100*   ADDED TO VERSION 13.0 BECAUSE CLAIMS DISCHARGED ON AND   *    10710001
107200*   AFTER 12/29/2012 ARE ELIGIBLE FOR PROVISION #5.          *    10720001
107300*                                                            *    10730001
107400**************************************************************    10740000
107500        IF H-IPPS-WAGE-INDEX NUMERIC AND                          10750000
107600           H-IPPS-WAGE-INDEX > 0                                  10760000
107700*---------------------------------------------------------        10770001
107900*   #4 - CALCULATE BLENDED PAYMENT                                10790015
108000*---------------------------------------------------------        10800001
108700           IF B-DISCHARGE-DATE >= 20121229                        10800116
                    IF H-LOS > PPS-IPTHRESH                             10800216
108100                 PERFORM 3600-SS-BLENDED-PMT                      10810016
108200                    THRU 3600-SS-BLENDED-PMT-EXIT                 10820016
                     ELSE                                               10821016
108300*---------------------------------------------------------        10822016
108400*   #5 - LOS (COVERED DAYS) <= IPPS COMPARABLE THRESHOLD          10822116
108500*        CALCULATE IPPS COMPARABLE PER DIEM AMT ONLY              10822216
108600*---------------------------------------------------------        10822316
108800                  PERFORM 3650-SS-IPPS-COMP-PMT                   10823016
108900                     THRU 3650-SS-IPPS-COMP-PMT-EXIT              10824016
                 ELSE                                                   10861014
108100               PERFORM 3600-SS-BLENDED-PMT                        10863016
108200                  THRU 3600-SS-BLENDED-PMT-EXIT                   10864016
109100        ELSE                                                      10910001
109200           MOVE 52 TO PPS-RTC                                     10920000
109300           GO TO 3400-SHORT-STAY-EXIT.                            10930016
110500                                                                  10940016
109700**************************************************************    10970000
109800*                                                            *    10980000
109900*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *    10990000
110000*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *    11000000
110100* ---------------------------------------------------------- *    11010000
110200*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *    11020000
110300*                                                            *    11030000
110400**************************************************************    11040000
110500                                                                  11050000
110600     MOVE 'N' TO H-SS-COST-IND.                                   11060000
110700     MOVE 'N' TO H-SS-PERDIEM-IND.                                11070000
110800     MOVE 'N' TO H-SS-BLEND-IND.                                  11080000
110900     MOVE 'N' TO H-SS-IPPSCOMP-IND.                               11090000
111000                                                                  11100000
111100*---------------------------------------------------------        11110000
111200*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%          11120000
111300*   OF PER DIEM) AND DRG ADJUSTED PMT AMT                         11130000
111400*---------------------------------------------------------        11140000
111500     IF H-SS-COST < H-SS-PAY-AMT                                  11150000
111600        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT                        11160000
111700           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT                  11170000
111800           MOVE 20 TO PPS-RTC                                     11180000
111900           MOVE 'Y' TO H-SS-COST-IND                              11190000
112000        ELSE                                                      11200000
112100           NEXT SENTENCE                                          11210000
112200        END-IF                                                    11220000
112300     ELSE                                                         11230000
112400        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT                     11240000
112500           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT               11250000
112600           MOVE 21 TO PPS-RTC                                     11260000
112700           MOVE 'Y' TO H-SS-PERDIEM-IND                           11270000
112800        ELSE                                                      11280000
112900           NEXT SENTENCE                                          11290000
113000        END-IF                                                    11300000
113100     END-IF.                                                      11310000
113200                                                                  11320000
113300*---------------------------------------------------------        11330000
113400*   USE THE BLENDED PMT OR IPPS COMPARABLE AMT IF LESS            11340001
113500*   THAN THE OTHER OPTIONS                                        11350001
113600*---------------------------------------------------------        11360000
113700     IF P-NEW-PROVIDER-NO NOT = '332006'                          11370000
113900*---------------------------------------------------------        11390001
114000*   COMPARE BLENDED PAYMENT                                       11400001
114100*---------------------------------------------------------        11410001
115610         IF B-DISCHARGE-DATE >= 20121229 AND                      11411021
                 H-LOS > PPS-IPTHRESH AND                               11420019
114300           H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT                 11430019
114400               MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT       11440019
114500               MOVE 22 TO PPS-RTC                                 11450019
114600               MOVE 'Y' TO H-SS-BLEND-IND                         11460019
114700               MOVE 'N' TO H-SS-COST-IND                          11470019
114800               MOVE 'N' TO H-SS-PERDIEM-IND                       11480019
114900               MOVE 'N' TO H-SS-IPPSCOMP-IND                      11490019
               ELSE                                                     11491021
115300*---------------------------------------------------------        11491119
115400*   COMPARE IPPS COMPARABLE PER DIEM AMOUNT                       11491219
115500*---------------------------------------------------------        11491319
115610             IF B-DISCHARGE-DATE >= 20121229 AND                  11492021
                     H-LOS <= PPS-IPTHRESH AND                          11492122
115700               H-IPPS-PER-DIEM <= PPS-DRG-ADJ-PAY-AMT             11570021
115800                 MOVE H-IPPS-PER-DIEM TO PPS-DRG-ADJ-PAY-AMT      11580021
115900                 MOVE 26 TO PPS-RTC                               11590021
116000                 MOVE 'Y' TO H-SS-IPPSCOMP-IND                    11600021
116100                 MOVE 'N' TO H-SS-BLEND-IND                       11610021
116200                 MOVE 'N' TO H-SS-COST-IND                        11620021
116300                 MOVE 'N' TO H-SS-PERDIEM-IND                     11630021
                   ELSE                                                 11631021
115610                 IF B-DISCHARGE-DATE < 20121229 AND               11632021
114300                   H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT         11634021
114400                     MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT 11635021
114500                     MOVE 22 TO PPS-RTC                           11636021
114600                     MOVE 'Y' TO H-SS-BLEND-IND                   11637021
114700                     MOVE 'N' TO H-SS-COST-IND                    11638021
114800                     MOVE 'N' TO H-SS-PERDIEM-IND                 11639021
114900                     MOVE 'N' TO H-SS-IPPSCOMP-IND                11639121
                       END-IF                                           11640021
                   END-IF                                               11640121
               END-IF                                                   11640221
           END-IF.                                                      11641021
116800                                                                  11680000
116900 3400-SHORT-STAY-EXIT.                                            11690000
117000      EXIT.                                                       11700000
117100                                                                  11710000
117200                                                                  11720000
117300***************************************************************   11730000
117400*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *   11740000
117500*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *   11750000
117600*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *   11760000
117700*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *   11770000
117800***************************************************************   11780000
117900 3600-SS-BLENDED-PMT.                                             11790000
118000***************************************************************   11800000
118100                                                                  11810000
118200*** ------------------------------------------------------ ***    11820000
118300*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***    11830000
118400*** ------------------------------------------------------ ***    11840000
118500     IF H-SSOT < 25                                               11850000
118600        COMPUTE H-LTCH-BLEND-PCT ROUNDED =                        11860000
118700          H-LOS / H-SSOT                                          11870000
118800     ELSE                                                         11880000
118900        COMPUTE H-LTCH-BLEND-PCT ROUNDED =                        11890000
119000          H-LOS / 25                                              11900000
119100     END-IF.                                                      11910000
119200                                                                  11920000
119300     IF H-LTCH-BLEND-PCT > 1                                      11930000
119400        MOVE 1 TO H-LTCH-BLEND-PCT                                11940000
119500     END-IF.                                                      11950000
119600                                                                  11960000
119700                                                                  11970000
119800*** ------------------------------------------------------ ***    11980000
119900*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***    11990000
120000*** ------------------------------------------------------ ***    12000000
120100     COMPUTE H-LTCH-BLEND-AMT ROUNDED =                           12010000
120200        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.                          12020000
120300                                                                  12030000
120400                                                                  12040000
120500*** ------------------------------------------------------ ***    12050000
120600*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***    12060000
120700*** ------------------------------------------------------ ***    12070000
120800     PERFORM 3650-SS-IPPS-COMP-PMT                                12080000
120900        THRU 3650-SS-IPPS-COMP-PMT-EXIT.                          12090000
121000                                                                  12100000
121100                                                                  12110000
121200*** ------------------------------------------------------ ***    12120000
121300*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***    12130000
121400*** ------------------------------------------------------ ***    12140000
121500     COMPUTE H-IPPS-BLEND-PCT ROUNDED =                           12150000
121600       1 - H-LTCH-BLEND-PCT.                                      12160000
121700                                                                  12170000
121800                                                                  12180000
121900*** ------------------------------------------------------ ***    12190000
122000*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***    12200000
122100*** ------------------------------------------------------ ***    12210000
122200     COMPUTE H-IPPS-BLEND-AMT ROUNDED =                           12220000
122300       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.                        12230000
122400                                                                  12240000
122500                                                                  12250000
122600*** ------------------------------------------------------ ***    12260000
122700*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***    12270000
122800*** ------------------------------------------------------ ***    12280000
122900     COMPUTE H-SS-BLENDED-PMT ROUNDED =                           12290000
123000       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.                       12300000
123100                                                                  12310000
123200                                                                  12320000
123300 3600-SS-BLENDED-PMT-EXIT.                                        12330000
123400      EXIT.                                                       12340000
123500                                                                  12350000
123600                                                                  12360000
123700***************************************************************   12370000
123800*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *   12380000
123900*   PER DIEM PAYMENT AMOUNT                                   *   12390000
124000***************************************************************   12400000
124100 3650-SS-IPPS-COMP-PMT.                                           12410000
124200***************************************************************   12420000
124300                                                                  12430000
124400*** -------------------------------------------------------       12440000
124500*** OPERATING TEACHING ADJUSTMENT                                 12450000
124600*** -------------------------------------------------------       12460000
124700     COMPUTE H-OPER-IME-TEACH ROUNDED =                           12470000
124800        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).                12480000
124900                                                                  12490000
125000                                                                  12500000
125100*** -------------------------------------------------------       12510000
125200*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)              12520000
125300*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%        12530000
125400*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL       12540000
125500***              THIS CHANGE IS RETROACTIVE TO 10/01/2008         12550000
125600*** -------------------------------------------------------       12560000
125700     IF H-CAPI-IME-RATIO > 1.5000                                 12570000
125800        MOVE 1.5000 TO H-CAPI-IME-RATIO.                          12580000
125900                                                                  12590000
126000     COMPUTE H-CAPI-IME-TEACH ROUNDED =                           12600000
126100        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).             12610000
126200                                                                  12620000
126300                                                                  12630000
126400*** -------------------------------------------------------       12640000
126500*** OPERATING DSH ADJUSTMENT                                      12650000
126600*** -------------------------------------------------------       12660000
126700                                                                  12670000
126800*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL              12680000
126900*---------------------------------------------------              12690000
127000     IF ALL-RURAL                                                 12700000
127100        SET RURAL-CBSA TO TRUE                                    12710000
127200     ELSE                                                         12720000
127300        SET URBAN-CBSA TO TRUE                                    12730000
127400     END-IF.                                                      12740000
127500                                                                  12750000
127600                                                                  12760000
127700*2) CALCULATE THE OPERATING DSH PERCENT                           12770000
127800*--------------------------------------                           12780000
127900     COMPUTE H-OPER-DSH-PCT ROUNDED =                             12790000
128000        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.                   12800000
128100                                                                  12810000
128200                                                                  12820000
128300*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION            12830000
128400*-----------------------------------------------------            12840000
128500                                                                  12850000
128600*    URBAN, < 100 BEDS                                            12860000
128700*    -----------------                                            12870000
128800     IF URBAN-CBSA AND H-BED-SIZE < 100 AND                       12880000
128900        H-OPER-DSH-PCT >= .15                                     12890000
129000          MOVE '3' TO H-GEO-CLASS                                 12900000
129100     ELSE                                                         12910000
129200                                                                  12920000
129300                                                                  12930000
129400*   URBAN, >= 100 BEDS                                            12940000
129500*   ------------------                                            12950000
129600       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND                    12960000
129700          H-OPER-DSH-PCT >= .15                                   12970000
129800            MOVE '2' TO H-GEO-CLASS                               12980000
129900       ELSE                                                       12990000
130000                                                                  13000000
130100                                                                  13010000
130200*   RURAL, >= 500 BEDS                                            13020000
130300*   ------------------                                            13030000
130400         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND                  13040000
130500            H-OPER-DSH-PCT >= .15                                 13050000
130600              MOVE '2' TO H-GEO-CLASS                             13060000
130700         ELSE                                                     13070000
130800                                                                  13080000
130900                                                                  13090000
131000*   RURAL, < 500 BEDS                                             13100000
131100*   -----------------                                             13110000
131200           IF RURAL-CBSA AND H-BED-SIZE < 500 AND                 13120000
131300              H-OPER-DSH-PCT >= .15                               13130000
131400                MOVE '3' TO H-GEO-CLASS                           13140000
131500           ELSE                                                   13150000
131600                                                                  13160000
131700                                                                  13170000
131800*   OTHER                                                         13180000
131900*   -----------------                                             13190000
132000              MOVE '4' TO H-GEO-CLASS                             13200000
132100                                                                  13210000
132200           END-IF                                                 13220000
132300         END-IF                                                   13230000
132400       END-IF                                                     13240000
132500     END-IF.                                                      13250000
132600                                                                  13260000
132700                                                                  13270000
132800*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS      13280000
132900*-----------------------------------------------------------      13290000
133000     EVALUATE H-GEO-CLASS                                         13300000
133100                                                                  13310000
133200*      GEOGRAPHIC CLASS 2                                         13320000
133300*      ------------------                                         13330000
133400       WHEN '2'                                                   13340000
133500          IF (H-OPER-DSH-PCT >= .15 AND <= .202)                  13350000
133600             COMPUTE H-OPER-DSH ROUNDED =                         13360000
133700               ((H-OPER-DSH-PCT - .15) * .65) + .025              13370000
133800          ELSE                                                    13380000
133900             IF H-OPER-DSH-PCT > .202                             13390000
134000                COMPUTE H-OPER-DSH ROUNDED =                      13400000
134100                  ((H-OPER-DSH-PCT - .202) * .825) + .0588        13410000
134200             ELSE                                                 13420000
134300                MOVE ZEROS TO H-OPER-DSH                          13430000
134400             END-IF                                               13440000
134500          END-IF                                                  13450000
134600                                                                  13460000
134700*      GEOGRAPHIC CLASS 3                                         13470000
134800*      ------------------                                         13480000
134900       WHEN '3'                                                   13490000
135000          IF (H-OPER-DSH-PCT >= .15 AND <= .202)                  13500000
135100             COMPUTE H-OPER-DSH ROUNDED =                         13510000
135200               ((H-OPER-DSH-PCT - .15) * .65) + .025              13520000
135300             IF H-OPER-DSH > .12                                  13530000
135400                MOVE .12 TO H-OPER-DSH                            13540000
135500             END-IF                                               13550000
135600          ELSE                                                    13560000
135700             IF H-OPER-DSH-PCT > .202                             13570000
135800                COMPUTE H-OPER-DSH ROUNDED =                      13580000
135900                  ((H-OPER-DSH-PCT - .202) * .825) + .0588        13590000
136000                IF H-OPER-DSH > .12                               13600000
136100                   MOVE .12 TO H-OPER-DSH                         13610000
136200                END-IF                                            13620000
136300             ELSE                                                 13630000
136400               MOVE ZEROS TO H-OPER-DSH                           13640000
136500             END-IF                                               13650000
136600          END-IF                                                  13660000
136700                                                                  13670000
136800*      GEOGRAPHIC CLASS 4                                         13680000
136900*      ------------------                                         13690000
137000       WHEN '4'                                                   13700000
137100          MOVE ZEROS TO H-OPER-DSH                                13710000
137200                                                                  13720000
137300     END-EVALUATE.                                                13730000
137400                                                                  13740000
137500                                                                  13750000
137600*** -------------------------------------------------------       13760000
137700*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)                   13770000
137800*** -------------------------------------------------------       13780000
137900     IF URBAN-CBSA AND H-BED-SIZE >= 100                          13790000
138000        COMPUTE H-CAPI-DSH ROUNDED =                              13800000
138100          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1                  13810000
138200     ELSE                                                         13820000
138300        MOVE ZEROS TO H-CAPI-DSH                                  13830000
138400     END-IF.                                                      13840000
138500                                                                  13850000
138600                                                                  13860000
138700*** -------------------------------------------------------       13870000
138800*** OPERATING PAYMENT (STANDARD AMOUNT)                           13880000
138900*** -------------------------------------------------------       13890000
139000     IF (P-NEW-STATE = 02 OR 12)                                  13900000
139100        MOVE P-NEW-COLA TO H-OPER-COLA                            13910000
139200     ELSE                                                         13920000
139300        MOVE 1.000 TO H-OPER-COLA                                 13930000
139400     END-IF.                                                      13940000
139500                                                                  13950000
139600     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =                       13960000
139700       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +             13970000
139800         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *              13980000
139900         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).   13990000
140000                                                                  14000000
140100                                                                  14010000
140200*** -------------------------------------------------------       14020000
140300*** CAPITAL PAYMENT (CAPITAL RATE)                                14030000
140400*** -------------------------------------------------------       14040000
140500     COMPUTE H-CAPI-COLA ROUNDED =                                14050000
140600       (.3152 * (H-OPER-COLA - 1) + 1).                           14060000
140700                                                                  14070000
140800*--------------------------------------------------------------*  14080000
140900*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *  14090000
141000*   LATER (CHANGED FROM 1.03 TO 1.00)                          *  14100000
141100*--------------------------------------------------------------*  14110000
141200     IF LARGE-URBAN                                               14120000
141300        MOVE 1.00 TO H-LRGURB-ADD-ON                              14130000
141400     ELSE                                                         14140000
141500        MOVE 1.00 TO H-LRGURB-ADD-ON                              14150000
141600     END-IF.                                                      14160000
141700                                                                  14170000
141800     COMPUTE H-CAPI-GAF ROUNDED =                                 14180000
141900       (H-IPPS-WAGE-INDEX ** .6848).                              14190000
142000                                                                  14200000
142100     COMPUTE H-CAPI-PMT ROUNDED =                                 14210000
142200       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *   14220000
142300       H-LRGURB-ADD-ON *  H-CAPI-COLA *                           14230000
142400       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).                       14240000
142500                                                                  14250000
142600                                                                  14260000
142700*** -------------------------------------------------------       14270000
142800*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)           14280000
142900*** -------------------------------------------------------       14290000
143000     COMPUTE H-IPPS-PAY-AMT ROUNDED =                             14300000
143100       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.                         14310000
143200                                                                  14320000
143300                                                                  14330000
143400*** -------------------------------------------------------       14340000
143500*** IPPS COMPARABLE PER DIEM PAYMENT                              14350000
143600*** -------------------------------------------------------       14360000
143700     COMPUTE H-IPPS-PER-DIEM ROUNDED =                            14370000
143800       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.                14380000
143900                                                                  14390000
144000     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT                          14400000
144100        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM                    14410000
144200     END-IF.                                                      14420000
144300                                                                  14430000
144400*** -------------------------------------------------------       14440000
144500*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS                   14450000
144600*** -------------------------------------------------------       14460000
144700     IF P-NEW-STATE = 40                                          14470000
144800        PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT           14480000
144900     END-IF.                                                      14490000
145000                                                                  14500000
145100                                                                  14510000
145200 3650-SS-IPPS-COMP-PMT-EXIT.                                      14520000
145300      EXIT.                                                       14530000
145400                                                                  14540000
145500                                                                  14550000
145600***************************************************************   14560000
145700 3675-SS-IPPS-COMP-PR-PMT.                                        14570000
145800***************************************************************   14580000
145900                                                                  14590000
146000*** -------------------------------------------------------       14600000
146100*** PUERTO RICO OPERATING PAYMENT (STANDARD AMOUNT)               14610000
146200*** -------------------------------------------------------       14620000
146300     COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =                    14630000
146400        ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +          14640000
146500          (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *              14650000
146600          H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).  14660000
146700                                                                  14670000
146800                                                                  14680000
146900*** -------------------------------------------------------       14690000
147000*** PUERTO RICO CAPITAL PAYMENT (CAPITAL RATE)                    14700000
147100*** -------------------------------------------------------       14710000
147200     COMPUTE H-PR-CAPI-GAF ROUNDED =                              14720000
147300        (W-IPPS-PR-WAGE-INDEX ** .6848).                          14730000
147400                                                                  14740000
147500     COMPUTE H-PR-CAPI-PMT ROUNDED =                              14750000
147600        H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *14760000
147700        H-LRGURB-ADD-ON * H-CAPI-COLA *                           14770000
147800        (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).                      14780000
147900                                                                  14790000
148000                                                                  14800000
148100*** -------------------------------------------------------       14810000
148200*** PR IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)        14820000
148300*** -------------------------------------------------------       14830000
148400     COMPUTE H-IPPS-PR-PAY-AMT ROUNDED =                          14840000
148500        H-PR-STAND-AMT-OPER-PMT + H-PR-CAPI-PMT.                  14850000
148600                                                                  14860000
148700                                                                  14870000
148800*** -------------------------------------------------------       14880000
148900*** PUERTO RICO IPPS COMPARABLE PER DIEM PAYMENT                  14890000
149000*** -------------------------------------------------------       14900000
149100     COMPUTE H-IPPS-PR-PER-DIEM ROUNDED =                         14910000
149200        (H-IPPS-PR-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.            14920000
149300                                                                  14930000
149400     IF H-IPPS-PR-PER-DIEM > H-IPPS-PR-PAY-AMT                    14940000
149500        MOVE H-IPPS-PR-PAY-AMT TO H-IPPS-PR-PER-DIEM              14950000
149600     END-IF.                                                      14960000
149700                                                                  14970000
149800                                                                  14980000
149900*** -------------------------------------------------------       14990000
150000*** BLEND FEDERAL PER DIEM AND PUERTO RICO PER DIEM               15000000
150100*** -------------------------------------------------------       15010000
150200     COMPUTE H-IPPS-PER-DIEM ROUNDED =                            15020000
150300        (H-IPPS-PER-DIEM    * H-NAT-IPPS-PMT-PCT) +               15030000
150400        (H-IPPS-PR-PER-DIEM * H-PR-IPPS-PMT-PCT ).                15040000
150500                                                                  15050000
150600                                                                  15060000
150700 3675-EXIT.                                                       15070000
150800      EXIT.                                                       15080000
150900                                                                  15090000
151000                                                                  15100000
151100***************************************************************   15110000
151200 4000-SPECIAL-PROVIDER.                                           15120000
151300***************************************************************   15130000
151400                                                                  15140000
151500*** PROCESS FOR CY2003                                            15150000
151600*** ------------------                                            15160000
151700     IF (B-DISCHARGE-DATE >= 20030701) AND                        15170000
151800        (B-DISCHARGE-DATE <  20040101)                            15180000
151900        COMPUTE H-SS-COST ROUNDED =                               15190000
152000            (PPS-FAC-COSTS * 1.95)                                15200000
152100        COMPUTE H-SS-PAY-AMT ROUNDED =                            15210000
152200         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95     15220000
152300     END-IF                                                       15230000
152400                                                                  15240000
152500                                                                  15250000
152600*** PROCESS FOR CY2004                                            15260000
152700*** ------------------                                            15270000
152800     IF (B-DISCHARGE-DATE >= 20040101) AND                        15280000
152900        (B-DISCHARGE-DATE <  20050101)                            15290000
153000        COMPUTE H-SS-COST ROUNDED =                               15300000
153100            (PPS-FAC-COSTS * 1.93)                                15310000
153200        COMPUTE H-SS-PAY-AMT ROUNDED =                            15320000
153300          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93    15330000
153400     END-IF                                                       15340000
153500                                                                  15350000
153600                                                                  15360000
153700*** PROCESS FOR CY2005                                            15370000
153800*** ------------------                                            15380000
153900     IF (B-DISCHARGE-DATE >= 20050101) AND                        15390000
154000        (B-DISCHARGE-DATE <  20060101)                            15400000
154100        COMPUTE H-SS-COST ROUNDED =                               15410000
154200            (PPS-FAC-COSTS * 1.65)                                15420000
154300        COMPUTE H-SS-PAY-AMT ROUNDED =                            15430000
154400          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65    15440000
154500     END-IF                                                       15450000
154600                                                                  15460000
154700                                                                  15470000
154800*** PROCESS FOR CY2006                                            15480000
154900*** ------------------                                            15490000
155000     IF (B-DISCHARGE-DATE >= 20060101) AND                        15500000
155100        (B-DISCHARGE-DATE <  20070101)                            15510000
155200        COMPUTE H-SS-COST ROUNDED =                               15520000
155300            (PPS-FAC-COSTS * 1.36)                                15530000
155400        COMPUTE H-SS-PAY-AMT ROUNDED =                            15540000
155500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36    15550000
155600     END-IF                                                       15560000
155700                                                                  15570000
155800                                                                  15580000
155900*** PROCESS FOR CY2007 AND AFTER                                  15590000
156000*** ----------------------------                                  15600000
156100     IF (B-DISCHARGE-DATE >= 20070101)                            15610000
156200        COMPUTE H-SS-COST ROUNDED =                               15620000
156300            (PPS-FAC-COSTS * 1.2)                                 15630000
156400        COMPUTE H-SS-PAY-AMT ROUNDED =                            15640000
156500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2     15650000
156600     END-IF.                                                      15660000
156700                                                                  15670000
156800 4000-SPECIAL-PROVIDER-EXIT.                                      15680000
156900      EXIT.                                                       15690000
157000                                                                  15700000
157100                                                                  15710000
157200***************************************************************   15720000
157300*   CALCULATE THE OUTLIER THRESHOLD                           *   15730000
157400*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *   15740000
157500*     IS GREATER THAN THE OUTLIER THRESHOLD                   *   15750000
157600*   SET RETURN CODE TO INDICATE OUTLIER PAYMENT METHOD        *   15760000
157700***************************************************************   15770000
157800 7000-CALC-OUTLIER.                                               15780000
157900***************************************************************   15790000
158000                                                                  15800000
158100     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =                      15810000
158200         PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT.                  15820000
158300                                                                  15830000
158400     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD                     15840000
158500        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =                     15850000
158600         ((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)           15860000
158700           * PPS-BDGT-NEUT-RATE * H-BLEND-PPS.                    15870000
158800                                                                  15880000
158900     IF B-SPEC-PAY-IND = '1'                                      15890000
159000        MOVE 0 TO PPS-OUTLIER-PAY-AMT.                            15900000
159100                                                                  15910000
159200     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 21                  15920000
159300        MOVE 24 TO PPS-RTC.                                       15930000
159400                                                                  15940000
159500     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 22                  15950000
159600        MOVE 25 TO PPS-RTC.                                       15960000
159700                                                                  15970000
159800     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 26                  15980000
159900        MOVE 27 TO PPS-RTC.                                       15990000
160000                                                                  16000000
160100     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 00                  16010000
160200        MOVE 01 TO PPS-RTC.                                       16020000
160300                                                                  16030000
160400     IF (PPS-RTC = 00 OR 20 OR 21 OR 22 OR 26)                    16040000
160500        IF PPS-REG-DAYS-USED > H-SSOT                             16050000
160600           MOVE 0 TO PPS-LTR-DAYS-USED                            16060000
160700        ELSE                                                      16070000
160800           NEXT SENTENCE.                                         16080000
160900                                                                  16090000
161000     IF (PPS-RTC = 01 OR 24 OR 25 OR 27) OR                       16100000
161100        (PPS-COT-IND = 'Y')                                       16110000
161200                                                                  16120000
161300        IF (B-COV-DAYS < H-LOS) OR                                16130000
161400           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)16140000
161500           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =                   16150000
161600             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO      16160000
161700                                                                  16170000
161800*** ------------------------------------------------------- ***   16180000
161900*** SET PPS-RTC TO 67 IN MAINFRAME PRICER, NOT IN PC PRICER ***   16190000
162000*** (IN PC PRICER, PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS)   ***   16200000
162100*** ------------------------------------------------------- ***   16210000
162200           IF NOT PC-PRICER                                       16220000
162300              MOVE 67 TO PPS-RTC                                  16230000
162400           END-IF                                                 16240000
162500                                                                  16250000
162600        ELSE                                                      16260000
162700           NEXT SENTENCE                                          16270000
162800        END-IF                                                    16280000
162900     ELSE                                                         16290000
163000        NEXT SENTENCE                                             16300000
163100     END-IF.                                                      16310000
163200                                                                  16320000
163300                                                                  16330000
163400 7000-EXIT.                                                       16340000
163500      EXIT.                                                       16350000
163600                                                                  16360000
163700                                                                  16370000
163800***************************************************************   16380000
163900*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *   16390000
164000*   SET RTC FOR SPECIFIED BLEND YEAR INDICATOR.               *   16400000
164100***************************************************************   16410000
164200 8000-BLEND.                                                      16420000
164300***************************************************************   16430000
164400                                                                  16440000
164500     COMPUTE H-LOS-RATIO ROUNDED = H-LOS / PPS-AVG-LOS.           16450000
164600                                                                  16460000
164700     IF H-LOS-RATIO > 1                                           16470000
164800        COMPUTE H-LOS-RATIO = ((H-LOS-RATIO - 1) * .8) + 1.       16480000
164900                                                                  16490000
165000     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =                        16500000
165100           (PPS-DRG-ADJ-PAY-AMT * PPS-BDGT-NEUT-RATE)             16510000
165200             * H-BLEND-PPS.                                       16520000
165300                                                                  16530000
165400     COMPUTE PPS-NEW-FAC-SPEC-RATE ROUNDED =                      16540000
165500            (P-NEW-FAC-SPEC-RATE * PPS-BDGT-NEUT-RATE)            16550000
165600              * H-BLEND-FAC * H-LOS-RATIO.                        16560000
165700                                                                  16570000
165800     COMPUTE PPS-FINAL-PAY-AMT =                                  16580000
165900          PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT               16590000
166000              + PPS-NEW-FAC-SPEC-RATE.                            16600000
166100                                                                  16610000
166200                                                                  16620000
166300*----------------------------------------------------------*      16630000
166400* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/O OUTLIER *      16640000
166500*----------------------------------------------------------*      16650000
166600     IF (PPS-RTC = 20 OR 21 OR 22 OR 26) AND (H-BLEND-RTC > 0)    16660000
166700          COMPUTE PPS-RTC = H-BLEND-RTC + 2                       16670000
166800                                                                  16680000
166900*----------------------------------------------------------*      16690000
167000* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/ OUTLIER  *      16700000
167100*----------------------------------------------------------*      16710000
167200     ELSE                                                         16720000
167300        IF (PPS-RTC = 24 OR 25 OR 27) AND (H-BLEND-RTC > 0)       16730000
167400           COMPUTE PPS-RTC = H-BLEND-RTC + 3                      16740000
167500                                                                  16750000
167600*----------------------------------------------------------*      16760000
167700* CALCULATE RETURN CODE FOR ALL OTHER BILLS                *      16770000
167800*----------------------------------------------------------*      16780000
167900        ELSE                                                      16790000
168000           ADD H-BLEND-RTC TO PPS-RTC                             16800000
168100                                                                  16810000
168200        END-IF                                                    16820000
168300     END-IF.                                                      16830000
168400                                                                  16840000
168500 8000-EXIT.                                                       16850000
168600      EXIT.                                                       16860000
168700                                                                  16870000
168800                                                                  16880000
168900***************************************************************   16890000
169000 9000-MOVE-RESULTS.                                               16900000
169100***************************************************************   16910000
169200                                                                  16920000
169300     IF PPS-RTC < 50                                              16930000
169400        MOVE H-LOS TO PPS-LOS                                     16940000
169500        MOVE CAL-VERSION TO PPS-CALC-VERS-CD                      16950000
169600     ELSE                                                         16960000
169700       INITIALIZE PPS-DATA                                        16970000
169800       INITIALIZE PPS-OTHER-DATA                                  16980000
169900                                                                  16990000
170000*** ----------------------------------- ***                       17000000
170100*** ADDED FOR JULY 2006 RELEASE (V07.1) ***                       17010000
170200*** ----------------------------------- ***                       17020000
170300       INITIALIZE PPS-CBSA                                        17030000
170400       INITIALIZE HOLD-PPS-COMPONENTS                             17040000
170500                                                                  17050000
170600       MOVE CAL-VERSION TO PPS-CALC-VERS-CD                       17060000
170700     END-IF.                                                      17070000
170800                                                                  17080000
170900*** *************************************************** ***       17090000
171000*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***       17100000
171100*** *************************************************** ***       17110000
171200                                                                  17120000
171300*    IF (B-PROVIDER-NO = '191301' OR                              17130023
171300*                        '191302' OR                              17130123
171300*                        '191303' OR                              17130223
171300*                        '191304' OR                              17130323
171300*                        '371305' OR                              17130423
171300*                        '371306' OR                              17130523
171300*                        '361307' OR                              17130623
171300*                        '361308' OR                              17130723
171300*                        '361309' OR                              17130823
171300*                        '37130A' OR                              17130923
171300*                        '37130B' OR                              17131023
171300*                        '02130C' OR                              17131123
171300*                        '332006' OR                              17131423
171300*                        '40130F' OR                              17131523
171300*                        '40130G' OR                              17131623
171300*                        '191201' OR                              17132023
171400*                        '191202' OR                              17140023
171500*                        '371203' OR                              17150023
171600*                        '361204' OR                              17160023
171700*                        '371205' OR                              17170023
171800*                        '021206' OR                              17180023
171900*                        '401207' OR                              17190023
172000*                        '311221')                                17200023
172100*                                                                 17210023
172200*     DISPLAY '---------------------------------------------'     17220023
172300*     DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO           17230023
172400*     DISPLAY 'PPS-RTC '                  PPS-RTC                 17240023
172500*     DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT       17250023
172600*     DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE        17260023
172700*     DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES           17270023
172800*     DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD   17280023
172900*     DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT         17290023
173000*     DISPLAY 'PPS-CBSA '                 PPS-CBSA                17300023
173100*     DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX          17310023
173200*     DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX       17320023
173300*     DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX       17330023
173400**    DISPLAY 'MES-SSRFBN-RATE '          MES-SSRFBN-RATE         17340000
173500**    DISPLAY 'MES-SSRFBN-STATE '         MES-SSRFBN-STATE        17350000
173600*     DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX    17360023
173700*     DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT     17370023
173800*     DISPLAY 'B-DRG-CODE '               B-DRG-CODE              17380023
173900*     DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS             17390023
174000*     DISPLAY 'H-SSOT '                   H-SSOT                  17400023
174100*     DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT        17410023
174200*     DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH            17420023
174300*     DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT     17430023
174400*     DISPLAY 'H-LOS '                    H-LOS                   17440023
174500*     DISPLAY 'H-REG-DAYS '               H-REG-DAYS              17450023
174600*     DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS            17460023
174700*     DISPLAY 'H-SSOT '                   H-SSOT                  17470023
174800*     DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC             17480023
174900*     DISPLAY 'H-BLEND-FAC '              H-BLEND-FAC             17490023
175000*     DISPLAY 'H-BLEND-PPS '              H-BLEND-PPS             17500023
175100*     DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT            17510023
175200*     DISPLAY 'H-SS-COST '                H-SS-COST               17520023
175300*     DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION         17530023
175400*     DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION      17540023
175500*     DISPLAY 'H-FIXED-LOSS-AMT '         H-FIXED-LOSS-AMT        17550023
175600*     DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE     17560023
175700*     DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO             17570023
175800*     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO          17580023
175900*     DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH        17590023
176000*     DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH        17600023
176100*     DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT        17610023
176200*     DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT        17620023
176300*     DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT        17630023
176400*     DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT        17640023
176500*     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO          17650023
176600*     DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO        17660023
176700*     DISPLAY 'H-BED-SIZE '               H-BED-SIZE              17670023
176800*     DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT          17680023
176900*     DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO             17690023
177000*     DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO        17700023
177100*     DISPLAY 'H-OPER-DSH '               H-OPER-DSH              17710023
177200*     DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH              17720023
177300*     DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS             17730023
177400*     DISPLAY 'H-URBAN-IND '              H-URBAN-IND             17740023
177500*     DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT    17750023
177600*     DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT 17760023
177700*     DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT              17770023
177800*     DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT           17780023
177900*     DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF              17790023
178000*     DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF           17800023
178100*     DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON         17810023
178200*     DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT          17820023
178300*     DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT       17830023
178400*     DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM         17840023
178500*     DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM      17850023
178600*     DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT        17860023
178700*     DISPLAY 'H-OPER-COLA '              H-OPER-COLA             17870023
178800*     DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA             17880023
178900*     DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR    17890023
179000*     DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR 17900023
179100*     DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR     17910023
179200*     DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR  17920023
179300*     DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT          17930023
179400*     DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS         17940023
179500*     DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF      17950023
179600*     DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS       17960023
179700*     DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE17970023
179800*     DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE 17980023
179900*     DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT      17990023
180000*     DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT       18000023
180100*     DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT 18010023
180200*     DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND           18020023
180300*     DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND        18030023
180400*     DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND          18040023
180500*     DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND       18050023
180600                                                                  18060000
180700*    END-IF.                                                      18070024
180800                                                                  18080000
180900 9000-EXIT.                                                       18090000
181000      EXIT.                                                       18100000
181100                                                                  18110000
181200******        L A S T   S O U R C E   S T A T E M E N T   *****   18120000
