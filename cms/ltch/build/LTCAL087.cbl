000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL087.
000400*REMARKS.        CMS.
000500*                EFFECTIVE OCTOBER 1, 2007.
000600 DATE-COMPILED.
000700 ENVIRONMENT DIVISION.
000800 CONFIGURATION SECTION.
000900 SOURCE-COMPUTER.            IBM-370.
001000 OBJECT-COMPUTER.            IBM-370.
001100 INPUT-OUTPUT  SECTION.
001200 FILE-CONTROL.
001300
001400 DATA DIVISION.
001500 FILE SECTION.
001600
001700 WORKING-STORAGE SECTION.
001800 01  W-STORAGE-REF                  PIC X(46)  VALUE
001900     'LTCAL087      - W O R K I N G   S T O R A G E'.
002000 01  CAL-VERSION                    PIC X(05)  VALUE 'V08.7'.
002100 01  PROGRAM-CONSTANTS.
002200     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
002300     05  FED-FY-BEGIN-04            PIC 9(08) VALUE 20031001.
002400     05  FED-FY-BEGIN-05            PIC 9(08) VALUE 20041001.
002500     05  FED-FY-BEGIN-06            PIC 9(08) VALUE 20051001.
002600     05  FED-FY-BEGIN-07            PIC 9(08) VALUE 20061001.
002700
002800
002900***************************************************************
003000*    LAYUP TABLE AREA FOR FY2007 LTC-DRG                      *
003100*    EFFECTIVE DATE OF OCTOBER 1, 2007                        *
003200***************************************************************
003300 COPY LTDRG086.
003400
003500
003600***************************************************************
003700*    LAYUP TABLE AREA FOR FY2007 IPPS-DRG                     *
003800*    EFFECTIVE DATE OF OCTOBER 1, 2007                        *
003900***************************************************************
004000 COPY IPDRG080.
004100
004200
004300***************************************************************
004400*    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
004500***************************************************************
004600 01  HOLD-PPS-COMPONENTS.
004700     05  H-LOS                        PIC 9(03).
004800     05  H-REG-DAYS                   PIC 9(03).
004900     05  H-TOTAL-DAYS                 PIC 9(05).
005000     05  H-SSOT                       PIC 9(02)V9(01).
005100     05  H-BLEND-RTC                  PIC 9(02).
005200     05  H-BLEND-FAC                  PIC 9(01)V9(01).
005300     05  H-BLEND-PPS                  PIC 9(01)V9(01).
005400     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
005500     05  H-SS-COST                    PIC 9(07)V9(02).
005600     05  H-LABOR-PORTION              PIC 9(07)V9(06).
005700     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
005800     05  H-FIXED-LOSS-AMT             PIC 9(07)V9(02).
005900     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
006000     05  H-LOS-RATIO                  PIC 9(01)V9(05).
006100
006200*** --------------------------------------------------- ***
006300*** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
006400*** --------------------------------------------------- ***
006500     05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
006600     05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
006700     05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
006800     05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
006900     05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
007000     05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
007100     05  H-INTERN-RATIO               PIC 9(01)V9(04).
007200     05  H-CAPI-IME-RATIO             PIC 9V9999.
007300     05  H-BED-SIZE                   PIC 9(05).
007400     05  H-OPER-DSH-PCT               PIC V9(04).
007500     05  H-SSI-RATIO                  PIC V9(04).
007600     05  H-MEDICAID-RATIO             PIC V9(04).
007700     05  H-OPER-DSH                   PIC 9(01)V9(04).
007800     05  H-CAPI-DSH                   PIC 9(01)V9(04).
007900     05  H-GEO-CLASS                  PIC X(01).
008000     05  H-URBAN-IND                  PIC X(01).
008100           88 URBAN-CBSA           VALUE '1'.
008200           88 RURAL-CBSA           VALUE '0'.
008300     05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
008400     05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
008500     05  H-CAPI-PMT                   PIC 9(07)V9(02).
008600     05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
008700     05  H-CAPI-GAF                   PIC 9(05)V9(04).
008800     05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
008900     05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
009000     05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
009100     05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
009200     05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
009300     05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
009400     05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
009500     05  H-OPER-COLA                  PIC 9(01)V9(03).
009600     05  H-CAPI-COLA                  PIC 9(01)V9(03).
009700     05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
009800     05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
009900     05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
010000     05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
010100     05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
010200     05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
010300     05  H-IPPS-DAYS-CUTOFF           PIC 9(02).
010400     05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
010500     05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
010600     05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
010700     05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
010800     05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
010900     05  H-COUNTER                    PIC 9(02).
011000
011100*** --------------------------------------------------- ***
011200*** VARIABLES FOR PC PRICER                             ***
011300*** --------------------------------------------------- ***
011400     05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
011500     05  H-SS-COST-IND                PIC X.
011600     05  H-SS-PERDIEM-IND             PIC X.
011700     05  H-SS-BLEND-IND               PIC X.
011800     05  H-SS-IPPSCOMP-IND            PIC X.
011900
012000
012100
012200
012300 LINKAGE SECTION.
012400**************************************************************
012500*      THIS IS THE BILL-RECORD THAT WILL BE PASSED FROM      *
012600*      THE LTDRV___ PROGRAM                                  *
012700**************************************************************
012800 01  BILL-NEW-DATA.
012900     10  B-NPI10.
013000         15  B-NPI8             PIC X(08).
013100         15  B-NPI-FILLER       PIC X(02).
013200     10  B-PROVIDER-NO          PIC X(06).
013300     10  B-PATIENT-STATUS       PIC X(02).
013400     10  B-DRG-CODE             PIC 9(03).
013500     10  B-LOS                  PIC 9(03).
013600     10  B-COV-DAYS             PIC 9(03).
013700     10  B-LTR-DAYS             PIC 9(02).
013800     10  B-DISCHARGE-DATE.
013900         15  B-DISCHG-CC        PIC 9(02).
014000         15  B-DISCHG-YY        PIC 9(02).
014100         15  B-DISCHG-MM        PIC 9(02).
014200         15  B-DISCHG-DD        PIC 9(02).
014300     10  B-COV-CHARGES          PIC 9(07)V9(02).
014400     10  B-SPEC-PAY-IND         PIC X(01).
014500     10  FILLER                 PIC X(13).
014600
014700
014800***************************************************************
014900***************************************************************
015000*                                                             *
015100*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *
015200*    AND PASSED BACK TO THE CALLING PROGRAM                   *
015300*    RETURN CODE VALUES (PPS-RTC)                             *
015400*                                                             *
015500*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
015600*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
015700*                                                             *
015800*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
015900*                                                             *
016000*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
016100*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
016200*                                                             *
016300*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
016400*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
016500*                                                             *
016600*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
016700*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
016800*                                                             *
016900*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
017000*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
017100*                                                             *
017200*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
017300*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
017400*                                                             *
017500*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
017600*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
017700*                                                             *
017800*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
017900*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
018000*                                                             *
018100*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
018200*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
018300*                                                             *
018400*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
018500*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
018600*                                                             *
018700*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
018800*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
018900*                                                             *
019000*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
019100*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
019200*                                                             *
019300*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
019400*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
019500*                                                             *
019600*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
019700*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
019800*                                                             *
019900*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
020000*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
020100*                                                             *
020200*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
020300*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
020400*                                                             *
020500*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
020600*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
020700*                                                             *
020800*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
020900*                  WITHOUT OUTLIER                            *
021000*                                                             *
021100*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
021200*                  DIEM WITHOUT OUTLIER                       *
021300*                                                             *
021400*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
021500*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
021600*                  AMOUNT WITHOUT OUTLIER                     *
021700*                                                             *
021800*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
021900*                  DIEM WITH OUTLIER                          *
022000*                                                             *
022100*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
022200*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
022300*                  AMOUNT WITH OUTLIER                        *
022400*                                                             *
022500*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
022600*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
022700*                                                             *
022800*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
022900*                  COMPARABLE THRESHOLD WITH OUTLIER          *
023000*                                                             *
023100*                                                             *
023200*                                                             *
023300*      ****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
023400*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
023500*             51 = PROVIDER RECORD TERMINATED                 *
023600*             52 = INVALID WAGE INDEX                         *
023700*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
023800*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
023900*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
024000*                                     OR                      *
024100*                  DISCHARGE DATE < CBSA EFF START DATE       *
024200*                  FOR PPS                                    *
024300*             56 = INVALID LENGTH OF STAY                     *
024400*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
024500*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
024600*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
024700*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
024800*                  OR BILL-LTR-DAYS > 60                      *
024900*             62 = INVALID NUMBER OF COVERED DAYS             *
025000*                  OR BILL-LTR-DAYS > COVERED DAYS            *
025100*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
025200*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
025300*                  OR COST OUTLIER THRESHOLD CALCULATION      *
025400*             72 = INVALID BLEND INDICATOR (NOT 1 THRU 5)     *
025500*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
025600*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
025700*             98 = CANNOT PROCESS BILL OLDER THAN FIVE YEARS  *
025800*                                                             *
025900***************************************************************
026000***************************************************************
026100
026200
026300***************************************************************
026400* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
026500* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
026600***************************************************************
026700 01  PPS-DATA-ALL.
026800     05  PPS-RTC                       PIC 9(02).
026900     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
027000     05  PPS-DATA.
027100         10  PPS-MSA                   PIC X(04).
027200         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
027300         10  PPS-AVG-LOS               PIC 9(02)V9(01).
027400         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
027500         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
027600         10  PPS-LOS                   PIC 9(03).
027700         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
027800         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
027900         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
028000         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
028100         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
028200         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
028300         10  PPS-SUBM-DRG-CODE         PIC X(03).
028400         10  PPS-CALC-VERS-CD          PIC X(05).
028500         10  PPS-REG-DAYS-USED         PIC 9(03).
028600         10  PPS-LTR-DAYS-USED         PIC 9(03).
028700         10  PPS-BLEND-YEAR            PIC 9(01).
028800         10  PPS-COLA                  PIC 9(01)V9(03).
028900         10  FILLER                    PIC X(04).
029000     05  PPS-OTHER-DATA.
029100         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
029200         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
029300         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
029400         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
029500         10  PPS-IPTHRESH              PIC 9(03)V9(01).
029600         10  FILLER                    PIC X(16).
029700     05  PPS-PC-DATA.
029800         10  PPS-COT-IND               PIC X(01).
029900         10  H-PC-IND                  PIC X(02).
030000               88  PC-PRICER               VALUE 'PC'.
030100         10  FILLER                    PIC X(18).
030200
030300 01 PPS-CBSA                           PIC X(05).
030400
030500
030600******************************************************************
030700*            THESE ARE THE VERSIONS OF THE LTDRV___              *
030800*           PROGRAMS THAT WILL BE PASSED BACK----                *
030900*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
031000******************************************************************
031100 01  PRICER-OPT-VERS-SW.
031200     05  PRICER-OPTION-SW          PIC X(01).
031300         88  ALL-TABLES-PASSED          VALUE 'A'.
031400         88  PROV-RECORD-PASSED         VALUE 'P'.
031500     05  PPS-VERSIONS.
031600         10  PPDRV-VERSION         PIC X(05).
031700
031800
031900**************************************************************
032000*      THIS IS THE PROV-RECORD THAT WILL BE PASSED BY        *
032100*      THE LTCAL___ PROGRAM (FROM PROGRAM LTDRV___)          *
032200**************************************************************
032300 01  PROV-NEW-HOLD.
032400     02  PROV-NEWREC-HOLD1.
032500         05  P-NEW-NPI10.
032600             10  P-NEW-NPI8             PIC X(08).
032700             10  P-NEW-NPI-FILLER       PIC X(02).
032800         05  P-NEW-PROVIDER-NO.
032900             10  P-NEW-STATE            PIC 9(02).
033000             10  FILLER                 PIC X(04).
033100         05  P-NEW-DATE-DATA.
033200             10  P-NEW-EFF-DATE.
033300                 15  P-NEW-EFF-DT-CC    PIC 9(02).
033400                 15  P-NEW-EFF-DT-YY    PIC 9(02).
033500                 15  P-NEW-EFF-DT-MM    PIC 9(02).
033600                 15  P-NEW-EFF-DT-DD    PIC 9(02).
033700             10  P-NEW-FY-BEGIN-DATE.
033800                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).
033900                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).
034000                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).
034100                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).
034200             10  P-NEW-REPORT-DATE.
034300                 15  P-NEW-REPORT-DT-CC PIC 9(02).
034400                 15  P-NEW-REPORT-DT-YY PIC 9(02).
034500                 15  P-NEW-REPORT-DT-MM PIC 9(02).
034600                 15  P-NEW-REPORT-DT-DD PIC 9(02).
034700             10  P-NEW-TERMINATION-DATE.
034800                 15  P-NEW-TERM-DT-CC   PIC 9(02).
034900                 15  P-NEW-TERM-DT-YY   PIC 9(02).
035000                 15  P-NEW-TERM-DT-MM   PIC 9(02).
035100                 15  P-NEW-TERM-DT-DD   PIC 9(02).
035200         05  P-NEW-WAIVER-CODE          PIC X(01).
035300             88  P-NEW-WAIVER-STATE       VALUE 'Y'.
035400         05  P-NEW-INTER-NO             PIC 9(05).
035500         05  P-NEW-PROVIDER-TYPE        PIC X(02).
035600         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
035700         05  P-NEW-CURRENT-DIV   REDEFINES
035800                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
035900         05  P-NEW-MSA-DATA.
036000             10  P-NEW-CHG-CODE-INDEX       PIC X.
036100             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT.
036200             10  P-NEW-GEO-LOC-MSA9   REDEFINES
036300                             P-NEW-GEO-LOC-MSAX  PIC 9(04).
036400             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT.
036500             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT.
036600             10  P-NEW-STAND-AMT-LOC-MSA9
036700                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.
036800                 15  P-NEW-RURAL-1ST.
036900                     20  P-NEW-STAND-RURAL  PIC XX.
037000                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.
037100                 15  P-NEW-RURAL-2ND        PIC XX.
037200         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.
037300         05  P-NEW-LUGAR                    PIC X.
037400         05  P-NEW-TEMP-RELIEF-IND          PIC X.
037500         05  P-NEW-FED-PPS-BLEND-IND        PIC X.
037600         05  FILLER                         PIC X(05).
037700     02  PROV-NEWREC-HOLD2.
037800         05  P-NEW-VARIABLES.
037900             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).
038000             10  P-NEW-COLA              PIC  9(01)V9(03).
038100             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).
038200             10  P-NEW-BED-SIZE          PIC  9(05).
038300             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).
038400             10  P-NEW-CMI               PIC  9(01)V9(04).
038500             10  P-NEW-SSI-RATIO         PIC  V9(04).
038600             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).
038700             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).
038800             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).
038900             10  P-NEW-DSH-PERCENT       PIC  V9(04).
039000             10  P-NEW-FYE-DATE          PIC  X(08).
039100         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).
039200         05  FILLER                        PIC X(01).
039300         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.
039400         05  P-NEW-GEO-LOC-CBSA9 REDEFINES
039500                       P-NEW-GEO-LOC-CBSAX PIC 9(05).
039600         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES
039700                       P-NEW-GEO-LOC-CBSAX.
039800             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.
039900             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.
040000             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.
040100             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.
040200             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.
040300         05  FILLER                        PIC X(10).
040400         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).
040500     02  PROV-NEWREC-HOLD3.
040600         05  P-NEW-PASS-AMT-DATA.
040700             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.
040800             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.
040900             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.
041000             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.
041100         05  P-NEW-CAPI-DATA.
041200             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.
041300             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.
041400             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.
041500             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.
041600             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.
041700             15  P-NEW-CAPI-NEW-HOSP       PIC X.
041800             15  P-NEW-CAPI-IME            PIC 9V9999.
041900             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.
042000         05  FILLER                        PIC X(22).
042100
042200
042300******************************************************************
042400*                THIS IS THE LTCH WAGE-INDEX                     *
042500*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
042600*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *
042700******************************************************************
042800 01  WAGE-NEW-INDEX-RECORD.
042900     05  W-CBSA                        PIC X(5).
043000     05  W-EFF-DATE                    PIC X(8).
043100     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).
043200     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).
043300     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).
043400
043500
043600******************************************************************
043700*                THIS IS THE IPPS WAGE-INDEX                     *
043800*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
043900******************************************************************
044000 01  WAGE-NEW-IPPS-INDEX-RECORD.
044100     05  W-CBSA-IPPS.
044200         10 CBSA-IPPS-123              PIC X(3).
044300         10 CBSA-IPPS-45               PIC X(2).
044400     05  W-CBSA-IPPS-SIZE              PIC X.
044500         88  LARGE-URBAN       VALUE 'L'.
044600         88  OTHER-URBAN       VALUE 'O'.
044700         88  ALL-RURAL         VALUE 'R'.
044800     05  W-CBSA-IPPS-EFF-DATE          PIC X(8).
044900     05  FILLER                        PIC X.
045000     05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).
045100     05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).
045200
045300
045400
045500 PROCEDURE DIVISION  USING BILL-NEW-DATA
045600                           PPS-DATA-ALL
045700                           PPS-CBSA
045800                           PRICER-OPT-VERS-SW
045900                           PROV-NEW-HOLD
046000                           WAGE-NEW-INDEX-RECORD
046100                           WAGE-NEW-IPPS-INDEX-RECORD.
046200
046300
046400***************************************************************
046500*                                                             *
046600*    PROCESSING:                                              *
046700*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
046800*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
046900*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
047000*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
047100*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
047200*           GOBACK.                                           *
047300*        D. ASSEMBLE PRICING COMPONENTS.                      *
047400*        E. CALCULATE THE PRICE.                              *
047500*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
047600*                                                             *
047700***************************************************************
047800
047900
048000***************************************************************
048100 0000-MAINLINE-CONTROL.
048200***************************************************************
048300
048400     PERFORM 0100-INITIAL-ROUTINE
048500        THRU 0100-EXIT.
048600
048700     PERFORM 1000-EDIT-THE-BILL-INFO
048800        THRU 1000-EXIT.
048900
049000     IF PPS-RTC = 00
049100        PERFORM 1700-EDIT-DRG-CODE
049200           THRU 1700-EXIT.
049300
049400     IF PPS-RTC = 00
049500        PERFORM 1800-EDIT-IPPS-DRG-CODE
049600           THRU 1800-EXIT
049700           VARYING DX5 FROM 1 BY 1 UNTIL DX5 > 1.
049800
049900     IF PPS-RTC = 00
050000        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
050100           THRU 2000-EXIT.
050200
050300     IF PPS-RTC = 00
050400        PERFORM 3000-CALC-PAYMENT
050500           THRU 3000-EXIT
050600        PERFORM 7000-CALC-OUTLIER
050700           THRU 7000-EXIT.
050800
050900     IF PPS-RTC < 50
051000        PERFORM 8000-BLEND
051100           THRU 8000-EXIT.
051200
051300     PERFORM 9000-MOVE-RESULTS
051400        THRU 9000-EXIT.
051500
051600     GOBACK.
051700
051800
051900***************************************************************
052000 0100-INITIAL-ROUTINE.
052100***************************************************************
052200
052300     MOVE ZEROS TO PPS-RTC.
052400     INITIALIZE PPS-DATA.
052500     INITIALIZE PPS-OTHER-DATA.
052600     INITIALIZE PPS-CBSA.
052700     INITIALIZE HOLD-PPS-COMPONENTS.
052800
052900     MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.
053000
053100*** ---------------------------------------------------- ***
053200*** RATES FOR LTCH PAYMENT: CHANGE IN JULY               ***
053300*** ---------------------------------------------------- ***
053200     IF B-DISCHARGE-DATE < 20080401
053100*       ------------------------------------------------ ***
053200*       EFFECTIVE 10/01/2007 - 03/31/2008                ***
053300*       ------------------------------------------------ ***
053400        MOVE .75788   TO PPS-NAT-LABOR-PCT
053500        MOVE .24212   TO PPS-NAT-NONLABOR-PCT
053600        MOVE 38356.45 TO PPS-STD-FED-RATE
053700        MOVE 20738.00 TO H-FIXED-LOSS-AMT
053800        MOVE 1.000    TO PPS-BDGT-NEUT-RATE
053000     ELSE
053100*       ------------------------------------------------ ***
053200*       EFFECTIVE 04/01/2008 - 06/30/2008 PER THE LAW    ***
053300*       ------------------------------------------------ ***
053400        MOVE .75788   TO PPS-NAT-LABOR-PCT
053500        MOVE .24212   TO PPS-NAT-NONLABOR-PCT
053600        MOVE 38086.04 TO PPS-STD-FED-RATE
053700        MOVE 20707.00 TO H-FIXED-LOSS-AMT
053800        MOVE 1.000    TO PPS-BDGT-NEUT-RATE
053905     END-IF.
053910
054000*** ---------------------------------------------------- ***
054100*** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
054125*** ---------------------------------------------------- ***
054150*** 5/19/2008 - ENTERED REVISED PUERTO RICO RATES        ***
054175***             EFFECTIVE RETROACTIVE TO 10/01/2007      ***
054200*** ---------------------------------------------------- ***
054300     MOVE 426.14 TO H-IPPS-CAPI-STD-FED-RATE.
054400     MOVE 202.89 TO H-IPPS-CAPI-STD-PR-RATE.
054500     MOVE 0.75   TO H-NAT-IPPS-PMT-PCT.
054600     MOVE 0.25   TO H-PR-IPPS-PMT-PCT.
054700
054800     IF W-IPPS-WAGE-INDEX > 1
054900        MOVE 3478.45 TO H-IPPS-NAT-LABOR-SHR
055000        MOVE 1512.15 TO H-IPPS-NAT-NONLABOR-SHR
055100     ELSE
055200        MOVE 3094.17 TO H-IPPS-NAT-LABOR-SHR
055300        MOVE 1896.43 TO H-IPPS-NAT-NONLABOR-SHR
055400     END-IF.
055500
055600     IF W-IPPS-PR-WAGE-INDEX > 1
055700        MOVE 1471.10 TO H-IPPS-PR-LABOR-SHR
055800        MOVE  901.64 TO H-IPPS-PR-NONLABOR-SHR
055900     ELSE
056000        MOVE 1392.80 TO H-IPPS-PR-LABOR-SHR
056100        MOVE  979.94 TO H-IPPS-PR-NONLABOR-SHR
056200     END-IF.
056300
056400
056500 0100-EXIT.
056600      EXIT.
056700
056800
056900***************************************************************
057000*    BILL DATA EDITS - IF ANY FAIL SET PPS-RTC                *
057100*    AND DO NOT ATTEMPT TO PRICE.                             *
057200***************************************************************
057300 1000-EDIT-THE-BILL-INFO.
057400***************************************************************
057500
057600     IF (B-LOS NUMERIC) AND (B-LOS > 0)
057700        MOVE B-LOS TO H-LOS
057800     ELSE
057900        MOVE 56 TO PPS-RTC.
058000
058100     IF PPS-RTC = 00
058200       IF P-NEW-COLA NOT NUMERIC
058300          MOVE 50 TO PPS-RTC.
058400
058500     IF PPS-RTC = 00
058600       IF P-NEW-WAIVER-STATE
058700          MOVE 53 TO PPS-RTC.
058800
058900     IF PPS-RTC = 00
059000         IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
059100            (B-DISCHARGE-DATE < W-EFF-DATE))
059200            MOVE 55 TO PPS-RTC.
059300
059400     IF PPS-RTC = 00
059500         IF P-NEW-TERMINATION-DATE > 00000000
059600            IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
059700               MOVE 51 TO PPS-RTC.
059800
059900     IF PPS-RTC = 00
060000         IF B-COV-CHARGES NOT NUMERIC
060100            MOVE 58 TO PPS-RTC.
060200
060300     IF PPS-RTC = 00
060400        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
060500           MOVE 61 TO PPS-RTC.
060600
060700     IF PPS-RTC = 00
060800        IF (B-COV-DAYS NOT NUMERIC) OR
060900           (B-COV-DAYS = 0 AND H-LOS > 0)
061000           MOVE 62 TO PPS-RTC.
061100
061200     IF PPS-RTC = 00
061300        IF B-LTR-DAYS > B-COV-DAYS
061400           MOVE 62 TO PPS-RTC.
061500
061600     IF PPS-RTC = 00
061700        COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
061800        COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
061900
062000     IF PPS-RTC = 00
062100        PERFORM 1200-DAYS-USED
062200           THRU 1200-DAYS-USED-EXIT.
062300
062400
062500*** -----------------------------------------------------------
062600*** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
062700*** -----------------------------------------------------------
062800     IF PPS-RTC = 00
062900        IF P-NEW-CAPI-IME NUMERIC
063000           MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
063100        ELSE
063200           MOVE ZEROS TO H-CAPI-IME-RATIO
063300        END-IF
063400     END-IF.
063500
063600     IF PPS-RTC = 00
063700        IF P-NEW-INTERN-RATIO NUMERIC
063800           MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
063900        ELSE
064000           MOVE ZEROS TO H-INTERN-RATIO
064100        END-IF
064200     END-IF.
064300
064400     IF PPS-RTC = 00
064500        IF P-NEW-BED-SIZE NUMERIC
064600           MOVE P-NEW-BED-SIZE TO H-BED-SIZE
064700        ELSE
064800           MOVE ZEROS TO H-BED-SIZE
064900        END-IF
065000     END-IF.
065100
065200     IF PPS-RTC = 00
065300        IF P-NEW-SSI-RATIO NUMERIC
065400           MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
065500        ELSE
065600           MOVE ZEROS TO H-SSI-RATIO
065700        END-IF
065800     END-IF.
065900
066000     IF PPS-RTC = 00
066100        IF P-NEW-MEDICAID-RATIO NUMERIC
066200           MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
066300        ELSE
066400           MOVE ZEROS TO H-MEDICAID-RATIO
066500        END-IF
066600     END-IF.
066700
066800
066900 1000-EXIT.
067000      EXIT.
067100
067200
067300***************************************************************
067400 1200-DAYS-USED.
067500***************************************************************
067600
067700     IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
067800        IF B-LTR-DAYS > H-LOS
067900           MOVE H-LOS TO PPS-LTR-DAYS-USED
068000        ELSE
068100           MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
068200     ELSE
068300        IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
068400           IF H-REG-DAYS > H-LOS
068500              MOVE H-LOS TO PPS-REG-DAYS-USED
068600           ELSE
068700              MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
068800        ELSE
068900           IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
069000              IF H-REG-DAYS > H-LOS
069100                 MOVE H-LOS TO PPS-REG-DAYS-USED
069200                 MOVE 0 TO PPS-LTR-DAYS-USED
069300              ELSE
069400                 IF H-TOTAL-DAYS > H-LOS
069500                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
069600                    COMPUTE PPS-LTR-DAYS-USED =
069700                            H-LOS - H-REG-DAYS
069800                 ELSE
069900                    IF H-TOTAL-DAYS <= H-LOS
070000                       MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
070100                       MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
070200                    ELSE
070300                       NEXT SENTENCE
070400           ELSE
070500              NEXT SENTENCE.
070600
070700 1200-DAYS-USED-EXIT.
070800      EXIT.
070900
071000
071100***************************************************************
071200*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
071300***************************************************************
071400 1700-EDIT-DRG-CODE.
071500***************************************************************
071600
071700     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
071800     IF PPS-RTC = 00
071900        SEARCH ALL WWM-ENTRY
072000           AT END
072100             MOVE 54 TO PPS-RTC
072200        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
072300             PERFORM 1750-FIND-VALUE
072400                THRU 1750-EXIT
072500        END-SEARCH.
072600
072700 1700-EXIT.
072800      EXIT.
072900
073000
073100***************************************************************
073200*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
073300***************************************************************
073400 1750-FIND-VALUE.
073500***************************************************************
073600
073700      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
073800      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
073900      MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.
074000
074100 1750-EXIT.
074200      EXIT.
074300
074400
074500***************************************************************
074600*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
074700***************************************************************
074800 1800-EDIT-IPPS-DRG-CODE.
074900***************************************************************
075000
075100     IF B-DRG-CODE NOT NUMERIC
075200        MOVE 54 TO PPS-RTC
075300        GO TO 1800-EXIT
075400     END-IF.
075500
075600     IF B-DISCHARGE-DATE NOT < DRGX-EFF-DATE(DX5) AND PPS-RTC = 0
075700        SET DX6                       TO B-DRG-CODE
075800        MOVE DRG-WT (DX5 DX6)         TO H-IPPS-DRG-WGT
075900        MOVE DRG-ALOS (DX5 DX6)       TO H-IPPS-DRG-ALOS
076000        MOVE ZEROES                   TO H-IPPS-DAYS-CUTOFF
076100        MOVE DRG-ARITH-ALOS (DX5 DX6) TO H-IPPS-ARITH-ALOS
076200     END-IF.
076300
076400 1800-EXIT.
076500      EXIT.
076600
076700
076800***************************************************************
076900***  GET THE PROVIDER SPECIFIC VARIABLES AND WAGE INDEX       *
077000*                                                             *
077100*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
077200*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
077300*    OF THAT VARIABLE.                                        *
077400*                                                             *
077500***************************************************************
077600 2000-ASSEMBLE-PPS-VARIABLES.
077700***************************************************************
077800
077900
078000*------------------------------------------------------*
078100* WAGE INDEX BLEND TABLE                               *
078200*------------------------------------------------------*
078300*                                                      *
078400*  BLEND YEAR   FEDERAL FY                BLEND        *
078500*  ----------   ----------------------    -----        *
078600*      1        10/01/2002 - 09/30/2003    1/5         *
078700*      2        10/01/2003 - 09/30/2004    2/5         *
078800*      3        10/01/2004 - 09/30/2005    3/5         *
078900*      4        10/01/2005 - 09/30/2006    4/5         *
079000*      5        10/01/2006 - INDEFINITE    5/5 (FULL)  *
079100*                                                      *
079200*------------------------------------------------------*
079300*                                                      *
079400* A PROVIDER WILL RECEIVE THE APPLICABLE BLEND FOR A   *
079500* GIVEN FEDERAL FY FOR CLAIMS DISCHARGED ON & AFTER    *
079600* ITS FY BEGIN DATE THAT FALLS WITHIN THAT FEDERAL FY. *
079700*                                                      *
079800*------------------------------------------------------*
079900
080000
080100     EVALUATE TRUE
080200
080300***************************************************************
080400* PROVIDER FY BEGIN DATE WITHIN THE CURRENT 5/5 FEDERAL FY    *
080500***************************************************************
080600      WHEN P-NEW-FY-BEGIN-DATE >= FED-FY-BEGIN-07
080700              IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
080800                 MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
080900              ELSE
081000                 MOVE 52 TO PPS-RTC
081100                 GO TO 2000-EXIT
081200              END-IF
081300
081400
081500***************************************************************
081600* PROVIDER FY BEGIN DATE WITHIN THE PREVIOUS 4/5 FEDERAL FY   *
081700***************************************************************
081800      WHEN P-NEW-FY-BEGIN-DATE <  FED-FY-BEGIN-07 AND
081900           P-NEW-FY-BEGIN-DATE >= FED-FY-BEGIN-06
082000
082100              IF W-WAGE-INDEX2 NUMERIC AND W-WAGE-INDEX2 > 0
082200                 MOVE W-WAGE-INDEX2 TO PPS-WAGE-INDEX
082300              ELSE
082400                 MOVE 52 TO PPS-RTC
082500                 GO TO 2000-EXIT
082600              END-IF
082700
082800
082900***************************************************************
083000* PROVIDER FY BEGIN DATE NOT UPDATED                          *
083100***************************************************************
083200      WHEN P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-06
083300           MOVE 52 TO PPS-RTC
083400           GO TO 2000-EXIT
083500
083600
083700***************************************************************
083800* PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
083900* (ALWAYS FED-FY-BEGIN-03)                                    *
084000***************************************************************
084100      WHEN P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
084200           MOVE 74 TO PPS-RTC
084300           GO TO 2000-EXIT
084400
084500     END-EVALUATE.
084600
084700
084800***************************************************************
084900* USE SPECIAL WAGE INDEX WHEN INDICATED                       *
085000***************************************************************
085100     IF P-NEW-SPECIAL-PAY-IND = '1'
085200        IF P-NEW-SPECIAL-WAGE-INDEX NUMERIC AND
085300           P-NEW-SPECIAL-WAGE-INDEX > 0
085400           MOVE P-NEW-SPECIAL-WAGE-INDEX TO PPS-WAGE-INDEX
085500        ELSE
085600           MOVE 52 TO PPS-RTC
085700           GO TO 2000-EXIT
085800        END-IF
085900     END-IF.
086000
086100
086200***************************************************************
086300* EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
086400***************************************************************
086500     IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
086600        MOVE 65 TO PPS-RTC.
086700
086800
086900***************************************************************
087000* DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
087100***************************************************************
087200     MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.
087300
087400     IF PPS-BLEND-YEAR > 0 AND PPS-BLEND-YEAR < 6
087500        NEXT SENTENCE
087600     ELSE
087700        MOVE 72 TO PPS-RTC
087800        GO TO 2000-EXIT.
087900
088000     MOVE 0 TO H-BLEND-FAC.
088100     MOVE 1 TO H-BLEND-PPS.
088200     MOVE 0 TO H-BLEND-RTC.
088300
088400     IF PPS-BLEND-YEAR = 1
088500        MOVE .8 TO H-BLEND-FAC
088600        MOVE .2 TO H-BLEND-PPS
088700        MOVE 4 TO H-BLEND-RTC
088800     ELSE
088900       IF PPS-BLEND-YEAR = 2
089000          MOVE .6 TO H-BLEND-FAC
089100          MOVE .4 TO H-BLEND-PPS
089200          MOVE 8 TO H-BLEND-RTC
089300       ELSE
089400         IF PPS-BLEND-YEAR = 3
089500            MOVE .4 TO H-BLEND-FAC
089600            MOVE .6 TO H-BLEND-PPS
089700            MOVE 12 TO H-BLEND-RTC
089800         ELSE
089900           IF PPS-BLEND-YEAR = 4
090000              MOVE .2 TO H-BLEND-FAC
090100              MOVE .8 TO H-BLEND-PPS
090200              MOVE 16 TO H-BLEND-RTC.
090300
090400 2000-EXIT.
090500      EXIT.
090600
090700
090800***************************************************************
090900*    IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)           *
091000*        CALCULATE THE STANDARD PAYMENT AMOUNT.               *
091100*        CALCULATE THE SHORT-STAY OUTLIER AMOUNT.             *
091200***************************************************************
091300 3000-CALC-PAYMENT.
091400***************************************************************
091500
091600*** -------------------------------------------------- ***
091700*** FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII) ***
091800*** -------------------------------------------------- ***
091900     IF (P-NEW-STATE = 02 OR 12)
092000        MOVE P-NEW-COLA TO PPS-COLA
092100     ELSE
092200        MOVE 1.000 TO PPS-COLA
092300     END-IF.
092400
092500
092600     COMPUTE PPS-FAC-COSTS ROUNDED =
092700         P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.
092800
092900     COMPUTE H-LABOR-PORTION ROUNDED =
093000         (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
093100          * PPS-WAGE-INDEX.
093200
093300     COMPUTE H-NONLABOR-PORTION ROUNDED =
093400         (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
093500          * PPS-COLA.
093600
093700     COMPUTE PPS-FED-PAY-AMT ROUNDED =
093800         (H-LABOR-PORTION + H-NONLABOR-PORTION).
093900
094000     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
094100         (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).
094200
094300
094400*** -------------------------------------------------------- ***
094500*** FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY ***
094600*** -------------------------------------------------------- ***
094700     MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.
094800
094900*** --------------------------------------------- ***
095000*** DETERMINE WHETHER THE CLAIM IS A SHORT STAY   ***
095100*** --------------------------------------------- ***
095200*** H-SSOT ROUNDED AND EXPANDED TO 1 DECIMAL      ***
095300*** PLACE FOR RELEASE 07.1                        ***
095400*** --------------------------------------------- ***
095500     COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
095600     IF H-LOS <= H-SSOT
095700        PERFORM 3400-SHORT-STAY
095800           THRU 3400-SHORT-STAY-EXIT.
095900
096000 3000-EXIT.
096100      EXIT.
096200
096300
096400***************************************************************
096500*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
096600*      OF THE AVG. LENGTH OF STAY THEN:                       *
096700*      - CALCULATE THE SHORT-STAY COST.                       *
096800*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *
096900*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *
097000*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *
097100*      - PAY THE LEAST OF:                                    *
097200*          1)SHORT STAY COST                                  *
097300*          2)SHORT STAY PAYMENT AMOUNT                        *
097400*          3)DRG ADJUSTED PAYMENT AMOUNT                      *
097500*          4)SHORT STAY BLENDED PAYMENT -OR-                  *
097600*          5)IPPS COMPARABLE AMOUNT                           *
097700*      - SET RETURN CODE TO INDICATE SHORT STAY PAYMENT TYPE  *
097800***************************************************************
097900 3400-SHORT-STAY.
098000***************************************************************
098100
098200**************************************************************
098300*                                                            *
098400*   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *
098500*                                                            *
098600**************************************************************
098700     IF P-NEW-PROVIDER-NO = '332006'
098800        PERFORM 4000-SPECIAL-PROVIDER
098900           THRU 4000-SPECIAL-PROVIDER-EXIT
099000
099100     ELSE
099200
099300
099400**************************************************************
099500*                                                            *
099600*   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *
099700* ---------------------------------------------------------- *
099800*   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *
099900*                                                            *
100000**************************************************************
100100        MOVE PPS-FAC-COSTS TO H-SS-COST
100200
100300
100400**************************************************************
100500*                                                            *
100600*   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *
100700* ---------------------------------------------------------- *
100800*   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *
100900*     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *
101000*     THE LENGTH OF STAY IS CORRECT                          *
101100*                                                            *
101200**************************************************************
101300        COMPUTE H-SS-PAY-AMT ROUNDED =
101400         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
101500
101600
101700**************************************************************
101800*                                                            *
101900*   SHORT STAY PROVISIONS #4 & #5                            *
102000* ---------------------------------------------------------- *
102100*   #4 - BLEND OF SS PMT & IPPS COMPARABLE PER DIEM AMT      *
102200*         (LOS (COVERED DAYS) > IPPS COMP THRESHOLD)         *
102300*   #5 - IPPS COMP PER DIEM AMT                              *
102400*         (LOS (COVERED DAYS) <= IPPS COMP THRESHOLD -AND-   *
102450*          DISCHARGE DATE B/W 7/1/07 & 12/21/07 INCLUSIVE)   *
102500* ---------------------------------------------------------- *
102600*   #4  INTRODUCED IN RELEASE 07.1                           *
102700*   #5  INTRODUCED IN RELEASE 08.0                           *
102800*                                                            *
102800*   12/31/2007 - BILLS WITH DISCHARGE DATES ON OR AFTER      *
102800*                12/29/2007 AREN'T ELIGIBLE FOR SHORT        *
102800*                STAY PROVISION #5 (FOR RELEASE 2008.5)      *
102800*                                                            *
102900**************************************************************
103000       IF W-IPPS-WAGE-INDEX NUMERIC AND
103100          W-IPPS-WAGE-INDEX > 0
103200
103300*---------------------------------------------------------
103400*   #4 - LOS (COVERED DAYS) > IPPS COMPARABLE THRESHOLD
103500*        CALCULATE BLENDED PAYMENT
103600*---------------------------------------------------------
103700          IF ((H-LOS > PPS-IPTHRESH) AND
103725              (B-DISCHARGE-DATE < 20071229)) OR
103750             (B-DISCHARGE-DATE > 20071228)
103800               PERFORM 3600-SS-BLENDED-PMT
103900                  THRU 3600-SS-BLENDED-PMT-EXIT
104000
104100*---------------------------------------------------------
104200*   #5 - LOS (COVERED DAYS) <= IPPS COMPARABLE THRESHOLD
104300*        CALCULATE IPPS COMPARABLE PER DIEM AMT ONLY
104400*---------------------------------------------------------
104500          ELSE
104600               PERFORM 3650-SS-IPPS-COMP-PMT
104700                  THRU 3650-SS-IPPS-COMP-PMT-EXIT
104800          END-IF
104900
105000*---------------------------------------------------------
105100*   WAGE INDEX IS INVALID
105200*   SET ERROR CODE & EXIT
105300*---------------------------------------------------------
105400       ELSE
105500          MOVE 52 TO PPS-RTC
105600          GO TO 3400-SHORT-STAY-EXIT
105700       END-IF.
105800
105900
106000**************************************************************
106100*                                                            *
106200*   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *
106300*   DRG ADJUSTED PAYMENT SHOULD BE USED                      *
106400* ---------------------------------------------------------- *
106500*   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *
106600*                                                            *
106700**************************************************************
106800
106900     MOVE 'N' TO H-SS-COST-IND.
107000     MOVE 'N' TO H-SS-PERDIEM-IND.
107100     MOVE 'N' TO H-SS-BLEND-IND.
107200     MOVE 'N' TO H-SS-IPPSCOMP-IND.
107300
107400*---------------------------------------------------------
107500*   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%
107600*   OF PER DIEM) AND DRG ADJUSTED PMT AMT
107700*---------------------------------------------------------
107800     IF H-SS-COST < H-SS-PAY-AMT
107900        IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT
108000           MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT
108100           MOVE 20 TO PPS-RTC
108200           MOVE 'Y' TO H-SS-COST-IND
108300        ELSE
108400           NEXT SENTENCE
108500        END-IF
108600     ELSE
108700        IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT
108800           MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT
108900           MOVE 21 TO PPS-RTC
109000           MOVE 'Y' TO H-SS-PERDIEM-IND
109100        ELSE
109200           NEXT SENTENCE
109300        END-IF
109400     END-IF.
109500
109600*---------------------------------------------------------
109700*   USE THE BLENDED PMT OR IPPS COMPARABLE AMT IF LESS
109800*   THAN THE OTHER OPTIONS
109900*---------------------------------------------------------
110000     IF P-NEW-PROVIDER-NO NOT = '332006'
110100
110200*---------------------------------------------------------
110300*   COMPARE BLENDED PAYMENT
110400*---------------------------------------------------------
103700        IF ((H-LOS > PPS-IPTHRESH) AND
103725            (B-DISCHARGE-DATE < 20071229)) OR
103750           (B-DISCHARGE-DATE > 20071228)
110600           IF H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
110700              MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
110800              MOVE 22 TO PPS-RTC
110900              MOVE 'Y' TO H-SS-BLEND-IND
111000              MOVE 'N' TO H-SS-COST-IND
111100              MOVE 'N' TO H-SS-PERDIEM-IND
111200              MOVE 'N' TO H-SS-IPPSCOMP-IND
111300           ELSE
111400              NEXT SENTENCE
111500           END-IF
111600
111700*---------------------------------------------------------
111800*   COMPARE IPPS COMPARABLE PER DIEM AMOUNT
111900*---------------------------------------------------------
112000        ELSE
112100           IF H-IPPS-PER-DIEM < PPS-DRG-ADJ-PAY-AMT
112200              MOVE H-IPPS-PER-DIEM TO PPS-DRG-ADJ-PAY-AMT
112300              MOVE 26 TO PPS-RTC
112400              MOVE 'Y' TO H-SS-IPPSCOMP-IND
112500              MOVE 'N' TO H-SS-BLEND-IND
112600              MOVE 'N' TO H-SS-COST-IND
112700              MOVE 'N' TO H-SS-PERDIEM-IND
112800           ELSE
112900              NEXT SENTENCE
113000           END-IF
113100     END-IF.
113200
113300 3400-SHORT-STAY-EXIT.
113400      EXIT.
113500
113600
113700***************************************************************
113800*    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
113900*       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
114000*       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
114100*       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
114200***************************************************************
114300 3600-SS-BLENDED-PMT.
114400***************************************************************
114500
114600*** ------------------------------------------------------ ***
114700*** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
114800*** ------------------------------------------------------ ***
114900     IF H-SSOT < 25
115000        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
115100          H-LOS / H-SSOT
115200     ELSE
115300        COMPUTE H-LTCH-BLEND-PCT ROUNDED =
115400          H-LOS / 25
115500     END-IF.
115600
115700     IF H-LTCH-BLEND-PCT > 1
115800        MOVE 1 TO H-LTCH-BLEND-PCT
115900     END-IF.
116000
116100
116200*** ------------------------------------------------------ ***
116300*** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
116400*** ------------------------------------------------------ ***
116500     COMPUTE H-LTCH-BLEND-AMT ROUNDED =
116600        H-SS-PAY-AMT * H-LTCH-BLEND-PCT.
116700
116800
116900*** ------------------------------------------------------ ***
117000*** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
117100*** ------------------------------------------------------ ***
117200     PERFORM 3650-SS-IPPS-COMP-PMT
117300        THRU 3650-SS-IPPS-COMP-PMT-EXIT.
117400
117500
117600*** ------------------------------------------------------ ***
117700*** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
117800*** ------------------------------------------------------ ***
117900     COMPUTE H-IPPS-BLEND-PCT ROUNDED =
118000       1 - H-LTCH-BLEND-PCT.
118100
118200
118300*** ------------------------------------------------------ ***
118400*** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
118500*** ------------------------------------------------------ ***
118600     COMPUTE H-IPPS-BLEND-AMT ROUNDED =
118700       H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.
118800
118900
119000*** ------------------------------------------------------ ***
119100*** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
119200*** ------------------------------------------------------ ***
119300     COMPUTE H-SS-BLENDED-PMT ROUNDED =
119400       H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.
119500
119600
119700 3600-SS-BLENDED-PMT-EXIT.
119800      EXIT.
119900
120000
120100***************************************************************
120200*   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
120300*   PER DIEM PAYMENT AMOUNT                                   *
120400***************************************************************
120500 3650-SS-IPPS-COMP-PMT.
120600***************************************************************
120700
120800*** -------------------------------------------------------
120900*** OPERATING TEACHING ADJUSTMENT
121000*** -------------------------------------------------------
121100     COMPUTE H-OPER-IME-TEACH ROUNDED =
121200        1.35 * ((1 + H-INTERN-RATIO) ** .405 - 1).
121300
121400
121500*** -------------------------------------------------------
121600*** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
121700*** -------------------------------------------------------
121800     IF H-CAPI-IME-RATIO > 1.5000
121900        MOVE 1.5000 TO H-CAPI-IME-RATIO.
122000
122100     COMPUTE H-CAPI-IME-TEACH ROUNDED =
122200        (2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1.
122300
122400
122500*** -------------------------------------------------------
122600*** OPERATING DSH ADJUSTMENT
122700*** -------------------------------------------------------
122800
122900*1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
123000*---------------------------------------------------
123100     IF ALL-RURAL
123200        SET RURAL-CBSA TO TRUE
123300     ELSE
123400        SET URBAN-CBSA TO TRUE
123500     END-IF.
123600
123700
123800*2) CALCULATE THE OPERATING DSH PERCENT
123900*--------------------------------------
124000     COMPUTE H-OPER-DSH-PCT ROUNDED =
124100        P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.
124200
124300
124400*3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
124500*-----------------------------------------------------
124600
124700*    URBAN, < 100 BEDS
124800*    -----------------
124900     IF URBAN-CBSA AND H-BED-SIZE < 100 AND
125000        H-OPER-DSH-PCT >= .15
125100          MOVE '3' TO H-GEO-CLASS
125200     ELSE
125300
125400
125500*   URBAN, >= 100 BEDS
125600*   ------------------
125700       IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
125800          H-OPER-DSH-PCT >= .15
125900            MOVE '2' TO H-GEO-CLASS
126000       ELSE
126100
126200
126300*   RURAL, >= 500 BEDS
126400*   ------------------
126500         IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
126600            H-OPER-DSH-PCT >= .15
126700              MOVE '2' TO H-GEO-CLASS
126800         ELSE
126900
127000
127100*   RURAL, < 500 BEDS
127200*   -----------------
127300           IF RURAL-CBSA AND H-BED-SIZE < 500 AND
127400              H-OPER-DSH-PCT >= .15
127500                MOVE '3' TO H-GEO-CLASS
127600           ELSE
127700
127800
127900*   OTHER
128000*   -----------------
128100              MOVE '4' TO H-GEO-CLASS
128200
128300           END-IF
128400         END-IF
128500       END-IF
128600     END-IF.
128700
128800
128900*4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
129000*-----------------------------------------------------------
129100     EVALUATE H-GEO-CLASS
129200
129300*      GEOGRAPHIC CLASS 2
129400*      ------------------
129500       WHEN '2'
129600          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
129700             COMPUTE H-OPER-DSH ROUNDED =
129800               ((H-OPER-DSH-PCT - .15) * .65) + .025
129900          ELSE
130000             IF H-OPER-DSH-PCT > .202
130100                COMPUTE H-OPER-DSH ROUNDED =
130200                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
130300             ELSE
130400                MOVE ZEROS TO H-OPER-DSH
130500             END-IF
130600          END-IF
130700
130800*      GEOGRAPHIC CLASS 3
130900*      ------------------
131000       WHEN '3'
131100          IF (H-OPER-DSH-PCT >= .15 AND <= .202)
131200             COMPUTE H-OPER-DSH ROUNDED =
131300               ((H-OPER-DSH-PCT - .15) * .65) + .025
131400             IF H-OPER-DSH > .12
131500                MOVE .12 TO H-OPER-DSH
131600             END-IF
131700          ELSE
131800             IF H-OPER-DSH-PCT > .202
131900                COMPUTE H-OPER-DSH ROUNDED =
132000                  ((H-OPER-DSH-PCT - .202) * .825) + .0588
132100                IF H-OPER-DSH > .12
132200                   MOVE .12 TO H-OPER-DSH
132300                END-IF
132400             ELSE
132500               MOVE ZEROS TO H-OPER-DSH
132600             END-IF
132700          END-IF
132800
132900*      GEOGRAPHIC CLASS 4
133000*      ------------------
133100       WHEN '4'
133200          MOVE ZEROS TO H-OPER-DSH
133300
133400     END-EVALUATE.
133500
133600
133700*** -------------------------------------------------------
133800*** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
133900*** -------------------------------------------------------
134000     IF URBAN-CBSA AND H-BED-SIZE >= 100
134100        COMPUTE H-CAPI-DSH ROUNDED =
134200          2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
134300     ELSE
134400        MOVE ZEROS TO H-CAPI-DSH
134500     END-IF.
134600
134700
134800*** -------------------------------------------------------
134900*** OPERATING PAYMENT (STANDARD AMOUNT)
135000*** -------------------------------------------------------
135100     IF (P-NEW-STATE = 02 OR 12)
135200        MOVE P-NEW-COLA TO H-OPER-COLA
135300     ELSE
135400        MOVE 1.000 TO H-OPER-COLA
135500     END-IF.
135600
135700     COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
135800       ( (H-IPPS-NAT-LABOR-SHR * W-IPPS-WAGE-INDEX) +
135900         (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
136000         H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
136100
136200
136300*** -------------------------------------------------------
136400*** CAPITAL PAYMENT (CAPITAL RATE)
136500*** -------------------------------------------------------
136600     COMPUTE H-CAPI-COLA ROUNDED =
136700       (.3152 * (H-OPER-COLA - 1) + 1).
136800
136900*--------------------------------------------------------------*
137000*   LARGE-URBAN ADD-ON ELIMINATED FOR VERSIONS 2008.1 &        *
137100*   LATER (CHANGED FROM 1.03 TO 1.00)                          *
137200*--------------------------------------------------------------*
137300     IF LARGE-URBAN
137400        MOVE 1.00 TO H-LRGURB-ADD-ON
137500     ELSE
137600        MOVE 1.00 TO H-LRGURB-ADD-ON
137700     END-IF.
137800
137900     COMPUTE H-CAPI-GAF ROUNDED =
138000       (W-IPPS-WAGE-INDEX ** .6848).
138100
138200     COMPUTE H-CAPI-PMT ROUNDED =
138300       H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
138400       H-LRGURB-ADD-ON *  H-CAPI-COLA *
138500       (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
138600
138700
138800*** -------------------------------------------------------
138900*** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
139000*** -------------------------------------------------------
139100     COMPUTE H-IPPS-PAY-AMT ROUNDED =
139200       H-STAND-AMT-OPER-PMT + H-CAPI-PMT.
139300
139400
139500*** -------------------------------------------------------
139600*** IPPS COMPARABLE PER DIEM PAYMENT
139700*** -------------------------------------------------------
139800     COMPUTE H-IPPS-PER-DIEM ROUNDED =
139900       (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
140000
140100     IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
140200        MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
140300     END-IF.
140400
140500*** -------------------------------------------------------
140600*** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
140700*** -------------------------------------------------------
140800     IF P-NEW-STATE = 40
140900        PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT
141000     END-IF.
141100
141200
141300 3650-SS-IPPS-COMP-PMT-EXIT.
141400      EXIT.
141500
141600
141700***************************************************************
141800 3675-SS-IPPS-COMP-PR-PMT.
141900***************************************************************
142000
142100*** -------------------------------------------------------
142200*** PUERTO RICO OPERATING PAYMENT (STANDARD AMOUNT)
142300*** -------------------------------------------------------
142400     COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =
142500        ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +
142600          (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *
142700          H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).
142800
142900
143000*** -------------------------------------------------------
143100*** PUERTO RICO CAPITAL PAYMENT (CAPITAL RATE)
143200*** -------------------------------------------------------
143300     COMPUTE H-PR-CAPI-GAF ROUNDED =
143400        (W-IPPS-PR-WAGE-INDEX ** .6848).
143500
143600     COMPUTE H-PR-CAPI-PMT ROUNDED =
143700        H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *
143800        H-LRGURB-ADD-ON * H-CAPI-COLA *
143900        (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).
144000
144100
144200*** -------------------------------------------------------
144300*** PR IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
144400*** -------------------------------------------------------
144500     COMPUTE H-IPPS-PR-PAY-AMT ROUNDED =
144600        H-PR-STAND-AMT-OPER-PMT + H-PR-CAPI-PMT.
144700
144800
144900*** -------------------------------------------------------
145000*** PUERTO RICO IPPS COMPARABLE PER DIEM PAYMENT
145100*** -------------------------------------------------------
145200     COMPUTE H-IPPS-PR-PER-DIEM ROUNDED =
145300        (H-IPPS-PR-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.
145400
145500     IF H-IPPS-PR-PER-DIEM > H-IPPS-PR-PAY-AMT
145600        MOVE H-IPPS-PR-PAY-AMT TO H-IPPS-PR-PER-DIEM
145700     END-IF.
145800
145900
146000*** -------------------------------------------------------
146100*** BLEND FEDERAL PER DIEM AND PUERTO RICO PER DIEM
146200*** -------------------------------------------------------
146300     COMPUTE H-IPPS-PER-DIEM ROUNDED =
146400        (H-IPPS-PER-DIEM    * H-NAT-IPPS-PMT-PCT) +
146500        (H-IPPS-PR-PER-DIEM * H-PR-IPPS-PMT-PCT ).
146600
146700
146800 3675-EXIT.
146900      EXIT.
147000
147100
147200***************************************************************
147300 4000-SPECIAL-PROVIDER.
147400***************************************************************
147500
147600*** PROCESS FOR CY2003
147700*** ------------------
147800     IF (B-DISCHARGE-DATE >= 20030701) AND
147900        (B-DISCHARGE-DATE <  20040101)
148000        COMPUTE H-SS-COST ROUNDED =
148100            (PPS-FAC-COSTS * 1.95)
148200        COMPUTE H-SS-PAY-AMT ROUNDED =
148300         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
148400     END-IF
148500
148600
148700*** PROCESS FOR CY2004
148800*** ------------------
148900     IF (B-DISCHARGE-DATE >= 20040101) AND
149000        (B-DISCHARGE-DATE <  20050101)
149100        COMPUTE H-SS-COST ROUNDED =
149200            (PPS-FAC-COSTS * 1.93)
149300        COMPUTE H-SS-PAY-AMT ROUNDED =
149400          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
149500     END-IF
149600
149700
149800*** PROCESS FOR CY2005
149900*** ------------------
150000     IF (B-DISCHARGE-DATE >= 20050101) AND
150100        (B-DISCHARGE-DATE <  20060101)
150200        COMPUTE H-SS-COST ROUNDED =
150300            (PPS-FAC-COSTS * 1.65)
150400        COMPUTE H-SS-PAY-AMT ROUNDED =
150500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
150600     END-IF
150700
150800
150900*** PROCESS FOR CY2006
151000*** ------------------
151100     IF (B-DISCHARGE-DATE >= 20060101) AND
151200        (B-DISCHARGE-DATE <  20070101)
151300        COMPUTE H-SS-COST ROUNDED =
151400            (PPS-FAC-COSTS * 1.36)
151500        COMPUTE H-SS-PAY-AMT ROUNDED =
151600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
151700     END-IF
151800
151900
152000*** PROCESS FOR CY2007 AND AFTER
152100*** ----------------------------
152200     IF (B-DISCHARGE-DATE >= 20070101)
152300        COMPUTE H-SS-COST ROUNDED =
152400            (PPS-FAC-COSTS * 1.2)
152500        COMPUTE H-SS-PAY-AMT ROUNDED =
152600          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
152700     END-IF.
152800
152900 4000-SPECIAL-PROVIDER-EXIT.
153000      EXIT.
153100
153200
153300***************************************************************
153400*   CALCULATE THE OUTLIER THRESHOLD                           *
153500*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
153600*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
153700*   SET RETURN CODE TO INDICATE OUTLIER PAYMENT METHOD        *
153800***************************************************************
153900 7000-CALC-OUTLIER.
154000***************************************************************
154100
154200     COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
154300         PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT.
154400
154500     IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
154600        COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
154700         ((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
154800           * PPS-BDGT-NEUT-RATE * H-BLEND-PPS.
154900
155000     IF B-SPEC-PAY-IND = '1'
155100        MOVE 0 TO PPS-OUTLIER-PAY-AMT.
155200
155300     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 21
155400        MOVE 24 TO PPS-RTC.
155500
155600     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 22
155700        MOVE 25 TO PPS-RTC.
155800
155900     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 26
156000        MOVE 27 TO PPS-RTC.
156100
156200     IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 00
156300        MOVE 01 TO PPS-RTC.
156400
156500     IF (PPS-RTC = 00 OR 20 OR 21 OR 22 OR 26)
156600        IF PPS-REG-DAYS-USED > H-SSOT
156700           MOVE 0 TO PPS-LTR-DAYS-USED
156800        ELSE
156900           NEXT SENTENCE.
157000
157100     IF (PPS-RTC = 01 OR 24 OR 25 OR 27) OR
157200        (PPS-COT-IND = 'Y')
157300
157400        IF (B-COV-DAYS < H-LOS) OR
157500           (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
157600           COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
157700             PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO
157800
157900*** ------------------------------------------------------- ***
158000*** SET PPS-RTC TO 67 IN MAINFRAME PRICER, NOT IN PC PRICER ***
158100*** (IN PC PRICER, PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS)   ***
158200*** ------------------------------------------------------- ***
158300           IF NOT PC-PRICER
158400              MOVE 67 TO PPS-RTC
158500           END-IF
158600
158700        ELSE
158800           NEXT SENTENCE
158900        END-IF
159000     ELSE
159100        NEXT SENTENCE
159200     END-IF.
159300
159400
159500 7000-EXIT.
159600      EXIT.
159700
159800
159900***************************************************************
160000*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
160100*   SET RTC FOR SPECIFIED BLEND YEAR INDICATOR.               *
160200***************************************************************
160300 8000-BLEND.
160400***************************************************************
160500
160600     COMPUTE H-LOS-RATIO ROUNDED = H-LOS / PPS-AVG-LOS.
160700
160800     IF H-LOS-RATIO > 1
160900        COMPUTE H-LOS-RATIO = ((H-LOS-RATIO - 1) * .8) + 1.
161000
161100     COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
161200           (PPS-DRG-ADJ-PAY-AMT * PPS-BDGT-NEUT-RATE)
161300             * H-BLEND-PPS.
161400
161500     COMPUTE PPS-NEW-FAC-SPEC-RATE ROUNDED =
161600            (P-NEW-FAC-SPEC-RATE * PPS-BDGT-NEUT-RATE)
161700              * H-BLEND-FAC * H-LOS-RATIO.
161800
161900     COMPUTE PPS-FINAL-PAY-AMT =
162000          PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
162100              + PPS-NEW-FAC-SPEC-RATE.
162200
162300
162400*----------------------------------------------------------*
162500* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/O OUTLIER *
162600*----------------------------------------------------------*
162700     IF (PPS-RTC = 20 OR 21 OR 22 OR 26) AND (H-BLEND-RTC > 0)
162800          COMPUTE PPS-RTC = H-BLEND-RTC + 2
162900
163000*----------------------------------------------------------*
163100* CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/ OUTLIER  *
163200*----------------------------------------------------------*
163300     ELSE
163400        IF (PPS-RTC = 24 OR 25 OR 27) AND (H-BLEND-RTC > 0)
163500           COMPUTE PPS-RTC = H-BLEND-RTC + 3
163600
163700*----------------------------------------------------------*
163800* CALCULATE RETURN CODE FOR ALL OTHER BILLS                *
163900*----------------------------------------------------------*
164000        ELSE
164100           ADD H-BLEND-RTC TO PPS-RTC
164200
164300        END-IF
164400     END-IF.
164500
164600 8000-EXIT.
164700      EXIT.
164800
164900
165000***************************************************************
165100 9000-MOVE-RESULTS.
165200***************************************************************
165300
165400     IF PPS-RTC < 50
165500        MOVE H-LOS TO PPS-LOS
165600        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
165700     ELSE
165800       INITIALIZE PPS-DATA
165900       INITIALIZE PPS-OTHER-DATA
166000
166100*** ----------------------------------- ***
166200*** ADDED FOR JULY 2006 RELEASE (V07.1) ***
166300*** ----------------------------------- ***
166400       INITIALIZE PPS-CBSA
166500       INITIALIZE HOLD-PPS-COMPONENTS
166600
166700       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
166800     END-IF.
166900
167000
167100*** *************************************************** ***
167200*** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***
167300*** *************************************************** ***
167400
167500*    IF (B-PROVIDER-NO = '087001' OR
167600*                        '087002' OR
167700*                        '087003' OR
167800*                        '087004' OR
167900*                        '087005' OR
168000*                        '400687'  )
168100*
168200*     DISPLAY '---------------------------------------------'
168300*     DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
168400*     DISPLAY 'PPS-RTC '                  PPS-RTC
168500*     DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT
168600*     DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
168700*     DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
168800*     DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
168900*     DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
169000*     DISPLAY 'PPS-CBSA '                 PPS-CBSA
169100*     DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
169200*     DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
169300*     DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
169400*     DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
169500*     DISPLAY 'B-DRG-CODE '               B-DRG-CODE
169600*     DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
169700*     DISPLAY 'H-SSOT '                   H-SSOT
169800*     DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
169900*     DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
170000*     DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
170100*     DISPLAY 'H-LOS '                    H-LOS
170200*     DISPLAY 'H-REG-DAYS '               H-REG-DAYS
170300*     DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
170400*     DISPLAY 'H-SSOT '                   H-SSOT
170500*     DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
170600*     DISPLAY 'H-BLEND-FAC '              H-BLEND-FAC
170700*     DISPLAY 'H-BLEND-PPS '              H-BLEND-PPS
170800*     DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
170900*     DISPLAY 'H-SS-COST '                H-SS-COST
171000*     DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
171100*     DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
171200*     DISPLAY 'H-FIXED-LOSS-AMT '         H-FIXED-LOSS-AMT
171300*     DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
171400*     DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
171500*     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
171600*     DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
171700*     DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
171800*     DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
171900*     DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
172000*     DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
172100*     DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
172200*     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
172300*     DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
172400*     DISPLAY 'H-BED-SIZE '               H-BED-SIZE
172500*     DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
172600*     DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
172700*     DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
172800*     DISPLAY 'H-OPER-DSH '               H-OPER-DSH
172900*     DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
173000*     DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
173100*     DISPLAY 'H-URBAN-IND '              H-URBAN-IND
173200*     DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
173300*     DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
173400*     DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
173500*     DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
173600*     DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
173700*     DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
173800*     DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
173900*     DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
174000*     DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
174100*     DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
174200*     DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
174300*     DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
174400*     DISPLAY 'H-OPER-COLA '              H-OPER-COLA
174500*     DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
174600*     DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
174700*     DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
174800*     DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
174900*     DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
175000*     DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
175100*     DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
175200*     DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
175300*     DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
175400*     DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
175500*     DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
175600*     DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT
175700*     DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT
175800*     DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
175900*     DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
176000*     DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
176100*     DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
176200*     DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
176300*
176400*    END-IF.
176500
176600 9000-EXIT.
176700      EXIT.
176800
176900******        L A S T   S O U R C E   S T A T E M E N T   *****
