000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL191.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2019
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
032300* 11/14/2017 ESCAL180 FOR PRODUCTION EFFECTIVE 1-1-18
032400* - CR10312 Annual Update:
032500*   - Changed BUNDLED-BASE-PMT-RATE to 232.37
032600*   - Changed ADJ-AVG-MAP-AMT-GT-17 to 42.41
032700*   - Changed ADJ-AVG-MAP-AMT-LT-18 to 37.31
032800*   - Changed FIX-DOLLAR-LOSS-GT-17 to 77.54
032900*   - Changed FIX-DOLLAR-LOSS-LT-18 to 47.79
033000* - Put a '10' in PPS-2011-COMORBID-PAY for AKI claims
033100*
033200* 10/17/2018 ESCAL190 FOR PRODUCTION EFFECTIVE 1-1-19
033300* - CR11021 Annual Update:
033400*   - Changed BUNDLED-BASE-PMT-RATE to 235.27
033500*   - Changed BUN-NAT-LABOR-PCT to 0.52300
033600*   - Changed BUN-NAT-NONLABOR-PCT to 0.47700
033700*   - Changed ADJ-AVG-MAP-AMT-GT-17 to 38.51
033800*   - Changed ADJ-AVG-MAP-AMT-LT-18 to 35.18
033900*   - Changed FIX-DOLLAR-LOSS-GT-17 to 65.11
034000*   - Changed FIX-DOLLAR-LOSS-LT-18 to 57.14
034100*
034200* 02/04/2019 ESCAL191 - NO CHANGES TO LOGIC OR RATES
034210*    - CORRECTED WAGE INDEX MEMBERS AS FOLLOWS:
034300*      - REPLACED ESBUN190 WITH ESBUN191
034400*      - REPLACED BUNDCBSA
034500*
034600******************************************************************
034700 DATE-COMPILED.
034800 ENVIRONMENT DIVISION.
034900 CONFIGURATION SECTION.
035000 SOURCE-COMPUTER.            IBM-Z990.
035100 OBJECT-COMPUTER.            IBM-Z990.
035200 INPUT-OUTPUT  SECTION.
035300 FILE-CONTROL.
035400
035500 DATA DIVISION.
035600 FILE SECTION.
035700/
035800 WORKING-STORAGE SECTION.
035900 01  W-STORAGE-REF                  PIC X(46) VALUE
036000     'ESCAL191      - W O R K I N G   S T O R A G E'.
036100 01  CAL-VERSION                    PIC X(05) VALUE 'C19.1'.
036200
036300 01  DISPLAY-LINE-MEASUREMENT.
036400     05  FILLER                     PIC X(50) VALUE
036500         '....:...10....:...20....:...30....:...40....:...50'.
036600     05  FILLER                     PIC X(50) VALUE
036700         '....:...60....:...70....:...80....:...90....:..100'.
036800     05  FILLER                     PIC X(20) VALUE
036900         '....:..110....:..120'.
037000
037100 01  PRINT-LINE-MEASUREMENT.
037200     05  FILLER                     PIC X(51) VALUE
037300         'X....:...10....:...20....:...30....:...40....:...50'.
037400     05  FILLER                     PIC X(50) VALUE
037500         '....:...60....:...70....:...80....:...90....:..100'.
037600     05  FILLER                     PIC X(32) VALUE
037700         '....:..110....:..120....:..130..'.
037800/
037900******************************************************************
038000*  This area contains all of the old Composite Rate variables.   *
038100* They will be eliminated when the transition period ends - 2014 *
038200******************************************************************
038300 01  HOLD-COMP-RATE-PPS-COMPONENTS.
038400     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
038500     05  H-PYMT-AMT                 PIC 9(04)V9(02).
038600     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
038700     05  H-PATIENT-AGE              PIC 9(03).
038800     05  H-AGE-FACTOR               PIC 9(01)V9(03).
038900     05  H-BSA-FACTOR               PIC 9(01)V9(04).
039000     05  H-BMI-FACTOR               PIC 9(01)V9(04).
039100     05  H-BSA                      PIC 9(03)V9(04).
039200     05  H-BMI                      PIC 9(03)V9(04).
039300     05  HGT-PART                   PIC 9(04)V9(08).
039400     05  WGT-PART                   PIC 9(04)V9(08).
039500     05  COMBINED-PART              PIC 9(04)V9(08).
039600     05  CALC-BSA                   PIC 9(04)V9(08).
039700
039800
039900* The following two variables will change from year to year
040000* and are used for the COMPOSITE part of the Bundled Pricer.
040100 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
040200 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
040300
040400* The next two percentages MUST add up to 1 (i.e. 100%)
040500* They will continue to change until CY2009 when CBSA will be 1.00
040600 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
040700 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
040800
040900* CONSTANTS AREA
041000* The next two percentages MUST add up TO 1 (i.e. 100%)
041100 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
041200 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
041300
041400* The next variable is only applicapable for the 2011 Pricer.
041500 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
041600
041700 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
041800 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
041900 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
042000                                                         0.428571.
042100* The above number technically represents the fractional
042200* number 3/7 which is three days per week that a person can
042300* receive dialysis.  It will remain this value ONLY for the
042400* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
042500* use the calculation method which is more understandable and
042600* follows the method used by the Policy folks.
042700
042800*  The following number that is loaded into the payment equation
042900*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
043000*  and   --DOES NOT CHANGE--
043100
043200 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
043300
043400 01  COMPOSITE-RATE-MULTIPLIERS.
043500*Composite rate payment multiplier (used for blended providers)
043600     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
043700     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
043800     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
043900     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
044000     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
044100     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
044200
044300     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
044400     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
044500/
044600******************************************************************
044700*    This area contains all of the NEW Bundled Rate variables.   *
044800******************************************************************
044900 01  HOLD-BUNDLED-PPS-COMPONENTS.
045000     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
045100     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
045200     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
045300     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
045400     05  H-BUN-BSA                  PIC 9(03)V9(04).
045500     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
045600     05  H-BUN-BMI                  PIC 9(03)V9(04).
045700     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
045800     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
045900     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
046000     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
046100                                    PIC 9(07)V9(04).
046200     05  H-BUN-WAGE-ADJ-TRAINING-AMT
046300                                    PIC 9(07)V9(04).
046400     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
046500     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
046600     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
046700     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
046800     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
046900                                    PIC 9(07)V9(04).
047000     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
047100     05  H-LV-OUT-PREDICT-SERVICES-MAP
047200                                    PIC 9(07)V9(04).
047300     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
047400                                    PIC 9(07)V9(04).
047500     05  H-LV-OUT-PREDICTED-MAP
047600                                    PIC 9(07)V9(04).
047700     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
047800
047900     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
048000     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
048100         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
048200
048300     05  H-COMORBID-DATA  OCCURS 6 TIMES
048400            INDEXED BY H-COMORBID-INDEX
048500                                    PIC X(02).
048600     05  H-COMORBID-CWF-CODE        PIC X(02).
048700
048800     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
048900
049000     05  QIP-REDUCTION              PIC 9(01)V9(03).
049100     05  SUB                        PIC 9(04).
049200
049300     05  THE-DATE                   PIC 9(08).
049400     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
049500     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
049600     05  ONSET-DATE                 PIC 9(08).
049700     05  MOVED-CORMORBIDS           PIC X(01).
049800     05  H-BUN-RURAL-MULTIPLIER     PIC 9(01)V9(03).
049900     05  H-TDAPA-PAYMENT            PIC 9(07)V9(04).
050000
050100 01  HOLD-OUTLIER-PPS-COMPONENTS.
050200     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
050300     05  H-OUT-BSA                  PIC 9(03)V9(04).
050400     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
050500     05  H-OUT-BMI                  PIC 9(03)V9(04).
050600     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
050700     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
050800     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
050900     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
051000     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
051100     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
051200     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
051300     05  H-OUT-PREDICTED-SERVICES-MAP
051400                                    PIC 9(07)V9(04).
051500     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
051600     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
051700                                    PIC 9(07)V9(04).
051800     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
051900     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
052000     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
052100     05  H-OUT-RURAL-MULTIPLIER     PIC 9(01)V9(03).
052200
052300* The following variable will change from year to year and is
052400* used for the BUNDLED part of the Bundled Pricer.
052500 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 235.27.
052600
052700* The next two percentages MUST add up to 1 (i.e. 100%)
052800* They start in 2011 and will continue to change until CY2014 when
052900* BUN-CBSA-BLEND-PCT will be 1.00
053000* The third blend percent is for those providers that waived the
053100* blended percent and went to full PPS.  This variable will be
053200* eliminated in 2014 when it is no longer needed.
053300 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
053400 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
053500 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
053600
053700* CONSTANTS AREA
053800* The next two percentages MUST add up TO 1 (i.e. 100%)
053900 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.52300.
054000 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.47700.
054100 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 95.60.
054200
054300*  The following number that is loaded into the payment equation
054400*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
054500*  and   --DOES NOT CHANGE--
054600 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
054700
054800* Added a constant to hold the BSA-National-Average that is used
054900* in the BSA Calculation. This value changes every five years.
055000 01 BSA-NATIONAL-AVERAGE            PIC 9(01)V9(02) VALUE 1.90.
055100
055200 01  PEDIATRIC-MULTIPLIERS.
055300*Separately billable payment multiplier (used for outliers)
055400     05  PED-SEP-BILL-PAY-MULTI.
055500         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.410.
055600         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.406.
055700         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.569.
055800         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.494.
055900     05  PED-EXPAND-BUNDLE-PAY-MULTI.
056000*Expanded bundle payment multiplier (used for normal billing)
056100         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.063.
056200         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.306.
056300         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.102.
056400         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.327.
056500
056600 01  ADULT-MULTIPLIERS.
056700*Separately billable payment multiplier (used for outliers)
056800     05  SEP-BILLABLE-PAYMANT-MULTI.
056900         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 1.044.
057000         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 1.000.
057100         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.005.
057200         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
057300         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.961.
057400         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.000.
057500         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.090.
057600         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.409.
057700         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.209.
057800*        10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
057900         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.426.
058000         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.999.
058100         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.494.
058200*        10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
058300         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.955.
058400         10 SB-RURAL               PIC 9(01)V9(03) VALUE 0.978.
058500*Case-Mix adjusted payment multiplier (used for normal billing)
058600     05  CASE-MIX-PAYMENT-MULTI.
058700         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.257.
058800         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.068.
058900         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.070.
059000         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
059100         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.109.
059200         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.032.
059300         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.017.
059400         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.327.
059500         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.040.
059600*        10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
059700         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.082.
059800         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.192.
059900         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.095.
060000*        10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
060100         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.239.
060200         10 CM-RURAL               PIC 9(01)V9(03) VALUE 1.008.
060300
060400 01  OUTLIER-SB-CALC-AMOUNTS.
060500     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 35.18.
060600     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 38.51.
060700     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 57.14.
060800     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 65.11.
060900     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
061000     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
061100/
061200******************************************************************
061300*    This area contains return code variables and their codes.   *
061400******************************************************************
061500 01 PAID-RETURN-CODE-TRACKERS.
061600     05  OUTLIER-TRACK              PIC X(01).
061700     05  ACUTE-COMORBID-TRACK       PIC X(01).
061800     05  CHRONIC-COMORBID-TRACK     PIC X(01).
061900     05  ONSET-TRACK                PIC X(01).
062000     05  LOW-VOLUME-TRACK           PIC X(01).
062100     05  TRAINING-TRACK             PIC X(01).
062200     05  PEDIATRIC-TRACK            PIC X(01).
062300     05  LOW-BMI-TRACK              PIC X(01).
062400 COPY RTCCPY.
062500*COPY "RTCCPY.CPY".
062600*                                                                *
062700*  Legal combinations of adjustments for ADULTS are:             *
062800*     if NO ONSET applies, then they can have any combination of:*
062900*       acute OR chronic comorbid, & outlier, low vol., training.*
063000*     if ONSET applies, then they can have:                      *
063100*           outlier and/or low volume.                           *
063200*  Legal combinations of adjustments for PEDIATRIC are:          *
063300*     outlier and/or training.                                   *
063400*                                                                *
063500*  Illegal combinations of adjustments for PEDIATRIC are:        *
063600*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
063700*     onset     with comorbid or training.                       *
063800*  Illegal combinations of adjustments for ANYONE are:           *
063900*     acute comorbid AND chronic comorbid.                       *
064000/
064100 LINKAGE SECTION.
064200 COPY BILLCPY.
064300*COPY "BILLCPY.CPY".
064400/
064500 COPY WAGECPY.
064600*COPY "WAGECPY.CPY".
064700/
064800 PROCEDURE DIVISION  USING BILL-NEW-DATA
064900                           PPS-DATA-ALL
065000                           WAGE-NEW-RATE-RECORD
065100                           COM-CBSA-WAGE-RECORD
065200                           BUN-CBSA-WAGE-RECORD.
065300
065400******************************************************************
065500* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
065600* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
065700* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
065800* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
065900* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
066000* UTILIZED HERE HAS BEEN APPROVED BY THE DIVISION OF             *
066100* INSTITUTIONAL CLAIMS PROCESSING (DICP).                        *
066200*                                                                *
066300*    PROCESSING:                                                 *
066400*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
066500*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
066600*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
066700*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
066800*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
066900*           GOBACK.                                              *
067000*        D. ASSEMBLE PRICING COMPONENTS.                         *
067100*        E. CALCULATE THE PRICE.                                 *
067200******************************************************************
067300
067400 0000-START-TO-FINISH.
067500     INITIALIZE PPS-DATA-ALL.
067600
067700* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
067800     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
067900
068000
068100* ESRD PC PRICER USES NEXT FOUR LINES TO INITIALIZE VALUES
068200* THAT IT NEEDS TO DISPLAY DETAILED RESULTS
068300     IF BUNDLED-TEST THEN
068400        INITIALIZE BILL-DATA-TEST
068500        INITIALIZE COND-CD-73
068600     END-IF.
068700
068800     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
068900     MOVE ZEROS                        TO PPS-RTC.
069000
069100     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
069200
069300     IF PPS-RTC = 00  THEN
069400        PERFORM 1200-INITIALIZATION
069500        IF B-COND-CODE  = '84' THEN
069600* Calculate payment for AKI claim
069700           MOVE H-BUN-BASE-WAGE-AMT TO
069800                H-PPS-FINAL-PAY-AMT
069900           MOVE '02' TO PPS-RTC
070000           MOVE '10' TO PPS-2011-COMORBID-PAY
070100        ELSE
070200* Calculate payment for ESRD claim
070300            PERFORM 2000-CALCULATE-BUNDLED-FACTORS
070400            PERFORM 9000-SET-RETURN-CODE
070500        END-IF
070600        PERFORM 9100-MOVE-RESULTS
070700     END-IF.
070800
070900     GOBACK.
071000/
071100 1000-VALIDATE-BILL-ELEMENTS.
071200     IF PPS-RTC = 00  THEN
071300        IF B-COND-CODE NOT = '73' AND '74' AND '84' AND
071400                             '87' AND '  '
071500           MOVE 58                  TO PPS-RTC
071600        END-IF
071700     END-IF.
071800
071900     IF PPS-RTC = 00  THEN
072000        IF  P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
072100           NEXT SENTENCE
072200        ELSE
072300           MOVE 52                        TO PPS-RTC
072400        END-IF
072500     END-IF.
072600
072700     IF PPS-RTC = 00  THEN
072800        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
072900           MOVE 53                     TO PPS-RTC
073000        END-IF
073100     END-IF.
073200
073300     IF PPS-RTC = 00  THEN
073400        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
073500           MOVE 54                     TO PPS-RTC
073600        END-IF
073700     END-IF.
073800
073900     IF PPS-RTC = 00  THEN
074000        IF B-COND-CODE NOT = '84' THEN
074100           IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
074200              MOVE 55                     TO PPS-RTC
074300           END-IF
074400        END-IF
074500     END-IF.
074600
074700     IF PPS-RTC = 00  THEN
074800        IF B-COND-CODE NOT = '84' THEN
074900           IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
075000              MOVE 56                     TO PPS-RTC
075100           END-IF
075200        END-IF
075300     END-IF.
075400
075500     IF PPS-RTC = 00  THEN
075600        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
075700                                OR '0881'
075800           NEXT SENTENCE
075900        ELSE
076000           MOVE 57                     TO PPS-RTC
076100        END-IF
076200     END-IF.
076300
076400     IF PPS-RTC = 00  THEN
076500        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
076600                                 ' '  THEN
076700           MOVE 53                     TO PPS-RTC
076800*  This RTC is for the Special Payment Indicator not = '1' or
076900*  blank, which closely approximates the intent of the edit check.
077000*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
077100        END-IF
077200     END-IF.
077300
077400     IF PPS-RTC = 00  THEN
077500        IF B-COND-CODE NOT = '84' THEN
077600           IF B-PATIENT-HGT > 300.00
077700              MOVE 71                     TO PPS-RTC
077800           END-IF
077900        END-IF
078000     END-IF.
078100
078200     IF PPS-RTC = 00  THEN
078300        IF B-COND-CODE NOT = '84' THEN
078400           IF B-PATIENT-WGT > 500.00  THEN
078500              MOVE 72                     TO PPS-RTC
078600           END-IF
078700        END-IF
078800     END-IF.
078900
079000* Before 2012 pricer, put in edit check to make sure that the
079100* # of sesions does not exceed the # of days in a month.  Maybe
079200* the # of cays in a month minus one when patient goes into a
079300* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
079400* or 0851)).  If done, then will need extra RTC.
079500     IF PPS-RTC = 00  THEN
079600        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
079700           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
079800           MOVE 73                     TO PPS-RTC
079900        END-IF
080000     END-IF.
080100
080200     IF PPS-RTC = 00  THEN
080300        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
080400           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
080500           MOVE 74                     TO PPS-RTC
080600        END-IF
080700     END-IF.
080800
080900     IF PPS-RTC = 00  THEN
081000        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
081100           MOVE 75                     TO PPS-RTC
081200        END-IF
081300     END-IF.
081400
081500     IF PPS-RTC = 00  THEN
081600        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
081700           MOVE 76                     TO PPS-RTC
081800        END-IF
081900     END-IF.
082000*OLD WAY OF VALIDATING COMORBIDS
082100*    IF PPS-RTC = 00  THEN
082200*       IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
082300*           VALID-COMORBID-CWF-RETURN-CD       THEN
082400*          NEXT SENTENCE
082500*       ELSE
082600*          MOVE 81                     TO PPS-RTC
082700*      END-IF
082800*    END-IF.
082900*
083000*CY2016 - DROP PNEUMONIA & MONOCLONAL GAMM COMORBIDS
083100
083200     IF PPS-RTC = 00  THEN
083300        IF B-COND-CODE NOT = '84' THEN
083400           IF COMORBID-CWF-RETURN-CODE = SPACES OR
083500               "10" OR "20" OR "40" OR "50" OR "60" THEN
083600              NEXT SENTENCE
083700           ELSE
083800              MOVE 81                     TO PPS-RTC
083900           END-IF
084000        END-IF
084100     END-IF.
084200/
084300 1200-INITIALIZATION.
084400     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
084500     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
084600     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
084700     INITIALIZE PAID-RETURN-CODE-TRACKERS.
084800
084900
085000******************************************************************
085100***Calculate BUNDLED Wage Adjusted Rate                        ***
085200******************************************************************
085300     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
085400        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
085500         BUN-CBSA-W-INDEX.
085600
085700     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
085800        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
085900
086000     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
086100        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
086200/
086300 2000-CALCULATE-BUNDLED-FACTORS.
086400
086500     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
086600     IF B-DOB-MM > B-THRU-MM  THEN
086700        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
086800     END-IF
086900     IF H-PATIENT-AGE < 18  THEN
087000        MOVE "Y"                    TO PEDIATRIC-TRACK
087100     END-IF.
087200
087300     MOVE SPACES                       TO MOVED-CORMORBIDS.
087400
087500     IF P-QIP-REDUCTION = ' '  THEN
087600* no reduction
087700        MOVE 1.000 TO QIP-REDUCTION
087800     ELSE
087900        IF P-QIP-REDUCTION = '1'  THEN
088000* one-half percent reduction
088100           MOVE 0.995 TO QIP-REDUCTION
088200        ELSE
088300           IF P-QIP-REDUCTION = '2'  THEN
088400* one percent reduction
088500              MOVE 0.990 TO QIP-REDUCTION
088600           ELSE
088700              IF P-QIP-REDUCTION = '3'  THEN
088800* one and one-half percent reduction
088900                 MOVE 0.985 TO QIP-REDUCTION
089000              ELSE
089100* two percent reduction
089200                 MOVE 0.980 TO QIP-REDUCTION
089300              END-IF
089400           END-IF
089500        END-IF
089600     END-IF.
089700
089800*    Since pricer has to pay a comorbid condition according to the
089900* return code that CWF passes back, it is cleaner if the pricer
090000* sets aside whatever comorbid data exists on the line-item when
090100* it comes into the pricer and then transferrs the CWF code to
090200* the appropriate place in the comorbid data.  This avoids
090300* making convoluted changes in the other parts of the program
090400* which has to look at both original comorbid data AND CWF return
090500* codes to handle comorbids.  Near the end of the program where
090600* variables are transferred to the output, the original comorbid
090700* data is put back into its original place as though nothing
090800* occurred.
090900*CY2016 DROPPED MB & MF
091000     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
091100        NEXT SENTENCE
091200     ELSE
091300        MOVE 'Y'                       TO MOVED-CORMORBIDS
091400        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
091500        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
091600        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
091700        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
091800        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
091900        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
092000        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
092100        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
092200           MOVE SPACES                 TO COMORBID-DATA (1)
092300                                          COMORBID-DATA (2)
092400                                          COMORBID-DATA (3)
092500                                          COMORBID-DATA (4)
092600                                          COMORBID-DATA (5)
092700                                          COMORBID-DATA (6)
092800                                          COMORBID-CWF-RETURN-CODE
092900        ELSE
093000           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
093100              MOVE 'MA'                TO COMORBID-DATA (1)
093200              MOVE SPACES              TO COMORBID-DATA (2)
093300                                          COMORBID-DATA (3)
093400                                          COMORBID-DATA (4)
093500                                          COMORBID-DATA (5)
093600                                          COMORBID-DATA (6)
093700                                          COMORBID-CWF-RETURN-CODE
093800           ELSE
093900*             IF COMORBID-CWF-RETURN-CODE = '30'  THEN
094000*                MOVE SPACES           TO COMORBID-DATA (1)
094100*                MOVE 'MB'             TO COMORBID-DATA (2)
094200*                MOVE SPACES           TO COMORBID-DATA (3)
094300*                MOVE SPACES           TO COMORBID-DATA (4)
094400*                MOVE SPACES           TO COMORBID-DATA (5)
094500*                MOVE SPACES           TO COMORBID-DATA (6)
094600*                                         COMORBID-CWF-RETURN-CODE
094700*             ELSE
094800                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
094900                    MOVE SPACES        TO COMORBID-DATA (1)
095000                    MOVE SPACES        TO COMORBID-DATA (2)
095100                    MOVE 'MC'          TO COMORBID-DATA (3)
095200                    MOVE SPACES        TO COMORBID-DATA (4)
095300                    MOVE SPACES        TO COMORBID-DATA (5)
095400                    MOVE SPACES        TO COMORBID-DATA (6)
095500                                          COMORBID-CWF-RETURN-CODE
095600                 ELSE
095700                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
095800                       MOVE SPACES     TO COMORBID-DATA (1)
095900                       MOVE SPACES     TO COMORBID-DATA (2)
096000                       MOVE SPACES     TO COMORBID-DATA (3)
096100                       MOVE 'MD'       TO COMORBID-DATA (4)
096200                       MOVE SPACES     TO COMORBID-DATA (5)
096300                       MOVE SPACES     TO COMORBID-DATA (6)
096400                                          COMORBID-CWF-RETURN-CODE
096500                    ELSE
096600                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
096700                          MOVE SPACES  TO COMORBID-DATA (1)
096800                          MOVE SPACES  TO COMORBID-DATA (2)
096900                          MOVE SPACES  TO COMORBID-DATA (3)
097000                          MOVE SPACES  TO COMORBID-DATA (4)
097100                          MOVE 'ME'    TO COMORBID-DATA (5)
097200                          MOVE SPACES  TO COMORBID-DATA (6)
097300                                          COMORBID-CWF-RETURN-CODE
097400*                      ELSE
097500*                         MOVE SPACES  TO COMORBID-DATA (1)
097600*                                         COMORBID-DATA (2)
097700*                                         COMORBID-DATA (3)
097800*                                         COMORBID-DATA (4)
097900*                                         COMORBID-DATA (5)
098000*                                         COMORBID-CWF-RETURN-CODE
098100*                         MOVE 'MF'    TO COMORBID-DATA (6)
098200                       END-IF
098300                    END-IF
098400                 END-IF
098500*             END-IF
098600           END-IF
098700        END-IF
098800     END-IF.
098900******************************************************************
099000***  Set BUNDLED age adjustment factor                         ***
099100******************************************************************
099200     IF H-PATIENT-AGE < 13  THEN
099300        IF B-REV-CODE = '0821' OR '0881' THEN
099400           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
099500        ELSE
099600           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
099700        END-IF
099800     ELSE
099900        IF H-PATIENT-AGE < 18 THEN
100000           IF B-REV-CODE = '0821' OR '0881' THEN
100100              MOVE EB-AGE-13-17-HEMO-MODE
100200                                       TO H-BUN-AGE-FACTOR
100300           ELSE
100400              MOVE EB-AGE-13-17-PD-MODE
100500                                       TO H-BUN-AGE-FACTOR
100600           END-IF
100700        ELSE
100800           IF H-PATIENT-AGE < 45  THEN
100900              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
101000           ELSE
101100              IF H-PATIENT-AGE < 60  THEN
101200                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
101300              ELSE
101400                 IF H-PATIENT-AGE < 70  THEN
101500                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
101600                 ELSE
101700                    IF H-PATIENT-AGE < 80  THEN
101800                       MOVE CM-AGE-70-79
101900                                       TO H-BUN-AGE-FACTOR
102000                    ELSE
102100                       MOVE CM-AGE-80-PLUS
102200                                       TO H-BUN-AGE-FACTOR
102300                    END-IF
102400                 END-IF
102500              END-IF
102600           END-IF
102700        END-IF
102800     END-IF.
102900
103000******************************************************************
103100***  Calculate BUNDLED BSA factor (note NEW formula)           ***
103200******************************************************************
103300     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
103400         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
103500
103600     IF H-PATIENT-AGE > 17  THEN
103700        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
103800*            CM-BSA ** ((H-BUN-BSA - 1.90) / .1)
103900             CM-BSA ** ((H-BUN-BSA - BSA-NATIONAL-AVERAGE) / .1)
104000     ELSE
104100        MOVE 1.000                     TO H-BUN-BSA-FACTOR
104200     END-IF.
104300
104400******************************************************************
104500***  Calculate BUNDLED BMI factor                              ***
104600******************************************************************
104700     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
104800         (B-PATIENT-HGT ** 2)) * 10000.
104900
105000     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
105100        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
105200        MOVE "Y"                       TO LOW-BMI-TRACK
105300     ELSE
105400        MOVE 1.000                     TO H-BUN-BMI-FACTOR
105500     END-IF.
105600
105700******************************************************************
105800***  Calculate BUNDLED ONSET factor                            ***
105900******************************************************************
106000     IF B-DIALYSIS-START-DATE > ZERO  THEN
106100        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
106200        COMPUTE INTEGER-LINE-ITEM-DATE =
106300            FUNCTION INTEGER-OF-DATE(THE-DATE)
106400        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
106500        COMPUTE INTEGER-DIALYSIS-DATE  =
106600            FUNCTION INTEGER-OF-DATE(THE-DATE)
106700* Need to add one to onset-date because the start date should
106800* be included in the count of days.  fix made 9/6/2011
106900        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
107000                              INTEGER-DIALYSIS-DATE) + 1
107100        IF H-PATIENT-AGE > 17  THEN
107200           IF ONSET-DATE > 120  THEN
107300              MOVE 1                   TO H-BUN-ONSET-FACTOR
107400           ELSE
107500              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
107600              MOVE "Y"                 TO ONSET-TRACK
107700           END-IF
107800        ELSE
107900           MOVE 1                      TO H-BUN-ONSET-FACTOR
108000        END-IF
108100     ELSE
108200        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
108300     END-IF.
108400
108500******************************************************************
108600***  Set BUNDLED Co-morbidities adjustment                     ***
108700******************************************************************
108800     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
108900        IF H-PATIENT-AGE  <  18  THEN
109000           MOVE 1.000                  TO
109100                                       H-BUN-COMORBID-MULTIPLIER
109200           MOVE '10'                   TO PPS-2011-COMORBID-PAY
109300        ELSE
109400           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
109500              MOVE 1.000               TO
109600                                       H-BUN-COMORBID-MULTIPLIER
109700              MOVE '10'                TO PPS-2011-COMORBID-PAY
109800           ELSE
109900              PERFORM 2100-CALC-COMORBID-ADJUST
110000              MOVE H-COMORBID-MULTIPLIER TO
110100                                       H-BUN-COMORBID-MULTIPLIER
110200           END-IF
110300        END-IF
110400     ELSE
110500        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
110600           MOVE 1.000                  TO
110700                                       H-BUN-COMORBID-MULTIPLIER
110800           MOVE '10'                   TO PPS-2011-COMORBID-PAY
110900        ELSE
111000           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
111100              MOVE CM-GI-BLEED         TO
111200                                       H-BUN-COMORBID-MULTIPLIER
111300              MOVE '20'                TO PPS-2011-COMORBID-PAY
111400           ELSE
111500*            IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
111600*                MOVE CM-PNEUMONIA     TO
111700*                                      H-BUN-COMORBID-MULTIPLIER
111800*                MOVE '30'             TO PPS-2011-COMORBID-PAY
111900*            ELSE
112000                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
112100                    MOVE CM-PERICARDITIS TO
112200                                       H-BUN-COMORBID-MULTIPLIER
112300                    MOVE '40'          TO PPS-2011-COMORBID-PAY
112400                 END-IF
112500*            END-IF
112600           END-IF
112700        END-IF
112800     END-IF.
112900
113000******************************************************************
113100***  Calculate BUNDLED Low Volume adjustment                   ***
113200******************************************************************
113300     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
113400        IF H-PATIENT-AGE > 17  THEN
113500           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
113600                                       H-BUN-LOW-VOL-MULTIPLIER
113700           MOVE "Y"                    TO  LOW-VOLUME-TRACK
113800        ELSE
113900           MOVE 1.000                  TO
114000                                       H-BUN-LOW-VOL-MULTIPLIER
114100        END-IF
114200     ELSE
114300        MOVE 1.000                     TO
114400                                       H-BUN-LOW-VOL-MULTIPLIER
114500     END-IF.
114600
114700***************************************************************
114800* Calculate Rural Adjustment Multiplier ADDED CY 2016
114900***************************************************************
115000     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
115100        MOVE CM-RURAL TO H-BUN-RURAL-MULTIPLIER
115200     ELSE
115300        MOVE 1.000 TO H-BUN-RURAL-MULTIPLIER.
115400
115500******************************************************************
115600***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
115700******************************************************************
115800     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
115900        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
116000        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
116100        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
116200        H-BUN-LOW-VOL-MULTIPLIER * H-BUN-RURAL-MULTIPLIER.
116300
116400******************************************************************
116500***  Calculate BUNDLED Condition Code payment                  ***
116600******************************************************************
116700* Self-care in Training add-on
116800     IF B-COND-CODE = '73' OR '87' THEN
116900* no add-on when onset is present
117000        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
117100           MOVE ZERO                   TO
117200                                    H-BUN-WAGE-ADJ-TRAINING-AMT
117300        ELSE
117400* use new PPS training add-on amount times wage-index
117500           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
117600             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
117700           MOVE "Y"                    TO TRAINING-TRACK
117800        END-IF
117900     ELSE
118000* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
118100        IF (B-COND-CODE = '74')  AND
118200           (B-REV-CODE = '0841' OR '0851')  THEN
118300              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
118400                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
118500        ELSE
118600           MOVE ZERO                   TO
118700                                    H-BUN-WAGE-ADJ-TRAINING-AMT
118800                                    H-CC-74-PER-DIEM-AMT
118900        END-IF
119000     END-IF.
119100
119200******************************************************************
119300***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
119400******************************************************************
119500     IF (B-COND-CODE = '74')  AND
119600        (B-REV-CODE = '0841' OR '0851')  THEN
119700           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
119800                           H-CC-74-PER-DIEM-AMT
119900           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
120000              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
120100              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
120200     ELSE COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
120300                  H-BUN-ADJUSTED-BASE-WAGE-AMT  +
120400                  H-BUN-WAGE-ADJ-TRAINING-AMT
120500     END-IF.
120600
120700****************************************************************
120800***  Include TDAPA Payment                                   ***
120900****************************************************************
121000     COMPUTE H-TDAPA-PAYMENT = B-PAYER-ONLY-VC-Q8 /
121100                               B-CLAIM-NUM-DIALYSIS-SESSIONS.
121200     COMPUTE H-PPS-FINAL-PAY-AMT = H-PPS-FINAL-PAY-AMT +
121300                                   H-TDAPA-PAYMENT.
121400
121500******************************************************************
121600***  Calculate BUNDLED Outlier                                 ***
121700******************************************************************
121800     PERFORM 2500-CALC-OUTLIER-FACTORS.
121900
122000******************************************************************
122100***  Calculate Low Volume payment for recovery purposes        ***
122200******************************************************************
122300     IF LOW-VOLUME-TRACK = "Y"  THEN
122400        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
122500        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
122600
122700        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
122800           H-PPS-FINAL-PAY-AMT
122900
123000        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
123100           H-OUT-PAYMENT
123200
123300        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
123400           H-LV-OUT-PAYMENT
123500
123600        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
123700           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
123800              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
123900        ELSE
124000           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
124100        END-IF
124200     END-IF.
124300
124400
124500/
124600 2100-CALC-COMORBID-ADJUST.
124700******************************************************************
124800***  Calculate Co-morbidities adjustment                       ***
124900******************************************************************
125000*  This logic assumes that the comorbids are randomly assigned   *
125100*to the comorbid table.  It will select the highest comorbid for *
125200*payment if one is found.  CY 2016 DROPPED MB & MF              *
125300******************************************************************
125400     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
125500     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
125600     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
125700
125800     PERFORM VARYING  SUB  FROM  1 BY 1
125900       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
126000         IF COMORBID-DATA (SUB) = 'MA'  THEN
126100           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
126200*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
126300           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
126400           MOVE '20'                   TO PPS-2011-COMORBID-PAY
126500         ELSE
126600*          IF COMORBID-DATA (SUB) = 'MB'  THEN
126700*            IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
126800*              MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
126900*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
127000*              MOVE '30'               TO PPS-2011-COMORBID-PAY
127100*            END-IF
127200*          ELSE
127300             IF COMORBID-DATA (SUB) = 'MC'  THEN
127400                IF CM-PERICARDITIS  >
127500                                      H-COMORBID-MULTIPLIER  THEN
127600                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
127700                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
127800                  MOVE '40'            TO PPS-2011-COMORBID-PAY
127900                END-IF
128000             ELSE
128100               IF COMORBID-DATA (SUB) = 'MD'  THEN
128200                 IF CM-MYELODYSPLASTIC  >
128300                                      H-COMORBID-MULTIPLIER  THEN
128400                   MOVE CM-MYELODYSPLASTIC  TO
128500                                      H-COMORBID-MULTIPLIER
128600                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
128700                   MOVE '50'           TO PPS-2011-COMORBID-PAY
128800                 END-IF
128900               ELSE
129000                 IF COMORBID-DATA (SUB) = 'ME'  THEN
129100                   IF CM-SICKEL-CELL  >
129200                                      H-COMORBID-MULTIPLIER  THEN
129300                     MOVE CM-SICKEL-CELL  TO
129400                                      H-COMORBID-MULTIPLIER
129500                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
129600                     MOVE '60'         TO PPS-2011-COMORBID-PAY
129700                   END-IF
129800*                ELSE
129900*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
130000*                    IF CM-MONOCLONAL-GAMM  >
130100*                                     H-COMORBID-MULTIPLIER  THEN
130200*                      MOVE CM-MONOCLONAL-GAMM TO
130300*                                     H-COMORBID-MULTIPLIER
130400*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
130500*                      MOVE '70'       TO PPS-2011-COMORBID-PAY
130600*                    END-IF
130700*                  END-IF
130800                 END-IF
130900               END-IF
131000             END-IF
131100*          END-IF
131200         END-IF
131300     END-PERFORM.
131400/
131500 2500-CALC-OUTLIER-FACTORS.
131600******************************************************************
131700***  Set separately billable OUTLIER age adjustment factor     ***
131800******************************************************************
131900     IF H-PATIENT-AGE < 13  THEN
132000        IF B-REV-CODE = '0821' OR '0881' THEN
132100           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
132200        ELSE
132300           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
132400        END-IF
132500     ELSE
132600        IF H-PATIENT-AGE < 18 THEN
132700           IF B-REV-CODE = '0821' OR '0881'  THEN
132800              MOVE SB-AGE-13-17-HEMO-MODE
132900                                       TO H-OUT-AGE-FACTOR
133000           ELSE
133100              MOVE SB-AGE-13-17-PD-MODE
133200                                       TO H-OUT-AGE-FACTOR
133300           END-IF
133400        ELSE
133500           IF H-PATIENT-AGE < 45  THEN
133600              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
133700           ELSE
133800              IF H-PATIENT-AGE < 60  THEN
133900                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
134000              ELSE
134100                 IF H-PATIENT-AGE < 70  THEN
134200                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
134300                 ELSE
134400                    IF H-PATIENT-AGE < 80  THEN
134500                       MOVE SB-AGE-70-79
134600                                       TO H-OUT-AGE-FACTOR
134700                    ELSE
134800                       MOVE SB-AGE-80-PLUS
134900                                       TO H-OUT-AGE-FACTOR
135000                    END-IF
135100                 END-IF
135200              END-IF
135300           END-IF
135400        END-IF
135500     END-IF.
135600
135700******************************************************************
135800**Calculate separately billable OUTLIER BSA factor (superscript)**
135900******************************************************************
136000     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
136100         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
136200
136300     IF H-PATIENT-AGE > 17  THEN
136400        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
136500*            SB-BSA ** ((H-OUT-BSA - 1.90) / .1)
136600             SB-BSA ** ((H-OUT-BSA - BSA-NATIONAL-AVERAGE) / .1)
136700     ELSE
136800        MOVE 1.000                     TO H-OUT-BSA-FACTOR
136900     END-IF.
137000
137100******************************************************************
137200***  Calculate separately billable OUTLIER BMI factor          ***
137300******************************************************************
137400     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
137500         (B-PATIENT-HGT ** 2)) * 10000.
137600
137700     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
137800        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
137900     ELSE
138000        MOVE 1.000                     TO H-OUT-BMI-FACTOR
138100     END-IF.
138200
138300******************************************************************
138400***  Calculate separately billable OUTLIER ONSET factor        ***
138500******************************************************************
138600     IF B-DIALYSIS-START-DATE > ZERO  THEN
138700        IF H-PATIENT-AGE > 17  THEN
138800           IF ONSET-DATE > 120  THEN
138900              MOVE 1                   TO H-OUT-ONSET-FACTOR
139000           ELSE
139100              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
139200           END-IF
139300        ELSE
139400           MOVE 1                      TO H-OUT-ONSET-FACTOR
139500        END-IF
139600     ELSE
139700        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
139800     END-IF.
139900
140000******************************************************************
140100***  Set separately billable OUTLIER Co-morbidities adjustment ***
140200* CY 2016 DROPPED MB & MF
140300******************************************************************
140400     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
140500        IF H-PATIENT-AGE  <  18  THEN
140600           MOVE 1.000                  TO
140700                                       H-OUT-COMORBID-MULTIPLIER
140800           MOVE '10'                   TO PPS-2011-COMORBID-PAY
140900        ELSE
141000           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
141100              MOVE 1.000               TO
141200                                       H-OUT-COMORBID-MULTIPLIER
141300              MOVE '10'                TO PPS-2011-COMORBID-PAY
141400           ELSE
141500              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
141600           END-IF
141700        END-IF
141800     ELSE
141900        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
142000           MOVE 1.000                  TO
142100                                       H-OUT-COMORBID-MULTIPLIER
142200        ELSE
142300           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
142400              MOVE SB-GI-BLEED         TO
142500                                       H-OUT-COMORBID-MULTIPLIER
142600           ELSE
142700*             IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
142800*                MOVE SB-PNEUMONIA     TO
142900*                                      H-OUT-COMORBID-MULTIPLIER
143000*             ELSE
143100                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
143200                    MOVE SB-PERICARDITIS TO
143300                                       H-OUT-COMORBID-MULTIPLIER
143400                 END-IF
143500*             END-IF
143600           END-IF
143700        END-IF
143800     END-IF.
143900
144000******************************************************************
144100***  Set OUTLIER low-volume-multiplier                         ***
144200******************************************************************
144300     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
144400        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
144500     ELSE
144600        IF H-PATIENT-AGE < 18  THEN
144700           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
144800        ELSE
144900           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
145000           MOVE "Y"                    TO LOW-VOLUME-TRACK
145100        END-IF
145200     END-IF.
145300
145400***************************************************************
145500* Calculate OUTLIER Rural Adjustment multiplier
145600***************************************************************
145700
145800     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
145900        MOVE SB-RURAL TO H-OUT-RURAL-MULTIPLIER
146000     ELSE
146100        MOVE 1.000 TO H-OUT-RURAL-MULTIPLIER.
146200
146300******************************************************************
146400***  Calculate predicted OUTLIER services MAP per treatment    ***
146500******************************************************************
146600     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
146700        (H-OUT-AGE-FACTOR             *
146800         H-OUT-BSA-FACTOR             *
146900         H-OUT-BMI-FACTOR             *
147000         H-OUT-ONSET-FACTOR           *
147100         H-OUT-COMORBID-MULTIPLIER    *
147200         H-OUT-RURAL-MULTIPLIER       *
147300         H-OUT-LOW-VOL-MULTIPLIER).
147400
147500******************************************************************
147600***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
147700******************************************************************
147800     IF H-PATIENT-AGE < 18  THEN
147900        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
148000           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
148100        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
148200     ELSE
148300
148400        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
148500           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
148600        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
148700     END-IF.
148800
148900******************************************************************
149000*** Calculate imputed OUTLIER services MAP amount per treatment***
149100******************************************************************
149200     IF (B-COND-CODE = '74')  AND
149300        (B-REV-CODE = '0841' OR '0851')  THEN
149400         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
149500            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
149600         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
149700         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
149800     ELSE
149900        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
150000        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
150100     END-IF.
150200
150300******************************************************************
150400*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
150500******************************************************************
150600     IF H-PATIENT-AGE < 18   THEN
150700        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
150800           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
150900        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
151000        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
151100           COMPUTE H-OUT-PAYMENT  ROUNDED  =
151200            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
151300                                         LOSS-SHARING-PCT-LT-18
151400           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
151500           MOVE "Y"                    TO OUTLIER-TRACK
151600        ELSE
151700           MOVE ZERO                   TO H-OUT-PAYMENT
151800           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
151900        END-IF
152000     ELSE
152100        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
152200           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
152300           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
152400        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
152500           COMPUTE H-OUT-PAYMENT  ROUNDED  =
152600            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
152700                                         LOSS-SHARING-PCT-GT-17
152800           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
152900           MOVE "Y"                    TO OUTLIER-TRACK
153000        ELSE
153100           MOVE ZERO                   TO H-OUT-PAYMENT
153200        END-IF
153300     END-IF.
153400
153500     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
153600
153700* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
153800     IF (B-COND-CODE = '74')  AND
153900        (B-REV-CODE = '0841' OR '0851')  THEN
154000           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
154100             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
154200     END-IF.
154300/
154400 2600-CALC-COMORBID-OUT-ADJUST.
154500******************************************************************
154600***  Calculate OUTLIER Co-morbidities adjustment               ***
154700******************************************************************
154800*  This logic assumes that the comorbids are randomly assigned   *
154900*to the comorbid table.  It will select the highest comorbid for *
155000*payment if one is found. CY 2016 DROPPED MB & MF                *
155100******************************************************************
155200
155300     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
155400     MOVE 1.000                        TO
155500                                  H-OUT-COMORBID-MULTIPLIER.
155600
155700     PERFORM VARYING  SUB  FROM  1 BY 1
155800       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
155900         IF COMORBID-DATA (SUB) = 'MA'  THEN
156000           MOVE SB-GI-BLEED            TO
156100                                  H-OUT-COMORBID-MULTIPLIER
156200*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
156300           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
156400         ELSE
156500*          IF COMORBID-DATA (SUB) = 'MB'  THEN
156600*            IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
156700*              MOVE SB-PNEUMONIA       TO
156800*                                 H-OUT-COMORBID-MULTIPLIER
156900*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
157000*            END-IF
157100*          ELSE
157200             IF COMORBID-DATA (SUB) = 'MC'  THEN
157300                IF SB-PERICARDITIS  >
157400                                  H-OUT-COMORBID-MULTIPLIER  THEN
157500                  MOVE SB-PERICARDITIS TO
157600                                  H-OUT-COMORBID-MULTIPLIER
157700                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
157800                END-IF
157900             ELSE
158000               IF COMORBID-DATA (SUB) = 'MD'  THEN
158100                 IF SB-MYELODYSPLASTIC  >
158200                                  H-OUT-COMORBID-MULTIPLIER  THEN
158300                   MOVE SB-MYELODYSPLASTIC  TO
158400                                  H-OUT-COMORBID-MULTIPLIER
158500                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
158600                 END-IF
158700               ELSE
158800                 IF COMORBID-DATA (SUB) = 'ME'  THEN
158900                   IF SB-SICKEL-CELL  >
159000                                 H-OUT-COMORBID-MULTIPLIER  THEN
159100                     MOVE SB-SICKEL-CELL  TO
159200                                  H-OUT-COMORBID-MULTIPLIER
159300                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
159400                   END-IF
159500*                ELSE
159600*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
159700*                    IF SB-MONOCLONAL-GAMM  >
159800*                                 H-OUT-COMORBID-MULTIPLIER  THEN
159900*                      MOVE SB-MONOCLONAL-GAMM  TO
160000*                                 H-OUT-COMORBID-MULTIPLIER
160100*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
160200*                    END-IF
160300*                  END-IF
160400                 END-IF
160500               END-IF
160600             END-IF
160700*          END-IF
160800         END-IF
160900     END-PERFORM.
161000/
161100******************************************************************
161200*** Calculate Low Volume Full PPS payment for recovery purposes***
161300******************************************************************
161400 3000-LOW-VOL-FULL-PPS-PAYMENT.
161500******************************************************************
161600** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
161700     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
161800        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
161900        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
162000        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
162100         H-BUN-RURAL-MULTIPLIER.
162200
162300******************************************************************
162400**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
162500* Self-care in Training add-on
162600     IF B-COND-CODE = '73' OR '87' THEN
162700* no add-on when onset is present
162800        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
162900           MOVE ZERO                   TO
163000                                    H-BUN-WAGE-ADJ-TRAINING-AMT
163100        ELSE
163200* use new PPS training add-on amount times wage-index
163300           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
163400             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
163500           MOVE "Y"                    TO TRAINING-TRACK
163600        END-IF
163700     ELSE
163800* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
163900        IF (B-COND-CODE = '74')  AND
164000           (B-REV-CODE = '0841' OR '0851')  THEN
164100              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
164200                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
164300        ELSE
164400           MOVE ZERO                   TO
164500                                    H-BUN-WAGE-ADJ-TRAINING-AMT
164600                                    H-CC-74-PER-DIEM-AMT
164700        END-IF
164800     END-IF.
164900
165000******************************************************************
165100**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
165200     IF (B-COND-CODE = '74')  AND
165300        (B-REV-CODE = '0841' OR '0851')  THEN
165400           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
165500                           H-CC-74-PER-DIEM-AMT
165600     ELSE
165700        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
165800                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
165900                H-BUN-WAGE-ADJ-TRAINING-AMT
166000     END-IF.
166100
166200/
166300******************************************************************
166400*** Calculate Low Volume OUT PPS payment for recovery purposes ***
166500******************************************************************
166600 3100-LOW-VOL-OUT-PPS-PAYMENT.
166700******************************************************************
166800**Modified code from 'Calc predict OUT serv MAP per treat' para.**
166900     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
167000        (H-OUT-AGE-FACTOR             *
167100         H-OUT-BSA-FACTOR             *
167200         H-OUT-BMI-FACTOR             *
167300         H-OUT-ONSET-FACTOR           *
167400         H-OUT-COMORBID-MULTIPLIER    *
167500         H-OUT-RURAL-MULTIPLIER).
167600
167700******************************************************************
167800**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
167900     IF H-PATIENT-AGE < 18  THEN
168000        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
168100           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
168200        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
168300     ELSE
168400        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
168500           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
168600        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
168700     END-IF.
168800
168900******************************************************************
169000** 'Calculate imput OUT services MAP amount per treatment' para **
169100** It is not necessary to modify or insert this paragraph here. **
169200
169300******************************************************************
169400**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
169500     IF H-PATIENT-AGE < 18   THEN
169600        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
169700           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
169800        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
169900        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
170000           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
170100            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
170200                                         LOSS-SHARING-PCT-LT-18
170300           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
170400        ELSE
170500           MOVE ZERO                   TO H-LV-OUT-PAYMENT
170600           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
170700        END-IF
170800     ELSE
170900        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
171000           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
171100           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
171200        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
171300           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
171400            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
171500                                         LOSS-SHARING-PCT-GT-17
171600           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
171700        ELSE
171800           MOVE ZERO                   TO H-LV-OUT-PAYMENT
171900        END-IF
172000     END-IF.
172100
172200     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
172300
172400* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
172500     IF (B-COND-CODE = '74')  AND
172600        (B-REV-CODE = '0841' OR '0851')  THEN
172700           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
172800             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
172900     END-IF.
173000
173100
173200/
173300 9000-SET-RETURN-CODE.
173400******************************************************************
173500***  Set the return code                                       ***
173600******************************************************************
173700*   The following 'table' helps in understanding and in making   *
173800*changes to the rather large and complex "IF" statement that     *
173900*follows.  This 'table' just reorders and rewords the comments   *
174000*contained in the working storage area concerning the paid       *
174100*return-codes.                                                   *
174200*                                                                *
174300*  17 = pediatric, outlier, training                             *
174400*  16 = pediatric, outlier                                       *
174500*  15 = pediatric, training                                      *
174600*  14 = pediatric                                                *
174700*                                                                *
174800*  24 = outlier, low volume, training, chronic comorbid          *
174900*  19 = outlier, low volume, training, acute comorbid            *
175000*  29 = outlier, low volume, training                            *
175100*  23 = outlier, low volume, chronic comorbid                    *
175200*  18 = outlier, low volume, acute comorbid                      *
175300*  30 = outlier, low volume, onset                               *
175400*  28 = outlier, low volume                                      *
175500*  34 = outlier, training, chronic comorbid                      *
175600*  35 = outlier, training, acute comorbid                        *
175700*  33 = outlier, training                                        *
175800*  07 = outlier, chronic comorbid                                *
175900*  06 = outlier, acute comorbid                                  *
176000*  09 = outlier, onset                                           *
176100*  03 = outlier                                                  *
176200*                                                                *
176300*  26 = low volume, training, chronic comorbid                   *
176400*  21 = low volume, training, acute comorbid                     *
176500*  12 = low volume, training                                     *
176600*  25 = low volume, chronic comorbid                             *
176700*  20 = low volume, acute comorbid                               *
176800*  32 = low volume, onset                                        *
176900*  10 = low volume                                               *
177000*                                                                *
177100*  27 = training, chronic comorbid                               *
177200*  22 = training, acute comorbid                                 *
177300*  11 = training                                                 *
177400*                                                                *
177500*  08 = onset                                                    *
177600*  04 = acute comorbid                                           *
177700*  05 = chronic comorbid                                         *
177800*  31 = low BMI                                                  *
177900*  02 = no adjustments                                           *
178000*                                                                *
178100*  13 = w/multiple adjustments....reserved for future use        *
178200******************************************************************
178300/
178400     IF PEDIATRIC-TRACK                       = "Y"  THEN
178500        IF OUTLIER-TRACK                      = "Y"  THEN
178600           IF TRAINING-TRACK                  = "Y"  THEN
178700              MOVE 17                  TO PPS-RTC
178800           ELSE
178900              MOVE 16                  TO PPS-RTC
179000           END-IF
179100        ELSE
179200           IF TRAINING-TRACK                  = "Y"  THEN
179300              MOVE 15                  TO PPS-RTC
179400           ELSE
179500              MOVE 14                  TO PPS-RTC
179600           END-IF
179700        END-IF
179800     ELSE
179900        IF OUTLIER-TRACK                      = "Y"  THEN
180000           IF LOW-VOLUME-TRACK                = "Y"  THEN
180100              IF TRAINING-TRACK               = "Y"  THEN
180200                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
180300                    MOVE 24            TO PPS-RTC
180400                 ELSE
180500                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
180600                       MOVE 19         TO PPS-RTC
180700                    ELSE
180800                       MOVE 29         TO PPS-RTC
180900                    END-IF
181000                 END-IF
181100              ELSE
181200                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
181300                    MOVE 23            TO PPS-RTC
181400                 ELSE
181500                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
181600                       MOVE 18         TO PPS-RTC
181700                    ELSE
181800                       IF ONSET-TRACK         = "Y"  THEN
181900                          MOVE 30      TO PPS-RTC
182000                       ELSE
182100                          MOVE 28      TO PPS-RTC
182200                       END-IF
182300                    END-IF
182400                 END-IF
182500              END-IF
182600           ELSE
182700              IF TRAINING-TRACK               = "Y"  THEN
182800                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
182900                    MOVE 34            TO PPS-RTC
183000                 ELSE
183100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
183200                       MOVE 35         TO PPS-RTC
183300                    ELSE
183400                       MOVE 33         TO PPS-RTC
183500                    END-IF
183600                 END-IF
183700              ELSE
183800                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
183900                    MOVE 07            TO PPS-RTC
184000                 ELSE
184100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
184200                       MOVE 06         TO PPS-RTC
184300                    ELSE
184400                       IF ONSET-TRACK         = "Y"  THEN
184500                          MOVE 09      TO PPS-RTC
184600                       ELSE
184700                          MOVE 03      TO PPS-RTC
184800                       END-IF
184900                    END-IF
185000                 END-IF
185100              END-IF
185200           END-IF
185300        ELSE
185400           IF LOW-VOLUME-TRACK                = "Y"
185500              IF TRAINING-TRACK               = "Y"  THEN
185600                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
185700                    MOVE 26            TO PPS-RTC
185800                 ELSE
185900                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
186000                       MOVE 21         TO PPS-RTC
186100                    ELSE
186200                       MOVE 12         TO PPS-RTC
186300                    END-IF
186400                 END-IF
186500              ELSE
186600                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
186700                    MOVE 25            TO PPS-RTC
186800                 ELSE
186900                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
187000                       MOVE 20         TO PPS-RTC
187100                    ELSE
187200                       IF ONSET-TRACK         = "Y"  THEN
187300                          MOVE 32      TO PPS-RTC
187400                       ELSE
187500                          MOVE 10      TO PPS-RTC
187600                       END-IF
187700                    END-IF
187800                 END-IF
187900              END-IF
188000           ELSE
188100              IF TRAINING-TRACK               = "Y"  THEN
188200                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
188300                    MOVE 27            TO PPS-RTC
188400                 ELSE
188500                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
188600                       MOVE 22         TO PPS-RTC
188700                    ELSE
188800                       MOVE 11         TO PPS-RTC
188900                    END-IF
189000                 END-IF
189100              ELSE
189200                 IF ONSET-TRACK               = "Y"  THEN
189300                    MOVE 08            TO PPS-RTC
189400                 ELSE
189500                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
189600                       MOVE 04         TO PPS-RTC
189700                    ELSE
189800                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
189900                          MOVE 05      TO PPS-RTC
190000                       ELSE
190100                          IF LOW-BMI-TRACK = "Y"  THEN
190200                             MOVE 31 TO PPS-RTC
190300                          ELSE
190400                             MOVE 02 TO PPS-RTC
190500                          END-IF
190600                       END-IF
190700                    END-IF
190800                 END-IF
190900              END-IF
191000           END-IF
191100        END-IF
191200     END-IF.
191300
191400/
191500 9100-MOVE-RESULTS.
191600     IF MOVED-CORMORBIDS = SPACES  THEN
191700        NEXT SENTENCE
191800     ELSE
191900        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
192000        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
192100        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
192200        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
192300        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
192400        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
192500        MOVE H-COMORBID-CWF-CODE       TO
192600                                    COMORBID-CWF-RETURN-CODE
192700     END-IF.
192800
192900     MOVE P-GEO-MSA                    TO PPS-MSA.
193000     MOVE P-GEO-CBSA                   TO PPS-CBSA.
193100     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
193200     MOVE B-COND-CODE                  TO PPS-COND-CODE.
193300     MOVE B-REV-CODE                   TO PPS-REV-CODE.
193400     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
193500     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
193600     MOVE BUN-NAT-NONLABOR-PCT         TO
193700                                    PPS-2011-NAT-NONLABOR-PCT.
193800     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
193900     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
194000     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
194100     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
194200     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
194300     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
194400     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
194500     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
194600     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
194700     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
194800                                    PPS-2011-BDGT-NEUT-RATE.
194900     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
195000     MOVE SPACES                       TO
195100                                    PPS-2011-COMORBID-MA-CC.
195200
195300     IF (B-COND-CODE = '74')  AND
195400        (B-REV-CODE = '0841' OR '0851')  THEN
195500         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
195600                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
195700     END-IF.
195800
195900     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
196000           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
196100              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
196200           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
196300              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
196400           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
196500              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
196600     ELSE
196700        MOVE ZERO                      TO
196800                                    PPS-2011-BLEND-COMP-RATE
196900        MOVE ZERO                      TO
197000                                    PPS-2011-BLEND-PPS-RATE
197100        MOVE ZERO                      TO
197200                                    PPS-2011-BLEND-OUTLIER-RATE
197300     END-IF.
197400
197500     MOVE H-PYMT-AMT                   TO
197600                                    PPS-2011-FULL-COMP-RATE.
197700     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
197800                                          PPS-FINAL-PAY-AMT.
197900     MOVE H-OUT-PAYMENT                TO
198000                                    PPS-2011-FULL-OUTLIER-RATE.
198100
198200     MOVE H-TDAPA-PAYMENT              TO TDAPA-RETURN.
198300
198400     IF B-COND-CODE NOT = '84' THEN
198500        IF P-QIP-REDUCTION = ' ' THEN
198600           NEXT SENTENCE
198700        ELSE
198800           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
198900                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
199000           COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
199100                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
199200           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
199300                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
199400           COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
199500                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
199600           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
199700                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
199800           COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
199900                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
200000        END-IF
200100     END-IF.
200200
200300*ESRD PC PRICER NEEDS BUNDLED-TEST-INDIC SET TO "T" IN ORDER TO BE
200400*TO PASS VALUES FOR DISPLAYING DETAILED RESULTS FROM BILL-DATA-TES
200500*BUNDLED-TEST-INDIC IS NOT SET TO "T"  IN THE PRODUCTION SYSTEM (F
200600     IF BUNDLED-TEST   THEN
200700        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
200800        MOVE 0.0                       TO MSA-WAGE-ADJ
200900        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
201000        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
201100        MOVE H-PATIENT-AGE             TO AGE-RETURN
201200        MOVE 0.0                       TO MSA-WAGE-AMT
201300        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
201400        MOVE H-BMI                     TO PPS-BMI
201500        MOVE H-BSA                     TO PPS-BSA
201600        MOVE MSA-BLEND-PCT             TO MSA-PCT
201700        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
201800
201900        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
202000           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
202100           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
202200        ELSE
202300           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
202400           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
202500        END-IF
202600
202700        MOVE H-BUN-BSA                 TO BUN-BSA
202800        MOVE H-BUN-BMI                 TO BUN-BMI
202900        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
203000        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
203100        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
203200        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
203300        MOVE H-OUT-BSA                 TO OUT-BSA
203400        MOVE SB-BSA                    TO OUT-SB-BSA
203500        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
203600        MOVE H-OUT-BMI                 TO OUT-BMI
203700        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
203800        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
203900        MOVE H-OUT-COMORBID-MULTIPLIER TO
204000                                    OUT-COMORBID-MULTIPLIER
204100        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
204200                                    OUT-PREDICTED-SERVICES-MAP
204300        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
204400                                    OUT-CASE-MIX-PREDICTED-MAP
204500        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
204600                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
204700        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
204800        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
204900        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
205000        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
205100        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
205200        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
205300        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
205400        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
205500        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
205600        MOVE CM-BSA                    TO PPS-CM-BSA
205700        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
205800        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
205900        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
206000        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
206100                                    BUN-ADJUSTED-BASE-WAGE-AMT
206200        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
206300                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
206400        MOVE TRAINING-ADD-ON-PMT-AMT   TO
206500                                    PPS-TRAINING-ADD-ON-PMT-AMT
206600        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
206700     END-IF.
206800******        L A S T   S O U R C E   S T A T E M E N T      *****
