000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL212.
000300*AUTHOR.         CMS.
000400*REMARKS.        EFFECTIVE OCTOBER 1, 2020
000500*
000600***********************************************************
000700*
000800* VERSION 21.2 ***
000900* NOVEMBER 20, 2020 - UPDATED THE IPPS RATES FOR
001000* SITE-NEUTRAL CASES AS FOLLOWS:
001100*
001200* SSO AND SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS:
001300*   (UPDATED FOR CN)
001400*  - IPPS LABOR SHARE WAGE INDEX > 1:       $4,071.57
001500*  - IPPS NONLABOR SHARE WAGE INDEX > 1:    $1,889.74
001600*
001700*  - IPPS LABOR SHARE WAGE INDEX < /= 1:    $3,696.01
001800*  - IPPS NONLABOR SHARE WAGE INDEX < /= 1: $2,265.30
001900*
002000*  - CAPITAL NATIONAL RATE:                   $466.21
002100*
002200* VERSION 21.2 UPDATES VERSION 21.1
002300*
002400***********************************************************
002500* VERSION 21.1 CONTAINED THE FOLLOWING UPDATES:
002600* OCTOBER 21, 2020 - UPDATED DUE TO CORRECTION NOTICE (CN).
002700*
002800* ONLY THE IPPS RATES FOR SITE NEUTRAL CASES WERE UPDATED.
002900*
003000* HIGH COST OUTLIER FIXED-LOSS AMOUNTS (NO POLICY/CALCULATION
003100* LOGIC CHANGES):
003200*  - SITE NEUTRAL RATE CASES: $29,064
003300*
003400* SSO AND SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS:
003500*   (UPDATED FOR CN)
003600*  - IPPS LABOR SHARE WAGE INDEX > 1:       $4,071.63
003700*  - IPPS NONLABOR SHARE WAGE INDEX > 1:    $1,889.77
003800*
003900*  - IPPS LABOR SHARE WAGE INDEX < /= 1:    $3,696.07
004000*  - IPPS NONLABOR SHARE WAGE INDEX < /= 1: $2,265.33
004100*
004200*  - CAPITAL NATIONAL RATE:                   $466.22
004300*
004400*
004500* VERSION 21.1 UPDATES VERSION 21.0.
004600*
004700*
004800* VERSION 21.0 INCLUDED THE FOLLOWING CHANGES TO IMPLEMENT
004900* BOTH CR11707 AND CR22879:
005000*
005100* FOR CR11707: UPDATES IN THE FISCAL INTERMEDIARY SHARED
005200* SYSTEM (FISS) INPATIENT AND OUTPATIENT PROVIDER SPECIFIC
005300* FILES (PSF).
005400* - ADDED TWO NEW FIELDS
005500*     *  P-SUPP-WI-IND    PIC X
005600*     *  P-SUPP-WI        PIC 9(02)V9(04)
005700* - ADDED RURAL FLOOR WAGE INDEX COLUMN TO CBSA WAGE INDEX TABLE
005800*     * T-CBSA-WAGE-INDX3  PIC S9(02)V9(04)
005900*
006000*
006100* FOR CR11879: FISCAL YEAR (FY) 2021 INPATIENT PROSPECTIVE PAYMENT
006200* SYSTEM (IPPS) AND LONG TERM CARE HOSPITAL (LTCH) PPS CHANGES
006300*
006400* IMPLEMENT UPDATES FROM FY 2021 LTCH PPS PRICER SPEC SHEET
006500* VERSION 21.0 PRODUCTION
006600*
006700* PRICER STANDARD FEDERAL RATES/FACTORS/POLICY:
006800*
006900* STANDARD FEDERAL RATES (BASED ON QUALITY DATA REPORT STATUS
007000* FOR FY2021):
007100*
007200*   FULL UPDATE (QUALITY INDICATOR ON PSF = 1): $43,755.34
007300*   REDUCED UPDATE (QUALITY INDICATOR ON PSF = 0 OR
007400*      BLANK): $42,899.90
007500*
007600* LABOR SHARE: 68.1% (0.681)
007700*
007800* NONLABOR SHARE: 31.9% (0.319)
007900*
008000* **********************NEW POLICY/LOGIC***********************
008100* A) FOR FY 2021, A 5 PERCENT CAP WILL BE APPLIED ON ANY
008200* DECREASE IN A LTCH'S PPS WAGE INDEX FROM THE LTCH'S PPS
008300* WAGE INDEX IN FY 2020.
008400* B) FOR ALL LTCHS WITH DECREASES GREATER THAN 5 PERCENT,
008500* MACS WILL POPULATE THE PSF SUPPLEMENTAL WAGE INDEX FIELD
008600* WITH THE FY 2020 LTCH PPS WAGE INDEX. MACS WILL ALSO ENTER A
008700* '1" IN THE SUPPLEMENTAL WAGE INDEX INDICATOR.
008800* C) LTCH PRICER SHOULD USE THESE TWO FIELDS TO SET THE FY 2021
008900* WAGE INDEX. SEE LOGIC BELOW:
009000* IF SUPP-WAGE-INDEX-FLAG = "1":
009100*      IF SUPP-WAGE-INDEX > 0:
009200*           IF (PPS-WAGE-INDEX- SUPP-WAGE-INDEX )/
009300*               SUPP-WAGE-INDEX  < -.05:
009400*                  PPS-WAGE-INDEX= (ROUND(SUPP-WAGE-INDEX  *
009500*                                  .95,.0001))
009600*           ELSE  RETURN ERROR CODE1
009700*      ELSE  RETURN ERROR CODE1
009800*
009900*    ERROR CODE WILL BE RETURNED BACK TO FISS. MAC WILL HAVE
010000*    TO UPDATE THE SUPPLEMENTAL WAGE INDEX FIELDS IN ORDER FOR
010100*    PRICER TO SUCCESSFULLY PRICE THE CLAIM.
010200*
010300* NOTE: THE PPS-WAGE-INDEX SHOULD CONTINUE TO BE SET EQUAL
010400* TO THE SPECIAL-WAGE-INDEX WHENEVER THE SPECIAL-PAY-INDICATOR
010500* FIELD IS EQUAL TO "1" AND THE SPECIAL-WAGE-INDEX IS GREATER
010600* THAN 0.
010700*
010800***************************************************************
010900*
011000* HIGH COST OUTLIER FIXED-LOSS AMOUNTS (NO POLICY/CALCULATION
011100* LOGIC CHANGES)
011200*
011300* - STANDARD RATE CASES: $27,195
011400* - SITE NEUTRAL RATE CASES: * SEE CN
011500*
011600* SITE NEUTRAL PAYMENT RATE BLEND (BASED ON BLEND YEAR VALUE
011700* IN PSF):
011800* - NO CHANGE IN LOGIC. NOTE: WE DO EXPECT FEDBLEND WILL BE
011900*   EQUAL TO 8 IN PSF FOR ALL PROVIDERS IN FY2021.
012000*
012100* SITE NEUTRAL RATE HCO BUDGET NEUTRALITY FACTOR: 0.949 (NO
012200* POLICY/CALCULATION LOGIC CHANGES)
012300* - ONLY APPLY TO NON-HCO PORTION OF THE SITE NEUTRAL PAYMENT
012400*   RATE AMOUNT AND DO NOT APPLY TO THE ANY APPLICABLE SITE
012500*   NEUTRAL PAYMENT RATE HCO PAYMENT
012600*
012700* SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS: - 0.954 (NO
012800* POLICY/CALCULATION LOGIC CHANGES)
012900* - APPLIED TO THE IPPS COMPARABLE PAYMENT OPTION FOR THE
013000* SITE NEUTRAL PAYMENT RATE PAYMENT, INCLUDING ANY APPLICABLE
013100* OUTLIER PAYMENT PRIOR TO MAKING THE 'LESSER OF' COMPARISON
013200* TO COST
013300*
013400*
013500* SSO AND SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS:
013600*
013700* (PLEASE NOTE THESE VALUES ARE SUBJECT TO CHANGE DURING
013800*  THE CN)
013900*
014000* - IPPS LABOR SHARE WAGE INDEX > 1:       * SEE CN
014100* - IPPS NONLABOR SHARE WAGE INDEX > 1:    * SEE CN
014200* - IPPS LABOR SHARE WAGE INDEX < /= 1:    * SEE CN
014300* - IPPS NONLABOR SHARE WAGE INDEX < /= 1: * SEE CN
014400*
014500* - CAPITAL NATIONAL RATE: * SEE CN
014600*
014700* - REDUCTION FACTOR FOR IPPS COMPARABLE OPERATING DSH
014800*   PAYMENT AMOUNT: 79.65% OR A FACTOR OF 0.7965. (THIS
014900*   REDUCTION IS NOT APPLIED TO THE CAPITAL DSH PAYMENT
015000*   CALCULATION.)
015100*
015200* - USE FY 2021 IPPS AREA WAGE INDEXES & MS-DRG WEIGHTS/
015300*   LENGTH OF STAY.
015400*
015500* *******************NEW LOGIC*****************
015600*
015700* A) CHANGE REQUEST 11707 ADDED 2 NEW FIELDS TO THE PSF:
015800*    SUPPLEMENTAL WAGE INDEX AND SUPPLEMENTAL WAGE INDEX
015900*    INDICATOR.
016000*
016100* B) WHEN SUPPLEMENTAL WAGE INDEX INDICATOR = '2',  PRICER
016200*    SHOULD SET THE IPPS COMPARABLE WAGE INDEX VALUE EQUAL
016300*    TO THE VALUE LOCATED IN THE SUPPLEMENTAL WAGE INDEX
016400*    FIELD.
016500*
016600* C) BELOW IS THE LOGIC:
016700*
016800*    IF SUPP-WAGE-INDEX-FLAG = "2":
016900*       IF SUPP-WAGE-INDEX > 0:
017000*          H-IPPS-WAGE-INDEX= SUPP-WAGE-INDEX
017100*          H-CAPI-GAF = ROUND(SUPP-WAGE-INDEX � 0.6848, .0001)
017200*      ELSE RETURN ERROR CODE
017300*
017400* ERROR CODE WILL BE RETURNED BACK TO FISS. MAC WILL
017500* HAVE TO UPDATE THE SUPPLEMENTAL WAGE INDEX FIELDS IN
017600* ORDER FOR PRICER TO SUCCESSFULLY PRICE THE CLAIM.
017700*
017800*
017900* CHANGED H-OPER-DSH-PCT PIC TO 9V9(04).
018000*
018100***********************************************************
018200 ENVIRONMENT DIVISION.
018300 CONFIGURATION SECTION.
018400 SOURCE-COMPUTER.            IBM-370.
018500 OBJECT-COMPUTER.            IBM-370.
018600 INPUT-OUTPUT  SECTION.
018700 FILE-CONTROL.
018800
018900 DATA DIVISION.
019000 FILE SECTION.
019100
019200 WORKING-STORAGE SECTION.
019300 01  W-STORAGE-REF                  PIC X(46)  VALUE
019400     'LTCAL212      - W O R K I N G   S T O R A G E'.
019500 01  CAL-VERSION                    PIC X(05)  VALUE 'V21.2'.
019600 01  PROGRAM-CONSTANTS.
019700     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
019800     05  VENT-ICD-10-CODE           PIC X(07) VALUE '5A1955Z'.
019900 01  PROGRAM-FLAGS.
020000     05  WS-PRIMARY-PMT-TYPE        PIC X(01).
020100         88 PMT-STANDARD-OLD       VALUE '1'.
020200         88 PMT-STANDARD-NEW       VALUE '2'.
020300         88 PMT-SITE-NEUTRAL       VALUE '3'.
020400         88 PMT-BLEND              VALUE '4'.
020500     05  WS-SECONDARY-PMT-TYPE-SNT  PIC X(01).
020600         88 PMT-SITE-NEUT-COST     VALUE '1'.
020700         88 PMT-SITE-NEUT-IPPS     VALUE '2'.
020800     05  WS-SECONDARY-PMT-TYPE-STD  PIC X(01).
020900         88 PMT-STANDARD-FULL      VALUE '1'.
021000         88 PMT-STANDARD-SSO       VALUE '2'.
021100     05  WS-VENT-STATUS             PIC X(01).
021200         88 VENT-PRESENT           VALUE 'Y'.
021300         88 VENT-NOT-PRESENT       VALUE 'N'.
021400
021500
021600***************************************************************
021700*    LAYUP TABLE AREA FOR FY2020 LTC-DRG                      *
021800*    EFFECTIVE DATE OF OCTOBER 1, 2019                        *
021900***************************************************************
022000 COPY LTDRG210.
022100
022200
022300***************************************************************
022400*    LAYUP TABLE AREA FOR FY2020 IPPS-DRG                     *
022500*    EFFECTIVE DATE OF OCTOBER 1, 2019                        *
022600***************************************************************
022700 COPY IPDRG211.
022800
022900
023000***************************************************************
023100*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
023200***************************************************************
023300 01  HOLD-PPS-COMPONENTS.
023400     05  H-LOS                        PIC 9(03).
023500     05  H-REG-DAYS                   PIC 9(03).
023600     05  H-TOTAL-DAYS                 PIC 9(05).
023700     05  H-SSOT                       PIC 9(02)V9(01).
023800     05  H-BLEND-RTC                  PIC 9(02).
023900     05  H-BLEND-SNT                  PIC 9(01)V9(01).
024000     05  H-BLEND-STD                  PIC 9(01)V9(01).
024100     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
024200     05  H-SS-COST                    PIC 9(07)V9(02).
024300     05  H-LABOR-PORTION              PIC 9(07)V9(06).
024400     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
024500     05  H-FIXED-LOSS-AMT-STD         PIC 9(07)V9(02).
024600     05  H-FIXED-LOSS-AMT-SNT         PIC 9(07)V9(02).
024700     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
024800     05  H-LOS-RATIO                  PIC 9(01)V9(05).
024900     05  H-ADMISSION-DATE             PIC 9(08).
025000     05  H-DISCHARGE-DATE             PIC 9(08).
025100     05  H-ADMISS-DATE-INT            PIC 9(07).
025200
025300*** --------------------------------------------------- ***
025400*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
025500*** --------------------------------------------------- ***
025600     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
025700     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
025800     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
025900     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
026000     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
026100     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
026200     05  H-INTERN-RATIO               PIC 9(01)V9(04).
026300     05  H-CAPI-IME-RATIO             PIC 9V9999.
026400     05  H-BED-SIZE                   PIC 9(05).
026500     05  H-OPER-DSH-PCT               PIC 9V9(04).
026600     05  H-SSI-RATIO                  PIC V9(04).
026700     05  H-MEDICAID-RATIO             PIC V9(04).
026800     05  H-OPER-DSH                   PIC 9(01)V9(04).
026900     05  H-CAPI-DSH                   PIC 9(01)V9(04).
027000     05  H-GEO-CLASS                  PIC X(01).
027100     05  H-URBAN-IND                  PIC X(01).
027200           88 URBAN-CBSA           VALUE '1'.
027300           88 RURAL-CBSA           VALUE '0'.
027400     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
027500     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
027600     05  H-CAPI-PMT                   PIC 9(07)V9(02).
027700     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
027800     05  H-CAPI-GAF                   PIC 9(05)V9(04).
027900     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
028000     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
028100     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
028200     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
028300     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
028400     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
028500     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
028600     05  H-OPER-COLA                  PIC 9(01)V9(03).
028700     05  H-CAPI-COLA                  PIC 9(01)V9(03).
028800     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
028900     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
029000     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
029100     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
029200     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
029300     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
029400     05  H-IPPS-DAYS-CUTOFF           PIC 9(02)V9(01).
029500     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
029600     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
029700     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
029800*    05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
029900*    05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
030000     05  H-NAT-OPER-IPPS-PMT-PCT      PIC 9(01)V9(02).
030100     05  H-PR-OPER-IPPS-PMT-PCT       PIC 9(01)V9(02).
030200     05  H-NAT-CAPI-IPPS-PMT-PCT      PIC 9(01)V9(02).
030300     05  H-PR-CAPI-IPPS-PMT-PCT       PIC 9(01)V9(02).
030400     05  H-COUNTER                    PIC 9(02).
030500     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).
030600     05  H-OPER-DSH-REDUCTION-FACTOR  PIC V9(04).
030700     05  H-OUTLIER-THRESHOLD-STD      PIC 9(07)V9(02).
030800     05  H-BDGT-NEUT-FACTOR           PIC 9(01)V9(06).
030900     05  H-OUTLIER-PAY-AMT-STD        PIC 9(07)V9(02).
031000     05  H-OUTLIER-PAY-AMT-SNT        PIC 9(07)V9(02).
031100     05  H-OUTLIER-IPPS-COMPARABLE    PIC 9(07)V9(02).
031200     05  H-SN-COST-4COMPARISON        PIC 9(07)V9(02).
031300     05  H-SN-IPPS-4COMPARISON        PIC 9(07)V9(02).
031400     05  H-SITE-NEUTRAL-IPPS-ADJ      PIC 9(01)V9(06).
031500     05  H-IPPS-LIKE-AMT              PIC 9(07)V9(02).
031600     05  H-IPPS-LIKE-AMT-OUTLIER      PIC 9(07)V9(02).
031700     05  H-PRE-DPP-PAY                PIC 9(07)V9(02).
031800
031900*** --------------------------------------------------- ***
032000*** VARIABLES FOR PC PRICER                             ***
032100*** --------------------------------------------------- ***
032200     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
032300     05  H-SS-COST-IND                PIC X.
032400     05  H-SS-PERDIEM-IND             PIC X.
032500     05  H-SS-BLEND-IND               PIC X.
032600     05  H-SS-IPPSCOMP-IND            PIC X.
032700
032800
032900*---------------------------------------------------------*
033000* 8-6-14 ADDED WK-HLDDRG-DATA AND WK-HLDDRG-DATA2 TO      *
033100* MATCH THE IPPS DRG TABLE DATA NAMES THAT WERE COPIED    *
033200* FROM THE FY14 IPPS PRICER CALCULATION PROGRAM           *
033300*---------------------------------------------------------*
033400
033500 01 WK-HLDDRG-DATA.
033600     05  HLDDRG-DATA.
033700         10  HLDDRG-DRGX               PIC X(03).
033800         10  FILLER1                   PIC X(01).
033900         10  HLDDRG-WEIGHT             PIC 9(02)V9(04).
034000         10  FILLER2                   PIC X(01).
034100         10  HLDDRG-GMALOS             PIC 9(02)V9(01).
034200         10  FILLER3                   PIC X(05).
034300         10  HLDDRG-LOW                PIC X(01).
034400         10  FILLER5                   PIC X(01).
034500         10  HLDDRG-ARITH-ALOS         PIC 9(02)V9(01).
034600         10  FILLER6                   PIC X(02).
034700         10  HLDDRG-PAC                PIC X(01).
034800         10  FILLER7                   PIC X(01).
034900         10  HLDDRG-SPPAC              PIC X(01).
035000         10  FILLER8                   PIC X(02).
035100         10  HLDDRG-DESC               PIC X(26).
035200
035300 01 WK-HLDDRG-DATA2.
035400     05  HLDDRG-DATA2.
035500         10  HLDDRG-DRGX2               PIC X(03).
035600         10  FILLER21                   PIC X(01).
035700         10  HLDDRG-WEIGHT2             PIC 9(02)V9(04).
035800         10  FILLER22                   PIC X(01).
035900         10  HLDDRG-GMALOS2             PIC 9(02)V9(01).
036000         10  FILLER23                   PIC X(05).
036100         10  HLDDRG-LOW2                PIC X(01).
036200         10  FILLER25                   PIC X(01).
036300         10  HLDDRG-ARITH-ALOS2         PIC 9(02)V9(01).
036400         10  FILLER26                   PIC X(02).
036500         10  HLDDRG-TRANS-FLAGS.
036600                   88  D-DRG-POSTACUTE-50-50
036700                   VALUE 'Y Y'.
036800                   88  D-DRG-POSTACUTE-PERDIEM
036900                   VALUE 'Y  '.
037000             15  HLDDRG-PAC2            PIC X(01).
037100             15  FILLER27               PIC X(01).
037200             15  HLDDRG-SPPAC2          PIC X(01).
037300         10  FILLER28                   PIC X(02).
037400         10  HLDDRG-DESC2               PIC X(26).
037500         10  HLDDRG-VALID               PIC X(01).
037600
037700
037800**** THESE ARE VARIABLES TO DISPLAY RESULTS FOR TESTING ***
037900 01  DISPLAY-VARIABLES.
038000     05 PSYCH-REHAB-DRG-PRESENT  PIC X(3) VALUE SPACE.
038100
038200
038300
038400
038500
038600 LINKAGE SECTION.
038700
038800**************************************************************
038900* THE LINKAGE SECTION CONTAINS DESCRIPTIONS OF THE FIELDS THAT
039000* CONTAIN VALUES THAT ARE PASSED FROM THE CALLING PROGRAM
039100* (LTDRV... IN THIS CASE)
039200**************************************************************
039300
039400
039500**************************************************************
039600* BILL-NEW-DATA IS THE BILL RECORD FROM THE LTDRV... PROGRAM
039700**************************************************************
039800 01  BILL-NEW-DATA.
039900     10  B-NPI10.
040000         15  B-NPI8               PIC X(08).
040100         15  B-NPI-FILLER         PIC X(02).
040200     10  B-PROVIDER-NO            PIC X(06).
040300     10  B-PATIENT-STATUS         PIC X(02).
040400     10  B-DRG-CODE               PIC 9(03).
040500     10  B-LOS                    PIC 9(03).
040600     10  B-COV-DAYS               PIC 9(03).
040700     10  B-LTR-DAYS               PIC 9(02).
040800     10  B-CST-RPT-DAYS           PIC 9(03).
040900     10  B-DISCHARGE-DATE.
041000         15  B-DISCHG-CC          PIC 9(02).
041100         15  B-DISCHG-YY          PIC 9(02).
041200         15  B-DISCHG-MM          PIC 9(02).
041300         15  B-DISCHG-DD          PIC 9(02).
041400     10  B-COV-CHARGES            PIC 9(07)V9(02).
041500     10  B-SPEC-PAY-IND           PIC X(01).
041600     05  B-REVIEW-CODE            PIC 9(02).
041700     05  B-DIAGNOSIS-CODE-TABLE.
041800         10  B-DIAGNOSIS-CODE     PIC X(07) OCCURS 25 TIMES
041900                                  INDEXED BY IDX-DIAG.
042000     05  B-PROCEDURE-CODE-TABLE.
042100         10  B-PROCEDURE-CODE     PIC X(07) OCCURS 25 TIMES
042200                                  INDEXED BY IDX-PROC.
042300     05  B-LTCH-DPP-INDICATOR-SW  PIC X.
042400         88 B-LTCH-DPP-ADJUSTMENT VALUE 'Y'.
042500     05  FILLER                   PIC X(19).
042600
042700
042800***************************************************************
042900
043000
043100
043200
043300
043400
043500*     ** ----------------------------------------------       *
043600
043700*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
043800*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
043900*                                                             *
044000*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
044100*                                                             *
044200*             02 = SHORT STAY PAYMENT WITHOUT OUTLIER         *
044300*                                                             *
044400*             03 = SHORT STAY PAYMENT WITH OUTLIER            *
044500*                                                             *
044600*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
044700*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
044800*                                                             *
044900*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
045000*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
045100*                                                             *
045200*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
045300*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
045400*                                                             *
045500*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
045600*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
045700*                                                             *
045800*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
045900*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
046000*                                                             *
046100*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
046200*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
046300*                                                             *
046400*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
046500*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
046600*                                                             *
046700*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
046800*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
046900*                                                             *
047000*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
047100*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
047200*                                                             *
047300*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
047400*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
047500*                                                             *
047600*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
047700*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
047800*                                                             *
047900*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
048000*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
048100*                                                             *
048200*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
048300*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
048400*                                                             *
048500*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
048600*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
048700*                                                             *
048800*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
048900*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
049000*                                                             *
049100*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
049200*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
049300*                                                             *
049400*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
049500*                  WITHOUT OUTLIER                            *
049600*                                                             *
049700*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
049800*                  DIEM WITHOUT OUTLIER                       *
049900*                                                             *
050000*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
050100*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
050200*                  AMOUNT WITHOUT OUTLIER                     *
050300*                                                             *
050400*             23 = SHORT STAY PAYMENT BASED ON ESTIMATED      *
050500*                  COST WITH OUTLIER                          *
050600*                                                             *
050700*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
050800*                  DIEM WITH OUTLIER                          *
050900*                                                             *
051000*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
051100*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
051200*                  AMOUNT WITH OUTLIER                        *
051300*                                                             *
051400*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *
051500*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *
051600*            FOR IPPS COMPARABLE PER DIEM)                    *
051700*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *
051800*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *
051900*            FOR IPPS COMPARABLE PER DIEM)                    *
052000*                                                             *
052100*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
052200*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
052300*                                                             *
052400*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
052500*                  COMPARABLE THRESHOLD WITH OUTLIER          *
052600*                                                             *
052700*             28 = SUBCLAUSE (II) DOES NOT QUALIFY FOR AN     *
052800*                  OUTLIER                                    *
052900*                                                             *
053000*             29 = SUBCLAUSE (II) QUALIFIES FOR AN OUTLIER    *
053100*                                                             *
053200*                                                             *
053300*     ** OLD & NEW POLICY ERROR CODE VALUES AND DESCRIPTIONS  *
053400*     ** ---------------------------------------------------  *
053500*     *****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
053600*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
053700*             51 = PROVIDER RECORD TERMINATED                 *
053800*             52 = INVALID WAGE INDEX                         *
053900*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
054000*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
054100*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
054200*                                     OR                      *
054300*                  DISCHARGE DATE < CBSA EFF START DATE       *
054400*                  FOR PPS                                    *
054500*             56 = INVALID LENGTH OF STAY                     *
054600*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
054700*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
054800*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
054900*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
055000*                  OR BILL-LTR-DAYS > 60                      *
055100*             62 = INVALID NUMBER OF COVERED DAYS             *
055200*                  OR BILL-LTR-DAYS > COVERED DAYS            *
055300*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
055400*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
055500*                  OR COST OUTLIER THRESHOLD CALCULATION      *
055600*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *
055700*             72 = INVALID BLEND INDICATOR OR REVIEW CODE     *
055800*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
055900*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
056000*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *
056100*                                                             *
056200*                                                             *
056300*             ADDITIONAL RETURN CODES STARTING IN 2016:       *
056400*                                                             *
056500*             A0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
056600*                  PSYCH/REHAB                                *
056700*                                                             *
056800*             A1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
056900*                  OUTLIER, PSYCH/REHAB                       *
057000*                                                             *
057100*             A2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
057200*                  SSO, PSYCH/REHAB                           *
057300*                                                             *
057400*             A3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
057500*                  SSO, OUTLIER, PSYCH/REHAB                  *
057600*                                                             *
057700*             A4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
057800*                  PSYCH/REHAB                                *
057900*                                                             *
058000*             A5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
058100*                  OUTLIER, PSYCH/REHAB                       *
058200*                                                             *
058300*             A6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
058400*                  SSO, PSYCH/REHAB                           *
058500*                                                             *
058600*             A7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
058700*                  SSO, OUTLIER, PSYCH/REHAB                  *
058800*                                                             *
058900*             AA = SITE-NEUTRAL BASED ON COST,                *
059000*                  PSYCH/REHAB                                *
059100*                                                             *
059200*             AB = SITE-NEUTRAL BASED ON IPPS,                *
059300*                  PSYCH/REHAB                                *
059400*                                                             *
059500*             AC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
059600*                  PSYCH/REHAB                                *
059700*                                                             *
059800*             B0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
059900*                  VENT                                       *
060000*                                                             *
060100*             B1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
060200*                  OUTLIER, VENT                              *
060300*                                                             *
060400*             B2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
060500*                  SSO, VENT                                  *
060600*                                                             *
060700*             B3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
060800*                  SSO, OUTLIER, VENT                         *
060900*                                                             *
061000*             B4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
061100*                  VENT                                       *
061200*                                                             *
061300*             B5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
061400*                  OUTLIER, VENT                              *
061500*                                                             *
061600*             B6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
061700*                  SSO, VENT                                  *
061800*                                                             *
061900*             B7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
062000*                  SSO, OUTLIER, VENT                         *
062100*                                                             *
062200*             BA = SITE-NEUTRAL BASED ON COST, VENT           *
062300*                                                             *
062400*             BB = SITE-NEUTRAL BASED ON IPPS, VENT           *
062500*                                                             *
062600*             BC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
062700*                  VENT                                       *
062800*                                                             *
062900*             BD = SSO STANDARD PAYMENT, VENT                 *
063000*                                                             *
063100*             BE = SSO STANDARD PAYMENT, OUTLIER, VENT        *
063200*                                                             *
063300*             BF = STANDARD PAYMENT FULL DRG, VENT            *
063400*                                                             *
063500*             BG = STANDARD PAYMENT FULL DRG, OUTLIER,        *
063600*                  VENT                                       *
063700*                                                             *
063800*             C0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
063900*                  NO VENT                                    *
064000*                                                             *
064100*             C1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
064200*                  OUTLIER, NO VENT                           *
064300*                                                             *
064400*             C2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
064500*                  SSO, NO VENT                               *
064600*                                                             *
064700*             C3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
064800*                  SSO, OUTLIER, NO VENT                      *
064900*                                                             *
065000*             C4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
065100*                  NO VENT                                    *
065200*                                                             *
065300*             C5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
065400*                  OUTLIER, NO VENT                           *
065500*                                                             *
065600*             C6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
065700*                  SSO, NO VENT                               *
065800*                                                             *
065900*             C7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
066000*                  SSO, OUTLIER, NO VENT                      *
066100*                                                             *
066200*             CA = SITE-NEUTRAL BASED ON COST, NO VENT        *
066300*                                                             *
066400*             CB = SITE-NEUTRAL BASED ON IPPS, NO VENT        *
066500*                                                             *
066600*             CC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
066700*                  NO VENT                                    *
066800*                                                             *
066900*             CD = SSO STANDARD PAYMENT, NO VENT              *
067000*                                                             *
067100*             CE = SSO STANDARD PAYMENT, OUTLIER,             *
067200*                  NO VENT                                    *
067300*                                                             *
067400*             CF = STANDARD PAYMENT FULL DRG, NO VENT         *
067500*                                                             *
067600*             CG = STANDARD PAYMENT FULL DRG, OUTLIER,        *
067700*                  NO VENT                                    *
067800*                                                             *
067900*                                                             *
068000***************************************************************
068100***************************************************************
068200*
068300*
068400***************************************************************
068500* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
068600* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
068700***************************************************************
068800 01  PPS-DATA-ALL.
068900     05  PPS-RTC.
069000           88  OLD-ERROR-CODE        VALUE '50' THRU '99'.
069100         10  PPS-RTC-1                 PIC X.
069200               88  NEW-ERROR-CODE    VALUE 'D'.
069300         10  PPS-RTC-2                 PIC X.
069400     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
069500     05  PPS-DATA.
069600         10  PPS-MSA                   PIC X(04).
069700         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
069800         10  PPS-AVG-LOS               PIC 9(02)V9(01).
069900         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
070000         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
070100         10  PPS-LOS                   PIC 9(03).
070200         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
070300         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
070400         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
070500         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
070600         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
070700         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
070800         10  PPS-SUBM-DRG-CODE         PIC X(03).
070900               88  PSYCH-REHAB-DRG   VALUE
071000                   '876' '880' '881' '882' '883' '884'
071100                   '885' '887' '886' '894' '895' '896'
071200                   '897' '945' '946'.
071300         10  PPS-CALC-VERS-CD          PIC X(05).
071400         10  PPS-REG-DAYS-USED         PIC 9(03).
071500         10  PPS-LTR-DAYS-USED         PIC 9(03).
071600         10  PPS-BLEND-YEAR            PIC 9(01).
071700         10  PPS-COLA                  PIC 9(01)V9(03).
071800         10  FILLER                    PIC X(04).
071900     05  PPS-OTHER-DATA.
072000         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
072100         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
072200         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
072300         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
072400         10  PPS-IPTHRESH              PIC 9(03)V9(01).
072500         10  PPS-LTCH-DPP-ADJ-AMT      PIC S9(09)V99.
072600         10  FILLER                    PIC X(05).
072700
072800     05  PPS-PC-DATA.
072900         10  PPS-COT-IND               PIC X(01).
073000         10  H-PC-IND                  PIC X(02).
073100               88  PC-PRICER               VALUE 'PC'.
073200         10  FILLER                    PIC X(18).
073300
073400 01  PPS-CBSA                          PIC X(05).
073500
073600
073700 01  PPS-PAYMENT-DATA.
073800     05  PPS-SITE-NEUTRAL-COST-PMT     PIC  9(07)V99.
073900     05  PPS-SITE-NEUTRAL-IPPS-PMT     PIC  9(07)V99.
074000     05  PPS-STANDARD-FULL-PMT         PIC  9(07)V99.
074100     05  PPS-STANDARD-SSO-PMT          PIC  9(07)V99.
074200
074300
074400******************************************************************
074500*            THESE ARE THE VERSIONS OF THE LTDRV___              *
074600*           PROGRAMS THAT WILL BE PASSED BACK----                *
074700*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
074800******************************************************************
074900 01  PRICER-OPT-VERS-SW.
075000     05  PRICER-OPTION-SW          PIC X(01).
075100         88  ALL-TABLES-PASSED          VALUE 'A'.
075200         88  PROV-RECORD-PASSED         VALUE 'P'.
075300     05  PPS-VERSIONS.
075400         10  PPDRV-VERSION         PIC X(05).
075500
075600
075700**************************************************************
075800* PROV-NEW-HOLD IS THE PROVIDER RECORD THAT IS PASSED FROM   *
075900* LTDRV___) TO LTCAL___                                      *
076000**************************************************************
076100 01  PROV-NEW-HOLD.
076200     02  PROV-NEWREC-HOLD1.
076300         05  P-NEW-NPI10.
076400             10  P-NEW-NPI8             PIC X(08).
076500             10  P-NEW-NPI-FILLER       PIC X(02).
076600         05  P-NEW-PROVIDER-NO.
076700               88  SUBCLAUSEII-PROV       VALUE '332006'.
076800             10  P-NEW-STATE            PIC 9(02).
076900             10  P-NEW-STATE-X REDEFINES
077000                 P-NEW-STATE            PIC X(02).
077100             10  FILLER                 PIC X(04).
077200         05  P-NEW-DATE-DATA.
077300             10  P-NEW-EFF-DATE.
077400                 15  P-NEW-EFF-DT-CC    PIC 9(02).
077500                 15  P-NEW-EFF-DT-YY    PIC 9(02).
077600                 15  P-NEW-EFF-DT-MM    PIC 9(02).
077700                 15  P-NEW-EFF-DT-DD    PIC 9(02).
077800             10  P-NEW-FY-BEGIN-DATE.
077900                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).
078000                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).
078100                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).
078200                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).
078300             10  P-NEW-REPORT-DATE.
078400                 15  P-NEW-REPORT-DT-CC PIC 9(02).
078500                 15  P-NEW-REPORT-DT-YY PIC 9(02).
078600                 15  P-NEW-REPORT-DT-MM PIC 9(02).
078700                 15  P-NEW-REPORT-DT-DD PIC 9(02).
078800             10  P-NEW-TERMINATION-DATE.
078900                 15  P-NEW-TERM-DT-CC   PIC 9(02).
079000                 15  P-NEW-TERM-DT-YY   PIC 9(02).
079100                 15  P-NEW-TERM-DT-MM   PIC 9(02).
079200                 15  P-NEW-TERM-DT-DD   PIC 9(02).
079300         05  P-NEW-WAIVER-CODE          PIC X(01).
079400             88  P-NEW-WAIVER-STATE       VALUE 'Y'.
079500         05  P-NEW-INTER-NO             PIC 9(05).
079600         05  P-NEW-PROVIDER-TYPE        PIC X(02).
079700         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
079800         05  P-NEW-CURRENT-DIV   REDEFINES
079900                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
080000         05  P-NEW-MSA-DATA.
080100             10  P-NEW-CHG-CODE-INDEX       PIC X.
080200             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT.
080300             10  P-NEW-GEO-LOC-MSA9   REDEFINES
080400                             P-NEW-GEO-LOC-MSAX  PIC 9(04).
080500             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT.
080600             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT.
080700             10  P-NEW-STAND-AMT-LOC-MSA9
080800                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.
080900                 15  P-NEW-RURAL-1ST.
081000                     20  P-NEW-STAND-RURAL  PIC XX.
081100                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.
081200                 15  P-NEW-RURAL-2ND        PIC XX.
081300         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.
081400         05  P-NEW-LUGAR                    PIC X.
081500         05  P-NEW-TEMP-RELIEF-IND          PIC X.
081600         05  P-NEW-FED-PPS-BLEND-IND        PIC X.
081700         05  P-NEW-STATE-CODE               PIC 9(02).
081800         05  P-NEW-STATE-CODE-X REDEFINES
081900               P-NEW-STATE-CODE             PIC X(02).
082000         05  FILLER                         PIC X(03).
082100     02  PROV-NEWREC-HOLD2.
082200         05  P-NEW-VARIABLES.
082300             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).
082400             10  P-NEW-COLA              PIC  9(01)V9(03).
082500             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).
082600             10  P-NEW-BED-SIZE          PIC  9(05).
082700             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).
082800             10  P-NEW-CMI               PIC  9(01)V9(04).
082900             10  P-NEW-SSI-RATIO         PIC  V9(04).
083000             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).
083100             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).
083200             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).
083300             10  P-NEW-DSH-PERCENT       PIC  V9(04).
083400             10  P-NEW-FYE-DATE          PIC  X(08).
083500         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).
083600         05  P-NEW-HOSP-QUAL-IND           PIC X(01).
083700         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.
083800         05  P-NEW-GEO-LOC-CBSA9 REDEFINES
083900                       P-NEW-GEO-LOC-CBSAX PIC 9(05).
084000         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES
084100                       P-NEW-GEO-LOC-CBSAX.
084200             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.
084300             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.
084400             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.
084500             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.
084600             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.
084700         05  FILLER                        PIC X(10).
084800         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).
084900     02  PROV-NEWREC-HOLD3.
085000         05  P-NEW-PASS-AMT-DATA.
085100             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.
085200             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.
085300             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.
085400             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.
085500         05  P-NEW-CAPI-DATA.
085600             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.
085700             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.
085800             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.
085900             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.
086000             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.
086100             15  P-NEW-CAPI-NEW-HOSP       PIC X.
086200             15  P-NEW-CAPI-IME            PIC 9V9999.
086300             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.
086400             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.
086500         05  P-SUPP-WI-IND                 PIC X.
086600         05  P-SUPP-WI                     PIC 9(02)V9(04).
086700         05  FILLER                        PIC X(11).
086800
086900
087000******************************************************************
087100*                THIS IS THE LTCH WAGE-INDEX                     *
087200*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
087300*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *
087400******************************************************************
087500 01  WAGE-NEW-INDEX-RECORD.
087600     05  W-CBSA                        PIC X(5).
087700     05  W-EFF-DATE                    PIC X(8).
087800     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).
087900     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).
088000     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).
088100
088200
088300******************************************************************
088400*                THIS IS THE IPPS WAGE-INDEX                     *
088500*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
088600******************************************************************
088700 01  WAGE-NEW-IPPS-INDEX-RECORD.
088800     05  W-CBSA-IPPS.
088900         10 CBSA-IPPS-123              PIC X(3).
089000         10 CBSA-IPPS-45               PIC X(2).
089100     05  W-CBSA-IPPS-SIZE              PIC X.
089200         88  LARGE-URBAN       VALUE 'L'.
089300         88  OTHER-URBAN       VALUE 'O'.
089400         88  ALL-RURAL         VALUE 'R'.
089500     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).
089600     05  FILLER                        PIC X.
089700     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).
089800     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).
089900
090000 PROCEDURE DIVISION  USING BILL-NEW-DATA
090100                           PPS-DATA-ALL
090200                           PPS-CBSA
090300                           PPS-PAYMENT-DATA
090400                           PRICER-OPT-VERS-SW
090500                           PROV-NEW-HOLD
090600                           WAGE-NEW-INDEX-RECORD
090700                           WAGE-NEW-IPPS-INDEX-RECORD.
090800
090900
091000***************************************************************
091100*                                                             *
091200*    PROCESSING:                                              *
091300*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
091400*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
091500*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
091600*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
091700*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
091800*           GOBACK.                                           *
091900*        D. ASSEMBLE PRICING COMPONENTS.                      *
092000*        E. CALCULATE THE PRICE.                              *
092100*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
092200*                                                             *
092300***************************************************************
092400
092500
092600***************************************************************
092700 0000-MAINLINE-CONTROL.
092800***************************************************************
092900
093000     PERFORM 0100-INITIAL-ROUTINE
093100        THRU 0100-EXIT.
093200
093300     PERFORM 1000-EDIT-INPUT-DATA
093400        THRU 1000-EXIT.
093500
093600     IF PPS-RTC = '00'
093700        PERFORM 1700-EDIT-DRG-CODE
093800           THRU 1700-EXIT.
093900
094000     IF PPS-RTC = '00'
094100        PERFORM 1800-EDIT-IPPS-DRG-CODE
094200           THRU 1800-EXIT.
094300
094400     IF PPS-RTC = '00'
094500        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
094600           THRU 2000-EXIT.
094700
094800     IF PPS-RTC = '00'
094900        PERFORM 3000-CALC-PAYMENT
095000           THRU 3000-EXIT.
095100
095200     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
095300        PERFORM 6000-CALC-HIGH-COST-OUTLIER
095400           THRU 6000-EXIT.
095500
095600     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
095700        PERFORM 7000-SET-FINAL-RETURN-CODES
095800           THRU 7000-EXIT.
095900
096000     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
096100        PERFORM 8000-CALC-FINAL-PMT
096200           THRU 8000-EXIT.
096300
096400     PERFORM 9000-MOVE-RESULTS
096500        THRU 9000-EXIT.
096600
096700     GOBACK.
096800
096900
097000***************************************************************
097100 0100-INITIAL-ROUTINE.
097200***************************************************************
097300
097400     MOVE '00' TO PPS-RTC.
097500     INITIALIZE PPS-DATA.
097600     INITIALIZE PPS-OTHER-DATA.
097700     INITIALIZE PPS-CBSA.
097800     INITIALIZE PPS-PAYMENT-DATA.
097900     INITIALIZE HOLD-PPS-COMPONENTS.
098000     INITIALIZE PROGRAM-FLAGS.
098100     INITIALIZE WK-HLDDRG-DATA
098200                WK-HLDDRG-DATA2.
098300
098400     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.
098500
098600
098700*** ---------------------------------------------------- ***
098800*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***
098900*** ---------------------------------------------------- ***
099000     MOVE .681 TO PPS-NAT-LABOR-PCT.
099100     MOVE .319 TO PPS-NAT-NONLABOR-PCT.
099200
099300*** --------------------------------------------------------
099400*** NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
099500*** REPORTING OF QUALITY DATA.
099600*** - FULL UPDATE (QUALITY INDICATOR ON PSF = 1)
099700*** - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK)
099800*** --------------------------------------------------------
099900     IF P-NEW-HOSP-QUAL-IND = '1'
100000        MOVE 43755.34 TO PPS-STD-FED-RATE
100100     ELSE
100200        MOVE 42899.90 TO PPS-STD-FED-RATE.
100300     MOVE 27195.00 TO H-FIXED-LOSS-AMT-STD.
100400     MOVE 29064.00 TO H-FIXED-LOSS-AMT-SNT.
100500     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.
100600
100700*** ---------------------------------------------------- ***
100800*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
100900*** ---------------------------------------------------- ***
101000     MOVE 466.21 TO H-IPPS-CAPI-STD-FED-RATE.
101100
101200     MOVE W-IPPS-WAGE-INDEX TO H-IPPS-WAGE-INDEX.
101300
101400     IF H-IPPS-WAGE-INDEX > 1
101500           MOVE 4071.57 TO H-IPPS-NAT-LABOR-SHR
101600           MOVE 1889.74 TO H-IPPS-NAT-NONLABOR-SHR
101700     ELSE
101800           MOVE 3696.01 TO H-IPPS-NAT-LABOR-SHR
101900           MOVE 2265.30 TO H-IPPS-NAT-NONLABOR-SHR
102000     END-IF.
102100
102200*** ---------------------------------------------------- ***
102300*** OPERATING DSH REDUCTION FACTOR                       ***
102400*** -----------------------------------------------------***
102500     MOVE 0.7965 TO H-OPER-DSH-REDUCTION-FACTOR.
102600
102700 0100-EXIT.
102800      EXIT.
102900
103000
103100***************************************************************
103200*    INPUT DATA EDITS - IF ANY FAIL SET PPS-RTC               *
103300*    AND DO NOT ATTEMPT TO PRICE.                             *
103400***************************************************************
103500 1000-EDIT-INPUT-DATA.
103600***************************************************************
103700
103800*** -----------------------------------------------------------
103900*** EDIT BILL (BILL-NEW-DATA) INPUT & SET ERROR CODE IF FAIL
104000*** -----------------------------------------------------------
104100     IF (B-LOS NUMERIC) AND (B-LOS > 0)
104200        MOVE B-LOS TO H-LOS
104300     ELSE
104400        MOVE '56' TO PPS-RTC.
104500
104600     IF PPS-RTC = '00'
104700        IF P-NEW-COLA NOT NUMERIC
104800           MOVE '50' TO PPS-RTC.
104900
105000     IF PPS-RTC = '00'
105100        IF P-NEW-WAIVER-STATE
105200           MOVE '53' TO PPS-RTC.
105300
105400     IF PPS-RTC = '00'
105500        IF B-DRG-CODE NOT NUMERIC
105600           MOVE '54' TO PPS-RTC.
105700
105800     IF PPS-RTC = '00'
105900        IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
106000           (B-DISCHARGE-DATE < W-EFF-DATE))
106100            MOVE '55' TO PPS-RTC.
106200
106300     IF PPS-RTC = '00'
106400        IF P-NEW-TERMINATION-DATE > 00000000
106500           IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
106600              MOVE '51' TO PPS-RTC.
106700
106800     IF PPS-RTC = '00'
106900        IF B-COV-CHARGES NOT NUMERIC
107000           MOVE '58' TO PPS-RTC.
107100
107200     IF PPS-RTC = '00'
107300        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
107400           MOVE '61' TO PPS-RTC.
107500
107600     IF PPS-RTC = '00'
107700        IF (B-COV-DAYS NOT NUMERIC) OR
107800           (B-COV-DAYS = 0 AND H-LOS > 0)
107900           MOVE '62' TO PPS-RTC.
108000
108100     IF PPS-RTC = '00'
108200        IF B-LTR-DAYS > B-COV-DAYS
108300           MOVE '62' TO PPS-RTC.
108400
108500     IF PPS-RTC = '00'
108600        IF (B-REVIEW-CODE < 00 OR B-REVIEW-CODE > 08) OR
108700           (B-REVIEW-CODE NOT NUMERIC)
108800           MOVE '72' TO PPS-RTC.
108900
109000
109100*** -----------------------------------------------------------
109200*** CALCULATE DAY RELATED VARIABLE VALUES
109300*** -----------------------------------------------------------
109400     IF PPS-RTC = '00'
109500        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
109600        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
109700
109800     IF PPS-RTC = '00'
109900        PERFORM 1200-DAYS-USED
110000           THRU 1200-DAYS-USED-EXIT.
110100
110200
110300*** -----------------------------------------------------------
110400*** EDIT PSF FIELDS USED BY ALL CLAIMS & SET ERROR CODE IF FAIL
110500*** -----------------------------------------------------------
110600
110700*-------------------------------------------------------------*
110800* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
110900* (ALWAYS FED-FY-BEGIN-03)                                    *
111000*-------------------------------------------------------------*
111100     IF PPS-RTC = '00'
111200        IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
111300           MOVE '74' TO PPS-RTC.
111400
111500*-------------------------------------------------------------*
111600* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
111700*-------------------------------------------------------------*
111800     IF PPS-RTC = '00'
111900        IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
112000           MOVE '65' TO PPS-RTC.
112100
112200
112300*** -----------------------------------------------------------
112400*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
112500*** -----------------------------------------------------------
112600     IF PPS-RTC = '00'
112700        IF P-NEW-CAPI-IME NUMERIC
112800           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
112900        ELSE
113000           MOVE ZEROS TO H-CAPI-IME-RATIO
113100        END-IF
113200     END-IF.
113300
113400     IF PPS-RTC = '00'
113500        IF P-NEW-INTERN-RATIO NUMERIC
113600           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
113700        ELSE
113800           MOVE ZEROS TO H-INTERN-RATIO
113900        END-IF
114000     END-IF.
114100
114200     IF PPS-RTC = '00'
114300        IF P-NEW-BED-SIZE NUMERIC
114400           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
114500        ELSE
114600           MOVE ZEROS TO H-BED-SIZE
114700        END-IF
114800     END-IF.
114900
115000     IF PPS-RTC = '00'
115100        IF P-NEW-SSI-RATIO NUMERIC
115200           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
115300        ELSE
115400           MOVE ZEROS TO H-SSI-RATIO
115500        END-IF
115600     END-IF.
115700
115800     IF PPS-RTC = '00'
115900        IF P-NEW-MEDICAID-RATIO NUMERIC
116000           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
116100        ELSE
116200           MOVE ZEROS TO H-MEDICAID-RATIO
116300        END-IF
116400     END-IF.
116500
116600
116700 1000-EXIT.
116800      EXIT.
116900
117000
117100***************************************************************
117200 1200-DAYS-USED.
117300***************************************************************
117400
117500     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
117600        IF B-LTR-DAYS > H-LOS
117700           MOVE H-LOS TO PPS-LTR-DAYS-USED
117800        ELSE
117900           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
118000     ELSE
118100        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
118200           IF H-REG-DAYS > H-LOS
118300              MOVE H-LOS TO PPS-REG-DAYS-USED
118400           ELSE
118500              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
118600        ELSE
118700           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
118800              IF H-REG-DAYS > H-LOS
118900                 MOVE H-LOS TO PPS-REG-DAYS-USED
119000                 MOVE 0 TO PPS-LTR-DAYS-USED
119100              ELSE
119200                 IF H-TOTAL-DAYS > H-LOS
119300                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
119400                    COMPUTE PPS-LTR-DAYS-USED =
119500                            H-LOS - H-REG-DAYS
119600                 ELSE
119700                    IF H-TOTAL-DAYS <= H-LOS
119800                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
119900                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
120000                    ELSE
120100                       NEXT SENTENCE
120200           ELSE
120300              NEXT SENTENCE.
120400
120500 1200-DAYS-USED-EXIT.
120600      EXIT.
120700
120800
120900***************************************************************
121000*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
121100***************************************************************
121200 1700-EDIT-DRG-CODE.
121300***************************************************************
121400
121500     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
121600     IF PPS-RTC = '00'
121700        SEARCH ALL WWM-ENTRY
121800           AT END
121900             MOVE '54' TO PPS-RTC
122000        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
122100             PERFORM 1750-FIND-VALUE
122200                THRU 1750-EXIT
122300        END-SEARCH.
122400
122500 1700-EXIT.
122600      EXIT.
122700
122800
122900***************************************************************
123000*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
123100***************************************************************
123200 1750-FIND-VALUE.
123300***************************************************************
123400
123500      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
123600      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
123700*     MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
123800
123900 1750-EXIT.
124000      EXIT.
124100
124200
124300***************************************************************
124400*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
124500***************************************************************
124600 1800-EDIT-IPPS-DRG-CODE.
124700***************************************************************
124800
124900**-------------------------------------------------------**
125000** THIS LOGIC WAS COPIED FROM THE IPPS PRICER (PPCAL140) **
125100** ENSURE IT STAYS CONSISTENT BECAUSE IT REFERENCES THE  **
125200** DRG TABLE USED BY THE IPPS PRICER.                    **
125300**-------------------------------------------------------**
125400
125500     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE
125600     SET DRG-IDX TO 1
125700     SEARCH DRG-TAB VARYING DRG-IDX
125800         AT END
125900           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC
126000           MOVE 'I' TO  HLDDRG-VALID
126100           MOVE '54' TO PPS-RTC
126200           GO TO 1800-EXIT
126300       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE
126400         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.
126500
126600
126700     MOVE  HLDDRG-DATA         TO WK-HLDDRG-DATA2.
126800     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.
126900     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2
127000                                  H-IPPS-DRG-WGT.
127100     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2
127200                                  H-IPPS-DRG-ALOS.
127300     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.
127400     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2
127500                                  H-IPPS-ARITH-ALOS.
127600     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.
127700     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.
127800     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.
127900     MOVE  'V'                 TO HLDDRG-VALID.
128000     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.
128100
128200 1800-EXIT.
128300      EXIT.
128400
128500
128600***************************************************************
128700***  GET THE PROVIDER SPECIFIC VARIABLES AND LTCH WAGE INDEX  *
128800*                                                             *
128900*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
129000*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
129100*    OF THAT VARIABLE.                                        *
129200*                                                             *
129300***************************************************************
129400 2000-ASSEMBLE-PPS-VARIABLES.
129500***************************************************************
129600
129700
129800*-------------------------------------------------------------*
129900* ASSIGN FULL (5/5) LTCH WAGE INDEX TO ALL CLAIMS DISCHARGED  *
130000* ON AND AFTER 7/1/2008 (THIRD COLUMN WAGE INDEX IN LTWIX***) *
130100*-------------------------------------------------------------*
130200     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
130300        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
130400     ELSE
130500        MOVE '52' TO PPS-RTC
130600        GO TO 2000-EXIT
130700     END-IF.
130800
130900
131000*-------------------------------------------------------------*
131100* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
131200*-------------------------------------------------------------*
131300     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
131400
131500*-------------------------------------------------------------*
131600* OLD POLICY CLAIMS MUST HAVE A BLEND YEAR INDICATOR OF 5     *
131700*-------------------------------------------------------------*
131800     IF B-REVIEW-CODE = 00 AND PPS-BLEND-YEAR NOT = 5
131900        MOVE 5 TO PPS-BLEND-YEAR
132000     END-IF.
132100
132200*-------------------------------------------------------------*
132300* NEW POLICY CLAIMS MUST HAVE A BLEND YR. IND. OF 6, 7, OR 8  *
132400*-------------------------------------------------------------*
132500     IF (B-REVIEW-CODE >= 01 AND B-REVIEW-CODE <= 08) AND
132600        (PPS-BLEND-YEAR < 6 OR PPS-BLEND-YEAR > 8)
132700        MOVE '72' TO PPS-RTC
132800        GO TO 2000-EXIT
132900     END-IF.
133000
133100*-------------------------------------------------------------*
133200* SET DEFAULT BLEND VARIABLE VALUES                           *
133300* - H-BLEND-STD = % STANDARD PMT CONTRIBUTES TO FINAL PMT     *
133400* - H-BLEND-SNT = % SITE NEUTRAL PMT CONTRIBUTES TO FINAL PMT *
133500*-------------------------------------------------------------*
133600     MOVE 0 TO H-BLEND-SNT.
133700     MOVE 1 TO H-BLEND-STD.
133800     MOVE 0 TO H-BLEND-RTC.
133900
134000
134100*-------------------------------------------------------------*
134200* FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII)          *
134300*-------------------------------------------------------------*
134400     IF (P-NEW-STATE = 02 OR 12)
134500        MOVE P-NEW-COLA TO PPS-COLA
134600     ELSE
134700        MOVE 1.000 TO PPS-COLA
134800     END-IF.
134900
135000
135100 2000-EXIT.
135200      EXIT.
135300
135400
135500***************************************************************
135600*    IF THE BILL & PSF DATA HAS PASSED ALL EDITS (RTC=00)     *
135700*        CALCULATE THE APPLICABLE CLAIM PAYMENT:              *
135800*           - STANDARD PAYMENT                                *
135900*           - SHORT STAY OUTLIER PAYMENT                      *
136000*           - SITE NEUTRAL PAYMENT                            *
136100*           - STANDARD/SITE NEUTRAL BLENDED PAYMENT           *
136200***************************************************************
136300 3000-CALC-PAYMENT.
136400***************************************************************
136500
136600
136700* ADDED 9-10-20 FOR SUPPLEMENTAL WAGE INDEX
136800     IF P-SUPP-WI-IND = '2'
136900        IF P-SUPP-WI > 0
137000* MOVED CALCULATION OF H-CAPI-GAF TO LTCAL MODULE BECAUSE ITS
137100* VALUE IS NOT PASSED BY THE LTDRV MODULE TO THE LTCAL MODULE
137200          COMPUTE H-CAPI-GAF = P-SUPP-WI ** 0.6848
137300        END-IF
137400     END-IF.
137500
137600
137700*-------------------------------------------------------------*
137800* CALCULATE CLAIM COST FOR ALL CLAIMS                         *
137900*-------------------------------------------------------------*
138000     COMPUTE PPS-FAC-COSTS ROUNDED =
138100         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
138200
138300
138400*-------------------------------------------------------------*
138500* DETERMINE WHICH PAYMENT METHOD TO USE. EITHER:              *
138600* - STANDARD PAYMENT UNDER THE OLD POLICY,                    *
138700* - STANDARD PAYMENT UNDER THE NEW POLICY,                    *
138800* - 100% SITE NEUTRAL PAYMENT, OR                             *
138900* - 50/50 BLEND OF SITE NEUTRAL & STANDARD PAYMENT.           *
139000*-------------------------------------------------------------*
139100     PERFORM 3100-DETERMINE-PAYMENT-TYPE
139200        THRU 3100-EXIT.
139300
139400     IF PPS-RTC NOT = '00'
139500        GO TO 3000-EXIT
139600     END-IF.
139700
139800
139900*-------------------------------------------------------------*
140000* CALCULATE CLAIM PAYMENT BASED ON PAYMENT METHOD             *
140100*-------------------------------------------------------------*
140200     IF PMT-STANDARD-OLD
140300        PERFORM 3200-CALC-STANDARD-PMT
140400           THRU 3200-EXIT
140500     END-IF.
140600
140700     IF PMT-STANDARD-NEW
140800        PERFORM 3200-CALC-STANDARD-PMT
140900           THRU 3200-EXIT
141000     END-IF.
141100
141200     IF PMT-SITE-NEUTRAL
141300        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
141400           THRU 3300-EXIT
141500     END-IF.
141600
141700     IF PMT-BLEND
141800        PERFORM 3200-CALC-STANDARD-PMT
141900           THRU 3200-EXIT
142000        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
142100           THRU 3300-EXIT
142200     END-IF.
142300
142400 3000-EXIT.
142500      EXIT.
142600
142700
142800***************************************************************
142900*  DETERMINE WHETHER A CLAIM'S PAYMENT SHOULD BE:             *
143000*  - STANDARD - OLD POLICY                                    *
143100*  - STANDARD - NEW POLICY                                    *
143200*  - 100% SITE NEUTRAL - NEW POLICY                           *
143300*  - 50/50 BLEND OF SITE NEUTRAL & STANDARD - NEW POLICY      *
143400***************************************************************
143500 3100-DETERMINE-PAYMENT-TYPE.
143600***************************************************************
143700
143800*-------------------------------------------------------------*
143900* STANDARD PAYMENT (OLD POLICY)
144000*-------------------------------------------------------------*
144100     IF B-REVIEW-CODE = 00
144200*    IF B-REVIEW-CODE = 00 OR
144300*       SUBCLAUSEII-PROV
144400        SET PMT-STANDARD-OLD TO TRUE
144500        GO TO 3100-EXIT
144600     END-IF.
144700
144800*-------------------------------------------------------------*
144900* STANDARD PAYMENT (NEW POLICY)
145000*-------------------------------------------------------------*
145100     IF (B-REVIEW-CODE = 01 AND NOT PSYCH-REHAB-DRG) OR
145200        B-REVIEW-CODE = 04 OR
145300        B-REVIEW-CODE = 05
145400        SET PMT-STANDARD-NEW TO TRUE
145500        GO TO 3100-EXIT
145600     END-IF.
145700
145800*-------------------------------------------------------------*
145900* SITE NEUTRAL PAYMENT (NEW POLICY)
146000*-------------------------------------------------------------*
146100     IF  (B-REVIEW-CODE = 01 AND PSYCH-REHAB-DRG) OR
146200          B-REVIEW-CODE = 02 OR
146300          B-REVIEW-CODE = 03 OR
146400          B-REVIEW-CODE = 06 OR
146500          B-REVIEW-CODE = 07 OR
146600          B-REVIEW-CODE = 08
146700
146800
146900*-------------------------------------------------------------*
147000* FOR COVID-19 PRICING, CLAIMS THAT WOULD NORMALLY GET PAID   *
147100* AS SITE-NEUTRAL WILL GET PAID AS STANDARD WHEN THE          *
147200* ADMISSION DATE IS ON OR AFTER JANUARY 27, 2020.             *
147300* SINCE THE ADMISSION DATE IS NOT INCLUDED IN THE INPUT BILL  *
147400* RECORD IT GETS CALCULATED FIRST.                            *
147500*-------------------------------------------------------------*
147600       MOVE B-DISCHARGE-DATE TO H-DISCHARGE-DATE
147700       COMPUTE H-ADMISS-DATE-INT =
147800         FUNCTION INTEGER-OF-DATE (H-DISCHARGE-DATE) - B-LOS
147900       COMPUTE H-ADMISSION-DATE =
148000         FUNCTION DATE-OF-INTEGER (H-ADMISS-DATE-INT)
148100       IF H-ADMISSION-DATE > 20200126
148200         SET PMT-STANDARD-NEW TO TRUE
148300         GO TO 3100-EXIT
148400       ELSE
148500
148600*-------------------------------------------------------------*
148700*     SET BUDGET NEUTRALITY RATE FOR SITE NEUTRAL CLAIMS
148800*-------------------------------------------------------------*
148900         MOVE 0.949 TO H-BDGT-NEUT-FACTOR
149000
149100*-------------------------------------------------------------*
149200*     SET SITE-NEUTRAL-IPPS-ADJ FOR SITE-NEUTRAL CLAIMS
149300*-------------------------------------------------------------*
149400         MOVE 0.954 TO H-SITE-NEUTRAL-IPPS-ADJ
149500
149600*-------------------------------------------------------------*
149700*     100% SITE NEUTRAL PAYMENT
149800*-------------------------------------------------------------*
149900         IF PPS-BLEND-YEAR = 8
150000            SET PMT-SITE-NEUTRAL TO TRUE
150100
150200*-------------------------------------------------------------*
150300*     50% SITE NEUTRAL + 50% STANDARD BLENDED PAYMENT
150400*-------------------------------------------------------------*
150500         ELSE
150600             IF PPS-BLEND-YEAR = 6 OR
150700                PPS-BLEND-YEAR = 7
150800                SET PMT-BLEND TO TRUE
150900
151000*-------------------------------------------------------------*
151100*           SET BLEND PERCENTS FOR BLENDED PAYMENT            *
151200*-------------------------------------------------------------*
151300                MOVE .5 TO H-BLEND-STD
151400                MOVE .5 TO H-BLEND-SNT
151500             END-IF
151600         END-IF
151700       END-IF
151800     END-IF.
151900
152000*-------------------------------------------------------------*
152100* CLAIM MEETS NONE OF THE ABOVE CRITERIA - SET RETURN CODE
152200*-------------------------------------------------------------*
152300     IF WS-PRIMARY-PMT-TYPE = ' '
152400        MOVE '72' TO PPS-RTC
152500     END-IF.
152600
152700
152800 3100-EXIT.
152900      EXIT.
153000
153100
153200***************************************************************
153300*     CALCULATE THE STANDARD PAYMENT AMOUNT.                  *
153400*     CALCULATE THE SHORT-STAY OUTLIER AMOUNT IF APPLICABLE.  *
153500***************************************************************
153600 3200-CALC-STANDARD-PMT.
153700***************************************************************
153800
153900*-------------------------------------------------------------*
154000* CALCULATE FULL STANDARD DRG ADJUSTED PAYMENT                *
154100*-------------------------------------------------------------*
154200     COMPUTE H-LABOR-PORTION ROUNDED =
154300         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
154400          * PPS-WAGE-INDEX.
154500
154600     COMPUTE H-NONLABOR-PORTION ROUNDED =
154700         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
154800          * PPS-COLA.
154900
155000     COMPUTE PPS-FED-PAY-AMT ROUNDED =
155100         (H-LABOR-PORTION + H-NONLABOR-PORTION).
155200
155300     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
155400         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
155500
155600* FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY
155700     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
155800
155900
156000*-------------------------------------------------------------*
156100* DETERMINE WHETHER THE CLAIM IS A SHORT STAY OUTLIER;        *
156200* APPLY SHORT STAY OUTLIER POLICY IF IT IS                    *
156300*-------------------------------------------------------------*
156400     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
156500
156600     IF H-LOS <= H-SSOT
156700        PERFORM 3400-SHORT-STAY
156800           THRU 3400-SHORT-STAY-EXIT
156900
157000        IF PMT-STANDARD-NEW OR PMT-BLEND
157100           SET PMT-STANDARD-SSO TO TRUE
157200           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-SSO-PMT
157300        END-IF
157400
157500*-------------------------------------------------------------*
157600* FOR REGULAR STAY CLAIMS, POPULATE THE APPROPRIATE PAYMENT   *
157700* FIELD FOR NEW POLICY CLAIMS                                 *
157800*-------------------------------------------------------------*
157900     ELSE
158000        IF PMT-STANDARD-NEW OR PMT-BLEND
158100           SET PMT-STANDARD-FULL TO TRUE
158200           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-FULL-PMT
158300        END-IF
158400     END-IF.
158500
158600 3200-EXIT.
158700      EXIT.
158800
158900
159000***************************************************************
159100*     CALCULATE THE SITE NEUTRAL PAYMENT AMOUNT               *
159200***************************************************************
159300 3300-CALC-SITE-NEUTRAL-PMT.
159400***************************************************************
159500* BEGINNING LTCAL183 - NEW METHOD
159600
159700*-------------------------------------------------------------*
159800* CALCULATE IPPS COMPARABLE PER DIEM AMT                      *
159900*-------------------------------------------------------------*
160000     PERFORM 3650-SS-IPPS-COMP-PMT
160100        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
160200
160300*-------------------------------------------------------------*
160400* CALCULATE SITE NEUTRAL IPPS COMP. PMT HIGH COST OUTLIER     *
160500* (HCO) FOR THE MINIMUM PAYMENT COMPARISON                    *
160600*-------------------------------------------------------------*
160700     SET PMT-SITE-NEUT-IPPS TO TRUE.
160800     MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT.
160900     PERFORM 6000-CALC-HIGH-COST-OUTLIER
161000        THRU 6000-EXIT.
161100     COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
161200             PPS-OUTLIER-PAY-AMT *
161300             H-SITE-NEUTRAL-IPPS-ADJ.
161400     MOVE PPS-OUTLIER-PAY-AMT TO H-OUTLIER-IPPS-COMPARABLE.
161500     INITIALIZE PPS-OUTLIER-PAY-AMT
161600                WS-SECONDARY-PMT-TYPE-SNT
161700                PPS-SITE-NEUTRAL-IPPS-PMT.
161800
161900*-------------------------------------------------------------*
162000* CALCULATE THE SITE NEUTRAL PAYMENT USING THE FOLLOWING      *
162100* FORMULA FROM POLICY GROUP:                                  *
162200* MIN (�SN ADJ * (IPPS PER DIEM AMT + SN IPPS HCO)�, COST)    *
162300*-------------------------------------------------------------*
162400
162500*-------------------------------------------------------------*
162600* CALCULATE SITE NEUTRAL COST PAYMENT FOR MIN PMT COMPARISON  *
162700*-------------------------------------------------------------*
162800     MOVE PPS-FAC-COSTS TO H-SN-COST-4COMPARISON.
162900
163000*-------------------------------------------------------------*
163100* CALCULATE SITE NEUTRAL IPPS COMP PMT FOR MIN PMT COMPARISON *
163200*-------------------------------------------------------------*
163300     COMPUTE H-SN-IPPS-4COMPARISON ROUNDED =
163400              H-SITE-NEUTRAL-IPPS-ADJ *
163500              (H-IPPS-PER-DIEM +
163600               H-OUTLIER-IPPS-COMPARABLE).
163700
163800*-------------------------------------------------------------*
163900* MINIMUM IS FINAL SITE NEUTRAL PMT BASED ON COST             *
164000*-------------------------------------------------------------*
164100     IF H-SN-COST-4COMPARISON < H-SN-IPPS-4COMPARISON
164200        SET PMT-SITE-NEUT-COST TO TRUE
164300        MOVE PPS-FAC-COSTS TO PPS-SITE-NEUTRAL-COST-PMT
164400
164500*-------------------------------------------------------------*
164600* MINIMUM IS FINAL SITE-NEUTRAL PMT BASED ON IPPS COMPARABLE  *
164700*-------------------------------------------------------------*
164800     ELSE
164900        SET PMT-SITE-NEUT-IPPS TO TRUE
165000        MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT
165100     END-IF.
165200
165300
165400 3300-EXIT.
165500      EXIT.
165600
165700
165800***************************************************************
165900*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
166000*      OF THE AVG. LENGTH OF STAY THEN:                       *
166100*      - PAY THE SHORT-STAY BLENDED PAYMENT                   *
166200*      - SET RETURN CODE FOR OLD POLICY CLAIMS ONLY TO        *
166300*        INDICATE SHORT STAY PAYMENT                          *
166400***************************************************************
166500
166600 3400-SHORT-STAY.
166700
166800        COMPUTE H-SS-PAY-AMT ROUNDED =
166900         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
167000
167100***************************************************************
167200*   CALCULATE BLENDED PAYMENT                                 *
167300***************************************************************
167400
167500        PERFORM 3600-SS-BLENDED-PMT
167600           THRU 3600-SS-BLENDED-PMT-EXIT
167700        MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
167800        IF PMT-STANDARD-OLD
167900           MOVE '22' TO PPS-RTC
168000        END-IF
168100        MOVE 'Y' TO H-SS-BLEND-IND
168200        MOVE 'N' TO H-SS-COST-IND
168300        MOVE 'N' TO H-SS-PERDIEM-IND
168400        MOVE 'N' TO H-SS-IPPSCOMP-IND.
168500
168600 3400-SHORT-STAY-EXIT.
168700      EXIT.
168800
168900
169000 3500-CALC-IPPS-LIKE-AMT.
169100
169200*-------------------------------------------------------------*
169300* GET AN 'IPPS-LIKE AMOUNT' TO BE USED FOR THE DPP ADJUSTMENT *
169400*-------------------------------------------------------------*
169500
169600*-------------------------------------------------------------*
169700* GET THE IPPS PAY AMT                                        *
169800*-------------------------------------------------------------*
169900     PERFORM 3650-SS-IPPS-COMP-PMT
170000        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
170100
170200*-------------------------------------------------------------*
170300* GET THE IPPS PMT HIGH COST OUTLIER (HCO)                    *
170400*-------------------------------------------------------------*
170500     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
170600                  H-IPPS-PAY-AMT + H-FIXED-LOSS-AMT-SNT
170700     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
170800        COMPUTE H-IPPS-LIKE-AMT-OUTLIER =
170900                (PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8
171000     END-IF.
171100
171200*-------------------------------------------------------------*
171300* COMPUTE THE IPPS LIKE AMOUNT                                *
171400*-------------------------------------------------------------*
171500     COMPUTE H-IPPS-LIKE-AMT =
171600                  H-IPPS-PAY-AMT +
171700                  H-IPPS-LIKE-AMT-OUTLIER.
171800
171900 3500-EXIT.
172000      EXIT.
172100
172200
172300***************************************************************
172400*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
172500*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
172600*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
172700*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
172800***************************************************************
172900 3600-SS-BLENDED-PMT.
173000***************************************************************
173100
173200*** ------------------------------------------------------ ***
173300*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
173400*** ------------------------------------------------------ ***
173500     IF H-SSOT < 25
173600        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
173700          H-LOS / H-SSOT
173800     ELSE
173900        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
174000          H-LOS / 25
174100     END-IF.
174200
174300     IF H-LTCH-BLEND-PCT > 1
174400        MOVE 1 TO H-LTCH-BLEND-PCT
174500     END-IF.
174600
174700
174800*** ------------------------------------------------------ ***
174900*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
175000*** ------------------------------------------------------ ***
175100     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
175200        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
175300
175400
175500*** ------------------------------------------------------ ***
175600*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
175700*** ------------------------------------------------------ ***
175800     PERFORM 3650-SS-IPPS-COMP-PMT
175900        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
176000
176100
176200*** ------------------------------------------------------ ***
176300*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
176400*** ------------------------------------------------------ ***
176500     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
176600       1 - H-LTCH-BLEND-PCT.
176700
176800
176900*** ------------------------------------------------------ ***
177000*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
177100*** ------------------------------------------------------ ***
177200     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
177300       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
177400
177500
177600*** ------------------------------------------------------ ***
177700*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
177800*** ------------------------------------------------------ ***
177900     COMPUTE H-SS-BLENDED-PMT ROUNDED =
178000       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
178100
178200
178300 3600-SS-BLENDED-PMT-EXIT.
178400      EXIT.
178500
178600
178700***************************************************************
178800*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
178900*   PER DIEM PAYMENT AMOUNT                                   *
179000***************************************************************
179100 3650-SS-IPPS-COMP-PMT.
179200***************************************************************
179300
179400*** -------------------------------------------------------
179500*** OPERATING TEACHING ADJUSTMENT
179600*** -------------------------------------------------------
179700     COMPUTE H-OPER-IME-TEACH ROUNDED =
179800        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
179900
180000
180100*** -------------------------------------------------------
180200*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
180300*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%
180400*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL
180500***              THIS CHANGE IS RETROACTIVE TO 10/01/2008
180600*** -------------------------------------------------------
180700     IF H-CAPI-IME-RATIO > 1.5000
180800        MOVE 1.5000 TO H-CAPI-IME-RATIO.
180900
181000     COMPUTE H-CAPI-IME-TEACH ROUNDED =
181100        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).
181200
181300
181400*** -------------------------------------------------------
181500*** OPERATING DSH ADJUSTMENT
181600*** -------------------------------------------------------
181700
181800*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
181900*---------------------------------------------------
182000     IF ALL-RURAL
182100        SET RURAL-CBSA TO TRUE
182200     ELSE
182300        SET URBAN-CBSA TO TRUE
182400     END-IF.
182500
182600
182700*2) CALCULATE THE OPERATING DSH PERCENT
182800*--------------------------------------
182900     COMPUTE H-OPER-DSH-PCT ROUNDED =
183000        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
183100
183200
183300*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
183400*-----------------------------------------------------
183500
183600*    URBAN, < 100 BEDS
183700*    -----------------
183800     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
183900        H-OPER-DSH-PCT >= .15
184000          MOVE '3' TO H-GEO-CLASS
184100     ELSE
184200
184300
184400*   URBAN, >= 100 BEDS
184500*   ------------------
184600       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
184700          H-OPER-DSH-PCT >= .15
184800            MOVE '2' TO H-GEO-CLASS
184900       ELSE
185000
185100
185200*   RURAL, >= 500 BEDS
185300*   ------------------
185400         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
185500            H-OPER-DSH-PCT >= .15
185600              MOVE '2' TO H-GEO-CLASS
185700         ELSE
185800
185900
186000*   RURAL, < 500 BEDS
186100*   -----------------
186200           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
186300              H-OPER-DSH-PCT >= .15
186400                MOVE '3' TO H-GEO-CLASS
186500           ELSE
186600
186700
186800*   OTHER
186900*   -----------------
187000              MOVE '4' TO H-GEO-CLASS
187100
187200           END-IF
187300         END-IF
187400       END-IF
187500     END-IF.
187600
187700
187800*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
187900*-----------------------------------------------------------
188000     EVALUATE H-GEO-CLASS
188100
188200*      GEOGRAPHIC CLASS 2
188300*      ------------------
188400       WHEN '2'
188500          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
188600             COMPUTE H-OPER-DSH ROUNDED =
188700               ((H-OPER-DSH-PCT - .15) * .65) + .025
188800          ELSE
188900             IF H-OPER-DSH-PCT > .202
189000                COMPUTE H-OPER-DSH ROUNDED =
189100                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
189200             ELSE
189300                MOVE ZEROS TO H-OPER-DSH
189400             END-IF
189500          END-IF
189600
189700*      GEOGRAPHIC CLASS 3
189800*      ------------------
189900       WHEN '3'
190000          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
190100             COMPUTE H-OPER-DSH ROUNDED =
190200               ((H-OPER-DSH-PCT - .15) * .65) + .025
190300             IF H-OPER-DSH > .12
190400                MOVE .12 TO H-OPER-DSH
190500             END-IF
190600          ELSE
190700             IF H-OPER-DSH-PCT > .202
190800                COMPUTE H-OPER-DSH ROUNDED =
190900                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
191000                IF H-OPER-DSH > .12
191100                   MOVE .12 TO H-OPER-DSH
191200                END-IF
191300             ELSE
191400               MOVE ZEROS TO H-OPER-DSH
191500             END-IF
191600          END-IF
191700
191800*      GEOGRAPHIC CLASS 4
191900*      ------------------
192000       WHEN '4'
192100          MOVE ZEROS TO H-OPER-DSH
192200
192300     END-EVALUATE.
192400
192500
192600*** -------------------------------------------------------
192700*** CURRENT OPERATING DSH PAYMENT REDUCTION
192800*** -------------------------------------------------------
192900     COMPUTE H-OPER-DSH ROUNDED =
193000             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.
193100
193200*** -------------------------------------------------------
193300*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
193400*** -------------------------------------------------------
193500     IF URBAN-CBSA AND H-BED-SIZE >= 100
193600        COMPUTE H-CAPI-DSH ROUNDED =
193700          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
193800     ELSE
193900        MOVE ZEROS TO H-CAPI-DSH
194000     END-IF.
194100
194200
194300*** -------------------------------------------------------
194400*** OPERATING PAYMENT (STANDARD AMOUNT)
194500*** -------------------------------------------------------
194600     IF (P-NEW-STATE = 02 OR 12)
194700        MOVE P-NEW-COLA TO H-OPER-COLA
194800     ELSE
194900        MOVE 1.000 TO H-OPER-COLA
195000     END-IF.
195100
195200     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
195300       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +
195400         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
195500         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
195600
195700
195800*** -------------------------------------------------------
195900*** CAPITAL PAYMENT (CAPITAL RATE)
196000*** -------------------------------------------------------
196100     COMPUTE H-CAPI-COLA ROUNDED =
196200       (.3152 * (H-OPER-COLA - 1) + 1).
196300
196400*--------------------------------------------------------------*
196500*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
196600*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
196700*--------------------------------------------------------------*
196800     IF LARGE-URBAN
196900        MOVE 1.00 TO H-LRGURB-ADD-ON
197000     ELSE
197100        MOVE 1.00 TO H-LRGURB-ADD-ON
197200     END-IF.
197300
197400     COMPUTE H-CAPI-GAF ROUNDED =
197500       (H-IPPS-WAGE-INDEX ** .6848).
197600
197700     COMPUTE H-CAPI-PMT ROUNDED =
197800       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
197900       H-LRGURB-ADD-ON *  H-CAPI-COLA *
198000       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
198100
198200
198300*** -------------------------------------------------------
198400*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
198500*** -------------------------------------------------------
198600     COMPUTE H-IPPS-PAY-AMT ROUNDED =
198700       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
198800
198900
199000*** -------------------------------------------------------
199100*** IPPS COMPARABLE PER DIEM PAYMENT
199200*** -------------------------------------------------------
199300     COMPUTE H-IPPS-PER-DIEM ROUNDED =
199400       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
199500
199600     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
199700        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
199800     END-IF.
199900
200000*** -------------------------------------------------------
200100*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
200200*** -------------------------------------------------------
200300
200400
200500 3650-SS-IPPS-COMP-PMT-EXIT.
200600      EXIT.
200700
200800
200900***************************************************************
201000*4000-SPECIAL-PROVIDER.
201100***************************************************************
201200*
201300*** PROCESS FOR CY2003
201400*** ------------------
201500*    IF (B-DISCHARGE-DATE >= 20030701) AND
201600*       (B-DISCHARGE-DATE <  20040101)
201700*       COMPUTE H-SS-COST ROUNDED =
201800*           (PPS-FAC-COSTS * 1.95)
201900*       COMPUTE H-SS-PAY-AMT ROUNDED =
202000*        ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
202100*    END-IF
202200*
202300*
202400*** PROCESS FOR CY2004
202500*** ------------------
202600*    IF (B-DISCHARGE-DATE >= 20040101) AND
202700*       (B-DISCHARGE-DATE <  20050101)
202800*       COMPUTE H-SS-COST ROUNDED =
202900*           (PPS-FAC-COSTS * 1.93)
203000*       COMPUTE H-SS-PAY-AMT ROUNDED =
203100*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
203200*    END-IF
203300*
203400*
203500*** PROCESS FOR CY2005
203600*** ------------------
203700*    IF (B-DISCHARGE-DATE >= 20050101) AND
203800*       (B-DISCHARGE-DATE <  20060101)
203900*       COMPUTE H-SS-COST ROUNDED =
204000*           (PPS-FAC-COSTS * 1.65)
204100*       COMPUTE H-SS-PAY-AMT ROUNDED =
204200*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
204300*    END-IF
204400*
204500*
204600*** PROCESS FOR CY2006
204700*** ------------------
204800*    IF (B-DISCHARGE-DATE >= 20060101) AND
204900*       (B-DISCHARGE-DATE <  20070101)
205000*       COMPUTE H-SS-COST ROUNDED =
205100*           (PPS-FAC-COSTS * 1.36)
205200*       COMPUTE H-SS-PAY-AMT ROUNDED =
205300*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
205400*    END-IF
205500*
205600*
205700*** PROCESS FOR CY2007 AND AFTER
205800*** ----------------------------
205900*    IF (B-DISCHARGE-DATE >= 20070101)
206000*       COMPUTE H-SS-COST ROUNDED =
206100*           (PPS-FAC-COSTS * 1.2)
206200*       COMPUTE H-SS-PAY-AMT ROUNDED =
206300*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
206400*    END-IF.
206500*
206600*4000-SPECIAL-PROVIDER-EXIT.
206700*     EXIT.
206800
206900
207000***************************************************************
207100*   CALCULATE THE OUTLIER THRESHOLD                           *
207200*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
207300*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
207400*   SET RETURN CODE                                           *
207500*   CALCULATE THE CHARGE THRESHOLD IF APPLICABLE              *
207600***************************************************************
207700 6000-CALC-HIGH-COST-OUTLIER.
207800***************************************************************
207900
208000
208100*-------------------------------------------------------------*
208200* FOR NON-BLENDED PAYMENT CLAIMS:                             *
208300*-------------------------------------------------------------*
208400* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLD  *
208500*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
208600* - CALCULATE OUTLIER THRESHOLD                               *
208700*-------------------------------------------------------------*
208800
208900     IF PMT-STANDARD-OLD
209000        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
209100                PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT-STD
209200     END-IF.
209300
209400
209500     IF PMT-STANDARD-NEW
209600        IF PMT-STANDARD-FULL
209700           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
209800                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
209900        ELSE
210000           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
210100                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
210200        END-IF
210300     END-IF.
210400
210500
210600     IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
210700        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
210800                PPS-SITE-NEUTRAL-IPPS-PMT + H-FIXED-LOSS-AMT-SNT
210900     END-IF.
211000
211100
211200*-------------------------------------------------------------*
211300* CALCULATE HIGH-COST OUTLIER IF COSTS EXCEED THRESHOLD       *
211400*-------------------------------------------------------------*
211500     IF NOT PMT-BLEND AND
211600        NOT (PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-COST)
211700        IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
211800           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
211900                   (PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8
212000
212100*-------------------------------------------------------------*
212200*        SITE-NEUTRAL ONLY: REDUCE BY BUDGET NEUTRALITY FACT. *
212300*-------------------------------------------------------------*
212400*          IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
212500*             COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
212600*                    PPS-OUTLIER-PAY-AMT * H-BDGT-NEUT-FACTOR
212700*          END-IF
212800        END-IF
212900     END-IF.
213000
213100
213200
213300*-------------------------------------------------------------*
213400* FOR BLENDED PAYMENT CLAIMS                                  *
213500* (RECEIVE 50% STANDARD PAYMENT + 50% SITE-NEUTRAL PAYMENT)   *
213600*-------------------------------------------------------------*
213700* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLDS *
213800*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
213900* - CALCULATE STANDARD PAYMENT OUTLIER THRESHOLD              *
214000* - CALCULATE SITE-NEUTRAL PAYMENT OUTLIER THRESHOLD          *
214100* - CALCULATE HIGH-COST OUTLIER IF APPLICABLE (50/50 BLEND)   *
214200*-------------------------------------------------------------*
214300
214400     IF PMT-BLEND
214500
214600*-------------------------------------------------------------*
214700* CALCULATE STANDARD OUTLIER THRESHOLD                        *
214800*-------------------------------------------------------------*
214900        IF PMT-STANDARD-FULL
215000           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
215100                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
215200        ELSE
215300           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
215400                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
215500        END-IF
215600
215700
215800*-------------------------------------------------------------*
215900* CALCULATE SITE-NEUTRAL OUTLIER THRESHOLD                    *
216000*-------------------------------------------------------------*
216100        IF PMT-SITE-NEUT-IPPS
216200           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
216300                   PPS-SITE-NEUTRAL-IPPS-PMT +
216400                   H-FIXED-LOSS-AMT-SNT
216500        END-IF
216600
216700
216800*-------------------------------------------------------------*
216900* CALCULATE STANDARD PAYMENT PORTION OF HIGH-COST OUTLIER IF  *
217000* COSTS EXCEED STANDARD PAYMENT THRESHOLD                     *
217100*-------------------------------------------------------------*
217200        IF PPS-FAC-COSTS > H-OUTLIER-THRESHOLD-STD
217300           COMPUTE H-OUTLIER-PAY-AMT-STD ROUNDED =
217400                   (PPS-FAC-COSTS - H-OUTLIER-THRESHOLD-STD) * .8
217500                   * H-BLEND-STD
217600        END-IF
217700
217800
217900*-------------------------------------------------------------*
218000* CALCULATE SITE-NEUTRAL PORTION OF HIGH-COST OUTLIER IF      *
218100* COSTS EXCEED THE SITE-NEUTRAL PAYMENT THRESHOLD             *
218200*-------------------------------------------------------------*
218300        IF PMT-SITE-NEUT-IPPS AND
218400           PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
218500           COMPUTE H-OUTLIER-PAY-AMT-SNT ROUNDED =
218600                  (((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
218700*                  * H-BLEND-SNT) * H-BDGT-NEUT-FACTOR
218800                   * H-BLEND-SNT)
218900        END-IF
219000
219100*-------------------------------------------------------------*
219200* CALCULATE TOTAL BLENDED HIGH-COST OUTLIER:                  *
219300* ADD THE SITE-NEUTRAL PAYMENT PORTION OF HIGH-COST OUTLIER   *
219400* TO THE STANDARD PAYMENT PORTION                             *
219500*-------------------------------------------------------------*
219600        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
219700                H-OUTLIER-PAY-AMT-STD +
219800                (H-OUTLIER-PAY-AMT-SNT * H-SITE-NEUTRAL-IPPS-ADJ)
219900
220000     END-IF.
220100
220200
220300*-------------------------------------------------------------*
220400* FOR ALL CLAIMS:                                             *
220500*-------------------------------------------------------------*
220600* SET HIGH-COST OUTLIER TO $0 IF BILL SPECIAL PAY IND. = '1'  *
220700*-------------------------------------------------------------*
220800     IF B-SPEC-PAY-IND = '1'
220900        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
221000
221100
221200*-------------------------------------------------------------*
221300* DETERMINE IF CHARGE THRESHOLD APPLIES & CALCULATE IF SO     *
221400*-------------------------------------------------------------*
221500     PERFORM 6100-CALC-CHARGE-THRESHOLD
221600        THRU 6100-EXIT.
221700
221800
221900 6000-EXIT.
222000      EXIT.
222100
222200
222300***************************************************************
222400*   CALCULATE CHARGE THRESHOLD & SET ERROR RTC WHEN APPLICABLE*
222500***************************************************************
222600 6100-CALC-CHARGE-THRESHOLD.
222700***************************************************************
222800
222900
223000*-------------------------------------------------------------*
223100* FOR MAINFRAME PRICER ONLY:                                  *
223200*-------------------------------------------------------------*
223300* FOR CLAIMS THAT RECEIVE A HIGH-COST OUTLIER AND HAVE A      *
223400* LENGTH OF STAY THAT EXCEEDS THE COVERED DAYS, CALCULATE THE *
223500* CHARGE THRESHOLD AND SET ERROR RETURN CODE '67'             *
223600*-------------------------------------------------------------*
223700
223800*-------------------------------------------------------------*
223900* FOR PC PRICER (PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS):      *
224000*-------------------------------------------------------------*
224100* CALCULATE CHARGE THRESHOLD FOR CLAIMS ALL CLAIMS THAT HAVE  *
224200* AN OPERATING COST-TO-CHARGE RATIO BUT DO NOT SET ERROR CODE *
224300*-------------------------------------------------------------*
224400
224500     IF (PPS-OUTLIER-PAY-AMT > 0 AND
224600         NOT (PMT-BLEND AND H-OUTLIER-PAY-AMT-SNT = 0)) OR
224700        PPS-COT-IND = 'Y'
224800
224900        IF B-COV-DAYS < H-LOS OR
225000           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
225100
225200           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
225300             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
225400
225500           IF NOT PC-PRICER
225600              MOVE '67' TO PPS-RTC
225700           END-IF
225800
225900        ELSE
226000           NEXT SENTENCE
226100        END-IF
226200     ELSE
226300        NEXT SENTENCE
226400     END-IF.
226500
226600 6100-EXIT.
226700      EXIT.
226800
226900
227000***************************************************************
227100*   SET FINAL RETURN CODES FOR PRICED CLAIMS                  *
227200***************************************************************
227300 7000-SET-FINAL-RETURN-CODES.
227400***************************************************************
227500
227600
227700*-------------------------------------------------------------*
227800* SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIM            *
227900*-------------------------------------------------------------*
228000*    IF SUBCLAUSEII-PROV
228100*       PERFORM 7300-SET-SUBII-RETURN-CODES
228200*          THRU 7300-EXIT
228300*       GO TO 7000-EXIT
228400*    END-IF.
228500
228600
228700*-------------------------------------------------------------*
228800* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
228900* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
229000*-------------------------------------------------------------*
229100     IF PMT-STANDARD-OLD
229200        PERFORM 7100-SET-OLD-RETURN-CODES
229300           THRU 7100-EXIT
229400     END-IF.
229500
229600
229700*-------------------------------------------------------------*
229800* SET RETURN CODES FOR NEW POLICY CLAIMS                      *
229900*-------------------------------------------------------------*
230000     IF PMT-STANDARD-NEW OR PMT-SITE-NEUTRAL OR PMT-BLEND
230100        PERFORM 7200-SET-NEW-RETURN-CODES
230200           THRU 7200-EXIT
230300     END-IF.
230400
230500
230600 7000-EXIT.
230700      EXIT.
230800
230900
231000***************************************************************
231100*   SET RETURN CODES FOR OLD POLICY CLAIMS                    *
231200***************************************************************
231300 7100-SET-OLD-RETURN-CODES.
231400***************************************************************
231500
231600*-------------------------------------------------------------*
231700* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
231800* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
231900*-------------------------------------------------------------*
232000
232100     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '21'
232200        MOVE '24' TO PPS-RTC.
232300
232400     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '22'
232500        MOVE '25' TO PPS-RTC.
232600
232700     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '26'
232800        MOVE '27' TO PPS-RTC.
232900
233000     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '00'
233100        MOVE '01' TO PPS-RTC.
233200
233300     IF (PPS-RTC = '00' OR '20' OR '21' OR '22' OR '26')
233400        IF PPS-REG-DAYS-USED > H-SSOT
233500           MOVE 0 TO PPS-LTR-DAYS-USED
233600        ELSE
233700           NEXT SENTENCE.
233800
233900 7100-EXIT.
234000      EXIT.
234100
234200
234300***************************************************************
234400*   SET RETURN CODES FOR NEW POLICY CLAIMS                    *
234500***************************************************************
234600 7200-SET-NEW-RETURN-CODES.
234700***************************************************************
234800
234900     INITIALIZE PPS-RTC.
235000
235100***************************************************************
235200* SET THE FIRST POSITION OF THE RETURN CODE                   *
235300***************************************************************
235400
235500*--------------------------------------------------*
235600* DEFAULT (NO PSYCH/REHAB NOR VENTILATOR SERVICE)  *
235700*--------------------------------------------------*
235800     MOVE 'C' TO PPS-RTC-1.
235900
236000*--------------------------------------------------*
236100* VENTILATOR SERVICE PRESENT                       *
236200*--------------------------------------------------*
236300     PERFORM 7250-SEARCH-FOR-VENT-PROC
236400        THRU 7250-EXIT.
236500     IF VENT-PRESENT
236600        MOVE 'B' TO PPS-RTC-1
236700     END-IF.
236800
236900*--------------------------------------------------*
237000* SITE NEUTRAL PMT BECAUSE PSYCH/REHAB DRG PRESENT *
237100* (PRESENCE OF PSCHY/REHAB DRG TRUMPS VENT PROC.)  *
237200*--------------------------------------------------*
237300     IF PSYCH-REHAB-DRG AND
237400        (PMT-SITE-NEUTRAL OR PMT-BLEND)
237500        MOVE 'A' TO PPS-RTC-1
237600     END-IF.
237700
237800
237900
238000***************************************************************
238100* SET THE SECOND POSITION OF RETURN CODE                      *
238200***************************************************************
238300
238400*-------------------------------------------------------------*
238500* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = COST         *
238600*-------------------------------------------------------------*
238700     IF PMT-BLEND AND PMT-SITE-NEUT-COST
238800
238900        IF PPS-OUTLIER-PAY-AMT = 0 AND
239000           PMT-STANDARD-FULL
239100           MOVE '0' TO PPS-RTC-2
239200        END-IF
239300
239400        IF PPS-OUTLIER-PAY-AMT > 0 AND
239500           PMT-STANDARD-FULL
239600           MOVE '1' TO PPS-RTC-2
239700        END-IF
239800
239900        IF PPS-OUTLIER-PAY-AMT = 0 AND
240000           PMT-STANDARD-SSO
240100           MOVE '2' TO PPS-RTC-2
240200        END-IF
240300
240400        IF PPS-OUTLIER-PAY-AMT > 0 AND
240500           PMT-STANDARD-SSO
240600           MOVE '3' TO PPS-RTC-2
240700        END-IF
240800
240900     END-IF.
241000
241100
241200*-------------------------------------------------------------*
241300* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = IPPS COMP.   *
241400*-------------------------------------------------------------*
241500     IF PMT-BLEND AND PMT-SITE-NEUT-IPPS
241600
241700        IF PPS-OUTLIER-PAY-AMT = 0 AND
241800           PMT-STANDARD-FULL
241900           MOVE '4' TO PPS-RTC-2
242000        END-IF
242100
242200        IF PPS-OUTLIER-PAY-AMT > 0 AND
242300           PMT-STANDARD-FULL
242400           MOVE '5' TO PPS-RTC-2
242500        END-IF
242600
242700        IF PPS-OUTLIER-PAY-AMT = 0 AND
242800           PMT-STANDARD-SSO
242900           MOVE '6' TO PPS-RTC-2
243000        END-IF
243100
243200        IF PPS-OUTLIER-PAY-AMT > 0 AND
243300           PMT-STANDARD-SSO
243400           MOVE '7' TO PPS-RTC-2
243500        END-IF
243600
243700     END-IF.
243800
243900
244000*-------------------------------------------------------------*
244100* 100% SITE NEUTRAL PAYMENT CLAIMS                            *
244200*-------------------------------------------------------------*
244300     IF PMT-SITE-NEUTRAL
244400
244500        IF PMT-SITE-NEUT-COST
244600           MOVE 'A' TO PPS-RTC-2
244700        END-IF
244800
244900        IF PMT-SITE-NEUT-IPPS
245000           IF PPS-OUTLIER-PAY-AMT = 0
245100              MOVE 'B' TO PPS-RTC-2
245200           ELSE
245300              MOVE 'C' TO PPS-RTC-2
245400           END-IF
245500        END-IF
245600     END-IF.
245700
245800
245900*-------------------------------------------------------------*
246000* 100% STANDARD PAYMENT CLAIMS                                *
246100*-------------------------------------------------------------*
246200     IF PMT-STANDARD-NEW
246300
246400        IF PMT-STANDARD-SSO AND
246500           PPS-OUTLIER-PAY-AMT = 0
246600           MOVE 'D' TO PPS-RTC-2
246700        END-IF
246800
246900        IF PMT-STANDARD-SSO AND
247000           PPS-OUTLIER-PAY-AMT > 0
247100           MOVE 'E' TO PPS-RTC-2
247200        END-IF
247300
247400        IF PMT-STANDARD-FULL AND
247500           PPS-OUTLIER-PAY-AMT = 0
247600           MOVE 'F' TO PPS-RTC-2
247700        END-IF
247800
247900        IF PMT-STANDARD-FULL AND
248000           PPS-OUTLIER-PAY-AMT > 0
248100           MOVE 'G' TO PPS-RTC-2
248200        END-IF
248300
248400     END-IF.
248500
248600
248700 7200-EXIT.
248800      EXIT.
248900
249000
249100***************************************************************
249200*   SEARCH FOR VENTILATOR SERVICE ICD-10 PROCEDURE CODE       *
249300***************************************************************
249400 7250-SEARCH-FOR-VENT-PROC.
249500***************************************************************
249600
249700     SET IDX-PROC TO 1.
249800
249900     SEARCH B-PROCEDURE-CODE VARYING IDX-PROC
250000         AT END
250100            SET VENT-NOT-PRESENT TO TRUE
250200         WHEN VENT-ICD-10-CODE = B-PROCEDURE-CODE (IDX-PROC)
250300            SET VENT-PRESENT TO TRUE
250400            GO TO 7250-EXIT
250500     END-SEARCH.
250600
250700 7250-EXIT.
250800      EXIT.
250900
251000
251100***************************************************************
251200*   SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIMS         *
251300***************************************************************
251400*7300-SET-SUBII-RETURN-CODES.
251500***************************************************************
251600*
251700*    INITIALIZE PPS-RTC.
251800*
251900*-------------------------------------------------------------*
252000* SET RETURN CODE BASED ON PRESENCE/ABSENCE OF OUTLIER        *
252100*-------------------------------------------------------------*
252200*    IF PPS-OUTLIER-PAY-AMT > 0
252300*       MOVE '29' TO PPS-RTC
252400*    ELSE
252500*       MOVE '28' TO PPS-RTC
252600*    END-IF.
252700*
252800*-------------------------------------------------------------*
252900* MOVE PER DIEM AMOUNT TO OUTPUT RECORD VARIABLE              *
253000*-------------------------------------------------------------*
253100*    MOVE P-NEW-FAC-SPEC-RATE TO PPS-NEW-FAC-SPEC-RATE.
253200*
253300*-------------------------------------------------------------*
253400* INITIALIZE OUTPUT FIELDS THAT DON'T APPLY TO SUBCLAUSE II   *
253500*-------------------------------------------------------------*
253600*    INITIALIZE PPS-OUTLIER-PAY-AMT
253700*               PPS-DRG-ADJ-PAY-AMT
253800*               PPS-FED-PAY-AMT
253900*               PPS-FAC-COSTS
254000*               PPS-SUBM-DRG-CODE
254100*               PPS-NAT-LABOR-PCT
254200*               PPS-NAT-NONLABOR-PCT
254300*               PPS-STD-FED-RATE
254400*               PPS-BDGT-NEUT-RATE
254500*               PPS-IPTHRESH
254600*               PPS-SITE-NEUTRAL-COST-PMT
254700*               PPS-SITE-NEUTRAL-IPPS-PMT
254800*               PPS-STANDARD-FULL-PMT
254900*               PPS-STANDARD-SSO-PMT.
255000*
255100*
255200*7300-EXIT.
255300*     EXIT.
255400
255500
255600***************************************************************
255700*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
255800*   UNIQUE CALCULATION FOR EACH CLAIM PAYMENT TYPE COMBO      *
255900***************************************************************
256000 8000-CALC-FINAL-PMT.
256100***************************************************************
256200
256300
256400*-------------------------------------------------------------*
256500* SUBCLAUSE II CLAIMS                                         *
256600*   P-NEW-FAC-SPEC-RATE = PER DIEM PMT RATE FOR SUBCLAUSE II  *
256700*-------------------------------------------------------------*
256800*    IF SUBCLAUSEII-PROV
256900*       COMPUTE PPS-FINAL-PAY-AMT ROUNDED =
257000*               P-NEW-FAC-SPEC-RATE *
257100*               B-CST-RPT-DAYS
257200*       GO TO 8000-EXIT
257300*    END-IF.
257400
257500
257600*-------------------------------------------------------------*
257700* OLD POLICY CLAIMS (100% STANDARD PAYMENT)                   *
257800*-------------------------------------------------------------*
257900     IF PMT-STANDARD-OLD
258000        COMPUTE PPS-FINAL-PAY-AMT =
258100                PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
258200     END-IF.
258300
258400
258500*-------------------------------------------------------------*
258600* NEW POLICY CLAIMS (ANY PAYMENT TYPE)                        *
258700*     - ONLY APPLICABLE PAYMENT FIELDS CONTAIN VALUES > $0    *
258800*     - APPLY BUDGET NEUTRALITY AND/OR BLEND TO PAYMENT       *
258900*       IF NEEDED                                             *
259000*     - ANY APPLICABLE BUDGET NEUTRALITY AND/OR BLEND WAS     *
259100*       ALREADY APPLIED TO OUTLIER PAYMENT                    *
259200*-------------------------------------------------------------*
259300     IF NOT PMT-STANDARD-OLD
259400
259500*-------------------------------------------------------*
259600* APPLY BUDGET NEUTRALITY AND SITE-NEUTRAL IPPS ADJ.    *
259700* TO 100% SITE-NEUTRAL PAYMENTS                         *
259800*-------------------------------------------------------*
259900        IF PMT-SITE-NEUTRAL
260000           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
260100                   PPS-SITE-NEUTRAL-COST-PMT *
260200                   H-BDGT-NEUT-FACTOR
260300
260400           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
260500                   PPS-SITE-NEUTRAL-IPPS-PMT *
260600                   H-BDGT-NEUT-FACTOR *
260700                   H-SITE-NEUTRAL-IPPS-ADJ
260800
260900           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
261000                   PPS-OUTLIER-PAY-AMT *
261100                   H-SITE-NEUTRAL-IPPS-ADJ
261200        END-IF
261300
261400
261500*-------------------------------------------------------*
261600* APPLY BLEND PERCENTS, BUDGET NEUT, AND SITE-NEUTRAL   *
261700* IPPS ADJUSTMENT TO BLENDED PAYMENTS                   *
261800*-------------------------------------------------------*
261900        IF PMT-BLEND
262000           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
262100                   PPS-SITE-NEUTRAL-COST-PMT *
262200                   H-BDGT-NEUT-FACTOR *
262300                   H-BLEND-SNT
262400
262500           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
262600                   PPS-SITE-NEUTRAL-IPPS-PMT *
262700                   H-BDGT-NEUT-FACTOR *
262800                   H-SITE-NEUTRAL-IPPS-ADJ *
262900                   H-BLEND-SNT
263000
263100           COMPUTE PPS-STANDARD-FULL-PMT ROUNDED =
263200                   PPS-STANDARD-FULL-PMT * H-BLEND-STD
263300
263400           COMPUTE PPS-STANDARD-SSO-PMT ROUNDED =
263500                   PPS-STANDARD-SSO-PMT * H-BLEND-STD
263600        END-IF
263700
263800*-------------------------------------------------------*
263900* SUM PAYMENT FIELDS FOR FINAL PAYMENT                  *
264000*-------------------------------------------------------*
264100        COMPUTE PPS-FINAL-PAY-AMT =
264200                PPS-STANDARD-FULL-PMT +
264300                PPS-STANDARD-SSO-PMT +
264400                PPS-SITE-NEUTRAL-COST-PMT +
264500                PPS-SITE-NEUTRAL-IPPS-PMT +
264600                PPS-OUTLIER-PAY-AMT
264700
264800        MOVE PPS-FINAL-PAY-AMT TO H-PRE-DPP-PAY
264900
265000*-------------------------------------------------------------*
265100* IF THERE'S AN LTCH DPP PAYMENT ADJUSTMENT THEN              *
265200* CALCULATE THE 'LTCH DPP ADJUSTMENT AMOUNT' AND              *
265300* ADD IT TO THE FINAL PAYMENT                                 *
265400*-------------------------------------------------------------*
265500        IF B-LTCH-DPP-ADJUSTMENT
265600           PERFORM 3500-CALC-IPPS-LIKE-AMT
265700              THRU 3500-EXIT
265800           COMPUTE PPS-LTCH-DPP-ADJ-AMT =
265900               H-IPPS-LIKE-AMT - H-PRE-DPP-PAY
266000           COMPUTE PPS-FINAL-PAY-AMT =
266100               H-PRE-DPP-PAY + PPS-LTCH-DPP-ADJ-AMT
266200        END-IF
266300
266400     END-IF.
266500
266600
266700 8000-EXIT.
266800      EXIT.
266900
267000
267100***************************************************************
267200 9000-MOVE-RESULTS.
267300***************************************************************
267400
267500
267600*-------------------------------------------------------------*
267700* IF CLAIM PRICED, MOVE LENGTH OF STAY & VERSION TO OUTPUT    *
267800*-------------------------------------------------------------*
267900     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
268000        MOVE H-LOS TO PPS-LOS
268100        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
268200
268300*-------------------------------------------------------------*
268400* IF CLAIM DIDN'T PRICE DUE TO AN ERROR, INITIALIZE ALL       *
268500* OUTPUT DATA EXCEPT FOR PPS-RTC AND PPS-CHRG-THRESHOLD,      *
268600* INITIALIZE WORK VARIABLES, AND MOVE VERSION TO OUTPUT       *
268700*-------------------------------------------------------------*
268800     ELSE
268900       INITIALIZE PPS-DATA
269000       INITIALIZE PPS-OTHER-DATA
269100       INITIALIZE PPS-CBSA
269200       INITIALIZE HOLD-PPS-COMPONENTS
269300       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
269400     END-IF.
269500
269600
269700*
269800*  THE FOLLOWING LINES ARE USED FOR TESTING
269900*  THEY DISPLAY VALUES FOR CERTAIN PROVIDERS
270000*  THE DISPLAY STATEMENTS OUTPUT VALUES TO THE SYSOUTDEVICE
270100* - COMMENT THEM OUT WHEN NOT TESTING
270200*
270300*    IF (B-PROVIDER-NO = '502111'
270400*                    OR  '502112'
270500*                    OR  '502113'
270600*                    OR  '132114'
270700*                    OR  '052115'
270800*                    OR  '502116'
270900*                    OR  '502117'
271000*                    OR  '502118'
271100*                    OR  '362119'
271200*                    OR  '362110'
271300*                    OR  '45211A'
271400*                    OR  '39211B'
271500*                    OR  '39211C'
271600*                    OR  '31211D'
271700*                    OR  '31211E')
271800*
271900*
272000*    DISPLAY '---------------------------------------------'
272100*    DISPLAY '*********************************************'
272200*    DISPLAY '---------------------------------------------'
272300**MATCH THE TEST OUTPUT FROM THE LTCH PRICER TO THE
272400**OUTPUT OF THE TEST CASE SPREADSHEET FROM POLICY
272500*    DISPLAY 'B-PROVIDER-NO '            B-PROVIDER-NO
272600*    DISPLAY ' '
272700*    DISPLAY ' '
272800*    DISPLAY 'B-REVIEW-CODE '            B-REVIEW-CODE
272900*    DISPLAY 'P-NEW-FED-PPS-BLEND-IND '  P-NEW-FED-PPS-BLEND-IND
273000*    DISPLAY 'DPP ADJUSTMENT PSF FLAG '  B-LTCH-DPP-INDICATOR-SW
273100**PSYCH/REHAB DRG PRESENT
273200*    IF PSYCH-REHAB-DRG
273300*       MOVE 'YES' TO PSYCH-REHAB-DRG-PRESENT
273400*    ELSE MOVE 'NO' TO PSYCH-REHAB-DRG-PRESENT
273500*    END-IF
273600*    DISPLAY 'PSYCH-REHAB-DRG '          PSYCH-REHAB-DRG-PRESENT
273700**IPPS CLAIM PRESENT
273800*    DISPLAY 'IPPS_CLAIM_PRESENT ?'
273900*    DISPLAY 'WS-VENT-STATUS '           WS-VENT-STATUS
274000*    DISPLAY 'ICU/CCU_PRESENT ?'
274100*    DISPLAY 'WS-PRIMARY-PMT-TYPE '      WS-PRIMARY-PMT-TYPE
274200*    DISPLAY 'PPS-CBSA '                 PPS-CBSA
274300*    DISPLAY 'P-NEW-STATE-CODE-X '       P-NEW-STATE-CODE-X
274400**ON THE TEST CASE TEST SPREADSHEET THE VALUE TITLED
274500**"CBSA FOR IPPS WI" IS CBSA CONCATINATED WITH STATE ABBREVIATION
274600**BUT, FOLLOWING LINE INSTEAD DISPLAYS CBSA + STATE NUMERIC
274700**ABBREVIATION BECAUSE THE PRICER DOESN'T HAVE STATE ABBREVIATION
274800*    DISPLAY 'CBSA_FOR_IPPS_WI '      PPS-CBSA P-NEW-STATE-CODE-X
274900*    DISPLAY 'PPS-SUPP-WAGE-INDEX '      P-SUPP-WI
275000*    DISPLAY 'PPS-SUPP-WAGE-INDEX-FLAG ' P-SUPP-WI-IND
275100*    DISPLAY 'SPECIAL PAY INDICATOR '    P-NEW-SPECIAL-PAY-IND
275200*    DISPLAY 'SPECIAL WAGE INDEX '       P-NEW-SPECIAL-WAGE-INDEX
275300*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
275400*    DISPLAY 'PPS-WAGE-INDEX CAPPED ?'
275500*    DISPLAY 'PPS-WAGE-INDEX FINAL ???'  W-IPPS-WAGE-INDEX
275600*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
275700*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
275800*    DISPLAY 'H-ADMISSION-DATE '         H-ADMISSION-DATE
275900**CARES ACT FLAG ON TEST CASE SPREADSHEET
276000*    DISPLAY ' '
276100*    DISPLAY 'H-LOS '                    H-LOS
276200*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
276300*    DISPLAY 'P-NEW-OPER-CSTCHG-RATIO '  P-NEW-OPER-CSTCHG-RATIO
276400*    DISPLAY 'H-SS-COST '                H-SS-COST
276500*    DISPLAY 'H-FIXED-LOSS-AMT-STD '     H-FIXED-LOSS-AMT-STD
276600*    DISPLAY 'H-FIXED-LOSS-AMT-SNT '     H-FIXED-LOSS-AMT-SNT
276700*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE
276800*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
276900*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
277000*    DISPLAY 'H-SSOT '                   H-SSOT
277100*    DISPLAY 'P-NEW-HOSP-QUAL-IND '      P-NEW-HOSP-QUAL-IND
277200*    DISPLAY 'PPS-STD-FED-RATE '         PPS-STD-FED-RATE
277300*    DISPLAY 'PPS-NAT-LABOR-PCT '        PPS-NAT-LABOR-PCT
277400*    DISPLAY 'PPS-NAT-NONLABOR-PCT '     PPS-NAT-NONLABOR-PCT
277500***** WORK IN PROGRESS
277600*****COMPUTE H-LABOR-PORTION-TIMES-WIX =
277700*****          H-LABOR-PORTION *
277800*    DISPLAY 'H-LABOR-PORTION-UNADJUSTED ?'
277900***** WORK IN PROGESS
278000*****COMPUTE H-NONLABOR-PORTION-TIMES-WIX =
278100*****          H-NONLABOR-PORTION *
278200*    DISPLAY 'NONLABOR-PORTION-UNADJUSTED ?'
278300*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
278400*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
278500*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
278600*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
278700*    DISPLAY ' '
278800*    DISPLAY ' '
278900*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
279000*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
279100*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
279200*    DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
279300*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
279400*    DISPLAY 'W-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
279500*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
279600*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
279700*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
279800*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
279900*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
280000*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE
280100*    DISPLAY ' '
280200*    DISPLAY ' '
280300*    DISPLAY ' '
280400*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
280500*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
280600*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
280700*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
280800*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
280900*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
281000*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
281100*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
281200*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
281300*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
281400*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
281500*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
281600*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
281700*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
281800*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
281900*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
282000*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
282100*    DISPLAY 'H-OUTLIER-THRESHOLD-STD '  H-OUTLIER-THRESHOLD-STD
282200*    DISPLAY ' '
282300*    DISPLAY 'PPS-OUTLIER-PAY-AMT '
282400*    DISPLAY 'PPS-STANDARD-SSO-PMT '
282500*    DISPLAY 'H-BDGT-NEUT-FACTOR '       H-BDGT-NEUT-FACTOR
282600*    DISPLAY 'COST OPTION '
282700*    DISPLAY 'IPPS OPTION '
282800*    DISPLAY 'HCO OPTION '
282900*    DISPLAY ' '
283000*    DISPLAY 'OUTLIER PAYMENT '
283100*    DISPLAY ' '
283200*    DISPLAY ' '
283300*    DISPLAY 'WS-PAYMENT-TYPE '
283400*    DISPLAY 'SN OUTLIER PAYMENT '
283500*    DISPLAY 'PPS-SITE-NEUTRAL-COST-PMT '
283600*    DISPLAY ' '
283700*    DISPLAY 'PRE-DPP PAY           '    H-PRE-DPP-PAY
283800*    DISPLAY ' '
283900*    DISPLAY 'DPP BASE PAY          '    H-IPPS-PAY-AMT
284000*    DISPLAY 'DPP OUTLIER THRESHOLD '    PPS-OUTLIER-THRESHOLD
284100*    DISPLAY 'DPP OUTLIER FLAG ?    '
284200*    DISPLAY 'DPP OUTLIER PAY       '    H-IPPS-LIKE-AMT-OUTLIER
284300*    DISPLAY 'DPP TOTAL             '    H-IPPS-LIKE-AMT
284400*    DISPLAY 'LTCH DPP ADJUSTMENT   '    PPS-LTCH-DPP-ADJ-AMT
284500*    DISPLAY ' '
284600*    DISPLAY 'PPS-RTC               '    PPS-RTC
284700*    DISPLAY 'PPS-FINAL-PAY-AMT     '    PPS-FINAL-PAY-AMT
284800***END OF ENTERING NEW DISPLAY ORDER FOR TEST CASE COMPARISON
284900*
285000*
285100***BEGIN OF OTHER VARIABLES FOR TESTING
285200*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
285300*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
285400*    DISPLAY 'H-OPER-IME-RATIO '         H-CAPI-IME-RATIO
285500*    DISPLAY 'B-PROCEDURE-CODE-TABLE '   B-PROCEDURE-CODE-TABLE
285600*    DISPLAY 'PPS-SITE-NEUTRAL-COST-PM ' PPS-SITE-NEUTRAL-COST-PMT
285700*    DISPLAY 'PPS-SITE-NEUTRAL-IPPS-PM ' PPS-SITE-NEUTRAL-IPPS-PMT
285800*    DISPLAY 'PPS-STANDARD-FULL-PMT '    PPS-STANDARD-FULL-PMT
285900*    DISPLAY 'PPS-STANDARD-SSO-PMT '     PPS-STANDARD-SSO-PMT
286000*    DISPLAY 'PPS-FAC-COSTS '            PPS-FAC-COSTS
286100*    DISPLAY 'PPS-CHRG-THRESHOLD '       PPS-CHRG-THRESHOLD
286200*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
286300*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
286400*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
286500*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS
286600*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
286700*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
286800*    DISPLAY 'H-BLEND-SNT '              H-BLEND-SNT
286900*    DISPLAY 'H-BLEND-STD '              H-BLEND-STD
287000*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
287100*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
287200*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
287300*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
287400*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
287500*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
287600*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
287700*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
287800*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
287900*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
288000*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND
288100*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
288200*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
288300*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
288400*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
288500*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
288600*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
288700*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
288800*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
288900*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
289000*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
289100*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
289200*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
289300*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
289400*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
289500*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
289600*
289700*    END-IF.
289800
289900 9000-EXIT.
290000      EXIT.
290100
290200******        L A S T   S O U R C E   S T A T E M E N T   *****
