000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     LTCAL080.
000400*REMARKS.        CMS.
000500*                EFFECTIVE JULY 1, 2007.
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
001900     'LTCAL080      - W O R K I N G   S T O R A G E'.
002000 01  CAL-VERSION                    PIC X(05)  VALUE 'V08.0'.
002010 01  PROGRAM-CONSTANTS.
002020     05  FED-FY-BEGIN-03            PIC 9(08) VALUE 20021001.
002030     05  FED-FY-BEGIN-04            PIC 9(08) VALUE 20031001.
002040     05  FED-FY-BEGIN-05            PIC 9(08) VALUE 20041001.
002050     05  FED-FY-BEGIN-06            PIC 9(08) VALUE 20051001.
002060     05  FED-FY-BEGIN-07            PIC 9(08) VALUE 20061001.
002100
002150
002200***************************************************************
002300*    LAYUP TABLE AREA FOR FY2007 LTC-DRG                      *
002400*    EFFECTIVE DATE OF OCTOBER 1, 2006                        *
002500***************************************************************
002600 COPY LTDRG080.
002100
002150
002200***************************************************************
002300*    LAYUP TABLE AREA FOR FY2007 IPPS-DRG                     *
002400*    EFFECTIVE DATE OF OCTOBER 1, 2006                        *
002500***************************************************************
002600 COPY IPDRG071.
024400

      ***************************************************************
      *    THESE VARIABLES WILL BE USED TO CALCULATE THE PAYMENT    *
      ***************************************************************
024500 01  HOLD-PPS-COMPONENTS.
024900     05  H-LOS                        PIC 9(03).
024900     05  H-REG-DAYS                   PIC 9(03).
024900     05  H-TOTAL-DAYS                 PIC 9(05).
024900     05  H-SSOT                       PIC 9(02)V9(01).
024900     05  H-BLEND-RTC                  PIC 9(02).
024900     05  H-BLEND-FAC                  PIC 9(01)V9(01).
024900     05  H-BLEND-PPS                  PIC 9(01)V9(01).
026200     05  H-SS-PAY-AMT                 PIC 9(07)V9(02).
026200     05  H-SS-COST                    PIC 9(07)V9(02).
026300     05  H-LABOR-PORTION              PIC 9(07)V9(06).
026300     05  H-NONLABOR-PORTION           PIC 9(07)V9(06).
026200     05  H-FIXED-LOSS-AMT             PIC 9(07)V9(02).
050600     05  H-NEW-FAC-SPEC-RATE          PIC 9(05)V9(02).
050600     05  H-LOS-RATIO                  PIC 9(01)V9(05).

      *** --------------------------------------------------- ***
      *** VARIABLES FOR SHORT-STAY OUTLIER PROVISION #4       ***
      *** --------------------------------------------------- ***
           05  H-OPER-IME-TEACH             PIC 9(06)V9(09).
           05  H-CAPI-IME-TEACH             PIC 9(06)V9(09).
           05  H-LTCH-BLEND-PCT             PIC 9(03)V9(04).
           05  H-IPPS-BLEND-PCT             PIC 9(03)V9(04).
           05  H-LTCH-BLEND-AMT             PIC 9(07)V9(02).
           05  H-IPPS-BLEND-AMT             PIC 9(07)V9(02).
           05  H-INTERN-RATIO               PIC 9(01)V9(04).
           05  H-CAPI-IME-RATIO             PIC 9V9999.
           05  H-BED-SIZE                   PIC 9(05).
           05  H-OPER-DSH-PCT               PIC V9(04).
           05  H-SSI-RATIO                  PIC V9(04).
           05  H-MEDICAID-RATIO             PIC V9(04).
           05  H-OPER-DSH                   PIC 9(01)V9(04).
           05  H-CAPI-DSH                   PIC 9(01)V9(04).
           05  H-GEO-CLASS                  PIC X(01).
           05  H-URBAN-IND                  PIC X(01).
                 88 URBAN-CBSA           VALUE '1'.
                 88 RURAL-CBSA           VALUE '0'.
           05  H-STAND-AMT-OPER-PMT         PIC 9(07)V9(02).
           05  H-PR-STAND-AMT-OPER-PMT      PIC 9(07)V9(02).
           05  H-CAPI-PMT                   PIC 9(07)V9(02).
           05  H-PR-CAPI-PMT                PIC 9(07)V9(02).
           05  H-CAPI-GAF                   PIC 9(05)V9(04).
           05  H-PR-CAPI-GAF                PIC 9(05)V9(04).
           05  H-LRGURB-ADD-ON              PIC 9(01)V9(02).
           05  H-IPPS-PAY-AMT               PIC 9(07)V9(02).
           05  H-IPPS-PR-PAY-AMT            PIC 9(07)V9(02).
           05  H-IPPS-PER-DIEM              PIC 9(07)V9(02).
           05  H-IPPS-PR-PER-DIEM           PIC 9(07)V9(02).
           05  H-SS-BLENDED-PMT             PIC 9(07)V9(02).
           05  H-OPER-COLA                  PIC 9(01)V9(03).
           05  H-CAPI-COLA                  PIC 9(01)V9(03).
           05  H-IPPS-NAT-LABOR-SHR         PIC 9(05)V9(02).
           05  H-IPPS-NAT-NONLABOR-SHR      PIC 9(05)V9(02).
           05  H-IPPS-PR-LABOR-SHR          PIC 9(05)V9(02).
           05  H-IPPS-PR-NONLABOR-SHR       PIC 9(05)V9(02).
           05  H-IPPS-DRG-WGT               PIC 9(02)V9(04).
           05  H-IPPS-DRG-ALOS              PIC 9(02)V9(01).
           05  H-IPPS-DAYS-CUTOFF           PIC 9(02).
           05  H-IPPS-ARITH-ALOS            PIC 9(02)V9(01).
           05  H-IPPS-CAPI-STD-FED-RATE     PIC 9(03)V9(02).
           05  H-IPPS-CAPI-STD-PR-RATE      PIC 9(03)V9(02).
           05  H-NAT-IPPS-PMT-PCT           PIC 9(01)V9(02).
           05  H-PR-IPPS-PMT-PCT            PIC 9(01)V9(02).
           05  H-COUNTER                    PIC 9(02).

      *** --------------------------------------------------- ***
      *** VARIABLES FOR PC PRICER                             ***
      *** --------------------------------------------------- ***
           05  H-PPS-DRG-UNADJ-PAY-AMT      PIC 9(07)V9(02).
           05  H-SS-COST-IND                PIC X.
           05  H-SS-PERDIEM-IND             PIC X.
           05  H-SS-BLEND-IND               PIC X.
           05  H-SS-IPPSCOMP-IND            PIC X.


028000
028050
028100 LINKAGE SECTION.
028200**************************************************************
028300*      THIS IS THE BILL-RECORD THAT WILL BE PASSED FROM      *
028400*      THE LTDRV___ PROGRAM                                  *
028500**************************************************************
028600 01  BILL-NEW-DATA.
028700     10  B-NPI10.
028800         15  B-NPI8             PIC X(08).
028900         15  B-NPI-FILLER       PIC X(02).
029000     10  B-PROVIDER-NO          PIC X(06).
029000     10  B-PATIENT-STATUS       PIC X(02).
029000     10  B-DRG-CODE             PIC 9(03).
029200     10  B-LOS                  PIC 9(03).
029300     10  B-COV-DAYS             PIC 9(03).
029700     10  B-LTR-DAYS             PIC 9(02).
029900     10  B-DISCHARGE-DATE.
030000         15  B-DISCHG-CC        PIC 9(02).
030100         15  B-DISCHG-YY        PIC 9(02).
030000         15  B-DISCHG-MM        PIC 9(02).
030100         15  B-DISCHG-DD        PIC 9(02).
030200     10  B-COV-CHARGES          PIC 9(07)V9(02).
030200     10  B-SPEC-PAY-IND         PIC X(01).
030300     10  FILLER                 PIC X(13).
030400
030450
030500***************************************************************
030520***************************************************************
030560*                                                             *
030600*    THIS DATA IS CALCULATED BY THIS LTCAL SUBROUTINE         *
030700*    AND PASSED BACK TO THE CALLING PROGRAM                   *
030800*    RETURN CODE VALUES (PPS-RTC)                             *
030900*                                                             *
031000*     ****   PPS-RTC 00-49 = HOW THE BILL WAS PAID            *
031100*             00 = NORMAL DRG PAYMENT WITHOUT OUTLIER         *
031200*                                                             *
031300*             01 = NORMAL DRG PAYMENT WITH OUTLIER            *
031400*                                                             *
031100*             04 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
031100*                  20% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
031200*                                                             *
031100*             05 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
031300*                  20% NORMAL DRG PAYMENT WITH OUTLIER        *
031400*                                                             *
031100*             06 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
031500*                  20% SHORT STAY PAYMENT WITHOUT OUTLIER     *
031600*                                                             *
031100*             07 = BLEND YEAR 1 - 80% FACILITY RATE PLUS      *
031700*                  20% SHORT STAY PAYMENT WITH OUTLIER        *
033100*                                                             *
031100*             08 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031100*                  40% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
031200*                                                             *
031100*             09 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031300*                  40% NORMAL DRG PAYMENT WITH OUTLIER        *
031400*                                                             *
031100*             10 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031500*                  40% SHORT STAY PAYMENT WITHOUT OUTLIER     *
031600*                                                             *
031100*             11 = BLEND YEAR 2 - 60% FACILITY RATE PLUS      *
031700*                  40% SHORT STAY PAYMENT WITH OUTLIER        *
033100*                                                             *
031100*             12 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
031100*                  60% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
031200*                                                             *
031100*             13 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
031300*                  60% NORMAL DRG PAYMENT WITH OUTLIER        *
031400*                                                             *
031100*             14 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
031500*                  60% SHORT STAY PAYMENT WITHOUT OUTLIER     *
031600*                                                             *
031100*             15 = BLEND YEAR 3 - 40% FACILITY RATE PLUS      *
031700*                  60% SHORT STAY PAYMENT WITH OUTLIER        *
033100*                                                             *
031100*             16 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
031100*                  80% NORMAL DRG PAYMENT WITHOUT OUTLIER     *
031200*                                                             *
031100*             17 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
031300*                  80% NORMAL DRG PAYMENT WITH OUTLIER        *
031400*                                                             *
031100*             18 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
031500*                  80% SHORT STAY PAYMENT WITHOUT OUTLIER     *
031600*                                                             *
031100*             19 = BLEND YEAR 4 - 20% FACILITY RATE PLUS      *
031700*                  80% SHORT STAY PAYMENT WITH OUTLIER        *
033100*                                                             *
033100*             20 = SHORT STAY PAYMENT BASED ON ESTIMATED COST *
033100*                  WITHOUT OUTLIER                            *
033100*                                                             *
033100*             21 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
033100*                  DIEM WITHOUT OUTLIER                       *
033100*                                                             *
033100*             22 = SHORT STAY PAYMENT BASED ON BLEND OF       *
033100*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
033100*                  AMOUNT WITHOUT OUTLIER                     *
033100*                                                             *
033100*             24 = SHORT STAY PAYMENT BASED ON LTC-DRG PER    *
033100*                  DIEM WITH OUTLIER                          *
033100*                                                             *
033100*             25 = SHORT STAY PAYMENT BASED ON BLEND OF       *
033100*                  LTC-DRG PER DIEM AND IPPS COMPARABLE       *
033100*                  AMOUNT WITH OUTLIER                        *
033100*                                                             *
033100*             26 = SHORT STAY PAYMENT BASED ON IPPS-          *
033100*                  COMPARABLE THRESHOLD WITHOUT OUTLIER       *
033100*                                                             *
033100*             27 = SHORT STAY PAYMENT BASED ON IPPS-          *
033100*                  COMPARABLE THRESHOLD WITH OUTLIER          *
033100*                                                             *
033100*                                                             *
033100*                                                             *
033200*      ****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID        *
033300*             50 = PROVIDER SPECIFIC RATE OR COLA NOT NUMERIC *
033400*             51 = PROVIDER RECORD TERMINATED                 *
033500*             52 = INVALID WAGE INDEX                         *
033600*             53 = WAIVER STATE - NOT CALCULATED BY PPS       *
033700*             54 = DRG ON CLAIM NOT FOUND IN TABLE            *
033800*             55 = DISCHARGE DATE < PROVIDER EFF START DATE   *
033900*                                     OR                      *
034000*                  DISCHARGE DATE < CBSA EFF START DATE       *
034100*                  FOR PPS                                    *
034500*             56 = INVALID LENGTH OF STAY                     *
034800*             58 = TOTAL COVERED CHARGES NOT NUMERIC          *
034900*             59 = PROVIDER SPECIFIC RECORD NOT FOUND         *
035000*             60 = CBSA WAGE INDEX RECORD NOT FOUND           *
035100*             61 = LIFETIME RESERVE DAYS NOT NUMERIC          *
035200*                  OR BILL-LTR-DAYS > 60                      *
035300*             62 = INVALID NUMBER OF COVERED DAYS             *
035500*                  OR BILL-LTR-DAYS > COVERED DAYS            *
035500*             65 = OPERATING COST-TO-CHARGE RATIO NOT NUMERIC *
035600*             67 = COST OUTLIER WITH LOS > COVERED DAYS       *
035700*                  OR COST OUTLIER THRESHOLD CALCULATION      *
035800*             72 = INVALID BLEND INDICATOR (NOT 1 THRU 5)     *
035900*             73 = DISCHARGED BEFORE PROVIDER FY BEGIN        *
036100*             74 = PROVIDER FY BEGIN DATE BEFORE 10/01/2002   *
036100*             98 = BILL DISCHARGE DATE BEFORE 10/01/2002      *
036200*                                                             *
036220***************************************************************
036260***************************************************************
036270
036280
036260***************************************************************
036260* THIS IS THE PPS DATA THAT WILL BE POPULATED IN THIS PROGRAM *
036260* FOR DISPLAY IN THE OPER REPORT CREATED BY LTMGR___          *
036260***************************************************************
036300 01  PPS-DATA-ALL.
036500     05  PPS-RTC                       PIC 9(02).
036500     05  PPS-CHRG-THRESHOLD            PIC 9(07)V9(02).
036400     05  PPS-DATA.
036600         10  PPS-MSA                   PIC X(04).
036600         10  PPS-WAGE-INDEX            PIC 9(02)V9(04).
036800         10  PPS-AVG-LOS               PIC 9(02)V9(01).
036900         10  PPS-RELATIVE-WGT          PIC 9(01)V9(04).
037300         10  PPS-OUTLIER-PAY-AMT       PIC 9(07)V9(02).
037500         10  PPS-LOS                   PIC 9(03).
038000         10  PPS-DRG-ADJ-PAY-AMT       PIC 9(07)V9(02).
038000         10  PPS-FED-PAY-AMT           PIC 9(07)V9(02).
038000         10  PPS-FINAL-PAY-AMT         PIC 9(07)V9(02).
038000         10  PPS-FAC-COSTS             PIC 9(07)V9(02).
038000         10  PPS-NEW-FAC-SPEC-RATE     PIC 9(07)V9(02).
038300         10  PPS-OUTLIER-THRESHOLD     PIC 9(07)V9(02).
038500         10  PPS-SUBM-DRG-CODE         PIC X(03).
038550         10  PPS-CALC-VERS-CD          PIC X(05).
038600         10  PPS-REG-DAYS-USED         PIC 9(03).
038650         10  PPS-LTR-DAYS-USED         PIC 9(03).
038700         10  PPS-BLEND-YEAR            PIC 9(01).
038750         10  PPS-COLA                  PIC 9(01)V9(03).
038800         10  FILLER                    PIC X(04).
038900     05  PPS-OTHER-DATA.
039200         10  PPS-NAT-LABOR-PCT         PIC 9(01)V9(05).
039200         10  PPS-NAT-NONLABOR-PCT      PIC 9(01)V9(05).
039400         10  PPS-STD-FED-RATE          PIC 9(05)V9(02).
039400         10  PPS-BDGT-NEUT-RATE        PIC 9(01)V9(03).
039400         10  PPS-IPTHRESH              PIC 9(03)V9(01).
039800         10  FILLER                    PIC X(16).
039900     05  PPS-PC-DATA.
040000         10  PPS-COT-IND               PIC X(01).
               10  H-PC-IND                  PIC X(02).
                     88  PC-PRICER               VALUE 'PC'.
040100         10  FILLER                    PIC X(18).
040200
040200 01 PPS-CBSA                           PIC X(05).
040200
040250
040300******************************************************************
040400*            THESE ARE THE VERSIONS OF THE LTDRV___              *
040500*           PROGRAMS THAT WILL BE PASSED BACK----                *
040600*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
040700******************************************************************
040800 01  PRICER-OPT-VERS-SW.
040900     05  PRICER-OPTION-SW          PIC X(01).
041000         88  ALL-TABLES-PASSED          VALUE 'A'.
041100         88  PROV-RECORD-PASSED         VALUE 'P'.
041200     05  PPS-VERSIONS.
041300         10  PPDRV-VERSION         PIC X(05).
041400
041500
041600**************************************************************
041700*      THIS IS THE PROV-RECORD THAT WILL BE PASSED BY        *
041800*      THE LTCAL___ PROGRAM (FROM PROGRAM LTDRV___)          *
041900**************************************************************
042000 01  PROV-NEW-HOLD.
042100     02  PROV-NEWREC-HOLD1.
042200         05  P-NEW-NPI10.
042300             10  P-NEW-NPI8             PIC X(08).
042400             10  P-NEW-NPI-FILLER       PIC X(02).
042500         05  P-NEW-PROVIDER-NO.
042600             10  P-NEW-STATE            PIC 9(02).
042700             10  FILLER                 PIC X(04).
042800         05  P-NEW-DATE-DATA.
042900             10  P-NEW-EFF-DATE.
043000                 15  P-NEW-EFF-DT-CC    PIC 9(02).
043100                 15  P-NEW-EFF-DT-YY    PIC 9(02).
043200                 15  P-NEW-EFF-DT-MM    PIC 9(02).
043300                 15  P-NEW-EFF-DT-DD    PIC 9(02).
043400             10  P-NEW-FY-BEGIN-DATE.
043500                 15  P-NEW-FY-BEG-DT-CC PIC 9(02).
043600                 15  P-NEW-FY-BEG-DT-YY PIC 9(02).
043700                 15  P-NEW-FY-BEG-DT-MM PIC 9(02).
043800                 15  P-NEW-FY-BEG-DT-DD PIC 9(02).
043900             10  P-NEW-REPORT-DATE.
044000                 15  P-NEW-REPORT-DT-CC PIC 9(02).
044100                 15  P-NEW-REPORT-DT-YY PIC 9(02).
044200                 15  P-NEW-REPORT-DT-MM PIC 9(02).
044300                 15  P-NEW-REPORT-DT-DD PIC 9(02).
044400             10  P-NEW-TERMINATION-DATE.
044500                 15  P-NEW-TERM-DT-CC   PIC 9(02).
044600                 15  P-NEW-TERM-DT-YY   PIC 9(02).
044700                 15  P-NEW-TERM-DT-MM   PIC 9(02).
044800                 15  P-NEW-TERM-DT-DD   PIC 9(02).
044900         05  P-NEW-WAIVER-CODE          PIC X(01).
045000             88  P-NEW-WAIVER-STATE       VALUE 'Y'.
045100         05  P-NEW-INTER-NO             PIC 9(05).
045200         05  P-NEW-PROVIDER-TYPE        PIC X(02).
047000         05  P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
048000         05  P-NEW-CURRENT-DIV   REDEFINES
048100                    P-NEW-CURRENT-CENSUS-DIV   PIC 9(01).
048300         05  P-NEW-MSA-DATA.
048400             10  P-NEW-CHG-CODE-INDEX       PIC X.
048500             10  P-NEW-GEO-LOC-MSAX         PIC X(04) JUST RIGHT.
048600             10  P-NEW-GEO-LOC-MSA9   REDEFINES
048700                             P-NEW-GEO-LOC-MSAX  PIC 9(04).
048800             10  P-NEW-WAGE-INDEX-LOC-MSA   PIC X(04) JUST RIGHT.
048900             10  P-NEW-STAND-AMT-LOC-MSA    PIC X(04) JUST RIGHT.
049000             10  P-NEW-STAND-AMT-LOC-MSA9
049100                 REDEFINES P-NEW-STAND-AMT-LOC-MSA.
049200                 15  P-NEW-RURAL-1ST.
049300                     20  P-NEW-STAND-RURAL  PIC XX.
049400                         88  P-NEW-STD-RURAL-CHECK VALUE '  '.
049500                 15  P-NEW-RURAL-2ND        PIC XX.
049600         05  P-NEW-SOL-COM-DEP-HOSP-YR PIC XX.
050000         05  P-NEW-LUGAR                    PIC X.
050100         05  P-NEW-TEMP-RELIEF-IND          PIC X.
050200         05  P-NEW-FED-PPS-BLEND-IND        PIC X.
050300         05  FILLER                         PIC X(05).
050400     02  PROV-NEWREC-HOLD2.
050500         05  P-NEW-VARIABLES.
050600             10  P-NEW-FAC-SPEC-RATE     PIC  9(05)V9(02).
050700             10  P-NEW-COLA              PIC  9(01)V9(03).
050800             10  P-NEW-INTERN-RATIO      PIC  9(01)V9(04).
050900             10  P-NEW-BED-SIZE          PIC  9(05).
051000             10  P-NEW-OPER-CSTCHG-RATIO PIC  9(01)V9(03).
051100             10  P-NEW-CMI               PIC  9(01)V9(04).
051200             10  P-NEW-SSI-RATIO         PIC  V9(04).
051300             10  P-NEW-MEDICAID-RATIO    PIC  V9(04).
051400             10  P-NEW-PPS-BLEND-YR-IND  PIC  9(01).
051500             10  P-NEW-PRUF-UPDTE-FACTOR PIC  9(01)V9(05).
051600             10  P-NEW-DSH-PERCENT       PIC  V9(04).
051700             10  P-NEW-FYE-DATE          PIC  X(08).
051720         05  P-NEW-SPECIAL-PAY-IND         PIC X(01).
051730         05  FILLER                        PIC X(01).
051740         05  P-NEW-GEO-LOC-CBSAX           PIC X(05) JUST RIGHT.
051750         05  P-NEW-GEO-LOC-CBSA9 REDEFINES
051760                       P-NEW-GEO-LOC-CBSAX PIC 9(05).
051770         05  P-NEW-GEO-LOC-CBSA-AST REDEFINES
051780                       P-NEW-GEO-LOC-CBSAX.
051790             10 P-NEW-GEO-LOC-CBSA-1ST     PIC X.
051800             10 P-NEW-GEO-LOC-CBSA-2ND     PIC X.
051810             10 P-NEW-GEO-LOC-CBSA-3RD     PIC X.
051820             10 P-NEW-GEO-LOC-CBSA-4TH     PIC X.
051830             10 P-NEW-GEO-LOC-CBSA-5TH     PIC X.
051840         05  FILLER                        PIC X(10).
051850         05  P-NEW-SPECIAL-WAGE-INDEX      PIC 9(02)V9(04).
051900     02  PROV-NEWREC-HOLD3.
052000         05  P-NEW-PASS-AMT-DATA.
052100             10  P-NEW-PASS-AMT-CAPITAL    PIC 9(04)V99.
052200             10  P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99.
052300             10  P-NEW-PASS-AMT-ORGAN-ACQ  PIC 9(04)V99.
052400             10  P-NEW-PASS-AMT-PLUS-MISC  PIC 9(04)V99.
052500         05  P-NEW-CAPI-DATA.
052600             15  P-NEW-CAPI-PPS-PAY-CODE   PIC X.
052700             15  P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99.
052800             15  P-NEW-CAPI-OLD-HARM-RATE  PIC 9(04)V99.
052900             15  P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999.
053000             15  P-NEW-CAPI-CSTCHG-RATIO   PIC 9V999.
053100             15  P-NEW-CAPI-NEW-HOSP       PIC X.
053200             15  P-NEW-CAPI-IME            PIC 9V9999.
053300             15  P-NEW-CAPI-EXCEPTIONS     PIC 9(04)V99.
053400         05  FILLER                        PIC X(22).
054400
054450
053500******************************************************************
053600*                THIS IS THE LTCH WAGE-INDEX                     *
053700*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
053750*    (CHANGED TO CBSA FROM MSA STARTING WITH JULY 2005 RELEASE)  *
053800******************************************************************
053900 01  WAGE-NEW-INDEX-RECORD.
054000     05  W-CBSA                        PIC X(5).
054100     05  W-EFF-DATE                    PIC X(8).
054200     05  W-WAGE-INDEX1                 PIC S9(02)V9(04).
054200     05  W-WAGE-INDEX2                 PIC S9(02)V9(04).
054300     05  W-WAGE-INDEX3                 PIC S9(02)V9(04).


      ******************************************************************
      *                THIS IS THE IPPS WAGE-INDEX                     *
      *          ASSOCIATED WITH THE BILL BEING PROCESSED              *
      ******************************************************************
       01  WAGE-NEW-IPPS-INDEX-RECORD.
           05  W-CBSA-IPPS.
               10 CBSA-IPPS-123              PIC X(3).
               10 CBSA-IPPS-45               PIC X(2).
           05  W-CBSA-IPPS-SIZE              PIC X.
               88  LARGE-URBAN       VALUE 'L'.
               88  OTHER-URBAN       VALUE 'O'.
               88  ALL-RURAL         VALUE 'R'.
           05  W-CBSA-IPPS-EFF-DATE          PIC X(8).
           05  FILLER                        PIC X.
           05  W-IPPS-WAGE-INDEX             PIC S9(02)V9(04).
           05  W-IPPS-PR-WAGE-INDEX          PIC S9(02)V9(04).
054400
054400
054400
054500 PROCEDURE DIVISION  USING BILL-NEW-DATA
054600                           PPS-DATA-ALL
054600                           PPS-CBSA
054700                           PRICER-OPT-VERS-SW
054800                           PROV-NEW-HOLD
054900                           WAGE-NEW-INDEX-RECORD
055000                           WAGE-NEW-IPPS-INDEX-RECORD.
055050
055060
055100***************************************************************
055100*                                                             *
055200*    PROCESSING:                                              *
055300*        A. WILL PROCESS CLAIMS BASED ON LENGTH OF STAY       *
055400*        B. INITIALIZE LTCAL HOLD VARIABLES.                  *
055500*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE        *
055600*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM        *
055700*           CANNOT BE PROCESSED, SET A RETURN CODE AND        *
055800*           GOBACK.                                           *
055900*        D. ASSEMBLE PRICING COMPONENTS.                      *
056000*        E. CALCULATE THE PRICE.                              *
056100*        F. CALCULATE OUTLIERS IF APPLICABLE.                 *
056200*                                                             *
056200***************************************************************
056220
056240
056260***************************************************************
056300 0000-MAINLINE-CONTROL.
056400***************************************************************
056500
           PERFORM 0100-INITIAL-ROUTINE
              THRU 0100-EXIT.

           PERFORM 1000-EDIT-THE-BILL-INFO
              THRU 1000-EXIT.

           IF PPS-RTC = 00
              PERFORM 1700-EDIT-DRG-CODE
                 THRU 1700-EXIT.

           IF PPS-RTC = 00
              PERFORM 1800-EDIT-IPPS-DRG-CODE
                 THRU 1800-EXIT
                 VARYING DX5 FROM 1 BY 1 UNTIL DX5 > 1.

           IF PPS-RTC = 00
              PERFORM 2000-ASSEMBLE-PPS-VARIABLES
                 THRU 2000-EXIT.

           IF PPS-RTC = 00
              PERFORM 3000-CALC-PAYMENT
                 THRU 3000-EXIT
              PERFORM 7000-CALC-OUTLIER
                 THRU 7000-EXIT.

           IF PPS-RTC < 50
              PERFORM 8000-BLEND
                 THRU 8000-EXIT.

           PERFORM 9000-MOVE-RESULTS
              THRU 9000-EXIT.

           GOBACK.
061800
061950
064800***************************************************************
062000 0100-INITIAL-ROUTINE.
064800***************************************************************
062100
062150     MOVE ZEROS TO PPS-RTC.
062200     INITIALIZE PPS-DATA.
062300     INITIALIZE PPS-OTHER-DATA.
           INITIALIZE PPS-CBSA.
062400     INITIALIZE HOLD-PPS-COMPONENTS.
062500
           MOVE P-NEW-GEO-LOC-CBSAX TO PPS-CBSA.

      *** ---------------------------------------------------- ***
      *** RATES FOR LTCH PAYMENT: CHANGE IN JULY               ***
      *** ---------------------------------------------------- ***
           MOVE .75788   TO PPS-NAT-LABOR-PCT.
           MOVE .24212   TO PPS-NAT-NONLABOR-PCT.
           MOVE 38356.45 TO PPS-STD-FED-RATE.
           MOVE 20738.00 TO H-FIXED-LOSS-AMT.
           MOVE 1.000    TO PPS-BDGT-NEUT-RATE.

      *** ---------------------------------------------------- ***
      *** RATES FOR IPPS COMPARABLE PAYMENT: CHANGE IN OCTOBER ***
      *** ---------------------------------------------------- ***
           MOVE 427.03 TO H-IPPS-CAPI-STD-FED-RATE.
           MOVE 203.03 TO H-IPPS-CAPI-STD-PR-RATE.
           MOVE 0.75   TO H-NAT-IPPS-PMT-PCT.
           MOVE 0.25   TO H-PR-IPPS-PMT-PCT.

           IF W-IPPS-WAGE-INDEX > 1
              MOVE 3397.52 TO H-IPPS-NAT-LABOR-SHR
              MOVE 1476.97 TO H-IPPS-NAT-NONLABOR-SHR
           ELSE
              MOVE 3022.18 TO H-IPPS-NAT-LABOR-SHR
              MOVE 1852.31 TO H-IPPS-NAT-NONLABOR-SHR
           END-IF.

           IF W-IPPS-PR-WAGE-INDEX > 1
              MOVE 1436.12 TO H-IPPS-PR-LABOR-SHR
              MOVE  880.20 TO H-IPPS-PR-NONLABOR-SHR
           ELSE
              MOVE 1359.68 TO H-IPPS-PR-LABOR-SHR
              MOVE  956.64 TO H-IPPS-PR-NONLABOR-SHR
           END-IF.


062000 0100-EXIT.
062100      EXIT.
063100
063100
064500***************************************************************
064600*    BILL DATA EDITS - IF ANY FAIL SET PPS-RTC                *
064700*    AND DO NOT ATTEMPT TO PRICE.                             *
064800***************************************************************
064400 1000-EDIT-THE-BILL-INFO.
073200***************************************************************
065100
065200     IF (B-LOS NUMERIC) AND (B-LOS > 0)
065400        MOVE B-LOS TO H-LOS
065500     ELSE
065600        MOVE 56 TO PPS-RTC.
065900
           IF PPS-RTC = 00
             IF P-NEW-COLA NOT NUMERIC
                MOVE 50 TO PPS-RTC.

067700     IF PPS-RTC = 00
067800       IF P-NEW-WAIVER-STATE
067900          MOVE 53 TO PPS-RTC.

068000     IF PPS-RTC = 00
068200         IF ((B-DISCHARGE-DATE < P-NEW-EFF-DATE) OR
068300            (B-DISCHARGE-DATE < W-EFF-DATE))
068400            MOVE 55 TO PPS-RTC.
068500
068600     IF PPS-RTC = 00
068700         IF P-NEW-TERMINATION-DATE > 00000000
068800            IF B-DISCHARGE-DATE >= P-NEW-TERMINATION-DATE
069000               MOVE 51 TO PPS-RTC.
069100
069200     IF PPS-RTC = 00
069300         IF B-COV-CHARGES NOT NUMERIC
069400            MOVE 58 TO PPS-RTC.
072700
072700     IF PPS-RTC = 00
072700        IF B-LTR-DAYS NOT NUMERIC OR B-LTR-DAYS > 60
072700           MOVE 61 TO PPS-RTC.
072700
072700     IF PPS-RTC = 00
072700        IF (B-COV-DAYS NOT NUMERIC) OR
                 (B-COV-DAYS = 0 AND H-LOS > 0)
072700           MOVE 62 TO PPS-RTC.
072700
072700     IF PPS-RTC = 00
072700        IF B-LTR-DAYS > B-COV-DAYS
072700           MOVE 62 TO PPS-RTC.
072700
072700     IF PPS-RTC = 00
              COMPUTE H-REG-DAYS = B-COV-DAYS - B-LTR-DAYS
              COMPUTE H-TOTAL-DAYS = H-REG-DAYS + B-LTR-DAYS.
072700
072700     IF PPS-RTC = 00
072700        PERFORM 1200-DAYS-USED
072700           THRU 1200-DAYS-USED-EXIT.
072700
072700
      *** -----------------------------------------------------------
      *** EDITS FOR PSF FIELDS USED FOR THE 4TH SHORT STAY PROVISION
      *** -----------------------------------------------------------
           IF PPS-RTC = 00
              IF P-NEW-CAPI-IME NUMERIC
                 MOVE P-NEW-CAPI-IME TO H-CAPI-IME-RATIO
              ELSE
                 MOVE ZEROS TO H-CAPI-IME-RATIO
              END-IF
           END-IF.

           IF PPS-RTC = 00
              IF P-NEW-INTERN-RATIO NUMERIC
                 MOVE P-NEW-INTERN-RATIO TO H-INTERN-RATIO
              ELSE
                 MOVE ZEROS TO H-INTERN-RATIO
              END-IF
           END-IF.

           IF PPS-RTC = 00
              IF P-NEW-BED-SIZE NUMERIC
                 MOVE P-NEW-BED-SIZE TO H-BED-SIZE
              ELSE
                 MOVE ZEROS TO H-BED-SIZE
              END-IF
           END-IF.

           IF PPS-RTC = 00
              IF P-NEW-SSI-RATIO NUMERIC
                 MOVE P-NEW-SSI-RATIO TO H-SSI-RATIO
              ELSE
                 MOVE ZEROS TO H-SSI-RATIO
              END-IF
           END-IF.

           IF PPS-RTC = 00
              IF P-NEW-MEDICAID-RATIO NUMERIC
                 MOVE P-NEW-MEDICAID-RATIO TO H-MEDICAID-RATIO
              ELSE
                 MOVE ZEROS TO H-MEDICAID-RATIO
              END-IF
           END-IF.


072900 1000-EXIT.
073000      EXIT.

072700
073200***************************************************************
072900 1200-DAYS-USED.
073200***************************************************************
073000
           IF (B-LTR-DAYS > 0) AND (H-REG-DAYS = 0)
              IF B-LTR-DAYS > H-LOS
                 MOVE H-LOS TO PPS-LTR-DAYS-USED
              ELSE
                 MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
           ELSE
              IF (H-REG-DAYS > 0) AND (B-LTR-DAYS = 0)
                 IF H-REG-DAYS > H-LOS
                    MOVE H-LOS TO PPS-REG-DAYS-USED
                 ELSE
                    MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
              ELSE
                 IF (H-REG-DAYS > 0) AND (B-LTR-DAYS > 0)
                    IF H-REG-DAYS > H-LOS
                       MOVE H-LOS TO PPS-REG-DAYS-USED
                       MOVE 0 TO PPS-LTR-DAYS-USED
                    ELSE
                       IF H-TOTAL-DAYS > H-LOS
                          MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
                          COMPUTE PPS-LTR-DAYS-USED =
                                  H-LOS - H-REG-DAYS
                       ELSE
                          IF H-TOTAL-DAYS <= H-LOS
                             MOVE H-REG-DAYS TO PPS-REG-DAYS-USED
                             MOVE B-LTR-DAYS TO PPS-LTR-DAYS-USED
                          ELSE
                             NEXT SENTENCE
                 ELSE
                    NEXT SENTENCE.
072700
072900 1200-DAYS-USED-EXIT.
073000      EXIT.


073200***************************************************************
073300*    FINDS THE LTCH DRG CODE IN THE TABLE                     *
073400***************************************************************
073100 1700-EDIT-DRG-CODE.
073400***************************************************************
073500
065000     MOVE B-DRG-CODE TO PPS-SUBM-DRG-CODE.
           IF PPS-RTC = 00
074500        SEARCH ALL WWM-ENTRY
074600           AT END
074700             MOVE 54 TO PPS-RTC
074800        WHEN WWM-DRG (WWM-INDX) = PPS-SUBM-DRG-CODE
075200             PERFORM 1750-FIND-VALUE
075300                THRU 1750-EXIT
              END-SEARCH.

       1700-EXIT.
            EXIT.


073200***************************************************************
073300*    FINDS THE RELATIVE WEIGHT AND AVG LOS FOR THE LTCH DRG   *
073400***************************************************************
073100 1750-FIND-VALUE.
077100***************************************************************
073500
075300      MOVE WWM-RELWT    (WWM-INDX) TO PPS-RELATIVE-WGT.
075400      MOVE WWM-ALOS     (WWM-INDX) TO PPS-AVG-LOS.
075400      MOVE WWM-IPTHRESH (WWM-INDX) TO PPS-IPTHRESH.

       1750-EXIT.
            EXIT.


073200***************************************************************
073300*    FINDS THE IPPS DRG CODE IN THE TABLE                     *
073400***************************************************************
073100 1800-EDIT-IPPS-DRG-CODE.
073400***************************************************************
073500
           IF B-DRG-CODE NOT NUMERIC
              MOVE 54 TO PPS-RTC
              GO TO 1800-EXIT
           END-IF.

           IF B-DISCHARGE-DATE NOT < DRGX-EFF-DATE(DX5) AND PPS-RTC = 0
              SET DX6                       TO B-DRG-CODE
              MOVE DRG-WT (DX5 DX6)         TO H-IPPS-DRG-WGT
              MOVE DRG-ALOS (DX5 DX6)       TO H-IPPS-DRG-ALOS
              MOVE ZEROES                   TO H-IPPS-DAYS-CUTOFF
              MOVE DRG-ARITH-ALOS (DX5 DX6) TO H-IPPS-ARITH-ALOS
           END-IF.

       1800-EXIT.
            EXIT.


077100***************************************************************
077600***  GET THE PROVIDER SPECIFIC VARIABLES AND WAGE INDEX       *
077500*                                                             *
077200*    THE APPROPRIATE SET OF THESE PPS VARIABLES ARE SELECTED  *
077300*    DEPENDING ON THE BILL DISCHARGE DATE AND EFFECTIVE DATE  *
077400*    OF THAT VARIABLE.                                        *
077500*                                                             *
077700***************************************************************
077000 2000-ASSEMBLE-PPS-VARIABLES.
080500***************************************************************
077800

      *------------------------------------------------------*
      * WAGE INDEX BLEND TABLE                               *
      *------------------------------------------------------*
      *                                                      *
      *  BLEND YEAR   FEDERAL FY                BLEND        *
      *  ----------   ----------------------    -----        *
      *      1        10/01/2002 - 09/30/2003    1/5         *
      *      2        10/01/2003 - 09/30/2004    2/5         *
      *      3        10/01/2004 - 09/30/2005    3/5         *
      *      4        10/01/2005 - 09/30/2006    4/5         *
      *      5        10/01/2006 - INDEFINITE    5/5 (FULL)  *
      *                                                      *
      *------------------------------------------------------*
      *                                                      *
      * A PROVIDER WILL RECEIVE THE APPLICABLE BLEND FOR A   *
      * GIVEN FEDERAL FY FOR CLAIMS DISCHARGED ON & AFTER    *
      * ITS FY BEGIN DATE THAT FALLS WITHIN THAT FEDERAL FY. *
      *                                                      *
      *------------------------------------------------------*


           EVALUATE TRUE

      ***************************************************************
      * PROVIDER FY BEGIN DATE WITHIN THE CURRENT 5/5 FEDERAL FY    *
      ***************************************************************
            WHEN P-NEW-FY-BEGIN-DATE >= FED-FY-BEGIN-07
                    IF W-WAGE-INDEX3 NUMERIC AND W-WAGE-INDEX3 > 0
                       MOVE W-WAGE-INDEX3 TO PPS-WAGE-INDEX
                    ELSE
                       MOVE 52 TO PPS-RTC
                       GO TO 2000-EXIT
                    END-IF


      ***************************************************************
      * PROVIDER FY BEGIN DATE WITHIN THE PREVIOUS 4/5 FEDERAL FY   *
      ***************************************************************
            WHEN P-NEW-FY-BEGIN-DATE <  FED-FY-BEGIN-07 AND
                 P-NEW-FY-BEGIN-DATE >= FED-FY-BEGIN-06

                    IF W-WAGE-INDEX2 NUMERIC AND W-WAGE-INDEX2 > 0
                       MOVE W-WAGE-INDEX2 TO PPS-WAGE-INDEX
                    ELSE
                       MOVE 52 TO PPS-RTC
                       GO TO 2000-EXIT
                    END-IF


      ***************************************************************
      * PROVIDER FY BEGIN DATE NOT UPDATED                          *
      ***************************************************************
            WHEN P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-06
                 MOVE 52 TO PPS-RTC
                 GO TO 2000-EXIT


      ***************************************************************
      * PROVIDER FY BEGIN DATE BEFORE THE FIRST PPS FEDERAL FY      *
      * (ALWAYS FED-FY-BEGIN-03)                                    *
      ***************************************************************
            WHEN P-NEW-FY-BEGIN-DATE < FED-FY-BEGIN-03
                 MOVE 74 TO PPS-RTC
                 GO TO 2000-EXIT

           END-EVALUATE.


      ***************************************************************
      * USE SPECIAL WAGE INDEX WHEN INDICATED                       *
      ***************************************************************
           IF P-NEW-SPECIAL-PAY-IND = '1'
              IF P-NEW-SPECIAL-WAGE-INDEX NUMERIC AND
                 P-NEW-SPECIAL-WAGE-INDEX > 0
                 MOVE P-NEW-SPECIAL-WAGE-INDEX TO PPS-WAGE-INDEX
              ELSE
                 MOVE 52 TO PPS-RTC
                 GO TO 2000-EXIT
              END-IF
           END-IF.


      ***************************************************************
      * EDIT FOR OPERATING COST-TO-CHARGE RATIO                     *
      ***************************************************************
079400     IF P-NEW-OPER-CSTCHG-RATIO NOT NUMERIC
080100        MOVE 65 TO PPS-RTC.


      ***************************************************************
      * DETERMINE BLEND YEAR, BLEND PERCENTAGES, BLEND RETURN CODE  *
      ***************************************************************
           MOVE P-NEW-FED-PPS-BLEND-IND TO PPS-BLEND-YEAR.

           IF PPS-BLEND-YEAR > 0 AND PPS-BLEND-YEAR < 6
              NEXT SENTENCE
           ELSE
              MOVE 72 TO PPS-RTC
              GO TO 2000-EXIT.

           MOVE 0 TO H-BLEND-FAC.
           MOVE 1 TO H-BLEND-PPS.
           MOVE 0 TO H-BLEND-RTC.

           IF PPS-BLEND-YEAR = 1
              MOVE .8 TO H-BLEND-FAC
              MOVE .2 TO H-BLEND-PPS
              MOVE 4 TO H-BLEND-RTC
           ELSE
             IF PPS-BLEND-YEAR = 2
                MOVE .6 TO H-BLEND-FAC
                MOVE .4 TO H-BLEND-PPS
                MOVE 8 TO H-BLEND-RTC
             ELSE
               IF PPS-BLEND-YEAR = 3
                  MOVE .4 TO H-BLEND-FAC
                  MOVE .6 TO H-BLEND-PPS
                  MOVE 12 TO H-BLEND-RTC
               ELSE
                 IF PPS-BLEND-YEAR = 4
                    MOVE .2 TO H-BLEND-FAC
                    MOVE .8 TO H-BLEND-PPS
                    MOVE 16 TO H-BLEND-RTC.
080200
077000 2000-EXIT.
            EXIT.

080300
080500***************************************************************
080600*    IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)           *
080700*        CALCULATE THE STANDARD PAYMENT AMOUNT.               *
080900*        CALCULATE THE SHORT-STAY OUTLIER AMOUNT.             *
081100***************************************************************
080400 3000-CALC-PAYMENT.
080500***************************************************************
081300
      *** -------------------------------------------------- ***
      *** FORCE COLA VALUE TO 1.000 (EXCEPT ALASKA & HAWAII) ***
      *** -------------------------------------------------- ***
           IF (P-NEW-STATE = 02 OR 12)
              MOVE P-NEW-COLA TO PPS-COLA
           ELSE
              MOVE 1.000 TO PPS-COLA
           END-IF.


           COMPUTE PPS-FAC-COSTS ROUNDED =
               P-NEW-OPER-CSTCHG-RATIO * B-COV-CHARGES.

           COMPUTE H-LABOR-PORTION ROUNDED =
               (PPS-STD-FED-RATE * PPS-NAT-LABOR-PCT)
                * PPS-WAGE-INDEX.

           COMPUTE H-NONLABOR-PORTION ROUNDED =
               (PPS-STD-FED-RATE * PPS-NAT-NONLABOR-PCT)
                * PPS-COLA.

           COMPUTE PPS-FED-PAY-AMT ROUNDED =
               (H-LABOR-PORTION + H-NONLABOR-PORTION).

           COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
               (PPS-FED-PAY-AMT * PPS-RELATIVE-WGT).


      *** -------------------------------------------------------- ***
      *** FOR PC PRICER: RETAIN DRG UNADJUSTED PMT AMT FOR DISPLAY ***
      *** -------------------------------------------------------- ***
           MOVE PPS-DRG-ADJ-PAY-AMT TO H-PPS-DRG-UNADJ-PAY-AMT.

      *** --------------------------------------------- ***
      *** DETERMINE WHETHER THE CLAIM IS A SHORT STAY   ***
      *** --------------------------------------------- ***
      *** H-SSOT ROUNDED AND EXPANDED TO 1 DECIMAL      ***
      *** PLACE FOR RELEASE 07.1                        ***
      *** --------------------------------------------- ***
           COMPUTE H-SSOT ROUNDED = (PPS-AVG-LOS / 6) * 5.
083900     IF H-LOS <= H-SSOT
083300        PERFORM 3400-SHORT-STAY
083300           THRU 3400-SHORT-STAY-EXIT.
086400
086500 3000-EXIT.
086500      EXIT.
088800
088800
080500***************************************************************
080600*    IF THE LENGTH OF STAY IS LESS THAN OR EQUAL TO 5/6       *
080700*      OF THE AVG. LENGTH OF STAY THEN:                       *
080900*      - CALCULATE THE SHORT-STAY COST.                       *
080900*      - CALCULATE THE SHORT-STAY PAYMENT AMOUNT.             *
080900*      - CALCULATE THE SHORT-STAY BLENDED PAYMENT -OR-        *
080900*      - CALCULATE THE IPPS COMPARABLE PER DIEM AMOUNT        *
080900*      - PAY THE LEAST OF:                                    *
080900*          1)SHORT STAY COST                                  *
080900*          2)SHORT STAY PAYMENT AMOUNT                        *
080900*          3)DRG ADJUSTED PAYMENT AMOUNT                      *
080900*          4)SHORT STAY BLENDED PAYMENT -OR-                  *
080900*          5)IPPS COMPARABLE AMOUNT                           *
080900*      - SET RETURN CODE TO INDICATE SHORT STAY PAYMENT TYPE  *
081100***************************************************************
087300 3400-SHORT-STAY.
080500***************************************************************
089200
      **************************************************************
      *                                                            *
      *   SHORT STAY PROVISION FOR SPECIAL PROVIDER 332006 ONLY    *
      *                                                            *
      **************************************************************
           IF P-NEW-PROVIDER-NO = '332006'
              PERFORM 4000-SPECIAL-PROVIDER
                 THRU 4000-SPECIAL-PROVIDER-EXIT

           ELSE


      **************************************************************
      *                                                            *
      *   SHORT STAY PROVISION #1 (SS COST = 100% OF FAC. COST)    *
      * ---------------------------------------------------------- *
      *   * CHANGED FROM 120% TO 100% OF COSTS FOR RELEASE 07.1    *
      *                                                            *
      **************************************************************
              MOVE PPS-FAC-COSTS TO H-SS-COST


      **************************************************************
      *                                                            *
      *   SHORT STAY PROVISION #2 (SS PMT = 120% OF PER DIEM)      *
      * ---------------------------------------------------------- *
      *   * USES LENGTH OF STAY INSTEAD OF COVERED DAYS, THE       *
      *     STANDARD SYSTEM RUNS EDITS ON THE BILL WHICH ENSURE    *
      *     THE LENGTH OF STAY IS CORRECT                          *
      *                                                            *
      **************************************************************
              COMPUTE H-SS-PAY-AMT ROUNDED =
               ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2


      **************************************************************
      *                                                            *
      *   SHORT STAY PROVISIONS #4 & #5                            *
      * ---------------------------------------------------------- *
      *   #4 - BLEND OF SS PMT & IPPS COMPARABLE PER DIEM AMT      *
      *         (LOS (COVERED DAYS) > IPPS COMP THRESHOLD)         *
      *   #5 - IPPS COMP PER DIEM AMT                              *
      *         (LOS (COVERED DAYS) <= IPPS COMP THRESHOLD)        *
      * ---------------------------------------------------------- *
      *   #4  INTRODUCED IN RELEASE 07.1                           *
      *   #5  INTRODUCED IN RELEASE 08.0                           *
      *                                                            *
      **************************************************************
             IF W-IPPS-WAGE-INDEX NUMERIC AND
                W-IPPS-WAGE-INDEX > 0

      *---------------------------------------------------------
      *   #4 - LOS (COVERED DAYS) > IPPS COMPARABLE THRESHOLD
      *        CALCULATE BLENDED PAYMENT
      *---------------------------------------------------------
                IF H-LOS > PPS-IPTHRESH
                   PERFORM 3600-SS-BLENDED-PMT
                      THRU 3600-SS-BLENDED-PMT-EXIT

      *---------------------------------------------------------
      *   #5 - LOS (COVERED DAYS) <= IPPS COMPARABLE THRESHOLD
      *        CALCULATE IPPS COMPARABLE PER DIEM AMT ONLY
      *---------------------------------------------------------
                ELSE
                   PERFORM 3650-SS-IPPS-COMP-PMT
                      THRU 3650-SS-IPPS-COMP-PMT-EXIT
                END-IF

      *---------------------------------------------------------
      *   WAGE INDEX IS INVALID
      *   SET ERROR CODE & EXIT
      *---------------------------------------------------------
             ELSE
                MOVE 52 TO PPS-RTC
                GO TO 3400-SHORT-STAY-EXIT
             END-IF.


      **************************************************************
      *                                                            *
      *   DETERMINE WHICH OF THE SHORT STAY PROVISIONS AND THE     *
      *   DRG ADJUSTED PAYMENT SHOULD BE USED                      *
      * ---------------------------------------------------------- *
      *   * SS INDICATORS ADDED FOR PC PRICER - RELEASE 07.1       *
      *                                                            *
      **************************************************************

           MOVE 'N' TO H-SS-COST-IND.
           MOVE 'N' TO H-SS-PERDIEM-IND.
           MOVE 'N' TO H-SS-BLEND-IND.
           MOVE 'N' TO H-SS-IPPSCOMP-IND.

      *---------------------------------------------------------
      *   DETERMINE THE LEAST OF THE SS COST, SS PMT AMT (120%
      *   OF PER DIEM) AND DRG ADJUSTED PMT AMT
      *---------------------------------------------------------
           IF H-SS-COST < H-SS-PAY-AMT
              IF H-SS-COST < PPS-DRG-ADJ-PAY-AMT
                 MOVE H-SS-COST TO PPS-DRG-ADJ-PAY-AMT
                 MOVE 20 TO PPS-RTC
                 MOVE 'Y' TO H-SS-COST-IND
              ELSE
                 NEXT SENTENCE
              END-IF
           ELSE
              IF H-SS-PAY-AMT < PPS-DRG-ADJ-PAY-AMT
                 MOVE H-SS-PAY-AMT TO PPS-DRG-ADJ-PAY-AMT
                 MOVE 21 TO PPS-RTC
                 MOVE 'Y' TO H-SS-PERDIEM-IND
              ELSE
                 NEXT SENTENCE
              END-IF
           END-IF.

      *---------------------------------------------------------
      *   USE THE BLENDED PMT OR IPPS COMPARABLE AMT IF LESS
      *   THAN THE OTHER OPTIONS
      *---------------------------------------------------------
           IF P-NEW-PROVIDER-NO NOT = '332006'

      *---------------------------------------------------------
      *   COMPARE BLENDED PAYMENT
      *---------------------------------------------------------
              IF H-LOS > PPS-IPTHRESH
                 IF H-SS-BLENDED-PMT < PPS-DRG-ADJ-PAY-AMT
                    MOVE H-SS-BLENDED-PMT TO PPS-DRG-ADJ-PAY-AMT
                    MOVE 22 TO PPS-RTC
                    MOVE 'Y' TO H-SS-BLEND-IND
                    MOVE 'N' TO H-SS-COST-IND
                    MOVE 'N' TO H-SS-PERDIEM-IND
                    MOVE 'N' TO H-SS-IPPSCOMP-IND
                 ELSE
                    NEXT SENTENCE
                 END-IF

      *---------------------------------------------------------
      *   COMPARE IPPS COMPARABLE PER DIEM AMOUNT
      *---------------------------------------------------------
              ELSE
                 IF H-IPPS-PER-DIEM < PPS-DRG-ADJ-PAY-AMT
                    MOVE H-IPPS-PER-DIEM TO PPS-DRG-ADJ-PAY-AMT
                    MOVE 26 TO PPS-RTC
                    MOVE 'Y' TO H-SS-IPPSCOMP-IND
                    MOVE 'N' TO H-SS-BLEND-IND
                    MOVE 'N' TO H-SS-COST-IND
                    MOVE 'N' TO H-SS-PERDIEM-IND
                 ELSE
                    NEXT SENTENCE
                 END-IF
           END-IF.
091600
087300 3400-SHORT-STAY-EXIT.
091700      EXIT.
088800
091600
      ***************************************************************
      *    CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE     *
      *       THIS PAYMENT IS A BLEND OF 120% OF THE SHORT STAY     *
      *       PER DIEM (SHORT STAY PAYMENT AMT) AND 100% OF THE     *
      *       IPPS COMPARABLE PER DIEM PAYMENT AMT                  *
      ***************************************************************
       3600-SS-BLENDED-PMT.
      ***************************************************************

      *** ------------------------------------------------------ ***
      *** CALCULATE THE BLEND PERCENTAGE OF LTC-DRG PER DIEM     ***
      *** ------------------------------------------------------ ***
           IF H-SSOT < 25
              COMPUTE H-LTCH-BLEND-PCT ROUNDED =
                H-LOS / H-SSOT
           ELSE
              COMPUTE H-LTCH-BLEND-PCT ROUNDED =
                H-LOS / 25
           END-IF.

           IF H-LTCH-BLEND-PCT > 1
              MOVE 1 TO H-LTCH-BLEND-PCT
           END-IF.


      *** ------------------------------------------------------ ***
      *** CALCULATE THE BLEND AMOUNT OF LTC-DRG PER DIEM         ***
      *** ------------------------------------------------------ ***
           COMPUTE H-LTCH-BLEND-AMT ROUNDED =
              H-SS-PAY-AMT * H-LTCH-BLEND-PCT.


      *** ------------------------------------------------------ ***
      *** CALCULATE THE IPPS COMPARABLE PER DIEM PAYMENT         ***
      *** ------------------------------------------------------ ***
           PERFORM 3650-SS-IPPS-COMP-PMT
              THRU 3650-SS-IPPS-COMP-PMT-EXIT.


      *** ------------------------------------------------------ ***
      *** CALCULATE THE BLEND PERCENTAGE OF IPPS COMPARABLE PMT  ***
      *** ------------------------------------------------------ ***
           COMPUTE H-IPPS-BLEND-PCT ROUNDED =
             1 - H-LTCH-BLEND-PCT.


      *** ------------------------------------------------------ ***
      *** CALCULATE THE BLEND AMOUNT OF IPPS COMPARABLE PMT      ***
      *** ------------------------------------------------------ ***
           COMPUTE H-IPPS-BLEND-AMT ROUNDED =
             H-IPPS-PER-DIEM * H-IPPS-BLEND-PCT.


      *** ------------------------------------------------------ ***
      *** CALCULATE THE SHORT STAY BLENDED PAYMENT ALTERNATIVE   ***
      *** ------------------------------------------------------ ***
           COMPUTE H-SS-BLENDED-PMT ROUNDED =
             H-LTCH-BLEND-AMT + H-IPPS-BLEND-AMT.


       3600-SS-BLENDED-PMT-EXIT.
            EXIT.


      ***************************************************************
      *   CALCULATE THE IPPS COMPARABLE PAYMENT COMPONENTS AND      *
      *   PER DIEM PAYMENT AMOUNT                                   *
      ***************************************************************
       3650-SS-IPPS-COMP-PMT.
      ***************************************************************

      *** -------------------------------------------------------
      *** OPERATING TEACHING ADJUSTMENT
      *** -------------------------------------------------------
           COMPUTE H-OPER-IME-TEACH ROUNDED =
              1.32 * ((1 + H-INTERN-RATIO) ** .405 - 1).


      *** -------------------------------------------------------
      *** CAPITAL TEACHING ADJUSTMENT (2.7183 = E ROUNDED)
      *** -------------------------------------------------------
           IF H-CAPI-IME-RATIO > 1.5000
              MOVE 1.5000 TO H-CAPI-IME-RATIO.

           COMPUTE H-CAPI-IME-TEACH ROUNDED =
              (2.7183 ** (.2822 * H-CAPI-IME-RATIO)) - 1.


      *** -------------------------------------------------------
      *** OPERATING DSH ADJUSTMENT
      *** -------------------------------------------------------

      *1) DETERMINE WHETHER THE PROVIDER IS URBAN OR RURAL
      *---------------------------------------------------
           IF ALL-RURAL
              SET RURAL-CBSA TO TRUE
           ELSE
              SET URBAN-CBSA TO TRUE
           END-IF.


      *2) CALCULATE THE OPERATING DSH PERCENT
      *--------------------------------------
           COMPUTE H-OPER-DSH-PCT ROUNDED =
              P-NEW-SSI-RATIO + P-NEW-MEDICAID-RATIO.


      *3) DETERMINE THE PROVIDER'S GEOGRAPHIC CLASSIFICATION
      *-----------------------------------------------------

      *    URBAN, < 100 BEDS
      *    -----------------
           IF URBAN-CBSA AND H-BED-SIZE < 100 AND
              H-OPER-DSH-PCT >= .15
                MOVE '3' TO H-GEO-CLASS
           ELSE


      *   URBAN, >= 100 BEDS
      *   ------------------
             IF URBAN-CBSA AND H-BED-SIZE >= 100 AND
                H-OPER-DSH-PCT >= .15
                  MOVE '2' TO H-GEO-CLASS
             ELSE


      *   RURAL, >= 500 BEDS
      *   ------------------
               IF RURAL-CBSA AND H-BED-SIZE >= 500 AND
                  H-OPER-DSH-PCT >= .15
                    MOVE '2' TO H-GEO-CLASS
               ELSE


      *   RURAL, < 500 BEDS
      *   -----------------
                 IF RURAL-CBSA AND H-BED-SIZE < 500 AND
                    H-OPER-DSH-PCT >= .15
                      MOVE '3' TO H-GEO-CLASS
                 ELSE


      *   OTHER
      *   -----------------
                    MOVE '4' TO H-GEO-CLASS

                 END-IF
               END-IF
             END-IF
           END-IF.


      *4) CALCULATE OPERATING DSH AMOUNT BASED ON GEOGRAPHIC CLASS
      *-----------------------------------------------------------
           EVALUATE H-GEO-CLASS

      *      GEOGRAPHIC CLASS 2
      *      ------------------
             WHEN '2'
                IF (H-OPER-DSH-PCT >= .15 AND <= .202)
                   COMPUTE H-OPER-DSH ROUNDED =
                     ((H-OPER-DSH-PCT - .15) * .65) + .025
                ELSE
                   IF H-OPER-DSH-PCT > .202
                      COMPUTE H-OPER-DSH ROUNDED =
                        ((H-OPER-DSH-PCT - .202) * .825) + .0588
                   ELSE
                      MOVE ZEROS TO H-OPER-DSH
                   END-IF
                END-IF

      *      GEOGRAPHIC CLASS 3
      *      ------------------
             WHEN '3'
                IF (H-OPER-DSH-PCT >= .15 AND <= .202)
                   COMPUTE H-OPER-DSH ROUNDED =
                     ((H-OPER-DSH-PCT - .15) * .65) + .025
                   IF H-OPER-DSH > .12
                      MOVE .12 TO H-OPER-DSH
                   END-IF
                ELSE
                   IF H-OPER-DSH-PCT > .202
                      COMPUTE H-OPER-DSH ROUNDED =
                        ((H-OPER-DSH-PCT - .202) * .825) + .0588
                      IF H-OPER-DSH > .12
                         MOVE .12 TO H-OPER-DSH
                      END-IF
                   ELSE
                     MOVE ZEROS TO H-OPER-DSH
                   END-IF
                END-IF

      *      GEOGRAPHIC CLASS 4
      *      ------------------
             WHEN '4'
                MOVE ZEROS TO H-OPER-DSH

           END-EVALUATE.


      *** -------------------------------------------------------
      *** CAPITAL DSH ADJUSTMENT (2.7183 = E ROUNDED)
      *** -------------------------------------------------------
           IF URBAN-CBSA AND H-BED-SIZE >= 100
              COMPUTE H-CAPI-DSH ROUNDED =
                2.7183 ** (.2025 * H-OPER-DSH-PCT) - 1
           ELSE
              MOVE ZEROS TO H-CAPI-DSH
           END-IF.


      *** -------------------------------------------------------
      *** OPERATING PAYMENT (STANDARD AMOUNT)
      *** -------------------------------------------------------
           IF (P-NEW-STATE = 02 OR 12)
              MOVE P-NEW-COLA TO H-OPER-COLA
           ELSE
              MOVE 1.000 TO H-OPER-COLA
           END-IF.

           COMPUTE H-STAND-AMT-OPER-PMT ROUNDED =
             ( (H-IPPS-NAT-LABOR-SHR * W-IPPS-WAGE-INDEX) +
               (H-IPPS-NAT-NONLABOR-SHR * H-OPER-COLA) ) *
               H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).


      *** -------------------------------------------------------
      *** CAPITAL PAYMENT (CAPITAL RATE)
      *** -------------------------------------------------------
           COMPUTE H-CAPI-COLA ROUNDED =
             (.3152 * (H-OPER-COLA - 1) + 1).

           IF LARGE-URBAN
              MOVE 1.03 TO H-LRGURB-ADD-ON
           ELSE
              MOVE 1.00 TO H-LRGURB-ADD-ON
           END-IF.

           COMPUTE H-CAPI-GAF ROUNDED =
             (W-IPPS-WAGE-INDEX ** .6848).

           COMPUTE H-CAPI-PMT ROUNDED =
             H-IPPS-CAPI-STD-FED-RATE * H-IPPS-DRG-WGT * H-CAPI-GAF *
             H-LRGURB-ADD-ON *  H-CAPI-COLA *
             (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).


      *** -------------------------------------------------------
      *** IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
      *** -------------------------------------------------------
           COMPUTE H-IPPS-PAY-AMT ROUNDED =
             H-STAND-AMT-OPER-PMT + H-CAPI-PMT.


      *** -------------------------------------------------------
      *** IPPS COMPARABLE PER DIEM PAYMENT
      *** -------------------------------------------------------
           COMPUTE H-IPPS-PER-DIEM ROUNDED =
             (H-IPPS-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.

           IF H-IPPS-PER-DIEM > H-IPPS-PAY-AMT
              MOVE H-IPPS-PAY-AMT TO H-IPPS-PER-DIEM
           END-IF.

      *** -------------------------------------------------------
      *** CALCULATE PAYMENT FOR PUERTO RICO HOSPITALS
      *** -------------------------------------------------------
           IF P-NEW-STATE = 40
              PERFORM 3675-SS-IPPS-COMP-PR-PMT THRU 3675-EXIT
           END-IF.


       3650-SS-IPPS-COMP-PMT-EXIT.
            EXIT.


      ***************************************************************
       3675-SS-IPPS-COMP-PR-PMT.
      ***************************************************************

      *** -------------------------------------------------------
      *** PUERTO RICO OPERATING PAYMENT (STANDARD AMOUNT)
      *** -------------------------------------------------------
           COMPUTE H-PR-STAND-AMT-OPER-PMT ROUNDED =
              ( (H-IPPS-PR-LABOR-SHR * W-IPPS-PR-WAGE-INDEX) +
                (H-IPPS-PR-NONLABOR-SHR * H-OPER-COLA) ) *
                H-IPPS-DRG-WGT * (1 + H-OPER-IME-TEACH + H-OPER-DSH ).


      *** -------------------------------------------------------
      *** PUERTO RICO CAPITAL PAYMENT (CAPITAL RATE)
      *** -------------------------------------------------------
           COMPUTE H-PR-CAPI-GAF ROUNDED =
              (W-IPPS-PR-WAGE-INDEX ** .6848).

           COMPUTE H-PR-CAPI-PMT ROUNDED =
              H-IPPS-CAPI-STD-PR-RATE * H-IPPS-DRG-WGT * H-PR-CAPI-GAF *
              H-LRGURB-ADD-ON * H-CAPI-COLA *
              (1 + H-CAPI-IME-TEACH + H-CAPI-DSH).


      *** -------------------------------------------------------
      *** PR IPPS COMPARABLE TOTAL PAYMENT (OPERATING + CAPITAL)
      *** -------------------------------------------------------
           COMPUTE H-IPPS-PR-PAY-AMT ROUNDED =
              H-PR-STAND-AMT-OPER-PMT + H-PR-CAPI-PMT.


      *** -------------------------------------------------------
      *** PUERTO RICO IPPS COMPARABLE PER DIEM PAYMENT
      *** -------------------------------------------------------
           COMPUTE H-IPPS-PR-PER-DIEM ROUNDED =
              (H-IPPS-PR-PAY-AMT / H-IPPS-DRG-ALOS) * H-LOS.

           IF H-IPPS-PR-PER-DIEM > H-IPPS-PR-PAY-AMT
              MOVE H-IPPS-PR-PAY-AMT TO H-IPPS-PR-PER-DIEM
           END-IF.


      *** -------------------------------------------------------
      *** BLEND FEDERAL PER DIEM AND PUERTO RICO PER DIEM
      *** -------------------------------------------------------
           COMPUTE H-IPPS-PER-DIEM ROUNDED =
              (H-IPPS-PER-DIEM    * H-NAT-IPPS-PMT-PCT) +
              (H-IPPS-PR-PER-DIEM * H-PR-IPPS-PMT-PCT ).


       3675-EXIT.
            EXIT.


080500***************************************************************
087300 4000-SPECIAL-PROVIDER.
080500***************************************************************
091700
      *** PROCESS FOR CY2003
      *** ------------------
           IF (B-DISCHARGE-DATE >= 20030701) AND
              (B-DISCHARGE-DATE <  20040101)
091400        COMPUTE H-SS-COST ROUNDED =
091500            (PPS-FAC-COSTS * 1.95)
091400        COMPUTE H-SS-PAY-AMT ROUNDED =
091500         ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.95
           END-IF


      *** PROCESS FOR CY2004
      *** ------------------
           IF (B-DISCHARGE-DATE >= 20040101) AND
              (B-DISCHARGE-DATE <  20050101)
091400        COMPUTE H-SS-COST ROUNDED =
091500            (PPS-FAC-COSTS * 1.93)
091400        COMPUTE H-SS-PAY-AMT ROUNDED =
091500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.93
           END-IF
091600

      *** PROCESS FOR CY2005
      *** ------------------
           IF (B-DISCHARGE-DATE >= 20050101) AND
              (B-DISCHARGE-DATE <  20060101)
091400        COMPUTE H-SS-COST ROUNDED =
091500            (PPS-FAC-COSTS * 1.65)
091400        COMPUTE H-SS-PAY-AMT ROUNDED =
091500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.65
           END-IF


      *** PROCESS FOR CY2006
      *** ------------------
           IF (B-DISCHARGE-DATE >= 20060101) AND
              (B-DISCHARGE-DATE <  20070101)
091400        COMPUTE H-SS-COST ROUNDED =
091500            (PPS-FAC-COSTS * 1.36)
091400        COMPUTE H-SS-PAY-AMT ROUNDED =
091500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.36
           END-IF


      *** PROCESS FOR CY2007 AND AFTER
      *** ----------------------------
           IF (B-DISCHARGE-DATE >= 20070101)
091400        COMPUTE H-SS-COST ROUNDED =
091500            (PPS-FAC-COSTS * 1.2)
091400        COMPUTE H-SS-PAY-AMT ROUNDED =
091500          ((PPS-DRG-ADJ-PAY-AMT / PPS-AVG-LOS) * H-LOS) * 1.2
           END-IF.

087300 4000-SPECIAL-PROVIDER-EXIT.
091700      EXIT.
088800
088800
080500***************************************************************
080600*   CALCULATE THE OUTLIER THRESHOLD                           *
080700*   CALCULATE THE OUTLIER PAYMENT AMOUNT IF THE FACILTY COST  *
080900*     IS GREATER THAN THE OUTLIER THRESHOLD                   *
080900*   SET RETURN CODE TO INDICATE OUTLIER PAYMENT METHOD        *
081100***************************************************************
087300 7000-CALC-OUTLIER.
080500***************************************************************
091600
           COMPUTE PPS-OUTLIER-THRESHOLD ROUNDED =
               PPS-DRG-ADJ-PAY-AMT + H-FIXED-LOSS-AMT.

           IF PPS-FAC-COSTS > PPS-OUTLIER-THRESHOLD
              COMPUTE PPS-OUTLIER-PAY-AMT ROUNDED =
               ((PPS-FAC-COSTS - PPS-OUTLIER-THRESHOLD) * .8)
                 * PPS-BDGT-NEUT-RATE * H-BLEND-PPS.

           IF B-SPEC-PAY-IND = '1'
              MOVE 0 TO PPS-OUTLIER-PAY-AMT.

           IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 21
              MOVE 24 TO PPS-RTC.

           IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 22
              MOVE 25 TO PPS-RTC.

           IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 26
              MOVE 27 TO PPS-RTC.

           IF PPS-OUTLIER-PAY-AMT > 0 AND PPS-RTC = 00
              MOVE 01 TO PPS-RTC.

           IF (PPS-RTC = 00 OR 20 OR 21 OR 22 OR 26)
              IF PPS-REG-DAYS-USED > H-SSOT
                 MOVE 0 TO PPS-LTR-DAYS-USED
              ELSE
                 NEXT SENTENCE.

           IF (PPS-RTC = 01 OR 24 OR 25 OR 27) OR
              (PPS-COT-IND = 'Y')

              IF (B-COV-DAYS < H-LOS) OR
                 (PPS-COT-IND = 'Y' AND P-NEW-OPER-CSTCHG-RATIO NOT = 0)
                 COMPUTE PPS-CHRG-THRESHOLD ROUNDED =
                   PPS-OUTLIER-THRESHOLD / P-NEW-OPER-CSTCHG-RATIO

      *** ------------------------------------------------------- ***
      *** SET PPS-RTC TO 67 IN MAINFRAME PRICER, NOT IN PC PRICER ***
      *** (IN PC PRICER, PPS-COT-IND = 'Y', B-COV-DAYS = H-LOS)   ***
      *** ------------------------------------------------------- ***
                 IF NOT PC-PRICER
                    MOVE 67 TO PPS-RTC
                 END-IF

              ELSE
                 NEXT SENTENCE
              END-IF
           ELSE
              NEXT SENTENCE
           END-IF.


087300 7000-EXIT.
091700      EXIT.


080500***************************************************************
080600*   CALCULATE THE "FINAL" PAYMENT AMOUNT.                     *
080700*   SET RTC FOR SPECIFIED BLEND YEAR INDICATOR.               *
081100***************************************************************
087300 8000-BLEND.
081100***************************************************************

           COMPUTE H-LOS-RATIO ROUNDED = H-LOS / PPS-AVG-LOS.

           IF H-LOS-RATIO > 1
              COMPUTE H-LOS-RATIO = ((H-LOS-RATIO - 1) * .8) + 1.

           COMPUTE PPS-DRG-ADJ-PAY-AMT ROUNDED =
                 (PPS-DRG-ADJ-PAY-AMT * PPS-BDGT-NEUT-RATE)
                   * H-BLEND-PPS.

           COMPUTE PPS-NEW-FAC-SPEC-RATE ROUNDED =
                  (P-NEW-FAC-SPEC-RATE * PPS-BDGT-NEUT-RATE)
                    * H-BLEND-FAC * H-LOS-RATIO.

           COMPUTE PPS-FINAL-PAY-AMT =
                PPS-DRG-ADJ-PAY-AMT + PPS-OUTLIER-PAY-AMT
                    + PPS-NEW-FAC-SPEC-RATE.


      *----------------------------------------------------------*
      * CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/O OUTLIER *
      *----------------------------------------------------------*
           IF (PPS-RTC = 20 OR 21 OR 22 OR 26) AND (H-BLEND-RTC > 0)
                COMPUTE PPS-RTC = H-BLEND-RTC + 2

      *----------------------------------------------------------*
      * CALCULATE RETURN CODE FOR BLENDED SHORT STAY W/ OUTLIER  *
      *----------------------------------------------------------*
           ELSE
              IF (PPS-RTC = 24 OR 25 OR 27) AND (H-BLEND-RTC > 0)
                 COMPUTE PPS-RTC = H-BLEND-RTC + 3

      *----------------------------------------------------------*
      * CALCULATE RETURN CODE FOR ALL OTHER BILLS                *
      *----------------------------------------------------------*
              ELSE
                 ADD H-BLEND-RTC TO PPS-RTC

              END-IF
           END-IF.

087300 8000-EXIT.
091700      EXIT.
091800
091800
080500***************************************************************
       9000-MOVE-RESULTS.
080500***************************************************************

056600     IF PPS-RTC < 50
056700        MOVE H-LOS TO PPS-LOS
058300        MOVE CAL-VERSION TO PPS-CALC-VERS-CD
058400     ELSE
062200       INITIALIZE PPS-DATA
062300       INITIALIZE PPS-OTHER-DATA

      *** ----------------------------------- ***
      *** ADDED FOR JULY 2006 RELEASE (V07.1) ***
      *** ----------------------------------- ***
062300       INITIALIZE PPS-CBSA
062300       INITIALIZE HOLD-PPS-COMPONENTS

061200       MOVE CAL-VERSION TO PPS-CALC-VERS-CD
           END-IF.


      *** *************************************************** ***
      *** FOR TESTING - DISPLAY PPS VALUES FOR SELECTED BILLS ***
      *** *************************************************** ***

      *    IF (B-PROVIDER-NO = '222043')
      *
      *    IF (B-PROVIDER-NO = '080001' OR
      *                        '080002' OR
      *                        '080003' OR
      *                        '080004' OR
      *                        '080005' OR
      *                        '080006' OR
      *                        '080007' OR
      *                        '080008' OR
      *                        '080009' OR
      *                        '401080' OR
      *                        '401180'  )
      *
      *     DISPLAY '---------------------------------------------'
      *     DISPLAY 'VALUES FOR PROVIDER '      B-PROVIDER-NO
      *     DISPLAY 'PPS-RTC '                  PPS-RTC
      *     DISPLAY 'PPS-FINAL-PAY-AMT '        PPS-FINAL-PAY-AMT
      *     DISPLAY 'B-DISCHARGE-DATE '         B-DISCHARGE-DATE
      *     DISPLAY 'B-COV-CHARGES '            B-COV-CHARGES
      *     DISPLAY 'PPS-OUTLIER-THRESHOLD '    PPS-OUTLIER-THRESHOLD
      *     DISPLAY 'PPS-FED-PAY-AMT '          PPS-FED-PAY-AMT
      *     DISPLAY 'PPS-CBSA '                 PPS-CBSA
      *     DISPLAY 'PPS-WAGE-INDEX '           PPS-WAGE-INDEX
      *     DISPLAY 'W-IPPS-WAGE-INDEX '        W-IPPS-WAGE-INDEX
      *     DISPLAY 'W-IPPS-PR-WAGE-INDEX '     W-IPPS-PR-WAGE-INDEX
      *     DISPLAY 'PPS-OUTLIER-PAY-AMT '      PPS-OUTLIER-PAY-AMT
      *     DISPLAY 'B-DRG-CODE '               B-DRG-CODE
      *     DISPLAY 'PPS-AVG-LOS '              PPS-AVG-LOS
      *     DISPLAY 'H-SSOT '                   H-SSOT
      *     DISPLAY 'PPS-RELATIVE-WGT '         PPS-RELATIVE-WGT
      *     DISPLAY 'PPS-IPTHRESH '             PPS-IPTHRESH
      *     DISPLAY 'PPS-DRG-ADJ-PAY-AMT '      PPS-DRG-ADJ-PAY-AMT
      *     DISPLAY 'H-LOS '                    H-LOS
      *     DISPLAY 'H-REG-DAYS '               H-REG-DAYS
      *     DISPLAY 'H-TOTAL-DAYS '             H-TOTAL-DAYS
      *     DISPLAY 'H-SSOT '                   H-SSOT
      *     DISPLAY 'H-BLEND-RTC '              H-BLEND-RTC
      *     DISPLAY 'H-BLEND-FAC '              H-BLEND-FAC
      *     DISPLAY 'H-BLEND-PPS '              H-BLEND-PPS
      *     DISPLAY 'H-SS-PAY-AMT '             H-SS-PAY-AMT
      *     DISPLAY 'H-SS-COST '                H-SS-COST
      *     DISPLAY 'H-LABOR-PORTION '          H-LABOR-PORTION
      *     DISPLAY 'H-NONLABOR-PORTION '       H-NONLABOR-PORTION
      *     DISPLAY 'H-FIXED-LOSS-AMT '         H-FIXED-LOSS-AMT
      *     DISPLAY 'H-NEW-FAC-SPEC-RATE '      H-NEW-FAC-SPEC-RATE
      *     DISPLAY 'H-LOS-RATIO '              H-LOS-RATIO
      *     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
      *     DISPLAY 'H-OPER-IME-TEACH '         H-OPER-IME-TEACH
      *     DISPLAY 'H-CAPI-IME-TEACH '         H-CAPI-IME-TEACH
      *     DISPLAY 'H-LTCH-BLEND-PCT '         H-LTCH-BLEND-PCT
      *     DISPLAY 'H-IPPS-BLEND-PCT '         H-IPPS-BLEND-PCT
      *     DISPLAY 'H-LTCH-BLEND-AMT '         H-LTCH-BLEND-AMT
      *     DISPLAY 'H-IPPS-BLEND-AMT '         H-IPPS-BLEND-AMT
      *     DISPLAY 'H-INTERN-RATIO '           H-INTERN-RATIO
      *     DISPLAY 'H-CAPI-IME-RATIO '         H-CAPI-IME-RATIO
      *     DISPLAY 'H-BED-SIZE '               H-BED-SIZE
      *     DISPLAY 'H-OPER-DSH-PCT '           H-OPER-DSH-PCT
      *     DISPLAY 'H-SSI-RATIO '              H-SSI-RATIO
      *     DISPLAY 'H-MEDICAID-RATIO '         H-MEDICAID-RATIO
      *     DISPLAY 'H-OPER-DSH '               H-OPER-DSH
      *     DISPLAY 'H-CAPI-DSH '               H-CAPI-DSH
      *     DISPLAY 'H-GEO-CLASS '              H-GEO-CLASS
      *     DISPLAY 'H-URBAN-IND '              H-URBAN-IND
      *     DISPLAY 'H-STAND-AMT-OPER-PMT '     H-STAND-AMT-OPER-PMT
      *     DISPLAY 'H-PR-STAND-AMT-OPER-PMT '  H-PR-STAND-AMT-OPER-PMT
      *     DISPLAY 'H-CAPI-PMT '               H-CAPI-PMT
      *     DISPLAY 'H-PR-CAPI-PMT '            H-PR-CAPI-PMT
      *     DISPLAY 'H-CAPI-GAF '               H-CAPI-GAF
      *     DISPLAY 'H-PR-CAPI-GAF '            H-PR-CAPI-GAF
      *     DISPLAY 'H-LRGURB-ADD-ON '          H-LRGURB-ADD-ON
      *     DISPLAY 'H-IPPS-PAY-AMT '           H-IPPS-PAY-AMT
      *     DISPLAY 'H-IPPS-PR-PAY-AMT '        H-IPPS-PR-PAY-AMT
      *     DISPLAY 'H-IPPS-PER-DIEM '          H-IPPS-PER-DIEM
      *     DISPLAY 'H-IPPS-PR-PER-DIEM '       H-IPPS-PR-PER-DIEM
      *     DISPLAY 'H-SS-BLENDED-PMT '         H-SS-BLENDED-PMT
      *     DISPLAY 'H-OPER-COLA '              H-OPER-COLA
      *     DISPLAY 'H-CAPI-COLA '              H-CAPI-COLA
      *     DISPLAY 'H-IPPS-NAT-LABOR-SHR '     H-IPPS-NAT-LABOR-SHR
      *     DISPLAY 'H-IPPS-NAT-NONLABOR-SHR '  H-IPPS-NAT-NONLABOR-SHR
      *     DISPLAY 'H-IPPS-PR-LABOR-SHR '      H-IPPS-PR-LABOR-SHR
      *     DISPLAY 'H-IPPS-PR-NONLABOR-SHR '   H-IPPS-PR-NONLABOR-SHR
      *     DISPLAY 'H-IPPS-DRG-WGT '           H-IPPS-DRG-WGT
      *     DISPLAY 'H-IPPS-DRG-ALOS '          H-IPPS-DRG-ALOS
      *     DISPLAY 'H-IPPS-DAYS-CUTOFF '       H-IPPS-DAYS-CUTOFF
      *     DISPLAY 'H-IPPS-ARITH-ALOS '        H-IPPS-ARITH-ALOS
      *     DISPLAY 'H-IPPS-CAPI-STD-FED-RATE ' H-IPPS-CAPI-STD-FED-RATE
      *     DISPLAY 'H-IPPS-CAPI-STD-PR-RATE '  H-IPPS-CAPI-STD-PR-RATE
      *     DISPLAY 'H-NAT-IPPS-PMT-PCT '       H-NAT-IPPS-PMT-PCT
      *     DISPLAY 'H-PR-IPPS-PMT-PCT '        H-PR-IPPS-PMT-PCT
      *     DISPLAY 'H-PPS-DRG-UNADJ-PAY-AMT '  H-PPS-DRG-UNADJ-PAY-AMT
      *     DISPLAY 'H-SS-COST-IND '            H-SS-COST-IND
      *     DISPLAY 'H-SS-PERDIEM-IND '         H-SS-PERDIEM-IND
      *     DISPLAY 'H-SS-BLEND-IND '           H-SS-BLEND-IND
      *     DISPLAY 'H-SS-IPPSCOMP-IND '        H-SS-IPPSCOMP-IND
      *
      *    END-IF.
097000
097100 9000-EXIT.
097100      EXIT.
061700
097300******        L A S T   S O U R C E   S T A T E M E N T   *****
