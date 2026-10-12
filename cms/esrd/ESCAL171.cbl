000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL171.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JULY 1, 2017
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
031700******************************************************************
031800 DATE-COMPILED.
031900 ENVIRONMENT DIVISION.
032000 CONFIGURATION SECTION.
032100 SOURCE-COMPUTER.            IBM-Z990.
032200 OBJECT-COMPUTER.            IBM-Z990.
032300 INPUT-OUTPUT  SECTION.
032400 FILE-CONTROL.
032500
032600 DATA DIVISION.
032700 FILE SECTION.
032800/
032900 WORKING-STORAGE SECTION.
033000 01  W-STORAGE-REF                  PIC X(46) VALUE
033100     'ESCAL171      - W O R K I N G   S T O R A G E'.
033200 01  CAL-VERSION                    PIC X(05) VALUE 'C17.1'.
033300
033400 01  DISPLAY-LINE-MEASUREMENT.
033500     05  FILLER                     PIC X(50) VALUE
033600         '....:...10....:...20....:...30....:...40....:...50'.
033700     05  FILLER                     PIC X(50) VALUE
033800         '....:...60....:...70....:...80....:...90....:..100'.
033900     05  FILLER                     PIC X(20) VALUE
034000         '....:..110....:..120'.
034100
034200 01  PRINT-LINE-MEASUREMENT.
034300     05  FILLER                     PIC X(51) VALUE
034400         'X....:...10....:...20....:...30....:...40....:...50'.
034500     05  FILLER                     PIC X(50) VALUE
034600         '....:...60....:...70....:...80....:...90....:..100'.
034700     05  FILLER                     PIC X(32) VALUE
034800         '....:..110....:..120....:..130..'.
034900/
035000******************************************************************
035100*  This area contains all of the old Composite Rate variables.   *
035200* They will be eliminated when the transition period ends - 2014 *
035300******************************************************************
035400 01  HOLD-COMP-RATE-PPS-COMPONENTS.
035500     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
035600     05  H-PYMT-AMT                 PIC 9(04)V9(02).
035700     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
035800     05  H-PATIENT-AGE              PIC 9(03).
035900     05  H-AGE-FACTOR               PIC 9(01)V9(03).
036000     05  H-BSA-FACTOR               PIC 9(01)V9(04).
036100     05  H-BMI-FACTOR               PIC 9(01)V9(04).
036200     05  H-BSA                      PIC 9(03)V9(04).
036300     05  H-BMI                      PIC 9(03)V9(04).
036400     05  HGT-PART                   PIC 9(04)V9(08).
036500     05  WGT-PART                   PIC 9(04)V9(08).
036600     05  COMBINED-PART              PIC 9(04)V9(08).
036700     05  CALC-BSA                   PIC 9(04)V9(08).
036800
036900
037000* The following two variables will change from year to year
037100* and are used for the COMPOSITE part of the Bundled Pricer.
037200 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
037300 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
037400
037500* The next two percentages MUST add up to 1 (i.e. 100%)
037600* They will continue to change until CY2009 when CBSA will be 1.00
037700 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
037800 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
037900
038000* CONSTANTS AREA
038100* The next two percentages MUST add up TO 1 (i.e. 100%)
038200 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
038300 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
038400
038500* The next variable is only applicapable for the 2011 Pricer.
038600 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
038700
038800 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
038900 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
039000 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
039100                                                         0.428571.
039200* The above number technically represents the fractional
039300* number 3/7 which is three days per week that a person can
039400* receive dialysis.  It will remain this value ONLY for the
039500* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
039600* use the calculation method which is more understandable and
039700* follows the method used by the Policy folks.
039800
039900*  The following number that is loaded into the payment equation
040000*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
040100*  and   --DOES NOT CHANGE--
040200
040300 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
040400
040500 01  COMPOSITE-RATE-MULTIPLIERS.
040600*Composite rate payment multiplier (used for blended providers)
040700     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
040800     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
040900     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
041000     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
041100     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
041200     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
041300
041400     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
041500     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
041600/
041700******************************************************************
041800*    This area contains all of the NEW Bundled Rate variables.   *
041900******************************************************************
042000 01  HOLD-BUNDLED-PPS-COMPONENTS.
042100     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
042200     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
042300     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
042400     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
042500     05  H-BUN-BSA                  PIC 9(03)V9(04).
042600     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
042700     05  H-BUN-BMI                  PIC 9(03)V9(04).
042800     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
042900     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
043000     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
043100     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
043200                                    PIC 9(07)V9(04).
043300     05  H-BUN-WAGE-ADJ-TRAINING-AMT
043400                                    PIC 9(07)V9(04).
043500     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
043600     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
043700     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
043800     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
043900     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
044000                                    PIC 9(07)V9(04).
044100     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
044200     05  H-LV-OUT-PREDICT-SERVICES-MAP
044300                                    PIC 9(07)V9(04).
044400     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
044500                                    PIC 9(07)V9(04).
044600     05  H-LV-OUT-PREDICTED-MAP
044700                                    PIC 9(07)V9(04).
044800     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
044900
045000     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
045100     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
045200         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
045300
045400     05  H-COMORBID-DATA  OCCURS 6 TIMES
045500            INDEXED BY H-COMORBID-INDEX
045600                                    PIC X(02).
045700     05  H-COMORBID-CWF-CODE        PIC X(02).
045800
045900     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
046000
046100     05  QIP-REDUCTION              PIC 9(01)V9(03).
046200     05  SUB                        PIC 9(04).
046300
046400     05  THE-DATE                   PIC 9(08).
046500     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
046600     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
046700     05  ONSET-DATE                 PIC 9(08).
046800     05  MOVED-CORMORBIDS           PIC X(01).
046900     05  H-BUN-RURAL-MULTIPLIER     PIC 9(01)V9(03).
047000
047100 01  HOLD-OUTLIER-PPS-COMPONENTS.
047200     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
047300     05  H-OUT-BSA                  PIC 9(03)V9(04).
047400     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
047500     05  H-OUT-BMI                  PIC 9(03)V9(04).
047600     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
047700     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
047800     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
047900     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
048000     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
048100     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
048200     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
048300     05  H-OUT-PREDICTED-SERVICES-MAP
048400                                    PIC 9(07)V9(04).
048500     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
048600     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
048700                                    PIC 9(07)V9(04).
048800     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
048900     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
049000     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
049100     05  H-OUT-RURAL-MULTIPLIER     PIC 9(01)V9(03).
049200
049300* The following variable will change from year to year and is
049400* used for the BUNDLED part of the Bundled Pricer.
049500 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 231.55.
049600
049700* The next two percentages MUST add up to 1 (i.e. 100%)
049800* They start in 2011 and will continue to change until CY2014 when
049900* BUN-CBSA-BLEND-PCT will be 1.00
050000* The third blend percent is for those providers that waived the
050100* blended percent and went to full PPS.  This variable will be
050200* eliminated in 2014 when it is no longer needed.
050300 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
050400 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
050500 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
050600
050700* CONSTANTS AREA
050800* The next two percentages MUST add up TO 1 (i.e. 100%)
050900 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.50673.
051000 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.49327.
051100 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 95.60.
051200
051300*  The following number that is loaded into the payment equation
051400*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
051500*  and   --DOES NOT CHANGE--
051600 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
051700
051800* Added a constant to hold the BSA-National-Average that is used
051900* in the BSA Calculation. This value changes every five years.
052000 01 BSA-NATIONAL-AVERAGE            PIC 9(01)V9(02) VALUE 1.90.
052100
052200 01  PEDIATRIC-MULTIPLIERS.
052300*Separately billable payment multiplier (used for outliers)
052400     05  PED-SEP-BILL-PAY-MULTI.
052500         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.410.
052600         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.406.
052700         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.569.
052800         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.494.
052900     05  PED-EXPAND-BUNDLE-PAY-MULTI.
053000*Expanded bundle payment multiplier (used for normal billing)
053100         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.063.
053200         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.306.
053300         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.102.
053400         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.327.
053500
053600 01  ADULT-MULTIPLIERS.
053700*Separately billable payment multiplier (used for outliers)
053800     05  SEP-BILLABLE-PAYMANT-MULTI.
053900         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 1.044.
054000         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 1.000.
054100         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.005.
054200         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
054300         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.961.
054400         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.000.
054500         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.090.
054600         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.409.
054700         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.209.
054800*        10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
054900         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.426.
055000         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.999.
055100         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.494.
055200*        10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
055300         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.955.
055400         10 SB-RURAL               PIC 9(01)V9(03) VALUE 0.978.
055500*Case-Mix adjusted payment multiplier (used for normal billing)
055600     05  CASE-MIX-PAYMENT-MULTI.
055700         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.257.
055800         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.068.
055900         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.070.
056000         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
056100         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.109.
056200         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.032.
056300         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.017.
056400         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.327.
056500         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.040.
056600*        10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
056700         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.082.
056800         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.192.
056900         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.095.
057000*        10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
057100         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.239.
057200         10 CM-RURAL               PIC 9(01)V9(03) VALUE 1.008.
057300
057400 01  OUTLIER-SB-CALC-AMOUNTS.
057500     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 38.29.
057600     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 45.00.
057700     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 68.49.
057800     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 82.92.
057900     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
058000     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
058100/
058200******************************************************************
058300*    This area contains return code variables and their codes.   *
058400******************************************************************
058500 01 PAID-RETURN-CODE-TRACKERS.
058600     05  OUTLIER-TRACK              PIC X(01).
058700     05  ACUTE-COMORBID-TRACK       PIC X(01).
058800     05  CHRONIC-COMORBID-TRACK     PIC X(01).
058900     05  ONSET-TRACK                PIC X(01).
059000     05  LOW-VOLUME-TRACK           PIC X(01).
059100     05  TRAINING-TRACK             PIC X(01).
059200     05  PEDIATRIC-TRACK            PIC X(01).
059300     05  LOW-BMI-TRACK              PIC X(01).
059400 COPY RTCCPY.
059500*COPY "RTCCPY.CPY".
059600*                                                                *
059700*  Legal combinations of adjustments for ADULTS are:             *
059800*     if NO ONSET applies, then they can have any combination of:*
059900*       acute OR chronic comorbid, & outlier, low vol., training.*
060000*     if ONSET applies, then they can have:                      *
060100*           outlier and/or low volume.                           *
060200*  Legal combinations of adjustments for PEDIATRIC are:          *
060300*     outlier and/or training.                                   *
060400*                                                                *
060500*  Illegal combinations of adjustments for PEDIATRIC are:        *
060600*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
060700*     onset     with comorbid or training.                       *
060800*  Illegal combinations of adjustments for ANYONE are:           *
060900*     acute comorbid AND chronic comorbid.                       *
061000/
061100 LINKAGE SECTION.
061200 COPY BILLCPY.
061300*COPY "BILLCPY.CPY".
061400/
061500 COPY WAGECPY.
061600*COPY "WAGECPY.CPY".
061700/
061800 PROCEDURE DIVISION  USING BILL-NEW-DATA
061900                           PPS-DATA-ALL
062000                           WAGE-NEW-RATE-RECORD
062100                           COM-CBSA-WAGE-RECORD
062200                           BUN-CBSA-WAGE-RECORD.
062300
062400******************************************************************
062500* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
062600* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
062700* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
062800* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
062900* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
063000* UTILIZED HERE HAS BEEN APPROVED BY THE DIVISION OF             *
063100* INSTITUTIONAL CLAIMS PROCESSING (DICP).                        *
063200*                                                                *
063300*    PROCESSING:                                                 *
063400*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
063500*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
063600*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
063700*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
063800*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
063900*           GOBACK.                                              *
064000*        D. ASSEMBLE PRICING COMPONENTS.                         *
064100*        E. CALCULATE THE PRICE.                                 *
064200******************************************************************
064300
064400 0000-START-TO-FINISH.
064500     INITIALIZE PPS-DATA-ALL.
064600
064700* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
064800     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
064900
065000     IF BUNDLED-TEST THEN
065100        INITIALIZE BILL-DATA-TEST
065200        INITIALIZE COND-CD-73
065300     END-IF.
065400     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
065500     MOVE ZEROS                        TO PPS-RTC.
065600
065700     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
065800
065900     IF PPS-RTC = 00  THEN
066000        PERFORM 1200-INITIALIZATION
066100        IF B-COND-CODE  = '84' THEN
066200* Calculate payment for AKI claim
066300           MOVE H-BUN-BASE-WAGE-AMT TO
066400                H-PPS-FINAL-PAY-AMT
066500           MOVE '02' TO PPS-RTC
066600        ELSE
066700* Calculate payment for ESRD claim
066800            PERFORM 2000-CALCULATE-BUNDLED-FACTORS
066900            PERFORM 9000-SET-RETURN-CODE
067000        END-IF
067100        PERFORM 9100-MOVE-RESULTS
067200     END-IF.
067300
067400     GOBACK.
067500/
067600 1000-VALIDATE-BILL-ELEMENTS.
067700     IF PPS-RTC = 00  THEN
067800        IF B-COND-CODE NOT = '73' AND '74' AND '84' AND
067900                             '87' AND '  '
068000           MOVE 58                  TO PPS-RTC
068100        END-IF
068200     END-IF.
068300
068400     IF PPS-RTC = 00  THEN
068500        IF  P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
068600           NEXT SENTENCE
068700        ELSE
068800           MOVE 52                        TO PPS-RTC
068900        END-IF
069000     END-IF.
069100
069200     IF PPS-RTC = 00  THEN
069300        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
069400           MOVE 53                     TO PPS-RTC
069500        END-IF
069600     END-IF.
069700
069800     IF PPS-RTC = 00  THEN
069900        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
070000           MOVE 54                     TO PPS-RTC
070100        END-IF
070200     END-IF.
070300
070400     IF PPS-RTC = 00  THEN
070500        IF B-COND-CODE NOT = '84' THEN
070600           IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
070700              MOVE 55                     TO PPS-RTC
070800           END-IF
070900        END-IF
071000     END-IF.
071100
071200     IF PPS-RTC = 00  THEN
071300        IF B-COND-CODE NOT = '84' THEN
071400           IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
071500              MOVE 56                     TO PPS-RTC
071600           END-IF
071700        END-IF
071800     END-IF.
071900
072000     IF PPS-RTC = 00  THEN
072100        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
072200                                OR '0881'
072300           NEXT SENTENCE
072400        ELSE
072500           MOVE 57                     TO PPS-RTC
072600        END-IF
072700     END-IF.
072800
072900     IF PPS-RTC = 00  THEN
073000        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
073100                                 ' '  THEN
073200           MOVE 53                     TO PPS-RTC
073300*  This RTC is for the Special Payment Indicator not = '1' or
073400*  blank, which closely approximates the intent of the edit check.
073500*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
073600        END-IF
073700     END-IF.
073800
073900     IF PPS-RTC = 00  THEN
074000        IF B-COND-CODE NOT = '84' THEN
074100           IF B-PATIENT-HGT > 300.00
074200              MOVE 71                     TO PPS-RTC
074300           END-IF
074400        END-IF
074500     END-IF.
074600
074700     IF PPS-RTC = 00  THEN
074800        IF B-COND-CODE NOT = '84' THEN
074900           IF B-PATIENT-WGT > 500.00  THEN
075000              MOVE 72                     TO PPS-RTC
075100           END-IF
075200        END-IF
075300     END-IF.
075400
075500* Before 2012 pricer, put in edit check to make sure that the
075600* # of sesions does not exceed the # of days in a month.  Maybe
075700* the # of cays in a month minus one when patient goes into a
075800* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
075900* or 0851)).  If done, then will need extra RTC.
076000     IF PPS-RTC = 00  THEN
076100        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
076200           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
076300           MOVE 73                     TO PPS-RTC
076400        END-IF
076500     END-IF.
076600
076700     IF PPS-RTC = 00  THEN
076800        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
076900           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
077000           MOVE 74                     TO PPS-RTC
077100        END-IF
077200     END-IF.
077300
077400     IF PPS-RTC = 00  THEN
077500        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
077600           MOVE 75                     TO PPS-RTC
077700        END-IF
077800     END-IF.
077900
078000     IF PPS-RTC = 00  THEN
078100        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
078200           MOVE 76                     TO PPS-RTC
078300        END-IF
078400     END-IF.
078500*OLD WAY OF VALIDATING COMORBIDS
078600*    IF PPS-RTC = 00  THEN
078700*       IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
078800*           VALID-COMORBID-CWF-RETURN-CD       THEN
078900*          NEXT SENTENCE
079000*       ELSE
079100*          MOVE 81                     TO PPS-RTC
079200*      END-IF
079300*    END-IF.
079400*
079500*CY2016 - DROP PNEUMONIA & MONOCLONAL GAMM COMORBIDS
079600
079700     IF PPS-RTC = 00  THEN
079800        IF B-COND-CODE NOT = '84' THEN
079900           IF COMORBID-CWF-RETURN-CODE = SPACES OR
080000               "10" OR "20" OR "40" OR "50" OR "60" THEN
080100              NEXT SENTENCE
080200           ELSE
080300              MOVE 81                     TO PPS-RTC
080400           END-IF
080500        END-IF
080600     END-IF.
080700/
080800 1200-INITIALIZATION.
080900     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
081000     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
081100     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
081200     INITIALIZE PAID-RETURN-CODE-TRACKERS.
081300
081400
081500******************************************************************
081600***Calculate BUNDLED Wage Adjusted Rate                        ***
081700******************************************************************
081800     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
081900        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
082000         BUN-CBSA-W-INDEX.
082100
082200     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
082300        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
082400
082500     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
082600        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
082700/
082800 2000-CALCULATE-BUNDLED-FACTORS.
082900
083000     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
083100     IF B-DOB-MM > B-THRU-MM  THEN
083200        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
083300     END-IF
083400     IF H-PATIENT-AGE < 18  THEN
083500        MOVE "Y"                    TO PEDIATRIC-TRACK
083600     END-IF.
083700
083800     MOVE SPACES                       TO MOVED-CORMORBIDS.
083900
084000     IF P-QIP-REDUCTION = ' '  THEN
084100* no reduction
084200        MOVE 1.000 TO QIP-REDUCTION
084300     ELSE
084400        IF P-QIP-REDUCTION = '1'  THEN
084500* one-half percent reduction
084600           MOVE 0.995 TO QIP-REDUCTION
084700        ELSE
084800           IF P-QIP-REDUCTION = '2'  THEN
084900* one percent reduction
085000              MOVE 0.990 TO QIP-REDUCTION
085100           ELSE
085200              IF P-QIP-REDUCTION = '3'  THEN
085300* one and one-half percent reduction
085400                 MOVE 0.985 TO QIP-REDUCTION
085500              ELSE
085600* two percent reduction
085700                 MOVE 0.980 TO QIP-REDUCTION
085800              END-IF
085900           END-IF
086000        END-IF
086100     END-IF.
086200
086300*    Since pricer has to pay a comorbid condition according to the
086400* return code that CWF passes back, it is cleaner if the pricer
086500* sets aside whatever comorbid data exists on the line-item when
086600* it comes into the pricer and then transferrs the CWF code to
086700* the appropriate place in the comorbid data.  This avoids
086800* making convoluted changes in the other parts of the program
086900* which has to look at both original comorbid data AND CWF return
087000* codes to handle comorbids.  Near the end of the program where
087100* variables are transferred to the output, the original comorbid
087200* data is put back into its original place as though nothing
087300* occurred.
087400*CY2016 DROPPED MB & MF
087500     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
087600        NEXT SENTENCE
087700     ELSE
087800        MOVE 'Y'                       TO MOVED-CORMORBIDS
087900        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
088000        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
088100        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
088200        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
088300        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
088400        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
088500        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
088600        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
088700           MOVE SPACES                 TO COMORBID-DATA (1)
088800                                          COMORBID-DATA (2)
088900                                          COMORBID-DATA (3)
089000                                          COMORBID-DATA (4)
089100                                          COMORBID-DATA (5)
089200                                          COMORBID-DATA (6)
089300                                          COMORBID-CWF-RETURN-CODE
089400        ELSE
089500           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
089600              MOVE 'MA'                TO COMORBID-DATA (1)
089700              MOVE SPACES              TO COMORBID-DATA (2)
089800                                          COMORBID-DATA (3)
089900                                          COMORBID-DATA (4)
090000                                          COMORBID-DATA (5)
090100                                          COMORBID-DATA (6)
090200                                          COMORBID-CWF-RETURN-CODE
090300           ELSE
090400*             IF COMORBID-CWF-RETURN-CODE = '30'  THEN
090500*                MOVE SPACES           TO COMORBID-DATA (1)
090600*                MOVE 'MB'             TO COMORBID-DATA (2)
090700*                MOVE SPACES           TO COMORBID-DATA (3)
090800*                MOVE SPACES           TO COMORBID-DATA (4)
090900*                MOVE SPACES           TO COMORBID-DATA (5)
091000*                MOVE SPACES           TO COMORBID-DATA (6)
091100*                                         COMORBID-CWF-RETURN-CODE
091200*             ELSE
091300                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
091400                    MOVE SPACES        TO COMORBID-DATA (1)
091500                    MOVE SPACES        TO COMORBID-DATA (2)
091600                    MOVE 'MC'          TO COMORBID-DATA (3)
091700                    MOVE SPACES        TO COMORBID-DATA (4)
091800                    MOVE SPACES        TO COMORBID-DATA (5)
091900                    MOVE SPACES        TO COMORBID-DATA (6)
092000                                          COMORBID-CWF-RETURN-CODE
092100                 ELSE
092200                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
092300                       MOVE SPACES     TO COMORBID-DATA (1)
092400                       MOVE SPACES     TO COMORBID-DATA (2)
092500                       MOVE SPACES     TO COMORBID-DATA (3)
092600                       MOVE 'MD'       TO COMORBID-DATA (4)
092700                       MOVE SPACES     TO COMORBID-DATA (5)
092800                       MOVE SPACES     TO COMORBID-DATA (6)
092900                                          COMORBID-CWF-RETURN-CODE
093000                    ELSE
093100                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
093200                          MOVE SPACES  TO COMORBID-DATA (1)
093300                          MOVE SPACES  TO COMORBID-DATA (2)
093400                          MOVE SPACES  TO COMORBID-DATA (3)
093500                          MOVE SPACES  TO COMORBID-DATA (4)
093600                          MOVE 'ME'    TO COMORBID-DATA (5)
093700                          MOVE SPACES  TO COMORBID-DATA (6)
093800                                          COMORBID-CWF-RETURN-CODE
093900*                      ELSE
094000*                         MOVE SPACES  TO COMORBID-DATA (1)
094100*                                         COMORBID-DATA (2)
094200*                                         COMORBID-DATA (3)
094300*                                         COMORBID-DATA (4)
094400*                                         COMORBID-DATA (5)
094500*                                         COMORBID-CWF-RETURN-CODE
094600*                         MOVE 'MF'    TO COMORBID-DATA (6)
094700                       END-IF
094800                    END-IF
094900                 END-IF
095000*             END-IF
095100           END-IF
095200        END-IF
095300     END-IF.
095400******************************************************************
095500***  Set BUNDLED age adjustment factor                         ***
095600******************************************************************
095700     IF H-PATIENT-AGE < 13  THEN
095800        IF B-REV-CODE = '0821' OR '0881' THEN
095900           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
096000        ELSE
096100           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
096200        END-IF
096300     ELSE
096400        IF H-PATIENT-AGE < 18 THEN
096500           IF B-REV-CODE = '0821' OR '0881' THEN
096600              MOVE EB-AGE-13-17-HEMO-MODE
096700                                       TO H-BUN-AGE-FACTOR
096800           ELSE
096900              MOVE EB-AGE-13-17-PD-MODE
097000                                       TO H-BUN-AGE-FACTOR
097100           END-IF
097200        ELSE
097300           IF H-PATIENT-AGE < 45  THEN
097400              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
097500           ELSE
097600              IF H-PATIENT-AGE < 60  THEN
097700                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
097800              ELSE
097900                 IF H-PATIENT-AGE < 70  THEN
098000                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
098100                 ELSE
098200                    IF H-PATIENT-AGE < 80  THEN
098300                       MOVE CM-AGE-70-79
098400                                       TO H-BUN-AGE-FACTOR
098500                    ELSE
098600                       MOVE CM-AGE-80-PLUS
098700                                       TO H-BUN-AGE-FACTOR
098800                    END-IF
098900                 END-IF
099000              END-IF
099100           END-IF
099200        END-IF
099300     END-IF.
099400
099500******************************************************************
099600***  Calculate BUNDLED BSA factor (note NEW formula)           ***
099700******************************************************************
099800     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
099900         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
100000
100100     IF H-PATIENT-AGE > 17  THEN
100200        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
100300*            CM-BSA ** ((H-BUN-BSA - 1.90) / .1)
100400             CM-BSA ** ((H-BUN-BSA - BSA-NATIONAL-AVERAGE) / .1)
100500     ELSE
100600        MOVE 1.000                     TO H-BUN-BSA-FACTOR
100700     END-IF.
100800
100900******************************************************************
101000***  Calculate BUNDLED BMI factor                              ***
101100******************************************************************
101200     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
101300         (B-PATIENT-HGT ** 2)) * 10000.
101400
101500     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
101600        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
101700        MOVE "Y"                       TO LOW-BMI-TRACK
101800     ELSE
101900        MOVE 1.000                     TO H-BUN-BMI-FACTOR
102000     END-IF.
102100
102200******************************************************************
102300***  Calculate BUNDLED ONSET factor                            ***
102400******************************************************************
102500     IF B-DIALYSIS-START-DATE > ZERO  THEN
102600        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
102700        COMPUTE INTEGER-LINE-ITEM-DATE =
102800            FUNCTION INTEGER-OF-DATE(THE-DATE)
102900        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
103000        COMPUTE INTEGER-DIALYSIS-DATE  =
103100            FUNCTION INTEGER-OF-DATE(THE-DATE)
103200* Need to add one to onset-date because the start date should
103300* be included in the count of days.  fix made 9/6/2011
103400        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
103500                              INTEGER-DIALYSIS-DATE) + 1
103600        IF H-PATIENT-AGE > 17  THEN
103700           IF ONSET-DATE > 120  THEN
103800              MOVE 1                   TO H-BUN-ONSET-FACTOR
103900           ELSE
104000              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
104100              MOVE "Y"                 TO ONSET-TRACK
104200           END-IF
104300        ELSE
104400           MOVE 1                      TO H-BUN-ONSET-FACTOR
104500        END-IF
104600     ELSE
104700        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
104800     END-IF.
104900
105000******************************************************************
105100***  Set BUNDLED Co-morbidities adjustment                     ***
105200******************************************************************
105300     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
105400        IF H-PATIENT-AGE  <  18  THEN
105500           MOVE 1.000                  TO
105600                                       H-BUN-COMORBID-MULTIPLIER
105700           MOVE '10'                   TO PPS-2011-COMORBID-PAY
105800        ELSE
105900           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
106000              MOVE 1.000               TO
106100                                       H-BUN-COMORBID-MULTIPLIER
106200              MOVE '10'                TO PPS-2011-COMORBID-PAY
106300           ELSE
106400              PERFORM 2100-CALC-COMORBID-ADJUST
106500              MOVE H-COMORBID-MULTIPLIER TO
106600                                       H-BUN-COMORBID-MULTIPLIER
106700           END-IF
106800        END-IF
106900     ELSE
107000        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
107100           MOVE 1.000                  TO
107200                                       H-BUN-COMORBID-MULTIPLIER
107300           MOVE '10'                   TO PPS-2011-COMORBID-PAY
107400        ELSE
107500           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
107600              MOVE CM-GI-BLEED         TO
107700                                       H-BUN-COMORBID-MULTIPLIER
107800              MOVE '20'                TO PPS-2011-COMORBID-PAY
107900           ELSE
108000*            IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
108100*                MOVE CM-PNEUMONIA     TO
108200*                                      H-BUN-COMORBID-MULTIPLIER
108300*                MOVE '30'             TO PPS-2011-COMORBID-PAY
108400*            ELSE
108500                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
108600                    MOVE CM-PERICARDITIS TO
108700                                       H-BUN-COMORBID-MULTIPLIER
108800                    MOVE '40'          TO PPS-2011-COMORBID-PAY
108900                 END-IF
109000*            END-IF
109100           END-IF
109200        END-IF
109300     END-IF.
109400
109500******************************************************************
109600***  Calculate BUNDLED Low Volume adjustment                   ***
109700******************************************************************
109800     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
109900        IF H-PATIENT-AGE > 17  THEN
110000           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
110100                                       H-BUN-LOW-VOL-MULTIPLIER
110200           MOVE "Y"                    TO  LOW-VOLUME-TRACK
110300        ELSE
110400           MOVE 1.000                  TO
110500                                       H-BUN-LOW-VOL-MULTIPLIER
110600        END-IF
110700     ELSE
110800        MOVE 1.000                     TO
110900                                       H-BUN-LOW-VOL-MULTIPLIER
111000     END-IF.
111100
111200***************************************************************
111300* Calculate Rural Adjustment Multiplier ADDED CY 2016
111400***************************************************************
111500     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
111600        MOVE CM-RURAL TO H-BUN-RURAL-MULTIPLIER
111700     ELSE
111800        MOVE 1.000 TO H-BUN-RURAL-MULTIPLIER.
111900
112000******************************************************************
112100***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
112200******************************************************************
112300     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
112400        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
112500        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
112600        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
112700        H-BUN-LOW-VOL-MULTIPLIER * H-BUN-RURAL-MULTIPLIER.
112800
112900******************************************************************
113000***  Calculate BUNDLED Condition Code payment                  ***
113100******************************************************************
113200* Self-care in Training add-on
113300     IF B-COND-CODE = '73' OR '87' THEN
113400* no add-on when onset is present
113500        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
113600           MOVE ZERO                   TO
113700                                    H-BUN-WAGE-ADJ-TRAINING-AMT
113800        ELSE
113900* use new PPS training add-on amount times wage-index
114000           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
114100             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
114200           MOVE "Y"                    TO TRAINING-TRACK
114300        END-IF
114400     ELSE
114500* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
114600        IF (B-COND-CODE = '74')  AND
114700           (B-REV-CODE = '0841' OR '0851')  THEN
114800              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
114900                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
115000        ELSE
115100           MOVE ZERO                   TO
115200                                    H-BUN-WAGE-ADJ-TRAINING-AMT
115300                                    H-CC-74-PER-DIEM-AMT
115400        END-IF
115500     END-IF.
115600
115700******************************************************************
115800***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
115900******************************************************************
116000     IF (B-COND-CODE = '74')  AND
116100        (B-REV-CODE = '0841' OR '0851')  THEN
116200           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
116300                           H-CC-74-PER-DIEM-AMT
116400           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
116500              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
116600              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
116700     ELSE COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
116800                  H-BUN-ADJUSTED-BASE-WAGE-AMT  +
116900                  H-BUN-WAGE-ADJ-TRAINING-AMT
117000     END-IF.
117100
117200******************************************************************
117300***  Calculate BUNDLED Outlier                                 ***
117400******************************************************************
117500     PERFORM 2500-CALC-OUTLIER-FACTORS.
117600
117700******************************************************************
117800***  Calculate Low Volume payment for recovery purposes        ***
117900******************************************************************
118000     IF LOW-VOLUME-TRACK = "Y"  THEN
118100        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
118200        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
118300
118400        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
118500           H-PPS-FINAL-PAY-AMT
118600
118700        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
118800           H-OUT-PAYMENT
118900
119000        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
119100           H-LV-OUT-PAYMENT
119200
119300        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
119400           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
119500              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
119600        ELSE
119700           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
119800        END-IF
119900     END-IF.
120000
120100
120200/
120300 2100-CALC-COMORBID-ADJUST.
120400******************************************************************
120500***  Calculate Co-morbidities adjustment                       ***
120600******************************************************************
120700*  This logic assumes that the comorbids are randomly assigned   *
120800*to the comorbid table.  It will select the highest comorbid for *
120900*payment if one is found.  CY 2016 DROPPED MB & MF              *
121000******************************************************************
121100     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
121200     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
121300     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
121400
121500     PERFORM VARYING  SUB  FROM  1 BY 1
121600       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
121700         IF COMORBID-DATA (SUB) = 'MA'  THEN
121800           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
121900*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
122000           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
122100           MOVE '20'                   TO PPS-2011-COMORBID-PAY
122200         ELSE
122300*          IF COMORBID-DATA (SUB) = 'MB'  THEN
122400*            IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
122500*              MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
122600*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
122700*              MOVE '30'               TO PPS-2011-COMORBID-PAY
122800*            END-IF
122900*          ELSE
123000             IF COMORBID-DATA (SUB) = 'MC'  THEN
123100                IF CM-PERICARDITIS  >
123200                                      H-COMORBID-MULTIPLIER  THEN
123300                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
123400                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
123500                  MOVE '40'            TO PPS-2011-COMORBID-PAY
123600                END-IF
123700             ELSE
123800               IF COMORBID-DATA (SUB) = 'MD'  THEN
123900                 IF CM-MYELODYSPLASTIC  >
124000                                      H-COMORBID-MULTIPLIER  THEN
124100                   MOVE CM-MYELODYSPLASTIC  TO
124200                                      H-COMORBID-MULTIPLIER
124300                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
124400                   MOVE '50'           TO PPS-2011-COMORBID-PAY
124500                 END-IF
124600               ELSE
124700                 IF COMORBID-DATA (SUB) = 'ME'  THEN
124800                   IF CM-SICKEL-CELL  >
124900                                      H-COMORBID-MULTIPLIER  THEN
125000                     MOVE CM-SICKEL-CELL  TO
125100                                      H-COMORBID-MULTIPLIER
125200                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
125300                     MOVE '60'         TO PPS-2011-COMORBID-PAY
125400                   END-IF
125500*                ELSE
125600*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
125700*                    IF CM-MONOCLONAL-GAMM  >
125800*                                     H-COMORBID-MULTIPLIER  THEN
125900*                      MOVE CM-MONOCLONAL-GAMM TO
126000*                                     H-COMORBID-MULTIPLIER
126100*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
126200*                      MOVE '70'       TO PPS-2011-COMORBID-PAY
126300*                    END-IF
126400*                  END-IF
126500                 END-IF
126600               END-IF
126700             END-IF
126800*          END-IF
126900         END-IF
127000     END-PERFORM.
127100/
127200 2500-CALC-OUTLIER-FACTORS.
127300******************************************************************
127400***  Set separately billable OUTLIER age adjustment factor     ***
127500******************************************************************
127600     IF H-PATIENT-AGE < 13  THEN
127700        IF B-REV-CODE = '0821' OR '0881' THEN
127800           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
127900        ELSE
128000           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
128100        END-IF
128200     ELSE
128300        IF H-PATIENT-AGE < 18 THEN
128400           IF B-REV-CODE = '0821' OR '0881'  THEN
128500              MOVE SB-AGE-13-17-HEMO-MODE
128600                                       TO H-OUT-AGE-FACTOR
128700           ELSE
128800              MOVE SB-AGE-13-17-PD-MODE
128900                                       TO H-OUT-AGE-FACTOR
129000           END-IF
129100        ELSE
129200           IF H-PATIENT-AGE < 45  THEN
129300              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
129400           ELSE
129500              IF H-PATIENT-AGE < 60  THEN
129600                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
129700              ELSE
129800                 IF H-PATIENT-AGE < 70  THEN
129900                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
130000                 ELSE
130100                    IF H-PATIENT-AGE < 80  THEN
130200                       MOVE SB-AGE-70-79
130300                                       TO H-OUT-AGE-FACTOR
130400                    ELSE
130500                       MOVE SB-AGE-80-PLUS
130600                                       TO H-OUT-AGE-FACTOR
130700                    END-IF
130800                 END-IF
130900              END-IF
131000           END-IF
131100        END-IF
131200     END-IF.
131300
131400******************************************************************
131500**Calculate separately billable OUTLIER BSA factor (superscript)**
131600******************************************************************
131700     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
131800         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
131900
132000     IF H-PATIENT-AGE > 17  THEN
132100        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
132200*            SB-BSA ** ((H-OUT-BSA - 1.90) / .1)
132300             SB-BSA ** ((H-OUT-BSA - BSA-NATIONAL-AVERAGE) / .1)
132400     ELSE
132500        MOVE 1.000                     TO H-OUT-BSA-FACTOR
132600     END-IF.
132700
132800******************************************************************
132900***  Calculate separately billable OUTLIER BMI factor          ***
133000******************************************************************
133100     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
133200         (B-PATIENT-HGT ** 2)) * 10000.
133300
133400     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
133500        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
133600     ELSE
133700        MOVE 1.000                     TO H-OUT-BMI-FACTOR
133800     END-IF.
133900
134000******************************************************************
134100***  Calculate separately billable OUTLIER ONSET factor        ***
134200******************************************************************
134300     IF B-DIALYSIS-START-DATE > ZERO  THEN
134400        IF H-PATIENT-AGE > 17  THEN
134500           IF ONSET-DATE > 120  THEN
134600              MOVE 1                   TO H-OUT-ONSET-FACTOR
134700           ELSE
134800              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
134900           END-IF
135000        ELSE
135100           MOVE 1                      TO H-OUT-ONSET-FACTOR
135200        END-IF
135300     ELSE
135400        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
135500     END-IF.
135600
135700******************************************************************
135800***  Set separately billable OUTLIER Co-morbidities adjustment ***
135900* CY 2016 DROPPED MB & MF
136000******************************************************************
136100     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
136200        IF H-PATIENT-AGE  <  18  THEN
136300           MOVE 1.000                  TO
136400                                       H-OUT-COMORBID-MULTIPLIER
136500           MOVE '10'                   TO PPS-2011-COMORBID-PAY
136600        ELSE
136700           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
136800              MOVE 1.000               TO
136900                                       H-OUT-COMORBID-MULTIPLIER
137000              MOVE '10'                TO PPS-2011-COMORBID-PAY
137100           ELSE
137200              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
137300           END-IF
137400        END-IF
137500     ELSE
137600        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
137700           MOVE 1.000                  TO
137800                                       H-OUT-COMORBID-MULTIPLIER
137900        ELSE
138000           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
138100              MOVE SB-GI-BLEED         TO
138200                                       H-OUT-COMORBID-MULTIPLIER
138300           ELSE
138400*             IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
138500*                MOVE SB-PNEUMONIA     TO
138600*                                      H-OUT-COMORBID-MULTIPLIER
138700*             ELSE
138800                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
138900                    MOVE SB-PERICARDITIS TO
139000                                       H-OUT-COMORBID-MULTIPLIER
139100                 END-IF
139200*             END-IF
139300           END-IF
139400        END-IF
139500     END-IF.
139600
139700******************************************************************
139800***  Set OUTLIER low-volume-multiplier                         ***
139900******************************************************************
140000     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
140100        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
140200     ELSE
140300        IF H-PATIENT-AGE < 18  THEN
140400           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
140500        ELSE
140600           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
140700           MOVE "Y"                    TO LOW-VOLUME-TRACK
140800        END-IF
140900     END-IF.
141000
141100***************************************************************
141200* Calculate OUTLIER Rural Adjustment multiplier
141300***************************************************************
141400
141500     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
141600        MOVE SB-RURAL TO H-OUT-RURAL-MULTIPLIER
141700     ELSE
141800        MOVE 1.000 TO H-OUT-RURAL-MULTIPLIER.
141900
142000******************************************************************
142100***  Calculate predicted OUTLIER services MAP per treatment    ***
142200******************************************************************
142300     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
142400        (H-OUT-AGE-FACTOR             *
142500         H-OUT-BSA-FACTOR             *
142600         H-OUT-BMI-FACTOR             *
142700         H-OUT-ONSET-FACTOR           *
142800         H-OUT-COMORBID-MULTIPLIER    *
142900         H-OUT-RURAL-MULTIPLIER       *
143000         H-OUT-LOW-VOL-MULTIPLIER).
143100
143200******************************************************************
143300***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
143400******************************************************************
143500     IF H-PATIENT-AGE < 18  THEN
143600        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
143700           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
143800        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
143900     ELSE
144000
144100        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
144200           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
144300        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
144400     END-IF.
144500
144600******************************************************************
144700*** Calculate imputed OUTLIER services MAP amount per treatment***
144800******************************************************************
144900     IF (B-COND-CODE = '74')  AND
145000        (B-REV-CODE = '0841' OR '0851')  THEN
145100         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
145200            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
145300         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
145400         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
145500     ELSE
145600        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
145700        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
145800     END-IF.
145900
146000******************************************************************
146100*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
146200******************************************************************
146300     IF H-PATIENT-AGE < 18   THEN
146400        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
146500           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
146600        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
146700        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
146800           COMPUTE H-OUT-PAYMENT  ROUNDED  =
146900            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
147000                                         LOSS-SHARING-PCT-LT-18
147100           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
147200           MOVE "Y"                    TO OUTLIER-TRACK
147300        ELSE
147400           MOVE ZERO                   TO H-OUT-PAYMENT
147500           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
147600        END-IF
147700     ELSE
147800        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
147900           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
148000           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
148100        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
148200           COMPUTE H-OUT-PAYMENT  ROUNDED  =
148300            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
148400                                         LOSS-SHARING-PCT-GT-17
148500           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
148600           MOVE "Y"                    TO OUTLIER-TRACK
148700        ELSE
148800           MOVE ZERO                   TO H-OUT-PAYMENT
148900        END-IF
149000     END-IF.
149100
149200     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
149300
149400* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
149500     IF (B-COND-CODE = '74')  AND
149600        (B-REV-CODE = '0841' OR '0851')  THEN
149700           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
149800             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
149900     END-IF.
150000/
150100 2600-CALC-COMORBID-OUT-ADJUST.
150200******************************************************************
150300***  Calculate OUTLIER Co-morbidities adjustment               ***
150400******************************************************************
150500*  This logic assumes that the comorbids are randomly assigned   *
150600*to the comorbid table.  It will select the highest comorbid for *
150700*payment if one is found. CY 2016 DROPPED MB & MF                *
150800******************************************************************
150900
151000     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
151100     MOVE 1.000                        TO
151200                                  H-OUT-COMORBID-MULTIPLIER.
151300
151400     PERFORM VARYING  SUB  FROM  1 BY 1
151500       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
151600         IF COMORBID-DATA (SUB) = 'MA'  THEN
151700           MOVE SB-GI-BLEED            TO
151800                                  H-OUT-COMORBID-MULTIPLIER
151900*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
152000           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
152100         ELSE
152200*          IF COMORBID-DATA (SUB) = 'MB'  THEN
152300*            IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
152400*              MOVE SB-PNEUMONIA       TO
152500*                                 H-OUT-COMORBID-MULTIPLIER
152600*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
152700*            END-IF
152800*          ELSE
152900             IF COMORBID-DATA (SUB) = 'MC'  THEN
153000                IF SB-PERICARDITIS  >
153100                                  H-OUT-COMORBID-MULTIPLIER  THEN
153200                  MOVE SB-PERICARDITIS TO
153300                                  H-OUT-COMORBID-MULTIPLIER
153400                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
153500                END-IF
153600             ELSE
153700               IF COMORBID-DATA (SUB) = 'MD'  THEN
153800                 IF SB-MYELODYSPLASTIC  >
153900                                  H-OUT-COMORBID-MULTIPLIER  THEN
154000                   MOVE SB-MYELODYSPLASTIC  TO
154100                                  H-OUT-COMORBID-MULTIPLIER
154200                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
154300                 END-IF
154400               ELSE
154500                 IF COMORBID-DATA (SUB) = 'ME'  THEN
154600                   IF SB-SICKEL-CELL  >
154700                                 H-OUT-COMORBID-MULTIPLIER  THEN
154800                     MOVE SB-SICKEL-CELL  TO
154900                                  H-OUT-COMORBID-MULTIPLIER
155000                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
155100                   END-IF
155200*                ELSE
155300*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
155400*                    IF SB-MONOCLONAL-GAMM  >
155500*                                 H-OUT-COMORBID-MULTIPLIER  THEN
155600*                      MOVE SB-MONOCLONAL-GAMM  TO
155700*                                 H-OUT-COMORBID-MULTIPLIER
155800*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
155900*                    END-IF
156000*                  END-IF
156100                 END-IF
156200               END-IF
156300             END-IF
156400*          END-IF
156500         END-IF
156600     END-PERFORM.
156700/
156800******************************************************************
156900*** Calculate Low Volume Full PPS payment for recovery purposes***
157000******************************************************************
157100 3000-LOW-VOL-FULL-PPS-PAYMENT.
157200******************************************************************
157300** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
157400     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
157500        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
157600        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
157700        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
157800         H-BUN-RURAL-MULTIPLIER.
157900
158000******************************************************************
158100**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
158200* Self-care in Training add-on
158300     IF B-COND-CODE = '73' OR '87' THEN
158400* no add-on when onset is present
158500        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
158600           MOVE ZERO                   TO
158700                                    H-BUN-WAGE-ADJ-TRAINING-AMT
158800        ELSE
158900* use new PPS training add-on amount times wage-index
159000           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
159100             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
159200           MOVE "Y"                    TO TRAINING-TRACK
159300        END-IF
159400     ELSE
159500* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
159600        IF (B-COND-CODE = '74')  AND
159700           (B-REV-CODE = '0841' OR '0851')  THEN
159800              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
159900                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
160000        ELSE
160100           MOVE ZERO                   TO
160200                                    H-BUN-WAGE-ADJ-TRAINING-AMT
160300                                    H-CC-74-PER-DIEM-AMT
160400        END-IF
160500     END-IF.
160600
160700******************************************************************
160800**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
160900     IF (B-COND-CODE = '74')  AND
161000        (B-REV-CODE = '0841' OR '0851')  THEN
161100           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
161200                           H-CC-74-PER-DIEM-AMT
161300     ELSE
161400        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
161500                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
161600                H-BUN-WAGE-ADJ-TRAINING-AMT
161700     END-IF.
161800
161900/
162000******************************************************************
162100*** Calculate Low Volume OUT PPS payment for recovery purposes ***
162200******************************************************************
162300 3100-LOW-VOL-OUT-PPS-PAYMENT.
162400******************************************************************
162500**Modified code from 'Calc predict OUT serv MAP per treat' para.**
162600     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
162700        (H-OUT-AGE-FACTOR             *
162800         H-OUT-BSA-FACTOR             *
162900         H-OUT-BMI-FACTOR             *
163000         H-OUT-ONSET-FACTOR           *
163100         H-OUT-COMORBID-MULTIPLIER    *
163200         H-OUT-RURAL-MULTIPLIER).
163300
163400******************************************************************
163500**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
163600     IF H-PATIENT-AGE < 18  THEN
163700        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
163800           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
163900        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
164000     ELSE
164100        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
164200           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
164300        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
164400     END-IF.
164500
164600******************************************************************
164700** 'Calculate imput OUT services MAP amount per treatment' para **
164800** It is not necessary to modify or insert this paragraph here. **
164900
165000******************************************************************
165100**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
165200     IF H-PATIENT-AGE < 18   THEN
165300        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
165400           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
165500        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
165600        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
165700           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
165800            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
165900                                         LOSS-SHARING-PCT-LT-18
166000           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
166100        ELSE
166200           MOVE ZERO                   TO H-LV-OUT-PAYMENT
166300           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
166400        END-IF
166500     ELSE
166600        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
166700           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
166800           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
166900        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
167000           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
167100            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
167200                                         LOSS-SHARING-PCT-GT-17
167300           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
167400        ELSE
167500           MOVE ZERO                   TO H-LV-OUT-PAYMENT
167600        END-IF
167700     END-IF.
167800
167900     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
168000
168100* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
168200     IF (B-COND-CODE = '74')  AND
168300        (B-REV-CODE = '0841' OR '0851')  THEN
168400           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
168500             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
168600     END-IF.
168700
168800
168900/
169000 9000-SET-RETURN-CODE.
169100******************************************************************
169200***  Set the return code                                       ***
169300******************************************************************
169400*   The following 'table' helps in understanding and in making   *
169500*changes to the rather large and complex "IF" statement that     *
169600*follows.  This 'table' just reorders and rewords the comments   *
169700*contained in the working storage area concerning the paid       *
169800*return-codes.                                                   *
169900*                                                                *
170000*  17 = pediatric, outlier, training                             *
170100*  16 = pediatric, outlier                                       *
170200*  15 = pediatric, training                                      *
170300*  14 = pediatric                                                *
170400*                                                                *
170500*  24 = outlier, low volume, training, chronic comorbid          *
170600*  19 = outlier, low volume, training, acute comorbid            *
170700*  29 = outlier, low volume, training                            *
170800*  23 = outlier, low volume, chronic comorbid                    *
170900*  18 = outlier, low volume, acute comorbid                      *
171000*  30 = outlier, low volume, onset                               *
171100*  28 = outlier, low volume                                      *
171200*  34 = outlier, training, chronic comorbid                      *
171300*  35 = outlier, training, acute comorbid                        *
171400*  33 = outlier, training                                        *
171500*  07 = outlier, chronic comorbid                                *
171600*  06 = outlier, acute comorbid                                  *
171700*  09 = outlier, onset                                           *
171800*  03 = outlier                                                  *
171900*                                                                *
172000*  26 = low volume, training, chronic comorbid                   *
172100*  21 = low volume, training, acute comorbid                     *
172200*  12 = low volume, training                                     *
172300*  25 = low volume, chronic comorbid                             *
172400*  20 = low volume, acute comorbid                               *
172500*  32 = low volume, onset                                        *
172600*  10 = low volume                                               *
172700*                                                                *
172800*  27 = training, chronic comorbid                               *
172900*  22 = training, acute comorbid                                 *
173000*  11 = training                                                 *
173100*                                                                *
173200*  08 = onset                                                    *
173300*  04 = acute comorbid                                           *
173400*  05 = chronic comorbid                                         *
173500*  31 = low BMI                                                  *
173600*  02 = no adjustments                                           *
173700*                                                                *
173800*  13 = w/multiple adjustments....reserved for future use        *
173900******************************************************************
174000/
174100     IF PEDIATRIC-TRACK                       = "Y"  THEN
174200        IF OUTLIER-TRACK                      = "Y"  THEN
174300           IF TRAINING-TRACK                  = "Y"  THEN
174400              MOVE 17                  TO PPS-RTC
174500           ELSE
174600              MOVE 16                  TO PPS-RTC
174700           END-IF
174800        ELSE
174900           IF TRAINING-TRACK                  = "Y"  THEN
175000              MOVE 15                  TO PPS-RTC
175100           ELSE
175200              MOVE 14                  TO PPS-RTC
175300           END-IF
175400        END-IF
175500     ELSE
175600        IF OUTLIER-TRACK                      = "Y"  THEN
175700           IF LOW-VOLUME-TRACK                = "Y"  THEN
175800              IF TRAINING-TRACK               = "Y"  THEN
175900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
176000                    MOVE 24            TO PPS-RTC
176100                 ELSE
176200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
176300                       MOVE 19         TO PPS-RTC
176400                    ELSE
176500                       MOVE 29         TO PPS-RTC
176600                    END-IF
176700                 END-IF
176800              ELSE
176900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
177000                    MOVE 23            TO PPS-RTC
177100                 ELSE
177200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
177300                       MOVE 18         TO PPS-RTC
177400                    ELSE
177500                       IF ONSET-TRACK         = "Y"  THEN
177600                          MOVE 30      TO PPS-RTC
177700                       ELSE
177800                          MOVE 28      TO PPS-RTC
177900                       END-IF
178000                    END-IF
178100                 END-IF
178200              END-IF
178300           ELSE
178400              IF TRAINING-TRACK               = "Y"  THEN
178500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
178600                    MOVE 34            TO PPS-RTC
178700                 ELSE
178800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
178900                       MOVE 35         TO PPS-RTC
179000                    ELSE
179100                       MOVE 33         TO PPS-RTC
179200                    END-IF
179300                 END-IF
179400              ELSE
179500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
179600                    MOVE 07            TO PPS-RTC
179700                 ELSE
179800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
179900                       MOVE 06         TO PPS-RTC
180000                    ELSE
180100                       IF ONSET-TRACK         = "Y"  THEN
180200                          MOVE 09      TO PPS-RTC
180300                       ELSE
180400                          MOVE 03      TO PPS-RTC
180500                       END-IF
180600                    END-IF
180700                 END-IF
180800              END-IF
180900           END-IF
181000        ELSE
181100           IF LOW-VOLUME-TRACK                = "Y"
181200              IF TRAINING-TRACK               = "Y"  THEN
181300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
181400                    MOVE 26            TO PPS-RTC
181500                 ELSE
181600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
181700                       MOVE 21         TO PPS-RTC
181800                    ELSE
181900                       MOVE 12         TO PPS-RTC
182000                    END-IF
182100                 END-IF
182200              ELSE
182300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
182400                    MOVE 25            TO PPS-RTC
182500                 ELSE
182600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
182700                       MOVE 20         TO PPS-RTC
182800                    ELSE
182900                       IF ONSET-TRACK         = "Y"  THEN
183000                          MOVE 32      TO PPS-RTC
183100                       ELSE
183200                          MOVE 10      TO PPS-RTC
183300                       END-IF
183400                    END-IF
183500                 END-IF
183600              END-IF
183700           ELSE
183800              IF TRAINING-TRACK               = "Y"  THEN
183900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
184000                    MOVE 27            TO PPS-RTC
184100                 ELSE
184200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
184300                       MOVE 22         TO PPS-RTC
184400                    ELSE
184500                       MOVE 11         TO PPS-RTC
184600                    END-IF
184700                 END-IF
184800              ELSE
184900                 IF ONSET-TRACK               = "Y"  THEN
185000                    MOVE 08            TO PPS-RTC
185100                 ELSE
185200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
185300                       MOVE 04         TO PPS-RTC
185400                    ELSE
185500                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
185600                          MOVE 05      TO PPS-RTC
185700                       ELSE
185800                          IF LOW-BMI-TRACK = "Y"  THEN
185900                             MOVE 31 TO PPS-RTC
186000                          ELSE
186100                             MOVE 02 TO PPS-RTC
186200                          END-IF
186300                       END-IF
186400                    END-IF
186500                 END-IF
186600              END-IF
186700           END-IF
186800        END-IF
186900     END-IF.
187000
187100/
187200 9100-MOVE-RESULTS.
187300     IF MOVED-CORMORBIDS = SPACES  THEN
187400        NEXT SENTENCE
187500     ELSE
187600        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
187700        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
187800        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
187900        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
188000        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
188100        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
188200        MOVE H-COMORBID-CWF-CODE       TO
188300                                    COMORBID-CWF-RETURN-CODE
188400     END-IF.
188500
188600     MOVE P-GEO-MSA                    TO PPS-MSA.
188700     MOVE P-GEO-CBSA                   TO PPS-CBSA.
188800     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
188900     MOVE B-COND-CODE                  TO PPS-COND-CODE.
189000     MOVE B-REV-CODE                   TO PPS-REV-CODE.
189100     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
189200     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
189300     MOVE BUN-NAT-NONLABOR-PCT         TO
189400                                    PPS-2011-NAT-NONLABOR-PCT.
189500     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
189600     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
189700     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
189800     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
189900     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
190000     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
190100     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
190200     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
190300     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
190400     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
190500                                    PPS-2011-BDGT-NEUT-RATE.
190600     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
190700     MOVE SPACES                       TO
190800                                    PPS-2011-COMORBID-MA-CC.
190900
191000     IF (B-COND-CODE = '74')  AND
191100        (B-REV-CODE = '0841' OR '0851')  THEN
191200         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
191300                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
191400     END-IF.
191500
191600     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
191700           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
191800              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
191900           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
192000              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
192100           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
192200              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
192300     ELSE
192400        MOVE ZERO                      TO
192500                                    PPS-2011-BLEND-COMP-RATE
192600        MOVE ZERO                      TO
192700                                    PPS-2011-BLEND-PPS-RATE
192800        MOVE ZERO                      TO
192900                                    PPS-2011-BLEND-OUTLIER-RATE
193000     END-IF.
193100
193200     MOVE H-PYMT-AMT                   TO
193300                                    PPS-2011-FULL-COMP-RATE.
193400     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
193500                                          PPS-FINAL-PAY-AMT.
193600     MOVE H-OUT-PAYMENT                TO
193700                                    PPS-2011-FULL-OUTLIER-RATE.
193800
193900     IF B-COND-CODE NOT = '84' THEN
194000        IF P-QIP-REDUCTION = ' ' THEN
194100           NEXT SENTENCE
194200        ELSE
194300           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
194400                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
194500           COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
194600                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
194700           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
194800                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
194900           COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
195000                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
195100           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
195200                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
195300           COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
195400                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
195500        END-IF
195600     END-IF.
195700
195800     IF BUNDLED-TEST   THEN
195900        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
196000        MOVE 0.0                       TO MSA-WAGE-ADJ
196100        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
196200        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
196300        MOVE H-PATIENT-AGE             TO AGE-RETURN
196400        MOVE 0.0                       TO MSA-WAGE-AMT
196500        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
196600        MOVE H-BMI                     TO PPS-BMI
196700        MOVE H-BSA                     TO PPS-BSA
196800        MOVE MSA-BLEND-PCT             TO MSA-PCT
196900        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
197000
197100        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
197200           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
197300           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
197400        ELSE
197500           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
197600           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
197700        END-IF
197800
197900        MOVE H-BUN-BSA                 TO BUN-BSA
198000        MOVE H-BUN-BMI                 TO BUN-BMI
198100        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
198200        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
198300        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
198400        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
198500        MOVE H-OUT-BSA                 TO OUT-BSA
198600        MOVE SB-BSA                    TO OUT-SB-BSA
198700        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
198800        MOVE H-OUT-BMI                 TO OUT-BMI
198900        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
199000        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
199100        MOVE H-OUT-COMORBID-MULTIPLIER TO
199200                                    OUT-COMORBID-MULTIPLIER
199300        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
199400                                    OUT-PREDICTED-SERVICES-MAP
199500        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
199600                                    OUT-CASE-MIX-PREDICTED-MAP
199700        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
199800                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
199900        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
200000        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
200100        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
200200        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
200300        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
200400        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
200500        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
200600        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
200700        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
200800        MOVE CM-BSA                    TO PPS-CM-BSA
200900        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
201000        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
201100        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
201200        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
201300                                    BUN-ADJUSTED-BASE-WAGE-AMT
201400        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
201500                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
201600        MOVE TRAINING-ADD-ON-PMT-AMT   TO
201700                                    PPS-TRAINING-ADD-ON-PMT-AMT
201800        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
201900     END-IF.
202000******        L A S T   S O U R C E   S T A T E M E N T      *****
