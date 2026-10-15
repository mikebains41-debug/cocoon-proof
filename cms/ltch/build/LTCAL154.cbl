000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL154.
000300*AUTHOR.         CMS.
000400*REMARKS.        EFFECTIVE JANUARY 1, 2015.
000500**************************************************
000600* UPDATED 12/10/15 DUE TO CHANGE REQUEST 9401 IN ORDER TO
000700* IMPLEMENT CHANGES NECESSARY TO OPERATIONALLY PROCESS THE
000800* CLAIMS OF A SUBCLAUSE (II) LTCH IN A MANNER THAT IS
000900* GENERALLY CONSISTENT WITH THE CLAIMS PROCESSING OF NON-
001000* PROSPECTIVE PAYMENT HOSPITALS EFFECTIVE JANUARY 1, 2015
001100*
001200* INCLUDES VALUES
001300* FROM THE FY 2015 LTCH PPS PRICER SPEC SHEET
001400* (EFFECTIVE 10/1/2014 THROUGH 9/30/2015,
001500* UNLESS OTHERWISE NOTED)
001600* AS OF SEPTEMBER 16, 2014
001700*
001800*
001900* PRICER RATES/FACTORS/POLICY:
002000*
002100* FEDERAL RATE:
002200*   - FULL UPDATE (QUALITY INDICATOR ON PSF = 1):
002300*      $41,043.71.
002400*   - REDUCED UPDATE (QUALITY INDICATOR ON PSF = 0 OR BLANK):
002500*      $40,240,51
002600*
002700* LABOR SHARE: 62.306%
002800*
002900* NONLABOR SHARE: 37.694%
003000*
003100* HIGH COST OUTLIER FIXED-LOSS AMOUNT: $14,972
003200* (NO PAYMENT POLICYCHANGES)
003300*
003400* NEW WAGE INDEX TABLE.
003500*
003600* NEW MS-LTC-DRG WEIGHTS/LENGTH OF STAY/IPPS
003700* COMPARABLE THRESHOLD.
003800*
003900* SHORT-STAY OUTLIERS:
004000*
004100*   - NO POLICY CHANGES.
004200*
004300*   - IPPS RATES/FACTORS:
004400*
004500*         IPPS LABOR SHARE WAGE INDEX > 1:
004600*          $3,784.75
004700*         IPPS NONLABOR SHARE WAGE INDEX > 1:
004800*          $1,653.10
004900*
005000*         IPPS LABOR SHARE WAGE INDEX < /= 1:
005100*          $3,371.47
005200*         IPPS NONLABOR SHARE WAGE INDEX < /= 1:
005300*          $2,066.38
005400*
005500*         PUERTO RICO LABOR SHARE WAGE INDEX > 1:
005600*          $1,609.97
005700*         PUERTO RICO NONLABOR SHARE WAGE INDEX > 1:
005800*          $937.45
005900*
006000*         PUERTO RICO LABOR SHARE WAGE INDEX < /= 1:
006100*          $1,579.40
006200*         PUERTO RICO NONLABOR SHARE WAGE INDEX < /= 1:
006300*          $968.02
006400*
006500*         CAPITAL NATIONAL RATE:  $434.97
006600*         CAPITAL PUERTO RICO RATE:  $209.45
006700*
006800*         IPPS WAGE INDEXES FROM TABLES 4A & 4B
006900*
007000*         "50/50" BLENDED IPPS WAGE INDEX TABLE FOR
007100*         CERTAIN LTCHS UNDER THE NEW CBSA TRANSITION
007200*         POLICY
007300*
007400*         POLICY CHANGE FOR IPPS COMPARABLE OPERATING
007500*         DSH PAYMENT AMOUNT
007600*          - REDUCE CURRENT OPERATING DSH PAYMENT
007700*            CALCULATION TO 82.14% (FACTOR OF 0.8214)
007800*            OF THE AMOUNT CALCULATED UNDER THE CURRENT
007900*            FORMULA IN THE PRICER.
008000*            THIS REDUCTION IS NOT
008100*            APPLIED TO THE CAPITAL DSH PAYMENT
008200*            CALCULATION.
008300*
008400*         NO IPPS POLICY CHANGES FOR IME (FACTOR 'C' IS
008500*          STILL 1.35)
008600*
008700*
008800**************************************************
008900 ENVIRONMENT DIVISION.
009000 CONFIGURATION SECTION.
009100 SOURCE-COMPUTER.            IBM-370.
009200 OBJECT-COMPUTER.            IBM-370.
009300 INPUT-OUTPUT  SECTION.
009400 FILE-CONTROL.
009500
009600 DATA DIVISION.
009700 FILE SECTION.
009800
009900 WORKING-STORAGE SECTION.
010000 01  W-STORAGE-REF                  PIC X(46)  VALUE
010100     'LTCAL154      - W O R K I N G   S T O R A G E'.
010200 01  CAL-VERSION                    PIC X(05)  VALUE 'V15.4'.
010300 01  PROGRAM-CONSTANTS.
010400     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
010500     05  FED-FY-BEGIN-04            PIC 9(08) VALUE 20031001.
010600     05  FED-FY-BEGIN-05            PIC 9(08) VALUE 20041001.
010700     05  FED-FY-BEGIN-06            PIC 9(08) VALUE 20051001.
010800     05  FED-FY-BEGIN-07            PIC 9(08) VALUE 20061001.
010900
011000
011100***************************************************************
011200*    LAYUP TABLE AREA FOR FY2015 LTC-DRG                      *
011300*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
011400***************************************************************
011500 COPY LTDRG152.
011600
011700
011800***************************************************************
011900*    LAYUP TABLE AREA FOR FY2015 IPPS-DRG                     *
012000*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
012100***************************************************************
012200 COPY IPDRG152.
012300
012400
012500***************************************************************
012600*    LAYUP TABLE AREA FOR FY2013 IPPS STATE SPECIFIC RFBNS    *
012700*    EFFECTIVE DATE OF OCTOBER 1, 2012 - NO TBL FOR FY 2013   *
012800***************************************************************
012900*COPY IRFBN***.
013000
013100
013200***************************************************************
013300*    LAYUP TABLE AREA FOR FY2015 IPPS COMPARABLE BLENDED      *
013400*    WAGE INDEX VALUES BY LTCH PROVIDER - ONLY FOR PROVIDERS  *
013500*    THAT RECEIVE THE BLENDED VALUE                           *
013600*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
013700***************************************************************
013800 COPY BLEND152.
013900
014000
014100***************************************************************
014200*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
014300***************************************************************
014400 01  HOLD-PPS-COMPONENTS.
014500     05  H-LOS                        PIC 9(03).
014600     05  H-REG-DAYS                   PIC 9(03).
014700     05  H-TOTAL-DAYS                 PIC 9(05).
014800     05  H-SSOT                       PIC 9(02)V9(01).
014900     05  H-BLEND-RTC                  PIC 9(02).
015000     05  H-BLEND-FAC                  PIC 9(01)V9(01).
015100     05  H-BLEND-PPS                  PIC 9(01)V9(01).
015200     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
015300     05  H-SS-COST                    PIC 9(07)V9(02).
015400     05  H-LABOR-PORTION              PIC 9(07)V9(06).
015500     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
015600     05  H-FIXED-LOSS-AMT             PIC 9(07)V9(02).
015700     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
015800     05  H-LOS-RATIO                  PIC 9(01)V9(05).
015900
016000*** --------------------------------------------------- ***
016100*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
016200*** --------------------------------------------------- ***
016300     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
016400     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
016500     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
016600     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
016700     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
016800     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
016900     05  H-INTERN-RATIO               PIC 9(01)V9(04).
017000     05  H-CAPI-IME-RATIO             PIC 9V9999.
017100     05  H-BED-SIZE                   PIC 9(05).
017200     05  H-OPER-DSH-PCT               PIC V9(04).
017300     05  H-SSI-RATIO                  PIC V9(04).
017400     05  H-MEDICAID-RATIO             PIC V9(04).
017500     05  H-OPER-DSH                   PIC 9(01)V9(04).
017600     05  H-CAPI-DSH                   PIC 9(01)V9(04).
017700     05  H-GEO-CLASS                  PIC X(01).
017800     05  H-URBAN-IND                  PIC X(01).
017900           88 URBAN-CBSA           VALUE '1'.
018000           88 RURAL-CBSA           VALUE '0'.
018100     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
018200     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
018300     05  H-CAPI-PMT                   PIC 9(07)V9(02).
018400     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
018500     05  H-CAPI-GAF                   PIC 9(05)V9(04).
018600     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
018700     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
018800     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
018900     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
019000     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
019100     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
019200     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
019300     05  H-OPER-COLA                  PIC 9(01)V9(03).
019400     05  H-CAPI-COLA                  PIC 9(01)V9(03).
019500     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
019600     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
019700     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
019800     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
019900     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
020000     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
020100     05  H-IPPS-DAYS-CUTOFF           PIC 9(02)V9(01).
020200     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
020300     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
020400     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
020500     05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
020600     05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
020700     05  H-COUNTER                    PIC 9(02).
020800     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).
020900     05  H-OPER-DSH-REDUCTION-FACTOR  PIC V9(04).
021000
021100*** --------------------------------------------------- ***
021200*** VARIABLES FOR PC PRICER                             ***
021300*** --------------------------------------------------- ***
021400     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
021500     05  H-SS-COST-IND                PIC X.
021600     05  H-SS-PERDIEM-IND             PIC X.
021700     05  H-SS-BLEND-IND               PIC X.
021800     05  H-SS-IPPSCOMP-IND            PIC X.
021900
022000
022100* 8-6-14 ADDED WK-HLDDRG-DATA AND WK-HLDDRG-DATA TO
022200* MATCH THE IPPS DRG TABLE DATA NAMES THAT WERE COPIED
022300* FROM THE FY14 IPPS PRICER CALCULATION PROGRAM
022400
022500 01 WK-HLDDRG-DATA.
022600     05  HLDDRG-DATA.
022700         10  HLDDRG-DRGX               PIC X(03).
022800         10  FILLER1                   PIC X(01).
022900         10  HLDDRG-WEIGHT             PIC 9(02)V9(04).
023000         10  FILLER2                   PIC X(01).
023100         10  HLDDRG-GMALOS             PIC 9(02)V9(01).
023200         10  FILLER3                   PIC X(05).
023300         10  HLDDRG-LOW                PIC X(01).
023400         10  FILLER5                   PIC X(01).
023500         10  HLDDRG-ARITH-ALOS         PIC 9(02)V9(01).
023600         10  FILLER6                   PIC X(02).
023700         10  HLDDRG-PAC                PIC X(01).
023800         10  FILLER7                   PIC X(01).
023900         10  HLDDRG-SPPAC              PIC X(01).
024000         10  FILLER8                   PIC X(02).
024100         10  HLDDRG-DESC               PIC X(26).
024200
024300 01 WK-HLDDRG-DATA2.
024400     05  HLDDRG-DATA2.
024500         10  HLDDRG-DRGX2               PIC X(03).
024600         10  FILLER21                   PIC X(01).
024700         10  HLDDRG-WEIGHT2             PIC 9(02)V9(04).
024800         10  FILLER22                   PIC X(01).
024900         10  HLDDRG-GMALOS2             PIC 9(02)V9(01).
025000         10  FILLER23                   PIC X(05).
025100         10  HLDDRG-LOW2                PIC X(01).
025200         10  FILLER25                   PIC X(01).
025300         10  HLDDRG-ARITH-ALOS2         PIC 9(02)V9(01).
025400         10  FILLER26                   PIC X(02).
025500         10  HLDDRG-TRANS-FLAGS.
025600                   88  D-DRG-POSTACUTE-50-50
025700                   VALUE 'Y Y'.
025800                   88  D-DRG-POSTACUTE-PERDIEM
025900                   VALUE 'Y  '.
026000             15  HLDDRG-PAC2            PIC X(01).
026100             15  FILLER27               PIC X(01).
026200             15  HLDDRG-SPPAC2          PIC X(01).
026300         10  FILLER28                   PIC X(02).
026400         10  HLDDRG-DESC2               PIC X(26).
026500         10  HLDDRG-VALID               PIC X(01).
026600
026700
026800
026900 LINKAGE SECTION.
027000**************************************************************
027100*      THIS IS THE BILL-RECORD THAT WILL BE PASSED FROM      *
027200*      THE LTDRV___ PROGRAM                                  *
027300**************************************************************
027400 01  BILL-NEW-DATA.
027500     05  B-NPI10.
027600         10  B-NPI8                   PIC X(08).
027700         10  B-NPI-FILLER             PIC X(02).
027800     05  B-PROVIDER-NO                PIC X(06).
027900     05  B-PATIENT-STATUS             PIC X(02).
028000     05  B-DRG-CODE                   PIC X(03).
028100     05  B-LOS                        PIC 9(03).
028200     05  B-COV-DAYS                   PIC 9(03).
028300     05  B-LTR-DAYS                   PIC 9(02).
028400     05  B-CST-RPT-DAYS               PIC 9(03).
028500     05  B-DISCHARGE-DATE.
028600         10  B-DISCHG-CC              PIC 9(02).
028700         10  B-DISCHG-YY              PIC 9(02).
028800         10  B-DISCHG-MM              PIC 9(02).
028900         10  B-DISCHG-DD              PIC 9(02).
029000     05  B-COV-CHARGES                PIC 9(07)V9(02).
029100     05  B-SPEC-PAY-IND               PIC X(01).
029200     05  B-REVIEW-CODE                PIC 9(02).
029300     05  B-DIAGNOSIS-CODE-TABLE.
029400         10  B-DIAGNOSIS-CODE         PIC X(07) OCCURS 25 TIMES
029500                                      INDEXED BY IDX-DIAG.
029600     05  B-PROCEDURE-CODE-TABLE.
029700         10 B-PROCEDURE-CODE          PIC X(07) OCCURS 25 TIMES
029800                                      INDEXED BY IDX-PROC.
029900     05  FILLER                       PIC X(20).
030000
030100
030200***************************************************************
030300***************************************************************
030400*                                                             *
030500*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *
030600*    AND PASSED BACK TO THE CALLING PROGRAM                   *
030700*    RETURN CODE VALUES (PPS-RTC)                             *
030800*                                                             *
030900*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
031000*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
031100*                                                             *
031200*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
031300*                                                             *
031400*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
031500*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
031600*                                                             *
031700*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
031800*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
031900*                                                             *
032000*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
032100*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
032200*                                                             *
032300*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
032400*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
032500*                                                             *
032600*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
032700*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
032800*                                                             *
032900*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
033000*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
033100*                                                             *
033200*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
033300*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
033400*                                                             *
033500*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
033600*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
033700*                                                             *
033800*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
033900*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
034000*                                                             *
034100*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
034200*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
034300*                                                             *
034400*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
034500*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
034600*                                                             *
034700*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
034800*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
034900*                                                             *
035000*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
035100*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
035200*                                                             *
035300*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
035400*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
035500*                                                             *
035600*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
035700*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
035800*                                                             *
035900*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
036000*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
036100*                                                             *
036200*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
036300*                  WITHOUT OUTLIER                            *
036400*                                                             *
036500*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
036600*                  DIEM WITHOUT OUTLIER                       *
036700*                                                             *
036800*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
036900*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
037000*                  AMOUNT WITHOUT OUTLIER                     *
037100*                                                             *
037200*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
037300*                  DIEM WITH OUTLIER                          *
037400*                                                             *
037500*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
037600*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
037700*                  AMOUNT WITH OUTLIER                        *
037800*                                                             *
037900*                                                             *
038000*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *
038100*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *
038200*            FOR IPPS COMPARABLE PER DIEM)                    *
038300*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *
038400*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *
038500*            FOR IPPS COMPARABLE PER DIEM)                    *
038600*                                                             *
038700*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
038800*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
038900*                                                             *
039000*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
039100*                  COMPARABLE THRESHOLD WITH OUTLIER          *
039200*                                                             *
039300*             28 = SUBCLAUSE (II) DOES NOT QUALIFY FOR AN     *
039400*                  OUTLIER                                    *
039500*                                                             *
039600*             29 = SUBCLAUSE (II) QUALIFIES FOR AN OUTLIER    *
039700*                                                             *
039800*                                                             *
039900*      ****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
040000*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
040100*             51 = PROVIDER RECORD TERMINATED                 *
040200*             52 = INVALID WAGE INDEX                         *
040300*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
040400*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
040500*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
040600*                                     OR                      *
040700*                  DISCHARGE DATE < CBSA EFF START DATE       *
040800*                  FOR PPS                                    *
040900*             56 = INVALID LENGTH OF STAY                     *
041000*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
041100*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
041200*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
041300*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
041400*                  OR BILL-LTR-DAYS > 60                      *
041500*             62 = INVALID NUMBER OF COVERED DAYS             *
041600*                  OR BILL-LTR-DAYS > COVERED DAYS            *
041700*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
041800*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
041900*                  OR COST OUTLIER THRESHOLD CALCULATION      *
042000*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *
042100*             72 = INVALID BLEND INDICATOR (NOT 1 THRU 5)     *
042200*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
042300*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
042400*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *
042500*                                                             *
042600***************************************************************
042700***************************************************************
042800
042900
043000***************************************************************
043100* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
043200* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
043300***************************************************************
043400 01  PPS-DATA-ALL.
043500     05  PPS-RTC                       PIC 9(02).
043600     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
043700     05  PPS-DATA.
043800         10  PPS-MSA                   PIC X(04).
043900         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
044000         10  PPS-AVG-LOS               PIC 9(02)V9(01).
044100         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
044200         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
044300         10  PPS-LOS                   PIC 9(03).
044400         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
044500         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
044600         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
044700         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
044800         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
044900         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
045000         10  PPS-SUBM-DRG-CODE         PIC X(03).
045100         10  PPS-CALC-VERS-CD          PIC X(05).
045200         10  PPS-REG-DAYS-USED         PIC 9(03).
045300         10  PPS-LTR-DAYS-USED         PIC 9(03).
045400         10  PPS-BLEND-YEAR            PIC 9(01).
045500         10  PPS-COLA                  PIC 9(01)V9(03).
045600         10  FILLER                    PIC X(04).
045700     05  PPS-OTHER-DATA.
045800         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
045900         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
046000         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
046100         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
046200         10  PPS-IPTHRESH              PIC 9(03)V9(01).
046300         10  FILLER                    PIC X(16).
046400     05  PPS-PC-DATA.
046500         10  PPS-COT-IND               PIC X(01).
046600         10  H-PC-IND                  PIC X(02).
046700               88  PC-PRICER               VALUE 'PC'.
046800         10  FILLER                    PIC X(18).
046900
047000 01 PPS-CBSA                           PIC X(05).
047100
047200
047300******************************************************************
047400*            THESE ARE THE VERSIONS OF THE LTDRV___              *
047500*           PROGRAMS THAT WILL BE PASSED BACK----                *
047600*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
047700******************************************************************
047800 01  PRICER-OPT-VERS-SW.
047900     05  PRICER-OPTION-SW          PIC X(01).
048000         88  ALL-TABLES-PASSED          VALUE 'A'.
048100         88  PROV-RECORD-PASSED         VALUE 'P'.
048200     05  PPS-VERSIONS.
048300         10  PPDRV-VERSION         PIC X(05).
048400
048500
048600**************************************************************
048700*      THIS IS THE PROV-RECORD THAT WILL BE PASSED BY        *
048800*      THE LTCAL___ PROGRAM (FROM PROGRAM LTDRV___)          *
048900**************************************************************
049000 01  PROV-NEW-HOLD.
049100     02  PROV-NEWREC-HOLD1.
049200         05  P-NEW-NPI10.
049300             10  P-NEW-NPI8             PIC X(08).
049400             10  P-NEW-NPI-FILLER       PIC X(02).
049500         05  P-NEW-PROVIDER-NO.
049600               88  SUBCLAUSEII-PROV       VALUE '332006'.
049700             10  P-NEW-STATE            PIC 9(02).
049800             10  FILLER                 PIC X(04).
049900         05  P-NEW-DATE-DATA.
050000             10  P-NEW-EFF-DATE.
050100                 15  P-NEW-EFF-DT-CC    PIC 9(02).
050200                 15  P-NEW-EFF-DT-YY    PIC 9(02).
050300                 15  P-NEW-EFF-DT-MM    PIC 9(02).
050400                 15  P-NEW-EFF-DT-DD    PIC 9(02).
050500             10  P-NEW-FY-BEGIN-DATE.
050600                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).
050700                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).
050800                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).
050900                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).
051000             10  P-NEW-REPORT-DATE.
051100                 15  P-NEW-REPORT-DT-CC PIC 9(02).
051200                 15  P-NEW-REPORT-DT-YY PIC 9(02).
051300                 15  P-NEW-REPORT-DT-MM PIC 9(02).
051400                 15  P-NEW-REPORT-DT-DD PIC 9(02).
051500             10  P-NEW-TERMINATION-DATE.
051600                 15  P-NEW-TERM-DT-CC   PIC 9(02).
051700                 15  P-NEW-TERM-DT-YY   PIC 9(02).
051800                 15  P-NEW-TERM-DT-MM   PIC 9(02).
051900                 15  P-NEW-TERM-DT-DD   PIC 9(02).
052000         05  P-NEW-WAIVER-CODE          PIC X(01).
052100             88  P-NEW-WAIVER-STATE       VALUE 'Y'.
052200         05  P-NEW-INTER-NO             PIC 9(05).
052300         05  P-NEW-PROVIDER-TYPE        PIC X(02).
052400         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
052500         05  P-NEW-CURRENT-DIV   REDEFINES
052600                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
052700         05  P-NEW-MSA-DATA.
052800             10  P-NEW-CHG-CODE-INDEX       PIC X.
052900             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT.
053000             10  P-NEW-GEO-LOC-MSA9   REDEFINES
053100                             P-NEW-GEO-LOC-MSAX  PIC 9(04).
053200             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT.
053300             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT.
053400             10  P-NEW-STAND-AMT-LOC-MSA9
053500                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.
053600                 15  P-NEW-RURAL-1ST.
053700                     20  P-NEW-STAND-RURAL  PIC XX.
053800                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.
053900                 15  P-NEW-RURAL-2ND        PIC XX.
054000         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.
054100         05  P-NEW-LUGAR                    PIC X.
054200         05  P-NEW-TEMP-RELIEF-IND          PIC X.
054300         05  P-NEW-FED-PPS-BLEND-IND        PIC X.
054400         05  FILLER                         PIC X(05).
054500     02  PROV-NEWREC-HOLD2.
054600         05  P-NEW-VARIABLES.
054700             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).
054800             10  P-NEW-COLA              PIC  9(01)V9(03).
054900             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).
055000             10  P-NEW-BED-SIZE          PIC  9(05).
055100             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).
055200             10  P-NEW-CMI               PIC  9(01)V9(04).
055300             10  P-NEW-SSI-RATIO         PIC  V9(04).
055400             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).
055500             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).
055600             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).
055700             10  P-NEW-DSH-PERCENT       PIC  V9(04).
055800             10  P-NEW-FYE-DATE          PIC  X(08).
055900         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).
056000         05  P-NEW-HOSP-QUAL-IND           PIC X(01).
056100         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.
056200         05  P-NEW-GEO-LOC-CBSA9 REDEFINES
056300                       P-NEW-GEO-LOC-CBSAX PIC 9(05).
056400         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES
056500                       P-NEW-GEO-LOC-CBSAX.
056600             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.
056700             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.
056800             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.
056900             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.
057000             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.
057100         05  FILLER                        PIC X(10).
057200         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).
057300     02  PROV-NEWREC-HOLD3.
057400         05  P-NEW-PASS-AMT-DATA.
057500             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.
057600             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.
057700             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.
057800             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.
057900         05  P-NEW-CAPI-DATA.
058000             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.
058100             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.
058200             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.
058300             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.
058400             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.
058500             15  P-NEW-CAPI-NEW-HOSP       PIC X.
058600             15  P-NEW-CAPI-IME            PIC 9V9999.
058700             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.
058800             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.
058900         05  FILLER                        PIC X(18).
059000
059100
059200******************************************************************
059300*                THIS IS THE LTCH WAGE-INDEX                     *
059400*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
059500*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *
059600******************************************************************
059700 01  WAGE-NEW-INDEX-RECORD.
059800     05  W-CBSA                        PIC X(5).
059900     05  W-EFF-DATE                    PIC X(8).
060000     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).
060100     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).
060200     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).
060300
060400
060500******************************************************************
060600*                THIS IS THE IPPS WAGE-INDEX                     *
060700*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
060800******************************************************************
060900 01  WAGE-NEW-IPPS-INDEX-RECORD.
061000     05  W-CBSA-IPPS.
061100         10 CBSA-IPPS-123              PIC X(3).
061200         10 CBSA-IPPS-45               PIC X(2).
061300     05  W-CBSA-IPPS-SIZE              PIC X.
061400         88  LARGE-URBAN       VALUE 'L'.
061500         88  OTHER-URBAN       VALUE 'O'.
061600         88  ALL-RURAL         VALUE 'R'.
061700     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).
061800     05  FILLER                        PIC X.
061900     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).
062000     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).
062100
062200
062300
062400 PROCEDURE DIVISION  USING BILL-NEW-DATA
062500                           PPS-DATA-ALL
062600                           PPS-CBSA
062700                           PRICER-OPT-VERS-SW
062800                           PROV-NEW-HOLD
062900                           WAGE-NEW-INDEX-RECORD
063000                           WAGE-NEW-IPPS-INDEX-RECORD.
063100
063200
063300***************************************************************
063400*                                                             *
063500*    PROCESSING:                                              *
063600*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
063700*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
063800*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
063900*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
064000*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
064100*           GOBACK.                                           *
064200*        D. ASSEMBLE PRICING COMPONENTS.                      *
064300*        E. CALCULATE THE PRICE.                              *
064400*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
064500*                                                             *
064600***************************************************************
064700
064800
064900***************************************************************
065000 0000-MAINLINE-CONTROL.
065100***************************************************************
065200
065300     PERFORM 0100-INITIAL-ROUTINE
065400        THRU 0100-EXIT.
065500
065600     PERFORM 1000-EDIT-THE-BILL-INFO
065700        THRU 1000-EXIT.
065800
065900     IF PPS-RTC = 00
066000        PERFORM 1700-EDIT-DRG-CODE
066100           THRU 1700-EXIT.
066200
066300     IF PPS-RTC = 00
066400        PERFORM 1800-EDIT-IPPS-DRG-CODE
066500           THRU 1800-EXIT.
066600
066700     IF PPS-RTC = 00
066800        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
066900           THRU 2000-EXIT.
067000
067100     IF PPS-RTC = 00
067200        PERFORM 3000-CALC-PAYMENT
067300           THRU 3000-EXIT
067400        PERFORM 7000-CALC-OUTLIER
067500           THRU 7000-EXIT.
067600
067700     IF PPS-RTC < 50
067800        IF SUBCLAUSEII-PROV
067900           PERFORM 8100-SUBCLAUSEII-FINAL-PAY
068000              THRU 8100-EXIT
068100        ELSE
068200           PERFORM 8000-BLEND
068300              THRU 8000-EXIT
068400        END-IF
068500     END-IF.
068600
068700     PERFORM 9000-MOVE-RESULTS
068800        THRU 9000-EXIT.
068900
069000     GOBACK.
069100
069200
069300***************************************************************
069400 0100-INITIAL-ROUTINE.
069500***************************************************************
069600
069700     MOVE ZEROS TO PPS-RTC.
069800     INITIALIZE PPS-DATA.
069900     INITIALIZE PPS-OTHER-DATA.
070000     INITIALIZE PPS-CBSA.
070100     INITIALIZE HOLD-PPS-COMPONENTS.
070200
070300     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.
070400
070500*** -----------------------------------------------------***
070600*** ADJUST IPPS WAGE INDEX BY THE STATE SPECIFIC RFBN    ***
070700*** (DISABLED 09/05/2014 V2015.1 - NO LONGER APPLIES)    ***
070800*** -----------------------------------------------------***
070900*    PERFORM 1900-APPLY-SSRFBN
071000*       THRU 1900-EXIT.
071100*
071200*    IF PPS-RTC NOT = 00
071300*       GO TO 0100-EXIT
071400*    END-IF.
071500
071600*** -----------------------------------------------------***
071700*** GET THE APPROPRIATE IPPS WAGE INDEX (NEW V2015.1)    ***
071800*** -----------------------------------------------------***
071900     PERFORM 1900-GET-IPPS-WAGE-INDEX
072000        THRU 1900-EXIT.
072100
072200     IF PPS-RTC NOT = 00
072300        GO TO 0100-EXIT
072400     END-IF.
072500
072600*** ---------------------------------------------------- ***
072700*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***
072800*** ---------------------------------------------------- ***
072900     MOVE .62306   TO PPS-NAT-LABOR-PCT.
073000     MOVE .37694   TO PPS-NAT-NONLABOR-PCT.
073100* NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
073200* REPORTING OF QUALITY DATA.
073300* - FULL UPDATE (QUALITY INDICATOR ON PSF = 1):
073400*     $40,607.31
073500* - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK):
073600*     $39808.74
073700     IF P-NEW-HOSP-QUAL-IND = '1'
073800        MOVE 41043.71 TO PPS-STD-FED-RATE
073900     ELSE
074000        MOVE 40240.51 TO PPS-STD-FED-RATE.
074100     MOVE 14972.00 TO H-FIXED-LOSS-AMT.
074200     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.
074300
074400*** ---------------------------------------------------- ***
074500*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
074600*** ---------------------------------------------------- ***
074700     MOVE 434.97 TO H-IPPS-CAPI-STD-FED-RATE.
074800     MOVE 209.45 TO H-IPPS-CAPI-STD-PR-RATE.
074900     MOVE 0.75   TO H-NAT-IPPS-PMT-PCT.
075000     MOVE 0.25   TO H-PR-IPPS-PMT-PCT.
075100
075200     IF H-IPPS-WAGE-INDEX > 1
075300        MOVE 3784.75 TO H-IPPS-NAT-LABOR-SHR
075400        MOVE 1653.10 TO H-IPPS-NAT-NONLABOR-SHR
075500     ELSE
075600        MOVE 3371.47 TO H-IPPS-NAT-LABOR-SHR
075700        MOVE 2066.38 TO H-IPPS-NAT-NONLABOR-SHR
075800     END-IF.
075900
076000     IF W-IPPS-PR-WAGE-INDEX > 1
076100        MOVE 1609.97 TO H-IPPS-PR-LABOR-SHR
076200        MOVE  937.45 TO H-IPPS-PR-NONLABOR-SHR
076300     ELSE
076400        MOVE 1579.40 TO H-IPPS-PR-LABOR-SHR
076500        MOVE  968.02 TO H-IPPS-PR-NONLABOR-SHR
076600     END-IF.
076700
076800*** ---------------------------------------------------- ***
076900*** OPERATING DSH REDUCTION FACTOR                       ***
077000*** -----------------------------------------------------***
077100     MOVE .8214 TO H-OPER-DSH-REDUCTION-FACTOR.
077200
077300 0100-EXIT.
077400      EXIT.
077500
077600
077700***************************************************************
077800*    BILL DATA EDITS - IF ANY FAIL SET PPS-RTC                *
077900*    AND DO NOT ATTEMPT TO PRICE.                             *
078000***************************************************************
078100 1000-EDIT-THE-BILL-INFO.
078200***************************************************************
078300
078400     IF (B-LOS NUMERIC) AND (B-LOS > 0)
078500        MOVE B-LOS TO H-LOS
078600     ELSE
078700        MOVE 56 TO PPS-RTC.
078800
078900     IF PPS-RTC = 00
079000       IF P-NEW-COLA NOT NUMERIC
079100          MOVE 50 TO PPS-RTC.
079200
079300     IF PPS-RTC = 00
079400       IF P-NEW-WAIVER-STATE
079500          MOVE 53 TO PPS-RTC.
079600
079700     IF PPS-RTC = 00
079800         IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
079900            (B-DISCHARGE-DATE < W-EFF-DATE))
080000            MOVE 55 TO PPS-RTC.
080100
080200     IF PPS-RTC = 00
080300         IF P-NEW-TERMINATION-DATE > 00000000
080400            IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
080500               MOVE 51 TO PPS-RTC.
080600
080700     IF PPS-RTC = 00
080800         IF B-COV-CHARGES NOT NUMERIC
080900            MOVE 58 TO PPS-RTC.
081000
081100     IF PPS-RTC = 00
081200        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
081300           MOVE 61 TO PPS-RTC.
081400
081500     IF PPS-RTC = 00
081600        IF (B-COV-DAYS NOT NUMERIC) OR
081700           (B-COV-DAYS = 0 AND H-LOS > 0)
081800           MOVE 62 TO PPS-RTC.
081900
082000     IF PPS-RTC = 00
082100        IF B-LTR-DAYS > B-COV-DAYS
082200           MOVE 62 TO PPS-RTC.
082300
082400     IF PPS-RTC = 00
082500        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
082600        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
082700
082800     IF PPS-RTC = 00
082900        PERFORM 1200-DAYS-USED
083000           THRU 1200-DAYS-USED-EXIT.
083100
083200
083300*** -----------------------------------------------------------
083400*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
083500*** -----------------------------------------------------------
083600     IF PPS-RTC = 00
083700        IF P-NEW-CAPI-IME NUMERIC
083800           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
083900        ELSE
084000           MOVE ZEROS TO H-CAPI-IME-RATIO
084100        END-IF
084200     END-IF.
084300
084400     IF PPS-RTC = 00
084500        IF P-NEW-INTERN-RATIO NUMERIC
084600           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
084700        ELSE
084800           MOVE ZEROS TO H-INTERN-RATIO
084900        END-IF
085000     END-IF.
085100
085200     IF PPS-RTC = 00
085300        IF P-NEW-BED-SIZE NUMERIC
085400           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
085500        ELSE
085600           MOVE ZEROS TO H-BED-SIZE
085700        END-IF
085800     END-IF.
085900
086000     IF PPS-RTC = 00
086100        IF P-NEW-SSI-RATIO NUMERIC
086200           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
086300        ELSE
086400           MOVE ZEROS TO H-SSI-RATIO
086500        END-IF
086600     END-IF.
086700
086800     IF PPS-RTC = 00
086900        IF P-NEW-MEDICAID-RATIO NUMERIC
087000           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
087100        ELSE
087200           MOVE ZEROS TO H-MEDICAID-RATIO
087300        END-IF
087400     END-IF.
087500
087600
087700 1000-EXIT.
087800      EXIT.
087900
088000
088100***************************************************************
088200 1200-DAYS-USED.
088300***************************************************************
088400
088500     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
088600        IF B-LTR-DAYS > H-LOS
088700           MOVE H-LOS TO PPS-LTR-DAYS-USED
088800        ELSE
088900           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
089000     ELSE
089100        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
089200           IF H-REG-DAYS > H-LOS
089300              MOVE H-LOS TO PPS-REG-DAYS-USED
089400           ELSE
089500              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
089600        ELSE
089700           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
089800              IF H-REG-DAYS > H-LOS
089900                 MOVE H-LOS TO PPS-REG-DAYS-USED
090000                 MOVE 0 TO PPS-LTR-DAYS-USED
090100              ELSE
090200                 IF H-TOTAL-DAYS > H-LOS
090300                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
090400                    COMPUTE PPS-LTR-DAYS-USED =
090500                            H-LOS - H-REG-DAYS
090600                 ELSE
090700                    IF H-TOTAL-DAYS <= H-LOS
090800                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
090900                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
091000                    ELSE
091100                       NEXT SENTENCE
091200           ELSE
091300              NEXT SENTENCE.
091400
091500 1200-DAYS-USED-EXIT.
091600      EXIT.
091700
091800
091900***************************************************************
092000*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
092100***************************************************************
092200 1700-EDIT-DRG-CODE.
092300***************************************************************
092400
092500     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
092600     IF PPS-RTC = 00
092700        SEARCH ALL WWM-ENTRY
092800           AT END
092900             MOVE 54 TO PPS-RTC
093000        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
093100             PERFORM 1750-FIND-VALUE
093200                THRU 1750-EXIT
093300        END-SEARCH.
093400
093500 1700-EXIT.
093600      EXIT.
093700
093800
093900***************************************************************
094000*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
094100***************************************************************
094200 1750-FIND-VALUE.
094300***************************************************************
094400
094500      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
094600      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
094700      MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
094800
094900 1750-EXIT.
095000      EXIT.
095100
095200
095300***************************************************************
095400*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
095500***************************************************************
095600 1800-EDIT-IPPS-DRG-CODE.
095700***************************************************************
095800
095900     IF B-DRG-CODE NOT NUMERIC
096000        MOVE 54 TO PPS-RTC
096100        GO TO 1800-EXIT
096200     END-IF.
096300
096400*THE FOLLOWING 26 OR SO LINES OF CODE WAS COPIED
096500*FROM THE FY14 IPPS PRICER LOCATED IN
096600*D29L.@BFN2699.INPATCOB.COBR140(PPCAL140)
096700*REPLACING THE CODE FROM LAST YEAR
096800*IN ORDER TO BE ABLE TO READ IN THE NEW FORMAT
096900*OF THE IPPS DRG TABLE
097000
097100     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE
097200     SET DRG-IDX TO 1
097300     SEARCH DRG-TAB VARYING DRG-IDX
097400         AT END
097500           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC
097600           MOVE 'I' TO  HLDDRG-VALID
097700       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE
097800         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.
097900
098000
098100     MOVE HLDDRG-DATA TO WK-HLDDRG-DATA2.
098200     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.
098300     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2
098400                                  H-IPPS-DRG-WGT.
098500     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2
098600                                  H-IPPS-DRG-ALOS.
098700     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.
098800     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2
098900                                  H-IPPS-ARITH-ALOS.
099000     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.
099100     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.
099200     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.
099300     MOVE  'V'                 TO HLDDRG-VALID.
099400     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.
099500
099600 1800-EXIT.
099700      EXIT.
099800
099900
100000***************************************************************
100100*    GETS THE APPROPRIATE IPPS WAGE INDEX                     *
100200*    (NEW STARTING WITH VERSION 2015.1)                       *
100300***************************************************************
100400 1900-GET-IPPS-WAGE-INDEX.
100500***************************************************************
100600
100700*-------------------------------------------------------------*
100800* GET THE IPPS WAGE INDEX ASSIGNED IN LTDRV***                *
100900* (MOVED HERE FROM 1900-APPLY-SSRFBN ON 09/05/2014 V2015.1)   *
101000*-------------------------------------------------------------*
101100     MOVE W-IPPS-WAGE-INDEX TO H-IPPS-WAGE-INDEX.
101200
101300*-------------------------------------------------------------*
101400* USE IPPS COMPARABLE BLENDED WAGE INDEX FROM TABLE IF        *
101500* PROVIDER FOUND IN TABLE - FOR FY 2015                       *
101600*-------------------------------------------------------------*
101700     SEARCH ALL IBW-ENTRY
101800        AT END
101900          CONTINUE
102000        WHEN IBW-PROV (IBW-INDX) = P-NEW-PROVIDER-NO
102100          MOVE IBW-WAGE-INDEX (IBW-INDX) TO H-IPPS-WAGE-INDEX
102200     END-SEARCH.
102300
102400*-------------------------------------------------------------*
102500* SET RETURN CODE TO 52 IF THE IPPS WAGE INDEX IS INVALID     *
102600*-------------------------------------------------------------*
102700     IF H-IPPS-WAGE-INDEX NOT NUMERIC OR
102800        H-IPPS-WAGE-INDEX NOT > 0
102900          MOVE 52 TO PPS-RTC
103000     END-IF.
103100
103200
103300 1900-EXIT.
103400      EXIT.
103500
103600
103700***************************************************************
103800*    ADJUST THE IPPS WAGE INDEX BY THE STATE SPECIFIC         *
103900*    RURAL FLOOR BUDGET NEUTRALITY FACTOR (SSRFBN)            *
104000*    (DISABLED 09/05/2014 V2015.1 - NO LONGER APPLIES)        *
104100***************************************************************
104200*1900-APPLY-SSRFBN.
104300***************************************************************
104400*
104500*    MOVE W-IPPS-WAGE-INDEX    TO H-IPPS-WAGE-INDEX.
104600*    MOVE P-NEW-STATE          TO MES-PPS-STATE.
104700*
104800*    PERFORM 1950-FIND-SSRFBN
104900*       THRU 1950-EXIT.
105000*
105100*    IF PPS-RTC = 00
105200*       IF  P-NEW-SPECIAL-PAY-IND = '1' OR '2'
105300*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =
105400*                   H-IPPS-WAGE-INDEX * 1
105500*       ELSE
105600*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =
105700*                   H-IPPS-WAGE-INDEX * MES-SSRFBN-RATE
105800*       END-IF
105900*    END-IF.
106000*
106100*1900-EXIT.
106200*     EXIT.
106300
106400
106500***************************************************************
106600*    FIND THE IPPS STATE SPECIFIC RURAL FLOOR BUDGET          *
106700*    NEUTRALITY FACTOR (SSRFBN)                               *
106800***************************************************************
106900*1950-FIND-SSRFBN.
107000***************************************************************
107100*
107200*    SET SSRFBN-IDX TO 1.
107300*    SEARCH SSRFBN-TAB VARYING SSRFBN-IDX
107400*
107500*        AT END
107600*          MOVE 68 TO PPS-RTC
107700*          GO TO 1950-EXIT
107800*
107900*        WHEN WK-SSRFBN-STATE(SSRFBN-IDX) = MES-PPS-STATE
108000*          MOVE WK-SSRFBN-REASON-ALL (SSRFBN-IDX) TO MES-SSRFBN.
108100*
108200*1950-EXIT.
108300*     EXIT.
108400
108500
108600***************************************************************
108700***  GET THE PROVIDER SPECIFIC VARIABLES AND LTCH WAGE INDEX  *
108800*                                                             *
108900*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
109000*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
109100*    OF THAT VARIABLE.                                        *
109200*                                                             *
109300***************************************************************
109400 2000-ASSEMBLE-PPS-VARIABLES.
109500***************************************************************
109600
109700
109800*------------------------------------------------------*
109900* WAGE INDEX BLEND TABLE                               *
110000*------------------------------------------------------*
110100*                                                      *
110200*  BLEND YEAR   FEDERAL FY                BLEND        *
110300*  ----------   ----------------------    -----        *
110400*      1        10/01/2002 - 09/30/2003    1/5         *
110500*      2        10/01/2003 - 09/30/2004    2/5         *
110600*      3        10/01/2004 - 09/30/2005    3/5         *
110700*      4        10/01/2005 - 09/30/2006    4/5         *
110800*      5        10/01/2006 - INDEFINITE    5/5 (FULL)  *
110900*                                                      *
111000*------------------------------------------------------*
111100*                                                      *
111200* A PROVIDER WILL RECEIVE THE APPLICABLE BLEND FOR A   *
111300* GIVEN FEDERAL FY FOR CLAIMS DISCHARGED ON & AFTER    *
111400* ITS FY BEGIN DATE THAT FALLS WITHIN THAT FEDERAL FY. *
111500*                                                      *
111600*------------------------------------------------------*
111700
111800
111900***************************************************************
112000* ASSIGN FULL (5/5) WAGE INDEX TO ALL CLAIMS DISCHARGED ON    *
112100* AND AFTER 7/1/2008 (NEW FOR VERSION 2008.0) - LTCH WAGE IDX *
112200***************************************************************
112300     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
112400        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
112500     ELSE
112600        MOVE 52 TO PPS-RTC
112700        GO TO 2000-EXIT
112800     END-IF.
112900
113000
113100***************************************************************
113200* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
113300* (ALWAYS FED-FY-BEGIN-03)                                    *
113400***************************************************************
113500      IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
113600         MOVE 74 TO PPS-RTC
113700         GO TO 2000-EXIT
113800      END-IF.
113900
114000
114100***************************************************************
114200* USE SPECIAL WAGE INDEX WHEN INDICATED - FOR LTCH WAGE INDEX *
114300* DISABLED 09/05/2014 - STARTING WITH VERSION 2015.1, THE     *
114400* SPECIAL WAGE INDEX IS ASSIGNED IN LTDRV***.                 *
114500***************************************************************
114600*    IF P-NEW-SPECIAL-PAY-IND = '1'
114700*       IF P-NEW-SPECIAL-WAGE-INDEX NUMERIC AND
114800*          P-NEW-SPECIAL-WAGE-INDEX > 0
114900*          MOVE P-NEW-SPECIAL-WAGE-INDEX TO PPS-WAGE-INDEX
115000*       ELSE
115100*          MOVE 52 TO PPS-RTC
115200*          GO TO 2000-EXIT
115300*       END-IF
115400*    END-IF.
115500
115600
115700***************************************************************
115800* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
115900***************************************************************
116000     IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
116100        MOVE 65 TO PPS-RTC.
116200
116300
116400***************************************************************
116500* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
116600***************************************************************
116700     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
116800
116900     IF PPS-BLEND-YEAR > 0 AND PPS-BLEND-YEAR < 6
117000        NEXT SENTENCE
117100     ELSE
117200        MOVE 72 TO PPS-RTC
117300        GO TO 2000-EXIT.
117400
117500     MOVE 0 TO H-BLEND-FAC.
117600     MOVE 1 TO H-BLEND-PPS.
117700     MOVE 0 TO H-BLEND-RTC.
117800
117900     IF PPS-BLEND-YEAR = 1
118000        MOVE .8 TO H-BLEND-FAC
118100        MOVE .2 TO H-BLEND-PPS
118200        MOVE 4 TO H-BLEND-RTC
118300     ELSE
118400       IF PPS-BLEND-YEAR = 2
118500          MOVE .6 TO H-BLEND-FAC
118600          MOVE .4 TO H-BLEND-PPS
118700          MOVE 8 TO H-BLEND-RTC
118800       ELSE
118900         IF PPS-BLEND-YEAR = 3
119000            MOVE .4 TO H-BLEND-FAC
119100            MOVE .6 TO H-BLEND-PPS
119200            MOVE 12 TO H-BLEND-RTC
119300         ELSE
119400           IF PPS-BLEND-YEAR = 4
119500              MOVE .2 TO H-BLEND-FAC
119600              MOVE .8 TO H-BLEND-PPS
119700              MOVE 16 TO H-BLEND-RTC.
119800
119900 2000-EXIT.
120000      EXIT.
120100
120200
120300***************************************************************
120400*    IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)           *
120500*        CALCULATE THE STANDARD PAYMENT AMOUNT.               *
120600*        CALCULATE THE SHORT-STAY OUTLIER AMOUNT.             *
120700***************************************************************
120800 3000-CALC-PAYMENT.
120900***************************************************************
121000
121100*** -------------------------------------------------- ***
121200*** FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII) ***
121300*** -------------------------------------------------- ***
121400     IF (P-NEW-STATE = 02 OR 12)
121500        MOVE P-NEW-COLA TO PPS-COLA
121600     ELSE
121700        MOVE 1.000 TO PPS-COLA
121800     END-IF.
121900
122000
122100     COMPUTE PPS-FAC-COSTS ROUNDED =
122200         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
122300
122400     COMPUTE H-LABOR-PORTION ROUNDED =
122500         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
122600          * PPS-WAGE-INDEX.
122700
122800     COMPUTE H-NONLABOR-PORTION ROUNDED =
122900         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
123000          * PPS-COLA.
123100
123200     COMPUTE PPS-FED-PAY-AMT ROUNDED =
123300         (H-LABOR-PORTION + H-NONLABOR-PORTION).
123400
123500     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
123600         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
123700
123800
123900*** -------------------------------------------------------- ***
124000*** FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY ***
124100*** -------------------------------------------------------- ***
124200     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
124300
124400*** --------------------------------------------- ***
124500*** DETERMINE WHETHER THE CLAIM IS A SHORT STAY   ***
124600*** --------------------------------------------- ***
124700*** H-SSOT ROUNDED AND EXPANDED TO 1 DECIMAL      ***
124800*** PLACE FOR RELEASE 07.1                        ***
124900*** --------------------------------------------- ***
125000     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
125100     IF H-LOS <= H-SSOT
125200        PERFORM 3400-SHORT-STAY
125300           THRU 3400-SHORT-STAY-EXIT.
125400
125500 3000-EXIT.
125600      EXIT.
125700
125800
125900***************************************************************
126000*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
126100*      OF THE AVG. LENGTH OF STAY THEN:                       *
126200*      - CALCULATE THE SHORT-STAY COST.                       *
126300*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *
126400*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *
126500*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *
126600*      - PAY THE LEAST OF:                                    *
126700*          1)SHORT STAY COST                                  *
126800*          2)SHORT STAY PAYMENT AMOUNT                        *
126900*          3)DRG ADJUSTED PAYMENT AMOUNT                      *
127000*          4)SHORT STAY BLENDED PAYMENT -OR-                  *
127100*          5)IPPS COMPARABLE AMOUNT                           *
127200*      - SET RETURN CODE TO INDICATE SHORT STAY PAYMENT TYPE  *
127300***************************************************************
127400
127500 3400-SHORT-STAY.
127600**************************************************************
127700*   SHORT STAY PROVISION FOR SUBCLAUSE II PROVIDERS ONLY     *
127800**************************************************************
127900     IF SUBCLAUSEII-PROV
128000        PERFORM 4000-SPECIAL-PROVIDER
128100           THRU 4000-SPECIAL-PROVIDER-EXIT
128200     ELSE
128300
128400**************************************************************
128500*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *
128600* ---------------------------------------------------------- *
128700*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *
128800**************************************************************
128900        MOVE PPS-FAC-COSTS TO H-SS-COST
129000
129100**************************************************************
129200*                                                            *
129300*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *
129400* ---------------------------------------------------------- *
129500*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *
129600*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *
129700*     THE LENGTH OF STAY IS CORRECT                          *
129800*                                                            *
129900**************************************************************
130000        COMPUTE H-SS-PAY-AMT ROUNDED =
130100         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
130200
130300**************************************************************
130400*                                                            *
130500*   SHORT STAY PROVISION #4 (BLEND OF SS PMT & IPPS          *
130600*   COMPARABLE PER DIEM AMT)                                 *
130700* ---------------------------------------------------------- *
130800*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
130900*   REMOVED FROM VERSION 09.0 BECAUSE CLAIMS DISCHARGED ON   *
131000*   AND AFTER 12/29/2008 ARE NOT ELIGIBLE FOR PROVISION #5.  *
131100*                                                            *
131200*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
131300*   ADDED TO VERSION 13.0 BECAUSE CLAIMS DISCHARGED ON AND   *
131400*   AFTER 12/29/2012 ARE ELIGIBLE FOR PROVISION #5.          *
131500*                                                            *
131600**************************************************************
131700        IF H-IPPS-WAGE-INDEX NUMERIC AND
131800           H-IPPS-WAGE-INDEX > 0
131900*---------------------------------------------------------
132000*   #4 - CALCULATE BLENDED PAYMENT
132100*---------------------------------------------------------
132200           IF B-DISCHARGE-DATE >= 20121229
132300              IF H-LOS > PPS-IPTHRESH
132400                 PERFORM 3600-SS-BLENDED-PMT
132500                    THRU 3600-SS-BLENDED-PMT-EXIT
132600               ELSE
132700*---------------------------------------------------------
132800*   #5 - LOS (COVERED DAYS) <= IPPS COMPARABLE THRESHOLD
132900*        CALCULATE IPPS COMPARABLE PER DIEM AMT ONLY
133000*---------------------------------------------------------
133100                  PERFORM 3650-SS-IPPS-COMP-PMT
133200                     THRU 3650-SS-IPPS-COMP-PMT-EXIT
133300           ELSE
133400               PERFORM 3600-SS-BLENDED-PMT
133500                  THRU 3600-SS-BLENDED-PMT-EXIT
133600        ELSE
133700           MOVE 52 TO PPS-RTC
133800           GO TO 3400-SHORT-STAY-EXIT.
133900
134000**************************************************************
134100*                                                            *
134200*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *
134300*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *
134400* ---------------------------------------------------------- *
134500*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *
134600*                                                            *
134700**************************************************************
134800
134900     MOVE 'N' TO H-SS-COST-IND.
135000     MOVE 'N' TO H-SS-PERDIEM-IND.
135100     MOVE 'N' TO H-SS-BLEND-IND.
135200     MOVE 'N' TO H-SS-IPPSCOMP-IND.
135300
135400*---------------------------------------------------------
135500*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%
135600*   OF PER DIEM) AND DRG ADJUSTED PMT AMT
135700*---------------------------------------------------------
135800     IF H-SS-COST < H-SS-PAY-AMT
135900        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT
136000           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT
136100           MOVE 20 TO PPS-RTC
136200           MOVE 'Y' TO H-SS-COST-IND
136300        ELSE
136400           NEXT SENTENCE
136500        END-IF
136600     ELSE
136700        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT
136800           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT
136900           MOVE 21 TO PPS-RTC
137000           MOVE 'Y' TO H-SS-PERDIEM-IND
137100        ELSE
137200           NEXT SENTENCE
137300        END-IF
137400     END-IF.
137500
137600*---------------------------------------------------------
137700*   USE THE BLENDED PMT OR IPPS COMPARABLE AMT IF LESS
137800*   THAN THE OTHER OPTIONS
137900*---------------------------------------------------------
138000     IF NOT SUBCLAUSEII-PROV
138100*---------------------------------------------------------
138200*   COMPARE BLENDED PAYMENT
138300*---------------------------------------------------------
138400         IF B-DISCHARGE-DATE >= 20121229 AND
138500           H-LOS > PPS-IPTHRESH AND
138600           H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
138700               MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
138800               MOVE 22 TO PPS-RTC
138900               MOVE 'Y' TO H-SS-BLEND-IND
139000               MOVE 'N' TO H-SS-COST-IND
139100               MOVE 'N' TO H-SS-PERDIEM-IND
139200               MOVE 'N' TO H-SS-IPPSCOMP-IND
139300         ELSE
139400*---------------------------------------------------------
139500*   COMPARE IPPS COMPARABLE PER DIEM AMOUNT
139600*---------------------------------------------------------
139700             IF B-DISCHARGE-DATE >= 20121229 AND
139800               H-LOS <= PPS-IPTHRESH AND
139900               H-IPPS-PER-DIEM <= PPS-DRG-ADJ-PAY-AMT
140000                 MOVE H-IPPS-PER-DIEM TO PPS-DRG-ADJ-PAY-AMT
140100                 MOVE 26 TO PPS-RTC
140200                 MOVE 'Y' TO H-SS-IPPSCOMP-IND
140300                 MOVE 'N' TO H-SS-BLEND-IND
140400                 MOVE 'N' TO H-SS-COST-IND
140500                 MOVE 'N' TO H-SS-PERDIEM-IND
140600             ELSE
140700                 IF B-DISCHARGE-DATE < 20121229 AND
140800                   H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
140900                     MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
141000                     MOVE 22 TO PPS-RTC
141100                     MOVE 'Y' TO H-SS-BLEND-IND
141200                     MOVE 'N' TO H-SS-COST-IND
141300                     MOVE 'N' TO H-SS-PERDIEM-IND
141400                     MOVE 'N' TO H-SS-IPPSCOMP-IND
141500                 END-IF
141600             END-IF
141700         END-IF
141800     END-IF.
141900
142000 3400-SHORT-STAY-EXIT.
142100      EXIT.
142200
142300
142400***************************************************************
142500*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
142600*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
142700*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
142800*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
142900***************************************************************
143000 3600-SS-BLENDED-PMT.
143100***************************************************************
143200
143300*** ------------------------------------------------------ ***
143400*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
143500*** ------------------------------------------------------ ***
143600     IF H-SSOT < 25
143700        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
143800          H-LOS / H-SSOT
143900     ELSE
144000        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
144100          H-LOS / 25
144200     END-IF.
144300
144400     IF H-LTCH-BLEND-PCT > 1
144500        MOVE 1 TO H-LTCH-BLEND-PCT
144600     END-IF.
144700
144800
144900*** ------------------------------------------------------ ***
145000*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
145100*** ------------------------------------------------------ ***
145200     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
145300        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
145400
145500
145600*** ------------------------------------------------------ ***
145700*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
145800*** ------------------------------------------------------ ***
145900     PERFORM 3650-SS-IPPS-COMP-PMT
146000        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
146100
146200
146300*** ------------------------------------------------------ ***
146400*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
146500*** ------------------------------------------------------ ***
146600     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
146700       1 - H-LTCH-BLEND-PCT.
146800
146900
147000*** ------------------------------------------------------ ***
147100*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
147200*** ------------------------------------------------------ ***
147300     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
147400       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
147500
147600
147700*** ------------------------------------------------------ ***
147800*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
147900*** ------------------------------------------------------ ***
148000     COMPUTE H-SS-BLENDED-PMT ROUNDED =
148100       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
148200
148300
148400 3600-SS-BLENDED-PMT-EXIT.
148500      EXIT.
148600
148700
148800***************************************************************
148900*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
149000*   PER DIEM PAYMENT AMOUNT                                   *
149100***************************************************************
149200 3650-SS-IPPS-COMP-PMT.
149300***************************************************************
149400
149500*** -------------------------------------------------------
149600*** OPERATING TEACHING ADJUSTMENT
149700*** -------------------------------------------------------
149800     COMPUTE H-OPER-IME-TEACH ROUNDED =
149900        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
150000
150100
150200*** -------------------------------------------------------
150300*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
150400*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%
150500*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL
150600***              THIS CHANGE IS RETROACTIVE TO 10/01/2008
150700*** -------------------------------------------------------
150800     IF H-CAPI-IME-RATIO > 1.5000
150900        MOVE 1.5000 TO H-CAPI-IME-RATIO.
151000
151100     COMPUTE H-CAPI-IME-TEACH ROUNDED =
151200        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).
151300
151400
151500*** -------------------------------------------------------
151600*** OPERATING DSH ADJUSTMENT
151700*** -------------------------------------------------------
151800
151900*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
152000*---------------------------------------------------
152100     IF ALL-RURAL
152200        SET RURAL-CBSA TO TRUE
152300     ELSE
152400        SET URBAN-CBSA TO TRUE
152500     END-IF.
152600
152700
152800*2) CALCULATE THE OPERATING DSH PERCENT
152900*--------------------------------------
153000     COMPUTE H-OPER-DSH-PCT ROUNDED =
153100        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
153200
153300
153400*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
153500*-----------------------------------------------------
153600
153700*    URBAN, < 100 BEDS
153800*    -----------------
153900     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
154000        H-OPER-DSH-PCT >= .15
154100          MOVE '3' TO H-GEO-CLASS
154200     ELSE
154300
154400
154500*   URBAN, >= 100 BEDS
154600*   ------------------
154700       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
154800          H-OPER-DSH-PCT >= .15
154900            MOVE '2' TO H-GEO-CLASS
155000       ELSE
155100
155200
155300*   RURAL, >= 500 BEDS
155400*   ------------------
155500         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
155600            H-OPER-DSH-PCT >= .15
155700              MOVE '2' TO H-GEO-CLASS
155800         ELSE
155900
156000
156100*   RURAL, < 500 BEDS
156200*   -----------------
156300           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
156400              H-OPER-DSH-PCT >= .15
156500                MOVE '3' TO H-GEO-CLASS
156600           ELSE
156700
156800
156900*   OTHER
157000*   -----------------
157100              MOVE '4' TO H-GEO-CLASS
157200
157300           END-IF
157400         END-IF
157500       END-IF
157600     END-IF.
157700
157800
157900*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
158000*-----------------------------------------------------------
158100     EVALUATE H-GEO-CLASS
158200
158300*      GEOGRAPHIC CLASS 2
158400*      ------------------
158500       WHEN '2'
158600          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
158700             COMPUTE H-OPER-DSH ROUNDED =
158800               ((H-OPER-DSH-PCT - .15) * .65) + .025
158900          ELSE
159000             IF H-OPER-DSH-PCT > .202
159100                COMPUTE H-OPER-DSH ROUNDED =
159200                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
159300             ELSE
159400                MOVE ZEROS TO H-OPER-DSH
159500             END-IF
159600          END-IF
159700
159800*      GEOGRAPHIC CLASS 3
159900*      ------------------
160000       WHEN '3'
160100          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
160200             COMPUTE H-OPER-DSH ROUNDED =
160300               ((H-OPER-DSH-PCT - .15) * .65) + .025
160400             IF H-OPER-DSH > .12
160500                MOVE .12 TO H-OPER-DSH
160600             END-IF
160700          ELSE
160800             IF H-OPER-DSH-PCT > .202
160900                COMPUTE H-OPER-DSH ROUNDED =
161000                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
161100                IF H-OPER-DSH > .12
161200                   MOVE .12 TO H-OPER-DSH
161300                END-IF
161400             ELSE
161500               MOVE ZEROS TO H-OPER-DSH
161600             END-IF
161700          END-IF
161800
161900*      GEOGRAPHIC CLASS 4
162000*      ------------------
162100       WHEN '4'
162200          MOVE ZEROS TO H-OPER-DSH
162300
162400     END-EVALUATE.
162500
162600
162700*** -------------------------------------------------------
162800*** CURRENT OPERATING DSH PAYMENT REDUCTION
162900*** -------------------------------------------------------
163000     COMPUTE H-OPER-DSH ROUNDED =
163100             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.
163200
163300*** -------------------------------------------------------
163400*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
163500*** -------------------------------------------------------
163600     IF URBAN-CBSA AND H-BED-SIZE >= 100
163700        COMPUTE H-CAPI-DSH ROUNDED =
163800          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
163900     ELSE
164000        MOVE ZEROS TO H-CAPI-DSH
164100     END-IF.
164200
164300
164400*** -------------------------------------------------------
164500*** OPERATING PAYMENT (STANDARD AMOUNT)
164600*** -------------------------------------------------------
164700     IF (P-NEW-STATE = 02 OR 12)
164800        MOVE P-NEW-COLA TO H-OPER-COLA
164900     ELSE
165000        MOVE 1.000 TO H-OPER-COLA
165100     END-IF.
165200
165300     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
165400       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +
165500         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
165600         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
165700
165800
165900*** -------------------------------------------------------
166000*** CAPITAL PAYMENT (CAPITAL RATE)
166100*** -------------------------------------------------------
166200     COMPUTE H-CAPI-COLA ROUNDED =
166300       (.3152 * (H-OPER-COLA - 1) + 1).
166400
166500*--------------------------------------------------------------*
166600*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
166700*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
166800*--------------------------------------------------------------*
166900     IF LARGE-URBAN
167000        MOVE 1.00 TO H-LRGURB-ADD-ON
167100     ELSE
167200        MOVE 1.00 TO H-LRGURB-ADD-ON
167300     END-IF.
167400
167500     COMPUTE H-CAPI-GAF ROUNDED =
167600       (H-IPPS-WAGE-INDEX ** .6848).
167700
167800     COMPUTE H-CAPI-PMT ROUNDED =
167900       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
168000       H-LRGURB-ADD-ON *  H-CAPI-COLA *
168100       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
168200
168300
168400*** -------------------------------------------------------
168500*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
168600*** -------------------------------------------------------
168700     COMPUTE H-IPPS-PAY-AMT ROUNDED =
168800       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
168900
169000
169100*** -------------------------------------------------------
169200*** IPPS COMPARABLE PER DIEM PAYMENT
169300*** -------------------------------------------------------
169400     COMPUTE H-IPPS-PER-DIEM ROUNDED =
169500       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
169600
169700     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
169800        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
169900     END-IF.
170000
170100*** -------------------------------------------------------
170200*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
170300*** -------------------------------------------------------
170400     IF P-NEW-STATE = 40
170500        PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT
170600     END-IF.
170700
170800
170900 3650-SS-IPPS-COMP-PMT-EXIT.
171000      EXIT.
171100
171200
171300***************************************************************
171400 3675-SS-IPPS-COMP-PR-PMT.
171500***************************************************************
171600
171700*** -------------------------------------------------------
171800*** PUERTO RICO OPERATING PAYMENT (STANDARD AMOUNT)
171900*** -------------------------------------------------------
172000     COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =
172100        ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +
172200          (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *
172300          H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
172400
172500
172600*** -------------------------------------------------------
172700*** PUERTO RICO CAPITAL PAYMENT (CAPITAL RATE)
172800*** -------------------------------------------------------
172900     COMPUTE H-PR-CAPI-GAF ROUNDED =
173000        (W-IPPS-PR-WAGE-INDEX ** .6848).
173100
173200     COMPUTE H-PR-CAPI-PMT ROUNDED =
173300        H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *
173400        H-LRGURB-ADD-ON * H-CAPI-COLA *
173500        (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
173600
173700
173800*** -------------------------------------------------------
173900*** PR IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
174000*** -------------------------------------------------------
174100     COMPUTE H-IPPS-PR-PAY-AMT ROUNDED =
174200        H-PR-STAND-AMT-OPER-PMT + H-PR-CAPI-PMT.
174300
174400
174500*** -------------------------------------------------------
174600*** PUERTO RICO IPPS COMPARABLE PER DIEM PAYMENT
174700*** -------------------------------------------------------
174800     COMPUTE H-IPPS-PR-PER-DIEM ROUNDED =
174900        (H-IPPS-PR-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
175000
175100     IF H-IPPS-PR-PER-DIEM > H-IPPS-PR-PAY-AMT
175200        MOVE H-IPPS-PR-PAY-AMT TO H-IPPS-PR-PER-DIEM
175300     END-IF.
175400
175500
175600*** -------------------------------------------------------
175700*** BLEND FEDERAL PER DIEM AND PUERTO RICO PER DIEM
175800*** -------------------------------------------------------
175900     COMPUTE H-IPPS-PER-DIEM ROUNDED =
176000        (H-IPPS-PER-DIEM    * H-NAT-IPPS-PMT-PCT) +
176100        (H-IPPS-PR-PER-DIEM * H-PR-IPPS-PMT-PCT ).
176200
176300
176400 3675-EXIT.
176500      EXIT.
176600
176700
176800***************************************************************
176900 4000-SPECIAL-PROVIDER.
177000***************************************************************
177100
177200*** PROCESS FOR CY2003
177300*** ------------------
177400     IF (B-DISCHARGE-DATE >= 20030701) AND
177500        (B-DISCHARGE-DATE <  20040101)
177600        COMPUTE H-SS-COST ROUNDED =
177700            (PPS-FAC-COSTS * 1.95)
177800        COMPUTE H-SS-PAY-AMT ROUNDED =
177900         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
178000     END-IF
178100
178200
178300*** PROCESS FOR CY2004
178400*** ------------------
178500     IF (B-DISCHARGE-DATE >= 20040101) AND
178600        (B-DISCHARGE-DATE <  20050101)
178700        COMPUTE H-SS-COST ROUNDED =
178800            (PPS-FAC-COSTS * 1.93)
178900        COMPUTE H-SS-PAY-AMT ROUNDED =
179000          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
179100     END-IF
179200
179300
179400*** PROCESS FOR CY2005
179500*** ------------------
179600     IF (B-DISCHARGE-DATE >= 20050101) AND
179700        (B-DISCHARGE-DATE <  20060101)
179800        COMPUTE H-SS-COST ROUNDED =
179900            (PPS-FAC-COSTS * 1.65)
180000        COMPUTE H-SS-PAY-AMT ROUNDED =
180100          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
180200     END-IF
180300
180400
180500*** PROCESS FOR CY2006
180600*** ------------------
180700     IF (B-DISCHARGE-DATE >= 20060101) AND
180800        (B-DISCHARGE-DATE <  20070101)
180900        COMPUTE H-SS-COST ROUNDED =
181000            (PPS-FAC-COSTS * 1.36)
181100        COMPUTE H-SS-PAY-AMT ROUNDED =
181200          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
181300     END-IF
181400
181500
181600*** PROCESS FOR CY2007 AND AFTER
181700*** ----------------------------
181800     IF (B-DISCHARGE-DATE >= 20070101)
181900        COMPUTE H-SS-COST ROUNDED =
182000            (PPS-FAC-COSTS * 1.2)
182100        COMPUTE H-SS-PAY-AMT ROUNDED =
182200          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
182300     END-IF.
182400
182500 4000-SPECIAL-PROVIDER-EXIT.
182600      EXIT.
182700
182800
182900***************************************************************
183000*   CALCULATE THE OUTLIER THRESHOLD                           *
183100*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
183200*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
183300*   SET RETURN CODE TO INDICATE OUTLIER PAYMENT METHOD        *
183400***************************************************************
183500 7000-CALC-OUTLIER.
183600***************************************************************
183700
183800     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
183900         PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT.
184000
184100     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
184200        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
184300         ((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
184400           * PPS-BDGT-NEUT-RATE * H-BLEND-PPS.
184500
184600     IF B-SPEC-PAY-IND = '1'
184700        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
184800
184900     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 21
185000        MOVE 24 TO PPS-RTC.
185100
185200     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 22
185300        MOVE 25 TO PPS-RTC.
185400
185500     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 26
185600        MOVE 27 TO PPS-RTC.
185700
185800     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 00
185900        MOVE 01 TO PPS-RTC.
186000
186100     IF (PPS-RTC = 00 OR 20 OR 21 OR 22 OR 26)
186200        IF PPS-REG-DAYS-USED > H-SSOT
186300           MOVE 0 TO PPS-LTR-DAYS-USED
186400        ELSE
186500           NEXT SENTENCE.
186600
186700     IF (PPS-RTC = 01 OR 24 OR 25 OR 27) OR
186800        (PPS-COT-IND = 'Y')
186900
187000        IF (B-COV-DAYS < H-LOS) OR
187100           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
187200           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
187300             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
187400
187500*** ------------------------------------------------------- ***
187600*** SET PPS-RTC TO 67 IN MAINFRAME PRICER, NOT IN PC PRICER ***
187700*** (IN PC PRICER, PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS)   ***
187800*** ------------------------------------------------------- ***
187900           IF NOT PC-PRICER
188000              MOVE 67 TO PPS-RTC
188100           END-IF
188200
188300        ELSE
188400           NEXT SENTENCE
188500        END-IF
188600     ELSE
188700        NEXT SENTENCE
188800     END-IF.
188900
189000
189100 7000-EXIT.
189200      EXIT.
189300
189400
189500***************************************************************
189600*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
189700*   SET RTC FOR SPECIFIED BLEND YEAR INDICATOR.               *
189800***************************************************************
189900 8000-BLEND.
190000***************************************************************
190100
190200     COMPUTE H-LOS-RATIO ROUNDED = H-LOS / PPS-AVG-LOS.
190300
190400     IF H-LOS-RATIO > 1
190500        COMPUTE H-LOS-RATIO = ((H-LOS-RATIO - 1) * .8) + 1.
190600
190700     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
190800           (PPS-DRG-ADJ-PAY-AMT * PPS-BDGT-NEUT-RATE)
190900             * H-BLEND-PPS.
191000
191100     COMPUTE PPS-NEW-FAC-SPEC-RATE ROUNDED =
191200            (P-NEW-FAC-SPEC-RATE * PPS-BDGT-NEUT-RATE)
191300              * H-BLEND-FAC * H-LOS-RATIO.
191400
191500     COMPUTE PPS-FINAL-PAY-AMT =
191600          PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
191700              + PPS-NEW-FAC-SPEC-RATE.
191800
191900
192000*----------------------------------------------------------*
192100* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/O OUTLIER *
192200*----------------------------------------------------------*
192300     IF (PPS-RTC = 20 OR 21 OR 22 OR 26) AND (H-BLEND-RTC > 0)
192400          COMPUTE PPS-RTC = H-BLEND-RTC + 2
192500
192600*----------------------------------------------------------*
192700* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/ OUTLIER  *
192800*----------------------------------------------------------*
192900     ELSE
193000        IF (PPS-RTC = 24 OR 25 OR 27) AND (H-BLEND-RTC > 0)
193100           COMPUTE PPS-RTC = H-BLEND-RTC + 3
193200
193300*----------------------------------------------------------*
193400* CALCULATE RETURN CODE FOR ALL OTHER BILLS                *
193500*----------------------------------------------------------*
193600        ELSE
193700           ADD H-BLEND-RTC TO PPS-RTC
193800
193900        END-IF
194000     END-IF.
194100
194200 8000-EXIT.
194300      EXIT.
194400
194500
194600***************************************************************
194700*   CALCULATE THE "FINAL" PAYMENT AMOUNT FOR SUBCLAUSE II     *
194800*   PROVIDERS AND SET APPROPRIATE RETURN CODE (PPS-RTC)       *
194900***************************************************************
195000 8100-SUBCLAUSEII-FINAL-PAY.
195100***************************************************************
195200
195300*----------------------------------------------------------*
195400* CALCULATE FINAL PAYMENT AMOUNT                           *
195500*----------------------------------------------------------*
195600     COMPUTE PPS-FINAL-PAY-AMT ROUNDED =
195700             P-NEW-FAC-SPEC-RATE *
195800             B-CST-RPT-DAYS.
195900
196000*----------------------------------------------------------*
196100* DETERMINE RETURN CODE                                    *
196200*----------------------------------------------------------*
196300     IF PPS-OUTLIER-PAY-AMT > 0
196400        MOVE 29 TO PPS-RTC
196500     ELSE
196600        MOVE 28 TO PPS-RTC
196700     END-IF.
196800
196900*-------------------------------------------------------------*
197000* MOVE PER DIEM AMOUNT TO OUTPUT RECORD VARIABLE              *
197100*-------------------------------------------------------------*
197200     MOVE P-NEW-FAC-SPEC-RATE TO PPS-NEW-FAC-SPEC-RATE.
197300
197400*-------------------------------------------------------------*
197500* INITIALIZE OUTPUT FIELDS THAT DON'T APPLY TO SUBCLAUSE II   *
197600*-------------------------------------------------------------*
197700     INITIALIZE PPS-OUTLIER-PAY-AMT
197800                PPS-DRG-ADJ-PAY-AMT
197900                PPS-FED-PAY-AMT
198000                PPS-FAC-COSTS
198100                PPS-SUBM-DRG-CODE
198200                PPS-NAT-LABOR-PCT
198300                PPS-NAT-NONLABOR-PCT
198400                PPS-STD-FED-RATE
198500                PPS-BDGT-NEUT-RATE
198600                PPS-IPTHRESH.
198700
198800 8100-EXIT.
198900      EXIT.
199000
199100
199200***************************************************************
199300 9000-MOVE-RESULTS.
199400***************************************************************
199500
199600     IF PPS-RTC < 50
199700        MOVE H-LOS TO PPS-LOS
199800        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
199900     ELSE
200000       INITIALIZE PPS-DATA
200100       INITIALIZE PPS-OTHER-DATA
200200
200300*** ----------------------------------- ***
200400*** ADDED FOR JULY 2006 RELEASE (V07.1) ***
200500*** ----------------------------------- ***
200600       INITIALIZE PPS-CBSA
200700       INITIALIZE HOLD-PPS-COMPONENTS
200800
200900       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
201000     END-IF.
201100
201200*** *************************************************** ***
201300*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***
201400*** *************************************************** ***
201500*
201600*    IF (B-PROVIDER-NO = '332006')
201700*    IF (B-PROVIDER-NO = '341501' OR
201800*                        '341502' OR
201900*                        '342015' OR
202000*                        '391504' OR
202100*                        '391505' OR
202200*                        '371506' OR
202300*                        '371507' OR
202400*                        '441508' OR
202500*                        '442006' OR
202600*                        '36150A' OR
202700*                        '36150B' OR
202800*                        '37150C' OR
202900*                        '37150D' OR
203000*                        '02150E' OR
203100*                        '332006' OR
203200*                        '311501' OR
203300*                        '391502' OR
203400*                        '671503' OR
203500*                        '361504' OR
203600*                        '39150L' OR
203700*                        '051506' OR
203800*                        '091508' OR
203900*                        '401507')
204000*
204100*    DISPLAY '---------------------------------------------'
204200*    DISPLAY '*********************************************'
204300*    DISPLAY '---------------------------------------------'
204400*    DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
204500*    DISPLAY 'PPS-RTC '                  PPS-RTC
204600*    DISPLAY 'PSF EFFECTIVE DATE '       P-NEW-EFF-DATE
204700*    DISPLAY 'CBSA EFF DATE '            W-EFF-DATE
204800*    DISPLAY 'BILL DISCHARGE DATE '      B-DISCHARGE-DATE
204900*    DISPLAY 'P-NEW-FAC-SPEC-RATE '      P-NEW-FAC-SPEC-RATE
205000*    DISPLAY 'COST REPORT DAYS '         B-CST-RPT-DAYS
205100*    DISPLAY '---------------------------------------------'
205200*    DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
205300*    DISPLAY 'PPS-RTC '                  PPS-RTC
205400*    DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT
205500*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
205600*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
205700*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
205800*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
205900*    DISPLAY 'PPS-CBSA '                 PPS-CBSA
206000*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
206100*    DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
206200*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
206300*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
206400*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
206500*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE
206600*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
206700*    DISPLAY 'H-SSOT '                   H-SSOT
206800*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
206900*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
207000*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
207100*    DISPLAY 'H-LOS '                    H-LOS
207200*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS
207300*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
207400*    DISPLAY 'H-SSOT '                   H-SSOT
207500*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
207600*    DISPLAY 'H-BLEND-FAC '              H-BLEND-FAC
207700*    DISPLAY 'H-BLEND-PPS '              H-BLEND-PPS
207800*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
207900*    DISPLAY 'P-NEW-OPER-CSTCHG-RATIO '  P-NEW-OPER-CSTCHG-RATIO
208000*    DISPLAY 'H-SS-COST '                H-SS-COST
208100*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
208200*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
208300*    DISPLAY 'H-FIXED-LOSS-AMT '         H-FIXED-LOSS-AMT
208400*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
208500*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
208600*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
208700*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
208800*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
208900*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
209000*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
209100*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
209200*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
209300*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
209400*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
209500*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE
209600*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
209700*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
209800*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
209900*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
210000*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
210100*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
210200*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND
210300*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
210400*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
210500*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
210600*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
210700*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
210800*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
210900*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
211000*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
211100*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
211200*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
211300*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
211400*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
211500*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
211600*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
211700*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
211800*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
211900*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
212000*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
212100*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
212200*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
212300*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
212400*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
212500*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
212600*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
212700*    DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT
212800*    DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT
212900*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
213000*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
213100*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
213200*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
213300*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
213400*
213500*    END-IF.
213600
213700 9000-EXIT.
213800      EXIT.
213900
214000******        L A S T   S O U R C E   S T A T E M E N T   *****
