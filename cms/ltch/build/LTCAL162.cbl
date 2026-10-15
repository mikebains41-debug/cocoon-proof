000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL162.
000300*AUTHOR.         CMS.
000400*REMARKS.        EFFECTIVE APRIL 1, 2016.
000500***********************************************************
000600*
000700*JANUARY 28, 2016 - CALCULATION MODULE UPDATED DUE TO
000800* CR 9527 AND CR 9300.
000900*
001000*(CR 9527) THIS NEW 2016 LTCH PRICER FOR THE
001100* APRIL 2016 RELEASE IS DUE TO THE PASSING OF H.R.2029 -
001200* CONSOLIDATED APPROPRIATIONS ACT, 2016 ON 12/18/15
001300* (SEC. 601 MODIFICATION OF MEDICARE INPATIENT HOSPITAL PAYMENT
001400* RATE FOR PUERTO RICO HOSPITALS.)
001500*
001600* UPDATED FY16 LTCH PRICER SPECS BASED ON THE IPPS RATE CHANGES
001700* DUE TO THE IPPS PUERTO RICO HOSPITAL PAYMENT RATE CHANGE.
001800* THE IPPS RATES USED IN THE LTCH PRICER ARE UPDATED EFFECTIVE
001900* 1/1/2016, ALONG WITH THE IPPS OPERATING PAYMENT CALCULATION
002000* FOR PUERTO RICO HOSPITALS.
002100*
002200* THE UPDATES MADE ARE AS FOLLOWS:
002300*
002400* - HIGH COST OUTLIER FIXED-LOSS AMOUNTS
002500*   - SITE NEUTRAL RATE CASES:
002600*     - FOR DISCHARGES FROM 10/1/2015 - 12/31/2015: $22,539
002700*     - FOR DISCHARGES FROM 1/1/2016 - 9/30/2016: $22,538
002800*
002900* - SSO AND SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS:
003000*   - DISCHARGES FROM 10/1/2015 - 12/31/2015
003100*     - NO UPDATES
003200*   - DISCHARGES FROM 1/1/2016 - 9/30/2016
003300*     - IPPS LABOR SHARE WAGE INDEX > 1: $3,805.40
003400*     - IPPS NONLABOR SHARE WAGE INDEX > 1: $1,662.13
003500*     - IPPS LABOR SHARE WAGE INDEX < /= 1: $3,389.87
003600*     - IPPS NONLABOR SHARE WAGE INDEX < /= 1: $2,077.66
003700*     - PUERTO RICO LABOR SHARE WAGE INDEX > 1: N/A
003800*     - PUERTO RICO NONLABOR SHARE WAGE INDEX > 1: N/A
003900*
004000* - LOGIC CHANGE FOR IPPS COMPARABLE AMOUNT CALCULATION
004100*   (USED FOR SSO AND SITE NEUTRAL RATE PAYMENTS) FOR PUERTO
004200*   RICO HOSPITALS
004300*     - PUERTO RICO BLEND PERCENTAGES FOR OPERATING IPPS
004400*       PAYMENTS CHANGING FROM 75% NATIONAL/25% PUERTO RICO
004500*       TO 100 NATIONAL/0% PUERTO RICO FOR DISCHARGES
004600*       ON OR AFTER JANUARY 1, 2016.
004700*     - PUERTO RICO BLEND PERCENTAGES FOR CAPITAL IPPS
004800*       PAYMENTS REMAIN 75% NATIONAL/25% PUERTO RICO FOR
004900*       DISCHARGES ON/AFTER JANUARY 1, 2016 THROUGH
005000*       SEPTEMBER 30, 2016.
005100*
005200*(CR 9300) ADDED STATE CODE 84 FOR PUERTO RICO
005300*
005400**************************************************
005500 ENVIRONMENT DIVISION.
005600 CONFIGURATION SECTION.
005700 SOURCE-COMPUTER.            IBM-370.
005800 OBJECT-COMPUTER.            IBM-370.
005900 INPUT-OUTPUT  SECTION.
006000 FILE-CONTROL.
006100
006200 DATA DIVISION.
006300 FILE SECTION.
006400
006500 WORKING-STORAGE SECTION.
006600 01  W-STORAGE-REF                  PIC X(46)  VALUE
006700     'LTCAL162      - W O R K I N G   S T O R A G E'.
006800 01  CAL-VERSION                    PIC X(05)  VALUE 'V16.2'.
006900 01  PROGRAM-CONSTANTS.
007000     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
007100     05  VENT-ICD-10-CODE           PIC X(07) VALUE '5A1955Z'.
007200 01  PROGRAM-FLAGS.
007300     05  WS-PRIMARY-PMT-TYPE        PIC X(01).
007400         88 PMT-STANDARD-OLD       VALUE '1'.
007500         88 PMT-STANDARD-NEW       VALUE '2'.
007600         88 PMT-SITE-NEUTRAL       VALUE '3'.
007700         88 PMT-BLEND              VALUE '4'.
007800     05  WS-SECONDARY-PMT-TYPE-SNT  PIC X(01).
007900         88 PMT-SITE-NEUT-COST     VALUE '1'.
008000         88 PMT-SITE-NEUT-IPPS     VALUE '2'.
008100     05  WS-SECONDARY-PMT-TYPE-STD  PIC X(01).
008200         88 PMT-STANDARD-FULL      VALUE '1'.
008300         88 PMT-STANDARD-SSO       VALUE '2'.
008400     05  WS-VENT-STATUS             PIC X(01).
008500         88 VENT-PRESENT           VALUE 'Y'.
008600         88 VENT-NOT-PRESENT       VALUE 'N'.
008700
008800
008900***************************************************************
009000*    LAYUP TABLE AREA FOR FY2015 LTC-DRG                      *
009100*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
009200***************************************************************
009300 COPY LTDRG160.
009400
009500
009600***************************************************************
009700*    LAYUP TABLE AREA FOR FY2015 IPPS-DRG                     *
009800*    EFFECTIVE DATE OF OCTOBER 1, 2014                        *
009900***************************************************************
010000 COPY IPDRG160.
010100
010200
010300***************************************************************
010400*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
010500***************************************************************
010600 01  HOLD-PPS-COMPONENTS.
010700     05  H-LOS                        PIC 9(03).
010800     05  H-REG-DAYS                   PIC 9(03).
010900     05  H-TOTAL-DAYS                 PIC 9(05).
011000     05  H-SSOT                       PIC 9(02)V9(01).
011100     05  H-BLEND-RTC                  PIC 9(02).
011200     05  H-BLEND-SNT                  PIC 9(01)V9(01).
011300     05  H-BLEND-STD                  PIC 9(01)V9(01).
011400     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
011500     05  H-SS-COST                    PIC 9(07)V9(02).
011600     05  H-LABOR-PORTION              PIC 9(07)V9(06).
011700     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
011800     05  H-FIXED-LOSS-AMT-STD         PIC 9(07)V9(02).
011900     05  H-FIXED-LOSS-AMT-SNT         PIC 9(07)V9(02).
012000     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
012100     05  H-LOS-RATIO                  PIC 9(01)V9(05).
012200
012300*** --------------------------------------------------- ***
012400*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
012500*** --------------------------------------------------- ***
012600     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
012700     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
012800     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
012900     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
013000     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
013100     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
013200     05  H-INTERN-RATIO               PIC 9(01)V9(04).
013300     05  H-CAPI-IME-RATIO             PIC 9V9999.
013400     05  H-BED-SIZE                   PIC 9(05).
013500     05  H-OPER-DSH-PCT               PIC V9(04).
013600     05  H-SSI-RATIO                  PIC V9(04).
013700     05  H-MEDICAID-RATIO             PIC V9(04).
013800     05  H-OPER-DSH                   PIC 9(01)V9(04).
013900     05  H-CAPI-DSH                   PIC 9(01)V9(04).
014000     05  H-GEO-CLASS                  PIC X(01).
014100     05  H-URBAN-IND                  PIC X(01).
014200           88 URBAN-CBSA           VALUE '1'.
014300           88 RURAL-CBSA           VALUE '0'.
014400     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
014500     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
014600     05  H-CAPI-PMT                   PIC 9(07)V9(02).
014700     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
014800     05  H-CAPI-GAF                   PIC 9(05)V9(04).
014900     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
015000     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
015100     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
015200     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
015300     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
015400     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
015500     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
015600     05  H-OPER-COLA                  PIC 9(01)V9(03).
015700     05  H-CAPI-COLA                  PIC 9(01)V9(03).
015800     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
015900     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
016000     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
016100     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
016200     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
016300     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
016400     05  H-IPPS-DAYS-CUTOFF           PIC 9(02)V9(01).
016500     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
016600     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
016700     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
016800*    05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
016900*    05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
017000     05  H-NAT-OPER-IPPS-PMT-PCT      PIC 9(01)V9(02).
017100     05  H-PR-OPER-IPPS-PMT-PCT       PIC 9(01)V9(02).
017200     05  H-NAT-CAPI-IPPS-PMT-PCT      PIC 9(01)V9(02).
017300     05  H-PR-CAPI-IPPS-PMT-PCT       PIC 9(01)V9(02).
017400     05  H-COUNTER                    PIC 9(02).
017500     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).
017600     05  H-OPER-DSH-REDUCTION-FACTOR  PIC V9(04).
017700     05  H-OUTLIER-THRESHOLD-STD      PIC 9(07)V9(02).
017800     05  H-BDGT-NEUT-FACTOR           PIC 9(01)V9(06).
017900     05  H-OUTLIER-PAY-AMT-STD        PIC 9(07)V9(02).
018000     05  H-OUTLIER-PAY-AMT-SNT        PIC 9(07)V9(02).
018100
018200*** --------------------------------------------------- ***
018300*** VARIABLES FOR PC PRICER                             ***
018400*** --------------------------------------------------- ***
018500     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
018600     05  H-SS-COST-IND                PIC X.
018700     05  H-SS-PERDIEM-IND             PIC X.
018800     05  H-SS-BLEND-IND               PIC X.
018900     05  H-SS-IPPSCOMP-IND            PIC X.
019000
019100
019200*---------------------------------------------------------*
019300* 8-6-14 ADDED WK-HLDDRG-DATA AND WK-HLDDRG-DATA2 TO      *
019400* MATCH THE IPPS DRG TABLE DATA NAMES THAT WERE COPIED    *
019500* FROM THE FY14 IPPS PRICER CALCULATION PROGRAM           *
019600*---------------------------------------------------------*
019700
019800 01 WK-HLDDRG-DATA.
019900     05  HLDDRG-DATA.
020000         10  HLDDRG-DRGX               PIC X(03).
020100         10  FILLER1                   PIC X(01).
020200         10  HLDDRG-WEIGHT             PIC 9(02)V9(04).
020300         10  FILLER2                   PIC X(01).
020400         10  HLDDRG-GMALOS             PIC 9(02)V9(01).
020500         10  FILLER3                   PIC X(05).
020600         10  HLDDRG-LOW                PIC X(01).
020700         10  FILLER5                   PIC X(01).
020800         10  HLDDRG-ARITH-ALOS         PIC 9(02)V9(01).
020900         10  FILLER6                   PIC X(02).
021000         10  HLDDRG-PAC                PIC X(01).
021100         10  FILLER7                   PIC X(01).
021200         10  HLDDRG-SPPAC              PIC X(01).
021300         10  FILLER8                   PIC X(02).
021400         10  HLDDRG-DESC               PIC X(26).
021500
021600 01 WK-HLDDRG-DATA2.
021700     05  HLDDRG-DATA2.
021800         10  HLDDRG-DRGX2               PIC X(03).
021900         10  FILLER21                   PIC X(01).
022000         10  HLDDRG-WEIGHT2             PIC 9(02)V9(04).
022100         10  FILLER22                   PIC X(01).
022200         10  HLDDRG-GMALOS2             PIC 9(02)V9(01).
022300         10  FILLER23                   PIC X(05).
022400         10  HLDDRG-LOW2                PIC X(01).
022500         10  FILLER25                   PIC X(01).
022600         10  HLDDRG-ARITH-ALOS2         PIC 9(02)V9(01).
022700         10  FILLER26                   PIC X(02).
022800         10  HLDDRG-TRANS-FLAGS.
022900                   88  D-DRG-POSTACUTE-50-50
023000                   VALUE 'Y Y'.
023100                   88  D-DRG-POSTACUTE-PERDIEM
023200                   VALUE 'Y  '.
023300             15  HLDDRG-PAC2            PIC X(01).
023400             15  FILLER27               PIC X(01).
023500             15  HLDDRG-SPPAC2          PIC X(01).
023600         10  FILLER28                   PIC X(02).
023700         10  HLDDRG-DESC2               PIC X(26).
023800         10  HLDDRG-VALID               PIC X(01).
023900
024000
024100
024200
024300
024400 LINKAGE SECTION.
024500
024600**************************************************************
024700* THE LINKAGE SECTION CONTAINS DESCRIPTIONS OF THE FIELDS THAT
024800* CONTAIN VALUES THAT ARE PASSED FROM THE CALLING PROGRAM
024900* (LTDRV... IN THIS CASE)
025000**************************************************************
025100
025200
025300**************************************************************
025400* BILL-NEW-DATA IS THE BILL RECORD FROM THE LTDRV... PROGRAM
025500**************************************************************
025600 01  BILL-NEW-DATA.
025700     10  B-NPI10.
025800         15  B-NPI8               PIC X(08).
025900         15  B-NPI-FILLER         PIC X(02).
026000     10  B-PROVIDER-NO            PIC X(06).
026100     10  B-PATIENT-STATUS         PIC X(02).
026200     10  B-DRG-CODE               PIC 9(03).
026300     10  B-LOS                    PIC 9(03).
026400     10  B-COV-DAYS               PIC 9(03).
026500     10  B-LTR-DAYS               PIC 9(02).
026600     10  B-CST-RPT-DAYS           PIC 9(03).
026700     10  B-DISCHARGE-DATE.
026800         15  B-DISCHG-CC          PIC 9(02).
026900         15  B-DISCHG-YY          PIC 9(02).
027000         15  B-DISCHG-MM          PIC 9(02).
027100         15  B-DISCHG-DD          PIC 9(02).
027200     10  B-COV-CHARGES            PIC 9(07)V9(02).
027300     10  B-SPEC-PAY-IND           PIC X(01).
027400     05  B-REVIEW-CODE            PIC 9(02).
027500     05  B-DIAGNOSIS-CODE-TABLE.
027600         10  B-DIAGNOSIS-CODE     PIC X(07) OCCURS 25 TIMES
027700                                  INDEXED BY IDX-DIAG.
027800     05  B-PROCEDURE-CODE-TABLE.
027900         10  B-PROCEDURE-CODE     PIC X(07) OCCURS 25 TIMES
028000                                  INDEXED BY IDX-PROC.
028100     05  FILLER                   PIC X(20).
028200
028300
028400***************************************************************
028500***************************************************************
028600*                                                             *
028700*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *
028800*    AND PASSED BACK TO THE CALLING PROGRAM (LTDRV)           *
028900*    RETURN CODE VALUES (PPS-RTC)                             *
029000*                                                             *
029100*     ** OLD POLICY RETURN CODE VALUES AND DESCRIPTIONS       *
029200*     ** ----------------------------------------------       *
029300*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
029400*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
029500*                                                             *
029600*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
029700*                                                             *
029800*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
029900*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
030000*                                                             *
030100*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
030200*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
030300*                                                             *
030400*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
030500*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
030600*                                                             *
030700*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
030800*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
030900*                                                             *
031000*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031100*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
031200*                                                             *
031300*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031400*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
031500*                                                             *
031600*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031700*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
031800*                                                             *
031900*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
032000*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
032100*                                                             *
032200*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
032300*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
032400*                                                             *
032500*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
032600*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
032700*                                                             *
032800*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
032900*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
033000*                                                             *
033100*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
033200*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
033300*                                                             *
033400*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
033500*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
033600*                                                             *
033700*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
033800*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
033900*                                                             *
034000*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
034100*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
034200*                                                             *
034300*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
034400*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
034500*                                                             *
034600*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
034700*                  WITHOUT OUTLIER                            *
034800*                                                             *
034900*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
035000*                  DIEM WITHOUT OUTLIER                       *
035100*                                                             *
035200*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
035300*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
035400*                  AMOUNT WITHOUT OUTLIER                     *
035500*                                                             *
035600*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
035700*                  DIEM WITH OUTLIER                          *
035800*                                                             *
035900*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
036000*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
036100*                  AMOUNT WITH OUTLIER                        *
036200*                                                             *
036300*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *
036400*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *
036500*            FOR IPPS COMPARABLE PER DIEM)                    *
036600*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *
036700*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *
036800*            FOR IPPS COMPARABLE PER DIEM)                    *
036900*                                                             *
037000*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
037100*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
037200*                                                             *
037300*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
037400*                  COMPARABLE THRESHOLD WITH OUTLIER          *
037500*                                                             *
037600*             28 = SUBCLAUSE (II) DOES NOT QUALIFY FOR AN     *
037700*                  OUTLIER                                    *
037800*                                                             *
037900*             29 = SUBCLAUSE (II) QUALIFIES FOR AN OUTLIER    *
038000*                                                             *
038100*                                                             *
038200*     ** OLD & NEW POLICY ERROR CODE VALUES AND DESCRIPTIONS  *
038300*     ** ---------------------------------------------------  *
038400*     *****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
038500*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
038600*             51 = PROVIDER RECORD TERMINATED                 *
038700*             52 = INVALID WAGE INDEX                         *
038800*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
038900*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
039000*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
039100*                                     OR                      *
039200*                  DISCHARGE DATE < CBSA EFF START DATE       *
039300*                  FOR PPS                                    *
039400*             56 = INVALID LENGTH OF STAY                     *
039500*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
039600*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
039700*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
039800*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
039900*                  OR BILL-LTR-DAYS > 60                      *
040000*             62 = INVALID NUMBER OF COVERED DAYS             *
040100*                  OR BILL-LTR-DAYS > COVERED DAYS            *
040200*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
040300*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
040400*                  OR COST OUTLIER THRESHOLD CALCULATION      *
040500*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *
040600*             72 = INVALID BLEND INDICATOR OR REVIEW CODE     *
040700*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
040800*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
040900*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *
041000*                                                             *
041100***************************************************************
041200***************************************************************
041300
041400
041500***************************************************************
041600* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
041700* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
041800***************************************************************
041900 01  PPS-DATA-ALL.
042000     05  PPS-RTC.
042100           88  OLD-ERROR-CODE        VALUE '50' THRU '99'.
042200         10  PPS-RTC-1                 PIC X.
042300               88  NEW-ERROR-CODE    VALUE 'D'.
042400         10  PPS-RTC-2                 PIC X.
042500     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
042600     05  PPS-DATA.
042700         10  PPS-MSA                   PIC X(04).
042800         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
042900         10  PPS-AVG-LOS               PIC 9(02)V9(01).
043000         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
043100         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
043200         10  PPS-LOS                   PIC 9(03).
043300         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
043400         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
043500         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
043600         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
043700         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
043800         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
043900         10  PPS-SUBM-DRG-CODE         PIC X(03).
044000               88  PSYCH-REHAB-DRG   VALUE
044100                   '876' '880' '881' '882' '883' '884'
044200                   '885' '887' '886' '894' '895' '896'
044300                   '897' '945' '946'.
044400         10  PPS-CALC-VERS-CD          PIC X(05).
044500         10  PPS-REG-DAYS-USED         PIC 9(03).
044600         10  PPS-LTR-DAYS-USED         PIC 9(03).
044700         10  PPS-BLEND-YEAR            PIC 9(01).
044800         10  PPS-COLA                  PIC 9(01)V9(03).
044900         10  FILLER                    PIC X(04).
045000     05  PPS-OTHER-DATA.
045100         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
045200         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
045300         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
045400         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
045500         10  PPS-IPTHRESH              PIC 9(03)V9(01).
045600         10  FILLER                    PIC X(16).
045700     05  PPS-PC-DATA.
045800         10  PPS-COT-IND               PIC X(01).
045900         10  H-PC-IND                  PIC X(02).
046000               88  PC-PRICER               VALUE 'PC'.
046100         10  FILLER                    PIC X(18).
046200
046300 01  PPS-CBSA                          PIC X(05).
046400
046500
046600 01  PPS-PAYMENT-DATA.
046700     05  PPS-SITE-NEUTRAL-COST-PMT     PIC 9(07)V99.
046800     05  PPS-SITE-NEUTRAL-IPPS-PMT     PIC 9(07)V99.
046900     05  PPS-STANDARD-FULL-PMT         PIC 9(07)V99.
047000     05  PPS-STANDARD-SSO-PMT          PIC 9(07)V99.
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
048700* PROV-NEW-HOLD IS THE PROVIDER RECORD THAT IS PASSED FROM   *
048800* LTDRV___) TO LTCAL___                                      *
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
062700                           PPS-PAYMENT-DATA
062800                           PRICER-OPT-VERS-SW
062900                           PROV-NEW-HOLD
063000                           WAGE-NEW-INDEX-RECORD
063100                           WAGE-NEW-IPPS-INDEX-RECORD.
063200
063300
063400***************************************************************
063500*                                                             *
063600*    PROCESSING:                                              *
063700*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
063800*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
063900*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
064000*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
064100*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
064200*           GOBACK.                                           *
064300*        D. ASSEMBLE PRICING COMPONENTS.                      *
064400*        E. CALCULATE THE PRICE.                              *
064500*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
064600*                                                             *
064700***************************************************************
064800
064900
065000***************************************************************
065100 0000-MAINLINE-CONTROL.
065200***************************************************************
065300
065400     PERFORM 0100-INITIAL-ROUTINE
065500        THRU 0100-EXIT.
065600
065700     PERFORM 1000-EDIT-INPUT-DATA
065800        THRU 1000-EXIT.
065900
066000     IF PPS-RTC = '00'
066100        PERFORM 1700-EDIT-DRG-CODE
066200           THRU 1700-EXIT.
066300
066400     IF PPS-RTC = '00'
066500        PERFORM 1800-EDIT-IPPS-DRG-CODE
066600           THRU 1800-EXIT.
066700
066800     IF PPS-RTC = '00'
066900        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
067000           THRU 2000-EXIT.
067100
067200     IF PPS-RTC = '00'
067300        PERFORM 3000-CALC-PAYMENT
067400           THRU 3000-EXIT.
067500
067600     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
067700        PERFORM 6000-CALC-HIGH-COST-OUTLIER
067800           THRU 6000-EXIT.
067900
068000     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
068100        PERFORM 7000-SET-FINAL-RETURN-CODES
068200           THRU 7000-EXIT.
068300
068400     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
068500        PERFORM 8000-CALC-FINAL-PMT
068600           THRU 8000-EXIT.
068700
068800     PERFORM 9000-MOVE-RESULTS
068900        THRU 9000-EXIT.
069000
069100     GOBACK.
069200
069300
069400***************************************************************
069500 0100-INITIAL-ROUTINE.
069600***************************************************************
069700
069800     MOVE '00' TO PPS-RTC.
069900     INITIALIZE PPS-DATA.
070000     INITIALIZE PPS-OTHER-DATA.
070100     INITIALIZE PPS-CBSA.
070200     INITIALIZE PPS-PAYMENT-DATA.
070300     INITIALIZE HOLD-PPS-COMPONENTS.
070400     INITIALIZE PROGRAM-FLAGS.
070500     INITIALIZE WK-HLDDRG-DATA
070600                WK-HLDDRG-DATA2.
070700
070800     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.
070900
071000
071100*** ---------------------------------------------------- ***
071200*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***
071300*** ---------------------------------------------------- ***
071400     MOVE .620 TO PPS-NAT-LABOR-PCT.
071500     MOVE .380 TO PPS-NAT-NONLABOR-PCT.
071600
071700*** --------------------------------------------------------
071800*** NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
071900*** REPORTING OF QUALITY DATA.
072000*** - FULL UPDATE (QUALITY INDICATOR ON PSF = 1)
072100*** - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK)
072200*** --------------------------------------------------------
072300     IF P-NEW-HOSP-QUAL-IND = '1'
072400        MOVE 41762.85 TO PPS-STD-FED-RATE
072500     ELSE
072600        MOVE 40941.55 TO PPS-STD-FED-RATE.
072700     MOVE 16423.00 TO H-FIXED-LOSS-AMT-STD.
072800     IF B-DISCHARGE-DATE < 20160101
072900        MOVE 22539.00 TO H-FIXED-LOSS-AMT-SNT
073000     ELSE
073100        MOVE 22538.00 TO H-FIXED-LOSS-AMT-SNT
073200     END-IF.
073300     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.
073400
073500*** ---------------------------------------------------- ***
073600*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
073700*** ---------------------------------------------------- ***
073800     IF B-DISCHARGE-DATE < 20160101
073900        MOVE 438.75 TO H-IPPS-CAPI-STD-FED-RATE
074000        MOVE 212.55 TO H-IPPS-CAPI-STD-PR-RATE
074100     ELSE
074200        MOVE 438.75 TO H-IPPS-CAPI-STD-FED-RATE
074300        MOVE 212.29 TO H-IPPS-CAPI-STD-PR-RATE
074400     END-IF.
074500
074600     IF B-DISCHARGE-DATE < 20160101
074700        MOVE 0.75 TO H-NAT-OPER-IPPS-PMT-PCT
074800        MOVE 0.25 TO H-PR-OPER-IPPS-PMT-PCT
074900        MOVE 0.75 TO H-NAT-CAPI-IPPS-PMT-PCT
075000        MOVE 0.25 TO H-PR-CAPI-IPPS-PMT-PCT
075100     ELSE
075200        MOVE 1.00 TO H-NAT-OPER-IPPS-PMT-PCT
075300        MOVE 0.00 TO H-PR-OPER-IPPS-PMT-PCT
075400        MOVE 0.75 TO H-NAT-CAPI-IPPS-PMT-PCT
075500        MOVE 0.25 TO H-PR-CAPI-IPPS-PMT-PCT
075600     END-IF.
075700
075800     MOVE W-IPPS-WAGE-INDEX TO H-IPPS-WAGE-INDEX.
075900
076000     IF H-IPPS-WAGE-INDEX > 1
076100        IF B-DISCHARGE-DATE < 20160101
076200           MOVE 3805.30 TO H-IPPS-NAT-LABOR-SHR
076300           MOVE 1662.09 TO H-IPPS-NAT-NONLABOR-SHR
076400        ELSE
076500           MOVE 3805.40 TO H-IPPS-NAT-LABOR-SHR
076600           MOVE 1662.13 TO H-IPPS-NAT-NONLABOR-SHR
076700        END-IF
076800     ELSE
076900        IF B-DISCHARGE-DATE < 20160101
077000           MOVE 3389.78 TO H-IPPS-NAT-LABOR-SHR
077100           MOVE 2077.61 TO H-IPPS-NAT-NONLABOR-SHR
077200        ELSE
077300           MOVE 3389.87 TO H-IPPS-NAT-LABOR-SHR
077400           MOVE 2077.66 TO H-IPPS-NAT-NONLABOR-SHR
077500        END-IF
077600     END-IF.
077700
077800
077900     IF W-IPPS-PR-WAGE-INDEX > 1
078000        IF B-DISCHARGE-DATE < 20160101
078100           MOVE 1650.00 TO H-IPPS-PR-LABOR-SHR
078200           MOVE  960.77 TO H-IPPS-PR-NONLABOR-SHR
078300        END-IF
078400     ELSE
078500        IF B-DISCHARGE-DATE < 20160101
078600           MOVE 1618.68 TO H-IPPS-PR-LABOR-SHR
078700           MOVE  992.09 TO H-IPPS-PR-NONLABOR-SHR
078800        END-IF
078900     END-IF.
079000
079100*** ---------------------------------------------------- ***
079200*** OPERATING DSH REDUCTION FACTOR                       ***
079300*** -----------------------------------------------------***
079400     MOVE 0.7277 TO H-OPER-DSH-REDUCTION-FACTOR.
079500
079600 0100-EXIT.
079700      EXIT.
079800
079900
080000***************************************************************
080100*    INPUT DATA EDITS - IF ANY FAIL SET PPS-RTC               *
080200*    AND DO NOT ATTEMPT TO PRICE.                             *
080300***************************************************************
080400 1000-EDIT-INPUT-DATA.
080500***************************************************************
080600
080700*** -----------------------------------------------------------
080800*** EDIT BILL (BILL-NEW-DATA) INPUT & SET ERROR CODE IF FAIL
080900*** -----------------------------------------------------------
081000     IF (B-LOS NUMERIC) AND (B-LOS > 0)
081100        MOVE B-LOS TO H-LOS
081200     ELSE
081300        MOVE '56' TO PPS-RTC.
081400
081500     IF PPS-RTC = '00'
081600        IF P-NEW-COLA NOT NUMERIC
081700           MOVE '50' TO PPS-RTC.
081800
081900     IF PPS-RTC = '00'
082000        IF P-NEW-WAIVER-STATE
082100           MOVE '53' TO PPS-RTC.
082200
082300     IF PPS-RTC = '00'
082400        IF B-DRG-CODE NOT NUMERIC
082500           MOVE '54' TO PPS-RTC.
082600
082700     IF PPS-RTC = '00'
082800        IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
082900           (B-DISCHARGE-DATE < W-EFF-DATE))
083000            MOVE '55' TO PPS-RTC.
083100
083200     IF PPS-RTC = '00'
083300        IF P-NEW-TERMINATION-DATE > 00000000
083400           IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
083500              MOVE '51' TO PPS-RTC.
083600
083700     IF PPS-RTC = '00'
083800        IF B-COV-CHARGES NOT NUMERIC
083900           MOVE '58' TO PPS-RTC.
084000
084100     IF PPS-RTC = '00'
084200        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
084300           MOVE '61' TO PPS-RTC.
084400
084500     IF PPS-RTC = '00'
084600        IF (B-COV-DAYS NOT NUMERIC) OR
084700           (B-COV-DAYS = 0 AND H-LOS > 0)
084800           MOVE '62' TO PPS-RTC.
084900
085000     IF PPS-RTC = '00'
085100        IF B-LTR-DAYS > B-COV-DAYS
085200           MOVE '62' TO PPS-RTC.
085300
085400     IF PPS-RTC = '00'
085500        IF (B-REVIEW-CODE < 00 OR B-REVIEW-CODE > 08) OR
085600           (B-REVIEW-CODE NOT NUMERIC)
085700           MOVE '72' TO PPS-RTC.
085800
085900
086000*** -----------------------------------------------------------
086100*** CALCULATE DAY RELATED VARIABLE VALUES
086200*** -----------------------------------------------------------
086300     IF PPS-RTC = '00'
086400        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
086500        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
086600
086700     IF PPS-RTC = '00'
086800        PERFORM 1200-DAYS-USED
086900           THRU 1200-DAYS-USED-EXIT.
087000
087100
087200*** -----------------------------------------------------------
087300*** EDIT PSF FIELDS USED BY ALL CLAIMS & SET ERROR CODE IF FAIL
087400*** -----------------------------------------------------------
087500
087600*-------------------------------------------------------------*
087700* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
087800* (ALWAYS FED-FY-BEGIN-03)                                    *
087900*-------------------------------------------------------------*
088000     IF PPS-RTC = '00'
088100        IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
088200           MOVE '74' TO PPS-RTC.
088300
088400*-------------------------------------------------------------*
088500* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
088600*-------------------------------------------------------------*
088700     IF PPS-RTC = '00'
088800        IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
088900           MOVE '65' TO PPS-RTC.
089000
089100
089200*** -----------------------------------------------------------
089300*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
089400*** -----------------------------------------------------------
089500     IF PPS-RTC = '00'
089600        IF P-NEW-CAPI-IME NUMERIC
089700           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
089800        ELSE
089900           MOVE ZEROS TO H-CAPI-IME-RATIO
090000        END-IF
090100     END-IF.
090200
090300     IF PPS-RTC = '00'
090400        IF P-NEW-INTERN-RATIO NUMERIC
090500           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
090600        ELSE
090700           MOVE ZEROS TO H-INTERN-RATIO
090800        END-IF
090900     END-IF.
091000
091100     IF PPS-RTC = '00'
091200        IF P-NEW-BED-SIZE NUMERIC
091300           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
091400        ELSE
091500           MOVE ZEROS TO H-BED-SIZE
091600        END-IF
091700     END-IF.
091800
091900     IF PPS-RTC = '00'
092000        IF P-NEW-SSI-RATIO NUMERIC
092100           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
092200        ELSE
092300           MOVE ZEROS TO H-SSI-RATIO
092400        END-IF
092500     END-IF.
092600
092700     IF PPS-RTC = '00'
092800        IF P-NEW-MEDICAID-RATIO NUMERIC
092900           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
093000        ELSE
093100           MOVE ZEROS TO H-MEDICAID-RATIO
093200        END-IF
093300     END-IF.
093400
093500
093600 1000-EXIT.
093700      EXIT.
093800
093900
094000***************************************************************
094100 1200-DAYS-USED.
094200***************************************************************
094300
094400     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
094500        IF B-LTR-DAYS > H-LOS
094600           MOVE H-LOS TO PPS-LTR-DAYS-USED
094700        ELSE
094800           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
094900     ELSE
095000        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
095100           IF H-REG-DAYS > H-LOS
095200              MOVE H-LOS TO PPS-REG-DAYS-USED
095300           ELSE
095400              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
095500        ELSE
095600           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
095700              IF H-REG-DAYS > H-LOS
095800                 MOVE H-LOS TO PPS-REG-DAYS-USED
095900                 MOVE 0 TO PPS-LTR-DAYS-USED
096000              ELSE
096100                 IF H-TOTAL-DAYS > H-LOS
096200                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
096300                    COMPUTE PPS-LTR-DAYS-USED =
096400                            H-LOS - H-REG-DAYS
096500                 ELSE
096600                    IF H-TOTAL-DAYS <= H-LOS
096700                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
096800                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
096900                    ELSE
097000                       NEXT SENTENCE
097100           ELSE
097200              NEXT SENTENCE.
097300
097400 1200-DAYS-USED-EXIT.
097500      EXIT.
097600
097700
097800***************************************************************
097900*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
098000***************************************************************
098100 1700-EDIT-DRG-CODE.
098200***************************************************************
098300
098400     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
098500     IF PPS-RTC = '00'
098600        SEARCH ALL WWM-ENTRY
098700           AT END
098800             MOVE '54' TO PPS-RTC
098900        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
099000             PERFORM 1750-FIND-VALUE
099100                THRU 1750-EXIT
099200        END-SEARCH.
099300
099400 1700-EXIT.
099500      EXIT.
099600
099700
099800***************************************************************
099900*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
100000***************************************************************
100100 1750-FIND-VALUE.
100200***************************************************************
100300
100400      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
100500      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
100600      MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
100700
100800 1750-EXIT.
100900      EXIT.
101000
101100
101200***************************************************************
101300*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
101400***************************************************************
101500 1800-EDIT-IPPS-DRG-CODE.
101600***************************************************************
101700
101800**-------------------------------------------------------**
101900** THIS LOGIC WAS COPIED FROM THE IPPS PRICER (PPCAL140) **
102000** ENSURE IT STAYS CONSISTENT BECAUSE IT REFERENCES THE  **
102100** DRG TABLE USED BY THE IPPS PRICER.                    **
102200**-------------------------------------------------------**
102300
102400     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE
102500     SET DRG-IDX TO 1
102600     SEARCH DRG-TAB VARYING DRG-IDX
102700         AT END
102800           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC
102900           MOVE 'I' TO  HLDDRG-VALID
103000           MOVE '54' TO PPS-RTC
103100           GO TO 1800-EXIT
103200       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE
103300         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.
103400
103500
103600     MOVE  HLDDRG-DATA         TO WK-HLDDRG-DATA2.
103700     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.
103800     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2
103900                                  H-IPPS-DRG-WGT.
104000     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2
104100                                  H-IPPS-DRG-ALOS.
104200     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.
104300     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2
104400                                  H-IPPS-ARITH-ALOS.
104500     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.
104600     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.
104700     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.
104800     MOVE  'V'                 TO HLDDRG-VALID.
104900     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.
105000
105100 1800-EXIT.
105200      EXIT.
105300
105400
105500***************************************************************
105600***  GET THE PROVIDER SPECIFIC VARIABLES AND LTCH WAGE INDEX  *
105700*                                                             *
105800*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
105900*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
106000*    OF THAT VARIABLE.                                        *
106100*                                                             *
106200***************************************************************
106300 2000-ASSEMBLE-PPS-VARIABLES.
106400***************************************************************
106500
106600
106700*-------------------------------------------------------------*
106800* ASSIGN FULL (5/5) LTCH WAGE INDEX TO ALL CLAIMS DISCHARGED  *
106900* ON AND AFTER 7/1/2008 (THIRD COLUMN WAGE INDEX IN LTWIX***) *
107000*-------------------------------------------------------------*
107100     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
107200        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
107300     ELSE
107400        MOVE '52' TO PPS-RTC
107500        GO TO 2000-EXIT
107600     END-IF.
107700
107800
107900*-------------------------------------------------------------*
108000* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
108100*-------------------------------------------------------------*
108200     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
108300
108400*-------------------------------------------------------------*
108500* OLD POLICY CLAIMS MUST HAVE A BLEND YEAR INDICATOR OF 5     *
108600*-------------------------------------------------------------*
108700     IF B-REVIEW-CODE = 00 AND PPS-BLEND-YEAR NOT = 5
108800        MOVE 5 TO PPS-BLEND-YEAR
108900     END-IF.
109000
109100*-------------------------------------------------------------*
109200* NEW POLICY CLAIMS MUST HAVE A BLEND YR. IND. OF 6, 7, OR 8  *
109300*-------------------------------------------------------------*
109400     IF (B-REVIEW-CODE >= 01 AND B-REVIEW-CODE <= 08) AND
109500        (PPS-BLEND-YEAR < 6 OR PPS-BLEND-YEAR > 8)
109600        MOVE '72' TO PPS-RTC
109700        GO TO 2000-EXIT
109800     END-IF.
109900
110000*-------------------------------------------------------------*
110100* SET DEFAULT BLEND VARIABLE VALUES                           *
110200* - H-BLEND-STD = % STANDARD PMT CONTRIBUTES TO FINAL PMT     *
110300* - H-BLEND-SNT = % SITE NEUTRAL PMT CONTRIBUTES TO FINAL PMT *
110400*-------------------------------------------------------------*
110500     MOVE 0 TO H-BLEND-SNT.
110600     MOVE 1 TO H-BLEND-STD.
110700     MOVE 0 TO H-BLEND-RTC.
110800
110900
111000*-------------------------------------------------------------*
111100* FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII)          *
111200*-------------------------------------------------------------*
111300     IF (P-NEW-STATE = 02 OR 12)
111400        MOVE P-NEW-COLA TO PPS-COLA
111500     ELSE
111600        MOVE 1.000 TO PPS-COLA
111700     END-IF.
111800
111900
112000 2000-EXIT.
112100      EXIT.
112200
112300
112400***************************************************************
112500*    IF THE BILL & PSF DATA HAS PASSED ALL EDITS (RTC=00)     *
112600*        CALCULATE THE APPLICABLE CLAIM PAYMENT:              *
112700*           - STANDARD PAYMENT                                *
112800*           - SHORT STAY OUTLIER PAYMENT                      *
112900*           - SITE NEUTRAL PAYMENT                            *
113000*           - STANDARD/SITE NEUTRAL BLENDED PAYMENT           *
113100***************************************************************
113200 3000-CALC-PAYMENT.
113300***************************************************************
113400
113500
113600*-------------------------------------------------------------*
113700* CALCULATE CLAIM COST FOR ALL CLAIMS                         *
113800*-------------------------------------------------------------*
113900     COMPUTE PPS-FAC-COSTS ROUNDED =
114000         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
114100
114200
114300*-------------------------------------------------------------*
114400* DETERMINE WHICH PAYMENT METHOD TO USE. EITHER:              *
114500* - STANDARD PAYMENT UNDER THE OLD POLICY,                    *
114600* - STANDARD PAYMENT UNDER THE NEW POLICY,                    *
114700* - 100% SITE NEUTRAL PAYMENT, OR                             *
114800* - 50/50 BLEND OF SITE NEUTRAL & STANDARD PAYMENT.           *
114900*-------------------------------------------------------------*
115000     PERFORM 3100-DETERMINE-PAYMENT-TYPE
115100        THRU 3100-EXIT.
115200
115300     IF PPS-RTC NOT = '00'
115400        GO TO 3000-EXIT
115500     END-IF.
115600
115700
115800*-------------------------------------------------------------*
115900* CALCULATE CLAIM PAYMENT BASED ON PAYMENT METHOD             *
116000*-------------------------------------------------------------*
116100     IF PMT-STANDARD-OLD
116200        PERFORM 3200-CALC-STANDARD-PMT
116300           THRU 3200-EXIT
116400     END-IF.
116500
116600     IF PMT-STANDARD-NEW
116700        PERFORM 3200-CALC-STANDARD-PMT
116800           THRU 3200-EXIT
116900     END-IF.
117000
117100     IF PMT-SITE-NEUTRAL
117200        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
117300           THRU 3300-EXIT
117400     END-IF.
117500
117600     IF PMT-BLEND
117700        PERFORM 3200-CALC-STANDARD-PMT
117800           THRU 3200-EXIT
117900        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
118000           THRU 3300-EXIT
118100     END-IF.
118200
118300 3000-EXIT.
118400      EXIT.
118500
118600
118700***************************************************************
118800*  DETERMINE WHETHER A CLAIM'S PAYMENT SHOULD BE:             *
118900*  - STANDARD - OLD POLICY                                    *
119000*  - STANDARD - NEW POLICY                                    *
119100*  - 100% SITE NEUTRAL - NEW POLICY                           *
119200*  - 50/50 BLEND OF SITE NEUTRAL & STANDARD - NEW POLICY      *
119300***************************************************************
119400 3100-DETERMINE-PAYMENT-TYPE.
119500***************************************************************
119600
119700*-------------------------------------------------------------*
119800* STANDARD PAYMENT (OLD POLICY)
119900*-------------------------------------------------------------*
120000     IF B-REVIEW-CODE = 00 OR
120100        SUBCLAUSEII-PROV
120200        SET PMT-STANDARD-OLD TO TRUE
120300        GO TO 3100-EXIT
120400     END-IF.
120500
120600*-------------------------------------------------------------*
120700* STANDARD PAYMENT (NEW POLICY)
120800*-------------------------------------------------------------*
120900     IF (B-REVIEW-CODE = 01 AND NOT PSYCH-REHAB-DRG) OR
121000        B-REVIEW-CODE = 04 OR
121100        B-REVIEW-CODE = 05
121200        SET PMT-STANDARD-NEW TO TRUE
121300        GO TO 3100-EXIT
121400     END-IF.
121500
121600*-------------------------------------------------------------*
121700* SITE NEUTRAL PAYMENT (NEW POLICY)
121800*-------------------------------------------------------------*
121900     IF  (B-REVIEW-CODE = 01 AND PSYCH-REHAB-DRG) OR
122000          B-REVIEW-CODE = 02 OR
122100          B-REVIEW-CODE = 03 OR
122200          B-REVIEW-CODE = 06 OR
122300          B-REVIEW-CODE = 07 OR
122400          B-REVIEW-CODE = 08
122500
122600*-------------------------------------------------------------*
122700*     SET BUDGET NEUTRALITY RATE FOR SITE NEUTRAL CLAIMS
122800*-------------------------------------------------------------*
122900        MOVE 0.949 TO H-BDGT-NEUT-FACTOR
123000
123100*-------------------------------------------------------------*
123200*     100% SITE NEUTRAL PAYMENT
123300*-------------------------------------------------------------*
123400        IF PPS-BLEND-YEAR = 8
123500           SET PMT-SITE-NEUTRAL TO TRUE
123600
123700*-------------------------------------------------------------*
123800*     50% SITE NEUTRAL + 50% STANDARD BLENDED PAYMENT
123900*-------------------------------------------------------------*
124000        ELSE
124100           IF PPS-BLEND-YEAR = 6 OR
124200              PPS-BLEND-YEAR = 7
124300              SET PMT-BLEND TO TRUE
124400
124500*-------------------------------------------------------------*
124600*           SET BLEND PERCENTS FOR BLENDED PAYMENT            *
124700*-------------------------------------------------------------*
124800              MOVE .5 TO H-BLEND-STD
124900              MOVE .5 TO H-BLEND-SNT
125000           END-IF
125100        END-IF
125200     END-IF.
125300
125400*-------------------------------------------------------------*
125500* CLAIM MEETS NONE OF THE ABOVE CRITERIA - SET RETURN CODE
125600*-------------------------------------------------------------*
125700     IF WS-PRIMARY-PMT-TYPE = ' '
125800        MOVE '72' TO PPS-RTC
125900     END-IF.
126000
126100
126200 3100-EXIT.
126300      EXIT.
126400
126500
126600***************************************************************
126700*     CALCULATE THE STANDARD PAYMENT AMOUNT.                  *
126800*     CALCULATE THE SHORT-STAY OUTLIER AMOUNT IF APPLICABLE.  *
126900***************************************************************
127000 3200-CALC-STANDARD-PMT.
127100***************************************************************
127200
127300*-------------------------------------------------------------*
127400* CALCULATE FULL STANDARD DRG ADJUSTED PAYMENT                *
127500*-------------------------------------------------------------*
127600     COMPUTE H-LABOR-PORTION ROUNDED =
127700         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
127800          * PPS-WAGE-INDEX.
127900
128000     COMPUTE H-NONLABOR-PORTION ROUNDED =
128100         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
128200          * PPS-COLA.
128300
128400     COMPUTE PPS-FED-PAY-AMT ROUNDED =
128500         (H-LABOR-PORTION + H-NONLABOR-PORTION).
128600
128700     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
128800         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
128900
129000* FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY
129100     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
129200
129300
129400*-------------------------------------------------------------*
129500* DETERMINE WHETHER THE CLAIM IS A SHORT STAY OUTLIER;        *
129600* APPLY SHORT STAY OUTLIER POLICY IF IT IS                    *
129700*-------------------------------------------------------------*
129800     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
129900
130000     IF H-LOS <= H-SSOT
130100        PERFORM 3400-SHORT-STAY
130200           THRU 3400-SHORT-STAY-EXIT
130300
130400        IF PMT-STANDARD-NEW OR PMT-BLEND
130500           SET PMT-STANDARD-SSO TO TRUE
130600           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-SSO-PMT
130700        END-IF
130800
130900*-------------------------------------------------------------*
131000* FOR REGULAR STAY CLAIMS, POPULATE THE APPROPRIATE PAYMENT   *
131100* FIELD FOR NEW POLICY CLAIMS                                 *
131200*-------------------------------------------------------------*
131300     ELSE
131400        IF PMT-STANDARD-NEW OR PMT-BLEND
131500           SET PMT-STANDARD-FULL TO TRUE
131600           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-FULL-PMT
131700        END-IF
131800     END-IF.
131900
132000 3200-EXIT.
132100      EXIT.
132200
132300
132400***************************************************************
132500*     CALCULATE THE SITE NEUTRAL PAYMENT AMOUNT               *
132600***************************************************************
132700 3300-CALC-SITE-NEUTRAL-PMT.
132800***************************************************************
132900
133000*-------------------------------------------------------------*
133100*  CALCULATE IPPS COMPARABLE PER DIEM AMT                     *
133200*-------------------------------------------------------------*
133300     PERFORM 3650-SS-IPPS-COMP-PMT
133400        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
133500
133600
133700*-------------------------------------------------------------*
133800* CALCULATE THE SITE NEUTRAL PAYMENT AS THE LESSER OF THE     *
133900* IPPS COMPARABLE PAYMENT AND CLAIM COST * BUDGET NEUT FACTOR *
134000* APPLY SITE-NEUTRAL BLEND PERCENT FOR BLENDED PAYMENT CLAIMS *
134100*-------------------------------------------------------------*
134200
134300*-------------------------------------------------------------*
134400*  SITE-NEUTRAL PAYMENT BASED ON COSTS                        *
134500*-------------------------------------------------------------*
134600     IF PPS-FAC-COSTS < H-IPPS-PER-DIEM
134700        SET PMT-SITE-NEUT-COST TO TRUE
134800        MOVE PPS-FAC-COSTS TO PPS-SITE-NEUTRAL-COST-PMT
134900
135000*-------------------------------------------------------------*
135100*  SITE-NEUTRAL PAYMENT BASED ON IPPS COMPARABLE              *
135200*-------------------------------------------------------------*
135300     ELSE
135400        SET PMT-SITE-NEUT-IPPS TO TRUE
135500        MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT
135600     END-IF.
135700
135800
135900 3300-EXIT.
136000      EXIT.
136100
136200
136300***************************************************************
136400*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
136500*      OF THE AVG. LENGTH OF STAY THEN:                       *
136600*      - CALCULATE THE SHORT-STAY COST.                       *
136700*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *
136800*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *
136900*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *
137000*      - PAY THE LEAST OF:                                    *
137100*          1)SHORT STAY COST                                  *
137200*          2)SHORT STAY PAYMENT AMOUNT                        *
137300*          3)DRG ADJUSTED PAYMENT AMOUNT                      *
137400*          4)SHORT STAY BLENDED PAYMENT -OR-                  *
137500*          5)IPPS COMPARABLE AMOUNT                           *
137600*      - SET RETURN CODE FOR OLD POLICY CLAIMS ONLY TO        *
137700*        INDICATE SHORT STAY PAYMENT TYPE                     *
137800***************************************************************
137900
138000 3400-SHORT-STAY.
138100**************************************************************
138200*   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *
138300**************************************************************
138400     IF SUBCLAUSEII-PROV
138500        PERFORM 4000-SPECIAL-PROVIDER
138600           THRU 4000-SPECIAL-PROVIDER-EXIT
138700     ELSE
138800
138900**************************************************************
139000*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *
139100* ---------------------------------------------------------- *
139200*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *
139300**************************************************************
139400        MOVE PPS-FAC-COSTS TO H-SS-COST
139500
139600**************************************************************
139700*                                                            *
139800*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *
139900* ---------------------------------------------------------- *
140000*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *
140100*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *
140200*     THE LENGTH OF STAY IS CORRECT                          *
140300*                                                            *
140400**************************************************************
140500        COMPUTE H-SS-PAY-AMT ROUNDED =
140600         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
140700
140800**************************************************************
140900*                                                            *
141000*   SHORT STAY PROVISION #4 (BLEND OF SS PMT & IPPS          *
141100*   COMPARABLE PER DIEM AMT)                                 *
141200* ---------------------------------------------------------- *
141300*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
141400*   REMOVED FROM VERSION 09.0 BECAUSE CLAIMS DISCHARGED ON   *
141500*   AND AFTER 12/29/2008 ARE NOT ELIGIBLE FOR PROVISION #5.  *
141600*                                                            *
141700*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
141800*   ADDED TO VERSION 13.0 BECAUSE CLAIMS DISCHARGED ON AND   *
141900*   AFTER 12/29/2012 ARE ELIGIBLE FOR PROVISION #5.          *
142000*                                                            *
142100**************************************************************
142200        IF H-IPPS-WAGE-INDEX NUMERIC AND
142300           H-IPPS-WAGE-INDEX > 0
142400*---------------------------------------------------------
142500*   #4 - CALCULATE BLENDED PAYMENT
142600*---------------------------------------------------------
142700           IF B-DISCHARGE-DATE >= 20121229
142800              IF H-LOS > PPS-IPTHRESH
142900                 PERFORM 3600-SS-BLENDED-PMT
143000                    THRU 3600-SS-BLENDED-PMT-EXIT
143100               ELSE
143200*---------------------------------------------------------
143300*   #5 - LOS (COVERED DAYS) <= IPPS COMPARABLE THRESHOLD
143400*        CALCULATE IPPS COMPARABLE PER DIEM AMT ONLY
143500*---------------------------------------------------------
143600                  PERFORM 3650-SS-IPPS-COMP-PMT
143700                     THRU 3650-SS-IPPS-COMP-PMT-EXIT
143800           ELSE
143900               PERFORM 3600-SS-BLENDED-PMT
144000                  THRU 3600-SS-BLENDED-PMT-EXIT
144100        ELSE
144200           MOVE '52' TO PPS-RTC
144300           GO TO 3400-SHORT-STAY-EXIT.
144400
144500**************************************************************
144600*                                                            *
144700*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *
144800*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *
144900* ---------------------------------------------------------- *
145000*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *
145100*                                                            *
145200**************************************************************
145300
145400     MOVE 'N' TO H-SS-COST-IND.
145500     MOVE 'N' TO H-SS-PERDIEM-IND.
145600     MOVE 'N' TO H-SS-BLEND-IND.
145700     MOVE 'N' TO H-SS-IPPSCOMP-IND.
145800
145900*---------------------------------------------------------
146000*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%
146100*   OF PER DIEM) AND DRG ADJUSTED PMT AMT
146200*---------------------------------------------------------
146300     IF H-SS-COST < H-SS-PAY-AMT
146400        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT
146500           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT
146600           IF PMT-STANDARD-OLD
146700              MOVE '20' TO PPS-RTC
146800           END-IF
146900           MOVE 'Y' TO H-SS-COST-IND
147000        ELSE
147100           NEXT SENTENCE
147200        END-IF
147300     ELSE
147400        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT
147500           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT
147600           IF PMT-STANDARD-OLD
147700              MOVE '21' TO PPS-RTC
147800           END-IF
147900           MOVE 'Y' TO H-SS-PERDIEM-IND
148000        ELSE
148100           NEXT SENTENCE
148200        END-IF
148300     END-IF.
148400
148500*---------------------------------------------------------
148600*   USE THE BLENDED PMT OR IPPS COMPARABLE AMT IF LESS
148700*   THAN THE OTHER OPTIONS
148800*---------------------------------------------------------
148900     IF NOT SUBCLAUSEII-PROV
149000*---------------------------------------------------------
149100*   COMPARE BLENDED PAYMENT
149200*---------------------------------------------------------
149300         IF B-DISCHARGE-DATE >= 20121229 AND
149400           H-LOS > PPS-IPTHRESH AND
149500           H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
149600               MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
149700               IF PMT-STANDARD-OLD
149800                  MOVE '22' TO PPS-RTC
149900               END-IF
150000               MOVE 'Y' TO H-SS-BLEND-IND
150100               MOVE 'N' TO H-SS-COST-IND
150200               MOVE 'N' TO H-SS-PERDIEM-IND
150300               MOVE 'N' TO H-SS-IPPSCOMP-IND
150400         ELSE
150500*---------------------------------------------------------
150600*   COMPARE IPPS COMPARABLE PER DIEM AMOUNT
150700*---------------------------------------------------------
150800             IF B-DISCHARGE-DATE >= 20121229 AND
150900               H-LOS <= PPS-IPTHRESH AND
151000               H-IPPS-PER-DIEM <= PPS-DRG-ADJ-PAY-AMT
151100                 MOVE H-IPPS-PER-DIEM TO PPS-DRG-ADJ-PAY-AMT
151200                 IF PMT-STANDARD-OLD
151300                    MOVE '26' TO PPS-RTC
151400                 END-IF
151500                 MOVE 'Y' TO H-SS-IPPSCOMP-IND
151600                 MOVE 'N' TO H-SS-BLEND-IND
151700                 MOVE 'N' TO H-SS-COST-IND
151800                 MOVE 'N' TO H-SS-PERDIEM-IND
151900             ELSE
152000                 IF B-DISCHARGE-DATE < 20121229 AND
152100                   H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
152200                     MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
152300                     IF PMT-STANDARD-OLD
152400                        MOVE '22' TO PPS-RTC
152500                     END-IF
152600                     MOVE 'Y' TO H-SS-BLEND-IND
152700                     MOVE 'N' TO H-SS-COST-IND
152800                     MOVE 'N' TO H-SS-PERDIEM-IND
152900                     MOVE 'N' TO H-SS-IPPSCOMP-IND
153000                 END-IF
153100             END-IF
153200         END-IF
153300     END-IF.
153400
153500 3400-SHORT-STAY-EXIT.
153600      EXIT.
153700
153800
153900***************************************************************
154000*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
154100*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
154200*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
154300*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
154400***************************************************************
154500 3600-SS-BLENDED-PMT.
154600***************************************************************
154700
154800*** ------------------------------------------------------ ***
154900*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
155000*** ------------------------------------------------------ ***
155100     IF H-SSOT < 25
155200        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
155300          H-LOS / H-SSOT
155400     ELSE
155500        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
155600          H-LOS / 25
155700     END-IF.
155800
155900     IF H-LTCH-BLEND-PCT > 1
156000        MOVE 1 TO H-LTCH-BLEND-PCT
156100     END-IF.
156200
156300
156400*** ------------------------------------------------------ ***
156500*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
156600*** ------------------------------------------------------ ***
156700     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
156800        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
156900
157000
157100*** ------------------------------------------------------ ***
157200*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
157300*** ------------------------------------------------------ ***
157400     PERFORM 3650-SS-IPPS-COMP-PMT
157500        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
157600
157700
157800*** ------------------------------------------------------ ***
157900*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
158000*** ------------------------------------------------------ ***
158100     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
158200       1 - H-LTCH-BLEND-PCT.
158300
158400
158500*** ------------------------------------------------------ ***
158600*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
158700*** ------------------------------------------------------ ***
158800     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
158900       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
159000
159100
159200*** ------------------------------------------------------ ***
159300*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
159400*** ------------------------------------------------------ ***
159500     COMPUTE H-SS-BLENDED-PMT ROUNDED =
159600       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
159700
159800
159900 3600-SS-BLENDED-PMT-EXIT.
160000      EXIT.
160100
160200
160300***************************************************************
160400*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
160500*   PER DIEM PAYMENT AMOUNT                                   *
160600***************************************************************
160700 3650-SS-IPPS-COMP-PMT.
160800***************************************************************
160900
161000*** -------------------------------------------------------
161100*** OPERATING TEACHING ADJUSTMENT
161200*** -------------------------------------------------------
161300     COMPUTE H-OPER-IME-TEACH ROUNDED =
161400        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
161500
161600
161700*** -------------------------------------------------------
161800*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
161900*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%
162000*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL
162100***              THIS CHANGE IS RETROACTIVE TO 10/01/2008
162200*** -------------------------------------------------------
162300     IF H-CAPI-IME-RATIO > 1.5000
162400        MOVE 1.5000 TO H-CAPI-IME-RATIO.
162500
162600     COMPUTE H-CAPI-IME-TEACH ROUNDED =
162700        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).
162800
162900
163000*** -------------------------------------------------------
163100*** OPERATING DSH ADJUSTMENT
163200*** -------------------------------------------------------
163300
163400*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
163500*---------------------------------------------------
163600     IF ALL-RURAL
163700        SET RURAL-CBSA TO TRUE
163800     ELSE
163900        SET URBAN-CBSA TO TRUE
164000     END-IF.
164100
164200
164300*2) CALCULATE THE OPERATING DSH PERCENT
164400*--------------------------------------
164500     COMPUTE H-OPER-DSH-PCT ROUNDED =
164600        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
164700
164800
164900*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
165000*-----------------------------------------------------
165100
165200*    URBAN, < 100 BEDS
165300*    -----------------
165400     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
165500        H-OPER-DSH-PCT >= .15
165600          MOVE '3' TO H-GEO-CLASS
165700     ELSE
165800
165900
166000*   URBAN, >= 100 BEDS
166100*   ------------------
166200       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
166300          H-OPER-DSH-PCT >= .15
166400            MOVE '2' TO H-GEO-CLASS
166500       ELSE
166600
166700
166800*   RURAL, >= 500 BEDS
166900*   ------------------
167000         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
167100            H-OPER-DSH-PCT >= .15
167200              MOVE '2' TO H-GEO-CLASS
167300         ELSE
167400
167500
167600*   RURAL, < 500 BEDS
167700*   -----------------
167800           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
167900              H-OPER-DSH-PCT >= .15
168000                MOVE '3' TO H-GEO-CLASS
168100           ELSE
168200
168300
168400*   OTHER
168500*   -----------------
168600              MOVE '4' TO H-GEO-CLASS
168700
168800           END-IF
168900         END-IF
169000       END-IF
169100     END-IF.
169200
169300
169400*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
169500*-----------------------------------------------------------
169600     EVALUATE H-GEO-CLASS
169700
169800*      GEOGRAPHIC CLASS 2
169900*      ------------------
170000       WHEN '2'
170100          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
170200             COMPUTE H-OPER-DSH ROUNDED =
170300               ((H-OPER-DSH-PCT - .15) * .65) + .025
170400          ELSE
170500             IF H-OPER-DSH-PCT > .202
170600                COMPUTE H-OPER-DSH ROUNDED =
170700                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
170800             ELSE
170900                MOVE ZEROS TO H-OPER-DSH
171000             END-IF
171100          END-IF
171200
171300*      GEOGRAPHIC CLASS 3
171400*      ------------------
171500       WHEN '3'
171600          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
171700             COMPUTE H-OPER-DSH ROUNDED =
171800               ((H-OPER-DSH-PCT - .15) * .65) + .025
171900             IF H-OPER-DSH > .12
172000                MOVE .12 TO H-OPER-DSH
172100             END-IF
172200          ELSE
172300             IF H-OPER-DSH-PCT > .202
172400                COMPUTE H-OPER-DSH ROUNDED =
172500                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
172600                IF H-OPER-DSH > .12
172700                   MOVE .12 TO H-OPER-DSH
172800                END-IF
172900             ELSE
173000               MOVE ZEROS TO H-OPER-DSH
173100             END-IF
173200          END-IF
173300
173400*      GEOGRAPHIC CLASS 4
173500*      ------------------
173600       WHEN '4'
173700          MOVE ZEROS TO H-OPER-DSH
173800
173900     END-EVALUATE.
174000
174100
174200*** -------------------------------------------------------
174300*** CURRENT OPERATING DSH PAYMENT REDUCTION
174400*** -------------------------------------------------------
174500     COMPUTE H-OPER-DSH ROUNDED =
174600             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.
174700
174800*** -------------------------------------------------------
174900*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
175000*** -------------------------------------------------------
175100     IF URBAN-CBSA AND H-BED-SIZE >= 100
175200        COMPUTE H-CAPI-DSH ROUNDED =
175300          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
175400     ELSE
175500        MOVE ZEROS TO H-CAPI-DSH
175600     END-IF.
175700
175800
175900*** -------------------------------------------------------
176000*** OPERATING PAYMENT (STANDARD AMOUNT)
176100*** -------------------------------------------------------
176200     IF (P-NEW-STATE = 02 OR 12)
176300        MOVE P-NEW-COLA TO H-OPER-COLA
176400     ELSE
176500        MOVE 1.000 TO H-OPER-COLA
176600     END-IF.
176700
176800     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
176900       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +
177000         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
177100         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
177200
177300
177400*** -------------------------------------------------------
177500*** CAPITAL PAYMENT (CAPITAL RATE)
177600*** -------------------------------------------------------
177700     COMPUTE H-CAPI-COLA ROUNDED =
177800       (.3152 * (H-OPER-COLA - 1) + 1).
177900
178000*--------------------------------------------------------------*
178100*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
178200*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
178300*--------------------------------------------------------------*
178400     IF LARGE-URBAN
178500        MOVE 1.00 TO H-LRGURB-ADD-ON
178600     ELSE
178700        MOVE 1.00 TO H-LRGURB-ADD-ON
178800     END-IF.
178900
179000     COMPUTE H-CAPI-GAF ROUNDED =
179100       (H-IPPS-WAGE-INDEX ** .6848).
179200
179300     COMPUTE H-CAPI-PMT ROUNDED =
179400       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
179500       H-LRGURB-ADD-ON *  H-CAPI-COLA *
179600       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
179700
179800
179900*** -------------------------------------------------------
180000*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
180100*** -------------------------------------------------------
180200     COMPUTE H-IPPS-PAY-AMT ROUNDED =
180300       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
180400
180500
180600*** -------------------------------------------------------
180700*** IPPS COMPARABLE PER DIEM PAYMENT
180800*** -------------------------------------------------------
180900     COMPUTE H-IPPS-PER-DIEM ROUNDED =
181000       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
181100
181200     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
181300        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
181400     END-IF.
181500
181600*** -------------------------------------------------------
181700*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
181800*** -------------------------------------------------------
181900     IF P-NEW-STATE = 40 OR 84
182000        PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT
182100     END-IF.
182200
182300
182400 3650-SS-IPPS-COMP-PMT-EXIT.
182500      EXIT.
182600
182700
182800***************************************************************
182900 3675-SS-IPPS-COMP-PR-PMT.
183000***************************************************************
183100
183200*** -------------------------------------------------------
183300*** PUERTO RICO SPECIFIC OPERATING PAYMENT (STANDARD AMOUNT)
183400*** ** FOR CLAIMS DISCHARGED BEFORE 1/1/2016 ONLY **
183500*** -------------------------------------------------------
183600     IF B-DISCHARGE-DATE < 20160101
183700       COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =
183800        ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +
183900          (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *
184000          H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH )
184100     END-IF.
184200
184300
184400*** -------------------------------------------------------
184500*** PUERTO RICO SPECIFIC CAPITAL PAYMENT (CAPITAL RATE)
184600*** -------------------------------------------------------
184700     COMPUTE H-PR-CAPI-GAF ROUNDED =
184800        (W-IPPS-PR-WAGE-INDEX ** .6848).
184900
185000     COMPUTE H-PR-CAPI-PMT ROUNDED =
185100        H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *
185200        H-LRGURB-ADD-ON * H-CAPI-COLA *
185300        (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
185400
185500
185600*** -------------------------------------------------------
185700*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
185800*** -------------------------------------------------------
185900     COMPUTE H-IPPS-PAY-AMT ROUNDED =
186000
186100*** COMPUTE NATIONAL PORTION OF BLEND
186200          (
186300           (H-STAND-AMT-OPER-PMT *
186400            H-NAT-OPER-IPPS-PMT-PCT) +
186500           (H-CAPI-PMT * H-NAT-CAPI-IPPS-PMT-PCT)
186600          ) +
186700
186800*** COMPUTE PUERTO RICO PORTION OF BLEND
186900          (
187000           (H-PR-STAND-AMT-OPER-PMT *
187100             H-PR-OPER-IPPS-PMT-PCT) +
187200           (H-PR-CAPI-PMT * H-PR-CAPI-IPPS-PMT-PCT)
187300          ).
187400
187500
187600*** -------------------------------------------------------
187700*** IPPS COMPARABLE PER DIEM PAYMENT
187800*** -------------------------------------------------------
187900     COMPUTE H-IPPS-PER-DIEM ROUNDED =
188000        (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
188100
188200     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
188300        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
188400     END-IF.
188500
188600
188700 3675-EXIT.
188800      EXIT.
188900
189000
189100***************************************************************
189200 4000-SPECIAL-PROVIDER.
189300***************************************************************
189400
189500*** PROCESS FOR CY2003
189600*** ------------------
189700     IF (B-DISCHARGE-DATE >= 20030701) AND
189800        (B-DISCHARGE-DATE <  20040101)
189900        COMPUTE H-SS-COST ROUNDED =
190000            (PPS-FAC-COSTS * 1.95)
190100        COMPUTE H-SS-PAY-AMT ROUNDED =
190200         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
190300     END-IF
190400
190500
190600*** PROCESS FOR CY2004
190700*** ------------------
190800     IF (B-DISCHARGE-DATE >= 20040101) AND
190900        (B-DISCHARGE-DATE <  20050101)
191000        COMPUTE H-SS-COST ROUNDED =
191100            (PPS-FAC-COSTS * 1.93)
191200        COMPUTE H-SS-PAY-AMT ROUNDED =
191300          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
191400     END-IF
191500
191600
191700*** PROCESS FOR CY2005
191800*** ------------------
191900     IF (B-DISCHARGE-DATE >= 20050101) AND
192000        (B-DISCHARGE-DATE <  20060101)
192100        COMPUTE H-SS-COST ROUNDED =
192200            (PPS-FAC-COSTS * 1.65)
192300        COMPUTE H-SS-PAY-AMT ROUNDED =
192400          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
192500     END-IF
192600
192700
192800*** PROCESS FOR CY2006
192900*** ------------------
193000     IF (B-DISCHARGE-DATE >= 20060101) AND
193100        (B-DISCHARGE-DATE <  20070101)
193200        COMPUTE H-SS-COST ROUNDED =
193300            (PPS-FAC-COSTS * 1.36)
193400        COMPUTE H-SS-PAY-AMT ROUNDED =
193500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
193600     END-IF
193700
193800
193900*** PROCESS FOR CY2007 AND AFTER
194000*** ----------------------------
194100     IF (B-DISCHARGE-DATE >= 20070101)
194200        COMPUTE H-SS-COST ROUNDED =
194300            (PPS-FAC-COSTS * 1.2)
194400        COMPUTE H-SS-PAY-AMT ROUNDED =
194500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
194600     END-IF.
194700
194800 4000-SPECIAL-PROVIDER-EXIT.
194900      EXIT.
195000
195100
195200***************************************************************
195300*   CALCULATE THE OUTLIER THRESHOLD                           *
195400*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
195500*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
195600*   SET RETURN CODE                                           *
195700*   CALCULATE THE CHARGE THRESHOLD IF APPLICABLE              *
195800***************************************************************
195900 6000-CALC-HIGH-COST-OUTLIER.
196000***************************************************************
196100
196200
196300*-------------------------------------------------------------*
196400* FOR NON-BLENDED PAYMENT CLAIMS:                             *
196500*-------------------------------------------------------------*
196600* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLD  *
196700*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
196800* - CALCULATE OUTLIER THRESHOLD                               *
196900*-------------------------------------------------------------*
197000
197100     IF PMT-STANDARD-OLD
197200        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
197300                PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT-STD
197400     END-IF.
197500
197600
197700     IF PMT-STANDARD-NEW
197800        IF PMT-STANDARD-FULL
197900           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
198000                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
198100        ELSE
198200           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
198300                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
198400        END-IF
198500     END-IF.
198600
198700
198800     IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
198900        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
199000                PPS-SITE-NEUTRAL-IPPS-PMT + H-FIXED-LOSS-AMT-SNT
199100     END-IF.
199200
199300
199400*-------------------------------------------------------------*
199500* CALCULATE HIGH-COST OUTLIER IF COSTS EXCEED THRESHOLD       *
199600*-------------------------------------------------------------*
199700     IF NOT PMT-BLEND AND
199800        NOT (PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-COST)
199900        IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
200000           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
200100                   (PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8
200200
200300*-------------------------------------------------------------*
200400*        SITE-NEUTRAL ONLY: REDUCE BY BUDGET NEUTRALITY FACT. *
200500*-------------------------------------------------------------*
200600           IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
200700              COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
200800                      PPS-OUTLIER-PAY-AMT * H-BDGT-NEUT-FACTOR
200900           END-IF
201000        END-IF
201100     END-IF.
201200
201300
201400
201500*-------------------------------------------------------------*
201600* FOR BLENDED PAYMENT CLAIMS                                  *
201700* (RECEIVE 50% STANDARD PAYMENT + 50% SITE-NEUTRAL PAYMENT)   *
201800*-------------------------------------------------------------*
201900* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLDS *
202000*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
202100* - CALCULATE STANDARD PAYMENT OUTLIER THRESHOLD              *
202200* - CALCULATE SITE-NEUTRAL PAYMENT OUTLIER THRESHOLD          *
202300* - CALCULATE HIGH-COST OUTLIER IF APPLICABLE (50/50 BLEND)   *
202400*-------------------------------------------------------------*
202500
202600     IF PMT-BLEND
202700
202800*-------------------------------------------------------------*
202900* CALCULATE STANDARD OUTLIER THRESHOLD                        *
203000*-------------------------------------------------------------*
203100        IF PMT-STANDARD-FULL
203200           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
203300                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
203400        ELSE
203500           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
203600                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
203700        END-IF
203800
203900
204000*-------------------------------------------------------------*
204100* CALCULATE SITE-NEUTRAL OUTLIER THRESHOLD                    *
204200*-------------------------------------------------------------*
204300        IF PMT-SITE-NEUT-IPPS
204400           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
204500                   PPS-SITE-NEUTRAL-IPPS-PMT +
204600                   H-FIXED-LOSS-AMT-SNT
204700        END-IF
204800
204900
205000*-------------------------------------------------------------*
205100* CALCULATE STANDARD PAYMENT PORTION OF HIGH-COST OUTLIER IF  *
205200* COSTS EXCEED STANDARD PAYMENT THRESHOLD                     *
205300*-------------------------------------------------------------*
205400        IF PPS-FAC-COSTS > H-OUTLIER-THRESHOLD-STD
205500           COMPUTE H-OUTLIER-PAY-AMT-STD ROUNDED =
205600                   (PPS-FAC-COSTS - H-OUTLIER-THRESHOLD-STD) * .8
205700                   * H-BLEND-STD
205800        END-IF
205900
206000
206100*-------------------------------------------------------------*
206200* CALCULATE SITE-NEUTRAL PORTION OF HIGH-COST OUTLIER IF      *
206300* COSTS EXCEED THE SITE-NEUTRAL PAYMENT THRESHOLD             *
206400*-------------------------------------------------------------*
206500        IF PMT-SITE-NEUT-IPPS AND
206600           PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
206700           COMPUTE H-OUTLIER-PAY-AMT-SNT ROUNDED =
206800                  (((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
206900                   * H-BLEND-SNT) * H-BDGT-NEUT-FACTOR
207000        END-IF
207100
207200*-------------------------------------------------------------*
207300* CALCULATE TOTAL BLENDED HIGH-COST OUTLIER:                  *
207400* ADD THE SITE-NEUTRAL PAYMENT PORTION OF HIGH-COST OUTLIER   *
207500* TO THE STANDARD PAYMENT PORTION                             *
207600*-------------------------------------------------------------*
207700        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
207800                H-OUTLIER-PAY-AMT-STD + H-OUTLIER-PAY-AMT-SNT
207900
208000     END-IF.
208100
208200
208300*-------------------------------------------------------------*
208400* FOR ALL CLAIMS:                                             *
208500*-------------------------------------------------------------*
208600* SET HIGH-COST OUTLIER TO $0 IF BILL SPECIAL PAY IND. = '1'  *
208700*-------------------------------------------------------------*
208800     IF B-SPEC-PAY-IND = '1'
208900        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
209000
209100
209200*-------------------------------------------------------------*
209300* DETERMINE IF CHARGE THRESHOLD APPLIES & CALCULATE IF SO     *
209400*-------------------------------------------------------------*
209500     PERFORM 6100-CALC-CHARGE-THRESHOLD
209600        THRU 6100-EXIT.
209700
209800
209900 6000-EXIT.
210000      EXIT.
210100
210200
210300***************************************************************
210400*   CALCULATE CHARGE THRESHOLD & SET ERROR RTC WHEN APPLICABLE*
210500***************************************************************
210600 6100-CALC-CHARGE-THRESHOLD.
210700***************************************************************
210800
210900
211000*-------------------------------------------------------------*
211100* FOR MAINFRAME PRICER ONLY:                                  *
211200*-------------------------------------------------------------*
211300* FOR CLAIMS THAT RECEIVE A HIGH-COST OUTLIER AND HAVE A      *
211400* LENGTH OF STAY THAT EXCEEDS THE COVERED DAYS, CALCULATE THE *
211500* CHARGE THRESHOLD AND SET ERROR RETURN CODE '67'             *
211600*-------------------------------------------------------------*
211700
211800*-------------------------------------------------------------*
211900* FOR PC PRICER (PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS):      *
212000*-------------------------------------------------------------*
212100* CALCULATE CHARGE THRESHOLD FOR CLAIMS ALL CLAIMS THAT HAVE  *
212200* AN OPERATING COST-TO-CHARGE RATIO BUT DO NOT SET ERROR CODE *
212300*-------------------------------------------------------------*
212400
212500     IF (PPS-OUTLIER-PAY-AMT > 0 AND
212600         NOT (PMT-BLEND AND H-OUTLIER-PAY-AMT-SNT = 0)) OR
212700        PPS-COT-IND = 'Y'
212800
212900        IF B-COV-DAYS < H-LOS OR
213000           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
213100
213200           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
213300             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
213400
213500           IF NOT PC-PRICER
213600              MOVE '67' TO PPS-RTC
213700           END-IF
213800
213900        ELSE
214000           NEXT SENTENCE
214100        END-IF
214200     ELSE
214300        NEXT SENTENCE
214400     END-IF.
214500
214600 6100-EXIT.
214700      EXIT.
214800
214900
215000***************************************************************
215100*   SET FINAL RETURN CODES FOR PRICED CLAIMS                  *
215200***************************************************************
215300 7000-SET-FINAL-RETURN-CODES.
215400***************************************************************
215500
215600
215700*-------------------------------------------------------------*
215800* SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIM            *
215900*-------------------------------------------------------------*
216000     IF SUBCLAUSEII-PROV
216100        PERFORM 7300-SET-SUBII-RETURN-CODES
216200           THRU 7300-EXIT
216300        GO TO 7000-EXIT
216400     END-IF.
216500
216600
216700*-------------------------------------------------------------*
216800* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
216900* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
217000*-------------------------------------------------------------*
217100     IF PMT-STANDARD-OLD
217200        PERFORM 7100-SET-OLD-RETURN-CODES
217300           THRU 7100-EXIT
217400     END-IF.
217500
217600
217700*-------------------------------------------------------------*
217800* SET RETURN CODES FOR NEW POLICY CLAIMS                      *
217900*-------------------------------------------------------------*
218000     IF PMT-STANDARD-NEW OR PMT-SITE-NEUTRAL OR PMT-BLEND
218100        PERFORM 7200-SET-NEW-RETURN-CODES
218200           THRU 7200-EXIT
218300     END-IF.
218400
218500
218600 7000-EXIT.
218700      EXIT.
218800
218900
219000***************************************************************
219100*   SET RETURN CODES FOR OLD POLICY CLAIMS                    *
219200***************************************************************
219300 7100-SET-OLD-RETURN-CODES.
219400***************************************************************
219500
219600*-------------------------------------------------------------*
219700* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
219800* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
219900*-------------------------------------------------------------*
220000
220100     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '21'
220200        MOVE '24' TO PPS-RTC.
220300
220400     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '22'
220500        MOVE '25' TO PPS-RTC.
220600
220700     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '26'
220800        MOVE '27' TO PPS-RTC.
220900
221000     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '00'
221100        MOVE '01' TO PPS-RTC.
221200
221300     IF (PPS-RTC = '00' OR '20' OR '21' OR '22' OR '26')
221400        IF PPS-REG-DAYS-USED > H-SSOT
221500           MOVE 0 TO PPS-LTR-DAYS-USED
221600        ELSE
221700           NEXT SENTENCE.
221800
221900 7100-EXIT.
222000      EXIT.
222100
222200
222300***************************************************************
222400*   SET RETURN CODES FOR NEW POLICY CLAIMS                    *
222500***************************************************************
222600 7200-SET-NEW-RETURN-CODES.
222700***************************************************************
222800
222900     INITIALIZE PPS-RTC.
223000
223100***************************************************************
223200* SET THE FIRST POSITION OF THE RETURN CODE                   *
223300***************************************************************
223400
223500*--------------------------------------------------*
223600* DEFAULT (NO PSYCH/REHAB NOR VENTILATOR SERVICE)  *
223700*--------------------------------------------------*
223800     MOVE 'C' TO PPS-RTC-1.
223900
224000*--------------------------------------------------*
224100* VENTILATOR SERVICE PRESENT                       *
224200*--------------------------------------------------*
224300     PERFORM 7250-SEARCH-FOR-VENT-PROC
224400        THRU 7250-EXIT.
224500     IF VENT-PRESENT
224600        MOVE 'B' TO PPS-RTC-1
224700     END-IF.
224800
224900*--------------------------------------------------*
225000* SITE NEUTRAL PMT BECAUSE PSYCH/REHAB DRG PRESENT *
225100* (PRESENCE OF PSCHY/REHAB DRG TRUMPS VENT PROC.)  *
225200*--------------------------------------------------*
225300     IF PSYCH-REHAB-DRG AND
225400        (PMT-SITE-NEUTRAL OR PMT-BLEND)
225500        MOVE 'A' TO PPS-RTC-1
225600     END-IF.
225700
225800
225900
226000***************************************************************
226100* SET THE SECOND POSITION OF RETURN CODE                      *
226200***************************************************************
226300
226400*-------------------------------------------------------------*
226500* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = COST         *
226600*-------------------------------------------------------------*
226700     IF PMT-BLEND AND PMT-SITE-NEUT-COST
226800
226900        IF PPS-OUTLIER-PAY-AMT = 0 AND
227000           PMT-STANDARD-FULL
227100           MOVE '0' TO PPS-RTC-2
227200        END-IF
227300
227400        IF PPS-OUTLIER-PAY-AMT > 0 AND
227500           PMT-STANDARD-FULL
227600           MOVE '1' TO PPS-RTC-2
227700        END-IF
227800
227900        IF PPS-OUTLIER-PAY-AMT = 0 AND
228000           PMT-STANDARD-SSO
228100           MOVE '2' TO PPS-RTC-2
228200        END-IF
228300
228400        IF PPS-OUTLIER-PAY-AMT > 0 AND
228500           PMT-STANDARD-SSO
228600           MOVE '3' TO PPS-RTC-2
228700        END-IF
228800
228900     END-IF.
229000
229100
229200*-------------------------------------------------------------*
229300* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = IPPS COMP.   *
229400*-------------------------------------------------------------*
229500     IF PMT-BLEND AND PMT-SITE-NEUT-IPPS
229600
229700        IF PPS-OUTLIER-PAY-AMT = 0 AND
229800           PMT-STANDARD-FULL
229900           MOVE '4' TO PPS-RTC-2
230000        END-IF
230100
230200        IF PPS-OUTLIER-PAY-AMT > 0 AND
230300           PMT-STANDARD-FULL
230400           MOVE '5' TO PPS-RTC-2
230500        END-IF
230600
230700        IF PPS-OUTLIER-PAY-AMT = 0 AND
230800           PMT-STANDARD-SSO
230900           MOVE '6' TO PPS-RTC-2
231000        END-IF
231100
231200        IF PPS-OUTLIER-PAY-AMT > 0 AND
231300           PMT-STANDARD-SSO
231400           MOVE '7' TO PPS-RTC-2
231500        END-IF
231600
231700     END-IF.
231800
231900
232000*-------------------------------------------------------------*
232100* 100% SITE NEUTRAL PAYMENT CLAIMS                            *
232200*-------------------------------------------------------------*
232300     IF PMT-SITE-NEUTRAL
232400
232500        IF PMT-SITE-NEUT-COST
232600           MOVE 'A' TO PPS-RTC-2
232700        END-IF
232800
232900        IF PMT-SITE-NEUT-IPPS
233000           IF PPS-OUTLIER-PAY-AMT = 0
233100              MOVE 'B' TO PPS-RTC-2
233200           ELSE
233300              MOVE 'C' TO PPS-RTC-2
233400           END-IF
233500        END-IF
233600     END-IF.
233700
233800
233900*-------------------------------------------------------------*
234000* 100% STANDARD PAYMENT CLAIMS                                *
234100*-------------------------------------------------------------*
234200     IF PMT-STANDARD-NEW
234300
234400        IF PMT-STANDARD-SSO AND
234500           PPS-OUTLIER-PAY-AMT = 0
234600           MOVE 'D' TO PPS-RTC-2
234700        END-IF
234800
234900        IF PMT-STANDARD-SSO AND
235000           PPS-OUTLIER-PAY-AMT > 0
235100           MOVE 'E' TO PPS-RTC-2
235200        END-IF
235300
235400        IF PMT-STANDARD-FULL AND
235500           PPS-OUTLIER-PAY-AMT = 0
235600           MOVE 'F' TO PPS-RTC-2
235700        END-IF
235800
235900        IF PMT-STANDARD-FULL AND
236000           PPS-OUTLIER-PAY-AMT > 0
236100           MOVE 'G' TO PPS-RTC-2
236200        END-IF
236300
236400     END-IF.
236500
236600
236700 7200-EXIT.
236800      EXIT.
236900
237000
237100***************************************************************
237200*   SEARCH FOR VENTILATOR SERVICE ICD-10 PROCEDURE CODE       *
237300***************************************************************
237400 7250-SEARCH-FOR-VENT-PROC.
237500***************************************************************
237600
237700     SET IDX-PROC TO 1.
237800
237900     SEARCH B-PROCEDURE-CODE VARYING IDX-PROC
238000         AT END
238100            SET VENT-NOT-PRESENT TO TRUE
238200         WHEN VENT-ICD-10-CODE = B-PROCEDURE-CODE (IDX-PROC)
238300            SET VENT-PRESENT TO TRUE
238400            GO TO 7250-EXIT
238500     END-SEARCH.
238600
238700 7250-EXIT.
238800      EXIT.
238900
239000
239100***************************************************************
239200*   SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIMS         *
239300***************************************************************
239400 7300-SET-SUBII-RETURN-CODES.
239500***************************************************************
239600
239700     INITIALIZE PPS-RTC.
239800
239900*-------------------------------------------------------------*
240000* SET RETURN CODE BASED ON PRESENCE/ABSENCE OF OUTLIER        *
240100*-------------------------------------------------------------*
240200     IF PPS-OUTLIER-PAY-AMT > 0
240300        MOVE '29' TO PPS-RTC
240400     ELSE
240500        MOVE '28' TO PPS-RTC
240600     END-IF.
240700
240800*-------------------------------------------------------------*
240900* MOVE PER DIEM AMOUNT TO OUTPUT RECORD VARIABLE              *
241000*-------------------------------------------------------------*
241100     MOVE P-NEW-FAC-SPEC-RATE TO PPS-NEW-FAC-SPEC-RATE.
241200
241300*-------------------------------------------------------------*
241400* INITIALIZE OUTPUT FIELDS THAT DON'T APPLY TO SUBCLAUSE II   *
241500*-------------------------------------------------------------*
241600     INITIALIZE PPS-OUTLIER-PAY-AMT
241700                PPS-DRG-ADJ-PAY-AMT
241800                PPS-FED-PAY-AMT
241900                PPS-FAC-COSTS
242000                PPS-SUBM-DRG-CODE
242100                PPS-NAT-LABOR-PCT
242200                PPS-NAT-NONLABOR-PCT
242300                PPS-STD-FED-RATE
242400                PPS-BDGT-NEUT-RATE
242500                PPS-IPTHRESH
242600                PPS-SITE-NEUTRAL-COST-PMT
242700                PPS-SITE-NEUTRAL-IPPS-PMT
242800                PPS-STANDARD-FULL-PMT
242900                PPS-STANDARD-SSO-PMT.
243000
243100
243200 7300-EXIT.
243300      EXIT.
243400
243500
243600***************************************************************
243700*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
243800*   UNIQUE CALCULATION FOR EACH CLAIM PAYMENT TYPE COMBO      *
243900***************************************************************
244000 8000-CALC-FINAL-PMT.
244100***************************************************************
244200
244300
244400*-------------------------------------------------------------*
244500* SUBCLAUSE II CLAIMS                                         *
244600*   P-NEW-FAC-SPEC-RATE = PER DIEM PMT RATE FOR SUBCLAUSE II  *
244700*-------------------------------------------------------------*
244800     IF SUBCLAUSEII-PROV
244900        COMPUTE PPS-FINAL-PAY-AMT ROUNDED =
245000                P-NEW-FAC-SPEC-RATE *
245100                B-CST-RPT-DAYS
245200        GO TO 8000-EXIT
245300     END-IF.
245400
245500
245600*-------------------------------------------------------------*
245700* OLD POLICY CLAIMS (100% STANDARD PAYMENT)                   *
245800*-------------------------------------------------------------*
245900     IF PMT-STANDARD-OLD
246000        COMPUTE PPS-FINAL-PAY-AMT =
246100                PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
246200     END-IF.
246300
246400
246500*-------------------------------------------------------------*
246600* NEW POLICY CLAIMS (ANY PAYMENT TYPE)                        *
246700*     - ONLY APPLICABLE PAYMENT FIELDS CONTAIN VALUES > $0    *
246800*     - APPLY BUDGET NEUTRALITY AND/OR BLEND TO PAYMENT       *
246900*       IF NEEDED                                             *
247000*     - ANY APPLICABLE BUDGET NEUTRALITY AND/OR BLEND WAS     *
247100*       ALREADY APPLIED TO OUTLIER PAYMENT                    *
247200*-------------------------------------------------------------*
247300     IF NOT PMT-STANDARD-OLD
247400
247500*-------------------------------------------------------*
247600* APPLY BUDGET NEUTRALITY TO 100% SITE-NEUTRAL PAYMENTS *
247700*-------------------------------------------------------*
247800        IF PMT-SITE-NEUTRAL
247900           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
248000                   PPS-SITE-NEUTRAL-COST-PMT *
248100                   H-BDGT-NEUT-FACTOR
248200
248300           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
248400                   PPS-SITE-NEUTRAL-IPPS-PMT *
248500                   H-BDGT-NEUT-FACTOR
248600        END-IF
248700
248800
248900*-------------------------------------------------------*
249000* APPLY BLEND PERCENTS & BUDGET NEUT TO BLENDED PAYMENTS*
249100*-------------------------------------------------------*
249200        IF PMT-BLEND
249300           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
249400                   PPS-SITE-NEUTRAL-COST-PMT *
249500                   H-BDGT-NEUT-FACTOR *
249600                   H-BLEND-SNT
249700
249800           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
249900                   PPS-SITE-NEUTRAL-IPPS-PMT *
250000                   H-BDGT-NEUT-FACTOR *
250100                   H-BLEND-SNT
250200
250300           COMPUTE PPS-STANDARD-FULL-PMT ROUNDED =
250400                   PPS-STANDARD-FULL-PMT * H-BLEND-STD
250500
250600           COMPUTE PPS-STANDARD-SSO-PMT ROUNDED =
250700                   PPS-STANDARD-SSO-PMT * H-BLEND-STD
250800        END-IF
250900
251000
251100*-------------------------------------------------------*
251200* SUM PAYMENT FIELDS FOR FINAL PAYMENT                  *
251300*-------------------------------------------------------*
251400        COMPUTE PPS-FINAL-PAY-AMT =
251500                PPS-STANDARD-FULL-PMT +
251600                PPS-STANDARD-SSO-PMT +
251700                PPS-SITE-NEUTRAL-COST-PMT +
251800                PPS-SITE-NEUTRAL-IPPS-PMT +
251900                PPS-OUTLIER-PAY-AMT
252000     END-IF.
252100
252200
252300 8000-EXIT.
252400      EXIT.
252500
252600
252700***************************************************************
252800 9000-MOVE-RESULTS.
252900***************************************************************
253000
253100
253200*-------------------------------------------------------------*
253300* IF CLAIM PRICED, MOVE LENGTH OF STAY & VERSION TO OUTPUT    *
253400*-------------------------------------------------------------*
253500     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
253600        MOVE H-LOS TO PPS-LOS
253700        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
253800
253900*-------------------------------------------------------------*
254000* IF CLAIM DIDN'T PRICE DUE TO AN ERROR, INITIALIZE ALL       *
254100* OUTPUT DATA EXCEPT FOR PPS-RTC AND PPS-CHRG-THRESHOLD,      *
254200* INITIALIZE WORK VARIABLES, AND MOVE VERSION TO OUTPUT       *
254300*-------------------------------------------------------------*
254400     ELSE
254500       INITIALIZE PPS-DATA
254600       INITIALIZE PPS-OTHER-DATA
254700       INITIALIZE PPS-CBSA
254800       INITIALIZE HOLD-PPS-COMPONENTS
254900       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
255000     END-IF.
255100
255200
255300*** *************************************************** ***
255400*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***
255500*** *************************************************** ***
255600*
255700*    IF (B-PROVIDER-NO = '332006')
255800*    IF (B-PROVIDER-NO = '341501' OR
255900*                        '341502' OR
256000*                        '342015' OR
256100*                        '391504' OR
256200*                        '391505' OR
256300*                        '371506' OR
256400*                        '371507' OR
256500*                        '441508' OR
256600*                        '442006' OR
256700*                        '36150A' OR
256800*                        '36150B' OR
256900*                        '37150C' OR
257000*                        '37150D' OR
257100*                        '02150E' OR
257200*                        '332006' OR
257300*                        '311501' OR
257400*                        '391502' OR
257500*                        '671503' OR
257600*                        '361504' OR
257700*                        '39150L' OR
257800*                        '051506' OR
257900*                        '091508' OR
258000*                        '401507' OR
258100*                        '3416B1' OR
258200*                        '3416B2' OR
258300*                        '3416B3' OR
258400*                        '3416B4' OR
258500*                        '3916B5' OR
258600*                        '3916B6' OR
258700*                        '3916B7' OR
258800*                        '3916B8' OR
258900*                        '3416B9' OR
259000*                        '3416B0' OR
259100*                        '3416BA' OR
259200*                        '3416BB' OR
259300*                        '1116BC' OR
259400*                        '1116BD' OR
259500*                        '1116BE' OR
259600*                        '1116BF' OR
259700*                        '1116BG' OR
259800*                        '1116BH' OR
259900*                        '3416BI' OR
260000*                        '1116BJ' OR
260100*                        '1116BK' OR
260200*                        '3716BL' OR
260300*                        '3716BM' OR
260400*                        '3716BN' OR
260500*                        '3716BO' OR
260600*                        '3716BP' OR
260700*                        '3716BQ' OR
260800*                        '3716BR' OR
260900*                        '3716BS' OR
261000*                        '4516BT' OR
261100*                        '4516BU' OR
261200*                        '3416BV' OR
261300*                        '1116BW' OR
261400*                        '1116BX' OR
261500*                        '1116BY' OR
261600*                        '3716BZ' OR
261700*                        '371601' OR
261800*                        '041602' OR
261900*                        '141603' OR
262000*                        '141604' OR
262100*                        '141605' OR
262200*                        '141606' OR
262300*                        '141607' OR
262400*                        '141608' OR
262500*                        '141609' OR
262600*                        '141600' OR
262700*                        '14160A' OR
262800*                        '14160B' OR
262900*                        '12160C' OR
263000*                        '12160D' OR
263100*                        '12160E' OR
263200*                        '12160F' OR
263300*                        '12160G' OR
263400*                        '12160H' OR
263500*                        '12160I' OR
263600*                        '12160J' OR
263700*                        '14160K' OR
263800*                        '14160L' OR
263900*                        '14160M' OR
264000*                        '14160N' OR
264100*                        '14160O' OR
264200*                        '14160P' OR
264300*                        '14160Q' OR
264400*                        '34160R' OR
264500*                        '34160S' OR
264600*                        '34160T' OR
264700*                        '39160U' OR
264800*                        '39160V' OR
264900*                        '37160W' )
265000*
265100*    DISPLAY '---------------------------------------------'
265200*    DISPLAY '*********************************************'
265300*    DISPLAY '---------------------------------------------'
265400*    DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
265500*    DISPLAY 'PPS-RTC '                  PPS-RTC
265600*    DISPLAY 'PSF EFFECTIVE DATE '       P-NEW-EFF-DATE
265700*    DISPLAY 'CBSA EFF DATE '            W-EFF-DATE
265800*    DISPLAY 'BILL DISCHARGE DATE '      B-DISCHARGE-DATE
265900*    DISPLAY 'P-NEW-FAC-SPEC-RATE '      P-NEW-FAC-SPEC-RATE
266000*    DISPLAY 'COST REPORT DAYS '         B-CST-RPT-DAYS
266100*    DISPLAY 'WS-PRIMARY-PMT-TYPE '      WS-PRIMARY-PMT-TYPE
266200*    DISPLAY 'WS-SECONDARY-PMT-TYPE-SNT' WS-SECONDARY-PMT-TYPE-SNT
266300*    DISPLAY 'WS-SECONDARY-PMT-TYPE-STD' WS-SECONDARY-PMT-TYPE-STD
266400*    DISPLAY 'B-REVIEW-CODE '            B-REVIEW-CODE
266500*    DISPLAY 'B-PROCEDURE-CODE-TABLE '   B-PROCEDURE-CODE-TABLE
266600*    DISPLAY 'WS-VENT-STATUS '           WS-VENT-STATUS
266700*    DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT
266800*    DISPLAY 'PPS-SITE-NEUTRAL-COST-PM ' PPS-SITE-NEUTRAL-COST-PMT
266900*    DISPLAY 'PPS-SITE-NEUTRAL-IPPS-PM ' PPS-SITE-NEUTRAL-IPPS-PMT
267000*    DISPLAY 'PPS-STANDARD-FULL-PMT '    PPS-STANDARD-FULL-PMT
267100*    DISPLAY 'PPS-STANDARD-SSO-PMT '     PPS-STANDARD-SSO-PMT
267200*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
267300*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
267400*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
267500*    DISPLAY 'PPS-FAC-COSTS '            PPS-FAC-COSTS
267600*    DISPLAY 'H-FIXED-LOSS-AMT-STD '     H-FIXED-LOSS-AMT-STD
267700*    DISPLAY 'H-FIXED-LOSS-AMT-SNT '     H-FIXED-LOSS-AMT-SNT
267800*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
267900*    DISPLAY 'H-OUTLIER-THRESHOLD-STD '  H-OUTLIER-THRESHOLD-STD
268000*    DISPLAY 'PPS-CHRG-THRESHOLD '       PPS-CHRG-THRESHOLD
268100*    DISPLAY 'H-BDGT-NEUT-FACTOR '       H-BDGT-NEUT-FACTOR
268200*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
268300*    DISPLAY 'PPS-CBSA '                 PPS-CBSA
268400*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
268500*    DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
268600*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
268700*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
268800*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE
268900*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
269000*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
269100*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
269200*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
269300*    DISPLAY 'H-LOS '                    H-LOS
269400*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS
269500*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
269600*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
269700*    DISPLAY 'H-BLEND-SNT '              H-BLEND-SNT
269800*    DISPLAY 'H-BLEND-STD '              H-BLEND-STD
269900*    DISPLAY 'P-NEW-OPER-CSTCHG-RATIO '  P-NEW-OPER-CSTCHG-RATIO
270000*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
270100*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
270200*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
270300*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
270400*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
270500*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
270600*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
270700*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
270800*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
270900*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
271000*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
271100*    DISPLAY 'H-SSOT '                   H-SSOT
271200*    DISPLAY 'H-SS-COST '                H-SS-COST
271300*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
271400*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
271500*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
271600*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
271700*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
271800*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
271900*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
272000*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
272100*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE
272200*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
272300*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
272400*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
272500*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
272600*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
272700*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
272800*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND
272900*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
273000*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
273100*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
273200*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
273300*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
273400*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
273500*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
273600*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
273700*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
273800*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
273900*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
274000*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
274100*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
274200*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
274300*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
274400*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
274500*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
274600*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
274700*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
274800*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
274900*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
275000*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
275100*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
275200*    DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT
275300*    DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT
275400*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
275500*
275600*    END-IF.
275700
275800 9000-EXIT.
275900      EXIT.
276000
276100******        L A S T   S O U R C E   S T A T E M E N T   *****
