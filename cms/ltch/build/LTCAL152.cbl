000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL152.
000300*AUTHOR.         CMS.
000400*REMARKS.        EFFECTIVE OCTOBER 1, 2014.
000500**************************************************
000600* UPDATED TO APPLY CHANGES
000700* FROM THE FY 2015 LTCH PPS PRICER SPEC SHEET
000800* (EFFECTIVE 10/1/2014 THROUGH 9/30/2015,
000900* UNLESS OTHERWISE NOTED)
001000* AS OF SEPTEMBER 16, 2014
001100*
001200*
001300* PRICER RATES/FACTORS/POLICY:
001400*
001500* FEDERAL RATE:
001600*   - FULL UPDATE (QUALITY INDICATOR ON PSF = 1):
001700*      $41,043.71.
001800*   - REDUCED UPDATE (QUALITY INDICATOR ON PSF = 0 OR BLANK):
001900*      $40,240,51
002000*
002100* LABOR SHARE: 62.306%
002200*
002300* NONLABOR SHARE: 37.694%
002400*
002500* HIGH COST OUTLIER FIXED-LOSS AMOUNT: $14,972
002600* (NO PAYMENT POLICYCHANGES)
002700*
002800* NEW WAGE INDEX TABLE.
002900*
003000* NEW MS-LTC-DRG WEIGHTS/LENGTH OF STAY/IPPS
003100* COMPARABLE THRESHOLD.
003200*
003300* SHORT-STAY OUTLIERS:
003400*
003500*   - NO POLICY CHANGES.
003600*
003700*   - IPPS RATES/FACTORS:
003800*
003900*         IPPS LABOR SHARE WAGE INDEX > 1:
004000*          $3,784.75
004100*         IPPS NONLABOR SHARE WAGE INDEX > 1:
004200*          $1,653.10
004300*
004400*         IPPS LABOR SHARE WAGE INDEX < /= 1:
004500*          $3,371.47
004600*         IPPS NONLABOR SHARE WAGE INDEX < /= 1:
004700*          $2,066.38
004800*
004900*         PUERTO RICO LABOR SHARE WAGE INDEX > 1:
005000*          $1,609.97
005100*         PUERTO RICO NONLABOR SHARE WAGE INDEX > 1:
005200*          $937.45
005300*
005400*         PUERTO RICO LABOR SHARE WAGE INDEX < /= 1:
005500*          $1,579.40
005600*         PUERTO RICO NONLABOR SHARE WAGE INDEX < /= 1:
005700*          $968.02
005800*
005900*         CAPITAL NATIONAL RATE:  $434.97
006000*         CAPITAL PUERTO RICO RATE:  $209.45
006100*
006200*         IPPS WAGE INDEXES FROM TABLES 4A & 4B
006300*
006400*         "50/50" BLENDED IPPS WAGE INDEX TABLE FOR
006500*         CERTAIN LTCHS UNDER THE NEW CBSA TRANSITION
006600*         POLICY
006700*
006800*         POLICY CHANGE FOR IPPS COMPARABLE OPERATING
006900*         DSH PAYMENT AMOUNT
007000*          - REDUCE CURRENT OPERATING DSH PAYMENT
007100*            CALCULATION TO 82.14% (FACTOR OF 0.8214)
007200*            OF THE AMOUNT CALCULATED UNDER THE CURRENT
007300*            FORMULA IN THE PRICER.
007400*            THIS REDUCTION IS NOT
007500*            APPLIED TO THE CAPITAL DSH PAYMENT
007600*            CALCULATION.
007700*
007800*         NO IPPS POLICY CHANGES FOR IME (FACTOR 'C' IS
007900*          STILL 1.35)
008000*
008100*
008200**************************************************
008300 ENVIRONMENT DIVISION.
008400 CONFIGURATION SECTION.
008500 SOURCE-COMPUTER.            IBM-370.
008600 OBJECT-COMPUTER.            IBM-370.
008700 INPUT-OUTPUT  SECTION.
008800 FILE-CONTROL.
008900
009000 DATA DIVISION.
009100 FILE SECTION.
009200
009300 WORKING-STORAGE SECTION.
009400 01  W-STORAGE-REF                  PIC X(46)  VALUE
009500     'LTCAL152      - W O R K I N G   S T O R A G E'.
009600 01  CAL-VERSION                    PIC X(05)  VALUE 'V15.2'.
009700 01  PROGRAM-CONSTANTS.
009800     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
009900     05  FED-FY-BEGIN-04            PIC 9(08) VALUE 20031001.
010000     05  FED-FY-BEGIN-05            PIC 9(08) VALUE 20041001.
010100     05  FED-FY-BEGIN-06            PIC 9(08) VALUE 20051001.
010200     05  FED-FY-BEGIN-07            PIC 9(08) VALUE 20061001.
010300
010400
010500***************************************************************
010600*    LAYUP TABLE AREA FOR FY2015 LTC-DRG                      *
010700*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
010800***************************************************************
010900 COPY LTDRG152.
011000
011100
011200***************************************************************
011300*    LAYUP TABLE AREA FOR FY2015 IPPS-DRG                     *
011400*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
011500***************************************************************
011600 COPY IPDRG152.
011700
011800
011900***************************************************************
012000*    LAYUP TABLE AREA FOR FY2013 IPPS STATE SPECIFIC RFBNS    *
012100*    EFFECTIVE DATE OF OCTOBER 1, 2012 - NO TBL FOR FY 2013   *
012200***************************************************************
012300*COPY IRFBN***.
012400
012500
012600***************************************************************
012700*    LAYUP TABLE AREA FOR FY2015 IPPS COMPARABLE BLENDED      *
012800*    WAGE INDEX VALUES BY LTCH PROVIDER - ONLY FOR PROVIDERS  *
012900*    THAT RECEIVE THE BLENDED VALUE                           *
013000*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
013100***************************************************************
013200 COPY BLEND152.
013300
013400
013500***************************************************************
013600*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
013700***************************************************************
013800 01  HOLD-PPS-COMPONENTS.
013900     05  H-LOS                        PIC 9(03).
014000     05  H-REG-DAYS                   PIC 9(03).
014100     05  H-TOTAL-DAYS                 PIC 9(05).
014200     05  H-SSOT                       PIC 9(02)V9(01).
014300     05  H-BLEND-RTC                  PIC 9(02).
014400     05  H-BLEND-FAC                  PIC 9(01)V9(01).
014500     05  H-BLEND-PPS                  PIC 9(01)V9(01).
014600     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
014700     05  H-SS-COST                    PIC 9(07)V9(02).
014800     05  H-LABOR-PORTION              PIC 9(07)V9(06).
014900     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
015000     05  H-FIXED-LOSS-AMT             PIC 9(07)V9(02).
015100     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
015200     05  H-LOS-RATIO                  PIC 9(01)V9(05).
015300
015400*** --------------------------------------------------- ***
015500*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
015600*** --------------------------------------------------- ***
015700     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
015800     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
015900     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
016000     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
016100     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
016200     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
016300     05  H-INTERN-RATIO               PIC 9(01)V9(04).
016400     05  H-CAPI-IME-RATIO             PIC 9V9999.
016500     05  H-BED-SIZE                   PIC 9(05).
016600     05  H-OPER-DSH-PCT               PIC V9(04).
016700     05  H-SSI-RATIO                  PIC V9(04).
016800     05  H-MEDICAID-RATIO             PIC V9(04).
016900     05  H-OPER-DSH                   PIC 9(01)V9(04).
017000     05  H-CAPI-DSH                   PIC 9(01)V9(04).
017100     05  H-GEO-CLASS                  PIC X(01).
017200     05  H-URBAN-IND                  PIC X(01).
017300           88 URBAN-CBSA           VALUE '1'.
017400           88 RURAL-CBSA           VALUE '0'.
017500     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
017600     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
017700     05  H-CAPI-PMT                   PIC 9(07)V9(02).
017800     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
017900     05  H-CAPI-GAF                   PIC 9(05)V9(04).
018000     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
018100     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
018200     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
018300     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
018400     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
018500     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
018600     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
018700     05  H-OPER-COLA                  PIC 9(01)V9(03).
018800     05  H-CAPI-COLA                  PIC 9(01)V9(03).
018900     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
019000     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
019100     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
019200     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
019300     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
019400     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
019500     05  H-IPPS-DAYS-CUTOFF           PIC 9(02)V9(01).
019600     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
019700     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
019800     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
019900     05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
020000     05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
020100     05  H-COUNTER                    PIC 9(02).
020200     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).
020300     05  H-OPER-DSH-REDUCTION-FACTOR  PIC V9(04).
020400
020500*** --------------------------------------------------- ***
020600*** VARIABLES FOR PC PRICER                             ***
020700*** --------------------------------------------------- ***
020800     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
020900     05  H-SS-COST-IND                PIC X.
021000     05  H-SS-PERDIEM-IND             PIC X.
021100     05  H-SS-BLEND-IND               PIC X.
021200     05  H-SS-IPPSCOMP-IND            PIC X.
021300
021400
021500* 8-6-14 ADDED WK-HLDDRG-DATA AND WK-HLDDRG-DATA TO
021600* MATCH THE IPPS DRG TABLE DATA NAMES THAT WERE COPIED
021700* FROM THE FY14 IPPS PRICER CALCULATION PROGRAM
021800
021900 01 WK-HLDDRG-DATA.
022000     05  HLDDRG-DATA.
022100         10  HLDDRG-DRGX               PIC X(03).
022200         10  FILLER1                   PIC X(01).
022300         10  HLDDRG-WEIGHT             PIC 9(02)V9(04).
022400         10  FILLER2                   PIC X(01).
022500         10  HLDDRG-GMALOS             PIC 9(02)V9(01).
022600         10  FILLER3                   PIC X(05).
022700         10  HLDDRG-LOW                PIC X(01).
022800         10  FILLER5                   PIC X(01).
022900         10  HLDDRG-ARITH-ALOS         PIC 9(02)V9(01).
023000         10  FILLER6                   PIC X(02).
023100         10  HLDDRG-PAC                PIC X(01).
023200         10  FILLER7                   PIC X(01).
023300         10  HLDDRG-SPPAC              PIC X(01).
023400         10  FILLER8                   PIC X(02).
023500         10  HLDDRG-DESC               PIC X(26).
023600
023700 01 WK-HLDDRG-DATA2.
023800     05  HLDDRG-DATA2.
023900         10  HLDDRG-DRGX2               PIC X(03).
024000         10  FILLER21                   PIC X(01).
024100         10  HLDDRG-WEIGHT2             PIC 9(02)V9(04).
024200         10  FILLER22                   PIC X(01).
024300         10  HLDDRG-GMALOS2             PIC 9(02)V9(01).
024400         10  FILLER23                   PIC X(05).
024500         10  HLDDRG-LOW2                PIC X(01).
024600         10  FILLER25                   PIC X(01).
024700         10  HLDDRG-ARITH-ALOS2         PIC 9(02)V9(01).
024800         10  FILLER26                   PIC X(02).
024900         10  HLDDRG-TRANS-FLAGS.
025000                   88  D-DRG-POSTACUTE-50-50
025100                   VALUE 'Y Y'.
025200                   88  D-DRG-POSTACUTE-PERDIEM
025300                   VALUE 'Y  '.
025400             15  HLDDRG-PAC2            PIC X(01).
025500             15  FILLER27               PIC X(01).
025600             15  HLDDRG-SPPAC2          PIC X(01).
025700         10  FILLER28                   PIC X(02).
025800         10  HLDDRG-DESC2               PIC X(26).
025900         10  HLDDRG-VALID               PIC X(01).
026000
026100
026200
026300 LINKAGE SECTION.
026400**************************************************************
026500*      THIS IS THE BILL-RECORD THAT WILL BE PASSED FROM      *
026600*      THE LTDRV___ PROGRAM                                  *
026700**************************************************************
026800 01  BILL-NEW-DATA.
026900     10  B-NPI10.
027000         15  B-NPI8             PIC X(08).
027100         15  B-NPI-FILLER       PIC X(02).
027200     10  B-PROVIDER-NO          PIC X(06).
027300     10  B-PATIENT-STATUS       PIC X(02).
027400     10  B-DRG-CODE             PIC 9(03).
027500     10  B-LOS                  PIC 9(03).
027600     10  B-COV-DAYS             PIC 9(03).
027700     10  B-LTR-DAYS             PIC 9(02).
027800     10  B-DISCHARGE-DATE.
027900         15  B-DISCHG-CC        PIC 9(02).
028000         15  B-DISCHG-YY        PIC 9(02).
028100         15  B-DISCHG-MM        PIC 9(02).
028200         15  B-DISCHG-DD        PIC 9(02).
028300     10  B-COV-CHARGES          PIC 9(07)V9(02).
028400     10  B-SPEC-PAY-IND         PIC X(01).
028500     10  FILLER                 PIC X(13).
028600
028700
028800***************************************************************
028900***************************************************************
029000*                                                             *
029100*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *
029200*    AND PASSED BACK TO THE CALLING PROGRAM                   *
029300*    RETURN CODE VALUES (PPS-RTC)                             *
029400*                                                             *
029500*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
029600*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
029700*                                                             *
029800*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
029900*                                                             *
030000*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
030100*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
030200*                                                             *
030300*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
030400*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
030500*                                                             *
030600*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
030700*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
030800*                                                             *
030900*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
031000*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
031100*                                                             *
031200*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031300*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
031400*                                                             *
031500*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031600*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
031700*                                                             *
031800*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031900*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
032000*                                                             *
032100*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
032200*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
032300*                                                             *
032400*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
032500*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
032600*                                                             *
032700*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
032800*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
032900*                                                             *
033000*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
033100*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
033200*                                                             *
033300*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
033400*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
033500*                                                             *
033600*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
033700*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
033800*                                                             *
033900*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
034000*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
034100*                                                             *
034200*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
034300*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
034400*                                                             *
034500*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
034600*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
034700*                                                             *
034800*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
034900*                  WITHOUT OUTLIER                            *
035000*                                                             *
035100*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
035200*                  DIEM WITHOUT OUTLIER                       *
035300*                                                             *
035400*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
035500*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
035600*                  AMOUNT WITHOUT OUTLIER                     *
035700*                                                             *
035800*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
035900*                  DIEM WITH OUTLIER                          *
036000*                                                             *
036100*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
036200*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
036300*                  AMOUNT WITH OUTLIER                        *
036400*                                                             *
036500*                                                             *
036600*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *
036700*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *
036800*            FOR IPPS COMPARABLE PER DIEM)                    *
036900*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *
037000*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *
037100*            FOR IPPS COMPARABLE PER DIEM)                    *
037200*                                                             *
037300*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
037400*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
037500*                                                             *
037600*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
037700*                  COMPARABLE THRESHOLD WITH OUTLIER          *
037800*                                                             *
037900*                                                             *
038000*                                                             *
038100*      ****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
038200*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
038300*             51 = PROVIDER RECORD TERMINATED                 *
038400*             52 = INVALID WAGE INDEX                         *
038500*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
038600*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
038700*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
038800*                                     OR                      *
038900*                  DISCHARGE DATE < CBSA EFF START DATE       *
039000*                  FOR PPS                                    *
039100*             56 = INVALID LENGTH OF STAY                     *
039200*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
039300*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
039400*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
039500*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
039600*                  OR BILL-LTR-DAYS > 60                      *
039700*             62 = INVALID NUMBER OF COVERED DAYS             *
039800*                  OR BILL-LTR-DAYS > COVERED DAYS            *
039900*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
040000*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
040100*                  OR COST OUTLIER THRESHOLD CALCULATION      *
040200*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *
040300*             72 = INVALID BLEND INDICATOR (NOT 1 THRU 5)     *
040400*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
040500*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
040600*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *
040700*                                                             *
040800***************************************************************
040900***************************************************************
041000
041100
041200***************************************************************
041300* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
041400* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
041500***************************************************************
041600 01  PPS-DATA-ALL.
041700     05  PPS-RTC                       PIC 9(02).
041800     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
041900     05  PPS-DATA.
042000         10  PPS-MSA                   PIC X(04).
042100         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
042200         10  PPS-AVG-LOS               PIC 9(02)V9(01).
042300         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
042400         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
042500         10  PPS-LOS                   PIC 9(03).
042600         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
042700         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
042800         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
042900         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
043000         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
043100         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
043200         10  PPS-SUBM-DRG-CODE         PIC X(03).
043300         10  PPS-CALC-VERS-CD          PIC X(05).
043400         10  PPS-REG-DAYS-USED         PIC 9(03).
043500         10  PPS-LTR-DAYS-USED         PIC 9(03).
043600         10  PPS-BLEND-YEAR            PIC 9(01).
043700         10  PPS-COLA                  PIC 9(01)V9(03).
043800         10  FILLER                    PIC X(04).
043900     05  PPS-OTHER-DATA.
044000         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
044100         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
044200         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
044300         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
044400         10  PPS-IPTHRESH              PIC 9(03)V9(01).
044500         10  FILLER                    PIC X(16).
044600     05  PPS-PC-DATA.
044700         10  PPS-COT-IND               PIC X(01).
044800         10  H-PC-IND                  PIC X(02).
044900               88  PC-PRICER               VALUE 'PC'.
045000         10  FILLER                    PIC X(18).
045100
045200 01 PPS-CBSA                           PIC X(05).
045300
045400
045500******************************************************************
045600*            THESE ARE THE VERSIONS OF THE LTDRV___              *
045700*           PROGRAMS THAT WILL BE PASSED BACK----                *
045800*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
045900******************************************************************
046000 01  PRICER-OPT-VERS-SW.
046100     05  PRICER-OPTION-SW          PIC X(01).
046200         88  ALL-TABLES-PASSED          VALUE 'A'.
046300         88  PROV-RECORD-PASSED         VALUE 'P'.
046400     05  PPS-VERSIONS.
046500         10  PPDRV-VERSION         PIC X(05).
046600
046700
046800**************************************************************
046900*      THIS IS THE PROV-RECORD THAT WILL BE PASSED BY        *
047000*      THE LTCAL___ PROGRAM (FROM PROGRAM LTDRV___)          *
047100**************************************************************
047200 01  PROV-NEW-HOLD.
047300     02  PROV-NEWREC-HOLD1.
047400         05  P-NEW-NPI10.
047500             10  P-NEW-NPI8             PIC X(08).
047600             10  P-NEW-NPI-FILLER       PIC X(02).
047700         05  P-NEW-PROVIDER-NO.
047800             10  P-NEW-STATE            PIC 9(02).
047900             10  FILLER                 PIC X(04).
048000         05  P-NEW-DATE-DATA.
048100             10  P-NEW-EFF-DATE.
048200                 15  P-NEW-EFF-DT-CC    PIC 9(02).
048300                 15  P-NEW-EFF-DT-YY    PIC 9(02).
048400                 15  P-NEW-EFF-DT-MM    PIC 9(02).
048500                 15  P-NEW-EFF-DT-DD    PIC 9(02).
048600             10  P-NEW-FY-BEGIN-DATE.
048700                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).
048800                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).
048900                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).
049000                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).
049100             10  P-NEW-REPORT-DATE.
049200                 15  P-NEW-REPORT-DT-CC PIC 9(02).
049300                 15  P-NEW-REPORT-DT-YY PIC 9(02).
049400                 15  P-NEW-REPORT-DT-MM PIC 9(02).
049500                 15  P-NEW-REPORT-DT-DD PIC 9(02).
049600             10  P-NEW-TERMINATION-DATE.
049700                 15  P-NEW-TERM-DT-CC   PIC 9(02).
049800                 15  P-NEW-TERM-DT-YY   PIC 9(02).
049900                 15  P-NEW-TERM-DT-MM   PIC 9(02).
050000                 15  P-NEW-TERM-DT-DD   PIC 9(02).
050100         05  P-NEW-WAIVER-CODE          PIC X(01).
050200             88  P-NEW-WAIVER-STATE       VALUE 'Y'.
050300         05  P-NEW-INTER-NO             PIC 9(05).
050400         05  P-NEW-PROVIDER-TYPE        PIC X(02).
050500         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
050600         05  P-NEW-CURRENT-DIV   REDEFINES
050700                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
050800         05  P-NEW-MSA-DATA.
050900             10  P-NEW-CHG-CODE-INDEX       PIC X.
051000             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT.
051100             10  P-NEW-GEO-LOC-MSA9   REDEFINES
051200                             P-NEW-GEO-LOC-MSAX  PIC 9(04).
051300             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT.
051400             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT.
051500             10  P-NEW-STAND-AMT-LOC-MSA9
051600                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.
051700                 15  P-NEW-RURAL-1ST.
051800                     20  P-NEW-STAND-RURAL  PIC XX.
051900                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.
052000                 15  P-NEW-RURAL-2ND        PIC XX.
052100         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.
052200         05  P-NEW-LUGAR                    PIC X.
052300         05  P-NEW-TEMP-RELIEF-IND          PIC X.
052400         05  P-NEW-FED-PPS-BLEND-IND        PIC X.
052500         05  FILLER                         PIC X(05).
052600     02  PROV-NEWREC-HOLD2.
052700         05  P-NEW-VARIABLES.
052800             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).
052900             10  P-NEW-COLA              PIC  9(01)V9(03).
053000             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).
053100             10  P-NEW-BED-SIZE          PIC  9(05).
053200             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).
053300             10  P-NEW-CMI               PIC  9(01)V9(04).
053400             10  P-NEW-SSI-RATIO         PIC  V9(04).
053500             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).
053600             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).
053700             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).
053800             10  P-NEW-DSH-PERCENT       PIC  V9(04).
053900             10  P-NEW-FYE-DATE          PIC  X(08).
054000         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).
054100         05  P-NEW-HOSP-QUAL-IND           PIC X(01).
054200         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.
054300         05  P-NEW-GEO-LOC-CBSA9 REDEFINES
054400                       P-NEW-GEO-LOC-CBSAX PIC 9(05).
054500         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES
054600                       P-NEW-GEO-LOC-CBSAX.
054700             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.
054800             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.
054900             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.
055000             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.
055100             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.
055200         05  FILLER                        PIC X(10).
055300         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).
055400     02  PROV-NEWREC-HOLD3.
055500         05  P-NEW-PASS-AMT-DATA.
055600             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.
055700             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.
055800             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.
055900             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.
056000         05  P-NEW-CAPI-DATA.
056100             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.
056200             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.
056300             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.
056400             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.
056500             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.
056600             15  P-NEW-CAPI-NEW-HOSP       PIC X.
056700             15  P-NEW-CAPI-IME            PIC 9V9999.
056800             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.
056900             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.
057000         05  FILLER                        PIC X(18).
057100
057200
057300******************************************************************
057400*                THIS IS THE LTCH WAGE-INDEX                     *
057500*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
057600*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *
057700******************************************************************
057800 01  WAGE-NEW-INDEX-RECORD.
057900     05  W-CBSA                        PIC X(5).
058000     05  W-EFF-DATE                    PIC X(8).
058100     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).
058200     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).
058300     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).
058400
058500
058600******************************************************************
058700*                THIS IS THE IPPS WAGE-INDEX                     *
058800*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
058900******************************************************************
059000 01  WAGE-NEW-IPPS-INDEX-RECORD.
059100     05  W-CBSA-IPPS.
059200         10 CBSA-IPPS-123              PIC X(3).
059300         10 CBSA-IPPS-45               PIC X(2).
059400     05  W-CBSA-IPPS-SIZE              PIC X.
059500         88  LARGE-URBAN       VALUE 'L'.
059600         88  OTHER-URBAN       VALUE 'O'.
059700         88  ALL-RURAL         VALUE 'R'.
059800     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).
059900     05  FILLER                        PIC X.
060000     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).
060100     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).
060200
060300
060400
060500 PROCEDURE DIVISION  USING BILL-NEW-DATA
060600                           PPS-DATA-ALL
060700                           PPS-CBSA
060800                           PRICER-OPT-VERS-SW
060900                           PROV-NEW-HOLD
061000                           WAGE-NEW-INDEX-RECORD
061100                           WAGE-NEW-IPPS-INDEX-RECORD.
061200
061300
061400***************************************************************
061500*                                                             *
061600*    PROCESSING:                                              *
061700*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
061800*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
061900*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
062000*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
062100*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
062200*           GOBACK.                                           *
062300*        D. ASSEMBLE PRICING COMPONENTS.                      *
062400*        E. CALCULATE THE PRICE.                              *
062500*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
062600*                                                             *
062700***************************************************************
062800
062900
063000***************************************************************
063100 0000-MAINLINE-CONTROL.
063200***************************************************************
063300
063400     PERFORM 0100-INITIAL-ROUTINE
063500        THRU 0100-EXIT.
063600
063700     PERFORM 1000-EDIT-THE-BILL-INFO
063800        THRU 1000-EXIT.
063900
064000     IF PPS-RTC = 00
064100        PERFORM 1700-EDIT-DRG-CODE
064200           THRU 1700-EXIT.
064300
064400     IF PPS-RTC = 00
064500        PERFORM 1800-EDIT-IPPS-DRG-CODE
064600           THRU 1800-EXIT.
064700
064800     IF PPS-RTC = 00
064900        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
065000           THRU 2000-EXIT.
065100
065200     IF PPS-RTC = 00
065300        PERFORM 3000-CALC-PAYMENT
065400           THRU 3000-EXIT
065500        PERFORM 7000-CALC-OUTLIER
065600           THRU 7000-EXIT.
065700
065800     IF PPS-RTC < 50
065900        PERFORM 8000-BLEND
066000           THRU 8000-EXIT.
066100
066200     PERFORM 9000-MOVE-RESULTS
066300        THRU 9000-EXIT.
066400
066500     GOBACK.
066600
066700
066800***************************************************************
066900 0100-INITIAL-ROUTINE.
067000***************************************************************
067100
067200     MOVE ZEROS TO PPS-RTC.
067300     INITIALIZE PPS-DATA.
067400     INITIALIZE PPS-OTHER-DATA.
067500     INITIALIZE PPS-CBSA.
067600     INITIALIZE HOLD-PPS-COMPONENTS.
067700
067800     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.
067900
068000*** -----------------------------------------------------***
068100*** ADJUST IPPS WAGE INDEX BY THE STATE SPECIFIC RFBN    ***
068200*** (DISABLED 09/05/2014 V2015.1 - NO LONGER APPLIES)    ***
068300*** -----------------------------------------------------***
068400*    PERFORM 1900-APPLY-SSRFBN
068500*       THRU 1900-EXIT.
068600*
068700*    IF PPS-RTC NOT = 00
068800*       GO TO 0100-EXIT
068900*    END-IF.
069000
069100*** -----------------------------------------------------***
069200*** GET THE APPROPRIATE IPPS WAGE INDEX (NEW V2015.1)    ***
069300*** -----------------------------------------------------***
069400     PERFORM 1900-GET-IPPS-WAGE-INDEX
069500        THRU 1900-EXIT.
069600
069700     IF PPS-RTC NOT = 00
069800        GO TO 0100-EXIT
069900     END-IF.
070000
070100*** ---------------------------------------------------- ***
070200*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***
070300*** ---------------------------------------------------- ***
070400     MOVE .62306   TO PPS-NAT-LABOR-PCT.
070500     MOVE .37694   TO PPS-NAT-NONLABOR-PCT.
070600* NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
070700* REPORTING OF QUALITY DATA.
070800* - FULL UPDATE (QUALITY INDICATOR ON PSF = 1):
070900*     $40,607.31
071000* - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK):
071100*     $39808.74
071200     IF P-NEW-HOSP-QUAL-IND = '1'
071300        MOVE 41043.71 TO PPS-STD-FED-RATE
071400     ELSE
071500        MOVE 40240.51 TO PPS-STD-FED-RATE.
071600     MOVE 14972.00 TO H-FIXED-LOSS-AMT.
071700     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.
071800
071900*** ---------------------------------------------------- ***
072000*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
072100*** ---------------------------------------------------- ***
072200     MOVE 434.97 TO H-IPPS-CAPI-STD-FED-RATE.
072300     MOVE 209.45 TO H-IPPS-CAPI-STD-PR-RATE.
072400     MOVE 0.75   TO H-NAT-IPPS-PMT-PCT.
072500     MOVE 0.25   TO H-PR-IPPS-PMT-PCT.
072600
072700     IF H-IPPS-WAGE-INDEX > 1
072800        MOVE 3784.75 TO H-IPPS-NAT-LABOR-SHR
072900        MOVE 1653.10 TO H-IPPS-NAT-NONLABOR-SHR
073000     ELSE
073100        MOVE 3371.47 TO H-IPPS-NAT-LABOR-SHR
073200        MOVE 2066.38 TO H-IPPS-NAT-NONLABOR-SHR
073300     END-IF.
073400
073500     IF W-IPPS-PR-WAGE-INDEX > 1
073600        MOVE 1609.97 TO H-IPPS-PR-LABOR-SHR
073700        MOVE  937.45 TO H-IPPS-PR-NONLABOR-SHR
073800     ELSE
073900        MOVE 1579.40 TO H-IPPS-PR-LABOR-SHR
074000        MOVE  968.02 TO H-IPPS-PR-NONLABOR-SHR
074100     END-IF.
074200
074300*** ---------------------------------------------------- ***
074400*** OPERATING DSH REDUCTION FACTOR                       ***
074500*** -----------------------------------------------------***
074600     MOVE .8214 TO H-OPER-DSH-REDUCTION-FACTOR.
074700
074800 0100-EXIT.
074900      EXIT.
075000
075100
075200***************************************************************
075300*    BILL DATA EDITS - IF ANY FAIL SET PPS-RTC                *
075400*    AND DO NOT ATTEMPT TO PRICE.                             *
075500***************************************************************
075600 1000-EDIT-THE-BILL-INFO.
075700***************************************************************
075800
075900     IF (B-LOS NUMERIC) AND (B-LOS > 0)
076000        MOVE B-LOS TO H-LOS
076100     ELSE
076200        MOVE 56 TO PPS-RTC.
076300
076400     IF PPS-RTC = 00
076500       IF P-NEW-COLA NOT NUMERIC
076600          MOVE 50 TO PPS-RTC.
076700
076800     IF PPS-RTC = 00
076900       IF P-NEW-WAIVER-STATE
077000          MOVE 53 TO PPS-RTC.
077100
077200     IF PPS-RTC = 00
077300         IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
077400            (B-DISCHARGE-DATE < W-EFF-DATE))
077500            MOVE 55 TO PPS-RTC.
077600
077700     IF PPS-RTC = 00
077800         IF P-NEW-TERMINATION-DATE > 00000000
077900            IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
078000               MOVE 51 TO PPS-RTC.
078100
078200     IF PPS-RTC = 00
078300         IF B-COV-CHARGES NOT NUMERIC
078400            MOVE 58 TO PPS-RTC.
078500
078600     IF PPS-RTC = 00
078700        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
078800           MOVE 61 TO PPS-RTC.
078900
079000     IF PPS-RTC = 00
079100        IF (B-COV-DAYS NOT NUMERIC) OR
079200           (B-COV-DAYS = 0 AND H-LOS > 0)
079300           MOVE 62 TO PPS-RTC.
079400
079500     IF PPS-RTC = 00
079600        IF B-LTR-DAYS > B-COV-DAYS
079700           MOVE 62 TO PPS-RTC.
079800
079900     IF PPS-RTC = 00
080000        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
080100        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
080200
080300     IF PPS-RTC = 00
080400        PERFORM 1200-DAYS-USED
080500           THRU 1200-DAYS-USED-EXIT.
080600
080700
080800*** -----------------------------------------------------------
080900*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
081000*** -----------------------------------------------------------
081100     IF PPS-RTC = 00
081200        IF P-NEW-CAPI-IME NUMERIC
081300           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
081400        ELSE
081500           MOVE ZEROS TO H-CAPI-IME-RATIO
081600        END-IF
081700     END-IF.
081800
081900     IF PPS-RTC = 00
082000        IF P-NEW-INTERN-RATIO NUMERIC
082100           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
082200        ELSE
082300           MOVE ZEROS TO H-INTERN-RATIO
082400        END-IF
082500     END-IF.
082600
082700     IF PPS-RTC = 00
082800        IF P-NEW-BED-SIZE NUMERIC
082900           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
083000        ELSE
083100           MOVE ZEROS TO H-BED-SIZE
083200        END-IF
083300     END-IF.
083400
083500     IF PPS-RTC = 00
083600        IF P-NEW-SSI-RATIO NUMERIC
083700           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
083800        ELSE
083900           MOVE ZEROS TO H-SSI-RATIO
084000        END-IF
084100     END-IF.
084200
084300     IF PPS-RTC = 00
084400        IF P-NEW-MEDICAID-RATIO NUMERIC
084500           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
084600        ELSE
084700           MOVE ZEROS TO H-MEDICAID-RATIO
084800        END-IF
084900     END-IF.
085000
085100
085200 1000-EXIT.
085300      EXIT.
085400
085500
085600***************************************************************
085700 1200-DAYS-USED.
085800***************************************************************
085900
086000     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
086100        IF B-LTR-DAYS > H-LOS
086200           MOVE H-LOS TO PPS-LTR-DAYS-USED
086300        ELSE
086400           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
086500     ELSE
086600        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
086700           IF H-REG-DAYS > H-LOS
086800              MOVE H-LOS TO PPS-REG-DAYS-USED
086900           ELSE
087000              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
087100        ELSE
087200           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
087300              IF H-REG-DAYS > H-LOS
087400                 MOVE H-LOS TO PPS-REG-DAYS-USED
087500                 MOVE 0 TO PPS-LTR-DAYS-USED
087600              ELSE
087700                 IF H-TOTAL-DAYS > H-LOS
087800                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
087900                    COMPUTE PPS-LTR-DAYS-USED =
088000                            H-LOS - H-REG-DAYS
088100                 ELSE
088200                    IF H-TOTAL-DAYS <= H-LOS
088300                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
088400                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
088500                    ELSE
088600                       NEXT SENTENCE
088700           ELSE
088800              NEXT SENTENCE.
088900
089000 1200-DAYS-USED-EXIT.
089100      EXIT.
089200
089300
089400***************************************************************
089500*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
089600***************************************************************
089700 1700-EDIT-DRG-CODE.
089800***************************************************************
089900
090000     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
090100     IF PPS-RTC = 00
090200        SEARCH ALL WWM-ENTRY
090300           AT END
090400             MOVE 54 TO PPS-RTC
090500        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
090600             PERFORM 1750-FIND-VALUE
090700                THRU 1750-EXIT
090800        END-SEARCH.
090900
091000 1700-EXIT.
091100      EXIT.
091200
091300
091400***************************************************************
091500*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
091600***************************************************************
091700 1750-FIND-VALUE.
091800***************************************************************
091900
092000      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
092100      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
092200      MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
092300
092400 1750-EXIT.
092500      EXIT.
092600
092700
092800***************************************************************
092900*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
093000***************************************************************
093100 1800-EDIT-IPPS-DRG-CODE.
093200***************************************************************
093300
093400     IF B-DRG-CODE NOT NUMERIC
093500        MOVE 54 TO PPS-RTC
093600        GO TO 1800-EXIT
093700     END-IF.
093800
093900*THE FOLLOWING 26 OR SO LINES OF CODE WAS COPIED
094000*FROM THE FY14 IPPS PRICER LOCATED IN
094100*D29L.@BFN2699.INPATCOB.COBR140(PPCAL140)
094200*REPLACING THE CODE FROM LAST YEAR
094300*IN ORDER TO BE ABLE TO READ IN THE NEW FORMAT
094400*OF THE IPPS DRG TABLE
094500
094600     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE
094700     SET DRG-IDX TO 1
094800     SEARCH DRG-TAB VARYING DRG-IDX
094900         AT END
095000           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC
095100           MOVE 'I' TO  HLDDRG-VALID
095200       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE
095300         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.
095400
095500
095600     MOVE HLDDRG-DATA TO WK-HLDDRG-DATA2.
095700     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.
095800     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2
095900                                  H-IPPS-DRG-WGT.
096000     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2
096100                                  H-IPPS-DRG-ALOS.
096200     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.
096300     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2
096400                                  H-IPPS-ARITH-ALOS.
096500     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.
096600     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.
096700     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.
096800     MOVE  'V'                 TO HLDDRG-VALID.
096900     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.
097000
097100 1800-EXIT.
097200      EXIT.
097300
097400
097500***************************************************************
097600*    GETS THE APPROPRIATE IPPS WAGE INDEX                     *
097700*    (NEW STARTING WITH VERSION 2015.1)                       *
097800***************************************************************
097900 1900-GET-IPPS-WAGE-INDEX.
098000***************************************************************
098100
098200*-------------------------------------------------------------*
098300* GET THE IPPS WAGE INDEX ASSIGNED IN LTDRV***                *
098400* (MOVED HERE FROM 1900-APPLY-SSRFBN ON 09/05/2014 V2015.1)   *
098500*-------------------------------------------------------------*
098600     MOVE W-IPPS-WAGE-INDEX TO H-IPPS-WAGE-INDEX.
098700
098800*-------------------------------------------------------------*
098900* USE IPPS COMPARABLE BLENDED WAGE INDEX FROM TABLE IF        *
099000* PROVIDER FOUND IN TABLE - FOR FY 2015                       *
099100*-------------------------------------------------------------*
099200     SEARCH ALL IBW-ENTRY
099300        AT END
099400          CONTINUE
099500        WHEN IBW-PROV (IBW-INDX) = P-NEW-PROVIDER-NO
099600          MOVE IBW-WAGE-INDEX (IBW-INDX) TO H-IPPS-WAGE-INDEX
099700     END-SEARCH.
099800
099900*-------------------------------------------------------------*
100000* SET RETURN CODE TO 52 IF THE IPPS WAGE INDEX IS INVALID     *
100100*-------------------------------------------------------------*
100200     IF H-IPPS-WAGE-INDEX NOT NUMERIC OR
100300        H-IPPS-WAGE-INDEX NOT > 0
100400          MOVE 52 TO PPS-RTC
100500     END-IF.
100600
100700
100800 1900-EXIT.
100900      EXIT.
101000
101100
101200***************************************************************
101300*    ADJUST THE IPPS WAGE INDEX BY THE STATE SPECIFIC         *
101400*    RURAL FLOOR BUDGET NEUTRALITY FACTOR (SSRFBN)            *
101500*    (DISABLED 09/05/2014 V2015.1 - NO LONGER APPLIES)        *
101600***************************************************************
101700*1900-APPLY-SSRFBN.
101800***************************************************************
101900*
102000*    MOVE W-IPPS-WAGE-INDEX    TO H-IPPS-WAGE-INDEX.
102100*    MOVE P-NEW-STATE          TO MES-PPS-STATE.
102200*
102300*    PERFORM 1950-FIND-SSRFBN
102400*       THRU 1950-EXIT.
102500*
102600*    IF PPS-RTC = 00
102700*       IF  P-NEW-SPECIAL-PAY-IND = '1' OR '2'
102800*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =
102900*                   H-IPPS-WAGE-INDEX * 1
103000*       ELSE
103100*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =
103200*                   H-IPPS-WAGE-INDEX * MES-SSRFBN-RATE
103300*       END-IF
103400*    END-IF.
103500*
103600*1900-EXIT.
103700*     EXIT.
103800
103900
104000***************************************************************
104100*    FIND THE IPPS STATE SPECIFIC RURAL FLOOR BUDGET          *
104200*    NEUTRALITY FACTOR (SSRFBN)                               *
104300***************************************************************
104400*1950-FIND-SSRFBN.
104500***************************************************************
104600*
104700*    SET SSRFBN-IDX TO 1.
104800*    SEARCH SSRFBN-TAB VARYING SSRFBN-IDX
104900*
105000*        AT END
105100*          MOVE 68 TO PPS-RTC
105200*          GO TO 1950-EXIT
105300*
105400*        WHEN WK-SSRFBN-STATE(SSRFBN-IDX) = MES-PPS-STATE
105500*          MOVE WK-SSRFBN-REASON-ALL (SSRFBN-IDX) TO MES-SSRFBN.
105600*
105700*1950-EXIT.
105800*     EXIT.
105900
106000
106100***************************************************************
106200***  GET THE PROVIDER SPECIFIC VARIABLES AND LTCH WAGE INDEX  *
106300*                                                             *
106400*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
106500*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
106600*    OF THAT VARIABLE.                                        *
106700*                                                             *
106800***************************************************************
106900 2000-ASSEMBLE-PPS-VARIABLES.
107000***************************************************************
107100
107200
107300*------------------------------------------------------*
107400* WAGE INDEX BLEND TABLE                               *
107500*------------------------------------------------------*
107600*                                                      *
107700*  BLEND YEAR   FEDERAL FY                BLEND        *
107800*  ----------   ----------------------    -----        *
107900*      1        10/01/2002 - 09/30/2003    1/5         *
108000*      2        10/01/2003 - 09/30/2004    2/5         *
108100*      3        10/01/2004 - 09/30/2005    3/5         *
108200*      4        10/01/2005 - 09/30/2006    4/5         *
108300*      5        10/01/2006 - INDEFINITE    5/5 (FULL)  *
108400*                                                      *
108500*------------------------------------------------------*
108600*                                                      *
108700* A PROVIDER WILL RECEIVE THE APPLICABLE BLEND FOR A   *
108800* GIVEN FEDERAL FY FOR CLAIMS DISCHARGED ON & AFTER    *
108900* ITS FY BEGIN DATE THAT FALLS WITHIN THAT FEDERAL FY. *
109000*                                                      *
109100*------------------------------------------------------*
109200
109300
109400***************************************************************
109500* ASSIGN FULL (5/5) WAGE INDEX TO ALL CLAIMS DISCHARGED ON    *
109600* AND AFTER 7/1/2008 (NEW FOR VERSION 2008.0) - LTCH WAGE IDX *
109700***************************************************************
109800     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
109900        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
110000     ELSE
110100        MOVE 52 TO PPS-RTC
110200        GO TO 2000-EXIT
110300     END-IF.
110400
110500
110600***************************************************************
110700* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
110800* (ALWAYS FED-FY-BEGIN-03)                                    *
110900***************************************************************
111000      IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
111100         MOVE 74 TO PPS-RTC
111200         GO TO 2000-EXIT
111300      END-IF.
111400
111500
111600***************************************************************
111700* USE SPECIAL WAGE INDEX WHEN INDICATED - FOR LTCH WAGE INDEX *
111800* DISABLED 09/05/2014 - STARTING WITH VERSION 2015.1, THE     *
111900* SPECIAL WAGE INDEX IS ASSIGNED IN LTDRV***.                 *
112000***************************************************************
112100*    IF P-NEW-SPECIAL-PAY-IND = '1'
112200*       IF P-NEW-SPECIAL-WAGE-INDEX NUMERIC AND
112300*          P-NEW-SPECIAL-WAGE-INDEX > 0
112400*          MOVE P-NEW-SPECIAL-WAGE-INDEX TO PPS-WAGE-INDEX
112500*       ELSE
112600*          MOVE 52 TO PPS-RTC
112700*          GO TO 2000-EXIT
112800*       END-IF
112900*    END-IF.
113000
113100
113200***************************************************************
113300* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
113400***************************************************************
113500     IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
113600        MOVE 65 TO PPS-RTC.
113700
113800
113900***************************************************************
114000* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
114100***************************************************************
114200     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
114300
114400     IF PPS-BLEND-YEAR > 0 AND PPS-BLEND-YEAR < 6
114500        NEXT SENTENCE
114600     ELSE
114700        MOVE 72 TO PPS-RTC
114800        GO TO 2000-EXIT.
114900
115000     MOVE 0 TO H-BLEND-FAC.
115100     MOVE 1 TO H-BLEND-PPS.
115200     MOVE 0 TO H-BLEND-RTC.
115300
115400     IF PPS-BLEND-YEAR = 1
115500        MOVE .8 TO H-BLEND-FAC
115600        MOVE .2 TO H-BLEND-PPS
115700        MOVE 4 TO H-BLEND-RTC
115800     ELSE
115900       IF PPS-BLEND-YEAR = 2
116000          MOVE .6 TO H-BLEND-FAC
116100          MOVE .4 TO H-BLEND-PPS
116200          MOVE 8 TO H-BLEND-RTC
116300       ELSE
116400         IF PPS-BLEND-YEAR = 3
116500            MOVE .4 TO H-BLEND-FAC
116600            MOVE .6 TO H-BLEND-PPS
116700            MOVE 12 TO H-BLEND-RTC
116800         ELSE
116900           IF PPS-BLEND-YEAR = 4
117000              MOVE .2 TO H-BLEND-FAC
117100              MOVE .8 TO H-BLEND-PPS
117200              MOVE 16 TO H-BLEND-RTC.
117300
117400 2000-EXIT.
117500      EXIT.
117600
117700
117800***************************************************************
117900*    IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)           *
118000*        CALCULATE THE STANDARD PAYMENT AMOUNT.               *
118100*        CALCULATE THE SHORT-STAY OUTLIER AMOUNT.             *
118200***************************************************************
118300 3000-CALC-PAYMENT.
118400***************************************************************
118500
118600*** -------------------------------------------------- ***
118700*** FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII) ***
118800*** -------------------------------------------------- ***
118900     IF (P-NEW-STATE = 02 OR 12)
119000        MOVE P-NEW-COLA TO PPS-COLA
119100     ELSE
119200        MOVE 1.000 TO PPS-COLA
119300     END-IF.
119400
119500
119600     COMPUTE PPS-FAC-COSTS ROUNDED =
119700         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
119800
119900     COMPUTE H-LABOR-PORTION ROUNDED =
120000         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
120100          * PPS-WAGE-INDEX.
120200
120300     COMPUTE H-NONLABOR-PORTION ROUNDED =
120400         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
120500          * PPS-COLA.
120600
120700     COMPUTE PPS-FED-PAY-AMT ROUNDED =
120800         (H-LABOR-PORTION + H-NONLABOR-PORTION).
120900
121000     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
121100         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
121200
121300
121400*** -------------------------------------------------------- ***
121500*** FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY ***
121600*** -------------------------------------------------------- ***
121700     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
121800
121900*** --------------------------------------------- ***
122000*** DETERMINE WHETHER THE CLAIM IS A SHORT STAY   ***
122100*** --------------------------------------------- ***
122200*** H-SSOT ROUNDED AND EXPANDED TO 1 DECIMAL      ***
122300*** PLACE FOR RELEASE 07.1                        ***
122400*** --------------------------------------------- ***
122500     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
122600     IF H-LOS <= H-SSOT
122700        PERFORM 3400-SHORT-STAY
122800           THRU 3400-SHORT-STAY-EXIT.
122900
123000 3000-EXIT.
123100      EXIT.
123200
123300
123400***************************************************************
123500*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
123600*      OF THE AVG. LENGTH OF STAY THEN:                       *
123700*      - CALCULATE THE SHORT-STAY COST.                       *
123800*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *
123900*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *
124000*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *
124100*      - PAY THE LEAST OF:                                    *
124200*          1)SHORT STAY COST                                  *
124300*          2)SHORT STAY PAYMENT AMOUNT                        *
124400*          3)DRG ADJUSTED PAYMENT AMOUNT                      *
124500*          4)SHORT STAY BLENDED PAYMENT -OR-                  *
124600*          5)IPPS COMPARABLE AMOUNT                           *
124700*      - SET RETURN CODE TO INDICATE SHORT STAY PAYMENT TYPE  *
124800***************************************************************
124900
125000 3400-SHORT-STAY.
125100**************************************************************
125200*   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *
125300**************************************************************
125400     IF P-NEW-PROVIDER-NO = '332006'
125500        PERFORM 4000-SPECIAL-PROVIDER
125600           THRU 4000-SPECIAL-PROVIDER-EXIT
125700     ELSE
125800
125900**************************************************************
126000*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *
126100* ---------------------------------------------------------- *
126200*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *
126300**************************************************************
126400        MOVE PPS-FAC-COSTS TO H-SS-COST
126500
126600**************************************************************
126700*                                                            *
126800*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *
126900* ---------------------------------------------------------- *
127000*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *
127100*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *
127200*     THE LENGTH OF STAY IS CORRECT                          *
127300*                                                            *
127400**************************************************************
127500        COMPUTE H-SS-PAY-AMT ROUNDED =
127600         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
127700
127800**************************************************************
127900*                                                            *
128000*   SHORT STAY PROVISION #4 (BLEND OF SS PMT & IPPS          *
128100*   COMPARABLE PER DIEM AMT)                                 *
128200* ---------------------------------------------------------- *
128300*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
128400*   REMOVED FROM VERSION 09.0 BECAUSE CLAIMS DISCHARGED ON   *
128500*   AND AFTER 12/29/2008 ARE NOT ELIGIBLE FOR PROVISION #5.  *
128600*                                                            *
128700*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
128800*   ADDED TO VERSION 13.0 BECAUSE CLAIMS DISCHARGED ON AND   *
128900*   AFTER 12/29/2012 ARE ELIGIBLE FOR PROVISION #5.          *
129000*                                                            *
129100**************************************************************
129200        IF H-IPPS-WAGE-INDEX NUMERIC AND
129300           H-IPPS-WAGE-INDEX > 0
129400*---------------------------------------------------------
129500*   #4 - CALCULATE BLENDED PAYMENT
129600*---------------------------------------------------------
129700           IF B-DISCHARGE-DATE >= 20121229
129800              IF H-LOS > PPS-IPTHRESH
129900                 PERFORM 3600-SS-BLENDED-PMT
130000                    THRU 3600-SS-BLENDED-PMT-EXIT
130100               ELSE
130200*---------------------------------------------------------
130300*   #5 - LOS (COVERED DAYS) <= IPPS COMPARABLE THRESHOLD
130400*        CALCULATE IPPS COMPARABLE PER DIEM AMT ONLY
130500*---------------------------------------------------------
130600                  PERFORM 3650-SS-IPPS-COMP-PMT
130700                     THRU 3650-SS-IPPS-COMP-PMT-EXIT
130800           ELSE
130900               PERFORM 3600-SS-BLENDED-PMT
131000                  THRU 3600-SS-BLENDED-PMT-EXIT
131100        ELSE
131200           MOVE 52 TO PPS-RTC
131300           GO TO 3400-SHORT-STAY-EXIT.
131400
131500**************************************************************
131600*                                                            *
131700*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *
131800*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *
131900* ---------------------------------------------------------- *
132000*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *
132100*                                                            *
132200**************************************************************
132300
132400     MOVE 'N' TO H-SS-COST-IND.
132500     MOVE 'N' TO H-SS-PERDIEM-IND.
132600     MOVE 'N' TO H-SS-BLEND-IND.
132700     MOVE 'N' TO H-SS-IPPSCOMP-IND.
132800
132900*---------------------------------------------------------
133000*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%
133100*   OF PER DIEM) AND DRG ADJUSTED PMT AMT
133200*---------------------------------------------------------
133300     IF H-SS-COST < H-SS-PAY-AMT
133400        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT
133500           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT
133600           MOVE 20 TO PPS-RTC
133700           MOVE 'Y' TO H-SS-COST-IND
133800        ELSE
133900           NEXT SENTENCE
134000        END-IF
134100     ELSE
134200        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT
134300           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT
134400           MOVE 21 TO PPS-RTC
134500           MOVE 'Y' TO H-SS-PERDIEM-IND
134600        ELSE
134700           NEXT SENTENCE
134800        END-IF
134900     END-IF.
135000
135100*---------------------------------------------------------
135200*   USE THE BLENDED PMT OR IPPS COMPARABLE AMT IF LESS
135300*   THAN THE OTHER OPTIONS
135400*---------------------------------------------------------
135500     IF P-NEW-PROVIDER-NO NOT = '332006'
135600*---------------------------------------------------------
135700*   COMPARE BLENDED PAYMENT
135800*---------------------------------------------------------
135900         IF B-DISCHARGE-DATE >= 20121229 AND
136000           H-LOS > PPS-IPTHRESH AND
136100           H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
136200               MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
136300               MOVE 22 TO PPS-RTC
136400               MOVE 'Y' TO H-SS-BLEND-IND
136500               MOVE 'N' TO H-SS-COST-IND
136600               MOVE 'N' TO H-SS-PERDIEM-IND
136700               MOVE 'N' TO H-SS-IPPSCOMP-IND
136800         ELSE
136900*---------------------------------------------------------
137000*   COMPARE IPPS COMPARABLE PER DIEM AMOUNT
137100*---------------------------------------------------------
137200             IF B-DISCHARGE-DATE >= 20121229 AND
137300               H-LOS <= PPS-IPTHRESH AND
137400               H-IPPS-PER-DIEM <= PPS-DRG-ADJ-PAY-AMT
137500                 MOVE H-IPPS-PER-DIEM TO PPS-DRG-ADJ-PAY-AMT
137600                 MOVE 26 TO PPS-RTC
137700                 MOVE 'Y' TO H-SS-IPPSCOMP-IND
137800                 MOVE 'N' TO H-SS-BLEND-IND
137900                 MOVE 'N' TO H-SS-COST-IND
138000                 MOVE 'N' TO H-SS-PERDIEM-IND
138100             ELSE
138200                 IF B-DISCHARGE-DATE < 20121229 AND
138300                   H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
138400                     MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
138500                     MOVE 22 TO PPS-RTC
138600                     MOVE 'Y' TO H-SS-BLEND-IND
138700                     MOVE 'N' TO H-SS-COST-IND
138800                     MOVE 'N' TO H-SS-PERDIEM-IND
138900                     MOVE 'N' TO H-SS-IPPSCOMP-IND
139000                 END-IF
139100             END-IF
139200         END-IF
139300     END-IF.
139400
139500 3400-SHORT-STAY-EXIT.
139600      EXIT.
139700
139800
139900***************************************************************
140000*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
140100*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
140200*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
140300*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
140400***************************************************************
140500 3600-SS-BLENDED-PMT.
140600***************************************************************
140700
140800*** ------------------------------------------------------ ***
140900*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
141000*** ------------------------------------------------------ ***
141100     IF H-SSOT < 25
141200        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
141300          H-LOS / H-SSOT
141400     ELSE
141500        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
141600          H-LOS / 25
141700     END-IF.
141800
141900     IF H-LTCH-BLEND-PCT > 1
142000        MOVE 1 TO H-LTCH-BLEND-PCT
142100     END-IF.
142200
142300
142400*** ------------------------------------------------------ ***
142500*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
142600*** ------------------------------------------------------ ***
142700     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
142800        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
142900
143000
143100*** ------------------------------------------------------ ***
143200*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
143300*** ------------------------------------------------------ ***
143400     PERFORM 3650-SS-IPPS-COMP-PMT
143500        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
143600
143700
143800*** ------------------------------------------------------ ***
143900*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
144000*** ------------------------------------------------------ ***
144100     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
144200       1 - H-LTCH-BLEND-PCT.
144300
144400
144500*** ------------------------------------------------------ ***
144600*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
144700*** ------------------------------------------------------ ***
144800     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
144900       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
145000
145100
145200*** ------------------------------------------------------ ***
145300*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
145400*** ------------------------------------------------------ ***
145500     COMPUTE H-SS-BLENDED-PMT ROUNDED =
145600       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
145700
145800
145900 3600-SS-BLENDED-PMT-EXIT.
146000      EXIT.
146100
146200
146300***************************************************************
146400*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
146500*   PER DIEM PAYMENT AMOUNT                                   *
146600***************************************************************
146700 3650-SS-IPPS-COMP-PMT.
146800***************************************************************
146900
147000*** -------------------------------------------------------
147100*** OPERATING TEACHING ADJUSTMENT
147200*** -------------------------------------------------------
147300     COMPUTE H-OPER-IME-TEACH ROUNDED =
147400        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
147500
147600
147700*** -------------------------------------------------------
147800*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
147900*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%
148000*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL
148100***              THIS CHANGE IS RETROACTIVE TO 10/01/2008
148200*** -------------------------------------------------------
148300     IF H-CAPI-IME-RATIO > 1.5000
148400        MOVE 1.5000 TO H-CAPI-IME-RATIO.
148500
148600     COMPUTE H-CAPI-IME-TEACH ROUNDED =
148700        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).
148800
148900
149000*** -------------------------------------------------------
149100*** OPERATING DSH ADJUSTMENT
149200*** -------------------------------------------------------
149300
149400*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
149500*---------------------------------------------------
149600     IF ALL-RURAL
149700        SET RURAL-CBSA TO TRUE
149800     ELSE
149900        SET URBAN-CBSA TO TRUE
150000     END-IF.
150100
150200
150300*2) CALCULATE THE OPERATING DSH PERCENT
150400*--------------------------------------
150500     COMPUTE H-OPER-DSH-PCT ROUNDED =
150600        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
150700
150800
150900*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
151000*-----------------------------------------------------
151100
151200*    URBAN, < 100 BEDS
151300*    -----------------
151400     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
151500        H-OPER-DSH-PCT >= .15
151600          MOVE '3' TO H-GEO-CLASS
151700     ELSE
151800
151900
152000*   URBAN, >= 100 BEDS
152100*   ------------------
152200       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
152300          H-OPER-DSH-PCT >= .15
152400            MOVE '2' TO H-GEO-CLASS
152500       ELSE
152600
152700
152800*   RURAL, >= 500 BEDS
152900*   ------------------
153000         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
153100            H-OPER-DSH-PCT >= .15
153200              MOVE '2' TO H-GEO-CLASS
153300         ELSE
153400
153500
153600*   RURAL, < 500 BEDS
153700*   -----------------
153800           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
153900              H-OPER-DSH-PCT >= .15
154000                MOVE '3' TO H-GEO-CLASS
154100           ELSE
154200
154300
154400*   OTHER
154500*   -----------------
154600              MOVE '4' TO H-GEO-CLASS
154700
154800           END-IF
154900         END-IF
155000       END-IF
155100     END-IF.
155200
155300
155400*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
155500*-----------------------------------------------------------
155600     EVALUATE H-GEO-CLASS
155700
155800*      GEOGRAPHIC CLASS 2
155900*      ------------------
156000       WHEN '2'
156100          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
156200             COMPUTE H-OPER-DSH ROUNDED =
156300               ((H-OPER-DSH-PCT - .15) * .65) + .025
156400          ELSE
156500             IF H-OPER-DSH-PCT > .202
156600                COMPUTE H-OPER-DSH ROUNDED =
156700                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
156800             ELSE
156900                MOVE ZEROS TO H-OPER-DSH
157000             END-IF
157100          END-IF
157200
157300*      GEOGRAPHIC CLASS 3
157400*      ------------------
157500       WHEN '3'
157600          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
157700             COMPUTE H-OPER-DSH ROUNDED =
157800               ((H-OPER-DSH-PCT - .15) * .65) + .025
157900             IF H-OPER-DSH > .12
158000                MOVE .12 TO H-OPER-DSH
158100             END-IF
158200          ELSE
158300             IF H-OPER-DSH-PCT > .202
158400                COMPUTE H-OPER-DSH ROUNDED =
158500                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
158600                IF H-OPER-DSH > .12
158700                   MOVE .12 TO H-OPER-DSH
158800                END-IF
158900             ELSE
159000               MOVE ZEROS TO H-OPER-DSH
159100             END-IF
159200          END-IF
159300
159400*      GEOGRAPHIC CLASS 4
159500*      ------------------
159600       WHEN '4'
159700          MOVE ZEROS TO H-OPER-DSH
159800
159900     END-EVALUATE.
160000
160100
160200*** -------------------------------------------------------
160300*** CURRENT OPERATING DSH PAYMENT REDUCTION
160400*** -------------------------------------------------------
160500     COMPUTE H-OPER-DSH ROUNDED =
160600             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.
160700
160800*** -------------------------------------------------------
160900*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
161000*** -------------------------------------------------------
161100     IF URBAN-CBSA AND H-BED-SIZE >= 100
161200        COMPUTE H-CAPI-DSH ROUNDED =
161300          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
161400     ELSE
161500        MOVE ZEROS TO H-CAPI-DSH
161600     END-IF.
161700
161800
161900*** -------------------------------------------------------
162000*** OPERATING PAYMENT (STANDARD AMOUNT)
162100*** -------------------------------------------------------
162200     IF (P-NEW-STATE = 02 OR 12)
162300        MOVE P-NEW-COLA TO H-OPER-COLA
162400     ELSE
162500        MOVE 1.000 TO H-OPER-COLA
162600     END-IF.
162700
162800     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
162900       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +
163000         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
163100         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
163200
163300
163400*** -------------------------------------------------------
163500*** CAPITAL PAYMENT (CAPITAL RATE)
163600*** -------------------------------------------------------
163700     COMPUTE H-CAPI-COLA ROUNDED =
163800       (.3152 * (H-OPER-COLA - 1) + 1).
163900
164000*--------------------------------------------------------------*
164100*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
164200*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
164300*--------------------------------------------------------------*
164400     IF LARGE-URBAN
164500        MOVE 1.00 TO H-LRGURB-ADD-ON
164600     ELSE
164700        MOVE 1.00 TO H-LRGURB-ADD-ON
164800     END-IF.
164900
165000     COMPUTE H-CAPI-GAF ROUNDED =
165100       (H-IPPS-WAGE-INDEX ** .6848).
165200
165300     COMPUTE H-CAPI-PMT ROUNDED =
165400       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
165500       H-LRGURB-ADD-ON *  H-CAPI-COLA *
165600       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
165700
165800
165900*** -------------------------------------------------------
166000*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
166100*** -------------------------------------------------------
166200     COMPUTE H-IPPS-PAY-AMT ROUNDED =
166300       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
166400
166500
166600*** -------------------------------------------------------
166700*** IPPS COMPARABLE PER DIEM PAYMENT
166800*** -------------------------------------------------------
166900     COMPUTE H-IPPS-PER-DIEM ROUNDED =
167000       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
167100
167200     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
167300        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
167400     END-IF.
167500
167600*** -------------------------------------------------------
167700*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
167800*** -------------------------------------------------------
167900     IF P-NEW-STATE = 40
168000        PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT
168100     END-IF.
168200
168300
168400 3650-SS-IPPS-COMP-PMT-EXIT.
168500      EXIT.
168600
168700
168800***************************************************************
168900 3675-SS-IPPS-COMP-PR-PMT.
169000***************************************************************
169100
169200*** -------------------------------------------------------
169300*** PUERTO RICO OPERATING PAYMENT (STANDARD AMOUNT)
169400*** -------------------------------------------------------
169500     COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =
169600        ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +
169700          (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *
169800          H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
169900
170000
170100*** -------------------------------------------------------
170200*** PUERTO RICO CAPITAL PAYMENT (CAPITAL RATE)
170300*** -------------------------------------------------------
170400     COMPUTE H-PR-CAPI-GAF ROUNDED =
170500        (W-IPPS-PR-WAGE-INDEX ** .6848).
170600
170700     COMPUTE H-PR-CAPI-PMT ROUNDED =
170800        H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *
170900        H-LRGURB-ADD-ON * H-CAPI-COLA *
171000        (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
171100
171200
171300*** -------------------------------------------------------
171400*** PR IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
171500*** -------------------------------------------------------
171600     COMPUTE H-IPPS-PR-PAY-AMT ROUNDED =
171700        H-PR-STAND-AMT-OPER-PMT + H-PR-CAPI-PMT.
171800
171900
172000*** -------------------------------------------------------
172100*** PUERTO RICO IPPS COMPARABLE PER DIEM PAYMENT
172200*** -------------------------------------------------------
172300     COMPUTE H-IPPS-PR-PER-DIEM ROUNDED =
172400        (H-IPPS-PR-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
172500
172600     IF H-IPPS-PR-PER-DIEM > H-IPPS-PR-PAY-AMT
172700        MOVE H-IPPS-PR-PAY-AMT TO H-IPPS-PR-PER-DIEM
172800     END-IF.
172900
173000
173100*** -------------------------------------------------------
173200*** BLEND FEDERAL PER DIEM AND PUERTO RICO PER DIEM
173300*** -------------------------------------------------------
173400     COMPUTE H-IPPS-PER-DIEM ROUNDED =
173500        (H-IPPS-PER-DIEM    * H-NAT-IPPS-PMT-PCT) +
173600        (H-IPPS-PR-PER-DIEM * H-PR-IPPS-PMT-PCT ).
173700
173800
173900 3675-EXIT.
174000      EXIT.
174100
174200
174300***************************************************************
174400 4000-SPECIAL-PROVIDER.
174500***************************************************************
174600
174700*** PROCESS FOR CY2003
174800*** ------------------
174900     IF (B-DISCHARGE-DATE >= 20030701) AND
175000        (B-DISCHARGE-DATE <  20040101)
175100        COMPUTE H-SS-COST ROUNDED =
175200            (PPS-FAC-COSTS * 1.95)
175300        COMPUTE H-SS-PAY-AMT ROUNDED =
175400         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
175500     END-IF
175600
175700
175800*** PROCESS FOR CY2004
175900*** ------------------
176000     IF (B-DISCHARGE-DATE >= 20040101) AND
176100        (B-DISCHARGE-DATE <  20050101)
176200        COMPUTE H-SS-COST ROUNDED =
176300            (PPS-FAC-COSTS * 1.93)
176400        COMPUTE H-SS-PAY-AMT ROUNDED =
176500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
176600     END-IF
176700
176800
176900*** PROCESS FOR CY2005
177000*** ------------------
177100     IF (B-DISCHARGE-DATE >= 20050101) AND
177200        (B-DISCHARGE-DATE <  20060101)
177300        COMPUTE H-SS-COST ROUNDED =
177400            (PPS-FAC-COSTS * 1.65)
177500        COMPUTE H-SS-PAY-AMT ROUNDED =
177600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
177700     END-IF
177800
177900
178000*** PROCESS FOR CY2006
178100*** ------------------
178200     IF (B-DISCHARGE-DATE >= 20060101) AND
178300        (B-DISCHARGE-DATE <  20070101)
178400        COMPUTE H-SS-COST ROUNDED =
178500            (PPS-FAC-COSTS * 1.36)
178600        COMPUTE H-SS-PAY-AMT ROUNDED =
178700          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
178800     END-IF
178900
179000
179100*** PROCESS FOR CY2007 AND AFTER
179200*** ----------------------------
179300     IF (B-DISCHARGE-DATE >= 20070101)
179400        COMPUTE H-SS-COST ROUNDED =
179500            (PPS-FAC-COSTS * 1.2)
179600        COMPUTE H-SS-PAY-AMT ROUNDED =
179700          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
179800     END-IF.
179900
180000 4000-SPECIAL-PROVIDER-EXIT.
180100      EXIT.
180200
180300
180400***************************************************************
180500*   CALCULATE THE OUTLIER THRESHOLD                           *
180600*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
180700*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
180800*   SET RETURN CODE TO INDICATE OUTLIER PAYMENT METHOD        *
180900***************************************************************
181000 7000-CALC-OUTLIER.
181100***************************************************************
181200
181300     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
181400         PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT.
181500
181600     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
181700        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
181800         ((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
181900           * PPS-BDGT-NEUT-RATE * H-BLEND-PPS.
182000
182100     IF B-SPEC-PAY-IND = '1'
182200        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
182300
182400     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 21
182500        MOVE 24 TO PPS-RTC.
182600
182700     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 22
182800        MOVE 25 TO PPS-RTC.
182900
183000     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 26
183100        MOVE 27 TO PPS-RTC.
183200
183300     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 00
183400        MOVE 01 TO PPS-RTC.
183500
183600     IF (PPS-RTC = 00 OR 20 OR 21 OR 22 OR 26)
183700        IF PPS-REG-DAYS-USED > H-SSOT
183800           MOVE 0 TO PPS-LTR-DAYS-USED
183900        ELSE
184000           NEXT SENTENCE.
184100
184200     IF (PPS-RTC = 01 OR 24 OR 25 OR 27) OR
184300        (PPS-COT-IND = 'Y')
184400
184500        IF (B-COV-DAYS < H-LOS) OR
184600           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
184700           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
184800             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
184900
185000*** ------------------------------------------------------- ***
185100*** SET PPS-RTC TO 67 IN MAINFRAME PRICER, NOT IN PC PRICER ***
185200*** (IN PC PRICER, PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS)   ***
185300*** ------------------------------------------------------- ***
185400           IF NOT PC-PRICER
185500              MOVE 67 TO PPS-RTC
185600           END-IF
185700
185800        ELSE
185900           NEXT SENTENCE
186000        END-IF
186100     ELSE
186200        NEXT SENTENCE
186300     END-IF.
186400
186500
186600 7000-EXIT.
186700      EXIT.
186800
186900
187000***************************************************************
187100*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
187200*   SET RTC FOR SPECIFIED BLEND YEAR INDICATOR.               *
187300***************************************************************
187400 8000-BLEND.
187500***************************************************************
187600
187700     COMPUTE H-LOS-RATIO ROUNDED = H-LOS / PPS-AVG-LOS.
187800
187900     IF H-LOS-RATIO > 1
188000        COMPUTE H-LOS-RATIO = ((H-LOS-RATIO - 1) * .8) + 1.
188100
188200     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
188300           (PPS-DRG-ADJ-PAY-AMT * PPS-BDGT-NEUT-RATE)
188400             * H-BLEND-PPS.
188500
188600     COMPUTE PPS-NEW-FAC-SPEC-RATE ROUNDED =
188700            (P-NEW-FAC-SPEC-RATE * PPS-BDGT-NEUT-RATE)
188800              * H-BLEND-FAC * H-LOS-RATIO.
188900
189000     COMPUTE PPS-FINAL-PAY-AMT =
189100          PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
189200              + PPS-NEW-FAC-SPEC-RATE.
189300
189400
189500*----------------------------------------------------------*
189600* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/O OUTLIER *
189700*----------------------------------------------------------*
189800     IF (PPS-RTC = 20 OR 21 OR 22 OR 26) AND (H-BLEND-RTC > 0)
189900          COMPUTE PPS-RTC = H-BLEND-RTC + 2
190000
190100*----------------------------------------------------------*
190200* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/ OUTLIER  *
190300*----------------------------------------------------------*
190400     ELSE
190500        IF (PPS-RTC = 24 OR 25 OR 27) AND (H-BLEND-RTC > 0)
190600           COMPUTE PPS-RTC = H-BLEND-RTC + 3
190700
190800*----------------------------------------------------------*
190900* CALCULATE RETURN CODE FOR ALL OTHER BILLS                *
191000*----------------------------------------------------------*
191100        ELSE
191200           ADD H-BLEND-RTC TO PPS-RTC
191300
191400        END-IF
191500     END-IF.
191600
191700 8000-EXIT.
191800      EXIT.
191900
192000
192100***************************************************************
192200 9000-MOVE-RESULTS.
192300***************************************************************
192400
192500     IF PPS-RTC < 50
192600        MOVE H-LOS TO PPS-LOS
192700        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
192800     ELSE
192900       INITIALIZE PPS-DATA
193000       INITIALIZE PPS-OTHER-DATA
193100
193200*** ----------------------------------- ***
193300*** ADDED FOR JULY 2006 RELEASE (V07.1) ***
193400*** ----------------------------------- ***
193500       INITIALIZE PPS-CBSA
193600       INITIALIZE HOLD-PPS-COMPONENTS
193700
193800       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
193900     END-IF.
194000
194100*** *************************************************** ***
194200*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***
194300*** *************************************************** ***
194400*
194500*    IF (B-PROVIDER-NO = '341501' OR
194600*                        '341502' OR
194700*                        '342015' OR
194800*                        '391504' OR
194900*                        '391505' OR
195000*                        '371506' OR
195100*                        '371507' OR
195200*                        '441508' OR
195300*                        '442006' OR
195400*                        '36150A' OR
195500*                        '36150B' OR
195600*                        '37150C' OR
195700*                        '37150D' OR
195800*                        '02150E' OR
195900*                        '332006' OR
196000*                        '311501' OR
196100*                        '391502' OR
196200*                        '671503' OR
196300*                        '361504' OR
196400*                        '39150L' OR
196500*                        '051506' OR
196600*                        '091508' OR
196700*                        '401507')
196800*
196900*    DISPLAY '---------------------------------------------'
197000*    DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
197100*    DISPLAY 'PPS-RTC '                  PPS-RTC
197200*    DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT
197300*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
197400*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
197500*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
197600*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
197700*    DISPLAY 'PPS-CBSA '                 PPS-CBSA
197800*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
197900*    DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
198000*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
198100*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
198200*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
198300*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE
198400*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
198500*    DISPLAY 'H-SSOT '                   H-SSOT
198600*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
198700*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
198800*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
198900*    DISPLAY 'H-LOS '                    H-LOS
199000*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS
199100*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
199200*    DISPLAY 'H-SSOT '                   H-SSOT
199300*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
199400*    DISPLAY 'H-BLEND-FAC '              H-BLEND-FAC
199500*    DISPLAY 'H-BLEND-PPS '              H-BLEND-PPS
199600*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
199700*    DISPLAY 'P-NEW-OPER-CSTCHG-RATIO '  P-NEW-OPER-CSTCHG-RATIO
199800*    DISPLAY 'H-SS-COST '                H-SS-COST
199900*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
200000*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
200100*    DISPLAY 'H-FIXED-LOSS-AMT '         H-FIXED-LOSS-AMT
200200*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
200300*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
200400*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
200500*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
200600*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
200700*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
200800*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
200900*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
201000*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
201100*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
201200*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
201300*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE
201400*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
201500*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
201600*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
201700*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
201800*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
201900*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
202000*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND
202100*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
202200*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
202300*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
202400*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
202500*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
202600*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
202700*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
202800*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
202900*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
203000*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
203100*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
203200*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
203300*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
203400*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
203500*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
203600*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
203700*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
203800*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
203900*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
204000*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
204100*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
204200*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
204300*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
204400*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
204500*    DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT
204600*    DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT
204700*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
204800*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
204900*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
205000*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
205100*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
205200*
205300*    END-IF.
205400
205500 9000-EXIT.
205600      EXIT.
205700
205800******        L A S T   S O U R C E   S T A T E M E N T   *****
