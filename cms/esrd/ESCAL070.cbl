000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL070.
000300*AUTHORS.    CMS.
000400*       EFFECTIVE JANUARY 1, 2007
000500******************************************************************
000600* 4/06/05 - ALLOW PROVIDER TYPE '05' FOR PEDIATRIC HOSP          *
000700*         - TO BE EFFECTIVE WITH THE NEXT RELEASE                *
000800*         - CHANGED IN 0100-INITIAL-ROUTINE WITH PROVIDER        *
000900*           TYPE '40'                                            *
001000* 1/01/06 - NEW CBSA TABLE FOR CY2006                            *
001100*         - UPDATE RATES WITH 1.6% INCREASE                      *
001200* 1/18/07 - THE MSA-WAGE-FACTOR-2007 WAS NOT IMPLEMENTED DURING  *
001300*           THE FIRST THREE MONTHS OF 2007                       *
001400*         - MSA-CBSA blend percent now set at 50% MSA 50% CBSA   *
001500*         - ADDITIONAL VARIABLES WERE CREATED IN ORDER TO MAKE   *
001600*           CHANGING VALUES EASIER (IN WORKING STORAGE RATHER    *
001700*           THAN IN THE PROCEDURE DIVISION)                      *
001800*         - THIS PROGRAM NOW REFLECTS ENHANCEMENTS MADE SO THAT  *
001900*           TESTING OF THE CODE DOES NOT REQUIRE COMMENTING      *
002000*           IN/OUT LINES OF CODE.  IN ADDITION CALCULATED        *
002100*           VARIABLES ARE NOW PASSED BACK WHEN TEST CASES ARE    *
002200*           ENCOUNTERED IN ORDER FOR THE MASTER DRIVER TO PRINT  *
002300*           MORE INFORMATION ABOUT WHAT WENT ON IN THIS PROGRAM. *
002400******************************************************************
002500 DATE-COMPILED.
002600 ENVIRONMENT DIVISION.
002700 CONFIGURATION SECTION.
002800 SOURCE-COMPUTER.            IBM-Z990.
002900 OBJECT-COMPUTER.            ITTY-BITTY-MACHINE-CORPORATION.
003000 INPUT-OUTPUT  SECTION.
003100 FILE-CONTROL.
003200
003300 DATA DIVISION.
003400 FILE SECTION.
003500/
003600 WORKING-STORAGE SECTION.
003700 01  W-STORAGE-REF                  PIC X(46)  VALUE
003800     'ESCAL070      - W O R K I N G   S T O R A G E'.
003900
004000 01  CAL-VERSION                    PIC X(05)  VALUE 'C07.0'.
004100
004200 01  DISPLAY-LINE-MEASUREMENT.
004300     05  FILLER                     PIC X(50) VALUE
004400         '....:...10....:...20....:...30....:...40....:...50'.
004500     05  FILLER                     PIC X(50) VALUE
004600         '....:...60....:...70....:...80....:...90....:..100'.
004700     05  FILLER                     PIC X(20) VALUE
004800         '....:..110....:..120'.
004900
005000 01  PRINT-LINE-MEASUREMENT.
005100     05  FILLER                     PIC X(51) VALUE
005200         'X....:...10....:...20....:...30....:...40....:...50'.
005300     05  FILLER                     PIC X(50) VALUE
005400         '....:...60....:...70....:...80....:...90....:..100'.
005500     05  FILLER                     PIC X(32) VALUE
005600         '....:..110....:..120....:..130..'.
005700
005800 01  HOLD-PPS-COMPONENTS.
005900     05  H-PYMT-AMT                 PIC 9(07)V9(02).
006000     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(07)V9(02).
006100     05  H-2006-WAGE-ADJ-PYMT       PIC 9(07)V9(02).
006200     05  H-MSA-COMPOSITE-PYMT       PIC 9(07)V9(02).
006300     05  H-WAGE-ADJ-PYMT-OLD        PIC 9(07)V9(02).
006400     05  H-WAGE-ADJ-PYMT-NEW        PIC 9(07)V9(02).
006500     05  H-WAGE-ADJ                 PIC 9(02)V9(04).
006600     05  H-PYMT-RATE                PIC 9(04)V9(02).
006700     05  H-FIXED-LOSS-AMT           PIC 9(07)V9(02).
006800     05  H-ESRD-FAC-RATE            PIC 9(07)V9(02).
006900     05  H-PATIENT-AGE              PIC 9(03).
007000     05  H-AGE-FACTOR               PIC 9(01)V9(03).
007100     05  H-BSA-FACTOR               PIC 9(01)V9(04).
007200     05  H-BMI-FACTOR               PIC 9(01)V9(04).
007300     05  H-BSA                      PIC 9(03)V9(04).
007400     05  H-BMI                      PIC 9(03)V9(04).
007500     05  H-DRUG-ADDON               PIC 9(01)V9(04).
007600
007700*   THE FOLLOWING THREE VARIABLES WILL CHANGE FROM YEAR TO YEAR
007800 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1510.
007900 01  HOSP-BASED-PMT-RATE            PIC 9(04)V9(02) VALUE 134.53.
008000 01  INDP-ESRD-FAC-PMT-RATE         PIC 9(04)V9(02) VALUE 130.40.
008100
008200*   THE NEXT TWO PERCENTAGES MUST ADD UP TO 1 (I.E. 100%)
008300*   THEY WILL CONTINUE TO CHANGE UNTIL 2009 (AND THEN BE FIXED)
008400 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.50.
008500 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 0.50.
008600
008700
008800*  CONSTANTS AREA
008900*   THE NEXT TWO PERCENTAGES MUST ADD UP TO 1 (I.E. 100%)
009000 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
009100 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
009200
009300 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
009400 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
009500 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
009600                                                       0.428571.
009700 01  MSA-WAGE-FACTOR-2006           PIC 9(01)V9(03) VALUE 1.016.
009800*01  MSA-WAGE-FACTOR-2007           PIC 9(01)V9(03) VALUE 1.016.
009900
010000*  THE FOLLOWING NUMBER THAT IS LOADED INTO THE PAYMENT EQUATION
010100*  IS MEANT TO BUDGET NEUTRALIZE CHANGES IN THE CASE MIX INDEX
010200*  AND   --DOES NOT CHANGE--
010300 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
010400
010500
010600******************************************************************
010700*                                                                *
010800*   ******** POSSIBLE RETURN CODES FROM THIS PROGRAM ********    *
010900*                                                                *
011000*    ****  PPS-RTC 00-49 = BILL PAYMENT INFORMATION CODES        *
011100*                                                                *
011200*            00 = ESRD PPS PAYMENT CALCULATED                    *
011300*                                                                *
011400*    ****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID             *
011500*                                                                *
011600*            52 = PROVIDER TYPE NOT = '40' OR '41' OR '05'       *
011700*            53 = SPECIAL PAYMENT INDICATOR NOT = '1' OR BLANK   *
011800*            54 = DATE OF BIRTH  NOT NUMERIC OR = ZERO           *
011900*            55 = PATIENT WEIGHT NOT NUMERIC OR = ZERO           *
012000*            56 = PATIENT HEIGHT NOT NUMERIC OR = ZERO           *
012100*            57 = REVENUE CENTER CODE NOT IN RANGE               *
012200*            58 = CONDITION CODE NOT = '73' OR '74' OR BLANK     *
012300*            71 = EXCEEDS MAXIMUM HEIGHT ALLOWANCE               *
012400*            72 = EXCEEDS MAXIMUM WEIGHT ALLOWANCE               *
012500*            73 = EXCEEDS MAXIMUM AGE                            *
012600******************************************************************
012700/
012800 LINKAGE SECTION.
012900 COPY BILLCPY.
013000*COPY "BILLCPY.CPY".
013100/
013200 COPY WAGECPY.
013300*COPY "WAGECPY.CPY".
013400/
013500 PROCEDURE DIVISION  USING BILL-NEW-DATA
013600                           PPS-DATA-ALL
013700                           WAGE-NEW-RATE-RECORD
013800                           COM-CBSA-WAGE-RECORD.
013900
014000******************************************************************
014100* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
014200* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
014300* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
014400* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
014500* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
014600* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
014700* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
014800* PROCESSING (DICP).                                             *
014900*                                                                *
015000*                                                                *
015100*    PROCESSING:                                                 *
015200*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
015300*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
015400*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
015500*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
015600*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
015700*           GOBACK.                                              *
015800*        D. ASSEMBLE PRICING COMPONENTS.                         *
015900*        E. CALCULATE THE PRICE.                                 *
016000******************************************************************
016100
016200 0000-MAINLINE-CONTROL.
016300
016400     PERFORM 0100-INITIAL-ROUTINE.
016500
016600     IF PPS-RTC = 00
016700        PERFORM 1000-EDIT-THE-BILL-INFO
016800     END-IF.
016900
017000     IF PPS-RTC = 00
017100        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
017200        PERFORM 3000-CALC-PAYMENT
017300     END-IF.
017400
017500     PERFORM 9000-MOVE-RESULTS.
017600
017700     GOBACK.
017800/
017900 0100-INITIAL-ROUTINE.
018000
018100******************************************************************
018200**   NEW PAYMENT RATES FOR NEW LEGISLATION                      **
018300******************************************************************
018400     INITIALIZE PPS-DATA-ALL.
018500     INITIALIZE BILL-DATA-TEST.
018600     INITIALIZE HOLD-PPS-COMPONENTS.
018700     MOVE ZEROS                        TO PPS-RTC.
018800     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
018900
019000* PROVIDER TYPE '40' AND '05' ARE HOSPITAL BASED ESRD FACILITIES
019100     IF P-PROV-TYPE = '40' OR '05'
019200        MOVE NAT-LABOR-PCT             TO PPS-NAT-LABOR-PCT
019300        MOVE NAT-NONLABOR-PCT          TO PPS-NAT-NONLABOR-PCT
019400        MOVE HOSP-BASED-PMT-RATE       TO H-PYMT-RATE
019500        COMPUTE H-2006-WAGE-ADJ-PYMT ROUNDED =
019600                W-NEW-RATE1-RECORD    *  MSA-WAGE-FACTOR-2006
019700        MOVE H-2006-WAGE-ADJ-PYMT      TO H-WAGE-ADJ-PYMT-OLD
019800        MOVE W-NEW-RATE1-RECORD        TO MSA-WAGE-AMT
019900        MOVE COM-CBSA-W-INDEX          TO H-WAGE-ADJ
020000     ELSE
020100* PROVIDER TYPE '41' IS AN INDEPENDENT ESRD FACILITY
020200        IF P-PROV-TYPE = '41'
020300           MOVE NAT-LABOR-PCT          TO PPS-NAT-LABOR-PCT
020400           MOVE NAT-NONLABOR-PCT       TO PPS-NAT-NONLABOR-PCT
020500           MOVE INDP-ESRD-FAC-PMT-RATE TO H-PYMT-RATE
020600           COMPUTE H-2006-WAGE-ADJ-PYMT ROUNDED =
020700                   W-NEW-RATE2-RECORD    *  MSA-WAGE-FACTOR-2006
020800           MOVE H-2006-WAGE-ADJ-PYMT   TO H-WAGE-ADJ-PYMT-OLD
020900           MOVE W-NEW-RATE2-RECORD     TO MSA-WAGE-AMT
021000           MOVE COM-CBSA-W-INDEX       TO H-WAGE-ADJ
021100        ELSE
021200           MOVE 52                     TO PPS-RTC
021300           MOVE ZERO                   TO PPS-WAGE-ADJ-RATE
021400        END-IF
021500     END-IF.
021600
021700     MOVE H-WAGE-ADJ-PYMT-OLD          TO MSA-ADJ-YEAR-AMT.
021800
021900******************************************************************
022000**  NEW DRUG ADD-ON FOR NEW LEGISLATION                         **
022100******************************************************************
022200
022300     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
022400     MOVE DRUG-ADDON                   TO H-DRUG-ADDON.
022500/
022600******************************************************************
022700***  BILL DATA EDITS IF ANY FAIL SET PPS-RTC                   ***
022800***  AND DO NOT ATTEMPT TO PRICE.                              ***
022900******************************************************************
023000 1000-EDIT-THE-BILL-INFO.
023100
023200     IF PPS-RTC = 00
023300        IF P-SPEC-PYMT-IND NOT = '1' AND ' '
023400           MOVE 53                     TO PPS-RTC
023500        END-IF
023600     END-IF.
023700
023800     IF PPS-RTC = 00
023900        IF (B-DOB-DATE = ZERO) OR (B-DOB-DATE NOT NUMERIC)
024000           MOVE 54                     TO PPS-RTC
024100        END-IF
024200     END-IF.
024300
024400     IF PPS-RTC = 00
024500        IF (B-PATIENT-WGT = 0) OR (B-PATIENT-WGT NOT NUMERIC)
024600           MOVE 55                     TO PPS-RTC
024700        END-IF
024800     END-IF.
024900
025000     IF PPS-RTC = 00
025100        IF (B-PATIENT-HGT = 0) OR (B-PATIENT-HGT NOT NUMERIC)
025200           MOVE 56                     TO PPS-RTC
025300        END-IF
025400     END-IF.
025500
025600     IF PPS-RTC = 00
025700        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
025800                                OR '0880' OR '0881'
025900           NEXT SENTENCE
026000        ELSE
026100           MOVE 57                     TO PPS-RTC
026200        END-IF
026300     END-IF.
026400
026500     IF PPS-RTC = 00
026600        IF B-COND-CODE NOT = '73' AND '74' AND '  '
026700           MOVE 58                     TO PPS-RTC
026800        END-IF
026900     END-IF.
027000
027100     IF PPS-RTC = 00
027200        IF B-PATIENT-HGT > 300.00
027300           MOVE 71                     TO PPS-RTC
027400        END-IF
027500     END-IF.
027600
027700     IF PPS-RTC = 00
027800        IF B-PATIENT-WGT > 500.00
027900           MOVE 72                     TO PPS-RTC
028000        END-IF
028100     END-IF.
028200
028300     IF PPS-RTC = 00
028400        PERFORM 1200-CALC-AGE
028500     END-IF.
028600
028700
028800 1200-CALC-AGE.
028900******************************************************************
029000***  CALCULATE PATIENT AGE                                     ***
029100******************************************************************
029200
029300     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY.
029400
029500     IF B-DOB-MM > B-THRU-MM
029600        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
029700     END-IF.
029800
029900******************************************************************
030000***  SET AGE ADJUSTMENT FACTOR                                 ***
030100******************************************************************
030200
030300     IF H-PATIENT-AGE < 18
030400        MOVE 1.620                     TO H-AGE-FACTOR
030500     ELSE
030600        IF H-PATIENT-AGE > 17 AND H-PATIENT-AGE < 45
030700           MOVE 1.223                  TO H-AGE-FACTOR
030800        ELSE
030900           IF H-PATIENT-AGE > 44 AND H-PATIENT-AGE < 60
031000              MOVE 1.055               TO H-AGE-FACTOR
031100           ELSE
031200              IF H-PATIENT-AGE > 59 AND H-PATIENT-AGE < 70
031300                 MOVE 1.000            TO H-AGE-FACTOR
031400              ELSE
031500                 IF H-PATIENT-AGE > 69 AND H-PATIENT-AGE < 80
031600                    MOVE 1.094         TO H-AGE-FACTOR
031700                 ELSE
031800                    IF H-PATIENT-AGE > 79
031900                       MOVE 1.174      TO H-AGE-FACTOR
032000                    END-IF
032100                 END-IF
032200              END-IF
032300           END-IF
032400        END-IF
032500     END-IF.
032600
032700/
032800 2000-ASSEMBLE-PPS-VARIABLES.
032900******************************************************************
033000***  CALCULATE PPS PRICING VARIABLES                           ***
033100******************************************************************
033200
033300     COMPUTE H-BSA ROUNDED = (.007184 *
033400         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
033500
033600     COMPUTE H-BMI ROUNDED = (B-PATIENT-WGT /
033700         (B-PATIENT-HGT ** 2)) * 10000.
033800
033900     IF H-PATIENT-AGE > 17
034000        COMPUTE H-BSA-FACTOR ROUNDED =
034100             1.037 ** ((H-BSA - 1.84) / .1)
034200     ELSE
034300        MOVE 1.000                     TO H-BSA-FACTOR
034400     END-IF.
034500
034600     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)
034700        MOVE 1.112                     TO H-BMI-FACTOR
034800     ELSE
034900        MOVE 1.000                     TO H-BMI-FACTOR
035000     END-IF.
035100
035200/
035300******************************************************************
035400***  IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)            ***
035500***      CALCULATE THE STANDARD PAYMENT AMOUNT.                ***
035600***    - BLEND 50% OLD RATE (MSA) WITH 50% NEW RATE (CBSA).    ***
035700******************************************************************
035800 3000-CALC-PAYMENT.
035900
036000* BEGINNING 01/01/2007 THE BLEND RATE WILL BE 50% MSA 50% CBSA
036100     COMPUTE H-WAGE-ADJ-PYMT-OLD ROUNDED =
036200            (H-WAGE-ADJ-PYMT-OLD * MSA-BLEND-PCT).
036300
036400     COMPUTE H-WAGE-ADJ-PYMT-NEW ROUNDED =
036500         (((H-PYMT-RATE * PPS-NAT-LABOR-PCT) * H-WAGE-ADJ) +
036600           (H-PYMT-RATE * PPS-NAT-NONLABOR-PCT)) * CBSA-BLEND-PCT.
036700
036800     COMPUTE H-WAGE-ADJ-PYMT-AMT =
036900             H-WAGE-ADJ-PYMT-NEW + H-WAGE-ADJ-PYMT-OLD.
037000
037100     COMPUTE H-PYMT-AMT ROUNDED = H-WAGE-ADJ-PYMT-AMT *
037200          H-BMI-FACTOR * H-BSA-FACTOR * PPS-BDGT-NEUT-RATE *
037300          H-AGE-FACTOR * H-DRUG-ADDON.
037400
037500     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
037600     MOVE SPACES                       TO COND-CD-73.
037700
037800     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
037900                                                      OR '0851')
038000        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
038100        MOVE 'A'                       TO AMT-INDIC
038200        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
038300     ELSE
038400        IF (B-COND-CODE = '73') AND (B-REV-CODE = '0841')
038500           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
038600           MOVE 'A'                    TO AMT-INDIC
038700           MOVE CAPD-AMT               TO BLOOD-DOLLAR
038800        ELSE
038900           IF (B-COND-CODE = '74') AND
039000              (B-REV-CODE = '0841' OR '0851')
039100              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
039200                                           CAPD-OR-CCPD-FACTOR
039300              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
039400           ELSE
039500              MOVE 'A'                 TO AMT-INDIC
039600              MOVE ZERO                TO BLOOD-DOLLAR
039700           END-IF
039800        END-IF
039900     END-IF.
040000
040100     MOVE H-PYMT-AMT                   TO PPS-FINAL-PAY-AMT.
040200     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
040300/
040400 9000-MOVE-RESULTS.
040500
040600     IF PPS-RTC < 50  THEN
040700        MOVE B-COND-CODE               TO PPS-COND-CODE
040800        MOVE B-REV-CODE                TO PPS-REV-CODE
040900        MOVE P-GEO-MSA                 TO PPS-MSA
041000        MOVE P-GEO-CBSA                TO PPS-CBSA
041100        MOVE H-AGE-FACTOR              TO PPS-AGE-FACTOR
041200        MOVE H-BSA-FACTOR              TO PPS-BSA-FACTOR
041300        MOVE H-BMI-FACTOR              TO PPS-BMI-FACTOR
041400        IF OLD-TEST-CASE  THEN
041500           MOVE H-DRUG-ADDON           TO DRUG-ADD-ON-RETURN
041600           MOVE H-WAGE-ADJ-PYMT-OLD    TO MSA-WAGE-ADJ
041700           MOVE H-WAGE-ADJ-PYMT-NEW    TO CBSA-WAGE-ADJ
041800           MOVE CBSA-BLEND-PCT         TO CBSA-PCT
041900           MOVE MSA-BLEND-PCT          TO MSA-PCT
042000           MOVE H-PYMT-RATE            TO CBSA-WAGE-PMT-RATE
042100           MOVE H-PATIENT-AGE          TO AGE-RETURN
042200           MOVE H-WAGE-ADJ             TO CBSA-WAGE-INDEX
042300           MOVE NAT-LABOR-PCT          TO LABOR-PCT
042400        END-IF
042500     ELSE
042600        IF OLD-TEST-CASE  THEN
042700           INITIALIZE PPS-COND-CODE
042800           INITIALIZE PPS-REV-CODE
042900           INITIALIZE PPS-MSA
043000           INITIALIZE PPS-CBSA
043100           INITIALIZE PPS-AGE-FACTOR
043200           INITIALIZE PPS-BSA-FACTOR
043300           INITIALIZE PPS-BMI-FACTOR
043400           INITIALIZE DRUG-ADD-ON-RETURN
043500           INITIALIZE MSA-WAGE-ADJ
043600           INITIALIZE CBSA-WAGE-ADJ
043700           INITIALIZE CBSA-PCT
043800           INITIALIZE MSA-PCT
043900           INITIALIZE CASE-MIX-FCTR-ADJ-RATE
044000           INITIALIZE CBSA-WAGE-PMT-RATE
044100           INITIALIZE HEMO-CCPD-CAPD
044200           INITIALIZE AGE-RETURN
044300        END-IF
044400     END-IF.
044500
044600******        L A S T   S O U R C E   S T A T E M E N T      *****
