000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL180.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2018
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
002700* 1/26/07 - MSA COMPOSITE PAYMENT RATES INCREASED 1.6% ABOVE THE *
002800*           2006 RATES.  THIS MEANS THAT THE RATES PASSED FROM   *
002900*           THE DRIVER, WHICH ARE 2005 RATES, NEED TO BE         *
003000*           MULTIPLIED BY 1.016 AND THEN ROUNDED TO GET THE 2006 *
003100*           RATE AND THEN THAT RESULT MULTIPLIED BY ANOTHER 1.016*
003200*           AND ROUNDED AGAIN TO GET THE 4/1/2007 RATE.  THIS    *
003300*           NECESSARY ROUNDING MAKES THE RESULTS AGREE WITH THOSE*
003400*           PUBLISHED IN THE FEDERAL REGISTER.  THIS METHOD WAS  *
003500*           VERIFIED VIA TEDIOUS EXCEL SPREADSHEET CALCULATIONS  *
003600* 10/30/07- MSA COMPOSITE PAYMENT RATES DID NOT INCREASE FROM THE*
003700*           2007/04/01 RATES.  THE COMPOSITE BASE RATES DID NOT  *
003800*           CHANGE FROM THE 07/04/01 FACILITY RATES.             *
003900*           THE BLEND OF MSA TO CBSA WAS CHANGED TO 25% MSA AND  *
004000*           75% CBSA.                                            *
004100*           THE DRUG ADDON FACTOR WAS INCREASED TO 1.1550        *
004200*           ALL OTHER FIGURES REMAINED THE SAME.                 *
004300* 11/21/07- CHANGES WERE MADE TO ALL THE CALCULATION SUBROUTINES *
004400*           BEGINNING IN 2005 IN ORDER TO ENSURE THAT THE        *
004500*           PC-PRICER CAN USE THE **EXACT** SAME CODE THAT EXISTS*
004600*           ON THE MAINFRAME.  IN ORDER TO ENSURE THAT THE       *
004700*           LINKAGE SECTION REMAINS THE SAME, THE FILLER AREAS   *
004800*           LOCATED AT THE END OF EACH '05' LEVEL HAVE BEEN      *
004900*           MODIFIED TO INCLUDE VARIABLES NEEDED FOR PROOFING OF *
005000*           THE MAINFRAME CODE AS WELL AS DISPLAYING ON THE PC-  *
005100*           PRICER.                                              *
005200*         -      THE VARIABLE LABELED 'P-ESRD-RATE' IS NEVER     *
005300*           USED IN CALCUALTIONS SINCE THE DRIVER IS THE ONLY ONE*
005400*           THAT USES IT IN SPECIAL CIRCUMSTANCES AT THE FISCAL  *
005500*           INTERMEDIARIES.  THEREFORE A DUAL USE WAS MADE OF IT *
005600*           SO THAT THE PC-PRICER CAN MAKE USE OF THE VERY       *
005700*           LIMITED SPACE LEFT.  THE VARIABLE NAME WAS REDEFINED *
005800*           TO 'CASE-MIX-FCTR-ADJ-RATE' TO REFLECT IT'S USAGE ON *
005900*           THE PC-PRICER.                                       *
006000*         -        USAGE OF THE THESE FILLER AREAS AND THE       *
006100*           'CASE-MIX-FCTR-ADJ-RATE' VARIABLE WILL ONLY OCCUR    *
006200*           WHEN A 'T' (FOR TESTING) IS IN THE LAST COLUMN OF THE*
006300*           INPUT RECORD.  OTHERWISE THESE VARIABLES WILL CONTAIN*
006400*           SPACES WHEN NOT IN TEST MODE.  MOST OF THE MOVES TO  *
006500*           THESE VARIABLES OCCURS IN THE 9000-MOVE-RESULTS PARA-*
006600*           GRAPH.  A FEW MOVES MUST OCCUR IN OTHER AREAS OF THE *
006700*           PROGRAM.                                             *
006800* 11/07/08- ALL CODE FOR 2006-2008 WAGE ADJUSTED PAYMENTS WERE   *
006900*           REMOVED BECAUSE THERE IS NO LONGER A BLEND BETWEEN   *
007000*           MSA AND CBSA STARTING 1/1/2009.                      *
007100*           THE DRUG ADDON FACTOR WAS CHANGED TO 1.1520          *
007200*           THE HOSPITAL AND INDEPENDENT ESRD FACILITY PAYMENT   *
007300*           RATES ARE NOW THE SAME.  THE TWO VARIABLES WERE LEFT *
007400*           IN THE PROGRAM IN CASE THEY DECIDE TO MAKE THEM      *
007500*           DIFFERENT IN THE FUTURE.                             *
007600* 12/03/08- RENAMED THIS SUBROUTINE ESCAL091 AND CHANGED THE     *
007700*           APPROPRIATE VERSION INFORMATION.  THE 9.0 VERSION OF *
007800*           THE PRICER WAS SENT OUT IN NOVEMBER.  AFTERWARDS THE *
007900*           POLICY PEOPLE WHO SET THE WAGE INDEXES, CHANGED THEIR*
008000*           MINDS ABOUT CBSA 16700 AND RESCINDED THE WAGE INDEX. *
008100*           THIS NECESSITATED A RE-RELEASE OF THE ESRD PRICER IN *
008200*           ORDER TO MAKE SURE THAT THE FI'S ARE USING THE LATEST*
008300*           VERSION AT THE START OF CY2009.                      *
008400* 11/02/09- Renamed this subroutine ESCAL100 and changed the     *
008500*           appropriate version information.  Changed the        *
008600*           composite rate (Hosp-Based-Pmt-Rate and Indp-ESRD-Fac*
008700*           -Pmt-Rate) to 135.15.  Also changed the Drug-Addon to*
008800*           1.1500.                                              *
008900*         - Began reorganization of program so that it can be    *
009000*           used with the Bundled rate payment system as well as *
009100*           the Composite rate payment system.  In that light,   *
009200*           changed WAGE-NEW-CBSA-RECORD to COM-CBSA-WAGE-RECORD *
009300*           and added BUN-CBSA-WAGE-RECORD which is not used in  *
009400*           this version of the program.  Changed corresponding  *
009500*           variable names to agree with the new name.           *
009600* 10/29/10- Renamed this subroutine ESCAL110.  This pricer       *
009700*           changed from being only a Composite Rate pricer to   *
009800*           processing line-items using both the Composite Rate  *
009900*           methodology AND a Bundled (now called PPS) Rate      *
010000*           methodology during a blend period that lasts from    *
010100*           2011 to 2013.  The original composite rate code has  *
010200*           been completely rewritten to conform to the new      *
010300*           manner of pricing as well as being more efficient.   *
010400*           There are too many changes to list from the bundled  *
010500*           methodology to put here.                             *
010600*           On the composite-rate side of the program, the drug  *
010700*           add-on has been changed to 14.7 percent and the      *
010800*           the composite rate changed to $138.53.               *
010900*           Also added new variable A-49-CENT-PART-D-DRUG-ADJ    *
011000*           to the composite-rate side of the calculation which  *
011100*           is an adjustment for ESRD drugs and biologicals      *
011200*           currently paid under Part-D.                         *
011300* 03/07/11- Renamed this subroutine ESCAL116.  This was due to   *
011400*           problems found in the initial version which was re-  *
011500*           leased to FISS for their initial work in bringing up *
011600*           the new pricer.  Future revisions may be needed.     *
011700* 10/28/11- Renamed this subroutine ESCAL120.  Four changes are: *
011800*           (1) fixed the onstart calculation to count from day  *
011900*           one and therefore use 120 days vs the 121 days prior *
012000*           calculation (which counted from the second day).     *
012100*           (2) added an output variable which is the amount of  *
012200*           the low volume that is added to a line-item payment  *
012300*           when the provider is a low-volume provider.  This is *
012400*           for recovery purposes.                               *
012500*           (3) added an input variable for the Quality Incentive*
012600*           Program (QIP).  The specific number in this field    *
012700*           comes from FISS which maintaines the Provider        *
012800*           Specific File and the number ultimately is provided  *
012900*           by the Quality people at CMS.                        *
013000*           (4) made necessary changes for CY 2012.  A noteworthy*
013100*           change is how blended payments are calculated.  In   *
013200*           2011 there was a 49 cent Part D drug adjustment.  In *
013300*           2012 this 49 cent is added to the Base-Payment-Rate  *
013400*           and then the 2.1 % productivity is applied.  This    *
013500*           means that the base rate starts at $139.02 and after *
013600*           the 2.1% increase the base rate is $141.94.          *
013700*           Another change is in calculating the BSA.  The super-*
013800*           script is now the same in the Composite Rate portion *
013900*           of the code as it is in the PPS portion of the code. *
014000* FUTURE    This program is intended to be used in a running TEN *
014100*           year (current year and nine prior years) mode.       *
014200*           As of 10/10, there are no plans on which variables to*
014300*           remove since plans may change yet again.             *
014400* ESCAL121  ESCAL120...Note that there is NO ESCAL120 calculating
014500*           subroutine due to a reversing of CBSA 41980 composite
014600*           & PPS WAGE INDEX which was sent out with the ESDRV120
014700*           subroutine prior to the start of the calendar year.
014800*           There is NO difference between the original ESCAL120
014900*           and ESCAL121 except the notational difference in the
015000*           version number.
015100* 11/14/12- ESCAL130 - Made annual updates for CY 2013 to match
015200*           specifications from the Chronic Care Policy Group.
015300*           In addition, code was added to implement the
015400*           assignment of the pediatric hemodialysis rate to
015500*           revenue code 0881 (ultrafiltration) when reported
015600*           on a pediatric claim (CR 7064 - Requirement #11).
015700*           List of changes for CY 2013 -->
015800*           - Composite payment rate for blended payments:
015900*              changed BASE-PAYMENT-RATE to 145.20.
016000*           - Drug add-on to the composite payment system for
016100*             blended payments:
016200*              changed DRUG-ADDON to 1.1400.
016300*           - ESRD PPS base rate:
016400*              changed BUNDLED-BASE-PMT-RATE to 240.36
016500*              (after taking into account both -->
016600*                    - the market basket update, and
016700*                    - the wage index budget neutrality adjustment
016800*                      factor).
016900*           - ESRD PPS outlier per treatment MAP amount for
017000*             adult patients:
017100*              changed ADJ-AVG-MAP-AMT-GT-17 to 59.42.
017200*           - ESRD PPS outlier per treatment MAP amount for
017300*             pediatric patients:
017400*              changed ADJ-AVG-MAP-AMT-LT-18 to 41.39.
017500*           - ESRD PPS outlier threshold fixed dollar loss amount
017600*             for adult patients:
017700*              changed FIX-DOLLAR-LOSS-GT-17 to 110.22.
017800*           - ESRD PPS outlier threshold fixed dollar loss amount
017900*             for pediatric patients:
018000*              changed FIX-DOLLAR-LOSS-LT-18 to 47.32.
018100*           - 25 percent of the basic case-mix adjusted composite
018200*             payment amount:
018300*              changed COM-CBSA-BLEND-PCT to 0.25.
018400*           - 75 percent of the ESRD PPS payment amount:
018500*              changed BUN-CBSA-BLEND-PCT to 0.75.
018600* 11-15-13 - ESCAL14B - BETA PRICER FOR TESTING ONLY
018700* We have to wait until November 29th, when the ESRD Final Rule
018800* is published, to release the CY 2014 ESRD Pricer to FISS
018900* because the rates are sensitive.  However, we will release a
019000* BETA version to FISS by November 15th so they can test the
019100* logic changes.
019200* The BETA release should have the following characteristics:
019300* - Contain a "B" in the file name(s) to indicate it's the 2014
019400*   BETA version
019500* - Contain the CY 2013 rates
019600* - Contain a modified CY 2013 wage index table
019700*       o Add the three Pacific Rim CBSAs to the table
019800*         (CBSAs 64, 65, and 66)
019900*       o Assign the three Pacific Rim CBSAs the CY 2013
020000*         Puerto Rico (CBSA 40) wage index value
020100* - Include new logic that forces all providers to receive the
020200*   100% PPS payment (blend logic removed/disabled)
020300*      TO MAKE SURE THAT ALL BILLS ARE 100% PPS
020400*      ADDED LINE TO MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
020500* - Include new logic that directs Pacific Rim providers to
020600*   flow through the pricing calculation as all other providers
020700* The BETA Pricer release memo/email should emphasize the fact
020800* that this version and the rates therein are for testing only.
020900*
021000* 11/15/13- ESCAL140 - Made annual updates for CY 2014 to match
021100* specifications from the Chronic Care Policy Group.
021200* In addition, code was changed in the following two ways:
021300* - Included new log that forces all providers to
021400*   receive the 100% PPS payment (blend logic is
021500*   removed/disabled)
021600* - Included new logic that directs Pacific Rim providers
021700*   to flow through the pricing calculation as all other
021800*   providers
021900* List of changes for CY 2014 -->
022000*      - Changed BUNDLED-BASE-PMT-RATE to 239.02.
022100*      - Changed ADJ-AVG-MAP-AMT-GT-17 to 50.25.
022200*      - Changed ADJ-AVG-MAP-AMT-LT-18 to 40.49.
022300*      - Changed FIX-DOLLAR-LOSS-GT-17 to 98.67.
022400*      - Changed FIX-DOLLAR-LOSS-LT-18 to 47.32.
022500*      - Changed TRAINING-ADD-ON-PMT-AMT to 50.16.
022600*      - Kept the following changes from the CY 2014 BETA
022700*              - COM-CBSA-BLEND-PCT = 0.00.
022800*              - BUN-CBSA-BLEND-PCT = 1.00.
022900*
023000* 11/15/14- ESCAL150 - Made annual updates for CY 2015 to match
023100* specifications from the Chronic Care Policy Group.
023200* List of changes for CY 2015 -->
023300*      - ESRD PPS base rate
023400*          Changed BUNDLED-BASE-PMT-RATE to 239.43.
023500*           includes Wage Index Budget Neutrality Adjustment
023600*           Factor of 1.001729
023700*      - Labor-related share
023800*          Changed BUN-NAT-LABOR-PCT to 0.46205
023900*           Implementation of the revised
024000*           labor-related share with a 50/50
024100*           blend under a 2-year transition
024200*           results in a labor-related share
024300*           value of 46.205 percent for CY 2015.
024400*      - Non-labor-related share
024500*          Changed BUN-NAT-NONLABOR-PCT to 0.53795
024600*           Non-labor-related share =
024700*            1 - Labor-related share
024800*      - Changed ADJ-AVG-MAP-AMT-GT-17 to 51.29.
024900*          For adult patients, the adjusted
025000*          average outlier service MAP
025100*          amount per treatment
025200*      - Changed ADJ-AVG-MAP-AMT-LT-18 to 43.57.
025300*          For pediatric patients, the
025400*          adjusted average outlier service
025500*          MAP amount per treatment
025600*      - Changed FIX-DOLLAR-LOSS-GT-17 to 86.19.
025700*          The fixed dollar loss amount for adult patients
025800*      - Changed FIX-DOLLAR-LOSS-LT-18 to 54.35.
025900*          The fixed dollar loss amount for pediatric patients
026000* 12/23/14 ESCAL151 WASN'T CHANGED EXCEPT TO ALLOW FOR NEW VERSION
026100* DUE TO CHANGES TO ESDRV151 TO IMPLEMENT SEARCH FOR SPECIAL WAGE
026200* INDEXES FOR CHILDREN'S HOSPITALS
026300* 11/17/15 - ESCAL160 -  specs from CM/CCPG/DCC
026400* List of changes for CY 2016 -->
026500* - ESRD PPS base rate
026600*     Changed BUNDLED-BASE-PMT-RATE to 230.39.
026700*     (Includes both a Wage Index Budget-Neutrality Adjustment
026800*     Factor of 1.000495 and a Refinement Budget-Neutrality
026900*     Adjustment Factor of 0.960319)
027000* - Labor-related share
027100*     Changed BUN-NAT-LABOR-PCT to 0.50673
027200*     Full iImplementation of the revised labor-related share
027300* - Non-labor-related share
027400*     Changed BUN-NAT-NONLABOR-PCT to 0.49327
027500*     Non-labor-related share = 1 - Labor-related share
027600* - Changed ADJ-AVG-MAP-AMT-GT-17 to 50.81.
027700*     For adult patients, the adjusted
027800*     average outlier service MAP
027900*     amount per treatment
028000* - Changed ADJ-AVG-MAP-AMT-LT-18 to 39.20.
028100*     For pediatric patients, the
028200*     adjusted average outlier service
028300*     MAP amount per treatment
028400* - Changed FIX-DOLLAR-LOSS-GT-17 to 86.97.
028500*     The fixed dollar loss amount for adult patients
028600* - Changed FIX-DOLLAR-LOSS-LT-18 to 62.19.
028700*     The fixed dollar loss amount for pediatric patients
028800* - Changed values of ADULT-MULTIPLIERS
028900* - Changed values of PEDIATRIC-MULTIPLIERS
029000* - Added Rural Adjustment, new variables and logic
029100* - Dropped Comorbids for Pneumonia & Monoclonal-Gamm
029200*
029300* 9/27/16 - ESCAL17B ** for BETA Testing **
029400* - Implement changes from CR9598 (AKI)
029500*   - new Condition Code 84 and Logic for AKI
029600*       - AKI payment = Base Rate adjusted by Wage Index
029700*       - skip validation of Height, Weight, Comorbid, and QIP
029800*       - Reduction for AKI claims
029900*   - Wage Index adjustment is only adjustment for AKI payments
030000* - Added variable BSA-NATIONAL-AVERAGE that's used
030100*   to calculate the BSA. It replaces the value that had been
030200*   hard-coded as 1.90.
030300* - Removed 5000-CALC-COMP-RATE-FACTORS because it was for
030400*   Composite pricing that hasn't been used since 2013
030500*
030600* 10/19/2016 ESCAL170 CR9807 EFFECTIVE 1-1-17 Annual Update
030700* - Changed BUNDLED-BASE-PMT-RATE to 231.55
030800* - Changed TRAINING-ADD-ON-PMT-AMT to 95.60
030900* - Changed ADJ-AVG-MAP-AMT-GT-17 to 45.00
031000* - Changed ADJ-AVG-MAP-AMT-LT-18 to 38.29
031100* - Changed FIX-DOLLAR-LOSS-GT-17 to 82.92
031200* - Changed FIX-DOLLAR-LOSS-LT-18 to 68.49
031300*
031400* 03/15/2017 ESCAL171 CR9609 EFFECTIVE 7-1-17
031500* - Added Condition Code of 87 for Retraining
031600*
031700* 06/14/2017 ESCAL18B BETA VERSION FOR TESTING ONLY
031800* - CR10065 TDAPA calculation added
031900*
032000* 10/2/2017 ESCAL18C BETA VERSION FOR TESTING ONLY
032100* - modify logic so TDAPA value can be passed to other modules
032200*
032300* 11/14/2017 ESCAL180 FOR PRODUCTION EFFECTIVE 1-1-17
032400* - CR10312 Annual Update:
032500*   - Changed BUNDLED-BASE-PMT-RATE to 232.37
032600*   - Changed ADJ-AVG-MAP-AMT-GT-17 to 42.41
032700*   - Changed ADJ-AVG-MAP-AMT-LT-18 to 37.31
032800*   - Changed FIX-DOLLAR-LOSS-GT-17 to 77.54
032900*   - Changed FIX-DOLLAR-LOSS-LT-18 to 47.79
033000* - Put a '10' in PPS-2011-COMORBID-PAY for AKI claims
033100*
033200******************************************************************
033300 DATE-COMPILED.
033400 ENVIRONMENT DIVISION.
033500 CONFIGURATION SECTION.
033600 SOURCE-COMPUTER.            IBM-Z990.
033700 OBJECT-COMPUTER.            IBM-Z990.
033800 INPUT-OUTPUT  SECTION.
033900 FILE-CONTROL.
034000
034100 DATA DIVISION.
034200 FILE SECTION.
034300/
034400 WORKING-STORAGE SECTION.
034500 01  W-STORAGE-REF                  PIC X(46) VALUE
034600     'ESCAL180      - W O R K I N G   S T O R A G E'.
034700 01  CAL-VERSION                    PIC X(05) VALUE 'C18.0'.
034800
034900 01  DISPLAY-LINE-MEASUREMENT.
035000     05  FILLER                     PIC X(50) VALUE
035100         '....:...10....:...20....:...30....:...40....:...50'.
035200     05  FILLER                     PIC X(50) VALUE
035300         '....:...60....:...70....:...80....:...90....:..100'.
035400     05  FILLER                     PIC X(20) VALUE
035500         '....:..110....:..120'.
035600
035700 01  PRINT-LINE-MEASUREMENT.
035800     05  FILLER                     PIC X(51) VALUE
035900         'X....:...10....:...20....:...30....:...40....:...50'.
036000     05  FILLER                     PIC X(50) VALUE
036100         '....:...60....:...70....:...80....:...90....:..100'.
036200     05  FILLER                     PIC X(32) VALUE
036300         '....:..110....:..120....:..130..'.
036400/
036500******************************************************************
036600*  This area contains all of the old Composite Rate variables.   *
036700* They will be eliminated when the transition period ends - 2014 *
036800******************************************************************
036900 01  HOLD-COMP-RATE-PPS-COMPONENTS.
037000     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
037100     05  H-PYMT-AMT                 PIC 9(04)V9(02).
037200     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
037300     05  H-PATIENT-AGE              PIC 9(03).
037400     05  H-AGE-FACTOR               PIC 9(01)V9(03).
037500     05  H-BSA-FACTOR               PIC 9(01)V9(04).
037600     05  H-BMI-FACTOR               PIC 9(01)V9(04).
037700     05  H-BSA                      PIC 9(03)V9(04).
037800     05  H-BMI                      PIC 9(03)V9(04).
037900     05  HGT-PART                   PIC 9(04)V9(08).
038000     05  WGT-PART                   PIC 9(04)V9(08).
038100     05  COMBINED-PART              PIC 9(04)V9(08).
038200     05  CALC-BSA                   PIC 9(04)V9(08).
038300
038400
038500* The following two variables will change from year to year
038600* and are used for the COMPOSITE part of the Bundled Pricer.
038700 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
038800 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
038900
039000* The next two percentages MUST add up to 1 (i.e. 100%)
039100* They will continue to change until CY2009 when CBSA will be 1.00
039200 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
039300 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
039400
039500* CONSTANTS AREA
039600* The next two percentages MUST add up TO 1 (i.e. 100%)
039700 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
039800 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
039900
040000* The next variable is only applicapable for the 2011 Pricer.
040100 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
040200
040300 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
040400 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
040500 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
040600                                                         0.428571.
040700* The above number technically represents the fractional
040800* number 3/7 which is three days per week that a person can
040900* receive dialysis.  It will remain this value ONLY for the
041000* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
041100* use the calculation method which is more understandable and
041200* follows the method used by the Policy folks.
041300
041400*  The following number that is loaded into the payment equation
041500*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
041600*  and   --DOES NOT CHANGE--
041700
041800 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
041900
042000 01  COMPOSITE-RATE-MULTIPLIERS.
042100*Composite rate payment multiplier (used for blended providers)
042200     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
042300     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
042400     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
042500     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
042600     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
042700     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
042800
042900     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
043000     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
043100/
043200******************************************************************
043300*    This area contains all of the NEW Bundled Rate variables.   *
043400******************************************************************
043500 01  HOLD-BUNDLED-PPS-COMPONENTS.
043600     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
043700     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
043800     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
043900     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
044000     05  H-BUN-BSA                  PIC 9(03)V9(04).
044100     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
044200     05  H-BUN-BMI                  PIC 9(03)V9(04).
044300     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
044400     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
044500     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
044600     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
044700                                    PIC 9(07)V9(04).
044800     05  H-BUN-WAGE-ADJ-TRAINING-AMT
044900                                    PIC 9(07)V9(04).
045000     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
045100     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
045200     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
045300     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
045400     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
045500                                    PIC 9(07)V9(04).
045600     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
045700     05  H-LV-OUT-PREDICT-SERVICES-MAP
045800                                    PIC 9(07)V9(04).
045900     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
046000                                    PIC 9(07)V9(04).
046100     05  H-LV-OUT-PREDICTED-MAP
046200                                    PIC 9(07)V9(04).
046300     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
046400
046500     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
046600     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
046700         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
046800
046900     05  H-COMORBID-DATA  OCCURS 6 TIMES
047000            INDEXED BY H-COMORBID-INDEX
047100                                    PIC X(02).
047200     05  H-COMORBID-CWF-CODE        PIC X(02).
047300
047400     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
047500
047600     05  QIP-REDUCTION              PIC 9(01)V9(03).
047700     05  SUB                        PIC 9(04).
047800
047900     05  THE-DATE                   PIC 9(08).
048000     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
048100     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
048200     05  ONSET-DATE                 PIC 9(08).
048300     05  MOVED-CORMORBIDS           PIC X(01).
048400     05  H-BUN-RURAL-MULTIPLIER     PIC 9(01)V9(03).
048500     05  H-TDAPA-PAYMENT            PIC 9(07)V9(04).
048600
048700 01  HOLD-OUTLIER-PPS-COMPONENTS.
048800     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
048900     05  H-OUT-BSA                  PIC 9(03)V9(04).
049000     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
049100     05  H-OUT-BMI                  PIC 9(03)V9(04).
049200     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
049300     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
049400     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
049500     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
049600     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
049700     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
049800     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
049900     05  H-OUT-PREDICTED-SERVICES-MAP
050000                                    PIC 9(07)V9(04).
050100     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
050200     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
050300                                    PIC 9(07)V9(04).
050400     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
050500     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
050600     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
050700     05  H-OUT-RURAL-MULTIPLIER     PIC 9(01)V9(03).
050800
050900* The following variable will change from year to year and is
051000* used for the BUNDLED part of the Bundled Pricer.
051100 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 232.37.
051200
051300* The next two percentages MUST add up to 1 (i.e. 100%)
051400* They start in 2011 and will continue to change until CY2014 when
051500* BUN-CBSA-BLEND-PCT will be 1.00
051600* The third blend percent is for those providers that waived the
051700* blended percent and went to full PPS.  This variable will be
051800* eliminated in 2014 when it is no longer needed.
051900 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
052000 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
052100 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
052200
052300* CONSTANTS AREA
052400* The next two percentages MUST add up TO 1 (i.e. 100%)
052500 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.50673.
052600 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.49327.
052700 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 95.60.
052800
052900*  The following number that is loaded into the payment equation
053000*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
053100*  and   --DOES NOT CHANGE--
053200 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
053300
053400* Added a constant to hold the BSA-National-Average that is used
053500* in the BSA Calculation. This value changes every five years.
053600 01 BSA-NATIONAL-AVERAGE            PIC 9(01)V9(02) VALUE 1.90.
053700
053800 01  PEDIATRIC-MULTIPLIERS.
053900*Separately billable payment multiplier (used for outliers)
054000     05  PED-SEP-BILL-PAY-MULTI.
054100         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.410.
054200         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.406.
054300         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.569.
054400         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.494.
054500     05  PED-EXPAND-BUNDLE-PAY-MULTI.
054600*Expanded bundle payment multiplier (used for normal billing)
054700         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.063.
054800         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.306.
054900         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.102.
055000         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.327.
055100
055200 01  ADULT-MULTIPLIERS.
055300*Separately billable payment multiplier (used for outliers)
055400     05  SEP-BILLABLE-PAYMANT-MULTI.
055500         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 1.044.
055600         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 1.000.
055700         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.005.
055800         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
055900         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.961.
056000         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.000.
056100         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.090.
056200         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.409.
056300         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.209.
056400*        10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
056500         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.426.
056600         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.999.
056700         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.494.
056800*        10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
056900         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.955.
057000         10 SB-RURAL               PIC 9(01)V9(03) VALUE 0.978.
057100*Case-Mix adjusted payment multiplier (used for normal billing)
057200     05  CASE-MIX-PAYMENT-MULTI.
057300         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.257.
057400         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.068.
057500         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.070.
057600         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
057700         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.109.
057800         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.032.
057900         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.017.
058000         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.327.
058100         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.040.
058200*        10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
058300         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.082.
058400         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.192.
058500         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.095.
058600*        10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
058700         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.239.
058800         10 CM-RURAL               PIC 9(01)V9(03) VALUE 1.008.
058900
059000 01  OUTLIER-SB-CALC-AMOUNTS.
059100     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 37.31.
059200     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 42.41.
059300     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 47.79.
059400     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 77.54.
059500     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
059600     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
059700/
059800******************************************************************
059900*    This area contains return code variables and their codes.   *
060000******************************************************************
060100 01 PAID-RETURN-CODE-TRACKERS.
060200     05  OUTLIER-TRACK              PIC X(01).
060300     05  ACUTE-COMORBID-TRACK       PIC X(01).
060400     05  CHRONIC-COMORBID-TRACK     PIC X(01).
060500     05  ONSET-TRACK                PIC X(01).
060600     05  LOW-VOLUME-TRACK           PIC X(01).
060700     05  TRAINING-TRACK             PIC X(01).
060800     05  PEDIATRIC-TRACK            PIC X(01).
060900     05  LOW-BMI-TRACK              PIC X(01).
061000 COPY RTCCPY.
061100*COPY "RTCCPY.CPY".
061200*                                                                *
061300*  Legal combinations of adjustments for ADULTS are:             *
061400*     if NO ONSET applies, then they can have any combination of:*
061500*       acute OR chronic comorbid, & outlier, low vol., training.*
061600*     if ONSET applies, then they can have:                      *
061700*           outlier and/or low volume.                           *
061800*  Legal combinations of adjustments for PEDIATRIC are:          *
061900*     outlier and/or training.                                   *
062000*                                                                *
062100*  Illegal combinations of adjustments for PEDIATRIC are:        *
062200*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
062300*     onset     with comorbid or training.                       *
062400*  Illegal combinations of adjustments for ANYONE are:           *
062500*     acute comorbid AND chronic comorbid.                       *
062600/
062700 LINKAGE SECTION.
062800 COPY BILLCPY.
062900*COPY "BILLCPY.CPY".
063000/
063100 COPY WAGECPY.
063200*COPY "WAGECPY.CPY".
063300/
063400 PROCEDURE DIVISION  USING BILL-NEW-DATA
063500                           PPS-DATA-ALL
063600                           WAGE-NEW-RATE-RECORD
063700                           COM-CBSA-WAGE-RECORD
063800                           BUN-CBSA-WAGE-RECORD.
063900
064000******************************************************************
064100* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
064200* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
064300* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
064400* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
064500* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
064600* UTILIZED HERE HAS BEEN APPROVED BY THE DIVISION OF             *
064700* INSTITUTIONAL CLAIMS PROCESSING (DICP).                        *
064800*                                                                *
064900*    PROCESSING:                                                 *
065000*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
065100*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
065200*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
065300*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
065400*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
065500*           GOBACK.                                              *
065600*        D. ASSEMBLE PRICING COMPONENTS.                         *
065700*        E. CALCULATE THE PRICE.                                 *
065800******************************************************************
065900
066000 0000-START-TO-FINISH.
066100     INITIALIZE PPS-DATA-ALL.
066200
066300* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
066400     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
066500
066600
066700* ESRD PC PRICER USES NEXT FOUR LINES TO INITIALIZE VALUES
066800* THAT IT NEEDS TO DISPLAY DETAILED RESULTS
066900     IF BUNDLED-TEST THEN
067000        INITIALIZE BILL-DATA-TEST
067100        INITIALIZE COND-CD-73
067200     END-IF.
067300
067400     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
067500     MOVE ZEROS                        TO PPS-RTC.
067600
067700     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
067800
067900     IF PPS-RTC = 00  THEN
068000        PERFORM 1200-INITIALIZATION
068100        IF B-COND-CODE  = '84' THEN
068200* Calculate payment for AKI claim
068300           MOVE H-BUN-BASE-WAGE-AMT TO
068400                H-PPS-FINAL-PAY-AMT
068500           MOVE '02' TO PPS-RTC
068600           MOVE '10' TO PPS-2011-COMORBID-PAY
068700        ELSE
068800* Calculate payment for ESRD claim
068900            PERFORM 2000-CALCULATE-BUNDLED-FACTORS
069000            PERFORM 9000-SET-RETURN-CODE
069100        END-IF
069200        PERFORM 9100-MOVE-RESULTS
069300     END-IF.
069400
069500     GOBACK.
069600/
069700 1000-VALIDATE-BILL-ELEMENTS.
069800     IF PPS-RTC = 00  THEN
069900        IF B-COND-CODE NOT = '73' AND '74' AND '84' AND
070000                             '87' AND '  '
070100           MOVE 58                  TO PPS-RTC
070200        END-IF
070300     END-IF.
070400
070500     IF PPS-RTC = 00  THEN
070600        IF  P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
070700           NEXT SENTENCE
070800        ELSE
070900           MOVE 52                        TO PPS-RTC
071000        END-IF
071100     END-IF.
071200
071300     IF PPS-RTC = 00  THEN
071400        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
071500           MOVE 53                     TO PPS-RTC
071600        END-IF
071700     END-IF.
071800
071900     IF PPS-RTC = 00  THEN
072000        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
072100           MOVE 54                     TO PPS-RTC
072200        END-IF
072300     END-IF.
072400
072500     IF PPS-RTC = 00  THEN
072600        IF B-COND-CODE NOT = '84' THEN
072700           IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
072800              MOVE 55                     TO PPS-RTC
072900           END-IF
073000        END-IF
073100     END-IF.
073200
073300     IF PPS-RTC = 00  THEN
073400        IF B-COND-CODE NOT = '84' THEN
073500           IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
073600              MOVE 56                     TO PPS-RTC
073700           END-IF
073800        END-IF
073900     END-IF.
074000
074100     IF PPS-RTC = 00  THEN
074200        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
074300                                OR '0881'
074400           NEXT SENTENCE
074500        ELSE
074600           MOVE 57                     TO PPS-RTC
074700        END-IF
074800     END-IF.
074900
075000     IF PPS-RTC = 00  THEN
075100        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
075200                                 ' '  THEN
075300           MOVE 53                     TO PPS-RTC
075400*  This RTC is for the Special Payment Indicator not = '1' or
075500*  blank, which closely approximates the intent of the edit check.
075600*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
075700        END-IF
075800     END-IF.
075900
076000     IF PPS-RTC = 00  THEN
076100        IF B-COND-CODE NOT = '84' THEN
076200           IF B-PATIENT-HGT > 300.00
076300              MOVE 71                     TO PPS-RTC
076400           END-IF
076500        END-IF
076600     END-IF.
076700
076800     IF PPS-RTC = 00  THEN
076900        IF B-COND-CODE NOT = '84' THEN
077000           IF B-PATIENT-WGT > 500.00  THEN
077100              MOVE 72                     TO PPS-RTC
077200           END-IF
077300        END-IF
077400     END-IF.
077500
077600* Before 2012 pricer, put in edit check to make sure that the
077700* # of sesions does not exceed the # of days in a month.  Maybe
077800* the # of cays in a month minus one when patient goes into a
077900* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
078000* or 0851)).  If done, then will need extra RTC.
078100     IF PPS-RTC = 00  THEN
078200        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
078300           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
078400           MOVE 73                     TO PPS-RTC
078500        END-IF
078600     END-IF.
078700
078800     IF PPS-RTC = 00  THEN
078900        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
079000           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
079100           MOVE 74                     TO PPS-RTC
079200        END-IF
079300     END-IF.
079400
079500     IF PPS-RTC = 00  THEN
079600        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
079700           MOVE 75                     TO PPS-RTC
079800        END-IF
079900     END-IF.
080000
080100     IF PPS-RTC = 00  THEN
080200        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
080300           MOVE 76                     TO PPS-RTC
080400        END-IF
080500     END-IF.
080600*OLD WAY OF VALIDATING COMORBIDS
080700*    IF PPS-RTC = 00  THEN
080800*       IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
080900*           VALID-COMORBID-CWF-RETURN-CD       THEN
081000*          NEXT SENTENCE
081100*       ELSE
081200*          MOVE 81                     TO PPS-RTC
081300*      END-IF
081400*    END-IF.
081500*
081600*CY2016 - DROP PNEUMONIA & MONOCLONAL GAMM COMORBIDS
081700
081800     IF PPS-RTC = 00  THEN
081900        IF B-COND-CODE NOT = '84' THEN
082000           IF COMORBID-CWF-RETURN-CODE = SPACES OR
082100               "10" OR "20" OR "40" OR "50" OR "60" THEN
082200              NEXT SENTENCE
082300           ELSE
082400              MOVE 81                     TO PPS-RTC
082500           END-IF
082600        END-IF
082700     END-IF.
082800/
082900 1200-INITIALIZATION.
083000     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
083100     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
083200     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
083300     INITIALIZE PAID-RETURN-CODE-TRACKERS.
083400
083500
083600******************************************************************
083700***Calculate BUNDLED Wage Adjusted Rate                        ***
083800******************************************************************
083900     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
084000        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
084100         BUN-CBSA-W-INDEX.
084200
084300     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
084400        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
084500
084600     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
084700        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
084800/
084900 2000-CALCULATE-BUNDLED-FACTORS.
085000
085100     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
085200     IF B-DOB-MM > B-THRU-MM  THEN
085300        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
085400     END-IF
085500     IF H-PATIENT-AGE < 18  THEN
085600        MOVE "Y"                    TO PEDIATRIC-TRACK
085700     END-IF.
085800
085900     MOVE SPACES                       TO MOVED-CORMORBIDS.
086000
086100     IF P-QIP-REDUCTION = ' '  THEN
086200* no reduction
086300        MOVE 1.000 TO QIP-REDUCTION
086400     ELSE
086500        IF P-QIP-REDUCTION = '1'  THEN
086600* one-half percent reduction
086700           MOVE 0.995 TO QIP-REDUCTION
086800        ELSE
086900           IF P-QIP-REDUCTION = '2'  THEN
087000* one percent reduction
087100              MOVE 0.990 TO QIP-REDUCTION
087200           ELSE
087300              IF P-QIP-REDUCTION = '3'  THEN
087400* one and one-half percent reduction
087500                 MOVE 0.985 TO QIP-REDUCTION
087600              ELSE
087700* two percent reduction
087800                 MOVE 0.980 TO QIP-REDUCTION
087900              END-IF
088000           END-IF
088100        END-IF
088200     END-IF.
088300
088400*    Since pricer has to pay a comorbid condition according to the
088500* return code that CWF passes back, it is cleaner if the pricer
088600* sets aside whatever comorbid data exists on the line-item when
088700* it comes into the pricer and then transferrs the CWF code to
088800* the appropriate place in the comorbid data.  This avoids
088900* making convoluted changes in the other parts of the program
089000* which has to look at both original comorbid data AND CWF return
089100* codes to handle comorbids.  Near the end of the program where
089200* variables are transferred to the output, the original comorbid
089300* data is put back into its original place as though nothing
089400* occurred.
089500*CY2016 DROPPED MB & MF
089600     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
089700        NEXT SENTENCE
089800     ELSE
089900        MOVE 'Y'                       TO MOVED-CORMORBIDS
090000        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
090100        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
090200        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
090300        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
090400        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
090500        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
090600        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
090700        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
090800           MOVE SPACES                 TO COMORBID-DATA (1)
090900                                          COMORBID-DATA (2)
091000                                          COMORBID-DATA (3)
091100                                          COMORBID-DATA (4)
091200                                          COMORBID-DATA (5)
091300                                          COMORBID-DATA (6)
091400                                          COMORBID-CWF-RETURN-CODE
091500        ELSE
091600           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
091700              MOVE 'MA'                TO COMORBID-DATA (1)
091800              MOVE SPACES              TO COMORBID-DATA (2)
091900                                          COMORBID-DATA (3)
092000                                          COMORBID-DATA (4)
092100                                          COMORBID-DATA (5)
092200                                          COMORBID-DATA (6)
092300                                          COMORBID-CWF-RETURN-CODE
092400           ELSE
092500*             IF COMORBID-CWF-RETURN-CODE = '30'  THEN
092600*                MOVE SPACES           TO COMORBID-DATA (1)
092700*                MOVE 'MB'             TO COMORBID-DATA (2)
092800*                MOVE SPACES           TO COMORBID-DATA (3)
092900*                MOVE SPACES           TO COMORBID-DATA (4)
093000*                MOVE SPACES           TO COMORBID-DATA (5)
093100*                MOVE SPACES           TO COMORBID-DATA (6)
093200*                                         COMORBID-CWF-RETURN-CODE
093300*             ELSE
093400                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
093500                    MOVE SPACES        TO COMORBID-DATA (1)
093600                    MOVE SPACES        TO COMORBID-DATA (2)
093700                    MOVE 'MC'          TO COMORBID-DATA (3)
093800                    MOVE SPACES        TO COMORBID-DATA (4)
093900                    MOVE SPACES        TO COMORBID-DATA (5)
094000                    MOVE SPACES        TO COMORBID-DATA (6)
094100                                          COMORBID-CWF-RETURN-CODE
094200                 ELSE
094300                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
094400                       MOVE SPACES     TO COMORBID-DATA (1)
094500                       MOVE SPACES     TO COMORBID-DATA (2)
094600                       MOVE SPACES     TO COMORBID-DATA (3)
094700                       MOVE 'MD'       TO COMORBID-DATA (4)
094800                       MOVE SPACES     TO COMORBID-DATA (5)
094900                       MOVE SPACES     TO COMORBID-DATA (6)
095000                                          COMORBID-CWF-RETURN-CODE
095100                    ELSE
095200                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
095300                          MOVE SPACES  TO COMORBID-DATA (1)
095400                          MOVE SPACES  TO COMORBID-DATA (2)
095500                          MOVE SPACES  TO COMORBID-DATA (3)
095600                          MOVE SPACES  TO COMORBID-DATA (4)
095700                          MOVE 'ME'    TO COMORBID-DATA (5)
095800                          MOVE SPACES  TO COMORBID-DATA (6)
095900                                          COMORBID-CWF-RETURN-CODE
096000*                      ELSE
096100*                         MOVE SPACES  TO COMORBID-DATA (1)
096200*                                         COMORBID-DATA (2)
096300*                                         COMORBID-DATA (3)
096400*                                         COMORBID-DATA (4)
096500*                                         COMORBID-DATA (5)
096600*                                         COMORBID-CWF-RETURN-CODE
096700*                         MOVE 'MF'    TO COMORBID-DATA (6)
096800                       END-IF
096900                    END-IF
097000                 END-IF
097100*             END-IF
097200           END-IF
097300        END-IF
097400     END-IF.
097500******************************************************************
097600***  Set BUNDLED age adjustment factor                         ***
097700******************************************************************
097800     IF H-PATIENT-AGE < 13  THEN
097900        IF B-REV-CODE = '0821' OR '0881' THEN
098000           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
098100        ELSE
098200           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
098300        END-IF
098400     ELSE
098500        IF H-PATIENT-AGE < 18 THEN
098600           IF B-REV-CODE = '0821' OR '0881' THEN
098700              MOVE EB-AGE-13-17-HEMO-MODE
098800                                       TO H-BUN-AGE-FACTOR
098900           ELSE
099000              MOVE EB-AGE-13-17-PD-MODE
099100                                       TO H-BUN-AGE-FACTOR
099200           END-IF
099300        ELSE
099400           IF H-PATIENT-AGE < 45  THEN
099500              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
099600           ELSE
099700              IF H-PATIENT-AGE < 60  THEN
099800                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
099900              ELSE
100000                 IF H-PATIENT-AGE < 70  THEN
100100                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
100200                 ELSE
100300                    IF H-PATIENT-AGE < 80  THEN
100400                       MOVE CM-AGE-70-79
100500                                       TO H-BUN-AGE-FACTOR
100600                    ELSE
100700                       MOVE CM-AGE-80-PLUS
100800                                       TO H-BUN-AGE-FACTOR
100900                    END-IF
101000                 END-IF
101100              END-IF
101200           END-IF
101300        END-IF
101400     END-IF.
101500
101600******************************************************************
101700***  Calculate BUNDLED BSA factor (note NEW formula)           ***
101800******************************************************************
101900     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
102000         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
102100
102200     IF H-PATIENT-AGE > 17  THEN
102300        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
102400*            CM-BSA ** ((H-BUN-BSA - 1.90) / .1)
102500             CM-BSA ** ((H-BUN-BSA - BSA-NATIONAL-AVERAGE) / .1)
102600     ELSE
102700        MOVE 1.000                     TO H-BUN-BSA-FACTOR
102800     END-IF.
102900
103000******************************************************************
103100***  Calculate BUNDLED BMI factor                              ***
103200******************************************************************
103300     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
103400         (B-PATIENT-HGT ** 2)) * 10000.
103500
103600     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
103700        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
103800        MOVE "Y"                       TO LOW-BMI-TRACK
103900     ELSE
104000        MOVE 1.000                     TO H-BUN-BMI-FACTOR
104100     END-IF.
104200
104300******************************************************************
104400***  Calculate BUNDLED ONSET factor                            ***
104500******************************************************************
104600     IF B-DIALYSIS-START-DATE > ZERO  THEN
104700        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
104800        COMPUTE INTEGER-LINE-ITEM-DATE =
104900            FUNCTION INTEGER-OF-DATE(THE-DATE)
105000        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
105100        COMPUTE INTEGER-DIALYSIS-DATE  =
105200            FUNCTION INTEGER-OF-DATE(THE-DATE)
105300* Need to add one to onset-date because the start date should
105400* be included in the count of days.  fix made 9/6/2011
105500        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
105600                              INTEGER-DIALYSIS-DATE) + 1
105700        IF H-PATIENT-AGE > 17  THEN
105800           IF ONSET-DATE > 120  THEN
105900              MOVE 1                   TO H-BUN-ONSET-FACTOR
106000           ELSE
106100              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
106200              MOVE "Y"                 TO ONSET-TRACK
106300           END-IF
106400        ELSE
106500           MOVE 1                      TO H-BUN-ONSET-FACTOR
106600        END-IF
106700     ELSE
106800        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
106900     END-IF.
107000
107100******************************************************************
107200***  Set BUNDLED Co-morbidities adjustment                     ***
107300******************************************************************
107400     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
107500        IF H-PATIENT-AGE  <  18  THEN
107600           MOVE 1.000                  TO
107700                                       H-BUN-COMORBID-MULTIPLIER
107800           MOVE '10'                   TO PPS-2011-COMORBID-PAY
107900        ELSE
108000           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
108100              MOVE 1.000               TO
108200                                       H-BUN-COMORBID-MULTIPLIER
108300              MOVE '10'                TO PPS-2011-COMORBID-PAY
108400           ELSE
108500              PERFORM 2100-CALC-COMORBID-ADJUST
108600              MOVE H-COMORBID-MULTIPLIER TO
108700                                       H-BUN-COMORBID-MULTIPLIER
108800           END-IF
108900        END-IF
109000     ELSE
109100        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
109200           MOVE 1.000                  TO
109300                                       H-BUN-COMORBID-MULTIPLIER
109400           MOVE '10'                   TO PPS-2011-COMORBID-PAY
109500        ELSE
109600           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
109700              MOVE CM-GI-BLEED         TO
109800                                       H-BUN-COMORBID-MULTIPLIER
109900              MOVE '20'                TO PPS-2011-COMORBID-PAY
110000           ELSE
110100*            IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
110200*                MOVE CM-PNEUMONIA     TO
110300*                                      H-BUN-COMORBID-MULTIPLIER
110400*                MOVE '30'             TO PPS-2011-COMORBID-PAY
110500*            ELSE
110600                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
110700                    MOVE CM-PERICARDITIS TO
110800                                       H-BUN-COMORBID-MULTIPLIER
110900                    MOVE '40'          TO PPS-2011-COMORBID-PAY
111000                 END-IF
111100*            END-IF
111200           END-IF
111300        END-IF
111400     END-IF.
111500
111600******************************************************************
111700***  Calculate BUNDLED Low Volume adjustment                   ***
111800******************************************************************
111900     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
112000        IF H-PATIENT-AGE > 17  THEN
112100           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
112200                                       H-BUN-LOW-VOL-MULTIPLIER
112300           MOVE "Y"                    TO  LOW-VOLUME-TRACK
112400        ELSE
112500           MOVE 1.000                  TO
112600                                       H-BUN-LOW-VOL-MULTIPLIER
112700        END-IF
112800     ELSE
112900        MOVE 1.000                     TO
113000                                       H-BUN-LOW-VOL-MULTIPLIER
113100     END-IF.
113200
113300***************************************************************
113400* Calculate Rural Adjustment Multiplier ADDED CY 2016
113500***************************************************************
113600     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
113700        MOVE CM-RURAL TO H-BUN-RURAL-MULTIPLIER
113800     ELSE
113900        MOVE 1.000 TO H-BUN-RURAL-MULTIPLIER.
114000
114100******************************************************************
114200***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
114300******************************************************************
114400     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
114500        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
114600        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
114700        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
114800        H-BUN-LOW-VOL-MULTIPLIER * H-BUN-RURAL-MULTIPLIER.
114900
115000******************************************************************
115100***  Calculate BUNDLED Condition Code payment                  ***
115200******************************************************************
115300* Self-care in Training add-on
115400     IF B-COND-CODE = '73' OR '87' THEN
115500* no add-on when onset is present
115600        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
115700           MOVE ZERO                   TO
115800                                    H-BUN-WAGE-ADJ-TRAINING-AMT
115900        ELSE
116000* use new PPS training add-on amount times wage-index
116100           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
116200             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
116300           MOVE "Y"                    TO TRAINING-TRACK
116400        END-IF
116500     ELSE
116600* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
116700        IF (B-COND-CODE = '74')  AND
116800           (B-REV-CODE = '0841' OR '0851')  THEN
116900              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
117000                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
117100        ELSE
117200           MOVE ZERO                   TO
117300                                    H-BUN-WAGE-ADJ-TRAINING-AMT
117400                                    H-CC-74-PER-DIEM-AMT
117500        END-IF
117600     END-IF.
117700
117800******************************************************************
117900***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
118000******************************************************************
118100     IF (B-COND-CODE = '74')  AND
118200        (B-REV-CODE = '0841' OR '0851')  THEN
118300           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
118400                           H-CC-74-PER-DIEM-AMT
118500           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
118600              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
118700              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
118800     ELSE COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
118900                  H-BUN-ADJUSTED-BASE-WAGE-AMT  +
119000                  H-BUN-WAGE-ADJ-TRAINING-AMT
119100     END-IF.
119200
119300****************************************************************
119400***  Include TDAPA Payment                                   ***
119500****************************************************************
119600     COMPUTE H-TDAPA-PAYMENT = B-PAYER-ONLY-VC-Q8 /
119700                               B-CLAIM-NUM-DIALYSIS-SESSIONS.
119800     COMPUTE H-PPS-FINAL-PAY-AMT = H-PPS-FINAL-PAY-AMT +
119900                                   H-TDAPA-PAYMENT.
120000
120100******************************************************************
120200***  Calculate BUNDLED Outlier                                 ***
120300******************************************************************
120400     PERFORM 2500-CALC-OUTLIER-FACTORS.
120500
120600******************************************************************
120700***  Calculate Low Volume payment for recovery purposes        ***
120800******************************************************************
120900     IF LOW-VOLUME-TRACK = "Y"  THEN
121000        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
121100        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
121200
121300        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
121400           H-PPS-FINAL-PAY-AMT
121500
121600        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
121700           H-OUT-PAYMENT
121800
121900        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
122000           H-LV-OUT-PAYMENT
122100
122200        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
122300           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
122400              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
122500        ELSE
122600           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
122700        END-IF
122800     END-IF.
122900
123000
123100/
123200 2100-CALC-COMORBID-ADJUST.
123300******************************************************************
123400***  Calculate Co-morbidities adjustment                       ***
123500******************************************************************
123600*  This logic assumes that the comorbids are randomly assigned   *
123700*to the comorbid table.  It will select the highest comorbid for *
123800*payment if one is found.  CY 2016 DROPPED MB & MF              *
123900******************************************************************
124000     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
124100     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
124200     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
124300
124400     PERFORM VARYING  SUB  FROM  1 BY 1
124500       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
124600         IF COMORBID-DATA (SUB) = 'MA'  THEN
124700           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
124800*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
124900           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
125000           MOVE '20'                   TO PPS-2011-COMORBID-PAY
125100         ELSE
125200*          IF COMORBID-DATA (SUB) = 'MB'  THEN
125300*            IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
125400*              MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
125500*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
125600*              MOVE '30'               TO PPS-2011-COMORBID-PAY
125700*            END-IF
125800*          ELSE
125900             IF COMORBID-DATA (SUB) = 'MC'  THEN
126000                IF CM-PERICARDITIS  >
126100                                      H-COMORBID-MULTIPLIER  THEN
126200                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
126300                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
126400                  MOVE '40'            TO PPS-2011-COMORBID-PAY
126500                END-IF
126600             ELSE
126700               IF COMORBID-DATA (SUB) = 'MD'  THEN
126800                 IF CM-MYELODYSPLASTIC  >
126900                                      H-COMORBID-MULTIPLIER  THEN
127000                   MOVE CM-MYELODYSPLASTIC  TO
127100                                      H-COMORBID-MULTIPLIER
127200                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
127300                   MOVE '50'           TO PPS-2011-COMORBID-PAY
127400                 END-IF
127500               ELSE
127600                 IF COMORBID-DATA (SUB) = 'ME'  THEN
127700                   IF CM-SICKEL-CELL  >
127800                                      H-COMORBID-MULTIPLIER  THEN
127900                     MOVE CM-SICKEL-CELL  TO
128000                                      H-COMORBID-MULTIPLIER
128100                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
128200                     MOVE '60'         TO PPS-2011-COMORBID-PAY
128300                   END-IF
128400*                ELSE
128500*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
128600*                    IF CM-MONOCLONAL-GAMM  >
128700*                                     H-COMORBID-MULTIPLIER  THEN
128800*                      MOVE CM-MONOCLONAL-GAMM TO
128900*                                     H-COMORBID-MULTIPLIER
129000*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
129100*                      MOVE '70'       TO PPS-2011-COMORBID-PAY
129200*                    END-IF
129300*                  END-IF
129400                 END-IF
129500               END-IF
129600             END-IF
129700*          END-IF
129800         END-IF
129900     END-PERFORM.
130000/
130100 2500-CALC-OUTLIER-FACTORS.
130200******************************************************************
130300***  Set separately billable OUTLIER age adjustment factor     ***
130400******************************************************************
130500     IF H-PATIENT-AGE < 13  THEN
130600        IF B-REV-CODE = '0821' OR '0881' THEN
130700           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
130800        ELSE
130900           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
131000        END-IF
131100     ELSE
131200        IF H-PATIENT-AGE < 18 THEN
131300           IF B-REV-CODE = '0821' OR '0881'  THEN
131400              MOVE SB-AGE-13-17-HEMO-MODE
131500                                       TO H-OUT-AGE-FACTOR
131600           ELSE
131700              MOVE SB-AGE-13-17-PD-MODE
131800                                       TO H-OUT-AGE-FACTOR
131900           END-IF
132000        ELSE
132100           IF H-PATIENT-AGE < 45  THEN
132200              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
132300           ELSE
132400              IF H-PATIENT-AGE < 60  THEN
132500                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
132600              ELSE
132700                 IF H-PATIENT-AGE < 70  THEN
132800                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
132900                 ELSE
133000                    IF H-PATIENT-AGE < 80  THEN
133100                       MOVE SB-AGE-70-79
133200                                       TO H-OUT-AGE-FACTOR
133300                    ELSE
133400                       MOVE SB-AGE-80-PLUS
133500                                       TO H-OUT-AGE-FACTOR
133600                    END-IF
133700                 END-IF
133800              END-IF
133900           END-IF
134000        END-IF
134100     END-IF.
134200
134300******************************************************************
134400**Calculate separately billable OUTLIER BSA factor (superscript)**
134500******************************************************************
134600     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
134700         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
134800
134900     IF H-PATIENT-AGE > 17  THEN
135000        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
135100*            SB-BSA ** ((H-OUT-BSA - 1.90) / .1)
135200             SB-BSA ** ((H-OUT-BSA - BSA-NATIONAL-AVERAGE) / .1)
135300     ELSE
135400        MOVE 1.000                     TO H-OUT-BSA-FACTOR
135500     END-IF.
135600
135700******************************************************************
135800***  Calculate separately billable OUTLIER BMI factor          ***
135900******************************************************************
136000     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
136100         (B-PATIENT-HGT ** 2)) * 10000.
136200
136300     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
136400        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
136500     ELSE
136600        MOVE 1.000                     TO H-OUT-BMI-FACTOR
136700     END-IF.
136800
136900******************************************************************
137000***  Calculate separately billable OUTLIER ONSET factor        ***
137100******************************************************************
137200     IF B-DIALYSIS-START-DATE > ZERO  THEN
137300        IF H-PATIENT-AGE > 17  THEN
137400           IF ONSET-DATE > 120  THEN
137500              MOVE 1                   TO H-OUT-ONSET-FACTOR
137600           ELSE
137700              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
137800           END-IF
137900        ELSE
138000           MOVE 1                      TO H-OUT-ONSET-FACTOR
138100        END-IF
138200     ELSE
138300        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
138400     END-IF.
138500
138600******************************************************************
138700***  Set separately billable OUTLIER Co-morbidities adjustment ***
138800* CY 2016 DROPPED MB & MF
138900******************************************************************
139000     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
139100        IF H-PATIENT-AGE  <  18  THEN
139200           MOVE 1.000                  TO
139300                                       H-OUT-COMORBID-MULTIPLIER
139400           MOVE '10'                   TO PPS-2011-COMORBID-PAY
139500        ELSE
139600           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
139700              MOVE 1.000               TO
139800                                       H-OUT-COMORBID-MULTIPLIER
139900              MOVE '10'                TO PPS-2011-COMORBID-PAY
140000           ELSE
140100              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
140200           END-IF
140300        END-IF
140400     ELSE
140500        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
140600           MOVE 1.000                  TO
140700                                       H-OUT-COMORBID-MULTIPLIER
140800        ELSE
140900           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
141000              MOVE SB-GI-BLEED         TO
141100                                       H-OUT-COMORBID-MULTIPLIER
141200           ELSE
141300*             IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
141400*                MOVE SB-PNEUMONIA     TO
141500*                                      H-OUT-COMORBID-MULTIPLIER
141600*             ELSE
141700                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
141800                    MOVE SB-PERICARDITIS TO
141900                                       H-OUT-COMORBID-MULTIPLIER
142000                 END-IF
142100*             END-IF
142200           END-IF
142300        END-IF
142400     END-IF.
142500
142600******************************************************************
142700***  Set OUTLIER low-volume-multiplier                         ***
142800******************************************************************
142900     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
143000        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
143100     ELSE
143200        IF H-PATIENT-AGE < 18  THEN
143300           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
143400        ELSE
143500           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
143600           MOVE "Y"                    TO LOW-VOLUME-TRACK
143700        END-IF
143800     END-IF.
143900
144000***************************************************************
144100* Calculate OUTLIER Rural Adjustment multiplier
144200***************************************************************
144300
144400     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
144500        MOVE SB-RURAL TO H-OUT-RURAL-MULTIPLIER
144600     ELSE
144700        MOVE 1.000 TO H-OUT-RURAL-MULTIPLIER.
144800
144900******************************************************************
145000***  Calculate predicted OUTLIER services MAP per treatment    ***
145100******************************************************************
145200     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
145300        (H-OUT-AGE-FACTOR             *
145400         H-OUT-BSA-FACTOR             *
145500         H-OUT-BMI-FACTOR             *
145600         H-OUT-ONSET-FACTOR           *
145700         H-OUT-COMORBID-MULTIPLIER    *
145800         H-OUT-RURAL-MULTIPLIER       *
145900         H-OUT-LOW-VOL-MULTIPLIER).
146000
146100******************************************************************
146200***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
146300******************************************************************
146400     IF H-PATIENT-AGE < 18  THEN
146500        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
146600           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
146700        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
146800     ELSE
146900
147000        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
147100           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
147200        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
147300     END-IF.
147400
147500******************************************************************
147600*** Calculate imputed OUTLIER services MAP amount per treatment***
147700******************************************************************
147800     IF (B-COND-CODE = '74')  AND
147900        (B-REV-CODE = '0841' OR '0851')  THEN
148000         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
148100            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
148200         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
148300         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
148400     ELSE
148500        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
148600        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
148700     END-IF.
148800
148900******************************************************************
149000*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
149100******************************************************************
149200     IF H-PATIENT-AGE < 18   THEN
149300        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
149400           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
149500        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
149600        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
149700           COMPUTE H-OUT-PAYMENT  ROUNDED  =
149800            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
149900                                         LOSS-SHARING-PCT-LT-18
150000           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
150100           MOVE "Y"                    TO OUTLIER-TRACK
150200        ELSE
150300           MOVE ZERO                   TO H-OUT-PAYMENT
150400           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
150500        END-IF
150600     ELSE
150700        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
150800           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
150900           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
151000        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
151100           COMPUTE H-OUT-PAYMENT  ROUNDED  =
151200            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
151300                                         LOSS-SHARING-PCT-GT-17
151400           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
151500           MOVE "Y"                    TO OUTLIER-TRACK
151600        ELSE
151700           MOVE ZERO                   TO H-OUT-PAYMENT
151800        END-IF
151900     END-IF.
152000
152100     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
152200
152300* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
152400     IF (B-COND-CODE = '74')  AND
152500        (B-REV-CODE = '0841' OR '0851')  THEN
152600           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
152700             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
152800     END-IF.
152900/
153000 2600-CALC-COMORBID-OUT-ADJUST.
153100******************************************************************
153200***  Calculate OUTLIER Co-morbidities adjustment               ***
153300******************************************************************
153400*  This logic assumes that the comorbids are randomly assigned   *
153500*to the comorbid table.  It will select the highest comorbid for *
153600*payment if one is found. CY 2016 DROPPED MB & MF                *
153700******************************************************************
153800
153900     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
154000     MOVE 1.000                        TO
154100                                  H-OUT-COMORBID-MULTIPLIER.
154200
154300     PERFORM VARYING  SUB  FROM  1 BY 1
154400       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
154500         IF COMORBID-DATA (SUB) = 'MA'  THEN
154600           MOVE SB-GI-BLEED            TO
154700                                  H-OUT-COMORBID-MULTIPLIER
154800*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
154900           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
155000         ELSE
155100*          IF COMORBID-DATA (SUB) = 'MB'  THEN
155200*            IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
155300*              MOVE SB-PNEUMONIA       TO
155400*                                 H-OUT-COMORBID-MULTIPLIER
155500*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
155600*            END-IF
155700*          ELSE
155800             IF COMORBID-DATA (SUB) = 'MC'  THEN
155900                IF SB-PERICARDITIS  >
156000                                  H-OUT-COMORBID-MULTIPLIER  THEN
156100                  MOVE SB-PERICARDITIS TO
156200                                  H-OUT-COMORBID-MULTIPLIER
156300                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
156400                END-IF
156500             ELSE
156600               IF COMORBID-DATA (SUB) = 'MD'  THEN
156700                 IF SB-MYELODYSPLASTIC  >
156800                                  H-OUT-COMORBID-MULTIPLIER  THEN
156900                   MOVE SB-MYELODYSPLASTIC  TO
157000                                  H-OUT-COMORBID-MULTIPLIER
157100                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
157200                 END-IF
157300               ELSE
157400                 IF COMORBID-DATA (SUB) = 'ME'  THEN
157500                   IF SB-SICKEL-CELL  >
157600                                 H-OUT-COMORBID-MULTIPLIER  THEN
157700                     MOVE SB-SICKEL-CELL  TO
157800                                  H-OUT-COMORBID-MULTIPLIER
157900                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
158000                   END-IF
158100*                ELSE
158200*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
158300*                    IF SB-MONOCLONAL-GAMM  >
158400*                                 H-OUT-COMORBID-MULTIPLIER  THEN
158500*                      MOVE SB-MONOCLONAL-GAMM  TO
158600*                                 H-OUT-COMORBID-MULTIPLIER
158700*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
158800*                    END-IF
158900*                  END-IF
159000                 END-IF
159100               END-IF
159200             END-IF
159300*          END-IF
159400         END-IF
159500     END-PERFORM.
159600/
159700******************************************************************
159800*** Calculate Low Volume Full PPS payment for recovery purposes***
159900******************************************************************
160000 3000-LOW-VOL-FULL-PPS-PAYMENT.
160100******************************************************************
160200** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
160300     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
160400        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
160500        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
160600        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
160700         H-BUN-RURAL-MULTIPLIER.
160800
160900******************************************************************
161000**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
161100* Self-care in Training add-on
161200     IF B-COND-CODE = '73' OR '87' THEN
161300* no add-on when onset is present
161400        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
161500           MOVE ZERO                   TO
161600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
161700        ELSE
161800* use new PPS training add-on amount times wage-index
161900           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
162000             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
162100           MOVE "Y"                    TO TRAINING-TRACK
162200        END-IF
162300     ELSE
162400* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
162500        IF (B-COND-CODE = '74')  AND
162600           (B-REV-CODE = '0841' OR '0851')  THEN
162700              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
162800                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
162900        ELSE
163000           MOVE ZERO                   TO
163100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
163200                                    H-CC-74-PER-DIEM-AMT
163300        END-IF
163400     END-IF.
163500
163600******************************************************************
163700**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
163800     IF (B-COND-CODE = '74')  AND
163900        (B-REV-CODE = '0841' OR '0851')  THEN
164000           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
164100                           H-CC-74-PER-DIEM-AMT
164200     ELSE
164300        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
164400                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
164500                H-BUN-WAGE-ADJ-TRAINING-AMT
164600     END-IF.
164700
164800/
164900******************************************************************
165000*** Calculate Low Volume OUT PPS payment for recovery purposes ***
165100******************************************************************
165200 3100-LOW-VOL-OUT-PPS-PAYMENT.
165300******************************************************************
165400**Modified code from 'Calc predict OUT serv MAP per treat' para.**
165500     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
165600        (H-OUT-AGE-FACTOR             *
165700         H-OUT-BSA-FACTOR             *
165800         H-OUT-BMI-FACTOR             *
165900         H-OUT-ONSET-FACTOR           *
166000         H-OUT-COMORBID-MULTIPLIER    *
166100         H-OUT-RURAL-MULTIPLIER).
166200
166300******************************************************************
166400**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
166500     IF H-PATIENT-AGE < 18  THEN
166600        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
166700           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
166800        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
166900     ELSE
167000        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
167100           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
167200        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
167300     END-IF.
167400
167500******************************************************************
167600** 'Calculate imput OUT services MAP amount per treatment' para **
167700** It is not necessary to modify or insert this paragraph here. **
167800
167900******************************************************************
168000**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
168100     IF H-PATIENT-AGE < 18   THEN
168200        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
168300           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
168400        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
168500        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
168600           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
168700            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
168800                                         LOSS-SHARING-PCT-LT-18
168900           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
169000        ELSE
169100           MOVE ZERO                   TO H-LV-OUT-PAYMENT
169200           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
169300        END-IF
169400     ELSE
169500        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
169600           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
169700           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
169800        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
169900           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
170000            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
170100                                         LOSS-SHARING-PCT-GT-17
170200           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
170300        ELSE
170400           MOVE ZERO                   TO H-LV-OUT-PAYMENT
170500        END-IF
170600     END-IF.
170700
170800     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
170900
171000* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
171100     IF (B-COND-CODE = '74')  AND
171200        (B-REV-CODE = '0841' OR '0851')  THEN
171300           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
171400             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
171500     END-IF.
171600
171700
171800/
171900 9000-SET-RETURN-CODE.
172000******************************************************************
172100***  Set the return code                                       ***
172200******************************************************************
172300*   The following 'table' helps in understanding and in making   *
172400*changes to the rather large and complex "IF" statement that     *
172500*follows.  This 'table' just reorders and rewords the comments   *
172600*contained in the working storage area concerning the paid       *
172700*return-codes.                                                   *
172800*                                                                *
172900*  17 = pediatric, outlier, training                             *
173000*  16 = pediatric, outlier                                       *
173100*  15 = pediatric, training                                      *
173200*  14 = pediatric                                                *
173300*                                                                *
173400*  24 = outlier, low volume, training, chronic comorbid          *
173500*  19 = outlier, low volume, training, acute comorbid            *
173600*  29 = outlier, low volume, training                            *
173700*  23 = outlier, low volume, chronic comorbid                    *
173800*  18 = outlier, low volume, acute comorbid                      *
173900*  30 = outlier, low volume, onset                               *
174000*  28 = outlier, low volume                                      *
174100*  34 = outlier, training, chronic comorbid                      *
174200*  35 = outlier, training, acute comorbid                        *
174300*  33 = outlier, training                                        *
174400*  07 = outlier, chronic comorbid                                *
174500*  06 = outlier, acute comorbid                                  *
174600*  09 = outlier, onset                                           *
174700*  03 = outlier                                                  *
174800*                                                                *
174900*  26 = low volume, training, chronic comorbid                   *
175000*  21 = low volume, training, acute comorbid                     *
175100*  12 = low volume, training                                     *
175200*  25 = low volume, chronic comorbid                             *
175300*  20 = low volume, acute comorbid                               *
175400*  32 = low volume, onset                                        *
175500*  10 = low volume                                               *
175600*                                                                *
175700*  27 = training, chronic comorbid                               *
175800*  22 = training, acute comorbid                                 *
175900*  11 = training                                                 *
176000*                                                                *
176100*  08 = onset                                                    *
176200*  04 = acute comorbid                                           *
176300*  05 = chronic comorbid                                         *
176400*  31 = low BMI                                                  *
176500*  02 = no adjustments                                           *
176600*                                                                *
176700*  13 = w/multiple adjustments....reserved for future use        *
176800******************************************************************
176900/
177000     IF PEDIATRIC-TRACK                       = "Y"  THEN
177100        IF OUTLIER-TRACK                      = "Y"  THEN
177200           IF TRAINING-TRACK                  = "Y"  THEN
177300              MOVE 17                  TO PPS-RTC
177400           ELSE
177500              MOVE 16                  TO PPS-RTC
177600           END-IF
177700        ELSE
177800           IF TRAINING-TRACK                  = "Y"  THEN
177900              MOVE 15                  TO PPS-RTC
178000           ELSE
178100              MOVE 14                  TO PPS-RTC
178200           END-IF
178300        END-IF
178400     ELSE
178500        IF OUTLIER-TRACK                      = "Y"  THEN
178600           IF LOW-VOLUME-TRACK                = "Y"  THEN
178700              IF TRAINING-TRACK               = "Y"  THEN
178800                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
178900                    MOVE 24            TO PPS-RTC
179000                 ELSE
179100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
179200                       MOVE 19         TO PPS-RTC
179300                    ELSE
179400                       MOVE 29         TO PPS-RTC
179500                    END-IF
179600                 END-IF
179700              ELSE
179800                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
179900                    MOVE 23            TO PPS-RTC
180000                 ELSE
180100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
180200                       MOVE 18         TO PPS-RTC
180300                    ELSE
180400                       IF ONSET-TRACK         = "Y"  THEN
180500                          MOVE 30      TO PPS-RTC
180600                       ELSE
180700                          MOVE 28      TO PPS-RTC
180800                       END-IF
180900                    END-IF
181000                 END-IF
181100              END-IF
181200           ELSE
181300              IF TRAINING-TRACK               = "Y"  THEN
181400                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
181500                    MOVE 34            TO PPS-RTC
181600                 ELSE
181700                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
181800                       MOVE 35         TO PPS-RTC
181900                    ELSE
182000                       MOVE 33         TO PPS-RTC
182100                    END-IF
182200                 END-IF
182300              ELSE
182400                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
182500                    MOVE 07            TO PPS-RTC
182600                 ELSE
182700                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
182800                       MOVE 06         TO PPS-RTC
182900                    ELSE
183000                       IF ONSET-TRACK         = "Y"  THEN
183100                          MOVE 09      TO PPS-RTC
183200                       ELSE
183300                          MOVE 03      TO PPS-RTC
183400                       END-IF
183500                    END-IF
183600                 END-IF
183700              END-IF
183800           END-IF
183900        ELSE
184000           IF LOW-VOLUME-TRACK                = "Y"
184100              IF TRAINING-TRACK               = "Y"  THEN
184200                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
184300                    MOVE 26            TO PPS-RTC
184400                 ELSE
184500                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
184600                       MOVE 21         TO PPS-RTC
184700                    ELSE
184800                       MOVE 12         TO PPS-RTC
184900                    END-IF
185000                 END-IF
185100              ELSE
185200                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
185300                    MOVE 25            TO PPS-RTC
185400                 ELSE
185500                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
185600                       MOVE 20         TO PPS-RTC
185700                    ELSE
185800                       IF ONSET-TRACK         = "Y"  THEN
185900                          MOVE 32      TO PPS-RTC
186000                       ELSE
186100                          MOVE 10      TO PPS-RTC
186200                       END-IF
186300                    END-IF
186400                 END-IF
186500              END-IF
186600           ELSE
186700              IF TRAINING-TRACK               = "Y"  THEN
186800                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
186900                    MOVE 27            TO PPS-RTC
187000                 ELSE
187100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
187200                       MOVE 22         TO PPS-RTC
187300                    ELSE
187400                       MOVE 11         TO PPS-RTC
187500                    END-IF
187600                 END-IF
187700              ELSE
187800                 IF ONSET-TRACK               = "Y"  THEN
187900                    MOVE 08            TO PPS-RTC
188000                 ELSE
188100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
188200                       MOVE 04         TO PPS-RTC
188300                    ELSE
188400                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
188500                          MOVE 05      TO PPS-RTC
188600                       ELSE
188700                          IF LOW-BMI-TRACK = "Y"  THEN
188800                             MOVE 31 TO PPS-RTC
188900                          ELSE
189000                             MOVE 02 TO PPS-RTC
189100                          END-IF
189200                       END-IF
189300                    END-IF
189400                 END-IF
189500              END-IF
189600           END-IF
189700        END-IF
189800     END-IF.
189900
190000/
190100 9100-MOVE-RESULTS.
190200     IF MOVED-CORMORBIDS = SPACES  THEN
190300        NEXT SENTENCE
190400     ELSE
190500        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
190600        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
190700        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
190800        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
190900        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
191000        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
191100        MOVE H-COMORBID-CWF-CODE       TO
191200                                    COMORBID-CWF-RETURN-CODE
191300     END-IF.
191400
191500     MOVE P-GEO-MSA                    TO PPS-MSA.
191600     MOVE P-GEO-CBSA                   TO PPS-CBSA.
191700     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
191800     MOVE B-COND-CODE                  TO PPS-COND-CODE.
191900     MOVE B-REV-CODE                   TO PPS-REV-CODE.
192000     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
192100     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
192200     MOVE BUN-NAT-NONLABOR-PCT         TO
192300                                    PPS-2011-NAT-NONLABOR-PCT.
192400     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
192500     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
192600     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
192700     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
192800     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
192900     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
193000     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
193100     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
193200     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
193300     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
193400                                    PPS-2011-BDGT-NEUT-RATE.
193500     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
193600     MOVE SPACES                       TO
193700                                    PPS-2011-COMORBID-MA-CC.
193800
193900     IF (B-COND-CODE = '74')  AND
194000        (B-REV-CODE = '0841' OR '0851')  THEN
194100         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
194200                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
194300     END-IF.
194400
194500     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
194600           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
194700              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
194800           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
194900              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
195000           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
195100              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
195200     ELSE
195300        MOVE ZERO                      TO
195400                                    PPS-2011-BLEND-COMP-RATE
195500        MOVE ZERO                      TO
195600                                    PPS-2011-BLEND-PPS-RATE
195700        MOVE ZERO                      TO
195800                                    PPS-2011-BLEND-OUTLIER-RATE
195900     END-IF.
196000
196100     MOVE H-PYMT-AMT                   TO
196200                                    PPS-2011-FULL-COMP-RATE.
196300     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
196400                                          PPS-FINAL-PAY-AMT.
196500     MOVE H-OUT-PAYMENT                TO
196600                                    PPS-2011-FULL-OUTLIER-RATE.
196700
196800     MOVE H-TDAPA-PAYMENT              TO TDAPA-RETURN.
196900
197000     IF B-COND-CODE NOT = '84' THEN
197100        IF P-QIP-REDUCTION = ' ' THEN
197200           NEXT SENTENCE
197300        ELSE
197400           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
197500                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
197600           COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
197700                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
197800           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
197900                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
198000           COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
198100                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
198200           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
198300                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
198400           COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
198500                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
198600        END-IF
198700     END-IF.
198800
198900*ESRD PC PRICER NEEDS BUNDLED-TEST-INDIC SET TO "T" IN ORDER TO BE
199000*TO PASS VALUES FOR DISPLAYING DETAILED RESULTS FROM BILL-DATA-TES
199100*BUNDLED-TEST-INDIC IS NOT SET TO "T"  IN THE PRODUCTION SYSTEM (F
199200     IF BUNDLED-TEST   THEN
199300        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
199400        MOVE 0.0                       TO MSA-WAGE-ADJ
199500        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
199600        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
199700        MOVE H-PATIENT-AGE             TO AGE-RETURN
199800        MOVE 0.0                       TO MSA-WAGE-AMT
199900        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
200000        MOVE H-BMI                     TO PPS-BMI
200100        MOVE H-BSA                     TO PPS-BSA
200200        MOVE MSA-BLEND-PCT             TO MSA-PCT
200300        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
200400
200500        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
200600           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
200700           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
200800        ELSE
200900           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
201000           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
201100        END-IF
201200
201300        MOVE H-BUN-BSA                 TO BUN-BSA
201400        MOVE H-BUN-BMI                 TO BUN-BMI
201500        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
201600        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
201700        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
201800        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
201900        MOVE H-OUT-BSA                 TO OUT-BSA
202000        MOVE SB-BSA                    TO OUT-SB-BSA
202100        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
202200        MOVE H-OUT-BMI                 TO OUT-BMI
202300        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
202400        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
202500        MOVE H-OUT-COMORBID-MULTIPLIER TO
202600                                    OUT-COMORBID-MULTIPLIER
202700        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
202800                                    OUT-PREDICTED-SERVICES-MAP
202900        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
203000                                    OUT-CASE-MIX-PREDICTED-MAP
203100        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
203200                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
203300        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
203400        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
203500        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
203600        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
203700        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
203800        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
203900        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
204000        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
204100        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
204200        MOVE CM-BSA                    TO PPS-CM-BSA
204300        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
204400        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
204500        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
204600        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
204700                                    BUN-ADJUSTED-BASE-WAGE-AMT
204800        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
204900                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
205000        MOVE TRAINING-ADD-ON-PMT-AMT   TO
205100                                    PPS-TRAINING-ADD-ON-PMT-AMT
205200        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
205300     END-IF.
205400******        L A S T   S O U R C E   S T A T E M E N T      *****
