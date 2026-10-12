000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL062.
000300*AUTHORS.    CMS.
000400*       EFFECTIVE JANUARY 1, 2006
000500******************************************************************
000600* 4/06/05 - ALLOW PROVIDER TYPE '05' FOR PEDIATRIC HOSP          *
000700*         - TO BE EFFECTIVE WITH THE NEXT RELEASE                *
000800*         - CHANGED IN 0100-INITIAL-ROUTINE WITH PROVIDER        *
000900*           TYPE '40'                                            *
001000* 1/01/06 - NEW CBSA TABLE FOR CY2006                            *
001100*         - UPDATE RATES WITH 1.6% INCREASE                      *
001200* 1/18/07 - THIS PROGRAM WAS ENHANCED IN ORDER TO VERIFY MORE    *
001300*           INFORMATION (VIA THE MASTER DRIVER).  VERY CLOSE     *
001400*           ATTENTION HAS BEEN PAID TO ENSURE THAT ALL VARIABLES *
001500*           THAT CHANGE FROM YEAR TO YEAR CONTINUE TO HAVE THE   *
001600*           SAME VALUES AS IN THE ORIGINAL VERSION.  NO CHANGES  *
001700*           WERE MADE IN THE CORE LOGIC OF THE PROCEDURE DIVISION*
001800*           WHERE THE ACTUAL CALCULATIONS OCCUR.  THOROUGH       *
001900*           TESTING USING THE ORIGINAL SET OF TEST CASES WAS MADE*
002000*           AND THERE ARE ABSOLUTELY NO DIFFERENCES IN CALCULATED*
002100*           AMOUNTS.  THE ORIGINAL CODE THAT WAS SENT OUT TO THE *
002200*           FISCAL INTERMEDIARIES IN 2006 REMAINS INTACT UNDER   *
002300*           THE MU00 ACCOUNT.                                    *
002400* 1/18/07 - MSA-CBSA blend percent set at 75% MSA 25% CBSA       *
002500*         - Additional variables were created in order to make   *
002600*           changing values easier (in WORKING STORAGE rather    *
002700*           than in the PROCEDURE DIVISION)                      *
002800*         - This program now reflects enhancements made so that  *
002900*           testing of the code does not require commenting      *
003000*           in/out lines of code.  In addition calculated        *
003100*           variables are now passed back when TEST cases are    *
003200*           encountered in order for the master driver to print  *
003300*           more information about what went on in this program. *
003400******************************************************************
003500 DATE-COMPILED.
003600 ENVIRONMENT DIVISION.
003700 CONFIGURATION SECTION.
003800 SOURCE-COMPUTER.            IBM-Z990.
003900 OBJECT-COMPUTER.            ITTY-BITTY-MACHINE-CORPORATION.
004000 INPUT-OUTPUT  SECTION.
004100 FILE-CONTROL.
004200
004300 DATA DIVISION.
004400 FILE SECTION.
004500/
004600 WORKING-STORAGE SECTION.
004700 01  W-STORAGE-REF                  PIC X(46)  VALUE
004800     'ESCAL062      - W O R K I N G   S T O R A G E'.
004900
005000 01  CAL-VERSION                    PIC X(05)  VALUE 'C06.2'.
005100
005200 01  DISPLAY-LINE-MEASUREMENT.
005300     05  FILLER                     PIC X(50) VALUE
005400         '....:...10....:...20....:...30....:...40....:...50'.
005500     05  FILLER                     PIC X(50) VALUE
005600         '....:...60....:...70....:...80....:...90....:..100'.
005700     05  FILLER                     PIC X(20) VALUE
005800         '....:..110....:..120'.
005900
006000 01  PRINT-LINE-MEASUREMENT.
006100     05  FILLER                     PIC X(51) VALUE
006200         'X....:...10....:...20....:...30....:...40....:...50'.
006300     05  FILLER                     PIC X(50) VALUE
006400         '....:...60....:...70....:...80....:...90....:..100'.
006500     05  FILLER                     PIC X(32) VALUE
006600         '....:..110....:..120....:..130..'.
006700
006800 01  HOLD-PPS-COMPONENTS.
006900     05  H-PYMT-AMT                 PIC 9(07)V9(02).
007000     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(07)V9(02).
007100     05  H-2006-WAGE-ADJ-PYMT       PIC 9(07)V9(02).
007200     05  H-MSA-COMPOSITE-PYMT       PIC 9(07)V9(02).
007300     05  H-WAGE-ADJ-PYMT-OLD        PIC 9(07)V9(02).
007400     05  H-WAGE-ADJ-PYMT-NEW        PIC 9(07)V9(02).
007500     05  H-WAGE-ADJ                 PIC 9(02)V9(04).
007600     05  H-PYMT-RATE                PIC 9(04)V9(02).
007700     05  H-FIXED-LOSS-AMT           PIC 9(07)V9(02).
007800     05  H-ESRD-FAC-RATE            PIC 9(07)V9(02).
007900     05  H-PATIENT-AGE              PIC 9(03).
008000     05  H-AGE-FACTOR               PIC 9(01)V9(03).
008100     05  H-BSA-FACTOR               PIC 9(01)V9(04).
008200     05  H-BMI-FACTOR               PIC 9(01)V9(04).
008300     05  H-BSA                      PIC 9(03)V9(04).
008400     05  H-BMI                      PIC 9(03)V9(04).
008500     05  H-DRUG-ADDON               PIC 9(01)V9(04).
008600
008700*   THE FOLLOWING THREE VARIABLES WILL CHANGE FROM YEAR TO YEAR
008800 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1450.
008900 01  HOSP-BASED-PMT-RATE            PIC 9(04)V9(02) VALUE 134.53.
009000 01  INDP-ESRD-FAC-PMT-RATE         PIC 9(04)V9(02) VALUE 130.40.
009100
009200*   THE NEXT TWO PERCENTAGES MUST ADD UP TO 1 (I.E. 100%)
009300*   THEY WILL CONTINUE TO CHANGE UNTIL 2009 (AND THEN BE FIXED)
009400 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.75.
009500 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 0.25.
009600
009700
009800*  CONSTANTS AREA
009900*   THE NEXT TWO PERCENTAGES MUST ADD UP TO 1 (I.E. 100%)
010000 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
010100 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
010200
010300 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
010400 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
010500 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
010600                                                       0.428571.
010700 01  MSA-WAGE-FACTOR-2006           PIC 9(01)V9(03) VALUE 1.016.
010800
010900*  THE FOLLOWING NUMBER THAT IS LOADED INTO THE PAYMENT EQUATION
011000*  IS MEANT TO BUDGET NEUTRALIZE CHANGES IN THE CASE MIX INDEX
011100*  AND   --DOES NOT CHANGE--
011200 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
011300
011400
011500******************************************************************
011600*                                                                *
011700*   ******** POSSIBLE RETURN CODES FROM THIS PROGRAM ********    *
011800*                                                                *
011900*    ****  PPS-RTC 00-49 = CLAIM PAYMENT INFORMATION CODES       *
012000*                                                                *
012100*            00 = ESRD PPS PAYMENT CALCULATED                    *
012200*                                                                *
012300*    ****  PPS-RTC 50-99 = WHY THE CLAIM WAS NOT PAID            *
012400*                                                                *
012500*            52 = PROVIDER TYPE NOT = '40' OR '41' OR '05'       *
012600*            53 = SPECIAL PAYMENT INDICATOR NOT = '1' OR BLANK   *
012700*            54 = DATE OF BIRTH  NOT NUMERIC OR = ZERO           *
012800*            55 = PATIENT WEIGHT NOT NUMERIC OR = ZERO           *
012900*            56 = PATIENT HEIGHT NOT NUMERIC OR = ZERO           *
013000*            57 = REVENUE CENTER CODE NOT IN RANGE               *
013100*            58 = CONDITION CODE NOT = '73' OR '74' OR BLANK     *
013200*            71 = EXCEEDS MAXIMUM HEIGHT ALLOWANCE (300)         *
013300*            72 = EXCEEDS MAXIMUM WEIGHT ALLOWANCE (500)         *
013400******************************************************************
013500/
013600 LINKAGE SECTION.
013700 COPY BILLCPY.
013800*COPY "BILLCPY.CPY".
013900/
014000 COPY WAGECPY.
014100*COPY "WAGECPY.CPY".
014200/
014300 PROCEDURE DIVISION  USING BILL-NEW-DATA
014400                           PPS-DATA-ALL
014500                           WAGE-NEW-RATE-RECORD
014600                           COM-CBSA-WAGE-RECORD.
014700
014800******************************************************************
014900* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
015000* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
015100* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
015200* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
015300* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
015400* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
015500* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
015600* PROCESSING (DICP).                                             *
015700*                                                                *
015800*                                                                *
015900*    PROCESSING:                                                 *
016000*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
016100*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
016200*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
016300*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
016400*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
016500*           GOBACK.                                              *
016600*        D. ASSEMBLE PRICING COMPONENTS.                         *
016700*        E. CALCULATE THE PRICE.                                 *
016800******************************************************************
016900
017000 0000-MAINLINE-CONTROL.
017100
017200     PERFORM 0100-INITIAL-ROUTINE.
017300
017400     IF PPS-RTC = 00
017500        PERFORM 1000-EDIT-THE-BILL-INFO
017600     END-IF.
017700
017800     IF PPS-RTC = 00
017900        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
018000        PERFORM 3000-CALC-PAYMENT
018100     END-IF.
018200
018300     PERFORM 9000-MOVE-RESULTS.
018400
018500     GOBACK.
018600/
018700 0100-INITIAL-ROUTINE.
018800
018900******************************************************************
019000**   NEW PAYMENT RATES FOR NEW LEGISLATION                      **
019100******************************************************************
019200     INITIALIZE PPS-DATA-ALL.
019300     INITIALIZE BILL-DATA-TEST.
019400     INITIALIZE HOLD-PPS-COMPONENTS.
019500     MOVE ZEROS                        TO PPS-RTC.
019600     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
019700
019800* PROVIDER TYPE '40' AND '05' ARE HOSPITAL BASED ESRD FACILITIES
019900     IF P-PROV-TYPE = '40' OR '05'
020000        MOVE NAT-LABOR-PCT             TO PPS-NAT-LABOR-PCT
020100        MOVE NAT-NONLABOR-PCT          TO PPS-NAT-NONLABOR-PCT
020200        MOVE HOSP-BASED-PMT-RATE       TO H-PYMT-RATE
020300        COMPUTE H-2006-WAGE-ADJ-PYMT ROUNDED =
020400                W-NEW-RATE1-RECORD    *  MSA-WAGE-FACTOR-2006
020500        MOVE H-2006-WAGE-ADJ-PYMT      TO H-WAGE-ADJ-PYMT-OLD
020600        MOVE W-NEW-RATE1-RECORD        TO MSA-WAGE-AMT
020700        MOVE COM-CBSA-W-INDEX          TO H-WAGE-ADJ
020800     ELSE
020900* PROVIDER TYPE '41' IS AN INDEPENDENT ESRD FACILITY
021000        IF P-PROV-TYPE = '41'
021100           MOVE NAT-LABOR-PCT          TO PPS-NAT-LABOR-PCT
021200           MOVE NAT-NONLABOR-PCT       TO PPS-NAT-NONLABOR-PCT
021300           MOVE INDP-ESRD-FAC-PMT-RATE TO H-PYMT-RATE
021400           COMPUTE H-2006-WAGE-ADJ-PYMT ROUNDED =
021500                   W-NEW-RATE2-RECORD    *  MSA-WAGE-FACTOR-2006
021600           MOVE H-2006-WAGE-ADJ-PYMT   TO H-WAGE-ADJ-PYMT-OLD
021700           MOVE W-NEW-RATE2-RECORD     TO MSA-WAGE-AMT
021800           MOVE COM-CBSA-W-INDEX       TO H-WAGE-ADJ
021900        ELSE
022000           MOVE 52                     TO PPS-RTC
022100           MOVE ZERO                   TO PPS-WAGE-ADJ-RATE
022200        END-IF
022300     END-IF.
022400
022500     MOVE H-WAGE-ADJ-PYMT-OLD          TO MSA-ADJ-YEAR-AMT.
022600
022700******************************************************************
022800**  NEW DRUG ADD-ON FOR NEW LEGISLATION                         **
022900******************************************************************
023000
023100     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
023200     MOVE DRUG-ADDON                   TO H-DRUG-ADDON.
023300/
023400******************************************************************
023500***  BILL DATA EDITS IF ANY FAIL SET PPS-RTC                   ***
023600***  AND DO NOT ATTEMPT TO PRICE.                              ***
023700******************************************************************
023800 1000-EDIT-THE-BILL-INFO.
023900
024000     IF PPS-RTC = 00
024100        IF P-SPEC-PYMT-IND NOT = '1' AND ' '
024200           MOVE 53                     TO PPS-RTC
024300        END-IF
024400     END-IF.
024500
024600     IF PPS-RTC = 00
024700        IF (B-DOB-DATE = ZERO) OR (B-DOB-DATE NOT NUMERIC)
024800           MOVE 54                     TO PPS-RTC
024900        END-IF
025000     END-IF.
025100
025200     IF PPS-RTC = 00
025300        IF (B-PATIENT-WGT = 0) OR (B-PATIENT-WGT NOT NUMERIC)
025400           MOVE 55                     TO PPS-RTC
025500        END-IF
025600     END-IF.
025700
025800     IF PPS-RTC = 00
025900        IF (B-PATIENT-HGT = 0) OR (B-PATIENT-HGT NOT NUMERIC)
026000           MOVE 56                     TO PPS-RTC
026100        END-IF
026200     END-IF.
026300
026400     IF PPS-RTC = 00
026500        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
026600                                OR '0880' OR '0881'
026700           NEXT SENTENCE
026800        ELSE
026900           MOVE 57                     TO PPS-RTC
027000        END-IF
027100     END-IF.
027200
027300     IF PPS-RTC = 00
027400        IF B-COND-CODE NOT = '73' AND '74' AND '  '
027500           MOVE 58                     TO PPS-RTC
027600        END-IF
027700     END-IF.
027800
027900     IF PPS-RTC = 00
028000        IF B-PATIENT-HGT > 300.00
028100           MOVE 71                     TO PPS-RTC
028200        END-IF
028300     END-IF.
028400
028500     IF PPS-RTC = 00
028600        IF B-PATIENT-WGT > 500.00
028700           MOVE 72                     TO PPS-RTC
028800        END-IF
028900     END-IF.
029000
029100     IF PPS-RTC = 00
029200        PERFORM 1200-CALC-AGE
029300     END-IF.
029400
029500
029600 1200-CALC-AGE.
029700******************************************************************
029800***  CALCULATE PATIENT AGE                                     ***
029900******************************************************************
030000
030100     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY.
030200
030300     IF B-DOB-MM > B-THRU-MM
030400        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
030500     END-IF.
030600
030700******************************************************************
030800***  SET AGE ADJUSTMENT FACTOR                                 ***
030900******************************************************************
031000
031100     IF H-PATIENT-AGE < 18
031200        MOVE 1.620                     TO H-AGE-FACTOR
031300     ELSE
031400        IF H-PATIENT-AGE > 17 AND H-PATIENT-AGE < 45
031500           MOVE 1.223                  TO H-AGE-FACTOR
031600        ELSE
031700           IF H-PATIENT-AGE > 44 AND H-PATIENT-AGE < 60
031800              MOVE 1.055               TO H-AGE-FACTOR
031900           ELSE
032000              IF H-PATIENT-AGE > 59 AND H-PATIENT-AGE < 70
032100                 MOVE 1.000            TO H-AGE-FACTOR
032200              ELSE
032300                 IF H-PATIENT-AGE > 69 AND H-PATIENT-AGE < 80
032400                    MOVE 1.094         TO H-AGE-FACTOR
032500                 ELSE
032600                    IF H-PATIENT-AGE > 79
032700                       MOVE 1.174      TO H-AGE-FACTOR
032800                    END-IF
032900                 END-IF
033000              END-IF
033100           END-IF
033200        END-IF
033300     END-IF.
033400
033500/
033600 2000-ASSEMBLE-PPS-VARIABLES.
033700******************************************************************
033800***  CALCULATE PPS PRICING VARIABLES:  BSA FACTOR & BMI FACTOR ***
033900******************************************************************
034000
034100     COMPUTE H-BSA ROUNDED = (.007184 *
034200         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
034300
034400     COMPUTE H-BMI ROUNDED = (B-PATIENT-WGT /
034500         (B-PATIENT-HGT ** 2)) * 10000.
034600
034700     IF H-PATIENT-AGE > 17
034800        COMPUTE H-BSA-FACTOR ROUNDED =
034900             1.037 ** ((H-BSA - 1.84) / .1)
035000     ELSE
035100        MOVE 1.000                     TO H-BSA-FACTOR
035200     END-IF.
035300
035400     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)
035500        MOVE 1.112                     TO H-BMI-FACTOR
035600     ELSE
035700        MOVE 1.000                     TO H-BMI-FACTOR
035800     END-IF.
035900
036000/
036100******************************************************************
036200***  IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)            ***
036300***      CALCULATE THE STANDARD PAYMENT AMOUNT.                ***
036400***    - BLEND 75% OLD RATE (MSA) WITH 25% NEW RATE (CBSA).    ***
036500******************************************************************
036600 3000-CALC-PAYMENT.
036700
036800* BEGINNING 01/01/2006 THE BLEND RATE WILL BE 75% MSA 25% CBSA
036900     COMPUTE H-WAGE-ADJ-PYMT-OLD ROUNDED =
037000            (H-WAGE-ADJ-PYMT-OLD * MSA-BLEND-PCT).
037100
037200     COMPUTE H-WAGE-ADJ-PYMT-NEW ROUNDED =
037300         (((H-PYMT-RATE * PPS-NAT-LABOR-PCT) * H-WAGE-ADJ) +
037400           (H-PYMT-RATE * PPS-NAT-NONLABOR-PCT)) * CBSA-BLEND-PCT.
037500
037600     COMPUTE H-WAGE-ADJ-PYMT-AMT =
037700             H-WAGE-ADJ-PYMT-NEW + H-WAGE-ADJ-PYMT-OLD.
037800
037900     COMPUTE H-PYMT-AMT ROUNDED = H-WAGE-ADJ-PYMT-AMT *
038000          H-BMI-FACTOR * H-BSA-FACTOR * PPS-BDGT-NEUT-RATE *
038100          H-AGE-FACTOR * H-DRUG-ADDON.
038200
038300     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
038400     MOVE SPACES                       TO COND-CD-73.
038500
038600     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
038700                                                      OR '0851')
038800        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
038900        MOVE 'A'                       TO AMT-INDIC
039000        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
039100     ELSE
039200        IF (B-COND-CODE = '73') AND (B-REV-CODE = '0841')
039300           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
039400           MOVE 'A'                    TO AMT-INDIC
039500           MOVE CAPD-AMT               TO BLOOD-DOLLAR
039600        ELSE
039700           IF (B-COND-CODE = '74') AND
039800              (B-REV-CODE = '0841' OR '0851')
039900              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
040000                                           CAPD-OR-CCPD-FACTOR
040100              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
040200           ELSE
040300              MOVE 'A'                 TO AMT-INDIC
040400              MOVE ZERO                TO BLOOD-DOLLAR
040500           END-IF
040600        END-IF
040700     END-IF.
040800
040900     MOVE H-PYMT-AMT                   TO PPS-FINAL-PAY-AMT.
041000     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
041100/
041200 9000-MOVE-RESULTS.
041300
041400     IF PPS-RTC < 50  THEN
041500        MOVE B-COND-CODE               TO PPS-COND-CODE
041600        MOVE B-REV-CODE                TO PPS-REV-CODE
041700        MOVE P-GEO-MSA                 TO PPS-MSA
041800        MOVE P-GEO-CBSA                TO PPS-CBSA
041900        MOVE H-AGE-FACTOR              TO PPS-AGE-FACTOR
042000        MOVE H-BSA-FACTOR              TO PPS-BSA-FACTOR
042100        MOVE H-BMI-FACTOR              TO PPS-BMI-FACTOR
042200        IF OLD-TEST-CASE  THEN
042300           MOVE H-DRUG-ADDON           TO DRUG-ADD-ON-RETURN
042400           MOVE H-WAGE-ADJ-PYMT-OLD    TO MSA-WAGE-ADJ
042500           MOVE H-WAGE-ADJ-PYMT-NEW    TO CBSA-WAGE-ADJ
042600           MOVE CBSA-BLEND-PCT         TO CBSA-PCT
042700           MOVE MSA-BLEND-PCT          TO MSA-PCT
042800           MOVE H-PYMT-RATE            TO CBSA-WAGE-PMT-RATE
042900           MOVE H-PATIENT-AGE          TO AGE-RETURN
043000           MOVE H-WAGE-ADJ             TO CBSA-WAGE-INDEX
043100           MOVE NAT-LABOR-PCT          TO LABOR-PCT
043200        END-IF
043300     ELSE
043400        IF OLD-TEST-CASE  THEN
043500           INITIALIZE PPS-COND-CODE
043600           INITIALIZE PPS-REV-CODE
043700           INITIALIZE PPS-MSA
043800           INITIALIZE PPS-CBSA
043900           INITIALIZE PPS-AGE-FACTOR
044000           INITIALIZE PPS-BSA-FACTOR
044100           INITIALIZE PPS-BMI-FACTOR
044200           INITIALIZE DRUG-ADD-ON-RETURN
044300           INITIALIZE MSA-WAGE-ADJ
044400           INITIALIZE CBSA-WAGE-ADJ
044500           INITIALIZE CBSA-PCT
044600           INITIALIZE MSA-PCT
044700           INITIALIZE CASE-MIX-FCTR-ADJ-RATE
044800           INITIALIZE CBSA-WAGE-PMT-RATE
044900           INITIALIZE HEMO-CCPD-CAPD
045000           INITIALIZE AGE-RETURN
045100        END-IF
045200     END-IF.
045300
045400******        L A S T   S O U R C E   S T A T E M E N T      *****
