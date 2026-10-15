000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL170.
000300*AUTHOR.         CMS.
000400*REMARKS.        EFFECTIVE DATE OCTOBER 1, 2016
000500***********************************************************
000600*
000700* AUGUST 25, 2016 *** IMPLEMENTS CR9579, CR9599, AND CR9723
000710*
000800* FOR VERSION 17.0 MADE THE FOLLOWING CHANGES:
000810*
000900* - ADDED DATA ELEMENT FOR STATE CODE FROM THE PROVIDER SPECIFIC
000910*   FILE
001000*   - ENTER THE 2-DIGIT STATE WHERE THE PROVIDER IS LOCATED. ENTER
001010*     ONLY THE FIRST (LOWEST) CODE FOR A GIVEN STATE. FOR EXAMPLE,
001110*     EFFECTIVE OCTOBER 1, 2005, FLORIDA HAS THE FOLLOWING STATE
001200*     CODES: 10, 68, AND69. MACS SHALL ENTER A "10" FOR FLORIDA'S
001300*     STATE CODE.
001400*     LIST OF VALID STATE CODES IS LOCATED IN 100-07, CHAPTER 2,
001500*     SECTION 2779A1.
001600* - APPLY THE BUDGET NEUTRALITY ADJUSTMENT TO SITE-
001700*   NEUTRAL PAYMENTS
001800* - APPLY THE BUDGET NEUTRALITY ADJUSTMENT ONLY TO THE
001900*   "BASE" SITE-NEUTRAL PAYMENT (SUCH AS THE IPPS-
002000*   COMPARABLE AMOUNT) AFTER THE HIGH-COST OUTLIER IS MADE
002100*   AND DO NOT APPLY THE BUDGET NEUTRALITY ADJUSTMENT TO
002200*   ANY APPLICABLE HIGH-COST OUTLIER PAYMENT
002300*
002400* APPLIED THE CHANGES FROM THE
002500* FY 2017 LTCH PPS PRICER SPEC SHEET (AS OF 8-24-2016)
002600* - STANDARD FEDERAL RATES (BASED ON QUALITY DATA REPORT
002700*   STATUS FOR FY17):
002800*    - FULL UPDATE (QUALITY INDICATOR ON PSF = 1):
002900*      $42476.41
003000*    - REDUCED UPDATE (QUALITY INDICATOR ON PSF = 0 OR
003100*       BLANK): $41641.49
003200* - LABOR SHARE: 66.5% (0.665)
003300* - NONLABOR SHARE: 33.5% (0.335)
003400* - WAGE INDEX - TABLES ATTACHED.
003500* - MS-LTC-DRG WEIGHTS/LENGTH OF STAY/IPPS COMPARABLE
003600*   THRESHOLD - TABLE ATTACHED.
003700* - HIGH COST OUTLIER FIXED-LOSS AMOUNTS (NO
003800*   POLICY/CALCULATION LOGIC CHANGES)
003900*    - STANDARD RATE CASES: $21943
004000*    - SITE NEUTRAL RATE CASES: $23573
004100* - SITE NEUTRAL RATE HCO BUDGET NEUTRALITY FACTOR: 0.949
004200*    - APPLIED TO TOTAL SITE NEUTRAL PAYMENT RATE AMOUNT
004300*      PRIOR TO APPLYING 50% TRANSITION BLEND FACTOR
004400*    - ONLY APPLY TO NON-HCO PORTION OF THE SITE NEUTRAL
004500*      PAYMENT RATE AMOUNT AND DO NOT APPLY TO THE ANY
004600*      APPLICABLE SITE NEUTRAL PAYMENT RATE HCO PAYMENT
004700*      (LOGIC CHANGE FOR FY 2017)
004800* - SHORT-STAY OUTLIERS (SSOS) - NO POLICY CHANGES
004900*   (UPDATED RATES/FACTORS BELOW)
005000* - SSO AND SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS:
005100*   (NOTE, SEPARATE PUERTO RICO RATES NO LONGER NEEDED
005200*    BEGINNING FY 2017)
005300*       - IPPS LABOR SHARE WAGE INDEX > 1: $3839.23
005400*       - IPPS NONLABOR SHARE WAGE INDEX > 1: $1676.91
005500*       - IPPS LABOR SHARE WAGE INDEX < /= 1: $3420.01
005600*       - IPPS NONLABOR SHARE WAGE INDEX < /= 1: $2096.13
005700*       - CAPITAL NATIONAL RATE: $446.79
005800*       (IPPS RATES BASED ON FORTHCOMING CORRECTION NOTICE
005900*       VALUES.)
006000*    - REDUCTION FACTOR FOR IPPS COMPARABLE OPERATING DSH
006100*      PAYMENT AMOUNT: 66.52% OR A FACTOR OF 0.6652. (THIS
006200*      REDUCTION IS NOT APPLIED TO THE CAPITAL DSH PAYMENT
006300*      CALCULATION.)
006400*    - USE FY 2017 IPPS AREA WAGE INDEXES & MS-DRG WEIGHTS/
006500*      LENGTH OF STAY
006600* - SPECIAL TREATMENT - PROVIDER 362006 (CALVARY
006700*   HOSPITAL) - THIS PROVIDER IS SUBJECT TO
006800*   THE NEW SITE NEUTRAL PRICING LOGIC AND WILL
006900*   CONTINUE TO BE PAID THE PER DIEM LOGIC.
007000*    - PER DIEM CALCULATION BASED ON COST
007100*      REPORT DAYS (NOT IPPS INLIER DAYS).
007200*
007300***********************************************************
007400 ENVIRONMENT DIVISION.
007500 CONFIGURATION SECTION.
007600 SOURCE-COMPUTER.            IBM-370.
007700 OBJECT-COMPUTER.            IBM-370.
007800 INPUT-OUTPUT  SECTION.
007900 FILE-CONTROL.
008000
008100 DATA DIVISION.
008200 FILE SECTION.
008300
008400 WORKING-STORAGE SECTION.
008500 01  W-STORAGE-REF                  PIC X(46)  VALUE
008600     'LTCAL170      - W O R K I N G   S T O R A G E'.
008700 01  CAL-VERSION                    PIC X(05)  VALUE 'V17.0'.
008800 01  PROGRAM-CONSTANTS.
008900     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
009000     05  VENT-ICD-10-CODE           PIC X(07) VALUE '5A1955Z'.
009100 01  PROGRAM-FLAGS.
009200     05  WS-PRIMARY-PMT-TYPE        PIC X(01).
009300         88 PMT-STANDARD-OLD       VALUE '1'.
009400         88 PMT-STANDARD-NEW       VALUE '2'.
009500         88 PMT-SITE-NEUTRAL       VALUE '3'.
009600         88 PMT-BLEND              VALUE '4'.
009700     05  WS-SECONDARY-PMT-TYPE-SNT  PIC X(01).
009800         88 PMT-SITE-NEUT-COST     VALUE '1'.
009900         88 PMT-SITE-NEUT-IPPS     VALUE '2'.
010000     05  WS-SECONDARY-PMT-TYPE-STD  PIC X(01).
010100         88 PMT-STANDARD-FULL      VALUE '1'.
010200         88 PMT-STANDARD-SSO       VALUE '2'.
010300     05  WS-VENT-STATUS             PIC X(01).
010400         88 VENT-PRESENT           VALUE 'Y'.
010500         88 VENT-NOT-PRESENT       VALUE 'N'.
010600
010700
010800***************************************************************
010900*    LAYUP TABLE AREA FOR FY2015 LTC-DRG                      *
011000*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
011100***************************************************************
011200 COPY LTDRG170.
011300
011400
011500***************************************************************
011600*    LAYUP TABLE AREA FOR FY2015 IPPS-DRG                     *
011700*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
011800***************************************************************
011900 COPY IPDRG170.
012000
012100
012200***************************************************************
012300*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
012400***************************************************************
012500 01  HOLD-PPS-COMPONENTS.
012600     05  H-LOS                        PIC 9(03).
012700     05  H-REG-DAYS                   PIC 9(03).
012800     05  H-TOTAL-DAYS                 PIC 9(05).
012900     05  H-SSOT                       PIC 9(02)V9(01).
013000     05  H-BLEND-RTC                  PIC 9(02).
013100     05  H-BLEND-SNT                  PIC 9(01)V9(01).
013200     05  H-BLEND-STD                  PIC 9(01)V9(01).
013300     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
013400     05  H-SS-COST                    PIC 9(07)V9(02).
013500     05  H-LABOR-PORTION              PIC 9(07)V9(06).
013600     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
013700     05  H-FIXED-LOSS-AMT-STD         PIC 9(07)V9(02).
013800     05  H-FIXED-LOSS-AMT-SNT         PIC 9(07)V9(02).
013900     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
014000     05  H-LOS-RATIO                  PIC 9(01)V9(05).
014100
014200*** --------------------------------------------------- ***
014300*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
014400*** --------------------------------------------------- ***
014500     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
014600     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
014700     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
014800     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
014900     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
015000     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
015100     05  H-INTERN-RATIO               PIC 9(01)V9(04).
015200     05  H-CAPI-IME-RATIO             PIC 9V9999.
015300     05  H-BED-SIZE                   PIC 9(05).
015400     05  H-OPER-DSH-PCT               PIC V9(04).
015500     05  H-SSI-RATIO                  PIC V9(04).
015600     05  H-MEDICAID-RATIO             PIC V9(04).
015700     05  H-OPER-DSH                   PIC 9(01)V9(04).
015800     05  H-CAPI-DSH                   PIC 9(01)V9(04).
015900     05  H-GEO-CLASS                  PIC X(01).
016000     05  H-URBAN-IND                  PIC X(01).
016100           88 URBAN-CBSA           VALUE '1'.
016200           88 RURAL-CBSA           VALUE '0'.
016300     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
016400     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
016500     05  H-CAPI-PMT                   PIC 9(07)V9(02).
016600     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
016700     05  H-CAPI-GAF                   PIC 9(05)V9(04).
016800     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
016900     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
017000     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
017100     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
017200     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
017300     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
017400     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
017500     05  H-OPER-COLA                  PIC 9(01)V9(03).
017600     05  H-CAPI-COLA                  PIC 9(01)V9(03).
017700     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
017800     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
017900     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
018000     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
018100     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
018200     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
018300     05  H-IPPS-DAYS-CUTOFF           PIC 9(02)V9(01).
018400     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
018500     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
018600     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
018700*    05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
018800*    05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
018900     05  H-NAT-OPER-IPPS-PMT-PCT      PIC 9(01)V9(02).
019000     05  H-PR-OPER-IPPS-PMT-PCT       PIC 9(01)V9(02).
019100     05  H-NAT-CAPI-IPPS-PMT-PCT      PIC 9(01)V9(02).
019200     05  H-PR-CAPI-IPPS-PMT-PCT       PIC 9(01)V9(02).
019300     05  H-COUNTER                    PIC 9(02).
019400     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).
019500     05  H-OPER-DSH-REDUCTION-FACTOR  PIC V9(04).
019600     05  H-OUTLIER-THRESHOLD-STD      PIC 9(07)V9(02).
019700     05  H-BDGT-NEUT-FACTOR           PIC 9(01)V9(06).
019800     05  H-OUTLIER-PAY-AMT-STD        PIC 9(07)V9(02).
019900     05  H-OUTLIER-PAY-AMT-SNT        PIC 9(07)V9(02).
020000
020100*** --------------------------------------------------- ***
020200*** VARIABLES FOR PC PRICER                             ***
020300*** --------------------------------------------------- ***
020400     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
020500     05  H-SS-COST-IND                PIC X.
020600     05  H-SS-PERDIEM-IND             PIC X.
020700     05  H-SS-BLEND-IND               PIC X.
020800     05  H-SS-IPPSCOMP-IND            PIC X.
020900
021000
021100*---------------------------------------------------------*
021200* 8-6-14 ADDED WK-HLDDRG-DATA AND WK-HLDDRG-DATA2 TO      *
021300* MATCH THE IPPS DRG TABLE DATA NAMES THAT WERE COPIED    *
021400* FROM THE FY14 IPPS PRICER CALCULATION PROGRAM           *
021500*---------------------------------------------------------*
021600
021700 01 WK-HLDDRG-DATA.
021800     05  HLDDRG-DATA.
021900         10  HLDDRG-DRGX               PIC X(03).
022000         10  FILLER1                   PIC X(01).
022100         10  HLDDRG-WEIGHT             PIC 9(02)V9(04).
022200         10  FILLER2                   PIC X(01).
022300         10  HLDDRG-GMALOS             PIC 9(02)V9(01).
022400         10  FILLER3                   PIC X(05).
022500         10  HLDDRG-LOW                PIC X(01).
022600         10  FILLER5                   PIC X(01).
022700         10  HLDDRG-ARITH-ALOS         PIC 9(02)V9(01).
022800         10  FILLER6                   PIC X(02).
022900         10  HLDDRG-PAC                PIC X(01).
023000         10  FILLER7                   PIC X(01).
023100         10  HLDDRG-SPPAC              PIC X(01).
023200         10  FILLER8                   PIC X(02).
023300         10  HLDDRG-DESC               PIC X(26).
023400
023500 01 WK-HLDDRG-DATA2.
023600     05  HLDDRG-DATA2.
023700         10  HLDDRG-DRGX2               PIC X(03).
023800         10  FILLER21                   PIC X(01).
023900         10  HLDDRG-WEIGHT2             PIC 9(02)V9(04).
024000         10  FILLER22                   PIC X(01).
024100         10  HLDDRG-GMALOS2             PIC 9(02)V9(01).
024200         10  FILLER23                   PIC X(05).
024300         10  HLDDRG-LOW2                PIC X(01).
024400         10  FILLER25                   PIC X(01).
024500         10  HLDDRG-ARITH-ALOS2         PIC 9(02)V9(01).
024600         10  FILLER26                   PIC X(02).
024700         10  HLDDRG-TRANS-FLAGS.
024800                   88  D-DRG-POSTACUTE-50-50
024900                   VALUE 'Y Y'.
025000                   88  D-DRG-POSTACUTE-PERDIEM
025100                   VALUE 'Y  '.
025200             15  HLDDRG-PAC2            PIC X(01).
025300             15  FILLER27               PIC X(01).
025400             15  HLDDRG-SPPAC2          PIC X(01).
025500         10  FILLER28                   PIC X(02).
025600         10  HLDDRG-DESC2               PIC X(26).
025700         10  HLDDRG-VALID               PIC X(01).
025800
025900
026000
026100
026200
026300 LINKAGE SECTION.
026400
026500**************************************************************
026600* THE LINKAGE SECTION CONTAINS DESCRIPTIONS OF THE FIELDS THAT
026700* CONTAIN VALUES THAT ARE PASSED FROM THE CALLING PROGRAM
026800* (LTDRV... IN THIS CASE)
026900**************************************************************
027000
027100
027200**************************************************************
027300* BILL-NEW-DATA IS THE BILL RECORD FROM THE LTDRV... PROGRAM
027400**************************************************************
027500 01  BILL-NEW-DATA.
027600     10  B-NPI10.
027700         15  B-NPI8               PIC X(08).
027800         15  B-NPI-FILLER         PIC X(02).
027900     10  B-PROVIDER-NO            PIC X(06).
028000     10  B-PATIENT-STATUS         PIC X(02).
028100     10  B-DRG-CODE               PIC 9(03).
028200     10  B-LOS                    PIC 9(03).
028300     10  B-COV-DAYS               PIC 9(03).
028400     10  B-LTR-DAYS               PIC 9(02).
028500     10  B-CST-RPT-DAYS           PIC 9(03).
028600     10  B-DISCHARGE-DATE.
028700         15  B-DISCHG-CC          PIC 9(02).
028800         15  B-DISCHG-YY          PIC 9(02).
028900         15  B-DISCHG-MM          PIC 9(02).
029000         15  B-DISCHG-DD          PIC 9(02).
029100     10  B-COV-CHARGES            PIC 9(07)V9(02).
029200     10  B-SPEC-PAY-IND           PIC X(01).
029300     05  B-REVIEW-CODE            PIC 9(02).
029400     05  B-DIAGNOSIS-CODE-TABLE.
029500         10  B-DIAGNOSIS-CODE     PIC X(07) OCCURS 25 TIMES
029600                                  INDEXED BY IDX-DIAG.
029700     05  B-PROCEDURE-CODE-TABLE.
029800         10  B-PROCEDURE-CODE     PIC X(07) OCCURS 25 TIMES
029900                                  INDEXED BY IDX-PROC.
030000     05  FILLER                   PIC X(20).
030100
030200
030300***************************************************************
030400***************************************************************
030500*                                                             *
030600*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *
030700*    AND PASSED BACK TO THE CALLING PROGRAM (LTDRV)           *
030800*    RETURN CODE VALUES (PPS-RTC)                             *
030900*                                                             *
031000*     ** OLD POLICY RETURN CODE VALUES AND DESCRIPTIONS       *
031100*     ** ----------------------------------------------       *
031200*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
031300*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
031400*                                                             *
031500*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
031600*                                                             *
031700*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
031800*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
031900*                                                             *
032000*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
032100*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
032200*                                                             *
032300*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
032400*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
032500*                                                             *
032600*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
032700*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
032800*                                                             *
032900*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
033000*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
033100*                                                             *
033200*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
033300*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
033400*                                                             *
033500*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
033600*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
033700*                                                             *
033800*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
033900*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
034000*                                                             *
034100*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
034200*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
034300*                                                             *
034400*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
034500*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
034600*                                                             *
034700*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
034800*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
034900*                                                             *
035000*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
035100*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
035200*                                                             *
035300*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
035400*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
035500*                                                             *
035600*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
035700*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
035800*                                                             *
035900*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
036000*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
036100*                                                             *
036200*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
036300*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
036400*                                                             *
036500*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
036600*                  WITHOUT OUTLIER                            *
036700*                                                             *
036800*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
036900*                  DIEM WITHOUT OUTLIER                       *
037000*                                                             *
037100*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
037200*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
037300*                  AMOUNT WITHOUT OUTLIER                     *
037400*                                                             *
037500*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
037600*                  DIEM WITH OUTLIER                          *
037700*                                                             *
037800*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
037900*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
038000*                  AMOUNT WITH OUTLIER                        *
038100*                                                             *
038200*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *
038300*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *
038400*            FOR IPPS COMPARABLE PER DIEM)                    *
038500*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *
038600*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *
038700*            FOR IPPS COMPARABLE PER DIEM)                    *
038800*                                                             *
038900*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
039000*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
039100*                                                             *
039200*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
039300*                  COMPARABLE THRESHOLD WITH OUTLIER          *
039400*                                                             *
039500*             28 = SUBCLAUSE (II) DOES NOT QUALIFY FOR AN     *
039600*                  OUTLIER                                    *
039700*                                                             *
039800*             29 = SUBCLAUSE (II) QUALIFIES FOR AN OUTLIER    *
039900*                                                             *
040000*                                                             *
040100*     ** OLD & NEW POLICY ERROR CODE VALUES AND DESCRIPTIONS  *
040200*     ** ---------------------------------------------------  *
040300*     *****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
040400*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
040500*             51 = PROVIDER RECORD TERMINATED                 *
040600*             52 = INVALID WAGE INDEX                         *
040700*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
040800*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
040900*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
041000*                                     OR                      *
041100*                  DISCHARGE DATE < CBSA EFF START DATE       *
041200*                  FOR PPS                                    *
041300*             56 = INVALID LENGTH OF STAY                     *
041400*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
041500*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
041600*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
041700*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
041800*                  OR BILL-LTR-DAYS > 60                      *
041900*             62 = INVALID NUMBER OF COVERED DAYS             *
042000*                  OR BILL-LTR-DAYS > COVERED DAYS            *
042100*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
042200*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
042300*                  OR COST OUTLIER THRESHOLD CALCULATION      *
042400*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *
042500*             72 = INVALID BLEND INDICATOR OR REVIEW CODE     *
042600*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
042700*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
042800*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *
042900*                                                             *
043000***************************************************************
043100***************************************************************
043200
043300
043400***************************************************************
043500* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
043600* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
043700***************************************************************
043800 01  PPS-DATA-ALL.
043900     05  PPS-RTC.
044000           88  OLD-ERROR-CODE        VALUE '50' THRU '99'.
044100         10  PPS-RTC-1                 PIC X.
044200               88  NEW-ERROR-CODE    VALUE 'D'.
044300         10  PPS-RTC-2                 PIC X.
044400     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
044500     05  PPS-DATA.
044600         10  PPS-MSA                   PIC X(04).
044700         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
044800         10  PPS-AVG-LOS               PIC 9(02)V9(01).
044900         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
045000         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
045100         10  PPS-LOS                   PIC 9(03).
045200         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
045300         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
045400         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
045500         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
045600         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
045700         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
045800         10  PPS-SUBM-DRG-CODE         PIC X(03).
045900               88  PSYCH-REHAB-DRG   VALUE
046000                   '876' '880' '881' '882' '883' '884'
046100                   '885' '887' '886' '894' '895' '896'
046200                   '897' '945' '946'.
046300         10  PPS-CALC-VERS-CD          PIC X(05).
046400         10  PPS-REG-DAYS-USED         PIC 9(03).
046500         10  PPS-LTR-DAYS-USED         PIC 9(03).
046600         10  PPS-BLEND-YEAR            PIC 9(01).
046700         10  PPS-COLA                  PIC 9(01)V9(03).
046800         10  FILLER                    PIC X(04).
046900     05  PPS-OTHER-DATA.
047000         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
047100         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
047200         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
047300         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
047400         10  PPS-IPTHRESH              PIC 9(03)V9(01).
047500         10  FILLER                    PIC X(16).
047600     05  PPS-PC-DATA.
047700         10  PPS-COT-IND               PIC X(01).
047800         10  H-PC-IND                  PIC X(02).
047900               88  PC-PRICER               VALUE 'PC'.
048000         10  FILLER                    PIC X(18).
048100
048200 01  PPS-CBSA                          PIC X(05).
048300
048400
048500 01  PPS-PAYMENT-DATA.
048600     05  PPS-SITE-NEUTRAL-COST-PMT     PIC 9(07)V99.
048700     05  PPS-SITE-NEUTRAL-IPPS-PMT     PIC 9(07)V99.
048800     05  PPS-STANDARD-FULL-PMT         PIC 9(07)V99.
048900     05  PPS-STANDARD-SSO-PMT          PIC 9(07)V99.
049000
049100
049200******************************************************************
049300*            THESE ARE THE VERSIONS OF THE LTDRV___              *
049400*           PROGRAMS THAT WILL BE PASSED BACK----                *
049500*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
049600******************************************************************
049700 01  PRICER-OPT-VERS-SW.
049800     05  PRICER-OPTION-SW          PIC X(01).
049900         88  ALL-TABLES-PASSED          VALUE 'A'.
050000         88  PROV-RECORD-PASSED         VALUE 'P'.
050100     05  PPS-VERSIONS.
050200         10  PPDRV-VERSION         PIC X(05).
050300
050400
050500**************************************************************
050600* PROV-NEW-HOLD IS THE PROVIDER RECORD THAT IS PASSED FROM   *
050700* LTDRV___) TO LTCAL___                                      *
050800**************************************************************
050900 01  PROV-NEW-HOLD.
051000     02  PROV-NEWREC-HOLD1.
051100         05  P-NEW-NPI10.
051200             10  P-NEW-NPI8             PIC X(08).
051300             10  P-NEW-NPI-FILLER       PIC X(02).
051400         05  P-NEW-PROVIDER-NO.
051500               88  SUBCLAUSEII-PROV       VALUE '332006'.
051600             10  P-NEW-STATE            PIC 9(02).
051700             10  FILLER                 PIC X(04).
051800         05  P-NEW-DATE-DATA.
051900             10  P-NEW-EFF-DATE.
052000                 15  P-NEW-EFF-DT-CC    PIC 9(02).
052100                 15  P-NEW-EFF-DT-YY    PIC 9(02).
052200                 15  P-NEW-EFF-DT-MM    PIC 9(02).
052300                 15  P-NEW-EFF-DT-DD    PIC 9(02).
052400             10  P-NEW-FY-BEGIN-DATE.
052500                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).
052600                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).
052700                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).
052800                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).
052900             10  P-NEW-REPORT-DATE.
053000                 15  P-NEW-REPORT-DT-CC PIC 9(02).
053100                 15  P-NEW-REPORT-DT-YY PIC 9(02).
053200                 15  P-NEW-REPORT-DT-MM PIC 9(02).
053300                 15  P-NEW-REPORT-DT-DD PIC 9(02).
053400             10  P-NEW-TERMINATION-DATE.
053500                 15  P-NEW-TERM-DT-CC   PIC 9(02).
053600                 15  P-NEW-TERM-DT-YY   PIC 9(02).
053700                 15  P-NEW-TERM-DT-MM   PIC 9(02).
053800                 15  P-NEW-TERM-DT-DD   PIC 9(02).
053900         05  P-NEW-WAIVER-CODE          PIC X(01).
054000             88  P-NEW-WAIVER-STATE       VALUE 'Y'.
054100         05  P-NEW-INTER-NO             PIC 9(05).
054200         05  P-NEW-PROVIDER-TYPE        PIC X(02).
054300         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
054400         05  P-NEW-CURRENT-DIV   REDEFINES
054500                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
054600         05  P-NEW-MSA-DATA.
054700             10  P-NEW-CHG-CODE-INDEX       PIC X.
054800             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT.
054900             10  P-NEW-GEO-LOC-MSA9   REDEFINES
055000                             P-NEW-GEO-LOC-MSAX  PIC 9(04).
055100             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT.
055200             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT.
055300             10  P-NEW-STAND-AMT-LOC-MSA9
055400                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.
055500                 15  P-NEW-RURAL-1ST.
055600                     20  P-NEW-STAND-RURAL  PIC XX.
055700                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.
055800                 15  P-NEW-RURAL-2ND        PIC XX.
055900         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.
056000         05  P-NEW-LUGAR                    PIC X.
056100         05  P-NEW-TEMP-RELIEF-IND          PIC X.
056200         05  P-NEW-FED-PPS-BLEND-IND        PIC X.
056300         05  P-NEW-STATE-CODE               PIC 9(02).
056400         05  P-NEW-STATE-CODE-X REDEFINES
056500               P-NEW-STATE-CODE             PIC X(02).
056600         05  FILLER                         PIC X(03).
056700     02  PROV-NEWREC-HOLD2.
056800         05  P-NEW-VARIABLES.
056900             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).
057000             10  P-NEW-COLA              PIC  9(01)V9(03).
057100             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).
057200             10  P-NEW-BED-SIZE          PIC  9(05).
057300             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).
057400             10  P-NEW-CMI               PIC  9(01)V9(04).
057500             10  P-NEW-SSI-RATIO         PIC  V9(04).
057600             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).
057700             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).
057800             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).
057900             10  P-NEW-DSH-PERCENT       PIC  V9(04).
058000             10  P-NEW-FYE-DATE          PIC  X(08).
058100         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).
058200         05  P-NEW-HOSP-QUAL-IND           PIC X(01).
058300         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.
058400         05  P-NEW-GEO-LOC-CBSA9 REDEFINES
058500                       P-NEW-GEO-LOC-CBSAX PIC 9(05).
058600         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES
058700                       P-NEW-GEO-LOC-CBSAX.
058800             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.
058900             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.
059000             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.
059100             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.
059200             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.
059300         05  FILLER                        PIC X(10).
059400         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).
059500     02  PROV-NEWREC-HOLD3.
059600         05  P-NEW-PASS-AMT-DATA.
059700             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.
059800             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.
059900             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.
060000             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.
060100         05  P-NEW-CAPI-DATA.
060200             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.
060300             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.
060400             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.
060500             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.
060600             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.
060700             15  P-NEW-CAPI-NEW-HOSP       PIC X.
060800             15  P-NEW-CAPI-IME            PIC 9V9999.
060900             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.
061000             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.
061100         05  FILLER                        PIC X(18).
061200
061300
061400******************************************************************
061500*                THIS IS THE LTCH WAGE-INDEX                     *
061600*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
061700*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *
061800******************************************************************
061900 01  WAGE-NEW-INDEX-RECORD.
062000     05  W-CBSA                        PIC X(5).
062100     05  W-EFF-DATE                    PIC X(8).
062200     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).
062300     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).
062400     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).
062500
062600
062700******************************************************************
062800*                THIS IS THE IPPS WAGE-INDEX                     *
062900*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
063000******************************************************************
063100 01  WAGE-NEW-IPPS-INDEX-RECORD.
063200     05  W-CBSA-IPPS.
063300         10 CBSA-IPPS-123              PIC X(3).
063400         10 CBSA-IPPS-45               PIC X(2).
063500     05  W-CBSA-IPPS-SIZE              PIC X.
063600         88  LARGE-URBAN       VALUE 'L'.
063700         88  OTHER-URBAN       VALUE 'O'.
063800         88  ALL-RURAL         VALUE 'R'.
063900     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).
064000     05  FILLER                        PIC X.
064100     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).
064200     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).
064300
064400
064500
064600 PROCEDURE DIVISION  USING BILL-NEW-DATA
064700                           PPS-DATA-ALL
064800                           PPS-CBSA
064900                           PPS-PAYMENT-DATA
065000                           PRICER-OPT-VERS-SW
065100                           PROV-NEW-HOLD
065200                           WAGE-NEW-INDEX-RECORD
065300                           WAGE-NEW-IPPS-INDEX-RECORD.
065400
065500
065600***************************************************************
065700*                                                             *
065800*    PROCESSING:                                              *
065900*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
066000*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
066100*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
066200*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
066300*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
066400*           GOBACK.                                           *
066500*        D. ASSEMBLE PRICING COMPONENTS.                      *
066600*        E. CALCULATE THE PRICE.                              *
066700*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
066800*                                                             *
066900***************************************************************
067000
067100
067200***************************************************************
067300 0000-MAINLINE-CONTROL.
067400***************************************************************
067500
067600     PERFORM 0100-INITIAL-ROUTINE
067700        THRU 0100-EXIT.
067800
067900     PERFORM 1000-EDIT-INPUT-DATA
068000        THRU 1000-EXIT.
068100
068200     IF PPS-RTC = '00'
068300        PERFORM 1700-EDIT-DRG-CODE
068400           THRU 1700-EXIT.
068500
068600     IF PPS-RTC = '00'
068700        PERFORM 1800-EDIT-IPPS-DRG-CODE
068800           THRU 1800-EXIT.
068900
069000     IF PPS-RTC = '00'
069100        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
069200           THRU 2000-EXIT.
069300
069400     IF PPS-RTC = '00'
069500        PERFORM 3000-CALC-PAYMENT
069600           THRU 3000-EXIT.
069700
069800     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
069900        PERFORM 6000-CALC-HIGH-COST-OUTLIER
070000           THRU 6000-EXIT.
070100
070200     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
070300        PERFORM 7000-SET-FINAL-RETURN-CODES
070400           THRU 7000-EXIT.
070500
070600     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
070700        PERFORM 8000-CALC-FINAL-PMT
070800           THRU 8000-EXIT.
070900
071000     PERFORM 9000-MOVE-RESULTS
071100        THRU 9000-EXIT.
071200
071300     GOBACK.
071400
071500
071600***************************************************************
071700 0100-INITIAL-ROUTINE.
071800***************************************************************
071900
072000     MOVE '00' TO PPS-RTC.
072100     INITIALIZE PPS-DATA.
072200     INITIALIZE PPS-OTHER-DATA.
072300     INITIALIZE PPS-CBSA.
072400     INITIALIZE PPS-PAYMENT-DATA.
072500     INITIALIZE HOLD-PPS-COMPONENTS.
072600     INITIALIZE PROGRAM-FLAGS.
072700     INITIALIZE WK-HLDDRG-DATA
072800                WK-HLDDRG-DATA2.
072900
073000     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.
073100
073200
073300*** ---------------------------------------------------- ***
073400*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***
073500*** ---------------------------------------------------- ***
073600     MOVE .665 TO PPS-NAT-LABOR-PCT.
073700     MOVE .335 TO PPS-NAT-NONLABOR-PCT.
073800
073900*** --------------------------------------------------------
074000*** NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
074100*** REPORTING OF QUALITY DATA.
074200*** - FULL UPDATE (QUALITY INDICATOR ON PSF = 1)
074300*** - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK)
074400*** --------------------------------------------------------
074500     IF P-NEW-HOSP-QUAL-IND = '1'
074600        MOVE 42476.41 TO PPS-STD-FED-RATE
074700     ELSE
074800        MOVE 41641.49 TO PPS-STD-FED-RATE.
074900     MOVE 21943.00 TO H-FIXED-LOSS-AMT-STD.
075000     MOVE 23573.00 TO H-FIXED-LOSS-AMT-SNT.
075100     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.
075200
075300*** ---------------------------------------------------- ***
075400*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
075500*** ---------------------------------------------------- ***
075600     MOVE 446.79 TO H-IPPS-CAPI-STD-FED-RATE.
075700
075800     MOVE W-IPPS-WAGE-INDEX TO H-IPPS-WAGE-INDEX.
075900
076000     IF H-IPPS-WAGE-INDEX > 1
076100           MOVE 3839.23 TO H-IPPS-NAT-LABOR-SHR
076200           MOVE 1676.91 TO H-IPPS-NAT-NONLABOR-SHR
076300     ELSE
076400           MOVE 3420.01 TO H-IPPS-NAT-LABOR-SHR
076500           MOVE 2096.13 TO H-IPPS-NAT-NONLABOR-SHR
076600     END-IF.
076700
076800*** ---------------------------------------------------- ***
076900*** OPERATING DSH REDUCTION FACTOR                       ***
077000*** -----------------------------------------------------***
077100     MOVE 0.6652 TO H-OPER-DSH-REDUCTION-FACTOR.
077200
077300 0100-EXIT.
077400      EXIT.
077500
077600
077700***************************************************************
077800*    INPUT DATA EDITS - IF ANY FAIL SET PPS-RTC               *
077900*    AND DO NOT ATTEMPT TO PRICE.                             *
078000***************************************************************
078100 1000-EDIT-INPUT-DATA.
078200***************************************************************
078300
078400*** -----------------------------------------------------------
078500*** EDIT BILL (BILL-NEW-DATA) INPUT & SET ERROR CODE IF FAIL
078600*** -----------------------------------------------------------
078700     IF (B-LOS NUMERIC) AND (B-LOS > 0)
078800        MOVE B-LOS TO H-LOS
078900     ELSE
079000        MOVE '56' TO PPS-RTC.
079100
079200     IF PPS-RTC = '00'
079300        IF P-NEW-COLA NOT NUMERIC
079400           MOVE '50' TO PPS-RTC.
079500
079600     IF PPS-RTC = '00'
079700        IF P-NEW-WAIVER-STATE
079800           MOVE '53' TO PPS-RTC.
079900
080000     IF PPS-RTC = '00'
080100        IF B-DRG-CODE NOT NUMERIC
080200           MOVE '54' TO PPS-RTC.
080300
080400     IF PPS-RTC = '00'
080500        IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
080600           (B-DISCHARGE-DATE < W-EFF-DATE))
080700            MOVE '55' TO PPS-RTC.
080800
080900     IF PPS-RTC = '00'
081000        IF P-NEW-TERMINATION-DATE > 00000000
081100           IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
081200              MOVE '51' TO PPS-RTC.
081300
081400     IF PPS-RTC = '00'
081500        IF B-COV-CHARGES NOT NUMERIC
081600           MOVE '58' TO PPS-RTC.
081700
081800     IF PPS-RTC = '00'
081900        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
082000           MOVE '61' TO PPS-RTC.
082100
082200     IF PPS-RTC = '00'
082300        IF (B-COV-DAYS NOT NUMERIC) OR
082400           (B-COV-DAYS = 0 AND H-LOS > 0)
082500           MOVE '62' TO PPS-RTC.
082600
082700     IF PPS-RTC = '00'
082800        IF B-LTR-DAYS > B-COV-DAYS
082900           MOVE '62' TO PPS-RTC.
083000
083100     IF PPS-RTC = '00'
083200        IF (B-REVIEW-CODE < 00 OR B-REVIEW-CODE > 08) OR
083300           (B-REVIEW-CODE NOT NUMERIC)
083400           MOVE '72' TO PPS-RTC.
083500
083600
083700*** -----------------------------------------------------------
083800*** CALCULATE DAY RELATED VARIABLE VALUES
083900*** -----------------------------------------------------------
084000     IF PPS-RTC = '00'
084100        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
084200        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
084300
084400     IF PPS-RTC = '00'
084500        PERFORM 1200-DAYS-USED
084600           THRU 1200-DAYS-USED-EXIT.
084700
084800
084900*** -----------------------------------------------------------
085000*** EDIT PSF FIELDS USED BY ALL CLAIMS & SET ERROR CODE IF FAIL
085100*** -----------------------------------------------------------
085200
085300*-------------------------------------------------------------*
085400* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
085500* (ALWAYS FED-FY-BEGIN-03)                                    *
085600*-------------------------------------------------------------*
085700     IF PPS-RTC = '00'
085800        IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
085900           MOVE '74' TO PPS-RTC.
086000
086100*-------------------------------------------------------------*
086200* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
086300*-------------------------------------------------------------*
086400     IF PPS-RTC = '00'
086500        IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
086600           MOVE '65' TO PPS-RTC.
086700
086800
086900*** -----------------------------------------------------------
087000*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
087100*** -----------------------------------------------------------
087200     IF PPS-RTC = '00'
087300        IF P-NEW-CAPI-IME NUMERIC
087400           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
087500        ELSE
087600           MOVE ZEROS TO H-CAPI-IME-RATIO
087700        END-IF
087800     END-IF.
087900
088000     IF PPS-RTC = '00'
088100        IF P-NEW-INTERN-RATIO NUMERIC
088200           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
088300        ELSE
088400           MOVE ZEROS TO H-INTERN-RATIO
088500        END-IF
088600     END-IF.
088700
088800     IF PPS-RTC = '00'
088900        IF P-NEW-BED-SIZE NUMERIC
089000           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
089100        ELSE
089200           MOVE ZEROS TO H-BED-SIZE
089300        END-IF
089400     END-IF.
089500
089600     IF PPS-RTC = '00'
089700        IF P-NEW-SSI-RATIO NUMERIC
089800           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
089900        ELSE
090000           MOVE ZEROS TO H-SSI-RATIO
090100        END-IF
090200     END-IF.
090300
090400     IF PPS-RTC = '00'
090500        IF P-NEW-MEDICAID-RATIO NUMERIC
090600           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
090700        ELSE
090800           MOVE ZEROS TO H-MEDICAID-RATIO
090900        END-IF
091000     END-IF.
091100
091200
091300 1000-EXIT.
091400      EXIT.
091500
091600
091700***************************************************************
091800 1200-DAYS-USED.
091900***************************************************************
092000
092100     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
092200        IF B-LTR-DAYS > H-LOS
092300           MOVE H-LOS TO PPS-LTR-DAYS-USED
092400        ELSE
092500           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
092600     ELSE
092700        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
092800           IF H-REG-DAYS > H-LOS
092900              MOVE H-LOS TO PPS-REG-DAYS-USED
093000           ELSE
093100              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
093200        ELSE
093300           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
093400              IF H-REG-DAYS > H-LOS
093500                 MOVE H-LOS TO PPS-REG-DAYS-USED
093600                 MOVE 0 TO PPS-LTR-DAYS-USED
093700              ELSE
093800                 IF H-TOTAL-DAYS > H-LOS
093900                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
094000                    COMPUTE PPS-LTR-DAYS-USED =
094100                            H-LOS - H-REG-DAYS
094200                 ELSE
094300                    IF H-TOTAL-DAYS <= H-LOS
094400                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
094500                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
094600                    ELSE
094700                       NEXT SENTENCE
094800           ELSE
094900              NEXT SENTENCE.
095000
095100 1200-DAYS-USED-EXIT.
095200      EXIT.
095300
095400
095500***************************************************************
095600*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
095700***************************************************************
095800 1700-EDIT-DRG-CODE.
095900***************************************************************
096000
096100     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
096200     IF PPS-RTC = '00'
096300        SEARCH ALL WWM-ENTRY
096400           AT END
096500             MOVE '54' TO PPS-RTC
096600        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
096700             PERFORM 1750-FIND-VALUE
096800                THRU 1750-EXIT
096900        END-SEARCH.
097000
097100 1700-EXIT.
097200      EXIT.
097300
097400
097500***************************************************************
097600*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
097700***************************************************************
097800 1750-FIND-VALUE.
097900***************************************************************
098000
098100      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
098200      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
098300      MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
098400
098500 1750-EXIT.
098600      EXIT.
098700
098800
098900***************************************************************
099000*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
099100***************************************************************
099200 1800-EDIT-IPPS-DRG-CODE.
099300***************************************************************
099400
099500**-------------------------------------------------------**
099600** THIS LOGIC WAS COPIED FROM THE IPPS PRICER (PPCAL140) **
099700** ENSURE IT STAYS CONSISTENT BECAUSE IT REFERENCES THE  **
099800** DRG TABLE USED BY THE IPPS PRICER.                    **
099900**-------------------------------------------------------**
100000
100100     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE
100200     SET DRG-IDX TO 1
100300     SEARCH DRG-TAB VARYING DRG-IDX
100400         AT END
100500           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC
100600           MOVE 'I' TO  HLDDRG-VALID
100700           MOVE '54' TO PPS-RTC
100800           GO TO 1800-EXIT
100900       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE
101000         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.
101100
101200
101300     MOVE  HLDDRG-DATA         TO WK-HLDDRG-DATA2.
101400     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.
101500     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2
101600                                  H-IPPS-DRG-WGT.
101700     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2
101800                                  H-IPPS-DRG-ALOS.
101900     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.
102000     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2
102100                                  H-IPPS-ARITH-ALOS.
102200     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.
102300     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.
102400     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.
102500     MOVE  'V'                 TO HLDDRG-VALID.
102600     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.
102700
102800 1800-EXIT.
102900      EXIT.
103000
103100
103200***************************************************************
103300***  GET THE PROVIDER SPECIFIC VARIABLES AND LTCH WAGE INDEX  *
103400*                                                             *
103500*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
103600*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
103700*    OF THAT VARIABLE.                                        *
103800*                                                             *
103900***************************************************************
104000 2000-ASSEMBLE-PPS-VARIABLES.
104100***************************************************************
104200
104300
104400*-------------------------------------------------------------*
104500* ASSIGN FULL (5/5) LTCH WAGE INDEX TO ALL CLAIMS DISCHARGED  *
104600* ON AND AFTER 7/1/2008 (THIRD COLUMN WAGE INDEX IN LTWIX***) *
104700*-------------------------------------------------------------*
104800     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
104900        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
105000     ELSE
105100        MOVE '52' TO PPS-RTC
105200        GO TO 2000-EXIT
105300     END-IF.
105400
105500
105600*-------------------------------------------------------------*
105700* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
105800*-------------------------------------------------------------*
105900     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
106000
106100*-------------------------------------------------------------*
106200* OLD POLICY CLAIMS MUST HAVE A BLEND YEAR INDICATOR OF 5     *
106300*-------------------------------------------------------------*
106400     IF B-REVIEW-CODE = 00 AND PPS-BLEND-YEAR NOT = 5
106500        MOVE 5 TO PPS-BLEND-YEAR
106600     END-IF.
106700
106800*-------------------------------------------------------------*
106900* NEW POLICY CLAIMS MUST HAVE A BLEND YR. IND. OF 6, 7, OR 8  *
107000*-------------------------------------------------------------*
107100     IF (B-REVIEW-CODE >= 01 AND B-REVIEW-CODE <= 08) AND
107200        (PPS-BLEND-YEAR < 6 OR PPS-BLEND-YEAR > 8)
107300        MOVE '72' TO PPS-RTC
107400        GO TO 2000-EXIT
107500     END-IF.
107600
107700*-------------------------------------------------------------*
107800* SET DEFAULT BLEND VARIABLE VALUES                           *
107900* - H-BLEND-STD = % STANDARD PMT CONTRIBUTES TO FINAL PMT     *
108000* - H-BLEND-SNT = % SITE NEUTRAL PMT CONTRIBUTES TO FINAL PMT *
108100*-------------------------------------------------------------*
108200     MOVE 0 TO H-BLEND-SNT.
108300     MOVE 1 TO H-BLEND-STD.
108400     MOVE 0 TO H-BLEND-RTC.
108500
108600
108700*-------------------------------------------------------------*
108800* FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII)          *
108900*-------------------------------------------------------------*
109000     IF (P-NEW-STATE = 02 OR 12)
109100        MOVE P-NEW-COLA TO PPS-COLA
109200     ELSE
109300        MOVE 1.000 TO PPS-COLA
109400     END-IF.
109500
109600
109700 2000-EXIT.
109800      EXIT.
109900
110000
110100***************************************************************
110200*    IF THE BILL & PSF DATA HAS PASSED ALL EDITS (RTC=00)     *
110300*        CALCULATE THE APPLICABLE CLAIM PAYMENT:              *
110400*           - STANDARD PAYMENT                                *
110500*           - SHORT STAY OUTLIER PAYMENT                      *
110600*           - SITE NEUTRAL PAYMENT                            *
110700*           - STANDARD/SITE NEUTRAL BLENDED PAYMENT           *
110800***************************************************************
110900 3000-CALC-PAYMENT.
111000***************************************************************
111100
111200
111300*-------------------------------------------------------------*
111400* CALCULATE CLAIM COST FOR ALL CLAIMS                         *
111500*-------------------------------------------------------------*
111600     COMPUTE PPS-FAC-COSTS ROUNDED =
111700         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
111800
111900
112000*-------------------------------------------------------------*
112100* DETERMINE WHICH PAYMENT METHOD TO USE. EITHER:              *
112200* - STANDARD PAYMENT UNDER THE OLD POLICY,                    *
112300* - STANDARD PAYMENT UNDER THE NEW POLICY,                    *
112400* - 100% SITE NEUTRAL PAYMENT, OR                             *
112500* - 50/50 BLEND OF SITE NEUTRAL & STANDARD PAYMENT.           *
112600*-------------------------------------------------------------*
112700     PERFORM 3100-DETERMINE-PAYMENT-TYPE
112800        THRU 3100-EXIT.
112900
113000     IF PPS-RTC NOT = '00'
113100        GO TO 3000-EXIT
113200     END-IF.
113300
113400
113500*-------------------------------------------------------------*
113600* CALCULATE CLAIM PAYMENT BASED ON PAYMENT METHOD             *
113700*-------------------------------------------------------------*
113800     IF PMT-STANDARD-OLD
113900        PERFORM 3200-CALC-STANDARD-PMT
114000           THRU 3200-EXIT
114100     END-IF.
114200
114300     IF PMT-STANDARD-NEW
114400        PERFORM 3200-CALC-STANDARD-PMT
114500           THRU 3200-EXIT
114600     END-IF.
114700
114800     IF PMT-SITE-NEUTRAL
114900        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
115000           THRU 3300-EXIT
115100     END-IF.
115200
115300     IF PMT-BLEND
115400        PERFORM 3200-CALC-STANDARD-PMT
115500           THRU 3200-EXIT
115600        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
115700           THRU 3300-EXIT
115800     END-IF.
115900
116000 3000-EXIT.
116100      EXIT.
116200
116300
116400***************************************************************
116500*  DETERMINE WHETHER A CLAIM'S PAYMENT SHOULD BE:             *
116600*  - STANDARD - OLD POLICY                                    *
116700*  - STANDARD - NEW POLICY                                    *
116800*  - 100% SITE NEUTRAL - NEW POLICY                           *
116900*  - 50/50 BLEND OF SITE NEUTRAL & STANDARD - NEW POLICY      *
117000***************************************************************
117100 3100-DETERMINE-PAYMENT-TYPE.
117200***************************************************************
117300
117400*-------------------------------------------------------------*
117500* STANDARD PAYMENT (OLD POLICY)
117600*-------------------------------------------------------------*
117700     IF B-REVIEW-CODE = 00 OR
117800        SUBCLAUSEII-PROV
117900        SET PMT-STANDARD-OLD TO TRUE
118000        GO TO 3100-EXIT
118100     END-IF.
118200
118300*-------------------------------------------------------------*
118400* STANDARD PAYMENT (NEW POLICY)
118500*-------------------------------------------------------------*
118600     IF (B-REVIEW-CODE = 01 AND NOT PSYCH-REHAB-DRG) OR
118700        B-REVIEW-CODE = 04 OR
118800        B-REVIEW-CODE = 05
118900        SET PMT-STANDARD-NEW TO TRUE
119000        GO TO 3100-EXIT
119100     END-IF.
119200
119300*-------------------------------------------------------------*
119400* SITE NEUTRAL PAYMENT (NEW POLICY)
119500*-------------------------------------------------------------*
119600     IF  (B-REVIEW-CODE = 01 AND PSYCH-REHAB-DRG) OR
119700          B-REVIEW-CODE = 02 OR
119800          B-REVIEW-CODE = 03 OR
119900          B-REVIEW-CODE = 06 OR
120000          B-REVIEW-CODE = 07 OR
120100          B-REVIEW-CODE = 08
120200
120300*-------------------------------------------------------------*
120400*     SET BUDGET NEUTRALITY RATE FOR SITE NEUTRAL CLAIMS
120500*-------------------------------------------------------------*
120600        MOVE 0.949 TO H-BDGT-NEUT-FACTOR
120700
120800*-------------------------------------------------------------*
120900*     100% SITE NEUTRAL PAYMENT
121000*-------------------------------------------------------------*
121100        IF PPS-BLEND-YEAR = 8
121200           SET PMT-SITE-NEUTRAL TO TRUE
121300
121400*-------------------------------------------------------------*
121500*     50% SITE NEUTRAL + 50% STANDARD BLENDED PAYMENT
121600*-------------------------------------------------------------*
121700        ELSE
121800           IF PPS-BLEND-YEAR = 6 OR
121900              PPS-BLEND-YEAR = 7
122000              SET PMT-BLEND TO TRUE
122100
122200*-------------------------------------------------------------*
122300*           SET BLEND PERCENTS FOR BLENDED PAYMENT            *
122400*-------------------------------------------------------------*
122500              MOVE .5 TO H-BLEND-STD
122600              MOVE .5 TO H-BLEND-SNT
122700           END-IF
122800        END-IF
122900     END-IF.
123000
123100*-------------------------------------------------------------*
123200* CLAIM MEETS NONE OF THE ABOVE CRITERIA - SET RETURN CODE
123300*-------------------------------------------------------------*
123400     IF WS-PRIMARY-PMT-TYPE = ' '
123500        MOVE '72' TO PPS-RTC
123600     END-IF.
123700
123800
123900 3100-EXIT.
124000      EXIT.
124100
124200
124300***************************************************************
124400*     CALCULATE THE STANDARD PAYMENT AMOUNT.                  *
124500*     CALCULATE THE SHORT-STAY OUTLIER AMOUNT IF APPLICABLE.  *
124600***************************************************************
124700 3200-CALC-STANDARD-PMT.
124800***************************************************************
124900
125000*-------------------------------------------------------------*
125100* CALCULATE FULL STANDARD DRG ADJUSTED PAYMENT                *
125200*-------------------------------------------------------------*
125300     COMPUTE H-LABOR-PORTION ROUNDED =
125400         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
125500          * PPS-WAGE-INDEX.
125600
125700     COMPUTE H-NONLABOR-PORTION ROUNDED =
125800         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
125900          * PPS-COLA.
126000
126100     COMPUTE PPS-FED-PAY-AMT ROUNDED =
126200         (H-LABOR-PORTION + H-NONLABOR-PORTION).
126300
126400     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
126500         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
126600
126700* FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY
126800     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
126900
127000
127100*-------------------------------------------------------------*
127200* DETERMINE WHETHER THE CLAIM IS A SHORT STAY OUTLIER;        *
127300* APPLY SHORT STAY OUTLIER POLICY IF IT IS                    *
127400*-------------------------------------------------------------*
127500     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
127600
127700     IF H-LOS <= H-SSOT
127800        PERFORM 3400-SHORT-STAY
127900           THRU 3400-SHORT-STAY-EXIT
128000
128100        IF PMT-STANDARD-NEW OR PMT-BLEND
128200           SET PMT-STANDARD-SSO TO TRUE
128300           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-SSO-PMT
128400        END-IF
128500
128600*-------------------------------------------------------------*
128700* FOR REGULAR STAY CLAIMS, POPULATE THE APPROPRIATE PAYMENT   *
128800* FIELD FOR NEW POLICY CLAIMS                                 *
128900*-------------------------------------------------------------*
129000     ELSE
129100        IF PMT-STANDARD-NEW OR PMT-BLEND
129200           SET PMT-STANDARD-FULL TO TRUE
129300           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-FULL-PMT
129400        END-IF
129500     END-IF.
129600
129700 3200-EXIT.
129800      EXIT.
129900
130000
130100***************************************************************
130200*     CALCULATE THE SITE NEUTRAL PAYMENT AMOUNT               *
130300***************************************************************
130400 3300-CALC-SITE-NEUTRAL-PMT.
130500***************************************************************
130600
130700*-------------------------------------------------------------*
130800*  CALCULATE IPPS COMPARABLE PER DIEM AMT                     *
130900*-------------------------------------------------------------*
131000     PERFORM 3650-SS-IPPS-COMP-PMT
131100        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
131200
131300
131400*-------------------------------------------------------------*
131500* CALCULATE THE SITE NEUTRAL PAYMENT AS THE LESSER OF THE     *
131600* IPPS COMPARABLE PAYMENT AND CLAIM COST * BUDGET NEUT FACTOR *
131700* APPLY SITE-NEUTRAL BLEND PERCENT FOR BLENDED PAYMENT CLAIMS *
131800*-------------------------------------------------------------*
131900
132000*-------------------------------------------------------------*
132100*  SITE-NEUTRAL PAYMENT BASED ON COSTS                        *
132200*-------------------------------------------------------------*
132300     IF PPS-FAC-COSTS < H-IPPS-PER-DIEM
132400        SET PMT-SITE-NEUT-COST TO TRUE
132500        MOVE PPS-FAC-COSTS TO PPS-SITE-NEUTRAL-COST-PMT
132600
132700*-------------------------------------------------------------*
132800*  SITE-NEUTRAL PAYMENT BASED ON IPPS COMPARABLE              *
132900*-------------------------------------------------------------*
133000     ELSE
133100        SET PMT-SITE-NEUT-IPPS TO TRUE
133200        MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT
133300     END-IF.
133400
133500
133600 3300-EXIT.
133700      EXIT.
133800
133900
134000***************************************************************
134100*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
134200*      OF THE AVG. LENGTH OF STAY THEN:                       *
134300*      - CALCULATE THE SHORT-STAY COST.                       *
134400*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *
134500*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *
134600*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *
134700*      - PAY THE LEAST OF:                                    *
134800*          1)SHORT STAY COST                                  *
134900*          2)SHORT STAY PAYMENT AMOUNT                        *
135000*          3)DRG ADJUSTED PAYMENT AMOUNT                      *
135100*          4)SHORT STAY BLENDED PAYMENT -OR-                  *
135200*          5)IPPS COMPARABLE AMOUNT                           *
135300*      - SET RETURN CODE FOR OLD POLICY CLAIMS ONLY TO        *
135400*        INDICATE SHORT STAY PAYMENT TYPE                     *
135500***************************************************************
135600
135700 3400-SHORT-STAY.
135800**************************************************************
135900*   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *
136000**************************************************************
136100     IF SUBCLAUSEII-PROV
136200        PERFORM 4000-SPECIAL-PROVIDER
136300           THRU 4000-SPECIAL-PROVIDER-EXIT
136400     ELSE
136500
136600**************************************************************
136700*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *
136800* ---------------------------------------------------------- *
136900*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *
137000**************************************************************
137100        MOVE PPS-FAC-COSTS TO H-SS-COST
137200
137300**************************************************************
137400*                                                            *
137500*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *
137600* ---------------------------------------------------------- *
137700*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *
137800*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *
137900*     THE LENGTH OF STAY IS CORRECT                          *
138000*                                                            *
138100**************************************************************
138200        COMPUTE H-SS-PAY-AMT ROUNDED =
138300         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
138400
138500**************************************************************
138600*                                                            *
138700*   SHORT STAY PROVISION #4 (BLEND OF SS PMT & IPPS          *
138800*   COMPARABLE PER DIEM AMT)                                 *
138900* ---------------------------------------------------------- *
139000*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
139100*   REMOVED FROM VERSION 09.0 BECAUSE CLAIMS DISCHARGED ON   *
139200*   AND AFTER 12/29/2008 ARE NOT ELIGIBLE FOR PROVISION #5.  *
139300*                                                            *
139400*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
139500*   ADDED TO VERSION 13.0 BECAUSE CLAIMS DISCHARGED ON AND   *
139600*   AFTER 12/29/2012 ARE ELIGIBLE FOR PROVISION #5.          *
139700*                                                            *
139800**************************************************************
139900        IF H-IPPS-WAGE-INDEX NUMERIC AND
140000           H-IPPS-WAGE-INDEX > 0
140100*---------------------------------------------------------
140200*   #4 - CALCULATE BLENDED PAYMENT
140300*---------------------------------------------------------
140400           IF B-DISCHARGE-DATE >= 20121229
140500              IF H-LOS > PPS-IPTHRESH
140600                 PERFORM 3600-SS-BLENDED-PMT
140700                    THRU 3600-SS-BLENDED-PMT-EXIT
140800               ELSE
140900*---------------------------------------------------------
141000*   #5 - LOS (COVERED DAYS) <= IPPS COMPARABLE THRESHOLD
141100*        CALCULATE IPPS COMPARABLE PER DIEM AMT ONLY
141200*---------------------------------------------------------
141300                  PERFORM 3650-SS-IPPS-COMP-PMT
141400                     THRU 3650-SS-IPPS-COMP-PMT-EXIT
141500           ELSE
141600               PERFORM 3600-SS-BLENDED-PMT
141700                  THRU 3600-SS-BLENDED-PMT-EXIT
141800        ELSE
141900           MOVE '52' TO PPS-RTC
142000           GO TO 3400-SHORT-STAY-EXIT.
142100
142200**************************************************************
142300*                                                            *
142400*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *
142500*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *
142600* ---------------------------------------------------------- *
142700*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *
142800*                                                            *
142900**************************************************************
143000
143100     MOVE 'N' TO H-SS-COST-IND.
143200     MOVE 'N' TO H-SS-PERDIEM-IND.
143300     MOVE 'N' TO H-SS-BLEND-IND.
143400     MOVE 'N' TO H-SS-IPPSCOMP-IND.
143500
143600*---------------------------------------------------------
143700*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%
143800*   OF PER DIEM) AND DRG ADJUSTED PMT AMT
143900*---------------------------------------------------------
144000     IF H-SS-COST < H-SS-PAY-AMT
144100        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT
144200           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT
144300           IF PMT-STANDARD-OLD
144400              MOVE '20' TO PPS-RTC
144500           END-IF
144600           MOVE 'Y' TO H-SS-COST-IND
144700        ELSE
144800           NEXT SENTENCE
144900        END-IF
145000     ELSE
145100        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT
145200           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT
145300           IF PMT-STANDARD-OLD
145400              MOVE '21' TO PPS-RTC
145500           END-IF
145600           MOVE 'Y' TO H-SS-PERDIEM-IND
145700        ELSE
145800           NEXT SENTENCE
145900        END-IF
146000     END-IF.
146100
146200*---------------------------------------------------------
146300*   USE THE BLENDED PMT OR IPPS COMPARABLE AMT IF LESS
146400*   THAN THE OTHER OPTIONS
146500*---------------------------------------------------------
146600     IF NOT SUBCLAUSEII-PROV
146700*---------------------------------------------------------
146800*   COMPARE BLENDED PAYMENT
146900*---------------------------------------------------------
147000         IF B-DISCHARGE-DATE >= 20121229 AND
147100           H-LOS > PPS-IPTHRESH AND
147200           H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
147300               MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
147400               IF PMT-STANDARD-OLD
147500                  MOVE '22' TO PPS-RTC
147600               END-IF
147700               MOVE 'Y' TO H-SS-BLEND-IND
147800               MOVE 'N' TO H-SS-COST-IND
147900               MOVE 'N' TO H-SS-PERDIEM-IND
148000               MOVE 'N' TO H-SS-IPPSCOMP-IND
148100         ELSE
148200*---------------------------------------------------------
148300*   COMPARE IPPS COMPARABLE PER DIEM AMOUNT
148400*---------------------------------------------------------
148500             IF B-DISCHARGE-DATE >= 20121229 AND
148600               H-LOS <= PPS-IPTHRESH AND
148700               H-IPPS-PER-DIEM <= PPS-DRG-ADJ-PAY-AMT
148800                 MOVE H-IPPS-PER-DIEM TO PPS-DRG-ADJ-PAY-AMT
148900                 IF PMT-STANDARD-OLD
149000                    MOVE '26' TO PPS-RTC
149100                 END-IF
149200                 MOVE 'Y' TO H-SS-IPPSCOMP-IND
149300                 MOVE 'N' TO H-SS-BLEND-IND
149400                 MOVE 'N' TO H-SS-COST-IND
149500                 MOVE 'N' TO H-SS-PERDIEM-IND
149600             ELSE
149700                 IF B-DISCHARGE-DATE < 20121229 AND
149800                   H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
149900                     MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
150000                     IF PMT-STANDARD-OLD
150100                        MOVE '22' TO PPS-RTC
150200                     END-IF
150300                     MOVE 'Y' TO H-SS-BLEND-IND
150400                     MOVE 'N' TO H-SS-COST-IND
150500                     MOVE 'N' TO H-SS-PERDIEM-IND
150600                     MOVE 'N' TO H-SS-IPPSCOMP-IND
150700                 END-IF
150800             END-IF
150900         END-IF
151000     END-IF.
151100
151200 3400-SHORT-STAY-EXIT.
151300      EXIT.
151400
151500
151600***************************************************************
151700*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
151800*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
151900*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
152000*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
152100***************************************************************
152200 3600-SS-BLENDED-PMT.
152300***************************************************************
152400
152500*** ------------------------------------------------------ ***
152600*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
152700*** ------------------------------------------------------ ***
152800     IF H-SSOT < 25
152900        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
153000          H-LOS / H-SSOT
153100     ELSE
153200        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
153300          H-LOS / 25
153400     END-IF.
153500
153600     IF H-LTCH-BLEND-PCT > 1
153700        MOVE 1 TO H-LTCH-BLEND-PCT
153800     END-IF.
153900
154000
154100*** ------------------------------------------------------ ***
154200*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
154300*** ------------------------------------------------------ ***
154400     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
154500        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
154600
154700
154800*** ------------------------------------------------------ ***
154900*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
155000*** ------------------------------------------------------ ***
155100     PERFORM 3650-SS-IPPS-COMP-PMT
155200        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
155300
155400
155500*** ------------------------------------------------------ ***
155600*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
155700*** ------------------------------------------------------ ***
155800     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
155900       1 - H-LTCH-BLEND-PCT.
156000
156100
156200*** ------------------------------------------------------ ***
156300*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
156400*** ------------------------------------------------------ ***
156500     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
156600       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
156700
156800
156900*** ------------------------------------------------------ ***
157000*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
157100*** ------------------------------------------------------ ***
157200     COMPUTE H-SS-BLENDED-PMT ROUNDED =
157300       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
157400
157500
157600 3600-SS-BLENDED-PMT-EXIT.
157700      EXIT.
157800
157900
158000***************************************************************
158100*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
158200*   PER DIEM PAYMENT AMOUNT                                   *
158300***************************************************************
158400 3650-SS-IPPS-COMP-PMT.
158500***************************************************************
158600
158700*** -------------------------------------------------------
158800*** OPERATING TEACHING ADJUSTMENT
158900*** -------------------------------------------------------
159000     COMPUTE H-OPER-IME-TEACH ROUNDED =
159100        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
159200
159300
159400*** -------------------------------------------------------
159500*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
159600*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%
159700*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL
159800***              THIS CHANGE IS RETROACTIVE TO 10/01/2008
159900*** -------------------------------------------------------
160000     IF H-CAPI-IME-RATIO > 1.5000
160100        MOVE 1.5000 TO H-CAPI-IME-RATIO.
160200
160300     COMPUTE H-CAPI-IME-TEACH ROUNDED =
160400        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).
160500
160600
160700*** -------------------------------------------------------
160800*** OPERATING DSH ADJUSTMENT
160900*** -------------------------------------------------------
161000
161100*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
161200*---------------------------------------------------
161300     IF ALL-RURAL
161400        SET RURAL-CBSA TO TRUE
161500     ELSE
161600        SET URBAN-CBSA TO TRUE
161700     END-IF.
161800
161900
162000*2) CALCULATE THE OPERATING DSH PERCENT
162100*--------------------------------------
162200     COMPUTE H-OPER-DSH-PCT ROUNDED =
162300        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
162400
162500
162600*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
162700*-----------------------------------------------------
162800
162900*    URBAN, < 100 BEDS
163000*    -----------------
163100     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
163200        H-OPER-DSH-PCT >= .15
163300          MOVE '3' TO H-GEO-CLASS
163400     ELSE
163500
163600
163700*   URBAN, >= 100 BEDS
163800*   ------------------
163900       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
164000          H-OPER-DSH-PCT >= .15
164100            MOVE '2' TO H-GEO-CLASS
164200       ELSE
164300
164400
164500*   RURAL, >= 500 BEDS
164600*   ------------------
164700         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
164800            H-OPER-DSH-PCT >= .15
164900              MOVE '2' TO H-GEO-CLASS
165000         ELSE
165100
165200
165300*   RURAL, < 500 BEDS
165400*   -----------------
165500           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
165600              H-OPER-DSH-PCT >= .15
165700                MOVE '3' TO H-GEO-CLASS
165800           ELSE
165900
166000
166100*   OTHER
166200*   -----------------
166300              MOVE '4' TO H-GEO-CLASS
166400
166500           END-IF
166600         END-IF
166700       END-IF
166800     END-IF.
166900
167000
167100*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
167200*-----------------------------------------------------------
167300     EVALUATE H-GEO-CLASS
167400
167500*      GEOGRAPHIC CLASS 2
167600*      ------------------
167700       WHEN '2'
167800          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
167900             COMPUTE H-OPER-DSH ROUNDED =
168000               ((H-OPER-DSH-PCT - .15) * .65) + .025
168100          ELSE
168200             IF H-OPER-DSH-PCT > .202
168300                COMPUTE H-OPER-DSH ROUNDED =
168400                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
168500             ELSE
168600                MOVE ZEROS TO H-OPER-DSH
168700             END-IF
168800          END-IF
168900
169000*      GEOGRAPHIC CLASS 3
169100*      ------------------
169200       WHEN '3'
169300          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
169400             COMPUTE H-OPER-DSH ROUNDED =
169500               ((H-OPER-DSH-PCT - .15) * .65) + .025
169600             IF H-OPER-DSH > .12
169700                MOVE .12 TO H-OPER-DSH
169800             END-IF
169900          ELSE
170000             IF H-OPER-DSH-PCT > .202
170100                COMPUTE H-OPER-DSH ROUNDED =
170200                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
170300                IF H-OPER-DSH > .12
170400                   MOVE .12 TO H-OPER-DSH
170500                END-IF
170600             ELSE
170700               MOVE ZEROS TO H-OPER-DSH
170800             END-IF
170900          END-IF
171000
171100*      GEOGRAPHIC CLASS 4
171200*      ------------------
171300       WHEN '4'
171400          MOVE ZEROS TO H-OPER-DSH
171500
171600     END-EVALUATE.
171700
171800
171900*** -------------------------------------------------------
172000*** CURRENT OPERATING DSH PAYMENT REDUCTION
172100*** -------------------------------------------------------
172200     COMPUTE H-OPER-DSH ROUNDED =
172300             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.
172400
172500*** -------------------------------------------------------
172600*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
172700*** -------------------------------------------------------
172800     IF URBAN-CBSA AND H-BED-SIZE >= 100
172900        COMPUTE H-CAPI-DSH ROUNDED =
173000          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
173100     ELSE
173200        MOVE ZEROS TO H-CAPI-DSH
173300     END-IF.
173400
173500
173600*** -------------------------------------------------------
173700*** OPERATING PAYMENT (STANDARD AMOUNT)
173800*** -------------------------------------------------------
173900     IF (P-NEW-STATE = 02 OR 12)
174000        MOVE P-NEW-COLA TO H-OPER-COLA
174100     ELSE
174200        MOVE 1.000 TO H-OPER-COLA
174300     END-IF.
174400
174500     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
174600       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +
174700         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
174800         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
174900
175000
175100*** -------------------------------------------------------
175200*** CAPITAL PAYMENT (CAPITAL RATE)
175300*** -------------------------------------------------------
175400     COMPUTE H-CAPI-COLA ROUNDED =
175500       (.3152 * (H-OPER-COLA - 1) + 1).
175600
175700*--------------------------------------------------------------*
175800*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
175900*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
176000*--------------------------------------------------------------*
176100     IF LARGE-URBAN
176200        MOVE 1.00 TO H-LRGURB-ADD-ON
176300     ELSE
176400        MOVE 1.00 TO H-LRGURB-ADD-ON
176500     END-IF.
176600
176700     COMPUTE H-CAPI-GAF ROUNDED =
176800       (H-IPPS-WAGE-INDEX ** .6848).
176900
177000     COMPUTE H-CAPI-PMT ROUNDED =
177100       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
177200       H-LRGURB-ADD-ON *  H-CAPI-COLA *
177300       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
177400
177500
177600*** -------------------------------------------------------
177700*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
177800*** -------------------------------------------------------
177900     COMPUTE H-IPPS-PAY-AMT ROUNDED =
178000       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
178100
178200
178300*** -------------------------------------------------------
178400*** IPPS COMPARABLE PER DIEM PAYMENT
178500*** -------------------------------------------------------
178600     COMPUTE H-IPPS-PER-DIEM ROUNDED =
178700       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
178800
178900     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
179000        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
179100     END-IF.
179200
179300*** -------------------------------------------------------
179400*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
179500*** -------------------------------------------------------
179600
179700
179800 3650-SS-IPPS-COMP-PMT-EXIT.
179900      EXIT.
180000
180100
180200***************************************************************
180300 4000-SPECIAL-PROVIDER.
180400***************************************************************
180500
180600*** PROCESS FOR CY2003
180700*** ------------------
180800     IF (B-DISCHARGE-DATE >= 20030701) AND
180900        (B-DISCHARGE-DATE <  20040101)
181000        COMPUTE H-SS-COST ROUNDED =
181100            (PPS-FAC-COSTS * 1.95)
181200        COMPUTE H-SS-PAY-AMT ROUNDED =
181300         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
181400     END-IF
181500
181600
181700*** PROCESS FOR CY2004
181800*** ------------------
181900     IF (B-DISCHARGE-DATE >= 20040101) AND
182000        (B-DISCHARGE-DATE <  20050101)
182100        COMPUTE H-SS-COST ROUNDED =
182200            (PPS-FAC-COSTS * 1.93)
182300        COMPUTE H-SS-PAY-AMT ROUNDED =
182400          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
182500     END-IF
182600
182700
182800*** PROCESS FOR CY2005
182900*** ------------------
183000     IF (B-DISCHARGE-DATE >= 20050101) AND
183100        (B-DISCHARGE-DATE <  20060101)
183200        COMPUTE H-SS-COST ROUNDED =
183300            (PPS-FAC-COSTS * 1.65)
183400        COMPUTE H-SS-PAY-AMT ROUNDED =
183500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
183600     END-IF
183700
183800
183900*** PROCESS FOR CY2006
184000*** ------------------
184100     IF (B-DISCHARGE-DATE >= 20060101) AND
184200        (B-DISCHARGE-DATE <  20070101)
184300        COMPUTE H-SS-COST ROUNDED =
184400            (PPS-FAC-COSTS * 1.36)
184500        COMPUTE H-SS-PAY-AMT ROUNDED =
184600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
184700     END-IF
184800
184900
185000*** PROCESS FOR CY2007 AND AFTER
185100*** ----------------------------
185200     IF (B-DISCHARGE-DATE >= 20070101)
185300        COMPUTE H-SS-COST ROUNDED =
185400            (PPS-FAC-COSTS * 1.2)
185500        COMPUTE H-SS-PAY-AMT ROUNDED =
185600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
185700     END-IF.
185800
185900 4000-SPECIAL-PROVIDER-EXIT.
186000      EXIT.
186100
186200
186300***************************************************************
186400*   CALCULATE THE OUTLIER THRESHOLD                           *
186500*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
186600*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
186700*   SET RETURN CODE                                           *
186800*   CALCULATE THE CHARGE THRESHOLD IF APPLICABLE              *
186900***************************************************************
187000 6000-CALC-HIGH-COST-OUTLIER.
187100***************************************************************
187200
187300
187400*-------------------------------------------------------------*
187500* FOR NON-BLENDED PAYMENT CLAIMS:                             *
187600*-------------------------------------------------------------*
187700* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLD  *
187800*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
187900* - CALCULATE OUTLIER THRESHOLD                               *
188000*-------------------------------------------------------------*
188100
188200     IF PMT-STANDARD-OLD
188300        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
188400                PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT-STD
188500     END-IF.
188600
188700
188800     IF PMT-STANDARD-NEW
188900        IF PMT-STANDARD-FULL
189000           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
189100                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
189200        ELSE
189300           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
189400                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
189500        END-IF
189600     END-IF.
189700
189800
189900     IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
190000        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
190100                PPS-SITE-NEUTRAL-IPPS-PMT + H-FIXED-LOSS-AMT-SNT
190200     END-IF.
190300
190400
190500*-------------------------------------------------------------*
190600* CALCULATE HIGH-COST OUTLIER IF COSTS EXCEED THRESHOLD       *
190700*-------------------------------------------------------------*
190800     IF NOT PMT-BLEND AND
190900        NOT (PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-COST)
191000        IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
191100           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
191200                   (PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8
191300
191400*-------------------------------------------------------------*
191500*        SITE-NEUTRAL ONLY: REDUCE BY BUDGET NEUTRALITY FACT. *
191600*-------------------------------------------------------------*
191700*          IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
191800*             COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
191900*                    PPS-OUTLIER-PAY-AMT * H-BDGT-NEUT-FACTOR
192000*          END-IF
192100        END-IF
192200     END-IF.
192300
192400
192500
192600*-------------------------------------------------------------*
192700* FOR BLENDED PAYMENT CLAIMS                                  *
192800* (RECEIVE 50% STANDARD PAYMENT + 50% SITE-NEUTRAL PAYMENT)   *
192900*-------------------------------------------------------------*
193000* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLDS *
193100*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
193200* - CALCULATE STANDARD PAYMENT OUTLIER THRESHOLD              *
193300* - CALCULATE SITE-NEUTRAL PAYMENT OUTLIER THRESHOLD          *
193400* - CALCULATE HIGH-COST OUTLIER IF APPLICABLE (50/50 BLEND)   *
193500*-------------------------------------------------------------*
193600
193700     IF PMT-BLEND
193800
193900*-------------------------------------------------------------*
194000* CALCULATE STANDARD OUTLIER THRESHOLD                        *
194100*-------------------------------------------------------------*
194200        IF PMT-STANDARD-FULL
194300           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
194400                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
194500        ELSE
194600           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
194700                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
194800        END-IF
194900
195000
195100*-------------------------------------------------------------*
195200* CALCULATE SITE-NEUTRAL OUTLIER THRESHOLD                    *
195300*-------------------------------------------------------------*
195400        IF PMT-SITE-NEUT-IPPS
195500           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
195600                   PPS-SITE-NEUTRAL-IPPS-PMT +
195700                   H-FIXED-LOSS-AMT-SNT
195800        END-IF
195900
196000
196100*-------------------------------------------------------------*
196200* CALCULATE STANDARD PAYMENT PORTION OF HIGH-COST OUTLIER IF  *
196300* COSTS EXCEED STANDARD PAYMENT THRESHOLD                     *
196400*-------------------------------------------------------------*
196500        IF PPS-FAC-COSTS > H-OUTLIER-THRESHOLD-STD
196600           COMPUTE H-OUTLIER-PAY-AMT-STD ROUNDED =
196700                   (PPS-FAC-COSTS - H-OUTLIER-THRESHOLD-STD) * .8
196800                   * H-BLEND-STD
196900        END-IF
197000
197100
197200*-------------------------------------------------------------*
197300* CALCULATE SITE-NEUTRAL PORTION OF HIGH-COST OUTLIER IF      *
197400* COSTS EXCEED THE SITE-NEUTRAL PAYMENT THRESHOLD             *
197500*-------------------------------------------------------------*
197600        IF PMT-SITE-NEUT-IPPS AND
197700           PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
197800           COMPUTE H-OUTLIER-PAY-AMT-SNT ROUNDED =
197900                  (((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
198000*                  * H-BLEND-SNT) * H-BDGT-NEUT-FACTOR
198100                   * H-BLEND-SNT)
198200        END-IF
198300
198400*-------------------------------------------------------------*
198500* CALCULATE TOTAL BLENDED HIGH-COST OUTLIER:                  *
198600* ADD THE SITE-NEUTRAL PAYMENT PORTION OF HIGH-COST OUTLIER   *
198700* TO THE STANDARD PAYMENT PORTION                             *
198800*-------------------------------------------------------------*
198900        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
199000                H-OUTLIER-PAY-AMT-STD + H-OUTLIER-PAY-AMT-SNT
199100
199200     END-IF.
199300
199400
199500*-------------------------------------------------------------*
199600* FOR ALL CLAIMS:                                             *
199700*-------------------------------------------------------------*
199800* SET HIGH-COST OUTLIER TO $0 IF BILL SPECIAL PAY IND. = '1'  *
199900*-------------------------------------------------------------*
200000     IF B-SPEC-PAY-IND = '1'
200100        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
200200
200300
200400*-------------------------------------------------------------*
200500* DETERMINE IF CHARGE THRESHOLD APPLIES & CALCULATE IF SO     *
200600*-------------------------------------------------------------*
200700     PERFORM 6100-CALC-CHARGE-THRESHOLD
200800        THRU 6100-EXIT.
200900
201000
201100 6000-EXIT.
201200      EXIT.
201300
201400
201500***************************************************************
201600*   CALCULATE CHARGE THRESHOLD & SET ERROR RTC WHEN APPLICABLE*
201700***************************************************************
201800 6100-CALC-CHARGE-THRESHOLD.
201900***************************************************************
202000
202100
202200*-------------------------------------------------------------*
202300* FOR MAINFRAME PRICER ONLY:                                  *
202400*-------------------------------------------------------------*
202500* FOR CLAIMS THAT RECEIVE A HIGH-COST OUTLIER AND HAVE A      *
202600* LENGTH OF STAY THAT EXCEEDS THE COVERED DAYS, CALCULATE THE *
202700* CHARGE THRESHOLD AND SET ERROR RETURN CODE '67'             *
202800*-------------------------------------------------------------*
202900
203000*-------------------------------------------------------------*
203100* FOR PC PRICER (PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS):      *
203200*-------------------------------------------------------------*
203300* CALCULATE CHARGE THRESHOLD FOR CLAIMS ALL CLAIMS THAT HAVE  *
203400* AN OPERATING COST-TO-CHARGE RATIO BUT DO NOT SET ERROR CODE *
203500*-------------------------------------------------------------*
203600
203700     IF (PPS-OUTLIER-PAY-AMT > 0 AND
203800         NOT (PMT-BLEND AND H-OUTLIER-PAY-AMT-SNT = 0)) OR
203900        PPS-COT-IND = 'Y'
204000
204100        IF B-COV-DAYS < H-LOS OR
204200           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
204300
204400           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
204500             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
204600
204700           IF NOT PC-PRICER
204800              MOVE '67' TO PPS-RTC
204900           END-IF
205000
205100        ELSE
205200           NEXT SENTENCE
205300        END-IF
205400     ELSE
205500        NEXT SENTENCE
205600     END-IF.
205700
205800 6100-EXIT.
205900      EXIT.
206000
206100
206200***************************************************************
206300*   SET FINAL RETURN CODES FOR PRICED CLAIMS                  *
206400***************************************************************
206500 7000-SET-FINAL-RETURN-CODES.
206600***************************************************************
206700
206800
206900*-------------------------------------------------------------*
207000* SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIM            *
207100*-------------------------------------------------------------*
207200     IF SUBCLAUSEII-PROV
207300        PERFORM 7300-SET-SUBII-RETURN-CODES
207400           THRU 7300-EXIT
207500        GO TO 7000-EXIT
207600     END-IF.
207700
207800
207900*-------------------------------------------------------------*
208000* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
208100* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
208200*-------------------------------------------------------------*
208300     IF PMT-STANDARD-OLD
208400        PERFORM 7100-SET-OLD-RETURN-CODES
208500           THRU 7100-EXIT
208600     END-IF.
208700
208800
208900*-------------------------------------------------------------*
209000* SET RETURN CODES FOR NEW POLICY CLAIMS                      *
209100*-------------------------------------------------------------*
209200     IF PMT-STANDARD-NEW OR PMT-SITE-NEUTRAL OR PMT-BLEND
209300        PERFORM 7200-SET-NEW-RETURN-CODES
209400           THRU 7200-EXIT
209500     END-IF.
209600
209700
209800 7000-EXIT.
209900      EXIT.
210000
210100
210200***************************************************************
210300*   SET RETURN CODES FOR OLD POLICY CLAIMS                    *
210400***************************************************************
210500 7100-SET-OLD-RETURN-CODES.
210600***************************************************************
210700
210800*-------------------------------------------------------------*
210900* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
211000* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
211100*-------------------------------------------------------------*
211200
211300     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '21'
211400        MOVE '24' TO PPS-RTC.
211500
211600     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '22'
211700        MOVE '25' TO PPS-RTC.
211800
211900     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '26'
212000        MOVE '27' TO PPS-RTC.
212100
212200     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '00'
212300        MOVE '01' TO PPS-RTC.
212400
212500     IF (PPS-RTC = '00' OR '20' OR '21' OR '22' OR '26')
212600        IF PPS-REG-DAYS-USED > H-SSOT
212700           MOVE 0 TO PPS-LTR-DAYS-USED
212800        ELSE
212900           NEXT SENTENCE.
213000
213100 7100-EXIT.
213200      EXIT.
213300
213400
213500***************************************************************
213600*   SET RETURN CODES FOR NEW POLICY CLAIMS                    *
213700***************************************************************
213800 7200-SET-NEW-RETURN-CODES.
213900***************************************************************
214000
214100     INITIALIZE PPS-RTC.
214200
214300***************************************************************
214400* SET THE FIRST POSITION OF THE RETURN CODE                   *
214500***************************************************************
214600
214700*--------------------------------------------------*
214800* DEFAULT (NO PSYCH/REHAB NOR VENTILATOR SERVICE)  *
214900*--------------------------------------------------*
215000     MOVE 'C' TO PPS-RTC-1.
215100
215200*--------------------------------------------------*
215300* VENTILATOR SERVICE PRESENT                       *
215400*--------------------------------------------------*
215500     PERFORM 7250-SEARCH-FOR-VENT-PROC
215600        THRU 7250-EXIT.
215700     IF VENT-PRESENT
215800        MOVE 'B' TO PPS-RTC-1
215900     END-IF.
216000
216100*--------------------------------------------------*
216200* SITE NEUTRAL PMT BECAUSE PSYCH/REHAB DRG PRESENT *
216300* (PRESENCE OF PSCHY/REHAB DRG TRUMPS VENT PROC.)  *
216400*--------------------------------------------------*
216500     IF PSYCH-REHAB-DRG AND
216600        (PMT-SITE-NEUTRAL OR PMT-BLEND)
216700        MOVE 'A' TO PPS-RTC-1
216800     END-IF.
216900
217000
217100
217200***************************************************************
217300* SET THE SECOND POSITION OF RETURN CODE                      *
217400***************************************************************
217500
217600*-------------------------------------------------------------*
217700* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = COST         *
217800*-------------------------------------------------------------*
217900     IF PMT-BLEND AND PMT-SITE-NEUT-COST
218000
218100        IF PPS-OUTLIER-PAY-AMT = 0 AND
218200           PMT-STANDARD-FULL
218300           MOVE '0' TO PPS-RTC-2
218400        END-IF
218500
218600        IF PPS-OUTLIER-PAY-AMT > 0 AND
218700           PMT-STANDARD-FULL
218800           MOVE '1' TO PPS-RTC-2
218900        END-IF
219000
219100        IF PPS-OUTLIER-PAY-AMT = 0 AND
219200           PMT-STANDARD-SSO
219300           MOVE '2' TO PPS-RTC-2
219400        END-IF
219500
219600        IF PPS-OUTLIER-PAY-AMT > 0 AND
219700           PMT-STANDARD-SSO
219800           MOVE '3' TO PPS-RTC-2
219900        END-IF
220000
220100     END-IF.
220200
220300
220400*-------------------------------------------------------------*
220500* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = IPPS COMP.   *
220600*-------------------------------------------------------------*
220700     IF PMT-BLEND AND PMT-SITE-NEUT-IPPS
220800
220900        IF PPS-OUTLIER-PAY-AMT = 0 AND
221000           PMT-STANDARD-FULL
221100           MOVE '4' TO PPS-RTC-2
221200        END-IF
221300
221400        IF PPS-OUTLIER-PAY-AMT > 0 AND
221500           PMT-STANDARD-FULL
221600           MOVE '5' TO PPS-RTC-2
221700        END-IF
221800
221900        IF PPS-OUTLIER-PAY-AMT = 0 AND
222000           PMT-STANDARD-SSO
222100           MOVE '6' TO PPS-RTC-2
222200        END-IF
222300
222400        IF PPS-OUTLIER-PAY-AMT > 0 AND
222500           PMT-STANDARD-SSO
222600           MOVE '7' TO PPS-RTC-2
222700        END-IF
222800
222900     END-IF.
223000
223100
223200*-------------------------------------------------------------*
223300* 100% SITE NEUTRAL PAYMENT CLAIMS                            *
223400*-------------------------------------------------------------*
223500     IF PMT-SITE-NEUTRAL
223600
223700        IF PMT-SITE-NEUT-COST
223800           MOVE 'A' TO PPS-RTC-2
223900        END-IF
224000
224100        IF PMT-SITE-NEUT-IPPS
224200           IF PPS-OUTLIER-PAY-AMT = 0
224300              MOVE 'B' TO PPS-RTC-2
224400           ELSE
224500              MOVE 'C' TO PPS-RTC-2
224600           END-IF
224700        END-IF
224800     END-IF.
224900
225000
225100*-------------------------------------------------------------*
225200* 100% STANDARD PAYMENT CLAIMS                                *
225300*-------------------------------------------------------------*
225400     IF PMT-STANDARD-NEW
225500
225600        IF PMT-STANDARD-SSO AND
225700           PPS-OUTLIER-PAY-AMT = 0
225800           MOVE 'D' TO PPS-RTC-2
225900        END-IF
226000
226100        IF PMT-STANDARD-SSO AND
226200           PPS-OUTLIER-PAY-AMT > 0
226300           MOVE 'E' TO PPS-RTC-2
226400        END-IF
226500
226600        IF PMT-STANDARD-FULL AND
226700           PPS-OUTLIER-PAY-AMT = 0
226800           MOVE 'F' TO PPS-RTC-2
226900        END-IF
227000
227100        IF PMT-STANDARD-FULL AND
227200           PPS-OUTLIER-PAY-AMT > 0
227300           MOVE 'G' TO PPS-RTC-2
227400        END-IF
227500
227600     END-IF.
227700
227800
227900 7200-EXIT.
228000      EXIT.
228100
228200
228300***************************************************************
228400*   SEARCH FOR VENTILATOR SERVICE ICD-10 PROCEDURE CODE       *
228500***************************************************************
228600 7250-SEARCH-FOR-VENT-PROC.
228700***************************************************************
228800
228900     SET IDX-PROC TO 1.
229000
229100     SEARCH B-PROCEDURE-CODE VARYING IDX-PROC
229200         AT END
229300            SET VENT-NOT-PRESENT TO TRUE
229400         WHEN VENT-ICD-10-CODE = B-PROCEDURE-CODE (IDX-PROC)
229500            SET VENT-PRESENT TO TRUE
229600            GO TO 7250-EXIT
229700     END-SEARCH.
229800
229900 7250-EXIT.
230000      EXIT.
230100
230200
230300***************************************************************
230400*   SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIMS         *
230500***************************************************************
230600 7300-SET-SUBII-RETURN-CODES.
230700***************************************************************
230800
230900     INITIALIZE PPS-RTC.
231000
231100*-------------------------------------------------------------*
231200* SET RETURN CODE BASED ON PRESENCE/ABSENCE OF OUTLIER        *
231300*-------------------------------------------------------------*
231400     IF PPS-OUTLIER-PAY-AMT > 0
231500        MOVE '29' TO PPS-RTC
231600     ELSE
231700        MOVE '28' TO PPS-RTC
231800     END-IF.
231900
232000*-------------------------------------------------------------*
232100* MOVE PER DIEM AMOUNT TO OUTPUT RECORD VARIABLE              *
232200*-------------------------------------------------------------*
232300     MOVE P-NEW-FAC-SPEC-RATE TO PPS-NEW-FAC-SPEC-RATE.
232400
232500*-------------------------------------------------------------*
232600* INITIALIZE OUTPUT FIELDS THAT DON'T APPLY TO SUBCLAUSE II   *
232700*-------------------------------------------------------------*
232800     INITIALIZE PPS-OUTLIER-PAY-AMT
232900                PPS-DRG-ADJ-PAY-AMT
233000                PPS-FED-PAY-AMT
233100                PPS-FAC-COSTS
233200                PPS-SUBM-DRG-CODE
233300                PPS-NAT-LABOR-PCT
233400                PPS-NAT-NONLABOR-PCT
233500                PPS-STD-FED-RATE
233600                PPS-BDGT-NEUT-RATE
233700                PPS-IPTHRESH
233800                PPS-SITE-NEUTRAL-COST-PMT
233900                PPS-SITE-NEUTRAL-IPPS-PMT
234000                PPS-STANDARD-FULL-PMT
234100                PPS-STANDARD-SSO-PMT.
234200
234300
234400 7300-EXIT.
234500      EXIT.
234600
234700
234800***************************************************************
234900*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
235000*   UNIQUE CALCULATION FOR EACH CLAIM PAYMENT TYPE COMBO      *
235100***************************************************************
235200 8000-CALC-FINAL-PMT.
235300***************************************************************
235400
235500
235600*-------------------------------------------------------------*
235700* SUBCLAUSE II CLAIMS                                         *
235800*   P-NEW-FAC-SPEC-RATE = PER DIEM PMT RATE FOR SUBCLAUSE II  *
235900*-------------------------------------------------------------*
236000     IF SUBCLAUSEII-PROV
236100        COMPUTE PPS-FINAL-PAY-AMT ROUNDED =
236200                P-NEW-FAC-SPEC-RATE *
236300                B-CST-RPT-DAYS
236400        GO TO 8000-EXIT
236500     END-IF.
236600
236700
236800*-------------------------------------------------------------*
236900* OLD POLICY CLAIMS (100% STANDARD PAYMENT)                   *
237000*-------------------------------------------------------------*
237100     IF PMT-STANDARD-OLD
237200        COMPUTE PPS-FINAL-PAY-AMT =
237300                PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
237400     END-IF.
237500
237600
237700*-------------------------------------------------------------*
237800* NEW POLICY CLAIMS (ANY PAYMENT TYPE)                        *
237900*     - ONLY APPLICABLE PAYMENT FIELDS CONTAIN VALUES > $0    *
238000*     - APPLY BUDGET NEUTRALITY AND/OR BLEND TO PAYMENT       *
238100*       IF NEEDED                                             *
238200*     - ANY APPLICABLE BUDGET NEUTRALITY AND/OR BLEND WAS     *
238300*       ALREADY APPLIED TO OUTLIER PAYMENT                    *
238400*-------------------------------------------------------------*
238500     IF NOT PMT-STANDARD-OLD
238600
238700*-------------------------------------------------------*
238800* APPLY BUDGET NEUTRALITY TO 100% SITE-NEUTRAL PAYMENTS *
238900*-------------------------------------------------------*
239000        IF PMT-SITE-NEUTRAL
239100           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
239200                   PPS-SITE-NEUTRAL-COST-PMT *
239300                   H-BDGT-NEUT-FACTOR
239400
239500           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
239600                   PPS-SITE-NEUTRAL-IPPS-PMT *
239700                   H-BDGT-NEUT-FACTOR
239800        END-IF
239900
240000
240100*-------------------------------------------------------*
240200* APPLY BLEND PERCENTS & BUDGET NEUT TO BLENDED PAYMENTS*
240300*-------------------------------------------------------*
240400        IF PMT-BLEND
240500           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
240600                   PPS-SITE-NEUTRAL-COST-PMT *
240700                   H-BDGT-NEUT-FACTOR *
240800                   H-BLEND-SNT
240900
241000           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
241100                   PPS-SITE-NEUTRAL-IPPS-PMT *
241200                   H-BDGT-NEUT-FACTOR *
241300                   H-BLEND-SNT
241400
241500           COMPUTE PPS-STANDARD-FULL-PMT ROUNDED =
241600                   PPS-STANDARD-FULL-PMT * H-BLEND-STD
241700
241800           COMPUTE PPS-STANDARD-SSO-PMT ROUNDED =
241900                   PPS-STANDARD-SSO-PMT * H-BLEND-STD
242000        END-IF
242100
242200
242300*-------------------------------------------------------*
242400* SUM PAYMENT FIELDS FOR FINAL PAYMENT                  *
242500*-------------------------------------------------------*
242600        COMPUTE PPS-FINAL-PAY-AMT =
242700                PPS-STANDARD-FULL-PMT +
242800                PPS-STANDARD-SSO-PMT +
242900                PPS-SITE-NEUTRAL-COST-PMT +
243000                PPS-SITE-NEUTRAL-IPPS-PMT +
243100                PPS-OUTLIER-PAY-AMT
243200     END-IF.
243300
243400
243500 8000-EXIT.
243600      EXIT.
243700
243800
243900***************************************************************
244000 9000-MOVE-RESULTS.
244100***************************************************************
244200
244300
244400*-------------------------------------------------------------*
244500* IF CLAIM PRICED, MOVE LENGTH OF STAY & VERSION TO OUTPUT    *
244600*-------------------------------------------------------------*
244700     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
244800        MOVE H-LOS TO PPS-LOS
244900        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
245000
245100*-------------------------------------------------------------*
245200* IF CLAIM DIDN'T PRICE DUE TO AN ERROR, INITIALIZE ALL       *
245300* OUTPUT DATA EXCEPT FOR PPS-RTC AND PPS-CHRG-THRESHOLD,      *
245400* INITIALIZE WORK VARIABLES, AND MOVE VERSION TO OUTPUT       *
245500*-------------------------------------------------------------*
245600     ELSE
245700       INITIALIZE PPS-DATA
245800       INITIALIZE PPS-OTHER-DATA
245900       INITIALIZE PPS-CBSA
246000       INITIALIZE HOLD-PPS-COMPONENTS
246100       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
246200     END-IF.
246300
246400
246500*** *************************************************** ***
246600*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***
246700*** *************************************************** ***
246800*
246900*    IF (B-PROVIDER-NO = '341701' OR
247000*                        '111702' OR
247100*                        '371703' OR
247200*                        '101704' OR
247300*                        '531705' OR
247400*                        '141706' OR
247500*                        '361707' OR
247600*                        '361708' OR
247700*                        '332006')
247800*
247900*    DISPLAY '---------------------------------------------'
248000*    DISPLAY '*********************************************'
248100*    DISPLAY '---------------------------------------------'
248200*    DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
248300*    DISPLAY 'PPS-RTC '                  PPS-RTC
248400*    DISPLAY 'PSF EFFECTIVE DATE '       P-NEW-EFF-DATE
248500*    DISPLAY 'CBSA EFF DATE '            W-EFF-DATE
248600*    DISPLAY 'BILL DISCHARGE DATE '      B-DISCHARGE-DATE
248700*    DISPLAY 'P-NEW-FAC-SPEC-RATE '      P-NEW-FAC-SPEC-RATE
248800*    DISPLAY 'COST REPORT DAYS '         B-CST-RPT-DAYS
248900*    DISPLAY 'WS-PRIMARY-PMT-TYPE '      WS-PRIMARY-PMT-TYPE
249000*    DISPLAY 'WS-SECONDARY-PMT-TYPE-SNT' WS-SECONDARY-PMT-TYPE-SNT
249100*    DISPLAY 'WS-SECONDARY-PMT-TYPE-STD' WS-SECONDARY-PMT-TYPE-STD
249200*    DISPLAY 'B-REVIEW-CODE '            B-REVIEW-CODE
249300*    DISPLAY 'B-PROCEDURE-CODE-TABLE '   B-PROCEDURE-CODE-TABLE
249400*    DISPLAY 'WS-VENT-STATUS '           WS-VENT-STATUS
249500*    DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT
249600*    DISPLAY 'PPS-SITE-NEUTRAL-COST-PM ' PPS-SITE-NEUTRAL-COST-PMT
249700*    DISPLAY 'PPS-SITE-NEUTRAL-IPPS-PM ' PPS-SITE-NEUTRAL-IPPS-PMT
249800*    DISPLAY 'PPS-STANDARD-FULL-PMT '    PPS-STANDARD-FULL-PMT
249900*    DISPLAY 'PPS-STANDARD-SSO-PMT '     PPS-STANDARD-SSO-PMT
250000*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
250100*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
250200*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
250300*    DISPLAY 'PPS-FAC-COSTS '            PPS-FAC-COSTS
250400*    DISPLAY 'H-FIXED-LOSS-AMT-STD '     H-FIXED-LOSS-AMT-STD
250500*    DISPLAY 'H-FIXED-LOSS-AMT-SNT '     H-FIXED-LOSS-AMT-SNT
250600*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
250700*    DISPLAY 'H-OUTLIER-THRESHOLD-STD '  H-OUTLIER-THRESHOLD-STD
250800*    DISPLAY 'PPS-CHRG-THRESHOLD '       PPS-CHRG-THRESHOLD
250900*    DISPLAY 'H-BDGT-NEUT-FACTOR '       H-BDGT-NEUT-FACTOR
251000*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
251100*    DISPLAY 'PPS-CBSA '                 PPS-CBSA
251200*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
251300*    DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
251400*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
251500*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
251600*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE
251700*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
251800*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
251900*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
252000*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
252100*    DISPLAY 'H-LOS '                    H-LOS
252200*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS
252300*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
252400*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
252500*    DISPLAY 'H-BLEND-SNT '              H-BLEND-SNT
252600*    DISPLAY 'H-BLEND-STD '              H-BLEND-STD
252700*    DISPLAY 'P-NEW-OPER-CSTCHG-RATIO '  P-NEW-OPER-CSTCHG-RATIO
252800*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
252900*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
253000*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
253100*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
253200*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
253300*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
253400*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
253500*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
253600*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
253700*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
253800*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
253900*    DISPLAY 'H-SSOT '                   H-SSOT
254000*    DISPLAY 'H-SS-COST '                H-SS-COST
254100*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
254200*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
254300*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
254400*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
254500*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
254600*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
254700*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
254800*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
254900*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE
255000*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
255100*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
255200*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
255300*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
255400*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
255500*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
255600*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND
255700*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
255800*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
255900*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
256000*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
256100*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
256200*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
256300*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
256400*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
256500*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
256600*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
256700*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
256800*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
256900*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
257000*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
257100*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
257200*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
257300*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
257400*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
257500*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
257600*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
257700*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
257800*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
257900*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
258000*    DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT
258100*    DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT
258200*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
258300*
258400*    END-IF.
258500
258600 9000-EXIT.
258700      EXIT.
258800
258900******        L A S T   S O U R C E   S T A T E M E N T   *****
