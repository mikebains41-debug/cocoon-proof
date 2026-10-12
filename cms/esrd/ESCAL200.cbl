000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL200.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2020
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
035100* Furnished for Acute Kidney Injury (AKI) in ESRD Facilities for
035200* Calendar Year (CY) 2020
035300*
035400*   - Changed BUNDLED-BASE-PMT-RATE to 239.33
035500*   - Unchanged BUN-NAT-LABOR-PCT      0.52300
035600*   - Unchanged BUN-NAT-NONLABOR-PCT   0.47700
035700*   - Changed ADJ-AVG-MAP-AMT-GT-17 to 35.78
035800*   - Changed ADJ-AVG-MAP-AMT-LT-18 to 32.32
035900*   - Changed FIX-DOLLAR-LOSS-GT-17 to 48.33
036000*   - Changed FIX-DOLLAR-LOSS-LT-18 to 41.04
036100*
036200********************************************************
036300 DATE-COMPILED.
036400 ENVIRONMENT DIVISION.
036500 CONFIGURATION SECTION.
036600 SOURCE-COMPUTER.            IBM-Z990.
036700 OBJECT-COMPUTER.            IBM-Z990.
036800 INPUT-OUTPUT  SECTION.
036900 FILE-CONTROL.
037000
037100 DATA DIVISION.
037200 FILE SECTION.
037300/
037400 WORKING-STORAGE SECTION.
037500 01  W-STORAGE-REF                  PIC X(46) VALUE
037600     'ESCAL200      - W O R K I N G   S T O R A G E'.
037700 01  CAL-VERSION                    PIC X(05) VALUE 'C20.0'.
037800
037900 01  DISPLAY-LINE-MEASUREMENT.
038000     05  FILLER                     PIC X(50) VALUE
038100         '....:...10....:...20....:...30....:...40....:...50'.
038200     05  FILLER                     PIC X(50) VALUE
038300         '....:...60....:...70....:...80....:...90....:..100'.
038400     05  FILLER                     PIC X(20) VALUE
038500         '....:..110....:..120'.
038600
038700 01  PRINT-LINE-MEASUREMENT.
038800     05  FILLER                     PIC X(51) VALUE
038900         'X....:...10....:...20....:...30....:...40....:...50'.
039000     05  FILLER                     PIC X(50) VALUE
039100         '....:...60....:...70....:...80....:...90....:..100'.
039200     05  FILLER                     PIC X(32) VALUE
039300         '....:..110....:..120....:..130..'.
039400/
039500******************************************************************
039600*  This area contains all of the old Composite Rate variables.   *
039700* They will be eliminated when the transition period ends - 2014 *
039800******************************************************************
039900 01  HOLD-COMP-RATE-PPS-COMPONENTS.
040000     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
040100     05  H-PYMT-AMT                 PIC 9(04)V9(02).
040200     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
040300     05  H-PATIENT-AGE              PIC 9(03).
040400     05  H-AGE-FACTOR               PIC 9(01)V9(03).
040500     05  H-BSA-FACTOR               PIC 9(01)V9(04).
040600     05  H-BMI-FACTOR               PIC 9(01)V9(04).
040700     05  H-BSA                      PIC 9(03)V9(04).
040800     05  H-BMI                      PIC 9(03)V9(04).
040900     05  HGT-PART                   PIC 9(04)V9(08).
041000     05  WGT-PART                   PIC 9(04)V9(08).
041100     05  COMBINED-PART              PIC 9(04)V9(08).
041200     05  CALC-BSA                   PIC 9(04)V9(08).
041300
041400
041500* The following two variables will change from year to year
041600* and are used for the COMPOSITE part of the Bundled Pricer.
041700 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
041800 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
041900
042000* The next two percentages MUST add up to 1 (i.e. 100%)
042100* They will continue to change until CY2009 when CBSA will be 1.00
042200 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
042300 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
042400
042500* CONSTANTS AREA
042600* The next two percentages MUST add up TO 1 (i.e. 100%)
042700 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
042800 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
042900
043000* The next variable is only applicapable for the 2011 Pricer.
043100 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
043200
043300 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
043400 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
043500 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
043600                                                         0.428571.
043700* The above number technically represents the fractional
043800* number 3/7 which is three days per week that a person can
043900* receive dialysis.  It will remain this value ONLY for the
044000* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
044100* use the calculation method which is more understandable and
044200* follows the method used by the Policy folks.
044300
044400*  The following number that is loaded into the payment equation
044500*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
044600*  and   --DOES NOT CHANGE--
044700
044800 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
044900
045000 01  COMPOSITE-RATE-MULTIPLIERS.
045100*Composite rate payment multiplier (used for blended providers)
045200     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
045300     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
045400     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
045500     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
045600     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
045700     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
045800
045900     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
046000     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
046100/
046200******************************************************************
046300*    This area contains all of the NEW Bundled Rate variables.   *
046400******************************************************************
046500 01  HOLD-BUNDLED-PPS-COMPONENTS.
046600     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
046700     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
046800     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
046900     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
047000     05  H-BUN-BSA                  PIC 9(03)V9(04).
047100     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
047200     05  H-BUN-BMI                  PIC 9(03)V9(04).
047300     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
047400     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
047500     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
047600     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
047700                                    PIC 9(07)V9(04).
047800     05  H-BUN-WAGE-ADJ-TRAINING-AMT
047900                                    PIC 9(07)V9(04).
048000     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
048100     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
048200     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
048300     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
048400     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
048500                                    PIC 9(07)V9(04).
048600     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
048700     05  H-LV-OUT-PREDICT-SERVICES-MAP
048800                                    PIC 9(07)V9(04).
048900     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
049000                                    PIC 9(07)V9(04).
049100     05  H-LV-OUT-PREDICTED-MAP
049200                                    PIC 9(07)V9(04).
049300     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
049400
049500     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
049600     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
049700         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
049800
049900     05  H-COMORBID-DATA  OCCURS 6 TIMES
050000            INDEXED BY H-COMORBID-INDEX
050100                                    PIC X(02).
050200     05  H-COMORBID-CWF-CODE        PIC X(02).
050300
050400     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
050500
050600     05  QIP-REDUCTION              PIC 9(01)V9(03).
050700     05  SUB                        PIC 9(04).
050800
050900     05  THE-DATE                   PIC 9(08).
051000     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
051100     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
051200     05  ONSET-DATE                 PIC 9(08).
051300     05  MOVED-CORMORBIDS           PIC X(01).
051400     05  H-BUN-RURAL-MULTIPLIER     PIC 9(01)V9(03).
051500     05  H-TDAPA-PAYMENT            PIC 9(07)V9(04).
051600
051700 01  HOLD-OUTLIER-PPS-COMPONENTS.
051800     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
051900     05  H-OUT-BSA                  PIC 9(03)V9(04).
052000     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
052100     05  H-OUT-BMI                  PIC 9(03)V9(04).
052200     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
052300     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
052400     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
052500     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
052600     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
052700     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
052800     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
052900     05  H-OUT-PREDICTED-SERVICES-MAP
053000                                    PIC 9(07)V9(04).
053100     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
053200     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
053300                                    PIC 9(07)V9(04).
053400     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
053500     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
053600     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
053700     05  H-OUT-RURAL-MULTIPLIER     PIC 9(01)V9(03).
053800
053900* The following variable will change from year to year and is
054000* used for the BUNDLED part of the Bundled Pricer.
054100 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 239.33.
054200
054300* The next two percentages MUST add up to 1 (i.e. 100%)
054400* They start in 2011 and will continue to change until CY2014 when
054500* BUN-CBSA-BLEND-PCT will be 1.00
054600* The third blend percent is for those providers that waived the
054700* blended percent and went to full PPS.  This variable will be
054800* eliminated in 2014 when it is no longer needed.
054900 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
055000 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
055100 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
055200
055300* CONSTANTS AREA
055400* The next two percentages MUST add up TO 1 (i.e. 100%)
055500 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.52300.
055600 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.47700.
055700 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 95.60.
055800
055900*  The following number that is loaded into the payment equation
056000*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
056100*  and   --DOES NOT CHANGE--
056200 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
056300
056400* Added a constant to hold the BSA-National-Average that is used
056500* in the BSA Calculation. This value changes every five years.
056600 01 BSA-NATIONAL-AVERAGE            PIC 9(01)V9(02) VALUE 1.90.
056700
056800 01  PEDIATRIC-MULTIPLIERS.
056900*Separately billable payment multiplier (used for outliers)
057000     05  PED-SEP-BILL-PAY-MULTI.
057100         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.410.
057200         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.406.
057300         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.569.
057400         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.494.
057500     05  PED-EXPAND-BUNDLE-PAY-MULTI.
057600*Expanded bundle payment multiplier (used for normal billing)
057700         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.063.
057800         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.306.
057900         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.102.
058000         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.327.
058100
058200 01  ADULT-MULTIPLIERS.
058300*Separately billable payment multiplier (used for outliers)
058400     05  SEP-BILLABLE-PAYMANT-MULTI.
058500         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 1.044.
058600         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 1.000.
058700         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.005.
058800         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
058900         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.961.
059000         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.000.
059100         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.090.
059200         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.409.
059300         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.209.
059400*        10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
059500         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.426.
059600         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.999.
059700         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.494.
059800*        10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
059900         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.955.
060000         10 SB-RURAL               PIC 9(01)V9(03) VALUE 0.978.
060100*Case-Mix adjusted payment multiplier (used for normal billing)
060200     05  CASE-MIX-PAYMENT-MULTI.
060300         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.257.
060400         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.068.
060500         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.070.
060600         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
060700         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.109.
060800         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.032.
060900         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.017.
061000         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.327.
061100         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.040.
061200*        10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
061300         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.082.
061400         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.192.
061500         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.095.
061600*        10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
061700         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.239.
061800         10 CM-RURAL               PIC 9(01)V9(03) VALUE 1.008.
061900
062000 01  OUTLIER-SB-CALC-AMOUNTS.
062100     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 32.32.
062200     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 35.78.
062300     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 41.04.
062400     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 48.33.
062500     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
062600     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
062700/
062800******************************************************************
062900*    This area contains return code variables and their codes.   *
063000******************************************************************
063100 01 PAID-RETURN-CODE-TRACKERS.
063200     05  OUTLIER-TRACK              PIC X(01).
063300     05  ACUTE-COMORBID-TRACK       PIC X(01).
063400     05  CHRONIC-COMORBID-TRACK     PIC X(01).
063500     05  ONSET-TRACK                PIC X(01).
063600     05  LOW-VOLUME-TRACK           PIC X(01).
063700     05  TRAINING-TRACK             PIC X(01).
063800     05  PEDIATRIC-TRACK            PIC X(01).
063900     05  LOW-BMI-TRACK              PIC X(01).
064000 COPY RTCCPY.
064100*COPY "RTCCPY.CPY".
064200*                                                                *
064300*  Legal combinations of adjustments for ADULTS are:             *
064400*     if NO ONSET applies, then they can have any combination of:*
064500*       acute OR chronic comorbid, & outlier, low vol., training.*
064600*     if ONSET applies, then they can have:                      *
064700*           outlier and/or low volume.                           *
064800*  Legal combinations of adjustments for PEDIATRIC are:          *
064900*     outlier and/or training.                                   *
065000*                                                                *
065100*  Illegal combinations of adjustments for PEDIATRIC are:        *
065200*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
065300*     onset     with comorbid or training.                       *
065400*  Illegal combinations of adjustments for ANYONE are:           *
065500*     acute comorbid AND chronic comorbid.                       *
065600/
065700 LINKAGE SECTION.
065800 COPY BILLCPY.
065900*COPY "BILLCPY.CPY".
066000/
066100 COPY WAGECPY.
066200*COPY "WAGECPY.CPY".
066300/
066400 PROCEDURE DIVISION  USING BILL-NEW-DATA
066500                           PPS-DATA-ALL
066600                           WAGE-NEW-RATE-RECORD
066700                           COM-CBSA-WAGE-RECORD
066800                           BUN-CBSA-WAGE-RECORD.
066900
067000******************************************************************
067100* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
067200* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
067300* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
067400* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
067500* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
067600* UTILIZED HERE HAS BEEN APPROVED BY THE DIVISION OF             *
067700* INSTITUTIONAL CLAIMS PROCESSING (DICP).                        *
067800*                                                                *
067900*    PROCESSING:                                                 *
068000*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
068100*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
068200*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
068300*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
068400*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
068500*           GOBACK.                                              *
068600*        D. ASSEMBLE PRICING COMPONENTS.                         *
068700*        E. CALCULATE THE PRICE.                                 *
068800******************************************************************
068900
069000 0000-START-TO-FINISH.
069100     INITIALIZE PPS-DATA-ALL.
069200
069300* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
069400     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
069500
069600
069700* ESRD PC PRICER USES NEXT FOUR LINES TO INITIALIZE VALUES
069800* THAT IT NEEDS TO DISPLAY DETAILED RESULTS
069900     IF BUNDLED-TEST THEN
070000        INITIALIZE BILL-DATA-TEST
070100        INITIALIZE COND-CD-73
070200     END-IF.
070300
070400     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
070500     MOVE ZEROS                        TO PPS-RTC.
070600
070700     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
070800
070900     IF PPS-RTC = 00  THEN
071000        PERFORM 1200-INITIALIZATION
071100        IF B-COND-CODE  = '84' THEN
071200* Calculate payment for AKI claim
071300           MOVE H-BUN-BASE-WAGE-AMT TO
071400                H-PPS-FINAL-PAY-AMT
071500           MOVE '02' TO PPS-RTC
071600           MOVE '10' TO PPS-2011-COMORBID-PAY
071700        ELSE
071800* Calculate payment for ESRD claim
071900            PERFORM 2000-CALCULATE-BUNDLED-FACTORS
072000            PERFORM 9000-SET-RETURN-CODE
072100        END-IF
072200        PERFORM 9100-MOVE-RESULTS
072300     END-IF.
072400
072500     GOBACK.
072600/
072700 1000-VALIDATE-BILL-ELEMENTS.
072800     IF PPS-RTC = 00  THEN
072900        IF B-COND-CODE NOT = '73' AND '74' AND '84' AND
073000                             '87' AND '  '
073100           MOVE 58                  TO PPS-RTC
073200        END-IF
073300     END-IF.
073400
073500     IF PPS-RTC = 00  THEN
073600        IF  P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
073700           NEXT SENTENCE
073800        ELSE
073900           MOVE 52                        TO PPS-RTC
074000        END-IF
074100     END-IF.
074200
074300     IF PPS-RTC = 00  THEN
074400        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
074500           MOVE 53                     TO PPS-RTC
074600        END-IF
074700     END-IF.
074800
074900     IF PPS-RTC = 00  THEN
075000        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
075100           MOVE 54                     TO PPS-RTC
075200        END-IF
075300     END-IF.
075400
075500     IF PPS-RTC = 00  THEN
075600        IF B-COND-CODE NOT = '84' THEN
075700           IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
075800              MOVE 55                     TO PPS-RTC
075900           END-IF
076000        END-IF
076100     END-IF.
076200
076300     IF PPS-RTC = 00  THEN
076400        IF B-COND-CODE NOT = '84' THEN
076500           IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
076600              MOVE 56                     TO PPS-RTC
076700           END-IF
076800        END-IF
076900     END-IF.
077000
077100     IF PPS-RTC = 00  THEN
077200        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
077300                                OR '0881'
077400           NEXT SENTENCE
077500        ELSE
077600           MOVE 57                     TO PPS-RTC
077700        END-IF
077800     END-IF.
077900
078000     IF PPS-RTC = 00  THEN
078100        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
078200                                 ' '  THEN
078300           MOVE 53                     TO PPS-RTC
078400*  This RTC is for the Special Payment Indicator not = '1' or
078500*  blank, which closely approximates the intent of the edit check.
078600*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
078700        END-IF
078800     END-IF.
078900
079000     IF PPS-RTC = 00  THEN
079100        IF B-COND-CODE NOT = '84' THEN
079200           IF B-PATIENT-HGT > 300.00
079300              MOVE 71                     TO PPS-RTC
079400           END-IF
079500        END-IF
079600     END-IF.
079700
079800     IF PPS-RTC = 00  THEN
079900        IF B-COND-CODE NOT = '84' THEN
080000           IF B-PATIENT-WGT > 500.00  THEN
080100              MOVE 72                     TO PPS-RTC
080200           END-IF
080300        END-IF
080400     END-IF.
080500
080600* Before 2012 pricer, put in edit check to make sure that the
080700* # of sesions does not exceed the # of days in a month.  Maybe
080800* the # of cays in a month minus one when patient goes into a
080900* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
081000* or 0851)).  If done, then will need extra RTC.
081100     IF PPS-RTC = 00  THEN
081200        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
081300           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
081400           MOVE 73                     TO PPS-RTC
081500        END-IF
081600     END-IF.
081700
081800     IF PPS-RTC = 00  THEN
081900        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
082000           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
082100           MOVE 74                     TO PPS-RTC
082200        END-IF
082300     END-IF.
082400
082500     IF PPS-RTC = 00  THEN
082600        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
082700           MOVE 75                     TO PPS-RTC
082800        END-IF
082900     END-IF.
083000
083100     IF PPS-RTC = 00  THEN
083200        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
083300           MOVE 76                     TO PPS-RTC
083400        END-IF
083500     END-IF.
083600*OLD WAY OF VALIDATING COMORBIDS
083700*    IF PPS-RTC = 00  THEN
083800*       IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
083900*           VALID-COMORBID-CWF-RETURN-CD       THEN
084000*          NEXT SENTENCE
084100*       ELSE
084200*          MOVE 81                     TO PPS-RTC
084300*      END-IF
084400*    END-IF.
084500*
084600*CY2016 - DROP PNEUMONIA & MONOCLONAL GAMM COMORBIDS
084700
084800     IF PPS-RTC = 00  THEN
084900        IF B-COND-CODE NOT = '84' THEN
085000           IF COMORBID-CWF-RETURN-CODE = SPACES OR
085100               "10" OR "20" OR "40" OR "50" OR "60" THEN
085200              NEXT SENTENCE
085300           ELSE
085400              MOVE 81                     TO PPS-RTC
085500           END-IF
085600        END-IF
085700     END-IF.
085800/
085900 1200-INITIALIZATION.
086000     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
086100     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
086200     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
086300     INITIALIZE PAID-RETURN-CODE-TRACKERS.
086400
086500
086600******************************************************************
086700***Calculate BUNDLED Wage Adjusted Rate                        ***
086800******************************************************************
086900     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
087000        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
087100         BUN-CBSA-W-INDEX.
087200
087300     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
087400        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
087500
087600     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
087700        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
087800/
087900 2000-CALCULATE-BUNDLED-FACTORS.
088000
088100     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
088200     IF B-DOB-MM > B-THRU-MM  THEN
088300        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
088400     END-IF
088500     IF H-PATIENT-AGE < 18  THEN
088600        MOVE "Y"                    TO PEDIATRIC-TRACK
088700     END-IF.
088800
088900     MOVE SPACES                       TO MOVED-CORMORBIDS.
089000
089100     IF P-QIP-REDUCTION = ' '  THEN
089200* no reduction
089300        MOVE 1.000 TO QIP-REDUCTION
089400     ELSE
089500        IF P-QIP-REDUCTION = '1'  THEN
089600* one-half percent reduction
089700           MOVE 0.995 TO QIP-REDUCTION
089800        ELSE
089900           IF P-QIP-REDUCTION = '2'  THEN
090000* one percent reduction
090100              MOVE 0.990 TO QIP-REDUCTION
090200           ELSE
090300              IF P-QIP-REDUCTION = '3'  THEN
090400* one and one-half percent reduction
090500                 MOVE 0.985 TO QIP-REDUCTION
090600              ELSE
090700* two percent reduction
090800                 MOVE 0.980 TO QIP-REDUCTION
090900              END-IF
091000           END-IF
091100        END-IF
091200     END-IF.
091300
091400*    Since pricer has to pay a comorbid condition according to the
091500* return code that CWF passes back, it is cleaner if the pricer
091600* sets aside whatever comorbid data exists on the line-item when
091700* it comes into the pricer and then transferrs the CWF code to
091800* the appropriate place in the comorbid data.  This avoids
091900* making convoluted changes in the other parts of the program
092000* which has to look at both original comorbid data AND CWF return
092100* codes to handle comorbids.  Near the end of the program where
092200* variables are transferred to the output, the original comorbid
092300* data is put back into its original place as though nothing
092400* occurred.
092500*CY2016 DROPPED MB & MF
092600     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
092700        NEXT SENTENCE
092800     ELSE
092900        MOVE 'Y'                       TO MOVED-CORMORBIDS
093000        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
093100        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
093200        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
093300        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
093400        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
093500        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
093600        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
093700        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
093800           MOVE SPACES                 TO COMORBID-DATA (1)
093900                                          COMORBID-DATA (2)
094000                                          COMORBID-DATA (3)
094100                                          COMORBID-DATA (4)
094200                                          COMORBID-DATA (5)
094300                                          COMORBID-DATA (6)
094400                                          COMORBID-CWF-RETURN-CODE
094500        ELSE
094600           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
094700              MOVE 'MA'                TO COMORBID-DATA (1)
094800              MOVE SPACES              TO COMORBID-DATA (2)
094900                                          COMORBID-DATA (3)
095000                                          COMORBID-DATA (4)
095100                                          COMORBID-DATA (5)
095200                                          COMORBID-DATA (6)
095300                                          COMORBID-CWF-RETURN-CODE
095400           ELSE
095500*             IF COMORBID-CWF-RETURN-CODE = '30'  THEN
095600*                MOVE SPACES           TO COMORBID-DATA (1)
095700*                MOVE 'MB'             TO COMORBID-DATA (2)
095800*                MOVE SPACES           TO COMORBID-DATA (3)
095900*                MOVE SPACES           TO COMORBID-DATA (4)
096000*                MOVE SPACES           TO COMORBID-DATA (5)
096100*                MOVE SPACES           TO COMORBID-DATA (6)
096200*                                         COMORBID-CWF-RETURN-CODE
096300*             ELSE
096400                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
096500                    MOVE SPACES        TO COMORBID-DATA (1)
096600                    MOVE SPACES        TO COMORBID-DATA (2)
096700                    MOVE 'MC'          TO COMORBID-DATA (3)
096800                    MOVE SPACES        TO COMORBID-DATA (4)
096900                    MOVE SPACES        TO COMORBID-DATA (5)
097000                    MOVE SPACES        TO COMORBID-DATA (6)
097100                                          COMORBID-CWF-RETURN-CODE
097200                 ELSE
097300                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
097400                       MOVE SPACES     TO COMORBID-DATA (1)
097500                       MOVE SPACES     TO COMORBID-DATA (2)
097600                       MOVE SPACES     TO COMORBID-DATA (3)
097700                       MOVE 'MD'       TO COMORBID-DATA (4)
097800                       MOVE SPACES     TO COMORBID-DATA (5)
097900                       MOVE SPACES     TO COMORBID-DATA (6)
098000                                          COMORBID-CWF-RETURN-CODE
098100                    ELSE
098200                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
098300                          MOVE SPACES  TO COMORBID-DATA (1)
098400                          MOVE SPACES  TO COMORBID-DATA (2)
098500                          MOVE SPACES  TO COMORBID-DATA (3)
098600                          MOVE SPACES  TO COMORBID-DATA (4)
098700                          MOVE 'ME'    TO COMORBID-DATA (5)
098800                          MOVE SPACES  TO COMORBID-DATA (6)
098900                                          COMORBID-CWF-RETURN-CODE
099000*                      ELSE
099100*                         MOVE SPACES  TO COMORBID-DATA (1)
099200*                                         COMORBID-DATA (2)
099300*                                         COMORBID-DATA (3)
099400*                                         COMORBID-DATA (4)
099500*                                         COMORBID-DATA (5)
099600*                                         COMORBID-CWF-RETURN-CODE
099700*                         MOVE 'MF'    TO COMORBID-DATA (6)
099800                       END-IF
099900                    END-IF
100000                 END-IF
100100*             END-IF
100200           END-IF
100300        END-IF
100400     END-IF.
100500******************************************************************
100600***  Set BUNDLED age adjustment factor                         ***
100700******************************************************************
100800     IF H-PATIENT-AGE < 13  THEN
100900        IF B-REV-CODE = '0821' OR '0881' THEN
101000           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
101100        ELSE
101200           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
101300        END-IF
101400     ELSE
101500        IF H-PATIENT-AGE < 18 THEN
101600           IF B-REV-CODE = '0821' OR '0881' THEN
101700              MOVE EB-AGE-13-17-HEMO-MODE
101800                                       TO H-BUN-AGE-FACTOR
101900           ELSE
102000              MOVE EB-AGE-13-17-PD-MODE
102100                                       TO H-BUN-AGE-FACTOR
102200           END-IF
102300        ELSE
102400           IF H-PATIENT-AGE < 45  THEN
102500              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
102600           ELSE
102700              IF H-PATIENT-AGE < 60  THEN
102800                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
102900              ELSE
103000                 IF H-PATIENT-AGE < 70  THEN
103100                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
103200                 ELSE
103300                    IF H-PATIENT-AGE < 80  THEN
103400                       MOVE CM-AGE-70-79
103500                                       TO H-BUN-AGE-FACTOR
103600                    ELSE
103700                       MOVE CM-AGE-80-PLUS
103800                                       TO H-BUN-AGE-FACTOR
103900                    END-IF
104000                 END-IF
104100              END-IF
104200           END-IF
104300        END-IF
104400     END-IF.
104500
104600******************************************************************
104700***  Calculate BUNDLED BSA factor (note NEW formula)           ***
104800******************************************************************
104900     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
105000         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
105100
105200     IF H-PATIENT-AGE > 17  THEN
105300        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
105400*            CM-BSA ** ((H-BUN-BSA - 1.90) / .1)
105500             CM-BSA ** ((H-BUN-BSA - BSA-NATIONAL-AVERAGE) / .1)
105600     ELSE
105700        MOVE 1.000                     TO H-BUN-BSA-FACTOR
105800     END-IF.
105900
106000******************************************************************
106100***  Calculate BUNDLED BMI factor                              ***
106200******************************************************************
106300     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
106400         (B-PATIENT-HGT ** 2)) * 10000.
106500
106600     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
106700        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
106800        MOVE "Y"                       TO LOW-BMI-TRACK
106900     ELSE
107000        MOVE 1.000                     TO H-BUN-BMI-FACTOR
107100     END-IF.
107200
107300******************************************************************
107400***  Calculate BUNDLED ONSET factor                            ***
107500******************************************************************
107600     IF B-DIALYSIS-START-DATE > ZERO  THEN
107700        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
107800        COMPUTE INTEGER-LINE-ITEM-DATE =
107900            FUNCTION INTEGER-OF-DATE(THE-DATE)
108000        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
108100        COMPUTE INTEGER-DIALYSIS-DATE  =
108200            FUNCTION INTEGER-OF-DATE(THE-DATE)
108300* Need to add one to onset-date because the start date should
108400* be included in the count of days.  fix made 9/6/2011
108500        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
108600                              INTEGER-DIALYSIS-DATE) + 1
108700        IF H-PATIENT-AGE > 17  THEN
108800           IF ONSET-DATE > 120  THEN
108900              MOVE 1                   TO H-BUN-ONSET-FACTOR
109000           ELSE
109100              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
109200              MOVE "Y"                 TO ONSET-TRACK
109300           END-IF
109400        ELSE
109500           MOVE 1                      TO H-BUN-ONSET-FACTOR
109600        END-IF
109700     ELSE
109800        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
109900     END-IF.
110000
110100******************************************************************
110200***  Set BUNDLED Co-morbidities adjustment                     ***
110300******************************************************************
110400     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
110500        IF H-PATIENT-AGE  <  18  THEN
110600           MOVE 1.000                  TO
110700                                       H-BUN-COMORBID-MULTIPLIER
110800           MOVE '10'                   TO PPS-2011-COMORBID-PAY
110900        ELSE
111000           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
111100              MOVE 1.000               TO
111200                                       H-BUN-COMORBID-MULTIPLIER
111300              MOVE '10'                TO PPS-2011-COMORBID-PAY
111400           ELSE
111500              PERFORM 2100-CALC-COMORBID-ADJUST
111600              MOVE H-COMORBID-MULTIPLIER TO
111700                                       H-BUN-COMORBID-MULTIPLIER
111800           END-IF
111900        END-IF
112000     ELSE
112100        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
112200           MOVE 1.000                  TO
112300                                       H-BUN-COMORBID-MULTIPLIER
112400           MOVE '10'                   TO PPS-2011-COMORBID-PAY
112500        ELSE
112600           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
112700              MOVE CM-GI-BLEED         TO
112800                                       H-BUN-COMORBID-MULTIPLIER
112900              MOVE '20'                TO PPS-2011-COMORBID-PAY
113000           ELSE
113100*            IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
113200*                MOVE CM-PNEUMONIA     TO
113300*                                      H-BUN-COMORBID-MULTIPLIER
113400*                MOVE '30'             TO PPS-2011-COMORBID-PAY
113500*            ELSE
113600                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
113700                    MOVE CM-PERICARDITIS TO
113800                                       H-BUN-COMORBID-MULTIPLIER
113900                    MOVE '40'          TO PPS-2011-COMORBID-PAY
114000                 END-IF
114100*            END-IF
114200           END-IF
114300        END-IF
114400     END-IF.
114500
114600******************************************************************
114700***  Calculate BUNDLED Low Volume adjustment                   ***
114800******************************************************************
114900     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
115000        IF H-PATIENT-AGE > 17  THEN
115100           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
115200                                       H-BUN-LOW-VOL-MULTIPLIER
115300           MOVE "Y"                    TO  LOW-VOLUME-TRACK
115400        ELSE
115500           MOVE 1.000                  TO
115600                                       H-BUN-LOW-VOL-MULTIPLIER
115700        END-IF
115800     ELSE
115900        MOVE 1.000                     TO
116000                                       H-BUN-LOW-VOL-MULTIPLIER
116100     END-IF.
116200
116300***************************************************************
116400* Calculate Rural Adjustment Multiplier ADDED CY 2016
116500***************************************************************
116600     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
116700        MOVE CM-RURAL TO H-BUN-RURAL-MULTIPLIER
116800     ELSE
116900        MOVE 1.000 TO H-BUN-RURAL-MULTIPLIER.
117000
117100******************************************************************
117200***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
117300******************************************************************
117400     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
117500        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
117600        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
117700        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
117800        H-BUN-LOW-VOL-MULTIPLIER * H-BUN-RURAL-MULTIPLIER.
117900
118000******************************************************************
118100***  Calculate BUNDLED Condition Code payment                  ***
118200******************************************************************
118300* Self-care in Training add-on
118400     IF B-COND-CODE = '73' OR '87' THEN
118500* no add-on when onset is present
118600        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
118700           MOVE ZERO                   TO
118800                                    H-BUN-WAGE-ADJ-TRAINING-AMT
118900        ELSE
119000* use new PPS training add-on amount times wage-index
119100           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
119200             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
119300           MOVE "Y"                    TO TRAINING-TRACK
119400        END-IF
119500     ELSE
119600* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
119700        IF (B-COND-CODE = '74')  AND
119800           (B-REV-CODE = '0841' OR '0851')  THEN
119900              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
120000                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
120100        ELSE
120200           MOVE ZERO                   TO
120300                                    H-BUN-WAGE-ADJ-TRAINING-AMT
120400                                    H-CC-74-PER-DIEM-AMT
120500        END-IF
120600     END-IF.
120700
120800******************************************************************
120900***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
121000******************************************************************
121100     IF (B-COND-CODE = '74')  AND
121200        (B-REV-CODE = '0841' OR '0851')  THEN
121300           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
121400                           H-CC-74-PER-DIEM-AMT
121500           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
121600              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
121700              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
121800     ELSE COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
121900                  H-BUN-ADJUSTED-BASE-WAGE-AMT  +
122000                  H-BUN-WAGE-ADJ-TRAINING-AMT
122100     END-IF.
122200
122300****************************************************************
122400***  Include TDAPA Payment                                   ***
122500****************************************************************
122600     COMPUTE H-TDAPA-PAYMENT = B-PAYER-ONLY-VC-Q8 /
122700                               B-CLAIM-NUM-DIALYSIS-SESSIONS.
122800     COMPUTE H-PPS-FINAL-PAY-AMT = H-PPS-FINAL-PAY-AMT +
122900                                   H-TDAPA-PAYMENT.
123000
123100******************************************************************
123200***  Calculate BUNDLED Outlier                                 ***
123300******************************************************************
123400     PERFORM 2500-CALC-OUTLIER-FACTORS.
123500
123600******************************************************************
123700***  Calculate Low Volume payment for recovery purposes        ***
123800******************************************************************
123900     IF LOW-VOLUME-TRACK = "Y"  THEN
124000        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
124100        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
124200
124300        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
124400           H-PPS-FINAL-PAY-AMT
124500
124600        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
124700           H-OUT-PAYMENT
124800
124900        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
125000           H-LV-OUT-PAYMENT
125100
125200        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
125300           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
125400              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
125500        ELSE
125600           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
125700        END-IF
125800     END-IF.
125900
126000
126100/
126200 2100-CALC-COMORBID-ADJUST.
126300******************************************************************
126400***  Calculate Co-morbidities adjustment                       ***
126500******************************************************************
126600*  This logic assumes that the comorbids are randomly assigned   *
126700*to the comorbid table.  It will select the highest comorbid for *
126800*payment if one is found.  CY 2016 DROPPED MB & MF              *
126900******************************************************************
127000     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
127100     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
127200     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
127300
127400     PERFORM VARYING  SUB  FROM  1 BY 1
127500       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
127600         IF COMORBID-DATA (SUB) = 'MA'  THEN
127700           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
127800*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
127900           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
128000           MOVE '20'                   TO PPS-2011-COMORBID-PAY
128100         ELSE
128200*          IF COMORBID-DATA (SUB) = 'MB'  THEN
128300*            IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
128400*              MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
128500*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
128600*              MOVE '30'               TO PPS-2011-COMORBID-PAY
128700*            END-IF
128800*          ELSE
128900             IF COMORBID-DATA (SUB) = 'MC'  THEN
129000                IF CM-PERICARDITIS  >
129100                                      H-COMORBID-MULTIPLIER  THEN
129200                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
129300                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
129400                  MOVE '40'            TO PPS-2011-COMORBID-PAY
129500                END-IF
129600             ELSE
129700               IF COMORBID-DATA (SUB) = 'MD'  THEN
129800                 IF CM-MYELODYSPLASTIC  >
129900                                      H-COMORBID-MULTIPLIER  THEN
130000                   MOVE CM-MYELODYSPLASTIC  TO
130100                                      H-COMORBID-MULTIPLIER
130200                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
130300                   MOVE '50'           TO PPS-2011-COMORBID-PAY
130400                 END-IF
130500               ELSE
130600                 IF COMORBID-DATA (SUB) = 'ME'  THEN
130700                   IF CM-SICKEL-CELL  >
130800                                      H-COMORBID-MULTIPLIER  THEN
130900                     MOVE CM-SICKEL-CELL  TO
131000                                      H-COMORBID-MULTIPLIER
131100                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
131200                     MOVE '60'         TO PPS-2011-COMORBID-PAY
131300                   END-IF
131400*                ELSE
131500*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
131600*                    IF CM-MONOCLONAL-GAMM  >
131700*                                     H-COMORBID-MULTIPLIER  THEN
131800*                      MOVE CM-MONOCLONAL-GAMM TO
131900*                                     H-COMORBID-MULTIPLIER
132000*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
132100*                      MOVE '70'       TO PPS-2011-COMORBID-PAY
132200*                    END-IF
132300*                  END-IF
132400                 END-IF
132500               END-IF
132600             END-IF
132700*          END-IF
132800         END-IF
132900     END-PERFORM.
133000/
133100 2500-CALC-OUTLIER-FACTORS.
133200******************************************************************
133300***  Set separately billable OUTLIER age adjustment factor     ***
133400******************************************************************
133500     IF H-PATIENT-AGE < 13  THEN
133600        IF B-REV-CODE = '0821' OR '0881' THEN
133700           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
133800        ELSE
133900           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
134000        END-IF
134100     ELSE
134200        IF H-PATIENT-AGE < 18 THEN
134300           IF B-REV-CODE = '0821' OR '0881'  THEN
134400              MOVE SB-AGE-13-17-HEMO-MODE
134500                                       TO H-OUT-AGE-FACTOR
134600           ELSE
134700              MOVE SB-AGE-13-17-PD-MODE
134800                                       TO H-OUT-AGE-FACTOR
134900           END-IF
135000        ELSE
135100           IF H-PATIENT-AGE < 45  THEN
135200              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
135300           ELSE
135400              IF H-PATIENT-AGE < 60  THEN
135500                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
135600              ELSE
135700                 IF H-PATIENT-AGE < 70  THEN
135800                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
135900                 ELSE
136000                    IF H-PATIENT-AGE < 80  THEN
136100                       MOVE SB-AGE-70-79
136200                                       TO H-OUT-AGE-FACTOR
136300                    ELSE
136400                       MOVE SB-AGE-80-PLUS
136500                                       TO H-OUT-AGE-FACTOR
136600                    END-IF
136700                 END-IF
136800              END-IF
136900           END-IF
137000        END-IF
137100     END-IF.
137200
137300******************************************************************
137400**Calculate separately billable OUTLIER BSA factor (superscript)**
137500******************************************************************
137600     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
137700         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
137800
137900     IF H-PATIENT-AGE > 17  THEN
138000        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
138100*            SB-BSA ** ((H-OUT-BSA - 1.90) / .1)
138200             SB-BSA ** ((H-OUT-BSA - BSA-NATIONAL-AVERAGE) / .1)
138300     ELSE
138400        MOVE 1.000                     TO H-OUT-BSA-FACTOR
138500     END-IF.
138600
138700******************************************************************
138800***  Calculate separately billable OUTLIER BMI factor          ***
138900******************************************************************
139000     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
139100         (B-PATIENT-HGT ** 2)) * 10000.
139200
139300     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
139400        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
139500     ELSE
139600        MOVE 1.000                     TO H-OUT-BMI-FACTOR
139700     END-IF.
139800
139900******************************************************************
140000***  Calculate separately billable OUTLIER ONSET factor        ***
140100******************************************************************
140200     IF B-DIALYSIS-START-DATE > ZERO  THEN
140300        IF H-PATIENT-AGE > 17  THEN
140400           IF ONSET-DATE > 120  THEN
140500              MOVE 1                   TO H-OUT-ONSET-FACTOR
140600           ELSE
140700              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
140800           END-IF
140900        ELSE
141000           MOVE 1                      TO H-OUT-ONSET-FACTOR
141100        END-IF
141200     ELSE
141300        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
141400     END-IF.
141500
141600******************************************************************
141700***  Set separately billable OUTLIER Co-morbidities adjustment ***
141800* CY 2016 DROPPED MB & MF
141900******************************************************************
142000     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
142100        IF H-PATIENT-AGE  <  18  THEN
142200           MOVE 1.000                  TO
142300                                       H-OUT-COMORBID-MULTIPLIER
142400           MOVE '10'                   TO PPS-2011-COMORBID-PAY
142500        ELSE
142600           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
142700              MOVE 1.000               TO
142800                                       H-OUT-COMORBID-MULTIPLIER
142900              MOVE '10'                TO PPS-2011-COMORBID-PAY
143000           ELSE
143100              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
143200           END-IF
143300        END-IF
143400     ELSE
143500        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
143600           MOVE 1.000                  TO
143700                                       H-OUT-COMORBID-MULTIPLIER
143800        ELSE
143900           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
144000              MOVE SB-GI-BLEED         TO
144100                                       H-OUT-COMORBID-MULTIPLIER
144200           ELSE
144300*             IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
144400*                MOVE SB-PNEUMONIA     TO
144500*                                      H-OUT-COMORBID-MULTIPLIER
144600*             ELSE
144700                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
144800                    MOVE SB-PERICARDITIS TO
144900                                       H-OUT-COMORBID-MULTIPLIER
145000                 END-IF
145100*             END-IF
145200           END-IF
145300        END-IF
145400     END-IF.
145500
145600******************************************************************
145700***  Set OUTLIER low-volume-multiplier                         ***
145800******************************************************************
145900     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
146000        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
146100     ELSE
146200        IF H-PATIENT-AGE < 18  THEN
146300           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
146400        ELSE
146500           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
146600           MOVE "Y"                    TO LOW-VOLUME-TRACK
146700        END-IF
146800     END-IF.
146900
147000***************************************************************
147100* Calculate OUTLIER Rural Adjustment multiplier
147200***************************************************************
147300
147400     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
147500        MOVE SB-RURAL TO H-OUT-RURAL-MULTIPLIER
147600     ELSE
147700        MOVE 1.000 TO H-OUT-RURAL-MULTIPLIER.
147800
147900******************************************************************
148000***  Calculate predicted OUTLIER services MAP per treatment    ***
148100******************************************************************
148200     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
148300        (H-OUT-AGE-FACTOR             *
148400         H-OUT-BSA-FACTOR             *
148500         H-OUT-BMI-FACTOR             *
148600         H-OUT-ONSET-FACTOR           *
148700         H-OUT-COMORBID-MULTIPLIER    *
148800         H-OUT-RURAL-MULTIPLIER       *
148900         H-OUT-LOW-VOL-MULTIPLIER).
149000
149100******************************************************************
149200***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
149300******************************************************************
149400     IF H-PATIENT-AGE < 18  THEN
149500        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
149600           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
149700        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
149800     ELSE
149900
150000        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
150100           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
150200        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
150300     END-IF.
150400
150500******************************************************************
150600*** Calculate imputed OUTLIER services MAP amount per treatment***
150700******************************************************************
150800     IF (B-COND-CODE = '74')  AND
150900        (B-REV-CODE = '0841' OR '0851')  THEN
151000         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
151100            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
151200         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
151300         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
151400     ELSE
151500        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
151600        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
151700     END-IF.
151800
151900******************************************************************
152000*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
152100******************************************************************
152200     IF H-PATIENT-AGE < 18   THEN
152300        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
152400           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
152500        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
152600        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
152700           COMPUTE H-OUT-PAYMENT  ROUNDED  =
152800            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
152900                                         LOSS-SHARING-PCT-LT-18
153000           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
153100           MOVE "Y"                    TO OUTLIER-TRACK
153200        ELSE
153300           MOVE ZERO                   TO H-OUT-PAYMENT
153400           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
153500        END-IF
153600     ELSE
153700        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
153800           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
153900           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
154000        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
154100           COMPUTE H-OUT-PAYMENT  ROUNDED  =
154200            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
154300                                         LOSS-SHARING-PCT-GT-17
154400           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
154500           MOVE "Y"                    TO OUTLIER-TRACK
154600        ELSE
154700           MOVE ZERO                   TO H-OUT-PAYMENT
154800        END-IF
154900     END-IF.
155000
155100     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
155200
155300* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
155400     IF (B-COND-CODE = '74')  AND
155500        (B-REV-CODE = '0841' OR '0851')  THEN
155600           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
155700             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
155800     END-IF.
155900/
156000 2600-CALC-COMORBID-OUT-ADJUST.
156100******************************************************************
156200***  Calculate OUTLIER Co-morbidities adjustment               ***
156300******************************************************************
156400*  This logic assumes that the comorbids are randomly assigned   *
156500*to the comorbid table.  It will select the highest comorbid for *
156600*payment if one is found. CY 2016 DROPPED MB & MF                *
156700******************************************************************
156800
156900     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
157000     MOVE 1.000                        TO
157100                                  H-OUT-COMORBID-MULTIPLIER.
157200
157300     PERFORM VARYING  SUB  FROM  1 BY 1
157400       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
157500         IF COMORBID-DATA (SUB) = 'MA'  THEN
157600           MOVE SB-GI-BLEED            TO
157700                                  H-OUT-COMORBID-MULTIPLIER
157800*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
157900           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
158000         ELSE
158100*          IF COMORBID-DATA (SUB) = 'MB'  THEN
158200*            IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
158300*              MOVE SB-PNEUMONIA       TO
158400*                                 H-OUT-COMORBID-MULTIPLIER
158500*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
158600*            END-IF
158700*          ELSE
158800             IF COMORBID-DATA (SUB) = 'MC'  THEN
158900                IF SB-PERICARDITIS  >
159000                                  H-OUT-COMORBID-MULTIPLIER  THEN
159100                  MOVE SB-PERICARDITIS TO
159200                                  H-OUT-COMORBID-MULTIPLIER
159300                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
159400                END-IF
159500             ELSE
159600               IF COMORBID-DATA (SUB) = 'MD'  THEN
159700                 IF SB-MYELODYSPLASTIC  >
159800                                  H-OUT-COMORBID-MULTIPLIER  THEN
159900                   MOVE SB-MYELODYSPLASTIC  TO
160000                                  H-OUT-COMORBID-MULTIPLIER
160100                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
160200                 END-IF
160300               ELSE
160400                 IF COMORBID-DATA (SUB) = 'ME'  THEN
160500                   IF SB-SICKEL-CELL  >
160600                                 H-OUT-COMORBID-MULTIPLIER  THEN
160700                     MOVE SB-SICKEL-CELL  TO
160800                                  H-OUT-COMORBID-MULTIPLIER
160900                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
161000                   END-IF
161100*                ELSE
161200*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
161300*                    IF SB-MONOCLONAL-GAMM  >
161400*                                 H-OUT-COMORBID-MULTIPLIER  THEN
161500*                      MOVE SB-MONOCLONAL-GAMM  TO
161600*                                 H-OUT-COMORBID-MULTIPLIER
161700*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
161800*                    END-IF
161900*                  END-IF
162000                 END-IF
162100               END-IF
162200             END-IF
162300*          END-IF
162400         END-IF
162500     END-PERFORM.
162600/
162700******************************************************************
162800*** Calculate Low Volume Full PPS payment for recovery purposes***
162900******************************************************************
163000 3000-LOW-VOL-FULL-PPS-PAYMENT.
163100******************************************************************
163200** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
163300     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
163400        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
163500        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
163600        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
163700         H-BUN-RURAL-MULTIPLIER.
163800
163900******************************************************************
164000**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
164100* Self-care in Training add-on
164200     IF B-COND-CODE = '73' OR '87' THEN
164300* no add-on when onset is present
164400        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
164500           MOVE ZERO                   TO
164600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
164700        ELSE
164800* use new PPS training add-on amount times wage-index
164900           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
165000             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
165100           MOVE "Y"                    TO TRAINING-TRACK
165200        END-IF
165300     ELSE
165400* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
165500        IF (B-COND-CODE = '74')  AND
165600           (B-REV-CODE = '0841' OR '0851')  THEN
165700              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
165800                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
165900        ELSE
166000           MOVE ZERO                   TO
166100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
166200                                    H-CC-74-PER-DIEM-AMT
166300        END-IF
166400     END-IF.
166500
166600******************************************************************
166700**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
166800     IF (B-COND-CODE = '74')  AND
166900        (B-REV-CODE = '0841' OR '0851')  THEN
167000           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
167100                           H-CC-74-PER-DIEM-AMT
167200     ELSE
167300        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
167400                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
167500                H-BUN-WAGE-ADJ-TRAINING-AMT
167600     END-IF.
167700
167800/
167900******************************************************************
168000*** Calculate Low Volume OUT PPS payment for recovery purposes ***
168100******************************************************************
168200 3100-LOW-VOL-OUT-PPS-PAYMENT.
168300******************************************************************
168400**Modified code from 'Calc predict OUT serv MAP per treat' para.**
168500     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
168600        (H-OUT-AGE-FACTOR             *
168700         H-OUT-BSA-FACTOR             *
168800         H-OUT-BMI-FACTOR             *
168900         H-OUT-ONSET-FACTOR           *
169000         H-OUT-COMORBID-MULTIPLIER    *
169100         H-OUT-RURAL-MULTIPLIER).
169200
169300******************************************************************
169400**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
169500     IF H-PATIENT-AGE < 18  THEN
169600        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
169700           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
169800        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
169900     ELSE
170000        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
170100           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
170200        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
170300     END-IF.
170400
170500******************************************************************
170600** 'Calculate imput OUT services MAP amount per treatment' para **
170700** It is not necessary to modify or insert this paragraph here. **
170800
170900******************************************************************
171000**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
171100     IF H-PATIENT-AGE < 18   THEN
171200        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
171300           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
171400        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
171500        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
171600           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
171700            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
171800                                         LOSS-SHARING-PCT-LT-18
171900           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
172000        ELSE
172100           MOVE ZERO                   TO H-LV-OUT-PAYMENT
172200           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
172300        END-IF
172400     ELSE
172500        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
172600           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
172700           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
172800        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
172900           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
173000            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
173100                                         LOSS-SHARING-PCT-GT-17
173200           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
173300        ELSE
173400           MOVE ZERO                   TO H-LV-OUT-PAYMENT
173500        END-IF
173600     END-IF.
173700
173800     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
173900
174000* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
174100     IF (B-COND-CODE = '74')  AND
174200        (B-REV-CODE = '0841' OR '0851')  THEN
174300           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
174400             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
174500     END-IF.
174600
174700
174800/
174900 9000-SET-RETURN-CODE.
175000******************************************************************
175100***  Set the return code                                       ***
175200******************************************************************
175300*   The following 'table' helps in understanding and in making   *
175400*changes to the rather large and complex "IF" statement that     *
175500*follows.  This 'table' just reorders and rewords the comments   *
175600*contained in the working storage area concerning the paid       *
175700*return-codes.                                                   *
175800*                                                                *
175900*  17 = pediatric, outlier, training                             *
176000*  16 = pediatric, outlier                                       *
176100*  15 = pediatric, training                                      *
176200*  14 = pediatric                                                *
176300*                                                                *
176400*  24 = outlier, low volume, training, chronic comorbid          *
176500*  19 = outlier, low volume, training, acute comorbid            *
176600*  29 = outlier, low volume, training                            *
176700*  23 = outlier, low volume, chronic comorbid                    *
176800*  18 = outlier, low volume, acute comorbid                      *
176900*  30 = outlier, low volume, onset                               *
177000*  28 = outlier, low volume                                      *
177100*  34 = outlier, training, chronic comorbid                      *
177200*  35 = outlier, training, acute comorbid                        *
177300*  33 = outlier, training                                        *
177400*  07 = outlier, chronic comorbid                                *
177500*  06 = outlier, acute comorbid                                  *
177600*  09 = outlier, onset                                           *
177700*  03 = outlier                                                  *
177800*                                                                *
177900*  26 = low volume, training, chronic comorbid                   *
178000*  21 = low volume, training, acute comorbid                     *
178100*  12 = low volume, training                                     *
178200*  25 = low volume, chronic comorbid                             *
178300*  20 = low volume, acute comorbid                               *
178400*  32 = low volume, onset                                        *
178500*  10 = low volume                                               *
178600*                                                                *
178700*  27 = training, chronic comorbid                               *
178800*  22 = training, acute comorbid                                 *
178900*  11 = training                                                 *
179000*                                                                *
179100*  08 = onset                                                    *
179200*  04 = acute comorbid                                           *
179300*  05 = chronic comorbid                                         *
179400*  31 = low BMI                                                  *
179500*  02 = no adjustments                                           *
179600*                                                                *
179700*  13 = w/multiple adjustments....reserved for future use        *
179800******************************************************************
179900/
180000     IF PEDIATRIC-TRACK                       = "Y"  THEN
180100        IF OUTLIER-TRACK                      = "Y"  THEN
180200           IF TRAINING-TRACK                  = "Y"  THEN
180300              MOVE 17                  TO PPS-RTC
180400           ELSE
180500              MOVE 16                  TO PPS-RTC
180600           END-IF
180700        ELSE
180800           IF TRAINING-TRACK                  = "Y"  THEN
180900              MOVE 15                  TO PPS-RTC
181000           ELSE
181100              MOVE 14                  TO PPS-RTC
181200           END-IF
181300        END-IF
181400     ELSE
181500        IF OUTLIER-TRACK                      = "Y"  THEN
181600           IF LOW-VOLUME-TRACK                = "Y"  THEN
181700              IF TRAINING-TRACK               = "Y"  THEN
181800                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
181900                    MOVE 24            TO PPS-RTC
182000                 ELSE
182100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
182200                       MOVE 19         TO PPS-RTC
182300                    ELSE
182400                       MOVE 29         TO PPS-RTC
182500                    END-IF
182600                 END-IF
182700              ELSE
182800                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
182900                    MOVE 23            TO PPS-RTC
183000                 ELSE
183100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
183200                       MOVE 18         TO PPS-RTC
183300                    ELSE
183400                       IF ONSET-TRACK         = "Y"  THEN
183500                          MOVE 30      TO PPS-RTC
183600                       ELSE
183700                          MOVE 28      TO PPS-RTC
183800                       END-IF
183900                    END-IF
184000                 END-IF
184100              END-IF
184200           ELSE
184300              IF TRAINING-TRACK               = "Y"  THEN
184400                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
184500                    MOVE 34            TO PPS-RTC
184600                 ELSE
184700                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
184800                       MOVE 35         TO PPS-RTC
184900                    ELSE
185000                       MOVE 33         TO PPS-RTC
185100                    END-IF
185200                 END-IF
185300              ELSE
185400                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
185500                    MOVE 07            TO PPS-RTC
185600                 ELSE
185700                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
185800                       MOVE 06         TO PPS-RTC
185900                    ELSE
186000                       IF ONSET-TRACK         = "Y"  THEN
186100                          MOVE 09      TO PPS-RTC
186200                       ELSE
186300                          MOVE 03      TO PPS-RTC
186400                       END-IF
186500                    END-IF
186600                 END-IF
186700              END-IF
186800           END-IF
186900        ELSE
187000           IF LOW-VOLUME-TRACK                = "Y"
187100              IF TRAINING-TRACK               = "Y"  THEN
187200                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
187300                    MOVE 26            TO PPS-RTC
187400                 ELSE
187500                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
187600                       MOVE 21         TO PPS-RTC
187700                    ELSE
187800                       MOVE 12         TO PPS-RTC
187900                    END-IF
188000                 END-IF
188100              ELSE
188200                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
188300                    MOVE 25            TO PPS-RTC
188400                 ELSE
188500                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
188600                       MOVE 20         TO PPS-RTC
188700                    ELSE
188800                       IF ONSET-TRACK         = "Y"  THEN
188900                          MOVE 32      TO PPS-RTC
189000                       ELSE
189100                          MOVE 10      TO PPS-RTC
189200                       END-IF
189300                    END-IF
189400                 END-IF
189500              END-IF
189600           ELSE
189700              IF TRAINING-TRACK               = "Y"  THEN
189800                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
189900                    MOVE 27            TO PPS-RTC
190000                 ELSE
190100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
190200                       MOVE 22         TO PPS-RTC
190300                    ELSE
190400                       MOVE 11         TO PPS-RTC
190500                    END-IF
190600                 END-IF
190700              ELSE
190800                 IF ONSET-TRACK               = "Y"  THEN
190900                    MOVE 08            TO PPS-RTC
191000                 ELSE
191100                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
191200                       MOVE 04         TO PPS-RTC
191300                    ELSE
191400                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
191500                          MOVE 05      TO PPS-RTC
191600                       ELSE
191700                          IF LOW-BMI-TRACK = "Y"  THEN
191800                             MOVE 31 TO PPS-RTC
191900                          ELSE
192000                             MOVE 02 TO PPS-RTC
192100                          END-IF
192200                       END-IF
192300                    END-IF
192400                 END-IF
192500              END-IF
192600           END-IF
192700        END-IF
192800     END-IF.
192900
193000/
193100 9100-MOVE-RESULTS.
193200     IF MOVED-CORMORBIDS = SPACES  THEN
193300        NEXT SENTENCE
193400     ELSE
193500        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
193600        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
193700        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
193800        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
193900        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
194000        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
194100        MOVE H-COMORBID-CWF-CODE       TO
194200                                    COMORBID-CWF-RETURN-CODE
194300     END-IF.
194400
194500     MOVE P-GEO-MSA                    TO PPS-MSA.
194600     MOVE P-GEO-CBSA                   TO PPS-CBSA.
194700     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
194800     MOVE B-COND-CODE                  TO PPS-COND-CODE.
194900     MOVE B-REV-CODE                   TO PPS-REV-CODE.
195000     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
195100     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
195200     MOVE BUN-NAT-NONLABOR-PCT         TO
195300                                    PPS-2011-NAT-NONLABOR-PCT.
195400     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
195500     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
195600     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
195700     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
195800     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
195900     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
196000     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
196100     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
196200     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
196300     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
196400                                    PPS-2011-BDGT-NEUT-RATE.
196500     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
196600     MOVE SPACES                       TO
196700                                    PPS-2011-COMORBID-MA-CC.
196800
196900     IF (B-COND-CODE = '74')  AND
197000        (B-REV-CODE = '0841' OR '0851')  THEN
197100         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
197200                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
197300     END-IF.
197400
197500     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
197600           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
197700              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
197800           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
197900              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
198000           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
198100              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
198200     ELSE
198300        MOVE ZERO                      TO
198400                                    PPS-2011-BLEND-COMP-RATE
198500        MOVE ZERO                      TO
198600                                    PPS-2011-BLEND-PPS-RATE
198700        MOVE ZERO                      TO
198800                                    PPS-2011-BLEND-OUTLIER-RATE
198900     END-IF.
199000
199100     MOVE H-PYMT-AMT                   TO
199200                                    PPS-2011-FULL-COMP-RATE.
199300     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
199400                                          PPS-FINAL-PAY-AMT.
199500     MOVE H-OUT-PAYMENT                TO
199600                                    PPS-2011-FULL-OUTLIER-RATE.
199700
199800     MOVE H-TDAPA-PAYMENT              TO TDAPA-RETURN.
199900
200000     IF B-COND-CODE NOT = '84' THEN
200100        IF P-QIP-REDUCTION = ' ' THEN
200200           NEXT SENTENCE
200300        ELSE
200400           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
200500                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
200600           COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
200700                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
200800           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
200900                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
201000           COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
201100                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
201200           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
201300                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
201400           COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
201500                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
201600        END-IF
201700     END-IF.
201800
201900*ESRD PC PRICER NEEDS BUNDLED-TEST-INDIC SET TO "T" IN ORDER TO BE
202000*TO PASS VALUES FOR DISPLAYING DETAILED RESULTS FROM BILL-DATA-TES
202100*BUNDLED-TEST-INDIC IS NOT SET TO "T"  IN THE PRODUCTION SYSTEM (F
202200     IF BUNDLED-TEST   THEN
202300        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
202400        MOVE 0.0                       TO MSA-WAGE-ADJ
202500        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
202600        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
202700        MOVE H-PATIENT-AGE             TO AGE-RETURN
202800        MOVE 0.0                       TO MSA-WAGE-AMT
202900        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
203000        MOVE H-BMI                     TO PPS-BMI
203100        MOVE H-BSA                     TO PPS-BSA
203200        MOVE MSA-BLEND-PCT             TO MSA-PCT
203300        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
203400
203500        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
203600           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
203700           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
203800        ELSE
203900           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
204000           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
204100        END-IF
204200
204300        MOVE H-BUN-BSA                 TO BUN-BSA
204400        MOVE H-BUN-BMI                 TO BUN-BMI
204500        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
204600        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
204700        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
204800        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
204900        MOVE H-OUT-BSA                 TO OUT-BSA
205000        MOVE SB-BSA                    TO OUT-SB-BSA
205100        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
205200        MOVE H-OUT-BMI                 TO OUT-BMI
205300        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
205400        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
205500        MOVE H-OUT-COMORBID-MULTIPLIER TO
205600                                    OUT-COMORBID-MULTIPLIER
205700        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
205800                                    OUT-PREDICTED-SERVICES-MAP
205900        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
206000                                    OUT-CASE-MIX-PREDICTED-MAP
206100        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
206200                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
206300        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
206400        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
206500        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
206600        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
206700        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
206800        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
206900        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
207000        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
207100        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
207200        MOVE CM-BSA                    TO PPS-CM-BSA
207300        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
207400        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
207500        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
207600        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
207700                                    BUN-ADJUSTED-BASE-WAGE-AMT
207800        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
207900                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
208000        MOVE TRAINING-ADD-ON-PMT-AMT   TO
208100                                    PPS-TRAINING-ADD-ON-PMT-AMT
208200        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
208300     END-IF.
208400******        L A S T   S O U R C E   S T A T E M E N T      *****
