000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL141.
000300*AUTHOR.         CMS.
000400*REMARKS.        EFFECTIVE OCTOBER 1, 2013.
000500**************************************************
000600* UPDATED TO APPLY CHANGES
000700* FROM THE FY 2014 LTCH PPS PRICER SPEC SHEET
000800* (EFFECTIVE 10/1/2013 THROUGH 9/30/2014,
000900* UNLESS OTHERWISE NOTED)
001000* AS OF JULY 26, 2013
001100*
001200
001300* PRICER RATES/FACTORS/POLICY:
001400*
001500* FEDERAL RATE:
001600*  NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
001700*  REPORTING OF QUALITY DATA.
001800*   - FULL UPDATE (QUALITY INDICATOR ON PSF = 1):
001900*      $40,607.31.
002000*   - REDUCED UPDATE (QUALITY INDICATOR ON PSF = 0 OR BLANK):
002100*      $39,808,74
002200*  ADDED A NEW DATA ITEM FOR THE HOSPITAL QUALITY INDICATOR
002300*  CALLED P-NEW-HOSP-QUAL-IND TO READ IN POSITION 139 OF
002400*  THE PROVIDER SPECIFIC FILE AND USED IT TO CALCULATE
002500*  FEDERAL RATE
002600*
002700* LABOR SHARE: 62.537%
002800*
002900* NONLABOR SHARE: 37.463%
003000*
003100* HIGH COST OUTLIER FIXED-LOSS AMOUNT: $13,314
003200* (NO PAYMENT POLICYCHANGES)
003300*
003400* NEW WAGE INDEX TABLE.
003500*
003600* NEW MS-LTC-DRG WEIGHTS/LENGTH OF STAY/IPPS
003700* COMPARABLE THRESHOLD.
003800*
003900* SHORT-STAY OUTLIERS:
004000*
004100*   - NO POLICY CHANGES
004200*
004300*   - IPPS RATES/FACTORS:
004400*
004500*         IPPS LABOR SHARE WAGE INDEX > 1:
004600*          $3,737.71
004700*         IPPS NONLABOR SHARE WAGE INDEX > 1:
004800*          $1,632.57
004900*
005000*         IPPS LABOR SHARE WAGE INDEX < /= 1:
005100*          $3,329.57
005200*         IPPS NONLABOR SHARE WAGE INDEX < /= 1:
005300*          $2,040.71
005400*
005500*         PUERTO RICO LABOR SHARE WAGE INDEX > 1:
005600*          $1,608.90
005700*         PUERTO RICO NONLABOR SHARE WAGE INDEX > 1:
005800*          $936.82
005900*
006000*         PUERTO RICO LABOR SHARE WAGE INDEX < /= 1:
006100*          $1,578.35
006200*         PUERTO RICO NONLABOR SHARE WAGE INDEX < /= 1:
006300*          $967.37
006400*
006500*         CAPITAL NATIONAL RATE:  $429.31
006600*         CAPITAL PUERTO RICO RATE:  $209.82
006700*
006800*         IPPS WAGE INDEXES FROM TABLES 4A & 4B
006900*
007000*         POLICY CHANGE FOR IPPS COMPARABLE OPERATING
007100*         DSH PAYMENT AMOUNT
007200*          - REDUCE CURRENT OPERATING DSH PAYMENT
007300*            CALCULATION TO 95.7% (FACTOR OF 0.957)
007400*            OF THE AMOUNT CALCULATED UNDER THE CURRENT
007500*            FORMULA IN THE PRICER.
007600*            (NOTE: THIS PERCENTAGE REDUCTION WILL BE
007700*            UPDATED ANNUALLY.) THIS REDUCTION IS NOT
007800*            APPLIED TO THE CAPITAL DSH PAYMENT
007900*            CALCULATION.
008000*          - IMPLEMENTED BY CREATING A NEW VARIABLE
008100*            TO HOLD THE OPERATING DSH REDUCTION FACTOR
008200*            AND NAMING IT H-OPER-DSH-REDUCTION-FACTOR
008300*            AND ADDING A LINE OF CODE TO PERFORM THE
008400*            REDUCTION (FOR UNCOMPENSATED CARE PAYMENT).
008500*
008600*         NO IPPS POLICY CHANGES FOR IME
008700*
008800* 9-3-13 VERSION 141 TO INCORPORATE THE NEW LTCH AND
008900* IPPS WAGE INDEX TABLES
009000*
009100**************************************************
009200 ENVIRONMENT DIVISION.
009300 CONFIGURATION SECTION.
009400 SOURCE-COMPUTER.            IBM-370.
009500 OBJECT-COMPUTER.            IBM-370.
009600 INPUT-OUTPUT  SECTION.
009700 FILE-CONTROL.
009800
009900 DATA DIVISION.
010000 FILE SECTION.
010100
010200 WORKING-STORAGE SECTION.
010300 01  W-STORAGE-REF                  PIC X(46)  VALUE
010400     'LTCAL141      - W O R K I N G   S T O R A G E'.
010500 01  CAL-VERSION                    PIC X(05)  VALUE 'V14.1'.
010600 01  PROGRAM-CONSTANTS.
010700     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
010800     05  FED-FY-BEGIN-04            PIC 9(08) VALUE 20031001.
010900     05  FED-FY-BEGIN-05            PIC 9(08) VALUE 20041001.
011000     05  FED-FY-BEGIN-06            PIC 9(08) VALUE 20051001.
011100     05  FED-FY-BEGIN-07            PIC 9(08) VALUE 20061001.
011200
011300
011400***************************************************************
011500*    LAYUP TABLE AREA FOR FY2014 LTC-DRG                      *
011600*    EFFECTIVE DATE OF OCTOBER 1, 2013                        *
011700***************************************************************
011800 COPY LTDRG141.
011900
012000
012100***************************************************************
012200*    LAYUP TABLE AREA FOR FY2014 IPPS-DRG                     *
012300*    EFFECTIVE DATE OF OCTOBER 1, 2013                        *
012400***************************************************************
012500 COPY IPDRG141.
012600
012700
012800***************************************************************
012900*    LAYUP TABLE AREA FOR FY2013 IPPS STATE SPECIFIC RFBNS    *
013000*    EFFECTIVE DATE OF OCTOBER 1, 2012 - NO TBL FOR FY 2013   *
013100***************************************************************
013200*COPY IRFBN***.
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
068200*** -----------------------------------------------------***
068300     PERFORM 1900-APPLY-SSRFBN
068400        THRU 1900-EXIT.
068500
068600     IF PPS-RTC NOT = 00
068700        GO TO 0100-EXIT
068800     END-IF.
068900
069000*** ---------------------------------------------------- ***
069100*** RATES FOR LTCH PAYMENT: CHANGE IN OCTOBER            ***
069200*** ---------------------------------------------------- ***
069300     MOVE .62537   TO PPS-NAT-LABOR-PCT.
069400     MOVE .37463   TO PPS-NAT-NONLABOR-PCT.
069500* NEW BEGINNING IN FY 2014, RATE BASED ON SUCCESSFUL
069600* REPORTING OF QUALITY DATA.
069700* - FULL UPDATE (QUALITY INDICATOR ON PSF = 1):
069800*     $40,607.31
069900* - REDUCED UPDATE (QUALTITY INDICATOR ON PSF = 0 OR BLANK):
070000*     $39808.74
070100     IF P-NEW-HOSP-QUAL-IND = '1'
070200        MOVE 40607.31 TO PPS-STD-FED-RATE
070300     ELSE
070400        MOVE 39808.74 TO PPS-STD-FED-RATE.
070500     MOVE 13314.00 TO H-FIXED-LOSS-AMT.
070600     MOVE 1.000    TO PPS-BDGT-NEUT-RATE.
070700
070800*** ---------------------------------------------------- ***
070900*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
071000*** ---------------------------------------------------- ***
071100     MOVE 429.31 TO H-IPPS-CAPI-STD-FED-RATE.
071200     MOVE 209.82 TO H-IPPS-CAPI-STD-PR-RATE.
071300     MOVE 0.75   TO H-NAT-IPPS-PMT-PCT.
071400     MOVE 0.25   TO H-PR-IPPS-PMT-PCT.
071500
071600     IF H-IPPS-WAGE-INDEX > 1
071700        MOVE 3737.71 TO H-IPPS-NAT-LABOR-SHR
071800        MOVE 1632.57 TO H-IPPS-NAT-NONLABOR-SHR
071900     ELSE
072000        MOVE 3329.57 TO H-IPPS-NAT-LABOR-SHR
072100        MOVE 2040.71 TO H-IPPS-NAT-NONLABOR-SHR
072200     END-IF.
072300
072400     IF W-IPPS-PR-WAGE-INDEX > 1
072500        MOVE 1608.90 TO H-IPPS-PR-LABOR-SHR
072600        MOVE  936.82 TO H-IPPS-PR-NONLABOR-SHR
072700     ELSE
072800        MOVE 1578.35 TO H-IPPS-PR-LABOR-SHR
072900        MOVE  967.37 TO H-IPPS-PR-NONLABOR-SHR
073000     END-IF.
073100
073200*** ---------------------------------------------------- ***
073300*** OPERATING DSH REDUCTION FACTOR                       ***
073400*** -----------------------------------------------------***
073500     MOVE .9570 TO H-OPER-DSH-REDUCTION-FACTOR.
073600
073700 0100-EXIT.
073800      EXIT.
073900
074000
074100***************************************************************
074200*    BILL DATA EDITS - IF ANY FAIL SET PPS-RTC                *
074300*    AND DO NOT ATTEMPT TO PRICE.                             *
074400***************************************************************
074500 1000-EDIT-THE-BILL-INFO.
074600***************************************************************
074700
074800     IF (B-LOS NUMERIC) AND (B-LOS > 0)
074900        MOVE B-LOS TO H-LOS
075000     ELSE
075100        MOVE 56 TO PPS-RTC.
075200
075300     IF PPS-RTC = 00
075400       IF P-NEW-COLA NOT NUMERIC
075500          MOVE 50 TO PPS-RTC.
075600
075700     IF PPS-RTC = 00
075800       IF P-NEW-WAIVER-STATE
075900          MOVE 53 TO PPS-RTC.
076000
076100     IF PPS-RTC = 00
076200         IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
076300            (B-DISCHARGE-DATE < W-EFF-DATE))
076400            MOVE 55 TO PPS-RTC.
076500
076600     IF PPS-RTC = 00
076700         IF P-NEW-TERMINATION-DATE > 00000000
076800            IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
076900               MOVE 51 TO PPS-RTC.
077000
077100     IF PPS-RTC = 00
077200         IF B-COV-CHARGES NOT NUMERIC
077300            MOVE 58 TO PPS-RTC.
077400
077500     IF PPS-RTC = 00
077600        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
077700           MOVE 61 TO PPS-RTC.
077800
077900     IF PPS-RTC = 00
078000        IF (B-COV-DAYS NOT NUMERIC) OR
078100           (B-COV-DAYS = 0 AND H-LOS > 0)
078200           MOVE 62 TO PPS-RTC.
078300
078400     IF PPS-RTC = 00
078500        IF B-LTR-DAYS > B-COV-DAYS
078600           MOVE 62 TO PPS-RTC.
078700
078800     IF PPS-RTC = 00
078900        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
079000        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
079100
079200     IF PPS-RTC = 00
079300        PERFORM 1200-DAYS-USED
079400           THRU 1200-DAYS-USED-EXIT.
079500
079600
079700*** -----------------------------------------------------------
079800*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
079900*** -----------------------------------------------------------
080000     IF PPS-RTC = 00
080100        IF P-NEW-CAPI-IME NUMERIC
080200           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
080300        ELSE
080400           MOVE ZEROS TO H-CAPI-IME-RATIO
080500        END-IF
080600     END-IF.
080700
080800     IF PPS-RTC = 00
080900        IF P-NEW-INTERN-RATIO NUMERIC
081000           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
081100        ELSE
081200           MOVE ZEROS TO H-INTERN-RATIO
081300        END-IF
081400     END-IF.
081500
081600     IF PPS-RTC = 00
081700        IF P-NEW-BED-SIZE NUMERIC
081800           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
081900        ELSE
082000           MOVE ZEROS TO H-BED-SIZE
082100        END-IF
082200     END-IF.
082300
082400     IF PPS-RTC = 00
082500        IF P-NEW-SSI-RATIO NUMERIC
082600           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
082700        ELSE
082800           MOVE ZEROS TO H-SSI-RATIO
082900        END-IF
083000     END-IF.
083100
083200     IF PPS-RTC = 00
083300        IF P-NEW-MEDICAID-RATIO NUMERIC
083400           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
083500        ELSE
083600           MOVE ZEROS TO H-MEDICAID-RATIO
083700        END-IF
083800     END-IF.
083900
084000
084100 1000-EXIT.
084200      EXIT.
084300
084400
084500***************************************************************
084600 1200-DAYS-USED.
084700***************************************************************
084800
084900     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
085000        IF B-LTR-DAYS > H-LOS
085100           MOVE H-LOS TO PPS-LTR-DAYS-USED
085200        ELSE
085300           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
085400     ELSE
085500        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
085600           IF H-REG-DAYS > H-LOS
085700              MOVE H-LOS TO PPS-REG-DAYS-USED
085800           ELSE
085900              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
086000        ELSE
086100           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
086200              IF H-REG-DAYS > H-LOS
086300                 MOVE H-LOS TO PPS-REG-DAYS-USED
086400                 MOVE 0 TO PPS-LTR-DAYS-USED
086500              ELSE
086600                 IF H-TOTAL-DAYS > H-LOS
086700                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
086800                    COMPUTE PPS-LTR-DAYS-USED =
086900                            H-LOS - H-REG-DAYS
087000                 ELSE
087100                    IF H-TOTAL-DAYS <= H-LOS
087200                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
087300                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
087400                    ELSE
087500                       NEXT SENTENCE
087600           ELSE
087700              NEXT SENTENCE.
087800
087900 1200-DAYS-USED-EXIT.
088000      EXIT.
088100
088200
088300***************************************************************
088400*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
088500***************************************************************
088600 1700-EDIT-DRG-CODE.
088700***************************************************************
088800
088900     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
089000     IF PPS-RTC = 00
089100        SEARCH ALL WWM-ENTRY
089200           AT END
089300             MOVE 54 TO PPS-RTC
089400        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
089500             PERFORM 1750-FIND-VALUE
089600                THRU 1750-EXIT
089700        END-SEARCH.
089800
089900 1700-EXIT.
090000      EXIT.
090100
090200
090300***************************************************************
090400*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
090500***************************************************************
090600 1750-FIND-VALUE.
090700***************************************************************
090800
090900      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
091000      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
091100      MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
091200
091300 1750-EXIT.
091400      EXIT.
091500
091600
091700***************************************************************
091800*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
091900***************************************************************
092000 1800-EDIT-IPPS-DRG-CODE.
092100***************************************************************
092200
092300     IF B-DRG-CODE NOT NUMERIC
092400        MOVE 54 TO PPS-RTC
092500        GO TO 1800-EXIT
092600     END-IF.
092700
092800*THE FOLLOWING 26 OR SO LINES OF CODE WAS COPIED
092900*FROM THE FY14 IPPS PRICER LOCATED IN
093000*D29L.@BFN2699.INPATCOB.COBR140(PPCAL140)
093100*REPLACING THE CODE FROM LAST YEAR
093200*IN ORDER TO BE ABLE TO READ IN THE NEW FORMAT
093300*OF THE IPPS DRG TABLE
093400
093500     IF  B-DISCHARGE-DATE NOT < WK-DRGX-EFF-DATE
093600     SET DRG-IDX TO 1
093700     SEARCH DRG-TAB VARYING DRG-IDX
093800         AT END
093900           MOVE ' NO DRG CODE    FOUND' TO HLDDRG-DESC
094000           MOVE 'I' TO  HLDDRG-VALID
094100       WHEN WK-DRG-DRGX(DRG-IDX) = B-DRG-CODE
094200         MOVE DRG-DATA-TAB(DRG-IDX) TO HLDDRG-DATA.
094300
094400
094500     MOVE HLDDRG-DATA TO WK-HLDDRG-DATA2.
094600     MOVE  HLDDRG-DRGX         TO HLDDRG-DRGX2.
094700     MOVE  HLDDRG-WEIGHT       TO HLDDRG-WEIGHT2
094800                                  H-IPPS-DRG-WGT.
094900     MOVE  HLDDRG-GMALOS       TO HLDDRG-GMALOS2
095000                                  H-IPPS-DRG-ALOS.
095100     MOVE  HLDDRG-LOW          TO HLDDRG-LOW2.
095200     MOVE  HLDDRG-ARITH-ALOS   TO HLDDRG-ARITH-ALOS2
095300                                  H-IPPS-ARITH-ALOS.
095400     MOVE  HLDDRG-PAC          TO HLDDRG-PAC2.
095500     MOVE  HLDDRG-SPPAC        TO HLDDRG-SPPAC2.
095600     MOVE  HLDDRG-DESC         TO HLDDRG-DESC2.
095700     MOVE  'V'                 TO HLDDRG-VALID.
095800     MOVE ZEROES               TO H-IPPS-DAYS-CUTOFF.
095900
096000 1800-EXIT.
096100      EXIT.
096200
096300
096400***************************************************************
096500*    ADJUST THE IPPS WAGE INDEX BY THE STATE SPECIFIC         *
096600*    RURAL FLOOR BUDGET NEUTRALITY FACTOR (SSRFBN)            *
096700***************************************************************
096800 1900-APPLY-SSRFBN.
096900***************************************************************
097000
097100     MOVE W-IPPS-WAGE-INDEX    TO H-IPPS-WAGE-INDEX.
097200*    MOVE P-NEW-STATE          TO MES-PPS-STATE.
097300
097400*    PERFORM 1950-FIND-SSRFBN
097500*       THRU 1950-EXIT.
097600
097700*    IF PPS-RTC = 00
097800*       IF  P-NEW-SPECIAL-PAY-IND = '1' OR '2'
097900*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =
098000*                   H-IPPS-WAGE-INDEX * 1
098100*       ELSE
098200*           COMPUTE H-IPPS-WAGE-INDEX ROUNDED =
098300*                   H-IPPS-WAGE-INDEX * MES-SSRFBN-RATE
098400*       END-IF
098500*    END-IF.
098600
098700 1900-EXIT.
098800      EXIT.
098900
099000
099100***************************************************************
099200*    FIND THE IPPS STATE SPECIFIC RURAL FLOOR BUDGET          *
099300*    NEUTRALITY FACTOR (SSRFBN)                               *
099400***************************************************************
099500*1950-FIND-SSRFBN.
099600***************************************************************
099700
099800*    SET SSRFBN-IDX TO 1.
099900*    SEARCH SSRFBN-TAB VARYING SSRFBN-IDX
100000
100100*        AT END
100200*          MOVE 68 TO PPS-RTC
100300*          GO TO 1950-EXIT
100400
100500*        WHEN WK-SSRFBN-STATE(SSRFBN-IDX) = MES-PPS-STATE
100600*          MOVE WK-SSRFBN-REASON-ALL (SSRFBN-IDX) TO MES-SSRFBN.
100700
100800*1950-EXIT.
100900*     EXIT.
101000
101100
101200***************************************************************
101300***  GET THE PROVIDER SPECIFIC VARIABLES AND WAGE INDEX       *
101400*                                                             *
101500*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
101600*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
101700*    OF THAT VARIABLE.                                        *
101800*                                                             *
101900***************************************************************
102000 2000-ASSEMBLE-PPS-VARIABLES.
102100***************************************************************
102200
102300
102400*------------------------------------------------------*
102500* WAGE INDEX BLEND TABLE                               *
102600*------------------------------------------------------*
102700*                                                      *
102800*  BLEND YEAR   FEDERAL FY                BLEND        *
102900*  ----------   ----------------------    -----        *
103000*      1        10/01/2002 - 09/30/2003    1/5         *
103100*      2        10/01/2003 - 09/30/2004    2/5         *
103200*      3        10/01/2004 - 09/30/2005    3/5         *
103300*      4        10/01/2005 - 09/30/2006    4/5         *
103400*      5        10/01/2006 - INDEFINITE    5/5 (FULL)  *
103500*                                                      *
103600*------------------------------------------------------*
103700*                                                      *
103800* A PROVIDER WILL RECEIVE THE APPLICABLE BLEND FOR A   *
103900* GIVEN FEDERAL FY FOR CLAIMS DISCHARGED ON & AFTER    *
104000* ITS FY BEGIN DATE THAT FALLS WITHIN THAT FEDERAL FY. *
104100*                                                      *
104200*------------------------------------------------------*
104300
104400
104500***************************************************************
104600* ASSIGN FULL (5/5) WAGE INDEX TO ALL CLAIMS DISCHARGED ON    *
104700* AND AFTER 7/1/2008 (NEW FOR VERSION 2008.0)                 *
104800***************************************************************
104900     IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
105000        MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
105100     ELSE
105200        MOVE 52 TO PPS-RTC
105300        GO TO 2000-EXIT
105400     END-IF.
105500
105600
105700***************************************************************
105800* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
105900* (ALWAYS FED-FY-BEGIN-03)                                    *
106000***************************************************************
106100      IF P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
106200         MOVE 74 TO PPS-RTC
106300         GO TO 2000-EXIT
106400      END-IF.
106500
106600
106700***************************************************************
106800* USE SPECIAL WAGE INDEX WHEN INDICATED                       *
106900***************************************************************
107000     IF P-NEW-SPECIAL-PAY-IND = '1'
107100        IF P-NEW-SPECIAL-WAGE-INDEX NUMERIC AND
107200           P-NEW-SPECIAL-WAGE-INDEX > 0
107300           MOVE P-NEW-SPECIAL-WAGE-INDEX TO PPS-WAGE-INDEX
107400        ELSE
107500           MOVE 52 TO PPS-RTC
107600           GO TO 2000-EXIT
107700        END-IF
107800     END-IF.
107900
108000
108100***************************************************************
108200* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
108300***************************************************************
108400     IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
108500        MOVE 65 TO PPS-RTC.
108600
108700
108800***************************************************************
108900* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
109000***************************************************************
109100     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
109200
109300     IF PPS-BLEND-YEAR > 0 AND PPS-BLEND-YEAR < 6
109400        NEXT SENTENCE
109500     ELSE
109600        MOVE 72 TO PPS-RTC
109700        GO TO 2000-EXIT.
109800
109900     MOVE 0 TO H-BLEND-FAC.
110000     MOVE 1 TO H-BLEND-PPS.
110100     MOVE 0 TO H-BLEND-RTC.
110200
110300     IF PPS-BLEND-YEAR = 1
110400        MOVE .8 TO H-BLEND-FAC
110500        MOVE .2 TO H-BLEND-PPS
110600        MOVE 4 TO H-BLEND-RTC
110700     ELSE
110800       IF PPS-BLEND-YEAR = 2
110900          MOVE .6 TO H-BLEND-FAC
111000          MOVE .4 TO H-BLEND-PPS
111100          MOVE 8 TO H-BLEND-RTC
111200       ELSE
111300         IF PPS-BLEND-YEAR = 3
111400            MOVE .4 TO H-BLEND-FAC
111500            MOVE .6 TO H-BLEND-PPS
111600            MOVE 12 TO H-BLEND-RTC
111700         ELSE
111800           IF PPS-BLEND-YEAR = 4
111900              MOVE .2 TO H-BLEND-FAC
112000              MOVE .8 TO H-BLEND-PPS
112100              MOVE 16 TO H-BLEND-RTC.
112200
112300 2000-EXIT.
112400      EXIT.
112500
112600
112700***************************************************************
112800*    IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)           *
112900*        CALCULATE THE STANDARD PAYMENT AMOUNT.               *
113000*        CALCULATE THE SHORT-STAY OUTLIER AMOUNT.             *
113100***************************************************************
113200 3000-CALC-PAYMENT.
113300***************************************************************
113400
113500*** -------------------------------------------------- ***
113600*** FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII) ***
113700*** -------------------------------------------------- ***
113800     IF (P-NEW-STATE = 02 OR 12)
113900        MOVE P-NEW-COLA TO PPS-COLA
114000     ELSE
114100        MOVE 1.000 TO PPS-COLA
114200     END-IF.
114300
114400
114500     COMPUTE PPS-FAC-COSTS ROUNDED =
114600         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
114700
114800     COMPUTE H-LABOR-PORTION ROUNDED =
114900         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
115000          * PPS-WAGE-INDEX.
115100
115200     COMPUTE H-NONLABOR-PORTION ROUNDED =
115300         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
115400          * PPS-COLA.
115500
115600     COMPUTE PPS-FED-PAY-AMT ROUNDED =
115700         (H-LABOR-PORTION + H-NONLABOR-PORTION).
115800
115900     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
116000         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
116100
116200
116300*** -------------------------------------------------------- ***
116400*** FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY ***
116500*** -------------------------------------------------------- ***
116600     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
116700
116800*** --------------------------------------------- ***
116900*** DETERMINE WHETHER THE CLAIM IS A SHORT STAY   ***
117000*** --------------------------------------------- ***
117100*** H-SSOT ROUNDED AND EXPANDED TO 1 DECIMAL      ***
117200*** PLACE FOR RELEASE 07.1                        ***
117300*** --------------------------------------------- ***
117400     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
117500     IF H-LOS <= H-SSOT
117600        PERFORM 3400-SHORT-STAY
117700           THRU 3400-SHORT-STAY-EXIT.
117800
117900 3000-EXIT.
118000      EXIT.
118100
118200
118300***************************************************************
118400*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
118500*      OF THE AVG. LENGTH OF STAY THEN:                       *
118600*      - CALCULATE THE SHORT-STAY COST.                       *
118700*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *
118800*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *
118900*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *
119000*      - PAY THE LEAST OF:                                    *
119100*          1)SHORT STAY COST                                  *
119200*          2)SHORT STAY PAYMENT AMOUNT                        *
119300*          3)DRG ADJUSTED PAYMENT AMOUNT                      *
119400*          4)SHORT STAY BLENDED PAYMENT -OR-                  *
119500*          5)IPPS COMPARABLE AMOUNT                           *
119600*      - SET RETURN CODE TO INDICATE SHORT STAY PAYMENT TYPE  *
119700***************************************************************
119800
119900 3400-SHORT-STAY.
120000**************************************************************
120100*   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *
120200**************************************************************
120300     IF P-NEW-PROVIDER-NO = '332006'
120400        PERFORM 4000-SPECIAL-PROVIDER
120500           THRU 4000-SPECIAL-PROVIDER-EXIT
120600     ELSE
120700
120800**************************************************************
120900*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *
121000* ---------------------------------------------------------- *
121100*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *
121200**************************************************************
121300        MOVE PPS-FAC-COSTS TO H-SS-COST
121400
121500**************************************************************
121600*                                                            *
121700*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *
121800* ---------------------------------------------------------- *
121900*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *
122000*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *
122100*     THE LENGTH OF STAY IS CORRECT                          *
122200*                                                            *
122300**************************************************************
122400        COMPUTE H-SS-PAY-AMT ROUNDED =
122500         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
122600
122700**************************************************************
122800*                                                            *
122900*   SHORT STAY PROVISION #4 (BLEND OF SS PMT & IPPS          *
123000*   COMPARABLE PER DIEM AMT)                                 *
123100* ---------------------------------------------------------- *
123200*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
123300*   REMOVED FROM VERSION 09.0 BECAUSE CLAIMS DISCHARGED ON   *
123400*   AND AFTER 12/29/2008 ARE NOT ELIGIBLE FOR PROVISION #5.  *
123500*                                                            *
123600*   SHORT STAY PROVISION #5 (IPPS COMPARABLE PER DIEM) WAS   *
123700*   ADDED TO VERSION 13.0 BECAUSE CLAIMS DISCHARGED ON AND   *
123800*   AFTER 12/29/2012 ARE ELIGIBLE FOR PROVISION #5.          *
123900*                                                            *
124000**************************************************************
124100        IF H-IPPS-WAGE-INDEX NUMERIC AND
124200           H-IPPS-WAGE-INDEX > 0
124300*---------------------------------------------------------
124400*   #4 - CALCULATE BLENDED PAYMENT
124500*---------------------------------------------------------
124600           IF B-DISCHARGE-DATE >= 20121229
124700              IF H-LOS > PPS-IPTHRESH
124800                 PERFORM 3600-SS-BLENDED-PMT
124900                    THRU 3600-SS-BLENDED-PMT-EXIT
125000               ELSE
125100*---------------------------------------------------------
125200*   #5 - LOS (COVERED DAYS) <= IPPS COMPARABLE THRESHOLD
125300*        CALCULATE IPPS COMPARABLE PER DIEM AMT ONLY
125400*---------------------------------------------------------
125500                  PERFORM 3650-SS-IPPS-COMP-PMT
125600                     THRU 3650-SS-IPPS-COMP-PMT-EXIT
125700           ELSE
125800               PERFORM 3600-SS-BLENDED-PMT
125900                  THRU 3600-SS-BLENDED-PMT-EXIT
126000        ELSE
126100           MOVE 52 TO PPS-RTC
126200           GO TO 3400-SHORT-STAY-EXIT.
126300
126400**************************************************************
126500*                                                            *
126600*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *
126700*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *
126800* ---------------------------------------------------------- *
126900*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *
127000*                                                            *
127100**************************************************************
127200
127300     MOVE 'N' TO H-SS-COST-IND.
127400     MOVE 'N' TO H-SS-PERDIEM-IND.
127500     MOVE 'N' TO H-SS-BLEND-IND.
127600     MOVE 'N' TO H-SS-IPPSCOMP-IND.
127700
127800*---------------------------------------------------------
127900*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%
128000*   OF PER DIEM) AND DRG ADJUSTED PMT AMT
128100*---------------------------------------------------------
128200     IF H-SS-COST < H-SS-PAY-AMT
128300        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT
128400           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT
128500           MOVE 20 TO PPS-RTC
128600           MOVE 'Y' TO H-SS-COST-IND
128700        ELSE
128800           NEXT SENTENCE
128900        END-IF
129000     ELSE
129100        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT
129200           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT
129300           MOVE 21 TO PPS-RTC
129400           MOVE 'Y' TO H-SS-PERDIEM-IND
129500        ELSE
129600           NEXT SENTENCE
129700        END-IF
129800     END-IF.
129900
130000*---------------------------------------------------------
130100*   USE THE BLENDED PMT OR IPPS COMPARABLE AMT IF LESS
130200*   THAN THE OTHER OPTIONS
130300*---------------------------------------------------------
130400     IF P-NEW-PROVIDER-NO NOT = '332006'
130500*---------------------------------------------------------
130600*   COMPARE BLENDED PAYMENT
130700*---------------------------------------------------------
130800         IF B-DISCHARGE-DATE >= 20121229 AND
130900           H-LOS > PPS-IPTHRESH AND
131000           H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
131100               MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
131200               MOVE 22 TO PPS-RTC
131300               MOVE 'Y' TO H-SS-BLEND-IND
131400               MOVE 'N' TO H-SS-COST-IND
131500               MOVE 'N' TO H-SS-PERDIEM-IND
131600               MOVE 'N' TO H-SS-IPPSCOMP-IND
131700         ELSE
131800*---------------------------------------------------------
131900*   COMPARE IPPS COMPARABLE PER DIEM AMOUNT
132000*---------------------------------------------------------
132100             IF B-DISCHARGE-DATE >= 20121229 AND
132200               H-LOS <= PPS-IPTHRESH AND
132300               H-IPPS-PER-DIEM <= PPS-DRG-ADJ-PAY-AMT
132400                 MOVE H-IPPS-PER-DIEM TO PPS-DRG-ADJ-PAY-AMT
132500                 MOVE 26 TO PPS-RTC
132600                 MOVE 'Y' TO H-SS-IPPSCOMP-IND
132700                 MOVE 'N' TO H-SS-BLEND-IND
132800                 MOVE 'N' TO H-SS-COST-IND
132900                 MOVE 'N' TO H-SS-PERDIEM-IND
133000             ELSE
133100                 IF B-DISCHARGE-DATE < 20121229 AND
133200                   H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
133300                     MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
133400                     MOVE 22 TO PPS-RTC
133500                     MOVE 'Y' TO H-SS-BLEND-IND
133600                     MOVE 'N' TO H-SS-COST-IND
133700                     MOVE 'N' TO H-SS-PERDIEM-IND
133800                     MOVE 'N' TO H-SS-IPPSCOMP-IND
133900                 END-IF
134000             END-IF
134100         END-IF
134200     END-IF.
134300
134400 3400-SHORT-STAY-EXIT.
134500      EXIT.
134600
134700
134800***************************************************************
134900*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
135000*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
135100*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
135200*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
135300***************************************************************
135400 3600-SS-BLENDED-PMT.
135500***************************************************************
135600
135700*** ------------------------------------------------------ ***
135800*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
135900*** ------------------------------------------------------ ***
136000     IF H-SSOT < 25
136100        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
136200          H-LOS / H-SSOT
136300     ELSE
136400        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
136500          H-LOS / 25
136600     END-IF.
136700
136800     IF H-LTCH-BLEND-PCT > 1
136900        MOVE 1 TO H-LTCH-BLEND-PCT
137000     END-IF.
137100
137200
137300*** ------------------------------------------------------ ***
137400*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
137500*** ------------------------------------------------------ ***
137600     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
137700        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
137800
137900
138000*** ------------------------------------------------------ ***
138100*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
138200*** ------------------------------------------------------ ***
138300     PERFORM 3650-SS-IPPS-COMP-PMT
138400        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
138500
138600
138700*** ------------------------------------------------------ ***
138800*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
138900*** ------------------------------------------------------ ***
139000     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
139100       1 - H-LTCH-BLEND-PCT.
139200
139300
139400*** ------------------------------------------------------ ***
139500*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
139600*** ------------------------------------------------------ ***
139700     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
139800       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
139900
140000
140100*** ------------------------------------------------------ ***
140200*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
140300*** ------------------------------------------------------ ***
140400     COMPUTE H-SS-BLENDED-PMT ROUNDED =
140500       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
140600
140700
140800 3600-SS-BLENDED-PMT-EXIT.
140900      EXIT.
141000
141100
141200***************************************************************
141300*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
141400*   PER DIEM PAYMENT AMOUNT                                   *
141500***************************************************************
141600 3650-SS-IPPS-COMP-PMT.
141700***************************************************************
141800
141900*** -------------------------------------------------------
142000*** OPERATING TEACHING ADJUSTMENT
142100*** -------------------------------------------------------
142200     COMPUTE H-OPER-IME-TEACH ROUNDED =
142300        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
142400
142500
142600*** -------------------------------------------------------
142700*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
142800*** STARTING FY 2009 - REDUCE H-CAPI-IME-TEACH ROUNDED 50%
142900*** 02/17/2009 - 50% REDUCTION REMOVED DUE TO STIMULUS BILL
143000***              THIS CHANGE IS RETROACTIVE TO 10/01/2008
143100*** -------------------------------------------------------
143200     IF H-CAPI-IME-RATIO > 1.5000
143300        MOVE 1.5000 TO H-CAPI-IME-RATIO.
143400
143500     COMPUTE H-CAPI-IME-TEACH ROUNDED =
143600        ((2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1).
143700
143800
143900*** -------------------------------------------------------
144000*** OPERATING DSH ADJUSTMENT
144100*** -------------------------------------------------------
144200
144300*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
144400*---------------------------------------------------
144500     IF ALL-RURAL
144600        SET RURAL-CBSA TO TRUE
144700     ELSE
144800        SET URBAN-CBSA TO TRUE
144900     END-IF.
145000
145100
145200*2) CALCULATE THE OPERATING DSH PERCENT
145300*--------------------------------------
145400     COMPUTE H-OPER-DSH-PCT ROUNDED =
145500        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
145600
145700
145800*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
145900*-----------------------------------------------------
146000
146100*    URBAN, < 100 BEDS
146200*    -----------------
146300     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
146400        H-OPER-DSH-PCT >= .15
146500          MOVE '3' TO H-GEO-CLASS
146600     ELSE
146700
146800
146900*   URBAN, >= 100 BEDS
147000*   ------------------
147100       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
147200          H-OPER-DSH-PCT >= .15
147300            MOVE '2' TO H-GEO-CLASS
147400       ELSE
147500
147600
147700*   RURAL, >= 500 BEDS
147800*   ------------------
147900         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
148000            H-OPER-DSH-PCT >= .15
148100              MOVE '2' TO H-GEO-CLASS
148200         ELSE
148300
148400
148500*   RURAL, < 500 BEDS
148600*   -----------------
148700           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
148800              H-OPER-DSH-PCT >= .15
148900                MOVE '3' TO H-GEO-CLASS
149000           ELSE
149100
149200
149300*   OTHER
149400*   -----------------
149500              MOVE '4' TO H-GEO-CLASS
149600
149700           END-IF
149800         END-IF
149900       END-IF
150000     END-IF.
150100
150200
150300*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
150400*-----------------------------------------------------------
150500     EVALUATE H-GEO-CLASS
150600
150700*      GEOGRAPHIC CLASS 2
150800*      ------------------
150900       WHEN '2'
151000          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
151100             COMPUTE H-OPER-DSH ROUNDED =
151200               ((H-OPER-DSH-PCT - .15) * .65) + .025
151300          ELSE
151400             IF H-OPER-DSH-PCT > .202
151500                COMPUTE H-OPER-DSH ROUNDED =
151600                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
151700             ELSE
151800                MOVE ZEROS TO H-OPER-DSH
151900             END-IF
152000          END-IF
152100
152200*      GEOGRAPHIC CLASS 3
152300*      ------------------
152400       WHEN '3'
152500          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
152600             COMPUTE H-OPER-DSH ROUNDED =
152700               ((H-OPER-DSH-PCT - .15) * .65) + .025
152800             IF H-OPER-DSH > .12
152900                MOVE .12 TO H-OPER-DSH
153000             END-IF
153100          ELSE
153200             IF H-OPER-DSH-PCT > .202
153300                COMPUTE H-OPER-DSH ROUNDED =
153400                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
153500                IF H-OPER-DSH > .12
153600                   MOVE .12 TO H-OPER-DSH
153700                END-IF
153800             ELSE
153900               MOVE ZEROS TO H-OPER-DSH
154000             END-IF
154100          END-IF
154200
154300*      GEOGRAPHIC CLASS 4
154400*      ------------------
154500       WHEN '4'
154600          MOVE ZEROS TO H-OPER-DSH
154700
154800     END-EVALUATE.
154900
155000
155100*** -------------------------------------------------------
155200*** CURRENT OPERATING DSH PAYMENT REDUCTION
155300*** -------------------------------------------------------
155400     COMPUTE H-OPER-DSH ROUNDED =
155500             H-OPER-DSH * H-OPER-DSH-REDUCTION-FACTOR.
155600
155700*** -------------------------------------------------------
155800*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
155900*** -------------------------------------------------------
156000     IF URBAN-CBSA AND H-BED-SIZE >= 100
156100        COMPUTE H-CAPI-DSH ROUNDED =
156200          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
156300     ELSE
156400        MOVE ZEROS TO H-CAPI-DSH
156500     END-IF.
156600
156700
156800*** -------------------------------------------------------
156900*** OPERATING PAYMENT (STANDARD AMOUNT)
157000*** -------------------------------------------------------
157100     IF (P-NEW-STATE = 02 OR 12)
157200        MOVE P-NEW-COLA TO H-OPER-COLA
157300     ELSE
157400        MOVE 1.000 TO H-OPER-COLA
157500     END-IF.
157600
157700     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
157800       ( (H-IPPS-NAT-LABOR-SHR * H-IPPS-WAGE-INDEX) +
157900         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
158000         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
158100
158200
158300*** -------------------------------------------------------
158400*** CAPITAL PAYMENT (CAPITAL RATE)
158500*** -------------------------------------------------------
158600     COMPUTE H-CAPI-COLA ROUNDED =
158700       (.3152 * (H-OPER-COLA - 1) + 1).
158800
158900*--------------------------------------------------------------*
159000*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
159100*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
159200*--------------------------------------------------------------*
159300     IF LARGE-URBAN
159400        MOVE 1.00 TO H-LRGURB-ADD-ON
159500     ELSE
159600        MOVE 1.00 TO H-LRGURB-ADD-ON
159700     END-IF.
159800
159900     COMPUTE H-CAPI-GAF ROUNDED =
160000       (H-IPPS-WAGE-INDEX ** .6848).
160100
160200     COMPUTE H-CAPI-PMT ROUNDED =
160300       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
160400       H-LRGURB-ADD-ON *  H-CAPI-COLA *
160500       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
160600
160700
160800*** -------------------------------------------------------
160900*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
161000*** -------------------------------------------------------
161100     COMPUTE H-IPPS-PAY-AMT ROUNDED =
161200       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
161300
161400
161500*** -------------------------------------------------------
161600*** IPPS COMPARABLE PER DIEM PAYMENT
161700*** -------------------------------------------------------
161800     COMPUTE H-IPPS-PER-DIEM ROUNDED =
161900       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
162000
162100     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
162200        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
162300     END-IF.
162400
162500*** -------------------------------------------------------
162600*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
162700*** -------------------------------------------------------
162800     IF P-NEW-STATE = 40
162900        PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT
163000     END-IF.
163100
163200
163300 3650-SS-IPPS-COMP-PMT-EXIT.
163400      EXIT.
163500
163600
163700***************************************************************
163800 3675-SS-IPPS-COMP-PR-PMT.
163900***************************************************************
164000
164100*** -------------------------------------------------------
164200*** PUERTO RICO OPERATING PAYMENT (STANDARD AMOUNT)
164300*** -------------------------------------------------------
164400     COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =
164500        ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +
164600          (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *
164700          H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
164800
164900
165000*** -------------------------------------------------------
165100*** PUERTO RICO CAPITAL PAYMENT (CAPITAL RATE)
165200*** -------------------------------------------------------
165300     COMPUTE H-PR-CAPI-GAF ROUNDED =
165400        (W-IPPS-PR-WAGE-INDEX ** .6848).
165500
165600     COMPUTE H-PR-CAPI-PMT ROUNDED =
165700        H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *
165800        H-LRGURB-ADD-ON * H-CAPI-COLA *
165900        (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
166000
166100
166200*** -------------------------------------------------------
166300*** PR IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
166400*** -------------------------------------------------------
166500     COMPUTE H-IPPS-PR-PAY-AMT ROUNDED =
166600        H-PR-STAND-AMT-OPER-PMT + H-PR-CAPI-PMT.
166700
166800
166900*** -------------------------------------------------------
167000*** PUERTO RICO IPPS COMPARABLE PER DIEM PAYMENT
167100*** -------------------------------------------------------
167200     COMPUTE H-IPPS-PR-PER-DIEM ROUNDED =
167300        (H-IPPS-PR-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
167400
167500     IF H-IPPS-PR-PER-DIEM > H-IPPS-PR-PAY-AMT
167600        MOVE H-IPPS-PR-PAY-AMT TO H-IPPS-PR-PER-DIEM
167700     END-IF.
167800
167900
168000*** -------------------------------------------------------
168100*** BLEND FEDERAL PER DIEM AND PUERTO RICO PER DIEM
168200*** -------------------------------------------------------
168300     COMPUTE H-IPPS-PER-DIEM ROUNDED =
168400        (H-IPPS-PER-DIEM    * H-NAT-IPPS-PMT-PCT) +
168500        (H-IPPS-PR-PER-DIEM * H-PR-IPPS-PMT-PCT ).
168600
168700
168800 3675-EXIT.
168900      EXIT.
169000
169100
169200***************************************************************
169300 4000-SPECIAL-PROVIDER.
169400***************************************************************
169500
169600*** PROCESS FOR CY2003
169700*** ------------------
169800     IF (B-DISCHARGE-DATE >= 20030701) AND
169900        (B-DISCHARGE-DATE <  20040101)
170000        COMPUTE H-SS-COST ROUNDED =
170100            (PPS-FAC-COSTS * 1.95)
170200        COMPUTE H-SS-PAY-AMT ROUNDED =
170300         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
170400     END-IF
170500
170600
170700*** PROCESS FOR CY2004
170800*** ------------------
170900     IF (B-DISCHARGE-DATE >= 20040101) AND
171000        (B-DISCHARGE-DATE <  20050101)
171100        COMPUTE H-SS-COST ROUNDED =
171200            (PPS-FAC-COSTS * 1.93)
171300        COMPUTE H-SS-PAY-AMT ROUNDED =
171400          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
171500     END-IF
171600
171700
171800*** PROCESS FOR CY2005
171900*** ------------------
172000     IF (B-DISCHARGE-DATE >= 20050101) AND
172100        (B-DISCHARGE-DATE <  20060101)
172200        COMPUTE H-SS-COST ROUNDED =
172300            (PPS-FAC-COSTS * 1.65)
172400        COMPUTE H-SS-PAY-AMT ROUNDED =
172500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
172600     END-IF
172700
172800
172900*** PROCESS FOR CY2006
173000*** ------------------
173100     IF (B-DISCHARGE-DATE >= 20060101) AND
173200        (B-DISCHARGE-DATE <  20070101)
173300        COMPUTE H-SS-COST ROUNDED =
173400            (PPS-FAC-COSTS * 1.36)
173500        COMPUTE H-SS-PAY-AMT ROUNDED =
173600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
173700     END-IF
173800
173900
174000*** PROCESS FOR CY2007 AND AFTER
174100*** ----------------------------
174200     IF (B-DISCHARGE-DATE >= 20070101)
174300        COMPUTE H-SS-COST ROUNDED =
174400            (PPS-FAC-COSTS * 1.2)
174500        COMPUTE H-SS-PAY-AMT ROUNDED =
174600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
174700     END-IF.
174800
174900 4000-SPECIAL-PROVIDER-EXIT.
175000      EXIT.
175100
175200
175300***************************************************************
175400*   CALCULATE THE OUTLIER THRESHOLD                           *
175500*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
175600*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
175700*   SET RETURN CODE TO INDICATE OUTLIER PAYMENT METHOD        *
175800***************************************************************
175900 7000-CALC-OUTLIER.
176000***************************************************************
176100
176200     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
176300         PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT.
176400
176500     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
176600        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
176700         ((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
176800           * PPS-BDGT-NEUT-RATE * H-BLEND-PPS.
176900
177000     IF B-SPEC-PAY-IND = '1'
177100        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
177200
177300     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 21
177400        MOVE 24 TO PPS-RTC.
177500
177600     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 22
177700        MOVE 25 TO PPS-RTC.
177800
177900     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 26
178000        MOVE 27 TO PPS-RTC.
178100
178200     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 00
178300        MOVE 01 TO PPS-RTC.
178400
178500     IF (PPS-RTC = 00 OR 20 OR 21 OR 22 OR 26)
178600        IF PPS-REG-DAYS-USED > H-SSOT
178700           MOVE 0 TO PPS-LTR-DAYS-USED
178800        ELSE
178900           NEXT SENTENCE.
179000
179100     IF (PPS-RTC = 01 OR 24 OR 25 OR 27) OR
179200        (PPS-COT-IND = 'Y')
179300
179400        IF (B-COV-DAYS < H-LOS) OR
179500           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
179600           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
179700             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
179800
179900*** ------------------------------------------------------- ***
180000*** SET PPS-RTC TO 67 IN MAINFRAME PRICER, NOT IN PC PRICER ***
180100*** (IN PC PRICER, PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS)   ***
180200*** ------------------------------------------------------- ***
180300           IF NOT PC-PRICER
180400              MOVE 67 TO PPS-RTC
180500           END-IF
180600
180700        ELSE
180800           NEXT SENTENCE
180900        END-IF
181000     ELSE
181100        NEXT SENTENCE
181200     END-IF.
181300
181400
181500 7000-EXIT.
181600      EXIT.
181700
181800
181900***************************************************************
182000*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
182100*   SET RTC FOR SPECIFIED BLEND YEAR INDICATOR.               *
182200***************************************************************
182300 8000-BLEND.
182400***************************************************************
182500
182600     COMPUTE H-LOS-RATIO ROUNDED = H-LOS / PPS-AVG-LOS.
182700
182800     IF H-LOS-RATIO > 1
182900        COMPUTE H-LOS-RATIO = ((H-LOS-RATIO - 1) * .8) + 1.
183000
183100     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
183200           (PPS-DRG-ADJ-PAY-AMT * PPS-BDGT-NEUT-RATE)
183300             * H-BLEND-PPS.
183400
183500     COMPUTE PPS-NEW-FAC-SPEC-RATE ROUNDED =
183600            (P-NEW-FAC-SPEC-RATE * PPS-BDGT-NEUT-RATE)
183700              * H-BLEND-FAC * H-LOS-RATIO.
183800
183900     COMPUTE PPS-FINAL-PAY-AMT =
184000          PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
184100              + PPS-NEW-FAC-SPEC-RATE.
184200
184300
184400*----------------------------------------------------------*
184500* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/O OUTLIER *
184600*----------------------------------------------------------*
184700     IF (PPS-RTC = 20 OR 21 OR 22 OR 26) AND (H-BLEND-RTC > 0)
184800          COMPUTE PPS-RTC = H-BLEND-RTC + 2
184900
185000*----------------------------------------------------------*
185100* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/ OUTLIER  *
185200*----------------------------------------------------------*
185300     ELSE
185400        IF (PPS-RTC = 24 OR 25 OR 27) AND (H-BLEND-RTC > 0)
185500           COMPUTE PPS-RTC = H-BLEND-RTC + 3
185600
185700*----------------------------------------------------------*
185800* CALCULATE RETURN CODE FOR ALL OTHER BILLS                *
185900*----------------------------------------------------------*
186000        ELSE
186100           ADD H-BLEND-RTC TO PPS-RTC
186200
186300        END-IF
186400     END-IF.
186500
186600 8000-EXIT.
186700      EXIT.
186800
186900
187000***************************************************************
187100 9000-MOVE-RESULTS.
187200***************************************************************
187300
187400     IF PPS-RTC < 50
187500        MOVE H-LOS TO PPS-LOS
187600        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
187700     ELSE
187800       INITIALIZE PPS-DATA
187900       INITIALIZE PPS-OTHER-DATA
188000
188100*** ----------------------------------- ***
188200*** ADDED FOR JULY 2006 RELEASE (V07.1) ***
188300*** ----------------------------------- ***
188400       INITIALIZE PPS-CBSA
188500       INITIALIZE HOLD-PPS-COMPONENTS
188600
188700       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
188800     END-IF.
188900
189000*** *************************************************** ***
189100*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***
189200*** *************************************************** ***
189300
189400*    IF (B-PROVIDER-NO = '191401' OR
189500*                        '191402' OR
189600*                        '391403' OR
189700*                        '391404' OR
189800*                        '371405' OR
189900*                        '371406' OR
190000*                        '361407' OR
190100*                        '361408' OR
190200*                        '361409' OR
190300*                        '37140A' OR
190400*                        '37140B' OR
190500*                        '02140C' OR
190600*                        '332006' OR
190700*                        '40140E' OR
190800*                        '041411' OR
190900*                        '041412')
191000*
191100*    DISPLAY '---------------------------------------------'
191200*    DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
191300*    DISPLAY 'PPS-RTC '                  PPS-RTC
191400*    DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT
191500*    DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
191600*    DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
191700*    DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
191800*    DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
191900*    DISPLAY 'PPS-CBSA '                 PPS-CBSA
192000*    DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
192100*    DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
192200*    DISPLAY 'H-IPPS-WAGE-INDEX '        H-IPPS-WAGE-INDEX
192300*    DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
192400*    DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
192500*    DISPLAY 'B-DRG-CODE '               B-DRG-CODE
192600*    DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
192700*    DISPLAY 'H-SSOT '                   H-SSOT
192800*    DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
192900*    DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
193000*    DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
193100*    DISPLAY 'H-LOS '                    H-LOS
193200*    DISPLAY 'H-REG-DAYS '               H-REG-DAYS
193300*    DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
193400*    DISPLAY 'H-SSOT '                   H-SSOT
193500*    DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
193600*    DISPLAY 'H-BLEND-FAC '              H-BLEND-FAC
193700*    DISPLAY 'H-BLEND-PPS '              H-BLEND-PPS
193800*    DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
193900*    DISPLAY 'H-SS-COST '                H-SS-COST
194000*    DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
194100*    DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
194200*    DISPLAY 'H-FIXED-LOSS-AMT '         H-FIXED-LOSS-AMT
194300*    DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
194400*    DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
194500*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
194600*    DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
194700*    DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
194800*    DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
194900*    DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
195000*    DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
195100*    DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
195200*    DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
195300*    DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
195400*    DISPLAY 'H-BED-SIZE '               H-BED-SIZE
195500*    DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
195600*    DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
195700*    DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
195800*    DISPLAY 'H-OPER-DSH '               H-OPER-DSH
195900*    DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
196000*    DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
196100*    DISPLAY 'H-URBAN-IND '              H-URBAN-IND
196200*    DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
196300*    DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
196400*    DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
196500*    DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
196600*    DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
196700*    DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
196800*    DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
196900*    DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
197000*    DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
197100*    DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
197200*    DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
197300*    DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
197400*    DISPLAY 'H-OPER-COLA '              H-OPER-COLA
197500*    DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
197600*    DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
197700*    DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
197800*    DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
197900*    DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
198000*    DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
198100*    DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
198200*    DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
198300*    DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
198400*    DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
198500*    DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
198600*    DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT
198700*    DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT
198800*    DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
198900*    DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
199000*    DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
199100*    DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
199200*    DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
199300*
199400*    END-IF.
199500
199600 9000-EXIT.
199700      EXIT.
199800
199900******        L A S T   S O U R C E   S T A T E M E N T   *****
