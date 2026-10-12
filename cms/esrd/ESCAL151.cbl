000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL151.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2015
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
023600* List of changes for CY 2015 -->
023700*      - ESRD PPS base rate
023800*          Changed BUNDLED-BASE-PMT-RATE to 239.43.
023900*           includes Wage Index Budget Neutrality Adjustment
024000*           Factor of 1.001729
024100*      - Labor-related share
024200*          Changed BUN-NAT-LABOR-PCT to 0.46205
024300*           Implementation of the revised
024400*           labor-related share with a 50/50
024500*           blend under a 2-year transition
024600*           results in a labor-related share
024700*           value of 46.205 percent for CY 2015.
024800*      - Non-labor-related share
024900*          Changed BUN-NAT-NONLABOR-PCT to 0.53795
025000*           Non-labor-related share =
025100*            1 - Labor-related share
025200*      - Changed ADJ-AVG-MAP-AMT-GT-17 to 51.29.
025300*          For adult patients, the adjusted
025400*          average outlier service MAP
025500*          amount per treatment
025600*      - Changed ADJ-AVG-MAP-AMT-LT-18 to 43.57.
025700*          For pediatric patients, the
025800*          adjusted average outlier service
025900*          MAP amount per treatment
026000*      - Changed FIX-DOLLAR-LOSS-GT-17 to 86.19.
026100*          The fixed dollar loss amount for adult patients
026200*      - Changed FIX-DOLLAR-LOSS-LT-18 to 54.35.
026300*          The fixed dollar loss amount for pediatric patients
026400* 12/23/14 ESCAL151 WASN'T CHANGED EXCEPT TO ALLOW FOR NEW VERSION
026410* DUE TO CHANGES TO ESDRV151 TO IMPLEMENT SEARCH FOR SPECIAL WAGE
026420* INDEXES FOR CHILDREN'S HOSPITALS
026500******************************************************************
026600 DATE-COMPILED.
026700 ENVIRONMENT DIVISION.
026800 CONFIGURATION SECTION.
026900 SOURCE-COMPUTER.            IBM-Z990.
027000 OBJECT-COMPUTER.            IBM-Z990.
027100 INPUT-OUTPUT  SECTION.
027200 FILE-CONTROL.
027300
027400 DATA DIVISION.
027500 FILE SECTION.
027600/
027700 WORKING-STORAGE SECTION.
027800 01  W-STORAGE-REF                  PIC X(46) VALUE
027900     'ESCAL151      - W O R K I N G   S T O R A G E'.
028000 01  CAL-VERSION                    PIC X(05) VALUE 'C15.1'.
028100
028200 01  DISPLAY-LINE-MEASUREMENT.
028300     05  FILLER                     PIC X(50) VALUE
028400         '....:...10....:...20....:...30....:...40....:...50'.
028500     05  FILLER                     PIC X(50) VALUE
028600         '....:...60....:...70....:...80....:...90....:..100'.
028700     05  FILLER                     PIC X(20) VALUE
028800         '....:..110....:..120'.
028900
029000 01  PRINT-LINE-MEASUREMENT.
029100     05  FILLER                     PIC X(51) VALUE
029200         'X....:...10....:...20....:...30....:...40....:...50'.
029300     05  FILLER                     PIC X(50) VALUE
029400         '....:...60....:...70....:...80....:...90....:..100'.
029500     05  FILLER                     PIC X(32) VALUE
029600         '....:..110....:..120....:..130..'.
029700/
029800******************************************************************
029900*  This area contains all of the old Composite Rate variables.   *
030000* They will be eliminated when the transition period ends - 2014 *
030100******************************************************************
030200 01  HOLD-COMP-RATE-PPS-COMPONENTS.
030300     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
030400     05  H-PYMT-AMT                 PIC 9(04)V9(02).
030500     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
030600     05  H-PATIENT-AGE              PIC 9(03).
030700     05  H-AGE-FACTOR               PIC 9(01)V9(03).
030800     05  H-BSA-FACTOR               PIC 9(01)V9(04).
030900     05  H-BMI-FACTOR               PIC 9(01)V9(04).
031000     05  H-BSA                      PIC 9(03)V9(04).
031100     05  H-BMI                      PIC 9(03)V9(04).
031200     05  HGT-PART                   PIC 9(04)V9(08).
031300     05  WGT-PART                   PIC 9(04)V9(08).
031400     05  COMBINED-PART              PIC 9(04)V9(08).
031500     05  CALC-BSA                   PIC 9(04)V9(08).
031600
031700
031800* The following two variables will change from year to year
031900* and are used for the COMPOSITE part of the Bundled Pricer.
032000 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
032100 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
032200
032300* The next two percentages MUST add up to 1 (i.e. 100%)
032400* They will continue to change until CY2009 when CBSA will be 1.00
032500 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
032600 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
032700
032800* CONSTANTS AREA
032900* The next two percentages MUST add up TO 1 (i.e. 100%)
033000 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
033100 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
033200
033300* The next variable is only applicapable for the 2011 Pricer.
033400 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
033500
033600 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
033700 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
033800 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
033900                                                         0.428571.
034000* The above number technically represents the fractional
034100* number 3/7 which is three days per week that a person can
034200* receive dialysis.  It will remain this value ONLY for the
034300* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
034400* use the calculation method which is more understandable and
034500* follows the method used by the Policy folks.
034600
034700*  The following number that is loaded into the payment equation
034800*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
034900*  and   --DOES NOT CHANGE--
035000
035100 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
035200
035300 01  COMPOSITE-RATE-MULTIPLIERS.
035400*Composite rate payment multiplier (used for blended providers)
035500     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
035600     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
035700     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
035800     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
035900     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
036000     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
036100
036200     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
036300     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
036400/
036500******************************************************************
036600*    This area contains all of the NEW Bundled Rate variables.   *
036700******************************************************************
036800 01  HOLD-BUNDLED-PPS-COMPONENTS.
036900     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
037000     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
037100     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
037200     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
037300     05  H-BUN-BSA                  PIC 9(03)V9(04).
037400     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
037500     05  H-BUN-BMI                  PIC 9(03)V9(04).
037600     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
037700     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
037800     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
037900     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
038000                                    PIC 9(07)V9(04).
038100     05  H-BUN-WAGE-ADJ-TRAINING-AMT
038200                                    PIC 9(07)V9(04).
038300     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
038400     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
038500     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
038600     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
038700     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
038800                                    PIC 9(07)V9(04).
038900     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
039000     05  H-LV-OUT-PREDICT-SERVICES-MAP
039100                                    PIC 9(07)V9(04).
039200     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
039300                                    PIC 9(07)V9(04).
039400     05  H-LV-OUT-PREDICTED-MAP
039500                                    PIC 9(07)V9(04).
039600     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
039700
039800     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
039900     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
040000         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
040100
040200     05  H-COMORBID-DATA  OCCURS 6 TIMES
040300            INDEXED BY H-COMORBID-INDEX
040400                                    PIC X(02).
040500     05  H-COMORBID-CWF-CODE        PIC X(02).
040600
040700     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
040800
040900     05  QIP-REDUCTION              PIC 9(01)V9(03).
041000     05  SUB                        PIC 9(04).
041100
041200     05  THE-DATE                   PIC 9(08).
041300     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
041400     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
041500     05  ONSET-DATE                 PIC 9(08).
041600     05  MOVED-CORMORBIDS           PIC X(01).
041700
041800 01  HOLD-OUTLIER-PPS-COMPONENTS.
041900     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
042000     05  H-OUT-BSA                  PIC 9(03)V9(04).
042100     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
042200     05  H-OUT-BMI                  PIC 9(03)V9(04).
042300     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
042400     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
042500     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
042600     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
042700     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
042800     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
042900     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
043000     05  H-OUT-PREDICTED-SERVICES-MAP
043100                                    PIC 9(07)V9(04).
043200     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
043300     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
043400                                    PIC 9(07)V9(04).
043500     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
043600     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
043700     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
043800
043900
044000* The following variable will change from year to year and is
044100* used for the BUNDLED part of the Bundled Pricer.
044200 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 239.43.
044300
044400* The next two percentages MUST add up to 1 (i.e. 100%)
044500* They start in 2011 and will continue to change until CY2014 when
044600* BUN-CBSA-BLEND-PCT will be 1.00
044700* The third blend percent is for those providers that waived the
044800* blended percent and went to full PPS.  This variable will be
044900* eliminated in 2014 when it is no longer needed.
045000 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
045100 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
045200 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
045300
045400* CONSTANTS AREA
045500* The next two percentages MUST add up TO 1 (i.e. 100%)
045600 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.46205.
045700 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.53795.
045800 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 50.16.
045900
046000*  The following number that is loaded into the payment equation
046100*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
046200*  and   --DOES NOT CHANGE--
046300
046400 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
046500
046600 01  PEDIATRIC-MULTIPLIERS.
046700*Separately billable payment multiplier (used for outliers)
046800     05  PED-SEP-BILL-PAY-MULTI.
046900         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.319.
047000         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.185.
047100         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.476.
047200         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.459.
047300     05  PED-EXPAND-BUNDLE-PAY-MULTI.
047400*Expanded bundle payment multiplier (used for normal billing)
047500         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.033.
047600         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.219.
047700         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.067.
047800         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.277.
047900
048000 01  ADULT-MULTIPLIERS.
048100*Separately billable payment multiplier (used for outliers)
048200     05  SEP-BILLABLE-PAYMANT-MULTI.
048300         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 0.996.
048400         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 0.992.
048500         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
048600         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 0.963.
048700         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.915.
048800         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.014.
048900         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.078.
049000         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.450.
049100         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.354.
049200         10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
049300         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.571.
049400         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.225.
049500         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.309.
049600         10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
049700         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.975.
049800*Case-Mix adjusted payment multiplier (used for normal billing)
049900     05  CASE-MIX-PAYMENT-MULTI.
050000         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.171.
050100         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.013.
050200         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
050300         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.011.
050400         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.016.
050500         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.020.
050600         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.025.
050700         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.510.
050800         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.114.
050900         10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
051000         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.183.
051100         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.072.
051200         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.099.
051300         10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
051400         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.189.
051500
051600 01  OUTLIER-SB-CALC-AMOUNTS.
051700     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 43.57.
051800     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 51.29.
051900     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 54.35.
052000     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 86.19.
052100     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
052200     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
052300/
052400******************************************************************
052500*    This area contains return code variables and their codes.   *
052600******************************************************************
052700 01 PAID-RETURN-CODE-TRACKERS.
052800     05  OUTLIER-TRACK              PIC X(01).
052900     05  ACUTE-COMORBID-TRACK       PIC X(01).
053000     05  CHRONIC-COMORBID-TRACK     PIC X(01).
053100     05  ONSET-TRACK                PIC X(01).
053200     05  LOW-VOLUME-TRACK           PIC X(01).
053300     05  TRAINING-TRACK             PIC X(01).
053400     05  PEDIATRIC-TRACK            PIC X(01).
053500     05  LOW-BMI-TRACK              PIC X(01).
053600 COPY RTCCPY.
053700*COPY "RTCCPY.CPY".
053800*                                                                *
053900*  Legal combinations of adjustments for ADULTS are:             *
054000*     if NO ONSET applies, then they can have any combination of:*
054100*       acute OR chronic comorbid, & outlier, low vol., training.*
054200*     if ONSET applies, then they can have:                      *
054300*           outlier and/or low volume.                           *
054400*  Legal combinations of adjustments for PEDIATRIC are:          *
054500*     outlier and/or training.                                   *
054600*                                                                *
054700*  Illegal combinations of adjustments for PEDIATRIC are:        *
054800*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
054900*     onset     with comorbid or training.                       *
055000*  Illegal combinations of adjustments for ANYONE are:           *
055100*     acute comorbid AND chronic comorbid.                       *
055200/
055300 LINKAGE SECTION.
055400 COPY BILLCPY.
055500*COPY "BILLCPY.CPY".
055600/
055700 COPY WAGECPY.
055800*COPY "WAGECPY.CPY".
055900/
056000 PROCEDURE DIVISION  USING BILL-NEW-DATA
056100                           PPS-DATA-ALL
056200                           WAGE-NEW-RATE-RECORD
056300                           COM-CBSA-WAGE-RECORD
056400                           BUN-CBSA-WAGE-RECORD.
056500
056600******************************************************************
056700* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
056800* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
056900* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
057000* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
057100* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
057200* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
057300* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
057400* PROCESSING (DICP).                                             *
057500*                                                                *
057600*                                                                *
057700*    PROCESSING:                                                 *
057800*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
057900*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
058000*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
058100*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
058200*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
058300*           GOBACK.                                              *
058400*        D. ASSEMBLE PRICING COMPONENTS.                         *
058500*        E. CALCULATE THE PRICE.                                 *
058600******************************************************************
058700
058800 0000-START-TO-FINISH.
058900     INITIALIZE PPS-DATA-ALL.
059000
059100* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
059200     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
059300
059400     IF BUNDLED-TEST THEN
059500        INITIALIZE BILL-DATA-TEST
059600        INITIALIZE COND-CD-73
059700     END-IF.
059800     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
059900     MOVE ZEROS                        TO PPS-RTC.
060000
060100     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
060200
060300     IF PPS-RTC = 00  THEN
060400        PERFORM 1200-INITIALIZATION
060500**Calculate patient age
060600        COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
060700        IF B-DOB-MM > B-THRU-MM  THEN
060800           COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
060900        END-IF
061000        IF H-PATIENT-AGE < 18  THEN
061100           MOVE "Y"                    TO PEDIATRIC-TRACK
061200        END-IF
061300        PERFORM 2000-CALCULATE-BUNDLED-FACTORS
061400        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
061500           PERFORM 5000-CALC-COMP-RATE-FACTORS
061600        END-IF
061700        PERFORM 9000-SET-RETURN-CODE
061800        PERFORM 9100-MOVE-RESULTS
061900     END-IF.
062000
062100     GOBACK.
062200/
062300 1000-VALIDATE-BILL-ELEMENTS.
062400     IF P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
062500        NEXT SENTENCE
062600     ELSE
062700        MOVE 52                        TO PPS-RTC
062800     END-IF.
062900
063000     IF PPS-RTC = 00  THEN
063100        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
063200           MOVE 53                     TO PPS-RTC
063300        END-IF
063400     END-IF.
063500
063600     IF PPS-RTC = 00  THEN
063700        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
063800           MOVE 54                     TO PPS-RTC
063900        END-IF
064000     END-IF.
064100
064200     IF PPS-RTC = 00  THEN
064300        IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
064400           MOVE 55                     TO PPS-RTC
064500        END-IF
064600     END-IF.
064700
064800     IF PPS-RTC = 00  THEN
064900        IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
065000           MOVE 56                     TO PPS-RTC
065100        END-IF
065200     END-IF.
065300
065400     IF PPS-RTC = 00  THEN
065500        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
065600                                OR '0881'
065700           NEXT SENTENCE
065800        ELSE
065900           MOVE 57                     TO PPS-RTC
066000        END-IF
066100     END-IF.
066200
066300     IF PPS-RTC = 00  THEN
066400        IF B-COND-CODE NOT = '73' AND '74' AND '  '
066500           MOVE 58                     TO PPS-RTC
066600        END-IF
066700     END-IF.
066800
066900     IF PPS-RTC = 00  THEN
067000        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
067100                                 ' '  THEN
067200           MOVE 53                     TO PPS-RTC
067300*  This RTC is for the Special Payment Indicator not = '1' or
067400*  blank, which closely approximates the intent of the edit check.
067500*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
067600        END-IF
067700     END-IF.
067800
067900     IF PPS-RTC = 00  THEN
068000        IF B-PATIENT-HGT > 300.00
068100           MOVE 71                     TO PPS-RTC
068200        END-IF
068300     END-IF.
068400
068500     IF PPS-RTC = 00  THEN
068600        IF B-PATIENT-WGT > 500.00  THEN
068700           MOVE 72                     TO PPS-RTC
068800        END-IF
068900     END-IF.
069000
069100* Before 2012 pricer, put in edit check to make sure that the
069200* # of sesions does not exceed the # of days in a month.  Maybe
069300* the # of cays in a month minus one when patient goes into a
069400* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
069500* or 0851)).  If done, then will need extra RTC.
069600     IF PPS-RTC = 00  THEN
069700        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
069800           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
069900           MOVE 73                     TO PPS-RTC
070000        END-IF
070100     END-IF.
070200
070300     IF PPS-RTC = 00  THEN
070400        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
070500           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
070600           MOVE 74                     TO PPS-RTC
070700        END-IF
070800     END-IF.
070900
071000     IF PPS-RTC = 00  THEN
071100        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
071200           MOVE 75                     TO PPS-RTC
071300        END-IF
071400     END-IF.
071500
071600     IF PPS-RTC = 00  THEN
071700        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
071800           MOVE 76                     TO PPS-RTC
071900        END-IF
072000     END-IF.
072100
072200     IF PPS-RTC = 00  THEN
072300        IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
072400            VALID-COMORBID-CWF-RETURN-CD       THEN
072500           NEXT SENTENCE
072600        ELSE
072700           MOVE 81                     TO PPS-RTC
072800        END-IF
072900     END-IF.
073000/
073100 1200-INITIALIZATION.
073200     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
073300     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
073400     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
073500     INITIALIZE PAID-RETURN-CODE-TRACKERS.
073600
073700     MOVE SPACES                       TO MOVED-CORMORBIDS.
073800
073900     IF P-QIP-REDUCTION = ' '  THEN
074000* no reduction
074100        MOVE 1.000 TO QIP-REDUCTION
074200     ELSE
074300        IF P-QIP-REDUCTION = '1'  THEN
074400* one-half percent reduction
074500           MOVE 0.995 TO QIP-REDUCTION
074600        ELSE
074700           IF P-QIP-REDUCTION = '2'  THEN
074800* one percent reduction
074900              MOVE 0.990 TO QIP-REDUCTION
075000           ELSE
075100              IF P-QIP-REDUCTION = '3'  THEN
075200* one and one-half percent reduction
075300                 MOVE 0.985 TO QIP-REDUCTION
075400              ELSE
075500* two percent reduction
075600                 MOVE 0.980 TO QIP-REDUCTION
075700              END-IF
075800           END-IF
075900        END-IF
076000     END-IF.
076100
076200*    Since pricer has to pay a comorbid condition according to the
076300* return code that CWF passes back, it is cleaner if the pricer
076400* sets aside whatever comorbid data exists on the line-item when
076500* it comes into the pricer and then transferrs the CWF code to
076600* the appropriate place in the comorbid data.  This avoids
076700* making convoluted changes in the other parts of the program
076800* which has to look at both original comorbid data AND CWF return
076900* codes to handle comorbids.  Near the end of the program where
077000* variables are transferred to the output, the original comorbid
077100* data is put back into its original place as though nothing
077200* occurred.
077300     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
077400        NEXT SENTENCE
077500     ELSE
077600        MOVE 'Y'                       TO MOVED-CORMORBIDS
077700        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
077800        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
077900        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
078000        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
078100        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
078200        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
078300        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
078400        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
078500           MOVE SPACES                 TO COMORBID-DATA (1)
078600                                          COMORBID-DATA (2)
078700                                          COMORBID-DATA (3)
078800                                          COMORBID-DATA (4)
078900                                          COMORBID-DATA (5)
079000                                          COMORBID-DATA (6)
079100                                          COMORBID-CWF-RETURN-CODE
079200        ELSE
079300           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
079400              MOVE 'MA'                TO COMORBID-DATA (1)
079500              MOVE SPACES              TO COMORBID-DATA (2)
079600                                          COMORBID-DATA (3)
079700                                          COMORBID-DATA (4)
079800                                          COMORBID-DATA (5)
079900                                          COMORBID-DATA (6)
080000                                          COMORBID-CWF-RETURN-CODE
080100           ELSE
080200              IF COMORBID-CWF-RETURN-CODE = '30'  THEN
080300                 MOVE SPACES           TO COMORBID-DATA (1)
080400                 MOVE 'MB'             TO COMORBID-DATA (2)
080500                 MOVE SPACES           TO COMORBID-DATA (3)
080600                 MOVE SPACES           TO COMORBID-DATA (4)
080700                 MOVE SPACES           TO COMORBID-DATA (5)
080800                 MOVE SPACES           TO COMORBID-DATA (6)
080900                                          COMORBID-CWF-RETURN-CODE
081000              ELSE
081100                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
081200                    MOVE SPACES        TO COMORBID-DATA (1)
081300                    MOVE SPACES        TO COMORBID-DATA (2)
081400                    MOVE 'MC'          TO COMORBID-DATA (3)
081500                    MOVE SPACES        TO COMORBID-DATA (4)
081600                    MOVE SPACES        TO COMORBID-DATA (5)
081700                    MOVE SPACES        TO COMORBID-DATA (6)
081800                                          COMORBID-CWF-RETURN-CODE
081900                 ELSE
082000                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
082100                       MOVE SPACES     TO COMORBID-DATA (1)
082200                       MOVE SPACES     TO COMORBID-DATA (2)
082300                       MOVE SPACES     TO COMORBID-DATA (3)
082400                       MOVE 'MD'       TO COMORBID-DATA (4)
082500                       MOVE SPACES     TO COMORBID-DATA (5)
082600                       MOVE SPACES     TO COMORBID-DATA (6)
082700                                          COMORBID-CWF-RETURN-CODE
082800                    ELSE
082900                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
083000                          MOVE SPACES  TO COMORBID-DATA (1)
083100                          MOVE SPACES  TO COMORBID-DATA (2)
083200                          MOVE SPACES  TO COMORBID-DATA (3)
083300                          MOVE SPACES  TO COMORBID-DATA (4)
083400                          MOVE 'ME'    TO COMORBID-DATA (5)
083500                          MOVE SPACES  TO COMORBID-DATA (6)
083600                                          COMORBID-CWF-RETURN-CODE
083700                       ELSE
083800                          MOVE SPACES  TO COMORBID-DATA (1)
083900                                          COMORBID-DATA (2)
084000                                          COMORBID-DATA (3)
084100                                          COMORBID-DATA (4)
084200                                          COMORBID-DATA (5)
084300                                          COMORBID-CWF-RETURN-CODE
084400                          MOVE 'MF'    TO COMORBID-DATA (6)
084500                       END-IF
084600                    END-IF
084700                 END-IF
084800              END-IF
084900           END-IF
085000        END-IF
085100     END-IF.
085200
085300******************************************************************
085400***Calculate BUNDLED Wage Adjusted Rate (note different method)***
085500******************************************************************
085600     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
085700        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
085800         BUN-CBSA-W-INDEX.
085900
086000     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
086100        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
086200
086300     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
086400        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
086500/
086600 2000-CALCULATE-BUNDLED-FACTORS.
086700******************************************************************
086800***  Set BUNDLED age adjustment factor                         ***
086900******************************************************************
087000     IF H-PATIENT-AGE < 13  THEN
087100        IF B-REV-CODE = '0821' OR '0881' THEN
087200           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
087300        ELSE
087400           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
087500        END-IF
087600     ELSE
087700        IF H-PATIENT-AGE < 18 THEN
087800           IF B-REV-CODE = '0821' OR '0881' THEN
087900              MOVE EB-AGE-13-17-HEMO-MODE
088000                                       TO H-BUN-AGE-FACTOR
088100           ELSE
088200              MOVE EB-AGE-13-17-PD-MODE
088300                                       TO H-BUN-AGE-FACTOR
088400           END-IF
088500        ELSE
088600           IF H-PATIENT-AGE < 45  THEN
088700              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
088800           ELSE
088900              IF H-PATIENT-AGE < 60  THEN
089000                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
089100              ELSE
089200                 IF H-PATIENT-AGE < 70  THEN
089300                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
089400                 ELSE
089500                    IF H-PATIENT-AGE < 80  THEN
089600                       MOVE CM-AGE-70-79
089700                                       TO H-BUN-AGE-FACTOR
089800                    ELSE
089900                       MOVE CM-AGE-80-PLUS
090000                                       TO H-BUN-AGE-FACTOR
090100                    END-IF
090200                 END-IF
090300              END-IF
090400           END-IF
090500        END-IF
090600     END-IF.
090700
090800******************************************************************
090900***  Calculate BUNDLED BSA factor (note NEW formula)           ***
091000******************************************************************
091100     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
091200         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
091300
091400     IF H-PATIENT-AGE > 17  THEN
091500        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
091600             CM-BSA ** ((H-BUN-BSA - 1.87) / .1)
091700     ELSE
091800        MOVE 1.000                     TO H-BUN-BSA-FACTOR
091900     END-IF.
092000
092100******************************************************************
092200***  Calculate BUNDLED BMI factor                              ***
092300******************************************************************
092400     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
092500         (B-PATIENT-HGT ** 2)) * 10000.
092600
092700     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
092800        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
092900        MOVE "Y"                       TO LOW-BMI-TRACK
093000     ELSE
093100        MOVE 1.000                     TO H-BUN-BMI-FACTOR
093200     END-IF.
093300
093400******************************************************************
093500***  Calculate BUNDLED ONSET factor                            ***
093600******************************************************************
093700     IF B-DIALYSIS-START-DATE > ZERO  THEN
093800        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
093900        COMPUTE INTEGER-LINE-ITEM-DATE =
094000            FUNCTION INTEGER-OF-DATE(THE-DATE)
094100        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
094200        COMPUTE INTEGER-DIALYSIS-DATE  =
094300            FUNCTION INTEGER-OF-DATE(THE-DATE)
094400* Need to add one to onset-date because the start date should
094500* be included in the count of days.  fix made 9/6/2011
094600        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
094700                              INTEGER-DIALYSIS-DATE) + 1
094800        IF H-PATIENT-AGE > 17  THEN
094900           IF ONSET-DATE > 120  THEN
095000              MOVE 1                   TO H-BUN-ONSET-FACTOR
095100           ELSE
095200              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
095300              MOVE "Y"                 TO ONSET-TRACK
095400           END-IF
095500        ELSE
095600           MOVE 1                      TO H-BUN-ONSET-FACTOR
095700        END-IF
095800     ELSE
095900        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
096000     END-IF.
096100
096200******************************************************************
096300***  Set BUNDLED Co-morbidities adjustment                     ***
096400******************************************************************
096500     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
096600        IF H-PATIENT-AGE  <  18  THEN
096700           MOVE 1.000                  TO
096800                                       H-BUN-COMORBID-MULTIPLIER
096900           MOVE '10'                   TO PPS-2011-COMORBID-PAY
097000        ELSE
097100           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
097200              MOVE 1.000               TO
097300                                       H-BUN-COMORBID-MULTIPLIER
097400              MOVE '10'                TO PPS-2011-COMORBID-PAY
097500           ELSE
097600              PERFORM 2100-CALC-COMORBID-ADJUST
097700              MOVE H-COMORBID-MULTIPLIER TO
097800                                       H-BUN-COMORBID-MULTIPLIER
097900           END-IF
098000        END-IF
098100     ELSE
098200        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
098300           MOVE 1.000                  TO
098400                                       H-BUN-COMORBID-MULTIPLIER
098500           MOVE '10'                   TO PPS-2011-COMORBID-PAY
098600        ELSE
098700           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
098800              MOVE CM-GI-BLEED         TO
098900                                       H-BUN-COMORBID-MULTIPLIER
099000              MOVE '20'                TO PPS-2011-COMORBID-PAY
099100           ELSE
099200              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
099300                 MOVE CM-PNEUMONIA     TO
099400                                       H-BUN-COMORBID-MULTIPLIER
099500                 MOVE '30'             TO PPS-2011-COMORBID-PAY
099600              ELSE
099700                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
099800                    MOVE CM-PERICARDITIS TO
099900                                       H-BUN-COMORBID-MULTIPLIER
100000                    MOVE '40'          TO PPS-2011-COMORBID-PAY
100100                 END-IF
100200              END-IF
100300           END-IF
100400        END-IF
100500     END-IF.
100600
100700******************************************************************
100800***  Calculate BUNDLED Low Volume adjustment                   ***
100900******************************************************************
101000     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
101100        IF H-PATIENT-AGE > 17  THEN
101200           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
101300                                       H-BUN-LOW-VOL-MULTIPLIER
101400           MOVE "Y"                    TO  LOW-VOLUME-TRACK
101500        ELSE
101600           MOVE 1.000                  TO
101700                                       H-BUN-LOW-VOL-MULTIPLIER
101800        END-IF
101900     ELSE
102000        MOVE 1.000                     TO
102100                                       H-BUN-LOW-VOL-MULTIPLIER
102200     END-IF.
102300
102400******************************************************************
102500***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
102600******************************************************************
102700     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
102800        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
102900        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
103000        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
103100        (H-BUN-LOW-VOL-MULTIPLIER).
103200
103300******************************************************************
103400***  Calculate BUNDLED Condition Code payment                  ***
103500******************************************************************
103600* Self-care in Training add-on
103700     IF B-COND-CODE = '73'  THEN
103800* no add-on when onset is present
103900        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
104000           MOVE ZERO                   TO
104100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
104200        ELSE
104300* use new PPS training add-on amount times wage-index
104400           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
104500             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
104600           MOVE "Y"                    TO TRAINING-TRACK
104700        END-IF
104800     ELSE
104900* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
105000        IF (B-COND-CODE = '74')  AND
105100           (B-REV-CODE = '0841' OR '0851')  THEN
105200              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
105300                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
105400        ELSE
105500           MOVE ZERO                   TO
105600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
105700                                    H-CC-74-PER-DIEM-AMT
105800        END-IF
105900     END-IF.
106000
106100******************************************************************
106200***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
106300******************************************************************
106400     IF (B-COND-CODE = '74')  AND
106500        (B-REV-CODE = '0841' OR '0851')  THEN
106600           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
106700                           H-CC-74-PER-DIEM-AMT
106800           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
106900              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
107000              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
107100     ELSE
107200        COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
107300                H-BUN-ADJUSTED-BASE-WAGE-AMT  +
107400                H-BUN-WAGE-ADJ-TRAINING-AMT
107500     END-IF.
107600
107700******************************************************************
107800***  Calculate BUNDLED Outlier                                 ***
107900******************************************************************
108000     PERFORM 2500-CALC-OUTLIER-FACTORS.
108100
108200******************************************************************
108300***  Calculate Low Volume payment for recovery purposes        ***
108400******************************************************************
108500     IF LOW-VOLUME-TRACK = "Y"  THEN
108600        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
108700        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
108800
108900        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
109000           H-PPS-FINAL-PAY-AMT
109100
109200        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
109300           H-OUT-PAYMENT
109400
109500        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
109600           H-LV-OUT-PAYMENT
109700
109800        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
109900           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
110000              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
110100        ELSE
110200           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
110300        END-IF
110400     END-IF.
110500
110600
110700/
110800 2100-CALC-COMORBID-ADJUST.
110900******************************************************************
111000***  Calculate Co-morbidities adjustment                       ***
111100******************************************************************
111200*  This logic assumes that the comorbids are randomly assigned   *
111300*to the comorbid table.  It will select the highest comorbid for *
111400*payment if one is found.                                        *
111500******************************************************************
111600     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
111700     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
111800     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
111900
112000     PERFORM VARYING  SUB  FROM  1 BY 1
112100       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
112200         IF COMORBID-DATA (SUB) = 'MA'  THEN
112300           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
112400           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
112500           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
112600           MOVE '20'                   TO PPS-2011-COMORBID-PAY
112700         ELSE
112800           IF COMORBID-DATA (SUB) = 'MB'  THEN
112900             IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
113000               MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
113100               MOVE "Y"                TO ACUTE-COMORBID-TRACK
113200               MOVE '30'               TO PPS-2011-COMORBID-PAY
113300             END-IF
113400           ELSE
113500             IF COMORBID-DATA (SUB) = 'MC'  THEN
113600                IF CM-PERICARDITIS  >
113700                                      H-COMORBID-MULTIPLIER  THEN
113800                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
113900                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
114000                  MOVE '40'            TO PPS-2011-COMORBID-PAY
114100                END-IF
114200             ELSE
114300               IF COMORBID-DATA (SUB) = 'MD'  THEN
114400                 IF CM-MYELODYSPLASTIC  >
114500                                      H-COMORBID-MULTIPLIER  THEN
114600                   MOVE CM-MYELODYSPLASTIC  TO
114700                                      H-COMORBID-MULTIPLIER
114800                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
114900                   MOVE '50'           TO PPS-2011-COMORBID-PAY
115000                 END-IF
115100               ELSE
115200                 IF COMORBID-DATA (SUB) = 'ME'  THEN
115300                   IF CM-SICKEL-CELL  >
115400                                      H-COMORBID-MULTIPLIER  THEN
115500                     MOVE CM-SICKEL-CELL  TO
115600                                      H-COMORBID-MULTIPLIER
115700                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
115800                     MOVE '60'         TO PPS-2011-COMORBID-PAY
115900                   END-IF
116000                 ELSE
116100                   IF COMORBID-DATA (SUB) = 'MF'  THEN
116200                     IF CM-MONOCLONAL-GAMM  >
116300                                      H-COMORBID-MULTIPLIER  THEN
116400                       MOVE CM-MONOCLONAL-GAMM TO
116500                                      H-COMORBID-MULTIPLIER
116600                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
116700                       MOVE '70'       TO PPS-2011-COMORBID-PAY
116800                     END-IF
116900                   END-IF
117000                 END-IF
117100               END-IF
117200             END-IF
117300           END-IF
117400         END-IF
117500     END-PERFORM.
117600/
117700 2500-CALC-OUTLIER-FACTORS.
117800******************************************************************
117900***  Set separately billable OUTLIER age adjustment factor     ***
118000******************************************************************
118100     IF H-PATIENT-AGE < 13  THEN
118200        IF B-REV-CODE = '0821' OR '0881' THEN
118300           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
118400        ELSE
118500           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
118600        END-IF
118700     ELSE
118800        IF H-PATIENT-AGE < 18 THEN
118900           IF B-REV-CODE = '0821' OR '0881'  THEN
119000              MOVE SB-AGE-13-17-HEMO-MODE
119100                                       TO H-OUT-AGE-FACTOR
119200           ELSE
119300              MOVE SB-AGE-13-17-PD-MODE
119400                                       TO H-OUT-AGE-FACTOR
119500           END-IF
119600        ELSE
119700           IF H-PATIENT-AGE < 45  THEN
119800              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
119900           ELSE
120000              IF H-PATIENT-AGE < 60  THEN
120100                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
120200              ELSE
120300                 IF H-PATIENT-AGE < 70  THEN
120400                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
120500                 ELSE
120600                    IF H-PATIENT-AGE < 80  THEN
120700                       MOVE SB-AGE-70-79
120800                                       TO H-OUT-AGE-FACTOR
120900                    ELSE
121000                       MOVE SB-AGE-80-PLUS
121100                                       TO H-OUT-AGE-FACTOR
121200                    END-IF
121300                 END-IF
121400              END-IF
121500           END-IF
121600        END-IF
121700     END-IF.
121800
121900******************************************************************
122000**Calculate separately billable OUTLIER BSA factor (superscript)**
122100******************************************************************
122200     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
122300         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
122400
122500     IF H-PATIENT-AGE > 17  THEN
122600        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
122700             SB-BSA ** ((H-OUT-BSA - 1.87) / .1)
122800     ELSE
122900        MOVE 1.000                     TO H-OUT-BSA-FACTOR
123000     END-IF.
123100
123200******************************************************************
123300***  Calculate separately billable OUTLIER BMI factor          ***
123400******************************************************************
123500     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
123600         (B-PATIENT-HGT ** 2)) * 10000.
123700
123800     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
123900        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
124000     ELSE
124100        MOVE 1.000                     TO H-OUT-BMI-FACTOR
124200     END-IF.
124300
124400******************************************************************
124500***  Calculate separately billable OUTLIER ONSET factor        ***
124600******************************************************************
124700     IF B-DIALYSIS-START-DATE > ZERO  THEN
124800        IF H-PATIENT-AGE > 17  THEN
124900           IF ONSET-DATE > 120  THEN
125000              MOVE 1                   TO H-OUT-ONSET-FACTOR
125100           ELSE
125200              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
125300           END-IF
125400        ELSE
125500           MOVE 1                      TO H-OUT-ONSET-FACTOR
125600        END-IF
125700     ELSE
125800        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
125900     END-IF.
126000
126100******************************************************************
126200***  Set separately billable OUTLIER Co-morbidities adjustment ***
126300******************************************************************
126400     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
126500        IF H-PATIENT-AGE  <  18  THEN
126600           MOVE 1.000                  TO
126700                                       H-OUT-COMORBID-MULTIPLIER
126800           MOVE '10'                   TO PPS-2011-COMORBID-PAY
126900        ELSE
127000           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
127100              MOVE 1.000               TO
127200                                       H-OUT-COMORBID-MULTIPLIER
127300              MOVE '10'                TO PPS-2011-COMORBID-PAY
127400           ELSE
127500              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
127600           END-IF
127700        END-IF
127800     ELSE
127900        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
128000           MOVE 1.000                  TO
128100                                       H-OUT-COMORBID-MULTIPLIER
128200        ELSE
128300           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
128400              MOVE SB-GI-BLEED         TO
128500                                       H-OUT-COMORBID-MULTIPLIER
128600           ELSE
128700              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
128800                 MOVE SB-PNEUMONIA     TO
128900                                       H-OUT-COMORBID-MULTIPLIER
129000              ELSE
129100                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
129200                    MOVE SB-PERICARDITIS TO
129300                                       H-OUT-COMORBID-MULTIPLIER
129400                 END-IF
129500              END-IF
129600           END-IF
129700        END-IF
129800     END-IF.
129900
130000******************************************************************
130100***  Set OUTLIER low-volume-multiplier                         ***
130200******************************************************************
130300     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
130400        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
130500     ELSE
130600        IF H-PATIENT-AGE < 18  THEN
130700           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
130800        ELSE
130900           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
131000           MOVE "Y"                    TO LOW-VOLUME-TRACK
131100        END-IF
131200     END-IF.
131300
131400******************************************************************
131500***  Calculate predicted OUTLIER services MAP per treatment    ***
131600******************************************************************
131700     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
131800        (H-OUT-AGE-FACTOR             *
131900         H-OUT-BSA-FACTOR             *
132000         H-OUT-BMI-FACTOR             *
132100         H-OUT-ONSET-FACTOR           *
132200         H-OUT-COMORBID-MULTIPLIER    *
132300         H-OUT-LOW-VOL-MULTIPLIER).
132400
132500******************************************************************
132600***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
132700******************************************************************
132800     IF H-PATIENT-AGE < 18  THEN
132900        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
133000           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
133100        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
133200     ELSE
133300
133400        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
133500           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
133600        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
133700     END-IF.
133800
133900******************************************************************
134000*** Calculate imputed OUTLIER services MAP amount per treatment***
134100******************************************************************
134200     IF (B-COND-CODE = '74')  AND
134300        (B-REV-CODE = '0841' OR '0851')  THEN
134400         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
134500            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
134600         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
134700         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
134800     ELSE
134900        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
135000        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
135100     END-IF.
135200
135300******************************************************************
135400*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
135500******************************************************************
135600     IF H-PATIENT-AGE < 18   THEN
135700        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
135800           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
135900        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
136000        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
136100           COMPUTE H-OUT-PAYMENT  ROUNDED  =
136200            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
136300                                         LOSS-SHARING-PCT-LT-18
136400           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
136500           MOVE "Y"                    TO OUTLIER-TRACK
136600        ELSE
136700           MOVE ZERO                   TO H-OUT-PAYMENT
136800           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
136900        END-IF
137000     ELSE
137100        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
137200           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
137300           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
137400        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
137500           COMPUTE H-OUT-PAYMENT  ROUNDED  =
137600            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
137700                                         LOSS-SHARING-PCT-GT-17
137800           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
137900           MOVE "Y"                    TO OUTLIER-TRACK
138000        ELSE
138100           MOVE ZERO                   TO H-OUT-PAYMENT
138200        END-IF
138300     END-IF.
138400
138500     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
138600
138700* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
138800     IF (B-COND-CODE = '74')  AND
138900        (B-REV-CODE = '0841' OR '0851')  THEN
139000           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
139100             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
139200     END-IF.
139300/
139400 2600-CALC-COMORBID-OUT-ADJUST.
139500******************************************************************
139600***  Calculate OUTLIER Co-morbidities adjustment               ***
139700******************************************************************
139800*  This logic assumes that the comorbids are randomly assigned   *
139900*to the comorbid table.  It will select the highest comorbid for *
140000*payment if one is found.                                        *
140100******************************************************************
140200
140300     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
140400     MOVE 1.000                        TO
140500                                  H-OUT-COMORBID-MULTIPLIER.
140600
140700     PERFORM VARYING  SUB  FROM  1 BY 1
140800       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
140900         IF COMORBID-DATA (SUB) = 'MA'  THEN
141000           MOVE SB-GI-BLEED            TO
141100                                  H-OUT-COMORBID-MULTIPLIER
141200           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
141300           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
141400         ELSE
141500           IF COMORBID-DATA (SUB) = 'MB'  THEN
141600             IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
141700               MOVE SB-PNEUMONIA       TO
141800                                  H-OUT-COMORBID-MULTIPLIER
141900               MOVE "Y"                TO ACUTE-COMORBID-TRACK
142000             END-IF
142100           ELSE
142200             IF COMORBID-DATA (SUB) = 'MC'  THEN
142300                IF SB-PERICARDITIS  >
142400                                  H-OUT-COMORBID-MULTIPLIER  THEN
142500                  MOVE SB-PERICARDITIS TO
142600                                  H-OUT-COMORBID-MULTIPLIER
142700                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
142800                END-IF
142900             ELSE
143000               IF COMORBID-DATA (SUB) = 'MD'  THEN
143100                 IF SB-MYELODYSPLASTIC  >
143200                                  H-OUT-COMORBID-MULTIPLIER  THEN
143300                   MOVE SB-MYELODYSPLASTIC  TO
143400                                  H-OUT-COMORBID-MULTIPLIER
143500                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
143600                 END-IF
143700               ELSE
143800                 IF COMORBID-DATA (SUB) = 'ME'  THEN
143900                   IF SB-SICKEL-CELL  >
144000                                  H-OUT-COMORBID-MULTIPLIER  THEN
144100                     MOVE SB-SICKEL-CELL  TO
144200                                  H-OUT-COMORBID-MULTIPLIER
144300                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
144400                   END-IF
144500                 ELSE
144600                   IF COMORBID-DATA (SUB) = 'MF'  THEN
144700                     IF SB-MONOCLONAL-GAMM  >
144800                                  H-OUT-COMORBID-MULTIPLIER  THEN
144900                       MOVE SB-MONOCLONAL-GAMM  TO
145000                                  H-OUT-COMORBID-MULTIPLIER
145100                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
145200                     END-IF
145300                   END-IF
145400                 END-IF
145500               END-IF
145600             END-IF
145700           END-IF
145800         END-IF
145900     END-PERFORM.
146000/
146100******************************************************************
146200*** Calculate Low Volume Full PPS payment for recovery purposes***
146300******************************************************************
146400 3000-LOW-VOL-FULL-PPS-PAYMENT.
146500******************************************************************
146600** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
146700     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
146800        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
146900        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
147000        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER).
147100
147200******************************************************************
147300**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
147400* Self-care in Training add-on
147500     IF B-COND-CODE = '73'  THEN
147600* no add-on when onset is present
147700        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
147800           MOVE ZERO                   TO
147900                                    H-BUN-WAGE-ADJ-TRAINING-AMT
148000        ELSE
148100* use new PPS training add-on amount times wage-index
148200           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
148300             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
148400           MOVE "Y"                    TO TRAINING-TRACK
148500        END-IF
148600     ELSE
148700* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
148800        IF (B-COND-CODE = '74')  AND
148900           (B-REV-CODE = '0841' OR '0851')  THEN
149000              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
149100                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
149200        ELSE
149300           MOVE ZERO                   TO
149400                                    H-BUN-WAGE-ADJ-TRAINING-AMT
149500                                    H-CC-74-PER-DIEM-AMT
149600        END-IF
149700     END-IF.
149800
149900******************************************************************
150000**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
150100     IF (B-COND-CODE = '74')  AND
150200        (B-REV-CODE = '0841' OR '0851')  THEN
150300           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
150400                           H-CC-74-PER-DIEM-AMT
150500     ELSE
150600        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
150700                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
150800                H-BUN-WAGE-ADJ-TRAINING-AMT
150900     END-IF.
151000
151100/
151200******************************************************************
151300*** Calculate Low Volume OUT PPS payment for recovery purposes ***
151400******************************************************************
151500 3100-LOW-VOL-OUT-PPS-PAYMENT.
151600******************************************************************
151700**Modified code from 'Calc predict OUT serv MAP per treat' para.**
151800     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
151900        (H-OUT-AGE-FACTOR             *
152000         H-OUT-BSA-FACTOR             *
152100         H-OUT-BMI-FACTOR             *
152200         H-OUT-ONSET-FACTOR           *
152300         H-OUT-COMORBID-MULTIPLIER).
152400
152500******************************************************************
152600**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
152700     IF H-PATIENT-AGE < 18  THEN
152800        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
152900           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
153000        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
153100     ELSE
153200        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
153300           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
153400        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
153500     END-IF.
153600
153700******************************************************************
153800** 'Calculate imput OUT services MAP amount per treatment' para **
153900** It is not necessary to modify or insert this paragraph here. **
154000
154100******************************************************************
154200**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
154300     IF H-PATIENT-AGE < 18   THEN
154400        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
154500           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
154600        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
154700        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
154800           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
154900            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
155000                                         LOSS-SHARING-PCT-LT-18
155100           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
155200        ELSE
155300           MOVE ZERO                   TO H-LV-OUT-PAYMENT
155400           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
155500        END-IF
155600     ELSE
155700        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
155800           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
155900           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
156000        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
156100           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
156200            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
156300                                         LOSS-SHARING-PCT-GT-17
156400           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
156500        ELSE
156600           MOVE ZERO                   TO H-LV-OUT-PAYMENT
156700        END-IF
156800     END-IF.
156900
157000     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
157100
157200* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
157300     IF (B-COND-CODE = '74')  AND
157400        (B-REV-CODE = '0841' OR '0851')  THEN
157500           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
157600             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
157700     END-IF.
157800/
157900 5000-CALC-COMP-RATE-FACTORS.
158000******************************************************************
158100***  Set Composite Rate age adjustment factor                  ***
158200******************************************************************
158300     IF H-PATIENT-AGE < 18  THEN
158400        MOVE CR-AGE-LT-18              TO H-AGE-FACTOR
158500     ELSE
158600        IF H-PATIENT-AGE < 45  THEN
158700           MOVE CR-AGE-18-44           TO H-AGE-FACTOR
158800        ELSE
158900           IF H-PATIENT-AGE < 60  THEN
159000              MOVE CR-AGE-45-59        TO H-AGE-FACTOR
159100           ELSE
159200              IF H-PATIENT-AGE < 70  THEN
159300                 MOVE CR-AGE-60-69     TO H-AGE-FACTOR
159400              ELSE
159500                 IF H-PATIENT-AGE < 80  THEN
159600                    MOVE CR-AGE-70-79  TO H-AGE-FACTOR
159700                 ELSE
159800                    MOVE CR-AGE-80-PLUS
159900                                       TO H-AGE-FACTOR
160000                 END-IF
160100              END-IF
160200           END-IF
160300        END-IF
160400     END-IF.
160500
160600******************************************************************
160700**Calculate Composite Rate BSA factor (2012 superscript now same)*
160800******************************************************************
160900     COMPUTE H-BSA  ROUNDED = (.007184 *
161000         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
161100
161200     IF H-PATIENT-AGE > 17  THEN
161300        COMPUTE H-BSA-FACTOR  ROUNDED =
161400             CR-BSA ** ((H-BSA - 1.87) / .1)
161500     ELSE
161600        MOVE 1.000                     TO H-BSA-FACTOR
161700     END-IF.
161800
161900******************************************************************
162000*** Calculate Composite Rate BMI factor (different BMI < 18.5) ***
162100******************************************************************
162200     COMPUTE H-BMI  ROUNDED = (B-PATIENT-WGT /
162300         (B-PATIENT-HGT ** 2)) * 10000.
162400
162500     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)  THEN
162600        MOVE CR-BMI-LT-18-5            TO H-BMI-FACTOR
162700     ELSE
162800        MOVE 1.000                     TO H-BMI-FACTOR
162900     END-IF.
163000
163100******************************************************************
163200***  Calculate Composite Rate Payment Amount                   ***
163300******************************************************************
163400*P-ESRD-RATE, also called the Exception Rate, will not be granted*
163500*in full beginning in 2011 (the beginning of the Bundled method) *
163600*and will be eliminated entirely beginning in 2014 which is the  *
163700*end of the blending period.  For 2011, those providers who elect*
163800*to be in the blend, will get only 75% of the exception rate.    *
163900*This apparently is for the pediatric providers who originally   *
164000*had the exception rate.                                         *
164100
164200     IF P-ESRD-RATE  =  ZERO  THEN
164300        MOVE BASE-PAYMENT-RATE         TO  H-PAYMENT-RATE
164400     ELSE
164500        MOVE P-ESRD-RATE               TO  H-PAYMENT-RATE
164600     END-IF.
164700
164800     COMPUTE H-WAGE-ADJ-PYMT-AMT ROUNDED =
164900     (((H-PAYMENT-RATE * NAT-LABOR-PCT) * COM-CBSA-W-INDEX) +
165000       (H-PAYMENT-RATE * NAT-NONLABOR-PCT)) *
165100            CBSA-BLEND-PCT.
165200
165300     COMPUTE H-PYMT-AMT ROUNDED = (H-WAGE-ADJ-PYMT-AMT *
165400        H-BMI-FACTOR * H-BSA-FACTOR * CASE-MIX-BDGT-NEUT-FACTOR *
165500        H-AGE-FACTOR * DRUG-ADDON).
165600
165700     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
165800
165900******************************************************************
166000***  Calculate condition code payment                          ***
166100******************************************************************
166200     MOVE SPACES                       TO COND-CD-73.
166300
166400* Hemo, peritoneal, or CCPD training add-on
166500     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
166600                                                      OR '0851')
166700        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
166800        MOVE 'A'                       TO AMT-INDIC
166900        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
167000     ELSE
167100* CAPD training add-on
167200        IF (B-COND-CODE = '73')  AND  (B-REV-CODE = '0841')  THEN
167300           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
167400           MOVE 'A'                    TO AMT-INDIC
167500           MOVE CAPD-AMT               TO BLOOD-DOLLAR
167600        ELSE
167700* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
167800           IF (B-COND-CODE = '74')  AND
167900              (B-REV-CODE = '0841' OR '0851')  THEN
168000              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
168100                                           CAPD-OR-CCPD-FACTOR
168200              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
168300           ELSE
168400              MOVE 'A'                 TO AMT-INDIC
168500              MOVE ZERO                TO BLOOD-DOLLAR
168600           END-IF
168700        END-IF
168800     END-IF.
168900
169000/
169100 9000-SET-RETURN-CODE.
169200******************************************************************
169300***  Set the return code                                       ***
169400******************************************************************
169500*   The following 'table' helps in understanding and in making   *
169600*changes to the rather large and complex "IF" statement that     *
169700*follows.  This 'table' just reorders and rewords the comments   *
169800*contained in the working storage area concerning the paid       *
169900*return-codes.                                                   *
170000*                                                                *
170100*  17 = pediatric, outlier, training                             *
170200*  16 = pediatric, outlier                                       *
170300*  15 = pediatric, training                                      *
170400*  14 = pediatric                                                *
170500*                                                                *
170600*  24 = outlier, low volume, training, chronic comorbid          *
170700*  19 = outlier, low volume, training, acute comorbid            *
170800*  29 = outlier, low volume, training                            *
170900*  23 = outlier, low volume, chronic comorbid                    *
171000*  18 = outlier, low volume, acute comorbid                      *
171100*  30 = outlier, low volume, onset                               *
171200*  28 = outlier, low volume                                      *
171300*  34 = outlier, training, chronic comorbid                      *
171400*  35 = outlier, training, acute comorbid                        *
171500*  33 = outlier, training                                        *
171600*  07 = outlier, chronic comorbid                                *
171700*  06 = outlier, acute comorbid                                  *
171800*  09 = outlier, onset                                           *
171900*  03 = outlier                                                  *
172000*                                                                *
172100*  26 = low volume, training, chronic comorbid                   *
172200*  21 = low volume, training, acute comorbid                     *
172300*  12 = low volume, training                                     *
172400*  25 = low volume, chronic comorbid                             *
172500*  20 = low volume, acute comorbid                               *
172600*  32 = low volume, onset                                        *
172700*  10 = low volume                                               *
172800*                                                                *
172900*  27 = training, chronic comorbid                               *
173000*  22 = training, acute comorbid                                 *
173100*  11 = training                                                 *
173200*                                                                *
173300*  08 = onset                                                    *
173400*  04 = acute comorbid                                           *
173500*  05 = chronic comorbid                                         *
173600*  31 = low BMI                                                  *
173700*  02 = no adjustments                                           *
173800*                                                                *
173900*  13 = w/multiple adjustments....reserved for future use        *
174000******************************************************************
174100/
174200     IF PEDIATRIC-TRACK                       = "Y"  THEN
174300        IF OUTLIER-TRACK                      = "Y"  THEN
174400           IF TRAINING-TRACK                  = "Y"  THEN
174500              MOVE 17                  TO PPS-RTC
174600           ELSE
174700              MOVE 16                  TO PPS-RTC
174800           END-IF
174900        ELSE
175000           IF TRAINING-TRACK                  = "Y"  THEN
175100              MOVE 15                  TO PPS-RTC
175200           ELSE
175300              MOVE 14                  TO PPS-RTC
175400           END-IF
175500        END-IF
175600     ELSE
175700        IF OUTLIER-TRACK                      = "Y"  THEN
175800           IF LOW-VOLUME-TRACK                = "Y"  THEN
175900              IF TRAINING-TRACK               = "Y"  THEN
176000                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
176100                    MOVE 24            TO PPS-RTC
176200                 ELSE
176300                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
176400                       MOVE 19         TO PPS-RTC
176500                    ELSE
176600                       MOVE 29         TO PPS-RTC
176700                    END-IF
176800                 END-IF
176900              ELSE
177000                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
177100                    MOVE 23            TO PPS-RTC
177200                 ELSE
177300                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
177400                       MOVE 18         TO PPS-RTC
177500                    ELSE
177600                       IF ONSET-TRACK         = "Y"  THEN
177700                          MOVE 30      TO PPS-RTC
177800                       ELSE
177900                          MOVE 28      TO PPS-RTC
178000                       END-IF
178100                    END-IF
178200                 END-IF
178300              END-IF
178400           ELSE
178500              IF TRAINING-TRACK               = "Y"  THEN
178600                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
178700                    MOVE 34            TO PPS-RTC
178800                 ELSE
178900                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
179000                       MOVE 35         TO PPS-RTC
179100                    ELSE
179200                       MOVE 33         TO PPS-RTC
179300                    END-IF
179400                 END-IF
179500              ELSE
179600                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
179700                    MOVE 07            TO PPS-RTC
179800                 ELSE
179900                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
180000                       MOVE 06         TO PPS-RTC
180100                    ELSE
180200                       IF ONSET-TRACK         = "Y"  THEN
180300                          MOVE 09      TO PPS-RTC
180400                       ELSE
180500                          MOVE 03      TO PPS-RTC
180600                       END-IF
180700                    END-IF
180800                 END-IF
180900              END-IF
181000           END-IF
181100        ELSE
181200           IF LOW-VOLUME-TRACK                = "Y"
181300              IF TRAINING-TRACK               = "Y"  THEN
181400                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
181500                    MOVE 26            TO PPS-RTC
181600                 ELSE
181700                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
181800                       MOVE 21         TO PPS-RTC
181900                    ELSE
182000                       MOVE 12         TO PPS-RTC
182100                    END-IF
182200                 END-IF
182300              ELSE
182400                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
182500                    MOVE 25            TO PPS-RTC
182600                 ELSE
182700                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
182800                       MOVE 20         TO PPS-RTC
182900                    ELSE
183000                       IF ONSET-TRACK         = "Y"  THEN
183100                          MOVE 32      TO PPS-RTC
183200                       ELSE
183300                          MOVE 10      TO PPS-RTC
183400                       END-IF
183500                    END-IF
183600                 END-IF
183700              END-IF
183800           ELSE
183900              IF TRAINING-TRACK               = "Y"  THEN
184000                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
184100                    MOVE 27            TO PPS-RTC
184200                 ELSE
184300                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
184400                       MOVE 22         TO PPS-RTC
184500                    ELSE
184600                       MOVE 11         TO PPS-RTC
184700                    END-IF
184800                 END-IF
184900              ELSE
185000                 IF ONSET-TRACK               = "Y"  THEN
185100                    MOVE 08            TO PPS-RTC
185200                 ELSE
185300                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
185400                       MOVE 04         TO PPS-RTC
185500                    ELSE
185600                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
185700                          MOVE 05      TO PPS-RTC
185800                       ELSE
185900                          IF LOW-BMI-TRACK = "Y"  THEN
186000                             MOVE 31 TO PPS-RTC
186100                          ELSE
186200                             MOVE 02 TO PPS-RTC
186300                          END-IF
186400                       END-IF
186500                    END-IF
186600                 END-IF
186700              END-IF
186800           END-IF
186900        END-IF
187000     END-IF.
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
193900
194000     IF P-QIP-REDUCTION = ' ' THEN
194100        NEXT SENTENCE
194200     ELSE
194300        COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
194400                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
194500        COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
194600                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
194700        COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
194800                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
194900        COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
195000                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
195100        COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
195200                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
195300        COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
195400                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
195500     END-IF.
195600
195700     IF BUNDLED-TEST   THEN
195800        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
195900        MOVE 0.0                       TO MSA-WAGE-ADJ
196000        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
196100        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
196200        MOVE H-PATIENT-AGE             TO AGE-RETURN
196300        MOVE 0.0                       TO MSA-WAGE-AMT
196400        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
196500        MOVE H-BMI                     TO PPS-BMI
196600        MOVE H-BSA                     TO PPS-BSA
196700        MOVE MSA-BLEND-PCT             TO MSA-PCT
196800        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
196900
197000        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
197100           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
197200           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
197300        ELSE
197400           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
197500           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
197600        END-IF
197700
197800        MOVE H-BUN-BSA                 TO BUN-BSA
197900        MOVE H-BUN-BMI                 TO BUN-BMI
198000        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
198100        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
198200        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
198300        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
198400        MOVE H-OUT-BSA                 TO OUT-BSA
198500        MOVE SB-BSA                    TO OUT-SB-BSA
198600        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
198700        MOVE H-OUT-BMI                 TO OUT-BMI
198800        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
198900        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
199000        MOVE H-OUT-COMORBID-MULTIPLIER TO
199100                                    OUT-COMORBID-MULTIPLIER
199200        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
199300                                    OUT-PREDICTED-SERVICES-MAP
199400        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
199500                                    OUT-CASE-MIX-PREDICTED-MAP
199600        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
199700                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
199800        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
199900        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
200000        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
200100        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
200200        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
200300        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
200400        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
200500        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
200600        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
200700        MOVE CM-BSA                    TO PPS-CM-BSA
200800        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
200900        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
201000        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
201100        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
201200                                    BUN-ADJUSTED-BASE-WAGE-AMT
201300        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
201400                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
201500        MOVE TRAINING-ADD-ON-PMT-AMT   TO
201600                                    PPS-TRAINING-ADD-ON-PMT-AMT
201700        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
201800     END-IF.
201900******        L A S T   S O U R C E   S T A T E M E N T      *****
