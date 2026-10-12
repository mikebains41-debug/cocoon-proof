000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL160.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2016
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
029200******************************************************************
029300 DATE-COMPILED.
029400 ENVIRONMENT DIVISION.
029500 CONFIGURATION SECTION.
029600 SOURCE-COMPUTER.            IBM-Z990.
029700 OBJECT-COMPUTER.            IBM-Z990.
029800 INPUT-OUTPUT  SECTION.
029900 FILE-CONTROL.
030000
030100 DATA DIVISION.
030200 FILE SECTION.
030300/
030400 WORKING-STORAGE SECTION.
030500 01  W-STORAGE-REF                  PIC X(46) VALUE
030600     'ESCAL160      - W O R K I N G   S T O R A G E'.
030700 01  CAL-VERSION                    PIC X(05) VALUE 'C16.0'.
030800
030900 01  DISPLAY-LINE-MEASUREMENT.
031000     05  FILLER                     PIC X(50) VALUE
031100         '....:...10....:...20....:...30....:...40....:...50'.
031200     05  FILLER                     PIC X(50) VALUE
031300         '....:...60....:...70....:...80....:...90....:..100'.
031400     05  FILLER                     PIC X(20) VALUE
031500         '....:..110....:..120'.
031600
031700 01  PRINT-LINE-MEASUREMENT.
031800     05  FILLER                     PIC X(51) VALUE
031900         'X....:...10....:...20....:...30....:...40....:...50'.
032000     05  FILLER                     PIC X(50) VALUE
032100         '....:...60....:...70....:...80....:...90....:..100'.
032200     05  FILLER                     PIC X(32) VALUE
032300         '....:..110....:..120....:..130..'.
032400/
032500******************************************************************
032600*  This area contains all of the old Composite Rate variables.   *
032700* They will be eliminated when the transition period ends - 2014 *
032800******************************************************************
032900 01  HOLD-COMP-RATE-PPS-COMPONENTS.
033000     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
033100     05  H-PYMT-AMT                 PIC 9(04)V9(02).
033200     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
033300     05  H-PATIENT-AGE              PIC 9(03).
033400     05  H-AGE-FACTOR               PIC 9(01)V9(03).
033500     05  H-BSA-FACTOR               PIC 9(01)V9(04).
033600     05  H-BMI-FACTOR               PIC 9(01)V9(04).
033700     05  H-BSA                      PIC 9(03)V9(04).
033800     05  H-BMI                      PIC 9(03)V9(04).
033900     05  HGT-PART                   PIC 9(04)V9(08).
034000     05  WGT-PART                   PIC 9(04)V9(08).
034100     05  COMBINED-PART              PIC 9(04)V9(08).
034200     05  CALC-BSA                   PIC 9(04)V9(08).
034300
034400
034500* The following two variables will change from year to year
034600* and are used for the COMPOSITE part of the Bundled Pricer.
034700 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
034800 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
034900
035000* The next two percentages MUST add up to 1 (i.e. 100%)
035100* They will continue to change until CY2009 when CBSA will be 1.00
035200 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
035300 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
035400
035500* CONSTANTS AREA
035600* The next two percentages MUST add up TO 1 (i.e. 100%)
035700 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
035800 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
035900
036000* The next variable is only applicapable for the 2011 Pricer.
036100 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
036200
036300 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
036400 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
036500 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
036600                                                         0.428571.
036700* The above number technically represents the fractional
036800* number 3/7 which is three days per week that a person can
036900* receive dialysis.  It will remain this value ONLY for the
037000* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
037100* use the calculation method which is more understandable and
037200* follows the method used by the Policy folks.
037300
037400*  The following number that is loaded into the payment equation
037500*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
037600*  and   --DOES NOT CHANGE--
037700
037800 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
037900
038000 01  COMPOSITE-RATE-MULTIPLIERS.
038100*Composite rate payment multiplier (used for blended providers)
038200     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
038300     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
038400     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
038500     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
038600     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
038700     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
038800
038900     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
039000     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
039100/
039200******************************************************************
039300*    This area contains all of the NEW Bundled Rate variables.   *
039400******************************************************************
039500 01  HOLD-BUNDLED-PPS-COMPONENTS.
039600     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
039700     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
039800     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
039900     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
040000     05  H-BUN-BSA                  PIC 9(03)V9(04).
040100     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
040200     05  H-BUN-BMI                  PIC 9(03)V9(04).
040300     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
040400     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
040500     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
040600     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
040700                                    PIC 9(07)V9(04).
040800     05  H-BUN-WAGE-ADJ-TRAINING-AMT
040900                                    PIC 9(07)V9(04).
041000     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
041100     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
041200     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
041300     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
041400     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
041500                                    PIC 9(07)V9(04).
041600     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
041700     05  H-LV-OUT-PREDICT-SERVICES-MAP
041800                                    PIC 9(07)V9(04).
041900     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
042000                                    PIC 9(07)V9(04).
042100     05  H-LV-OUT-PREDICTED-MAP
042200                                    PIC 9(07)V9(04).
042300     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
042400
042500     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
042600     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
042700         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
042800
042900     05  H-COMORBID-DATA  OCCURS 6 TIMES
043000            INDEXED BY H-COMORBID-INDEX
043100                                    PIC X(02).
043200     05  H-COMORBID-CWF-CODE        PIC X(02).
043300
043400     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
043500
043600     05  QIP-REDUCTION              PIC 9(01)V9(03).
043700     05  SUB                        PIC 9(04).
043800
043900     05  THE-DATE                   PIC 9(08).
044000     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
044100     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
044200     05  ONSET-DATE                 PIC 9(08).
044300     05  MOVED-CORMORBIDS           PIC X(01).
044400     05  H-BUN-RURAL-MULTIPLIER     PIC 9(01)V9(03).
044500
044600 01  HOLD-OUTLIER-PPS-COMPONENTS.
044700     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
044800     05  H-OUT-BSA                  PIC 9(03)V9(04).
044900     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
045000     05  H-OUT-BMI                  PIC 9(03)V9(04).
045100     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
045200     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
045300     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
045400     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
045500     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
045600     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
045700     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
045800     05  H-OUT-PREDICTED-SERVICES-MAP
045900                                    PIC 9(07)V9(04).
046000     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
046100     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
046200                                    PIC 9(07)V9(04).
046300     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
046400     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
046500     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
046600     05  H-OUT-RURAL-MULTIPLIER     PIC 9(01)V9(03).
046700
046800* The following variable will change from year to year and is
046900* used for the BUNDLED part of the Bundled Pricer.
047000 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 230.39.
047100
047200* The next two percentages MUST add up to 1 (i.e. 100%)
047300* They start in 2011 and will continue to change until CY2014 when
047400* BUN-CBSA-BLEND-PCT will be 1.00
047500* The third blend percent is for those providers that waived the
047600* blended percent and went to full PPS.  This variable will be
047700* eliminated in 2014 when it is no longer needed.
047800 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
047900 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
048000 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
048100
048200* CONSTANTS AREA
048300* The next two percentages MUST add up TO 1 (i.e. 100%)
048400 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.50673.
048500 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.49327.
048600 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 50.16.
048700
048800*  The following number that is loaded into the payment equation
048900*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
049000*  and   --DOES NOT CHANGE--
049100
049200 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
049300
049400 01  PEDIATRIC-MULTIPLIERS.
049500*Separately billable payment multiplier (used for outliers)
049600     05  PED-SEP-BILL-PAY-MULTI.
049700         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.410.
049800         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.406.
049900         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.569.
050000         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.494.
050100     05  PED-EXPAND-BUNDLE-PAY-MULTI.
050200*Expanded bundle payment multiplier (used for normal billing)
050300         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.063.
050400         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.306.
050500         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.102.
050600         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.327.
050700
050800 01  ADULT-MULTIPLIERS.
050900*Separately billable payment multiplier (used for outliers)
051000     05  SEP-BILLABLE-PAYMANT-MULTI.
051100         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 1.044.
051200         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 1.000.
051300         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.005.
051400         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
051500         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.961.
051600         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.000.
051700         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.090.
051800         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.409.
051900         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.209.
052000*        10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
052100         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.426.
052200         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.999.
052300         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.494.
052400*        10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
052500         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.955.
052600         10 SB-RURAL               PIC 9(01)V9(03) VALUE 0.978.
052700*Case-Mix adjusted payment multiplier (used for normal billing)
052800     05  CASE-MIX-PAYMENT-MULTI.
052900         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.257.
053000         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.068.
053100         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.070.
053200         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.000.
053300         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.109.
053400         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.032.
053500         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.017.
053600         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.327.
053700         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.040.
053800*        10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
053900         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.082.
054000         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.192.
054100         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.095.
054200*        10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
054300         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.239.
054400         10 CM-RURAL               PIC 9(01)V9(03) VALUE 1.008.
054500
054600 01  OUTLIER-SB-CALC-AMOUNTS.
054700     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 39.20.
054800     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 50.81.
054900     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 62.19.
055000     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 86.97.
055100     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
055200     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
055300/
055400******************************************************************
055500*    This area contains return code variables and their codes.   *
055600******************************************************************
055700 01 PAID-RETURN-CODE-TRACKERS.
055800     05  OUTLIER-TRACK              PIC X(01).
055900     05  ACUTE-COMORBID-TRACK       PIC X(01).
056000     05  CHRONIC-COMORBID-TRACK     PIC X(01).
056100     05  ONSET-TRACK                PIC X(01).
056200     05  LOW-VOLUME-TRACK           PIC X(01).
056300     05  TRAINING-TRACK             PIC X(01).
056400     05  PEDIATRIC-TRACK            PIC X(01).
056500     05  LOW-BMI-TRACK              PIC X(01).
056600 COPY RTCCPY.
056700*COPY "RTCCPY.CPY".
056800*                                                                *
056900*  Legal combinations of adjustments for ADULTS are:             *
057000*     if NO ONSET applies, then they can have any combination of:*
057100*       acute OR chronic comorbid, & outlier, low vol., training.*
057200*     if ONSET applies, then they can have:                      *
057300*           outlier and/or low volume.                           *
057400*  Legal combinations of adjustments for PEDIATRIC are:          *
057500*     outlier and/or training.                                   *
057600*                                                                *
057700*  Illegal combinations of adjustments for PEDIATRIC are:        *
057800*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
057900*     onset     with comorbid or training.                       *
058000*  Illegal combinations of adjustments for ANYONE are:           *
058100*     acute comorbid AND chronic comorbid.                       *
058200/
058300 LINKAGE SECTION.
058400 COPY BILLCPY.
058500*COPY "BILLCPY.CPY".
058600/
058700 COPY WAGECPY.
058800*COPY "WAGECPY.CPY".
058900/
059000 PROCEDURE DIVISION  USING BILL-NEW-DATA
059100                           PPS-DATA-ALL
059200                           WAGE-NEW-RATE-RECORD
059300                           COM-CBSA-WAGE-RECORD
059400                           BUN-CBSA-WAGE-RECORD.
059500
059600******************************************************************
059700* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
059800* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
059900* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
060000* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
060100* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
060200* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
060300* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
060400* PROCESSING (DICP).                                             *
060500*                                                                *
060600*                                                                *
060700*    PROCESSING:                                                 *
060800*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
060900*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
061000*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
061100*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
061200*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
061300*           GOBACK.                                              *
061400*        D. ASSEMBLE PRICING COMPONENTS.                         *
061500*        E. CALCULATE THE PRICE.                                 *
061600******************************************************************
061700
061800 0000-START-TO-FINISH.
061900     INITIALIZE PPS-DATA-ALL.
062000
062100* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
062200     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
062300
062400     IF BUNDLED-TEST THEN
062500        INITIALIZE BILL-DATA-TEST
062600        INITIALIZE COND-CD-73
062700     END-IF.
062800     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
062900     MOVE ZEROS                        TO PPS-RTC.
063000
063100     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
063200
063300     IF PPS-RTC = 00  THEN
063400        PERFORM 1200-INITIALIZATION
063500**Calculate patient age
063600        COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
063700        IF B-DOB-MM > B-THRU-MM  THEN
063800           COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
063900        END-IF
064000        IF H-PATIENT-AGE < 18  THEN
064100           MOVE "Y"                    TO PEDIATRIC-TRACK
064200        END-IF
064300        PERFORM 2000-CALCULATE-BUNDLED-FACTORS
064400        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
064500           PERFORM 5000-CALC-COMP-RATE-FACTORS
064600        END-IF
064700        PERFORM 9000-SET-RETURN-CODE
064800        PERFORM 9100-MOVE-RESULTS
064900     END-IF.
065000
065100     GOBACK.
065200/
065300 1000-VALIDATE-BILL-ELEMENTS.
065400     IF P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
065500        NEXT SENTENCE
065600     ELSE
065700        MOVE 52                        TO PPS-RTC
065800     END-IF.
065900
066000     IF PPS-RTC = 00  THEN
066100        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
066200           MOVE 53                     TO PPS-RTC
066300        END-IF
066400     END-IF.
066500
066600     IF PPS-RTC = 00  THEN
066700        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
066800           MOVE 54                     TO PPS-RTC
066900        END-IF
067000     END-IF.
067100
067200     IF PPS-RTC = 00  THEN
067300        IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
067400           MOVE 55                     TO PPS-RTC
067500        END-IF
067600     END-IF.
067700
067800     IF PPS-RTC = 00  THEN
067900        IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
068000           MOVE 56                     TO PPS-RTC
068100        END-IF
068200     END-IF.
068300
068400     IF PPS-RTC = 00  THEN
068500        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
068600                                OR '0881'
068700           NEXT SENTENCE
068800        ELSE
068900           MOVE 57                     TO PPS-RTC
069000        END-IF
069100     END-IF.
069200
069300     IF PPS-RTC = 00  THEN
069400        IF B-COND-CODE NOT = '73' AND '74' AND '  '
069500           MOVE 58                     TO PPS-RTC
069600        END-IF
069700     END-IF.
069800
069900     IF PPS-RTC = 00  THEN
070000        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
070100                                 ' '  THEN
070200           MOVE 53                     TO PPS-RTC
070300*  This RTC is for the Special Payment Indicator not = '1' or
070400*  blank, which closely approximates the intent of the edit check.
070500*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
070600        END-IF
070700     END-IF.
070800
070900     IF PPS-RTC = 00  THEN
071000        IF B-PATIENT-HGT > 300.00
071100           MOVE 71                     TO PPS-RTC
071200        END-IF
071300     END-IF.
071400
071500     IF PPS-RTC = 00  THEN
071600        IF B-PATIENT-WGT > 500.00  THEN
071700           MOVE 72                     TO PPS-RTC
071800        END-IF
071900     END-IF.
072000
072100* Before 2012 pricer, put in edit check to make sure that the
072200* # of sesions does not exceed the # of days in a month.  Maybe
072300* the # of cays in a month minus one when patient goes into a
072400* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
072500* or 0851)).  If done, then will need extra RTC.
072600     IF PPS-RTC = 00  THEN
072700        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
072800           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
072900           MOVE 73                     TO PPS-RTC
073000        END-IF
073100     END-IF.
073200
073300     IF PPS-RTC = 00  THEN
073400        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
073500           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
073600           MOVE 74                     TO PPS-RTC
073700        END-IF
073800     END-IF.
073900
074000     IF PPS-RTC = 00  THEN
074100        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
074200           MOVE 75                     TO PPS-RTC
074300        END-IF
074400     END-IF.
074500
074600     IF PPS-RTC = 00  THEN
074700        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
074800           MOVE 76                     TO PPS-RTC
074900        END-IF
075000     END-IF.
075100*OLD WAY OF VALIDATING COMORBIDS
075200*    IF PPS-RTC = 00  THEN
075300*       IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
075400*           VALID-COMORBID-CWF-RETURN-CD       THEN
075500*          NEXT SENTENCE
075600*       ELSE
075700*          MOVE 81                     TO PPS-RTC
075800*      END-IF
075900*    END-IF.
076000*
076100*CY2016 - DROP PNEUMONIA & MONOCLONAL GAMM COMORBIDS
076200
076300     IF PPS-RTC = 00  THEN
076400        IF COMORBID-CWF-RETURN-CODE = SPACES OR
076500            "10" OR "20" OR "40" OR "50" OR "60" THEN
076600           NEXT SENTENCE
076700        ELSE
076800           MOVE 81                     TO PPS-RTC
076900        END-IF
077000     END-IF.
077100/
077200 1200-INITIALIZATION.
077300     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
077400     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
077500     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
077600     INITIALIZE PAID-RETURN-CODE-TRACKERS.
077700
077800     MOVE SPACES                       TO MOVED-CORMORBIDS.
077900
078000     IF P-QIP-REDUCTION = ' '  THEN
078100* no reduction
078200        MOVE 1.000 TO QIP-REDUCTION
078300     ELSE
078400        IF P-QIP-REDUCTION = '1'  THEN
078500* one-half percent reduction
078600           MOVE 0.995 TO QIP-REDUCTION
078700        ELSE
078800           IF P-QIP-REDUCTION = '2'  THEN
078900* one percent reduction
079000              MOVE 0.990 TO QIP-REDUCTION
079100           ELSE
079200              IF P-QIP-REDUCTION = '3'  THEN
079300* one and one-half percent reduction
079400                 MOVE 0.985 TO QIP-REDUCTION
079500              ELSE
079600* two percent reduction
079700                 MOVE 0.980 TO QIP-REDUCTION
079800              END-IF
079900           END-IF
080000        END-IF
080100     END-IF.
080200
080300*    Since pricer has to pay a comorbid condition according to the
080400* return code that CWF passes back, it is cleaner if the pricer
080500* sets aside whatever comorbid data exists on the line-item when
080600* it comes into the pricer and then transferrs the CWF code to
080700* the appropriate place in the comorbid data.  This avoids
080800* making convoluted changes in the other parts of the program
080900* which has to look at both original comorbid data AND CWF return
081000* codes to handle comorbids.  Near the end of the program where
081100* variables are transferred to the output, the original comorbid
081200* data is put back into its original place as though nothing
081300* occurred.
081400*CY2016 DROPPED MB & MF
081500     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
081600        NEXT SENTENCE
081700     ELSE
081800        MOVE 'Y'                       TO MOVED-CORMORBIDS
081900        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
082000        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
082100        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
082200        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
082300        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
082400        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
082500        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
082600        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
082700           MOVE SPACES                 TO COMORBID-DATA (1)
082800                                          COMORBID-DATA (2)
082900                                          COMORBID-DATA (3)
083000                                          COMORBID-DATA (4)
083100                                          COMORBID-DATA (5)
083200                                          COMORBID-DATA (6)
083300                                          COMORBID-CWF-RETURN-CODE
083400        ELSE
083500           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
083600              MOVE 'MA'                TO COMORBID-DATA (1)
083700              MOVE SPACES              TO COMORBID-DATA (2)
083800                                          COMORBID-DATA (3)
083900                                          COMORBID-DATA (4)
084000                                          COMORBID-DATA (5)
084100                                          COMORBID-DATA (6)
084200                                          COMORBID-CWF-RETURN-CODE
084300           ELSE
084400*             IF COMORBID-CWF-RETURN-CODE = '30'  THEN
084500*                MOVE SPACES           TO COMORBID-DATA (1)
084600*                MOVE 'MB'             TO COMORBID-DATA (2)
084700*                MOVE SPACES           TO COMORBID-DATA (3)
084800*                MOVE SPACES           TO COMORBID-DATA (4)
084900*                MOVE SPACES           TO COMORBID-DATA (5)
085000*                MOVE SPACES           TO COMORBID-DATA (6)
085100*                                         COMORBID-CWF-RETURN-CODE
085200*             ELSE
085300                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
085400                    MOVE SPACES        TO COMORBID-DATA (1)
085500                    MOVE SPACES        TO COMORBID-DATA (2)
085600                    MOVE 'MC'          TO COMORBID-DATA (3)
085700                    MOVE SPACES        TO COMORBID-DATA (4)
085800                    MOVE SPACES        TO COMORBID-DATA (5)
085900                    MOVE SPACES        TO COMORBID-DATA (6)
086000                                          COMORBID-CWF-RETURN-CODE
086100                 ELSE
086200                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
086300                       MOVE SPACES     TO COMORBID-DATA (1)
086400                       MOVE SPACES     TO COMORBID-DATA (2)
086500                       MOVE SPACES     TO COMORBID-DATA (3)
086600                       MOVE 'MD'       TO COMORBID-DATA (4)
086700                       MOVE SPACES     TO COMORBID-DATA (5)
086800                       MOVE SPACES     TO COMORBID-DATA (6)
086900                                          COMORBID-CWF-RETURN-CODE
087000                    ELSE
087100                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
087200                          MOVE SPACES  TO COMORBID-DATA (1)
087300                          MOVE SPACES  TO COMORBID-DATA (2)
087400                          MOVE SPACES  TO COMORBID-DATA (3)
087500                          MOVE SPACES  TO COMORBID-DATA (4)
087600                          MOVE 'ME'    TO COMORBID-DATA (5)
087700                          MOVE SPACES  TO COMORBID-DATA (6)
087800                                          COMORBID-CWF-RETURN-CODE
087900*                      ELSE
088000*                         MOVE SPACES  TO COMORBID-DATA (1)
088100*                                         COMORBID-DATA (2)
088200*                                         COMORBID-DATA (3)
088300*                                         COMORBID-DATA (4)
088400*                                         COMORBID-DATA (5)
088500*                                         COMORBID-CWF-RETURN-CODE
088600*                         MOVE 'MF'    TO COMORBID-DATA (6)
088700                       END-IF
088800                    END-IF
088900                 END-IF
089000*             END-IF
089100           END-IF
089200        END-IF
089300     END-IF.
089400
089500******************************************************************
089600***Calculate BUNDLED Wage Adjusted Rate (note different method)***
089700******************************************************************
089800     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
089900        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
090000         BUN-CBSA-W-INDEX.
090100
090200     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
090300        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
090400
090500     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
090600        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
090700/
090800 2000-CALCULATE-BUNDLED-FACTORS.
090900******************************************************************
091000***  Set BUNDLED age adjustment factor                         ***
091100******************************************************************
091200     IF H-PATIENT-AGE < 13  THEN
091300        IF B-REV-CODE = '0821' OR '0881' THEN
091400           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
091500        ELSE
091600           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
091700        END-IF
091800     ELSE
091900        IF H-PATIENT-AGE < 18 THEN
092000           IF B-REV-CODE = '0821' OR '0881' THEN
092100              MOVE EB-AGE-13-17-HEMO-MODE
092200                                       TO H-BUN-AGE-FACTOR
092300           ELSE
092400              MOVE EB-AGE-13-17-PD-MODE
092500                                       TO H-BUN-AGE-FACTOR
092600           END-IF
092700        ELSE
092800           IF H-PATIENT-AGE < 45  THEN
092900              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
093000           ELSE
093100              IF H-PATIENT-AGE < 60  THEN
093200                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
093300              ELSE
093400                 IF H-PATIENT-AGE < 70  THEN
093500                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
093600                 ELSE
093700                    IF H-PATIENT-AGE < 80  THEN
093800                       MOVE CM-AGE-70-79
093900                                       TO H-BUN-AGE-FACTOR
094000                    ELSE
094100                       MOVE CM-AGE-80-PLUS
094200                                       TO H-BUN-AGE-FACTOR
094300                    END-IF
094400                 END-IF
094500              END-IF
094600           END-IF
094700        END-IF
094800     END-IF.
094900
095000******************************************************************
095100***  Calculate BUNDLED BSA factor (note NEW formula)           ***
095200******************************************************************
095300     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
095400         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
095500
095600     IF H-PATIENT-AGE > 17  THEN
095700        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
095800             CM-BSA ** ((H-BUN-BSA - 1.90) / .1)
095900     ELSE
096000        MOVE 1.000                     TO H-BUN-BSA-FACTOR
096100     END-IF.
096200
096300******************************************************************
096400***  Calculate BUNDLED BMI factor                              ***
096500******************************************************************
096600     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
096700         (B-PATIENT-HGT ** 2)) * 10000.
096800
096900     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
097000        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
097100        MOVE "Y"                       TO LOW-BMI-TRACK
097200     ELSE
097300        MOVE 1.000                     TO H-BUN-BMI-FACTOR
097400     END-IF.
097500
097600******************************************************************
097700***  Calculate BUNDLED ONSET factor                            ***
097800******************************************************************
097900     IF B-DIALYSIS-START-DATE > ZERO  THEN
098000        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
098100        COMPUTE INTEGER-LINE-ITEM-DATE =
098200            FUNCTION INTEGER-OF-DATE(THE-DATE)
098300        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
098400        COMPUTE INTEGER-DIALYSIS-DATE  =
098500            FUNCTION INTEGER-OF-DATE(THE-DATE)
098600* Need to add one to onset-date because the start date should
098700* be incSB-AGE-LT-13-PD-MODEf days.  fix made 9/6/2011
098800        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
098900                              INTEGER-DIALYSIS-DATE) + 1
099000        IF H-PATIENT-AGE > 17  THEN
099100           IF ONSET-DATE > 120  THEN
099200              MOVE 1                   TO H-BUN-ONSET-FACTOR
099300           ELSE
099400              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
099500              MOVE "Y"                 TO ONSET-TRACK
099600           END-IF
099700        ELSE
099800           MOVE 1                      TO H-BUN-ONSET-FACTOR
099900        END-IF
100000     ELSE
100100        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
100200     END-IF.
100300
100400******************************************************************
100500***  Set BUNDLED Co-morbidities adjustment                     ***
100600******************************************************************
100700     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
100800        IF H-PATIENT-AGE  <  18  THEN
100900           MOVE 1.000                  TO
101000                                       H-BUN-COMORBID-MULTIPLIER
101100           MOVE '10'                   TO PPS-2011-COMORBID-PAY
101200        ELSE
101300           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
101400              MOVE 1.000               TO
101500                                       H-BUN-COMORBID-MULTIPLIER
101600              MOVE '10'                TO PPS-2011-COMORBID-PAY
101700           ELSE
101800              PERFORM 2100-CALC-COMORBID-ADJUST
101900              MOVE H-COMORBID-MULTIPLIER TO
102000                                       H-BUN-COMORBID-MULTIPLIER
102100           END-IF
102200        END-IF
102300     ELSE
102400        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
102500           MOVE 1.000                  TO
102600                                       H-BUN-COMORBID-MULTIPLIER
102700           MOVE '10'                   TO PPS-2011-COMORBID-PAY
102800        ELSE
102900           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
103000              MOVE CM-GI-BLEED         TO
103100                                       H-BUN-COMORBID-MULTIPLIER
103200              MOVE '20'                TO PPS-2011-COMORBID-PAY
103300           ELSE
103400*            IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
103500*                MOVE CM-PNEUMONIA     TO
103600*                                      H-BUN-COMORBID-MULTIPLIER
103700*                MOVE '30'             TO PPS-2011-COMORBID-PAY
103800*            ELSE
103900                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
104000                    MOVE CM-PERICARDITIS TO
104100                                       H-BUN-COMORBID-MULTIPLIER
104200                    MOVE '40'          TO PPS-2011-COMORBID-PAY
104300                 END-IF
104400*            END-IF
104500           END-IF
104600        END-IF
104700     END-IF.
104800
104900******************************************************************
105000***  Calculate BUNDLED Low Volume adjustment                   ***
105100******************************************************************
105200     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
105300        IF H-PATIENT-AGE > 17  THEN
105400           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
105500                                       H-BUN-LOW-VOL-MULTIPLIER
105600           MOVE "Y"                    TO  LOW-VOLUME-TRACK
105700        ELSE
105800           MOVE 1.000                  TO
105900                                       H-BUN-LOW-VOL-MULTIPLIER
106000        END-IF
106100     ELSE
106200        MOVE 1.000                     TO
106300                                       H-BUN-LOW-VOL-MULTIPLIER
106400     END-IF.
106500
106600***************************************************************
106700* Calculate Rural Adjustment Multiplier ADDED CY 2016
106800***************************************************************
106900     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
107000        MOVE CM-RURAL TO H-BUN-RURAL-MULTIPLIER
107100     ELSE
107200        MOVE 1.000 TO H-BUN-RURAL-MULTIPLIER.
107300
107400******************************************************************
107500***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
107600******************************************************************
107700     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
107800        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
107900        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
108000        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
108100        H-BUN-LOW-VOL-MULTIPLIER * H-BUN-RURAL-MULTIPLIER.
108200
108300******************************************************************
108400***  Calculate BUNDLED Condition Code payment                  ***
108500******************************************************************
108600* Self-care in Training add-on
108700     IF B-COND-CODE = '73'  THEN
108800* no add-on when onset is present
108900        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
109000           MOVE ZERO                   TO
109100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
109200        ELSE
109300* use new PPS training add-on amount times wage-index
109400           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
109500             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
109600           MOVE "Y"                    TO TRAINING-TRACK
109700        END-IF
109800     ELSE
109900* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
110000        IF (B-COND-CODE = '74')  AND
110100           (B-REV-CODE = '0841' OR '0851')  THEN
110200              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
110300                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
110400        ELSE
110500           MOVE ZERO                   TO
110600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
110700                                    H-CC-74-PER-DIEM-AMT
110800        END-IF
110900     END-IF.
111000
111100******************************************************************
111200***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
111300******************************************************************
111400     IF (B-COND-CODE = '74')  AND
111500        (B-REV-CODE = '0841' OR '0851')  THEN
111600           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
111700                           H-CC-74-PER-DIEM-AMT
111800           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
111900              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
112000              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
112100     ELSE
112200        COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
112300                H-BUN-ADJUSTED-BASE-WAGE-AMT  +
112400                H-BUN-WAGE-ADJ-TRAINING-AMT
112500     END-IF.
112600
112700******************************************************************
112800***  Calculate BUNDLED Outlier                                 ***
112900******************************************************************
113000     PERFORM 2500-CALC-OUTLIER-FACTORS.
113100
113200******************************************************************
113300***  Calculate Low Volume payment for recovery purposes        ***
113400******************************************************************
113500     IF LOW-VOLUME-TRACK = "Y"  THEN
113600        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
113700        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
113800
113900        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
114000           H-PPS-FINAL-PAY-AMT
114100
114200        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
114300           H-OUT-PAYMENT
114400
114500        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
114600           H-LV-OUT-PAYMENT
114700
114800        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
114900           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
115000              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
115100        ELSE
115200           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
115300        END-IF
115400     END-IF.
115500
115600
115700/
115800 2100-CALC-COMORBID-ADJUST.
115900******************************************************************
116000***  Calculate Co-morbidities adjustment                       ***
116100******************************************************************
116200*  This logic assumes that the comorbids are randomly assigned   *
116300*to the comorbid table.  It will select the highest comorbid for *
116400*payment if one is found.  CY 2016 DROPPED MB & MF              *
116500******************************************************************
116600     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
116700     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
116800     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
116900
117000     PERFORM VARYING  SUB  FROM  1 BY 1
117100       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
117200         IF COMORBID-DATA (SUB) = 'MA'  THEN
117300           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
117400*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
117500           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
117600           MOVE '20'                   TO PPS-2011-COMORBID-PAY
117700         ELSE
117800*          IF COMORBID-DATA (SUB) = 'MB'  THEN
117900*            IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
118000*              MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
118100*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
118200*              MOVE '30'               TO PPS-2011-COMORBID-PAY
118300*            END-IF
118400*          ELSE
118500             IF COMORBID-DATA (SUB) = 'MC'  THEN
118600                IF CM-PERICARDITIS  >
118700                                      H-COMORBID-MULTIPLIER  THEN
118800                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
118900                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
119000                  MOVE '40'            TO PPS-2011-COMORBID-PAY
119100                END-IF
119200             ELSE
119300               IF COMORBID-DATA (SUB) = 'MD'  THEN
119400                 IF CM-MYELODYSPLASTIC  >
119500                                      H-COMORBID-MULTIPLIER  THEN
119600                   MOVE CM-MYELODYSPLASTIC  TO
119700                                      H-COMORBID-MULTIPLIER
119800                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
119900                   MOVE '50'           TO PPS-2011-COMORBID-PAY
120000                 END-IF
120100               ELSE
120200                 IF COMORBID-DATA (SUB) = 'ME'  THEN
120300                   IF CM-SICKEL-CELL  >
120400                                      H-COMORBID-MULTIPLIER  THEN
120500                     MOVE CM-SICKEL-CELL  TO
120600                                      H-COMORBID-MULTIPLIER
120700                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
120800                     MOVE '60'         TO PPS-2011-COMORBID-PAY
120900                   END-IF
121000*                ELSE
121100*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
121200*                    IF CM-MONOCLONAL-GAMM  >
121300*                                     H-COMORBID-MULTIPLIER  THEN
121400*                      MOVE CM-MONOCLONAL-GAMM TO
121500*                                     H-COMORBID-MULTIPLIER
121600*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
121700*                      MOVE '70'       TO PPS-2011-COMORBID-PAY
121800*                    END-IF
121900*                  END-IF
122000                 END-IF
122100               END-IF
122200             END-IF
122300*          END-IF
122400         END-IF
122500     END-PERFORM.
122600/
122700 2500-CALC-OUTLIER-FACTORS.
122800******************************************************************
122900***  Set separately billable OUTLIER age adjustment factor     ***
123000******************************************************************
123100     IF H-PATIENT-AGE < 13  THEN
123200        IF B-REV-CODE = '0821' OR '0881' THEN
123300           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
123400        ELSE
123500           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
123600        END-IF
123700     ELSE
123800        IF H-PATIENT-AGE < 18 THEN
123900           IF B-REV-CODE = '0821' OR '0881'  THEN
124000              MOVE SB-AGE-13-17-HEMO-MODE
124100                                       TO H-OUT-AGE-FACTOR
124200           ELSE
124300              MOVE SB-AGE-13-17-PD-MODE
124400                                       TO H-OUT-AGE-FACTOR
124500           END-IF
124600        ELSE
124700           IF H-PATIENT-AGE < 45  THEN
124800              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
124900           ELSE
125000              IF H-PATIENT-AGE < 60  THEN
125100                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
125200              ELSE
125300                 IF H-PATIENT-AGE < 70  THEN
125400                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
125500                 ELSE
125600                    IF H-PATIENT-AGE < 80  THEN
125700                       MOVE SB-AGE-70-79
125800                                       TO H-OUT-AGE-FACTOR
125900                    ELSE
126000                       MOVE SB-AGE-80-PLUS
126100                                       TO H-OUT-AGE-FACTOR
126200                    END-IF
126300                 END-IF
126400              END-IF
126500           END-IF
126600        END-IF
126700     END-IF.
126800
126900******************************************************************
127000**Calculate separately billable OUTLIER BSA factor (superscript)**
127100******************************************************************
127200     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
127300         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
127400
127500     IF H-PATIENT-AGE > 17  THEN
127600        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
127700             SB-BSA ** ((H-OUT-BSA - 1.90) / .1)
127800     ELSE
127900        MOVE 1.000                     TO H-OUT-BSA-FACTOR
128000     END-IF.
128100
128200******************************************************************
128300***  Calculate separately billable OUTLIER BMI factor          ***
128400******************************************************************
128500     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
128600         (B-PATIENT-HGT ** 2)) * 10000.
128700
128800     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
128900        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
129000     ELSE
129100        MOVE 1.000                     TO H-OUT-BMI-FACTOR
129200     END-IF.
129300
129400******************************************************************
129500***  Calculate separately billable OUTLIER ONSET factor        ***
129600******************************************************************
129700     IF B-DIALYSIS-START-DATE > ZERO  THEN
129800        IF H-PATIENT-AGE > 17  THEN
129900           IF ONSET-DATE > 120  THEN
130000              MOVE 1                   TO H-OUT-ONSET-FACTOR
130100           ELSE
130200              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
130300           END-IF
130400        ELSE
130500           MOVE 1                      TO H-OUT-ONSET-FACTOR
130600        END-IF
130700     ELSE
130800        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
130900     END-IF.
131000
131100******************************************************************
131200***  Set separately billable OUTLIER Co-morbidities adjustment ***
131300* CY 2016 DROPPED MB & MF
131400******************************************************************
131500     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
131600        IF H-PATIENT-AGE  <  18  THEN
131700           MOVE 1.000                  TO
131800                                       H-OUT-COMORBID-MULTIPLIER
131900           MOVE '10'                   TO PPS-2011-COMORBID-PAY
132000        ELSE
132100           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
132200              MOVE 1.000               TO
132300                                       H-OUT-COMORBID-MULTIPLIER
132400              MOVE '10'                TO PPS-2011-COMORBID-PAY
132500           ELSE
132600              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
132700           END-IF
132800        END-IF
132900     ELSE
133000        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
133100           MOVE 1.000                  TO
133200                                       H-OUT-COMORBID-MULTIPLIER
133300        ELSE
133400           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
133500              MOVE SB-GI-BLEED         TO
133600                                       H-OUT-COMORBID-MULTIPLIER
133700           ELSE
133800*             IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
133900*                MOVE SB-PNEUMONIA     TO
134000*                                      H-OUT-COMORBID-MULTIPLIER
134100*             ELSE
134200                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
134300                    MOVE SB-PERICARDITIS TO
134400                                       H-OUT-COMORBID-MULTIPLIER
134500                 END-IF
134600*             END-IF
134700           END-IF
134800        END-IF
134900     END-IF.
135000
135100******************************************************************
135200***  Set OUTLIER low-volume-multiplier                         ***
135300******************************************************************
135400     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
135500        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
135600     ELSE
135700        IF H-PATIENT-AGE < 18  THEN
135800           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
135900        ELSE
136000           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
136100           MOVE "Y"                    TO LOW-VOLUME-TRACK
136200        END-IF
136300     END-IF.
136400
136500***************************************************************
136600* Calculate OUTLIER Rural Adjustment multiplier
136700***************************************************************
136800
136900     IF (P-GEO-CBSA < 100) AND (H-PATIENT-AGE > 17) THEN
137000        MOVE SB-RURAL TO H-OUT-RURAL-MULTIPLIER
137100     ELSE
137200        MOVE 1.000 TO H-OUT-RURAL-MULTIPLIER.
137300
137400******************************************************************
137500***  Calculate predicted OUTLIER services MAP per treatment    ***
137600******************************************************************
137700     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
137800        (H-OUT-AGE-FACTOR             *
137900         H-OUT-BSA-FACTOR             *
138000         H-OUT-BMI-FACTOR             *
138100         H-OUT-ONSET-FACTOR           *
138200         H-OUT-COMORBID-MULTIPLIER    *
138300         H-OUT-RURAL-MULTIPLIER       *
138400         H-OUT-LOW-VOL-MULTIPLIER).
138500
138600******************************************************************
138700***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
138800******************************************************************
138900     IF H-PATIENT-AGE < 18  THEN
139000        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
139100           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
139200        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
139300     ELSE
139400
139500        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
139600           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
139700        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
139800     END-IF.
139900
140000******************************************************************
140100*** Calculate imputed OUTLIER services MAP amount per treatment***
140200******************************************************************
140300     IF (B-COND-CODE = '74')  AND
140400        (B-REV-CODE = '0841' OR '0851')  THEN
140500         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
140600            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
140700         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
140800         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
140900     ELSE
141000        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
141100        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
141200     END-IF.
141300
141400******************************************************************
141500*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
141600******************************************************************
141700     IF H-PATIENT-AGE < 18   THEN
141800        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
141900           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
142000        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
142100        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
142200           COMPUTE H-OUT-PAYMENT  ROUNDED  =
142300            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
142400                                         LOSS-SHARING-PCT-LT-18
142500           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
142600           MOVE "Y"                    TO OUTLIER-TRACK
142700        ELSE
142800           MOVE ZERO                   TO H-OUT-PAYMENT
142900           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
143000        END-IF
143100     ELSE
143200        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
143300           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
143400           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
143500        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
143600           COMPUTE H-OUT-PAYMENT  ROUNDED  =
143700            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
143800                                         LOSS-SHARING-PCT-GT-17
143900           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
144000           MOVE "Y"                    TO OUTLIER-TRACK
144100        ELSE
144200           MOVE ZERO                   TO H-OUT-PAYMENT
144300        END-IF
144400     END-IF.
144500
144600     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
144700
144800* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
144900     IF (B-COND-CODE = '74')  AND
145000        (B-REV-CODE = '0841' OR '0851')  THEN
145100           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
145200             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
145300     END-IF.
145400/
145500 2600-CALC-COMORBID-OUT-ADJUST.
145600******************************************************************
145700***  Calculate OUTLIER Co-morbidities adjustment               ***
145800******************************************************************
145900*  This logic assumes that the comorbids are randomly assigned   *
146000*to the comorbid table.  It will select the highest comorbid for *
146100*payment if one is found. CY 2016 DROPPED MB & MF                *
146200******************************************************************
146300
146400     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
146500     MOVE 1.000                        TO
146600                                  H-OUT-COMORBID-MULTIPLIER.
146700
146800     PERFORM VARYING  SUB  FROM  1 BY 1
146900       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
147000         IF COMORBID-DATA (SUB) = 'MA'  THEN
147100           MOVE SB-GI-BLEED            TO
147200                                  H-OUT-COMORBID-MULTIPLIER
147300*          MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
147400           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
147500         ELSE
147600*          IF COMORBID-DATA (SUB) = 'MB'  THEN
147700*            IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
147800*              MOVE SB-PNEUMONIA       TO
147900*                                 H-OUT-COMORBID-MULTIPLIER
148000*              MOVE "Y"                TO ACUTE-COMORBID-TRACK
148100*            END-IF
148200*          ELSE
148300             IF COMORBID-DATA (SUB) = 'MC'  THEN
148400                IF SB-PERICARDITIS  >
148500                                  H-OUT-COMORBID-MULTIPLIER  THEN
148600                  MOVE SB-PERICARDITIS TO
148700                                  H-OUT-COMORBID-MULTIPLIER
148800                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
148900                END-IF
149000             ELSE
149100               IF COMORBID-DATA (SUB) = 'MD'  THEN
149200                 IF SB-MYELODYSPLASTIC  >
149300                                  H-OUT-COMORBID-MULTIPLIER  THEN
149400                   MOVE SB-MYELODYSPLASTIC  TO
149500                                  H-OUT-COMORBID-MULTIPLIER
149600                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
149700                 END-IF
149800               ELSE
149900                 IF COMORBID-DATA (SUB) = 'ME'  THEN
150000                   IF SB-SICKEL-CELL  >
150100                                 H-OUT-COMORBID-MULTIPLIER  THEN
150200                     MOVE SB-SICKEL-CELL  TO
150300                                  H-OUT-COMORBID-MULTIPLIER
150400                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
150500                   END-IF
150600*                ELSE
150700*                  IF COMORBID-DATA (SUB) = 'MF'  THEN
150800*                    IF SB-MONOCLONAL-GAMM  >
150900*                                 H-OUT-COMORBID-MULTIPLIER  THEN
151000*                      MOVE SB-MONOCLONAL-GAMM  TO
151100*                                 H-OUT-COMORBID-MULTIPLIER
151200*                      MOVE "Y"        TO CHRONIC-COMORBID-TRACK
151300*                    END-IF
151400*                  END-IF
151500                 END-IF
151600               END-IF
151700             END-IF
151800*          END-IF
151900         END-IF
152000     END-PERFORM.
152100/
152200******************************************************************
152300*** Calculate Low Volume Full PPS payment for recovery purposes***
152400******************************************************************
152500 3000-LOW-VOL-FULL-PPS-PAYMENT.
152600******************************************************************
152700** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
152800     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
152900        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
153000        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
153100        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
153200         H-BUN-RURAL-MULTIPLIER.
153300
153400******************************************************************
153500**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
153600* Self-care in Training add-on
153700     IF B-COND-CODE = '73'  THEN
153800* no add-on when onset is present
153900        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
154000           MOVE ZERO                   TO
154100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
154200        ELSE
154300* use new PPS training add-on amount times wage-index
154400           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
154500             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
154600           MOVE "Y"                    TO TRAINING-TRACK
154700        END-IF
154800     ELSE
154900* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
155000        IF (B-COND-CODE = '74')  AND
155100           (B-REV-CODE = '0841' OR '0851')  THEN
155200              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
155300                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
155400        ELSE
155500           MOVE ZERO                   TO
155600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
155700                                    H-CC-74-PER-DIEM-AMT
155800        END-IF
155900     END-IF.
156000
156100******************************************************************
156200**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
156300     IF (B-COND-CODE = '74')  AND
156400        (B-REV-CODE = '0841' OR '0851')  THEN
156500           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
156600                           H-CC-74-PER-DIEM-AMT
156700     ELSE
156800        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
156900                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
157000                H-BUN-WAGE-ADJ-TRAINING-AMT
157100     END-IF.
157200
157300/
157400******************************************************************
157500*** Calculate Low Volume OUT PPS payment for recovery purposes ***
157600******************************************************************
157700 3100-LOW-VOL-OUT-PPS-PAYMENT.
157800******************************************************************
157900**Modified code from 'Calc predict OUT serv MAP per treat' para.**
158000     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
158100        (H-OUT-AGE-FACTOR             *
158200         H-OUT-BSA-FACTOR             *
158300         H-OUT-BMI-FACTOR             *
158400         H-OUT-ONSET-FACTOR           *
158500         H-OUT-COMORBID-MULTIPLIER    *
158600         H-OUT-RURAL-MULTIPLIER).
158700
158800******************************************************************
158900**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
159000     IF H-PATIENT-AGE < 18  THEN
159100        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
159200           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
159300        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
159400     ELSE
159500        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
159600           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
159700        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
159800     END-IF.
159900
160000******************************************************************
160100** 'Calculate imput OUT services MAP amount per treatment' para **
160200** It is not necessary to modify or insert this paragraph here. **
160300
160400******************************************************************
160500**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
160600     IF H-PATIENT-AGE < 18   THEN
160700        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
160800           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
160900        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
161000        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
161100           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
161200            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
161300                                         LOSS-SHARING-PCT-LT-18
161400           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
161500        ELSE
161600           MOVE ZERO                   TO H-LV-OUT-PAYMENT
161700           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
161800        END-IF
161900     ELSE
162000        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
162100           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
162200           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
162300        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
162400           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
162500            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
162600                                         LOSS-SHARING-PCT-GT-17
162700           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
162800        ELSE
162900           MOVE ZERO                   TO H-LV-OUT-PAYMENT
163000        END-IF
163100     END-IF.
163200
163300     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
163400
163500* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
163600     IF (B-COND-CODE = '74')  AND
163700        (B-REV-CODE = '0841' OR '0851')  THEN
163800           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
163900             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
164000     END-IF.
164100/
164200 5000-CALC-COMP-RATE-FACTORS.
164300******************************************************************
164400***  Set Composite Rate age adjustment factor                  ***
164500******************************************************************
164600     IF H-PATIENT-AGE < 18  THEN
164700        MOVE CR-AGE-LT-18              TO H-AGE-FACTOR
164800     ELSE
164900        IF H-PATIENT-AGE < 45  THEN
165000           MOVE CR-AGE-18-44           TO H-AGE-FACTOR
165100        ELSE
165200           IF H-PATIENT-AGE < 60  THEN
165300              MOVE CR-AGE-45-59        TO H-AGE-FACTOR
165400           ELSE
165500              IF H-PATIENT-AGE < 70  THEN
165600                 MOVE CR-AGE-60-69     TO H-AGE-FACTOR
165700              ELSE
165800                 IF H-PATIENT-AGE < 80  THEN
165900                    MOVE CR-AGE-70-79  TO H-AGE-FACTOR
166000                 ELSE
166100                    MOVE CR-AGE-80-PLUS
166200                                       TO H-AGE-FACTOR
166300                 END-IF
166400              END-IF
166500           END-IF
166600        END-IF
166700     END-IF.
166800
166900******************************************************************
167000**Calculate Composite Rate BSA factor (2012 superscript now same)*
167100******************************************************************
167200     COMPUTE H-BSA  ROUNDED = (.007184 *
167300         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
167400
167500     IF H-PATIENT-AGE > 17  THEN
167600        COMPUTE H-BSA-FACTOR  ROUNDED =
167700             CR-BSA ** ((H-BSA - 1.87) / .1)
167800     ELSE
167900        MOVE 1.000                     TO H-BSA-FACTOR
168000     END-IF.
168100
168200******************************************************************
168300*** Calculate Composite Rate BMI factor (different BMI < 18.5) ***
168400******************************************************************
168500     COMPUTE H-BMI  ROUNDED = (B-PATIENT-WGT /
168600         (B-PATIENT-HGT ** 2)) * 10000.
168700
168800     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)  THEN
168900        MOVE CR-BMI-LT-18-5            TO H-BMI-FACTOR
169000     ELSE
169100        MOVE 1.000                     TO H-BMI-FACTOR
169200     END-IF.
169300
169400******************************************************************
169500***  Calculate Composite Rate Payment Amount                   ***
169600******************************************************************
169700*P-ESRD-RATE, also called the Exception Rate, will not be granted*
169800*in full beginning in 2011 (the beginning of the Bundled method) *
169900*and will be eliminated entirely beginning in 2014 which is the  *
170000*end of the blending period.  For 2011, those providers who elect*
170100*to be in the blend, will get only 75% of the exception rate.    *
170200*This apparently is for the pediatric providers who originally   *
170300*had the exception rate.                                         *
170400
170500     IF P-ESRD-RATE  =  ZERO  THEN
170600        MOVE BASE-PAYMENT-RATE         TO  H-PAYMENT-RATE
170700     ELSE
170800        MOVE P-ESRD-RATE               TO  H-PAYMENT-RATE
170900     END-IF.
171000
171100     COMPUTE H-WAGE-ADJ-PYMT-AMT ROUNDED =
171200     (((H-PAYMENT-RATE * NAT-LABOR-PCT) * COM-CBSA-W-INDEX) +
171300       (H-PAYMENT-RATE * NAT-NONLABOR-PCT)) *
171400            CBSA-BLEND-PCT.
171500
171600     COMPUTE H-PYMT-AMT ROUNDED = (H-WAGE-ADJ-PYMT-AMT *
171700        H-BMI-FACTOR * H-BSA-FACTOR * CASE-MIX-BDGT-NEUT-FACTOR *
171800        H-AGE-FACTOR * DRUG-ADDON).
171900
172000     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
172100
172200******************************************************************
172300***  Calculate condition code payment                          ***
172400******************************************************************
172500     MOVE SPACES                       TO COND-CD-73.
172600
172700* Hemo, peritoneal, or CCPD training add-on
172800     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
172900                                                      OR '0851')
173000        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
173100        MOVE 'A'                       TO AMT-INDIC
173200        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
173300     ELSE
173400* CAPD training add-on
173500        IF (B-COND-CODE = '73')  AND  (B-REV-CODE = '0841')  THEN
173600           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
173700           MOVE 'A'                    TO AMT-INDIC
173800           MOVE CAPD-AMT               TO BLOOD-DOLLAR
173900        ELSE
174000* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
174100           IF (B-COND-CODE = '74')  AND
174200              (B-REV-CODE = '0841' OR '0851')  THEN
174300              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
174400                                           CAPD-OR-CCPD-FACTOR
174500              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
174600           ELSE
174700              MOVE 'A'                 TO AMT-INDIC
174800              MOVE ZERO                TO BLOOD-DOLLAR
174900           END-IF
175000        END-IF
175100     END-IF.
175200
175300/
175400 9000-SET-RETURN-CODE.
175500******************************************************************
175600***  Set the return code                                       ***
175700******************************************************************
175800*   The following 'table' helps in understanding and in making   *
175900*changes to the rather large and complex "IF" statement that     *
176000*follows.  This 'table' just reorders and rewords the comments   *
176100*contained in the working storage area concerning the paid       *
176200*return-codes.                                                   *
176300*                                                                *
176400*  17 = pediatric, outlier, training                             *
176500*  16 = pediatric, outlier                                       *
176600*  15 = pediatric, training                                      *
176700*  14 = pediatric                                                *
176800*                                                                *
176900*  24 = outlier, low volume, training, chronic comorbid          *
177000*  19 = outlier, low volume, training, acute comorbid            *
177100*  29 = outlier, low volume, training                            *
177200*  23 = outlier, low volume, chronic comorbid                    *
177300*  18 = outlier, low volume, acute comorbid                      *
177400*  30 = outlier, low volume, onset                               *
177500*  28 = outlier, low volume                                      *
177600*  34 = outlier, training, chronic comorbid                      *
177700*  35 = outlier, training, acute comorbid                        *
177800*  33 = outlier, training                                        *
177900*  07 = outlier, chronic comorbid                                *
178000*  06 = outlier, acute comorbid                                  *
178100*  09 = outlier, onset                                           *
178200*  03 = outlier                                                  *
178300*                                                                *
178400*  26 = low volume, training, chronic comorbid                   *
178500*  21 = low volume, training, acute comorbid                     *
178600*  12 = low volume, training                                     *
178700*  25 = low volume, chronic comorbid                             *
178800*  20 = low volume, acute comorbid                               *
178900*  32 = low volume, onset                                        *
179000*  10 = low volume                                               *
179100*                                                                *
179200*  27 = training, chronic comorbid                               *
179300*  22 = training, acute comorbid                                 *
179400*  11 = training                                                 *
179500*                                                                *
179600*  08 = onset                                                    *
179700*  04 = acute comorbid                                           *
179800*  05 = chronic comorbid                                         *
179900*  31 = low BMI                                                  *
180000*  02 = no adjustments                                           *
180100*                                                                *
180200*  13 = w/multiple adjustments....reserved for future use        *
180300******************************************************************
180400/
180500     IF PEDIATRIC-TRACK                       = "Y"  THEN
180600        IF OUTLIER-TRACK                      = "Y"  THEN
180700           IF TRAINING-TRACK                  = "Y"  THEN
180800              MOVE 17                  TO PPS-RTC
180900           ELSE
181000              MOVE 16                  TO PPS-RTC
181100           END-IF
181200        ELSE
181300           IF TRAINING-TRACK                  = "Y"  THEN
181400              MOVE 15                  TO PPS-RTC
181500           ELSE
181600              MOVE 14                  TO PPS-RTC
181700           END-IF
181800        END-IF
181900     ELSE
182000        IF OUTLIER-TRACK                      = "Y"  THEN
182100           IF LOW-VOLUME-TRACK                = "Y"  THEN
182200              IF TRAINING-TRACK               = "Y"  THEN
182300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
182400                    MOVE 24            TO PPS-RTC
182500                 ELSE
182600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
182700                       MOVE 19         TO PPS-RTC
182800                    ELSE
182900                       MOVE 29         TO PPS-RTC
183000                    END-IF
183100                 END-IF
183200              ELSE
183300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
183400                    MOVE 23            TO PPS-RTC
183500                 ELSE
183600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
183700                       MOVE 18         TO PPS-RTC
183800                    ELSE
183900                       IF ONSET-TRACK         = "Y"  THEN
184000                          MOVE 30      TO PPS-RTC
184100                       ELSE
184200                          MOVE 28      TO PPS-RTC
184300                       END-IF
184400                    END-IF
184500                 END-IF
184600              END-IF
184700           ELSE
184800              IF TRAINING-TRACK               = "Y"  THEN
184900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
185000                    MOVE 34            TO PPS-RTC
185100                 ELSE
185200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
185300                       MOVE 35         TO PPS-RTC
185400                    ELSE
185500                       MOVE 33         TO PPS-RTC
185600                    END-IF
185700                 END-IF
185800              ELSE
185900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
186000                    MOVE 07            TO PPS-RTC
186100                 ELSE
186200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
186300                       MOVE 06         TO PPS-RTC
186400                    ELSE
186500                       IF ONSET-TRACK         = "Y"  THEN
186600                          MOVE 09      TO PPS-RTC
186700                       ELSE
186800                          MOVE 03      TO PPS-RTC
186900                       END-IF
187000                    END-IF
187100                 END-IF
187200              END-IF
187300           END-IF
187400        ELSE
187500           IF LOW-VOLUME-TRACK                = "Y"
187600              IF TRAINING-TRACK               = "Y"  THEN
187700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
187800                    MOVE 26            TO PPS-RTC
187900                 ELSE
188000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
188100                       MOVE 21         TO PPS-RTC
188200                    ELSE
188300                       MOVE 12         TO PPS-RTC
188400                    END-IF
188500                 END-IF
188600              ELSE
188700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
188800                    MOVE 25            TO PPS-RTC
188900                 ELSE
189000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
189100                       MOVE 20         TO PPS-RTC
189200                    ELSE
189300                       IF ONSET-TRACK         = "Y"  THEN
189400                          MOVE 32      TO PPS-RTC
189500                       ELSE
189600                          MOVE 10      TO PPS-RTC
189700                       END-IF
189800                    END-IF
189900                 END-IF
190000              END-IF
190100           ELSE
190200              IF TRAINING-TRACK               = "Y"  THEN
190300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
190400                    MOVE 27            TO PPS-RTC
190500                 ELSE
190600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
190700                       MOVE 22         TO PPS-RTC
190800                    ELSE
190900                       MOVE 11         TO PPS-RTC
191000                    END-IF
191100                 END-IF
191200              ELSE
191300                 IF ONSET-TRACK               = "Y"  THEN
191400                    MOVE 08            TO PPS-RTC
191500                 ELSE
191600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
191700                       MOVE 04         TO PPS-RTC
191800                    ELSE
191900                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
192000                          MOVE 05      TO PPS-RTC
192100                       ELSE
192200                          IF LOW-BMI-TRACK = "Y"  THEN
192300                             MOVE 31 TO PPS-RTC
192400                          ELSE
192500                             MOVE 02 TO PPS-RTC
192600                          END-IF
192700                       END-IF
192800                    END-IF
192900                 END-IF
193000              END-IF
193100           END-IF
193200        END-IF
193300     END-IF.
193400/
193500 9100-MOVE-RESULTS.
193600     IF MOVED-CORMORBIDS = SPACES  THEN
193700        NEXT SENTENCE
193800     ELSE
193900        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
194000        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
194100        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
194200        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
194300        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
194400        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
194500        MOVE H-COMORBID-CWF-CODE       TO
194600                                    COMORBID-CWF-RETURN-CODE
194700     END-IF.
194800
194900     MOVE P-GEO-MSA                    TO PPS-MSA.
195000     MOVE P-GEO-CBSA                   TO PPS-CBSA.
195100     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
195200     MOVE B-COND-CODE                  TO PPS-COND-CODE.
195300     MOVE B-REV-CODE                   TO PPS-REV-CODE.
195400     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
195500     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
195600     MOVE BUN-NAT-NONLABOR-PCT         TO
195700                                    PPS-2011-NAT-NONLABOR-PCT.
195800     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
195900     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
196000     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
196100     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
196200     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
196300     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
196400     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
196500     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
196600     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
196700     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
196800                                    PPS-2011-BDGT-NEUT-RATE.
196900     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
197000     MOVE SPACES                       TO
197100                                    PPS-2011-COMORBID-MA-CC.
197200
197300     IF (B-COND-CODE = '74')  AND
197400        (B-REV-CODE = '0841' OR '0851')  THEN
197500         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
197600                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
197700     END-IF.
197800
197900     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
198000           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
198100              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
198200           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
198300              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
198400           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
198500              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
198600     ELSE
198700        MOVE ZERO                      TO
198800                                    PPS-2011-BLEND-COMP-RATE
198900        MOVE ZERO                      TO
199000                                    PPS-2011-BLEND-PPS-RATE
199100        MOVE ZERO                      TO
199200                                    PPS-2011-BLEND-OUTLIER-RATE
199300     END-IF.
199400
199500     MOVE H-PYMT-AMT                   TO
199600                                    PPS-2011-FULL-COMP-RATE.
199700     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
199800                                          PPS-FINAL-PAY-AMT.
199900     MOVE H-OUT-PAYMENT                TO
200000                                    PPS-2011-FULL-OUTLIER-RATE.
200100
200200
200300     IF P-QIP-REDUCTION = ' ' THEN
200400        NEXT SENTENCE
200500     ELSE
200600        COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
200700                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
200800        COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
200900                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
201000        COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
201100                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
201200        COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
201300                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
201400        COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
201500                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
201600        COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
201700                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
201800     END-IF.
201900
202000     IF BUNDLED-TEST   THEN
202100        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
202200        MOVE 0.0                       TO MSA-WAGE-ADJ
202300        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
202400        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
202500        MOVE H-PATIENT-AGE             TO AGE-RETURN
202600        MOVE 0.0                       TO MSA-WAGE-AMT
202700        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
202800        MOVE H-BMI                     TO PPS-BMI
202900        MOVE H-BSA                     TO PPS-BSA
203000        MOVE MSA-BLEND-PCT             TO MSA-PCT
203100        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
203200
203300        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
203400           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
203500           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
203600        ELSE
203700           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
203800           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
203900        END-IF
204000
204100        MOVE H-BUN-BSA                 TO BUN-BSA
204200        MOVE H-BUN-BMI                 TO BUN-BMI
204300        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
204400        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
204500        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
204600        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
204700        MOVE H-OUT-BSA                 TO OUT-BSA
204800        MOVE SB-BSA                    TO OUT-SB-BSA
204900        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
205000        MOVE H-OUT-BMI                 TO OUT-BMI
205100        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
205200        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
205300        MOVE H-OUT-COMORBID-MULTIPLIER TO
205400                                    OUT-COMORBID-MULTIPLIER
205500        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
205600                                    OUT-PREDICTED-SERVICES-MAP
205700        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
205800                                    OUT-CASE-MIX-PREDICTED-MAP
205900        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
206000                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
206100        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
206200        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
206300        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
206400        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
206500        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
206600        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
206700        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
206800        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
206900        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
207000        MOVE CM-BSA                    TO PPS-CM-BSA
207100        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
207200        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
207300        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
207400        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
207500                                    BUN-ADJUSTED-BASE-WAGE-AMT
207600        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
207700                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
207800        MOVE TRAINING-ADD-ON-PMT-AMT   TO
207900                                    PPS-TRAINING-ADD-ON-PMT-AMT
208000        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
208100     END-IF.
208200******        L A S T   S O U R C E   S T A T E M E N T      *****
