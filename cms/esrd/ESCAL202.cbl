000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL202.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JULY 1, 2020
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
034300*    - CORRECTED WAGE INDEX MEMBERS AS FOLLOWS:
034400*      - REPLACED ESBUN190 WITH ESBUN191
034500*      - REPLACED BUNDCBSA
034600*
034700* 10/09/2019 - ESCAL200 FOR PRODUCTION EFFECTIVE 1-1-20
034800* - CR 11506 Annual Update
034900* Implementation of Changes in the End-Stage Renal Disease (ESRD)
035000* Prospective Payment System (PPS) and Payment for Dialysis
035100* Furnished for Acute Kidney Injury (AKI) in ESRD Facilities
035200* Calendar Year (CY) 2020
035300*   - Changed BUNDLED-BASE-PMT-RATE to 239.33
035400*   - Unchanged BUN-NAT-LABOR-PCT      0.52300
035500*   - Unchanged BUN-NAT-NONLABOR-PCT   0.47700
035600*   - Changed ADJ-AVG-MAP-AMT-GT-17 to 35.78
035700*   - Changed ADJ-AVG-MAP-AMT-LT-18 to 32.32
035800*   - Changed FIX-DOLLAR-LOSS-GT-17 to 48.33
035900*   - Changed FIX-DOLLAR-LOSS-LT-18 to 41.04
036000*
036100* 3-19-20 ESCAL201 CR11390 ESRD Treatment Choices (ETC) Model:
036200*  Home Dialysis Payment Adjustment (HDPA) - Implementation
036300*  New logic and record layout
036400*  New Variables that were added to BILLCPY copybook
036500*    input field for the Data Code
036600*        B-DATA-CODE PIC X(02)
036700*    output field for the Adjusted Base Wage Amount before
036800*       adding bonus
036900*        ADJ-BASE-WAGE-BEFORE-ETC-HDPA  PIC 9(07)V9(04).
037000*  New Constant added to hold Percentage Adjustment
037100*    equals 1.03 for ESRD Pricer v20.1
037200*    ETC-HDPA-PCT  PIC 9V99   VALUE 1.03
037300*  Other New Variables to Hold values for calculations
037400*    H-PER-DIEM-AMT-WITHOUT-HDPA PIC 9(07)V9(04).
037500*    H-PER-DIEM-AMT-WITH-HDPA   PIC 9(07)V9(04).
037600*    H-FINAL-AMT-WITHOUT-HDPA   PIC 9(07)V9(02).
037700*    H-FINAL-AMT-WITH-HDPA      PIC 9(07)V9(02).
037800*
037900* 4-10-20 ESCAL202 - fixed issue where claims with blank QIPs
038000* weren't returning the Adjusted Base Wage Amount before Bonus
038100*
038200******************************************************************
038300 DATE-COMPILED.
038400 ENVIRONMENT DIVISION.
038500 CONFIGURATION SECTION.
038600 SOURCE-COMPUTER.            IBM-Z990.
038700 OBJECT-COMPUTER.            IBM-Z990.
038800 INPUT-OUTPUT  SECTION.
038900 FILE-CONTROL.
039000
039100 DATA DIVISION.
039200 FILE SECTION.
039300/
039400 WORKING-STORAGE SECTION.
039500 01  W-STORAGE-REF                  PIC X(46) VALUE
039600     'ESCAL202      - W O R K I N G   S T O R A G E'.
039700 01  CAL-VERSION                    PIC X(05) VALUE 'C20.2'.
039800
039900 01  DISPLAY-LINE-MEASUREMENT.
040000     05  FILLER                     PIC X(50) VALUE
040100         '....:...10....:...20....:...30....:...40....:...50'.
040200     05  FILLER                     PIC X(50) VALUE
040300         '....:...60....:...70....:...80....:...90....:..100'.
040400     05  FILLER                     PIC X(20) VALUE
040500         '....:..110....:..120'.
040600
040700 01  PRINT-LINE-MEASUREMENT.
040800     05  FILLER                     PIC X(51) VALUE
040900         'X....:...10....:...20....:...30....:...40....:...50'.
041000     05  FILLER                     PIC X(50) VALUE
041100         '....:...60....:...70....:...80....:...90....:..100'.
041200     05  FILLER                     PIC X(32) VALUE
041300         '....:..110....:..120....:..130..'.
041400/
041500******************************************************************
041600*  This area contains all of the old Composite Rate variables.   *
041700* They will be eliminated when the transition period ends - 2014 *
041800******************************************************************
041900 01  HOLD-COMP-RATE-PPS-COMPONENTS.
042000     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
042100     05  H-PYMT-AMT                 PIC 9(04)V9(02).
042200     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
042300     05  H-PATIENT-AGE              PIC 9(03).
042400     05  H-AGE-FACTOR               PIC 9(01)V9(03).
042500     05  H-BSA-FACTOR               PIC 9(01)V9(04).
042600     05  H-BMI-FACTOR               PIC 9(01)V9(04).
042700     05  H-BSA                      PIC 9(03)V9(04).
042800     05  H-BMI                      PIC 9(03)V9(04).
042900     05  HGT-PART                   PIC 9(04)V9(08).
043000     05  WGT-PART                   PIC 9(04)V9(08).
043100     05  COMBINED-PART              PIC 9(04)V9(08).
043200     05  CALC-BSA                   PIC 9(04)V9(08).
043300
043400
043500* The following two variables will change from year to year
043600* and are used for the COMPOSITE part of the Bundled Pricer.
043700 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
043800 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
043900
044000* The next two percentages MUST add up to 1 (i.e. 100%)
044100* They will continue to change until CY2009 when CBSA will be 1.00
044200 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
044300 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
044400
044500* CONSTANTS AREA
044600* The next two percentages MUST add up TO 1 (i.e. 100%)
044700 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
044800 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
044900
045000*  ETC HDPA Percentage Adjustment
045100 01  ETC-HDPA-PCT                   PIC 9V99        VALUE 1.03.
045200
045300* The next variable is only applicapable for the 2011 Pricer.
045400 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
045500
045600 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
045700 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
045800 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
045900                                                         0.428571.
046000* The above number technically represents the fractional
046100* number 3/7 which is three days per week that a person can
046200* receive dialysis.  It will remain this value ONLY for the
046300* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
046400* use the calculation method which is more understandable and
046500* follows the method used by the Policy folks.
046600
046700*  The following number that is loaded into the payment equation
046800*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
046900*  and   --DOES NOT CHANGE--
047000
047100 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
047200
047300 01  COMPOSITE-RATE-MULTIPLIERS.
047400*Composite rate payment multiplier (used for blended providers)
047500     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
047600     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
047700     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
047800     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
047900     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
048000     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
048100
048200     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
048300     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
048400/
048500******************************************************************
048600*    This area contains all of the NEW Bundled Rate variables.   *
048700******************************************************************
048800 01  HOLD-BUNDLED-PPS-COMPONENTS.
048900     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
049000     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
049100     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
049200     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
049300     05  H-BUN-BSA                  PIC 9(03)V9(04).
049400     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
049500     05  H-BUN-BMI                  PIC 9(03)V9(04).
049600     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
049700     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
049800     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
049900     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
050000                                    PIC 9(07)V9(04).
050100     05  H-BUN-WAGE-ADJ-TRAINING-AMT
050200                                    PIC 9(07)V9(04).
050300     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
050400     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
050500     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
050600     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
050700     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
050800                                    PIC 9(07)V9(04).
050900     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
051000     05  H-LV-OUT-PREDICT-SERVICES-MAP
051100                                    PIC 9(07)V9(04).
051200     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
051300                                    PIC 9(07)V9(04).
051400     05  H-LV-OUT-PREDICTED-MAP
051500                                    PIC 9(07)V9(04).
051600     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
051700
051800     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
051900     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
052000         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
052100
052200     05  H-COMORBID-DATA  OCCURS 6 TIMES
052300            INDEXED BY H-COMORBID-INDEX
052400                                    PIC X(02).
052500     05  H-COMORBID-CWF-CODE        PIC X(02).
052600
052700     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
052800
052900     05  QIP-REDUCTION              PIC 9(01)V9(03).
053000     05  SUB                        PIC 9(04).
053100
053200     05  THE-DATE                   PIC 9(08).
053300     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
053400     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
053500     05  ONSET-DATE                 PIC 9(08).
053600     05  MOVED-CORMORBIDS           PIC X(01).
053700     05  H-BUN-RURAL-MULTIPLIER     PIC 9(01)V9(03).
053800     05  H-TDAPA-PAYMENT            PIC 9(07)V9(04).
053900     05  H-PER-DIEM-AMT-WITHOUT-HDPA PIC 9(07)V9(04).
054000     05  H-PER-DIEM-AMT-WITH-HDPA   PIC 9(07)V9(04).
054100     05  H-FINAL-AMT-WITHOUT-HDPA   PIC 9(07)V9(02).
054200     05  H-FINAL-AMT-WITH-HDPA      PIC 9(07)V9(02).
054300
054400 01  HOLD-OUTLIER-PPS-COMPONENTS.
054500     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
054600     05  H-OUT-BSA                  PIC 9(03)V9(04).
054700     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
054800     05  H-OUT-BMI                  PIC 9(03)V9(04).
054900     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
055000     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
055100     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
055200     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
055300     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
055400     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
055500     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
055600     05  H-OUT-PREDICTED-SERVICES-MAP
055700                                    PIC 9(07)V9(04).
055800     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
055900     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
056000                                    PIC 9(07)V9(04).
056100     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
056200     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
056300     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
056400     05  H-OUT-RURAL-MULTIPLIER     PIC 9(01)V9(03).
056500
056600* The following variable will change from year to year and is
056700* used for the BUNDLED part of the Bundled Pricer.
056800 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 239.33.
056900
057000* The next two percentages MUST add up to 1 (i.e. 100%)
057100* They start in 2011 and will continue to change until CY2014 when
057200* BUN-CBSA-BLEND-PCT will be 1.00
057300* The third blend percent is for those providers that waived the
057400* blended percent and went to full PPS.  This variable will be
057500* eliminated in 2014 when it is no longer needed.
057600 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
057700 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
057800 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
057900
058000* CONSTANTS AREA
058100* The next two percentages MUST add up TO 1 (i.e. 100%)
058200 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.52300.
058300 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.47700.
058400 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 95.60.
058500
058600*  The following number that is loaded into the payment equation
058700*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
058800*  and   --DOES NOT CHANGE--
058900 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
059000
059100* Added a constant to hold the BSA-National-Average that is used
059200* in the BSA Calculation. This value changes every five years.
059300 01 BSA-NATIONAL-AVERAGE            PIC 9(01)V9(02) VALUE 1.90.
059400
059500 01  PEDIATRIC-MULTIPLIERS.
059600*Separately billable payment multiplier (used for outliers)
059700     05  PED-SEP-BILL-PAY-MULTI.
059800         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.410.
059900         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.406.
060000         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.569.
060100         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.494.
060200     05  PED-EXPAND-BUNDLE-PAY-MULTI.
060300*Expanded bundle payment multiplier (used for normal billing)
060400         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.063.
060500         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.306.
060600         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.102.
060700         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.327.
060800
060900 01  ADULT-MULTIPLIERS.
061000*Separately billable payment multiplier (used for outliers)
061100     05  SEP-BILLABLE-PAYMANT-MULTI.
061200         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 1.044.
061300         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 1.000.
061400         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.005.
061500         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
061600         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.961.
061700         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.000.
061800         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.090.
061900         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.409.
062000         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.209.
062100*        10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
062200         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.426.
062300         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.999.
062400         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.494.
062500*        10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
062600         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.955.
062700         10 SB-RURAL               PIC 9(01)V9(03) VALUE 0.978.
062800*Case-Mix adjusted payment multiplier (used for normal billing)
062900     05  CASE-MIX-PAYMENT-MULTI.
063000         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.257.
063100         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.068.
063200         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.070.
063300         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
063400         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.109.
063500         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.032.
063600         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.017.
063700         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.327.
063800         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.040.
063900*        10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
064000         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.082.
064100         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.192.
064200         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.095.
064300*        10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
064400         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.239.
064500         10 CM-RURAL               PIC 9(01)V9(03) VALUE 1.008.
064600
064700 01  OUTLIER-SB-CALC-AMOUNTS.
064800     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 32.32.
064900     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 35.78.
065000     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 41.04.
065100     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 48.33.
065200     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
065300     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
065400/
065500******************************************************************
065600*    This area contains return code variables and their codes.   *
065700******************************************************************
065800 01 PAID-RETURN-CODE-TRACKERS.
065900     05  OUTLIER-TRACK              PIC X(01).
066000     05  ACUTE-COMORBID-TRACK       PIC X(01).
066100     05  CHRONIC-COMORBID-TRACK     PIC X(01).
066200     05  ONSET-TRACK                PIC X(01).
066300     05  LOW-VOLUME-TRACK           PIC X(01).
066400     05  TRAINING-TRACK             PIC X(01).
066500     05  PEDIATRIC-TRACK            PIC X(01).
066600     05  LOW-BMI-TRACK              PIC X(01).
066700 COPY RTCCPY.
066800*COPY "RTCCPY.CPY".
066900*                                                                *
067000*  Legal combinations of adjustments for ADULTS are:             *
067100*     if NO ONSET applies, then they can have any combination of:*
067200*       acute OR chronic comorbid, & outlier, low vol., training.*
067300*     if ONSET applies, then they can have:                      *
067400*           outlier and/or low volume.                           *
067500*  Legal combinations of adjustments for PEDIATRIC are:          *
067600*     outlier and/or training.                                   *
067700*                                                                *
067800*  Illegal combinations of adjustments for PEDIATRIC are:        *
067900*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
068000*     onset     with comorbid or training.                       *
068100*  Illegal combinations of adjustments for ANYONE are:           *
068200*     acute comorbid AND chronic comorbid.                       *
068300/
068400 LINKAGE SECTION.
068500 COPY BILLCPY.
068600*COPY "BILLCPY.CPY".
068700/
068800 COPY WAGECPY.
068900*COPY "WAGECPY.CPY".
069000/
069100 PROCEDURE DIVISION  USING BILL-NEW-DATA
069200                           PPS-DATA-ALL
069300                           WAGE-NEW-RATE-RECORD
069400                           COM-CBSA-WAGE-RECORD
069500                           BUN-CBSA-WAGE-RECORD.
069600
069700******************************************************************
069800* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
069900* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
070000* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
070100* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
070200* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
070300* UTILIZED HERE HAS BEEN APPROVED BY THE DIVISION OF             *
070400* INSTITUTIONAL CLAIMS PROCESSING (DICP).                        *
070500*                                                                *
070600*    PROCESSING:                                                 *
070700*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
070800*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
070900*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
071000*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
071100*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
071200*           GOBACK.                                              *
071300*        D. ASSEMBLE PRICING COMPONENTS.                         *
071400*        E. CALCULATE THE PRICE.                                 *
071500******************************************************************
071600
071700 0000-START-TO-FINISH.
071800     INITIALIZE PPS-DATA-ALL.
071900
072000* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
072100     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
072200
072300
072400* ESRD PC PRICER USES NEXT FOUR LINES TO INITIALIZE VALUES
072500* THAT IT NEEDS TO DISPLAY DETAILED RESULTS
072600     IF BUNDLED-TEST THEN
072700        INITIALIZE BILL-DATA-TEST
072800        INITIALIZE COND-CD-73
072900     END-IF.
073000
073100     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
073200     MOVE ZEROS                        TO PPS-RTC.
073300
073400     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
073500
073600     IF PPS-RTC = 00  THEN
073700        PERFORM 1200-INITIALIZATION
073800        IF B-COND-CODE  = '84' THEN
073900* Calculate payment for AKI claim
074000           MOVE H-BUN-BASE-WAGE-AMT TO
074100                H-PPS-FINAL-PAY-AMT
074200           MOVE '02' TO PPS-RTC
074300           MOVE '10' TO PPS-2011-COMORBID-PAY
074400        ELSE
074500* Calculate payment for ESRD claim
074600            PERFORM 2000-CALCULATE-BUNDLED-FACTORS
074700            PERFORM 9000-SET-RETURN-CODE
074800        END-IF
074900        PERFORM 9100-MOVE-RESULTS
075000     END-IF.
075100
075200     GOBACK.
075300/
075400 1000-VALIDATE-BILL-ELEMENTS.
075500     IF PPS-RTC = 00  THEN
075600        IF B-COND-CODE NOT = '73' AND '74' AND '84' AND
075700                             '87' AND '  '
075800           MOVE 58                  TO PPS-RTC
075900        END-IF
076000     END-IF.
076100
076200     IF PPS-RTC = 00  THEN
076300        IF  P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
076400           NEXT SENTENCE
076500        ELSE
076600           MOVE 52                        TO PPS-RTC
076700        END-IF
076800     END-IF.
076900
077000     IF PPS-RTC = 00  THEN
077100        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
077200           MOVE 53                     TO PPS-RTC
077300        END-IF
077400     END-IF.
077500
077600     IF PPS-RTC = 00  THEN
077700        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
077800           MOVE 54                     TO PPS-RTC
077900        END-IF
078000     END-IF.
078100
078200     IF PPS-RTC = 00  THEN
078300        IF B-COND-CODE NOT = '84' THEN
078400           IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
078500              MOVE 55                     TO PPS-RTC
078600           END-IF
078700        END-IF
078800     END-IF.
078900
079000     IF PPS-RTC = 00  THEN
079100        IF B-COND-CODE NOT = '84' THEN
079200           IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
079300              MOVE 56                     TO PPS-RTC
079400           END-IF
079500        END-IF
079600     END-IF.
079700
079800     IF PPS-RTC = 00  THEN
079900        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
080000                                OR '0881'
080100           NEXT SENTENCE
080200        ELSE
080300           MOVE 57                     TO PPS-RTC
080400        END-IF
080500     END-IF.
080600
080700     IF PPS-RTC = 00  THEN
080800        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
080900                                 ' '  THEN
081000           MOVE 53                     TO PPS-RTC
081100*  This RTC is for the Special Payment Indicator not = '1' or
081200*  blank, which closely approximates the intent of the edit check.
081300*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
081400        END-IF
081500     END-IF.
081600
081700     IF PPS-RTC = 00  THEN
081800        IF B-COND-CODE NOT = '84' THEN
081900           IF B-PATIENT-HGT > 300.00
082000              MOVE 71                     TO PPS-RTC
082100           END-IF
082200        END-IF
082300     END-IF.
082400
082500     IF PPS-RTC = 00  THEN
082600        IF B-COND-CODE NOT = '84' THEN
082700           IF B-PATIENT-WGT > 500.00  THEN
082800              MOVE 72                     TO PPS-RTC
082900           END-IF
083000        END-IF
083100     END-IF.
083200
083300* Before 2012 pricer, put in edit check to make sure that the
083400* # of sesions does not exceed the # of days in a month.  Maybe
083500* the # of cays in a month minus one when patient goes into a
083600* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
083700* or 0851)).  If done, then will need extra RTC.
083800     IF PPS-RTC = 00  THEN
083900        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
084000           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
084100           MOVE 73                     TO PPS-RTC
084200        END-IF
084300     END-IF.
084400
084500     IF PPS-RTC = 00  THEN
084600        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
084700           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
084800           MOVE 74                     TO PPS-RTC
084900        END-IF
085000     END-IF.
085100
085200     IF PPS-RTC = 00  THEN
085300        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
085400           MOVE 75                     TO PPS-RTC
085500        END-IF
085600     END-IF.
085700
085800     IF PPS-RTC = 00  THEN
085900        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
086000           MOVE 76                     TO PPS-RTC
086100        END-IF
086200     END-IF.
086300*OLD WAY OF VALIDATING COMORBIDS
086400*    IF PPS-RTC = 00  THEN
086500*       IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
086600*           VALID-COMORBID-CWF-RETURN-CD       THEN
086700*          NEXT SENTENCE
086800*       ELSE
086900*          MOVE 81                     TO PPS-RTC
087000*      END-IF
087100*    END-IF.
087200*
087300*CY2016 - DROP PNEUMONIA & MONOCLONAL GAMM COMORBIDS
087400
087500     IF PPS-RTC = 00  THEN
087600        IF B-COND-CODE NOT = '84' THEN
087700           IF COMORBID-CWF-RETURN-CODE = SPACES OR
087800               "10" OR "20" OR "40" OR "50" OR "60" THEN
087900              NEXT SENTENCE
088000           ELSE
088100              MOVE 81                     TO PPS-RTC
088200           END-IF
088300        END-IF
088400     END-IF.
088500/
088600 1200-INITIALIZATION.
088700     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
088800     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
088900     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
089000     INITIALIZE PAID-RETURN-CODE-TRACKERS.
089100
089200
089300******************************************************************
089400***Calculate BUNDLED Wage Adjusted Rate                        ***
089500******************************************************************
089600     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
089700        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
089800         BUN-CBSA-W-INDEX.
089900
090000     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
090100        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
090200
090300     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
090400        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
090500/
090600 2000-CALCULATE-BUNDLED-FACTORS.
090700
090800     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
090900     IF B-DOB-MM > B-THRU-MM  THEN
091000        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
091100     END-IF
091200     IF H-PATIENT-AGE < 18  THEN
091300        MOVE "Y"                    TO PEDIATRIC-TRACK
091400     END-IF.
091500
091600     MOVE SPACES                       TO MOVED-CORMORBIDS.
091700
091800     IF P-QIP-REDUCTION = ' '  THEN
091900* no reduction
092000        MOVE 1.000 TO QIP-REDUCTION
092100     ELSE
092200        IF P-QIP-REDUCTION = '1'  THEN
092300* one-half percent reduction
092400           MOVE 0.995 TO QIP-REDUCTION
092500        ELSE
092600           IF P-QIP-REDUCTION = '2'  THEN
092700* one percent reduction
092800              MOVE 0.990 TO QIP-REDUCTION
092900           ELSE
093000              IF P-QIP-REDUCTION = '3'  THEN
093100* one and one-half percent reduction
093200                 MOVE 0.985 TO QIP-REDUCTION
093300              ELSE
093400* two percent reduction
093500                 MOVE 0.980 TO QIP-REDUCTION
093600              END-IF
093700           END-IF
093800        END-IF
093900     END-IF.
094000
094100*    Since pricer has to pay a comorbid condition according to the
094200* return code that CWF passes back, it is cleaner if the pricer
094300* sets aside whatever comorbid data exists on the line-item when
094400* it comes into the pricer and then transferrs the CWF code to
094500* the appropriate place in the comorbid data.  This avoids
094600* making convoluted changes in the other parts of the program
094700* which has to look at both original comorbid data AND CWF return
094800* codes to handle comorbids.  Near the end of the program where
094900* variables are transferred to the output, the original comorbid
095000* data is put back into its original place as though nothing
095100* occurred.
095200*CY2016 DROPPED MB & MF
095300     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
095400        NEXT SENTENCE
095500     ELSE
095600        MOVE 'Y'                       TO MOVED-CORMORBIDS
095700        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
095800        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
095900        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
096000        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
096100        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
096200        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
096300        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
096400        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
096500           MOVE SPACES                 TO COMORBID-DATA (1)
096600                                          COMORBID-DATA (2)
096700                                          COMORBID-DATA (3)
096800                                          COMORBID-DATA (4)
096900                                          COMORBID-DATA (5)
097000                                          COMORBID-DATA (6)
097100                                          COMORBID-CWF-RETURN-CODE
097200        ELSE
097300           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
097400              MOVE 'MA'                TO COMORBID-DATA (1)
097500              MOVE SPACES              TO COMORBID-DATA (2)
097600                                          COMORBID-DATA (3)
097700                                          COMORBID-DATA (4)
097800                                          COMORBID-DATA (5)
097900                                          COMORBID-DATA (6)
098000                                          COMORBID-CWF-RETURN-CODE
098100           ELSE
098200*             IF COMORBID-CWF-RETURN-CODE = '30'  THEN
098300*                MOVE SPACES           TO COMORBID-DATA (1)
098400*                MOVE 'MB'             TO COMORBID-DATA (2)
098500*                MOVE SPACES           TO COMORBID-DATA (3)
098600*                MOVE SPACES           TO COMORBID-DATA (4)
098700*                MOVE SPACES           TO COMORBID-DATA (5)
098800*                MOVE SPACES           TO COMORBID-DATA (6)
098900*                                         COMORBID-CWF-RETURN-CODE
099000*             ELSE
099100                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
099200                    MOVE SPACES        TO COMORBID-DATA (1)
099300                    MOVE SPACES        TO COMORBID-DATA (2)
099400                    MOVE 'MC'          TO COMORBID-DATA (3)
099500                    MOVE SPACES        TO COMORBID-DATA (4)
099600                    MOVE SPACES        TO COMORBID-DATA (5)
099700                    MOVE SPACES        TO COMORBID-DATA (6)
099800                                          COMORBID-CWF-RETURN-CODE
099900                 ELSE
100000                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
100100                       MOVE SPACES     TO COMORBID-DATA (1)
100200                       MOVE SPACES     TO COMORBID-DATA (2)
100300                       MOVE SPACES     TO COMORBID-DATA (3)
100400                       MOVE 'MD'       TO COMORBID-DATA (4)
100500                       MOVE SPACES     TO COMORBID-DATA (5)
100600                       MOVE SPACES     TO COMORBID-DATA (6)
100700                                          COMORBID-CWF-RETURN-CODE
100800                    ELSE
100900                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
101000                          MOVE SPACES  TO COMORBID-DATA (1)
101100                          MOVE SPACES  TO COMORBID-DATA (2)
101200                          MOVE SPACES  TO COMORBID-DATA (3)
101300                          MOVE SPACES  TO COMORBID-DATA (4)
101400                          MOVE 'ME'    TO COMORBID-DATA (5)
101500                          MOVE SPACES  TO COMORBID-DATA (6)
101600                                          COMORBID-CWF-RETURN-CODE
101700*                      ELSE
101800*                         MOVE SPACES  TO COMORBID-DATA (1)
101900*                                         COMORBID-DATA (2)
102000*                                         COMORBID-DATA (3)
102100*                                         COMORBID-DATA (4)
102200*                                         COMORBID-DATA (5)
102300*                                         COMORBID-CWF-RETURN-CODE
102400*                         MOVE 'MF'    TO COMORBID-DATA (6)
102500                       END-IF
102600                    END-IF
102700                 END-IF
102800*             END-IF
102900           END-IF
103000        END-IF
103100     END-IF.
103200******************************************************************
103300***  Set BUNDLED age adjustment factor                         ***
103400******************************************************************
103500     IF H-PATIENT-AGE < 13  THEN
103600        IF B-REV-CODE = '0821' OR '0881' THEN
103700           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
103800        ELSE
103900           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
104000        END-IF
104100     ELSE
104200        IF H-PATIENT-AGE < 18 THEN
104300           IF B-REV-CODE = '0821' OR '0881' THEN
104400              MOVE EB-AGE-13-17-HEMO-MODE
104500                                       TO H-BUN-AGE-FACTOR
104600           ELSE
104700              MOVE EB-AGE-13-17-PD-MODE
104800                                       TO H-BUN-AGE-FACTOR
104900           END-IF
105000        ELSE
105100           IF H-PATIENT-AGE < 45  THEN
105200              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
105300           ELSE
105400              IF H-PATIENT-AGE < 60  THEN
105500                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
105600              ELSE
105700                 IF H-PATIENT-AGE < 70  THEN
105800                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
105900                 ELSE
106000                    IF H-PATIENT-AGE < 80  THEN
106100                       MOVE CM-AGE-70-79
106200                                       TO H-BUN-AGE-FACTOR
106300                    ELSE
106400                       MOVE CM-AGE-80-PLUS
106500                                       TO H-BUN-AGE-FACTOR
106600                    END-IF
106700                 END-IF
106800              END-IF
106900           END-IF
107000        END-IF
107100     END-IF.
107200
107300******************************************************************
107400***  Calculate BUNDLED BSA factor (note NEW formula)           ***
107500******************************************************************
107600     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
107700         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
107800
107900     IF H-PATIENT-AGE > 17  THEN
108000        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
108100*            CM-BSA ** ((H-BUN-BSA - 1.90) / .1)
108200             CM-BSA ** ((H-BUN-BSA - BSA-NATIONAL-AVERAGE) / .1)
108300     ELSE
108400        MOVE 1.000                     TO H-BUN-BSA-FACTOR
108500     END-IF.
108600
108700******************************************************************
108800***  Calculate BUNDLED BMI factor                              ***
108900******************************************************************
109000     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
109100         (B-PATIENT-HGT ** 2)) * 10000.
109200
109300     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
109400        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
109500        MOVE "Y"                       TO LOW-BMI-TRACK
109600     ELSE
109700        MOVE 1.000                     TO H-BUN-BMI-FACTOR
109800     END-IF.
109900
110000******************************************************************
110100***  Calculate BUNDLED ONSET factor                            ***
110200******************************************************************
110300     IF B-DIALYSIS-START-DATE > ZERO  THEN
110400        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
110500        COMPUTE INTEGER-LINE-ITEM-DATE =
110600            FUNCTION INTEGER-OF-DATE(THE-DATE)
110700        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
110800        COMPUTE INTEGER-DIALYSIS-DATE  =
110900            FUNCTION INTEGER-OF-DATE(THE-DATE)
111000* Need to add one to onset-date because the start date should
111100* be included in the count of days.  fix made 9/6/2011
111200        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
111300                              INTEGER-DIALYSIS-DATE) + 1
111400        IF H-PATIENT-AGE > 17  THEN
111500           IF ONSET-DATE > 120  THEN
111600              MOVE 1                   TO H-BUN-ONSET-FACTOR
111700           ELSE
111800              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
111900              MOVE "Y"                 TO ONSET-TRACK
112000           END-IF
112100        ELSE
112200           MOVE 1                      TO H-BUN-ONSET-FACTOR
112300        END-IF
112400     ELSE
112500        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
112600     END-IF.
112700
112800******************************************************************
112900***  Set BUNDLED Co-morbidities adjustment                     ***
113000******************************************************************
113100     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
113200        IF H-PATIENT-AGE  <  18  THEN
113300           MOVE 1.000                  TO
113400                                       H-BUN-COMORBID-MULTIPLIER
113500           MOVE '10'                   TO PPS-2011-COMORBID-PAY
113600        ELSE
113700           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
113800              MOVE 1.000               TO
113900                                       H-BUN-COMORBID-MULTIPLIER
114000              MOVE '10'                TO PPS-2011-COMORBID-PAY
114100           ELSE
114200              PERFORM 2100-CALC-COMORBID-ADJUST
114300              MOVE H-COMORBID-MULTIPLIER TO
114400                                       H-BUN-COMORBID-MULTIPLIER
114500           END-IF
114600        END-IF
114700     ELSE
114800        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
114900           MOVE 1.000                  TO
115000                                       H-BUN-COMORBID-MULTIPLIER
115100           MOVE '10'                   TO PPS-2011-COMORBID-PAY
115200        ELSE
115300           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
115400              MOVE CM-GI-BLEED         TO
115500                                       H-BUN-COMORBID-MULTIPLIER
115600              MOVE '20'                TO PPS-2011-COMORBID-PAY
115700           ELSE
115800*            IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
115900*                MOVE CM-PNEUMONIA     TO
116000*                                      H-BUN-COMORBID-MULTIPLIER
116100*                MOVE '30'             TO PPS-2011-COMORBID-PAY
116200*            ELSE
116300                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
116400                    MOVE CM-PERICARDITIS TO
116500                                       H-BUN-COMORBID-MULTIPLIER
116600                    MOVE '40'          TO PPS-2011-COMORBID-PAY
116700                 END-IF
116800*            END-IF
116900           END-IF
117000        END-IF
117100     END-IF.
117200
117300******************************************************************
117400***  Calculate BUNDLED Low Volume adjustment                   ***
117500******************************************************************
117600     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
117700        IF H-PATIENT-AGE > 17  THEN
117800           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
117900                                       H-BUN-LOW-VOL-MULTIPLIER
118000           MOVE "Y"                    TO  LOW-VOLUME-TRACK
118100        ELSE
118200           MOVE 1.000                  TO
118300                                       H-BUN-LOW-VOL-MULTIPLIER
118400        END-IF
118500     ELSE
118600        MOVE 1.000                     TO
118700                                       H-BUN-LOW-VOL-MULTIPLIER
118800     END-IF.
118900
119000***************************************************************
119100* Calculate Rural Adjustment Multiplier ADDED CY 2016
119200***************************************************************
119300     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
119400        MOVE CM-RURAL TO H-BUN-RURAL-MULTIPLIER
119500     ELSE
119600        MOVE 1.000 TO H-BUN-RURAL-MULTIPLIER.
119700
119800******************************************************************
119900***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
120000******************************************************************
120100     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
120200        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
120300        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
120400        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
120500        H-BUN-LOW-VOL-MULTIPLIER * H-BUN-RURAL-MULTIPLIER.
120600
120700******************************************************************
120800***  Calculate BUNDLED Condition Code payment                  ***
120900******************************************************************
121000* Self-care in Training add-on
121100     IF B-COND-CODE = '73' OR '87' THEN
121200* no add-on when onset is present
121300        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
121400           MOVE ZERO TO H-BUN-WAGE-ADJ-TRAINING-AMT
121500        ELSE
121600* use new PPS training add-on amount times wage-index
121700           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT ROUNDED  =
121800             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
121900           MOVE "Y" TO TRAINING-TRACK
122000        END-IF
122100     ELSE
122200* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
122300        IF (B-COND-CODE = '74')  AND
122400           (B-REV-CODE = '0841' OR '0851')  THEN
122500*             COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
122600*                (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
122700* ESCAL201 for ETC HDPA Bonus - changed code to calculate payment
122800* of both With and Without Bonus at the same time
122900              COMPUTE H-PER-DIEM-AMT-WITHOUT-HDPA ROUNDED =
123000                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
123100              COMPUTE H-PER-DIEM-AMT-WITH-HDPA ROUNDED =
123200                 ((H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7) *
123300                         ETC-HDPA-PCT
123400        ELSE
123500           MOVE ZERO                   TO
123600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
123700*                                   H-CC-74-PER-DIEM-AMT
123800                                    H-PER-DIEM-AMT-WITHOUT-HDPA
123900                                    H-PER-DIEM-AMT-WITH-HDPA
124000        END-IF
124100     END-IF.
124200
124300******************************************************************
124400***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
124500******************************************************************
124600     IF (B-COND-CODE = '74')  AND
124700        (B-REV-CODE = '0841' OR '0851')  THEN
124800*                          H-CC-74-PER-DIEM-AMT
124900           COMPUTE H-FINAL-AMT-WITHOUT-HDPA ROUNDED  =
125000                                    H-PER-DIEM-AMT-WITHOUT-HDPA
125100           COMPUTE H-FINAL-AMT-WITH-HDPA ROUNDED  =
125200                                    H-PER-DIEM-AMT-WITH-HDPA
125300
125400           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
125500              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
125600              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
125700*    ELSE COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
125800*                 H-BUN-ADJUSTED-BASE-WAGE-AMT  +
125900*                 H-BUN-WAGE-ADJ-TRAINING-AMT
126000     ELSE COMPUTE H-FINAL-AMT-WITHOUT-HDPA ROUNDED  =
126100                  H-BUN-ADJUSTED-BASE-WAGE-AMT  +
126200                  H-BUN-WAGE-ADJ-TRAINING-AMT
126300          COMPUTE H-FINAL-AMT-WITH-HDPA ROUNDED  =
126400                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * ETC-HDPA-PCT) +
126500                  H-BUN-WAGE-ADJ-TRAINING-AMT
126600     END-IF.
126700
126800****************************************************************
126900***  Include TDAPA Payment                                   ***
127000****************************************************************
127100     COMPUTE H-TDAPA-PAYMENT = B-PAYER-ONLY-VC-Q8 /
127200                               B-CLAIM-NUM-DIALYSIS-SESSIONS.
127300*    COMPUTE H-PPS-FINAL-PAY-AMT = H-PPS-FINAL-PAY-AMT +
127400*                                  H-TDAPA-PAYMENT.
127500     COMPUTE H-FINAL-AMT-WITHOUT-HDPA = H-FINAL-AMT-WITHOUT-HDPA +
127600                                        H-TDAPA-PAYMENT.
127700     COMPUTE H-FINAL-AMT-WITH-HDPA = H-FINAL-AMT-WITH-HDPA +
127800                                     H-TDAPA-PAYMENT.
127900
128000     IF B-DATA-CODE = '94'
128100     THEN MOVE H-FINAL-AMT-WITH-HDPA TO H-PPS-FINAL-PAY-AMT
128200     ELSE MOVE H-FINAL-AMT-WITHOUT-HDPA TO H-PPS-FINAL-PAY-AMT
128300     END-IF.
128400
128500
128600******************************************************************
128700***  Calculate BUNDLED Outlier                                 ***
128800******************************************************************
128900     PERFORM 2500-CALC-OUTLIER-FACTORS.
129000
129100******************************************************************
129200***  Calculate Low Volume payment for recovery purposes        ***
129300******************************************************************
129400     IF LOW-VOLUME-TRACK = "Y"  THEN
129500        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
129600        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
129700
129800        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
129900           H-PPS-FINAL-PAY-AMT
130000
130100        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
130200           H-OUT-PAYMENT
130300
130400        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
130500           H-LV-OUT-PAYMENT
130600
130700        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
130800           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
130900              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
131000        ELSE
131100           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
131200        END-IF
131300     END-IF.
131400
131500
131600/
131700 2100-CALC-COMORBID-ADJUST.
131800******************************************************************
131900***  Calculate Co-morbidities adjustment                       ***
132000******************************************************************
132100*  This logic assumes that the comorbids are randomly assigned   *
132200*to the comorbid table.  It will select the highest comorbid for *
132300*payment if one is found.  CY 2016 DROPPED MB & MF              *
132400******************************************************************
132500     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
132600     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
132700     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
132800
132900     PERFORM VARYING  SUB  FROM  1 BY 1
133000       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
133100         IF COMORBID-DATA (SUB) = 'MA'  THEN
133200           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
133300*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
133400           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
133500           MOVE '20'                   TO PPS-2011-COMORBID-PAY
133600         ELSE
133700*          IF COMORBID-DATA (SUB) = 'MB'  THEN
133800*            IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
133900*              MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
134000*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
134100*              MOVE '30'               TO PPS-2011-COMORBID-PAY
134200*            END-IF
134300*          ELSE
134400             IF COMORBID-DATA (SUB) = 'MC'  THEN
134500                IF CM-PERICARDITIS  >
134600                                      H-COMORBID-MULTIPLIER  THEN
134700                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
134800                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
134900                  MOVE '40'            TO PPS-2011-COMORBID-PAY
135000                END-IF
135100             ELSE
135200               IF COMORBID-DATA (SUB) = 'MD'  THEN
135300                 IF CM-MYELODYSPLASTIC  >
135400                                      H-COMORBID-MULTIPLIER  THEN
135500                   MOVE CM-MYELODYSPLASTIC  TO
135600                                      H-COMORBID-MULTIPLIER
135700                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
135800                   MOVE '50'           TO PPS-2011-COMORBID-PAY
135900                 END-IF
136000               ELSE
136100                 IF COMORBID-DATA (SUB) = 'ME'  THEN
136200                   IF CM-SICKEL-CELL  >
136300                                      H-COMORBID-MULTIPLIER  THEN
136400                     MOVE CM-SICKEL-CELL  TO
136500                                      H-COMORBID-MULTIPLIER
136600                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
136700                     MOVE '60'         TO PPS-2011-COMORBID-PAY
136800                   END-IF
136900*                ELSE
137000*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
137100*                    IF CM-MONOCLONAL-GAMM  >
137200*                                     H-COMORBID-MULTIPLIER  THEN
137300*                      MOVE CM-MONOCLONAL-GAMM TO
137400*                                     H-COMORBID-MULTIPLIER
137500*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
137600*                      MOVE '70'       TO PPS-2011-COMORBID-PAY
137700*                    END-IF
137800*                  END-IF
137900                 END-IF
138000               END-IF
138100             END-IF
138200*          END-IF
138300         END-IF
138400     END-PERFORM.
138500/
138600 2500-CALC-OUTLIER-FACTORS.
138700******************************************************************
138800***  Set separately billable OUTLIER age adjustment factor     ***
138900******************************************************************
139000     IF H-PATIENT-AGE < 13  THEN
139100        IF B-REV-CODE = '0821' OR '0881' THEN
139200           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
139300        ELSE
139400           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
139500        END-IF
139600     ELSE
139700        IF H-PATIENT-AGE < 18 THEN
139800           IF B-REV-CODE = '0821' OR '0881'  THEN
139900              MOVE SB-AGE-13-17-HEMO-MODE
140000                                       TO H-OUT-AGE-FACTOR
140100           ELSE
140200              MOVE SB-AGE-13-17-PD-MODE
140300                                       TO H-OUT-AGE-FACTOR
140400           END-IF
140500        ELSE
140600           IF H-PATIENT-AGE < 45  THEN
140700              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
140800           ELSE
140900              IF H-PATIENT-AGE < 60  THEN
141000                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
141100              ELSE
141200                 IF H-PATIENT-AGE < 70  THEN
141300                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
141400                 ELSE
141500                    IF H-PATIENT-AGE < 80  THEN
141600                       MOVE SB-AGE-70-79
141700                                       TO H-OUT-AGE-FACTOR
141800                    ELSE
141900                       MOVE SB-AGE-80-PLUS
142000                                       TO H-OUT-AGE-FACTOR
142100                    END-IF
142200                 END-IF
142300              END-IF
142400           END-IF
142500        END-IF
142600     END-IF.
142700
142800******************************************************************
142900**Calculate separately billable OUTLIER BSA factor (superscript)**
143000******************************************************************
143100     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
143200         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
143300
143400     IF H-PATIENT-AGE > 17  THEN
143500        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
143600*            SB-BSA ** ((H-OUT-BSA - 1.90) / .1)
143700             SB-BSA ** ((H-OUT-BSA - BSA-NATIONAL-AVERAGE) / .1)
143800     ELSE
143900        MOVE 1.000                     TO H-OUT-BSA-FACTOR
144000     END-IF.
144100
144200******************************************************************
144300***  Calculate separately billable OUTLIER BMI factor          ***
144400******************************************************************
144500     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
144600         (B-PATIENT-HGT ** 2)) * 10000.
144700
144800     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
144900        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
145000     ELSE
145100        MOVE 1.000                     TO H-OUT-BMI-FACTOR
145200     END-IF.
145300
145400******************************************************************
145500***  Calculate separately billable OUTLIER ONSET factor        ***
145600******************************************************************
145700     IF B-DIALYSIS-START-DATE > ZERO  THEN
145800        IF H-PATIENT-AGE > 17  THEN
145900           IF ONSET-DATE > 120  THEN
146000              MOVE 1                   TO H-OUT-ONSET-FACTOR
146100           ELSE
146200              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
146300           END-IF
146400        ELSE
146500           MOVE 1                      TO H-OUT-ONSET-FACTOR
146600        END-IF
146700     ELSE
146800        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
146900     END-IF.
147000
147100******************************************************************
147200***  Set separately billable OUTLIER Co-morbidities adjustment ***
147300* CY 2016 DROPPED MB & MF
147400******************************************************************
147500     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
147600        IF H-PATIENT-AGE  <  18  THEN
147700           MOVE 1.000                  TO
147800                                       H-OUT-COMORBID-MULTIPLIER
147900           MOVE '10'                   TO PPS-2011-COMORBID-PAY
148000        ELSE
148100           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
148200              MOVE 1.000               TO
148300                                       H-OUT-COMORBID-MULTIPLIER
148400              MOVE '10'                TO PPS-2011-COMORBID-PAY
148500           ELSE
148600              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
148700           END-IF
148800        END-IF
148900     ELSE
149000        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
149100           MOVE 1.000                  TO
149200                                       H-OUT-COMORBID-MULTIPLIER
149300        ELSE
149400           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
149500              MOVE SB-GI-BLEED         TO
149600                                       H-OUT-COMORBID-MULTIPLIER
149700           ELSE
149800*             IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
149900*                MOVE SB-PNEUMONIA     TO
150000*                                      H-OUT-COMORBID-MULTIPLIER
150100*             ELSE
150200                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
150300                    MOVE SB-PERICARDITIS TO
150400                                       H-OUT-COMORBID-MULTIPLIER
150500                 END-IF
150600*             END-IF
150700           END-IF
150800        END-IF
150900     END-IF.
151000
151100******************************************************************
151200***  Set OUTLIER low-volume-multiplier                         ***
151300******************************************************************
151400     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
151500        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
151600     ELSE
151700        IF H-PATIENT-AGE < 18  THEN
151800           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
151900        ELSE
152000           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
152100           MOVE "Y"                    TO LOW-VOLUME-TRACK
152200        END-IF
152300     END-IF.
152400
152500***************************************************************
152600* Calculate OUTLIER Rural Adjustment multiplier
152700***************************************************************
152800
152900     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
153000        MOVE SB-RURAL TO H-OUT-RURAL-MULTIPLIER
153100     ELSE
153200        MOVE 1.000 TO H-OUT-RURAL-MULTIPLIER.
153300
153400******************************************************************
153500***  Calculate predicted OUTLIER services MAP per treatment    ***
153600******************************************************************
153700     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
153800        (H-OUT-AGE-FACTOR             *
153900         H-OUT-BSA-FACTOR             *
154000         H-OUT-BMI-FACTOR             *
154100         H-OUT-ONSET-FACTOR           *
154200         H-OUT-COMORBID-MULTIPLIER    *
154300         H-OUT-RURAL-MULTIPLIER       *
154400         H-OUT-LOW-VOL-MULTIPLIER).
154500
154600******************************************************************
154700***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
154800******************************************************************
154900     IF H-PATIENT-AGE < 18  THEN
155000        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
155100           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
155200        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
155300     ELSE
155400
155500        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
155600           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
155700        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
155800     END-IF.
155900
156000******************************************************************
156100*** Calculate imputed OUTLIER services MAP amount per treatment***
156200******************************************************************
156300     IF (B-COND-CODE = '74')  AND
156400        (B-REV-CODE = '0841' OR '0851')  THEN
156500         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
156600            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
156700         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
156800         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
156900     ELSE
157000        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
157100        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
157200     END-IF.
157300
157400******************************************************************
157500*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
157600******************************************************************
157700     IF H-PATIENT-AGE < 18   THEN
157800        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
157900           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
158000        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
158100        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
158200           COMPUTE H-OUT-PAYMENT  ROUNDED  =
158300            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
158400                                         LOSS-SHARING-PCT-LT-18
158500           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
158600           MOVE "Y"                    TO OUTLIER-TRACK
158700        ELSE
158800           MOVE ZERO                   TO H-OUT-PAYMENT
158900           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
159000        END-IF
159100     ELSE
159200        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
159300           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
159400           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
159500        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
159600           COMPUTE H-OUT-PAYMENT  ROUNDED  =
159700            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
159800                                         LOSS-SHARING-PCT-GT-17
159900           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
160000           MOVE "Y"                    TO OUTLIER-TRACK
160100        ELSE
160200           MOVE ZERO                   TO H-OUT-PAYMENT
160300        END-IF
160400     END-IF.
160500
160600     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
160700
160800* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
160900     IF (B-COND-CODE = '74')  AND
161000        (B-REV-CODE = '0841' OR '0851')  THEN
161100           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
161200             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
161300     END-IF.
161400/
161500 2600-CALC-COMORBID-OUT-ADJUST.
161600******************************************************************
161700***  Calculate OUTLIER Co-morbidities adjustment               ***
161800******************************************************************
161900*  This logic assumes that the comorbids are randomly assigned   *
162000*to the comorbid table.  It will select the highest comorbid for *
162100*payment if one is found. CY 2016 DROPPED MB & MF                *
162200******************************************************************
162300
162400     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
162500     MOVE 1.000                        TO
162600                                  H-OUT-COMORBID-MULTIPLIER.
162700
162800     PERFORM VARYING  SUB  FROM  1 BY 1
162900       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
163000         IF COMORBID-DATA (SUB) = 'MA'  THEN
163100           MOVE SB-GI-BLEED            TO
163200                                  H-OUT-COMORBID-MULTIPLIER
163300*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
163400           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
163500         ELSE
163600*          IF COMORBID-DATA (SUB) = 'MB'  THEN
163700*            IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
163800*              MOVE SB-PNEUMONIA       TO
163900*                                 H-OUT-COMORBID-MULTIPLIER
164000*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
164100*            END-IF
164200*          ELSE
164300             IF COMORBID-DATA (SUB) = 'MC'  THEN
164400                IF SB-PERICARDITIS  >
164500                                  H-OUT-COMORBID-MULTIPLIER  THEN
164600                  MOVE SB-PERICARDITIS TO
164700                                  H-OUT-COMORBID-MULTIPLIER
164800                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
164900                END-IF
165000             ELSE
165100               IF COMORBID-DATA (SUB) = 'MD'  THEN
165200                 IF SB-MYELODYSPLASTIC  >
165300                                  H-OUT-COMORBID-MULTIPLIER  THEN
165400                   MOVE SB-MYELODYSPLASTIC  TO
165500                                  H-OUT-COMORBID-MULTIPLIER
165600                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
165700                 END-IF
165800               ELSE
165900                 IF COMORBID-DATA (SUB) = 'ME'  THEN
166000                   IF SB-SICKEL-CELL  >
166100                                 H-OUT-COMORBID-MULTIPLIER  THEN
166200                     MOVE SB-SICKEL-CELL  TO
166300                                  H-OUT-COMORBID-MULTIPLIER
166400                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
166500                   END-IF
166600*                ELSE
166700*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
166800*                    IF SB-MONOCLONAL-GAMM  >
166900*                                 H-OUT-COMORBID-MULTIPLIER  THEN
167000*                      MOVE SB-MONOCLONAL-GAMM  TO
167100*                                 H-OUT-COMORBID-MULTIPLIER
167200*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
167300*                    END-IF
167400*                  END-IF
167500                 END-IF
167600               END-IF
167700             END-IF
167800*          END-IF
167900         END-IF
168000     END-PERFORM.
168100/
168200******************************************************************
168300*** Calculate Low Volume Full PPS payment for recovery purposes***
168400******************************************************************
168500 3000-LOW-VOL-FULL-PPS-PAYMENT.
168600******************************************************************
168700** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
168800     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
168900        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
169000        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
169100        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
169200         H-BUN-RURAL-MULTIPLIER.
169300
169400******************************************************************
169500**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
169600* Self-care in Training add-on
169700     IF B-COND-CODE = '73' OR '87' THEN
169800* no add-on when onset is present
169900        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
170000           MOVE ZERO                   TO
170100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
170200        ELSE
170300* use new PPS training add-on amount times wage-index
170400           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
170500             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
170600           MOVE "Y"                    TO TRAINING-TRACK
170700        END-IF
170800     ELSE
170900* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
171000        IF (B-COND-CODE = '74')  AND
171100           (B-REV-CODE = '0841' OR '0851')  THEN
171200              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
171300                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
171400        ELSE
171500           MOVE ZERO                   TO
171600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
171700                                    H-CC-74-PER-DIEM-AMT
171800        END-IF
171900     END-IF.
172000
172100******************************************************************
172200**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
172300     IF (B-COND-CODE = '74')  AND
172400        (B-REV-CODE = '0841' OR '0851')  THEN
172500           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
172600                           H-CC-74-PER-DIEM-AMT
172700     ELSE
172800        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
172900                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
173000                H-BUN-WAGE-ADJ-TRAINING-AMT
173100     END-IF.
173200
173300
173400******************************************************************
173500*** Calculate Low Volume OUT PPS payment for recovery purposes ***
173600******************************************************************
173700 3100-LOW-VOL-OUT-PPS-PAYMENT.
173800******************************************************************
173900**Modified code from 'Calc predict OUT serv MAP per treat' para.**
174000     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
174100        (H-OUT-AGE-FACTOR             *
174200         H-OUT-BSA-FACTOR             *
174300         H-OUT-BMI-FACTOR             *
174400         H-OUT-ONSET-FACTOR           *
174500         H-OUT-COMORBID-MULTIPLIER    *
174600         H-OUT-RURAL-MULTIPLIER).
174700
174800******************************************************************
174900**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
175000     IF H-PATIENT-AGE < 18  THEN
175100        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
175200           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
175300        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
175400     ELSE
175500        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
175600           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
175700        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
175800     END-IF.
175900
176000******************************************************************
176100** 'Calculate imput OUT services MAP amount per treatment' para **
176200** It is not necessary to modify or insert this paragraph here. **
176300
176400******************************************************************
176500**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
176600     IF H-PATIENT-AGE < 18   THEN
176700        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
176800           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
176900        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
177000        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
177100           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
177200            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
177300                                         LOSS-SHARING-PCT-LT-18
177400           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
177500        ELSE
177600           MOVE ZERO                   TO H-LV-OUT-PAYMENT
177700           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
177800        END-IF
177900     ELSE
178000        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
178100           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
178200           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
178300        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
178400           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
178500            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
178600                                         LOSS-SHARING-PCT-GT-17
178700           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
178800        ELSE
178900           MOVE ZERO                   TO H-LV-OUT-PAYMENT
179000        END-IF
179100     END-IF.
179200
179300     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
179400
179500* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
179600     IF (B-COND-CODE = '74')  AND
179700        (B-REV-CODE = '0841' OR '0851')  THEN
179800           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
179900             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
180000     END-IF.
180100
180200
180300/
180400 9000-SET-RETURN-CODE.
180500******************************************************************
180600***  Set the return code                                       ***
180700******************************************************************
180800*   The following 'table' helps in understanding and in making   *
180900*changes to the rather large and complex "IF" statement that     *
181000*follows.  This 'table' just reorders and rewords the comments   *
181100*contained in the working storage area concerning the paid       *
181200*return-codes.                                                   *
181300*                                                                *
181400*  17 = pediatric, outlier, training                             *
181500*  16 = pediatric, outlier                                       *
181600*  15 = pediatric, training                                      *
181700*  14 = pediatric                                                *
181800*                                                                *
181900*  24 = outlier, low volume, training, chronic comorbid          *
182000*  19 = outlier, low volume, training, acute comorbid            *
182100*  29 = outlier, low volume, training                            *
182200*  23 = outlier, low volume, chronic comorbid                    *
182300*  18 = outlier, low volume, acute comorbid                      *
182400*  30 = outlier, low volume, onset                               *
182500*  28 = outlier, low volume                                      *
182600*  34 = outlier, training, chronic comorbid                      *
182700*  35 = outlier, training, acute comorbid                        *
182800*  33 = outlier, training                                        *
182900*  07 = outlier, chronic comorbid                                *
183000*  06 = outlier, acute comorbid                                  *
183100*  09 = outlier, onset                                           *
183200*  03 = outlier                                                  *
183300*                                                                *
183400*  26 = low volume, training, chronic comorbid                   *
183500*  21 = low volume, training, acute comorbid                     *
183600*  12 = low volume, training                                     *
183700*  25 = low volume, chronic comorbid                             *
183800*  20 = low volume, acute comorbid                               *
183900*  32 = low volume, onset                                        *
184000*  10 = low volume                                               *
184100*                                                                *
184200*  27 = training, chronic comorbid                               *
184300*  22 = training, acute comorbid                                 *
184400*  11 = training                                                 *
184500*                                                                *
184600*  08 = onset                                                    *
184700*  04 = acute comorbid                                           *
184800*  05 = chronic comorbid                                         *
184900*  31 = low BMI                                                  *
185000*  02 = no adjustments                                           *
185100*                                                                *
185200*  13 = w/multiple adjustments....reserved for future use        *
185300******************************************************************
185400/
185500     IF PEDIATRIC-TRACK                       = "Y"  THEN
185600        IF OUTLIER-TRACK                      = "Y"  THEN
185700           IF TRAINING-TRACK                  = "Y"  THEN
185800              MOVE 17                  TO PPS-RTC
185900           ELSE
186000              MOVE 16                  TO PPS-RTC
186100           END-IF
186200        ELSE
186300           IF TRAINING-TRACK                  = "Y"  THEN
186400              MOVE 15                  TO PPS-RTC
186500           ELSE
186600              MOVE 14                  TO PPS-RTC
186700           END-IF
186800        END-IF
186900     ELSE
187000        IF OUTLIER-TRACK                      = "Y"  THEN
187100           IF LOW-VOLUME-TRACK                = "Y"  THEN
187200              IF TRAINING-TRACK               = "Y"  THEN
187300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
187400                    MOVE 24            TO PPS-RTC
187500                 ELSE
187600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
187700                       MOVE 19         TO PPS-RTC
187800                    ELSE
187900                       MOVE 29         TO PPS-RTC
188000                    END-IF
188100                 END-IF
188200              ELSE
188300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
188400                    MOVE 23            TO PPS-RTC
188500                 ELSE
188600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
188700                       MOVE 18         TO PPS-RTC
188800                    ELSE
188900                       IF ONSET-TRACK         = "Y"  THEN
189000                          MOVE 30      TO PPS-RTC
189100                       ELSE
189200                          MOVE 28      TO PPS-RTC
189300                       END-IF
189400                    END-IF
189500                 END-IF
189600              END-IF
189700           ELSE
189800              IF TRAINING-TRACK               = "Y"  THEN
189900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
190000                    MOVE 34            TO PPS-RTC
190100                 ELSE
190200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
190300                       MOVE 35         TO PPS-RTC
190400                    ELSE
190500                       MOVE 33         TO PPS-RTC
190600                    END-IF
190700                 END-IF
190800              ELSE
190900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
191000                    MOVE 07            TO PPS-RTC
191100                 ELSE
191200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
191300                       MOVE 06         TO PPS-RTC
191400                    ELSE
191500                       IF ONSET-TRACK         = "Y"  THEN
191600                          MOVE 09      TO PPS-RTC
191700                       ELSE
191800                          MOVE 03      TO PPS-RTC
191900                       END-IF
192000                    END-IF
192100                 END-IF
192200              END-IF
192300           END-IF
192400        ELSE
192500           IF LOW-VOLUME-TRACK                = "Y"
192600              IF TRAINING-TRACK               = "Y"  THEN
192700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
192800                    MOVE 26            TO PPS-RTC
192900                 ELSE
193000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
193100                       MOVE 21         TO PPS-RTC
193200                    ELSE
193300                       MOVE 12         TO PPS-RTC
193400                    END-IF
193500                 END-IF
193600              ELSE
193700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
193800                    MOVE 25            TO PPS-RTC
193900                 ELSE
194000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
194100                       MOVE 20         TO PPS-RTC
194200                    ELSE
194300                       IF ONSET-TRACK         = "Y"  THEN
194400                          MOVE 32      TO PPS-RTC
194500                       ELSE
194600                          MOVE 10      TO PPS-RTC
194700                       END-IF
194800                    END-IF
194900                 END-IF
195000              END-IF
195100           ELSE
195200              IF TRAINING-TRACK               = "Y"  THEN
195300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
195400                    MOVE 27            TO PPS-RTC
195500                 ELSE
195600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
195700                       MOVE 22         TO PPS-RTC
195800                    ELSE
195900                       MOVE 11         TO PPS-RTC
196000                    END-IF
196100                 END-IF
196200              ELSE
196300                 IF ONSET-TRACK               = "Y"  THEN
196400                    MOVE 08            TO PPS-RTC
196500                 ELSE
196600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
196700                       MOVE 04         TO PPS-RTC
196800                    ELSE
196900                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
197000                          MOVE 05      TO PPS-RTC
197100                       ELSE
197200                          IF LOW-BMI-TRACK = "Y"  THEN
197300                             MOVE 31 TO PPS-RTC
197400                          ELSE
197500                             MOVE 02 TO PPS-RTC
197600                          END-IF
197700                       END-IF
197800                    END-IF
197900                 END-IF
198000              END-IF
198100           END-IF
198200        END-IF
198300     END-IF.
198400
198500/
198600 9100-MOVE-RESULTS.
198700     IF MOVED-CORMORBIDS = SPACES  THEN
198800        NEXT SENTENCE
198900     ELSE
199000        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
199100        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
199200        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
199300        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
199400        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
199500        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
199600        MOVE H-COMORBID-CWF-CODE       TO
199700                                    COMORBID-CWF-RETURN-CODE
199800     END-IF.
199900
200000     MOVE P-GEO-MSA                    TO PPS-MSA.
200100     MOVE P-GEO-CBSA                   TO PPS-CBSA.
200200     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
200300     MOVE B-COND-CODE                  TO PPS-COND-CODE.
200400     MOVE B-REV-CODE                   TO PPS-REV-CODE.
200500     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
200600     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
200700     MOVE BUN-NAT-NONLABOR-PCT         TO
200800                                    PPS-2011-NAT-NONLABOR-PCT.
200900     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
201000     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
201100     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
201200     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
201300     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
201400     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
201500     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
201600     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
201700     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
201800     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
201900                                    PPS-2011-BDGT-NEUT-RATE.
202000     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
202100     MOVE SPACES                       TO
202200                                    PPS-2011-COMORBID-MA-CC.
202300
202400     IF (B-COND-CODE = '74')  AND
202500        (B-REV-CODE = '0841' OR '0851')  THEN
202600         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
202700                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
202800     END-IF.
202900
203000     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
203100           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
203200              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
203300           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
203400              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
203500           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
203600              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
203700     ELSE
203800        MOVE ZERO                      TO
203900                                    PPS-2011-BLEND-COMP-RATE
204000        MOVE ZERO                      TO
204100                                    PPS-2011-BLEND-PPS-RATE
204200        MOVE ZERO                      TO
204300                                    PPS-2011-BLEND-OUTLIER-RATE
204400     END-IF.
204500
204600     MOVE H-PYMT-AMT                   TO
204700                                    PPS-2011-FULL-COMP-RATE.
204800
204900     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
205000                                          PPS-FINAL-PAY-AMT.
205100
205200     MOVE H-OUT-PAYMENT                TO
205300                                    PPS-2011-FULL-OUTLIER-RATE.
205400
205500     MOVE H-TDAPA-PAYMENT              TO TDAPA-RETURN.
205600
205700     IF B-COND-CODE NOT = '84'
205800     THEN
205900       IF P-QIP-REDUCTION = ' '
206000       THEN CONTINUE
206100       ELSE
206200* OLD BLEND CODE - NEED TO CONSIDER REMOVING
206300         COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
206400                 PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
206500         COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
206600                 PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
206700         COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
206800                 PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
206900         COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
207000                 PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
207100
207200
207300         COMPUTE H-FINAL-AMT-WITHOUT-HDPA    ROUNDED =
207400                 H-FINAL-AMT-WITHOUT-HDPA    *  QIP-REDUCTION
207500         COMPUTE H-FINAL-AMT-WITH-HDPA       ROUNDED =
207600                 H-FINAL-AMT-WITH-HDPA       *  QIP-REDUCTION
207700
207800         COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
207900                 PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
208000
208100* COMPUTATION OF PPS-2011-FULL-PPS-RATE MOVED TO A STEP BELOW
208200*       COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
208300*               PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
208400
208500       END-IF
208600
208700********************************************************
208800* NEW FOR VERSION 20.1 - APPLY THE HDPA-ETC ADJUSTMENT *
208900********************************************************
209000       IF B-DATA-CODE = '94'
209100       THEN
209200         MOVE H-FINAL-AMT-WITH-HDPA TO PPS-2011-FULL-PPS-RATE
209300         MOVE H-FINAL-AMT-WITHOUT-HDPA TO
209400                          ADJ-BASE-WAGE-BEFORE-ETC-HDPA
209500       ELSE
209600         MOVE H-FINAL-AMT-WITHOUT-HDPA TO
209700                          PPS-2011-FULL-PPS-RATE
209800         MOVE ZERO TO ADJ-BASE-WAGE-BEFORE-ETC-HDPA
209900       END-IF
210000
210100     END-IF.
210200
210300*ESRD PC PRICER NEEDS BUNDLED-TEST-INDIC SET TO "T" IN ORDER TO BE
210400*TO PASS VALUES FOR DISPLAYING DETAILED RESULTS FROM BILL-DATA-TES
210500*BUNDLED-TEST-INDIC IS NOT SET TO "T"  IN THE PRODUCTION SYSTEM (F
210600     IF BUNDLED-TEST   THEN
210700        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
210800        MOVE 0.0                       TO MSA-WAGE-ADJ
210900        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
211000        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
211100        MOVE H-PATIENT-AGE             TO AGE-RETURN
211200        MOVE 0.0                       TO MSA-WAGE-AMT
211300        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
211400        MOVE H-BMI                     TO PPS-BMI
211500        MOVE H-BSA                     TO PPS-BSA
211600        MOVE MSA-BLEND-PCT             TO MSA-PCT
211700        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
211800
211900        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
212000           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
212100           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
212200        ELSE
212300           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
212400           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
212500        END-IF
212600
212700        MOVE H-BUN-BSA                 TO BUN-BSA
212800        MOVE H-BUN-BMI                 TO BUN-BMI
212900        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
213000        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
213100        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
213200        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
213300        MOVE H-OUT-BSA                 TO OUT-BSA
213400        MOVE SB-BSA                    TO OUT-SB-BSA
213500        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
213600        MOVE H-OUT-BMI                 TO OUT-BMI
213700        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
213800        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
213900        MOVE H-OUT-COMORBID-MULTIPLIER TO
214000                                    OUT-COMORBID-MULTIPLIER
214100        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
214200                                    OUT-PREDICTED-SERVICES-MAP
214300        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
214400                                    OUT-CASE-MIX-PREDICTED-MAP
214500        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
214600                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
214700        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
214800        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
214900        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
215000        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
215100        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
215200        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
215300        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
215400        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
215500        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
215600        MOVE CM-BSA                    TO PPS-CM-BSA
215700        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
215800        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
215900        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
216000        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
216100                                    BUN-ADJUSTED-BASE-WAGE-AMT
216200        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
216300                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
216400        MOVE TRAINING-ADD-ON-PMT-AMT   TO
216500                                    PPS-TRAINING-ADD-ON-PMT-AMT
216600        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
216700     END-IF.
216800******        L A S T   S O U R C E   S T A T E M E N T      *****
