000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL202.
000300*AUTHOR.         CMS.
000400*REMARKS.        EFFECTIVE DATE = COST REPORTING PERIODS
000500*                BEGINNING ON OR AFTER OCTOBER 1, 2019
000600***********************************************************
000700*
000800* UPDATED APRIL 8, 2020
000900* VERSION 20.2 PRODUCTION
001000* IMPLEMENT CHANGES IN CR11742 - QUARTERLY UPDATE TO THE LONG
001100* TERM CARE HOSPITAL (LTCH) PROSPECTIVE PAYMENT SYSTEM (PPS)
001200* FISCAL YEAR (FY) 2020 PRICER
001300*
001400* INCLUDES CHANGES FOR COVID-19 AS FOLLOWS:
001500*    - EFFECTIVE FOR ALL CLAIMS WITH ADMISSION DATES ON AND
001600*      AFTER JANUARY 27, 2020
001700*    - BECAUSE THE LTCH PRICER DOESN'T RECEIVE THE ADMISSION
001800*      DATE, IT WILL CALCULATE IT AS:
001900*        ADMISSION DATE = DISCHARGE DATE - LENGTH OF STAY
002000*    - IF THE ADMISSION DATE IS ON OR AFTER 1/27/2020 AND THE
002100*      REVIEW CODE INDICATES A SITE NEUTRAL PAYMENT, PRICER
002200*      WILL RE-ROUTE THE CLAIM TO PAY THE STANDARD PAYMENT.
002300*
002400*
002500* STILL USES THE FOLLOWING RATES FROM VERSION 20.0:
002600* CR11361
002700* FROM: FY 2020 LTCH PPS PRICER SPEC SHEET
002800* UPDATE FOR CORRECTION NOTICE
002900* DATE: SEPTEMBER 13, 2019
003000*
003100* PRICER STANDARD FEDERAL RATES/FACTORS/POLICY:
003200*
003300* STANDARD FEDERAL RATES (BASED ON QUALITY DATA REPORT STATUS
003400* FOR FY2020):
003500*
003600*   FULL UPDATE (QUALITY INDICATOR ON PSF = 1): $42,677.64
003700*   REDUCED UPDATE (QUALITY INDICATOR ON PSF = 0 OR
003800*      BLANK): $41,844.90
003900*
004000* LABOR SHARE: 66.3% (0.663)
004100*
004200* NONLABOR SHARE: 33.7% (0.337)
004300*
004400* HIGH COST OUTLIER FIXED-LOSS AMOUNTS (NO POLICY/CALCULATION
004500*   LOGIC CHANGES)
004600*    - STANDARD RATE CASES: $26778
004700*    - SITE NEUTRAL RATE CASES: $26552
004800*
004900* SITE NEUTRAL PAYMENT RATE BLEND (BASED ON BLEND YEAR VALUE IN
005000*   PSF):
005100*
005200*    - 100% STANDARD FEDERAL PAYMENT RATE PAYMENT (FEDBLEND = 5
005300*      IN PSF): NO CHANGE
005400*    - 50% STANDARD FEDERAL PAYMENT RATE PAYMENT + 50% SITE
005500*      NEUTRAL PAYMENT RATE PAYMENT (FEDBLEND = 6, 7 IN PSF):
005600*      NO CHANGE
005700*    - 100% SITE NEUTRAL PAYMENT RATE PAYMENT (FEDBLEND = 8 IN
005800*      PSF): NO CHANGE
005900*
006000* SITE NEUTRAL RATE HCO BUDGET NEUTRALITY FACTOR: 0.949 (NO
006100*   POLICY/CALCULATION LOGIC CHANGES)
006200*
006300* SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS: - 0.954 (NO
006400*   POLICY/CALCULATION LOGIC CHANGES)
006500*
006600* SSO AND SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS:
006700*
006800* IPPS LABOR SHARE WAGE INDEX > 1:   $3959.10
006900* IPPS NONLABOR SHARE WAGE INDEX > 1:   $1837.53
007000* IPPS LABOR SHARE WAGE INDEX < /= 1:   $3593.91
007100* IPPS NONLABOR SHARE WAGE INDEX < /= 1:   $2202.72
007200* CAPITAL NATIONAL RATE: $462.33
007300*
007400* - REDUCTION FACTOR FOR IPPS COMPARABLE OPERATING DSH PAYMENT
007500* AMOUNT: 75.36% OR A FACTOR OF 0.7536. (THIS REDUCTION IS NOT
007600* APPLIED TO THE CAPITAL DSH PAYMENT CALCULATION.)
007700*
007800*
007900* - USE FY 2020 IPPS AREA WAGE INDEXES & MS-DRG WEIGHTS/LENGTH
008000*   OF STAY
008100*
008200*  * LOGIC IMPLEMENTING THE IPPS COMPARABLE WAGE INDEX MIRRORS
008300*    THE LOGIC FOR THE FY 2020 IPPS WI'S RURAL FLOOR POLICY.
008400*
008500***********************************************************
008600 ENVIRONMENT DIVISION.
008700 CONFIGURATION SECTION.
008800 SOURCE-COMPUTER.            IBM-370.
008900 OBJECT-COMPUTER.            IBM-370.
009000 INPUT-OUTPUT  SECTION.
009100 FILE-CONTROL.
009200
009300 DATA DIVISION.
009400 FILE SECTION.
009500
009600 WORKING-STORAGE SECTION.
009700 01  W-STORAGE-REF                  PIC X(46)  VALUE
009800     'LTCAL202      - W O R K I N G   S T O R A G E'.
009900 01  CAL-VERSION                    PIC X(05)  VALUE 'V20.2'.
010000 01  PROGRAM-CONSTANTS.
010100     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
010200     05  VENT-ICD-10-CODE           PIC X(07) VALUE '5A1955Z'.
010300 01  PROGRAM-FLAGS.
010400     05  WS-PRIMARY-PMT-TYPE        PIC X(01).
010500         88 PMT-STANDARD-OLD       VALUE '1'.
010600         88 PMT-STANDARD-NEW       VALUE '2'.
010700         88 PMT-SITE-NEUTRAL       VALUE '3'.
010800         88 PMT-BLEND              VALUE '4'.
010900     05  WS-SECONDARY-PMT-TYPE-SNT  PIC X(01).
011000         88 PMT-SITE-NEUT-COST     VALUE '1'.
011100         88 PMT-SITE-NEUT-IPPS     VALUE '2'.
011200     05  WS-SECONDARY-PMT-TYPE-STD  PIC X(01).
011300         88 PMT-STANDARD-FULL      VALUE '1'.
011400         88 PMT-STANDARD-SSO       VALUE '2'.
011500     05  WS-VENT-STATUS             PIC X(01).
011600         88 VENT-PRESENT           VALUE 'Y'.
011700         88 VENT-NOT-PRESENT       VALUE 'N'.
011800
011900
012000***************************************************************
012100*    LAYUP TABLE AREA FOR FY2020 LTC-DRG                      *
012200*    EFFECTIVE DATE OF OCTOBER 1, 2019                        *
012300***************************************************************
012400 COPY LTDRG200.
012500
012600
012700***************************************************************
012800*    LAYUP TABLE AREA FOR FY2020 IPPS-DRG                     *
012900*    EFFECTIVE DATE OF OCTOBER 1, 2019                        *
013000***************************************************************
013100 COPY IPDRG200.
013200
013300
013400***************************************************************
013500*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
013600***************************************************************
013700 01  HOLD-PPS-COMPONENTS.
013800     05  H-LOS                        PIC 9(03).
013900     05  H-REG-DAYS                   PIC 9(03).
014000     05  H-TOTAL-DAYS                 PIC 9(05).
014100     05  H-SSOT                       PIC 9(02)V9(01).
014200     05  H-BLEND-RTC                  PIC 9(02).
014300     05  H-BLEND-SNT                  PIC 9(01)V9(01).
014400     05  H-BLEND-STD                  PIC 9(01)V9(01).
014500     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
014600     05  H-SS-COST                    PIC 9(07)V9(02).
014700     05  H-LABOR-PORTION              PIC 9(07)V9(06).
014800     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
014900     05  H-FIXED-LOSS-AMT-STD         PIC 9(07)V9(02).
015000     05  H-FIXED-LOSS-AMT-SNT         PIC 9(07)V9(02).
015100     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
015200     05  H-LOS-RATIO                  PIC 9(01)V9(05).
015300     05  H-ADMISSION-DATE             PIC 9(08).
015400     05  H-DISCHARGE-DATE             PIC 9(08).
015500     05  H-ADMISS-DATE-INT            PIC 9(07).
015600
015700*** --------------------------------------------------- ***
015800*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
015900*** --------------------------------------------------- ***
016000     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
016100     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
016200     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
016300     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
016400     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
016500     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
016600     05  H-INTERN-RATIO               PIC 9(01)V9(04).
016700     05  H-CAPI-IME-RATIO             PIC 9V9999.
016800     05  H-BED-SIZE                   PIC 9(05).
016900     05  H-OPER-DSH-PCT               PIC V9(04).
017000     05  H-SSI-RATIO                  PIC V9(04).
017100     05  H-MEDICAID-RATIO             PIC V9(04).
017200     05  H-OPER-DSH                   PIC 9(01)V9(04).
017300     05  H-CAPI-DSH                   PIC 9(01)V9(04).
017400     05  H-GEO-CLASS                  PIC X(01).
017500     05  H-URBAN-IND                  PIC X(01).
017600           88 URBAN-CBSA           VALUE '1'.
017700           88 RURAL-CBSA           VALUE '0'.
017800     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
017900     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
018000     05  H-CAPI-PMT                   PIC 9(07)V9(02).
018100     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
018200     05  H-CAPI-GAF                   PIC 9(05)V9(04).
018300     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
018400     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
018500     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
018600     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
018700     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
018800     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
018900     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
019000     05  H-OPER-COLA                  PIC 9(01)V9(03).
019100     05  H-CAPI-COLA                  PIC 9(01)V9(03).
019200     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
019300     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
019400     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
019500     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
019600     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
019700     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
019800     05  H-IPPS-DAYS-CUTOFF           PIC 9(02)V9(01).
019900     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
020000     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
020100     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
020200*    05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
020300*    05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
020400     05  H-NAT-OPER-IPPS-PMT-PCT      PIC 9(01)V9(02).
020500     05  H-PR-OPER-IPPS-PMT-PCT       PIC 9(01)V9(02).
020600     05  H-NAT-CAPI-IPPS-PMT-PCT      PIC 9(01)V9(02).
020700     05  H-PR-CAPI-IPPS-PMT-PCT       PIC 9(01)V9(02).
020800     05  H-COUNTER                    PIC 9(02).
020900     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).
021000     05  H-OPER-DSH-REDUCTION-FACTOR  PIC V9(04).
021100     05  H-OUTLIER-THRESHOLD-STD      PIC 9(07)V9(02).
021200     05  H-BDGT-NEUT-FACTOR           PIC 9(01)V9(06).
021300     05  H-OUTLIER-PAY-AMT-STD        PIC 9(07)V9(02).
021400     05  H-OUTLIER-PAY-AMT-SNT        PIC 9(07)V9(02).
021500     05  H-OUTLIER-IPPS-COMPARABLE    PIC 9(07)V9(02).
021600     05  H-SN-COST-4COMPARISON        PIC 9(07)V9(02).
021700     05  H-SN-IPPS-4COMPARISON        PIC 9(07)V9(02).
021800     05  H-SITE-NEUTRAL-IPPS-ADJ      PIC 9(01)V9(06).
021900     05  H-IPPS-LIKE-AMT              PIC 9(07)V9(02).
022000     05  H-IPPS-LIKE-AMT-OUTLIER      PIC 9(07)V9(02).
022100     05  H-PRE-DPP-PAY                PIC 9(07)V9(02).
022200
022300*** --------------------------------------------------- ***
022400*** VARIABLES FOR PC PRICER                             ***
022500*** --------------------------------------------------- ***
022600     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
022700     05  H-SS-COST-IND                PIC X.
022800     05  H-SS-PERDIEM-IND             PIC X.
022900     05  H-SS-BLEND-IND               PIC X.
023000     05  H-SS-IPPSCOMP-IND            PIC X.
023100
023200
023300*---------------------------------------------------------*
023400* 8-6-14 ADDED WK-HLDDRG-DATA AND WK-HLDDRG-DATA2 TO      *
023500* MATCH THE IPPS DRG TABLE DATA NAMES THAT WERE COPIED    *
023600* FROM THE FY14 IPPS PRICER CALCULATION PROGRAM           *
023700*---------------------------------------------------------*
023800
023900 01 WK-HLDDRG-DATA.
024000     05  HLDDRG-DATA.
024100         10  HLDDRG-DRGX               PIC X(03).
024200         10  FILLER1                   PIC X(01).
024300         10  HLDDRG-WEIGHT             PIC 9(02)V9(04).
024400         10  FILLER2                   PIC X(01).
024500         10  HLDDRG-GMALOS             PIC 9(02)V9(01).
024600         10  FILLER3                   PIC X(05).
024700         10  HLDDRG-LOW                PIC X(01).
024800         10  FILLER5                   PIC X(01).
024900         10  HLDDRG-ARITH-ALOS         PIC 9(02)V9(01).
025000         10  FILLER6                   PIC X(02).
025100         10  HLDDRG-PAC                PIC X(01).
025200         10  FILLER7                   PIC X(01).
025300         10  HLDDRG-SPPAC              PIC X(01).
025400         10  FILLER8                   PIC X(02).
025500         10  HLDDRG-DESC               PIC X(26).
025600
025700 01 WK-HLDDRG-DATA2.
025800     05  HLDDRG-DATA2.
025900         10  HLDDRG-DRGX2               PIC X(03).
026000         10  FILLER21                   PIC X(01).
026100         10  HLDDRG-WEIGHT2             PIC 9(02)V9(04).
026200         10  FILLER22                   PIC X(01).
026300         10  HLDDRG-GMALOS2             PIC 9(02)V9(01).
026400         10  FILLER23                   PIC X(05).
026500         10  HLDDRG-LOW2                PIC X(01).
026600         10  FILLER25                   PIC X(01).
026700         10  HLDDRG-ARITH-ALOS2         PIC 9(02)V9(01).
026800         10  FILLER26                   PIC X(02).
026900         10  HLDDRG-TRANS-FLAGS.
027000                   88  D-DRG-POSTACUTE-50-50
027100                   VALUE 'Y Y'.
027200                   88  D-DRG-POSTACUTE-PERDIEM
027300                   VALUE 'Y  '.
027400             15  HLDDRG-PAC2            PIC X(01).
027500             15  FILLER27               PIC X(01).
027600             15  HLDDRG-SPPAC2          PIC X(01).
027700         10  FILLER28                   PIC X(02).
027800         10  HLDDRG-DESC2               PIC X(26).
027900         10  HLDDRG-VALID               PIC X(01).
028000
028100
028200**** THESE ARE VARIABLES TO DISPLAY RESULTS FOR TESTING ***
028300 01  DISPLAY-VARIABLES.
028400     05 PSYCH-REHAB-DRG-PRESENT  PIC X(3) VALUE SPACE.
028500
028600
028700
028800
028900
029000 LINKAGE SECTION.
029100
029200**************************************************************
029300* THE LINKAGE SECTION CONTAINS DESCRIPTIONS OF THE FIELDS THAT
029400* CONTAIN VALUES THAT ARE PASSED FROM THE CALLING PROGRAM
029500* (LTDRV... IN THIS CASE)
029600**************************************************************
029700
029800
029900**************************************************************
030000* BILL-NEW-DATA IS THE BILL RECORD FROM THE LTDRV... PROGRAM
030100**************************************************************
030200 01  BILL-NEW-DATA.
030300     10  B-NPI10.
030400         15  B-NPI8               PIC X(08).
030500         15  B-NPI-FILLER         PIC X(02).
030600     10  B-PROVIDER-NO            PIC X(06).
030700     10  B-PATIENT-STATUS         PIC X(02).
030800     10  B-DRG-CODE               PIC 9(03).
030900     10  B-LOS                    PIC 9(03).
031000     10  B-COV-DAYS               PIC 9(03).
031100     10  B-LTR-DAYS               PIC 9(02).
031200     10  B-CST-RPT-DAYS           PIC 9(03).
031300     10  B-DISCHARGE-DATE.
031400         15  B-DISCHG-CC          PIC 9(02).
031500         15  B-DISCHG-YY          PIC 9(02).
031600         15  B-DISCHG-MM          PIC 9(02).
031700         15  B-DISCHG-DD          PIC 9(02).
031800     10  B-COV-CHARGES            PIC 9(07)V9(02).
031900     10  B-SPEC-PAY-IND           PIC X(01).
032000     05  B-REVIEW-CODE            PIC 9(02).
032100     05  B-DIAGNOSIS-CODE-TABLE.
032200         10  B-DIAGNOSIS-CODE     PIC X(07) OCCURS 25 TIMES
032300                                  INDEXED BY IDX-DIAG.
032400     05  B-PROCEDURE-CODE-TABLE.
032500         10  B-PROCEDURE-CODE     PIC X(07) OCCURS 25 TIMES
032600                                  INDEXED BY IDX-PROC.
032700     05  B-LTCH-DPP-INDICATOR-SW  PIC X.
032800         88 B-LTCH-DPP-ADJUSTMENT VALUE 'Y'.
032900     05  FILLER                   PIC X(19).
033000
033100
033200***************************************************************
033300***************************************************************
033400*                                                             *
033500*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *
033600*    AND PASSED BACK TO THE CALLING PROGRAM (LTDRV)           *
033700*    RETURN CODE VALUES (PPS-RTC)                             *
033800*                                                             *
033900*     ** OLD POLICY RETURN CODE VALUES AND DESCRIPTIONS       *
034000*     ** ----------------------------------------------       *
034100*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
034200*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
034300*                                                             *
034400*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
034500*                                                             *
034600*             02 = SHORT STAY PAYMENT WITHOUT OUTLIER         *
034700*                                                             *
034800*             03 = SHORT STAY PAYMENT WITH OUTLIER            *
034900*                                                             *
035000*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
035100*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
035200*                                                             *
035300*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
035400*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
035500*                                                             *
035600*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
035700*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
035800*                                                             *
035900*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
036000*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
036100*                                                             *
036200*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
036300*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
036400*                                                             *
036500*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
036600*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
036700*                                                             *
036800*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
036900*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
037000*                                                             *
037100*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
037200*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
037300*                                                             *
037400*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
037500*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
037600*                                                             *
037700*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
037800*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
037900*                                                             *
038000*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
038100*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
038200*                                                             *
038300*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
038400*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
038500*                                                             *
038600*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
038700*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
038800*                                                             *
038900*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
039000*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
039100*                                                             *
039200*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
039300*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
039400*                                                             *
039500*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
039600*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
039700*                                                             *
039800*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
039900*                  WITHOUT OUTLIER                            *
040000*                                                             *
040100*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
040200*                  DIEM WITHOUT OUTLIER                       *
040300*                                                             *
040400*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
040500*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
040600*                  AMOUNT WITHOUT OUTLIER                     *
040700*                                                             *
040800*             23 = SHORT STAY PAYMENT BASED ON ESTIMATED      *
040900*                  COST WITH OUTLIER                          *
041000*                                                             *
041100*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
041200*                  DIEM WITH OUTLIER                          *
041300*                                                             *
041400*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
041500*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
041600*                  AMOUNT WITH OUTLIER                        *
041700*                                                             *
041800*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *
041900*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *
042000*            FOR IPPS COMPARABLE PER DIEM)                    *
042100*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *
042200*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *
042300*            FOR IPPS COMPARABLE PER DIEM)                    *
042400*                                                             *
042500*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
042600*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
042700*                                                             *
042800*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
042900*                  COMPARABLE THRESHOLD WITH OUTLIER          *
043000*                                                             *
043100*             28 = SUBCLAUSE (II) DOES NOT QUALIFY FOR AN     *
043200*                  OUTLIER                                    *
043300*                                                             *
043400*             29 = SUBCLAUSE (II) QUALIFIES FOR AN OUTLIER    *
043500*                                                             *
043600*                                                             *
043700*     ** OLD & NEW POLICY ERROR CODE VALUES AND DESCRIPTIONS  *
043800*     ** ---------------------------------------------------  *
043900*     *****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
044000*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
044100*             51 = PROVIDER RECORD TERMINATED                 *
044200*             52 = INVALID WAGE INDEX                         *
044300*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
044400*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
044500*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
044600*                                     OR                      *
044700*                  DISCHARGE DATE < CBSA EFF START DATE       *
044800*                  FOR PPS                                    *
044900*             56 = INVALID LENGTH OF STAY                     *
045000*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
045100*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
045200*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
045300*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
045400*                  OR BILL-LTR-DAYS > 60                      *
045500*             62 = INVALID NUMBER OF COVERED DAYS             *
045600*                  OR BILL-LTR-DAYS > COVERED DAYS            *
045700*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
045800*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
045900*                  OR COST OUTLIER THRESHOLD CALCULATION      *
046000*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *
046100*             72 = INVALID BLEND INDICATOR OR REVIEW CODE     *
046200*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
046300*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
046400*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *
046500*                                                             *
046600*                                                             *
046700*             ADDITIONAL RETURN CODES STARTING IN 2016:       *
046800*                                                             *
046900*             A0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
047000*                  PSYCH/REHAB                                *
047100*                                                             *
047200*             A1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
047300*                  OUTLIER, PSYCH/REHAB                       *
047400*                                                             *
047500*             A2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
047600*                  SSO, PSYCH/REHAB                           *
047700*                                                             *
047800*             A3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
047900*                  SSO, OUTLIER, PSYCH/REHAB                  *
048000*                                                             *
048100*             A4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
048200*                  PSYCH/REHAB                                *
048300*                                                             *
048400*             A5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
048500*                  OUTLIER, PSYCH/REHAB                       *
048600*                                                             *
048700*             A6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
048800*                  SSO, PSYCH/REHAB                           *
048900*                                                             *
049000*             A7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
049100*                  SSO, OUTLIER, PSYCH/REHAB                  *
049200*                                                             *
049300*             AA = SITE-NEUTRAL BASED ON COST,                *
049400*                  PSYCH/REHAB                                *
049500*                                                             *
049600*             AB = SITE-NEUTRAL BASED ON IPPS,                *
049700*                  PSYCH/REHAB                                *
049800*                                                             *
049900*             AC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
050000*                  PSYCH/REHAB                                *
050100*                                                             *
050200*             B0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
050300*                  VENT                                       *
050400*                                                             *
050500*             B1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
050600*                  OUTLIER, VENT                              *
050700*                                                             *
050800*             B2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
050900*                  SSO, VENT                                  *
051000*                                                             *
051100*             B3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
051200*                  SSO, OUTLIER, VENT                         *
051300*                                                             *
051400*             B4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
051500*                  VENT                                       *
051600*                                                             *
051700*             B5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
051800*                  OUTLIER, VENT                              *
051900*                                                             *
052000*             B6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
052100*                  SSO, VENT                                  *
052200*                                                             *
052300*             B7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
052400*                  SSO, OUTLIER, VENT                         *
052500*                                                             *
052600*             BA = SITE-NEUTRAL BASED ON COST, VENT           *
052700*                                                             *
052800*             BB = SITE-NEUTRAL BASED ON IPPS, VENT           *
052900*                                                             *
053000*             BC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
053100*                  VENT                                       *
053200*                                                             *
053300*             BD = SSO STANDARD PAYMENT, VENT                 *
053400*                                                             *
053500*             BE = SSO STANDARD PAYMENT, OUTLIER, VENT        *
053600*                                                             *
053700*             BF = STANDARD PAYMENT FULL DRG, VENT            *
053800*                                                             *
053900*             BG = STANDARD PAYMENT FULL DRG, OUTLIER,        *
054000*                  VENT                                       *
054100*                                                             *
054200*             C0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
054300*                  NO VENT                                    *
054400*                                                             *
054500*             C1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
054600*                  OUTLIER, NO VENT                           *
054700*                                                             *
054800*             C2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
054900*                  SSO, NO VENT                               *
055000*                                                             *
055100*             C3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
055200*                  SSO, OUTLIER, NO VENT                      *
055300*                                                             *
055400*             C4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
055500*                  NO VENT                                    *
055600*                                                             *
055700*             C5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
055800*                  OUTLIER, NO VENT                           *
055900*                                                             *
056000*             C6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
056100*                  SSO, NO VENT                               *
056200*                                                             *
056300*             C7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
056400*                  SSO, OUTLIER, NO VENT                      *
056500*                                                             *
056600*             CA = SITE-NEUTRAL BASED ON COST, NO VENT        *
056700*                                                             *
056800*             CB = SITE-NEUTRAL BASED ON IPPS, NO VENT        *
056900*                                                             *
057000*             CC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
057100*                  NO VENT                                    *
057200*                                                             *
057300*             CD = SSO STANDARD PAYMENT, NO VENT              *
057400*                                                             *
057500*             CE = SSO STANDARD PAYMENT, OUTLIER,             *
057600*                  NO VENT                                    *
057700*                                                             *
057800*             CF = STANDARD PAYMENT FULL DRG, NO VENT         *
057900*                                                             *
058000*             CG = STANDARD PAYMENT FULL DRG, OUTLIER,        *
058100*                  NO VENT                                    *
058200*                                                             *
058300*                                                             *
058400***************************************************************
058500***************************************************************
058600*
058700*
058800***************************************************************
058900* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
059000* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
059100***************************************************************
059200 01  PPS-DATA-ALL.
059300     05  PPS-RTC.
059400           88  OLD-ERROR-CODE        VALUE '50' THRU '99'.
059500         10  PPS-RTC-1                 PIC X.
059600               88  NEW-ERROR-CODE    VALUE 'D'.
059700         10  PPS-RTC-2                 PIC X.
059800     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
059900     05  PPS-DATA.
060000         10  PPS-MSA                   PIC X(04).
060100         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
060200         10  PPS-AVG-LOS               PIC 9(02)V9(01).
060300         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
060400         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
060500         10  PPS-LOS                   PIC 9(03).
060600         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
060700         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
060800         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
060900         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
061000         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
061100         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
061200         10  PPS-SUBM-DRG-CODE         PIC X(03).
061300               88  PSYCH-REHAB-DRG   VALUE
061400                   '876' '880' '881' '882' '883' '884'
061500                   '885' '887' '886' '894' '895' '896'
061600                   '897' '945' '946'.
061700         10  PPS-CALC-VERS-CD          PIC X(05).
061800         10  PPS-REG-DAYS-USED         PIC 9(03).
061900         10  PPS-LTR-DAYS-USED         PIC 9(03).
062000         10  PPS-BLEND-YEAR            PIC 9(01).
062100         10  PPS-COLA                  PIC 9(01)V9(03).
062200         10  FILLER                    PIC X(04).
062300     05  PPS-OTHER-DATA.
062400         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
062500         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
062600         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
062700         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
062800         10  PPS-IPTHRESH              PIC 9(03)V9(01).
062900         10  PPS-LTCH-DPP-ADJ-AMT      PIC S9(09)V99.
063000         10  FILLER                    PIC X(05).
063100
063200     05  PPS-PC-DATA.
063300         10  PPS-COT-IND               PIC X(01).
063400         10  H-PC-IND                  PIC X(02).
063500               88  PC-PRICER               VALUE 'PC'.
063600         10  FILLER                    PIC X(18).
063700
063800 01  PPS-CBSA                          PIC X(05).
063900
064000
064100 01  PPS-PAYMENT-DATA.
064200     05  PPS-SITE-NEUTRAL-COST-PMT     PIC  9(07)V99.
064300     05  PPS-SITE-NEUTRAL-IPPS-PMT     PIC  9(07)V99.
064400     05  PPS-STANDARD-FULL-PMT         PIC  9(07)V99.
064500     05  PPS-STANDARD-SSO-PMT          PIC  9(07)V99.
064600
064700
064800******************************************************************
064900*            THESE ARE THE VERSIONS OF THE LTDRV___              *
065000*           PROGRAMS THAT WILL BE PASSED BACK----                *
065100*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
065200******************************************************************
065300 01  PRICER-OPT-VERS-SW.
065400     05  PRICER-OPTION-SW          PIC X(01).
065500         88  ALL-TABLES-PASSED          VALUE 'A'.
065600         88  PROV-RECORD-PASSED         VALUE 'P'.
065700     05  PPS-VERSIONS.
065800         10  PPDRV-VERSION         PIC X(05).
065900
066000
066100**************************************************************
066200* PROV-NEW-HOLD IS THE PROVIDER RECORD THAT IS PASSED FROM   *
066300* LTDRV___) TO LTCAL___                                      *
066400**************************************************************
066500 01  PROV-NEW-HOLD.
066600     02  PROV-NEWREC-HOLD1.
066700         05  P-NEW-NPI10.
066800             10  P-NEW-NPI8             PIC X(08).
066900             10  P-NEW-NPI-FILLER       PIC X(02).
067000         05  P-NEW-PROVIDER-NO.
067100               88  SUBCLAUSEII-PROV       VALUE '332006'.
067200             10  P-NEW-STATE            PIC 9(02).
067300             10  P-NEW-STATE-X REDEFINES
067400                 P-NEW-STATE            PIC X(02).
067500             10  FILLER                 PIC X(04).
067600         05  P-NEW-DATE-DATA.
067700             10  P-NEW-EFF-DATE.
067800                 15  P-NEW-EFF-DT-CC    PIC 9(02).
067900                 15  P-NEW-EFF-DT-YY    PIC 9(02).
068000                 15  P-NEW-EFF-DT-MM    PIC 9(02).
068100                 15  P-NEW-EFF-DT-DD    PIC 9(02).
068200             10  P-NEW-FY-BEGIN-DATE.
068300                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).
068400                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).
068500                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).
068600                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).
068700             10  P-NEW-REPORT-DATE.
068800                 15  P-NEW-REPORT-DT-CC PIC 9(02).
068900                 15  P-NEW-REPORT-DT-YY PIC 9(02).
069000                 15  P-NEW-REPORT-DT-MM PIC 9(02).
069100                 15  P-NEW-REPORT-DT-DD PIC 9(02).
069200             10  P-NEW-TERMINATION-DATE.
069300                 15  P-NEW-TERM-DT-CC   PIC 9(02).
069400                 15  P-NEW-TERM-DT-YY   PIC 9(02).
069500                 15  P-NEW-TERM-DT-MM   PIC 9(02).
069600                 15  P-NEW-TERM-DT-DD   PIC 9(02).
069700         05  P-NEW-WAIVER-CODE          PIC X(01).
069800             88  P-NEW-WAIVER-STATE       VALUE 'Y'.
069900         05  P-NEW-INTER-NO             PIC 9(05).
070000         05  P-NEW-PROVIDER-TYPE        PIC X(02).
070100         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
070200         05  P-NEW-CURRENT-DIV   REDEFINES
070300                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
070400         05  P-NEW-MSA-DATA.
070500             10  P-NEW-CHG-CODE-INDEX       PIC X.
070600             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT.
070700             10  P-NEW-GEO-LOC-MSA9   REDEFINES
070800                             P-NEW-GEO-LOC-MSAX  PIC 9(04).
070900             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT.
071000             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT.
071100             10  P-NEW-STAND-AMT-LOC-MSA9
071200                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.
071300                 15  P-NEW-RURAL-1ST.
071400                     20  P-NEW-STAND-RURAL  PIC XX.
071500                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.
071600                 15  P-NEW-RURAL-2ND        PIC XX.
071700         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.
071800         05  P-NEW-LUGAR                    PIC X.
071900         05  P-NEW-TEMP-RELIEF-IND          PIC X.
072000         05  P-NEW-FED-PPS-BLEND-IND        PIC X.
072100         05  P-NEW-STATE-CODE               PIC 9(02).
072200         05  P-NEW-STATE-CODE-X REDEFINES
072300               P-NEW-STATE-CODE             PIC X(02).
072400         05  FILLER                         PIC X(03).
072500     02  PROV-NEWREC-HOLD2.
072600         05  P-NEW-VARIABLES.
072700             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).
072800             10  P-NEW-COLA              PIC  9(01)V9(03).
072900             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).
073000             10  P-NEW-BED-SIZE          PIC  9(05).
073100             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).
073200             10  P-NEW-CMI               PIC  9(01)V9(04).
073300             10  P-NEW-SSI-RATIO         PIC  V9(04).
073400             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).
073500             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).
073600             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).
073700             10  P-NEW-DSH-PERCENT       PIC  V9(04).
073800             10  P-NEW-FYE-DATE          PIC  X(08).
073900         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).
074000         05  P-NEW-HOSP-QUAL-IND           PIC X(01).
074100         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.
074200         05  P-NEW-GEO-LOC-CBSA9 REDEFINES
074300                       P-NEW-GEO-LOC-CBSAX PIC 9(05).
074400         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES
074500                       P-NEW-GEO-LOC-CBSAX.
074600             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.
074700             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.
074800             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.
074900             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.
075000             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.
075100         05  FILLER                        PIC X(10).
075200         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).
075300     02  PROV-NEWREC-HOLD3.
075400         05  P-NEW-PASS-AMT-DATA.
075500             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.
075600             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.
075700             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.
075800             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.
075900         05  P-NEW-CAPI-DATA.
076000             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.
076100             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.
076200             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.
076300             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.
076400             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.
076500             15  P-NEW-CAPI-NEW-HOSP       PIC X.
076600             15  P-NEW-CAPI-IME            PIC 9V9999.
076700             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.
076800             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.
076900         05  FILLER                        PIC X(18).
077000
077100
077200******************************************************************
077300*                THIS IS THE LTCH WAGE-INDEX                     *
077400*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
077500*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *
077600******************************************************************
077700 01  WAGE-NEW-INDEX-RECORD.
077800     05  W-CBSA                        PIC X(5).
077900     05  W-EFF-DATE                    PIC X(8).
078000     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).
078100     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).
078200     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).
078300
078400
078500******************************************************************
078600*                THIS IS THE IPPS WAGE-INDEX                     *
078700*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
078800******************************************************************
078900 01  WAGE-NEW-IPPS-INDEX-RECORD.
079000     05  W-CBSA-IPPS.
079100         10 CBSA-IPPS-123              PIC X(3).
079200         10 CBSA-IPPS-45               PIC X(2).
079300     05  W-CBSA-IPPS-SIZE              PIC X.
079400         88  LARGE-URBAN       VALUE 'L'.
079500         88  OTHER-URBAN       VALUE 'O'.
079600         88  ALL-RURAL         VALUE 'R'.
079700     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).
079800     05  FILLER                        PIC X.
079900     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).
080000     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).
080100
080200 PROCEDURE DIVISION  USING BILL-NEW-DATA
080300                           PPS-DATA-ALL
080400                           PPS-CBSA
080500                           PPS-PAYMENT-DATA
080600                           PRICER-OPT-VERS-SW
080700                           PROV-NEW-HOLD
080800                           WAGE-NEW-INDEX-RECORD
080900                           WAGE-NEW-IPPS-INDEX-RECORD.
081000
081100
081200***************************************************************
081300*                                                             *
081400*    PROCESSING:                                              *
081500*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
081600*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
081700*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
081800*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
081900*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
082000*           GOBACK.                                           *
082100*        D. ASSEMBLE PRICING COMPONENTS.                      *
082200*        E. CALCULATE THE PRICE.                              *
082300*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
082400*                                                             *
082500***************************************************************
082600
082700
082800***************************************************************
082900 0000-MAINLINE-CONTROL.
083000***************************************************************
083100
083200     PERFORM 0100-INITIAL-ROUTINE
083300        THRU 0100-EXIT.
083400
083500     PERFORM 1000-EDIT-INPUT-DATA
083600        THRU 1000-EXIT.
083700
083800     IF PPS-RTC = '00'
083900        PERFORM 1700-EDIT-DRG-CODE
084000           THRU 1700-EXIT.
084100
084200     IF PPS-RTC = '00'
084300        PERFORM 1800-EDIT-IPPS-DRG-CODE
084400           THRU 1800-EXIT.
084500
084600     IF PPS-RTC = '00'
084700        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
084800           THRU 2000-EXIT.
084900
085000     IF PPS-RTC = '00'
085100        PERFORM 3000-CALC-PAYMENT
085200           THRU 3000-EXIT.
085300
085400     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
085500        PERFORM 6000-CALC-HIGH-COST-OUTLIER
085600           THRU 6000-EXIT.
085700
085800     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
085900        PERFORM 7000-SET-FINAL-RETURN-CODES
086000           THRU 7000-EXIT.
086100
086200     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
086300        PERFORM 8000-CALC-FINAL-PMT
086400           THRU 8000-EXIT.
086500
086600     PERFORM 9000-MOVE-RESULTS
086700        THRU 9000-EXIT.
086800
086900     GOBACK.
087000
087100
087200***************************************************************
087300 0100-INITIAL-ROUTINE.
087400***************************************************************
087500
087600     MOVE '00' TO PPS-RTC.
087700     INITIALIZE PPS-DATA.
087800     INITIALIZE PPS-OTHER-DATA.
087900     INITIALIZE PPS-CBSA.
088000     INITIALIZE PPS-PAYMENT-DATA.
088100     INITIALIZE HOLD-PPS-COMPONENTS.
088200     INITIALIZE PROGRAM-FLAGS.
088300     INITIALIZE WK-HLDDRG-DATA
088400                WK-HLDDRG-DATA2.
088500
088600     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.
088700
088800
088900*** ---------------------------------------------------- ***
089000*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***
089100*** ---------------------------------------------------- ***
089200     MOVE .663 TO PPS-NAT-LABOR-PCT.
089300     MOVE .337 TO PPS-NAT-NONLABOR-PCT.
089400
089500*** --------------------------------------------------------
089600*** NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
089700*** REPORTING OF QUALITY DATA.
089800*** - FULL UPDATE (QUALITY INDICATOR ON PSF = 1)
089900*** - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK)
090000*** --------------------------------------------------------
090100     IF P-NEW-HOSP-QUAL-IND = '1'
090200        MOVE 42677.64 TO PPS-STD-FED-RATE
090300     ELSE
090400        MOVE 41844.90 TO PPS-STD-FED-RATE.
090500     MOVE 26778.00 TO H-FIXED-LOSS-AMT-STD.
090600     MOVE 26552.00 TO H-FIXED-LOSS-AMT-SNT.
090700     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.
090800
090900*** ---------------------------------------------------- ***
091000*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
091100*** ---------------------------------------------------- ***
091200     MOVE 462.33 TO H-IPPS-CAPI-STD-FED-RATE.
091300
091400     MOVE W-IPPS-WAGE-INDEX TO H-IPPS-WAGE-INDEX.
091500
091600     IF H-IPPS-WAGE-INDEX > 1
091700           MOVE 3959.10 TO H-IPPS-NAT-LABOR-SHR
091800           MOVE 1837.53 TO H-IPPS-NAT-NONLABOR-SHR
091900     ELSE
092000           MOVE 3593.91 TO H-IPPS-NAT-LABOR-SHR
092100           MOVE 2202.72 TO H-IPPS-NAT-NONLABOR-SHR
092200     END-IF.
092300
092400*** ---------------------------------------------------- ***
092500*** OPERATING DSH REDUCTION FACTOR                       ***
092600*** -----------------------------------------------------***
092700     MOVE 0.7536 TO H-OPER-DSH-REDUCTION-FACTOR.
092800
092900 0100-EXIT.
093000      EXIT.
093100
093200
093300***************************************************************
093400*    INPUT DATA EDITS - IF ANY FAIL SET PPS-RTC               *
093500*    AND DO NOT ATTEMPT TO PRICE.                             *
093600***************************************************************
093700 1000-EDIT-INPUT-DATA.
093800***************************************************************
093900
094000*** -----------------------------------------------------------
094100*** EDIT BILL (BILL-NEW-DATA) INPUT & SET ERROR CODE IF FAIL
094200*** -----------------------------------------------------------
094300     IF (B-LOS NUMERIC) AND (B-LOS > 0)
094400        MOVE B-LOS TO H-LOS
094500     ELSE
094600        MOVE '56' TO PPS-RTC.
094700
094800     IF PPS-RTC = '00'
094900        IF P-NEW-COLA NOT NUMERIC
095000           MOVE '50' TO PPS-RTC.
095100
095200     IF PPS-RTC = '00'
095300        IF P-NEW-WAIVER-STATE
095400           MOVE '53' TO PPS-RTC.
095500
095600     IF PPS-RTC = '00'
095700        IF B-DRG-CODE NOT NUMERIC
095800           MOVE '54' TO PPS-RTC.
095900
096000     IF PPS-RTC = '00'
096100        IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
096200           (B-DISCHARGE-DATE < W-EFF-DATE))
096300            MOVE '55' TO PPS-RTC.
096400
096500     IF PPS-RTC = '00'
096600        IF P-NEW-TERMINATION-DATE > 00000000
096700           IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
096800              MOVE '51' TO PPS-RTC.
096900
097000     IF PPS-RTC = '00'
097100        IF B-COV-CHARGES NOT NUMERIC
097200           MOVE '58' TO PPS-RTC.
097300
097400     IF PPS-RTC = '00'
097500        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
097600           MOVE '61' TO PPS-RTC.
097700
097800     IF PPS-RTC = '00'
097900        IF (B-COV-DAYS NOT NUMERIC) OR
098000           (B-COV-DAYS = 0 AND H-LOS > 0)
098100           MOVE '62' TO PPS-RTC.
098200
098300     IF PPS-RTC = '00'
098400        IF B-LTR-DAYS > B-COV-DAYS
098500           MOVE '62' TO PPS-RTC.
098600
098700     IF PPS-RTC = '00'
098800        IF (B-REVIEW-CODE < 00 OR B-REVIEW-CODE > 08) OR
098900           (B-REVIEW-CODE NOT NUMERIC)
099000           MOVE '72' TO PPS-RTC.
099100
099200
099300*** -----------------------------------------------------------
099400*** CALCULATE DAY RELATED VARIABLE VALUES
099500*** -----------------------------------------------------------
099600     IF PPS-RTC = '00'
099700        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
099800        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
099900
100000     IF PPS-RTC = '00'
100100        PERFORM 1200-DAYS-USED
100200           THRU 1200-DAYS-USED-EXIT.
100300
100400
100500*** -----------------------------------------------------------
100600*** EDIT PSF FIELDS USED BY ALL CLAIMS & SET ERROR CODE IF FAIL
100700*** -----------------------------------------------------------
100800
100900*-------------------------------------------------------------*
101000* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
101100* (ALWAYS FED-FY-BEGIN-03)                                    *
101200*-------------------------------------------------------------*
101300     IF PPS-RTC = '00'
101400        IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
101500           MOVE '74' TO PPS-RTC.
101600
101700*-------------------------------------------------------------*
101800* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
101900*-------------------------------------------------------------*
102000     IF PPS-RTC = '00'
102100        IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
102200           MOVE '65' TO PPS-RTC.
102300
102400
102500*** -----------------------------------------------------------
102600*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
102700*** -----------------------------------------------------------
102800     IF PPS-RTC = '00'
102900        IF P-NEW-CAPI-IME NUMERIC
103000           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
103100        ELSE
103200           MOVE ZEROS TO H-CAPI-IME-RATIO
103300        END-IF
103400     END-IF.
103500
103600     IF PPS-RTC = '00'
103700        IF P-NEW-INTERN-RATIO NUMERIC
103800           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
103900        ELSE
104000           MOVE ZEROS TO H-INTERN-RATIO
104100        END-IF
104200     END-IF.
104300
104400     IF PPS-RTC = '00'
104500        IF P-NEW-BED-SIZE NUMERIC
104600           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
104700        ELSE
104800           MOVE ZEROS TO H-BED-SIZE
104900        END-IF
105000     END-IF.
105100
105200     IF PPS-RTC = '00'
105300        IF P-NEW-SSI-RATIO NUMERIC
105400           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
105500        ELSE
105600           MOVE ZEROS TO H-SSI-RATIO
105700        END-IF
105800     END-IF.
105900
106000     IF PPS-RTC = '00'
106100        IF P-NEW-MEDICAID-RATIO NUMERIC
106200           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
106300        ELSE
106400           MOVE ZEROS TO H-MEDICAID-RATIO
106500        END-IF
106600     END-IF.
106700
106800
106900 1000-EXIT.
107000      EXIT.
107100
107200
107300***************************************************************
107400 1200-DAYS-USED.
107500***************************************************************
107600
107700     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
107800        IF B-LTR-DAYS > H-LOS
107900           MOVE H-LOS TO PPS-LTR-DAYS-USED
108000        ELSE
108100           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
108200     ELSE
108300        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
108400           IF H-REG-DAYS > H-LOS
108500              MOVE H-LOS TO PPS-REG-DAYS-USED
108600           ELSE
108700              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
108800        ELSE
108900           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
109000              IF H-REG-DAYS > H-LOS
109100                 MOVE H-LOS TO PPS-REG-DAYS-USED
109200                 MOVE 0 TO PPS-LTR-DAYS-USED
109300              ELSE
109400                 IF H-TOTAL-DAYS > H-LOS
109500                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
109600                    COMPUTE PPS-LTR-DAYS-USED =
109700                            H-LOS - H-REG-DAYS
109800                 ELSE
109900                    IF H-TOTAL-DAYS <= H-LOS
110000                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
110100                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
110200                    ELSE
110300                       NEXT SENTENCE
110400           ELSE
110500              NEXT SENTENCE.
110600
110700 1200-DAYS-USED-EXIT.
110800      EXIT.
110900
111000
111100***************************************************************
111200*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
111300***************************************************************
111400 1700-EDIT-DRG-CODE.
111500***************************************************************
111600
111700     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
111800     IF PPS-RTC = '00'
111900        SEARCH ALL WWM-ENTRY
112000           AT END
112100             MOVE '54' TO PPS-RTC
112200        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
112300             PERFORM 1750-FIND-VALUE
112400                THRU 1750-EXIT
112500        END-SEARCH.
112600
112700 1700-EXIT.
112800      EXIT.
112900
113000
113100***************************************************************
113200*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
113300***************************************************************
113400 1750-FIND-VALUE.
113500***************************************************************
113600
113700      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
113800      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
113900*     MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
114000
114100 1750-EXIT.
114200      EXIT.
114300
114400
114500***************************************************************
114600*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
114700***************************************************************
114800 1800-EDIT-IPPS-DRG-CODE.
114900***************************************************************
115000
115100**-------------------------------------------------------**
115200** THIS LOGIC WAS COPIED FROM THE IPPS PRICER (PPCAL140) **
115300** ENSURE IT STAYS CONSISTENT BECAUSE IT REFERENCES THE  **
115400** DRG TABLE USED BY THE IPPS PRICER.                    **
115500**-------------------------------------------------------**
115600
115700     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE
115800     SET DRG-IDX TO 1
115900     SEARCH DRG-TAB VARYING DRG-IDX
116000         AT END
116100           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC
116200           MOVE 'I' TO  HLDDRG-VALID
116300           MOVE '54' TO PPS-RTC
116400           GO TO 1800-EXIT
116500       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE
116600         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.
116700
116800
116900     MOVE  HLDDRG-DATA         TO WK-HLDDRG-DATA2.
117000     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.
117100     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2
117200                                  H-IPPS-DRG-WGT.
117300     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2
117400                                  H-IPPS-DRG-ALOS.
117500     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.
117600     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2
117700                                  H-IPPS-ARITH-ALOS.
117800     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.
117900     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.
118000     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.
118100     MOVE  'V'                 TO HLDDRG-VALID.
118200     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.
118300
118400 1800-EXIT.
118500      EXIT.
118600
118700
118800***************************************************************
118900***  GET THE PROVIDER SPECIFIC VARIABLES AND LTCH WAGE INDEX  *
119000*                                                             *
119100*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
119200*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
119300*    OF THAT VARIABLE.                                        *
119400*                                                             *
119500***************************************************************
119600 2000-ASSEMBLE-PPS-VARIABLES.
119700***************************************************************
119800
119900
120000*-------------------------------------------------------------*
120100* ASSIGN FULL (5/5) LTCH WAGE INDEX TO ALL CLAIMS DISCHARGED  *
120200* ON AND AFTER 7/1/2008 (THIRD COLUMN WAGE INDEX IN LTWIX***) *
120300*-------------------------------------------------------------*
120400     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
120500        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
120600     ELSE
120700        MOVE '52' TO PPS-RTC
120800        GO TO 2000-EXIT
120900     END-IF.
121000
121100
121200*-------------------------------------------------------------*
121300* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
121400*-------------------------------------------------------------*
121500     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
121600
121700*-------------------------------------------------------------*
121800* OLD POLICY CLAIMS MUST HAVE A BLEND YEAR INDICATOR OF 5     *
121900*-------------------------------------------------------------*
122000     IF B-REVIEW-CODE = 00 AND PPS-BLEND-YEAR NOT = 5
122100        MOVE 5 TO PPS-BLEND-YEAR
122200     END-IF.
122300
122400*-------------------------------------------------------------*
122500* NEW POLICY CLAIMS MUST HAVE A BLEND YR. IND. OF 6, 7, OR 8  *
122600*-------------------------------------------------------------*
122700     IF (B-REVIEW-CODE >= 01 AND B-REVIEW-CODE <= 08) AND
122800        (PPS-BLEND-YEAR < 6 OR PPS-BLEND-YEAR > 8)
122900        MOVE '72' TO PPS-RTC
123000        GO TO 2000-EXIT
123100     END-IF.
123200
123300*-------------------------------------------------------------*
123400* SET DEFAULT BLEND VARIABLE VALUES                           *
123500* - H-BLEND-STD = % STANDARD PMT CONTRIBUTES TO FINAL PMT     *
123600* - H-BLEND-SNT = % SITE NEUTRAL PMT CONTRIBUTES TO FINAL PMT *
123700*-------------------------------------------------------------*
123800     MOVE 0 TO H-BLEND-SNT.
123900     MOVE 1 TO H-BLEND-STD.
124000     MOVE 0 TO H-BLEND-RTC.
124100
124200
124300*-------------------------------------------------------------*
124400* FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII)          *
124500*-------------------------------------------------------------*
124600     IF (P-NEW-STATE = 02 OR 12)
124700        MOVE P-NEW-COLA TO PPS-COLA
124800     ELSE
124900        MOVE 1.000 TO PPS-COLA
125000     END-IF.
125100
125200
125300 2000-EXIT.
125400      EXIT.
125500
125600
125700***************************************************************
125800*    IF THE BILL & PSF DATA HAS PASSED ALL EDITS (RTC=00)     *
125900*        CALCULATE THE APPLICABLE CLAIM PAYMENT:              *
126000*           - STANDARD PAYMENT                                *
126100*           - SHORT STAY OUTLIER PAYMENT                      *
126200*           - SITE NEUTRAL PAYMENT                            *
126300*           - STANDARD/SITE NEUTRAL BLENDED PAYMENT           *
126400***************************************************************
126500 3000-CALC-PAYMENT.
126600***************************************************************
126700
126800
126900
127000
127100*-------------------------------------------------------------*
127200* CALCULATE CLAIM COST FOR ALL CLAIMS                         *
127300*-------------------------------------------------------------*
127400     COMPUTE PPS-FAC-COSTS ROUNDED =
127500         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
127600
127700
127800*-------------------------------------------------------------*
127900* DETERMINE WHICH PAYMENT METHOD TO USE. EITHER:              *
128000* - STANDARD PAYMENT UNDER THE OLD POLICY,                    *
128100* - STANDARD PAYMENT UNDER THE NEW POLICY,                    *
128200* - 100% SITE NEUTRAL PAYMENT, OR                             *
128300* - 50/50 BLEND OF SITE NEUTRAL & STANDARD PAYMENT.           *
128400*-------------------------------------------------------------*
128500     PERFORM 3100-DETERMINE-PAYMENT-TYPE
128600        THRU 3100-EXIT.
128700
128800     IF PPS-RTC NOT = '00'
128900        GO TO 3000-EXIT
129000     END-IF.
129100
129200
129300*-------------------------------------------------------------*
129400* CALCULATE CLAIM PAYMENT BASED ON PAYMENT METHOD             *
129500*-------------------------------------------------------------*
129600     IF PMT-STANDARD-OLD
129700        PERFORM 3200-CALC-STANDARD-PMT
129800           THRU 3200-EXIT
129900     END-IF.
130000
130100     IF PMT-STANDARD-NEW
130200        PERFORM 3200-CALC-STANDARD-PMT
130300           THRU 3200-EXIT
130400     END-IF.
130500
130600     IF PMT-SITE-NEUTRAL
130700        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
130800           THRU 3300-EXIT
130900     END-IF.
131000
131100     IF PMT-BLEND
131200        PERFORM 3200-CALC-STANDARD-PMT
131300           THRU 3200-EXIT
131400        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
131500           THRU 3300-EXIT
131600     END-IF.
131700
131800 3000-EXIT.
131900      EXIT.
132000
132100
132200***************************************************************
132300*  DETERMINE WHETHER A CLAIM'S PAYMENT SHOULD BE:             *
132400*  - STANDARD - OLD POLICY                                    *
132500*  - STANDARD - NEW POLICY                                    *
132600*  - 100% SITE NEUTRAL - NEW POLICY                           *
132700*  - 50/50 BLEND OF SITE NEUTRAL & STANDARD - NEW POLICY      *
132800***************************************************************
132900 3100-DETERMINE-PAYMENT-TYPE.
133000***************************************************************
133100
133200*-------------------------------------------------------------*
133300* STANDARD PAYMENT (OLD POLICY)
133400*-------------------------------------------------------------*
133500     IF B-REVIEW-CODE = 00
133600*    IF B-REVIEW-CODE = 00 OR
133700*       SUBCLAUSEII-PROV
133800        SET PMT-STANDARD-OLD TO TRUE
133900        GO TO 3100-EXIT
134000     END-IF.
134100
134200*-------------------------------------------------------------*
134300* STANDARD PAYMENT (NEW POLICY)
134400*-------------------------------------------------------------*
134500     IF (B-REVIEW-CODE = 01 AND NOT PSYCH-REHAB-DRG) OR
134600        B-REVIEW-CODE = 04 OR
134700        B-REVIEW-CODE = 05
134800        SET PMT-STANDARD-NEW TO TRUE
134900        GO TO 3100-EXIT
135000     END-IF.
135100
135200*-------------------------------------------------------------*
135300* SITE NEUTRAL PAYMENT (NEW POLICY)
135400*-------------------------------------------------------------*
135500     IF  (B-REVIEW-CODE = 01 AND PSYCH-REHAB-DRG) OR
135600          B-REVIEW-CODE = 02 OR
135700          B-REVIEW-CODE = 03 OR
135800          B-REVIEW-CODE = 06 OR
135900          B-REVIEW-CODE = 07 OR
136000          B-REVIEW-CODE = 08
136100
136200
136300*-------------------------------------------------------------*
136400* FOR COVID-19 PRICING, CLAIMS THAT WOULD NORMALLY GET PAID   *
136500* AS SITE-NEUTRAL WILL GET PAID AS STANDARD WHEN THE          *
136600* ADMISSION DATE IS ON OR AFTER JANUARY 27, 2020.             *
136700* SINCE THE ADMISSION DATE IS NOT INCLUDED IN THE INPUT BILL  *
136800* RECORD IT GETS CALCULATED FIRST.                            *
136900*-------------------------------------------------------------*
137000       MOVE B-DISCHARGE-DATE TO H-DISCHARGE-DATE
137100       COMPUTE H-ADMISS-DATE-INT =
137200         FUNCTION INTEGER-OF-DATE (H-DISCHARGE-DATE) - B-LOS
137300       COMPUTE H-ADMISSION-DATE =
137400         FUNCTION DATE-OF-INTEGER (H-ADMISS-DATE-INT)
137500       IF H-ADMISSION-DATE > 20200126
137600         SET PMT-STANDARD-NEW TO TRUE
137700         GO TO 3100-EXIT
137800       ELSE
137900
138000*-------------------------------------------------------------*
138100*     SET BUDGET NEUTRALITY RATE FOR SITE NEUTRAL CLAIMS
138200*-------------------------------------------------------------*
138300         MOVE 0.949 TO H-BDGT-NEUT-FACTOR
138400
138500*-------------------------------------------------------------*
138600*     SET SITE-NEUTRAL-IPPS-ADJ FOR SITE-NEUTRAL CLAIMS
138700*-------------------------------------------------------------*
138800         MOVE 0.954 TO H-SITE-NEUTRAL-IPPS-ADJ
138900
139000*-------------------------------------------------------------*
139100*     100% SITE NEUTRAL PAYMENT
139200*-------------------------------------------------------------*
139300         IF PPS-BLEND-YEAR = 8
139400            SET PMT-SITE-NEUTRAL TO TRUE
139500
139600*-------------------------------------------------------------*
139700*     50% SITE NEUTRAL + 50% STANDARD BLENDED PAYMENT
139800*-------------------------------------------------------------*
139900         ELSE
140000             IF PPS-BLEND-YEAR = 6 OR
140100                PPS-BLEND-YEAR = 7
140200                SET PMT-BLEND TO TRUE
140300
140400*-------------------------------------------------------------*
140500*           SET BLEND PERCENTS FOR BLENDED PAYMENT            *
140600*-------------------------------------------------------------*
140700                MOVE .5 TO H-BLEND-STD
140800                MOVE .5 TO H-BLEND-SNT
140900             END-IF
141000         END-IF
141100       END-IF
141200     END-IF.
141300
141400*-------------------------------------------------------------*
141500* CLAIM MEETS NONE OF THE ABOVE CRITERIA - SET RETURN CODE
141600*-------------------------------------------------------------*
141700     IF WS-PRIMARY-PMT-TYPE = ' '
141800        MOVE '72' TO PPS-RTC
141900     END-IF.
142000
142100
142200 3100-EXIT.
142300      EXIT.
142400
142500
142600***************************************************************
142700*     CALCULATE THE STANDARD PAYMENT AMOUNT.                  *
142800*     CALCULATE THE SHORT-STAY OUTLIER AMOUNT IF APPLICABLE.  *
142900***************************************************************
143000 3200-CALC-STANDARD-PMT.
143100***************************************************************
143200
143300*-------------------------------------------------------------*
143400* CALCULATE FULL STANDARD DRG ADJUSTED PAYMENT                *
143500*-------------------------------------------------------------*
143600     COMPUTE H-LABOR-PORTION ROUNDED =
143700         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
143800          * PPS-WAGE-INDEX.
143900
144000     COMPUTE H-NONLABOR-PORTION ROUNDED =
144100         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
144200          * PPS-COLA.
144300
144400     COMPUTE PPS-FED-PAY-AMT ROUNDED =
144500         (H-LABOR-PORTION + H-NONLABOR-PORTION).
144600
144700     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
144800         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
144900
145000* FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY
145100     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
145200
145300
145400*-------------------------------------------------------------*
145500* DETERMINE WHETHER THE CLAIM IS A SHORT STAY OUTLIER;        *
145600* APPLY SHORT STAY OUTLIER POLICY IF IT IS                    *
145700*-------------------------------------------------------------*
145800     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
145900
146000     IF H-LOS <= H-SSOT
146100        PERFORM 3400-SHORT-STAY
146200           THRU 3400-SHORT-STAY-EXIT
146300
146400        IF PMT-STANDARD-NEW OR PMT-BLEND
146500           SET PMT-STANDARD-SSO TO TRUE
146600           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-SSO-PMT
146700        END-IF
146800
146900*-------------------------------------------------------------*
147000* FOR REGULAR STAY CLAIMS, POPULATE THE APPROPRIATE PAYMENT   *
147100* FIELD FOR NEW POLICY CLAIMS                                 *
147200*-------------------------------------------------------------*
147300     ELSE
147400        IF PMT-STANDARD-NEW OR PMT-BLEND
147500           SET PMT-STANDARD-FULL TO TRUE
147600           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-FULL-PMT
147700        END-IF
147800     END-IF.
147900
148000 3200-EXIT.
148100      EXIT.
148200
148300
148400***************************************************************
148500*     CALCULATE THE SITE NEUTRAL PAYMENT AMOUNT               *
148600***************************************************************
148700 3300-CALC-SITE-NEUTRAL-PMT.
148800***************************************************************
148900* BEGINNING LTCAL183 - NEW METHOD
149000
149100*-------------------------------------------------------------*
149200* CALCULATE IPPS COMPARABLE PER DIEM AMT                      *
149300*-------------------------------------------------------------*
149400     PERFORM 3650-SS-IPPS-COMP-PMT
149500        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
149600
149700*-------------------------------------------------------------*
149800* CALCULATE SITE NEUTRAL IPPS COMP. PMT HIGH COST OUTLIER     *
149900* (HCO) FOR THE MINIMUM PAYMENT COMPARISON                    *
150000*-------------------------------------------------------------*
150100     SET PMT-SITE-NEUT-IPPS TO TRUE.
150200     MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT.
150300     PERFORM 6000-CALC-HIGH-COST-OUTLIER
150400        THRU 6000-EXIT.
150500     COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
150600             PPS-OUTLIER-PAY-AMT *
150700             H-SITE-NEUTRAL-IPPS-ADJ.
150800     MOVE PPS-OUTLIER-PAY-AMT TO H-OUTLIER-IPPS-COMPARABLE.
150900     INITIALIZE PPS-OUTLIER-PAY-AMT
151000                WS-SECONDARY-PMT-TYPE-SNT
151100                PPS-SITE-NEUTRAL-IPPS-PMT.
151200
151300*-------------------------------------------------------------*
151400* CALCULATE THE SITE NEUTRAL PAYMENT USING THE FOLLOWING      *
151500* FORMULA FROM POLICY GROUP:                                  *
151600* MIN (�SN ADJ * (IPPS PER DIEM AMT + SN IPPS HCO)�, COST)    *
151700*-------------------------------------------------------------*
151800
151900*-------------------------------------------------------------*
152000* CALCULATE SITE NEUTRAL COST PAYMENT FOR MIN PMT COMPARISON  *
152100*-------------------------------------------------------------*
152200     MOVE PPS-FAC-COSTS TO H-SN-COST-4COMPARISON.
152300
152400*-------------------------------------------------------------*
152500* CALCULATE SITE NEUTRAL IPPS COMP PMT FOR MIN PMT COMPARISON *
152600*-------------------------------------------------------------*
152700     COMPUTE H-SN-IPPS-4COMPARISON ROUNDED =
152800              H-SITE-NEUTRAL-IPPS-ADJ *
152900              (H-IPPS-PER-DIEM +
153000               H-OUTLIER-IPPS-COMPARABLE).
153100
153200*-------------------------------------------------------------*
153300* MINIMUM IS FINAL SITE NEUTRAL PMT BASED ON COST             *
153400*-------------------------------------------------------------*
153500     IF H-SN-COST-4COMPARISON < H-SN-IPPS-4COMPARISON
153600        SET PMT-SITE-NEUT-COST TO TRUE
153700        MOVE PPS-FAC-COSTS TO PPS-SITE-NEUTRAL-COST-PMT
153800
153900*-------------------------------------------------------------*
154000* MINIMUM IS FINAL SITE-NEUTRAL PMT BASED ON IPPS COMPARABLE  *
154100*-------------------------------------------------------------*
154200     ELSE
154300        SET PMT-SITE-NEUT-IPPS TO TRUE
154400        MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT
154500     END-IF.
154600
154700
154800 3300-EXIT.
154900      EXIT.
155000
155100
155200***************************************************************
155300*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
155400*      OF THE AVG. LENGTH OF STAY THEN:                       *
155500*      - PAY THE SHORT-STAY BLENDED PAYMENT                   *
155600*      - SET RETURN CODE FOR OLD POLICY CLAIMS ONLY TO        *
155700*        INDICATE SHORT STAY PAYMENT                          *
155800***************************************************************
155900
156000 3400-SHORT-STAY.
156100
156200        COMPUTE H-SS-PAY-AMT ROUNDED =
156300         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
156400
156500***************************************************************
156600*   CALCULATE BLENDED PAYMENT                                 *
156700***************************************************************
156800
156900        PERFORM 3600-SS-BLENDED-PMT
157000           THRU 3600-SS-BLENDED-PMT-EXIT
157100        MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
157200        IF PMT-STANDARD-OLD
157300           MOVE '22' TO PPS-RTC
157400        END-IF
157500        MOVE 'Y' TO H-SS-BLEND-IND
157600        MOVE 'N' TO H-SS-COST-IND
157700        MOVE 'N' TO H-SS-PERDIEM-IND
157800        MOVE 'N' TO H-SS-IPPSCOMP-IND.
157900
158000 3400-SHORT-STAY-EXIT.
158100      EXIT.
158200
158300
158400 3500-CALC-IPPS-LIKE-AMT.
158500
158600*-------------------------------------------------------------*
158700* GET AN 'IPPS-LIKE AMOUNT' TO BE USED FOR THE DPP ADJUSTMENT *
158800*-------------------------------------------------------------*
158900
159000*-------------------------------------------------------------*
159100* GET THE IPPS PAY AMT                                        *
159200*-------------------------------------------------------------*
159300     PERFORM 3650-SS-IPPS-COMP-PMT
159400        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
159500
159600*-------------------------------------------------------------*
159700* GET THE IPPS PMT HIGH COST OUTLIER (HCO)                    *
159800*-------------------------------------------------------------*
159900     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
160000                  H-IPPS-PAY-AMT + H-FIXED-LOSS-AMT-SNT
160100     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
160200        COMPUTE H-IPPS-LIKE-AMT-OUTLIER =
160300                (PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8
160400     END-IF.
160500
160600*-------------------------------------------------------------*
160700* COMPUTE THE IPPS LIKE AMOUNT                                *
160800*-------------------------------------------------------------*
160900     COMPUTE H-IPPS-LIKE-AMT =
161000                  H-IPPS-PAY-AMT +
161100                  H-IPPS-LIKE-AMT-OUTLIER.
161200
161300 3500-EXIT.
161400      EXIT.
161500
161600
161700***************************************************************
161800*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
161900*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
162000*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
162100*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
162200***************************************************************
162300 3600-SS-BLENDED-PMT.
162400***************************************************************
162500
162600*** ------------------------------------------------------ ***
162700*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
162800*** ------------------------------------------------------ ***
162900     IF H-SSOT < 25
163000        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
163100          H-LOS / H-SSOT
163200     ELSE
163300        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
163400          H-LOS / 25
163500     END-IF.
163600
163700     IF H-LTCH-BLEND-PCT > 1
163800        MOVE 1 TO H-LTCH-BLEND-PCT
163900     END-IF.
164000
164100
164200*** ------------------------------------------------------ ***
164300*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
164400*** ------------------------------------------------------ ***
164500     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
164600        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
164700
164800
164900*** ------------------------------------------------------ ***
165000*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
165100*** ------------------------------------------------------ ***
165200     PERFORM 3650-SS-IPPS-COMP-PMT
165300        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
165400
165500
165600*** ------------------------------------------------------ ***
165700*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
165800*** ------------------------------------------------------ ***
165900     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
166000       1 - H-LTCH-BLEND-PCT.
166100
166200
166300*** ------------------------------------------------------ ***
166400*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
166500*** ------------------------------------------------------ ***
166600     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
166700       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
166800
166900
167000*** ------------------------------------------------------ ***
167100*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
167200*** ------------------------------------------------------ ***
167300     COMPUTE H-SS-BLENDED-PMT ROUNDED =
167400       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
167500
167600
167700 3600-SS-BLENDED-PMT-EXIT.
167800      EXIT.
167900
168000
168100***************************************************************
168200*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
168300*   PER DIEM PAYMENT AMOUNT                                   *
168400***************************************************************
168500 3650-SS-IPPS-COMP-PMT.
168600***************************************************************
168700
168800*** -------------------------------------------------------
168900*** OPERATING TEACHING ADJUSTMENT
169000*** -------------------------------------------------------
169100     COMPUTE H-OPER-IME-TEACH ROUNDED =
169200        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
169300
169400
169500*** -------------------------------------------------------
169600*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
169700*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%
169800*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL
169900***              THIS CHANGE IS RETROACTIVE TO 10/01/2008
170000*** -------------------------------------------------------
170100     IF H-CAPI-IME-RATIO > 1.5000
170200        MOVE 1.5000 TO H-CAPI-IME-RATIO.
170300
170400     COMPUTE H-CAPI-IME-TEACH ROUNDED =
170500        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).
170600
170700
170800*** -------------------------------------------------------
170900*** OPERATING DSH ADJUSTMENT
171000*** -------------------------------------------------------
171100
171200*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
171300*---------------------------------------------------
171400     IF ALL-RURAL
171500        SET RURAL-CBSA TO TRUE
171600     ELSE
171700        SET URBAN-CBSA TO TRUE
171800     END-IF.
171900
172000
172100*2) CALCULATE THE OPERATING DSH PERCENT
172200*--------------------------------------
172300     COMPUTE H-OPER-DSH-PCT ROUNDED =
172400        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
172500
172600
172700*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
172800*-----------------------------------------------------
172900
173000*    URBAN, < 100 BEDS
173100*    -----------------
173200     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
173300        H-OPER-DSH-PCT >= .15
173400          MOVE '3' TO H-GEO-CLASS
173500     ELSE
173600
173700
173800*   URBAN, >= 100 BEDS
173900*   ------------------
174000       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
174100          H-OPER-DSH-PCT >= .15
174200            MOVE '2' TO H-GEO-CLASS
174300       ELSE
174400
174500
174600*   RURAL, >= 500 BEDS
174700*   ------------------
174800         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
174900            H-OPER-DSH-PCT >= .15
175000              MOVE '2' TO H-GEO-CLASS
175100         ELSE
175200
175300
175400*   RURAL, < 500 BEDS
175500*   -----------------
175600           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
175700              H-OPER-DSH-PCT >= .15
175800                MOVE '3' TO H-GEO-CLASS
175900           ELSE
176000
176100
176200*   OTHER
176300*   -----------------
176400              MOVE '4' TO H-GEO-CLASS
176500
176600           END-IF
176700         END-IF
176800       END-IF
176900     END-IF.
177000
177100
177200*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
177300*-----------------------------------------------------------
177400     EVALUATE H-GEO-CLASS
177500
177600*      GEOGRAPHIC CLASS 2
177700*      ------------------
177800       WHEN '2'
177900          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
178000             COMPUTE H-OPER-DSH ROUNDED =
178100               ((H-OPER-DSH-PCT - .15) * .65) + .025
178200          ELSE
178300             IF H-OPER-DSH-PCT > .202
178400                COMPUTE H-OPER-DSH ROUNDED =
178500                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
178600             ELSE
178700                MOVE ZEROS TO H-OPER-DSH
178800             END-IF
178900          END-IF
179000
179100*      GEOGRAPHIC CLASS 3
179200*      ------------------
179300       WHEN '3'
179400          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
179500             COMPUTE H-OPER-DSH ROUNDED =
179600               ((H-OPER-DSH-PCT - .15) * .65) + .025
179700             IF H-OPER-DSH > .12
179800                MOVE .12 TO H-OPER-DSH
179900             END-IF
180000          ELSE
180100             IF H-OPER-DSH-PCT > .202
180200                COMPUTE H-OPER-DSH ROUNDED =
180300                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
180400                IF H-OPER-DSH > .12
180500                   MOVE .12 TO H-OPER-DSH
180600                END-IF
180700             ELSE
180800               MOVE ZEROS TO H-OPER-DSH
180900             END-IF
181000          END-IF
181100
181200*      GEOGRAPHIC CLASS 4
181300*      ------------------
181400       WHEN '4'
181500          MOVE ZEROS TO H-OPER-DSH
181600
181700     END-EVALUATE.
181800
181900
182000*** -------------------------------------------------------
182100*** CURRENT OPERATING DSH PAYMENT REDUCTION
182200*** -------------------------------------------------------
182300     COMPUTE H-OPER-DSH ROUNDED =
182400             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.
182500
182600*** -------------------------------------------------------
182700*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
182800*** -------------------------------------------------------
182900     IF URBAN-CBSA AND H-BED-SIZE >= 100
183000        COMPUTE H-CAPI-DSH ROUNDED =
183100          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
183200     ELSE
183300        MOVE ZEROS TO H-CAPI-DSH
183400     END-IF.
183500
183600
183700*** -------------------------------------------------------
183800*** OPERATING PAYMENT (STANDARD AMOUNT)
183900*** -------------------------------------------------------
184000     IF (P-NEW-STATE = 02 OR 12)
184100        MOVE P-NEW-COLA TO H-OPER-COLA
184200     ELSE
184300        MOVE 1.000 TO H-OPER-COLA
184400     END-IF.
184500
184600     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
184700       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +
184800         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
184900         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
185000
185100
185200*** -------------------------------------------------------
185300*** CAPITAL PAYMENT (CAPITAL RATE)
185400*** -------------------------------------------------------
185500     COMPUTE H-CAPI-COLA ROUNDED =
185600       (.3152 * (H-OPER-COLA - 1) + 1).
185700
185800*--------------------------------------------------------------*
185900*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
186000*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
186100*--------------------------------------------------------------*
186200     IF LARGE-URBAN
186300        MOVE 1.00 TO H-LRGURB-ADD-ON
186400     ELSE
186500        MOVE 1.00 TO H-LRGURB-ADD-ON
186600     END-IF.
186700
186800     COMPUTE H-CAPI-GAF ROUNDED =
186900       (H-IPPS-WAGE-INDEX ** .6848).
187000
187100     COMPUTE H-CAPI-PMT ROUNDED =
187200       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
187300       H-LRGURB-ADD-ON *  H-CAPI-COLA *
187400       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
187500
187600
187700*** -------------------------------------------------------
187800*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
187900*** -------------------------------------------------------
188000     COMPUTE H-IPPS-PAY-AMT ROUNDED =
188100       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
188200
188300
188400*** -------------------------------------------------------
188500*** IPPS COMPARABLE PER DIEM PAYMENT
188600*** -------------------------------------------------------
188700     COMPUTE H-IPPS-PER-DIEM ROUNDED =
188800       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
188900
189000     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
189100        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
189200     END-IF.
189300
189400*** -------------------------------------------------------
189500*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
189600*** -------------------------------------------------------
189700
189800
189900 3650-SS-IPPS-COMP-PMT-EXIT.
190000      EXIT.
190100
190200
190300***************************************************************
190400*4000-SPECIAL-PROVIDER.
190500***************************************************************
190600*
190700*** PROCESS FOR CY2003
190800*** ------------------
190900*    IF (B-DISCHARGE-DATE >= 20030701) AND
191000*       (B-DISCHARGE-DATE <  20040101)
191100*       COMPUTE H-SS-COST ROUNDED =
191200*           (PPS-FAC-COSTS * 1.95)
191300*       COMPUTE H-SS-PAY-AMT ROUNDED =
191400*        ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
191500*    END-IF
191600*
191700*
191800*** PROCESS FOR CY2004
191900*** ------------------
192000*    IF (B-DISCHARGE-DATE >= 20040101) AND
192100*       (B-DISCHARGE-DATE <  20050101)
192200*       COMPUTE H-SS-COST ROUNDED =
192300*           (PPS-FAC-COSTS * 1.93)
192400*       COMPUTE H-SS-PAY-AMT ROUNDED =
192500*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
192600*    END-IF
192700*
192800*
192900*** PROCESS FOR CY2005
193000*** ------------------
193100*    IF (B-DISCHARGE-DATE >= 20050101) AND
193200*       (B-DISCHARGE-DATE <  20060101)
193300*       COMPUTE H-SS-COST ROUNDED =
193400*           (PPS-FAC-COSTS * 1.65)
193500*       COMPUTE H-SS-PAY-AMT ROUNDED =
193600*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
193700*    END-IF
193800*
193900*
194000*** PROCESS FOR CY2006
194100*** ------------------
194200*    IF (B-DISCHARGE-DATE >= 20060101) AND
194300*       (B-DISCHARGE-DATE <  20070101)
194400*       COMPUTE H-SS-COST ROUNDED =
194500*           (PPS-FAC-COSTS * 1.36)
194600*       COMPUTE H-SS-PAY-AMT ROUNDED =
194700*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
194800*    END-IF
194900*
195000*
195100*** PROCESS FOR CY2007 AND AFTER
195200*** ----------------------------
195300*    IF (B-DISCHARGE-DATE >= 20070101)
195400*       COMPUTE H-SS-COST ROUNDED =
195500*           (PPS-FAC-COSTS * 1.2)
195600*       COMPUTE H-SS-PAY-AMT ROUNDED =
195700*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
195800*    END-IF.
195900*
196000*4000-SPECIAL-PROVIDER-EXIT.
196100*     EXIT.
196200
196300
196400***************************************************************
196500*   CALCULATE THE OUTLIER THRESHOLD                           *
196600*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
196700*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
196800*   SET RETURN CODE                                           *
196900*   CALCULATE THE CHARGE THRESHOLD IF APPLICABLE              *
197000***************************************************************
197100 6000-CALC-HIGH-COST-OUTLIER.
197200***************************************************************
197300
197400
197500*-------------------------------------------------------------*
197600* FOR NON-BLENDED PAYMENT CLAIMS:                             *
197700*-------------------------------------------------------------*
197800* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLD  *
197900*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
198000* - CALCULATE OUTLIER THRESHOLD                               *
198100*-------------------------------------------------------------*
198200
198300     IF PMT-STANDARD-OLD
198400        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
198500                PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT-STD
198600     END-IF.
198700
198800
198900     IF PMT-STANDARD-NEW
199000        IF PMT-STANDARD-FULL
199100           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
199200                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
199300        ELSE
199400           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
199500                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
199600        END-IF
199700     END-IF.
199800
199900
200000     IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
200100        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
200200                PPS-SITE-NEUTRAL-IPPS-PMT + H-FIXED-LOSS-AMT-SNT
200300     END-IF.
200400
200500
200600*-------------------------------------------------------------*
200700* CALCULATE HIGH-COST OUTLIER IF COSTS EXCEED THRESHOLD       *
200800*-------------------------------------------------------------*
200900     IF NOT PMT-BLEND AND
201000        NOT (PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-COST)
201100        IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
201200           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
201300                   (PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8
201400
201500*-------------------------------------------------------------*
201600*        SITE-NEUTRAL ONLY: REDUCE BY BUDGET NEUTRALITY FACT. *
201700*-------------------------------------------------------------*
201800*          IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
201900*             COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
202000*                    PPS-OUTLIER-PAY-AMT * H-BDGT-NEUT-FACTOR
202100*          END-IF
202200        END-IF
202300     END-IF.
202400
202500
202600
202700*-------------------------------------------------------------*
202800* FOR BLENDED PAYMENT CLAIMS                                  *
202900* (RECEIVE 50% STANDARD PAYMENT + 50% SITE-NEUTRAL PAYMENT)   *
203000*-------------------------------------------------------------*
203100* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLDS *
203200*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
203300* - CALCULATE STANDARD PAYMENT OUTLIER THRESHOLD              *
203400* - CALCULATE SITE-NEUTRAL PAYMENT OUTLIER THRESHOLD          *
203500* - CALCULATE HIGH-COST OUTLIER IF APPLICABLE (50/50 BLEND)   *
203600*-------------------------------------------------------------*
203700
203800     IF PMT-BLEND
203900
204000*-------------------------------------------------------------*
204100* CALCULATE STANDARD OUTLIER THRESHOLD                        *
204200*-------------------------------------------------------------*
204300        IF PMT-STANDARD-FULL
204400           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
204500                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
204600        ELSE
204700           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
204800                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
204900        END-IF
205000
205100
205200*-------------------------------------------------------------*
205300* CALCULATE SITE-NEUTRAL OUTLIER THRESHOLD                    *
205400*-------------------------------------------------------------*
205500        IF PMT-SITE-NEUT-IPPS
205600           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
205700                   PPS-SITE-NEUTRAL-IPPS-PMT +
205800                   H-FIXED-LOSS-AMT-SNT
205900        END-IF
206000
206100
206200*-------------------------------------------------------------*
206300* CALCULATE STANDARD PAYMENT PORTION OF HIGH-COST OUTLIER IF  *
206400* COSTS EXCEED STANDARD PAYMENT THRESHOLD                     *
206500*-------------------------------------------------------------*
206600        IF PPS-FAC-COSTS > H-OUTLIER-THRESHOLD-STD
206700           COMPUTE H-OUTLIER-PAY-AMT-STD ROUNDED =
206800                   (PPS-FAC-COSTS - H-OUTLIER-THRESHOLD-STD) * .8
206900                   * H-BLEND-STD
207000        END-IF
207100
207200
207300*-------------------------------------------------------------*
207400* CALCULATE SITE-NEUTRAL PORTION OF HIGH-COST OUTLIER IF      *
207500* COSTS EXCEED THE SITE-NEUTRAL PAYMENT THRESHOLD             *
207600*-------------------------------------------------------------*
207700        IF PMT-SITE-NEUT-IPPS AND
207800           PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
207900           COMPUTE H-OUTLIER-PAY-AMT-SNT ROUNDED =
208000                  (((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
208100*                  * H-BLEND-SNT) * H-BDGT-NEUT-FACTOR
208200                   * H-BLEND-SNT)
208300        END-IF
208400
208500*-------------------------------------------------------------*
208600* CALCULATE TOTAL BLENDED HIGH-COST OUTLIER:                  *
208700* ADD THE SITE-NEUTRAL PAYMENT PORTION OF HIGH-COST OUTLIER   *
208800* TO THE STANDARD PAYMENT PORTION                             *
208900*-------------------------------------------------------------*
209000        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
209100                H-OUTLIER-PAY-AMT-STD +
209200                (H-OUTLIER-PAY-AMT-SNT * H-SITE-NEUTRAL-IPPS-ADJ)
209300
209400     END-IF.
209500
209600
209700*-------------------------------------------------------------*
209800* FOR ALL CLAIMS:                                             *
209900*-------------------------------------------------------------*
210000* SET HIGH-COST OUTLIER TO $0 IF BILL SPECIAL PAY IND. = '1'  *
210100*-------------------------------------------------------------*
210200     IF B-SPEC-PAY-IND = '1'
210300        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
210400
210500
210600*-------------------------------------------------------------*
210700* DETERMINE IF CHARGE THRESHOLD APPLIES & CALCULATE IF SO     *
210800*-------------------------------------------------------------*
210900     PERFORM 6100-CALC-CHARGE-THRESHOLD
211000        THRU 6100-EXIT.
211100
211200
211300 6000-EXIT.
211400      EXIT.
211500
211600
211700***************************************************************
211800*   CALCULATE CHARGE THRESHOLD & SET ERROR RTC WHEN APPLICABLE*
211900***************************************************************
212000 6100-CALC-CHARGE-THRESHOLD.
212100***************************************************************
212200
212300
212400*-------------------------------------------------------------*
212500* FOR MAINFRAME PRICER ONLY:                                  *
212600*-------------------------------------------------------------*
212700* FOR CLAIMS THAT RECEIVE A HIGH-COST OUTLIER AND HAVE A      *
212800* LENGTH OF STAY THAT EXCEEDS THE COVERED DAYS, CALCULATE THE *
212900* CHARGE THRESHOLD AND SET ERROR RETURN CODE '67'             *
213000*-------------------------------------------------------------*
213100
213200*-------------------------------------------------------------*
213300* FOR PC PRICER (PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS):      *
213400*-------------------------------------------------------------*
213500* CALCULATE CHARGE THRESHOLD FOR CLAIMS ALL CLAIMS THAT HAVE  *
213600* AN OPERATING COST-TO-CHARGE RATIO BUT DO NOT SET ERROR CODE *
213700*-------------------------------------------------------------*
213800
213900     IF (PPS-OUTLIER-PAY-AMT > 0 AND
214000         NOT (PMT-BLEND AND H-OUTLIER-PAY-AMT-SNT = 0)) OR
214100        PPS-COT-IND = 'Y'
214200
214300        IF B-COV-DAYS < H-LOS OR
214400           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
214500
214600           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
214700             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
214800
214900           IF NOT PC-PRICER
215000              MOVE '67' TO PPS-RTC
215100           END-IF
215200
215300        ELSE
215400           NEXT SENTENCE
215500        END-IF
215600     ELSE
215700        NEXT SENTENCE
215800     END-IF.
215900
216000 6100-EXIT.
216100      EXIT.
216200
216300
216400***************************************************************
216500*   SET FINAL RETURN CODES FOR PRICED CLAIMS                  *
216600***************************************************************
216700 7000-SET-FINAL-RETURN-CODES.
216800***************************************************************
216900
217000
217100*-------------------------------------------------------------*
217200* SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIM            *
217300*-------------------------------------------------------------*
217400*    IF SUBCLAUSEII-PROV
217500*       PERFORM 7300-SET-SUBII-RETURN-CODES
217600*          THRU 7300-EXIT
217700*       GO TO 7000-EXIT
217800*    END-IF.
217900
218000
218100*-------------------------------------------------------------*
218200* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
218300* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
218400*-------------------------------------------------------------*
218500     IF PMT-STANDARD-OLD
218600        PERFORM 7100-SET-OLD-RETURN-CODES
218700           THRU 7100-EXIT
218800     END-IF.
218900
219000
219100*-------------------------------------------------------------*
219200* SET RETURN CODES FOR NEW POLICY CLAIMS                      *
219300*-------------------------------------------------------------*
219400     IF PMT-STANDARD-NEW OR PMT-SITE-NEUTRAL OR PMT-BLEND
219500        PERFORM 7200-SET-NEW-RETURN-CODES
219600           THRU 7200-EXIT
219700     END-IF.
219800
219900
220000 7000-EXIT.
220100      EXIT.
220200
220300
220400***************************************************************
220500*   SET RETURN CODES FOR OLD POLICY CLAIMS                    *
220600***************************************************************
220700 7100-SET-OLD-RETURN-CODES.
220800***************************************************************
220900
221000*-------------------------------------------------------------*
221100* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
221200* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
221300*-------------------------------------------------------------*
221400
221500     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '21'
221600        MOVE '24' TO PPS-RTC.
221700
221800     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '22'
221900        MOVE '25' TO PPS-RTC.
222000
222100     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '26'
222200        MOVE '27' TO PPS-RTC.
222300
222400     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '00'
222500        MOVE '01' TO PPS-RTC.
222600
222700     IF (PPS-RTC = '00' OR '20' OR '21' OR '22' OR '26')
222800        IF PPS-REG-DAYS-USED > H-SSOT
222900           MOVE 0 TO PPS-LTR-DAYS-USED
223000        ELSE
223100           NEXT SENTENCE.
223200
223300 7100-EXIT.
223400      EXIT.
223500
223600
223700***************************************************************
223800*   SET RETURN CODES FOR NEW POLICY CLAIMS                    *
223900***************************************************************
224000 7200-SET-NEW-RETURN-CODES.
224100***************************************************************
224200
224300     INITIALIZE PPS-RTC.
224400
224500***************************************************************
224600* SET THE FIRST POSITION OF THE RETURN CODE                   *
224700***************************************************************
224800
224900*--------------------------------------------------*
225000* DEFAULT (NO PSYCH/REHAB NOR VENTILATOR SERVICE)  *
225100*--------------------------------------------------*
225200     MOVE 'C' TO PPS-RTC-1.
225300
225400*--------------------------------------------------*
225500* VENTILATOR SERVICE PRESENT                       *
225600*--------------------------------------------------*
225700     PERFORM 7250-SEARCH-FOR-VENT-PROC
225800        THRU 7250-EXIT.
225900     IF VENT-PRESENT
226000        MOVE 'B' TO PPS-RTC-1
226100     END-IF.
226200
226300*--------------------------------------------------*
226400* SITE NEUTRAL PMT BECAUSE PSYCH/REHAB DRG PRESENT *
226500* (PRESENCE OF PSCHY/REHAB DRG TRUMPS VENT PROC.)  *
226600*--------------------------------------------------*
226700     IF PSYCH-REHAB-DRG AND
226800        (PMT-SITE-NEUTRAL OR PMT-BLEND)
226900        MOVE 'A' TO PPS-RTC-1
227000     END-IF.
227100
227200
227300
227400***************************************************************
227500* SET THE SECOND POSITION OF RETURN CODE                      *
227600***************************************************************
227700
227800*-------------------------------------------------------------*
227900* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = COST         *
228000*-------------------------------------------------------------*
228100     IF PMT-BLEND AND PMT-SITE-NEUT-COST
228200
228300        IF PPS-OUTLIER-PAY-AMT = 0 AND
228400           PMT-STANDARD-FULL
228500           MOVE '0' TO PPS-RTC-2
228600        END-IF
228700
228800        IF PPS-OUTLIER-PAY-AMT > 0 AND
228900           PMT-STANDARD-FULL
229000           MOVE '1' TO PPS-RTC-2
229100        END-IF
229200
229300        IF PPS-OUTLIER-PAY-AMT = 0 AND
229400           PMT-STANDARD-SSO
229500           MOVE '2' TO PPS-RTC-2
229600        END-IF
229700
229800        IF PPS-OUTLIER-PAY-AMT > 0 AND
229900           PMT-STANDARD-SSO
230000           MOVE '3' TO PPS-RTC-2
230100        END-IF
230200
230300     END-IF.
230400
230500
230600*-------------------------------------------------------------*
230700* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = IPPS COMP.   *
230800*-------------------------------------------------------------*
230900     IF PMT-BLEND AND PMT-SITE-NEUT-IPPS
231000
231100        IF PPS-OUTLIER-PAY-AMT = 0 AND
231200           PMT-STANDARD-FULL
231300           MOVE '4' TO PPS-RTC-2
231400        END-IF
231500
231600        IF PPS-OUTLIER-PAY-AMT > 0 AND
231700           PMT-STANDARD-FULL
231800           MOVE '5' TO PPS-RTC-2
231900        END-IF
232000
232100        IF PPS-OUTLIER-PAY-AMT = 0 AND
232200           PMT-STANDARD-SSO
232300           MOVE '6' TO PPS-RTC-2
232400        END-IF
232500
232600        IF PPS-OUTLIER-PAY-AMT > 0 AND
232700           PMT-STANDARD-SSO
232800           MOVE '7' TO PPS-RTC-2
232900        END-IF
233000
233100     END-IF.
233200
233300
233400*-------------------------------------------------------------*
233500* 100% SITE NEUTRAL PAYMENT CLAIMS                            *
233600*-------------------------------------------------------------*
233700     IF PMT-SITE-NEUTRAL
233800
233900        IF PMT-SITE-NEUT-COST
234000           MOVE 'A' TO PPS-RTC-2
234100        END-IF
234200
234300        IF PMT-SITE-NEUT-IPPS
234400           IF PPS-OUTLIER-PAY-AMT = 0
234500              MOVE 'B' TO PPS-RTC-2
234600           ELSE
234700              MOVE 'C' TO PPS-RTC-2
234800           END-IF
234900        END-IF
235000     END-IF.
235100
235200
235300*-------------------------------------------------------------*
235400* 100% STANDARD PAYMENT CLAIMS                                *
235500*-------------------------------------------------------------*
235600     IF PMT-STANDARD-NEW
235700
235800        IF PMT-STANDARD-SSO AND
235900           PPS-OUTLIER-PAY-AMT = 0
236000           MOVE 'D' TO PPS-RTC-2
236100        END-IF
236200
236300        IF PMT-STANDARD-SSO AND
236400           PPS-OUTLIER-PAY-AMT > 0
236500           MOVE 'E' TO PPS-RTC-2
236600        END-IF
236700
236800        IF PMT-STANDARD-FULL AND
236900           PPS-OUTLIER-PAY-AMT = 0
237000           MOVE 'F' TO PPS-RTC-2
237100        END-IF
237200
237300        IF PMT-STANDARD-FULL AND
237400           PPS-OUTLIER-PAY-AMT > 0
237500           MOVE 'G' TO PPS-RTC-2
237600        END-IF
237700
237800     END-IF.
237900
238000
238100 7200-EXIT.
238200      EXIT.
238300
238400
238500***************************************************************
238600*   SEARCH FOR VENTILATOR SERVICE ICD-10 PROCEDURE CODE       *
238700***************************************************************
238800 7250-SEARCH-FOR-VENT-PROC.
238900***************************************************************
239000
239100     SET IDX-PROC TO 1.
239200
239300     SEARCH B-PROCEDURE-CODE VARYING IDX-PROC
239400         AT END
239500            SET VENT-NOT-PRESENT TO TRUE
239600         WHEN VENT-ICD-10-CODE = B-PROCEDURE-CODE (IDX-PROC)
239700            SET VENT-PRESENT TO TRUE
239800            GO TO 7250-EXIT
239900     END-SEARCH.
240000
240100 7250-EXIT.
240200      EXIT.
240300
240400
240500***************************************************************
240600*   SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIMS         *
240700***************************************************************
240800*7300-SET-SUBII-RETURN-CODES.
240900***************************************************************
241000*
241100*    INITIALIZE PPS-RTC.
241200*
241300*-------------------------------------------------------------*
241400* SET RETURN CODE BASED ON PRESENCE/ABSENCE OF OUTLIER        *
241500*-------------------------------------------------------------*
241600*    IF PPS-OUTLIER-PAY-AMT > 0
241700*       MOVE '29' TO PPS-RTC
241800*    ELSE
241900*       MOVE '28' TO PPS-RTC
242000*    END-IF.
242100*
242200*-------------------------------------------------------------*
242300* MOVE PER DIEM AMOUNT TO OUTPUT RECORD VARIABLE              *
242400*-------------------------------------------------------------*
242500*    MOVE P-NEW-FAC-SPEC-RATE TO PPS-NEW-FAC-SPEC-RATE.
242600*
242700*-------------------------------------------------------------*
242800* INITIALIZE OUTPUT FIELDS THAT DON'T APPLY TO SUBCLAUSE II   *
242900*-------------------------------------------------------------*
243000*    INITIALIZE PPS-OUTLIER-PAY-AMT
243100*               PPS-DRG-ADJ-PAY-AMT
243200*               PPS-FED-PAY-AMT
243300*               PPS-FAC-COSTS
243400*               PPS-SUBM-DRG-CODE
243500*               PPS-NAT-LABOR-PCT
243600*               PPS-NAT-NONLABOR-PCT
243700*               PPS-STD-FED-RATE
243800*               PPS-BDGT-NEUT-RATE
243900*               PPS-IPTHRESH
244000*               PPS-SITE-NEUTRAL-COST-PMT
244100*               PPS-SITE-NEUTRAL-IPPS-PMT
244200*               PPS-STANDARD-FULL-PMT
244300*               PPS-STANDARD-SSO-PMT.
244400*
244500*
244600*7300-EXIT.
244700*     EXIT.
244800
244900
245000***************************************************************
245100*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
245200*   UNIQUE CALCULATION FOR EACH CLAIM PAYMENT TYPE COMBO      *
245300***************************************************************
245400 8000-CALC-FINAL-PMT.
245500***************************************************************
245600
245700
245800*-------------------------------------------------------------*
245900* SUBCLAUSE II CLAIMS                                         *
246000*   P-NEW-FAC-SPEC-RATE = PER DIEM PMT RATE FOR SUBCLAUSE II  *
246100*-------------------------------------------------------------*
246200*    IF SUBCLAUSEII-PROV
246300*       COMPUTE PPS-FINAL-PAY-AMT ROUNDED =
246400*               P-NEW-FAC-SPEC-RATE *
246500*               B-CST-RPT-DAYS
246600*       GO TO 8000-EXIT
246700*    END-IF.
246800
246900
247000*-------------------------------------------------------------*
247100* OLD POLICY CLAIMS (100% STANDARD PAYMENT)                   *
247200*-------------------------------------------------------------*
247300     IF PMT-STANDARD-OLD
247400        COMPUTE PPS-FINAL-PAY-AMT =
247500                PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
247600     END-IF.
247700
247800
247900*-------------------------------------------------------------*
248000* NEW POLICY CLAIMS (ANY PAYMENT TYPE)                        *
248100*     - ONLY APPLICABLE PAYMENT FIELDS CONTAIN VALUES > $0    *
248200*     - APPLY BUDGET NEUTRALITY AND/OR BLEND TO PAYMENT       *
248300*       IF NEEDED                                             *
248400*     - ANY APPLICABLE BUDGET NEUTRALITY AND/OR BLEND WAS     *
248500*       ALREADY APPLIED TO OUTLIER PAYMENT                    *
248600*-------------------------------------------------------------*
248700     IF NOT PMT-STANDARD-OLD
248800
248900*-------------------------------------------------------*
249000* APPLY BUDGET NEUTRALITY AND SITE-NEUTRAL IPPS ADJ.    *
249100* TO 100% SITE-NEUTRAL PAYMENTS                         *
249200*-------------------------------------------------------*
249300        IF PMT-SITE-NEUTRAL
249400           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
249500                   PPS-SITE-NEUTRAL-COST-PMT *
249600                   H-BDGT-NEUT-FACTOR
249700
249800           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
249900                   PPS-SITE-NEUTRAL-IPPS-PMT *
250000                   H-BDGT-NEUT-FACTOR *
250100                   H-SITE-NEUTRAL-IPPS-ADJ
250200
250300           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
250400                   PPS-OUTLIER-PAY-AMT *
250500                   H-SITE-NEUTRAL-IPPS-ADJ
250600        END-IF
250700
250800
250900*-------------------------------------------------------*
251000* APPLY BLEND PERCENTS, BUDGET NEUT, AND SITE-NEUTRAL   *
251100* IPPS ADJUSTMENT TO BLENDED PAYMENTS                   *
251200*-------------------------------------------------------*
251300        IF PMT-BLEND
251400           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
251500                   PPS-SITE-NEUTRAL-COST-PMT *
251600                   H-BDGT-NEUT-FACTOR *
251700                   H-BLEND-SNT
251800
251900           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
252000                   PPS-SITE-NEUTRAL-IPPS-PMT *
252100                   H-BDGT-NEUT-FACTOR *
252200                   H-SITE-NEUTRAL-IPPS-ADJ *
252300                   H-BLEND-SNT
252400
252500           COMPUTE PPS-STANDARD-FULL-PMT ROUNDED =
252600                   PPS-STANDARD-FULL-PMT * H-BLEND-STD
252700
252800           COMPUTE PPS-STANDARD-SSO-PMT ROUNDED =
252900                   PPS-STANDARD-SSO-PMT * H-BLEND-STD
253000        END-IF
253100
253200*-------------------------------------------------------*
253300* SUM PAYMENT FIELDS FOR FINAL PAYMENT                  *
253400*-------------------------------------------------------*
253500        COMPUTE PPS-FINAL-PAY-AMT =
253600                PPS-STANDARD-FULL-PMT +
253700                PPS-STANDARD-SSO-PMT +
253800                PPS-SITE-NEUTRAL-COST-PMT +
253900                PPS-SITE-NEUTRAL-IPPS-PMT +
254000                PPS-OUTLIER-PAY-AMT
254100
254200        MOVE PPS-FINAL-PAY-AMT TO H-PRE-DPP-PAY
254300
254400*-------------------------------------------------------------*
254500* IF THERE'S AN LTCH DPP PAYMENT ADJUSTMENT THEN              *
254600* CALCULATE THE 'LTCH DPP ADJUSTMENT AMOUNT' AND              *
254700* ADD IT TO THE FINAL PAYMENT                                 *
254800*-------------------------------------------------------------*
254900        IF B-LTCH-DPP-ADJUSTMENT
255000           PERFORM 3500-CALC-IPPS-LIKE-AMT
255100              THRU 3500-EXIT
255200           COMPUTE PPS-LTCH-DPP-ADJ-AMT =
255300               H-IPPS-LIKE-AMT - H-PRE-DPP-PAY
255400           COMPUTE PPS-FINAL-PAY-AMT =
255500               H-PRE-DPP-PAY + PPS-LTCH-DPP-ADJ-AMT
255600        END-IF
255700
255800     END-IF.
255900
256000
256100 8000-EXIT.
256200      EXIT.
256300
256400
256500***************************************************************
256600 9000-MOVE-RESULTS.
256700***************************************************************
256800
256900
257000*-------------------------------------------------------------*
257100* IF CLAIM PRICED, MOVE LENGTH OF STAY & VERSION TO OUTPUT    *
257200*-------------------------------------------------------------*
257300     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
257400        MOVE H-LOS TO PPS-LOS
257500        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
257600
257700*-------------------------------------------------------------*
257800* IF CLAIM DIDN'T PRICE DUE TO AN ERROR, INITIALIZE ALL       *
257900* OUTPUT DATA EXCEPT FOR PPS-RTC AND PPS-CHRG-THRESHOLD,      *
258000* INITIALIZE WORK VARIABLES, AND MOVE VERSION TO OUTPUT       *
258100*-------------------------------------------------------------*
258200     ELSE
258300       INITIALIZE PPS-DATA
258400       INITIALIZE PPS-OTHER-DATA
258500       INITIALIZE PPS-CBSA
258600       INITIALIZE HOLD-PPS-COMPONENTS
258700       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
258800     END-IF.
258900
259000
259100*
259200*  THE FOLLOWING LINES ARE USED FOR TESTING
259300*  THEY DISPLAY VALUES FOR CERTAIN PROVIDERS
259400*  THE DISPLAY STATEMENTS OUTPUT VALUES TO THE SYSOUTDEVICE
259500* - COMMENT THEM OUT WHEN NOT TESTING
259600*
259700*    IF (B-PROVIDER-NO = '502021'
259800*                    OR  '502022'
259900*                    OR  '452023'
260000*                    OR  '452024'
260100*                    OR  '012025'
260200*                    OR  '332026'
260300*                    OR  '332027'
260400*                    OR  '532028'
260500*                    OR  '142029')
260600*
260700*
260800*
260900*    DISPLAY '---------------------------------------------'
261000*    DISPLAY '*********************************************'
261100*    DISPLAY '---------------------------------------------'
261200*MATCH THE TEST OUTPUT FROM THE LTCH PRICER TO THE
261300*OUTPUT OF THE TEST CASE SPREADSHEET FROM POLICY
261400*    DISPLAY 'B-PROVIDER-NO '            B-PROVIDER-NO
261500*    DISPLAY ' '
261600*    DISPLAY ' '
261700*    DISPLAY 'B-REVIEW-CODE '            B-REVIEW-CODE
261800*    DISPLAY 'P-NEW-FED-PPS-BLEND-IND '  P-NEW-FED-PPS-BLEND-IND
261900* PSYCH/REHAB DRG PRESENT
262000*    IF PSYCH-REHAB-DRG
262100*       MOVE 'YES' TO PSYCH-REHAB-DRG-PRESENT
262200*    ELSE MOVE 'NO' TO PSYCH-REHAB-DRG-PRESENT
262300*    END-IF
262400*    DISPLAY 'PSYCH-REHAB-DRG '          PSYCH-REHAB-DRG-PRESENT
262500* IPPS CLAIM PRESENT
262600*    DISPLAY 'IPPS_CLAIM_PRESENT ?'
262700*    DISPLAY 'WS-VENT-STATUS '           WS-VENT-STATUS
262800*    DISPLAY 'ICU/CCU_PRESENT ?'
262900*    DISPLAY 'SEVERE_WOUND_EXCEPTION ?'
263000*    DISPLAY 'SPINAL_CORD-EXCEPTION ?'
263100*    DISPLAY 'WS-PRIMARY-PMT-TYPE '      WS-PRIMARY-PMT-TYPE
263200*    DISPLAY 'PPS-CBSA '                 PPS-CBSA
263300*    DISPLAY 'P-NEW-STATE-CODE-X '       P-NEW-STATE-CODE-X
263400* ON THE TEST CASE TEST SPREADSHEET THE VALUE TITLED
263500* "CBSA FOR IPPS WI" IS CBSA CONCATINATED WITH STATE ABBREVIATION
263600* BUT, FOLLOWING LINE INSTEAD DISPLAYS CBSA + STATE NUMERIC
263700* ABBREVIATION BECAUSE THE PRICER DOESN'T HAVE STATE ABBREVIATION
263800*    DISPLAY 'CBSA_FOR_IPPS_WI '  PPS-CBSA P-NEW-STATE-CODE-X
263900*    DISPLAY 'CBSA_FOR_IPPS_WI ?'
264000*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
264100*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
264200*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
264300*    DISPLAY 'H-ADMISSION-DATE '         H-ADMISSION-DATE
264400* CARES ACT FLAG ON TEST CASE SPREADSHEET
264500*    DISPLAY ' '
264600*    DISPLAY 'H-LOS '                    H-LOS
264700*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
264800*    DISPLAY 'P-NEW-OPER-CSTCHG-RATIO '  P-NEW-OPER-CSTCHG-RATIO
264900*    DISPLAY 'H-SS-COST '                H-SS-COST
265000*    DISPLAY 'H-FIXED-LOSS-AMT-STD '     H-FIXED-LOSS-AMT-STD
265100*    DISPLAY 'H-FIXED-LOSS-AMT-SNT '     H-FIXED-LOSS-AMT-SNT
265200*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE
265300*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
265400*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
265500*    DISPLAY 'H-SSOT '                   H-SSOT
265600*    DISPLAY 'P-NEW-HOSP-QUAL-IND '      P-NEW-HOSP-QUAL-IND
265700*    DISPLAY 'PPS-STD-FED-RATE '         PPS-STD-FED-RATE
265800*    DISPLAY 'PPS-NAT-LABOR-PCT '        PPS-NAT-LABOR-PCT
265900*    DISPLAY 'PPS-NAT-NONLABOR-PCT '     PPS-NAT-NONLABOR-PCT
266000***** WORK IN PROGRESS
266100*****COMPUTE H-LABOR-PORTION-TIMES-WIX =
266200*****          H-LABOR-PORTION *
266300*    DISPLAY 'H-LABOR-PORTION-UNADJUSTED ?'
266400***** WORK IN PROGESS
266500*****COMPUTE H-NONLABOR-PORTION-TIMES-WIX =
266600*****          H-NONLABOR-PORTION *
266700*    DISPLAY 'NONLABOR-PORTION-UNADJUSTED ?'
266800*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
266900*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
267000*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
267100*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
267200*    DISPLAY ' '
267300*    DISPLAY ' '
267400*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
267500*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
267600*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
267700*****DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
267800*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
267900*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
268000*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
268100*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
268200*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
268300*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
268400*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE
268500*    DISPLAY ' '
268600*    DISPLAY ' '
268700*    DISPLAY ' '
268800*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
268900*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
269000*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
269100*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
269200*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
269300*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
269400*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
269500*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
269600*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
269700*    DISPLAY ' '
269800*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
269900*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
270000*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
270100*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
270200*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
270300*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
270400*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
270500*    DISPLAY 'H-OUTLIER-THRESHOLD-STD '  H-OUTLIER-THRESHOLD-STD
270600*    DISPLAY ' '
270700*    DISPLAY ' '
270800*    DISPLAY ' '
270900*    DISPLAY 'H-BDGT-NEUT-FACTOR '       H-BDGT-NEUT-FACTOR
271000*    DISPLAY ' '
271100*    DISPLAY ' '
271200*    DISPLAY ' '
271300*    DISPLAY ' '
271400*    DISPLAY 'PPS-LTCH-DPP-ADJ-AMT '     PPS-LTCH-DPP-ADJ-AMT
271500*    DISPLAY ' '
271600*    DISPLAY ' '
271700*    DISPLAY ' '
271800*    DISPLAY ' '
271900*    DISPLAY 'PRE-DPP PAY           '    H-PRE-DPP-PAY
272000*    DISPLAY 'DPP BASE PAY          '    H-IPPS-PAY-AMT
272100*    DISPLAY 'DPP OUTLIER THRESHOLD '    PPS-OUTLIER-THRESHOLD
272200*    DISPLAY 'DPP OUTLIER FLAG ?    '
272300*    DISPLAY 'DPP OUTLIER PAY       '    H-IPPS-LIKE-AMT-OUTLIER
272400*    DISPLAY 'DPP TOTAL             '    H-IPPS-LIKE-AMT
272500*    DISPLAY 'LTCH DPP ADJUSTMENT   '    PPS-LTCH-DPP-ADJ-AMT
272600*    DISPLAY ' '
272700*    DISPLAY 'PPS-RTC               '    PPS-RTC
272800*    DISPLAY 'PPS-FINAL-PAY-AMT     '    PPS-FINAL-PAY-AMT
272900***END OF ENTERING NEW DISPLAY ORDER FOR TEST CASE COMPARISON
273000*
273100*
273200***BEGIN OF OTHER VARIABLES FOR TESTING
273300*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
273400*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
273500*    DISPLAY 'H-OPER-IME-RATIO '         H-CAPI-IME-RATIO
273600*    DISPLAY 'B-PROCEDURE-CODE-TABLE '   B-PROCEDURE-CODE-TABLE
273700*    DISPLAY 'PPS-SITE-NEUTRAL-COST-PM ' PPS-SITE-NEUTRAL-COST-PMT
273800*    DISPLAY 'PPS-SITE-NEUTRAL-IPPS-PM ' PPS-SITE-NEUTRAL-IPPS-PMT
273900*    DISPLAY 'PPS-STANDARD-FULL-PMT '    PPS-STANDARD-FULL-PMT
274000*    DISPLAY 'PPS-STANDARD-SSO-PMT '     PPS-STANDARD-SSO-PMT
274100*    DISPLAY 'PPS-FAC-COSTS '            PPS-FAC-COSTS
274200*    DISPLAY 'PPS-CHRG-THRESHOLD '       PPS-CHRG-THRESHOLD
274300*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
274400*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
274500*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
274600*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS
274700*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
274800*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
274900*    DISPLAY 'H-BLEND-SNT '              H-BLEND-SNT
275000*    DISPLAY 'H-BLEND-STD '              H-BLEND-STD
275100*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
275200*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
275300*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
275400*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
275500*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
275600*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
275700*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
275800*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
275900*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
276000*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
276100*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND
276200*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
276300*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
276400*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
276500*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
276600*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
276700*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
276800*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
276900*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
277000*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
277100*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
277200*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
277300*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
277400*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
277500*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
277600*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
277700*
277800*    END-IF.
277900
278000 9000-EXIT.
278100      EXIT.
278200
278300******        L A S T   S O U R C E   S T A T E M E N T   *****
