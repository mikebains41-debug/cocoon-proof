000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL140.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2014
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
018600* 11-15-14 - ESCAL14B - BETA PRICER FOR TESTING ONLY
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
023000******************************************************************
023100 DATE-COMPILED.
023200 ENVIRONMENT DIVISION.
023300 CONFIGURATION SECTION.
023400 SOURCE-COMPUTER.            IBM-Z990.
023500 OBJECT-COMPUTER.            IBM-Z990.
023600 INPUT-OUTPUT  SECTION.
023700 FILE-CONTROL.
023800
023900 DATA DIVISION.
024000 FILE SECTION.
024100/
024200 WORKING-STORAGE SECTION.
024300 01  W-STORAGE-REF                  PIC X(46) VALUE
024400     'ESCAL140      - W O R K I N G   S T O R A G E'.
024500 01  CAL-VERSION                    PIC X(05) VALUE 'C14.0'.
024600
024700 01  DISPLAY-LINE-MEASUREMENT.
024800     05  FILLER                     PIC X(50) VALUE
024900         '....:...10....:...20....:...30....:...40....:...50'.
025000     05  FILLER                     PIC X(50) VALUE
025100         '....:...60....:...70....:...80....:...90....:..100'.
025200     05  FILLER                     PIC X(20) VALUE
025300         '....:..110....:..120'.
025400
025500 01  PRINT-LINE-MEASUREMENT.
025600     05  FILLER                     PIC X(51) VALUE
025700         'X....:...10....:...20....:...30....:...40....:...50'.
025800     05  FILLER                     PIC X(50) VALUE
025900         '....:...60....:...70....:...80....:...90....:..100'.
026000     05  FILLER                     PIC X(32) VALUE
026100         '....:..110....:..120....:..130..'.
026200/
026300******************************************************************
026400*  This area contains all of the old Composite Rate variables.   *
026500* They will be eliminated when the transition period ends - 2014 *
026600******************************************************************
026700 01  HOLD-COMP-RATE-PPS-COMPONENTS.
026800     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
026900     05  H-PYMT-AMT                 PIC 9(04)V9(02).
027000     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
027100     05  H-PATIENT-AGE              PIC 9(03).
027200     05  H-AGE-FACTOR               PIC 9(01)V9(03).
027300     05  H-BSA-FACTOR               PIC 9(01)V9(04).
027400     05  H-BMI-FACTOR               PIC 9(01)V9(04).
027500     05  H-BSA                      PIC 9(03)V9(04).
027600     05  H-BMI                      PIC 9(03)V9(04).
027700     05  HGT-PART                   PIC 9(04)V9(08).
027800     05  WGT-PART                   PIC 9(04)V9(08).
027900     05  COMBINED-PART              PIC 9(04)V9(08).
028000     05  CALC-BSA                   PIC 9(04)V9(08).
028100
028200
028300* The following two variables will change from year to year
028400* and are used for the COMPOSITE part of the Bundled Pricer.
028500 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
028600 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
028700
028800* The next two percentages MUST add up to 1 (i.e. 100%)
028900* They will continue to change until CY2009 when CBSA will be 1.00
029000 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
029100 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
029200
029300* CONSTANTS AREA
029400* The next two percentages MUST add up TO 1 (i.e. 100%)
029500 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
029600 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
029700
029800* The next variable is only applicapable for the 2011 Pricer.
029900 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
030000
030100 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
030200 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
030300 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
030400                                                         0.428571.
030500* The above number technically represents the fractional
030600* number 3/7 which is three days per week that a person can
030700* receive dialysis.  It will remain this value ONLY for the
030800* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
030900* use the calculation method which is more understandable and
031000* follows the method used by the Policy folks.
031100
031200*  The following number that is loaded into the payment equation
031300*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
031400*  and   --DOES NOT CHANGE--
031500
031600 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
031700
031800 01  COMPOSITE-RATE-MULTIPLIERS.
031900*Composite rate payment multiplier (used for blended providers)
032000     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
032100     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
032200     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
032300     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
032400     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
032500     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
032600
032700     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
032800     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
032900/
033000******************************************************************
033100*    This area contains all of the NEW Bundled Rate variables.   *
033200******************************************************************
033300 01  HOLD-BUNDLED-PPS-COMPONENTS.
033400     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
033500     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
033600     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
033700     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
033800     05  H-BUN-BSA                  PIC 9(03)V9(04).
033900     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
034000     05  H-BUN-BMI                  PIC 9(03)V9(04).
034100     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
034200     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
034300     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
034400     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
034500                                    PIC 9(07)V9(04).
034600     05  H-BUN-WAGE-ADJ-TRAINING-AMT
034700                                    PIC 9(07)V9(04).
034800     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
034900     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
035000     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
035100     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
035200     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
035300                                    PIC 9(07)V9(04).
035400     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
035500     05  H-LV-OUT-PREDICT-SERVICES-MAP
035600                                    PIC 9(07)V9(04).
035700     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
035800                                    PIC 9(07)V9(04).
035900     05  H-LV-OUT-PREDICTED-MAP
036000                                    PIC 9(07)V9(04).
036100     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
036200
036300     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
036400     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
036500         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
036600
036700     05  H-COMORBID-DATA  OCCURS 6 TIMES
036800            INDEXED BY H-COMORBID-INDEX
036900                                    PIC X(02).
037000     05  H-COMORBID-CWF-CODE        PIC X(02).
037100
037200     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
037300
037400     05  QIP-REDUCTION              PIC 9(01)V9(03).
037500     05  SUB                        PIC 9(04).
037600
037700     05  THE-DATE                   PIC 9(08).
037800     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
037900     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
038000     05  ONSET-DATE                 PIC 9(08).
038100     05  MOVED-CORMORBIDS           PIC X(01).
038200
038300 01  HOLD-OUTLIER-PPS-COMPONENTS.
038400     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
038500     05  H-OUT-BSA                  PIC 9(03)V9(04).
038600     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
038700     05  H-OUT-BMI                  PIC 9(03)V9(04).
038800     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
038900     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
039000     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
039100     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
039200     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
039300     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
039400     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
039500     05  H-OUT-PREDICTED-SERVICES-MAP
039600                                    PIC 9(07)V9(04).
039700     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
039800     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
039900                                    PIC 9(07)V9(04).
040000     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
040100     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
040200     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
040300
040400
040500* The following variable will change from year to year and is
040600* used for the BUNDLED part of the Bundled Pricer.
040700 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 239.02.
040800
040900* The next two percentages MUST add up to 1 (i.e. 100%)
041000* They start in 2011 and will continue to change until CY2014 when
041100* BUN-CBSA-BLEND-PCT will be 1.00
041200* The third blend percent is for those providers that waived the
041300* blended percent and went to full PPS.  This variable will be
041400* eliminated in 2014 when it is no longer needed.
041500 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.00.
041600 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 1.00.
041700 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
041800
041900* CONSTANTS AREA
042000* The next two percentages MUST add up TO 1 (i.e. 100%)
042100 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.41737.
042200 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.58263.
042300 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 50.16.
042400
042500*  The following number that is loaded into the payment equation
042600*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
042700*  and   --DOES NOT CHANGE--
042800
042900 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
043000
043100 01  PEDIATRIC-MULTIPLIERS.
043200*Separately billable payment multiplier (used for outliers)
043300     05  PED-SEP-BILL-PAY-MULTI.
043400         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.319.
043500         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.185.
043600         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.476.
043700         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.459.
043800     05  PED-EXPAND-BUNDLE-PAY-MULTI.
043900*Expanded bundle payment multiplier (used for normal billing)
044000         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.033.
044100         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.219.
044200         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.067.
044300         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.277.
044400
044500 01  ADULT-MULTIPLIERS.
044600*Separately billable payment multiplier (used for outliers)
044700     05  SEP-BILLABLE-PAYMANT-MULTI.
044800         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 0.996.
044900         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 0.992.
045000         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
045100         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 0.963.
045200         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.915.
045300         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.014.
045400         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.078.
045500         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.450.
045600         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.354.
045700         10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
045800         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.571.
045900         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.225.
046000         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.309.
046100         10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
046200         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.975.
046300*Case-Mix adjusted payment multiplier (used for normal billing)
046400     05  CASE-MIX-PAYMENT-MULTI.
046500         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.171.
046600         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.013.
046700         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
046800         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.011.
046900         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.016.
047000         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.020.
047100         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.025.
047200         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.510.
047300         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.114.
047400         10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
047500         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.183.
047600         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.072.
047700         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.099.
047800         10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
047900         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.189.
048000
048100 01  OUTLIER-SB-CALC-AMOUNTS.
048200     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 40.49.
048300     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 50.25.
048400     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 54.01.
048500     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 98.67.
048600     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
048700     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
048800/
048900******************************************************************
049000*    This area contains return code variables and their codes.   *
049100******************************************************************
049200 01 PAID-RETURN-CODE-TRACKERS.
049300     05  OUTLIER-TRACK              PIC X(01).
049400     05  ACUTE-COMORBID-TRACK       PIC X(01).
049500     05  CHRONIC-COMORBID-TRACK     PIC X(01).
049600     05  ONSET-TRACK                PIC X(01).
049700     05  LOW-VOLUME-TRACK           PIC X(01).
049800     05  TRAINING-TRACK             PIC X(01).
049900     05  PEDIATRIC-TRACK            PIC X(01).
050000     05  LOW-BMI-TRACK              PIC X(01).
050100 COPY RTCCPY.
050200*COPY "RTCCPY.CPY".
050300*                                                                *
050400*  Legal combinations of adjustments for ADULTS are:             *
050500*     if NO ONSET applies, then they can have any combination of:*
050600*       acute OR chronic comorbid, & outlier, low vol., training.*
050700*     if ONSET applies, then they can have:                      *
050800*           outlier and/or low volume.                           *
050900*  Legal combinations of adjustments for PEDIATRIC are:          *
051000*     outlier and/or training.                                   *
051100*                                                                *
051200*  Illegal combinations of adjustments for PEDIATRIC are:        *
051300*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
051400*     onset     with comorbid or training.                       *
051500*  Illegal combinations of adjustments for ANYONE are:           *
051600*     acute comorbid AND chronic comorbid.                       *
051700/
051800 LINKAGE SECTION.
051900 COPY BILLCPY.
052000*COPY "BILLCPY.CPY".
052100/
052200 COPY WAGECPY.
052300*COPY "WAGECPY.CPY".
052400/
052500 PROCEDURE DIVISION  USING BILL-NEW-DATA
052600                           PPS-DATA-ALL
052700                           WAGE-NEW-RATE-RECORD
052800                           COM-CBSA-WAGE-RECORD
052900                           BUN-CBSA-WAGE-RECORD.
053000
053100******************************************************************
053200* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
053300* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
053400* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
053500* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
053600* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
053700* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
053800* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
053900* PROCESSING (DICP).                                             *
054000*                                                                *
054100*                                                                *
054200*    PROCESSING:                                                 *
054300*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
054400*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
054500*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
054600*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
054700*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
054800*           GOBACK.                                              *
054900*        D. ASSEMBLE PRICING COMPONENTS.                         *
055000*        E. CALCULATE THE PRICE.                                 *
055100******************************************************************
055200
055300 0000-START-TO-FINISH.
055400     INITIALIZE PPS-DATA-ALL.
055500
055600* TO MAKE SURE THAT ALL BILLS ARE 100% PPS
055700     MOVE 'Y' TO P-PROV-WAIVE-BLEND-PAY-INDIC.
055800
055900     IF BUNDLED-TEST THEN
056000        INITIALIZE BILL-DATA-TEST
056100        INITIALIZE COND-CD-73
056200     END-IF.
056300     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
056400     MOVE ZEROS                        TO PPS-RTC.
056500
056600     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
056700
056800     IF PPS-RTC = 00  THEN
056900        PERFORM 1200-INITIALIZATION
057000**Calculate patient age
057100        COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
057200        IF B-DOB-MM > B-THRU-MM  THEN
057300           COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
057400        END-IF
057500        IF H-PATIENT-AGE < 18  THEN
057600           MOVE "Y"                    TO PEDIATRIC-TRACK
057700        END-IF
057800        PERFORM 2000-CALCULATE-BUNDLED-FACTORS
057900        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
058000           PERFORM 5000-CALC-COMP-RATE-FACTORS
058100        END-IF
058200        PERFORM 9000-SET-RETURN-CODE
058300        PERFORM 9100-MOVE-RESULTS
058400     END-IF.
058500
058600     GOBACK.
058700/
058800 1000-VALIDATE-BILL-ELEMENTS.
058900     IF P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
059000        NEXT SENTENCE
059100     ELSE
059200        MOVE 52                        TO PPS-RTC
059300     END-IF.
059400
059500     IF PPS-RTC = 00  THEN
059600        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
059700           MOVE 53                     TO PPS-RTC
059800        END-IF
059900     END-IF.
060000
060100     IF PPS-RTC = 00  THEN
060200        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
060300           MOVE 54                     TO PPS-RTC
060400        END-IF
060500     END-IF.
060600
060700     IF PPS-RTC = 00  THEN
060800        IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
060900           MOVE 55                     TO PPS-RTC
061000        END-IF
061100     END-IF.
061200
061300     IF PPS-RTC = 00  THEN
061400        IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
061500           MOVE 56                     TO PPS-RTC
061600        END-IF
061700     END-IF.
061800
061900     IF PPS-RTC = 00  THEN
062000        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
062100                                OR '0881'
062200           NEXT SENTENCE
062300        ELSE
062400           MOVE 57                     TO PPS-RTC
062500        END-IF
062600     END-IF.
062700
062800     IF PPS-RTC = 00  THEN
062900        IF B-COND-CODE NOT = '73' AND '74' AND '  '
063000           MOVE 58                     TO PPS-RTC
063100        END-IF
063200     END-IF.
063300
063400     IF PPS-RTC = 00  THEN
063500        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
063600                                 ' '  THEN
063700           MOVE 53                     TO PPS-RTC
063800*  This RTC is for the Special Payment Indicator not = '1' or
063900*  blank, which closely approximates the intent of the edit check.
064000*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
064100        END-IF
064200     END-IF.
064300
064400     IF PPS-RTC = 00  THEN
064500        IF B-PATIENT-HGT > 300.00
064600           MOVE 71                     TO PPS-RTC
064700        END-IF
064800     END-IF.
064900
065000     IF PPS-RTC = 00  THEN
065100        IF B-PATIENT-WGT > 500.00  THEN
065200           MOVE 72                     TO PPS-RTC
065300        END-IF
065400     END-IF.
065500
065600* Before 2012 pricer, put in edit check to make sure that the
065700* # of sesions does not exceed the # of days in a month.  Maybe
065800* the # of cays in a month minus one when patient goes into a
065900* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
066000* or 0851)).  If done, then will need extra RTC.
066100     IF PPS-RTC = 00  THEN
066200        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
066300           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
066400           MOVE 73                     TO PPS-RTC
066500        END-IF
066600     END-IF.
066700
066800     IF PPS-RTC = 00  THEN
066900        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
067000           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
067100           MOVE 74                     TO PPS-RTC
067200        END-IF
067300     END-IF.
067400
067500     IF PPS-RTC = 00  THEN
067600        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
067700           MOVE 75                     TO PPS-RTC
067800        END-IF
067900     END-IF.
068000
068100     IF PPS-RTC = 00  THEN
068200        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
068300           MOVE 76                     TO PPS-RTC
068400        END-IF
068500     END-IF.
068600
068700     IF PPS-RTC = 00  THEN
068800        IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
068900            VALID-COMORBID-CWF-RETURN-CD       THEN
069000           NEXT SENTENCE
069100        ELSE
069200           MOVE 81                     TO PPS-RTC
069300        END-IF
069400     END-IF.
069500/
069600 1200-INITIALIZATION.
069700     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
069800     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
069900     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
070000     INITIALIZE PAID-RETURN-CODE-TRACKERS.
070100
070200     MOVE SPACES                       TO MOVED-CORMORBIDS.
070300
070400     IF P-QIP-REDUCTION = ' '  THEN
070500* no reduction
070600        MOVE 1.000 TO QIP-REDUCTION
070700     ELSE
070800        IF P-QIP-REDUCTION = '1'  THEN
070900* one-half percent reduction
071000           MOVE 0.995 TO QIP-REDUCTION
071100        ELSE
071200           IF P-QIP-REDUCTION = '2'  THEN
071300* one percent reduction
071400              MOVE 0.990 TO QIP-REDUCTION
071500           ELSE
071600              IF P-QIP-REDUCTION = '3'  THEN
071700* one and one-half percent reduction
071800                 MOVE 0.985 TO QIP-REDUCTION
071900              ELSE
072000* two percent reduction
072100                 MOVE 0.980 TO QIP-REDUCTION
072200              END-IF
072300           END-IF
072400        END-IF
072500     END-IF.
072600
072700*    Since pricer has to pay a comorbid condition according to the
072800* return code that CWF passes back, it is cleaner if the pricer
072900* sets aside whatever comorbid data exists on the line-item when
073000* it comes into the pricer and then transferrs the CWF code to
073100* the appropriate place in the comorbid data.  This avoids
073200* making convoluted changes in the other parts of the program
073300* which has to look at both original comorbid data AND CWF return
073400* codes to handle comorbids.  Near the end of the program where
073500* variables are transferred to the output, the original comorbid
073600* data is put back into its original place as though nothing
073700* occurred.
073800     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
073900        NEXT SENTENCE
074000     ELSE
074100        MOVE 'Y'                       TO MOVED-CORMORBIDS
074200        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
074300        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
074400        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
074500        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
074600        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
074700        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
074800        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
074900        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
075000           MOVE SPACES                 TO COMORBID-DATA (1)
075100                                          COMORBID-DATA (2)
075200                                          COMORBID-DATA (3)
075300                                          COMORBID-DATA (4)
075400                                          COMORBID-DATA (5)
075500                                          COMORBID-DATA (6)
075600                                          COMORBID-CWF-RETURN-CODE
075700        ELSE
075800           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
075900              MOVE 'MA'                TO COMORBID-DATA (1)
076000              MOVE SPACES              TO COMORBID-DATA (2)
076100                                          COMORBID-DATA (3)
076200                                          COMORBID-DATA (4)
076300                                          COMORBID-DATA (5)
076400                                          COMORBID-DATA (6)
076500                                          COMORBID-CWF-RETURN-CODE
076600           ELSE
076700              IF COMORBID-CWF-RETURN-CODE = '30'  THEN
076800                 MOVE SPACES           TO COMORBID-DATA (1)
076900                 MOVE 'MB'             TO COMORBID-DATA (2)
077000                 MOVE SPACES           TO COMORBID-DATA (3)
077100                 MOVE SPACES           TO COMORBID-DATA (4)
077200                 MOVE SPACES           TO COMORBID-DATA (5)
077300                 MOVE SPACES           TO COMORBID-DATA (6)
077400                                          COMORBID-CWF-RETURN-CODE
077500              ELSE
077600                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
077700                    MOVE SPACES        TO COMORBID-DATA (1)
077800                    MOVE SPACES        TO COMORBID-DATA (2)
077900                    MOVE 'MC'          TO COMORBID-DATA (3)
078000                    MOVE SPACES        TO COMORBID-DATA (4)
078100                    MOVE SPACES        TO COMORBID-DATA (5)
078200                    MOVE SPACES        TO COMORBID-DATA (6)
078300                                          COMORBID-CWF-RETURN-CODE
078400                 ELSE
078500                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
078600                       MOVE SPACES     TO COMORBID-DATA (1)
078700                       MOVE SPACES     TO COMORBID-DATA (2)
078800                       MOVE SPACES     TO COMORBID-DATA (3)
078900                       MOVE 'MD'       TO COMORBID-DATA (4)
079000                       MOVE SPACES     TO COMORBID-DATA (5)
079100                       MOVE SPACES     TO COMORBID-DATA (6)
079200                                          COMORBID-CWF-RETURN-CODE
079300                    ELSE
079400                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
079500                          MOVE SPACES  TO COMORBID-DATA (1)
079600                          MOVE SPACES  TO COMORBID-DATA (2)
079700                          MOVE SPACES  TO COMORBID-DATA (3)
079800                          MOVE SPACES  TO COMORBID-DATA (4)
079900                          MOVE 'ME'    TO COMORBID-DATA (5)
080000                          MOVE SPACES  TO COMORBID-DATA (6)
080100                                          COMORBID-CWF-RETURN-CODE
080200                       ELSE
080300                          MOVE SPACES  TO COMORBID-DATA (1)
080400                                          COMORBID-DATA (2)
080500                                          COMORBID-DATA (3)
080600                                          COMORBID-DATA (4)
080700                                          COMORBID-DATA (5)
080800                                          COMORBID-CWF-RETURN-CODE
080900                          MOVE 'MF'    TO COMORBID-DATA (6)
081000                       END-IF
081100                    END-IF
081200                 END-IF
081300              END-IF
081400           END-IF
081500        END-IF
081600     END-IF.
081700
081800******************************************************************
081900***Calculate BUNDLED Wage Adjusted Rate (note different method)***
082000******************************************************************
082100     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
082200        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
082300         BUN-CBSA-W-INDEX.
082400
082500     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
082600        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
082700
082800     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
082900        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
083000/
083100 2000-CALCULATE-BUNDLED-FACTORS.
083200******************************************************************
083300***  Set BUNDLED age adjustment factor                         ***
083400******************************************************************
083500     IF H-PATIENT-AGE < 13  THEN
083600        IF B-REV-CODE = '0821' OR '0881' THEN
083700           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
083800        ELSE
083900           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
084000        END-IF
084100     ELSE
084200        IF H-PATIENT-AGE < 18 THEN
084300           IF B-REV-CODE = '0821' OR '0881' THEN
084400              MOVE EB-AGE-13-17-HEMO-MODE
084500                                       TO H-BUN-AGE-FACTOR
084600           ELSE
084700              MOVE EB-AGE-13-17-PD-MODE
084800                                       TO H-BUN-AGE-FACTOR
084900           END-IF
085000        ELSE
085100           IF H-PATIENT-AGE < 45  THEN
085200              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
085300           ELSE
085400              IF H-PATIENT-AGE < 60  THEN
085500                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
085600              ELSE
085700                 IF H-PATIENT-AGE < 70  THEN
085800                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
085900                 ELSE
086000                    IF H-PATIENT-AGE < 80  THEN
086100                       MOVE CM-AGE-70-79
086200                                       TO H-BUN-AGE-FACTOR
086300                    ELSE
086400                       MOVE CM-AGE-80-PLUS
086500                                       TO H-BUN-AGE-FACTOR
086600                    END-IF
086700                 END-IF
086800              END-IF
086900           END-IF
087000        END-IF
087100     END-IF.
087200
087300******************************************************************
087400***  Calculate BUNDLED BSA factor (note NEW formula)           ***
087500******************************************************************
087600     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
087700         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
087800
087900     IF H-PATIENT-AGE > 17  THEN
088000        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
088100             CM-BSA ** ((H-BUN-BSA - 1.87) / .1)
088200     ELSE
088300        MOVE 1.000                     TO H-BUN-BSA-FACTOR
088400     END-IF.
088500
088600******************************************************************
088700***  Calculate BUNDLED BMI factor                              ***
088800******************************************************************
088900     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
089000         (B-PATIENT-HGT ** 2)) * 10000.
089100
089200     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
089300        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
089400        MOVE "Y"                       TO LOW-BMI-TRACK
089500     ELSE
089600        MOVE 1.000                     TO H-BUN-BMI-FACTOR
089700     END-IF.
089800
089900******************************************************************
090000***  Calculate BUNDLED ONSET factor                            ***
090100******************************************************************
090200     IF B-DIALYSIS-START-DATE > ZERO  THEN
090300        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
090400        COMPUTE INTEGER-LINE-ITEM-DATE =
090500            FUNCTION INTEGER-OF-DATE(THE-DATE)
090600        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
090700        COMPUTE INTEGER-DIALYSIS-DATE  =
090800            FUNCTION INTEGER-OF-DATE(THE-DATE)
090900* Need to add one to onset-date because the start date should
091000* be included in the count of days.  fix made 9/6/2011
091100        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
091200                              INTEGER-DIALYSIS-DATE) + 1
091300        IF H-PATIENT-AGE > 17  THEN
091400           IF ONSET-DATE > 120  THEN
091500              MOVE 1                   TO H-BUN-ONSET-FACTOR
091600           ELSE
091700              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
091800              MOVE "Y"                 TO ONSET-TRACK
091900           END-IF
092000        ELSE
092100           MOVE 1                      TO H-BUN-ONSET-FACTOR
092200        END-IF
092300     ELSE
092400        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
092500     END-IF.
092600
092700******************************************************************
092800***  Set BUNDLED Co-morbidities adjustment                     ***
092900******************************************************************
093000     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
093100        IF H-PATIENT-AGE  <  18  THEN
093200           MOVE 1.000                  TO
093300                                       H-BUN-COMORBID-MULTIPLIER
093400           MOVE '10'                   TO PPS-2011-COMORBID-PAY
093500        ELSE
093600           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
093700              MOVE 1.000               TO
093800                                       H-BUN-COMORBID-MULTIPLIER
093900              MOVE '10'                TO PPS-2011-COMORBID-PAY
094000           ELSE
094100              PERFORM 2100-CALC-COMORBID-ADJUST
094200              MOVE H-COMORBID-MULTIPLIER TO
094300                                       H-BUN-COMORBID-MULTIPLIER
094400           END-IF
094500        END-IF
094600     ELSE
094700        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
094800           MOVE 1.000                  TO
094900                                       H-BUN-COMORBID-MULTIPLIER
095000           MOVE '10'                   TO PPS-2011-COMORBID-PAY
095100        ELSE
095200           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
095300              MOVE CM-GI-BLEED         TO
095400                                       H-BUN-COMORBID-MULTIPLIER
095500              MOVE '20'                TO PPS-2011-COMORBID-PAY
095600           ELSE
095700              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
095800                 MOVE CM-PNEUMONIA     TO
095900                                       H-BUN-COMORBID-MULTIPLIER
096000                 MOVE '30'             TO PPS-2011-COMORBID-PAY
096100              ELSE
096200                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
096300                    MOVE CM-PERICARDITIS TO
096400                                       H-BUN-COMORBID-MULTIPLIER
096500                    MOVE '40'          TO PPS-2011-COMORBID-PAY
096600                 END-IF
096700              END-IF
096800           END-IF
096900        END-IF
097000     END-IF.
097100
097200******************************************************************
097300***  Calculate BUNDLED Low Volume adjustment                   ***
097400******************************************************************
097500     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
097600        IF H-PATIENT-AGE > 17  THEN
097700           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
097800                                       H-BUN-LOW-VOL-MULTIPLIER
097900           MOVE "Y"                    TO  LOW-VOLUME-TRACK
098000        ELSE
098100           MOVE 1.000                  TO
098200                                       H-BUN-LOW-VOL-MULTIPLIER
098300        END-IF
098400     ELSE
098500        MOVE 1.000                     TO
098600                                       H-BUN-LOW-VOL-MULTIPLIER
098700     END-IF.
098800
098900******************************************************************
099000***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
099100******************************************************************
099200     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
099300        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
099400        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
099500        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
099600        (H-BUN-LOW-VOL-MULTIPLIER).
099700
099800******************************************************************
099900***  Calculate BUNDLED Condition Code payment                  ***
100000******************************************************************
100100* Self-care in Training add-on
100200     IF B-COND-CODE = '73'  THEN
100300* no add-on when onset is present
100400        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
100500           MOVE ZERO                   TO
100600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
100700        ELSE
100800* use new PPS training add-on amount times wage-index
100900           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
101000             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
101100           MOVE "Y"                    TO TRAINING-TRACK
101200        END-IF
101300     ELSE
101400* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
101500        IF (B-COND-CODE = '74')  AND
101600           (B-REV-CODE = '0841' OR '0851')  THEN
101700              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
101800                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
101900        ELSE
102000           MOVE ZERO                   TO
102100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
102200                                    H-CC-74-PER-DIEM-AMT
102300        END-IF
102400     END-IF.
102500
102600******************************************************************
102700***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
102800******************************************************************
102900     IF (B-COND-CODE = '74')  AND
103000        (B-REV-CODE = '0841' OR '0851')  THEN
103100           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
103200                           H-CC-74-PER-DIEM-AMT
103300           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
103400              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
103500              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
103600     ELSE
103700        COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
103800                H-BUN-ADJUSTED-BASE-WAGE-AMT  +
103900                H-BUN-WAGE-ADJ-TRAINING-AMT
104000     END-IF.
104100
104200******************************************************************
104300***  Calculate BUNDLED Outlier                                 ***
104400******************************************************************
104500     PERFORM 2500-CALC-OUTLIER-FACTORS.
104600
104700******************************************************************
104800***  Calculate Low Volume payment for recovery purposes        ***
104900******************************************************************
105000     IF LOW-VOLUME-TRACK = "Y"  THEN
105100        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
105200        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
105300
105400        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
105500           H-PPS-FINAL-PAY-AMT
105600
105700        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
105800           H-OUT-PAYMENT
105900
106000        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
106100           H-LV-OUT-PAYMENT
106200
106300        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
106400           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
106500              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
106600        ELSE
106700           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
106800        END-IF
106900     END-IF.
107000
107100
107200/
107300 2100-CALC-COMORBID-ADJUST.
107400******************************************************************
107500***  Calculate Co-morbidities adjustment                       ***
107600******************************************************************
107700*  This logic assumes that the comorbids are randomly assigned   *
107800*to the comorbid table.  It will select the highest comorbid for *
107900*payment if one is found.                                        *
108000******************************************************************
108100     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
108200     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
108300     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
108400
108500     PERFORM VARYING  SUB  FROM  1 BY 1
108600       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
108700         IF COMORBID-DATA (SUB) = 'MA'  THEN
108800           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
108900           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
109000           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
109100           MOVE '20'                   TO PPS-2011-COMORBID-PAY
109200         ELSE
109300           IF COMORBID-DATA (SUB) = 'MB'  THEN
109400             IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
109500               MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
109600               MOVE "Y"                TO ACUTE-COMORBID-TRACK
109700               MOVE '30'               TO PPS-2011-COMORBID-PAY
109800             END-IF
109900           ELSE
110000             IF COMORBID-DATA (SUB) = 'MC'  THEN
110100                IF CM-PERICARDITIS  >
110200                                      H-COMORBID-MULTIPLIER  THEN
110300                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
110400                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
110500                  MOVE '40'            TO PPS-2011-COMORBID-PAY
110600                END-IF
110700             ELSE
110800               IF COMORBID-DATA (SUB) = 'MD'  THEN
110900                 IF CM-MYELODYSPLASTIC  >
111000                                      H-COMORBID-MULTIPLIER  THEN
111100                   MOVE CM-MYELODYSPLASTIC  TO
111200                                      H-COMORBID-MULTIPLIER
111300                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
111400                   MOVE '50'           TO PPS-2011-COMORBID-PAY
111500                 END-IF
111600               ELSE
111700                 IF COMORBID-DATA (SUB) = 'ME'  THEN
111800                   IF CM-SICKEL-CELL  >
111900                                      H-COMORBID-MULTIPLIER  THEN
112000                     MOVE CM-SICKEL-CELL  TO
112100                                      H-COMORBID-MULTIPLIER
112200                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
112300                     MOVE '60'         TO PPS-2011-COMORBID-PAY
112400                   END-IF
112500                 ELSE
112600                   IF COMORBID-DATA (SUB) = 'MF'  THEN
112700                     IF CM-MONOCLONAL-GAMM  >
112800                                      H-COMORBID-MULTIPLIER  THEN
112900                       MOVE CM-MONOCLONAL-GAMM TO
113000                                      H-COMORBID-MULTIPLIER
113100                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
113200                       MOVE '70'       TO PPS-2011-COMORBID-PAY
113300                     END-IF
113400                   END-IF
113500                 END-IF
113600               END-IF
113700             END-IF
113800           END-IF
113900         END-IF
114000     END-PERFORM.
114100/
114200 2500-CALC-OUTLIER-FACTORS.
114300******************************************************************
114400***  Set separately billable OUTLIER age adjustment factor     ***
114500******************************************************************
114600     IF H-PATIENT-AGE < 13  THEN
114700        IF B-REV-CODE = '0821' OR '0881' THEN
114800           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
114900        ELSE
115000           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
115100        END-IF
115200     ELSE
115300        IF H-PATIENT-AGE < 18 THEN
115400           IF B-REV-CODE = '0821' OR '0881'  THEN
115500              MOVE SB-AGE-13-17-HEMO-MODE
115600                                       TO H-OUT-AGE-FACTOR
115700           ELSE
115800              MOVE SB-AGE-13-17-PD-MODE
115900                                       TO H-OUT-AGE-FACTOR
116000           END-IF
116100        ELSE
116200           IF H-PATIENT-AGE < 45  THEN
116300              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
116400           ELSE
116500              IF H-PATIENT-AGE < 60  THEN
116600                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
116700              ELSE
116800                 IF H-PATIENT-AGE < 70  THEN
116900                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
117000                 ELSE
117100                    IF H-PATIENT-AGE < 80  THEN
117200                       MOVE SB-AGE-70-79
117300                                       TO H-OUT-AGE-FACTOR
117400                    ELSE
117500                       MOVE SB-AGE-80-PLUS
117600                                       TO H-OUT-AGE-FACTOR
117700                    END-IF
117800                 END-IF
117900              END-IF
118000           END-IF
118100        END-IF
118200     END-IF.
118300
118400******************************************************************
118500**Calculate separately billable OUTLIER BSA factor (superscript)**
118600******************************************************************
118700     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
118800         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
118900
119000     IF H-PATIENT-AGE > 17  THEN
119100        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
119200             SB-BSA ** ((H-OUT-BSA - 1.87) / .1)
119300     ELSE
119400        MOVE 1.000                     TO H-OUT-BSA-FACTOR
119500     END-IF.
119600
119700******************************************************************
119800***  Calculate separately billable OUTLIER BMI factor          ***
119900******************************************************************
120000     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
120100         (B-PATIENT-HGT ** 2)) * 10000.
120200
120300     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
120400        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
120500     ELSE
120600        MOVE 1.000                     TO H-OUT-BMI-FACTOR
120700     END-IF.
120800
120900******************************************************************
121000***  Calculate separately billable OUTLIER ONSET factor        ***
121100******************************************************************
121200     IF B-DIALYSIS-START-DATE > ZERO  THEN
121300        IF H-PATIENT-AGE > 17  THEN
121400           IF ONSET-DATE > 120  THEN
121500              MOVE 1                   TO H-OUT-ONSET-FACTOR
121600           ELSE
121700              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
121800           END-IF
121900        ELSE
122000           MOVE 1                      TO H-OUT-ONSET-FACTOR
122100        END-IF
122200     ELSE
122300        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
122400     END-IF.
122500
122600******************************************************************
122700***  Set separately billable OUTLIER Co-morbidities adjustment ***
122800******************************************************************
122900     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
123000        IF H-PATIENT-AGE  <  18  THEN
123100           MOVE 1.000                  TO
123200                                       H-OUT-COMORBID-MULTIPLIER
123300           MOVE '10'                   TO PPS-2011-COMORBID-PAY
123400        ELSE
123500           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
123600              MOVE 1.000               TO
123700                                       H-OUT-COMORBID-MULTIPLIER
123800              MOVE '10'                TO PPS-2011-COMORBID-PAY
123900           ELSE
124000              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
124100           END-IF
124200        END-IF
124300     ELSE
124400        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
124500           MOVE 1.000                  TO
124600                                       H-OUT-COMORBID-MULTIPLIER
124700        ELSE
124800           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
124900              MOVE SB-GI-BLEED         TO
125000                                       H-OUT-COMORBID-MULTIPLIER
125100           ELSE
125200              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
125300                 MOVE SB-PNEUMONIA     TO
125400                                       H-OUT-COMORBID-MULTIPLIER
125500              ELSE
125600                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
125700                    MOVE SB-PERICARDITIS TO
125800                                       H-OUT-COMORBID-MULTIPLIER
125900                 END-IF
126000              END-IF
126100           END-IF
126200        END-IF
126300     END-IF.
126400
126500******************************************************************
126600***  Set OUTLIER low-volume-multiplier                         ***
126700******************************************************************
126800     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
126900        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
127000     ELSE
127100        IF H-PATIENT-AGE < 18  THEN
127200           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
127300        ELSE
127400           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
127500           MOVE "Y"                    TO LOW-VOLUME-TRACK
127600        END-IF
127700     END-IF.
127800
127900******************************************************************
128000***  Calculate predicted OUTLIER services MAP per treatment    ***
128100******************************************************************
128200     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
128300        (H-OUT-AGE-FACTOR             *
128400         H-OUT-BSA-FACTOR             *
128500         H-OUT-BMI-FACTOR             *
128600         H-OUT-ONSET-FACTOR           *
128700         H-OUT-COMORBID-MULTIPLIER    *
128800         H-OUT-LOW-VOL-MULTIPLIER).
128900
129000******************************************************************
129100***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
129200******************************************************************
129300     IF H-PATIENT-AGE < 18  THEN
129400        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
129500           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
129600        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
129700     ELSE
129800
129900        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
130000           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
130100        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
130200     END-IF.
130300
130400******************************************************************
130500*** Calculate imputed OUTLIER services MAP amount per treatment***
130600******************************************************************
130700     IF (B-COND-CODE = '74')  AND
130800        (B-REV-CODE = '0841' OR '0851')  THEN
130900         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
131000            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
131100         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
131200         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
131300     ELSE
131400        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
131500        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
131600     END-IF.
131700
131800******************************************************************
131900*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
132000******************************************************************
132100     IF H-PATIENT-AGE < 18   THEN
132200        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
132300           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
132400        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
132500        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
132600           COMPUTE H-OUT-PAYMENT  ROUNDED  =
132700            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
132800                                         LOSS-SHARING-PCT-LT-18
132900           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
133000           MOVE "Y"                    TO OUTLIER-TRACK
133100        ELSE
133200           MOVE ZERO                   TO H-OUT-PAYMENT
133300           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
133400        END-IF
133500     ELSE
133600        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
133700           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
133800           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
133900        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
134000           COMPUTE H-OUT-PAYMENT  ROUNDED  =
134100            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
134200                                         LOSS-SHARING-PCT-GT-17
134300           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
134400           MOVE "Y"                    TO OUTLIER-TRACK
134500        ELSE
134600           MOVE ZERO                   TO H-OUT-PAYMENT
134700        END-IF
134800     END-IF.
134900
135000     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
135100
135200* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
135300     IF (B-COND-CODE = '74')  AND
135400        (B-REV-CODE = '0841' OR '0851')  THEN
135500           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
135600             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
135700     END-IF.
135800/
135900 2600-CALC-COMORBID-OUT-ADJUST.
136000******************************************************************
136100***  Calculate OUTLIER Co-morbidities adjustment               ***
136200******************************************************************
136300*  This logic assumes that the comorbids are randomly assigned   *
136400*to the comorbid table.  It will select the highest comorbid for *
136500*payment if one is found.                                        *
136600******************************************************************
136700
136800     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
136900     MOVE 1.000                        TO
137000                                  H-OUT-COMORBID-MULTIPLIER.
137100
137200     PERFORM VARYING  SUB  FROM  1 BY 1
137300       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
137400         IF COMORBID-DATA (SUB) = 'MA'  THEN
137500           MOVE SB-GI-BLEED            TO
137600                                  H-OUT-COMORBID-MULTIPLIER
137700           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
137800           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
137900         ELSE
138000           IF COMORBID-DATA (SUB) = 'MB'  THEN
138100             IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
138200               MOVE SB-PNEUMONIA       TO
138300                                  H-OUT-COMORBID-MULTIPLIER
138400               MOVE "Y"                TO ACUTE-COMORBID-TRACK
138500             END-IF
138600           ELSE
138700             IF COMORBID-DATA (SUB) = 'MC'  THEN
138800                IF SB-PERICARDITIS  >
138900                                  H-OUT-COMORBID-MULTIPLIER  THEN
139000                  MOVE SB-PERICARDITIS TO
139100                                  H-OUT-COMORBID-MULTIPLIER
139200                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
139300                END-IF
139400             ELSE
139500               IF COMORBID-DATA (SUB) = 'MD'  THEN
139600                 IF SB-MYELODYSPLASTIC  >
139700                                  H-OUT-COMORBID-MULTIPLIER  THEN
139800                   MOVE SB-MYELODYSPLASTIC  TO
139900                                  H-OUT-COMORBID-MULTIPLIER
140000                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
140100                 END-IF
140200               ELSE
140300                 IF COMORBID-DATA (SUB) = 'ME'  THEN
140400                   IF SB-SICKEL-CELL  >
140500                                  H-OUT-COMORBID-MULTIPLIER  THEN
140600                     MOVE SB-SICKEL-CELL  TO
140700                                  H-OUT-COMORBID-MULTIPLIER
140800                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
140900                   END-IF
141000                 ELSE
141100                   IF COMORBID-DATA (SUB) = 'MF'  THEN
141200                     IF SB-MONOCLONAL-GAMM  >
141300                                  H-OUT-COMORBID-MULTIPLIER  THEN
141400                       MOVE SB-MONOCLONAL-GAMM  TO
141500                                  H-OUT-COMORBID-MULTIPLIER
141600                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
141700                     END-IF
141800                   END-IF
141900                 END-IF
142000               END-IF
142100             END-IF
142200           END-IF
142300         END-IF
142400     END-PERFORM.
142500/
142600******************************************************************
142700*** Calculate Low Volume Full PPS payment for recovery purposes***
142800******************************************************************
142900 3000-LOW-VOL-FULL-PPS-PAYMENT.
143000******************************************************************
143100** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
143200     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
143300        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
143400        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
143500        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER).
143600
143700******************************************************************
143800**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
143900* Self-care in Training add-on
144000     IF B-COND-CODE = '73'  THEN
144100* no add-on when onset is present
144200        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
144300           MOVE ZERO                   TO
144400                                    H-BUN-WAGE-ADJ-TRAINING-AMT
144500        ELSE
144600* use new PPS training add-on amount times wage-index
144700           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
144800             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
144900           MOVE "Y"                    TO TRAINING-TRACK
145000        END-IF
145100     ELSE
145200* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
145300        IF (B-COND-CODE = '74')  AND
145400           (B-REV-CODE = '0841' OR '0851')  THEN
145500              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
145600                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
145700        ELSE
145800           MOVE ZERO                   TO
145900                                    H-BUN-WAGE-ADJ-TRAINING-AMT
146000                                    H-CC-74-PER-DIEM-AMT
146100        END-IF
146200     END-IF.
146300
146400******************************************************************
146500**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
146600     IF (B-COND-CODE = '74')  AND
146700        (B-REV-CODE = '0841' OR '0851')  THEN
146800           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
146900                           H-CC-74-PER-DIEM-AMT
147000     ELSE
147100        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
147200                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
147300                H-BUN-WAGE-ADJ-TRAINING-AMT
147400     END-IF.
147500
147600/
147700******************************************************************
147800*** Calculate Low Volume OUT PPS payment for recovery purposes ***
147900******************************************************************
148000 3100-LOW-VOL-OUT-PPS-PAYMENT.
148100******************************************************************
148200**Modified code from 'Calc predict OUT serv MAP per treat' para.**
148300     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
148400        (H-OUT-AGE-FACTOR             *
148500         H-OUT-BSA-FACTOR             *
148600         H-OUT-BMI-FACTOR             *
148700         H-OUT-ONSET-FACTOR           *
148800         H-OUT-COMORBID-MULTIPLIER).
148900
149000******************************************************************
149100**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
149200     IF H-PATIENT-AGE < 18  THEN
149300        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
149400           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
149500        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
149600     ELSE
149700        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
149800           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
149900        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
150000     END-IF.
150100
150200******************************************************************
150300** 'Calculate imput OUT services MAP amount per treatment' para **
150400** It is not necessary to modify or insert this paragraph here. **
150500
150600******************************************************************
150700**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
150800     IF H-PATIENT-AGE < 18   THEN
150900        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
151000           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
151100        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
151200        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
151300           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
151400            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
151500                                         LOSS-SHARING-PCT-LT-18
151600           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
151700        ELSE
151800           MOVE ZERO                   TO H-LV-OUT-PAYMENT
151900           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
152000        END-IF
152100     ELSE
152200        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
152300           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
152400           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
152500        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
152600           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
152700            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
152800                                         LOSS-SHARING-PCT-GT-17
152900           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
153000        ELSE
153100           MOVE ZERO                   TO H-LV-OUT-PAYMENT
153200        END-IF
153300     END-IF.
153400
153500     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
153600
153700* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
153800     IF (B-COND-CODE = '74')  AND
153900        (B-REV-CODE = '0841' OR '0851')  THEN
154000           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
154100             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
154200     END-IF.
154300/
154400 5000-CALC-COMP-RATE-FACTORS.
154500******************************************************************
154600***  Set Composite Rate age adjustment factor                  ***
154700******************************************************************
154800     IF H-PATIENT-AGE < 18  THEN
154900        MOVE CR-AGE-LT-18              TO H-AGE-FACTOR
155000     ELSE
155100        IF H-PATIENT-AGE < 45  THEN
155200           MOVE CR-AGE-18-44           TO H-AGE-FACTOR
155300        ELSE
155400           IF H-PATIENT-AGE < 60  THEN
155500              MOVE CR-AGE-45-59        TO H-AGE-FACTOR
155600           ELSE
155700              IF H-PATIENT-AGE < 70  THEN
155800                 MOVE CR-AGE-60-69     TO H-AGE-FACTOR
155900              ELSE
156000                 IF H-PATIENT-AGE < 80  THEN
156100                    MOVE CR-AGE-70-79  TO H-AGE-FACTOR
156200                 ELSE
156300                    MOVE CR-AGE-80-PLUS
156400                                       TO H-AGE-FACTOR
156500                 END-IF
156600              END-IF
156700           END-IF
156800        END-IF
156900     END-IF.
157000
157100******************************************************************
157200**Calculate Composite Rate BSA factor (2012 superscript now same)*
157300******************************************************************
157400     COMPUTE H-BSA  ROUNDED = (.007184 *
157500         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
157600
157700     IF H-PATIENT-AGE > 17  THEN
157800        COMPUTE H-BSA-FACTOR  ROUNDED =
157900             CR-BSA ** ((H-BSA - 1.87) / .1)
158000     ELSE
158100        MOVE 1.000                     TO H-BSA-FACTOR
158200     END-IF.
158300
158400******************************************************************
158500*** Calculate Composite Rate BMI factor (different BMI < 18.5) ***
158600******************************************************************
158700     COMPUTE H-BMI  ROUNDED = (B-PATIENT-WGT /
158800         (B-PATIENT-HGT ** 2)) * 10000.
158900
159000     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)  THEN
159100        MOVE CR-BMI-LT-18-5            TO H-BMI-FACTOR
159200     ELSE
159300        MOVE 1.000                     TO H-BMI-FACTOR
159400     END-IF.
159500
159600******************************************************************
159700***  Calculate Composite Rate Payment Amount                   ***
159800******************************************************************
159900*P-ESRD-RATE, also called the Exception Rate, will not be granted*
160000*in full beginning in 2011 (the beginning of the Bundled method) *
160100*and will be eliminated entirely beginning in 2014 which is the  *
160200*end of the blending period.  For 2011, those providers who elect*
160300*to be in the blend, will get only 75% of the exception rate.    *
160400*This apparently is for the pediatric providers who originally   *
160500*had the exception rate.                                         *
160600
160700     IF P-ESRD-RATE  =  ZERO  THEN
160800        MOVE BASE-PAYMENT-RATE         TO  H-PAYMENT-RATE
160900     ELSE
161000        MOVE P-ESRD-RATE               TO  H-PAYMENT-RATE
161100     END-IF.
161200
161300     COMPUTE H-WAGE-ADJ-PYMT-AMT ROUNDED =
161400     (((H-PAYMENT-RATE * NAT-LABOR-PCT) * COM-CBSA-W-INDEX) +
161500       (H-PAYMENT-RATE * NAT-NONLABOR-PCT)) *
161600            CBSA-BLEND-PCT.
161700
161800     COMPUTE H-PYMT-AMT ROUNDED = (H-WAGE-ADJ-PYMT-AMT *
161900        H-BMI-FACTOR * H-BSA-FACTOR * CASE-MIX-BDGT-NEUT-FACTOR *
162000        H-AGE-FACTOR * DRUG-ADDON).
162100
162200     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
162300
162400******************************************************************
162500***  Calculate condition code payment                          ***
162600******************************************************************
162700     MOVE SPACES                       TO COND-CD-73.
162800
162900* Hemo, peritoneal, or CCPD training add-on
163000     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
163100                                                      OR '0851')
163200        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
163300        MOVE 'A'                       TO AMT-INDIC
163400        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
163500     ELSE
163600* CAPD training add-on
163700        IF (B-COND-CODE = '73')  AND  (B-REV-CODE = '0841')  THEN
163800           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
163900           MOVE 'A'                    TO AMT-INDIC
164000           MOVE CAPD-AMT               TO BLOOD-DOLLAR
164100        ELSE
164200* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
164300           IF (B-COND-CODE = '74')  AND
164400              (B-REV-CODE = '0841' OR '0851')  THEN
164500              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
164600                                           CAPD-OR-CCPD-FACTOR
164700              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
164800           ELSE
164900              MOVE 'A'                 TO AMT-INDIC
165000              MOVE ZERO                TO BLOOD-DOLLAR
165100           END-IF
165200        END-IF
165300     END-IF.
165400
165500/
165600 9000-SET-RETURN-CODE.
165700******************************************************************
165800***  Set the return code                                       ***
165900******************************************************************
166000*   The following 'table' helps in understanding and in making   *
166100*changes to the rather large and complex "IF" statement that     *
166200*follows.  This 'table' just reorders and rewords the comments   *
166300*contained in the working storage area concerning the paid       *
166400*return-codes.                                                   *
166500*                                                                *
166600*  17 = pediatric, outlier, training                             *
166700*  16 = pediatric, outlier                                       *
166800*  15 = pediatric, training                                      *
166900*  14 = pediatric                                                *
167000*                                                                *
167100*  24 = outlier, low volume, training, chronic comorbid          *
167200*  19 = outlier, low volume, training, acute comorbid            *
167300*  29 = outlier, low volume, training                            *
167400*  23 = outlier, low volume, chronic comorbid                    *
167500*  18 = outlier, low volume, acute comorbid                      *
167600*  30 = outlier, low volume, onset                               *
167700*  28 = outlier, low volume                                      *
167800*  34 = outlier, training, chronic comorbid                      *
167900*  35 = outlier, training, acute comorbid                        *
168000*  33 = outlier, training                                        *
168100*  07 = outlier, chronic comorbid                                *
168200*  06 = outlier, acute comorbid                                  *
168300*  09 = outlier, onset                                           *
168400*  03 = outlier                                                  *
168500*                                                                *
168600*  26 = low volume, training, chronic comorbid                   *
168700*  21 = low volume, training, acute comorbid                     *
168800*  12 = low volume, training                                     *
168900*  25 = low volume, chronic comorbid                             *
169000*  20 = low volume, acute comorbid                               *
169100*  32 = low volume, onset                                        *
169200*  10 = low volume                                               *
169300*                                                                *
169400*  27 = training, chronic comorbid                               *
169500*  22 = training, acute comorbid                                 *
169600*  11 = training                                                 *
169700*                                                                *
169800*  08 = onset                                                    *
169900*  04 = acute comorbid                                           *
170000*  05 = chronic comorbid                                         *
170100*  31 = low BMI                                                  *
170200*  02 = no adjustments                                           *
170300*                                                                *
170400*  13 = w/multiple adjustments....reserved for future use        *
170500******************************************************************
170600/
170700     IF PEDIATRIC-TRACK                       = "Y"  THEN
170800        IF OUTLIER-TRACK                      = "Y"  THEN
170900           IF TRAINING-TRACK                  = "Y"  THEN
171000              MOVE 17                  TO PPS-RTC
171100           ELSE
171200              MOVE 16                  TO PPS-RTC
171300           END-IF
171400        ELSE
171500           IF TRAINING-TRACK                  = "Y"  THEN
171600              MOVE 15                  TO PPS-RTC
171700           ELSE
171800              MOVE 14                  TO PPS-RTC
171900           END-IF
172000        END-IF
172100     ELSE
172200        IF OUTLIER-TRACK                      = "Y"  THEN
172300           IF LOW-VOLUME-TRACK                = "Y"  THEN
172400              IF TRAINING-TRACK               = "Y"  THEN
172500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
172600                    MOVE 24            TO PPS-RTC
172700                 ELSE
172800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
172900                       MOVE 19         TO PPS-RTC
173000                    ELSE
173100                       MOVE 29         TO PPS-RTC
173200                    END-IF
173300                 END-IF
173400              ELSE
173500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
173600                    MOVE 23            TO PPS-RTC
173700                 ELSE
173800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
173900                       MOVE 18         TO PPS-RTC
174000                    ELSE
174100                       IF ONSET-TRACK         = "Y"  THEN
174200                          MOVE 30      TO PPS-RTC
174300                       ELSE
174400                          MOVE 28      TO PPS-RTC
174500                       END-IF
174600                    END-IF
174700                 END-IF
174800              END-IF
174900           ELSE
175000              IF TRAINING-TRACK               = "Y"  THEN
175100                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
175200                    MOVE 34            TO PPS-RTC
175300                 ELSE
175400                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
175500                       MOVE 35         TO PPS-RTC
175600                    ELSE
175700                       MOVE 33         TO PPS-RTC
175800                    END-IF
175900                 END-IF
176000              ELSE
176100                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
176200                    MOVE 07            TO PPS-RTC
176300                 ELSE
176400                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
176500                       MOVE 06         TO PPS-RTC
176600                    ELSE
176700                       IF ONSET-TRACK         = "Y"  THEN
176800                          MOVE 09      TO PPS-RTC
176900                       ELSE
177000                          MOVE 03      TO PPS-RTC
177100                       END-IF
177200                    END-IF
177300                 END-IF
177400              END-IF
177500           END-IF
177600        ELSE
177700           IF LOW-VOLUME-TRACK                = "Y"
177800              IF TRAINING-TRACK               = "Y"  THEN
177900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
178000                    MOVE 26            TO PPS-RTC
178100                 ELSE
178200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
178300                       MOVE 21         TO PPS-RTC
178400                    ELSE
178500                       MOVE 12         TO PPS-RTC
178600                    END-IF
178700                 END-IF
178800              ELSE
178900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
179000                    MOVE 25            TO PPS-RTC
179100                 ELSE
179200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
179300                       MOVE 20         TO PPS-RTC
179400                    ELSE
179500                       IF ONSET-TRACK         = "Y"  THEN
179600                          MOVE 32      TO PPS-RTC
179700                       ELSE
179800                          MOVE 10      TO PPS-RTC
179900                       END-IF
180000                    END-IF
180100                 END-IF
180200              END-IF
180300           ELSE
180400              IF TRAINING-TRACK               = "Y"  THEN
180500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
180600                    MOVE 27            TO PPS-RTC
180700                 ELSE
180800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
180900                       MOVE 22         TO PPS-RTC
181000                    ELSE
181100                       MOVE 11         TO PPS-RTC
181200                    END-IF
181300                 END-IF
181400              ELSE
181500                 IF ONSET-TRACK               = "Y"  THEN
181600                    MOVE 08            TO PPS-RTC
181700                 ELSE
181800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
181900                       MOVE 04         TO PPS-RTC
182000                    ELSE
182100                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
182200                          MOVE 05      TO PPS-RTC
182300                       ELSE
182400                          IF LOW-BMI-TRACK = "Y"  THEN
182500                             MOVE 31 TO PPS-RTC
182600                          ELSE
182700                             MOVE 02 TO PPS-RTC
182800                          END-IF
182900                       END-IF
183000                    END-IF
183100                 END-IF
183200              END-IF
183300           END-IF
183400        END-IF
183500     END-IF.
183600/
183700 9100-MOVE-RESULTS.
183800     IF MOVED-CORMORBIDS = SPACES  THEN
183900        NEXT SENTENCE
184000     ELSE
184100        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
184200        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
184300        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
184400        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
184500        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
184600        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
184700        MOVE H-COMORBID-CWF-CODE       TO
184800                                    COMORBID-CWF-RETURN-CODE
184900     END-IF.
185000
185100     MOVE P-GEO-MSA                    TO PPS-MSA.
185200     MOVE P-GEO-CBSA                   TO PPS-CBSA.
185300     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
185400     MOVE B-COND-CODE                  TO PPS-COND-CODE.
185500     MOVE B-REV-CODE                   TO PPS-REV-CODE.
185600     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
185700     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
185800     MOVE BUN-NAT-NONLABOR-PCT         TO
185900                                    PPS-2011-NAT-NONLABOR-PCT.
186000     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
186100     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
186200     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
186300     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
186400     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
186500     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
186600     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
186700     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
186800     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
186900     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
187000                                    PPS-2011-BDGT-NEUT-RATE.
187100     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
187200     MOVE SPACES                       TO
187300                                    PPS-2011-COMORBID-MA-CC.
187400
187500     IF (B-COND-CODE = '74')  AND
187600        (B-REV-CODE = '0841' OR '0851')  THEN
187700         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
187800                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
187900     END-IF.
188000
188100     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
188200           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
188300              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
188400           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
188500              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
188600           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
188700              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
188800     ELSE
188900        MOVE ZERO                      TO
189000                                    PPS-2011-BLEND-COMP-RATE
189100        MOVE ZERO                      TO
189200                                    PPS-2011-BLEND-PPS-RATE
189300        MOVE ZERO                      TO
189400                                    PPS-2011-BLEND-OUTLIER-RATE
189500     END-IF.
189600
189700     MOVE H-PYMT-AMT                   TO
189800                                    PPS-2011-FULL-COMP-RATE.
189900     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
190000                                          PPS-FINAL-PAY-AMT.
190100     MOVE H-OUT-PAYMENT                TO
190200                                    PPS-2011-FULL-OUTLIER-RATE.
190300
190400
190500     IF P-QIP-REDUCTION = ' ' THEN
190600        NEXT SENTENCE
190700     ELSE
190800        COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
190900                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
191000        COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
191100                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
191200        COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
191300                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
191400        COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
191500                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
191600        COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
191700                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
191800        COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
191900                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
192000     END-IF.
192100
192200     IF BUNDLED-TEST   THEN
192300        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
192400        MOVE 0.0                       TO MSA-WAGE-ADJ
192500        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
192600        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
192700        MOVE H-PATIENT-AGE             TO AGE-RETURN
192800        MOVE 0.0                       TO MSA-WAGE-AMT
192900        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
193000        MOVE H-BMI                     TO PPS-BMI
193100        MOVE H-BSA                     TO PPS-BSA
193200        MOVE MSA-BLEND-PCT             TO MSA-PCT
193300        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
193400
193500        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
193600           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
193700           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
193800        ELSE
193900           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
194000           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
194100        END-IF
194200
194300        MOVE H-BUN-BSA                 TO BUN-BSA
194400        MOVE H-BUN-BMI                 TO BUN-BMI
194500        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
194600        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
194700        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
194800        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
194900        MOVE H-OUT-BSA                 TO OUT-BSA
195000        MOVE SB-BSA                    TO OUT-SB-BSA
195100        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
195200        MOVE H-OUT-BMI                 TO OUT-BMI
195300        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
195400        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
195500        MOVE H-OUT-COMORBID-MULTIPLIER TO
195600                                    OUT-COMORBID-MULTIPLIER
195700        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
195800                                    OUT-PREDICTED-SERVICES-MAP
195900        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
196000                                    OUT-CASE-MIX-PREDICTED-MAP
196100        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
196200                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
196300        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
196400        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
196500        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
196600        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
196700        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
196800        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
196900        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
197000        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
197100        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
197200        MOVE CM-BSA                    TO PPS-CM-BSA
197300        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
197400        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
197500        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
197600        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
197700                                    BUN-ADJUSTED-BASE-WAGE-AMT
197800        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
197900                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
198000        MOVE TRAINING-ADD-ON-PMT-AMT   TO
198100                                    PPS-TRAINING-ADD-ON-PMT-AMT
198200        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
198300     END-IF.
198400******        L A S T   S O U R C E   S T A T E M E N T      *****
