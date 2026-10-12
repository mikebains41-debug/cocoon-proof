000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL170.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2017
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
031400******************************************************************
031500 DATE-COMPILED.
031600 ENVIRONMENT DIVISION.
031700 CONFIGURATION SECTION.
031800 SOURCE-COMPUTER.            IBM-Z990.
031900 OBJECT-COMPUTER.            IBM-Z990.
032000 INPUT-OUTPUT  SECTION.
032100 FILE-CONTROL.
032200
032300 DATA DIVISION.
032400 FILE SECTION.
032500/
032600 WORKING-STORAGE SECTION.
032700 01  W-STORAGE-REF                  PIC X(46) VALUE
032800     'ESCAL170      - W O R K I N G   S T O R A G E'.
032900 01  CAL-VERSION                    PIC X(05) VALUE 'C17.0'.
033000
033100 01  DISPLAY-LINE-MEASUREMENT.
033200     05  FILLER                     PIC X(50) VALUE
033300         '....:...10....:...20....:...30....:...40....:...50'.
033400     05  FILLER                     PIC X(50) VALUE
033500         '....:...60....:...70....:...80....:...90....:..100'.
033600     05  FILLER                     PIC X(20) VALUE
033700         '....:..110....:..120'.
033800
033900 01  PRINT-LINE-MEASUREMENT.
034000     05  FILLER                     PIC X(51) VALUE
034100         'X....:...10....:...20....:...30....:...40....:...50'.
034200     05  FILLER                     PIC X(50) VALUE
034300         '....:...60....:...70....:...80....:...90....:..100'.
034400     05  FILLER                     PIC X(32) VALUE
034500         '....:..110....:..120....:..130..'.
034600/
034700******************************************************************
034800*  This area contains all of the old Composite Rate variables.   *
034900* They will be eliminated when the transition period ends - 2014 *
035000******************************************************************
035100 01  HOLD-COMP-RATE-PPS-COMPONENTS.
035200     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
035300     05  H-PYMT-AMT                 PIC 9(04)V9(02).
035400     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
035500     05  H-PATIENT-AGE              PIC 9(03).
035600     05  H-AGE-FACTOR               PIC 9(01)V9(03).
035700     05  H-BSA-FACTOR               PIC 9(01)V9(04).
035800     05  H-BMI-FACTOR               PIC 9(01)V9(04).
035900     05  H-BSA                      PIC 9(03)V9(04).
036000     05  H-BMI                      PIC 9(03)V9(04).
036100     05  HGT-PART                   PIC 9(04)V9(08).
036200     05  WGT-PART                   PIC 9(04)V9(08).
036300     05  COMBINED-PART              PIC 9(04)V9(08).
036400     05  CALC-BSA                   PIC 9(04)V9(08).
036500
036600
036700* The following two variables will change from year to year
036800* and are used for the COMPOSITE part of the Bundled Pricer.
036900 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
037000 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
037100
037200* The next two percentages MUST add up to 1 (i.e. 100%)
037300* They will continue to change until CY2009 when CBSA will be 1.00
037400 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
037500 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
037600
037700* CONSTANTS AREA
037800* The next two percentages MUST add up TO 1 (i.e. 100%)
037900 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
038000 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
038100
038200* The next variable is only applicapable for the 2011 Pricer.
038300 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
038400
038500 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
038600 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
038700 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
038800                                                         0.428571.
038900* The above number technically represents the fractional
039000* number 3/7 which is three days per week that a person can
039100* receive dialysis.  It will remain this value ONLY for the
039200* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
039300* use the calculation method which is more understandable and
039400* follows the method used by the Policy folks.
039500
039600*  The following number that is loaded into the payment equation
039700*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
039800*  and   --DOES NOT CHANGE--
039900
040000 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
040100
040200 01  COMPOSITE-RATE-MULTIPLIERS.
040300*Composite rate payment multiplier (used for blended providers)
040400     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
040500     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
040600     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
040700     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
040800     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
040900     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
041000
041100     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
041200     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
041300/
041400******************************************************************
041500*    This area contains all of the NEW Bundled Rate variables.   *
041600******************************************************************
041700 01  HOLD-BUNDLED-PPS-COMPONENTS.
041800     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
041900     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
042000     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
042100     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
042200     05  H-BUN-BSA                  PIC 9(03)V9(04).
042300     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
042400     05  H-BUN-BMI                  PIC 9(03)V9(04).
042500     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
042600     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
042700     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
042800     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
042900                                    PIC 9(07)V9(04).
043000     05  H-BUN-WAGE-ADJ-TRAINING-AMT
043100                                    PIC 9(07)V9(04).
043200     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
043300     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
043400     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
043500     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
043600     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
043700                                    PIC 9(07)V9(04).
043800     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
043900     05  H-LV-OUT-PREDICT-SERVICES-MAP
044000                                    PIC 9(07)V9(04).
044100     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
044200                                    PIC 9(07)V9(04).
044300     05  H-LV-OUT-PREDICTED-MAP
044400                                    PIC 9(07)V9(04).
044500     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
044600
044700     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
044800     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
044900         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
045000
045100     05  H-COMORBID-DATA  OCCURS 6 TIMES
045200            INDEXED BY H-COMORBID-INDEX
045300                                    PIC X(02).
045400     05  H-COMORBID-CWF-CODE        PIC X(02).
045500
045600     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
045700
045800     05  QIP-REDUCTION              PIC 9(01)V9(03).
045900     05  SUB                        PIC 9(04).
046000
046100     05  THE-DATE                   PIC 9(08).
046200     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
046300     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
046400     05  ONSET-DATE                 PIC 9(08).
046500     05  MOVED-CORMORBIDS           PIC X(01).
046600     05  H-BUN-RURAL-MULTIPLIER     PIC 9(01)V9(03).
046700
046800 01  HOLD-OUTLIER-PPS-COMPONENTS.
046900     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
047000     05  H-OUT-BSA                  PIC 9(03)V9(04).
047100     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
047200     05  H-OUT-BMI                  PIC 9(03)V9(04).
047300     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
047400     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
047500     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
047600     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
047700     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
047800     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
047900     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
048000     05  H-OUT-PREDICTED-SERVICES-MAP
048100                                    PIC 9(07)V9(04).
048200     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
048300     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
048400                                    PIC 9(07)V9(04).
048500     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
048600     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
048700     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
048800     05  H-OUT-RURAL-MULTIPLIER     PIC 9(01)V9(03).
048900
049000* The following variable will change from year to year and is
049100* used for the BUNDLED part of the Bundled Pricer.
049200 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 231.55.
049300
049400* The next two percentages MUST add up to 1 (i.e. 100%)
049500* They start in 2011 and will continue to change until CY2014 when
049600* BUN-CBSA-BLEND-PCT will be 1.00
049700* The third blend percent is for those providers that waived the
049800* blended percent and went to full PPS.  This variable will be
049900* eliminated in 2014 when it is no longer needed.
050000 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
050100 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
050200 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
050300
050400* CONSTANTS AREA
050500* The next two percentages MUST add up TO 1 (i.e. 100%)
050600 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.50673.
050700 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.49327.
050800 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 95.60.
050900
051000*  The following number that is loaded into the payment equation
051100*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
051200*  and   --DOES NOT CHANGE--
051300 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
051400
051500* Added a constant to hold the BSA-National-Average that is used
051600* in the BSA Calculation. This value changes every five years.
051700 01 BSA-NATIONAL-AVERAGE            PIC 9(01)V9(02) VALUE 1.90.
051800
051900 01  PEDIATRIC-MULTIPLIERS.
052000*Separately billable payment multiplier (used for outliers)
052100     05  PED-SEP-BILL-PAY-MULTI.
052200         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.410.
052300         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.406.
052400         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.569.
052500         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.494.
052600     05  PED-EXPAND-BUNDLE-PAY-MULTI.
052700*Expanded bundle payment multiplier (used for normal billing)
052800         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.063.
052900         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.306.
053000         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.102.
053100         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.327.
053200
053300 01  ADULT-MULTIPLIERS.
053400*Separately billable payment multiplier (used for outliers)
053500     05  SEP-BILLABLE-PAYMANT-MULTI.
053600         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 1.044.
053700         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 1.000.
053800         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.005.
053900         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
054000         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.961.
054100         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.000.
054200         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.090.
054300         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.409.
054400         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.209.
054500*        10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
054600         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.426.
054700         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.999.
054800         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.494.
054900*        10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
055000         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.955.
055100         10 SB-RURAL               PIC 9(01)V9(03) VALUE 0.978.
055200*Case-Mix adjusted payment multiplier (used for normal billing)
055300     05  CASE-MIX-PAYMENT-MULTI.
055400         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.257.
055500         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.068.
055600         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.070.
055700         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
055800         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.109.
055900         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.032.
056000         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.017.
056100         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.327.
056200         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.040.
056300*        10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
056400         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.082.
056500         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.192.
056600         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.095.
056700*        10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
056800         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.239.
056900         10 CM-RURAL               PIC 9(01)V9(03) VALUE 1.008.
057000
057100 01  OUTLIER-SB-CALC-AMOUNTS.
057200     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 38.29.
057300     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 45.00.
057400     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 68.49.
057500     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 82.92.
057600     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
057700     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
057800/
057900******************************************************************
058000*    This area contains return code variables and their codes.   *
058100******************************************************************
058200 01 PAID-RETURN-CODE-TRACKERS.
058300     05  OUTLIER-TRACK              PIC X(01).
058400     05  ACUTE-COMORBID-TRACK       PIC X(01).
058500     05  CHRONIC-COMORBID-TRACK     PIC X(01).
058600     05  ONSET-TRACK                PIC X(01).
058700     05  LOW-VOLUME-TRACK           PIC X(01).
058800     05  TRAINING-TRACK             PIC X(01).
058900     05  PEDIATRIC-TRACK            PIC X(01).
059000     05  LOW-BMI-TRACK              PIC X(01).
059100 COPY RTCCPY.
059200*COPY "RTCCPY.CPY".
059300*                                                                *
059400*  Legal combinations of adjustments for ADULTS are:             *
059500*     if NO ONSET applies, then they can have any combination of:*
059600*       acute OR chronic comorbid, & outlier, low vol., training.*
059700*     if ONSET applies, then they can have:                      *
059800*           outlier and/or low volume.                           *
059900*  Legal combinations of adjustments for PEDIATRIC are:          *
060000*     outlier and/or training.                                   *
060100*                                                                *
060200*  Illegal combinations of adjustments for PEDIATRIC are:        *
060300*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
060400*     onset     with comorbid or training.                       *
060500*  Illegal combinations of adjustments for ANYONE are:           *
060600*     acute comorbid AND chronic comorbid.                       *
060700/
060800 LINKAGE SECTION.
060900 COPY BILLCPY.
061000*COPY "BILLCPY.CPY".
061100/
061200 COPY WAGECPY.
061300*COPY "WAGECPY.CPY".
061400/
061500 PROCEDURE DIVISION  USING BILL-NEW-DATA
061600                           PPS-DATA-ALL
061700                           WAGE-NEW-RATE-RECORD
061800                           COM-CBSA-WAGE-RECORD
061900                           BUN-CBSA-WAGE-RECORD.
062000
062100******************************************************************
062200* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
062300* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
062400* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
062500* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
062600* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
062700* UTILIZED HERE HAS BEEN APPROVED BY THE DIVISION OF             *
062800* INSTITUTIONAL CLAIMS PROCESSING (DICP).                        *
062900*                                                                *
063000*    PROCESSING:                                                 *
063100*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
063200*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
063300*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
063400*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
063500*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
063600*           GOBACK.                                              *
063700*        D. ASSEMBLE PRICING COMPONENTS.                         *
063800*        E. CALCULATE THE PRICE.                                 *
063900******************************************************************
064000
064100 0000-START-TO-FINISH.
064200     INITIALIZE PPS-DATA-ALL.
064300
064400* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
064500     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
064600
064700     IF BUNDLED-TEST THEN
064800        INITIALIZE BILL-DATA-TEST
064900        INITIALIZE COND-CD-73
065000     END-IF.
065100     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
065200     MOVE ZEROS                        TO PPS-RTC.
065300
065400     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
065500
065600     IF PPS-RTC = 00  THEN
065700        PERFORM 1200-INITIALIZATION
065800        IF B-COND-CODE  = '84' THEN
065900* Calculate payment for AKI claim
066000           MOVE H-BUN-BASE-WAGE-AMT TO
066100                H-PPS-FINAL-PAY-AMT
066200           MOVE '02' TO PPS-RTC
066300        ELSE
066400* Calculate payment for ESRD claim
066500            PERFORM 2000-CALCULATE-BUNDLED-FACTORS
066600            PERFORM 9000-SET-RETURN-CODE
066700        END-IF
066800        PERFORM 9100-MOVE-RESULTS
066900     END-IF.
067000
067100     GOBACK.
067200/
067300 1000-VALIDATE-BILL-ELEMENTS.
067400     IF  P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
067500        NEXT SENTENCE
067600     ELSE
067700        MOVE 52                        TO PPS-RTC
067800     END-IF.
067900
068000     IF PPS-RTC = 00  THEN
068100        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
068200           MOVE 53                     TO PPS-RTC
068300        END-IF
068400     END-IF.
068500
068600     IF PPS-RTC = 00  THEN
068700        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
068800           MOVE 54                     TO PPS-RTC
068900        END-IF
069000     END-IF.
069100
069200     IF PPS-RTC = 00  THEN
069300        IF B-COND-CODE NOT = '84' THEN
069400           IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
069500              MOVE 55                     TO PPS-RTC
069600           END-IF
069700        END-IF
069800     END-IF.
069900
070000     IF PPS-RTC = 00  THEN
070100        IF B-COND-CODE NOT = '84' THEN
070200           IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
070300              MOVE 56                     TO PPS-RTC
070400           END-IF
070500        END-IF
070600     END-IF.
070700
070800     IF PPS-RTC = 00  THEN
070900        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
071000                                OR '0881'
071100           NEXT SENTENCE
071200        ELSE
071300           MOVE 57                     TO PPS-RTC
071400        END-IF
071500     END-IF.
071600
071700     IF PPS-RTC = 00  THEN
071800        IF B-COND-CODE NOT = '73' AND '74' AND '84' AND '  '
071900           MOVE 58                  TO PPS-RTC
072000        END-IF
072100     END-IF.
072200
072300     IF PPS-RTC = 00  THEN
072400        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
072500                                 ' '  THEN
072600           MOVE 53                     TO PPS-RTC
072700*  This RTC is for the Special Payment Indicator not = '1' or
072800*  blank, which closely approximates the intent of the edit check.
072900*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
073000        END-IF
073100     END-IF.
073200
073300     IF PPS-RTC = 00  THEN
073400        IF B-COND-CODE NOT = '84' THEN
073500           IF B-PATIENT-HGT > 300.00
073600              MOVE 71                     TO PPS-RTC
073700           END-IF
073800        END-IF
073900     END-IF.
074000
074100     IF PPS-RTC = 00  THEN
074200        IF B-COND-CODE NOT = '84' THEN
074300           IF B-PATIENT-WGT > 500.00  THEN
074400              MOVE 72                     TO PPS-RTC
074500           END-IF
074600        END-IF
074700     END-IF.
074800
074900* Before 2012 pricer, put in edit check to make sure that the
075000* # of sesions does not exceed the # of days in a month.  Maybe
075100* the # of cays in a month minus one when patient goes into a
075200* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
075300* or 0851)).  If done, then will need extra RTC.
075400     IF PPS-RTC = 00  THEN
075500        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
075600           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
075700           MOVE 73                     TO PPS-RTC
075800        END-IF
075900     END-IF.
076000
076100     IF PPS-RTC = 00  THEN
076200        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
076300           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
076400           MOVE 74                     TO PPS-RTC
076500        END-IF
076600     END-IF.
076700
076800     IF PPS-RTC = 00  THEN
076900        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
077000           MOVE 75                     TO PPS-RTC
077100        END-IF
077200     END-IF.
077300
077400     IF PPS-RTC = 00  THEN
077500        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
077600           MOVE 76                     TO PPS-RTC
077700        END-IF
077800     END-IF.
077900*OLD WAY OF VALIDATING COMORBIDS
078000*    IF PPS-RTC = 00  THEN
078100*       IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
078200*           VALID-COMORBID-CWF-RETURN-CD       THEN
078300*          NEXT SENTENCE
078400*       ELSE
078500*          MOVE 81                     TO PPS-RTC
078600*      END-IF
078700*    END-IF.
078800*
078900*CY2016 - DROP PNEUMONIA & MONOCLONAL GAMM COMORBIDS
079000
079100     IF PPS-RTC = 00  THEN
079200        IF B-COND-CODE NOT = '84' THEN
079300           IF COMORBID-CWF-RETURN-CODE = SPACES OR
079400               "10" OR "20" OR "40" OR "50" OR "60" THEN
079500              NEXT SENTENCE
079600           ELSE
079700              MOVE 81                     TO PPS-RTC
079800           END-IF
079900        END-IF
080000     END-IF.
080100/
080200 1200-INITIALIZATION.
080300     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
080400     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
080500     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
080600     INITIALIZE PAID-RETURN-CODE-TRACKERS.
080700
080800
080900******************************************************************
081000***Calculate BUNDLED Wage Adjusted Rate                        ***
081100******************************************************************
081200     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
081300        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
081400         BUN-CBSA-W-INDEX.
081500
081600     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
081700        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
081800
081900     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
082000        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
082100/
082200 2000-CALCULATE-BUNDLED-FACTORS.
082300
082400     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
082500     IF B-DOB-MM > B-THRU-MM  THEN
082600        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
082700     END-IF
082800     IF H-PATIENT-AGE < 18  THEN
082900        MOVE "Y"                    TO PEDIATRIC-TRACK
083000     END-IF.
083100
083200     MOVE SPACES                       TO MOVED-CORMORBIDS.
083300
083400     IF P-QIP-REDUCTION = ' '  THEN
083500* no reduction
083600        MOVE 1.000 TO QIP-REDUCTION
083700     ELSE
083800        IF P-QIP-REDUCTION = '1'  THEN
083900* one-half percent reduction
084000           MOVE 0.995 TO QIP-REDUCTION
084100        ELSE
084200           IF P-QIP-REDUCTION = '2'  THEN
084300* one percent reduction
084400              MOVE 0.990 TO QIP-REDUCTION
084500           ELSE
084600              IF P-QIP-REDUCTION = '3'  THEN
084700* one and one-half percent reduction
084800                 MOVE 0.985 TO QIP-REDUCTION
084900              ELSE
085000* two percent reduction
085100                 MOVE 0.980 TO QIP-REDUCTION
085200              END-IF
085300           END-IF
085400        END-IF
085500     END-IF.
085600
085700*    Since pricer has to pay a comorbid condition according to the
085800* return code that CWF passes back, it is cleaner if the pricer
085900* sets aside whatever comorbid data exists on the line-item when
086000* it comes into the pricer and then transferrs the CWF code to
086100* the appropriate place in the comorbid data.  This avoids
086200* making convoluted changes in the other parts of the program
086300* which has to look at both original comorbid data AND CWF return
086400* codes to handle comorbids.  Near the end of the program where
086500* variables are transferred to the output, the original comorbid
086600* data is put back into its original place as though nothing
086700* occurred.
086800*CY2016 DROPPED MB & MF
086900     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
087000        NEXT SENTENCE
087100     ELSE
087200        MOVE 'Y'                       TO MOVED-CORMORBIDS
087300        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
087400        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
087500        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
087600        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
087700        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
087800        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
087900        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
088000        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
088100           MOVE SPACES                 TO COMORBID-DATA (1)
088200                                          COMORBID-DATA (2)
088300                                          COMORBID-DATA (3)
088400                                          COMORBID-DATA (4)
088500                                          COMORBID-DATA (5)
088600                                          COMORBID-DATA (6)
088700                                          COMORBID-CWF-RETURN-CODE
088800        ELSE
088900           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
089000              MOVE 'MA'                TO COMORBID-DATA (1)
089100              MOVE SPACES              TO COMORBID-DATA (2)
089200                                          COMORBID-DATA (3)
089300                                          COMORBID-DATA (4)
089400                                          COMORBID-DATA (5)
089500                                          COMORBID-DATA (6)
089600                                          COMORBID-CWF-RETURN-CODE
089700           ELSE
089800*             IF COMORBID-CWF-RETURN-CODE = '30'  THEN
089900*                MOVE SPACES           TO COMORBID-DATA (1)
090000*                MOVE 'MB'             TO COMORBID-DATA (2)
090100*                MOVE SPACES           TO COMORBID-DATA (3)
090200*                MOVE SPACES           TO COMORBID-DATA (4)
090300*                MOVE SPACES           TO COMORBID-DATA (5)
090400*                MOVE SPACES           TO COMORBID-DATA (6)
090500*                                         COMORBID-CWF-RETURN-CODE
090600*             ELSE
090700                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
090800                    MOVE SPACES        TO COMORBID-DATA (1)
090900                    MOVE SPACES        TO COMORBID-DATA (2)
091000                    MOVE 'MC'          TO COMORBID-DATA (3)
091100                    MOVE SPACES        TO COMORBID-DATA (4)
091200                    MOVE SPACES        TO COMORBID-DATA (5)
091300                    MOVE SPACES        TO COMORBID-DATA (6)
091400                                          COMORBID-CWF-RETURN-CODE
091500                 ELSE
091600                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
091700                       MOVE SPACES     TO COMORBID-DATA (1)
091800                       MOVE SPACES     TO COMORBID-DATA (2)
091900                       MOVE SPACES     TO COMORBID-DATA (3)
092000                       MOVE 'MD'       TO COMORBID-DATA (4)
092100                       MOVE SPACES     TO COMORBID-DATA (5)
092200                       MOVE SPACES     TO COMORBID-DATA (6)
092300                                          COMORBID-CWF-RETURN-CODE
092400                    ELSE
092500                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
092600                          MOVE SPACES  TO COMORBID-DATA (1)
092700                          MOVE SPACES  TO COMORBID-DATA (2)
092800                          MOVE SPACES  TO COMORBID-DATA (3)
092900                          MOVE SPACES  TO COMORBID-DATA (4)
093000                          MOVE 'ME'    TO COMORBID-DATA (5)
093100                          MOVE SPACES  TO COMORBID-DATA (6)
093200                                          COMORBID-CWF-RETURN-CODE
093300*                      ELSE
093400*                         MOVE SPACES  TO COMORBID-DATA (1)
093500*                                         COMORBID-DATA (2)
093600*                                         COMORBID-DATA (3)
093700*                                         COMORBID-DATA (4)
093800*                                         COMORBID-DATA (5)
093900*                                         COMORBID-CWF-RETURN-CODE
094000*                         MOVE 'MF'    TO COMORBID-DATA (6)
094100                       END-IF
094200                    END-IF
094300                 END-IF
094400*             END-IF
094500           END-IF
094600        END-IF
094700     END-IF.
094800******************************************************************
094900***  Set BUNDLED age adjustment factor                         ***
095000******************************************************************
095100     IF H-PATIENT-AGE < 13  THEN
095200        IF B-REV-CODE = '0821' OR '0881' THEN
095300           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
095400        ELSE
095500           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
095600        END-IF
095700     ELSE
095800        IF H-PATIENT-AGE < 18 THEN
095900           IF B-REV-CODE = '0821' OR '0881' THEN
096000              MOVE EB-AGE-13-17-HEMO-MODE
096100                                       TO H-BUN-AGE-FACTOR
096200           ELSE
096300              MOVE EB-AGE-13-17-PD-MODE
096400                                       TO H-BUN-AGE-FACTOR
096500           END-IF
096600        ELSE
096700           IF H-PATIENT-AGE < 45  THEN
096800              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
096900           ELSE
097000              IF H-PATIENT-AGE < 60  THEN
097100                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
097200              ELSE
097300                 IF H-PATIENT-AGE < 70  THEN
097400                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
097500                 ELSE
097600                    IF H-PATIENT-AGE < 80  THEN
097700                       MOVE CM-AGE-70-79
097800                                       TO H-BUN-AGE-FACTOR
097900                    ELSE
098000                       MOVE CM-AGE-80-PLUS
098100                                       TO H-BUN-AGE-FACTOR
098200                    END-IF
098300                 END-IF
098400              END-IF
098500           END-IF
098600        END-IF
098700     END-IF.
098800
098900******************************************************************
099000***  Calculate BUNDLED BSA factor (note NEW formula)           ***
099100******************************************************************
099200     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
099300         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
099400
099500     IF H-PATIENT-AGE > 17  THEN
099600        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
099700*            CM-BSA ** ((H-BUN-BSA - 1.90) / .1)
099800             CM-BSA ** ((H-BUN-BSA - BSA-NATIONAL-AVERAGE) / .1)
099900     ELSE
100000        MOVE 1.000                     TO H-BUN-BSA-FACTOR
100100     END-IF.
100200
100300******************************************************************
100400***  Calculate BUNDLED BMI factor                              ***
100500******************************************************************
100600     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
100700         (B-PATIENT-HGT ** 2)) * 10000.
100800
100900     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
101000        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
101100        MOVE "Y"                       TO LOW-BMI-TRACK
101200     ELSE
101300        MOVE 1.000                     TO H-BUN-BMI-FACTOR
101400     END-IF.
101500
101600******************************************************************
101700***  Calculate BUNDLED ONSET factor                            ***
101800******************************************************************
101900     IF B-DIALYSIS-START-DATE > ZERO  THEN
102000        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
102100        COMPUTE INTEGER-LINE-ITEM-DATE =
102200            FUNCTION INTEGER-OF-DATE(THE-DATE)
102300        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
102400        COMPUTE INTEGER-DIALYSIS-DATE  =
102500            FUNCTION INTEGER-OF-DATE(THE-DATE)
102600* Need to add one to onset-date because the start date should
102700* be included in the count of days.  fix made 9/6/2011
102800        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
102900                              INTEGER-DIALYSIS-DATE) + 1
103000        IF H-PATIENT-AGE > 17  THEN
103100           IF ONSET-DATE > 120  THEN
103200              MOVE 1                   TO H-BUN-ONSET-FACTOR
103300           ELSE
103400              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
103500              MOVE "Y"                 TO ONSET-TRACK
103600           END-IF
103700        ELSE
103800           MOVE 1                      TO H-BUN-ONSET-FACTOR
103900        END-IF
104000     ELSE
104100        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
104200     END-IF.
104300
104400******************************************************************
104500***  Set BUNDLED Co-morbidities adjustment                     ***
104600******************************************************************
104700     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
104800        IF H-PATIENT-AGE  <  18  THEN
104900           MOVE 1.000                  TO
105000                                       H-BUN-COMORBID-MULTIPLIER
105100           MOVE '10'                   TO PPS-2011-COMORBID-PAY
105200        ELSE
105300           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
105400              MOVE 1.000               TO
105500                                       H-BUN-COMORBID-MULTIPLIER
105600              MOVE '10'                TO PPS-2011-COMORBID-PAY
105700           ELSE
105800              PERFORM 2100-CALC-COMORBID-ADJUST
105900              MOVE H-COMORBID-MULTIPLIER TO
106000                                       H-BUN-COMORBID-MULTIPLIER
106100           END-IF
106200        END-IF
106300     ELSE
106400        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
106500           MOVE 1.000                  TO
106600                                       H-BUN-COMORBID-MULTIPLIER
106700           MOVE '10'                   TO PPS-2011-COMORBID-PAY
106800        ELSE
106900           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
107000              MOVE CM-GI-BLEED         TO
107100                                       H-BUN-COMORBID-MULTIPLIER
107200              MOVE '20'                TO PPS-2011-COMORBID-PAY
107300           ELSE
107400*            IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
107500*                MOVE CM-PNEUMONIA     TO
107600*                                      H-BUN-COMORBID-MULTIPLIER
107700*                MOVE '30'             TO PPS-2011-COMORBID-PAY
107800*            ELSE
107900                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
108000                    MOVE CM-PERICARDITIS TO
108100                                       H-BUN-COMORBID-MULTIPLIER
108200                    MOVE '40'          TO PPS-2011-COMORBID-PAY
108300                 END-IF
108400*            END-IF
108500           END-IF
108600        END-IF
108700     END-IF.
108800
108900******************************************************************
109000***  Calculate BUNDLED Low Volume adjustment                   ***
109100******************************************************************
109200     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
109300        IF H-PATIENT-AGE > 17  THEN
109400           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
109500                                       H-BUN-LOW-VOL-MULTIPLIER
109600           MOVE "Y"                    TO  LOW-VOLUME-TRACK
109700        ELSE
109800           MOVE 1.000                  TO
109900                                       H-BUN-LOW-VOL-MULTIPLIER
110000        END-IF
110100     ELSE
110200        MOVE 1.000                     TO
110300                                       H-BUN-LOW-VOL-MULTIPLIER
110400     END-IF.
110500
110600***************************************************************
110700* Calculate Rural Adjustment Multiplier ADDED CY 2016
110800***************************************************************
110900     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
111000        MOVE CM-RURAL TO H-BUN-RURAL-MULTIPLIER
111100     ELSE
111200        MOVE 1.000 TO H-BUN-RURAL-MULTIPLIER.
111300
111400******************************************************************
111500***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
111600******************************************************************
111700     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
111800        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
111900        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
112000        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
112100        H-BUN-LOW-VOL-MULTIPLIER * H-BUN-RURAL-MULTIPLIER.
112200
112300******************************************************************
112400***  Calculate BUNDLED Condition Code payment                  ***
112500******************************************************************
112600* Self-care in Training add-on
112700     IF B-COND-CODE = '73'  THEN
112800* no add-on when onset is present
112900        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
113000           MOVE ZERO                   TO
113100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
113200        ELSE
113300* use new PPS training add-on amount times wage-index
113400           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
113500             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
113600           MOVE "Y"                    TO TRAINING-TRACK
113700        END-IF
113800     ELSE
113900* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
114000        IF (B-COND-CODE = '74')  AND
114100           (B-REV-CODE = '0841' OR '0851')  THEN
114200              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
114300                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
114400        ELSE
114500           MOVE ZERO                   TO
114600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
114700                                    H-CC-74-PER-DIEM-AMT
114800        END-IF
114900     END-IF.
115000
115100******************************************************************
115200***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
115300******************************************************************
115400     IF (B-COND-CODE = '74')  AND
115500        (B-REV-CODE = '0841' OR '0851')  THEN
115600           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
115700                           H-CC-74-PER-DIEM-AMT
115800           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
115900              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
116000              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
116100     ELSE COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
116200                  H-BUN-ADJUSTED-BASE-WAGE-AMT  +
116300                  H-BUN-WAGE-ADJ-TRAINING-AMT
116400     END-IF.
116500
116600******************************************************************
116700***  Calculate BUNDLED Outlier                                 ***
116800******************************************************************
116900     PERFORM 2500-CALC-OUTLIER-FACTORS.
117000
117100******************************************************************
117200***  Calculate Low Volume payment for recovery purposes        ***
117300******************************************************************
117400     IF LOW-VOLUME-TRACK = "Y"  THEN
117500        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
117600        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
117700
117800        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
117900           H-PPS-FINAL-PAY-AMT
118000
118100        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
118200           H-OUT-PAYMENT
118300
118400        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
118500           H-LV-OUT-PAYMENT
118600
118700        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
118800           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
118900              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
119000        ELSE
119100           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
119200        END-IF
119300     END-IF.
119400
119500
119600/
119700 2100-CALC-COMORBID-ADJUST.
119800******************************************************************
119900***  Calculate Co-morbidities adjustment                       ***
120000******************************************************************
120100*  This logic assumes that the comorbids are randomly assigned   *
120200*to the comorbid table.  It will select the highest comorbid for *
120300*payment if one is found.  CY 2016 DROPPED MB & MF              *
120400******************************************************************
120500     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
120600     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
120700     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
120800
120900     PERFORM VARYING  SUB  FROM  1 BY 1
121000       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
121100         IF COMORBID-DATA (SUB) = 'MA'  THEN
121200           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
121300*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
121400           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
121500           MOVE '20'                   TO PPS-2011-COMORBID-PAY
121600         ELSE
121700*          IF COMORBID-DATA (SUB) = 'MB'  THEN
121800*            IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
121900*              MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
122000*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
122100*              MOVE '30'               TO PPS-2011-COMORBID-PAY
122200*            END-IF
122300*          ELSE
122400             IF COMORBID-DATA (SUB) = 'MC'  THEN
122500                IF CM-PERICARDITIS  >
122600                                      H-COMORBID-MULTIPLIER  THEN
122700                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
122800                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
122900                  MOVE '40'            TO PPS-2011-COMORBID-PAY
123000                END-IF
123100             ELSE
123200               IF COMORBID-DATA (SUB) = 'MD'  THEN
123300                 IF CM-MYELODYSPLASTIC  >
123400                                      H-COMORBID-MULTIPLIER  THEN
123500                   MOVE CM-MYELODYSPLASTIC  TO
123600                                      H-COMORBID-MULTIPLIER
123700                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
123800                   MOVE '50'           TO PPS-2011-COMORBID-PAY
123900                 END-IF
124000               ELSE
124100                 IF COMORBID-DATA (SUB) = 'ME'  THEN
124200                   IF CM-SICKEL-CELL  >
124300                                      H-COMORBID-MULTIPLIER  THEN
124400                     MOVE CM-SICKEL-CELL  TO
124500                                      H-COMORBID-MULTIPLIER
124600                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
124700                     MOVE '60'         TO PPS-2011-COMORBID-PAY
124800                   END-IF
124900*                ELSE
125000*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
125100*                    IF CM-MONOCLONAL-GAMM  >
125200*                                     H-COMORBID-MULTIPLIER  THEN
125300*                      MOVE CM-MONOCLONAL-GAMM TO
125400*                                     H-COMORBID-MULTIPLIER
125500*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
125600*                      MOVE '70'       TO PPS-2011-COMORBID-PAY
125700*                    END-IF
125800*                  END-IF
125900                 END-IF
126000               END-IF
126100             END-IF
126200*          END-IF
126300         END-IF
126400     END-PERFORM.
126500/
126600 2500-CALC-OUTLIER-FACTORS.
126700******************************************************************
126800***  Set separately billable OUTLIER age adjustment factor     ***
126900******************************************************************
127000     IF H-PATIENT-AGE < 13  THEN
127100        IF B-REV-CODE = '0821' OR '0881' THEN
127200           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
127300        ELSE
127400           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
127500        END-IF
127600     ELSE
127700        IF H-PATIENT-AGE < 18 THEN
127800           IF B-REV-CODE = '0821' OR '0881'  THEN
127900              MOVE SB-AGE-13-17-HEMO-MODE
128000                                       TO H-OUT-AGE-FACTOR
128100           ELSE
128200              MOVE SB-AGE-13-17-PD-MODE
128300                                       TO H-OUT-AGE-FACTOR
128400           END-IF
128500        ELSE
128600           IF H-PATIENT-AGE < 45  THEN
128700              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
128800           ELSE
128900              IF H-PATIENT-AGE < 60  THEN
129000                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
129100              ELSE
129200                 IF H-PATIENT-AGE < 70  THEN
129300                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
129400                 ELSE
129500                    IF H-PATIENT-AGE < 80  THEN
129600                       MOVE SB-AGE-70-79
129700                                       TO H-OUT-AGE-FACTOR
129800                    ELSE
129900                       MOVE SB-AGE-80-PLUS
130000                                       TO H-OUT-AGE-FACTOR
130100                    END-IF
130200                 END-IF
130300              END-IF
130400           END-IF
130500        END-IF
130600     END-IF.
130700
130800******************************************************************
130900**Calculate separately billable OUTLIER BSA factor (superscript)**
131000******************************************************************
131100     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
131200         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
131300
131400     IF H-PATIENT-AGE > 17  THEN
131500        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
131600*            SB-BSA ** ((H-OUT-BSA - 1.90) / .1)
131700             SB-BSA ** ((H-OUT-BSA - BSA-NATIONAL-AVERAGE) / .1)
131800     ELSE
131900        MOVE 1.000                     TO H-OUT-BSA-FACTOR
132000     END-IF.
132100
132200******************************************************************
132300***  Calculate separately billable OUTLIER BMI factor          ***
132400******************************************************************
132500     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
132600         (B-PATIENT-HGT ** 2)) * 10000.
132700
132800     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
132900        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
133000     ELSE
133100        MOVE 1.000                     TO H-OUT-BMI-FACTOR
133200     END-IF.
133300
133400******************************************************************
133500***  Calculate separately billable OUTLIER ONSET factor        ***
133600******************************************************************
133700     IF B-DIALYSIS-START-DATE > ZERO  THEN
133800        IF H-PATIENT-AGE > 17  THEN
133900           IF ONSET-DATE > 120  THEN
134000              MOVE 1                   TO H-OUT-ONSET-FACTOR
134100           ELSE
134200              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
134300           END-IF
134400        ELSE
134500           MOVE 1                      TO H-OUT-ONSET-FACTOR
134600        END-IF
134700     ELSE
134800        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
134900     END-IF.
135000
135100******************************************************************
135200***  Set separately billable OUTLIER Co-morbidities adjustment ***
135300* CY 2016 DROPPED MB & MF
135400******************************************************************
135500     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
135600        IF H-PATIENT-AGE  <  18  THEN
135700           MOVE 1.000                  TO
135800                                       H-OUT-COMORBID-MULTIPLIER
135900           MOVE '10'                   TO PPS-2011-COMORBID-PAY
136000        ELSE
136100           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
136200              MOVE 1.000               TO
136300                                       H-OUT-COMORBID-MULTIPLIER
136400              MOVE '10'                TO PPS-2011-COMORBID-PAY
136500           ELSE
136600              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
136700           END-IF
136800        END-IF
136900     ELSE
137000        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
137100           MOVE 1.000                  TO
137200                                       H-OUT-COMORBID-MULTIPLIER
137300        ELSE
137400           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
137500              MOVE SB-GI-BLEED         TO
137600                                       H-OUT-COMORBID-MULTIPLIER
137700           ELSE
137800*             IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
137900*                MOVE SB-PNEUMONIA     TO
138000*                                      H-OUT-COMORBID-MULTIPLIER
138100*             ELSE
138200                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
138300                    MOVE SB-PERICARDITIS TO
138400                                       H-OUT-COMORBID-MULTIPLIER
138500                 END-IF
138600*             END-IF
138700           END-IF
138800        END-IF
138900     END-IF.
139000
139100******************************************************************
139200***  Set OUTLIER low-volume-multiplier                         ***
139300******************************************************************
139400     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
139500        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
139600     ELSE
139700        IF H-PATIENT-AGE < 18  THEN
139800           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
139900        ELSE
140000           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
140100           MOVE "Y"                    TO LOW-VOLUME-TRACK
140200        END-IF
140300     END-IF.
140400
140500***************************************************************
140600* Calculate OUTLIER Rural Adjustment multiplier
140700***************************************************************
140800
140900     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
141000        MOVE SB-RURAL TO H-OUT-RURAL-MULTIPLIER
141100     ELSE
141200        MOVE 1.000 TO H-OUT-RURAL-MULTIPLIER.
141300
141400******************************************************************
141500***  Calculate predicted OUTLIER services MAP per treatment    ***
141600******************************************************************
141700     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
141800        (H-OUT-AGE-FACTOR             *
141900         H-OUT-BSA-FACTOR             *
142000         H-OUT-BMI-FACTOR             *
142100         H-OUT-ONSET-FACTOR           *
142200         H-OUT-COMORBID-MULTIPLIER    *
142300         H-OUT-RURAL-MULTIPLIER       *
142400         H-OUT-LOW-VOL-MULTIPLIER).
142500
142600******************************************************************
142700***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
142800******************************************************************
142900     IF H-PATIENT-AGE < 18  THEN
143000        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
143100           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
143200        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
143300     ELSE
143400
143500        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
143600           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
143700        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
143800     END-IF.
143900
144000******************************************************************
144100*** Calculate imputed OUTLIER services MAP amount per treatment***
144200******************************************************************
144300     IF (B-COND-CODE = '74')  AND
144400        (B-REV-CODE = '0841' OR '0851')  THEN
144500         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
144600            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
144700         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
144800         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
144900     ELSE
145000        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
145100        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
145200     END-IF.
145300
145400******************************************************************
145500*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
145600******************************************************************
145700     IF H-PATIENT-AGE < 18   THEN
145800        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
145900           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
146000        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
146100        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
146200           COMPUTE H-OUT-PAYMENT  ROUNDED  =
146300            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
146400                                         LOSS-SHARING-PCT-LT-18
146500           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
146600           MOVE "Y"                    TO OUTLIER-TRACK
146700        ELSE
146800           MOVE ZERO                   TO H-OUT-PAYMENT
146900           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
147000        END-IF
147100     ELSE
147200        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
147300           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
147400           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
147500        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
147600           COMPUTE H-OUT-PAYMENT  ROUNDED  =
147700            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
147800                                         LOSS-SHARING-PCT-GT-17
147900           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
148000           MOVE "Y"                    TO OUTLIER-TRACK
148100        ELSE
148200           MOVE ZERO                   TO H-OUT-PAYMENT
148300        END-IF
148400     END-IF.
148500
148600     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
148700
148800* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
148900     IF (B-COND-CODE = '74')  AND
149000        (B-REV-CODE = '0841' OR '0851')  THEN
149100           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
149200             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
149300     END-IF.
149400/
149500 2600-CALC-COMORBID-OUT-ADJUST.
149600******************************************************************
149700***  Calculate OUTLIER Co-morbidities adjustment               ***
149800******************************************************************
149900*  This logic assumes that the comorbids are randomly assigned   *
150000*to the comorbid table.  It will select the highest comorbid for *
150100*payment if one is found. CY 2016 DROPPED MB & MF                *
150200******************************************************************
150300
150400     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
150500     MOVE 1.000                        TO
150600                                  H-OUT-COMORBID-MULTIPLIER.
150700
150800     PERFORM VARYING  SUB  FROM  1 BY 1
150900       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
151000         IF COMORBID-DATA (SUB) = 'MA'  THEN
151100           MOVE SB-GI-BLEED            TO
151200                                  H-OUT-COMORBID-MULTIPLIER
151300*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
151400           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
151500         ELSE
151600*          IF COMORBID-DATA (SUB) = 'MB'  THEN
151700*            IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
151800*              MOVE SB-PNEUMONIA       TO
151900*                                 H-OUT-COMORBID-MULTIPLIER
152000*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
152100*            END-IF
152200*          ELSE
152300             IF COMORBID-DATA (SUB) = 'MC'  THEN
152400                IF SB-PERICARDITIS  >
152500                                  H-OUT-COMORBID-MULTIPLIER  THEN
152600                  MOVE SB-PERICARDITIS TO
152700                                  H-OUT-COMORBID-MULTIPLIER
152800                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
152900                END-IF
153000             ELSE
153100               IF COMORBID-DATA (SUB) = 'MD'  THEN
153200                 IF SB-MYELODYSPLASTIC  >
153300                                  H-OUT-COMORBID-MULTIPLIER  THEN
153400                   MOVE SB-MYELODYSPLASTIC  TO
153500                                  H-OUT-COMORBID-MULTIPLIER
153600                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
153700                 END-IF
153800               ELSE
153900                 IF COMORBID-DATA (SUB) = 'ME'  THEN
154000                   IF SB-SICKEL-CELL  >
154100                                 H-OUT-COMORBID-MULTIPLIER  THEN
154200                     MOVE SB-SICKEL-CELL  TO
154300                                  H-OUT-COMORBID-MULTIPLIER
154400                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
154500                   END-IF
154600*                ELSE
154700*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
154800*                    IF SB-MONOCLONAL-GAMM  >
154900*                                 H-OUT-COMORBID-MULTIPLIER  THEN
155000*                      MOVE SB-MONOCLONAL-GAMM  TO
155100*                                 H-OUT-COMORBID-MULTIPLIER
155200*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
155300*                    END-IF
155400*                  END-IF
155500                 END-IF
155600               END-IF
155700             END-IF
155800*          END-IF
155900         END-IF
156000     END-PERFORM.
156100/
156200******************************************************************
156300*** Calculate Low Volume Full PPS payment for recovery purposes***
156400******************************************************************
156500 3000-LOW-VOL-FULL-PPS-PAYMENT.
156600******************************************************************
156700** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
156800     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
156900        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
157000        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
157100        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
157200         H-BUN-RURAL-MULTIPLIER.
157300
157400******************************************************************
157500**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
157600* Self-care in Training add-on
157700     IF B-COND-CODE = '73'  THEN
157800* no add-on when onset is present
157900        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
158000           MOVE ZERO                   TO
158100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
158200        ELSE
158300* use new PPS training add-on amount times wage-index
158400           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
158500             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
158600           MOVE "Y"                    TO TRAINING-TRACK
158700        END-IF
158800     ELSE
158900* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
159000        IF (B-COND-CODE = '74')  AND
159100           (B-REV-CODE = '0841' OR '0851')  THEN
159200              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
159300                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
159400        ELSE
159500           MOVE ZERO                   TO
159600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
159700                                    H-CC-74-PER-DIEM-AMT
159800        END-IF
159900     END-IF.
160000
160100******************************************************************
160200**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
160300     IF (B-COND-CODE = '74')  AND
160400        (B-REV-CODE = '0841' OR '0851')  THEN
160500           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
160600                           H-CC-74-PER-DIEM-AMT
160700     ELSE
160800        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
160900                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
161000                H-BUN-WAGE-ADJ-TRAINING-AMT
161100     END-IF.
161200
161300/
161400******************************************************************
161500*** Calculate Low Volume OUT PPS payment for recovery purposes ***
161600******************************************************************
161700 3100-LOW-VOL-OUT-PPS-PAYMENT.
161800******************************************************************
161900**Modified code from 'Calc predict OUT serv MAP per treat' para.**
162000     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
162100        (H-OUT-AGE-FACTOR             *
162200         H-OUT-BSA-FACTOR             *
162300         H-OUT-BMI-FACTOR             *
162400         H-OUT-ONSET-FACTOR           *
162500         H-OUT-COMORBID-MULTIPLIER    *
162600         H-OUT-RURAL-MULTIPLIER).
162700
162800******************************************************************
162900**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
163000     IF H-PATIENT-AGE < 18  THEN
163100        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
163200           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
163300        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
163400     ELSE
163500        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
163600           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
163700        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
163800     END-IF.
163900
164000******************************************************************
164100** 'Calculate imput OUT services MAP amount per treatment' para **
164200** It is not necessary to modify or insert this paragraph here. **
164300
164400******************************************************************
164500**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
164600     IF H-PATIENT-AGE < 18   THEN
164700        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
164800           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
164900        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
165000        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
165100           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
165200            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
165300                                         LOSS-SHARING-PCT-LT-18
165400           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
165500        ELSE
165600           MOVE ZERO                   TO H-LV-OUT-PAYMENT
165700           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
165800        END-IF
165900     ELSE
166000        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
166100           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
166200           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
166300        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
166400           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
166500            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
166600                                         LOSS-SHARING-PCT-GT-17
166700           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
166800        ELSE
166900           MOVE ZERO                   TO H-LV-OUT-PAYMENT
167000        END-IF
167100     END-IF.
167200
167300     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
167400
167500* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
167600     IF (B-COND-CODE = '74')  AND
167700        (B-REV-CODE = '0841' OR '0851')  THEN
167800           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
167900             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
168000     END-IF.
168100
168200
168300/
168400 9000-SET-RETURN-CODE.
168500******************************************************************
168600***  Set the return code                                       ***
168700******************************************************************
168800*   The following 'table' helps in understanding and in making   *
168900*changes to the rather large and complex "IF" statement that     *
169000*follows.  This 'table' just reorders and rewords the comments   *
169100*contained in the working storage area concerning the paid       *
169200*return-codes.                                                   *
169300*                                                                *
169400*  17 = pediatric, outlier, training                             *
169500*  16 = pediatric, outlier                                       *
169600*  15 = pediatric, training                                      *
169700*  14 = pediatric                                                *
169800*                                                                *
169900*  24 = outlier, low volume, training, chronic comorbid          *
170000*  19 = outlier, low volume, training, acute comorbid            *
170100*  29 = outlier, low volume, training                            *
170200*  23 = outlier, low volume, chronic comorbid                    *
170300*  18 = outlier, low volume, acute comorbid                      *
170400*  30 = outlier, low volume, onset                               *
170500*  28 = outlier, low volume                                      *
170600*  34 = outlier, training, chronic comorbid                      *
170700*  35 = outlier, training, acute comorbid                        *
170800*  33 = outlier, training                                        *
170900*  07 = outlier, chronic comorbid                                *
171000*  06 = outlier, acute comorbid                                  *
171100*  09 = outlier, onset                                           *
171200*  03 = outlier                                                  *
171300*                                                                *
171400*  26 = low volume, training, chronic comorbid                   *
171500*  21 = low volume, training, acute comorbid                     *
171600*  12 = low volume, training                                     *
171700*  25 = low volume, chronic comorbid                             *
171800*  20 = low volume, acute comorbid                               *
171900*  32 = low volume, onset                                        *
172000*  10 = low volume                                               *
172100*                                                                *
172200*  27 = training, chronic comorbid                               *
172300*  22 = training, acute comorbid                                 *
172400*  11 = training                                                 *
172500*                                                                *
172600*  08 = onset                                                    *
172700*  04 = acute comorbid                                           *
172800*  05 = chronic comorbid                                         *
172900*  31 = low BMI                                                  *
173000*  02 = no adjustments                                           *
173100*                                                                *
173200*  13 = w/multiple adjustments....reserved for future use        *
173300******************************************************************
173400/
173500     IF PEDIATRIC-TRACK                       = "Y"  THEN
173600        IF OUTLIER-TRACK                      = "Y"  THEN
173700           IF TRAINING-TRACK                  = "Y"  THEN
173800              MOVE 17                  TO PPS-RTC
173900           ELSE
174000              MOVE 16                  TO PPS-RTC
174100           END-IF
174200        ELSE
174300           IF TRAINING-TRACK                  = "Y"  THEN
174400              MOVE 15                  TO PPS-RTC
174500           ELSE
174600              MOVE 14                  TO PPS-RTC
174700           END-IF
174800        END-IF
174900     ELSE
175000        IF OUTLIER-TRACK                      = "Y"  THEN
175100           IF LOW-VOLUME-TRACK                = "Y"  THEN
175200              IF TRAINING-TRACK               = "Y"  THEN
175300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
175400                    MOVE 24            TO PPS-RTC
175500                 ELSE
175600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
175700                       MOVE 19         TO PPS-RTC
175800                    ELSE
175900                       MOVE 29         TO PPS-RTC
176000                    END-IF
176100                 END-IF
176200              ELSE
176300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
176400                    MOVE 23            TO PPS-RTC
176500                 ELSE
176600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
176700                       MOVE 18         TO PPS-RTC
176800                    ELSE
176900                       IF ONSET-TRACK         = "Y"  THEN
177000                          MOVE 30      TO PPS-RTC
177100                       ELSE
177200                          MOVE 28      TO PPS-RTC
177300                       END-IF
177400                    END-IF
177500                 END-IF
177600              END-IF
177700           ELSE
177800              IF TRAINING-TRACK               = "Y"  THEN
177900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
178000                    MOVE 34            TO PPS-RTC
178100                 ELSE
178200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
178300                       MOVE 35         TO PPS-RTC
178400                    ELSE
178500                       MOVE 33         TO PPS-RTC
178600                    END-IF
178700                 END-IF
178800              ELSE
178900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
179000                    MOVE 07            TO PPS-RTC
179100                 ELSE
179200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
179300                       MOVE 06         TO PPS-RTC
179400                    ELSE
179500                       IF ONSET-TRACK         = "Y"  THEN
179600                          MOVE 09      TO PPS-RTC
179700                       ELSE
179800                          MOVE 03      TO PPS-RTC
179900                       END-IF
180000                    END-IF
180100                 END-IF
180200              END-IF
180300           END-IF
180400        ELSE
180500           IF LOW-VOLUME-TRACK                = "Y"
180600              IF TRAINING-TRACK               = "Y"  THEN
180700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
180800                    MOVE 26            TO PPS-RTC
180900                 ELSE
181000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
181100                       MOVE 21         TO PPS-RTC
181200                    ELSE
181300                       MOVE 12         TO PPS-RTC
181400                    END-IF
181500                 END-IF
181600              ELSE
181700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
181800                    MOVE 25            TO PPS-RTC
181900                 ELSE
182000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
182100                       MOVE 20         TO PPS-RTC
182200                    ELSE
182300                       IF ONSET-TRACK         = "Y"  THEN
182400                          MOVE 32      TO PPS-RTC
182500                       ELSE
182600                          MOVE 10      TO PPS-RTC
182700                       END-IF
182800                    END-IF
182900                 END-IF
183000              END-IF
183100           ELSE
183200              IF TRAINING-TRACK               = "Y"  THEN
183300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
183400                    MOVE 27            TO PPS-RTC
183500                 ELSE
183600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
183700                       MOVE 22         TO PPS-RTC
183800                    ELSE
183900                       MOVE 11         TO PPS-RTC
184000                    END-IF
184100                 END-IF
184200              ELSE
184300                 IF ONSET-TRACK               = "Y"  THEN
184400                    MOVE 08            TO PPS-RTC
184500                 ELSE
184600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
184700                       MOVE 04         TO PPS-RTC
184800                    ELSE
184900                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
185000                          MOVE 05      TO PPS-RTC
185100                       ELSE
185200                          IF LOW-BMI-TRACK = "Y"  THEN
185300                             MOVE 31 TO PPS-RTC
185400                          ELSE
185500                             MOVE 02 TO PPS-RTC
185600                          END-IF
185700                       END-IF
185800                    END-IF
185900                 END-IF
186000              END-IF
186100           END-IF
186200        END-IF
186300     END-IF.
186400
186500/
186600 9100-MOVE-RESULTS.
186700     IF MOVED-CORMORBIDS = SPACES  THEN
186800        NEXT SENTENCE
186900     ELSE
187000        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
187100        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
187200        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
187300        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
187400        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
187500        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
187600        MOVE H-COMORBID-CWF-CODE       TO
187700                                    COMORBID-CWF-RETURN-CODE
187800     END-IF.
187900
188000     MOVE P-GEO-MSA                    TO PPS-MSA.
188100     MOVE P-GEO-CBSA                   TO PPS-CBSA.
188200     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
188300     MOVE B-COND-CODE                  TO PPS-COND-CODE.
188400     MOVE B-REV-CODE                   TO PPS-REV-CODE.
188500     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
188600     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
188700     MOVE BUN-NAT-NONLABOR-PCT         TO
188800                                    PPS-2011-NAT-NONLABOR-PCT.
188900     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
189000     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
189100     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
189200     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
189300     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
189400     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
189500     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
189600     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
189700     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
189800     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
189900                                    PPS-2011-BDGT-NEUT-RATE.
190000     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
190100     MOVE SPACES                       TO
190200                                    PPS-2011-COMORBID-MA-CC.
190300
190400     IF (B-COND-CODE = '74')  AND
190500        (B-REV-CODE = '0841' OR '0851')  THEN
190600         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
190700                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
190800     END-IF.
190900
191000     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
191100           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
191200              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
191300           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
191400              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
191500           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
191600              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
191700     ELSE
191800        MOVE ZERO                      TO
191900                                    PPS-2011-BLEND-COMP-RATE
192000        MOVE ZERO                      TO
192100                                    PPS-2011-BLEND-PPS-RATE
192200        MOVE ZERO                      TO
192300                                    PPS-2011-BLEND-OUTLIER-RATE
192400     END-IF.
192500
192600     MOVE H-PYMT-AMT                   TO
192700                                    PPS-2011-FULL-COMP-RATE.
192800     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
192900                                          PPS-FINAL-PAY-AMT.
193000     MOVE H-OUT-PAYMENT                TO
193100                                    PPS-2011-FULL-OUTLIER-RATE.
193200
193300     IF B-COND-CODE NOT = '84' THEN
193400        IF P-QIP-REDUCTION = ' ' THEN
193500           NEXT SENTENCE
193600        ELSE
193700           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
193800                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
193900           COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
194000                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
194100           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
194200                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
194300           COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
194400                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
194500           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
194600                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
194700           COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
194800                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
194900        END-IF
195000     END-IF.
195100
195200     IF BUNDLED-TEST   THEN
195300        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
195400        MOVE 0.0                       TO MSA-WAGE-ADJ
195500        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
195600        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
195700        MOVE H-PATIENT-AGE             TO AGE-RETURN
195800        MOVE 0.0                       TO MSA-WAGE-AMT
195900        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
196000        MOVE H-BMI                     TO PPS-BMI
196100        MOVE H-BSA                     TO PPS-BSA
196200        MOVE MSA-BLEND-PCT             TO MSA-PCT
196300        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
196400
196500        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
196600           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
196700           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
196800        ELSE
196900           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
197000           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
197100        END-IF
197200
197300        MOVE H-BUN-BSA                 TO BUN-BSA
197400        MOVE H-BUN-BMI                 TO BUN-BMI
197500        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
197600        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
197700        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
197800        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
197900        MOVE H-OUT-BSA                 TO OUT-BSA
198000        MOVE SB-BSA                    TO OUT-SB-BSA
198100        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
198200        MOVE H-OUT-BMI                 TO OUT-BMI
198300        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
198400        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
198500        MOVE H-OUT-COMORBID-MULTIPLIER TO
198600                                    OUT-COMORBID-MULTIPLIER
198700        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
198800                                    OUT-PREDICTED-SERVICES-MAP
198900        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
199000                                    OUT-CASE-MIX-PREDICTED-MAP
199100        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
199200                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
199300        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
199400        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
199500        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
199600        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
199700        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
199800        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
199900        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
200000        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
200100        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
200200        MOVE CM-BSA                    TO PPS-CM-BSA
200300        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
200400        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
200500        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
200600        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
200700                                    BUN-ADJUSTED-BASE-WAGE-AMT
200800        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
200900                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
201000        MOVE TRAINING-ADD-ON-PMT-AMT   TO
201100                                    PPS-TRAINING-ADD-ON-PMT-AMT
201200        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
201300     END-IF.
201400******        L A S T   S O U R C E   S T A T E M E N T      *****
