000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL183.
000300*AUTHOR.         CMS.
000400*REMARKS.        EFFECTIVE DATE = OCTOBER 1, 2017
000500***********************************************************
000600*
000700* UPDATED MARCH 8, 2018.
000800* VERSION 18.3.
000900* IMPLEMENTATION DATE = APRIL 1, 2018.
001000* IMPLEMENTS CR10547 - INPATIENT PROSPECTIVE PAYMENT SYSTEM
001100* (IPPS) AND LONG-TERM CARE HOSPITAL (LTCH) PER THE ADVANCING
001200* CHRONIC CARE, EXTENDERS, AND SOCIAL SERVICES (ACCESS) ACT
001300* INCLUDED IN THE BIPARTISAN BUDGET ACT OF 2018.
001400* - CHANGED SITE-NEUTRAL CALCULATION.
001500*
001600* VERSION 18.2, IMPLEMENTATED ON JANUARY 1, 2018, MADE THE
001700* FOLLOWING CHANGES.
001800* IMPLEMENTS CR10368 - OFF-CYCLE UPDATE TO THE LONG TERM CARE
001900* HOSPITAL (LTCH) PROSPECTIVE PAYMENT SYSTEM (PPS) FISCAL YEAR
002000* (FY) 2018 PRICER.
002100* - UPDATED THE LTCH WAGE INDEX.
002200*
002300*
002400* VERSION 18.1, IMPLEMENTED ON OCTOBER 1, 2017, MADE THE
002500* FOLLOWING CHANGES:
002600*
002700* - NEW FOR FY18, SHORT-STAY OUTLIERS (SSO) CASES ARE PAID ONLY
002800*   THE 'BLENDED PAYMENT OPTION.' THAT MEANS THAT THE CODE USED
002900*   TO CALCULATE OTHER SSO PAYMENT OPTIONS, AS WELL AS THE CODE
003000*   THAT COMPARES THE OTHER OPTIONS, HAS BEEN REMOVED FOR THIS
003100*   VERSION. THIS ALSO MEANS THAT THE IPPS THRESHOLD IS NOT BEING
003200*   USED IN ANY CALCULATIONS THEREFORE IT HAS BEEN REMOVED.
003300*
003400* - IN ADDITION, SUBCLAUSE II IS NO LONGER DONE BY THE LTCH PRICER
003500*   THEREFORE THE CODE HAS BEEN REMOVED.
003600*
003700*
003800* FROM THE FY 2018 LTCH PPS PRICER SPEC SHEET
003900* (UPDATED FOR FINAL RULE AS OF 8-2-2017)
004000*
004100* PRICER STANDARD FEDERAL RATES/FACTORS/POLICY:
004200*
004300* STANDARD FEDERAL RATES (BASED ON QUALITY DATA REPORT STATUS
004400* FOR FY18):
004500*
004600* * FULL UPDATE (QUALITY INDICATOR ON PSF = 1): $41415.11
004700* * REDUCED UPDATE (QUALITY INDICATOR ON PSF = 0 OR BLANK):
004800* $40595.02
004900*
005000* LABOR SHARE: 66.2% (0.662)
005100*
005200* NONLABOR SHARE: 33.8% (0.338)
005300*
005400* MS-LTC-DRG WEIGHTS/LENGTH OF STAY TABLE. NOTE THAT, DUE TO
005500* CHANGES IN THE SSO PAYMENT POLICY, THE IPPS THRESHOLD IS NO
005600* LONGER APPLICABLE.
005700*
005800* HIGH COST OUTLIER FIXED-LOSS AMOUNTS (NO POLICY/CALCULATION
005900* LOGIC CHANGES)
006000*
006100* * STANDARD RATE CASES: $27381
006200* * SITE NEUTRAL RATE CASES: $26537
006300*
006400* SITE NEUTRAL RATE HCO BUDGET NEUTRALITY FACTOR: 0.949 (NO
006500* POLICY/CALCULATION LOGIC CHANGES)
006600* * APPLIED TO TOTAL SITE NEUTRAL PAYMENT RATE AMOUNT PRIOR TO
006700*   APPLYING 50% TRANSITION BLEND FACTOR, WHEN APPLICABLE
006800* * ONLY APPLY TO NON-HCO PORTION OF THE SITE NEUTRAL PAYMENT
006900*   RATE AMOUNT AND DO NOT APPLY TO THE ANY APPLICABLE SITE
007000*   NEUTRAL PAYMENT RATE HCO PAYMENT
007100*
007200* SHORT-STAY OUTLIER (SSO):
007300* LOGIC TO PAYMENT CHANGES EFFECTIVE FOR DISCHARGES OCCURRING
007400* ON/AFTER OCTOBER 1, 2017 (FY 2018):
007500* - THE DEFINITION OF SSO REMAINS THE SAME. THAT IS, THE
007600*   SHORT STAY THRESHOLD CONTINUES TO BE CASES WHOSE COVERED
007700*   LENGTH OF STAY LESS THAN OR EQUAL TO 5/6TH OF THE
007800*   GEOMETRIC MEAN OF THE LENGTH OF STAY FOR THAT DRG.
007900* - SSO CASES ARE PAID USING ONLY THE 'BLENDED PAYMENT OPTION'
008000*   FROM THE FY 2017 SSO PAYMENT POLICY (I.E., THERE IS ONLY
008100*   ONE PAYMENT CALCULATION FOR SSO CASES; THERE IS NO LONGER
008200*   A 'LESSER OF' FORMULA).
008300*
008400* SSO AND SITE NEUTRAL RATE PAYMENTS IPPS RATES/FACTORS:
008500*
008600* IPPS LABOR SHARE WAGE INDEX > 1: $3806.04
008700* IPPS NONLABOR SHARE WAGE INDEX > 1: $1766.49
008800* IPPS LABOR SHARE WAGE INDEX < /= 1:  $3454.97
008900* IPPS NONLABOR SHARE WAGE INDEX < /= 1:  $2117.56
009000* CAPITAL NATIONAL RATE: $453.95
009100*
009200* * REDUCTION FACTOR FOR IPPS COMPARABLE OPERATING DSH PAYMENT
009300* AMOUNT: 68.51% OR A FACTOR OF 0.6851. (THIS REDUCTION IS NOT
009400* APPLIED TO THE CAPITAL DSH PAYMENT CALCULATION.)
009500*
009600* * USE FY 2018 IPPS AREA WAGE INDEXES & MS-DRG WEIGHTS/LENGTH
009700* OF STAY
009800*
009900* SPECIAL TREATMENT - PROVIDER 332006 (CALVARY HOSPITAL/FORMER
010000* SUBCLAUSE (II)) - PAYMENT LOGIC IN PRICER SPECIFIC TO THIS
010100* PROVIDER IS NO LONGER NEEDED SINCE UNDER CR 9912 (TRANSMITTAL
010200* 179; FEBRUARY 3, 2017) CLAIMS FROM SUCH LTCH WITH A DISCHARGE
010300* DATE ON OR AFTER JANUARY 1, 2017 SHALL NO LONGER PROCESS
010400* THROUGH THE LTCH PRICER.
010500*
010600***********************************************************
010700 ENVIRONMENT DIVISION.
010800 CONFIGURATION SECTION.
010900 SOURCE-COMPUTER.            IBM-370.
011000 OBJECT-COMPUTER.            IBM-370.
011100 INPUT-OUTPUT  SECTION.
011200 FILE-CONTROL.
011300
011400 DATA DIVISION.
011500 FILE SECTION.
011600
011700 WORKING-STORAGE SECTION.
011800 01  W-STORAGE-REF                  PIC X(46)  VALUE
011900     'LTCAL183      - W O R K I N G   S T O R A G E'.
012000 01  CAL-VERSION                    PIC X(05)  VALUE 'V18.3'.
012100 01  PROGRAM-CONSTANTS.
012200     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
012300     05  VENT-ICD-10-CODE           PIC X(07) VALUE '5A1955Z'.
012400 01  PROGRAM-FLAGS.
012500     05  WS-PRIMARY-PMT-TYPE        PIC X(01).
012600         88 PMT-STANDARD-OLD       VALUE '1'.
012700         88 PMT-STANDARD-NEW       VALUE '2'.
012800         88 PMT-SITE-NEUTRAL       VALUE '3'.
012900         88 PMT-BLEND              VALUE '4'.
013000     05  WS-SECONDARY-PMT-TYPE-SNT  PIC X(01).
013100         88 PMT-SITE-NEUT-COST     VALUE '1'.
013200         88 PMT-SITE-NEUT-IPPS     VALUE '2'.
013300     05  WS-SECONDARY-PMT-TYPE-STD  PIC X(01).
013400         88 PMT-STANDARD-FULL      VALUE '1'.
013500         88 PMT-STANDARD-SSO       VALUE '2'.
013600     05  WS-VENT-STATUS             PIC X(01).
013700         88 VENT-PRESENT           VALUE 'Y'.
013800         88 VENT-NOT-PRESENT       VALUE 'N'.
013900
014000
014100***************************************************************
014200*    LAYUP TABLE AREA FOR FY2018 LTC-DRG                      *
014300*    EFFECTIVE DATE OF OCTOBER 1, 2017                        *
014400***************************************************************
014500 COPY LTDRG181.
014600
014700
014800***************************************************************
014900*    LAYUP TABLE AREA FOR FY2018 IPPS-DRG                     *
015000*    EFFECTIVE DATE OF OCTOBER 1, 2017                        *
015100***************************************************************
015200 COPY IPDRG181.
015300
015400
015500***************************************************************
015600*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
015700***************************************************************
015800 01  HOLD-PPS-COMPONENTS.
015900     05  H-LOS                        PIC 9(03).
016000     05  H-REG-DAYS                   PIC 9(03).
016100     05  H-TOTAL-DAYS                 PIC 9(05).
016200     05  H-SSOT                       PIC 9(02)V9(01).
016300     05  H-BLEND-RTC                  PIC 9(02).
016400     05  H-BLEND-SNT                  PIC 9(01)V9(01).
016500     05  H-BLEND-STD                  PIC 9(01)V9(01).
016600     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
016700     05  H-SS-COST                    PIC 9(07)V9(02).
016800     05  H-LABOR-PORTION              PIC 9(07)V9(06).
016900     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
017000     05  H-FIXED-LOSS-AMT-STD         PIC 9(07)V9(02).
017100     05  H-FIXED-LOSS-AMT-SNT         PIC 9(07)V9(02).
017200     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
017300     05  H-LOS-RATIO                  PIC 9(01)V9(05).
017400
017500*** --------------------------------------------------- ***
017600*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
017700*** --------------------------------------------------- ***
017800     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
017900     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
018000     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
018100     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
018200     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
018300     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
018400     05  H-INTERN-RATIO               PIC 9(01)V9(04).
018500     05  H-CAPI-IME-RATIO             PIC 9V9999.
018600     05  H-BED-SIZE                   PIC 9(05).
018700     05  H-OPER-DSH-PCT               PIC V9(04).
018800     05  H-SSI-RATIO                  PIC V9(04).
018900     05  H-MEDICAID-RATIO             PIC V9(04).
019000     05  H-OPER-DSH                   PIC 9(01)V9(04).
019100     05  H-CAPI-DSH                   PIC 9(01)V9(04).
019200     05  H-GEO-CLASS                  PIC X(01).
019300     05  H-URBAN-IND                  PIC X(01).
019400           88 URBAN-CBSA           VALUE '1'.
019500           88 RURAL-CBSA           VALUE '0'.
019600     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
019700     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
019800     05  H-CAPI-PMT                   PIC 9(07)V9(02).
019900     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
020000     05  H-CAPI-GAF                   PIC 9(05)V9(04).
020100     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
020200     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
020300     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
020400     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
020500     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
020600     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
020700     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
020800     05  H-OPER-COLA                  PIC 9(01)V9(03).
020900     05  H-CAPI-COLA                  PIC 9(01)V9(03).
021000     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
021100     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
021200     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
021300     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
021400     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
021500     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
021600     05  H-IPPS-DAYS-CUTOFF           PIC 9(02)V9(01).
021700     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
021800     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
021900     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
022000*    05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
022100*    05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
022200     05  H-NAT-OPER-IPPS-PMT-PCT      PIC 9(01)V9(02).
022300     05  H-PR-OPER-IPPS-PMT-PCT       PIC 9(01)V9(02).
022400     05  H-NAT-CAPI-IPPS-PMT-PCT      PIC 9(01)V9(02).
022500     05  H-PR-CAPI-IPPS-PMT-PCT       PIC 9(01)V9(02).
022600     05  H-COUNTER                    PIC 9(02).
022700     05  H-IPPS-WAGE-INDEX            PIC 9(02)V9(04).
022800     05  H-OPER-DSH-REDUCTION-FACTOR  PIC V9(04).
022900     05  H-OUTLIER-THRESHOLD-STD      PIC 9(07)V9(02).
023000     05  H-BDGT-NEUT-FACTOR           PIC 9(01)V9(06).
023100     05  H-OUTLIER-PAY-AMT-STD        PIC 9(07)V9(02).
023200     05  H-OUTLIER-PAY-AMT-SNT        PIC 9(07)V9(02).
023300     05  H-OUTLIER-IPPS-COMPARABLE    PIC 9(07)V9(02).
023400     05  H-SN-COST-4COMPARISON        PIC 9(07)V9(02).
023500     05  H-SN-IPPS-4COMPARISON        PIC 9(07)V9(02).
023600     05  H-SITE-NEUTRAL-IPPS-ADJ      PIC 9(01)V9(06).
023700
023800*** --------------------------------------------------- ***
023900*** VARIABLES FOR PC PRICER                             ***
024000*** --------------------------------------------------- ***
024100     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
024200     05  H-SS-COST-IND                PIC X.
024300     05  H-SS-PERDIEM-IND             PIC X.
024400     05  H-SS-BLEND-IND               PIC X.
024500     05  H-SS-IPPSCOMP-IND            PIC X.
024600
024700
024800*---------------------------------------------------------*
024900* 8-6-14 ADDED WK-HLDDRG-DATA AND WK-HLDDRG-DATA2 TO      *
025000* MATCH THE IPPS DRG TABLE DATA NAMES THAT WERE COPIED    *
025100* FROM THE FY14 IPPS PRICER CALCULATION PROGRAM           *
025200*---------------------------------------------------------*
025300
025400 01 WK-HLDDRG-DATA.
025500     05  HLDDRG-DATA.
025600         10  HLDDRG-DRGX               PIC X(03).
025700         10  FILLER1                   PIC X(01).
025800         10  HLDDRG-WEIGHT             PIC 9(02)V9(04).
025900         10  FILLER2                   PIC X(01).
026000         10  HLDDRG-GMALOS             PIC 9(02)V9(01).
026100         10  FILLER3                   PIC X(05).
026200         10  HLDDRG-LOW                PIC X(01).
026300         10  FILLER5                   PIC X(01).
026400         10  HLDDRG-ARITH-ALOS         PIC 9(02)V9(01).
026500         10  FILLER6                   PIC X(02).
026600         10  HLDDRG-PAC                PIC X(01).
026700         10  FILLER7                   PIC X(01).
026800         10  HLDDRG-SPPAC              PIC X(01).
026900         10  FILLER8                   PIC X(02).
027000         10  HLDDRG-DESC               PIC X(26).
027100
027200 01 WK-HLDDRG-DATA2.
027300     05  HLDDRG-DATA2.
027400         10  HLDDRG-DRGX2               PIC X(03).
027500         10  FILLER21                   PIC X(01).
027600         10  HLDDRG-WEIGHT2             PIC 9(02)V9(04).
027700         10  FILLER22                   PIC X(01).
027800         10  HLDDRG-GMALOS2             PIC 9(02)V9(01).
027900         10  FILLER23                   PIC X(05).
028000         10  HLDDRG-LOW2                PIC X(01).
028100         10  FILLER25                   PIC X(01).
028200         10  HLDDRG-ARITH-ALOS2         PIC 9(02)V9(01).
028300         10  FILLER26                   PIC X(02).
028400         10  HLDDRG-TRANS-FLAGS.
028500                   88  D-DRG-POSTACUTE-50-50
028600                   VALUE 'Y Y'.
028700                   88  D-DRG-POSTACUTE-PERDIEM
028800                   VALUE 'Y  '.
028900             15  HLDDRG-PAC2            PIC X(01).
029000             15  FILLER27               PIC X(01).
029100             15  HLDDRG-SPPAC2          PIC X(01).
029200         10  FILLER28                   PIC X(02).
029300         10  HLDDRG-DESC2               PIC X(26).
029400         10  HLDDRG-VALID               PIC X(01).
029500
029600
029700
029800
029900
030000 LINKAGE SECTION.
030100
030200**************************************************************
030300* THE LINKAGE SECTION CONTAINS DESCRIPTIONS OF THE FIELDS THAT
030400* CONTAIN VALUES THAT ARE PASSED FROM THE CALLING PROGRAM
030500* (LTDRV... IN THIS CASE)
030600**************************************************************
030700
030800
030900**************************************************************
031000* BILL-NEW-DATA IS THE BILL RECORD FROM THE LTDRV... PROGRAM
031100**************************************************************
031200 01  BILL-NEW-DATA.
031300     10  B-NPI10.
031400         15  B-NPI8               PIC X(08).
031500         15  B-NPI-FILLER         PIC X(02).
031600     10  B-PROVIDER-NO            PIC X(06).
031700     10  B-PATIENT-STATUS         PIC X(02).
031800     10  B-DRG-CODE               PIC 9(03).
031900     10  B-LOS                    PIC 9(03).
032000     10  B-COV-DAYS               PIC 9(03).
032100     10  B-LTR-DAYS               PIC 9(02).
032200     10  B-CST-RPT-DAYS           PIC 9(03).
032300     10  B-DISCHARGE-DATE.
032400         15  B-DISCHG-CC          PIC 9(02).
032500         15  B-DISCHG-YY          PIC 9(02).
032600         15  B-DISCHG-MM          PIC 9(02).
032700         15  B-DISCHG-DD          PIC 9(02).
032800     10  B-COV-CHARGES            PIC 9(07)V9(02).
032900     10  B-SPEC-PAY-IND           PIC X(01).
033000     05  B-REVIEW-CODE            PIC 9(02).
033100     05  B-DIAGNOSIS-CODE-TABLE.
033200         10  B-DIAGNOSIS-CODE     PIC X(07) OCCURS 25 TIMES
033300                                  INDEXED BY IDX-DIAG.
033400     05  B-PROCEDURE-CODE-TABLE.
033500         10  B-PROCEDURE-CODE     PIC X(07) OCCURS 25 TIMES
033600                                  INDEXED BY IDX-PROC.
033700     05  FILLER                   PIC X(20).
033800
033900
034000***************************************************************
034100***************************************************************
034200*                                                             *
034300*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *
034400*    AND PASSED BACK TO THE CALLING PROGRAM (LTDRV)           *
034500*    RETURN CODE VALUES (PPS-RTC)                             *
034600*                                                             *
034700*     ** OLD POLICY RETURN CODE VALUES AND DESCRIPTIONS       *
034800*     ** ----------------------------------------------       *
034900*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
035000*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
035100*                                                             *
035200*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
035300*                                                             *
035400*             02 = SHORT STAY PAYMENT WITHOUT OUTLIER         *
035500*                                                             *
035600*             03 = SHORT STAY PAYMENT WITH OUTLIER            *
035700*                                                             *
035800*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
035900*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
036000*                                                             *
036100*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
036200*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
036300*                                                             *
036400*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
036500*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
036600*                                                             *
036700*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
036800*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
036900*                                                             *
037000*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
037100*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
037200*                                                             *
037300*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
037400*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
037500*                                                             *
037600*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
037700*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
037800*                                                             *
037900*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
038000*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
038100*                                                             *
038200*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
038300*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
038400*                                                             *
038500*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
038600*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
038700*                                                             *
038800*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
038900*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
039000*                                                             *
039100*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
039200*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
039300*                                                             *
039400*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
039500*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
039600*                                                             *
039700*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
039800*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
039900*                                                             *
040000*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
040100*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
040200*                                                             *
040300*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
040400*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
040500*                                                             *
040600*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
040700*                  WITHOUT OUTLIER                            *
040800*                                                             *
040900*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
041000*                  DIEM WITHOUT OUTLIER                       *
041100*                                                             *
041200*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
041300*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
041400*                  AMOUNT WITHOUT OUTLIER                     *
041500*                                                             *
041600*             23 = SHORT STAY PAYMENT BASED ON ESTIMATED      *
041700*                  COST WITH OUTLIER                          *
041800*                                                             *
041900*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
042000*                  DIEM WITH OUTLIER                          *
042100*                                                             *
042200*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
042300*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
042400*                  AMOUNT WITH OUTLIER                        *
042500*                                                             *
042600*      ****  RETURN CODES 26 & 27 ARE NOT RETURNED AS OF      *
042700*            12/29/2008 (SHORT-STAYS NO LONGER ELIGIBLE       *
042800*            FOR IPPS COMPARABLE PER DIEM)                    *
042900*      ****  RETURN CODES 26 & 27 ARE NOW RETURNED AS OF      *
043000*            12/29/2012 (SHORT-STAYS ARE ELIGIBLE             *
043100*            FOR IPPS COMPARABLE PER DIEM)                    *
043200*                                                             *
043300*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
043400*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
043500*                                                             *
043600*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
043700*                  COMPARABLE THRESHOLD WITH OUTLIER          *
043800*                                                             *
043900*             28 = SUBCLAUSE (II) DOES NOT QUALIFY FOR AN     *
044000*                  OUTLIER                                    *
044100*                                                             *
044200*             29 = SUBCLAUSE (II) QUALIFIES FOR AN OUTLIER    *
044300*                                                             *
044400*                                                             *
044500*     ** OLD & NEW POLICY ERROR CODE VALUES AND DESCRIPTIONS  *
044600*     ** ---------------------------------------------------  *
044700*     *****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
044800*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
044900*             51 = PROVIDER RECORD TERMINATED                 *
045000*             52 = INVALID WAGE INDEX                         *
045100*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
045200*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
045300*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
045400*                                     OR                      *
045500*                  DISCHARGE DATE < CBSA EFF START DATE       *
045600*                  FOR PPS                                    *
045700*             56 = INVALID LENGTH OF STAY                     *
045800*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
045900*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
046000*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
046100*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
046200*                  OR BILL-LTR-DAYS > 60                      *
046300*             62 = INVALID NUMBER OF COVERED DAYS             *
046400*                  OR BILL-LTR-DAYS > COVERED DAYS            *
046500*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
046600*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
046700*                  OR COST OUTLIER THRESHOLD CALCULATION      *
046800*             68 = PROVIDER SPECIFIC STATE CODE INVALID       *
046900*             72 = INVALID BLEND INDICATOR OR REVIEW CODE     *
047000*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
047100*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
047200*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *
047300*                                                             *
047400*                                                             *
047500*             ADDITIONAL RETURN CODES STARTING IN 2016:       *
047600*                                                             *
047700*             A0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
047800*                  PSYCH/REHAB                                *
047900*                                                             *
048000*             A1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
048100*                  OUTLIER, PSYCH/REHAB                       *
048200*                                                             *
048300*             A2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
048400*                  SSO, PSYCH/REHAB                           *
048500*                                                             *
048600*             A3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
048700*                  SSO, OUTLIER, PSYCH/REHAB                  *
048800*                                                             *
048900*             A4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
049000*                  PSYCH/REHAB                                *
049100*                                                             *
049200*             A5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
049300*                  OUTLIER, PSYCH/REHAB                       *
049400*                                                             *
049500*             A6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
049600*                  SSO, PSYCH/REHAB                           *
049700*                                                             *
049800*             A7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
049900*                  SSO, OUTLIER, PSYCH/REHAB                  *
050000*                                                             *
050100*             AA = SITE-NEUTRAL BASED ON COST,                *
050200*                  PSYCH/REHAB                                *
050300*                                                             *
050400*             AB = SITE-NEUTRAL BASED ON IPPS,                *
050500*                  PSYCH/REHAB                                *
050600*                                                             *
050700*             AC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
050800*                  PSYCH/REHAB                                *
050900*                                                             *
051000*             B0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
051100*                  VENT                                       *
051200*                                                             *
051300*             B1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
051400*                  OUTLIER, VENT                              *
051500*                                                             *
051600*             B2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
051700*                  SSO, VENT                                  *
051800*                                                             *
051900*             B3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
052000*                  SSO, OUTLIER, VENT                         *
052100*                                                             *
052200*             B4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
052300*                  VENT                                       *
052400*                                                             *
052500*             B5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
052600*                  OUTLIER, VENT                              *
052700*                                                             *
052800*             B6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
052900*                  SSO, VENT                                  *
053000*                                                             *
053100*             B7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
053200*                  SSO, OUTLIER, VENT                         *
053300*                                                             *
053400*             BA = SITE-NEUTRAL BASED ON COST, VENT           *
053500*                                                             *
053600*             BB = SITE-NEUTRAL BASED ON IPPS, VENT           *
053700*                                                             *
053800*             BC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
053900*                  VENT                                       *
054000*                                                             *
054100*             BD = SSO STANDARD PAYMENT, VENT                 *
054200*                                                             *
054300*             BE = SSO STANDARD PAYMENT, OUTLIER, VENT        *
054400*                                                             *
054500*             BF = STANDARD PAYMENT FULL DRG, VENT            *
054600*                                                             *
054700*             BG = STANDARD PAYMENT FULL DRG, OUTLIER,        *
054800*                  VENT                                       *
054900*                                                             *
055000*             C0 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
055100*                  NO VENT                                    *
055200*                                                             *
055300*             C1 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
055400*                  OUTLIER, NO VENT                           *
055500*                                                             *
055600*             C2 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
055700*                  SSO, NO VENT                               *
055800*                                                             *
055900*             C3 = BLEND YR, SITE NEUTRAL BASED ON COST,      *
056000*                  SSO, OUTLIER, NO VENT                      *
056100*                                                             *
056200*             C4 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
056300*                  NO VENT                                    *
056400*                                                             *
056500*             C5 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
056600*                  OUTLIER, NO VENT                           *
056700*                                                             *
056800*             C6 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
056900*                  SSO, NO VENT                               *
057000*                                                             *
057100*             C7 = BLEND YR, SITE NEUTRAL BASED ON IPPS,      *
057200*                  SSO, OUTLIER, NO VENT                      *
057300*                                                             *
057400*             CA = SITE-NEUTRAL BASED ON COST, NO VENT        *
057500*                                                             *
057600*             CB = SITE-NEUTRAL BASED ON IPPS, NO VENT        *
057700*                                                             *
057800*             CC = SITE-NEUTRAL BASED ON IPPS, OUTLIER,       *
057900*                  NO VENT                                    *
058000*                                                             *
058100*             CD = SSO STANDARD PAYMENT, NO VENT              *
058200*                                                             *
058300*             CE = SSO STANDARD PAYMENT, OUTLIER,             *
058400*                  NO VENT                                    *
058500*                                                             *
058600*             CF = STANDARD PAYMENT FULL DRG, NO VENT         *
058700*                                                             *
058800*                                                             *
058900***************************************************************
059000***************************************************************
059100*
059200*
059300***************************************************************
059400* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
059500* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
059600***************************************************************
059700 01  PPS-DATA-ALL.
059800     05  PPS-RTC.
059900           88  OLD-ERROR-CODE        VALUE '50' THRU '99'.
060000         10  PPS-RTC-1                 PIC X.
060100               88  NEW-ERROR-CODE    VALUE 'D'.
060200         10  PPS-RTC-2                 PIC X.
060300     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
060400     05  PPS-DATA.
060500         10  PPS-MSA                   PIC X(04).
060600         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
060700         10  PPS-AVG-LOS               PIC 9(02)V9(01).
060800         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
060900         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
061000         10  PPS-LOS                   PIC 9(03).
061100         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
061200         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
061300         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
061400         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
061500         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
061600         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
061700         10  PPS-SUBM-DRG-CODE         PIC X(03).
061800               88  PSYCH-REHAB-DRG   VALUE
061900                   '876' '880' '881' '882' '883' '884'
062000                   '885' '887' '886' '894' '895' '896'
062100                   '897' '945' '946'.
062200         10  PPS-CALC-VERS-CD          PIC X(05).
062300         10  PPS-REG-DAYS-USED         PIC 9(03).
062400         10  PPS-LTR-DAYS-USED         PIC 9(03).
062500         10  PPS-BLEND-YEAR            PIC 9(01).
062600         10  PPS-COLA                  PIC 9(01)V9(03).
062700         10  FILLER                    PIC X(04).
062800     05  PPS-OTHER-DATA.
062900         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
063000         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
063100         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
063200         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
063300         10  PPS-IPTHRESH              PIC 9(03)V9(01).
063400         10  FILLER                    PIC X(16).
063500     05  PPS-PC-DATA.
063600         10  PPS-COT-IND               PIC X(01).
063700         10  H-PC-IND                  PIC X(02).
063800               88  PC-PRICER               VALUE 'PC'.
063900         10  FILLER                    PIC X(18).
064000
064100 01  PPS-CBSA                          PIC X(05).
064200
064300
064400 01  PPS-PAYMENT-DATA.
064500     05  PPS-SITE-NEUTRAL-COST-PMT     PIC 9(07)V99.
064600     05  PPS-SITE-NEUTRAL-IPPS-PMT     PIC 9(07)V99.
064700     05  PPS-STANDARD-FULL-PMT         PIC 9(07)V99.
064800     05  PPS-STANDARD-SSO-PMT          PIC 9(07)V99.
064900
065000
065100******************************************************************
065200*            THESE ARE THE VERSIONS OF THE LTDRV___              *
065300*           PROGRAMS THAT WILL BE PASSED BACK----                *
065400*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
065500******************************************************************
065600 01  PRICER-OPT-VERS-SW.
065700     05  PRICER-OPTION-SW          PIC X(01).
065800         88  ALL-TABLES-PASSED          VALUE 'A'.
065900         88  PROV-RECORD-PASSED         VALUE 'P'.
066000     05  PPS-VERSIONS.
066100         10  PPDRV-VERSION         PIC X(05).
066200
066300
066400**************************************************************
066500* PROV-NEW-HOLD IS THE PROVIDER RECORD THAT IS PASSED FROM   *
066600* LTDRV___) TO LTCAL___                                      *
066700**************************************************************
066800 01  PROV-NEW-HOLD.
066900     02  PROV-NEWREC-HOLD1.
067000         05  P-NEW-NPI10.
067100             10  P-NEW-NPI8             PIC X(08).
067200             10  P-NEW-NPI-FILLER       PIC X(02).
067300         05  P-NEW-PROVIDER-NO.
067400               88  SUBCLAUSEII-PROV       VALUE '332006'.
067500             10  P-NEW-STATE            PIC 9(02).
067600             10  FILLER                 PIC X(04).
067700         05  P-NEW-DATE-DATA.
067800             10  P-NEW-EFF-DATE.
067900                 15  P-NEW-EFF-DT-CC    PIC 9(02).
068000                 15  P-NEW-EFF-DT-YY    PIC 9(02).
068100                 15  P-NEW-EFF-DT-MM    PIC 9(02).
068200                 15  P-NEW-EFF-DT-DD    PIC 9(02).
068300             10  P-NEW-FY-BEGIN-DATE.
068400                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).
068500                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).
068600                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).
068700                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).
068800             10  P-NEW-REPORT-DATE.
068900                 15  P-NEW-REPORT-DT-CC PIC 9(02).
069000                 15  P-NEW-REPORT-DT-YY PIC 9(02).
069100                 15  P-NEW-REPORT-DT-MM PIC 9(02).
069200                 15  P-NEW-REPORT-DT-DD PIC 9(02).
069300             10  P-NEW-TERMINATION-DATE.
069400                 15  P-NEW-TERM-DT-CC   PIC 9(02).
069500                 15  P-NEW-TERM-DT-YY   PIC 9(02).
069600                 15  P-NEW-TERM-DT-MM   PIC 9(02).
069700                 15  P-NEW-TERM-DT-DD   PIC 9(02).
069800         05  P-NEW-WAIVER-CODE          PIC X(01).
069900             88  P-NEW-WAIVER-STATE       VALUE 'Y'.
070000         05  P-NEW-INTER-NO             PIC 9(05).
070100         05  P-NEW-PROVIDER-TYPE        PIC X(02).
070200         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
070300         05  P-NEW-CURRENT-DIV   REDEFINES
070400                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
070500         05  P-NEW-MSA-DATA.
070600             10  P-NEW-CHG-CODE-INDEX       PIC X.
070700             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT.
070800             10  P-NEW-GEO-LOC-MSA9   REDEFINES
070900                             P-NEW-GEO-LOC-MSAX  PIC 9(04).
071000             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT.
071100             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT.
071200             10  P-NEW-STAND-AMT-LOC-MSA9
071300                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.
071400                 15  P-NEW-RURAL-1ST.
071500                     20  P-NEW-STAND-RURAL  PIC XX.
071600                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.
071700                 15  P-NEW-RURAL-2ND        PIC XX.
071800         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.
071900         05  P-NEW-LUGAR                    PIC X.
072000         05  P-NEW-TEMP-RELIEF-IND          PIC X.
072100         05  P-NEW-FED-PPS-BLEND-IND        PIC X.
072200         05  P-NEW-STATE-CODE               PIC 9(02).
072300         05  P-NEW-STATE-CODE-X REDEFINES
072400               P-NEW-STATE-CODE             PIC X(02).
072500         05  FILLER                         PIC X(03).
072600     02  PROV-NEWREC-HOLD2.
072700         05  P-NEW-VARIABLES.
072800             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).
072900             10  P-NEW-COLA              PIC  9(01)V9(03).
073000             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).
073100             10  P-NEW-BED-SIZE          PIC  9(05).
073200             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).
073300             10  P-NEW-CMI               PIC  9(01)V9(04).
073400             10  P-NEW-SSI-RATIO         PIC  V9(04).
073500             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).
073600             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).
073700             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).
073800             10  P-NEW-DSH-PERCENT       PIC  V9(04).
073900             10  P-NEW-FYE-DATE          PIC  X(08).
074000         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).
074100         05  P-NEW-HOSP-QUAL-IND           PIC X(01).
074200         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.
074300         05  P-NEW-GEO-LOC-CBSA9 REDEFINES
074400                       P-NEW-GEO-LOC-CBSAX PIC 9(05).
074500         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES
074600                       P-NEW-GEO-LOC-CBSAX.
074700             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.
074800             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.
074900             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.
075000             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.
075100             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.
075200         05  FILLER                        PIC X(10).
075300         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).
075400     02  PROV-NEWREC-HOLD3.
075500         05  P-NEW-PASS-AMT-DATA.
075600             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.
075700             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.
075800             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.
075900             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.
076000         05  P-NEW-CAPI-DATA.
076100             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.
076200             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.
076300             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.
076400             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.
076500             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.
076600             15  P-NEW-CAPI-NEW-HOSP       PIC X.
076700             15  P-NEW-CAPI-IME            PIC 9V9999.
076800             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.
076900             15  P-VAL-BASED-PURCH-SCORE   PIC 9V999.
077000         05  FILLER                        PIC X(18).
077100
077200
077300******************************************************************
077400*                THIS IS THE LTCH WAGE-INDEX                     *
077500*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
077600*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *
077700******************************************************************
077800 01  WAGE-NEW-INDEX-RECORD.
077900     05  W-CBSA                        PIC X(5).
078000     05  W-EFF-DATE                    PIC X(8).
078100     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).
078200     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).
078300     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).
078400
078500
078600******************************************************************
078700*                THIS IS THE IPPS WAGE-INDEX                     *
078800*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
078900******************************************************************
079000 01  WAGE-NEW-IPPS-INDEX-RECORD.
079100     05  W-CBSA-IPPS.
079200         10 CBSA-IPPS-123              PIC X(3).
079300         10 CBSA-IPPS-45               PIC X(2).
079400     05  W-CBSA-IPPS-SIZE              PIC X.
079500         88  LARGE-URBAN       VALUE 'L'.
079600         88  OTHER-URBAN       VALUE 'O'.
079700         88  ALL-RURAL         VALUE 'R'.
079800     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).
079900     05  FILLER                        PIC X.
080000     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).
080100     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).
080200
080300
080400
080500 PROCEDURE DIVISION  USING BILL-NEW-DATA
080600                           PPS-DATA-ALL
080700                           PPS-CBSA
080800                           PPS-PAYMENT-DATA
080900                           PRICER-OPT-VERS-SW
081000                           PROV-NEW-HOLD
081100                           WAGE-NEW-INDEX-RECORD
081200                           WAGE-NEW-IPPS-INDEX-RECORD.
081300
081400
081500***************************************************************
081600*                                                             *
081700*    PROCESSING:                                              *
081800*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
081900*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
082000*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
082100*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
082200*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
082300*           GOBACK.                                           *
082400*        D. ASSEMBLE PRICING COMPONENTS.                      *
082500*        E. CALCULATE THE PRICE.                              *
082600*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
082700*                                                             *
082800***************************************************************
082900
083000
083100***************************************************************
083200 0000-MAINLINE-CONTROL.
083300***************************************************************
083400
083500     PERFORM 0100-INITIAL-ROUTINE
083600        THRU 0100-EXIT.
083700
083800     PERFORM 1000-EDIT-INPUT-DATA
083900        THRU 1000-EXIT.
084000
084100     IF PPS-RTC = '00'
084200        PERFORM 1700-EDIT-DRG-CODE
084300           THRU 1700-EXIT.
084400
084500     IF PPS-RTC = '00'
084600        PERFORM 1800-EDIT-IPPS-DRG-CODE
084700           THRU 1800-EXIT.
084800
084900     IF PPS-RTC = '00'
085000        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
085100           THRU 2000-EXIT.
085200
085300     IF PPS-RTC = '00'
085400        PERFORM 3000-CALC-PAYMENT
085500           THRU 3000-EXIT.
085600
085700     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
085800        PERFORM 6000-CALC-HIGH-COST-OUTLIER
085900           THRU 6000-EXIT.
086000
086100     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
086200        PERFORM 7000-SET-FINAL-RETURN-CODES
086300           THRU 7000-EXIT.
086400
086500     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
086600        PERFORM 8000-CALC-FINAL-PMT
086700           THRU 8000-EXIT.
086800
086900     PERFORM 9000-MOVE-RESULTS
087000        THRU 9000-EXIT.
087100
087200     GOBACK.
087300
087400
087500***************************************************************
087600 0100-INITIAL-ROUTINE.
087700***************************************************************
087800
087900     MOVE '00' TO PPS-RTC.
088000     INITIALIZE PPS-DATA.
088100     INITIALIZE PPS-OTHER-DATA.
088200     INITIALIZE PPS-CBSA.
088300     INITIALIZE PPS-PAYMENT-DATA.
088400     INITIALIZE HOLD-PPS-COMPONENTS.
088500     INITIALIZE PROGRAM-FLAGS.
088600     INITIALIZE WK-HLDDRG-DATA
088700                WK-HLDDRG-DATA2.
088800
088900     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.
089000
089100
089200*** ---------------------------------------------------- ***
089300*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***
089400*** ---------------------------------------------------- ***
089500     MOVE .662 TO PPS-NAT-LABOR-PCT.
089600     MOVE .338 TO PPS-NAT-NONLABOR-PCT.
089700
089800*** --------------------------------------------------------
089900*** NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
090000*** REPORTING OF QUALITY DATA.
090100*** - FULL UPDATE (QUALITY INDICATOR ON PSF = 1)
090200*** - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK)
090300*** --------------------------------------------------------
090400     IF P-NEW-HOSP-QUAL-IND = '1'
090500        MOVE 41415.11 TO PPS-STD-FED-RATE
090600     ELSE
090700        MOVE 40595.02 TO PPS-STD-FED-RATE.
090800     MOVE 27381.00 TO H-FIXED-LOSS-AMT-STD.
090900     MOVE 26537.00 TO H-FIXED-LOSS-AMT-SNT.
091000     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.
091100
091200*** ---------------------------------------------------- ***
091300*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
091400*** ---------------------------------------------------- ***
091500     MOVE 453.95 TO H-IPPS-CAPI-STD-FED-RATE.
091600
091700     MOVE W-IPPS-WAGE-INDEX TO H-IPPS-WAGE-INDEX.
091800
091900     IF H-IPPS-WAGE-INDEX > 1
092000           MOVE 3806.04 TO H-IPPS-NAT-LABOR-SHR
092100           MOVE 1766.49 TO H-IPPS-NAT-NONLABOR-SHR
092200     ELSE
092300           MOVE 3454.97 TO H-IPPS-NAT-LABOR-SHR
092400           MOVE 2117.56 TO H-IPPS-NAT-NONLABOR-SHR
092500     END-IF.
092600
092700*** ---------------------------------------------------- ***
092800*** OPERATING DSH REDUCTION FACTOR                       ***
092900*** -----------------------------------------------------***
093000     MOVE 0.6851 TO H-OPER-DSH-REDUCTION-FACTOR.
093100
093200 0100-EXIT.
093300      EXIT.
093400
093500
093600***************************************************************
093700*    INPUT DATA EDITS - IF ANY FAIL SET PPS-RTC               *
093800*    AND DO NOT ATTEMPT TO PRICE.                             *
093900***************************************************************
094000 1000-EDIT-INPUT-DATA.
094100***************************************************************
094200
094300*** -----------------------------------------------------------
094400*** EDIT BILL (BILL-NEW-DATA) INPUT & SET ERROR CODE IF FAIL
094500*** -----------------------------------------------------------
094600     IF (B-LOS NUMERIC) AND (B-LOS > 0)
094700        MOVE B-LOS TO H-LOS
094800     ELSE
094900        MOVE '56' TO PPS-RTC.
095000
095100     IF PPS-RTC = '00'
095200        IF P-NEW-COLA NOT NUMERIC
095300           MOVE '50' TO PPS-RTC.
095400
095500     IF PPS-RTC = '00'
095600        IF P-NEW-WAIVER-STATE
095700           MOVE '53' TO PPS-RTC.
095800
095900     IF PPS-RTC = '00'
096000        IF B-DRG-CODE NOT NUMERIC
096100           MOVE '54' TO PPS-RTC.
096200
096300     IF PPS-RTC = '00'
096400        IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
096500           (B-DISCHARGE-DATE < W-EFF-DATE))
096600            MOVE '55' TO PPS-RTC.
096700
096800     IF PPS-RTC = '00'
096900        IF P-NEW-TERMINATION-DATE > 00000000
097000           IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
097100              MOVE '51' TO PPS-RTC.
097200
097300     IF PPS-RTC = '00'
097400        IF B-COV-CHARGES NOT NUMERIC
097500           MOVE '58' TO PPS-RTC.
097600
097700     IF PPS-RTC = '00'
097800        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
097900           MOVE '61' TO PPS-RTC.
098000
098100     IF PPS-RTC = '00'
098200        IF (B-COV-DAYS NOT NUMERIC) OR
098300           (B-COV-DAYS = 0 AND H-LOS > 0)
098400           MOVE '62' TO PPS-RTC.
098500
098600     IF PPS-RTC = '00'
098700        IF B-LTR-DAYS > B-COV-DAYS
098800           MOVE '62' TO PPS-RTC.
098900
099000     IF PPS-RTC = '00'
099100        IF (B-REVIEW-CODE < 00 OR B-REVIEW-CODE > 08) OR
099200           (B-REVIEW-CODE NOT NUMERIC)
099300           MOVE '72' TO PPS-RTC.
099400
099500
099600*** -----------------------------------------------------------
099700*** CALCULATE DAY RELATED VARIABLE VALUES
099800*** -----------------------------------------------------------
099900     IF PPS-RTC = '00'
100000        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
100100        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
100200
100300     IF PPS-RTC = '00'
100400        PERFORM 1200-DAYS-USED
100500           THRU 1200-DAYS-USED-EXIT.
100600
100700
100800*** -----------------------------------------------------------
100900*** EDIT PSF FIELDS USED BY ALL CLAIMS & SET ERROR CODE IF FAIL
101000*** -----------------------------------------------------------
101100
101200*-------------------------------------------------------------*
101300* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
101400* (ALWAYS FED-FY-BEGIN-03)                                    *
101500*-------------------------------------------------------------*
101600     IF PPS-RTC = '00'
101700        IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
101800           MOVE '74' TO PPS-RTC.
101900
102000*-------------------------------------------------------------*
102100* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
102200*-------------------------------------------------------------*
102300     IF PPS-RTC = '00'
102400        IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
102500           MOVE '65' TO PPS-RTC.
102600
102700
102800*** -----------------------------------------------------------
102900*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
103000*** -----------------------------------------------------------
103100     IF PPS-RTC = '00'
103200        IF P-NEW-CAPI-IME NUMERIC
103300           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
103400        ELSE
103500           MOVE ZEROS TO H-CAPI-IME-RATIO
103600        END-IF
103700     END-IF.
103800
103900     IF PPS-RTC = '00'
104000        IF P-NEW-INTERN-RATIO NUMERIC
104100           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
104200        ELSE
104300           MOVE ZEROS TO H-INTERN-RATIO
104400        END-IF
104500     END-IF.
104600
104700     IF PPS-RTC = '00'
104800        IF P-NEW-BED-SIZE NUMERIC
104900           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
105000        ELSE
105100           MOVE ZEROS TO H-BED-SIZE
105200        END-IF
105300     END-IF.
105400
105500     IF PPS-RTC = '00'
105600        IF P-NEW-SSI-RATIO NUMERIC
105700           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
105800        ELSE
105900           MOVE ZEROS TO H-SSI-RATIO
106000        END-IF
106100     END-IF.
106200
106300     IF PPS-RTC = '00'
106400        IF P-NEW-MEDICAID-RATIO NUMERIC
106500           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
106600        ELSE
106700           MOVE ZEROS TO H-MEDICAID-RATIO
106800        END-IF
106900     END-IF.
107000
107100
107200 1000-EXIT.
107300      EXIT.
107400
107500
107600***************************************************************
107700 1200-DAYS-USED.
107800***************************************************************
107900
108000     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
108100        IF B-LTR-DAYS > H-LOS
108200           MOVE H-LOS TO PPS-LTR-DAYS-USED
108300        ELSE
108400           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
108500     ELSE
108600        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
108700           IF H-REG-DAYS > H-LOS
108800              MOVE H-LOS TO PPS-REG-DAYS-USED
108900           ELSE
109000              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
109100        ELSE
109200           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
109300              IF H-REG-DAYS > H-LOS
109400                 MOVE H-LOS TO PPS-REG-DAYS-USED
109500                 MOVE 0 TO PPS-LTR-DAYS-USED
109600              ELSE
109700                 IF H-TOTAL-DAYS > H-LOS
109800                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
109900                    COMPUTE PPS-LTR-DAYS-USED =
110000                            H-LOS - H-REG-DAYS
110100                 ELSE
110200                    IF H-TOTAL-DAYS <= H-LOS
110300                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
110400                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
110500                    ELSE
110600                       NEXT SENTENCE
110700           ELSE
110800              NEXT SENTENCE.
110900
111000 1200-DAYS-USED-EXIT.
111100      EXIT.
111200
111300
111400***************************************************************
111500*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
111600***************************************************************
111700 1700-EDIT-DRG-CODE.
111800***************************************************************
111900
112000     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
112100     IF PPS-RTC = '00'
112200        SEARCH ALL WWM-ENTRY
112300           AT END
112400             MOVE '54' TO PPS-RTC
112500        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
112600             PERFORM 1750-FIND-VALUE
112700                THRU 1750-EXIT
112800        END-SEARCH.
112900
113000 1700-EXIT.
113100      EXIT.
113200
113300
113400***************************************************************
113500*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
113600***************************************************************
113700 1750-FIND-VALUE.
113800***************************************************************
113900
114000      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
114100      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
114200*     MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
114300
114400 1750-EXIT.
114500      EXIT.
114600
114700
114800***************************************************************
114900*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
115000***************************************************************
115100 1800-EDIT-IPPS-DRG-CODE.
115200***************************************************************
115300
115400**-------------------------------------------------------**
115500** THIS LOGIC WAS COPIED FROM THE IPPS PRICER (PPCAL140) **
115600** ENSURE IT STAYS CONSISTENT BECAUSE IT REFERENCES THE  **
115700** DRG TABLE USED BY THE IPPS PRICER.                    **
115800**-------------------------------------------------------**
115900
116000     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE
116100     SET DRG-IDX TO 1
116200     SEARCH DRG-TAB VARYING DRG-IDX
116300         AT END
116400           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC
116500           MOVE 'I' TO  HLDDRG-VALID
116600           MOVE '54' TO PPS-RTC
116700           GO TO 1800-EXIT
116800       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE
116900         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.
117000
117100
117200     MOVE  HLDDRG-DATA         TO WK-HLDDRG-DATA2.
117300     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.
117400     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2
117500                                  H-IPPS-DRG-WGT.
117600     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2
117700                                  H-IPPS-DRG-ALOS.
117800     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.
117900     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2
118000                                  H-IPPS-ARITH-ALOS.
118100     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.
118200     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.
118300     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.
118400     MOVE  'V'                 TO HLDDRG-VALID.
118500     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.
118600
118700 1800-EXIT.
118800      EXIT.
118900
119000
119100***************************************************************
119200***  GET THE PROVIDER SPECIFIC VARIABLES AND LTCH WAGE INDEX  *
119300*                                                             *
119400*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
119500*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
119600*    OF THAT VARIABLE.                                        *
119700*                                                             *
119800***************************************************************
119900 2000-ASSEMBLE-PPS-VARIABLES.
120000***************************************************************
120100
120200
120300*-------------------------------------------------------------*
120400* ASSIGN FULL (5/5) LTCH WAGE INDEX TO ALL CLAIMS DISCHARGED  *
120500* ON AND AFTER 7/1/2008 (THIRD COLUMN WAGE INDEX IN LTWIX***) *
120600*-------------------------------------------------------------*
120700     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
120800        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
120900     ELSE
121000        MOVE '52' TO PPS-RTC
121100        GO TO 2000-EXIT
121200     END-IF.
121300
121400
121500*-------------------------------------------------------------*
121600* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
121700*-------------------------------------------------------------*
121800     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
121900
122000*-------------------------------------------------------------*
122100* OLD POLICY CLAIMS MUST HAVE A BLEND YEAR INDICATOR OF 5     *
122200*-------------------------------------------------------------*
122300     IF B-REVIEW-CODE = 00 AND PPS-BLEND-YEAR NOT = 5
122400        MOVE 5 TO PPS-BLEND-YEAR
122500     END-IF.
122600
122700*-------------------------------------------------------------*
122800* NEW POLICY CLAIMS MUST HAVE A BLEND YR. IND. OF 6, 7, OR 8  *
122900*-------------------------------------------------------------*
123000     IF (B-REVIEW-CODE >= 01 AND B-REVIEW-CODE <= 08) AND
123100        (PPS-BLEND-YEAR < 6 OR PPS-BLEND-YEAR > 8)
123200        MOVE '72' TO PPS-RTC
123300        GO TO 2000-EXIT
123400     END-IF.
123500
123600*-------------------------------------------------------------*
123700* SET DEFAULT BLEND VARIABLE VALUES                           *
123800* - H-BLEND-STD = % STANDARD PMT CONTRIBUTES TO FINAL PMT     *
123900* - H-BLEND-SNT = % SITE NEUTRAL PMT CONTRIBUTES TO FINAL PMT *
124000*-------------------------------------------------------------*
124100     MOVE 0 TO H-BLEND-SNT.
124200     MOVE 1 TO H-BLEND-STD.
124300     MOVE 0 TO H-BLEND-RTC.
124400
124500
124600*-------------------------------------------------------------*
124700* FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII)          *
124800*-------------------------------------------------------------*
124900     IF (P-NEW-STATE = 02 OR 12)
125000        MOVE P-NEW-COLA TO PPS-COLA
125100     ELSE
125200        MOVE 1.000 TO PPS-COLA
125300     END-IF.
125400
125500
125600 2000-EXIT.
125700      EXIT.
125800
125900
126000***************************************************************
126100*    IF THE BILL & PSF DATA HAS PASSED ALL EDITS (RTC=00)     *
126200*        CALCULATE THE APPLICABLE CLAIM PAYMENT:              *
126300*           - STANDARD PAYMENT                                *
126400*           - SHORT STAY OUTLIER PAYMENT                      *
126500*           - SITE NEUTRAL PAYMENT                            *
126600*           - STANDARD/SITE NEUTRAL BLENDED PAYMENT           *
126700***************************************************************
126800 3000-CALC-PAYMENT.
126900***************************************************************
127000
127100
127200*-------------------------------------------------------------*
127300* CALCULATE CLAIM COST FOR ALL CLAIMS                         *
127400*-------------------------------------------------------------*
127500     COMPUTE PPS-FAC-COSTS ROUNDED =
127600         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
127700
127800
127900*-------------------------------------------------------------*
128000* DETERMINE WHICH PAYMENT METHOD TO USE. EITHER:              *
128100* - STANDARD PAYMENT UNDER THE OLD POLICY,                    *
128200* - STANDARD PAYMENT UNDER THE NEW POLICY,                    *
128300* - 100% SITE NEUTRAL PAYMENT, OR                             *
128400* - 50/50 BLEND OF SITE NEUTRAL & STANDARD PAYMENT.           *
128500*-------------------------------------------------------------*
128600     PERFORM 3100-DETERMINE-PAYMENT-TYPE
128700        THRU 3100-EXIT.
128800
128900     IF PPS-RTC NOT = '00'
129000        GO TO 3000-EXIT
129100     END-IF.
129200
129300
129400*-------------------------------------------------------------*
129500* CALCULATE CLAIM PAYMENT BASED ON PAYMENT METHOD             *
129600*-------------------------------------------------------------*
129700     IF PMT-STANDARD-OLD
129800        PERFORM 3200-CALC-STANDARD-PMT
129900           THRU 3200-EXIT
130000     END-IF.
130100
130200     IF PMT-STANDARD-NEW
130300        PERFORM 3200-CALC-STANDARD-PMT
130400           THRU 3200-EXIT
130500     END-IF.
130600
130700     IF PMT-SITE-NEUTRAL
130800        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
130900           THRU 3300-EXIT
131000     END-IF.
131100
131200     IF PMT-BLEND
131300        PERFORM 3200-CALC-STANDARD-PMT
131400           THRU 3200-EXIT
131500        PERFORM 3300-CALC-SITE-NEUTRAL-PMT
131600           THRU 3300-EXIT
131700     END-IF.
131800
131900 3000-EXIT.
132000      EXIT.
132100
132200
132300***************************************************************
132400*  DETERMINE WHETHER A CLAIM'S PAYMENT SHOULD BE:             *
132500*  - STANDARD - OLD POLICY                                    *
132600*  - STANDARD - NEW POLICY                                    *
132700*  - 100% SITE NEUTRAL - NEW POLICY                           *
132800*  - 50/50 BLEND OF SITE NEUTRAL & STANDARD - NEW POLICY      *
132900***************************************************************
133000 3100-DETERMINE-PAYMENT-TYPE.
133100***************************************************************
133200
133300*-------------------------------------------------------------*
133400* STANDARD PAYMENT (OLD POLICY)
133500*-------------------------------------------------------------*
133600     IF B-REVIEW-CODE = 00
133700*    IF B-REVIEW-CODE = 00 OR
133800*       SUBCLAUSEII-PROV
133900        SET PMT-STANDARD-OLD TO TRUE
134000        GO TO 3100-EXIT
134100     END-IF.
134200
134300*-------------------------------------------------------------*
134400* STANDARD PAYMENT (NEW POLICY)
134500*-------------------------------------------------------------*
134600     IF (B-REVIEW-CODE = 01 AND NOT PSYCH-REHAB-DRG) OR
134700        B-REVIEW-CODE = 04 OR
134800        B-REVIEW-CODE = 05
134900        SET PMT-STANDARD-NEW TO TRUE
135000        GO TO 3100-EXIT
135100     END-IF.
135200
135300*-------------------------------------------------------------*
135400* SITE NEUTRAL PAYMENT (NEW POLICY)
135500*-------------------------------------------------------------*
135600     IF  (B-REVIEW-CODE = 01 AND PSYCH-REHAB-DRG) OR
135700          B-REVIEW-CODE = 02 OR
135800          B-REVIEW-CODE = 03 OR
135900          B-REVIEW-CODE = 06 OR
136000          B-REVIEW-CODE = 07 OR
136100          B-REVIEW-CODE = 08
136200
136300*-------------------------------------------------------------*
136400*     SET BUDGET NEUTRALITY RATE FOR SITE NEUTRAL CLAIMS
136500*-------------------------------------------------------------*
136600        MOVE 0.949 TO H-BDGT-NEUT-FACTOR
136700
136800*-------------------------------------------------------------*
136900*     SET SITE-NEUTRAL-IPPS-ADJ FOR SITE-NEUTRAL CLAIMS
137000*-------------------------------------------------------------*
137100        MOVE 0.954 TO H-SITE-NEUTRAL-IPPS-ADJ
137200
137300*-------------------------------------------------------------*
137400*     100% SITE NEUTRAL PAYMENT
137500*-------------------------------------------------------------*
137600        IF PPS-BLEND-YEAR = 8
137700           SET PMT-SITE-NEUTRAL TO TRUE
137800
137900*-------------------------------------------------------------*
138000*     50% SITE NEUTRAL + 50% STANDARD BLENDED PAYMENT
138100*-------------------------------------------------------------*
138200        ELSE
138300           IF PPS-BLEND-YEAR = 6 OR
138400              PPS-BLEND-YEAR = 7
138500              SET PMT-BLEND TO TRUE
138600
138700*-------------------------------------------------------------*
138800*           SET BLEND PERCENTS FOR BLENDED PAYMENT            *
138900*-------------------------------------------------------------*
139000              MOVE .5 TO H-BLEND-STD
139100              MOVE .5 TO H-BLEND-SNT
139200           END-IF
139300        END-IF
139400     END-IF.
139500
139600*-------------------------------------------------------------*
139700* CLAIM MEETS NONE OF THE ABOVE CRITERIA - SET RETURN CODE
139800*-------------------------------------------------------------*
139900     IF WS-PRIMARY-PMT-TYPE = ' '
140000        MOVE '72' TO PPS-RTC
140100     END-IF.
140200
140300
140400 3100-EXIT.
140500      EXIT.
140600
140700
140800***************************************************************
140900*     CALCULATE THE STANDARD PAYMENT AMOUNT.                  *
141000*     CALCULATE THE SHORT-STAY OUTLIER AMOUNT IF APPLICABLE.  *
141100***************************************************************
141200 3200-CALC-STANDARD-PMT.
141300***************************************************************
141400
141500*-------------------------------------------------------------*
141600* CALCULATE FULL STANDARD DRG ADJUSTED PAYMENT                *
141700*-------------------------------------------------------------*
141800     COMPUTE H-LABOR-PORTION ROUNDED =
141900         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
142000          * PPS-WAGE-INDEX.
142100
142200     COMPUTE H-NONLABOR-PORTION ROUNDED =
142300         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
142400          * PPS-COLA.
142500
142600     COMPUTE PPS-FED-PAY-AMT ROUNDED =
142700         (H-LABOR-PORTION + H-NONLABOR-PORTION).
142800
142900     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
143000         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
143100
143200* FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY
143300     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
143400
143500
143600*-------------------------------------------------------------*
143700* DETERMINE WHETHER THE CLAIM IS A SHORT STAY OUTLIER;        *
143800* APPLY SHORT STAY OUTLIER POLICY IF IT IS                    *
143900*-------------------------------------------------------------*
144000     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
144100
144200     IF H-LOS <= H-SSOT
144300        PERFORM 3400-SHORT-STAY
144400           THRU 3400-SHORT-STAY-EXIT
144500
144600        IF PMT-STANDARD-NEW OR PMT-BLEND
144700           SET PMT-STANDARD-SSO TO TRUE
144800           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-SSO-PMT
144900        END-IF
145000
145100*-------------------------------------------------------------*
145200* FOR REGULAR STAY CLAIMS, POPULATE THE APPROPRIATE PAYMENT   *
145300* FIELD FOR NEW POLICY CLAIMS                                 *
145400*-------------------------------------------------------------*
145500     ELSE
145600        IF PMT-STANDARD-NEW OR PMT-BLEND
145700           SET PMT-STANDARD-FULL TO TRUE
145800           MOVE PPS-DRG-ADJ-PAY-AMT TO PPS-STANDARD-FULL-PMT
145900        END-IF
146000     END-IF.
146100
146200 3200-EXIT.
146300      EXIT.
146400
146500
146600***************************************************************
146700*     CALCULATE THE SITE NEUTRAL PAYMENT AMOUNT               *
146800***************************************************************
146900 3300-CALC-SITE-NEUTRAL-PMT.
147000***************************************************************
147100* BEGINNING LTCAL183 - NEW METHOD
147200
147300*-------------------------------------------------------------*
147400* CALCULATE IPPS COMPARABLE PER DIEM AMT                      *
147500*-------------------------------------------------------------*
147600     PERFORM 3650-SS-IPPS-COMP-PMT
147700        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
147800
147900*-------------------------------------------------------------*
148000* CALCULATE SITE NEUTRAL IPPS COMP. PMT HIGH COST OUTLIER     *
148100* (HCO) FOR THE MINIMUM PAYMENT COMPARISON                    *
148200*-------------------------------------------------------------*
148300     SET PMT-SITE-NEUT-IPPS TO TRUE.
148400     MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT.
148500     PERFORM 6000-CALC-HIGH-COST-OUTLIER
148600        THRU 6000-EXIT.
148700     COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
148800             PPS-OUTLIER-PAY-AMT *
148900             H-SITE-NEUTRAL-IPPS-ADJ.
149000     MOVE PPS-OUTLIER-PAY-AMT TO H-OUTLIER-IPPS-COMPARABLE.
149100     INITIALIZE PPS-OUTLIER-PAY-AMT
149200                WS-SECONDARY-PMT-TYPE-SNT
149300                PPS-SITE-NEUTRAL-IPPS-PMT.
149400
149500*-------------------------------------------------------------*
149600* CALCULATE THE SITE NEUTRAL PAYMENT USING THE FOLLOWING      *
149700* FORMULA FROM POLICY GROUP:                                  *
149800* MIN (�SN ADJ * (IPPS PER DIEM AMT + SN IPPS HCO)�, COST)    *
149900*-------------------------------------------------------------*
150000
150100*-------------------------------------------------------------*
150200* CALCULATE SITE NEUTRAL COST PAYMENT FOR MIN PMT COMPARISON  *
150300*-------------------------------------------------------------*
150400     MOVE PPS-FAC-COSTS TO H-SN-COST-4COMPARISON.
150500
150600*-------------------------------------------------------------*
150700* CALCULATE SITE NEUTRAL IPPS COMP PMT FOR MIN PMT COMPARISON *
150800*-------------------------------------------------------------*
150900     COMPUTE H-SN-IPPS-4COMPARISON ROUNDED =
151000              H-SITE-NEUTRAL-IPPS-ADJ *
151100              (H-IPPS-PER-DIEM +
151200               H-OUTLIER-IPPS-COMPARABLE).
151300
151400*-------------------------------------------------------------*
151500* MINIMUM IS FINAL SITE NEUTRAL PMT BASED ON COST             *
151600*-------------------------------------------------------------*
151700     IF H-SN-COST-4COMPARISON < H-SN-IPPS-4COMPARISON
151800        SET PMT-SITE-NEUT-COST TO TRUE
151900        MOVE PPS-FAC-COSTS TO PPS-SITE-NEUTRAL-COST-PMT
152000
152100*-------------------------------------------------------------*
152200* MINIMUM IS FINAL SITE-NEUTRAL PMT BASED ON IPPS COMPARABLE  *
152300*-------------------------------------------------------------*
152400     ELSE
152500        SET PMT-SITE-NEUT-IPPS TO TRUE
152600        MOVE H-IPPS-PER-DIEM TO PPS-SITE-NEUTRAL-IPPS-PMT
152700     END-IF.
152800
152900
153000 3300-EXIT.
153100      EXIT.
153200
153300
153400***************************************************************
153500*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
153600*      OF THE AVG. LENGTH OF STAY THEN:                       *
153700*      - PAY THE SHORT-STAY BLENDED PAYMENT                   *
153800*      - SET RETURN CODE FOR OLD POLICY CLAIMS ONLY TO        *
153900*        INDICATE SHORT STAY PAYMENT                          *
154000***************************************************************
154100
154200 3400-SHORT-STAY.
154300
154400        COMPUTE H-SS-PAY-AMT ROUNDED =
154500         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
154600
154700***************************************************************
154800*   CALCULATE BLENDED PAYMENT                                 *
154900***************************************************************
155000
155100        PERFORM 3600-SS-BLENDED-PMT
155200           THRU 3600-SS-BLENDED-PMT-EXIT
155300        MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
155400        IF PMT-STANDARD-OLD
155500           MOVE '22' TO PPS-RTC
155600        END-IF
155700        MOVE 'Y' TO H-SS-BLEND-IND
155800        MOVE 'N' TO H-SS-COST-IND
155900        MOVE 'N' TO H-SS-PERDIEM-IND
156000        MOVE 'N' TO H-SS-IPPSCOMP-IND.
156100
156200 3400-SHORT-STAY-EXIT.
156300      EXIT.
156400
156500
156600***************************************************************
156700*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
156800*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
156900*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
157000*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
157100***************************************************************
157200 3600-SS-BLENDED-PMT.
157300***************************************************************
157400
157500*** ------------------------------------------------------ ***
157600*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
157700*** ------------------------------------------------------ ***
157800     IF H-SSOT < 25
157900        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
158000          H-LOS / H-SSOT
158100     ELSE
158200        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
158300          H-LOS / 25
158400     END-IF.
158500
158600     IF H-LTCH-BLEND-PCT > 1
158700        MOVE 1 TO H-LTCH-BLEND-PCT
158800     END-IF.
158900
159000
159100*** ------------------------------------------------------ ***
159200*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
159300*** ------------------------------------------------------ ***
159400     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
159500        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
159600
159700
159800*** ------------------------------------------------------ ***
159900*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
160000*** ------------------------------------------------------ ***
160100     PERFORM 3650-SS-IPPS-COMP-PMT
160200        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
160300
160400
160500*** ------------------------------------------------------ ***
160600*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
160700*** ------------------------------------------------------ ***
160800     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
160900       1 - H-LTCH-BLEND-PCT.
161000
161100
161200*** ------------------------------------------------------ ***
161300*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
161400*** ------------------------------------------------------ ***
161500     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
161600       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
161700
161800
161900*** ------------------------------------------------------ ***
162000*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
162100*** ------------------------------------------------------ ***
162200     COMPUTE H-SS-BLENDED-PMT ROUNDED =
162300       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
162400
162500
162600 3600-SS-BLENDED-PMT-EXIT.
162700      EXIT.
162800
162900
163000***************************************************************
163100*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
163200*   PER DIEM PAYMENT AMOUNT                                   *
163300***************************************************************
163400 3650-SS-IPPS-COMP-PMT.
163500***************************************************************
163600
163700*** -------------------------------------------------------
163800*** OPERATING TEACHING ADJUSTMENT
163900*** -------------------------------------------------------
164000     COMPUTE H-OPER-IME-TEACH ROUNDED =
164100        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
164200
164300
164400*** -------------------------------------------------------
164500*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
164600*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%
164700*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL
164800***              THIS CHANGE IS RETROACTIVE TO 10/01/2008
164900*** -------------------------------------------------------
165000     IF H-CAPI-IME-RATIO > 1.5000
165100        MOVE 1.5000 TO H-CAPI-IME-RATIO.
165200
165300     COMPUTE H-CAPI-IME-TEACH ROUNDED =
165400        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).
165500
165600
165700*** -------------------------------------------------------
165800*** OPERATING DSH ADJUSTMENT
165900*** -------------------------------------------------------
166000
166100*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
166200*---------------------------------------------------
166300     IF ALL-RURAL
166400        SET RURAL-CBSA TO TRUE
166500     ELSE
166600        SET URBAN-CBSA TO TRUE
166700     END-IF.
166800
166900
167000*2) CALCULATE THE OPERATING DSH PERCENT
167100*--------------------------------------
167200     COMPUTE H-OPER-DSH-PCT ROUNDED =
167300        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
167400
167500
167600*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
167700*-----------------------------------------------------
167800
167900*    URBAN, < 100 BEDS
168000*    -----------------
168100     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
168200        H-OPER-DSH-PCT >= .15
168300          MOVE '3' TO H-GEO-CLASS
168400     ELSE
168500
168600
168700*   URBAN, >= 100 BEDS
168800*   ------------------
168900       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
169000          H-OPER-DSH-PCT >= .15
169100            MOVE '2' TO H-GEO-CLASS
169200       ELSE
169300
169400
169500*   RURAL, >= 500 BEDS
169600*   ------------------
169700         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
169800            H-OPER-DSH-PCT >= .15
169900              MOVE '2' TO H-GEO-CLASS
170000         ELSE
170100
170200
170300*   RURAL, < 500 BEDS
170400*   -----------------
170500           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
170600              H-OPER-DSH-PCT >= .15
170700                MOVE '3' TO H-GEO-CLASS
170800           ELSE
170900
171000
171100*   OTHER
171200*   -----------------
171300              MOVE '4' TO H-GEO-CLASS
171400
171500           END-IF
171600         END-IF
171700       END-IF
171800     END-IF.
171900
172000
172100*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
172200*-----------------------------------------------------------
172300     EVALUATE H-GEO-CLASS
172400
172500*      GEOGRAPHIC CLASS 2
172600*      ------------------
172700       WHEN '2'
172800          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
172900             COMPUTE H-OPER-DSH ROUNDED =
173000               ((H-OPER-DSH-PCT - .15) * .65) + .025
173100          ELSE
173200             IF H-OPER-DSH-PCT > .202
173300                COMPUTE H-OPER-DSH ROUNDED =
173400                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
173500             ELSE
173600                MOVE ZEROS TO H-OPER-DSH
173700             END-IF
173800          END-IF
173900
174000*      GEOGRAPHIC CLASS 3
174100*      ------------------
174200       WHEN '3'
174300          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
174400             COMPUTE H-OPER-DSH ROUNDED =
174500               ((H-OPER-DSH-PCT - .15) * .65) + .025
174600             IF H-OPER-DSH > .12
174700                MOVE .12 TO H-OPER-DSH
174800             END-IF
174900          ELSE
175000             IF H-OPER-DSH-PCT > .202
175100                COMPUTE H-OPER-DSH ROUNDED =
175200                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
175300                IF H-OPER-DSH > .12
175400                   MOVE .12 TO H-OPER-DSH
175500                END-IF
175600             ELSE
175700               MOVE ZEROS TO H-OPER-DSH
175800             END-IF
175900          END-IF
176000
176100*      GEOGRAPHIC CLASS 4
176200*      ------------------
176300       WHEN '4'
176400          MOVE ZEROS TO H-OPER-DSH
176500
176600     END-EVALUATE.
176700
176800
176900*** -------------------------------------------------------
177000*** CURRENT OPERATING DSH PAYMENT REDUCTION
177100*** -------------------------------------------------------
177200     COMPUTE H-OPER-DSH ROUNDED =
177300             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.
177400
177500*** -------------------------------------------------------
177600*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
177700*** -------------------------------------------------------
177800     IF URBAN-CBSA AND H-BED-SIZE >= 100
177900        COMPUTE H-CAPI-DSH ROUNDED =
178000          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
178100     ELSE
178200        MOVE ZEROS TO H-CAPI-DSH
178300     END-IF.
178400
178500
178600*** -------------------------------------------------------
178700*** OPERATING PAYMENT (STANDARD AMOUNT)
178800*** -------------------------------------------------------
178900     IF (P-NEW-STATE = 02 OR 12)
179000        MOVE P-NEW-COLA TO H-OPER-COLA
179100     ELSE
179200        MOVE 1.000 TO H-OPER-COLA
179300     END-IF.
179400
179500     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
179600       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +
179700         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
179800         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
179900
180000
180100*** -------------------------------------------------------
180200*** CAPITAL PAYMENT (CAPITAL RATE)
180300*** -------------------------------------------------------
180400     COMPUTE H-CAPI-COLA ROUNDED =
180500       (.3152 * (H-OPER-COLA - 1) + 1).
180600
180700*--------------------------------------------------------------*
180800*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
180900*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
181000*--------------------------------------------------------------*
181100     IF LARGE-URBAN
181200        MOVE 1.00 TO H-LRGURB-ADD-ON
181300     ELSE
181400        MOVE 1.00 TO H-LRGURB-ADD-ON
181500     END-IF.
181600
181700     COMPUTE H-CAPI-GAF ROUNDED =
181800       (H-IPPS-WAGE-INDEX ** .6848).
181900
182000     COMPUTE H-CAPI-PMT ROUNDED =
182100       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
182200       H-LRGURB-ADD-ON *  H-CAPI-COLA *
182300       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
182400
182500
182600*** -------------------------------------------------------
182700*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
182800*** -------------------------------------------------------
182900     COMPUTE H-IPPS-PAY-AMT ROUNDED =
183000       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
183100
183200
183300*** -------------------------------------------------------
183400*** IPPS COMPARABLE PER DIEM PAYMENT
183500*** -------------------------------------------------------
183600     COMPUTE H-IPPS-PER-DIEM ROUNDED =
183700       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
183800
183900     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
184000        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
184100     END-IF.
184200
184300*** -------------------------------------------------------
184400*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
184500*** -------------------------------------------------------
184600
184700
184800 3650-SS-IPPS-COMP-PMT-EXIT.
184900      EXIT.
185000
185100
185200***************************************************************
185300*4000-SPECIAL-PROVIDER.
185400***************************************************************
185500*
185600*** PROCESS FOR CY2003
185700*** ------------------
185800*    IF (B-DISCHARGE-DATE >= 20030701) AND
185900*       (B-DISCHARGE-DATE <  20040101)
186000*       COMPUTE H-SS-COST ROUNDED =
186100*           (PPS-FAC-COSTS * 1.95)
186200*       COMPUTE H-SS-PAY-AMT ROUNDED =
186300*        ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
186400*    END-IF
186500*
186600*
186700*** PROCESS FOR CY2004
186800*** ------------------
186900*    IF (B-DISCHARGE-DATE >= 20040101) AND
187000*       (B-DISCHARGE-DATE <  20050101)
187100*       COMPUTE H-SS-COST ROUNDED =
187200*           (PPS-FAC-COSTS * 1.93)
187300*       COMPUTE H-SS-PAY-AMT ROUNDED =
187400*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
187500*    END-IF
187600*
187700*
187800*** PROCESS FOR CY2005
187900*** ------------------
188000*    IF (B-DISCHARGE-DATE >= 20050101) AND
188100*       (B-DISCHARGE-DATE <  20060101)
188200*       COMPUTE H-SS-COST ROUNDED =
188300*           (PPS-FAC-COSTS * 1.65)
188400*       COMPUTE H-SS-PAY-AMT ROUNDED =
188500*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
188600*    END-IF
188700*
188800*
188900*** PROCESS FOR CY2006
189000*** ------------------
189100*    IF (B-DISCHARGE-DATE >= 20060101) AND
189200*       (B-DISCHARGE-DATE <  20070101)
189300*       COMPUTE H-SS-COST ROUNDED =
189400*           (PPS-FAC-COSTS * 1.36)
189500*       COMPUTE H-SS-PAY-AMT ROUNDED =
189600*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
189700*    END-IF
189800*
189900*
190000*** PROCESS FOR CY2007 AND AFTER
190100*** ----------------------------
190200*    IF (B-DISCHARGE-DATE >= 20070101)
190300*       COMPUTE H-SS-COST ROUNDED =
190400*           (PPS-FAC-COSTS * 1.2)
190500*       COMPUTE H-SS-PAY-AMT ROUNDED =
190600*         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
190700*    END-IF.
190800*
190900*4000-SPECIAL-PROVIDER-EXIT.
191000*     EXIT.
191100
191200
191300***************************************************************
191400*   CALCULATE THE OUTLIER THRESHOLD                           *
191500*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
191600*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
191700*   SET RETURN CODE                                           *
191800*   CALCULATE THE CHARGE THRESHOLD IF APPLICABLE              *
191900***************************************************************
192000 6000-CALC-HIGH-COST-OUTLIER.
192100***************************************************************
192200
192300
192400*-------------------------------------------------------------*
192500* FOR NON-BLENDED PAYMENT CLAIMS:                             *
192600*-------------------------------------------------------------*
192700* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLD  *
192800*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
192900* - CALCULATE OUTLIER THRESHOLD                               *
193000*-------------------------------------------------------------*
193100
193200     IF PMT-STANDARD-OLD
193300        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
193400                PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT-STD
193500     END-IF.
193600
193700
193800     IF PMT-STANDARD-NEW
193900        IF PMT-STANDARD-FULL
194000           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
194100                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
194200        ELSE
194300           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
194400                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
194500        END-IF
194600     END-IF.
194700
194800
194900     IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
195000        COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
195100                PPS-SITE-NEUTRAL-IPPS-PMT + H-FIXED-LOSS-AMT-SNT
195200     END-IF.
195300
195400
195500*-------------------------------------------------------------*
195600* CALCULATE HIGH-COST OUTLIER IF COSTS EXCEED THRESHOLD       *
195700*-------------------------------------------------------------*
195800     IF NOT PMT-BLEND AND
195900        NOT (PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-COST)
196000        IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
196100           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
196200                   (PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8
196300
196400*-------------------------------------------------------------*
196500*        SITE-NEUTRAL ONLY: REDUCE BY BUDGET NEUTRALITY FACT. *
196600*-------------------------------------------------------------*
196700*          IF PMT-SITE-NEUTRAL AND PMT-SITE-NEUT-IPPS
196800*             COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
196900*                    PPS-OUTLIER-PAY-AMT * H-BDGT-NEUT-FACTOR
197000*          END-IF
197100        END-IF
197200     END-IF.
197300
197400
197500
197600*-------------------------------------------------------------*
197700* FOR BLENDED PAYMENT CLAIMS                                  *
197800* (RECEIVE 50% STANDARD PAYMENT + 50% SITE-NEUTRAL PAYMENT)   *
197900*-------------------------------------------------------------*
198000* - DETERMINE WHICH PAYMENT TO USE TO CALC OUTLIER THRESHOLDS *
198100*   BASED ON CLAIMS'S PAYMENT TYPE & PAYMENT FIELD VALUES     *
198200* - CALCULATE STANDARD PAYMENT OUTLIER THRESHOLD              *
198300* - CALCULATE SITE-NEUTRAL PAYMENT OUTLIER THRESHOLD          *
198400* - CALCULATE HIGH-COST OUTLIER IF APPLICABLE (50/50 BLEND)   *
198500*-------------------------------------------------------------*
198600
198700     IF PMT-BLEND
198800
198900*-------------------------------------------------------------*
199000* CALCULATE STANDARD OUTLIER THRESHOLD                        *
199100*-------------------------------------------------------------*
199200        IF PMT-STANDARD-FULL
199300           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
199400                   PPS-STANDARD-FULL-PMT + H-FIXED-LOSS-AMT-STD
199500        ELSE
199600           COMPUTE H-OUTLIER-THRESHOLD-STD ROUNDED =
199700                   PPS-STANDARD-SSO-PMT + H-FIXED-LOSS-AMT-STD
199800        END-IF
199900
200000
200100*-------------------------------------------------------------*
200200* CALCULATE SITE-NEUTRAL OUTLIER THRESHOLD                    *
200300*-------------------------------------------------------------*
200400        IF PMT-SITE-NEUT-IPPS
200500           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
200600                   PPS-SITE-NEUTRAL-IPPS-PMT +
200700                   H-FIXED-LOSS-AMT-SNT
200800        END-IF
200900
201000
201100*-------------------------------------------------------------*
201200* CALCULATE STANDARD PAYMENT PORTION OF HIGH-COST OUTLIER IF  *
201300* COSTS EXCEED STANDARD PAYMENT THRESHOLD                     *
201400*-------------------------------------------------------------*
201500        IF PPS-FAC-COSTS > H-OUTLIER-THRESHOLD-STD
201600           COMPUTE H-OUTLIER-PAY-AMT-STD ROUNDED =
201700                   (PPS-FAC-COSTS - H-OUTLIER-THRESHOLD-STD) * .8
201800                   * H-BLEND-STD
201900        END-IF
202000
202100
202200*-------------------------------------------------------------*
202300* CALCULATE SITE-NEUTRAL PORTION OF HIGH-COST OUTLIER IF      *
202400* COSTS EXCEED THE SITE-NEUTRAL PAYMENT THRESHOLD             *
202500*-------------------------------------------------------------*
202600        IF PMT-SITE-NEUT-IPPS AND
202700           PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
202800           COMPUTE H-OUTLIER-PAY-AMT-SNT ROUNDED =
202900                  (((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
203000*                  * H-BLEND-SNT) * H-BDGT-NEUT-FACTOR
203100                   * H-BLEND-SNT)
203200        END-IF
203300
203400*-------------------------------------------------------------*
203500* CALCULATE TOTAL BLENDED HIGH-COST OUTLIER:                  *
203600* ADD THE SITE-NEUTRAL PAYMENT PORTION OF HIGH-COST OUTLIER   *
203700* TO THE STANDARD PAYMENT PORTION                             *
203800*-------------------------------------------------------------*
203900        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
204000                H-OUTLIER-PAY-AMT-STD +
204100                (H-OUTLIER-PAY-AMT-SNT * H-SITE-NEUTRAL-IPPS-ADJ)
204200
204300     END-IF.
204400
204500
204600*-------------------------------------------------------------*
204700* FOR ALL CLAIMS:                                             *
204800*-------------------------------------------------------------*
204900* SET HIGH-COST OUTLIER TO $0 IF BILL SPECIAL PAY IND. = '1'  *
205000*-------------------------------------------------------------*
205100     IF B-SPEC-PAY-IND = '1'
205200        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
205300
205400
205500*-------------------------------------------------------------*
205600* DETERMINE IF CHARGE THRESHOLD APPLIES & CALCULATE IF SO     *
205700*-------------------------------------------------------------*
205800     PERFORM 6100-CALC-CHARGE-THRESHOLD
205900        THRU 6100-EXIT.
206000
206100
206200 6000-EXIT.
206300      EXIT.
206400
206500
206600***************************************************************
206700*   CALCULATE CHARGE THRESHOLD & SET ERROR RTC WHEN APPLICABLE*
206800***************************************************************
206900 6100-CALC-CHARGE-THRESHOLD.
207000***************************************************************
207100
207200
207300*-------------------------------------------------------------*
207400* FOR MAINFRAME PRICER ONLY:                                  *
207500*-------------------------------------------------------------*
207600* FOR CLAIMS THAT RECEIVE A HIGH-COST OUTLIER AND HAVE A      *
207700* LENGTH OF STAY THAT EXCEEDS THE COVERED DAYS, CALCULATE THE *
207800* CHARGE THRESHOLD AND SET ERROR RETURN CODE '67'             *
207900*-------------------------------------------------------------*
208000
208100*-------------------------------------------------------------*
208200* FOR PC PRICER (PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS):      *
208300*-------------------------------------------------------------*
208400* CALCULATE CHARGE THRESHOLD FOR CLAIMS ALL CLAIMS THAT HAVE  *
208500* AN OPERATING COST-TO-CHARGE RATIO BUT DO NOT SET ERROR CODE *
208600*-------------------------------------------------------------*
208700
208800     IF (PPS-OUTLIER-PAY-AMT > 0 AND
208900         NOT (PMT-BLEND AND H-OUTLIER-PAY-AMT-SNT = 0)) OR
209000        PPS-COT-IND = 'Y'
209100
209200        IF B-COV-DAYS < H-LOS OR
209300           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
209400
209500           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
209600             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
209700
209800           IF NOT PC-PRICER
209900              MOVE '67' TO PPS-RTC
210000           END-IF
210100
210200        ELSE
210300           NEXT SENTENCE
210400        END-IF
210500     ELSE
210600        NEXT SENTENCE
210700     END-IF.
210800
210900 6100-EXIT.
211000      EXIT.
211100
211200
211300***************************************************************
211400*   SET FINAL RETURN CODES FOR PRICED CLAIMS                  *
211500***************************************************************
211600 7000-SET-FINAL-RETURN-CODES.
211700***************************************************************
211800
211900
212000*-------------------------------------------------------------*
212100* SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIM            *
212200*-------------------------------------------------------------*
212300*    IF SUBCLAUSEII-PROV
212400*       PERFORM 7300-SET-SUBII-RETURN-CODES
212500*          THRU 7300-EXIT
212600*       GO TO 7000-EXIT
212700*    END-IF.
212800
212900
213000*-------------------------------------------------------------*
213100* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
213200* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
213300*-------------------------------------------------------------*
213400     IF PMT-STANDARD-OLD
213500        PERFORM 7100-SET-OLD-RETURN-CODES
213600           THRU 7100-EXIT
213700     END-IF.
213800
213900
214000*-------------------------------------------------------------*
214100* SET RETURN CODES FOR NEW POLICY CLAIMS                      *
214200*-------------------------------------------------------------*
214300     IF PMT-STANDARD-NEW OR PMT-SITE-NEUTRAL OR PMT-BLEND
214400        PERFORM 7200-SET-NEW-RETURN-CODES
214500           THRU 7200-EXIT
214600     END-IF.
214700
214800
214900 7000-EXIT.
215000      EXIT.
215100
215200
215300***************************************************************
215400*   SET RETURN CODES FOR OLD POLICY CLAIMS                    *
215500***************************************************************
215600 7100-SET-OLD-RETURN-CODES.
215700***************************************************************
215800
215900*-------------------------------------------------------------*
216000* ALTER RETURN CODES FOR OLD POLICY CLAIMS TO REFLECT OUTLIER *
216100* PAYMENT IF OUTLIER PAYMENT IS > $0                          *
216200*-------------------------------------------------------------*
216300
216400     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '21'
216500        MOVE '24' TO PPS-RTC.
216600
216700     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '22'
216800        MOVE '25' TO PPS-RTC.
216900
217000     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '26'
217100        MOVE '27' TO PPS-RTC.
217200
217300     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = '00'
217400        MOVE '01' TO PPS-RTC.
217500
217600     IF (PPS-RTC = '00' OR '20' OR '21' OR '22' OR '26')
217700        IF PPS-REG-DAYS-USED > H-SSOT
217800           MOVE 0 TO PPS-LTR-DAYS-USED
217900        ELSE
218000           NEXT SENTENCE.
218100
218200 7100-EXIT.
218300      EXIT.
218400
218500
218600***************************************************************
218700*   SET RETURN CODES FOR NEW POLICY CLAIMS                    *
218800***************************************************************
218900 7200-SET-NEW-RETURN-CODES.
219000***************************************************************
219100
219200     INITIALIZE PPS-RTC.
219300
219400***************************************************************
219500* SET THE FIRST POSITION OF THE RETURN CODE                   *
219600***************************************************************
219700
219800*--------------------------------------------------*
219900* DEFAULT (NO PSYCH/REHAB NOR VENTILATOR SERVICE)  *
220000*--------------------------------------------------*
220100     MOVE 'C' TO PPS-RTC-1.
220200
220300*--------------------------------------------------*
220400* VENTILATOR SERVICE PRESENT                       *
220500*--------------------------------------------------*
220600     PERFORM 7250-SEARCH-FOR-VENT-PROC
220700        THRU 7250-EXIT.
220800     IF VENT-PRESENT
220900        MOVE 'B' TO PPS-RTC-1
221000     END-IF.
221100
221200*--------------------------------------------------*
221300* SITE NEUTRAL PMT BECAUSE PSYCH/REHAB DRG PRESENT *
221400* (PRESENCE OF PSCHY/REHAB DRG TRUMPS VENT PROC.)  *
221500*--------------------------------------------------*
221600     IF PSYCH-REHAB-DRG AND
221700        (PMT-SITE-NEUTRAL OR PMT-BLEND)
221800        MOVE 'A' TO PPS-RTC-1
221900     END-IF.
222000
222100
222200
222300***************************************************************
222400* SET THE SECOND POSITION OF RETURN CODE                      *
222500***************************************************************
222600
222700*-------------------------------------------------------------*
222800* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = COST         *
222900*-------------------------------------------------------------*
223000     IF PMT-BLEND AND PMT-SITE-NEUT-COST
223100
223200        IF PPS-OUTLIER-PAY-AMT = 0 AND
223300           PMT-STANDARD-FULL
223400           MOVE '0' TO PPS-RTC-2
223500        END-IF
223600
223700        IF PPS-OUTLIER-PAY-AMT > 0 AND
223800           PMT-STANDARD-FULL
223900           MOVE '1' TO PPS-RTC-2
224000        END-IF
224100
224200        IF PPS-OUTLIER-PAY-AMT = 0 AND
224300           PMT-STANDARD-SSO
224400           MOVE '2' TO PPS-RTC-2
224500        END-IF
224600
224700        IF PPS-OUTLIER-PAY-AMT > 0 AND
224800           PMT-STANDARD-SSO
224900           MOVE '3' TO PPS-RTC-2
225000        END-IF
225100
225200     END-IF.
225300
225400
225500*-------------------------------------------------------------*
225600* BLENDED PAYMENT CLAIMS; SITE NEUTRAL PORTION = IPPS COMP.   *
225700*-------------------------------------------------------------*
225800     IF PMT-BLEND AND PMT-SITE-NEUT-IPPS
225900
226000        IF PPS-OUTLIER-PAY-AMT = 0 AND
226100           PMT-STANDARD-FULL
226200           MOVE '4' TO PPS-RTC-2
226300        END-IF
226400
226500        IF PPS-OUTLIER-PAY-AMT > 0 AND
226600           PMT-STANDARD-FULL
226700           MOVE '5' TO PPS-RTC-2
226800        END-IF
226900
227000        IF PPS-OUTLIER-PAY-AMT = 0 AND
227100           PMT-STANDARD-SSO
227200           MOVE '6' TO PPS-RTC-2
227300        END-IF
227400
227500        IF PPS-OUTLIER-PAY-AMT > 0 AND
227600           PMT-STANDARD-SSO
227700           MOVE '7' TO PPS-RTC-2
227800        END-IF
227900
228000     END-IF.
228100
228200
228300*-------------------------------------------------------------*
228400* 100% SITE NEUTRAL PAYMENT CLAIMS                            *
228500*-------------------------------------------------------------*
228600     IF PMT-SITE-NEUTRAL
228700
228800        IF PMT-SITE-NEUT-COST
228900           MOVE 'A' TO PPS-RTC-2
229000        END-IF
229100
229200        IF PMT-SITE-NEUT-IPPS
229300           IF PPS-OUTLIER-PAY-AMT = 0
229400              MOVE 'B' TO PPS-RTC-2
229500           ELSE
229600              MOVE 'C' TO PPS-RTC-2
229700           END-IF
229800        END-IF
229900     END-IF.
230000
230100
230200*-------------------------------------------------------------*
230300* 100% STANDARD PAYMENT CLAIMS                                *
230400*-------------------------------------------------------------*
230500     IF PMT-STANDARD-NEW
230600
230700        IF PMT-STANDARD-SSO AND
230800           PPS-OUTLIER-PAY-AMT = 0
230900           MOVE 'D' TO PPS-RTC-2
231000        END-IF
231100
231200        IF PMT-STANDARD-SSO AND
231300           PPS-OUTLIER-PAY-AMT > 0
231400           MOVE 'E' TO PPS-RTC-2
231500        END-IF
231600
231700        IF PMT-STANDARD-FULL AND
231800           PPS-OUTLIER-PAY-AMT = 0
231900           MOVE 'F' TO PPS-RTC-2
232000        END-IF
232100
232200        IF PMT-STANDARD-FULL AND
232300           PPS-OUTLIER-PAY-AMT > 0
232400           MOVE 'G' TO PPS-RTC-2
232500        END-IF
232600
232700     END-IF.
232800
232900
233000 7200-EXIT.
233100      EXIT.
233200
233300
233400***************************************************************
233500*   SEARCH FOR VENTILATOR SERVICE ICD-10 PROCEDURE CODE       *
233600***************************************************************
233700 7250-SEARCH-FOR-VENT-PROC.
233800***************************************************************
233900
234000     SET IDX-PROC TO 1.
234100
234200     SEARCH B-PROCEDURE-CODE VARYING IDX-PROC
234300         AT END
234400            SET VENT-NOT-PRESENT TO TRUE
234500         WHEN VENT-ICD-10-CODE = B-PROCEDURE-CODE (IDX-PROC)
234600            SET VENT-PRESENT TO TRUE
234700            GO TO 7250-EXIT
234800     END-SEARCH.
234900
235000 7250-EXIT.
235100      EXIT.
235200
235300
235400***************************************************************
235500*   SET RETURN CODES FOR SUBCLAUSE II PROVIDER CLAIMS         *
235600***************************************************************
235700*7300-SET-SUBII-RETURN-CODES.
235800***************************************************************
235900*
236000*    INITIALIZE PPS-RTC.
236100*
236200*-------------------------------------------------------------*
236300* SET RETURN CODE BASED ON PRESENCE/ABSENCE OF OUTLIER        *
236400*-------------------------------------------------------------*
236500*    IF PPS-OUTLIER-PAY-AMT > 0
236600*       MOVE '29' TO PPS-RTC
236700*    ELSE
236800*       MOVE '28' TO PPS-RTC
236900*    END-IF.
237000*
237100*-------------------------------------------------------------*
237200* MOVE PER DIEM AMOUNT TO OUTPUT RECORD VARIABLE              *
237300*-------------------------------------------------------------*
237400*    MOVE P-NEW-FAC-SPEC-RATE TO PPS-NEW-FAC-SPEC-RATE.
237500*
237600*-------------------------------------------------------------*
237700* INITIALIZE OUTPUT FIELDS THAT DON'T APPLY TO SUBCLAUSE II   *
237800*-------------------------------------------------------------*
237900*    INITIALIZE PPS-OUTLIER-PAY-AMT
238000*               PPS-DRG-ADJ-PAY-AMT
238100*               PPS-FED-PAY-AMT
238200*               PPS-FAC-COSTS
238300*               PPS-SUBM-DRG-CODE
238400*               PPS-NAT-LABOR-PCT
238500*               PPS-NAT-NONLABOR-PCT
238600*               PPS-STD-FED-RATE
238700*               PPS-BDGT-NEUT-RATE
238800*               PPS-IPTHRESH
238900*               PPS-SITE-NEUTRAL-COST-PMT
239000*               PPS-SITE-NEUTRAL-IPPS-PMT
239100*               PPS-STANDARD-FULL-PMT
239200*               PPS-STANDARD-SSO-PMT.
239300*
239400*
239500*7300-EXIT.
239600*     EXIT.
239700
239800
239900***************************************************************
240000*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
240100*   UNIQUE CALCULATION FOR EACH CLAIM PAYMENT TYPE COMBO      *
240200***************************************************************
240300 8000-CALC-FINAL-PMT.
240400***************************************************************
240500
240600
240700*-------------------------------------------------------------*
240800* SUBCLAUSE II CLAIMS                                         *
240900*   P-NEW-FAC-SPEC-RATE = PER DIEM PMT RATE FOR SUBCLAUSE II  *
241000*-------------------------------------------------------------*
241100*    IF SUBCLAUSEII-PROV
241200*       COMPUTE PPS-FINAL-PAY-AMT ROUNDED =
241300*               P-NEW-FAC-SPEC-RATE *
241400*               B-CST-RPT-DAYS
241500*       GO TO 8000-EXIT
241600*    END-IF.
241700
241800
241900*-------------------------------------------------------------*
242000* OLD POLICY CLAIMS (100% STANDARD PAYMENT)                   *
242100*-------------------------------------------------------------*
242200     IF PMT-STANDARD-OLD
242300        COMPUTE PPS-FINAL-PAY-AMT =
242400                PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
242500     END-IF.
242600
242700
242800*-------------------------------------------------------------*
242900* NEW POLICY CLAIMS (ANY PAYMENT TYPE)                        *
243000*     - ONLY APPLICABLE PAYMENT FIELDS CONTAIN VALUES > $0    *
243100*     - APPLY BUDGET NEUTRALITY AND/OR BLEND TO PAYMENT       *
243200*       IF NEEDED                                             *
243300*     - ANY APPLICABLE BUDGET NEUTRALITY AND/OR BLEND WAS     *
243400*       ALREADY APPLIED TO OUTLIER PAYMENT                    *
243500*-------------------------------------------------------------*
243600     IF NOT PMT-STANDARD-OLD
243700
243800*-------------------------------------------------------*
243900* APPLY BUDGET NEUTRALITY AND SITE-NEUTRAL IPPS ADJ.    *
244000* TO 100% SITE-NEUTRAL PAYMENTS                         *
244100*-------------------------------------------------------*
244200        IF PMT-SITE-NEUTRAL
244300           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
244400                   PPS-SITE-NEUTRAL-COST-PMT *
244500                   H-BDGT-NEUT-FACTOR
244600
244700           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
244800                   PPS-SITE-NEUTRAL-IPPS-PMT *
244900                   H-BDGT-NEUT-FACTOR *
245000                   H-SITE-NEUTRAL-IPPS-ADJ
245100
245200           COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
245300                   PPS-OUTLIER-PAY-AMT *
245400                   H-SITE-NEUTRAL-IPPS-ADJ
245500        END-IF
245600
245700
245800*-------------------------------------------------------*
245900* APPLY BLEND PERCENTS, BUDGET NEUT, AND SITE-NEUTRAL   *
246000* IPPS ADJUSTMENT TO BLENDED PAYMENTS                   *
246100*-------------------------------------------------------*
246200        IF PMT-BLEND
246300           COMPUTE PPS-SITE-NEUTRAL-COST-PMT ROUNDED =
246400                   PPS-SITE-NEUTRAL-COST-PMT *
246500                   H-BDGT-NEUT-FACTOR *
246600                   H-BLEND-SNT
246700
246800           COMPUTE PPS-SITE-NEUTRAL-IPPS-PMT ROUNDED =
246900                   PPS-SITE-NEUTRAL-IPPS-PMT *
247000                   H-BDGT-NEUT-FACTOR *
247100                   H-SITE-NEUTRAL-IPPS-ADJ *
247200                   H-BLEND-SNT
247300
247400           COMPUTE PPS-STANDARD-FULL-PMT ROUNDED =
247500                   PPS-STANDARD-FULL-PMT * H-BLEND-STD
247600
247700           COMPUTE PPS-STANDARD-SSO-PMT ROUNDED =
247800                   PPS-STANDARD-SSO-PMT * H-BLEND-STD
247900        END-IF
248000
248100*-------------------------------------------------------*
248200* SUM PAYMENT FIELDS FOR FINAL PAYMENT                  *
248300*-------------------------------------------------------*
248400        COMPUTE PPS-FINAL-PAY-AMT =
248500                PPS-STANDARD-FULL-PMT +
248600                PPS-STANDARD-SSO-PMT +
248700                PPS-SITE-NEUTRAL-COST-PMT +
248800                PPS-SITE-NEUTRAL-IPPS-PMT +
248900                PPS-OUTLIER-PAY-AMT
249000     END-IF.
249100
249200
249300 8000-EXIT.
249400      EXIT.
249500
249600
249700***************************************************************
249800 9000-MOVE-RESULTS.
249900***************************************************************
250000
250100
250200*-------------------------------------------------------------*
250300* IF CLAIM PRICED, MOVE LENGTH OF STAY & VERSION TO OUTPUT    *
250400*-------------------------------------------------------------*
250500     IF NOT OLD-ERROR-CODE AND NOT NEW-ERROR-CODE
250600        MOVE H-LOS TO PPS-LOS
250700        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
250800
250900*-------------------------------------------------------------*
251000* IF CLAIM DIDN'T PRICE DUE TO AN ERROR, INITIALIZE ALL       *
251100* OUTPUT DATA EXCEPT FOR PPS-RTC AND PPS-CHRG-THRESHOLD,      *
251200* INITIALIZE WORK VARIABLES, AND MOVE VERSION TO OUTPUT       *
251300*-------------------------------------------------------------*
251400     ELSE
251500       INITIALIZE PPS-DATA
251600       INITIALIZE PPS-OTHER-DATA
251700       INITIALIZE PPS-CBSA
251800       INITIALIZE HOLD-PPS-COMPONENTS
251900       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
252000     END-IF.
252100
252200
252300*** *************************************************** ***
252400*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***
252500*** *************************************************** ***
252600
252700*    IF (B-PROVIDER-NO = '371833'
252800*                    OR  '111802'
252900*                    OR  '011803'
253000*                    OR  '371804'
253100*                    OR  '101805'
253200*                    OR  '531806'
253300*                    OR  '141807'
253400*       )
253500*
253600*
253700*    DISPLAY '---------------------------------------------'
253800*    DISPLAY '*********************************************'
253900*    DISPLAY '---------------------------------------------'
254000*    DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
254100*    DISPLAY 'PPS-RTC '                  PPS-RTC
254200*    DISPLAY 'PSF EFFECTIVE DATE '       P-NEW-EFF-DATE
254300*    DISPLAY 'CBSA EFF DATE '            W-EFF-DATE
254400*    DISPLAY 'BILL DISCHARGE DATE '      B-DISCHARGE-DATE
254500*    DISPLAY 'P-NEW-FAC-SPEC-RATE '      P-NEW-FAC-SPEC-RATE
254600*    DISPLAY 'COST REPORT DAYS '         B-CST-RPT-DAYS
254700*    DISPLAY 'WS-PRIMARY-PMT-TYPE '      WS-PRIMARY-PMT-TYPE
254800*    DISPLAY 'WS-SECONDARY-PMT-TYPE-SNT' WS-SECONDARY-PMT-TYPE-SNT
254900*    DISPLAY 'WS-SECONDARY-PMT-TYPE-STD' WS-SECONDARY-PMT-TYPE-STD
255000*    DISPLAY 'B-REVIEW-CODE '            B-REVIEW-CODE
255100*    DISPLAY 'B-PROCEDURE-CODE-TABLE '   B-PROCEDURE-CODE-TABLE
255200*    DISPLAY 'WS-VENT-STATUS '           WS-VENT-STATUS
255300*    DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT
255400*    DISPLAY 'PPS-SITE-NEUTRAL-COST-PM ' PPS-SITE-NEUTRAL-COST-PMT
255500*    DISPLAY 'PPS-SITE-NEUTRAL-IPPS-PM ' PPS-SITE-NEUTRAL-IPPS-PMT
255600*    DISPLAY 'PPS-STANDARD-FULL-PMT '    PPS-STANDARD-FULL-PMT
255700*    DISPLAY 'PPS-STANDARD-SSO-PMT '     PPS-STANDARD-SSO-PMT
255800*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
255900*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
256000*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
256100*    DISPLAY 'PPS-FAC-COSTS '            PPS-FAC-COSTS
256200*    DISPLAY 'H-FIXED-LOSS-AMT-STD '     H-FIXED-LOSS-AMT-STD
256300*    DISPLAY 'H-FIXED-LOSS-AMT-SNT '     H-FIXED-LOSS-AMT-SNT
256400*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
256500*    DISPLAY 'H-OUTLIER-THRESHOLD-STD '  H-OUTLIER-THRESHOLD-STD
256600*    DISPLAY 'PPS-CHRG-THRESHOLD '       PPS-CHRG-THRESHOLD
256700*    DISPLAY 'H-BDGT-NEUT-FACTOR '       H-BDGT-NEUT-FACTOR
256800*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
256900*    DISPLAY 'PPS-CBSA '                 PPS-CBSA
257000*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
257100*    DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
257200*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
257300*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
257400*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE
257500*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
257600*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
257700*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
257800*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
257900*    DISPLAY 'H-LOS '                    H-LOS
258000*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS
258100*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
258200*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
258300*    DISPLAY 'H-BLEND-SNT '              H-BLEND-SNT
258400*    DISPLAY 'H-BLEND-STD '              H-BLEND-STD
258500*    DISPLAY 'P-NEW-OPER-CSTCHG-RATIO '  P-NEW-OPER-CSTCHG-RATIO
258600*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
258700*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
258800*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
258900*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
259000*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
259100*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
259200*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
259300*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
259400*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
259500*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
259600*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
259700*    DISPLAY 'H-SSOT '                   H-SSOT
259800*    DISPLAY 'H-SS-COST '                H-SS-COST
259900*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
260000*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
260100*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
260200*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
260300*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
260400*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
260500*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
260600*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
260700*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE
260800*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
260900*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
261000*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
261100*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
261200*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
261300*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
261400*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND
261500*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
261600*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
261700*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
261800*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
261900*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
262000*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
262100*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
262200*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
262300*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
262400*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
262500*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
262600*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
262700*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
262800*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
262900*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
263000*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
263100*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
263200*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
263300*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
263400*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
263500*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
263600*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
263700*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
263800*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
263900*
264000*    END-IF.
264100
264200 9000-EXIT.
264300      EXIT.
264400
264500******        L A S T   S O U R C E   S T A T E M E N T   *****
