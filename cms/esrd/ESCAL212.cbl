000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL212.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2021
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
038200* 9-04-20 ESCAL21B - For testing addition of new input and output
038300* fields added to BILLCPY listed as follows:
038400*   P-SUPP-WI-IND
038500*   P-SUPP-WI
038600*   B-PAYER-ONLY-VALUE-CODE
038700*   B-PAYER-ONLY-VC-QG-AMT
038800*   TPNIES-RETURN
038900*   NETWORK-REDUCTION-RETURN
039000*
039100* 11/05/2020 - ESCAL210 FOR PRODUCTION EFFECTIVE 1-1-21
039200* - CR 12011 Annual Update
039300* Implementation of Changes in the End-Stage Renal Disease (ESRD)
039400* Prospective Payment System (PPS) and Payment for Dialysis
039500* Furnished for Acute Kidney Injury (AKI) in ESRD Facilities
039600* Calendar Year (CY) 2021
039700*   - Changed BUNDLED-BASE-PMT-RATE  to 251.69
039800*   - Unchanged BUN-NAT-LABOR-PCT    to 0.52300
039900*   - Unchanged BUN-NAT-NONLABOR-PCT to 0.47700
040000*   - Changed ADJ-AVG-MAP-AMT-GT-17  to 50.92
040100*   - Changed ADJ-AVG-MAP-AMT-LT-18  to 30.88
040200*   - Changed FIX-DOLLAR-LOSS-GT-17  to 122.90
040300*   - Changed FIX-DOLLAR-LOSS-LT-18  to 45.06
040400*
040500*   - Set ETC-HDPA-PCT to 1.03 for FY2020
040600*
040700* Adds New Calculations for both:
040800*   - TPNIES Payment, and
040900*   - Network Reduction.
041000*
041100* 12/11/2020 - ESCAL211 FOR PRODUCTION EFFECTIVE 1-1-21
041200* - includes following changes:
041300*   - Changed BUNDLED-BASE-PMT-RATE  to 253.13
041400*   - Changed FIX-DOLLAR-LOSS-GT-17  to 122.49
041500*   - Changed FIX-DOLLAR-LOSS-LT-18  to 44.78
041600*
041700* 2/4/2021 - ESCAL212 FOR PRODUCTION EFFECTIVE 1-1-21
041800* - fixed to correctly apply the Network Fee Reduction to all ESRD
041900*   claims
042000*
042100******************************************************************
042200 DATE-COMPILED.
042300 ENVIRONMENT DIVISION.
042400 CONFIGURATION SECTION.
042500 SOURCE-COMPUTER.            IBM-Z990.
042600 OBJECT-COMPUTER.            IBM-Z990.
042700 INPUT-OUTPUT  SECTION.
042800 FILE-CONTROL.
042900
043000 DATA DIVISION.
043100 FILE SECTION.
043200/
043300 WORKING-STORAGE SECTION.
043400 01  W-STORAGE-REF                  PIC X(46) VALUE
043500     'ESCAL212      - W O R K I N G   S T O R A G E'.
043600 01  CAL-VERSION                    PIC X(05) VALUE 'C21.2'.
043700
043800 01  DISPLAY-LINE-MEASUREMENT.
043900     05  FILLER                     PIC X(50) VALUE
044000         '....:...10....:...20....:...30....:...40....:...50'.
044100     05  FILLER                     PIC X(50) VALUE
044200         '....:...60....:...70....:...80....:...90....:..100'.
044300     05  FILLER                     PIC X(20) VALUE
044400         '....:..110....:..120'.
044500
044600 01  PRINT-LINE-MEASUREMENT.
044700     05  FILLER                     PIC X(51) VALUE
044800         'X....:...10....:...20....:...30....:...40....:...50'.
044900     05  FILLER                     PIC X(50) VALUE
045000         '....:...60....:...70....:...80....:...90....:..100'.
045100     05  FILLER                     PIC X(32) VALUE
045200         '....:..110....:..120....:..130..'.
045300/
045400******************************************************************
045500*  This area contains all of the old Composite Rate variables.   *
045600* They will be eliminated when the transition period ends - 2014 *
045700******************************************************************
045800 01  HOLD-COMP-RATE-PPS-COMPONENTS.
045900     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
046000     05  H-PYMT-AMT                 PIC 9(04)V9(02).
046100     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
046200     05  H-PATIENT-AGE              PIC 9(03).
046300     05  H-AGE-FACTOR               PIC 9(01)V9(03).
046400     05  H-BSA-FACTOR               PIC 9(01)V9(04).
046500     05  H-BMI-FACTOR               PIC 9(01)V9(04).
046600     05  H-BSA                      PIC 9(03)V9(04).
046700     05  H-BMI                      PIC 9(03)V9(04).
046800     05  HGT-PART                   PIC 9(04)V9(08).
046900     05  WGT-PART                   PIC 9(04)V9(08).
047000     05  COMBINED-PART              PIC 9(04)V9(08).
047100     05  CALC-BSA                   PIC 9(04)V9(08).
047200
047300
047400* The following two variables will change from year to year
047500* and are used for the COMPOSITE part of the Bundled Pricer.
047600 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
047700 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
047800
047900* The next two percentages MUST add up to 1 (i.e. 100%)
048000* They will continue to change until CY2009 when CBSA will be 1.00
048100 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
048200 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
048300
048400* CONSTANTS AREA
048500* The next two percentages MUST add up TO 1 (i.e. 100%)
048600 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
048700 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
048800
048900*  ETC HDPA Percentage Adjustment
049000 01  ETC-HDPA-PCT                   PIC 9V99        VALUE 1.03.
049100
049200* The next variable is only applicapable for the 2011 Pricer.
049300 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
049400
049500 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
049600 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
049700 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
049800                                                         0.428571.
049900* The above number technically represents the fractional
050000* number 3/7 which is three days per week that a person can
050100* receive dialysis.  It will remain this value ONLY for the
050200* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
050300* use the calculation method which is more understandable and
050400* follows the method used by the Policy folks.
050500
050600*  The following number that is loaded into the payment equation
050700*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
050800*  and   --DOES NOT CHANGE--
050900
051000 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
051100
051200 01  COMPOSITE-RATE-MULTIPLIERS.
051300*Composite rate payment multiplier (used for blended providers)
051400     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
051500     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
051600     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
051700     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
051800     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
051900     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
052000
052100     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
052200     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
052300/
052400******************************************************************
052500*    This area contains all of the NEW Bundled Rate variables.   *
052600******************************************************************
052700 01  HOLD-BUNDLED-PPS-COMPONENTS.
052800     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
052900     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
053000     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
053100     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
053200     05  H-BUN-BSA                  PIC 9(03)V9(04).
053300     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
053400     05  H-BUN-BMI                  PIC 9(03)V9(04).
053500     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
053600     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
053700     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
053800     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
053900                                    PIC 9(07)V9(04).
054000     05  H-BUN-WAGE-ADJ-TRAINING-AMT
054100                                    PIC 9(07)V9(04).
054200     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
054300     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
054400     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
054500     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
054600     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
054700                                    PIC 9(07)V9(04).
054800     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
054900     05  H-LV-OUT-PREDICT-SERVICES-MAP
055000                                    PIC 9(07)V9(04).
055100     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
055200                                    PIC 9(07)V9(04).
055300     05  H-LV-OUT-PREDICTED-MAP
055400                                    PIC 9(07)V9(04).
055500     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
055600
055700     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
055800     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
055900         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
056000
056100     05  H-COMORBID-DATA  OCCURS 6 TIMES
056200            INDEXED BY H-COMORBID-INDEX
056300                                    PIC X(02).
056400     05  H-COMORBID-CWF-CODE        PIC X(02).
056500
056600     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
056700
056800     05  QIP-REDUCTION              PIC 9(01)V9(03).
056900     05  SUB                        PIC 9(04).
057000
057100     05  THE-DATE                   PIC 9(08).
057200     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
057300     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
057400     05  ONSET-DATE                 PIC 9(08).
057500     05  MOVED-CORMORBIDS           PIC X(01).
057600     05  H-BUN-RURAL-MULTIPLIER     PIC 9(01)V9(03).
057700     05  H-TDAPA-PAYMENT            PIC 9(07)V9(04).
057800     05  H-TPNIES-PAYMENT           PIC 9(07)V9(04).
057900     05  H-NETWORK-REDUCTION        PIC 9(01)V9(02).
058000     05  H-PER-DIEM-AMT-WITHOUT-HDPA PIC 9(07)V9(04).
058100     05  H-PER-DIEM-AMT-WITH-HDPA   PIC 9(07)V9(04).
058200     05  H-FINAL-AMT-WITHOUT-HDPA   PIC 9(07)V9(02).
058300     05  H-FINAL-AMT-WITH-HDPA      PIC 9(07)V9(02).
058400
058500 01  HOLD-OUTLIER-PPS-COMPONENTS.
058600     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
058700     05  H-OUT-BSA                  PIC 9(03)V9(04).
058800     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
058900     05  H-OUT-BMI                  PIC 9(03)V9(04).
059000     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
059100     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
059200     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
059300     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
059400     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
059500     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
059600     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
059700     05  H-OUT-PREDICTED-SERVICES-MAP
059800                                    PIC 9(07)V9(04).
059900     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
060000     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
060100                                    PIC 9(07)V9(04).
060200     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
060300     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
060400     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
060500     05  H-OUT-RURAL-MULTIPLIER     PIC 9(01)V9(03).
060600
060700* The following variable will change from year to year and is
060800* used for the BUNDLED part of the Bundled Pricer.
060900 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 253.13.
061000
061100* The next two percentages MUST add up to 1 (i.e. 100%)
061200* They start in 2011 and will continue to change until CY2014 when
061300* BUN-CBSA-BLEND-PCT will be 1.00
061400* The third blend percent is for those providers that waived the
061500* blended percent and went to full PPS.  This variable will be
061600* eliminated in 2014 when it is no longer needed.
061700 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
061800 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
061900 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
062000
062100* CONSTANTS AREA
062200* The next two percentages MUST add up TO 1 (i.e. 100%)
062300 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.52300.
062400 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.47700.
062500 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 95.60.
062600
062700*  The following number that is loaded into the payment equation
062800*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
062900*  and   --DOES NOT CHANGE--
063000 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
063100
063200* Added a constant to hold the BSA-National-Average that is used
063300* in the BSA Calculation. This value changes every five years.
063400 01 BSA-NATIONAL-AVERAGE            PIC 9(01)V9(02) VALUE 1.90.
063500
063600 01  PEDIATRIC-MULTIPLIERS.
063700*Separately billable payment multiplier (used for outliers)
063800     05  PED-SEP-BILL-PAY-MULTI.
063900         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.410.
064000         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.406.
064100         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.569.
064200         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.494.
064300     05  PED-EXPAND-BUNDLE-PAY-MULTI.
064400*Expanded bundle payment multiplier (used for normal billing)
064500         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.063.
064600         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.306.
064700         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.102.
064800         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.327.
064900
065000 01  ADULT-MULTIPLIERS.
065100*Separately billable payment multiplier (used for outliers)
065200     05  SEP-BILLABLE-PAYMANT-MULTI.
065300         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 1.044.
065400         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 1.000.
065500         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.005.
065600         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
065700         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.961.
065800         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.000.
065900         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.090.
066000         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.409.
066100         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.209.
066200*        10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
066300         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.426.
066400         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.999.
066500         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.494.
066600*        10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
066700         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.955.
066800         10 SB-RURAL               PIC 9(01)V9(03) VALUE 0.978.
066900*Case-Mix adjusted payment multiplier (used for normal billing)
067000     05  CASE-MIX-PAYMENT-MULTI.
067100         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.257.
067200         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.068.
067300         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.070.
067400         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
067500         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.109.
067600         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.032.
067700         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.017.
067800         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.327.
067900         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.040.
068000*        10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
068100         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.082.
068200         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.192.
068300         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.095.
068400*        10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
068500         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.239.
068600         10 CM-RURAL               PIC 9(01)V9(03) VALUE 1.008.
068700
068800 01  OUTLIER-SB-CALC-AMOUNTS.
068900     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE  30.88.
069000     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE  50.92.
069100     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE  44.78.
069200     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 122.49.
069300     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE   0.80.
069400     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE   0.80.
069500/
069600******************************************************************
069700*    This area contains return code variables and their codes.   *
069800******************************************************************
069900 01 PAID-RETURN-CODE-TRACKERS.
070000     05  OUTLIER-TRACK              PIC X(01).
070100     05  ACUTE-COMORBID-TRACK       PIC X(01).
070200     05  CHRONIC-COMORBID-TRACK     PIC X(01).
070300     05  ONSET-TRACK                PIC X(01).
070400     05  LOW-VOLUME-TRACK           PIC X(01).
070500     05  TRAINING-TRACK             PIC X(01).
070600     05  PEDIATRIC-TRACK            PIC X(01).
070700     05  LOW-BMI-TRACK              PIC X(01).
070800 COPY RTCCPY.
070900*COPY "RTCCPY.CPY".
071000*                                                                *
071100*  Legal combinations of adjustments for ADULTS are:             *
071200*     if NO ONSET applies, then they can have any combination of:*
071300*       acute OR chronic comorbid, & outlier, low vol., training.*
071400*     if ONSET applies, then they can have:                      *
071500*           outlier and/or low volume.                           *
071600*  Legal combinations of adjustments for PEDIATRIC are:          *
071700*     outlier and/or training.                                   *
071800*                                                                *
071900*  Illegal combinations of adjustments for PEDIATRIC are:        *
072000*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
072100*     onset     with comorbid or training.                       *
072200*  Illegal combinations of adjustments for ANYONE are:           *
072300*     acute comorbid AND chronic comorbid.                       *
072400/
072500 LINKAGE SECTION.
072600 COPY BILLCPY.
072700*COPY "BILLCPY.CPY".
072800/
072900 COPY WAGECPY.
073000*COPY "WAGECPY.CPY".
073100/
073200 PROCEDURE DIVISION  USING BILL-NEW-DATA
073300                           PPS-DATA-ALL
073400                           WAGE-NEW-RATE-RECORD
073500                           COM-CBSA-WAGE-RECORD
073600                           BUN-CBSA-WAGE-RECORD.
073700
073800******************************************************************
073900* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
074000* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
074100* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
074200* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
074300* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
074400* UTILIZED HERE HAS BEEN APPROVED BY THE DIVISION OF             *
074500* INSTITUTIONAL CLAIMS PROCESSING (DICP).                        *
074600*                                                                *
074700*    PROCESSING:                                                 *
074800*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
074900*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
075000*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
075100*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
075200*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
075300*           GOBACK.                                              *
075400*        D. ASSEMBLE PRICING COMPONENTS.                         *
075500*        E. CALCULATE THE PRICE.                                 *
075600******************************************************************
075700
075800 0000-START-TO-FINISH.
075900     INITIALIZE PPS-DATA-ALL.
076000
076100* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
076200     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
076300
076400
076500* ESRD PC PRICER USES NEXT FOUR LINES TO INITIALIZE VALUES
076600* THAT IT NEEDS TO DISPLAY DETAILED RESULTS
076700     IF BUNDLED-TEST THEN
076800        INITIALIZE BILL-DATA-TEST
076900        INITIALIZE COND-CD-73
077000     END-IF.
077100
077200     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
077300     MOVE ZEROS                        TO PPS-RTC.
077400
077500     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
077600
077700     IF PPS-RTC = 00  THEN
077800        PERFORM 1200-INITIALIZATION
077900        IF B-COND-CODE  = '84' THEN
078000* Calculate payment for AKI claim
078100           MOVE H-BUN-BASE-WAGE-AMT TO
078200                H-PPS-FINAL-PAY-AMT
078300           MOVE '02' TO PPS-RTC
078400           MOVE '10' TO PPS-2011-COMORBID-PAY
078500        ELSE
078600* Calculate payment for ESRD claim
078700            PERFORM 2000-CALCULATE-BUNDLED-FACTORS
078800            PERFORM 9000-SET-RETURN-CODE
078900        END-IF
079000        PERFORM 9100-MOVE-RESULTS
079100     END-IF.
079200
079300     GOBACK.
079400/
079500 1000-VALIDATE-BILL-ELEMENTS.
079600     IF PPS-RTC = 00  THEN
079700        IF B-COND-CODE NOT = '73' AND '74' AND '84' AND
079800                             '87' AND '  '
079900           MOVE 58                  TO PPS-RTC
080000        END-IF
080100     END-IF.
080200
080300     IF PPS-RTC = 00  THEN
080400        IF  P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
080500           NEXT SENTENCE
080600        ELSE
080700           MOVE 52                        TO PPS-RTC
080800        END-IF
080900     END-IF.
081000
081100     IF PPS-RTC = 00  THEN
081200        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
081300           MOVE 53                     TO PPS-RTC
081400        END-IF
081500     END-IF.
081600
081700     IF PPS-RTC = 00  THEN
081800        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
081900           MOVE 54                     TO PPS-RTC
082000        END-IF
082100     END-IF.
082200
082300     IF PPS-RTC = 00  THEN
082400        IF B-COND-CODE NOT = '84' THEN
082500           IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
082600              MOVE 55                     TO PPS-RTC
082700           END-IF
082800        END-IF
082900     END-IF.
083000
083100     IF PPS-RTC = 00  THEN
083200        IF B-COND-CODE NOT = '84' THEN
083300           IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
083400              MOVE 56                     TO PPS-RTC
083500           END-IF
083600        END-IF
083700     END-IF.
083800
083900     IF PPS-RTC = 00  THEN
084000        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
084100                                OR '0881'
084200           NEXT SENTENCE
084300        ELSE
084400           MOVE 57                     TO PPS-RTC
084500        END-IF
084600     END-IF.
084700
084800     IF PPS-RTC = 00  THEN
084900        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
085000                                 ' '  THEN
085100           MOVE 53                     TO PPS-RTC
085200*  This RTC is for the Special Payment Indicator not = '1' or
085300*  blank, which closely approximates the intent of the edit check.
085400*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
085500        END-IF
085600     END-IF.
085700
085800     IF PPS-RTC = 00  THEN
085900        IF B-COND-CODE NOT = '84' THEN
086000           IF B-PATIENT-HGT > 300.00
086100              MOVE 71                     TO PPS-RTC
086200           END-IF
086300        END-IF
086400     END-IF.
086500
086600     IF PPS-RTC = 00  THEN
086700        IF B-COND-CODE NOT = '84' THEN
086800           IF B-PATIENT-WGT > 500.00  THEN
086900              MOVE 72                     TO PPS-RTC
087000           END-IF
087100        END-IF
087200     END-IF.
087300
087400* Before 2012 pricer, put in edit check to make sure that the
087500* # of sesions does not exceed the # of days in a month.  Maybe
087600* the # of cays in a month minus one when patient goes into a
087700* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
087800* or 0851)).  If done, then will need extra RTC.
087900     IF PPS-RTC = 00  THEN
088000        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
088100           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
088200           MOVE 73                     TO PPS-RTC
088300        END-IF
088400     END-IF.
088500
088600     IF PPS-RTC = 00  THEN
088700        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
088800           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
088900           MOVE 74                     TO PPS-RTC
089000        END-IF
089100     END-IF.
089200
089300     IF PPS-RTC = 00  THEN
089400        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
089500           MOVE 75                     TO PPS-RTC
089600        END-IF
089700     END-IF.
089800
089900     IF PPS-RTC = 00  THEN
090000        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
090100           MOVE 76                     TO PPS-RTC
090200        END-IF
090300     END-IF.
090400*OLD WAY OF VALIDATING COMORBIDS
090500*    IF PPS-RTC = 00  THEN
090600*       IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
090700*           VALID-COMORBID-CWF-RETURN-CD       THEN
090800*          NEXT SENTENCE
090900*       ELSE
091000*          MOVE 81                     TO PPS-RTC
091100*      END-IF
091200*    END-IF.
091300*
091400*CY2016 - DROP PNEUMONIA & MONOCLONAL GAMM COMORBIDS
091500
091600     IF PPS-RTC = 00  THEN
091700        IF B-COND-CODE NOT = '84' THEN
091800           IF COMORBID-CWF-RETURN-CODE = SPACES OR
091900               "10" OR "20" OR "40" OR "50" OR "60" THEN
092000              NEXT SENTENCE
092100           ELSE
092200              MOVE 81                     TO PPS-RTC
092300           END-IF
092400        END-IF
092500     END-IF.
092600/
092700 1200-INITIALIZATION.
092800     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
092900     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
093000     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
093100     INITIALIZE PAID-RETURN-CODE-TRACKERS.
093200
093300
093400******************************************************************
093500***Calculate BUNDLED Wage Adjusted Rate                        ***
093600******************************************************************
093700     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
093800        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
093900         BUN-CBSA-W-INDEX.
094000
094100     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
094200        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
094300
094400     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
094500        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
094600/
094700 2000-CALCULATE-BUNDLED-FACTORS.
094800
094900     COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
095000     IF B-DOB-MM > B-THRU-MM  THEN
095100        COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
095200     END-IF
095300     IF H-PATIENT-AGE < 18  THEN
095400        MOVE "Y"                    TO PEDIATRIC-TRACK
095500     END-IF.
095600
095700     MOVE SPACES                       TO MOVED-CORMORBIDS.
095800
095900     IF P-QIP-REDUCTION = ' '  THEN
096000* no reduction
096100        MOVE 1.000 TO QIP-REDUCTION
096200     ELSE
096300        IF P-QIP-REDUCTION = '1'  THEN
096400* one-half percent reduction
096500           MOVE 0.995 TO QIP-REDUCTION
096600        ELSE
096700           IF P-QIP-REDUCTION = '2'  THEN
096800* one percent reduction
096900              MOVE 0.990 TO QIP-REDUCTION
097000           ELSE
097100              IF P-QIP-REDUCTION = '3'  THEN
097200* one and one-half percent reduction
097300                 MOVE 0.985 TO QIP-REDUCTION
097400              ELSE
097500* two percent reduction
097600                 MOVE 0.980 TO QIP-REDUCTION
097700              END-IF
097800           END-IF
097900        END-IF
098000     END-IF.
098100
098200*    Since pricer has to pay a comorbid condition according to the
098300* return code that CWF passes back, it is cleaner if the pricer
098400* sets aside whatever comorbid data exists on the line-item when
098500* it comes into the pricer and then transferrs the CWF code to
098600* the appropriate place in the comorbid data.  This avoids
098700* making convoluted changes in the other parts of the program
098800* which has to look at both original comorbid data AND CWF return
098900* codes to handle comorbids.  Near the end of the program where
099000* variables are transferred to the output, the original comorbid
099100* data is put back into its original place as though nothing
099200* occurred.
099300*CY2016 DROPPED MB & MF
099400     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
099500        NEXT SENTENCE
099600     ELSE
099700        MOVE 'Y'                       TO MOVED-CORMORBIDS
099800        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
099900        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
100000        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
100100        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
100200        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
100300        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
100400        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
100500        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
100600           MOVE SPACES                 TO COMORBID-DATA (1)
100700                                          COMORBID-DATA (2)
100800                                          COMORBID-DATA (3)
100900                                          COMORBID-DATA (4)
101000                                          COMORBID-DATA (5)
101100                                          COMORBID-DATA (6)
101200                                          COMORBID-CWF-RETURN-CODE
101300        ELSE
101400           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
101500              MOVE 'MA'                TO COMORBID-DATA (1)
101600              MOVE SPACES              TO COMORBID-DATA (2)
101700                                          COMORBID-DATA (3)
101800                                          COMORBID-DATA (4)
101900                                          COMORBID-DATA (5)
102000                                          COMORBID-DATA (6)
102100                                          COMORBID-CWF-RETURN-CODE
102200           ELSE
102300*             IF COMORBID-CWF-RETURN-CODE = '30'  THEN
102400*                MOVE SPACES           TO COMORBID-DATA (1)
102500*                MOVE 'MB'             TO COMORBID-DATA (2)
102600*                MOVE SPACES           TO COMORBID-DATA (3)
102700*                MOVE SPACES           TO COMORBID-DATA (4)
102800*                MOVE SPACES           TO COMORBID-DATA (5)
102900*                MOVE SPACES           TO COMORBID-DATA (6)
103000*                                         COMORBID-CWF-RETURN-CODE
103100*             ELSE
103200                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
103300                    MOVE SPACES        TO COMORBID-DATA (1)
103400                    MOVE SPACES        TO COMORBID-DATA (2)
103500                    MOVE 'MC'          TO COMORBID-DATA (3)
103600                    MOVE SPACES        TO COMORBID-DATA (4)
103700                    MOVE SPACES        TO COMORBID-DATA (5)
103800                    MOVE SPACES        TO COMORBID-DATA (6)
103900                                          COMORBID-CWF-RETURN-CODE
104000                 ELSE
104100                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
104200                       MOVE SPACES     TO COMORBID-DATA (1)
104300                       MOVE SPACES     TO COMORBID-DATA (2)
104400                       MOVE SPACES     TO COMORBID-DATA (3)
104500                       MOVE 'MD'       TO COMORBID-DATA (4)
104600                       MOVE SPACES     TO COMORBID-DATA (5)
104700                       MOVE SPACES     TO COMORBID-DATA (6)
104800                                          COMORBID-CWF-RETURN-CODE
104900                    ELSE
105000                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
105100                          MOVE SPACES  TO COMORBID-DATA (1)
105200                          MOVE SPACES  TO COMORBID-DATA (2)
105300                          MOVE SPACES  TO COMORBID-DATA (3)
105400                          MOVE SPACES  TO COMORBID-DATA (4)
105500                          MOVE 'ME'    TO COMORBID-DATA (5)
105600                          MOVE SPACES  TO COMORBID-DATA (6)
105700                                          COMORBID-CWF-RETURN-CODE
105800*                      ELSE
105900*                         MOVE SPACES  TO COMORBID-DATA (1)
106000*                                         COMORBID-DATA (2)
106100*                                         COMORBID-DATA (3)
106200*                                         COMORBID-DATA (4)
106300*                                         COMORBID-DATA (5)
106400*                                         COMORBID-CWF-RETURN-CODE
106500*                         MOVE 'MF'    TO COMORBID-DATA (6)
106600                       END-IF
106700                    END-IF
106800                 END-IF
106900*             END-IF
107000           END-IF
107100        END-IF
107200     END-IF.
107300******************************************************************
107400***  Set BUNDLED age adjustment factor                         ***
107500******************************************************************
107600     IF H-PATIENT-AGE < 13  THEN
107700        IF B-REV-CODE = '0821' OR '0881' THEN
107800           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
107900        ELSE
108000           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
108100        END-IF
108200     ELSE
108300        IF H-PATIENT-AGE < 18 THEN
108400           IF B-REV-CODE = '0821' OR '0881' THEN
108500              MOVE EB-AGE-13-17-HEMO-MODE
108600                                       TO H-BUN-AGE-FACTOR
108700           ELSE
108800              MOVE EB-AGE-13-17-PD-MODE
108900                                       TO H-BUN-AGE-FACTOR
109000           END-IF
109100        ELSE
109200           IF H-PATIENT-AGE < 45  THEN
109300              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
109400           ELSE
109500              IF H-PATIENT-AGE < 60  THEN
109600                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
109700              ELSE
109800                 IF H-PATIENT-AGE < 70  THEN
109900                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
110000                 ELSE
110100                    IF H-PATIENT-AGE < 80  THEN
110200                       MOVE CM-AGE-70-79
110300                                       TO H-BUN-AGE-FACTOR
110400                    ELSE
110500                       MOVE CM-AGE-80-PLUS
110600                                       TO H-BUN-AGE-FACTOR
110700                    END-IF
110800                 END-IF
110900              END-IF
111000           END-IF
111100        END-IF
111200     END-IF.
111300
111400******************************************************************
111500***  Calculate BUNDLED BSA factor (note NEW formula)           ***
111600******************************************************************
111700     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
111800         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
111900
112000     IF H-PATIENT-AGE > 17  THEN
112100        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
112200*            CM-BSA ** ((H-BUN-BSA - 1.90) / .1)
112300             CM-BSA ** ((H-BUN-BSA - BSA-NATIONAL-AVERAGE) / .1)
112400     ELSE
112500        MOVE 1.000                     TO H-BUN-BSA-FACTOR
112600     END-IF.
112700
112800******************************************************************
112900***  Calculate BUNDLED BMI factor                              ***
113000******************************************************************
113100     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
113200         (B-PATIENT-HGT ** 2)) * 10000.
113300
113400     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
113500        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
113600        MOVE "Y"                       TO LOW-BMI-TRACK
113700     ELSE
113800        MOVE 1.000                     TO H-BUN-BMI-FACTOR
113900     END-IF.
114000
114100******************************************************************
114200***  Calculate BUNDLED ONSET factor                            ***
114300******************************************************************
114400     IF B-DIALYSIS-START-DATE > ZERO  THEN
114500        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
114600        COMPUTE INTEGER-LINE-ITEM-DATE =
114700            FUNCTION INTEGER-OF-DATE(THE-DATE)
114800        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
114900        COMPUTE INTEGER-DIALYSIS-DATE  =
115000            FUNCTION INTEGER-OF-DATE(THE-DATE)
115100* Need to add one to onset-date because the start date should
115200* be included in the count of days.  fix made 9/6/2011
115300        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
115400                              INTEGER-DIALYSIS-DATE) + 1
115500        IF H-PATIENT-AGE > 17  THEN
115600           IF ONSET-DATE > 120  THEN
115700              MOVE 1                   TO H-BUN-ONSET-FACTOR
115800           ELSE
115900              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
116000              MOVE "Y"                 TO ONSET-TRACK
116100           END-IF
116200        ELSE
116300           MOVE 1                      TO H-BUN-ONSET-FACTOR
116400        END-IF
116500     ELSE
116600        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
116700     END-IF.
116800
116900******************************************************************
117000***  Set BUNDLED Co-morbidities adjustment                     ***
117100******************************************************************
117200     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
117300        IF H-PATIENT-AGE  <  18  THEN
117400           MOVE 1.000                  TO
117500                                       H-BUN-COMORBID-MULTIPLIER
117600           MOVE '10'                   TO PPS-2011-COMORBID-PAY
117700        ELSE
117800           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
117900              MOVE 1.000               TO
118000                                       H-BUN-COMORBID-MULTIPLIER
118100              MOVE '10'                TO PPS-2011-COMORBID-PAY
118200           ELSE
118300              PERFORM 2100-CALC-COMORBID-ADJUST
118400              MOVE H-COMORBID-MULTIPLIER TO
118500                                       H-BUN-COMORBID-MULTIPLIER
118600           END-IF
118700        END-IF
118800     ELSE
118900        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
119000           MOVE 1.000                  TO
119100                                       H-BUN-COMORBID-MULTIPLIER
119200           MOVE '10'                   TO PPS-2011-COMORBID-PAY
119300        ELSE
119400           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
119500              MOVE CM-GI-BLEED         TO
119600                                       H-BUN-COMORBID-MULTIPLIER
119700              MOVE '20'                TO PPS-2011-COMORBID-PAY
119800           ELSE
119900*            IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
120000*                MOVE CM-PNEUMONIA     TO
120100*                                      H-BUN-COMORBID-MULTIPLIER
120200*                MOVE '30'             TO PPS-2011-COMORBID-PAY
120300*            ELSE
120400                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
120500                    MOVE CM-PERICARDITIS TO
120600                                       H-BUN-COMORBID-MULTIPLIER
120700                    MOVE '40'          TO PPS-2011-COMORBID-PAY
120800                 END-IF
120900*            END-IF
121000           END-IF
121100        END-IF
121200     END-IF.
121300
121400******************************************************************
121500***  Calculate BUNDLED Low Volume adjustment                   ***
121600******************************************************************
121700     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
121800        IF H-PATIENT-AGE > 17  THEN
121900           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
122000                                       H-BUN-LOW-VOL-MULTIPLIER
122100           MOVE "Y"                    TO  LOW-VOLUME-TRACK
122200        ELSE
122300           MOVE 1.000                  TO
122400                                       H-BUN-LOW-VOL-MULTIPLIER
122500        END-IF
122600     ELSE
122700        MOVE 1.000                     TO
122800                                       H-BUN-LOW-VOL-MULTIPLIER
122900     END-IF.
123000
123100***************************************************************
123200* Calculate Rural Adjustment Multiplier ADDED CY 2016
123300***************************************************************
123400     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
123500        MOVE CM-RURAL TO H-BUN-RURAL-MULTIPLIER
123600     ELSE
123700        MOVE 1.000 TO H-BUN-RURAL-MULTIPLIER.
123800
123900******************************************************************
124000***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
124100******************************************************************
124200     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
124300        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
124400        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
124500        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
124600        H-BUN-LOW-VOL-MULTIPLIER * H-BUN-RURAL-MULTIPLIER.
124700
124800******************************************************************
124900***  Calculate BUNDLED Condition Code payment                  ***
125000******************************************************************
125100* Self-care in Training add-on
125200     IF B-COND-CODE = '73' OR '87' THEN
125300* no add-on when onset is present
125400        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
125500           MOVE ZERO TO H-BUN-WAGE-ADJ-TRAINING-AMT
125600        ELSE
125700* use new PPS training add-on amount times wage-index
125800           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT ROUNDED  =
125900             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
126000           MOVE "Y" TO TRAINING-TRACK
126100        END-IF
126200     ELSE
126300* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
126400        IF (B-COND-CODE = '74')  AND
126500           (B-REV-CODE = '0841' OR '0851')  THEN
126600*             COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
126700*                (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
126800* ESCAL201 for ETC HDPA Bonus - changed code to calculate payment
126900* of both With and Without Bonus at the same time
127000              COMPUTE H-PER-DIEM-AMT-WITHOUT-HDPA ROUNDED =
127100                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
127200              COMPUTE H-PER-DIEM-AMT-WITH-HDPA ROUNDED =
127300                 ((H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7) *
127400                         ETC-HDPA-PCT
127500        ELSE
127600           MOVE ZERO                   TO
127700                                    H-BUN-WAGE-ADJ-TRAINING-AMT
127800*                                   H-CC-74-PER-DIEM-AMT
127900                                    H-PER-DIEM-AMT-WITHOUT-HDPA
128000                                    H-PER-DIEM-AMT-WITH-HDPA
128100        END-IF
128200     END-IF.
128300
128400******************************************************************
128500***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
128600******************************************************************
128700     IF (B-COND-CODE = '74')  AND
128800        (B-REV-CODE = '0841' OR '0851')  THEN
128900*                          H-CC-74-PER-DIEM-AMT
129000           COMPUTE H-FINAL-AMT-WITHOUT-HDPA ROUNDED  =
129100                                    H-PER-DIEM-AMT-WITHOUT-HDPA
129200           COMPUTE H-FINAL-AMT-WITH-HDPA ROUNDED  =
129300                                    H-PER-DIEM-AMT-WITH-HDPA
129400
129500           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
129600              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
129700              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
129800*    ELSE COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
129900*                 H-BUN-ADJUSTED-BASE-WAGE-AMT  +
130000*                 H-BUN-WAGE-ADJ-TRAINING-AMT
130100     ELSE COMPUTE H-FINAL-AMT-WITHOUT-HDPA ROUNDED  =
130200                  H-BUN-ADJUSTED-BASE-WAGE-AMT  +
130300                  H-BUN-WAGE-ADJ-TRAINING-AMT
130400          COMPUTE H-FINAL-AMT-WITH-HDPA ROUNDED  =
130500                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * ETC-HDPA-PCT) +
130600                  H-BUN-WAGE-ADJ-TRAINING-AMT
130700     END-IF.
130800
130900****************************************************************
131000***  Compute TDAPA Payment                                   ***
131100****************************************************************
131200     COMPUTE H-TDAPA-PAYMENT = B-PAYER-ONLY-VC-Q8 /
131300                               B-CLAIM-NUM-DIALYSIS-SESSIONS.
131400
131500****************************************************************
131600***  Compute TPNIES Payment                                  ***
131700****************************************************************
131800     IF B-PAYER-ONLY-VC-QG-AMT NUMERIC
131900     COMPUTE H-TPNIES-PAYMENT =
132000          (0.65 * B-PAYER-ONLY-VC-QG-AMT) /
132100           B-CLAIM-NUM-DIALYSIS-SESSIONS.
132200
132300
132400****************************************************************
132500***  Compute AMOUNT With and Without HDPA but no QIP yet     ***
132600****************************************************************
132700     COMPUTE H-FINAL-AMT-WITHOUT-HDPA = H-FINAL-AMT-WITHOUT-HDPA +
132800                                        H-TDAPA-PAYMENT +
132900                                        H-TPNIES-PAYMENT.
133000     COMPUTE H-FINAL-AMT-WITH-HDPA = H-FINAL-AMT-WITH-HDPA +
133100                                     H-TDAPA-PAYMENT +
133200                                     H-TPNIES-PAYMENT.
133300
133400     IF B-DATA-CODE = '94'
133500     THEN MOVE H-FINAL-AMT-WITH-HDPA TO H-PPS-FINAL-PAY-AMT
133600     ELSE MOVE H-FINAL-AMT-WITHOUT-HDPA TO H-PPS-FINAL-PAY-AMT
133700     END-IF.
133800
133900
134000****************************************************************
134100* Determine Network Fee Reduction for ESRD Claim
134200* BR11871.2
134300* $.21 for per-diem PPS
134400* $.50 for full PPS
134500****************************************************************
134600
134700     IF ((B-COND-CODE = '74') AND
134800         (B-REV-CODE = '0841' OR '0851'))
134900     THEN MOVE 0.21 TO H-NETWORK-REDUCTION
135000     ELSE MOVE 0.50 TO H-NETWORK-REDUCTION.
135100
135200******************************************************************
135300***  Calculate BUNDLED Outlier                                 ***
135400******************************************************************
135500     PERFORM 2500-CALC-OUTLIER-FACTORS.
135600
135700******************************************************************
135800***  Calculate Low Volume payment for recovery purposes        ***
135900******************************************************************
136000     IF LOW-VOLUME-TRACK = "Y"  THEN
136100        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
136200        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
136300
136400        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
136500           H-PPS-FINAL-PAY-AMT
136600
136700        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
136800           H-OUT-PAYMENT
136900
137000        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
137100           H-LV-OUT-PAYMENT
137200
137300        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
137400           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
137500              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
137600        ELSE
137700           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
137800        END-IF
137900     END-IF.
138000
138100
138200/
138300 2100-CALC-COMORBID-ADJUST.
138400******************************************************************
138500***  Calculate Co-morbidities adjustment                       ***
138600******************************************************************
138700*  This logic assumes that the comorbids are randomly assigned   *
138800*to the comorbid table.  It will select the highest comorbid for *
138900*payment if one is found.  CY 2016 DROPPED MB & MF              *
139000******************************************************************
139100     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
139200     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
139300     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
139400
139500     PERFORM VARYING  SUB  FROM  1 BY 1
139600       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
139700         IF COMORBID-DATA (SUB) = 'MA'  THEN
139800           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
139900*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
140000           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
140100           MOVE '20'                   TO PPS-2011-COMORBID-PAY
140200         ELSE
140300*          IF COMORBID-DATA (SUB) = 'MB'  THEN
140400*            IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
140500*              MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
140600*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
140700*              MOVE '30'               TO PPS-2011-COMORBID-PAY
140800*            END-IF
140900*          ELSE
141000             IF COMORBID-DATA (SUB) = 'MC'  THEN
141100                IF CM-PERICARDITIS  >
141200                                      H-COMORBID-MULTIPLIER  THEN
141300                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
141400                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
141500                  MOVE '40'            TO PPS-2011-COMORBID-PAY
141600                END-IF
141700             ELSE
141800               IF COMORBID-DATA (SUB) = 'MD'  THEN
141900                 IF CM-MYELODYSPLASTIC  >
142000                                      H-COMORBID-MULTIPLIER  THEN
142100                   MOVE CM-MYELODYSPLASTIC  TO
142200                                      H-COMORBID-MULTIPLIER
142300                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
142400                   MOVE '50'           TO PPS-2011-COMORBID-PAY
142500                 END-IF
142600               ELSE
142700                 IF COMORBID-DATA (SUB) = 'ME'  THEN
142800                   IF CM-SICKEL-CELL  >
142900                                      H-COMORBID-MULTIPLIER  THEN
143000                     MOVE CM-SICKEL-CELL  TO
143100                                      H-COMORBID-MULTIPLIER
143200                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
143300                     MOVE '60'         TO PPS-2011-COMORBID-PAY
143400                   END-IF
143500*                ELSE
143600*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
143700*                    IF CM-MONOCLONAL-GAMM  >
143800*                                     H-COMORBID-MULTIPLIER  THEN
143900*                      MOVE CM-MONOCLONAL-GAMM TO
144000*                                     H-COMORBID-MULTIPLIER
144100*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
144200*                      MOVE '70'       TO PPS-2011-COMORBID-PAY
144300*                    END-IF
144400*                  END-IF
144500                 END-IF
144600               END-IF
144700             END-IF
144800*          END-IF
144900         END-IF
145000     END-PERFORM.
145100/
145200 2500-CALC-OUTLIER-FACTORS.
145300******************************************************************
145400***  Set separately billable OUTLIER age adjustment factor     ***
145500******************************************************************
145600     IF H-PATIENT-AGE < 13  THEN
145700        IF B-REV-CODE = '0821' OR '0881' THEN
145800           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
145900        ELSE
146000           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
146100        END-IF
146200     ELSE
146300        IF H-PATIENT-AGE < 18 THEN
146400           IF B-REV-CODE = '0821' OR '0881'  THEN
146500              MOVE SB-AGE-13-17-HEMO-MODE
146600                                       TO H-OUT-AGE-FACTOR
146700           ELSE
146800              MOVE SB-AGE-13-17-PD-MODE
146900                                       TO H-OUT-AGE-FACTOR
147000           END-IF
147100        ELSE
147200           IF H-PATIENT-AGE < 45  THEN
147300              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
147400           ELSE
147500              IF H-PATIENT-AGE < 60  THEN
147600                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
147700              ELSE
147800                 IF H-PATIENT-AGE < 70  THEN
147900                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
148000                 ELSE
148100                    IF H-PATIENT-AGE < 80  THEN
148200                       MOVE SB-AGE-70-79
148300                                       TO H-OUT-AGE-FACTOR
148400                    ELSE
148500                       MOVE SB-AGE-80-PLUS
148600                                       TO H-OUT-AGE-FACTOR
148700                    END-IF
148800                 END-IF
148900              END-IF
149000           END-IF
149100        END-IF
149200     END-IF.
149300
149400******************************************************************
149500**Calculate separately billable OUTLIER BSA factor (superscript)**
149600******************************************************************
149700     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
149800         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
149900
150000     IF H-PATIENT-AGE > 17  THEN
150100        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
150200*            SB-BSA ** ((H-OUT-BSA - 1.90) / .1)
150300             SB-BSA ** ((H-OUT-BSA - BSA-NATIONAL-AVERAGE) / .1)
150400     ELSE
150500        MOVE 1.000                     TO H-OUT-BSA-FACTOR
150600     END-IF.
150700
150800******************************************************************
150900***  Calculate separately billable OUTLIER BMI factor          ***
151000******************************************************************
151100     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
151200         (B-PATIENT-HGT ** 2)) * 10000.
151300
151400     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
151500        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
151600     ELSE
151700        MOVE 1.000                     TO H-OUT-BMI-FACTOR
151800     END-IF.
151900
152000******************************************************************
152100***  Calculate separately billable OUTLIER ONSET factor        ***
152200******************************************************************
152300     IF B-DIALYSIS-START-DATE > ZERO  THEN
152400        IF H-PATIENT-AGE > 17  THEN
152500           IF ONSET-DATE > 120  THEN
152600              MOVE 1                   TO H-OUT-ONSET-FACTOR
152700           ELSE
152800              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
152900           END-IF
153000        ELSE
153100           MOVE 1                      TO H-OUT-ONSET-FACTOR
153200        END-IF
153300     ELSE
153400        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
153500     END-IF.
153600
153700******************************************************************
153800***  Set separately billable OUTLIER Co-morbidities adjustment ***
153900* CY 2016 DROPPED MB & MF
154000******************************************************************
154100     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
154200        IF H-PATIENT-AGE  <  18  THEN
154300           MOVE 1.000                  TO
154400                                       H-OUT-COMORBID-MULTIPLIER
154500           MOVE '10'                   TO PPS-2011-COMORBID-PAY
154600        ELSE
154700           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
154800              MOVE 1.000               TO
154900                                       H-OUT-COMORBID-MULTIPLIER
155000              MOVE '10'                TO PPS-2011-COMORBID-PAY
155100           ELSE
155200              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
155300           END-IF
155400        END-IF
155500     ELSE
155600        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
155700           MOVE 1.000                  TO
155800                                       H-OUT-COMORBID-MULTIPLIER
155900        ELSE
156000           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
156100              MOVE SB-GI-BLEED         TO
156200                                       H-OUT-COMORBID-MULTIPLIER
156300           ELSE
156400*             IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
156500*                MOVE SB-PNEUMONIA     TO
156600*                                      H-OUT-COMORBID-MULTIPLIER
156700*             ELSE
156800                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
156900                    MOVE SB-PERICARDITIS TO
157000                                       H-OUT-COMORBID-MULTIPLIER
157100                 END-IF
157200*             END-IF
157300           END-IF
157400        END-IF
157500     END-IF.
157600
157700******************************************************************
157800***  Set OUTLIER low-volume-multiplier                         ***
157900******************************************************************
158000     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
158100        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
158200     ELSE
158300        IF H-PATIENT-AGE < 18  THEN
158400           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
158500        ELSE
158600           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
158700           MOVE "Y"                    TO LOW-VOLUME-TRACK
158800        END-IF
158900     END-IF.
159000
159100***************************************************************
159200* Calculate OUTLIER Rural Adjustment multiplier
159300***************************************************************
159400
159500     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
159600        MOVE SB-RURAL TO H-OUT-RURAL-MULTIPLIER
159700     ELSE
159800        MOVE 1.000 TO H-OUT-RURAL-MULTIPLIER.
159900
160000******************************************************************
160100***  Calculate predicted OUTLIER services MAP per treatment    ***
160200******************************************************************
160300     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
160400        (H-OUT-AGE-FACTOR             *
160500         H-OUT-BSA-FACTOR             *
160600         H-OUT-BMI-FACTOR             *
160700         H-OUT-ONSET-FACTOR           *
160800         H-OUT-COMORBID-MULTIPLIER    *
160900         H-OUT-RURAL-MULTIPLIER       *
161000         H-OUT-LOW-VOL-MULTIPLIER).
161100
161200******************************************************************
161300***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
161400******************************************************************
161500     IF H-PATIENT-AGE < 18  THEN
161600        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
161700           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
161800        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
161900     ELSE
162000
162100        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
162200           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
162300        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
162400     END-IF.
162500
162600******************************************************************
162700*** Calculate imputed OUTLIER services MAP amount per treatment***
162800******************************************************************
162900     IF (B-COND-CODE = '74')  AND
163000        (B-REV-CODE = '0841' OR '0851')  THEN
163100         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
163200            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
163300         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
163400         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
163500     ELSE
163600        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
163700        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
163800     END-IF.
163900
164000******************************************************************
164100*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
164200******************************************************************
164300     IF H-PATIENT-AGE < 18   THEN
164400        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
164500           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
164600        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
164700        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
164800           COMPUTE H-OUT-PAYMENT  ROUNDED  =
164900            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
165000                                         LOSS-SHARING-PCT-LT-18
165100           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
165200           MOVE "Y"                    TO OUTLIER-TRACK
165300        ELSE
165400           MOVE ZERO                   TO H-OUT-PAYMENT
165500           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
165600        END-IF
165700     ELSE
165800        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
165900           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
166000           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
166100        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
166200           COMPUTE H-OUT-PAYMENT  ROUNDED  =
166300            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
166400                                         LOSS-SHARING-PCT-GT-17
166500           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
166600           MOVE "Y"                    TO OUTLIER-TRACK
166700        ELSE
166800           MOVE ZERO                   TO H-OUT-PAYMENT
166900        END-IF
167000     END-IF.
167100
167200     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
167300
167400* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
167500     IF (B-COND-CODE = '74')  AND
167600        (B-REV-CODE = '0841' OR '0851')  THEN
167700           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
167800             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
167900     END-IF.
168000/
168100 2600-CALC-COMORBID-OUT-ADJUST.
168200******************************************************************
168300***  Calculate OUTLIER Co-morbidities adjustment               ***
168400******************************************************************
168500*  This logic assumes that the comorbids are randomly assigned   *
168600*to the comorbid table.  It will select the highest comorbid for *
168700*payment if one is found. CY 2016 DROPPED MB & MF                *
168800******************************************************************
168900
169000     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
169100     MOVE 1.000                        TO
169200                                  H-OUT-COMORBID-MULTIPLIER.
169300
169400     PERFORM VARYING  SUB  FROM  1 BY 1
169500       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
169600         IF COMORBID-DATA (SUB) = 'MA'  THEN
169700           MOVE SB-GI-BLEED            TO
169800                                  H-OUT-COMORBID-MULTIPLIER
169900*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
170000           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
170100         ELSE
170200*          IF COMORBID-DATA (SUB) = 'MB'  THEN
170300*            IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
170400*              MOVE SB-PNEUMONIA       TO
170500*                                 H-OUT-COMORBID-MULTIPLIER
170600*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
170700*            END-IF
170800*          ELSE
170900             IF COMORBID-DATA (SUB) = 'MC'  THEN
171000                IF SB-PERICARDITIS  >
171100                                  H-OUT-COMORBID-MULTIPLIER  THEN
171200                  MOVE SB-PERICARDITIS TO
171300                                  H-OUT-COMORBID-MULTIPLIER
171400                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
171500                END-IF
171600             ELSE
171700               IF COMORBID-DATA (SUB) = 'MD'  THEN
171800                 IF SB-MYELODYSPLASTIC  >
171900                                  H-OUT-COMORBID-MULTIPLIER  THEN
172000                   MOVE SB-MYELODYSPLASTIC  TO
172100                                  H-OUT-COMORBID-MULTIPLIER
172200                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
172300                 END-IF
172400               ELSE
172500                 IF COMORBID-DATA (SUB) = 'ME'  THEN
172600                   IF SB-SICKEL-CELL  >
172700                                 H-OUT-COMORBID-MULTIPLIER  THEN
172800                     MOVE SB-SICKEL-CELL  TO
172900                                  H-OUT-COMORBID-MULTIPLIER
173000                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
173100                   END-IF
173200*                ELSE
173300*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
173400*                    IF SB-MONOCLONAL-GAMM  >
173500*                                 H-OUT-COMORBID-MULTIPLIER  THEN
173600*                      MOVE SB-MONOCLONAL-GAMM  TO
173700*                                 H-OUT-COMORBID-MULTIPLIER
173800*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
173900*                    END-IF
174000*                  END-IF
174100                 END-IF
174200               END-IF
174300             END-IF
174400*          END-IF
174500         END-IF
174600     END-PERFORM.
174700/
174800******************************************************************
174900*** Calculate Low Volume Full PPS payment for recovery purposes***
175000******************************************************************
175100 3000-LOW-VOL-FULL-PPS-PAYMENT.
175200******************************************************************
175300** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
175400     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
175500        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
175600        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
175700        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
175800         H-BUN-RURAL-MULTIPLIER.
175900
176000******************************************************************
176100**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
176200* Self-care in Training add-on
176300     IF B-COND-CODE = '73' OR '87' THEN
176400* no add-on when onset is present
176500        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
176600           MOVE ZERO                   TO
176700                                    H-BUN-WAGE-ADJ-TRAINING-AMT
176800        ELSE
176900* use new PPS training add-on amount times wage-index
177000           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
177100             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
177200           MOVE "Y"                    TO TRAINING-TRACK
177300        END-IF
177400     ELSE
177500* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
177600        IF (B-COND-CODE = '74')  AND
177700           (B-REV-CODE = '0841' OR '0851')  THEN
177800              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
177900                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
178000        ELSE
178100           MOVE ZERO                   TO
178200                                    H-BUN-WAGE-ADJ-TRAINING-AMT
178300                                    H-CC-74-PER-DIEM-AMT
178400        END-IF
178500     END-IF.
178600
178700******************************************************************
178800**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
178900     IF (B-COND-CODE = '74')  AND
179000        (B-REV-CODE = '0841' OR '0851')  THEN
179100           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
179200                           H-CC-74-PER-DIEM-AMT
179300     ELSE
179400        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
179500                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
179600                H-BUN-WAGE-ADJ-TRAINING-AMT
179700     END-IF.
179800
179900
180000******************************************************************
180100*** Calculate Low Volume OUT PPS payment for recovery purposes ***
180200******************************************************************
180300 3100-LOW-VOL-OUT-PPS-PAYMENT.
180400******************************************************************
180500**Modified code from 'Calc predict OUT serv MAP per treat' para.**
180600     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
180700        (H-OUT-AGE-FACTOR             *
180800         H-OUT-BSA-FACTOR             *
180900         H-OUT-BMI-FACTOR             *
181000         H-OUT-ONSET-FACTOR           *
181100         H-OUT-COMORBID-MULTIPLIER    *
181200         H-OUT-RURAL-MULTIPLIER).
181300
181400******************************************************************
181500**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
181600     IF H-PATIENT-AGE < 18  THEN
181700        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
181800           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
181900        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
182000     ELSE
182100        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
182200           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
182300        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
182400     END-IF.
182500
182600******************************************************************
182700** 'Calculate imput OUT services MAP amount per treatment' para **
182800** It is not necessary to modify or insert this paragraph here. **
182900
183000******************************************************************
183100**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
183200     IF H-PATIENT-AGE < 18   THEN
183300        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
183400           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
183500        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
183600        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
183700           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
183800            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
183900                                         LOSS-SHARING-PCT-LT-18
184000           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
184100        ELSE
184200           MOVE ZERO                   TO H-LV-OUT-PAYMENT
184300           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
184400        END-IF
184500     ELSE
184600        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
184700           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
184800           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
184900        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
185000           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
185100            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
185200                                         LOSS-SHARING-PCT-GT-17
185300           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
185400        ELSE
185500           MOVE ZERO                   TO H-LV-OUT-PAYMENT
185600        END-IF
185700     END-IF.
185800
185900     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
186000
186100* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
186200     IF (B-COND-CODE = '74')  AND
186300        (B-REV-CODE = '0841' OR '0851')  THEN
186400           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
186500             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
186600     END-IF.
186700
186800
186900/
187000 9000-SET-RETURN-CODE.
187100******************************************************************
187200***  Set the return code                                       ***
187300******************************************************************
187400*   The following 'table' helps in understanding and in making   *
187500*changes to the rather large and complex "IF" statement that     *
187600*follows.  This 'table' just reorders and rewords the comments   *
187700*contained in the working storage area concerning the paid       *
187800*return-codes.                                                   *
187900*                                                                *
188000*  17 = pediatric, outlier, training                             *
188100*  16 = pediatric, outlier                                       *
188200*  15 = pediatric, training                                      *
188300*  14 = pediatric                                                *
188400*                                                                *
188500*  24 = outlier, low volume, training, chronic comorbid          *
188600*  19 = outlier, low volume, training, acute comorbid            *
188700*  29 = outlier, low volume, training                            *
188800*  23 = outlier, low volume, chronic comorbid                    *
188900*  18 = outlier, low volume, acute comorbid                      *
189000*  30 = outlier, low volume, onset                               *
189100*  28 = outlier, low volume                                      *
189200*  34 = outlier, training, chronic comorbid                      *
189300*  35 = outlier, training, acute comorbid                        *
189400*  33 = outlier, training                                        *
189500*  07 = outlier, chronic comorbid                                *
189600*  06 = outlier, acute comorbid                                  *
189700*  09 = outlier, onset                                           *
189800*  03 = outlier                                                  *
189900*                                                                *
190000*  26 = low volume, training, chronic comorbid                   *
190100*  21 = low volume, training, acute comorbid                     *
190200*  12 = low volume, training                                     *
190300*  25 = low volume, chronic comorbid                             *
190400*  20 = low volume, acute comorbid                               *
190500*  32 = low volume, onset                                        *
190600*  10 = low volume                                               *
190700*                                                                *
190800*  27 = training, chronic comorbid                               *
190900*  22 = training, acute comorbid                                 *
191000*  11 = training                                                 *
191100*                                                                *
191200*  08 = onset                                                    *
191300*  04 = acute comorbid                                           *
191400*  05 = chronic comorbid                                         *
191500*  31 = low BMI                                                  *
191600*  02 = no adjustments                                           *
191700*                                                                *
191800*  13 = w/multiple adjustments....reserved for future use        *
191900******************************************************************
192000/
192100     IF PEDIATRIC-TRACK                       = "Y"  THEN
192200        IF OUTLIER-TRACK                      = "Y"  THEN
192300           IF TRAINING-TRACK                  = "Y"  THEN
192400              MOVE 17                  TO PPS-RTC
192500           ELSE
192600              MOVE 16                  TO PPS-RTC
192700           END-IF
192800        ELSE
192900           IF TRAINING-TRACK                  = "Y"  THEN
193000              MOVE 15                  TO PPS-RTC
193100           ELSE
193200              MOVE 14                  TO PPS-RTC
193300           END-IF
193400        END-IF
193500     ELSE
193600        IF OUTLIER-TRACK                      = "Y"  THEN
193700           IF LOW-VOLUME-TRACK                = "Y"  THEN
193800              IF TRAINING-TRACK               = "Y"  THEN
193900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
194000                    MOVE 24            TO PPS-RTC
194100                 ELSE
194200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
194300                       MOVE 19         TO PPS-RTC
194400                    ELSE
194500                       MOVE 29         TO PPS-RTC
194600                    END-IF
194700                 END-IF
194800              ELSE
194900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
195000                    MOVE 23            TO PPS-RTC
195100                 ELSE
195200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
195300                       MOVE 18         TO PPS-RTC
195400                    ELSE
195500                       IF ONSET-TRACK         = "Y"  THEN
195600                          MOVE 30      TO PPS-RTC
195700                       ELSE
195800                          MOVE 28      TO PPS-RTC
195900                       END-IF
196000                    END-IF
196100                 END-IF
196200              END-IF
196300           ELSE
196400              IF TRAINING-TRACK               = "Y"  THEN
196500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
196600                    MOVE 34            TO PPS-RTC
196700                 ELSE
196800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
196900                       MOVE 35         TO PPS-RTC
197000                    ELSE
197100                       MOVE 33         TO PPS-RTC
197200                    END-IF
197300                 END-IF
197400              ELSE
197500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
197600                    MOVE 07            TO PPS-RTC
197700                 ELSE
197800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
197900                       MOVE 06         TO PPS-RTC
198000                    ELSE
198100                       IF ONSET-TRACK         = "Y"  THEN
198200                          MOVE 09      TO PPS-RTC
198300                       ELSE
198400                          MOVE 03      TO PPS-RTC
198500                       END-IF
198600                    END-IF
198700                 END-IF
198800              END-IF
198900           END-IF
199000        ELSE
199100           IF LOW-VOLUME-TRACK                = "Y"
199200              IF TRAINING-TRACK               = "Y"  THEN
199300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
199400                    MOVE 26            TO PPS-RTC
199500                 ELSE
199600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
199700                       MOVE 21         TO PPS-RTC
199800                    ELSE
199900                       MOVE 12         TO PPS-RTC
200000                    END-IF
200100                 END-IF
200200              ELSE
200300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
200400                    MOVE 25            TO PPS-RTC
200500                 ELSE
200600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
200700                       MOVE 20         TO PPS-RTC
200800                    ELSE
200900                       IF ONSET-TRACK         = "Y"  THEN
201000                          MOVE 32      TO PPS-RTC
201100                       ELSE
201200                          MOVE 10      TO PPS-RTC
201300                       END-IF
201400                    END-IF
201500                 END-IF
201600              END-IF
201700           ELSE
201800              IF TRAINING-TRACK               = "Y"  THEN
201900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
202000                    MOVE 27            TO PPS-RTC
202100                 ELSE
202200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
202300                       MOVE 22         TO PPS-RTC
202400                    ELSE
202500                       MOVE 11         TO PPS-RTC
202600                    END-IF
202700                 END-IF
202800              ELSE
202900                 IF ONSET-TRACK               = "Y"  THEN
203000                    MOVE 08            TO PPS-RTC
203100                 ELSE
203200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
203300                       MOVE 04         TO PPS-RTC
203400                    ELSE
203500                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
203600                          MOVE 05      TO PPS-RTC
203700                       ELSE
203800                          IF LOW-BMI-TRACK = "Y"  THEN
203900                             MOVE 31 TO PPS-RTC
204000                          ELSE
204100                             MOVE 02 TO PPS-RTC
204200                          END-IF
204300                       END-IF
204400                    END-IF
204500                 END-IF
204600              END-IF
204700           END-IF
204800        END-IF
204900     END-IF.
205000
205100/
205200 9100-MOVE-RESULTS.
205300     IF MOVED-CORMORBIDS = SPACES  THEN
205400        NEXT SENTENCE
205500     ELSE
205600        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
205700        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
205800        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
205900        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
206000        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
206100        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
206200        MOVE H-COMORBID-CWF-CODE       TO
206300                                    COMORBID-CWF-RETURN-CODE
206400     END-IF.
206500
206600     MOVE P-GEO-MSA                    TO PPS-MSA.
206700     MOVE P-GEO-CBSA                   TO PPS-CBSA.
206800     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
206900     MOVE B-COND-CODE                  TO PPS-COND-CODE.
207000     MOVE B-REV-CODE                   TO PPS-REV-CODE.
207100     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
207200     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
207300     MOVE BUN-NAT-NONLABOR-PCT         TO
207400                                    PPS-2011-NAT-NONLABOR-PCT.
207500     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
207600     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
207700     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
207800     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
207900     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
208000     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
208100     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
208200     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
208300     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
208400     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
208500                                    PPS-2011-BDGT-NEUT-RATE.
208600     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
208700     MOVE SPACES                       TO
208800                                    PPS-2011-COMORBID-MA-CC.
208900
209000     IF (B-COND-CODE = '74')  AND
209100        (B-REV-CODE = '0841' OR '0851')  THEN
209200         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
209300                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
209400     END-IF.
209500
209600     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
209700           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
209800              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
209900           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
210000              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
210100           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
210200              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
210300     ELSE
210400        MOVE ZERO                      TO
210500                                    PPS-2011-BLEND-COMP-RATE
210600        MOVE ZERO                      TO
210700                                    PPS-2011-BLEND-PPS-RATE
210800        MOVE ZERO                      TO
210900                                    PPS-2011-BLEND-OUTLIER-RATE
211000     END-IF.
211100
211200     MOVE H-PYMT-AMT                   TO
211300                                    PPS-2011-FULL-COMP-RATE.
211400
211500     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
211600                                          PPS-FINAL-PAY-AMT.
211700
211800     MOVE H-OUT-PAYMENT                TO
211900                                    PPS-2011-FULL-OUTLIER-RATE.
212000
212100     MOVE H-TDAPA-PAYMENT              TO TDAPA-RETURN.
212200
212300     MOVE H-TPNIES-PAYMENT             TO TPNIES-RETURN.
212400
212500     MOVE H-NETWORK-REDUCTION          TO
212600                                    NETWORK-REDUCTION-RETURN.
212700
212800****************************************************************
212900***  QIP Reduction                                           ***
213000****************************************************************
213100
213200*  NOTE:  B-COND-CODE 84 IS AKI AND DOESN'T GET QIP REDUCTION
213300     IF B-COND-CODE NOT = '84'
213400     THEN
213500       IF P-QIP-REDUCTION = ' '
213600       THEN CONTINUE
213700       ELSE
213800* OLD BLEND CODE - NEED TO CONSIDER REMOVING
213900         COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
214000                 PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
214100         COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
214200                 PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
214300         COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
214400                 PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
214500         COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
214600                 PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
214700
214800
214900         COMPUTE H-FINAL-AMT-WITHOUT-HDPA    ROUNDED =
215000                 H-FINAL-AMT-WITHOUT-HDPA    *  QIP-REDUCTION
215100         COMPUTE H-FINAL-AMT-WITH-HDPA       ROUNDED =
215200                 H-FINAL-AMT-WITH-HDPA       *  QIP-REDUCTION
215300
215400         COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
215500                 PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
215600
215700       END-IF
215800     END-IF.
215900
216000********************************************************
216100* NEW FOR VERSION 21.0: APPLY THE NETWORK REDUCTION ***
216200********************************************************
216300
216400     COMPUTE H-FINAL-AMT-WITHOUT-HDPA ROUNDED =
216500              H-FINAL-AMT-WITHOUT-HDPA - H-NETWORK-REDUCTION.
216600     COMPUTE H-FINAL-AMT-WITH-HDPA ROUNDED =
216700              H-FINAL-AMT-WITH-HDPA - H-NETWORK-REDUCTION.
216800
216900********************************************************
217000* NEW FOR VERSION 20.1 - APPLY THE HDPA-ETC ADJUSTMENT *
217100********************************************************
217200
217300* do not apply this adjustment to AKI claims
217400     IF B-COND-CODE NOT = '84'
217500     THEN
217600       IF B-DATA-CODE = '94'
217700       THEN
217800         MOVE H-FINAL-AMT-WITH-HDPA TO PPS-2011-FULL-PPS-RATE
217900         MOVE H-FINAL-AMT-WITHOUT-HDPA TO
218000                          ADJ-BASE-WAGE-BEFORE-ETC-HDPA
218100       ELSE
218200         MOVE H-FINAL-AMT-WITHOUT-HDPA TO
218300                          PPS-2011-FULL-PPS-RATE
218400         MOVE ZERO TO ADJ-BASE-WAGE-BEFORE-ETC-HDPA
218500       END-IF
218600     END-IF.
218700
218800*ESRD PC PRICER NEEDS BUNDLED-TEST-INDIC SET TO "T" IN ORDER TO BE
218900*TO PASS VALUES FOR DISPLAYING DETAILED RESULTS FROM BILL-DATA-TES
219000*BUNDLED-TEST-INDIC IS NOT SET TO "T"  IN THE PRODUCTION SYSTEM (F
219100     IF BUNDLED-TEST   THEN
219200        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
219300        MOVE 0.0                       TO MSA-WAGE-ADJ
219400        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
219500        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
219600        MOVE H-PATIENT-AGE             TO AGE-RETURN
219700        MOVE 0.0                       TO MSA-WAGE-AMT
219800        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
219900        MOVE H-BMI                     TO PPS-BMI
220000        MOVE H-BSA                     TO PPS-BSA
220100        MOVE MSA-BLEND-PCT             TO MSA-PCT
220200        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
220300
220400        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
220500           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
220600           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
220700        ELSE
220800           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
220900           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
221000        END-IF
221100
221200        MOVE H-BUN-BSA                 TO BUN-BSA
221300        MOVE H-BUN-BMI                 TO BUN-BMI
221400        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
221500        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
221600        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
221700        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
221800        MOVE H-OUT-BSA                 TO OUT-BSA
221900        MOVE SB-BSA                    TO OUT-SB-BSA
222000        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
222100        MOVE H-OUT-BMI                 TO OUT-BMI
222200        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
222300        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
222400        MOVE H-OUT-COMORBID-MULTIPLIER TO
222500                                    OUT-COMORBID-MULTIPLIER
222600        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
222700                                    OUT-PREDICTED-SERVICES-MAP
222800        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
222900                                    OUT-CASE-MIX-PREDICTED-MAP
223000        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
223100                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
223200        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
223300        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
223400        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
223500        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
223600        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
223700        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
223800        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
223900        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
224000        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
224100        MOVE CM-BSA                    TO PPS-CM-BSA
224200        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
224300        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
224400        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
224500        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
224600                                    BUN-ADJUSTED-BASE-WAGE-AMT
224700        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
224800                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
224900        MOVE TRAINING-ADD-ON-PMT-AMT   TO
225000                                    PPS-TRAINING-ADD-ON-PMT-AMT
225100        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
225200     END-IF.
225300******        L A S T   S O U R C E   S T A T E M E N T      *****
