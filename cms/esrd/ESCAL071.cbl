000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL071.
000300*AUTHORS.    CMS.
000400*       EFFECTIVE APRIL 1, 2007
000500******************************************************************
000600* 4/06/05 - ALLOW PROVIDER TYPE '05' FOR PEDIATRIC HOSP          *
000700*         - TO BE EFFECTIVE WITH THE NEXT RELEASE                *
000800*         - CHANGED IN 0100-INITIAL-ROUTINE WITH PROVIDER        *
000900*           TYPE '40'                                            *
001000* 1/01/06 - NEW CBSA TABLE FOR CY2006                            *
001100*         - UPDATE 2005 MSA COMPOSITE RATES WITH 1.6% INCREASE   *
001200* 1/18/07 - THE MSA-WAGE-FACTOR-2007 WAS NOT IMPLEMENTED DURING  *
001300*           THE FIRST THREE MONTHS OF 2007                       *
001400*         - MSA-CBSA BLEND PERCENT NOW SET AT 50% MSA 50% CBSA   *
001500*         - ADDITIONAL VARIABLES WERE CREATED IN ORDER TO MAKE   *
001600*           CHANGING VALUES EASIER (IN WORKING STORAGE RATHER    *
001700*           THAN IN THE PROCEDURE DIVISION)                      *
001800*         - THIS PROGRAM NOW REFLECTS ENHANCEMENTS MADE SO THAT  *
001900*           TESTING OF THE CODE DOES NOT REQUIRE COMMENTING      *
002000*           IN/OUT LINES OF CODE.  IN ADDITION CALCULATED        *
002100*           VARIABLES ARE NOW PASSED BACK WHEN TEST CASES ARE    *
002200*           ENCOUNTERED IN ORDER FOR THE MASTER DRIVER TO PRINT  *
002300*           MORE INFORMATION ABOUT WHAT WENT ON IN THIS PROGRAM  *
002400* 1/19/07 - INDEPENDENT ESRD FACILITY WAGE NOW    $132.49        *
002500*           HOSPITAL BASED ESRD FACILTIY WAGE NOW $136.68        *
002600*           DRUG ADD-ON ADJUSTMENT AFTER 4/1/07   1.1490         *
002700* 1/26/07 - MSA composite payment rates increased 1.6% above the *
002800*           2006 rates.  This means that the rates passed from   *
002900*           the driver, which are 2005 rates, need to be         *
003000*           multiplied by 1.016 and then rounded to get the 2006 *
003100*           rate and then that result multiplied by another 1.016*
003200*           and rounded again to get the 4/1/2007 rate.  This    *
003300*           necessary rounding makes the results agree with those*
003400*           published in the Federal Register.  This method was  *
003500*           verified via tedious Excel spreadsheet calculations  *
003600******************************************************************
003700 DATE-COMPILED.
003800 ENVIRONMENT DIVISION.
003900 CONFIGURATION SECTION.
004000 SOURCE-COMPUTER.            IBM-Z990.
004100 OBJECT-COMPUTER.            ITTY-BITTY-MACHINE-CORPORATION.
004200 INPUT-OUTPUT  SECTION.
004300 FILE-CONTROL.
004400
004500 DATA DIVISION.
004600 FILE SECTION.
004700/
004800 WORKING-STORAGE SECTION.
004900 01  W-STORAGE-REF                  PIC X(46)  VALUE
005000     'ESCAL071      - W O R K I N G   S T O R A G E'.
005100 01  CAL-VERSION                    PIC X(05)  VALUE 'C07.1'.
005200
005300 01  DISPLAY-LINE-MEASUREMENT.
005400     05  FILLER                     PIC X(50) VALUE
005500         '....:...10....:...20....:...30....:...40....:...50'.
005600     05  FILLER                     PIC X(50) VALUE
005700         '....:...60....:...70....:...80....:...90....:..100'.
005800     05  FILLER                     PIC X(20) VALUE
005900         '....:..110....:..120'.
006000
006100 01  PRINT-LINE-MEASUREMENT.
006200     05  FILLER                     PIC X(51) VALUE
006300         'X....:...10....:...20....:...30....:...40....:...50'.
006400     05  FILLER                     PIC X(50) VALUE
006500         '....:...60....:...70....:...80....:...90....:..100'.
006600     05  FILLER                     PIC X(32) VALUE
006700         '....:..110....:..120....:..130..'.
006800
006900 01  HOLD-PPS-COMPONENTS.
007000     05  H-PYMT-AMT                 PIC 9(07)V9(02).
007100     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(07)V9(02).
007200     05  H-2006-WAGE-ADJ-PYMT       PIC 9(07)V9(02).
007300     05  H-2007-WAGE-ADJ-PYMT       PIC 9(07)V9(02).
007400     05  H-MSA-COMPOSITE-PYMT       PIC 9(07)V9(02).
007500     05  H-WAGE-ADJ-PYMT-OLD        PIC 9(07)V9(02).
007600     05  H-WAGE-ADJ-PYMT-NEW        PIC 9(07)V9(02).
007700     05  H-WAGE-ADJ                 PIC 9(02)V9(04).
007800     05  H-PYMT-RATE                PIC 9(04)V9(02).
007900     05  H-FIXED-LOSS-AMT           PIC 9(07)V9(02).
008000     05  H-ESRD-FAC-RATE            PIC 9(07)V9(02).
008100     05  H-PATIENT-AGE              PIC 9(03).
008200     05  H-AGE-FACTOR               PIC 9(01)V9(03).
008300     05  H-BSA-FACTOR               PIC 9(01)V9(04).
008400     05  H-BMI-FACTOR               PIC 9(01)V9(04).
008500     05  H-BSA                      PIC 9(03)V9(04).
008600     05  H-BMI                      PIC 9(03)V9(04).
008700     05  H-DRUG-ADDON               PIC 9(01)V9(04).
008800
008900*   THE FOLLOWING THREE VARIABLES WILL CHANGE FROM YEAR TO YEAR
009000 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1490.
009100 01  HOSP-BASED-PMT-RATE            PIC 9(04)V9(02) VALUE 136.68.
009200 01  INDP-ESRD-FAC-PMT-RATE         PIC 9(04)V9(02) VALUE 132.49.
009300
009400*   THE NEXT TWO PERCENTAGES MUST ADD UP TO 1 (I.E. 100%)
009500*   THEY WILL CONTINUE TO CHANGE UNTIL 2009 (AND THEN BE FIXED)
009600 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.50.
009700 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 0.50.
009800
009900
010000*  CONSTANTS AREA
010100*   THE NEXT TWO PERCENTAGES MUST ADD UP TO 1 (I.E. 100%)
010200 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
010300 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
010400
010500 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
010600 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
010700 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
010800                                                       0.428571.
010900 01  MSA-WAGE-FACTOR-2006           PIC 9(01)V9(03) VALUE 1.016.
011000 01  MSA-WAGE-FACTOR-2007           PIC 9(01)V9(03) VALUE 1.016.
011100
011200*  THE FOLLOWING NUMBER THAT IS LOADED INTO THE PAYMENT EQUATION
011300*  IS MEANT TO BUDGET NEUTRALIZE CHANGES IN THE CASE MIX INDEX
011400*  AND   --DOES NOT CHANGE--
011500 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
011600
011700
011800******************************************************************
011900*                                                                *
012000*   ******** POSSIBLE RETURN CODES FROM THIS PROGRAM ********    *
012100*                                                                *
012200*    ****  PPS-RTC 00-49 = BILL PAYMENT INFORMATION CODES        *
012300*                                                                *
012400*            00 = ESRD PPS PAYMENT CALCULATED                    *
012500*                                                                *
012600*    ****  PPS-RTC 50-99 = WHY THE BILL WAS NOT PAID             *
012700*                                                                *
012800*            52 = PROVIDER TYPE NOT = '40' OR '41' OR '05'       *
012900*            53 = SPECIAL PAYMENT INDICATOR NOT = '1' OR BLANK   *
013000*            54 = DATE OF BIRTH  NOT NUMERIC OR = ZERO           *
013100*            55 = PATIENT WEIGHT NOT NUMERIC OR = ZERO           *
013200*            56 = PATIENT HEIGHT NOT NUMERIC OR = ZERO           *
013300*            57 = REVENUE CENTER CODE NOT IN RANGE               *
013400*            58 = CONDITION CODE NOT = '73' OR '74' OR BLANK     *
013500*            71 = EXCEEDS MAXIMUM HEIGHT ALLOWANCE               *
013600*            72 = EXCEEDS MAXIMUM WEIGHT ALLOWANCE               *
013700******************************************************************
013800/
013900 LINKAGE SECTION.
014000 COPY BILLCPY.
014100*COPY "BILLCPY.CPY".
014200/
014300 COPY WAGECPY.
014400*COPY "WAGECPY.CPY".
014500/
014600 PROCEDURE DIVISION  USING BILL-NEW-DATA
014700                           PPS-DATA-ALL
014800                           WAGE-NEW-RATE-RECORD
014900                           COM-CBSA-WAGE-RECORD.
015000
015100******************************************************************
015200* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
015300* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
015400* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
015500* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
015600* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
015700* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
015800* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
015900* PROCESSING (DICP).                                             *
016000*                                                                *
016100*                                                                *
016200*    PROCESSING:                                                 *
016300*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
016400*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
016500*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
016600*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
016700*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
016800*           GOBACK.                                              *
016900*        D. ASSEMBLE PRICING COMPONENTS.                         *
017000*        E. CALCULATE THE PRICE.                                 *
017100******************************************************************
017200
017300 0000-MAINLINE-CONTROL.
017400
017500     PERFORM 0100-INITIAL-ROUTINE.
017600
017700     IF PPS-RTC = 00
017800        PERFORM 1000-EDIT-THE-BILL-INFO
017900     END-IF.
018000
018100     IF PPS-RTC = 00
018200        PERFORM 2000-ASSEMBLE-PPS-VARIABLES
018300        PERFORM 3000-CALC-PAYMENT
018400     END-IF.
018500
018600     PERFORM 9000-MOVE-RESULTS.
018700
018800     GOBACK.
018900/
019000 0100-INITIAL-ROUTINE.
019100
019200******************************************************************
019300**   NEW PAYMENT RATES FOR NEW LEGISLATION                      **
019400******************************************************************
019500     INITIALIZE PPS-DATA-ALL.
019600     INITIALIZE BILL-DATA-TEST.
019700     INITIALIZE HOLD-PPS-COMPONENTS.
019800     MOVE ZEROS                        TO PPS-RTC.
019900     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
020000
020100* PROVIDER TYPE '40' AND '05' ARE HOSPITAL BASED ESRD FACILITIES
020200     IF P-PROV-TYPE = '40' OR '05'
020300        MOVE NAT-LABOR-PCT             TO PPS-NAT-LABOR-PCT
020400        MOVE NAT-NONLABOR-PCT          TO PPS-NAT-NONLABOR-PCT
020500        MOVE HOSP-BASED-PMT-RATE       TO H-PYMT-RATE
020600        COMPUTE H-2006-WAGE-ADJ-PYMT ROUNDED =
020700                W-NEW-RATE1-RECORD    *  MSA-WAGE-FACTOR-2006
020800        COMPUTE H-2007-WAGE-ADJ-PYMT ROUNDED =
020900                H-2006-WAGE-ADJ-PYMT  *  MSA-WAGE-FACTOR-2007
021000        MOVE H-2007-WAGE-ADJ-PYMT      TO H-WAGE-ADJ-PYMT-OLD
021100        MOVE W-NEW-RATE1-RECORD        TO MSA-WAGE-AMT
021200        MOVE COM-CBSA-W-INDEX          TO H-WAGE-ADJ
021300     ELSE
021400* PROVIDER TYPE '41' IS AN INDEPENDENT ESRD FACILITY
021500        IF P-PROV-TYPE = '41'
021600           MOVE NAT-LABOR-PCT          TO PPS-NAT-LABOR-PCT
021700           MOVE NAT-NONLABOR-PCT       TO PPS-NAT-NONLABOR-PCT
021800           MOVE INDP-ESRD-FAC-PMT-RATE TO H-PYMT-RATE
021900           COMPUTE H-2006-WAGE-ADJ-PYMT ROUNDED =
022000                   W-NEW-RATE2-RECORD    *  MSA-WAGE-FACTOR-2006
022100           COMPUTE H-2007-WAGE-ADJ-PYMT ROUNDED =
022200                   H-2006-WAGE-ADJ-PYMT  *  MSA-WAGE-FACTOR-2007
022300           MOVE H-2007-WAGE-ADJ-PYMT   TO H-WAGE-ADJ-PYMT-OLD
022400           MOVE W-NEW-RATE2-RECORD     TO MSA-WAGE-AMT
022500           MOVE COM-CBSA-W-INDEX       TO H-WAGE-ADJ
022600        ELSE
022700           MOVE 52                     TO PPS-RTC
022800           MOVE ZERO                   TO PPS-WAGE-ADJ-RATE
022900        END-IF
023000     END-IF.
023100
023200     MOVE H-WAGE-ADJ-PYMT-OLD          TO MSA-ADJ-YEAR-AMT.
023300
023400******************************************************************
023500**  NEW DRUG ADD-ON FOR NEW LEGISLATION                         **
023600******************************************************************
023700
023800     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
023900     MOVE DRUG-ADDON                   TO H-DRUG-ADDON.
024000/
024100******************************************************************
024200***  BILL DATA EDITS IF ANY FAIL SET PPS-RTC                   ***
024300***  AND DO NOT ATTEMPT TO PRICE.                              ***
024400******************************************************************
024500 1000-EDIT-THE-BILL-INFO.
024600
024700     IF PPS-RTC = 00
024800        IF P-SPEC-PYMT-IND NOT = '1' AND ' '
024900           MOVE 53                     TO PPS-RTC
025000        END-IF
025100     END-IF.
025200
025300     IF PPS-RTC = 00
025400        IF (B-DOB-DATE = ZERO) OR (B-DOB-DATE NOT NUMERIC)
025500           MOVE 54                     TO PPS-RTC
025600        END-IF
025700     END-IF.
025800
025900     IF PPS-RTC = 00
026000        IF (B-PATIENT-WGT = 0) OR (B-PATIENT-WGT NOT NUMERIC)
026100           MOVE 55                     TO PPS-RTC
026200        END-IF
026300     END-IF.
026400
026500     IF PPS-RTC = 00
026600        IF (B-PATIENT-HGT = 0) OR (B-PATIENT-HGT NOT NUMERIC)
026700           MOVE 56                     TO PPS-RTC
026800        END-IF
026900     END-IF.
027000
027100     IF PPS-RTC = 00
027200        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
027300                                OR '0880' OR '0881'
027400           NEXT SENTENCE
027500        ELSE
027600           MOVE 57                     TO PPS-RTC
027700        END-IF
027800     END-IF.
027900
028000     IF PPS-RTC = 00
028100        IF B-COND-CODE NOT = '73' AND '74' AND '  '
028200           MOVE 58                     TO PPS-RTC
028300        END-IF
028400     END-IF.
028500
028600     IF PPS-RTC = 00
028700        IF B-PATIENT-HGT > 300.00
028800           MOVE 71                     TO PPS-RTC
028900        END-IF
029000     END-IF.
029100
029200     IF PPS-RTC = 00
029300        IF B-PATIENT-WGT > 500.00
029400           MOVE 72                     TO PPS-RTC
029500        END-IF
029600     END-IF.
029700
029800     IF PPS-RTC = 00
029900        PERFORM 1200-CALC-AGE
030000     END-IF.
030100
030200
030300 1200-CALC-AGE.
030400******************************************************************
030500***  CALCULATE PATIENT AGE                                     ***
030600******************************************************************
030700
030800     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY.
030900
031000     IF B-DOB-MM > B-THRU-MM
031100        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
031200     END-IF.
031300
031400******************************************************************
031500***  SET AGE ADJUSTMENT FACTOR                                 ***
031600******************************************************************
031700
031800     IF H-PATIENT-AGE < 18
031900        MOVE 1.620                     TO H-AGE-FACTOR
032000     ELSE
032100        IF H-PATIENT-AGE > 17 AND H-PATIENT-AGE < 45
032200           MOVE 1.223                  TO H-AGE-FACTOR
032300        ELSE
032400           IF H-PATIENT-AGE > 44 AND H-PATIENT-AGE < 60
032500              MOVE 1.055               TO H-AGE-FACTOR
032600           ELSE
032700              IF H-PATIENT-AGE > 59 AND H-PATIENT-AGE < 70
032800                 MOVE 1.000            TO H-AGE-FACTOR
032900              ELSE
033000                 IF H-PATIENT-AGE > 69 AND H-PATIENT-AGE < 80
033100                    MOVE 1.094         TO H-AGE-FACTOR
033200                 ELSE
033300                    IF H-PATIENT-AGE > 79
033400                       MOVE 1.174      TO H-AGE-FACTOR
033500                    END-IF
033600                 END-IF
033700              END-IF
033800           END-IF
033900        END-IF
034000     END-IF.
034100
034200/
034300 2000-ASSEMBLE-PPS-VARIABLES.
034400******************************************************************
034500***  CALCULATE PPS PRICING VARIABLES                           ***
034600******************************************************************
034700
034800     COMPUTE H-BSA ROUNDED = (.007184 *
034900         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
035000
035100     COMPUTE H-BMI ROUNDED = (B-PATIENT-WGT /
035200         (B-PATIENT-HGT ** 2)) * 10000.
035300
035400     IF H-PATIENT-AGE > 17
035500        COMPUTE H-BSA-FACTOR ROUNDED =
035600             1.037 ** ((H-BSA - 1.84) / .1)
035700     ELSE
035800        MOVE 1.000                     TO H-BSA-FACTOR
035900     END-IF.
036000
036100     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)
036200        MOVE 1.112                     TO H-BMI-FACTOR
036300     ELSE
036400        MOVE 1.000                     TO H-BMI-FACTOR
036500     END-IF.
036600
036700/
036800******************************************************************
036900***  IF THE BILL DATA HAS PASSED ALL EDITS (RTC=00)            ***
037000***      CALCULATE THE STANDARD PAYMENT AMOUNT.                ***
037100***    - BLEND 50% OLD RATE (MSA) WITH 50% NEW RATE (CBSA).    ***
037200******************************************************************
037300 3000-CALC-PAYMENT.
037400
037500* BEGINNING 01/01/2007 THE BLEND RATE WILL BE 50% MSA 50% CBSA
037600     COMPUTE H-WAGE-ADJ-PYMT-OLD ROUNDED =
037700            (H-WAGE-ADJ-PYMT-OLD * MSA-BLEND-PCT).
037800
037900     COMPUTE H-WAGE-ADJ-PYMT-NEW ROUNDED =
038000         (((H-PYMT-RATE * PPS-NAT-LABOR-PCT) * H-WAGE-ADJ) +
038100           (H-PYMT-RATE * PPS-NAT-NONLABOR-PCT)) * CBSA-BLEND-PCT.
038200
038300     COMPUTE H-WAGE-ADJ-PYMT-AMT =
038400             H-WAGE-ADJ-PYMT-NEW + H-WAGE-ADJ-PYMT-OLD.
038500
038600     COMPUTE H-PYMT-AMT ROUNDED = H-WAGE-ADJ-PYMT-AMT *
038700          H-BMI-FACTOR * H-BSA-FACTOR * PPS-BDGT-NEUT-RATE *
038800          H-AGE-FACTOR * H-DRUG-ADDON.
038900
039000     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
039100     MOVE SPACES                       TO COND-CD-73.
039200
039300     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
039400                                                      OR '0851')
039500        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
039600        MOVE 'A'                       TO AMT-INDIC
039700        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
039800     ELSE
039900        IF (B-COND-CODE = '73') AND (B-REV-CODE = '0841')
040000           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
040100           MOVE 'A'                    TO AMT-INDIC
040200           MOVE CAPD-AMT               TO BLOOD-DOLLAR
040300        ELSE
040400           IF (B-COND-CODE = '74') AND
040500              (B-REV-CODE = '0841' OR '0851')
040600              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
040700                                           CAPD-OR-CCPD-FACTOR
040800              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
040900           ELSE
041000              MOVE 'A'                 TO AMT-INDIC
041100              MOVE ZERO                TO BLOOD-DOLLAR
041200           END-IF
041300        END-IF
041400     END-IF.
041500
041600     MOVE H-PYMT-AMT                   TO PPS-FINAL-PAY-AMT.
041700     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
041800/
041900 9000-MOVE-RESULTS.
042000
042100     IF PPS-RTC < 50  THEN
042200        MOVE B-COND-CODE               TO PPS-COND-CODE
042300        MOVE B-REV-CODE                TO PPS-REV-CODE
042400        MOVE P-GEO-MSA                 TO PPS-MSA
042500        MOVE P-GEO-CBSA                TO PPS-CBSA
042600        MOVE H-AGE-FACTOR              TO PPS-AGE-FACTOR
042700        MOVE H-BSA-FACTOR              TO PPS-BSA-FACTOR
042800        MOVE H-BMI-FACTOR              TO PPS-BMI-FACTOR
042900        IF OLD-TEST-CASE  THEN
043000           MOVE H-DRUG-ADDON           TO DRUG-ADD-ON-RETURN
043100           MOVE H-WAGE-ADJ-PYMT-OLD    TO MSA-WAGE-ADJ
043200           MOVE H-WAGE-ADJ-PYMT-NEW    TO CBSA-WAGE-ADJ
043300           MOVE CBSA-BLEND-PCT         TO CBSA-PCT
043400           MOVE MSA-BLEND-PCT          TO MSA-PCT
043500           MOVE H-PYMT-RATE            TO CBSA-WAGE-PMT-RATE
043600           MOVE H-PATIENT-AGE          TO AGE-RETURN
043700           MOVE H-WAGE-ADJ             TO CBSA-WAGE-INDEX
043800           MOVE NAT-LABOR-PCT          TO LABOR-PCT
043900        END-IF
044000     ELSE
044100        IF OLD-TEST-CASE  THEN
044200           INITIALIZE PPS-COND-CODE
044300           INITIALIZE PPS-REV-CODE
044400           INITIALIZE PPS-MSA
044500           INITIALIZE PPS-CBSA
044600           INITIALIZE PPS-AGE-FACTOR
044700           INITIALIZE PPS-BSA-FACTOR
044800           INITIALIZE PPS-BMI-FACTOR
044900           INITIALIZE DRUG-ADD-ON-RETURN
045000           INITIALIZE MSA-WAGE-ADJ
045100           INITIALIZE CBSA-WAGE-ADJ
045200           INITIALIZE CBSA-PCT
045300           INITIALIZE MSA-PCT
045400           INITIALIZE CASE-MIX-FCTR-ADJ-RATE
045500           INITIALIZE CBSA-WAGE-PMT-RATE
045600           INITIALIZE HEMO-CCPD-CAPD
045700           INITIALIZE AGE-RETURN
045800        END-IF
045900     END-IF.
046000
046100******        L A S T   S O U R C E   S T A T E M E N T      *****
