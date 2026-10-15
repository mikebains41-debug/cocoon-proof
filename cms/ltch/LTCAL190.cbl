000100 IDENTIFICATION DIVISION.                                         00010012
000200 PROGRAM-ID.     LTCAL190.                                        00020012
000300*AUTHOR.         CMS.                                             00030012
000400*REMARKS.        EFFECTIVE DATE = OCTOBER 1, 2018                 00040012
000500***********************************************************       00050012
000600*                                                                 00060012
000700* UPDATED OCTOBER 5, 2018.                                        00070012
000800* VERSION 19.0.                                                   00080012
000900* IMPLEMENTATION DATE = OCTOBER 1, 2018.                          00090012
001000* IMPLEMENTS CR10869                                              00100012
001100*                                                                 00110012
001200*                                                                 00120012
001300*                                                                 00130012
001400* FROM THE FY 2019 LTCH PPS PRICER SPEC SHEET 9-7-18              00140012
001500*                                                                 00150012
001600*                                                                 00160012
001700* PRICER STANDARD FEDERAL RATES/FACTORS/POLICY:                   00170012
001800*                                                                 00180012
001900* STANDARD FEDERAL RATES (BASED ON QUALITY DATA REPORT STATUS     00190012
002000* FOR FY19):                                                      00200012
002100*                                                                 00210012
002200* * FULL UPDATE (QUALITY INDICATOR ON PSF = 1): $41558,68         00220012
002300* * REDUCED UPDATE (QUALITY INDICATOR ON PSF = 0 OR BLANK):       00230012
002400* $40738.57                                                       00240012
002500*                                                                 00250012
002600* LABOR SHARE: 66.0% (0.660)                                      00260012
002700*                                                                 00270012
002800* NONLABOR SHARE: 34.0% (0.340)                                   00280012
002900*                                                                 00290012
003000* HIGH COST OUTLIER FIXED-LOSS AMOUNTS (NO POLICY/CALCULATION     00300012
003100* LOGIC CHANGES)                                                  00310012
003200*                                                                 00320012
003300* * STANDARD RATE CASES: $27121                                   00330012
003400* * SITE NEUTRAL RATE CASES: $25743                               00340012
003500*                                                                 00350012
003600* SITE NEUTRAL RATE HCO BUDGET NEUTRALITY FACTOR: 0.949 (NO       00360012
003700* POLICY/CALCULATION LOGIC CHANGES)                               00370012
003800*                                                                 00380012
003900* SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS: 0.954 (NO        00390012
004000* POLICY/CALCULATION LOGIC CHANGES)                               00400012
004100*                                                                 00410012
004200* SSO AND SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS:          00420012
004300*                                                                 00430012
004400* IPPS LABOR SHARE WAGE INDEX > 1: $3856.27                       00440012
004500* IPPS NONLABOR SHARE WAGE INDEX > 1: $1789.81                    00450012
004600* IPPS LABOR SHARE WAGE INDEX < /= 1:  $3500.57                   00460012
004700* IPPS NONLABOR SHARE WAGE INDEX < /= 1:  $2145.51                00470012
004800* CAPITAL NATIONAL RATE: $459.41                                  00480012
004900*                                                                 00490012
005000* * REDUCTION FACTOR FOR IPPS COMPARABLE OPERATING DSH PAYMENT    00500012
005100* AMOUNT: 75.63% OR A FACTOR OF 0.7563. (THIS REDUCTION IS NOT    00510012
005200* APPLIED TO THE CAPITAL DSH PAYMENT CALCULATION.)                00520012
005300*                                                                 00530012
005400* * USE FY 2019 IPPS AREA WAGE INDEXES & MS-DRG WEIGHTS/LENGTH    00540012
005500* OF STAY                                                         00550012
005600*                                                                 00560012
005700* 10-5-18 CORRECTED H-IPPS-NAT-NONLABOR-SHR TO 1789.81            00570012
005800*                                                                 00580012
005900***********************************************************       00590012
006000 ENVIRONMENT DIVISION.                                            00600012
006100 CONFIGURATION SECTION.                                           00610012
006200 SOURCE-COMPUTER.            IBM-370.                             00620012
006300 OBJECT-COMPUTER.            IBM-370.                             00630012
006400 INPUT-OUTPUT  SECTION.                                           00640012
006500 FILE-CONTROL.                                                    00650012
006600                                                                  00660012
006700 DATA DIVISION.                                                   00670012
006800 FILE SECTION.                                                    00680012
006900                                                                  00690012
007000 WORKING-STORAGE SECTION.                                         00700012
007100 01  W-STORAGE-REF                  PIC X(46)  VALUE              00710012
007200     'LTCAL190      - W O R K I N G   S T O R A G E'.             00720012
007300 01  CAL-VERSION                    PIC X(05)  VALUE 'V19.0'.     00730012
007400 01  PROGRAM-CONSTANTS.                                           00740012
007500     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.     00750012
007600     05  VENT-ICD-10-CODE           PIC X(07) VALUE '5A1955Z'.    00760012
007700 01  PROGRAM-FLAGS.                                               00770012
007800     05  WS-PRIMARY-PMT-TYPE        PIC X(01).                    00780012
007900         88 PMT-STANDARD-OLD       VALUE '1'.                     00790012
008000         88 PMT-STANDARD-NEW       VALUE '2'.                     00800012
008100         88 PMT-SITE-NEUTRAL       VALUE '3'.                     00810012
008200         88 PMT-BLEND              VALUE '4'.                     00820012
008300     05  WS-SECONDARY-PMT-TYPE-SNT  PIC X(01).                    00830012
008400         88 PMT-SITE-NEUT-COST     VALUE '1'.                     00840012
008500         88 PMT-SITE-NEUT-IPPS     VALUE '2'.                     00850012
008600     05  WS-SECONDARY-PMT-TYPE-STD  PIC X(01).                    00860012
008700         88 PMT-STANDARD-FULL      VALUE '1'.                     00870012
008800         88 PMT-STANDARD-SSO       VALUE '2'.                     00880012
008900     05  WS-VENT-STATUS             PIC X(01).                    00890012
009000         88 VENT-PRESENT           VALUE 'Y'.                     00900012
009100         88 VENT-NOT-PRESENT       VALUE 'N'.                     00910012
009200                                                                  00920012
009300                                                                  00930012
009400***************************************************************   00940012
009500*    LAYUP TABLE AREA FOR FY2019 LTC-DRG                      *   00950012
009600*    EFFECTIVE DATE OF OCTOBER 1, 2018                        *   00960012
009700***************************************************************   00970012
009800 COPY LTDRG190.                                                   00980012
009900                                                                  00990012
010000                                                                  01000012
010100***************************************************************   01010012
010200*    LAYUP TABLE AREA FOR FY2019 IPPS-DRG                     *   01020012
010300*    EFFECTIVE DATE OF OCTOBER 1, 2018                        *   01030012
010400***************************************************************   01040012
010500 COPY IPDRG190.                                                   01050012
010600                                                                  01060012
010700                                                                  01070012
010800***************************************************************   01080012
010900*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *   01090012
011000***************************************************************   01100012
011100 01  HOLD-PPS-COMPONENTS.                                         01110012
011200     05  H-LOS                        PIC 9(03).                  01120012
011300     05  H-REG-DAYS                   PIC 9(03).                  01130012
011400     05  H-TOTAL-DAYS                 PIC 9(05).                  01140012
011500     05  H-SSOT                       PIC 9(02)V9(01).            01150012
011600     05  H-BLEND-RTC                  PIC 9(02).                  01160012
011700     05  H-BLEND-SNT                  PIC 9(01)V9(01).            01170012
011800     05  H-BLEND-STD                  PIC 9(01)V9(01).            01180012
011900     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).            01190012
012000     05  H-SS-COST                    PIC 9(07)V9(02).            01200012
012100     05  H-LABOR-PORTION              PIC 9(07)V9(06).            01210012
012200     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).            01220012
012300     05  H-FIXED-LOSS-AMT-STD         PIC 9(07)V9(02).            01230012
012400     05  H-FIXED-LOSS-AMT-SNT         PIC 9(07)V9(02).            01240012
012500     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).            01250012
012600     05  H-LOS-RATIO                  PIC 9(01)V9(05).            01260012
012700                                                                  01270012
012800*** --------------------------------------------------- ***       01280012
012900*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***       01290012
013000*** --------------------------------------------------- ***       01300012
013100     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).            01310012
013200     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).            01320012
013300     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).            01330012
013400     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).            01340012
013500     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).            01350012
013600     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).            01360012
013700     05  H-INTERN-RATIO               PIC 9(01)V9(04).            01370012
013800     05  H-CAPI-IME-RATIO             PIC 9V9999.                 01380012
013900     05  H-BED-SIZE                   PIC 9(05).                  01390012
014000     05  H-OPER-DSH-PCT               PIC V9(04).                 01400012
014100     05  H-SSI-RATIO                  PIC V9(04).                 01410012
014200     05  H-MEDICAID-RATIO             PIC V9(04).                 01420012
014300     05  H-OPER-DSH                   PIC 9(01)V9(04).            01430012
014400     05  H-CAPI-DSH                   PIC 9(01)V9(04).            01440012
014500     05  H-GEO-CLASS                  PIC X(01).                  01450012
014600     05  H-URBAN-IND                  PIC X(01).                  01460012
014700           88 URBAN-CBSA           VALUE '1'.                     01470012
014800           88 RURAL-CBSA           VALUE '0'.                     01480012
014900     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).            01490012
015000     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).            01500012
015100     05  H-CAPI-PMT                   PIC 9(07)V9(02).            01510012
015200     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).            01520012
015300     05  H-CAPI-GAF                   PIC 9(05)V9(04).            01530012
015400     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).            01540012
015500     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).            01550012
015600     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).            01560012
015700     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).            01570012
015800     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).            01580012
015900     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).            01590012
016000     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).            01600012
016100     05  H-OPER-COLA                  PIC 9(01)V9(03).            01610012
016200     05  H-CAPI-COLA                  PIC 9(01)V9(03).            01620012
016300     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).            01630012
016400     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).            01640012
016500     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).            01650012
016600     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).            01660012
016700     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).            01670012
016800     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).            01680012
016900     05  H-IPPS-DAYS-CUTOFF           PIC 9(02)V9(01).            01690012
017000     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).            01700012
017100     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).            01710012
017200     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).            01720012
017300*    05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).            01730012
017400*    05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).            01740012
017500     05  H-NAT-OPER-IPPS-PMT-PCT      PIC 9(01)V9(02).            01750012
017600     05  H-PR-OPER-IPPS-PMT-PCT       PIC 9(01)V9(02).            01760012
017700     05  H-NAT-CAPI-IPPS-PMT-PCT      PIC 9(01)V9(02).            01770012
017800     05  H-PR-CAPI-IPPS-PMT-PCT       PIC 9(01)V9(02).            01780012
017900     05  H-COUNTER                    PIC 9(02).                  01790012
018000     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).            01800012
018100     05  H-OPER-DSH-REDUCTION-FACTOR  PIC V9(04).                 01810012
018200     05  H-OUTLIER-THRESHOLD-STD      PIC 9(07)V9(02).            01820012
018300     05  H-BDGT-NEUT-FACTOR           PIC 9(01)V9(06).            01830012
018400     05  H-OUTLIER-PAY-AMT-STD        PIC 9(07)V9(02).            01840012
018500     05  H-OUTLIER-PAY-AMT-SNT        PIC 9(07)V9(02).            01850012
018600     05  H-OUTLIER-IPPS-COMPARABLE    PIC 9(07)V9(02).            01860012
018700     05  H-SN-COST-4COMPARISON        PIC 9(07)V9(02).            01870012
018800     05  H-SN-IPPS-4COMPARISON        PIC 9(07)V9(02).            01880012
018900     05  H-SITE-NEUTRAL-IPPS-ADJ      PIC 9(01)V9(06).            01890012
019000                                                                  01900012
019100*** --------------------------------------------------- ***       01910012
019200*** VARIABLES FOR PC PRICER                             ***       01920012
019300*** --------------------------------------------------- ***       01930012
019400     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).            01940012
019500     05  H-SS-COST-IND                PIC X.                      01950012
019600     05  H-SS-PERDIEM-IND             PIC X.                      01960012
019700     05  H-SS-BLEND-IND               PIC X.                      01970012
019800     05  H-SS-IPPSCOMP-IND            PIC X.                      01980012
019900                                                                  01990012
020000                                                                  02000012
020100*---------------------------------------------------------*       02010012
020200* 8-6-14 ADDED WK-HLDDRG-DATA AND WK-HLDDRG-DATA2 TO      *       02020012
020300* MATCH THE IPPS DRG TABLE DATA NAMES THAT WERE COPIED    *       02030012
020400* FROM THE FY14 IPPS PRICER CALCULATION PROGRAM           *       02040012
020500*---------------------------------------------------------*       02050012
020600                                                                  02060012
020700 01 WK-HLDDRG-DATA.                                               02070012
020800     05  HLDDRG-DATA.                                             02080012
020900         10  HLDDRG-DRGX               PIC X(03).                 02090012
021000         10  FILLER1                   PIC X(01).                 02100012
021100         10  HLDDRG-WEIGHT             PIC 9(02)V9(04).           02110012
021200         10  FILLER2                   PIC X(01).                 02120012
021300         10  HLDDRG-GMALOS             PIC 9(02)V9(01).           02130012
021400         10  FILLER3                   PIC X(05).                 02140012
021500         10  HLDDRG-LOW                PIC X(01).                 02150012
021600         10  FILLER5                   PIC X(01).                 02160012
021700         10  HLDDRG-ARITH-ALOS         PIC 9(02)V9(01).           02170012
021800         10  FILLER6                   PIC X(02).                 02180012
021900         10  HLDDRG-PAC                PIC X(01).                 02190012
022000         10  FILLER7                   PIC X(01).                 02200012
022100         10  HLDDRG-SPPAC              PIC X(01).                 02210012
022200         10  FILLER8                   PIC X(02).                 02220012
022300         10  HLDDRG-DESC               PIC X(26).                 02230012
022400                                                                  02240012
022500 01 WK-HLDDRG-DATA2.                                              02250012
022600     05  HLDDRG-DATA2.                                            02260012
022700         10  HLDDRG-DRGX2               PIC X(03).                02270012
022800         10  FILLER21                   PIC X(01).                02280012
022900         10  HLDDRG-WEIGHT2             PIC 9(02)V9(04).          02290012
023000         10  FILLER22                   PIC X(01).                02300012
023100         10  HLDDRG-GMALOS2             PIC 9(02)V9(01).          02310012
023200         10  FILLER23                   PIC X(05).                02320012
023300         10  HLDDRG-LOW2                PIC X(01).                02330012
023400         10  FILLER25                   PIC X(01).                02340012
023500         10  HLDDRG-ARITH-ALOS2         PIC 9(02)V9(01).          02350012
023600         10  FILLER26                   PIC X(02).                02360012
023700         10  HLDDRG-TRANS-FLAGS.                                  02370012
023800                   88  D-DRG-POSTACUTE-50-50                      02380012
023900                   VALUE 'Y Y'.                                   02390012
024000                   88  D-DRG-POSTACUTE-PERDIEM                    02400012
024100                   VALUE 'Y  '.                                   02410012
024200             15  HLDDRG-PAC2            PIC X(01).                02420012
024300             15  FILLER27               PIC X(01).                02430012
024400             15  HLDDRG-SPPAC2          PIC X(01).                02440012
024500         10  FILLER28                   PIC X(02).                02450012
024600         10  HLDDRG-DESC2               PIC X(26).                02460012
024700         10  HLDDRG-VALID               PIC X(01).                02470012
024800                                                                  02480012
024900                                                                  02490012
025000                                                                  02500012
025100                                                                  02510012
025200                                                                  02520012
025300 LINKAGE SECTION.                                                 02530012
025400                                                                  02540012
025500**************************************************************    02550012
025600* THE LINKAGE SECTION CONTAINS DESCRIPTIONS OF THE FIELDS THAT    02560012
025700* CONTAIN VALUES THAT ARE PASSED FROM THE CALLING PROGRAM         02570012
025800* (LTDRV... IN THIS CASE)                                         02580012
025900**************************************************************    02590012
026000                                                                  02600012
026100                                                                  02610012
026200**************************************************************    02620012
026300* BILL-NEW-DATA IS THE BILL RECORD FROM THE LTDRV... PROGRAM      02630012
026400**************************************************************    02640012
026500 01  BILL-NEW-DATA.                                               02650012
026600     10  B-NPI10.                                                 02660012
026700         15  B-NPI8               PIC X(08).                      02670012
026800         15  B-NPI-FILLER         PIC X(02).                      02680012
026900     10  B-PROVIDER-NO            PIC X(06).                      02690012
027000     10  B-PATIENT-STATUS         PIC X(02).                      02700012
027100     10  B-DRG-CODE               PIC 9(03).                      02710012
027200     10  B-LOS                    PIC 9(03).                      02720012
027300     10  B-COV-DAYS               PIC 9(03).                      02730012
027400     10  B-LTR-DAYS               PIC 9(02).                      02740012
027500     10  B-CST-RPT-DAYS           PIC 9(03).                      02750012
027600     10  B-DISCHARGE-DATE.                                        02760012
027700         15  B-DISCHG-CC          PIC 9(02).                      02770012
027800         15  B-DISCHG-YY          PIC 9(02).                      02780012
027900         15  B-DISCHG-MM          PIC 9(02).                      02790012
028000         15  B-DISCHG-DD          PIC 9(02).                      02800012
028100     10  B-COV-CHARGES            PIC 9(07)V9(02).                02810012
028200     10  B-SPEC-PAY-IND           PIC X(01).                      02820012
028300     05  B-REVIEW-CODE            PIC 9(02).                      02830012
028400     05  B-DIAGNOSIS-CODE-TABLE.                                  02840012
028500         10  B-DIAGNOSIS-CODE     PIC X(07) OCCURS 25 TIMES       02850012
028600                                  INDEXED BY IDX-DIAG.            02860012
028700     05  B-PROCEDURE-CODE-TABLE.                                  02870012
028800         10  B-PROCEDURE-CODE     PIC X(07) OCCURS 25 TIMES       02880012
028900                                  INDEXED BY IDX-PROC.            02890012
029000     05  FILLER                   PIC X(20).                      02900012
029100                                                                  02910012
029200                                                                  02920012
029300***************************************************************   02930012
029400***************************************************************   02940012
029500*                                                             *   02950012
029600*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *   02960012
029700*    AND PASSED BACK TO THE CALLING PROGRAM (LTDRV)           *   02970012
029800*    RETURN CODE VALUES (PPS-RTC)                             *   02980012
029900*                                                             *   02990012
030000*     ** OLD POLICY RETURN CODE VALUES AND DESCRIPTIONS       *   03000012
030100*     ** ----------------------------------------------       *   03010012
030200*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *   03020012
030300*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *   03030012
030400*                                                             *   03040012
030500*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *   03050012
030600*                                                             *   03060012
030700*             02 = SHORT STAY PAYMENT WITHOUT OUTLIER         *   03070012
030800*                                                             *   03080012
030900*             03 = SHORT STAY PAYMENT WITH OUTLIER            *   03090012
031000*                                                             *   03100012
031100*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   03110012
031200*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   03120012
031300*                                                             *   03130012
031400*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   03140012
031500*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *   03150012
031600*                                                             *   03160012
031700*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   03170012
031800*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *   03180012
031900*                                                             *   03190012
032000*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *   03200012
032100*                  20% SHORT STAY PAYMENT WITH OUTLIER        *   03210012
032200*                                                             *   03220012
032300*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   03230012
032400*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   03240012
032500*                                                             *   03250012
032600*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   03260012
032700*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *   03270012
032800*                                                             *   03280012
032900*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   03290012
033000*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *   03300012
033100*                                                             *   03310012
033200*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *   03320012
033300*                  40% SHORT STAY PAYMENT WITH OUTLIER        *   03330012
033400*                                                             *   03340012
033500*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   03350012
033600*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   03360012
033700*                                                             *   03370012
033800*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   03380012
033900*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *   03390012
034000*                                                             *   03400012
034100*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   03410012
034200*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *   03420012
034300*                                                             *   03430012
034400*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *   03440012
034500*                  60% SHORT STAY PAYMENT WITH OUTLIER        *   03450012
034600*                                                             *   03460012
034700*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   03470012
034800*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *   03480012
034900*                                                             *   03490012
035000*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   03500012
035100*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *   03510012
035200*                                                             *   03520012
035300*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   03530012
035400*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *   03540012
035500*                                                             *   03550012
035600*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *   03560012
035700*                  80% SHORT STAY PAYMENT WITH OUTLIER        *   03570012
035800*                                                             *   03580012
035900*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *   03590012
036000*                  WITHOUT OUTLIER                            *   03600012
036100*                                                             *   03610012
036200*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *   03620012
036300*                  DIEM WITHOUT OUTLIER                       *   03630012
036400*                                                             *   03640012
036500*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *   03650012
036600*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *   03660012
036700*                  AMOUNT WITHOUT OUTLIER                     *   03670012
036800*                                                             *   03680012
036900*             23 = SHORT STAY PAYMENT BASED ON ESTIMATED      *   03690012
037000*                  COST WITH OUTLIER                          *   03700012
037100*                                                             *   03710012
037200*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *   03720012
037300*                  DIEM WITH OUTLIER                          *   03730012
037400*                                                             *   03740012
037500*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *   03750012
037600*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *   03760012
037700*                  AMOUNT WITH OUTLIER                        *   03770012
037800*                                                             *   03780012
037900*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *   03790012
038000*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *   03800012
038100*            FOR IPPS COMPARABLE PER DIEM)                    *   03810012
038200*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *   03820012
038300*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *   03830012
038400*            FOR IPPS COMPARABLE PER DIEM)                    *   03840012
038500*                                                             *   03850012
038600*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *   03860012
038700*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *   03870012
038800*                                                             *   03880012
038900*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *   03890012
039000*                  COMPARABLE THRESHOLD WITH OUTLIER          *   03900012
039100*                                                             *   03910012
039200*             28 = SUBCLAUSE (II) DOES NOT QUALIFY FOR AN     *   03920012
039300*                  OUTLIER                                    *   03930012
039400*                                                             *   03940012
039500*             29 = SUBCLAUSE (II) QUALIFIES FOR AN OUTLIER    *   03950012
039600*                                                             *   03960012
039700*                                                             *   03970012
039800*     ** OLD & NEW POLICY ERROR CODE VALUES AND DESCRIPTIONS  *   03980012
039900*     ** ---------------------------------------------------  *   03990012
040000*     *****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *   04000012
040100*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *   04010012
040200*             51 = PROVIDER RECORD TERMINATED                 *   04020012
040300*             52 = INVALID WAGE INDEX                         *   04030012
040400*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *   04040012
040500*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *   04050012
040600*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *   04060012
040700*                                     OR                      *   04070012
040800*                  DISCHARGE DATE < CBSA EFF START DATE       *   04080012
040900*                  FOR PPS                                    *   04090012
041000*             56 = INVALID LENGTH OF STAY                     *   04100012
041100*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *   04110012
041200*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *   04120012
041300*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *   04130012
041400*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *   04140012
041500*                  OR BILL-LTR-DAYS > 60                      *   04150012
041600*             62 = INVALID NUMBER OF COVERED DAYS             *   04160012
041700*                  OR BILL-LTR-DAYS > COVERED DAYS            *   04170012
041800*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *   04180012
041900*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *   04190012
042000*                  OR COST OUTLIER THRESHOLD CALCULATION      *   04200012
042100*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *   04210012
042200*             72 = INVALID BLEND INDICATOR OR REVIEW CODE     *   04220012
042300*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *   04230012
042400*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *   04240012
042500*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *   04250012
042600*                                                             *   04260012
042700*                                                             *   04270012
042800*             ADDITIONAL RETURN CODES STARTING IN 2016:       *   04280012
042900*                                                             *   04290012
043000*             A0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   04300012
043100*                  PSYCH/REHAB                                *   04310012
043200*                                                             *   04320012
043300*             A1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   04330012
043400*                  OUTLIER, PSYCH/REHAB                       *   04340012
043500*                                                             *   04350012
043600*             A2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   04360012
043700*                  SSO, PSYCH/REHAB                           *   04370012
043800*                                                             *   04380012
043900*             A3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   04390012
044000*                  SSO, OUTLIER, PSYCH/REHAB                  *   04400012
044100*                                                             *   04410012
044200*             A4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   04420012
044300*                  PSYCH/REHAB                                *   04430012
044400*                                                             *   04440012
044500*             A5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   04450012
044600*                  OUTLIER, PSYCH/REHAB                       *   04460012
044700*                                                             *   04470012
044800*             A6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   04480012
044900*                  SSO, PSYCH/REHAB                           *   04490012
045000*                                                             *   04500012
045100*             A7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   04510012
045200*                  SSO, OUTLIER, PSYCH/REHAB                  *   04520012
045300*                                                             *   04530012
045400*             AA = SITE-NEUTRAL BASED ON COST,                *   04540012
045500*                  PSYCH/REHAB                                *   04550012
045600*                                                             *   04560012
045700*             AB = SITE-NEUTRAL BASED ON IPPS,                *   04570012
045800*                  PSYCH/REHAB                                *   04580012
045900*                                                             *   04590012
046000*             AC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *   04600012
046100*                  PSYCH/REHAB                                *   04610012
046200*                                                             *   04620012
046300*             B0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   04630012
046400*                  VENT                                       *   04640012
046500*                                                             *   04650012
046600*             B1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   04660012
046700*                  OUTLIER, VENT                              *   04670012
046800*                                                             *   04680012
046900*             B2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   04690012
047000*                  SSO, VENT                                  *   04700012
047100*                                                             *   04710012
047200*             B3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   04720012
047300*                  SSO, OUTLIER, VENT                         *   04730012
047400*                                                             *   04740012
047500*             B4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   04750012
047600*                  VENT                                       *   04760012
047700*                                                             *   04770012
047800*             B5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   04780012
047900*                  OUTLIER, VENT                              *   04790012
048000*                                                             *   04800012
048100*             B6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   04810012
048200*                  SSO, VENT                                  *   04820012
048300*                                                             *   04830012
048400*             B7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   04840012
048500*                  SSO, OUTLIER, VENT                         *   04850012
048600*                                                             *   04860012
048700*             BA = SITE-NEUTRAL BASED ON COST, VENT           *   04870012
048800*                                                             *   04880012
048900*             BB = SITE-NEUTRAL BASED ON IPPS, VENT           *   04890012
049000*                                                             *   04900012
049100*             BC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *   04910012
049200*                  VENT                                       *   04920012
049300*                                                             *   04930012
049400*             BD = SSO STANDARD PAYMENT, VENT                 *   04940012
049500*                                                             *   04950012
049600*             BE = SSO STANDARD PAYMENT, OUTLIER, VENT        *   04960012
049700*                                                             *   04970012
049800*             BF = STANDARD PAYMENT FULL DRG, VENT            *   04980012
049900*                                                             *   04990012
050000*             BG = STANDARD PAYMENT FULL DRG, OUTLIER,        *   05000012
050100*                  VENT                                       *   05010012
050200*                                                             *   05020012
050300*             C0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   05030012
050400*                  NO VENT                                    *   05040012
050500*                                                             *   05050012
050600*             C1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   05060012
050700*                  OUTLIER, NO VENT                           *   05070012
050800*                                                             *   05080012
050900*             C2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   05090012
051000*                  SSO, NO VENT                               *   05100012
051100*                                                             *   05110012
051200*             C3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *   05120012
051300*                  SSO, OUTLIER, NO VENT                      *   05130012
051400*                                                             *   05140012
051500*             C4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   05150012
051600*                  NO VENT                                    *   05160012
051700*                                                             *   05170012
051800*             C5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   05180012
051900*                  OUTLIER, NO VENT                           *   05190012
052000*                                                             *   05200012
052100*             C6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   05210012
052200*                  SSO, NO VENT                               *   05220012
052300*                                                             *   05230012
052400*             C7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *   05240012
052500*                  SSO, OUTLIER, NO VENT                      *   05250012
052600*                                                             *   05260012
052700*             CA = SITE-NEUTRAL BASED ON COST, NO VENT        *   05270012
052800*                                                             *   05280012
052900*             CB = SITE-NEUTRAL BASED ON IPPS, NO VENT        *   05290012
053000*                                                             *   05300012
053100*             CC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *   05310012
053200*                  NO VENT                                    *   05320012
053300*                                                             *   05330012
053400*             CD = SSO STANDARD PAYMENT, NO VENT              *   05340012
053500*                                                             *   05350012
053600*             CE = SSO STANDARD PAYMENT, OUTLIER,             *   05360012
053700*                  NO VENT                                    *   05370012
053800*                                                             *   05380012
053900*             CF = STANDARD PAYMENT FULL DRG, NO VENT         *   05390012
054000*                                                             *   05400012
054100*                                                             *   05410012
054200***************************************************************   05420012
054300***************************************************************   05430012
054400*                                                                 05440012
054500*                                                                 05450012
054600***************************************************************   05460012
054700* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *   05470012
054800* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *   05480012
054900***************************************************************   05490012
055000 01  PPS-DATA-ALL.                                                05500012
055100     05  PPS-RTC.                                                 05510012
055200           88  OLD-ERROR-CODE        VALUE '50' THRU '99'.        05520012
055300         10  PPS-RTC-1                 PIC X.                     05530012
055400               88  NEW-ERROR-CODE    VALUE 'D'.                   05540012
055500         10  PPS-RTC-2                 PIC X.                     05550012
055600     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).           05560012
055700     05  PPS-DATA.                                                05570012
055800         10  PPS-MSA                   PIC X(04).                 05580012
055900         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).           05590012
056000         10  PPS-AVG-LOS               PIC 9(02)V9(01).           05600012
056100         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).           05610012
056200         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).           05620012
056300         10  PPS-LOS                   PIC 9(03).                 05630012
056400         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).           05640012
056500         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).           05650012
056600         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).           05660012
056700         10  PPS-FAC-COSTS             PIC 9(07)V9(02).           05670012
056800         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).           05680012
056900         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).           05690012
057000         10  PPS-SUBM-DRG-CODE         PIC X(03).                 05700012
057100               88  PSYCH-REHAB-DRG   VALUE                        05710012
057200                   '876' '880' '881' '882' '883' '884'            05720012
057300                   '885' '887' '886' '894' '895' '896'            05730012
057400                   '897' '945' '946'.                             05740012
057500         10  PPS-CALC-VERS-CD          PIC X(05).                 05750012
057600         10  PPS-REG-DAYS-USED         PIC 9(03).                 05760012
057700         10  PPS-LTR-DAYS-USED         PIC 9(03).                 05770012
057800         10  PPS-BLEND-YEAR            PIC 9(01).                 05780012
057900         10  PPS-COLA                  PIC 9(01)V9(03).           05790012
058000         10  FILLER                    PIC X(04).                 05800012
058100     05  PPS-OTHER-DATA.                                          05810012
058200         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).           05820012
058300         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).           05830012
058400         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).           05840012
058500         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).           05850012
058600         10  PPS-IPTHRESH              PIC 9(03)V9(01).           05860012
058700         10  FILLER                    PIC X(16).                 05870012
058800     05  PPS-PC-DATA.                                             05880012
058900         10  PPS-COT-IND               PIC X(01).                 05890012
059000         10  H-PC-IND                  PIC X(02).                 05900012
059100               88  PC-PRICER               VALUE 'PC'.            05910012
059200         10  FILLER                    PIC X(18).                 05920012
059300                                                                  05930012
059400 01  PPS-CBSA                          PIC X(05).                 05940012
059500                                                                  05950012
059600                                                                  05960012
059700 01  PPS-PAYMENT-DATA.                                            05970012
059800     05  PPS-SITE-NEUTRAL-COST-PMT     PIC 9(07)V99.              05980012
059900     05  PPS-SITE-NEUTRAL-IPPS-PMT     PIC 9(07)V99.              05990012
060000     05  PPS-STANDARD-FULL-PMT         PIC 9(07)V99.              06000012
060100     05  PPS-STANDARD-SSO-PMT          PIC 9(07)V99.              06010012
060200                                                                  06020012
060300                                                                  06030012
060400******************************************************************06040012
060500*            THESE ARE THE VERSIONS OF THE LTDRV___              *06050012
060600*           PROGRAMS THAT WILL BE PASSED BACK----                *06060012
060700*          ASSOCIATED WITH THE BILL BEING PROCESSED              *06070012
060800******************************************************************06080012
060900 01  PRICER-OPT-VERS-SW.                                          06090012
061000     05  PRICER-OPTION-SW          PIC X(01).                     06100012
061100         88  ALL-TABLES-PASSED          VALUE 'A'.                06110012
061200         88  PROV-RECORD-PASSED         VALUE 'P'.                06120012
061300     05  PPS-VERSIONS.                                            06130012
061400         10  PPDRV-VERSION         PIC X(05).                     06140012
061500                                                                  06150012
061600                                                                  06160012
061700**************************************************************    06170012
061800* PROV-NEW-HOLD IS THE PROVIDER RECORD THAT IS PASSED FROM   *    06180012
061900* LTDRV___) TO LTCAL___                                      *    06190012
062000**************************************************************    06200012
062100 01  PROV-NEW-HOLD.                                               06210012
062200     02  PROV-NEWREC-HOLD1.                                       06220012
062300         05  P-NEW-NPI10.                                         06230012
062400             10  P-NEW-NPI8             PIC X(08).                06240012
062500             10  P-NEW-NPI-FILLER       PIC X(02).                06250012
062600         05  P-NEW-PROVIDER-NO.                                   06260012
062700               88  SUBCLAUSEII-PROV       VALUE '332006'.         06270012
062800             10  P-NEW-STATE            PIC 9(02).                06280012
062900             10  FILLER                 PIC X(04).                06290012
063000         05  P-NEW-DATE-DATA.                                     06300012
063100             10  P-NEW-EFF-DATE.                                  06310012
063200                 15  P-NEW-EFF-DT-CC    PIC 9(02).                06320012
063300                 15  P-NEW-EFF-DT-YY    PIC 9(02).                06330012
063400                 15  P-NEW-EFF-DT-MM    PIC 9(02).                06340012
063500                 15  P-NEW-EFF-DT-DD    PIC 9(02).                06350012
063600             10  P-NEW-FY-BEGIN-DATE.                             06360012
063700                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).                06370012
063800                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).                06380012
063900                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).                06390012
064000                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).                06400012
064100             10  P-NEW-REPORT-DATE.                               06410012
064200                 15  P-NEW-REPORT-DT-CC PIC 9(02).                06420012
064300                 15  P-NEW-REPORT-DT-YY PIC 9(02).                06430012
064400                 15  P-NEW-REPORT-DT-MM PIC 9(02).                06440012
064500                 15  P-NEW-REPORT-DT-DD PIC 9(02).                06450012
064600             10  P-NEW-TERMINATION-DATE.                          06460012
064700                 15  P-NEW-TERM-DT-CC   PIC 9(02).                06470012
064800                 15  P-NEW-TERM-DT-YY   PIC 9(02).                06480012
064900                 15  P-NEW-TERM-DT-MM   PIC 9(02).                06490012
065000                 15  P-NEW-TERM-DT-DD   PIC 9(02).                06500012
065100         05  P-NEW-WAIVER-CODE          PIC X(01).                06510012
065200             88  P-NEW-WAIVER-STATE       VALUE 'Y'.              06520012
065300         05  P-NEW-INTER-NO             PIC 9(05).                06530012
065400         05  P-NEW-PROVIDER-TYPE        PIC X(02).                06540012
065500         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).                06550012
065600         05  P-NEW-CURRENT-DIV   REDEFINES                        06560012
065700                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).         06570012
065800         05  P-NEW-MSA-DATA.                                      06580012
065900             10  P-NEW-CHG-CODE-INDEX       PIC X.                06590012
066000             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT. 06600012
066100             10  P-NEW-GEO-LOC-MSA9   REDEFINES                   06610012
066200                             P-NEW-GEO-LOC-MSAX  PIC 9(04).       06620012
066300             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT. 06630012
066400             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT. 06640012
066500             10  P-NEW-STAND-AMT-LOC-MSA9                         06650012
066600                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.               06660012
066700                 15  P-NEW-RURAL-1ST.                             06670012
066800                     20  P-NEW-STAND-RURAL  PIC XX.               06680012
066900                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.    06690012
067000                 15  P-NEW-RURAL-2ND        PIC XX.               06700012
067100         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.                    06710012
067200         05  P-NEW-LUGAR                    PIC X.                06720012
067300         05  P-NEW-TEMP-RELIEF-IND          PIC X.                06730012
067400         05  P-NEW-FED-PPS-BLEND-IND        PIC X.                06740012
067500         05  P-NEW-STATE-CODE               PIC 9(02).            06750012
067600         05  P-NEW-STATE-CODE-X REDEFINES                         06760012
067700               P-NEW-STATE-CODE             PIC X(02).            06770012
067800         05  FILLER                         PIC X(03).            06780012
067900     02  PROV-NEWREC-HOLD2.                                       06790012
068000         05  P-NEW-VARIABLES.                                     06800012
068100             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).        06810012
068200             10  P-NEW-COLA              PIC  9(01)V9(03).        06820012
068300             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).        06830012
068400             10  P-NEW-BED-SIZE          PIC  9(05).              06840012
068500             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).        06850012
068600             10  P-NEW-CMI               PIC  9(01)V9(04).        06860012
068700             10  P-NEW-SSI-RATIO         PIC  V9(04).             06870012
068800             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).             06880012
068900             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).              06890012
069000             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).        06900012
069100             10  P-NEW-DSH-PERCENT       PIC  V9(04).             06910012
069200             10  P-NEW-FYE-DATE          PIC  X(08).              06920012
069300         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).             06930012
069400         05  P-NEW-HOSP-QUAL-IND           PIC X(01).             06940012
069500         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.  06950012
069600         05  P-NEW-GEO-LOC-CBSA9 REDEFINES                        06960012
069700                       P-NEW-GEO-LOC-CBSAX PIC 9(05).             06970012
069800         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES                     06980012
069900                       P-NEW-GEO-LOC-CBSA9.                       06990012
070000             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.                 07000012
070100             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.                 07010012
070200             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.                 07020012
070300             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.                 07030012
070400             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.                 07040012
070500         05  FILLER                        PIC X(10).             07050012
070600         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).       07060012
070700     02  PROV-NEWREC-HOLD3.                                       07070012
070800         05  P-NEW-PASS-AMT-DATA.                                 07080012
070900             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.          07090012
071000             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.          07100012
071100             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.          07110012
071200             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.          07120012
071300         05  P-NEW-CAPI-DATA.                                     07130012
071400             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.                 07140012
071500             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.          07150012
071600             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.          07160012
071700             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.        07170012
071800             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.             07180012
071900             15  P-NEW-CAPI-NEW-HOSP       PIC X.                 07190012
072000             15  P-NEW-CAPI-IME            PIC 9V9999.            07200012
072100             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.          07210012
072200             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.             07220012
072300         05  FILLER                        PIC X(18).             07230012
072400                                                                  07240012
072500                                                                  07250012
072600******************************************************************07260012
072700*                THIS IS THE LTCH WAGE-INDEX                     *07270012
072800*          ASSOCIATED WITH THE BILL BEING PROCESSED              *07280012
072900*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *07290012
073000******************************************************************07300012
073100 01  WAGE-NEW-INDEX-RECORD.                                       07310012
073200     05  W-CBSA                        PIC X(5).                  07320012
073300     05  W-EFF-DATE                    PIC X(8).                  07330012
073400     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).          07340012
073500     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).          07350012
073600     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).          07360012
073700                                                                  07370012
073800                                                                  07380012
073900******************************************************************07390012
074000*                THIS IS THE IPPS WAGE-INDEX                     *07400012
074100*          ASSOCIATED WITH THE BILL BEING PROCESSED              *07410012
074200******************************************************************07420012
074300 01  WAGE-NEW-IPPS-INDEX-RECORD.                                  07430012
074400     05  W-CBSA-IPPS.                                             07440012
074500         10 CBSA-IPPS-123              PIC X(3).                  07450012
074600         10 CBSA-IPPS-45               PIC X(2).                  07460012
074700     05  W-CBSA-IPPS-SIZE              PIC X.                     07470012
074800         88  LARGE-URBAN       VALUE 'L'.                         07480012
074900         88  OTHER-URBAN       VALUE 'O'.                         07490012
075000         88  ALL-RURAL         VALUE 'R'.                         07500012
075100     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).                  07510012
075200     05  FILLER                        PIC X.                     07520012
075300     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).          07530012
075400     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).          07540012
075500                                                                  07550012
075600                                                                  07560012
075700                                                                  07570012
075800 PROCEDURE DIVISION  USING BILL-NEW-DATA                          07580012
075900                           PPS-DATA-ALL                           07590012
076000                           PPS-CBSA                               07600012
076100                           PPS-PAYMENT-DATA                       07610012
076200                           PRICER-OPT-VERS-SW                     07620012
076300                           PROV-NEW-HOLD                          07630012
076400                           WAGE-NEW-INDEX-RECORD                  07640012
076500                           WAGE-NEW-IPPS-INDEX-RECORD.            07650012
076600                                                                  07660012
076700                                                                  07670012
076800***************************************************************   07680012
076900*                                                             *   07690012
077000*    PROCESSING:                                              *   07700012
077100*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *   07710012
077200*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *   07720012
077300*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *   07730012
077400*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *   07740012
077500*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *   07750012
077600*           GOBACK.                                           *   07760012
077700*        D. ASSEMBLE PRICING COMPONENTS.                      *   07770012
077800*        E. CALCULATE THE PRICE.                              *   07780012
077900*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *   07790012
078000*                                                             *   07800012
078100***************************************************************   07810012
078200                                                                  07820012
078300                                                                  07830012
078400***************************************************************   07840012
078500 0000-MAINLINE-CONTROL.                                           07850012
078600***************************************************************   07860012
078700                                                                  07870012
078800     PERFORM 0100-INITIAL-ROUTINE                                 07880012
078900        THRU 0100-EXIT.                                           07890012
079000                                                                  07900012
079100     PERFORM 1000-EDIT-INPUT-DATA                                 07910012
079200        THRU 1000-EXIT.                                           07920012
079300                                                                  07930012
079400     IF PPS-RTC = '00'                                            07940012
079500        PERFORM 1700-EDIT-DRG-CODE                                07950012
079600           THRU 1700-EXIT.                                        07960012
079700                                                                  07970012
079800     IF PPS-RTC = '00'                                            07980012
079900        PERFORM 1800-EDIT-IPPS-DRG-CODE                           07990012
080000           THRU 1800-EXIT.                                        08000012
080100                                                                  08010012
080200     IF PPS-RTC = '00'                                            08020012
080300        PERFORM 2000-ASSEMBLE-PPS-VARIABLES                       08030012
080400           THRU 2000-EXIT.                                        08040012
080500                                                                  08050012
080600     IF PPS-RTC = '00'                                            08060012
080700        PERFORM 3000-CALC-PAYMENT                                 08070012
080800           THRU 3000-EXIT.                                        08080012
080900                                                                  08090012
081000     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE                 08100012
081100        PERFORM 6000-CALC-HIGH-COST-OUTLIER                       08110012
081200           THRU 6000-EXIT.                                        08120012
081300                                                                  08130012
081400     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE                 08140012
081500        PERFORM 7000-SET-FINAL-RETURN-CODES                       08150012
081600           THRU 7000-EXIT.                                        08160012
081700                                                                  08170012
081800     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE                 08180012
081900        PERFORM 8000-CALC-FINAL-PMT                               08190012
082000           THRU 8000-EXIT.                                        08200012
082100                                                                  08210012
082200     PERFORM 9000-MOVE-RESULTS                                    08220012
082300        THRU 9000-EXIT.                                           08230012
082400                                                                  08240012
082500     GOBACK.                                                      08250012
082600                                                                  08260012
082700                                                                  08270012
082800***************************************************************   08280012
082900 0100-INITIAL-ROUTINE.                                            08290012
083000***************************************************************   08300012
083100                                                                  08310012
083200     MOVE '00' TO PPS-RTC.                                        08320012
083300     INITIALIZE PPS-DATA.                                         08330012
083400     INITIALIZE PPS-OTHER-DATA.                                   08340012
083500     INITIALIZE PPS-CBSA.                                         08350012
083600     INITIALIZE PPS-PAYMENT-DATA.                                 08360012
083700     INITIALIZE HOLD-PPS-COMPONENTS.                              08370012
083800     INITIALIZE PROGRAM-FLAGS.                                    08380012
083900     INITIALIZE WK-HLDDRG-DATA                                    08390012
084000                WK-HLDDRG-DATA2.                                  08400012
084100                                                                  08410012
084200     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.                        08420012
084300                                                                  08430012
084400                                                                  08440012
084500*** ---------------------------------------------------- ***      08450012
084600*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***      08460012
084700*** ---------------------------------------------------- ***      08470012
084800     MOVE .660 TO PPS-NAT-LABOR-PCT.                              08480012
084900     MOVE .340 TO PPS-NAT-NONLABOR-PCT.                           08490012
085000                                                                  08500012
085100*** --------------------------------------------------------      08510012
085200*** NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL            08520012
085300*** REPORTING OF QUALITY DATA.                                    08530012
085400*** - FULL UPDATE (QUALITY INDICATOR ON PSF = 1)                  08540012
085500*** - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK)     08550012
085600*** --------------------------------------------------------      08560012
085700     IF P-NEW-HOSP-QUAL-IND = '1'                                 08570012
085800        MOVE 41558.68 TO PPS-STD-FED-RATE                         08580012
085900     ELSE                                                         08590012
086000        MOVE 40738.57 TO PPS-STD-FED-RATE.                        08600012
086100     MOVE 27121.00 TO H-FIXED-LOSS-AMT-STD.                       08610012
086200     MOVE 25743.00 TO H-FIXED-LOSS-AMT-SNT.                       08620012
086300     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.                         08630012
086400                                                                  08640012
086500*** ---------------------------------------------------- ***      08650012
086600*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***      08660012
086700*** ---------------------------------------------------- ***      08670012
086800     MOVE 459.41 TO H-IPPS-CAPI-STD-FED-RATE.                     08680012
086900                                                                  08690012
087000     MOVE W-IPPS-WAGE-INDEX TO H-IPPS-WAGE-INDEX.                 08700012
087100                                                                  08710012
087200     IF H-IPPS-WAGE-INDEX > 1                                     08720012
087300           MOVE 3856.27 TO H-IPPS-NAT-LABOR-SHR                   08730012
087400           MOVE 1789.81 TO H-IPPS-NAT-NONLABOR-SHR                08740012
087500     ELSE                                                         08750012
087600           MOVE 3500.57 TO H-IPPS-NAT-LABOR-SHR                   08760012
087700           MOVE 2145.51 TO H-IPPS-NAT-NONLABOR-SHR                08770012
087800     END-IF.                                                      08780012
087900                                                                  08790012
088000*** ---------------------------------------------------- ***      08800012
088100*** OPERATING DSH REDUCTION FACTOR                       ***      08810012
088200*** -----------------------------------------------------***      08820012
088300     MOVE 0.7563 TO H-OPER-DSH-REDUCTION-FACTOR.                  08830012
088400                                                                  08840012
088500 0100-EXIT.                                                       08850012
088600      EXIT.                                                       08860012
088700                                                                  08870012
088800                                                                  08880012
088900***************************************************************   08890012
089000*    INPUT DATA EDITS - IF ANY FAIL SET PPS-RTC               *   08900012
089100*    AND DO NOT ATTEMPT TO PRICE.                             *   08910012
089200***************************************************************   08920012
089300 1000-EDIT-INPUT-DATA.                                            08930012
089400***************************************************************   08940012
089500                                                                  08950012
089600*** -----------------------------------------------------------   08960012
089700*** EDIT BILL (BILL-NEW-DATA) INPUT & SET ERROR CODE IF FAIL      08970012
089800*** -----------------------------------------------------------   08980012
089900     IF (B-LOS NUMERIC) AND (B-LOS > 0)                           08990012
090000        MOVE B-LOS TO H-LOS                                       09000012
090100     ELSE                                                         09010012
090200        MOVE '56' TO PPS-RTC.                                     09020012
090300                                                                  09030012
090400     IF PPS-RTC = '00'                                            09040012
090500        IF P-NEW-COLA NOT NUMERIC                                 09050012
090600           MOVE '50' TO PPS-RTC.                                  09060012
090700                                                                  09070012
090800     IF PPS-RTC = '00'                                            09080012
090900        IF P-NEW-WAIVER-STATE                                     09090012
091000           MOVE '53' TO PPS-RTC.                                  09100012
091100                                                                  09110012
091200     IF PPS-RTC = '00'                                            09120012
091300        IF B-DRG-CODE NOT NUMERIC                                 09130012
091400           MOVE '54' TO PPS-RTC.                                  09140012
091500                                                                  09150012
091600     IF PPS-RTC = '00'                                            09160012
091700        IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR                09170012
091800           (B-DISCHARGE-DATE < W-EFF-DATE))                       09180012
091900            MOVE '55' TO PPS-RTC.                                 09190012
092000                                                                  09200012
092100     IF PPS-RTC = '00'                                            09210012
092200        IF P-NEW-TERMINATION-DATE > 00000000                      09220012
092300           IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE          09230012
092400              MOVE '51' TO PPS-RTC.                               09240012
092500                                                                  09250012
092600     IF PPS-RTC = '00'                                            09260012
092700        IF B-COV-CHARGES NOT NUMERIC                              09270012
092800           MOVE '58' TO PPS-RTC.                                  09280012
092900                                                                  09290012
093000     IF PPS-RTC = '00'                                            09300012
093100        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60              09310012
093200           MOVE '61' TO PPS-RTC.                                  09320012
093300                                                                  09330012
093400     IF PPS-RTC = '00'                                            09340012
093500        IF (B-COV-DAYS NOT NUMERIC) OR                            09350012
093600           (B-COV-DAYS = 0 AND H-LOS > 0)                         09360012
093700           MOVE '62' TO PPS-RTC.                                  09370012
093800                                                                  09380012
093900     IF PPS-RTC = '00'                                            09390012
094000        IF B-LTR-DAYS > B-COV-DAYS                                09400012
094100           MOVE '62' TO PPS-RTC.                                  09410012
094200                                                                  09420012
094300     IF PPS-RTC = '00'                                            09430012
094400        IF (B-REVIEW-CODE < 00 OR B-REVIEW-CODE > 08) OR          09440012
094500           (B-REVIEW-CODE NOT NUMERIC)                            09450012
094600           MOVE '72' TO PPS-RTC.                                  09460012
094700                                                                  09470012
094800                                                                  09480012
094900*** -----------------------------------------------------------   09490012
095000*** CALCULATE DAY RELATED VARIABLE VALUES                         09500012
095100*** -----------------------------------------------------------   09510012
095200     IF PPS-RTC = '00'                                            09520012
095300        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS              09530012
095400        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.           09540012
095500                                                                  09550012
095600     IF PPS-RTC = '00'                                            09560012
095700        PERFORM 1200-DAYS-USED                                    09570012
095800           THRU 1200-DAYS-USED-EXIT.                              09580012
095900                                                                  09590012
096000                                                                  09600012
096100*** -----------------------------------------------------------   09610012
096200*** EDIT PSF FIELDS USED BY ALL CLAIMS & SET ERROR CODE IF FAIL   09620012
096300*** -----------------------------------------------------------   09630012
096400                                                                  09640012
096500*-------------------------------------------------------------*   09650012
096600* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *   09660012
096700* (ALWAYS FED-FY-BEGIN-03)                                    *   09670012
096800*-------------------------------------------------------------*   09680012
096900     IF PPS-RTC = '00'                                            09690012
097000        IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03                  09700012
097100           MOVE '74' TO PPS-RTC.                                  09710012
097200                                                                  09720012
097300*-------------------------------------------------------------*   09730012
097400* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *   09740012
097500*-------------------------------------------------------------*   09750012
097600     IF PPS-RTC = '00'                                            09760012
097700        IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC                    09770012
097800           MOVE '65' TO PPS-RTC.                                  09780012
097900                                                                  09790012
098000                                                                  09800012
098100*** -----------------------------------------------------------   09810012
098200*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION    09820012
098300*** -----------------------------------------------------------   09830012
098400     IF PPS-RTC = '00'                                            09840012
098500        IF P-NEW-CAPI-IME NUMERIC                                 09850012
098600           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO                09860012
098700        ELSE                                                      09870012
098800           MOVE ZEROS TO H-CAPI-IME-RATIO                         09880012
098900        END-IF                                                    09890012
099000     END-IF.                                                      09900012
099100                                                                  09910012
099200     IF PPS-RTC = '00'                                            09920012
099300        IF P-NEW-INTERN-RATIO NUMERIC                             09930012
099400           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO              09940012
099500        ELSE                                                      09950012
099600           MOVE ZEROS TO H-INTERN-RATIO                           09960012
099700        END-IF                                                    09970012
099800     END-IF.                                                      09980012
099900                                                                  09990012
100000     IF PPS-RTC = '00'                                            10000012
100100        IF P-NEW-BED-SIZE NUMERIC                                 10010012
100200           MOVE P-NEW-BED-SIZE TO H-BED-SIZE                      10020012
100300        ELSE                                                      10030012
100400           MOVE ZEROS TO H-BED-SIZE                               10040012
100500        END-IF                                                    10050012
100600     END-IF.                                                      10060012
100700                                                                  10070012
100800     IF PPS-RTC = '00'                                            10080012
100900        IF P-NEW-SSI-RATIO NUMERIC                                10090012
101000           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO                    10100012
101100        ELSE                                                      10110012
101200           MOVE ZEROS TO H-SSI-RATIO                              10120012
101300        END-IF                                                    10130012
101400     END-IF.                                                      10140012
101500                                                                  10150012
101600     IF PPS-RTC = '00'                                            10160012
101700        IF P-NEW-MEDICAID-RATIO NUMERIC                           10170012
101800           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO          10180012
101900        ELSE                                                      10190012
102000           MOVE ZEROS TO H-MEDICAID-RATIO                         10200012
102100        END-IF                                                    10210012
102200     END-IF.                                                      10220012
102300                                                                  10230012
102400                                                                  10240012
102500 1000-EXIT.                                                       10250012
102600      EXIT.                                                       10260012
102700                                                                  10270012
102800                                                                  10280012
102900***************************************************************   10290012
103000 1200-DAYS-USED.                                                  10300012
103100***************************************************************   10310012
103200                                                                  10320012
103300     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)                     10330012
103400        IF B-LTR-DAYS > H-LOS                                     10340012
103500           MOVE H-LOS TO PPS-LTR-DAYS-USED                        10350012
103600        ELSE                                                      10360012
103700           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED                   10370012
103800     ELSE                                                         10380012
103900        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)                  10390012
104000           IF H-REG-DAYS > H-LOS                                  10400012
104100              MOVE H-LOS TO PPS-REG-DAYS-USED                     10410012
104200           ELSE                                                   10420012
104300              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED                10430012
104400        ELSE                                                      10440012
104500           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)               10450012
104600              IF H-REG-DAYS > H-LOS                               10460012
104700                 MOVE H-LOS TO PPS-REG-DAYS-USED                  10470012
104800                 MOVE 0 TO PPS-LTR-DAYS-USED                      10480012
104900              ELSE                                                10490012
105000                 IF H-TOTAL-DAYS > H-LOS                          10500012
105100                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED          10510012
105200                    COMPUTE PPS-LTR-DAYS-USED =                   10520012
105300                            H-LOS - H-REG-DAYS                    10530012
105400                 ELSE                                             10540012
105500                    IF H-TOTAL-DAYS <= H-LOS                      10550012
105600                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED       10560012
105700                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED       10570012
105800                    ELSE                                          10580012
105900                       NEXT SENTENCE                              10590012
106000           ELSE                                                   10600012
106100              NEXT SENTENCE.                                      10610012
106200                                                                  10620012
106300 1200-DAYS-USED-EXIT.                                             10630012
106400      EXIT.                                                       10640012
106500                                                                  10650012
106600                                                                  10660012
106700***************************************************************   10670012
106800*    FINDS THE LTCH DRG CODE IN THE TABLE                     *   10680012
106900***************************************************************   10690012
107000 1700-EDIT-DRG-CODE.                                              10700012
107100***************************************************************   10710012
107200                                                                  10720012
107300     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.                        10730012
107400     IF PPS-RTC = '00'                                            10740012
107500        SEARCH ALL WWM-ENTRY                                      10750012
107600           AT END                                                 10760012
107700             MOVE '54' TO PPS-RTC                                 10770012
107800        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE               10780012
107900             PERFORM 1750-FIND-VALUE                              10790012
108000                THRU 1750-EXIT                                    10800012
108100        END-SEARCH.                                               10810012
108200                                                                  10820012
108300 1700-EXIT.                                                       10830012
108400      EXIT.                                                       10840012
108500                                                                  10850012
108600                                                                  10860012
108700***************************************************************   10870012
108800*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *   10880012
108900***************************************************************   10890012
109000 1750-FIND-VALUE.                                                 10900012
109100***************************************************************   10910012
109200                                                                  10920012
109300      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.           10930012
109400      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.                10940012
109500*     MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.               10950012
109600                                                                  10960012
109700 1750-EXIT.                                                       10970012
109800      EXIT.                                                       10980012
109900                                                                  10990012
110000                                                                  11000012
110100***************************************************************   11010012
110200*    FINDS THE IPPS DRG CODE IN THE TABLE                     *   11020012
110300***************************************************************   11030012
110400 1800-EDIT-IPPS-DRG-CODE.                                         11040012
110500***************************************************************   11050012
110600                                                                  11060012
110700**-------------------------------------------------------**       11070012
110800** THIS LOGIC WAS COPIED FROM THE IPPS PRICER (PPCAL140) **       11080012
110900** ENSURE IT STAYS CONSISTENT BECAUSE IT REFERENCES THE  **       11090012
111000** DRG TABLE USED BY THE IPPS PRICER.                    **       11100012
111100**-------------------------------------------------------**       11110012
111200                                                                  11120012
111300     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE                  11130012
111400     SET DRG-IDX TO 1                                             11140012
111500     SEARCH DRG-TAB VARYING DRG-IDX                               11150012
111600         AT END                                                   11160012
111700           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC            11170012
111800           MOVE 'I' TO  HLDDRG-VALID                              11180012
111900           MOVE '54' TO PPS-RTC                                   11190012
112000           GO TO 1800-EXIT                                        11200012
112100       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE                     11210012
112200         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.               11220012
112300                                                                  11230012
112400                                                                  11240012
112500     MOVE  HLDDRG-DATA         TO WK-HLDDRG-DATA2.                11250012
112600     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.                   11260012
112700     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2                  11270012
112800                                  H-IPPS-DRG-WGT.                 11280012
112900     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2                  11290012
113000                                  H-IPPS-DRG-ALOS.                11300012
113100     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.                    11310012
113200     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2              11320012
113300                                  H-IPPS-ARITH-ALOS.              11330012
113400     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.                    11340012
113500     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.                  11350012
113600     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.                   11360012
113700     MOVE  'V'                 TO HLDDRG-VALID.                   11370012
113800     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.             11380012
113900                                                                  11390012
114000 1800-EXIT.                                                       11400012
114100      EXIT.                                                       11410012
114200                                                                  11420012
114300                                                                  11430012
114400***************************************************************   11440012
114500***  GET THE PROVIDER SPECIFIC VARIABLES AND LTCH WAGE INDEX  *   11450012
114600*                                                             *   11460012
114700*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *   11470012
114800*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *   11480012
114900*    OF THAT VARIABLE.                                        *   11490012
115000*                                                             *   11500012
115100***************************************************************   11510012
115200 2000-ASSEMBLE-PPS-VARIABLES.                                     11520012
115300***************************************************************   11530012
115400                                                                  11540012
115500                                                                  11550012
115600*-------------------------------------------------------------*   11560012
115700* ASSIGN FULL (5/5) LTCH WAGE INDEX TO ALL CLAIMS DISCHARGED  *   11570012
115800* ON AND AFTER 7/1/2008 (THIRD COLUMN WAGE INDEX IN LTWIX***) *   11580012
115900*-------------------------------------------------------------*   11590012
116000     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0               11600012
116100        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX                      11610012
116200     ELSE                                                         11620012
116300        MOVE '52' TO PPS-RTC                                      11630012
116400        GO TO 2000-EXIT                                           11640012
116500     END-IF.                                                      11650012
116600                                                                  11660012
116700                                                                  11670012
116800*-------------------------------------------------------------*   11680012
116900* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *   11690012
117000*-------------------------------------------------------------*   11700012
117100     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.              11710012
117200                                                                  11720012
117300*-------------------------------------------------------------*   11730012
117400* OLD POLICY CLAIMS MUST HAVE A BLEND YEAR INDICATOR OF 5     *   11740012
117500*-------------------------------------------------------------*   11750012
117600     IF B-REVIEW-CODE = 00 AND PPS-BLEND-YEAR NOT = 5             11760012
117700        MOVE 5 TO PPS-BLEND-YEAR                                  11770012
117800     END-IF.                                                      11780012
117900                                                                  11790012
118000*-------------------------------------------------------------*   11800012
118100* NEW POLICY CLAIMS MUST HAVE A BLEND YR. IND. OF 6, 7, OR 8  *   11810012
118200*-------------------------------------------------------------*   11820012
118300     IF (B-REVIEW-CODE >= 01 AND B-REVIEW-CODE <= 08) AND         11830012
118400        (PPS-BLEND-YEAR < 6 OR PPS-BLEND-YEAR > 8)                11840012
118500        MOVE '72' TO PPS-RTC                                      11850012
118600        GO TO 2000-EXIT                                           11860012
118700     END-IF.                                                      11870012
118800                                                                  11880012
118900*-------------------------------------------------------------*   11890012
119000* SET DEFAULT BLEND VARIABLE VALUES                           *   11900012
119100* - H-BLEND-STD = % STANDARD PMT CONTRIBUTES TO FINAL PMT     *   11910012
119200* - H-BLEND-SNT = % SITE NEUTRAL PMT CONTRIBUTES TO FINAL PMT *   11920012
119300*-------------------------------------------------------------*   11930012
119400     MOVE 0 TO H-BLEND-SNT.                                       11940012
119500     MOVE 1 TO H-BLEND-STD.                                       11950012
119600     MOVE 0 TO H-BLEND-RTC.                                       11960012
119700                                                                  11970012
119800                                                                  11980012
119900*-------------------------------------------------------------*   11990012
120000* FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII)          *   12000012
120100*-------------------------------------------------------------*   12010012
120200     IF (P-NEW-STATE = 02 OR 12)                                  12020012
120300        MOVE P-NEW-COLA TO PPS-COLA                               12030012
120400     ELSE                                                         12040012
120500        MOVE 1.000 TO PPS-COLA                                    12050012
120600     END-IF.                                                      12060012
120700                                                                  12070012
120800                                                                  12080012
120900 2000-EXIT.                                                       12090012
121000      EXIT.                                                       12100012
121100                                                                  12110012
121200                                                                  12120012
121300***************************************************************   12130012
121400*    IF THE BILL & PSF DATA HAS PASSED ALL EDITS (RTC=00)     *   12140012
121500*        CALCULATE THE APPLICABLE CLAIM PAYMENT:              *   12150012
121600*           - STANDARD PAYMENT                                *   12160012
121700*           - SHORT STAY OUTLIER PAYMENT                      *   12170012
121800*           - SITE NEUTRAL PAYMENT                            *   12180012
121900*           - STANDARD/SITE NEUTRAL BLENDED PAYMENT           *   12190012
122000***************************************************************   12200012
122100 3000-CALC-PAYMENT.                                               12210012
122200***************************************************************   12220012
122300                                                                  12230012
122400                                                                  12240012
122500*-------------------------------------------------------------*   12250012
122600* CALCULATE CLAIM COST FOR ALL CLAIMS                         *   12260012
122700*-------------------------------------------------------------*   12270012
122800     COMPUTE PPS-FAC-COSTS ROUNDED =                              12280012
122900         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.                 12290012
123000                                                                  12300012
123100                                                                  12310012
123200*-------------------------------------------------------------*   12320012
123300* DETERMINE WHICH PAYMENT METHOD TO USE. EITHER:              *   12330012
123400* - STANDARD PAYMENT UNDER THE OLD POLICY,                    *   12340012
123500* - STANDARD PAYMENT UNDER THE NEW POLICY,                    *   12350012
123600* - 100% SITE NEUTRAL PAYMENT, OR                             *   12360012
123700* - 50/50 BLEND OF SITE NEUTRAL & STANDARD PAYMENT.           *   12370012
123800*-------------------------------------------------------------*   12380012
123900     PERFORM 3100-DETERMINE-PAYMENT-TYPE                          12390012
124000        THRU 3100-EXIT.                                           12400012
124100                                                                  12410012
124200     IF PPS-RTC NOT = '00'                                        12420012
124300        GO TO 3000-EXIT                                           12430012
124400     END-IF.                                                      12440012
124500                                                                  12450012
124600                                                                  12460012
124700*-------------------------------------------------------------*   12470012
124800* CALCULATE CLAIM PAYMENT BASED ON PAYMENT METHOD             *   12480012
124900*-------------------------------------------------------------*   12490012
125000     IF PMT-STANDARD-OLD                                          12500012
125100        PERFORM 3200-CALC-STANDARD-PMT                            12510012
125200           THRU 3200-EXIT                                         12520012
125300     END-IF.                                                      12530012
125400                                                                  12540012
125500     IF PMT-STANDARD-NEW                                          12550012
125600        PERFORM 3200-CALC-STANDARD-PMT                            12560012
125700           THRU 3200-EXIT                                         12570012
125800     END-IF.                                                      12580012
125900                                                                  12590012
126000     IF PMT-SITE-NEUTRAL                                          12600012
126100        PERFORM 3300-CALC-SITE-NEUTRAL-PMT                        12610012
126200           THRU 3300-EXIT                                         12620012
126300     END-IF.                                                      12630012
126400                                                                  12640012
126500     IF PMT-BLEND                                                 12650012
126600        PERFORM 3200-CALC-STANDARD-PMT                            12660012
126700           THRU 3200-EXIT                                         12670012
126800        PERFORM 3300-CALC-SITE-NEUTRAL-PMT                        12680012
126900           THRU 3300-EXIT                                         12690012
127000     END-IF.                                                      12700012
127100                                                                  12710012
127200 3000-EXIT.                                                       12720012
127300      EXIT.                                                       12730012
127400                                                                  12740012
127500                                                                  12750012
127600***************************************************************   12760012
127700*  DETERMINE WHETHER A CLAIM'S PAYMENT SHOULD BE:             *   12770012
127800*  - STANDARD - OLD POLICY                                    *   12780012
127900*  - STANDARD - NEW POLICY                                    *   12790012
128000*  - 100% SITE NEUTRAL - NEW POLICY                           *   12800012
128100*  - 50/50 BLEND OF SITE NEUTRAL & STANDARD - NEW POLICY      *   12810012
128200***************************************************************   12820012
128300 3100-DETERMINE-PAYMENT-TYPE.                                     12830012
128400***************************************************************   12840012
128500                                                                  12850012
128600*-------------------------------------------------------------*   12860012
128700* STANDARD PAYMENT (OLD POLICY)                                   12870012
128800*-------------------------------------------------------------*   12880012
128900     IF B-REVIEW-CODE = 00                                        12890012
129000*    IF B-REVIEW-CODE = 00 OR                                     12900012
129100*       SUBCLAUSEII-PROV                                          12910012
129200        SET PMT-STANDARD-OLD TO TRUE                              12920012
129300        GO TO 3100-EXIT                                           12930012
129400     END-IF.                                                      12940012
129500                                                                  12950012
129600*-------------------------------------------------------------*   12960012
129700* STANDARD PAYMENT (NEW POLICY)                                   12970012
129800*-------------------------------------------------------------*   12980012
129900     IF (B-REVIEW-CODE = 01 AND NOT PSYCH-REHAB-DRG) OR           12990012
130000        B-REVIEW-CODE = 04 OR                                     13000012
130100        B-REVIEW-CODE = 05                                        13010012
130200        SET PMT-STANDARD-NEW TO TRUE                              13020012
130300        GO TO 3100-EXIT                                           13030012
130400     END-IF.                                                      13040012
130500                                                                  13050012
130600*-------------------------------------------------------------*   13060012
130700* SITE NEUTRAL PAYMENT (NEW POLICY)                               13070012
130800*-------------------------------------------------------------*   13080012
130900     IF  (B-REVIEW-CODE = 01 AND PSYCH-REHAB-DRG) OR              13090012
131000          B-REVIEW-CODE = 02 OR                                   13100012
131100          B-REVIEW-CODE = 03 OR                                   13110012
131200          B-REVIEW-CODE = 06 OR                                   13120012
131300          B-REVIEW-CODE = 07 OR                                   13130012
131400          B-REVIEW-CODE = 08                                      13140012
131500                                                                  13150012
131600*-------------------------------------------------------------*   13160012
131700*     SET BUDGET NEUTRALITY RATE FOR SITE NEUTRAL CLAIMS          13170012
131800*-------------------------------------------------------------*   13180012
131900        MOVE 0.949 TO H-BDGT-NEUT-FACTOR                          13190012
132000                                                                  13200012
132100*-------------------------------------------------------------*   13210012
132200*     SET SITE-NEUTRAL-IPPS-ADJ FOR SITE-NEUTRAL CLAIMS           13220012
132300*-------------------------------------------------------------*   13230012
132400        MOVE 0.954 TO H-SITE-NEUTRAL-IPPS-ADJ                     13240012
132500                                                                  13250012
132600*-------------------------------------------------------------*   13260012
132700*     100% SITE NEUTRAL PAYMENT                                   13270012
132800*-------------------------------------------------------------*   13280012
132900        IF PPS-BLEND-YEAR = 8                                     13290012
133000           SET PMT-SITE-NEUTRAL TO TRUE                           13300012
133100                                                                  13310012
133200*-------------------------------------------------------------*   13320012
133300*     50% SITE NEUTRAL + 50% STANDARD BLENDED PAYMENT             13330012
133400*-------------------------------------------------------------*   13340012
133500        ELSE                                                      13350012
133600           IF PPS-BLEND-YEAR = 6 OR                               13360012
133700              PPS-BLEND-YEAR = 7                                  13370012
133800              SET PMT-BLEND TO TRUE                               13380012
133900                                                                  13390012
134000*-------------------------------------------------------------*   13400012
134100*           SET BLEND PERCENTS FOR BLENDED PAYMENT            *   13410012
134200*-------------------------------------------------------------*   13420012
134300              MOVE .5 TO H-BLEND-STD                              13430012
134400              MOVE .5 TO H-BLEND-SNT                              13440012
134500           END-IF                                                 13450012
134600        END-IF                                                    13460012
134700     END-IF.                                                      13470012
134800                                                                  13480012
134900*-------------------------------------------------------------*   13490012
135000* CLAIM MEETS NONE OF THE ABOVE CRITERIA - SET RETURN CODE        13500012
135100*-------------------------------------------------------------*   13510012
135200     IF WS-PRIMARY-PMT-TYPE = ' '                                 13520012
135300        MOVE '72' TO PPS-RTC                                      13530012
135400     END-IF.                                                      13540012
135500                                                                  13550012
135600                                                                  13560012
135700 3100-EXIT.                                                       13570012
135800      EXIT.                                                       13580012
135900                                                                  13590012
136000                                                                  13600012
136100***************************************************************   13610012
136200*     CALCULATE THE STANDARD PAYMENT AMOUNT.                  *   13620012
136300*     CALCULATE THE SHORT-STAY OUTLIER AMOUNT IF APPLICABLE.  *   13630012
136400***************************************************************   13640012
136500 3200-CALC-STANDARD-PMT.                                          13650012
136600***************************************************************   13660012
136700                                                                  13670012
136800*-------------------------------------------------------------*   13680012
136900* CALCULATE FULL STANDARD DRG ADJUSTED PAYMENT                *   13690012
137000*-------------------------------------------------------------*   13700012
137100     COMPUTE H-LABOR-PORTION ROUNDED =                            13710012
137200         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)                   13720012
137300          * PPS-WAGE-INDEX.                                       13730012
137400                                                                  13740012
137500     COMPUTE H-NONLABOR-PORTION ROUNDED =                         13750012
137600         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)                13760012
137700          * PPS-COLA.                                             13770012
137800                                                                  13780012
137900     COMPUTE PPS-FED-PAY-AMT ROUNDED =                            13790012
138000         (H-LABOR-PORTION + H-NONLABOR-PORTION).                  13800012
138100                                                                  13810012
138200     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =                        13820012
138300         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).                    13830012
138400                                                                  13840012
138500* FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY        13850012
138600     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.         13860012
138700                                                                  13870012
138800                                                                  13880012
138900*-------------------------------------------------------------*   13890012
139000* DETERMINE WHETHER THE CLAIM IS A SHORT STAY OUTLIER;        *   13900012
139100* APPLY SHORT STAY OUTLIER POLICY IF IT IS                    *   13910012
139200*-------------------------------------------------------------*   13920012
139300     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.              13930012
139400                                                                  13940012
139500     IF H-LOS <= H-SSOT                                           13950012
139600        PERFORM 3400-SHORT-STAY                                   13960012
139700           THRU 3400-SHORT-STAY-EXIT                              13970012
139800                                                                  13980012
139900        IF PMT-STANDARD-NEW OR PMT-BLEND                          13990012
140000           SET PMT-STANDARD-SSO TO TRUE                           14000012
140100           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-SSO-PMT       14010012
140200        END-IF                                                    14020012
140300                                                                  14030012
140400*-------------------------------------------------------------*   14040012
140500* FOR REGULAR STAY CLAIMS, POPULATE THE APPROPRIATE PAYMENT   *   14050012
140600* FIELD FOR NEW POLICY CLAIMS                                 *   14060012
140700*-------------------------------------------------------------*   14070012
140800     ELSE                                                         14080012
140900        IF PMT-STANDARD-NEW OR PMT-BLEND                          14090012
141000           SET PMT-STANDARD-FULL TO TRUE                          14100012
141100           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-FULL-PMT      14110012
141200        END-IF                                                    14120012
141300     END-IF.                                                      14130012
141400                                                                  14140012
141500 3200-EXIT.                                                       14150012
141600      EXIT.                                                       14160012
141700                                                                  14170012
141800                                                                  14180012
141900***************************************************************   14190012
142000*     CALCULATE THE SITE NEUTRAL PAYMENT AMOUNT               *   14200012
142100***************************************************************   14210012
142200 3300-CALC-SITE-NEUTRAL-PMT.                                      14220012
142300***************************************************************   14230012
142400* BEGINNING LTCAL183 - NEW METHOD                                 14240012
142500                                                                  14250012
142600*-------------------------------------------------------------*   14260012
142700* CALCULATE IPPS COMPARABLE PER DIEM AMT                      *   14270012
142800*-------------------------------------------------------------*   14280012
142900     PERFORM 3650-SS-IPPS-COMP-PMT                                14290012
143000        THRU 3650-SS-IPPS-COMP-PMT-EXIT.                          14300012
143100                                                                  14310012
143200*-------------------------------------------------------------*   14320012
143300* CALCULATE SITE NEUTRAL IPPS COMP. PMT HIGH COST OUTLIER     *   14330012
143400* (HCO) FOR THE MINIMUM PAYMENT COMPARISON                    *   14340012
143500*-------------------------------------------------------------*   14350012
143600     SET PMT-SITE-NEUT-IPPS TO TRUE.                              14360012
143700     MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT.           14370012
143800     PERFORM 6000-CALC-HIGH-COST-OUTLIER                          14380012
143900        THRU 6000-EXIT.                                           14390012
144000     COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =                        14400012
144100             PPS-OUTLIER-PAY-AMT *                                14410012
144200             H-SITE-NEUTRAL-IPPS-ADJ.                             14420012
144300     MOVE PPS-OUTLIER-PAY-AMT TO H-OUTLIER-IPPS-COMPARABLE.       14430012
144400     INITIALIZE PPS-OUTLIER-PAY-AMT                               14440012
144500                WS-SECONDARY-PMT-TYPE-SNT                         14450012
144600                PPS-SITE-NEUTRAL-IPPS-PMT.                        14460012
144700                                                                  14470012
144800*-------------------------------------------------------------*   14480012
144900* CALCULATE THE SITE NEUTRAL PAYMENT USING THE FOLLOWING      *   14490012
145000* FORMULA FROM POLICY GROUP:                                  *   14500012
145100* MIN (ÝSN ADJ * (IPPS PER DIEM AMT + SN IPPS HCO)¨, COST)    *   14510012
145200*-------------------------------------------------------------*   14520012
145300                                                                  14530012
145400*-------------------------------------------------------------*   14540012
145500* CALCULATE SITE NEUTRAL COST PAYMENT FOR MIN PMT COMPARISON  *   14550012
145600*-------------------------------------------------------------*   14560012
145700     MOVE PPS-FAC-COSTS TO H-SN-COST-4COMPARISON.                 14570012
145800                                                                  14580012
145900*-------------------------------------------------------------*   14590012
146000* CALCULATE SITE NEUTRAL IPPS COMP PMT FOR MIN PMT COMPARISON *   14600012
146100*-------------------------------------------------------------*   14610012
146200     COMPUTE H-SN-IPPS-4COMPARISON ROUNDED =                      14620012
146300              H-SITE-NEUTRAL-IPPS-ADJ *                           14630012
146400              (H-IPPS-PER-DIEM +                                  14640012
146500               H-OUTLIER-IPPS-COMPARABLE).                        14650012
146600                                                                  14660012
146700*-------------------------------------------------------------*   14670012
146800* MINIMUM IS FINAL SITE NEUTRAL PMT BASED ON COST             *   14680012
146900*-------------------------------------------------------------*   14690012
147000     IF H-SN-COST-4COMPARISON < H-SN-IPPS-4COMPARISON             14700012
147100        SET PMT-SITE-NEUT-COST TO TRUE                            14710012
147200        MOVE PPS-FAC-COSTS TO PPS-SITE-NEUTRAL-COST-PMT           14720012
147300                                                                  14730012
147400*-------------------------------------------------------------*   14740012
147500* MINIMUM IS FINAL SITE-NEUTRAL PMT BASED ON IPPS COMPARABLE  *   14750012
147600*-------------------------------------------------------------*   14760012
147700     ELSE                                                         14770012
147800        SET PMT-SITE-NEUT-IPPS TO TRUE                            14780012
147900        MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT         14790012
148000     END-IF.                                                      14800012
148100                                                                  14810012
148200                                                                  14820012
148300 3300-EXIT.                                                       14830012
148400      EXIT.                                                       14840012
148500                                                                  14850012
148600                                                                  14860012
148700***************************************************************   14870012
148800*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *   14880012
148900*      OF THE AVG. LENGTH OF STAY THEN:                       *   14890012
149000*      - PAY THE SHORT-STAY BLENDED PAYMENT                   *   14900012
149100*      - SET RETURN CODE FOR OLD POLICY CLAIMS ONLY TO        *   14910012
149200*        INDICATE SHORT STAY PAYMENT                          *   14920012
149300***************************************************************   14930012
149400                                                                  14940012
149500 3400-SHORT-STAY.                                                 14950012
149600                                                                  14960012
149700        COMPUTE H-SS-PAY-AMT ROUNDED =                            14970012
149800         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2      14980012
149900                                                                  14990012
150000***************************************************************   15000012
150100*   CALCULATE BLENDED PAYMENT                                 *   15010012
150200***************************************************************   15020012
150300                                                                  15030012
150400        PERFORM 3600-SS-BLENDED-PMT                               15040012
150500           THRU 3600-SS-BLENDED-PMT-EXIT                          15050012
150600        MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT              15060012
150700        IF PMT-STANDARD-OLD                                       15070012
150800           MOVE '22' TO PPS-RTC                                   15080012
150900        END-IF                                                    15090012
151000        MOVE 'Y' TO H-SS-BLEND-IND                                15100012
151100        MOVE 'N' TO H-SS-COST-IND                                 15110012
151200        MOVE 'N' TO H-SS-PERDIEM-IND                              15120012
151300        MOVE 'N' TO H-SS-IPPSCOMP-IND.                            15130012
151400                                                                  15140012
151500 3400-SHORT-STAY-EXIT.                                            15150012
151600      EXIT.                                                       15160012
151700                                                                  15170012
151800                                                                  15180012
151900***************************************************************   15190012
152000*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *   15200012
152100*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *   15210012
152200*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *   15220012
152300*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *   15230012
152400***************************************************************   15240012
152500 3600-SS-BLENDED-PMT.                                             15250012
152600***************************************************************   15260012
152700                                                                  15270012
152800*** ------------------------------------------------------ ***    15280012
152900*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***    15290012
153000*** ------------------------------------------------------ ***    15300012
153100     IF H-SSOT < 25                                               15310012
153200        COMPUTE H-LTCH-BLEND-PCT ROUNDED =                        15320012
153300          H-LOS / H-SSOT                                          15330012
153400     ELSE                                                         15340012
153500        COMPUTE H-LTCH-BLEND-PCT ROUNDED =                        15350012
153600          H-LOS / 25                                              15360012
153700     END-IF.                                                      15370012
153800                                                                  15380012
153900     IF H-LTCH-BLEND-PCT > 1                                      15390012
154000        MOVE 1 TO H-LTCH-BLEND-PCT                                15400012
154100     END-IF.                                                      15410012
154200                                                                  15420012
154300                                                                  15430012
154400*** ------------------------------------------------------ ***    15440012
154500*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***    15450012
154600*** ------------------------------------------------------ ***    15460012
154700     COMPUTE H-LTCH-BLEND-AMT ROUNDED =                           15470012
154800        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.                          15480012
154900                                                                  15490012
155000                                                                  15500012
155100*** ------------------------------------------------------ ***    15510012
155200*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***    15520012
155300*** ------------------------------------------------------ ***    15530012
155400     PERFORM 3650-SS-IPPS-COMP-PMT                                15540012
155500        THRU 3650-SS-IPPS-COMP-PMT-EXIT.                          15550012
155600                                                                  15560012
155700                                                                  15570012
155800*** ------------------------------------------------------ ***    15580012
155900*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***    15590012
156000*** ------------------------------------------------------ ***    15600012
156100     COMPUTE H-IPPS-BLEND-PCT ROUNDED =                           15610012
156200       1 - H-LTCH-BLEND-PCT.                                      15620012
156300                                                                  15630012
156400                                                                  15640012
156500*** ------------------------------------------------------ ***    15650012
156600*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***    15660012
156700*** ------------------------------------------------------ ***    15670012
156800     COMPUTE H-IPPS-BLEND-AMT ROUNDED =                           15680012
156900       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.                        15690012
157000                                                                  15700012
157100                                                                  15710012
157200*** ------------------------------------------------------ ***    15720012
157300*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***    15730012
157400*** ------------------------------------------------------ ***    15740012
157500     COMPUTE H-SS-BLENDED-PMT ROUNDED =                           15750012
157600       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.                       15760012
157700                                                                  15770012
157800                                                                  15780012
157900 3600-SS-BLENDED-PMT-EXIT.                                        15790012
158000      EXIT.                                                       15800012
158100                                                                  15810012
158200                                                                  15820012
158300***************************************************************   15830012
158400*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *   15840012
158500*   PER DIEM PAYMENT AMOUNT                                   *   15850012
158600***************************************************************   15860012
158700 3650-SS-IPPS-COMP-PMT.                                           15870012
158800***************************************************************   15880012
158900                                                                  15890012
159000*** -------------------------------------------------------       15900012
159100*** OPERATING TEACHING ADJUSTMENT                                 15910012
159200*** -------------------------------------------------------       15920012
159300     COMPUTE H-OPER-IME-TEACH ROUNDED =                           15930012
159400        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).                15940012
159500                                                                  15950012
159600                                                                  15960012
159700*** -------------------------------------------------------       15970012
159800*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)              15980012
159900*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%        15990012
160000*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL       16000012
160100***              THIS CHANGE IS RETROACTIVE TO 10/01/2008         16010012
160200*** -------------------------------------------------------       16020012
160300     IF H-CAPI-IME-RATIO > 1.5000                                 16030012
160400        MOVE 1.5000 TO H-CAPI-IME-RATIO.                          16040012
160500                                                                  16050012
160600     COMPUTE H-CAPI-IME-TEACH ROUNDED =                           16060012
160700        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).             16070012
160800                                                                  16080012
160900                                                                  16090012
161000*** -------------------------------------------------------       16100012
161100*** OPERATING DSH ADJUSTMENT                                      16110012
161200*** -------------------------------------------------------       16120012
161300                                                                  16130012
161400*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL              16140012
161500*---------------------------------------------------              16150012
161600     IF ALL-RURAL                                                 16160012
161700        SET RURAL-CBSA TO TRUE                                    16170012
161800     ELSE                                                         16180012
161900        SET URBAN-CBSA TO TRUE                                    16190012
162000     END-IF.                                                      16200012
162100                                                                  16210012
162200                                                                  16220012
162300*2) CALCULATE THE OPERATING DSH PERCENT                           16230012
162400*--------------------------------------                           16240012
162500     COMPUTE H-OPER-DSH-PCT ROUNDED =                             16250012
162600        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.                   16260012
162700                                                                  16270012
162800                                                                  16280012
162900*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION            16290012
163000*-----------------------------------------------------            16300012
163100                                                                  16310012
163200*    URBAN, < 100 BEDS                                            16320012
163300*    -----------------                                            16330012
163400     IF URBAN-CBSA AND H-BED-SIZE < 100 AND                       16340012
163500        H-OPER-DSH-PCT >= .15                                     16350012
163600          MOVE '3' TO H-GEO-CLASS                                 16360012
163700     ELSE                                                         16370012
163800                                                                  16380012
163900                                                                  16390012
164000*   URBAN, >= 100 BEDS                                            16400012
164100*   ------------------                                            16410012
164200       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND                    16420012
164300          H-OPER-DSH-PCT >= .15                                   16430012
164400            MOVE '2' TO H-GEO-CLASS                               16440012
164500       ELSE                                                       16450012
164600                                                                  16460012
164700                                                                  16470012
164800*   RURAL, >= 500 BEDS                                            16480012
164900*   ------------------                                            16490012
165000         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND                  16500012
165100            H-OPER-DSH-PCT >= .15                                 16510012
165200              MOVE '2' TO H-GEO-CLASS                             16520012
165300         ELSE                                                     16530012
165400                                                                  16540012
165500                                                                  16550012
165600*   RURAL, < 500 BEDS                                             16560012
165700*   -----------------                                             16570012
165800           IF RURAL-CBSA AND H-BED-SIZE < 500 AND                 16580012
165900              H-OPER-DSH-PCT >= .15                               16590012
166000                MOVE '3' TO H-GEO-CLASS                           16600012
166100           ELSE                                                   16610012
166200                                                                  16620012
166300                                                                  16630012
166400*   OTHER                                                         16640012
166500*   -----------------                                             16650012
166600              MOVE '4' TO H-GEO-CLASS                             16660012
166700                                                                  16670012
166800           END-IF                                                 16680012
166900         END-IF                                                   16690012
167000       END-IF                                                     16700012
167100     END-IF.                                                      16710012
167200                                                                  16720012
167300                                                                  16730012
167400*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS      16740012
167500*-----------------------------------------------------------      16750012
167600     EVALUATE H-GEO-CLASS                                         16760012
167700                                                                  16770012
167800*      GEOGRAPHIC CLASS 2                                         16780012
167900*      ------------------                                         16790012
168000       WHEN '2'                                                   16800012
168100          IF (H-OPER-DSH-PCT >= .15 AND <= .202)                  16810012
168200             COMPUTE H-OPER-DSH ROUNDED =                         16820012
168300               ((H-OPER-DSH-PCT - .15) * .65) + .025              16830012
168400          ELSE                                                    16840012
168500             IF H-OPER-DSH-PCT > .202                             16850012
168600                COMPUTE H-OPER-DSH ROUNDED =                      16860012
168700                  ((H-OPER-DSH-PCT - .202) * .825) + .0588        16870012
168800             ELSE                                                 16880012
168900                MOVE ZEROS TO H-OPER-DSH                          16890012
169000             END-IF                                               16900012
169100          END-IF                                                  16910012
169200                                                                  16920012
169300*      GEOGRAPHIC CLASS 3                                         16930012
169400*      ------------------                                         16940012
169500       WHEN '3'                                                   16950012
169600          IF (H-OPER-DSH-PCT >= .15 AND <= .202)                  16960012
169700             COMPUTE H-OPER-DSH ROUNDED =                         16970012
169800               ((H-OPER-DSH-PCT - .15) * .65) + .025              16980012
169900             IF H-OPER-DSH > .12                                  16990012
170000                MOVE .12 TO H-OPER-DSH                            17000012
170100             END-IF                                               17010012
170200          ELSE                                                    17020012
170300             IF H-OPER-DSH-PCT > .202                             17030012
170400                COMPUTE H-OPER-DSH ROUNDED =                      17040012
170500                  ((H-OPER-DSH-PCT - .202) * .825) + .0588        17050012
170600                IF H-OPER-DSH > .12                               17060012
170700                   MOVE .12 TO H-OPER-DSH                         17070012
170800                END-IF                                            17080012
170900             ELSE                                                 17090012
171000               MOVE ZEROS TO H-OPER-DSH                           17100012
171100             END-IF                                               17110012
171200          END-IF                                                  17120012
171300                                                                  17130012
171400*      GEOGRAPHIC CLASS 4                                         17140012
171500*      ------------------                                         17150012
171600       WHEN '4'                                                   17160012
171700          MOVE ZEROS TO H-OPER-DSH                                17170012
171800                                                                  17180012
171900     END-EVALUATE.                                                17190012
172000                                                                  17200012
172100                                                                  17210012
172200*** -------------------------------------------------------       17220012
172300*** CURRENT OPERATING DSH PAYMENT REDUCTION                       17230012
172400*** -------------------------------------------------------       17240012
172500     COMPUTE H-OPER-DSH ROUNDED =                                 17250012
172600             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.            17260012
172700                                                                  17270012
172800*** -------------------------------------------------------       17280012
172900*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)                   17290012
173000*** -------------------------------------------------------       17300012
173100     IF URBAN-CBSA AND H-BED-SIZE >= 100                          17310012
173200        COMPUTE H-CAPI-DSH ROUNDED =                              17320012
173300          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1                  17330012
173400     ELSE                                                         17340012
173500        MOVE ZEROS TO H-CAPI-DSH                                  17350012
173600     END-IF.                                                      17360012
173700                                                                  17370012
173800                                                                  17380012
173900*** -------------------------------------------------------       17390012
174000*** OPERATING PAYMENT (STANDARD AMOUNT)                           17400012
174100*** -------------------------------------------------------       17410012
174200     IF (P-NEW-STATE = 02 OR 12)                                  17420012
174300        MOVE P-NEW-COLA TO H-OPER-COLA                            17430012
174400     ELSE                                                         17440012
174500        MOVE 1.000 TO H-OPER-COLA                                 17450012
174600     END-IF.                                                      17460012
174700                                                                  17470012
174800     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =                       17480012
174900       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +             17490012
175000         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *              17500012
175100         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).   17510012
175200                                                                  17520012
175300                                                                  17530012
175400*** -------------------------------------------------------       17540012
175500*** CAPITAL PAYMENT (CAPITAL RATE)                                17550012
175600*** -------------------------------------------------------       17560012
175700     COMPUTE H-CAPI-COLA ROUNDED =                                17570012
175800       (.3152 * (H-OPER-COLA - 1) + 1).                           17580012
175900                                                                  17590012
176000*--------------------------------------------------------------*  17600012
176100*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *  17610012
176200*   LATER (CHANGED FROM 1.03 TO 1.00)                          *  17620012
176300*--------------------------------------------------------------*  17630012
176400     IF LARGE-URBAN                                               17640012
176500        MOVE 1.00 TO H-LRGURB-ADD-ON                              17650012
176600     ELSE                                                         17660012
176700        MOVE 1.00 TO H-LRGURB-ADD-ON                              17670012
176800     END-IF.                                                      17680012
176900                                                                  17690012
177000     COMPUTE H-CAPI-GAF ROUNDED =                                 17700012
177100       (H-IPPS-WAGE-INDEX ** .6848).                              17710012
177200                                                                  17720012
177300     COMPUTE H-CAPI-PMT ROUNDED =                                 17730012
177400       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *   17740012
177500       H-LRGURB-ADD-ON *  H-CAPI-COLA *                           17750012
177600       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).                       17760012
177700                                                                  17770012
177800                                                                  17780012
177900*** -------------------------------------------------------       17790012
178000*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)           17800012
178100*** -------------------------------------------------------       17810012
178200     COMPUTE H-IPPS-PAY-AMT ROUNDED =                             17820012
178300       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.                         17830012
178400                                                                  17840012
178500                                                                  17850012
178600*** -------------------------------------------------------       17860012
178700*** IPPS COMPARABLE PER DIEM PAYMENT                              17870012
178800*** -------------------------------------------------------       17880012
178900     COMPUTE H-IPPS-PER-DIEM ROUNDED =                            17890012
179000       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.                17900012
179100                                                                  17910012
179200     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT                          17920012
179300        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM                    17930012
179400     END-IF.                                                      17940012
179500                                                                  17950012
179600*** -------------------------------------------------------       17960012
179700*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS                   17970012
179800*** -------------------------------------------------------       17980012
179900                                                                  17990012
180000                                                                  18000012
180100 3650-SS-IPPS-COMP-PMT-EXIT.                                      18010012
180200      EXIT.                                                       18020012
180300                                                                  18030012
180400                                                                  18040012
180500***************************************************************   18050012
180600*4000-SPECIAL-PROVIDER.                                           18060012
180700***************************************************************   18070012
180800*                                                                 18080012
180900*** PROCESS FOR CY2003                                            18090012
181000*** ------------------                                            18100012
181100*    IF (B-DISCHARGE-DATE >= 20030701) AND                        18110012
181200*       (B-DISCHARGE-DATE <  20040101)                            18120012
181300*       COMPUTE H-SS-COST ROUNDED =                               18130012
181400*           (PPS-FAC-COSTS * 1.95)                                18140012
181500*       COMPUTE H-SS-PAY-AMT ROUNDED =                            18150012
181600*        ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95     18160012
181700*    END-IF                                                       18170012
181800*                                                                 18180012
181900*                                                                 18190012
182000*** PROCESS FOR CY2004                                            18200012
182100*** ------------------                                            18210012
182200*    IF (B-DISCHARGE-DATE >= 20040101) AND                        18220012
182300*       (B-DISCHARGE-DATE <  20050101)                            18230012
182400*       COMPUTE H-SS-COST ROUNDED =                               18240012
182500*           (PPS-FAC-COSTS * 1.93)                                18250012
182600*       COMPUTE H-SS-PAY-AMT ROUNDED =                            18260012
182700*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93    18270012
182800*    END-IF                                                       18280012
182900*                                                                 18290012
183000*                                                                 18300012
183100*** PROCESS FOR CY2005                                            18310012
183200*** ------------------                                            18320012
183300*    IF (B-DISCHARGE-DATE >= 20050101) AND                        18330012
183400*       (B-DISCHARGE-DATE <  20060101)                            18340012
183500*       COMPUTE H-SS-COST ROUNDED =                               18350012
183600*           (PPS-FAC-COSTS * 1.65)                                18360012
183700*       COMPUTE H-SS-PAY-AMT ROUNDED =                            18370012
183800*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65    18380012
183900*    END-IF                                                       18390012
184000*                                                                 18400012
184100*                                                                 18410012
184200*** PROCESS FOR CY2006                                            18420012
184300*** ------------------                                            18430012
184400*    IF (B-DISCHARGE-DATE >= 20060101) AND                        18440012
184500*       (B-DISCHARGE-DATE <  20070101)                            18450012
184600*       COMPUTE H-SS-COST ROUNDED =                               18460012
184700*           (PPS-FAC-COSTS * 1.36)                                18470012
184800*       COMPUTE H-SS-PAY-AMT ROUNDED =                            18480012
184900*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36    18490012
185000*    END-IF                                                       18500012
185100*                                                                 18510012
185200*                                                                 18520012
185300*** PROCESS FOR CY2007 AND AFTER                                  18530012
185400*** ----------------------------                                  18540012
185500*    IF (B-DISCHARGE-DATE >= 20070101)                            18550012
185600*       COMPUTE H-SS-COST ROUNDED =                               18560012
185700*           (PPS-FAC-COSTS * 1.2)                                 18570012
185800*       COMPUTE H-SS-PAY-AMT ROUNDED =                            18580012
185900*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2     18590012
186000*    END-IF.                                                      18600012
186100*                                                                 18610012
186200*4000-SPECIAL-PROVIDER-EXIT.                                      18620012
186300*     EXIT.                                                       18630012
186400                                                                  18640012
186500                                                                  18650012
186600***************************************************************   18660012
186700*   CALCULATE THE OUTLIER THRESHOLD                           *   18670012
186800*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *   18680012
186900*     IS GREATER THAN THE OUTLIER THRESHOLD                   *   18690012
187000*   SET RETURN CODE                                           *   18700012
187100*   CALCULATE THE CHARGE THRESHOLD IF APPLICABLE              *   18710012
187200***************************************************************   18720012
187300 6000-CALC-HIGH-COST-OUTLIER.                                     18730012
187400***************************************************************   18740012
187500                                                                  18750012
187600                                                                  18760012
187700*-------------------------------------------------------------*   18770012
187800* FOR NON-BLENDED PAYMENT CLAIMS:                             *   18780012
187900*-------------------------------------------------------------*   18790012
188000* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLD  *   18800012
188100*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *   18810012
188200* - CALCULATE OUTLIER THRESHOLD                               *   18820012
188300*-------------------------------------------------------------*   18830012
188400                                                                  18840012
188500     IF PMT-STANDARD-OLD                                          18850012
188600        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =                   18860012
188700                PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT-STD        18870012
188800     END-IF.                                                      18880012
188900                                                                  18890012
189000                                                                  18900012
189100     IF PMT-STANDARD-NEW                                          18910012
189200        IF PMT-STANDARD-FULL                                      18920012
189300           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =                18930012
189400                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD   18940012
189500        ELSE                                                      18950012
189600           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =                18960012
189700                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD    18970012
189800        END-IF                                                    18980012
189900     END-IF.                                                      18990012
190000                                                                  19000012
190100                                                                  19010012
190200     IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS                   19020012
190300        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =                   19030012
190400                PPS-SITE-NEUTRAL-IPPS-PMT + H-FIXED-LOSS-AMT-SNT  19040012
190500     END-IF.                                                      19050012
190600                                                                  19060012
190700                                                                  19070012
190800*-------------------------------------------------------------*   19080012
190900* CALCULATE HIGH-COST OUTLIER IF COSTS EXCEED THRESHOLD       *   19090012
191000*-------------------------------------------------------------*   19100012
191100     IF NOT PMT-BLEND AND                                         19110012
191200        NOT (PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-COST)             19120012
191300        IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD                  19130012
191400           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =                  19140012
191500                   (PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8   19150012
191600                                                                  19160012
191700*-------------------------------------------------------------*   19170012
191800*        SITE-NEUTRAL ONLY: REDUCE BY BUDGET NEUTRALITY FACT. *   19180012
191900*-------------------------------------------------------------*   19190012
192000*          IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS             19200012
192100*             COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =               19210012
192200*                    PPS-OUTLIER-PAY-AMT * H-BDGT-NEUT-FACTOR     19220012
192300*          END-IF                                                 19230012
192400        END-IF                                                    19240012
192500     END-IF.                                                      19250012
192600                                                                  19260012
192700                                                                  19270012
192800                                                                  19280012
192900*-------------------------------------------------------------*   19290012
193000* FOR BLENDED PAYMENT CLAIMS                                  *   19300012
193100* (RECEIVE 50% STANDARD PAYMENT + 50% SITE-NEUTRAL PAYMENT)   *   19310012
193200*-------------------------------------------------------------*   19320012
193300* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLDS *   19330012
193400*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *   19340012
193500* - CALCULATE STANDARD PAYMENT OUTLIER THRESHOLD              *   19350012
193600* - CALCULATE SITE-NEUTRAL PAYMENT OUTLIER THRESHOLD          *   19360012
193700* - CALCULATE HIGH-COST OUTLIER IF APPLICABLE (50/50 BLEND)   *   19370012
193800*-------------------------------------------------------------*   19380012
193900                                                                  19390012
194000     IF PMT-BLEND                                                 19400012
194100                                                                  19410012
194200*-------------------------------------------------------------*   19420012
194300* CALCULATE STANDARD OUTLIER THRESHOLD                        *   19430012
194400*-------------------------------------------------------------*   19440012
194500        IF PMT-STANDARD-FULL                                      19450012
194600           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =              19460012
194700                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD   19470012
194800        ELSE                                                      19480012
194900           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =              19490012
195000                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD    19500012
195100        END-IF                                                    19510012
195200                                                                  19520012
195300                                                                  19530012
195400*-------------------------------------------------------------*   19540012
195500* CALCULATE SITE-NEUTRAL OUTLIER THRESHOLD                    *   19550012
195600*-------------------------------------------------------------*   19560012
195700        IF PMT-SITE-NEUT-IPPS                                     19570012
195800           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =                19580012
195900                   PPS-SITE-NEUTRAL-IPPS-PMT +                    19590012
196000                   H-FIXED-LOSS-AMT-SNT                           19600012
196100        END-IF                                                    19610012
196200                                                                  19620012
196300                                                                  19630012
196400*-------------------------------------------------------------*   19640012
196500* CALCULATE STANDARD PAYMENT PORTION OF HIGH-COST OUTLIER IF  *   19650012
196600* COSTS EXCEED STANDARD PAYMENT THRESHOLD                     *   19660012
196700*-------------------------------------------------------------*   19670012
196800        IF PPS-FAC-COSTS > H-OUTLIER-THRESHOLD-STD                19680012
196900           COMPUTE H-OUTLIER-PAY-AMT-STD ROUNDED =                19690012
197000                   (PPS-FAC-COSTS - H-OUTLIER-THRESHOLD-STD) * .8 19700012
197100                   * H-BLEND-STD                                  19710012
197200        END-IF                                                    19720012
197300                                                                  19730012
197400                                                                  19740012
197500*-------------------------------------------------------------*   19750012
197600* CALCULATE SITE-NEUTRAL PORTION OF HIGH-COST OUTLIER IF      *   19760012
197700* COSTS EXCEED THE SITE-NEUTRAL PAYMENT THRESHOLD             *   19770012
197800*-------------------------------------------------------------*   19780012
197900        IF PMT-SITE-NEUT-IPPS AND                                 19790012
198000           PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD                  19800012
198100           COMPUTE H-OUTLIER-PAY-AMT-SNT ROUNDED =                19810012
198200                  (((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8) 19820012
198300*                  * H-BLEND-SNT) * H-BDGT-NEUT-FACTOR            19830012
198400                   * H-BLEND-SNT)                                 19840012
198500        END-IF                                                    19850012
198600                                                                  19860012
198700*-------------------------------------------------------------*   19870012
198800* CALCULATE TOTAL BLENDED HIGH-COST OUTLIER:                  *   19880012
198900* ADD THE SITE-NEUTRAL PAYMENT PORTION OF HIGH-COST OUTLIER   *   19890012
199000* TO THE STANDARD PAYMENT PORTION                             *   19900012
199100*-------------------------------------------------------------*   19910012
199200        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =                     19920012
199300                H-OUTLIER-PAY-AMT-STD +                           19930012
199400                (H-OUTLIER-PAY-AMT-SNT * H-SITE-NEUTRAL-IPPS-ADJ) 19940012
199500                                                                  19950012
199600     END-IF.                                                      19960012
199700                                                                  19970012
199800                                                                  19980012
199900*-------------------------------------------------------------*   19990012
200000* FOR ALL CLAIMS:                                             *   20000012
200100*-------------------------------------------------------------*   20010012
200200* SET HIGH-COST OUTLIER TO $0 IF BILL SPECIAL PAY IND. = '1'  *   20020012
200300*-------------------------------------------------------------*   20030012
200400     IF B-SPEC-PAY-IND = '1'                                      20040012
200500        MOVE 0 TO PPS-OUTLIER-PAY-AMT.                            20050012
200600                                                                  20060012
200700                                                                  20070012
200800*-------------------------------------------------------------*   20080012
200900* DETERMINE IF CHARGE THRESHOLD APPLIES & CALCULATE IF SO     *   20090012
201000*-------------------------------------------------------------*   20100012
201100     PERFORM 6100-CALC-CHARGE-THRESHOLD                           20110012
201200        THRU 6100-EXIT.                                           20120012
201300                                                                  20130012
201400                                                                  20140012
201500 6000-EXIT.                                                       20150012
201600      EXIT.                                                       20160012
201700                                                                  20170012
201800                                                                  20180012
201900***************************************************************   20190012
202000*   CALCULATE CHARGE THRESHOLD & SET ERROR RTC WHEN APPLICABLE*   20200012
202100***************************************************************   20210012
202200 6100-CALC-CHARGE-THRESHOLD.                                      20220012
202300***************************************************************   20230012
202400                                                                  20240012
202500                                                                  20250012
202600*-------------------------------------------------------------*   20260012
202700* FOR MAINFRAME PRICER ONLY:                                  *   20270012
202800*-------------------------------------------------------------*   20280012
202900* FOR CLAIMS THAT RECEIVE A HIGH-COST OUTLIER AND HAVE A      *   20290012
203000* LENGTH OF STAY THAT EXCEEDS THE COVERED DAYS, CALCULATE THE *   20300012
203100* CHARGE THRESHOLD AND SET ERROR RETURN CODE '67'             *   20310012
203200*-------------------------------------------------------------*   20320012
203300                                                                  20330012
203400*-------------------------------------------------------------*   20340012
203500* FOR PC PRICER (PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS):      *   20350012
203600*-------------------------------------------------------------*   20360012
203700* CALCULATE CHARGE THRESHOLD FOR CLAIMS ALL CLAIMS THAT HAVE  *   20370012
203800* AN OPERATING COST-TO-CHARGE RATIO BUT DO NOT SET ERROR CODE *   20380012
203900*-------------------------------------------------------------*   20390012
204000                                                                  20400012
204100     IF (PPS-OUTLIER-PAY-AMT > 0 AND                              20410012
204200         NOT (PMT-BLEND AND H-OUTLIER-PAY-AMT-SNT = 0)) OR        20420012
204300        PPS-COT-IND = 'Y'                                         20430012
204400                                                                  20440012
204500        IF B-COV-DAYS < H-LOS OR                                  20450012
204600           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)20460012
204700                                                                  20470012
204800           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =                   20480012
204900             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO      20490012
205000                                                                  20500012
205100           IF NOT PC-PRICER                                       20510012
205200              MOVE '67' TO PPS-RTC                                20520012
205300           END-IF                                                 20530012
205400                                                                  20540012
205500        ELSE                                                      20550012
205600           NEXT SENTENCE                                          20560012
205700        END-IF                                                    20570012
205800     ELSE                                                         20580012
205900        NEXT SENTENCE                                             20590012
206000     END-IF.                                                      20600012
206100                                                                  20610012
206200 6100-EXIT.                                                       20620012
206300      EXIT.                                                       20630012
206400                                                                  20640012
206500                                                                  20650012
206600***************************************************************   20660012
206700*   SET FINAL RETURN CODES FOR PRICED CLAIMS                  *   20670012
206800***************************************************************   20680012
206900 7000-SET-FINAL-RETURN-CODES.                                     20690012
207000***************************************************************   20700012
207100                                                                  20710012
207200                                                                  20720012
207300*-------------------------------------------------------------*   20730012
207400* SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIM            *   20740012
207500*-------------------------------------------------------------*   20750012
207600*    IF SUBCLAUSEII-PROV                                          20760012
207700*       PERFORM 7300-SET-SUBII-RETURN-CODES                       20770012
207800*          THRU 7300-EXIT                                         20780012
207900*       GO TO 7000-EXIT                                           20790012
208000*    END-IF.                                                      20800012
208100                                                                  20810012
208200                                                                  20820012
208300*-------------------------------------------------------------*   20830012
208400* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *   20840012
208500* PAYMENT IF OUTLIER PAYMENT IS > $0                          *   20850012
208600*-------------------------------------------------------------*   20860012
208700     IF PMT-STANDARD-OLD                                          20870012
208800        PERFORM 7100-SET-OLD-RETURN-CODES                         20880012
208900           THRU 7100-EXIT                                         20890012
209000     END-IF.                                                      20900012
209100                                                                  20910012
209200                                                                  20920012
209300*-------------------------------------------------------------*   20930012
209400* SET RETURN CODES FOR NEW POLICY CLAIMS                      *   20940012
209500*-------------------------------------------------------------*   20950012
209600     IF PMT-STANDARD-NEW OR PMT-SITE-NEUTRAL OR PMT-BLEND         20960012
209700        PERFORM 7200-SET-NEW-RETURN-CODES                         20970012
209800           THRU 7200-EXIT                                         20980012
209900     END-IF.                                                      20990012
210000                                                                  21000012
210100                                                                  21010012
210200 7000-EXIT.                                                       21020012
210300      EXIT.                                                       21030012
210400                                                                  21040012
210500                                                                  21050012
210600***************************************************************   21060012
210700*   SET RETURN CODES FOR OLD POLICY CLAIMS                    *   21070012
210800***************************************************************   21080012
210900 7100-SET-OLD-RETURN-CODES.                                       21090012
211000***************************************************************   21100012
211100                                                                  21110012
211200*-------------------------------------------------------------*   21120012
211300* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *   21130012
211400* PAYMENT IF OUTLIER PAYMENT IS > $0                          *   21140012
211500*-------------------------------------------------------------*   21150012
211600                                                                  21160012
211700     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '21'                21170012
211800        MOVE '24' TO PPS-RTC.                                     21180012
211900                                                                  21190012
212000     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '22'                21200012
212100        MOVE '25' TO PPS-RTC.                                     21210012
212200                                                                  21220012
212300     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '26'                21230012
212400        MOVE '27' TO PPS-RTC.                                     21240012
212500                                                                  21250012
212600     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '00'                21260012
212700        MOVE '01' TO PPS-RTC.                                     21270012
212800                                                                  21280012
212900     IF (PPS-RTC = '00' OR '20' OR '21' OR '22' OR '26')          21290012
213000        IF PPS-REG-DAYS-USED > H-SSOT                             21300012
213100           MOVE 0 TO PPS-LTR-DAYS-USED                            21310012
213200        ELSE                                                      21320012
213300           NEXT SENTENCE.                                         21330012
213400                                                                  21340012
213500 7100-EXIT.                                                       21350012
213600      EXIT.                                                       21360012
213700                                                                  21370012
213800                                                                  21380012
213900***************************************************************   21390012
214000*   SET RETURN CODES FOR NEW POLICY CLAIMS                    *   21400012
214100***************************************************************   21410012
214200 7200-SET-NEW-RETURN-CODES.                                       21420012
214300***************************************************************   21430012
214400                                                                  21440012
214500     INITIALIZE PPS-RTC.                                          21450012
214600                                                                  21460012
214700***************************************************************   21470012
214800* SET THE FIRST POSITION OF THE RETURN CODE                   *   21480012
214900***************************************************************   21490012
215000                                                                  21500012
215100*--------------------------------------------------*              21510012
215200* DEFAULT (NO PSYCH/REHAB NOR VENTILATOR SERVICE)  *              21520012
215300*--------------------------------------------------*              21530012
215400     MOVE 'C' TO PPS-RTC-1.                                       21540012
215500                                                                  21550012
215600*--------------------------------------------------*              21560012
215700* VENTILATOR SERVICE PRESENT                       *              21570012
215800*--------------------------------------------------*              21580012
215900     PERFORM 7250-SEARCH-FOR-VENT-PROC                            21590012
216000        THRU 7250-EXIT.                                           21600012
216100     IF VENT-PRESENT                                              21610012
216200        MOVE 'B' TO PPS-RTC-1                                     21620012
216300     END-IF.                                                      21630012
216400                                                                  21640012
216500*--------------------------------------------------*              21650012
216600* SITE NEUTRAL PMT BECAUSE PSYCH/REHAB DRG PRESENT *              21660012
216700* (PRESENCE OF PSCHY/REHAB DRG TRUMPS VENT PROC.)  *              21670012
216800*--------------------------------------------------*              21680012
216900     IF PSYCH-REHAB-DRG AND                                       21690012
217000        (PMT-SITE-NEUTRAL OR PMT-BLEND)                           21700012
217100        MOVE 'A' TO PPS-RTC-1                                     21710012
217200     END-IF.                                                      21720012
217300                                                                  21730012
217400                                                                  21740012
217500                                                                  21750012
217600***************************************************************   21760012
217700* SET THE SECOND POSITION OF RETURN CODE                      *   21770012
217800***************************************************************   21780012
217900                                                                  21790012
218000*-------------------------------------------------------------*   21800012
218100* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = COST         *   21810012
218200*-------------------------------------------------------------*   21820012
218300     IF PMT-BLEND AND PMT-SITE-NEUT-COST                          21830012
218400                                                                  21840012
218500        IF PPS-OUTLIER-PAY-AMT = 0 AND                            21850012
218600           PMT-STANDARD-FULL                                      21860012
218700           MOVE '0' TO PPS-RTC-2                                  21870012
218800        END-IF                                                    21880012
218900                                                                  21890012
219000        IF PPS-OUTLIER-PAY-AMT > 0 AND                            21900012
219100           PMT-STANDARD-FULL                                      21910012
219200           MOVE '1' TO PPS-RTC-2                                  21920012
219300        END-IF                                                    21930012
219400                                                                  21940012
219500        IF PPS-OUTLIER-PAY-AMT = 0 AND                            21950012
219600           PMT-STANDARD-SSO                                       21960012
219700           MOVE '2' TO PPS-RTC-2                                  21970012
219800        END-IF                                                    21980012
219900                                                                  21990012
220000        IF PPS-OUTLIER-PAY-AMT > 0 AND                            22000012
220100           PMT-STANDARD-SSO                                       22010012
220200           MOVE '3' TO PPS-RTC-2                                  22020012
220300        END-IF                                                    22030012
220400                                                                  22040012
220500     END-IF.                                                      22050012
220600                                                                  22060012
220700                                                                  22070012
220800*-------------------------------------------------------------*   22080012
220900* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = IPPS COMP.   *   22090012
221000*-------------------------------------------------------------*   22100012
221100     IF PMT-BLEND AND PMT-SITE-NEUT-IPPS                          22110012
221200                                                                  22120012
221300        IF PPS-OUTLIER-PAY-AMT = 0 AND                            22130012
221400           PMT-STANDARD-FULL                                      22140012
221500           MOVE '4' TO PPS-RTC-2                                  22150012
221600        END-IF                                                    22160012
221700                                                                  22170012
221800        IF PPS-OUTLIER-PAY-AMT > 0 AND                            22180012
221900           PMT-STANDARD-FULL                                      22190012
222000           MOVE '5' TO PPS-RTC-2                                  22200012
222100        END-IF                                                    22210012
222200                                                                  22220012
222300        IF PPS-OUTLIER-PAY-AMT = 0 AND                            22230012
222400           PMT-STANDARD-SSO                                       22240012
222500           MOVE '6' TO PPS-RTC-2                                  22250012
222600        END-IF                                                    22260012
222700                                                                  22270012
222800        IF PPS-OUTLIER-PAY-AMT > 0 AND                            22280012
222900           PMT-STANDARD-SSO                                       22290012
223000           MOVE '7' TO PPS-RTC-2                                  22300012
223100        END-IF                                                    22310012
223200                                                                  22320012
223300     END-IF.                                                      22330012
223400                                                                  22340012
223500                                                                  22350012
223600*-------------------------------------------------------------*   22360012
223700* 100% SITE NEUTRAL PAYMENT CLAIMS                            *   22370012
223800*-------------------------------------------------------------*   22380012
223900     IF PMT-SITE-NEUTRAL                                          22390012
224000                                                                  22400012
224100        IF PMT-SITE-NEUT-COST                                     22410012
224200           MOVE 'A' TO PPS-RTC-2                                  22420012
224300        END-IF                                                    22430012
224400                                                                  22440012
224500        IF PMT-SITE-NEUT-IPPS                                     22450012
224600           IF PPS-OUTLIER-PAY-AMT = 0                             22460012
224700              MOVE 'B' TO PPS-RTC-2                               22470012
224800           ELSE                                                   22480012
224900              MOVE 'C' TO PPS-RTC-2                               22490012
225000           END-IF                                                 22500012
225100        END-IF                                                    22510012
225200     END-IF.                                                      22520012
225300                                                                  22530012
225400                                                                  22540012
225500*-------------------------------------------------------------*   22550012
225600* 100% STANDARD PAYMENT CLAIMS                                *   22560012
225700*-------------------------------------------------------------*   22570012
225800     IF PMT-STANDARD-NEW                                          22580012
225900                                                                  22590012
226000        IF PMT-STANDARD-SSO AND                                   22600012
226100           PPS-OUTLIER-PAY-AMT = 0                                22610012
226200           MOVE 'D' TO PPS-RTC-2                                  22620012
226300        END-IF                                                    22630012
226400                                                                  22640012
226500        IF PMT-STANDARD-SSO AND                                   22650012
226600           PPS-OUTLIER-PAY-AMT > 0                                22660012
226700           MOVE 'E' TO PPS-RTC-2                                  22670012
226800        END-IF                                                    22680012
226900                                                                  22690012
227000        IF PMT-STANDARD-FULL AND                                  22700012
227100           PPS-OUTLIER-PAY-AMT = 0                                22710012
227200           MOVE 'F' TO PPS-RTC-2                                  22720012
227300        END-IF                                                    22730012
227400                                                                  22740012
227500        IF PMT-STANDARD-FULL AND                                  22750012
227600           PPS-OUTLIER-PAY-AMT > 0                                22760012
227700           MOVE 'G' TO PPS-RTC-2                                  22770012
227800        END-IF                                                    22780012
227900                                                                  22790012
228000     END-IF.                                                      22800012
228100                                                                  22810012
228200                                                                  22820012
228300 7200-EXIT.                                                       22830012
228400      EXIT.                                                       22840012
228500                                                                  22850012
228600                                                                  22860012
228700***************************************************************   22870012
228800*   SEARCH FOR VENTILATOR SERVICE ICD-10 PROCEDURE CODE       *   22880012
228900***************************************************************   22890012
229000 7250-SEARCH-FOR-VENT-PROC.                                       22900012
229100***************************************************************   22910012
229200                                                                  22920012
229300     SET IDX-PROC TO 1.                                           22930012
229400                                                                  22940012
229500     SEARCH B-PROCEDURE-CODE VARYING IDX-PROC                     22950012
229600         AT END                                                   22960012
229700            SET VENT-NOT-PRESENT TO TRUE                          22970012
229800         WHEN VENT-ICD-10-CODE = B-PROCEDURE-CODE (IDX-PROC)      22980012
229900            SET VENT-PRESENT TO TRUE                              22990012
230000            GO TO 7250-EXIT                                       23000012
230100     END-SEARCH.                                                  23010012
230200                                                                  23020012
230300 7250-EXIT.                                                       23030012
230400      EXIT.                                                       23040012
230500                                                                  23050012
230600                                                                  23060012
230700***************************************************************   23070012
230800*   SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIMS         *   23080012
230900***************************************************************   23090012
231000*7300-SET-SUBII-RETURN-CODES.                                     23100012
231100***************************************************************   23110012
231200*                                                                 23120012
231300*    INITIALIZE PPS-RTC.                                          23130012
231400*                                                                 23140012
231500*-------------------------------------------------------------*   23150012
231600* SET RETURN CODE BASED ON PRESENCE/ABSENCE OF OUTLIER        *   23160012
231700*-------------------------------------------------------------*   23170012
231800*    IF PPS-OUTLIER-PAY-AMT > 0                                   23180012
231900*       MOVE '29' TO PPS-RTC                                      23190012
232000*    ELSE                                                         23200012
232100*       MOVE '28' TO PPS-RTC                                      23210012
232200*    END-IF.                                                      23220012
232300*                                                                 23230012
232400*-------------------------------------------------------------*   23240012
232500* MOVE PER DIEM AMOUNT TO OUTPUT RECORD VARIABLE              *   23250012
232600*-------------------------------------------------------------*   23260012
232700*    MOVE P-NEW-FAC-SPEC-RATE TO PPS-NEW-FAC-SPEC-RATE.           23270012
232800*                                                                 23280012
232900*-------------------------------------------------------------*   23290012
233000* INITIALIZE OUTPUT FIELDS THAT DON'T APPLY TO SUBCLAUSE II   *   23300012
233100*-------------------------------------------------------------*   23310012
233200*    INITIALIZE PPS-OUTLIER-PAY-AMT                               23320012
233300*               PPS-DRG-ADJ-PAY-AMT                               23330012
233400*               PPS-FED-PAY-AMT                                   23340012
233500*               PPS-FAC-COSTS                                     23350012
233600*               PPS-SUBM-DRG-CODE                                 23360012
233700*               PPS-NAT-LABOR-PCT                                 23370012
233800*               PPS-NAT-NONLABOR-PCT                              23380012
233900*               PPS-STD-FED-RATE                                  23390012
234000*               PPS-BDGT-NEUT-RATE                                23400012
234100*               PPS-IPTHRESH                                      23410012
234200*               PPS-SITE-NEUTRAL-COST-PMT                         23420012
234300*               PPS-SITE-NEUTRAL-IPPS-PMT                         23430012
234400*               PPS-STANDARD-FULL-PMT                             23440012
234500*               PPS-STANDARD-SSO-PMT.                             23450012
234600*                                                                 23460012
234700*                                                                 23470012
234800*7300-EXIT.                                                       23480012
234900*     EXIT.                                                       23490012
235000                                                                  23500012
235100                                                                  23510012
235200***************************************************************   23520012
235300*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *   23530012
235400*   UNIQUE CALCULATION FOR EACH CLAIM PAYMENT TYPE COMBO      *   23540012
235500***************************************************************   23550012
235600 8000-CALC-FINAL-PMT.                                             23560012
235700***************************************************************   23570012
235800                                                                  23580012
235900                                                                  23590012
236000*-------------------------------------------------------------*   23600012
236100* SUBCLAUSE II CLAIMS                                         *   23610012
236200*   P-NEW-FAC-SPEC-RATE = PER DIEM PMT RATE FOR SUBCLAUSE II  *   23620012
236300*-------------------------------------------------------------*   23630012
236400*    IF SUBCLAUSEII-PROV                                          23640012
236500*       COMPUTE PPS-FINAL-PAY-AMT ROUNDED =                       23650012
236600*               P-NEW-FAC-SPEC-RATE *                             23660012
236700*               B-CST-RPT-DAYS                                    23670012
236800*       GO TO 8000-EXIT                                           23680012
236900*    END-IF.                                                      23690012
237000                                                                  23700012
237100                                                                  23710012
237200*-------------------------------------------------------------*   23720012
237300* OLD POLICY CLAIMS (100% STANDARD PAYMENT)                   *   23730012
237400*-------------------------------------------------------------*   23740012
237500     IF PMT-STANDARD-OLD                                          23750012
237600        COMPUTE PPS-FINAL-PAY-AMT =                               23760012
237700                PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT         23770012
237800     END-IF.                                                      23780012
237900                                                                  23790012
238000                                                                  23800012
238100*-------------------------------------------------------------*   23810012
238200* NEW POLICY CLAIMS (ANY PAYMENT TYPE)                        *   23820012
238300*     - ONLY APPLICABLE PAYMENT FIELDS CONTAIN VALUES > $0    *   23830012
238400*     - APPLY BUDGET NEUTRALITY AND/OR BLEND TO PAYMENT       *   23840012
238500*       IF NEEDED                                             *   23850012
238600*     - ANY APPLICABLE BUDGET NEUTRALITY AND/OR BLEND WAS     *   23860012
238700*       ALREADY APPLIED TO OUTLIER PAYMENT                    *   23870012
238800*-------------------------------------------------------------*   23880012
238900     IF NOT PMT-STANDARD-OLD                                      23890012
239000                                                                  23900012
239100*-------------------------------------------------------*         23910012
239200* APPLY BUDGET NEUTRALITY AND SITE-NEUTRAL IPPS ADJ.    *         23920012
239300* TO 100% SITE-NEUTRAL PAYMENTS                         *         23930012
239400*-------------------------------------------------------*         23940012
239500        IF PMT-SITE-NEUTRAL                                       23950012
239600           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =            23960012
239700                   PPS-SITE-NEUTRAL-COST-PMT *                    23970012
239800                   H-BDGT-NEUT-FACTOR                             23980012
239900                                                                  23990012
240000           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =            24000012
240100                   PPS-SITE-NEUTRAL-IPPS-PMT *                    24010012
240200                   H-BDGT-NEUT-FACTOR *                           24020012
240300                   H-SITE-NEUTRAL-IPPS-ADJ                        24030012
240400                                                                  24040012
240500           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =                  24050012
240600                   PPS-OUTLIER-PAY-AMT *                          24060012
240700                   H-SITE-NEUTRAL-IPPS-ADJ                        24070012
240800        END-IF                                                    24080012
240900                                                                  24090012
241000                                                                  24100012
241100*-------------------------------------------------------*         24110012
241200* APPLY BLEND PERCENTS, BUDGET NEUT, AND SITE-NEUTRAL   *         24120012
241300* IPPS ADJUSTMENT TO BLENDED PAYMENTS                   *         24130012
241400*-------------------------------------------------------*         24140012
241500        IF PMT-BLEND                                              24150012
241600           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =            24160012
241700                   PPS-SITE-NEUTRAL-COST-PMT *                    24170012
241800                   H-BDGT-NEUT-FACTOR *                           24180012
241900                   H-BLEND-SNT                                    24190012
242000                                                                  24200012
242100           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =            24210012
242200                   PPS-SITE-NEUTRAL-IPPS-PMT *                    24220012
242300                   H-BDGT-NEUT-FACTOR *                           24230012
242400                   H-SITE-NEUTRAL-IPPS-ADJ *                      24240012
242500                   H-BLEND-SNT                                    24250012
242600                                                                  24260012
242700           COMPUTE PPS-STANDARD-FULL-PMT ROUNDED =                24270012
242800                   PPS-STANDARD-FULL-PMT * H-BLEND-STD            24280012
242900                                                                  24290012
243000           COMPUTE PPS-STANDARD-SSO-PMT ROUNDED =                 24300012
243100                   PPS-STANDARD-SSO-PMT * H-BLEND-STD             24310012
243200        END-IF                                                    24320012
243300                                                                  24330012
243400*-------------------------------------------------------*         24340012
243500* SUM PAYMENT FIELDS FOR FINAL PAYMENT                  *         24350012
243600*-------------------------------------------------------*         24360012
243700        COMPUTE PPS-FINAL-PAY-AMT =                               24370012
243800                PPS-STANDARD-FULL-PMT +                           24380012
243900                PPS-STANDARD-SSO-PMT +                            24390012
244000                PPS-SITE-NEUTRAL-COST-PMT +                       24400012
244100                PPS-SITE-NEUTRAL-IPPS-PMT +                       24410012
244200                PPS-OUTLIER-PAY-AMT                               24420012
244300     END-IF.                                                      24430012
244400                                                                  24440012
244500                                                                  24450012
244600 8000-EXIT.                                                       24460012
244700      EXIT.                                                       24470012
244800                                                                  24480012
244900                                                                  24490012
245000***************************************************************   24500012
245100 9000-MOVE-RESULTS.                                               24510012
245200***************************************************************   24520012
245300                                                                  24530012
245400                                                                  24540012
245500*-------------------------------------------------------------*   24550012
245600* IF CLAIM PRICED, MOVE LENGTH OF STAY & VERSION TO OUTPUT    *   24560012
245700*-------------------------------------------------------------*   24570012
245800     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE                 24580012
245900        MOVE H-LOS TO PPS-LOS                                     24590012
246000        MOVE CAL-VERSION TO PPS-CALC-VERS-CD                      24600012
246100                                                                  24610012
246200*-------------------------------------------------------------*   24620012
246300* IF CLAIM DIDN'T PRICE DUE TO AN ERROR, INITIALIZE ALL       *   24630012
246400* OUTPUT DATA EXCEPT FOR PPS-RTC AND PPS-CHRG-THRESHOLD,      *   24640012
246500* INITIALIZE WORK VARIABLES, AND MOVE VERSION TO OUTPUT       *   24650012
246600*-------------------------------------------------------------*   24660012
246700     ELSE                                                         24670012
246800       INITIALIZE PPS-DATA                                        24680012
246900       INITIALIZE PPS-OTHER-DATA                                  24690012
247000       INITIALIZE PPS-CBSA                                        24700012
247100       INITIALIZE HOLD-PPS-COMPONENTS                             24710012
247200       MOVE CAL-VERSION TO PPS-CALC-VERS-CD                       24720012
247300     END-IF.                                                      24730012
247400                                                                  24740012
247500                                                                  24750012
247600*** *************************************************** ***       24760012
247700*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***       24770012
247800*** *************************************************** ***       24780012
247900                                                                  24790012
248000*    IF (B-PROVIDER-NO = '371833'                                 24800012
248100*                    OR  '111802'                                 24810012
248200*                    OR  '011803'                                 24820012
248300*                    OR  '371804'                                 24830012
248400*                    OR  '101805'                                 24840012
248500*                    OR  '531806'                                 24850012
248600*                    OR  '141807'                                 24860012
248700*       )                                                         24870012
248800*                                                                 24880012
248900*                                                                 24890012
249000*    DISPLAY '---------------------------------------------'      24900012
249100*    DISPLAY '*********************************************'      24910012
249200*    DISPLAY '---------------------------------------------'      24920012
249300*    DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO            24930012
249400*    DISPLAY 'PPS-RTC '                  PPS-RTC                  24940012
249500*    DISPLAY 'PSF EFFECTIVE DATE '       P-NEW-EFF-DATE           24950012
249600*    DISPLAY 'CBSA EFF DATE '            W-EFF-DATE               24960012
249700*    DISPLAY 'BILL DISCHARGE DATE '      B-DISCHARGE-DATE         24970012
249800*    DISPLAY 'P-NEW-FAC-SPEC-RATE '      P-NEW-FAC-SPEC-RATE      24980012
249900*    DISPLAY 'COST REPORT DAYS '         B-CST-RPT-DAYS           24990012
250000*    DISPLAY 'WS-PRIMARY-PMT-TYPE '      WS-PRIMARY-PMT-TYPE      25000012
250100*    DISPLAY 'WS-SECONDARY-PMT-TYPE-SNT' WS-SECONDARY-PMT-TYPE-SNT25010012
250200*    DISPLAY 'WS-SECONDARY-PMT-TYPE-STD' WS-SECONDARY-PMT-TYPE-STD25020012
250300*    DISPLAY 'B-REVIEW-CODE '            B-REVIEW-CODE            25030012
250400*    DISPLAY 'B-PROCEDURE-CODE-TABLE '   B-PROCEDURE-CODE-TABLE   25040012
250500*    DISPLAY 'WS-VENT-STATUS '           WS-VENT-STATUS           25050012
250600*    DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT        25060012
250700*    DISPLAY 'PPS-SITE-NEUTRAL-COST-PM ' PPS-SITE-NEUTRAL-COST-PMT25070012
250800*    DISPLAY 'PPS-SITE-NEUTRAL-IPPS-PM ' PPS-SITE-NEUTRAL-IPPS-PMT25080012
250900*    DISPLAY 'PPS-STANDARD-FULL-PMT '    PPS-STANDARD-FULL-PMT    25090012
251000*    DISPLAY 'PPS-STANDARD-SSO-PMT '     PPS-STANDARD-SSO-PMT     25100012
251100*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE         25110012
251200*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES            25120012
251300*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT      25130012
251400*    DISPLAY 'PPS-FAC-COSTS '            PPS-FAC-COSTS            25140012
251500*    DISPLAY 'H-FIXED-LOSS-AMT-STD '     H-FIXED-LOSS-AMT-STD     25150012
251600*    DISPLAY 'H-FIXED-LOSS-AMT-SNT '     H-FIXED-LOSS-AMT-SNT     25160012
251700*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD    25170012
251800*    DISPLAY 'H-OUTLIER-THRESHOLD-STD '  H-OUTLIER-THRESHOLD-STD  25180012
251900*    DISPLAY 'PPS-CHRG-THRESHOLD '       PPS-CHRG-THRESHOLD       25190012
252000*    DISPLAY 'H-BDGT-NEUT-FACTOR '       H-BDGT-NEUT-FACTOR       25200012
252100*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT          25210012
252200*    DISPLAY 'PPS-CBSA '                 PPS-CBSA                 25220012
252300*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX           25230012
252400*    DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX        25240012
252500*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX        25250012
252600*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX     25260012
252700*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE               25270012
252800*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS              25280012
252900*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT         25290012
253000*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH             25300012
253100*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT      25310012
253200*    DISPLAY 'H-LOS '                    H-LOS                    25320012
253300*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS               25330012
253400*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS             25340012
253500*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC              25350012
253600*    DISPLAY 'H-BLEND-SNT '              H-BLEND-SNT              25360012
253700*    DISPLAY 'H-BLEND-STD '              H-BLEND-STD              25370012
253800*    DISPLAY 'P-NEW-OPER-CSTCHG-RATIO '  P-NEW-OPER-CSTCHG-RATIO  25380012
253900*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION          25390012
254000*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION       25400012
254100*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE      25410012
254200*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO              25420012
254300*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO           25430012
254400*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH         25440012
254500*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH         25450012
254600*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND            25460012
254700*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND         25470012
254800*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND           25480012
254900*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND        25490012
255000*    DISPLAY 'H-SSOT '                   H-SSOT                   25500012
255100*    DISPLAY 'H-SS-COST '                H-SS-COST                25510012
255200*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT             25520012
255300*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT         25530012
255400*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT         25540012
255500*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT         25550012
255600*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT         25560012
255700*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT         25570012
255800*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO           25580012
255900*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO         25590012
256000*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE               25600012
256100*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT           25610012
256200*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO              25620012
256300*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO         25630012
256400*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH               25640012
256500*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH               25650012
256600*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS              25660012
256700*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND              25670012
256800*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT     25680012
256900*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT  25690012
257000*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT               25700012
257100*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT            25710012
257200*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF               25720012
257300*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF            25730012
257400*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON          25740012
257500*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT           25750012
257600*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT        25760012
257700*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM          25770012
257800*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM       25780012
257900*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA              25790012
258000*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA              25800012
258100*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR     25810012
258200*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR  25820012
258300*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR      25830012
258400*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR   25840012
258500*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT           25850012
258600*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS          25860012
258700*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF       25870012
258800*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS        25880012
258900*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE 25890012
259000*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE  25900012
259100*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT  25910012
259200*                                                                 25920012
259300*    END-IF.                                                      25930012
259400                                                                  25940012
259500 9000-EXIT.                                                       25950012
259600      EXIT.                                                       25960012
259700                                                                  25970012
259800******        L A S T   S O U R C E   S T A T E M E N T   *****   25980012
