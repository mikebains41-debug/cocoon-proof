000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL130.
000300*AUTHOR.     CMS
000400*       EFFECTIVE JANUARY 1, 2013
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
018600*
018700******************************************************************
018800 DATE-COMPILED.
018900 ENVIRONMENT DIVISION.
019000 CONFIGURATION SECTION.
019100 SOURCE-COMPUTER.            IBM-Z990.
019200 OBJECT-COMPUTER.            ITTY-BITTY-MACHINE-CORPORATION.
019300 INPUT-OUTPUT  SECTION.
019400 FILE-CONTROL.
019500
019600 DATA DIVISION.
019700 FILE SECTION.
019800/
019900 WORKING-STORAGE SECTION.
020000 01  W-STORAGE-REF                  PIC X(46) VALUE
020100     'ESCAL130      - W O R K I N G   S T O R A G E'.
020200 01  CAL-VERSION                    PIC X(05) VALUE 'C13.0'.
020300
020400 01  DISPLAY-LINE-MEASUREMENT.
020500     05  FILLER                     PIC X(50) VALUE
020600         '....:...10....:...20....:...30....:...40....:...50'.
020700     05  FILLER                     PIC X(50) VALUE
020800         '....:...60....:...70....:...80....:...90....:..100'.
020900     05  FILLER                     PIC X(20) VALUE
021000         '....:..110....:..120'.
021100
021200 01  PRINT-LINE-MEASUREMENT.
021300     05  FILLER                     PIC X(51) VALUE
021400         'X....:...10....:...20....:...30....:...40....:...50'.
021500     05  FILLER                     PIC X(50) VALUE
021600         '....:...60....:...70....:...80....:...90....:..100'.
021700     05  FILLER                     PIC X(32) VALUE
021800         '....:..110....:..120....:..130..'.
021900/
022000******************************************************************
022100*  This area contains all of the old Composite Rate variables.   *
022200* They will be eliminated when the transition period ends - 2014 *
022300******************************************************************
022400 01  HOLD-COMP-RATE-PPS-COMPONENTS.
022500     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
022600     05  H-PYMT-AMT                 PIC 9(04)V9(02).
022700     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
022800     05  H-PATIENT-AGE              PIC 9(03).
022900     05  H-AGE-FACTOR               PIC 9(01)V9(03).
023000     05  H-BSA-FACTOR               PIC 9(01)V9(04).
023100     05  H-BMI-FACTOR               PIC 9(01)V9(04).
023200     05  H-BSA                      PIC 9(03)V9(04).
023300     05  H-BMI                      PIC 9(03)V9(04).
023400     05  HGT-PART                   PIC 9(04)V9(08).
023500     05  WGT-PART                   PIC 9(04)V9(08).
023600     05  COMBINED-PART              PIC 9(04)V9(08).
023700     05  CALC-BSA                   PIC 9(04)V9(08).
023800
023900
024000* The following two variables will change from year to year
024100* and are used for the COMPOSITE part of the Bundled Pricer.
024200 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1400.
024300 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 145.20.
024400
024500* The next two percentages MUST add up to 1 (i.e. 100%)
024600* They will continue to change until CY2009 when CBSA will be 1.00
024700 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
024800 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
024900
025000* CONSTANTS AREA
025100* The next two percentages MUST add up TO 1 (i.e. 100%)
025200 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
025300 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
025400
025500* The next variable is only applicapable for the 2011 Pricer.
025600 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
025700
025800 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
025900 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
026000 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
026100                                                         0.428571.
026200* The above number technically represents the fractional
026300* number 3/7 which is three days per week that a person can
026400* receive dialysis.  It will remain this value ONLY for the
026500* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
026600* use the calculation method which is more understandable and
026700* follows the method used by the Policy folks.
026800
026900*  The following number that is loaded into the payment equation
027000*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
027100*  and   --DOES NOT CHANGE--
027200
027300 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
027400
027500 01  COMPOSITE-RATE-MULTIPLIERS.
027600*Composite rate payment multiplier (used for blended providers)
027700     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
027800     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
027900     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
028000     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
028100     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
028200     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
028300
028400     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
028500     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
028600/
028700******************************************************************
028800*    This area contains all of the NEW Bundled Rate variables.   *
028900******************************************************************
029000 01  HOLD-BUNDLED-PPS-COMPONENTS.
029100     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
029200     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
029300     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
029400     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
029500     05  H-BUN-BSA                  PIC 9(03)V9(04).
029600     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
029700     05  H-BUN-BMI                  PIC 9(03)V9(04).
029800     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
029900     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
030000     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
030100     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
030200                                    PIC 9(07)V9(04).
030300     05  H-BUN-WAGE-ADJ-TRAINING-AMT
030400                                    PIC 9(07)V9(04).
030500     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
030600     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
030700     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
030800     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
030900     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
031000                                    PIC 9(07)V9(04).
031100     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
031200     05  H-LV-OUT-PREDICT-SERVICES-MAP
031300                                    PIC 9(07)V9(04).
031400     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
031500                                    PIC 9(07)V9(04).
031600     05  H-LV-OUT-PREDICTED-MAP
031700                                    PIC 9(07)V9(04).
031800     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
031900
032000     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
032100     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
032200         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
032300
032400     05  H-COMORBID-DATA  OCCURS 6 TIMES
032500            INDEXED BY H-COMORBID-INDEX
032600                                    PIC X(02).
032700     05  H-COMORBID-CWF-CODE        PIC X(02).
032800
032900     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
033000
033100     05  QIP-REDUCTION              PIC 9(01)V9(03).
033200     05  SUB                        PIC 9(04).
033300
033400     05  THE-DATE                   PIC 9(08).
033500     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
033600     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
033700     05  ONSET-DATE                 PIC 9(08).
033800     05  MOVED-CORMORBIDS           PIC X(01).
033900
034000 01  HOLD-OUTLIER-PPS-COMPONENTS.
034100     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
034200     05  H-OUT-BSA                  PIC 9(03)V9(04).
034300     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
034400     05  H-OUT-BMI                  PIC 9(03)V9(04).
034500     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
034600     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
034700     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
034800     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
034900     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
035000     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
035100     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
035200     05  H-OUT-PREDICTED-SERVICES-MAP
035300                                    PIC 9(07)V9(04).
035400     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
035500     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
035600                                    PIC 9(07)V9(04).
035700     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
035800     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
035900     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
036000
036100
036200* The following variable will change from year to year and is
036300* used for the BUNDLED part of the Bundled Pricer.
036400 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 240.36.
036500
036600* The next two percentages MUST add up to 1 (i.e. 100%)
036700* They start in 2011 and will continue to change until CY2014 when
036800* BUN-CBSA-BLEND-PCT will be 1.00
036900* The third blend percent is for those providers that waived the
037000* blended percent and went to full PPS.  This variable will be
037100* eliminated in 2014 when it is no longer needed.
037200 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.25.
037300 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.75.
037400 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
037500
037600* CONSTANTS AREA
037700* The next two percentages MUST add up TO 1 (i.e. 100%)
037800 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.41737.
037900 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.58263.
038000 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 33.44.
038100
038200*  The following number that is loaded into the payment equation
038300*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
038400*  and   --DOES NOT CHANGE--
038500
038600 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
038700
038800 01  PEDIATRIC-MULTIPLIERS.
038900*Separately billable payment multiplier (used for outliers)
039000     05  PED-SEP-BILL-PAY-MULTI.
039100         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.319.
039200         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.185.
039300         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.476.
039400         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.459.
039500     05  PED-EXPAND-BUNDLE-PAY-MULTI.
039600*Expanded bundle payment multiplier (used for normal billing)
039700         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.033.
039800         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.219.
039900         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.067.
040000         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.277.
040100
040200 01  ADULT-MULTIPLIERS.
040300*Separately billable payment multiplier (used for outliers)
040400     05  SEP-BILLABLE-PAYMANT-MULTI.
040500         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 0.996.
040600         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 0.992.
040700         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
040800         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 0.963.
040900         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.915.
041000         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.014.
041100         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.078.
041200         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.450.
041300         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.354.
041400         10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
041500         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.571.
041600         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.225.
041700         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.309.
041800         10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
041900         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.975.
042000*Case-Mix adjusted payment multiplier (used for normal billing)
042100     05  CASE-MIX-PAYMENT-MULTI.
042200         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.171.
042300         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.013.
042400         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
042500         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.011.
042600         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.016.
042700         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.020.
042800         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.025.
042900         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.510.
043000         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.114.
043100         10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
043200         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.183.
043300         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.072.
043400         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.099.
043500         10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
043600         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.189.
043700
043800 01  OUTLIER-SB-CALC-AMOUNTS.
043900     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 41.39.
044000     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 59.42.
044100     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 47.32.
044200     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 110.22.
044300     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
044400     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
044500/
044600******************************************************************
044700*    This area contains return code variables and their codes.   *
044800******************************************************************
044900 01 PAID-RETURN-CODE-TRACKERS.
045000     05  OUTLIER-TRACK              PIC X(01).
045100     05  ACUTE-COMORBID-TRACK       PIC X(01).
045200     05  CHRONIC-COMORBID-TRACK     PIC X(01).
045300     05  ONSET-TRACK                PIC X(01).
045400     05  LOW-VOLUME-TRACK           PIC X(01).
045500     05  TRAINING-TRACK             PIC X(01).
045600     05  PEDIATRIC-TRACK            PIC X(01).
045700     05  LOW-BMI-TRACK              PIC X(01).
045800 COPY RTCCPY.
045900*COPY "RTCCPY.CPY".
046000*                                                                *
046100*  Legal combinations of adjustments for ADULTS are:             *
046200*     if NO ONSET applies, then they can have any combination of:*
046300*       acute OR chronic comorbid, & outlier, low vol., training.*
046400*     if ONSET applies, then they can have:                      *
046500*           outlier and/or low volume.                           *
046600*  Legal combinations of adjustments for PEDIATRIC are:          *
046700*     outlier and/or training.                                   *
046800*                                                                *
046900*  Illegal combinations of adjustments for PEDIATRIC are:        *
047000*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
047100*     onset     with comorbid or training.                       *
047200*  Illegal combinations of adjustments for ANYONE are:           *
047300*     acute comorbid AND chronic comorbid.                       *
047400/
047500 LINKAGE SECTION.
047600 COPY BILLCPY.
047700*COPY "BILLCPY.CPY".
047800/
047900 COPY WAGECPY.
048000*COPY "WAGECPY.CPY".
048100/
048200 PROCEDURE DIVISION  USING BILL-NEW-DATA
048300                           PPS-DATA-ALL
048400                           WAGE-NEW-RATE-RECORD
048500                           COM-CBSA-WAGE-RECORD
048600                           BUN-CBSA-WAGE-RECORD.
048700
048800******************************************************************
048900* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
049000* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
049100* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
049200* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
049300* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
049400* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
049500* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
049600* PROCESSING (DICP).                                             *
049700*                                                                *
049800*                                                                *
049900*    PROCESSING:                                                 *
050000*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
050100*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
050200*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
050300*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
050400*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
050500*           GOBACK.                                              *
050600*        D. ASSEMBLE PRICING COMPONENTS.                         *
050700*        E. CALCULATE THE PRICE.                                 *
050800******************************************************************
050900
051000 0000-START-TO-FINISH.
051100     INITIALIZE PPS-DATA-ALL.
051200
051300     IF BUNDLED-TEST  THEN
051400        INITIALIZE BILL-DATA-TEST
051500        INITIALIZE COND-CD-73
051600     END-IF.
051700     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
051800     MOVE ZEROS                        TO PPS-RTC.
051900
052000     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
052100
052200     IF PPS-RTC = 00  THEN
052300        PERFORM 1200-INITIALIZATION
052400**Calculate patient age
052500        COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
052600        IF B-DOB-MM > B-THRU-MM  THEN
052700           COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
052800        END-IF
052900        IF H-PATIENT-AGE < 18  THEN
053000           MOVE "Y"                    TO PEDIATRIC-TRACK
053100        END-IF
053200        PERFORM 2000-CALCULATE-BUNDLED-FACTORS
053300        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
053400           PERFORM 5000-CALC-COMP-RATE-FACTORS
053500        END-IF
053600        PERFORM 9000-SET-RETURN-CODE
053700        PERFORM 9100-MOVE-RESULTS
053800     END-IF.
053900
054000     GOBACK.
054100/
054200 1000-VALIDATE-BILL-ELEMENTS.
054300     IF P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
054400        NEXT SENTENCE
054500     ELSE
054600        MOVE 52                        TO PPS-RTC
054700     END-IF.
054800
054900     IF PPS-RTC = 00  THEN
055000        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
055100           MOVE 53                     TO PPS-RTC
055200        END-IF
055300     END-IF.
055400
055500     IF PPS-RTC = 00  THEN
055600        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
055700           MOVE 54                     TO PPS-RTC
055800        END-IF
055900     END-IF.
056000
056100     IF PPS-RTC = 00  THEN
056200        IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
056300           MOVE 55                     TO PPS-RTC
056400        END-IF
056500     END-IF.
056600
056700     IF PPS-RTC = 00  THEN
056800        IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
056900           MOVE 56                     TO PPS-RTC
057000        END-IF
057100     END-IF.
057200
057300     IF PPS-RTC = 00  THEN
057400        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
057500                                OR '0881'
057600           NEXT SENTENCE
057700        ELSE
057800           MOVE 57                     TO PPS-RTC
057900        END-IF
058000     END-IF.
058100
058200     IF PPS-RTC = 00  THEN
058300        IF B-COND-CODE NOT = '73' AND '74' AND '  '
058400           MOVE 58                     TO PPS-RTC
058500        END-IF
058600     END-IF.
058700
058800     IF PPS-RTC = 00  THEN
058900        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
059000                                 ' '  THEN
059100           MOVE 53                     TO PPS-RTC
059200*  This RTC is for the Special Payment Indicator not = '1' or
059300*  blank, which closely approximates the intent of the edit check.
059400*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
059500        END-IF
059600     END-IF.
059700
059800     IF PPS-RTC = 00  THEN
059900        IF B-PATIENT-HGT > 300.00
060000           MOVE 71                     TO PPS-RTC
060100        END-IF
060200     END-IF.
060300
060400     IF PPS-RTC = 00  THEN
060500        IF B-PATIENT-WGT > 500.00  THEN
060600           MOVE 72                     TO PPS-RTC
060700        END-IF
060800     END-IF.
060900
061000* Before 2012 pricer, put in edit check to make sure that the
061100* # of sesions does not exceed the # of days in a month.  Maybe
061200* the # of cays in a month minus one when patient goes into a
061300* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
061400* or 0851)).  If done, then will need extra RTC.
061500     IF PPS-RTC = 00  THEN
061600        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
061700           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
061800           MOVE 73                     TO PPS-RTC
061900        END-IF
062000     END-IF.
062100
062200     IF PPS-RTC = 00  THEN
062300        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
062400           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
062500           MOVE 74                     TO PPS-RTC
062600        END-IF
062700     END-IF.
062800
062900     IF PPS-RTC = 00  THEN
063000        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
063100           MOVE 75                     TO PPS-RTC
063200        END-IF
063300     END-IF.
063400
063500     IF PPS-RTC = 00  THEN
063600        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
063700           MOVE 76                     TO PPS-RTC
063800        END-IF
063900     END-IF.
064000
064100     IF PPS-RTC = 00  THEN
064200        IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
064300            VALID-COMORBID-CWF-RETURN-CD       THEN
064400           NEXT SENTENCE
064500        ELSE
064600           MOVE 81                     TO PPS-RTC
064700        END-IF
064800     END-IF.
064900/
065000 1200-INITIALIZATION.
065100     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
065200     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
065300     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
065400     INITIALIZE PAID-RETURN-CODE-TRACKERS.
065500
065600     MOVE SPACES                       TO MOVED-CORMORBIDS.
065700
065800     IF P-QIP-REDUCTION = ' '  THEN
065900* no reduction
066000        MOVE 1.000 TO QIP-REDUCTION
066100     ELSE
066200        IF P-QIP-REDUCTION = '1'  THEN
066300* one-half percent reduction
066400           MOVE 0.995 TO QIP-REDUCTION
066500        ELSE
066600           IF P-QIP-REDUCTION = '2'  THEN
066700* one percent reduction
066800              MOVE 0.990 TO QIP-REDUCTION
066900           ELSE
067000              IF P-QIP-REDUCTION = '3'  THEN
067100* one and one-half percent reduction
067200                 MOVE 0.985 TO QIP-REDUCTION
067300              ELSE
067400* two percent reduction
067500                 MOVE 0.980 TO QIP-REDUCTION
067600              END-IF
067700           END-IF
067800        END-IF
067900     END-IF.
068000
068100*    Since pricer has to pay a comorbid condition according to the
068200* return code that CWF passes back, it is cleaner if the pricer
068300* sets aside whatever comorbid data exists on the line-item when
068400* it comes into the pricer and then transferrs the CWF code to
068500* the appropriate place in the comorbid data.  This avoids
068600* making convoluted changes in the other parts of the program
068700* which has to look at both original comorbid data AND CWF return
068800* codes to handle comorbids.  Near the end of the program where
068900* variables are transferred to the output, the original comorbid
069000* data is put back into its original place as though nothing
069100* occurred.
069200     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
069300        NEXT SENTENCE
069400     ELSE
069500        MOVE 'Y'                       TO MOVED-CORMORBIDS
069600        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
069700        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
069800        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
069900        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
070000        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
070100        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
070200        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
070300        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
070400           MOVE SPACES                 TO COMORBID-DATA (1)
070500                                          COMORBID-DATA (2)
070600                                          COMORBID-DATA (3)
070700                                          COMORBID-DATA (4)
070800                                          COMORBID-DATA (5)
070900                                          COMORBID-DATA (6)
071000                                          COMORBID-CWF-RETURN-CODE
071100        ELSE
071200           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
071300              MOVE 'MA'                TO COMORBID-DATA (1)
071400              MOVE SPACES              TO COMORBID-DATA (2)
071500                                          COMORBID-DATA (3)
071600                                          COMORBID-DATA (4)
071700                                          COMORBID-DATA (5)
071800                                          COMORBID-DATA (6)
071900                                          COMORBID-CWF-RETURN-CODE
072000           ELSE
072100              IF COMORBID-CWF-RETURN-CODE = '30'  THEN
072200                 MOVE SPACES           TO COMORBID-DATA (1)
072300                 MOVE 'MB'             TO COMORBID-DATA (2)
072400                 MOVE SPACES           TO COMORBID-DATA (3)
072500                 MOVE SPACES           TO COMORBID-DATA (4)
072600                 MOVE SPACES           TO COMORBID-DATA (5)
072700                 MOVE SPACES           TO COMORBID-DATA (6)
072800                                          COMORBID-CWF-RETURN-CODE
072900              ELSE
073000                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
073100                    MOVE SPACES        TO COMORBID-DATA (1)
073200                    MOVE SPACES        TO COMORBID-DATA (2)
073300                    MOVE 'MC'          TO COMORBID-DATA (3)
073400                    MOVE SPACES        TO COMORBID-DATA (4)
073500                    MOVE SPACES        TO COMORBID-DATA (5)
073600                    MOVE SPACES        TO COMORBID-DATA (6)
073700                                          COMORBID-CWF-RETURN-CODE
073800                 ELSE
073900                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
074000                       MOVE SPACES     TO COMORBID-DATA (1)
074100                       MOVE SPACES     TO COMORBID-DATA (2)
074200                       MOVE SPACES     TO COMORBID-DATA (3)
074300                       MOVE 'MD'       TO COMORBID-DATA (4)
074400                       MOVE SPACES     TO COMORBID-DATA (5)
074500                       MOVE SPACES     TO COMORBID-DATA (6)
074600                                          COMORBID-CWF-RETURN-CODE
074700                    ELSE
074800                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
074900                          MOVE SPACES  TO COMORBID-DATA (1)
075000                          MOVE SPACES  TO COMORBID-DATA (2)
075100                          MOVE SPACES  TO COMORBID-DATA (3)
075200                          MOVE SPACES  TO COMORBID-DATA (4)
075300                          MOVE 'ME'    TO COMORBID-DATA (5)
075400                          MOVE SPACES  TO COMORBID-DATA (6)
075500                                          COMORBID-CWF-RETURN-CODE
075600                       ELSE
075700                          MOVE SPACES  TO COMORBID-DATA (1)
075800                                          COMORBID-DATA (2)
075900                                          COMORBID-DATA (3)
076000                                          COMORBID-DATA (4)
076100                                          COMORBID-DATA (5)
076200                                          COMORBID-CWF-RETURN-CODE
076300                          MOVE 'MF'    TO COMORBID-DATA (6)
076400                       END-IF
076500                    END-IF
076600                 END-IF
076700              END-IF
076800           END-IF
076900        END-IF
077000     END-IF.
077100
077200******************************************************************
077300***Calculate BUNDLED Wage Adjusted Rate (note different method)***
077400******************************************************************
077500     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
077600        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
077700         BUN-CBSA-W-INDEX.
077800
077900     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
078000        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
078100
078200     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
078300        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
078400/
078500 2000-CALCULATE-BUNDLED-FACTORS.
078600******************************************************************
078700***  Set BUNDLED age adjustment factor                         ***
078800******************************************************************
078900     IF H-PATIENT-AGE < 13  THEN
079000        IF B-REV-CODE = '0821' OR '0881' THEN
079100           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
079200        ELSE
079300           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
079400        END-IF
079500     ELSE
079600        IF H-PATIENT-AGE < 18 THEN
079700           IF B-REV-CODE = '0821' OR '0881' THEN
079800              MOVE EB-AGE-13-17-HEMO-MODE
079900                                       TO H-BUN-AGE-FACTOR
080000           ELSE
080100              MOVE EB-AGE-13-17-PD-MODE
080200                                       TO H-BUN-AGE-FACTOR
080300           END-IF
080400        ELSE
080500           IF H-PATIENT-AGE < 45  THEN
080600              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
080700           ELSE
080800              IF H-PATIENT-AGE < 60  THEN
080900                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
081000              ELSE
081100                 IF H-PATIENT-AGE < 70  THEN
081200                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
081300                 ELSE
081400                    IF H-PATIENT-AGE < 80  THEN
081500                       MOVE CM-AGE-70-79
081600                                       TO H-BUN-AGE-FACTOR
081700                    ELSE
081800                       MOVE CM-AGE-80-PLUS
081900                                       TO H-BUN-AGE-FACTOR
082000                    END-IF
082100                 END-IF
082200              END-IF
082300           END-IF
082400        END-IF
082500     END-IF.
082600
082700******************************************************************
082800***  Calculate BUNDLED BSA factor (note NEW formula)           ***
082900******************************************************************
083000     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
083100         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
083200
083300     IF H-PATIENT-AGE > 17  THEN
083400        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
083500             CM-BSA ** ((H-BUN-BSA - 1.87) / .1)
083600     ELSE
083700        MOVE 1.000                     TO H-BUN-BSA-FACTOR
083800     END-IF.
083900
084000******************************************************************
084100***  Calculate BUNDLED BMI factor                              ***
084200******************************************************************
084300     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
084400         (B-PATIENT-HGT ** 2)) * 10000.
084500
084600     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
084700        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
084800        MOVE "Y"                       TO LOW-BMI-TRACK
084900     ELSE
085000        MOVE 1.000                     TO H-BUN-BMI-FACTOR
085100     END-IF.
085200
085300******************************************************************
085400***  Calculate BUNDLED ONSET factor                            ***
085500******************************************************************
085600     IF B-DIALYSIS-START-DATE > ZERO  THEN
085700        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
085800        COMPUTE INTEGER-LINE-ITEM-DATE =
085900            FUNCTION INTEGER-OF-DATE(THE-DATE)
086000        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
086100        COMPUTE INTEGER-DIALYSIS-DATE  =
086200            FUNCTION INTEGER-OF-DATE(THE-DATE)
086300* Need to add one to onset-date because the start date should
086400* be included in the count of days.  fix made 9/6/2011
086500        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
086600                              INTEGER-DIALYSIS-DATE) + 1
086700        IF H-PATIENT-AGE > 17  THEN
086800           IF ONSET-DATE > 120  THEN
086900              MOVE 1                   TO H-BUN-ONSET-FACTOR
087000           ELSE
087100              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
087200              MOVE "Y"                 TO ONSET-TRACK
087300           END-IF
087400        ELSE
087500           MOVE 1                      TO H-BUN-ONSET-FACTOR
087600        END-IF
087700     ELSE
087800        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
087900     END-IF.
088000
088100******************************************************************
088200***  Set BUNDLED Co-morbidities adjustment                     ***
088300******************************************************************
088400     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
088500        IF H-PATIENT-AGE  <  18  THEN
088600           MOVE 1.000                  TO
088700                                       H-BUN-COMORBID-MULTIPLIER
088800           MOVE '10'                   TO PPS-2011-COMORBID-PAY
088900        ELSE
089000           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
089100              MOVE 1.000               TO
089200                                       H-BUN-COMORBID-MULTIPLIER
089300              MOVE '10'                TO PPS-2011-COMORBID-PAY
089400           ELSE
089500              PERFORM 2100-CALC-COMORBID-ADJUST
089600              MOVE H-COMORBID-MULTIPLIER TO
089700                                       H-BUN-COMORBID-MULTIPLIER
089800           END-IF
089900        END-IF
090000     ELSE
090100        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
090200           MOVE 1.000                  TO
090300                                       H-BUN-COMORBID-MULTIPLIER
090400           MOVE '10'                   TO PPS-2011-COMORBID-PAY
090500        ELSE
090600           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
090700              MOVE CM-GI-BLEED         TO
090800                                       H-BUN-COMORBID-MULTIPLIER
090900              MOVE '20'                TO PPS-2011-COMORBID-PAY
091000           ELSE
091100              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
091200                 MOVE CM-PNEUMONIA     TO
091300                                       H-BUN-COMORBID-MULTIPLIER
091400                 MOVE '30'             TO PPS-2011-COMORBID-PAY
091500              ELSE
091600                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
091700                    MOVE CM-PERICARDITIS TO
091800                                       H-BUN-COMORBID-MULTIPLIER
091900                    MOVE '40'          TO PPS-2011-COMORBID-PAY
092000                 END-IF
092100              END-IF
092200           END-IF
092300        END-IF
092400     END-IF.
092500
092600******************************************************************
092700***  Calculate BUNDLED Low Volume adjustment                   ***
092800******************************************************************
092900     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
093000        IF H-PATIENT-AGE > 17  THEN
093100           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
093200                                       H-BUN-LOW-VOL-MULTIPLIER
093300           MOVE "Y"                    TO  LOW-VOLUME-TRACK
093400        ELSE
093500           MOVE 1.000                  TO
093600                                       H-BUN-LOW-VOL-MULTIPLIER
093700        END-IF
093800     ELSE
093900        MOVE 1.000                     TO
094000                                       H-BUN-LOW-VOL-MULTIPLIER
094100     END-IF.
094200
094300******************************************************************
094400***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
094500******************************************************************
094600     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
094700        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
094800        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
094900        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
095000        (H-BUN-LOW-VOL-MULTIPLIER).
095100
095200******************************************************************
095300***  Calculate BUNDLED Condition Code payment                  ***
095400******************************************************************
095500* Self-care in Training add-on
095600     IF B-COND-CODE = '73'  THEN
095700* no add-on when onset is present
095800        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
095900           MOVE ZERO                   TO
096000                                    H-BUN-WAGE-ADJ-TRAINING-AMT
096100        ELSE
096200* use new PPS training add-on amount times wage-index
096300           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
096400             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
096500           MOVE "Y"                    TO TRAINING-TRACK
096600        END-IF
096700     ELSE
096800* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
096900        IF (B-COND-CODE = '74')  AND
097000           (B-REV-CODE = '0841' OR '0851')  THEN
097100              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
097200                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
097300        ELSE
097400           MOVE ZERO                   TO
097500                                    H-BUN-WAGE-ADJ-TRAINING-AMT
097600                                    H-CC-74-PER-DIEM-AMT
097700        END-IF
097800     END-IF.
097900
098000******************************************************************
098100***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
098200******************************************************************
098300     IF (B-COND-CODE = '74')  AND
098400        (B-REV-CODE = '0841' OR '0851')  THEN
098500           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
098600                           H-CC-74-PER-DIEM-AMT
098700           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
098800              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
098900              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
099000     ELSE
099100        COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
099200                H-BUN-ADJUSTED-BASE-WAGE-AMT  +
099300                H-BUN-WAGE-ADJ-TRAINING-AMT
099400     END-IF.
099500
099600******************************************************************
099700***  Calculate BUNDLED Outlier                                 ***
099800******************************************************************
099900     PERFORM 2500-CALC-OUTLIER-FACTORS.
100000
100100******************************************************************
100200***  Calculate Low Volume payment for recovery purposes        ***
100300******************************************************************
100400     IF LOW-VOLUME-TRACK = "Y"  THEN
100500        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
100600        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
100700
100800        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
100900           H-PPS-FINAL-PAY-AMT
101000
101100        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
101200           H-OUT-PAYMENT
101300
101400        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
101500           H-LV-OUT-PAYMENT
101600
101700        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
101800           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
101900              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
102000        ELSE
102100           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
102200        END-IF
102300     END-IF.
102400
102500
102600/
102700 2100-CALC-COMORBID-ADJUST.
102800******************************************************************
102900***  Calculate Co-morbidities adjustment                       ***
103000******************************************************************
103100*  This logic assumes that the comorbids are randomly assigned   *
103200*to the comorbid table.  It will select the highest comorbid for *
103300*payment if one is found.                                        *
103400******************************************************************
103500     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
103600     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
103700     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
103800
103900     PERFORM VARYING  SUB  FROM  1 BY 1
104000       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
104100         IF COMORBID-DATA (SUB) = 'MA'  THEN
104200           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
104300           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
104400           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
104500           MOVE '20'                   TO PPS-2011-COMORBID-PAY
104600         ELSE
104700           IF COMORBID-DATA (SUB) = 'MB'  THEN
104800             IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
104900               MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
105000               MOVE "Y"                TO ACUTE-COMORBID-TRACK
105100               MOVE '30'               TO PPS-2011-COMORBID-PAY
105200             END-IF
105300           ELSE
105400             IF COMORBID-DATA (SUB) = 'MC'  THEN
105500                IF CM-PERICARDITIS  >
105600                                      H-COMORBID-MULTIPLIER  THEN
105700                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
105800                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
105900                  MOVE '40'            TO PPS-2011-COMORBID-PAY
106000                END-IF
106100             ELSE
106200               IF COMORBID-DATA (SUB) = 'MD'  THEN
106300                 IF CM-MYELODYSPLASTIC  >
106400                                      H-COMORBID-MULTIPLIER  THEN
106500                   MOVE CM-MYELODYSPLASTIC  TO
106600                                      H-COMORBID-MULTIPLIER
106700                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
106800                   MOVE '50'           TO PPS-2011-COMORBID-PAY
106900                 END-IF
107000               ELSE
107100                 IF COMORBID-DATA (SUB) = 'ME'  THEN
107200                   IF CM-SICKEL-CELL  >
107300                                      H-COMORBID-MULTIPLIER  THEN
107400                     MOVE CM-SICKEL-CELL  TO
107500                                      H-COMORBID-MULTIPLIER
107600                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
107700                     MOVE '60'         TO PPS-2011-COMORBID-PAY
107800                   END-IF
107900                 ELSE
108000                   IF COMORBID-DATA (SUB) = 'MF'  THEN
108100                     IF CM-MONOCLONAL-GAMM  >
108200                                      H-COMORBID-MULTIPLIER  THEN
108300                       MOVE CM-MONOCLONAL-GAMM TO
108400                                      H-COMORBID-MULTIPLIER
108500                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
108600                       MOVE '70'       TO PPS-2011-COMORBID-PAY
108700                     END-IF
108800                   END-IF
108900                 END-IF
109000               END-IF
109100             END-IF
109200           END-IF
109300         END-IF
109400     END-PERFORM.
109500/
109600 2500-CALC-OUTLIER-FACTORS.
109700******************************************************************
109800***  Set separately billable OUTLIER age adjustment factor     ***
109900******************************************************************
110000     IF H-PATIENT-AGE < 13  THEN
110100        IF B-REV-CODE = '0821' OR '0881' THEN
110200           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
110300        ELSE
110400           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
110500        END-IF
110600     ELSE
110700        IF H-PATIENT-AGE < 18 THEN
110800           IF B-REV-CODE = '0821' OR '0881'  THEN
110900              MOVE SB-AGE-13-17-HEMO-MODE
111000                                       TO H-OUT-AGE-FACTOR
111100           ELSE
111200              MOVE SB-AGE-13-17-PD-MODE
111300                                       TO H-OUT-AGE-FACTOR
111400           END-IF
111500        ELSE
111600           IF H-PATIENT-AGE < 45  THEN
111700              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
111800           ELSE
111900              IF H-PATIENT-AGE < 60  THEN
112000                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
112100              ELSE
112200                 IF H-PATIENT-AGE < 70  THEN
112300                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
112400                 ELSE
112500                    IF H-PATIENT-AGE < 80  THEN
112600                       MOVE SB-AGE-70-79
112700                                       TO H-OUT-AGE-FACTOR
112800                    ELSE
112900                       MOVE SB-AGE-80-PLUS
113000                                       TO H-OUT-AGE-FACTOR
113100                    END-IF
113200                 END-IF
113300              END-IF
113400           END-IF
113500        END-IF
113600     END-IF.
113700
113800******************************************************************
113900**Calculate separately billable OUTLIER BSA factor (superscript)**
114000******************************************************************
114100     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
114200         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
114300
114400     IF H-PATIENT-AGE > 17  THEN
114500        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
114600             SB-BSA ** ((H-OUT-BSA - 1.87) / .1)
114700     ELSE
114800        MOVE 1.000                     TO H-OUT-BSA-FACTOR
114900     END-IF.
115000
115100******************************************************************
115200***  Calculate separately billable OUTLIER BMI factor          ***
115300******************************************************************
115400     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
115500         (B-PATIENT-HGT ** 2)) * 10000.
115600
115700     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
115800        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
115900     ELSE
116000        MOVE 1.000                     TO H-OUT-BMI-FACTOR
116100     END-IF.
116200
116300******************************************************************
116400***  Calculate separately billable OUTLIER ONSET factor        ***
116500******************************************************************
116600     IF B-DIALYSIS-START-DATE > ZERO  THEN
116700        IF H-PATIENT-AGE > 17  THEN
116800           IF ONSET-DATE > 120  THEN
116900              MOVE 1                   TO H-OUT-ONSET-FACTOR
117000           ELSE
117100              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
117200           END-IF
117300        ELSE
117400           MOVE 1                      TO H-OUT-ONSET-FACTOR
117500        END-IF
117600     ELSE
117700        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
117800     END-IF.
117900
118000******************************************************************
118100***  Set separately billable OUTLIER Co-morbidities adjustment ***
118200******************************************************************
118300     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
118400        IF H-PATIENT-AGE  <  18  THEN
118500           MOVE 1.000                  TO
118600                                       H-OUT-COMORBID-MULTIPLIER
118700           MOVE '10'                   TO PPS-2011-COMORBID-PAY
118800        ELSE
118900           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
119000              MOVE 1.000               TO
119100                                       H-OUT-COMORBID-MULTIPLIER
119200              MOVE '10'                TO PPS-2011-COMORBID-PAY
119300           ELSE
119400              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
119500           END-IF
119600        END-IF
119700     ELSE
119800        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
119900           MOVE 1.000                  TO
120000                                       H-OUT-COMORBID-MULTIPLIER
120100        ELSE
120200           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
120300              MOVE SB-GI-BLEED         TO
120400                                       H-OUT-COMORBID-MULTIPLIER
120500           ELSE
120600              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
120700                 MOVE SB-PNEUMONIA     TO
120800                                       H-OUT-COMORBID-MULTIPLIER
120900              ELSE
121000                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
121100                    MOVE SB-PERICARDITIS TO
121200                                       H-OUT-COMORBID-MULTIPLIER
121300                 END-IF
121400              END-IF
121500           END-IF
121600        END-IF
121700     END-IF.
121800
121900******************************************************************
122000***  Set OUTLIER low-volume-multiplier                         ***
122100******************************************************************
122200     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
122300        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
122400     ELSE
122500        IF H-PATIENT-AGE < 18  THEN
122600           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
122700        ELSE
122800           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
122900           MOVE "Y"                    TO LOW-VOLUME-TRACK
123000        END-IF
123100     END-IF.
123200
123300******************************************************************
123400***  Calculate predicted OUTLIER services MAP per treatment    ***
123500******************************************************************
123600     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
123700        (H-OUT-AGE-FACTOR             *
123800         H-OUT-BSA-FACTOR             *
123900         H-OUT-BMI-FACTOR             *
124000         H-OUT-ONSET-FACTOR           *
124100         H-OUT-COMORBID-MULTIPLIER    *
124200         H-OUT-LOW-VOL-MULTIPLIER).
124300
124400******************************************************************
124500***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
124600******************************************************************
124700     IF H-PATIENT-AGE < 18  THEN
124800        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
124900           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
125000        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
125100     ELSE
125200
125300        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
125400           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
125500        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
125600     END-IF.
125700
125800******************************************************************
125900*** Calculate imputed OUTLIER services MAP amount per treatment***
126000******************************************************************
126100     IF (B-COND-CODE = '74')  AND
126200        (B-REV-CODE = '0841' OR '0851')  THEN
126300         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
126400            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
126500         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
126600         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
126700     ELSE
126800        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
126900        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
127000     END-IF.
127100
127200******************************************************************
127300*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
127400******************************************************************
127500     IF H-PATIENT-AGE < 18   THEN
127600        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
127700           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
127800        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
127900        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
128000           COMPUTE H-OUT-PAYMENT  ROUNDED  =
128100            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
128200                                         LOSS-SHARING-PCT-LT-18
128300           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
128400           MOVE "Y"                    TO OUTLIER-TRACK
128500        ELSE
128600           MOVE ZERO                   TO H-OUT-PAYMENT
128700           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
128800        END-IF
128900     ELSE
129000        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
129100           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
129200           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
129300        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
129400           COMPUTE H-OUT-PAYMENT  ROUNDED  =
129500            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
129600                                         LOSS-SHARING-PCT-GT-17
129700           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
129800           MOVE "Y"                    TO OUTLIER-TRACK
129900        ELSE
130000           MOVE ZERO                   TO H-OUT-PAYMENT
130100        END-IF
130200     END-IF.
130300
130400     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
130500
130600* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
130700     IF (B-COND-CODE = '74')  AND
130800        (B-REV-CODE = '0841' OR '0851')  THEN
130900           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
131000             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
131100     END-IF.
131200/
131300 2600-CALC-COMORBID-OUT-ADJUST.
131400******************************************************************
131500***  Calculate OUTLIER Co-morbidities adjustment               ***
131600******************************************************************
131700*  This logic assumes that the comorbids are randomly assigned   *
131800*to the comorbid table.  It will select the highest comorbid for *
131900*payment if one is found.                                        *
132000******************************************************************
132100
132200     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
132300     MOVE 1.000                        TO
132400                                  H-OUT-COMORBID-MULTIPLIER.
132500
132600     PERFORM VARYING  SUB  FROM  1 BY 1
132700       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
132800         IF COMORBID-DATA (SUB) = 'MA'  THEN
132900           MOVE SB-GI-BLEED            TO
133000                                  H-OUT-COMORBID-MULTIPLIER
133100           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
133200           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
133300         ELSE
133400           IF COMORBID-DATA (SUB) = 'MB'  THEN
133500             IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
133600               MOVE SB-PNEUMONIA       TO
133700                                  H-OUT-COMORBID-MULTIPLIER
133800               MOVE "Y"                TO ACUTE-COMORBID-TRACK
133900             END-IF
134000           ELSE
134100             IF COMORBID-DATA (SUB) = 'MC'  THEN
134200                IF SB-PERICARDITIS  >
134300                                  H-OUT-COMORBID-MULTIPLIER  THEN
134400                  MOVE SB-PERICARDITIS TO
134500                                  H-OUT-COMORBID-MULTIPLIER
134600                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
134700                END-IF
134800             ELSE
134900               IF COMORBID-DATA (SUB) = 'MD'  THEN
135000                 IF SB-MYELODYSPLASTIC  >
135100                                  H-OUT-COMORBID-MULTIPLIER  THEN
135200                   MOVE SB-MYELODYSPLASTIC  TO
135300                                  H-OUT-COMORBID-MULTIPLIER
135400                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
135500                 END-IF
135600               ELSE
135700                 IF COMORBID-DATA (SUB) = 'ME'  THEN
135800                   IF SB-SICKEL-CELL  >
135900                                  H-OUT-COMORBID-MULTIPLIER  THEN
136000                     MOVE SB-SICKEL-CELL  TO
136100                                  H-OUT-COMORBID-MULTIPLIER
136200                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
136300                   END-IF
136400                 ELSE
136500                   IF COMORBID-DATA (SUB) = 'MF'  THEN
136600                     IF SB-MONOCLONAL-GAMM  >
136700                                  H-OUT-COMORBID-MULTIPLIER  THEN
136800                       MOVE SB-MONOCLONAL-GAMM  TO
136900                                  H-OUT-COMORBID-MULTIPLIER
137000                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
137100                     END-IF
137200                   END-IF
137300                 END-IF
137400               END-IF
137500             END-IF
137600           END-IF
137700         END-IF
137800     END-PERFORM.
137900/
138000******************************************************************
138100*** Calculate Low Volume Full PPS payment for recovery purposes***
138200******************************************************************
138300 3000-LOW-VOL-FULL-PPS-PAYMENT.
138400******************************************************************
138500** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
138600     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
138700        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
138800        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
138900        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER).
139000
139100******************************************************************
139200**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
139300* Self-care in Training add-on
139400     IF B-COND-CODE = '73'  THEN
139500* no add-on when onset is present
139600        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
139700           MOVE ZERO                   TO
139800                                    H-BUN-WAGE-ADJ-TRAINING-AMT
139900        ELSE
140000* use new PPS training add-on amount times wage-index
140100           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
140200             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
140300           MOVE "Y"                    TO TRAINING-TRACK
140400        END-IF
140500     ELSE
140600* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
140700        IF (B-COND-CODE = '74')  AND
140800           (B-REV-CODE = '0841' OR '0851')  THEN
140900              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
141000                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
141100        ELSE
141200           MOVE ZERO                   TO
141300                                    H-BUN-WAGE-ADJ-TRAINING-AMT
141400                                    H-CC-74-PER-DIEM-AMT
141500        END-IF
141600     END-IF.
141700
141800******************************************************************
141900**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
142000     IF (B-COND-CODE = '74')  AND
142100        (B-REV-CODE = '0841' OR '0851')  THEN
142200           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
142300                           H-CC-74-PER-DIEM-AMT
142400     ELSE
142500        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
142600                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
142700                H-BUN-WAGE-ADJ-TRAINING-AMT
142800     END-IF.
142900
143000/
143100******************************************************************
143200*** Calculate Low Volume OUT PPS payment for recovery purposes ***
143300******************************************************************
143400 3100-LOW-VOL-OUT-PPS-PAYMENT.
143500******************************************************************
143600**Modified code from 'Calc predict OUT serv MAP per treat' para.**
143700     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
143800        (H-OUT-AGE-FACTOR             *
143900         H-OUT-BSA-FACTOR             *
144000         H-OUT-BMI-FACTOR             *
144100         H-OUT-ONSET-FACTOR           *
144200         H-OUT-COMORBID-MULTIPLIER).
144300
144400******************************************************************
144500**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
144600     IF H-PATIENT-AGE < 18  THEN
144700        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
144800           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
144900        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
145000     ELSE
145100        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
145200           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
145300        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
145400     END-IF.
145500
145600******************************************************************
145700** 'Calculate imput OUT services MAP amount per treatment' para **
145800** It is not necessary to modify or insert this paragraph here. **
145900
146000******************************************************************
146100**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
146200     IF H-PATIENT-AGE < 18   THEN
146300        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
146400           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
146500        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
146600        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
146700           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
146800            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
146900                                         LOSS-SHARING-PCT-LT-18
147000           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
147100        ELSE
147200           MOVE ZERO                   TO H-LV-OUT-PAYMENT
147300           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
147400        END-IF
147500     ELSE
147600        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
147700           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
147800           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
147900        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
148000           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
148100            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
148200                                         LOSS-SHARING-PCT-GT-17
148300           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
148400        ELSE
148500           MOVE ZERO                   TO H-LV-OUT-PAYMENT
148600        END-IF
148700     END-IF.
148800
148900     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
149000
149100* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
149200     IF (B-COND-CODE = '74')  AND
149300        (B-REV-CODE = '0841' OR '0851')  THEN
149400           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
149500             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
149600     END-IF.
149700/
149800 5000-CALC-COMP-RATE-FACTORS.
149900******************************************************************
150000***  Set Composite Rate age adjustment factor                  ***
150100******************************************************************
150200     IF H-PATIENT-AGE < 18  THEN
150300        MOVE CR-AGE-LT-18              TO H-AGE-FACTOR
150400     ELSE
150500        IF H-PATIENT-AGE < 45  THEN
150600           MOVE CR-AGE-18-44           TO H-AGE-FACTOR
150700        ELSE
150800           IF H-PATIENT-AGE < 60  THEN
150900              MOVE CR-AGE-45-59        TO H-AGE-FACTOR
151000           ELSE
151100              IF H-PATIENT-AGE < 70  THEN
151200                 MOVE CR-AGE-60-69     TO H-AGE-FACTOR
151300              ELSE
151400                 IF H-PATIENT-AGE < 80  THEN
151500                    MOVE CR-AGE-70-79  TO H-AGE-FACTOR
151600                 ELSE
151700                    MOVE CR-AGE-80-PLUS
151800                                       TO H-AGE-FACTOR
151900                 END-IF
152000              END-IF
152100           END-IF
152200        END-IF
152300     END-IF.
152400
152500******************************************************************
152600**Calculate Composite Rate BSA factor (2012 superscript now same)*
152700******************************************************************
152800     COMPUTE H-BSA  ROUNDED = (.007184 *
152900         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
153000
153100     IF H-PATIENT-AGE > 17  THEN
153200        COMPUTE H-BSA-FACTOR  ROUNDED =
153300             CR-BSA ** ((H-BSA - 1.87) / .1)
153400     ELSE
153500        MOVE 1.000                     TO H-BSA-FACTOR
153600     END-IF.
153700
153800******************************************************************
153900*** Calculate Composite Rate BMI factor (different BMI < 18.5) ***
154000******************************************************************
154100     COMPUTE H-BMI  ROUNDED = (B-PATIENT-WGT /
154200         (B-PATIENT-HGT ** 2)) * 10000.
154300
154400     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)  THEN
154500        MOVE CR-BMI-LT-18-5            TO H-BMI-FACTOR
154600     ELSE
154700        MOVE 1.000                     TO H-BMI-FACTOR
154800     END-IF.
154900
155000******************************************************************
155100***  Calculate Composite Rate Payment Amount                   ***
155200******************************************************************
155300*P-ESRD-RATE, also called the Exception Rate, will not be granted*
155400*in full beginning in 2011 (the beginning of the Bundled method) *
155500*and will be eliminated entirely beginning in 2014 which is the  *
155600*end of the blending period.  For 2011, those providers who elect*
155700*to be in the blend, will get only 75% of the exception rate.    *
155800*This apparently is for the pediatric providers who originally   *
155900*had the exception rate.                                         *
156000
156100     IF P-ESRD-RATE  =  ZERO  THEN
156200        MOVE BASE-PAYMENT-RATE         TO  H-PAYMENT-RATE
156300     ELSE
156400        MOVE P-ESRD-RATE               TO  H-PAYMENT-RATE
156500     END-IF.
156600
156700     COMPUTE H-WAGE-ADJ-PYMT-AMT ROUNDED =
156800     (((H-PAYMENT-RATE * NAT-LABOR-PCT) * COM-CBSA-W-INDEX) +
156900       (H-PAYMENT-RATE * NAT-NONLABOR-PCT)) *
157000            CBSA-BLEND-PCT.
157100
157200     COMPUTE H-PYMT-AMT ROUNDED = (H-WAGE-ADJ-PYMT-AMT *
157300        H-BMI-FACTOR * H-BSA-FACTOR * CASE-MIX-BDGT-NEUT-FACTOR *
157400        H-AGE-FACTOR * DRUG-ADDON).
157500
157600     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
157700
157800******************************************************************
157900***  Calculate condition code payment                          ***
158000******************************************************************
158100     MOVE SPACES                       TO COND-CD-73.
158200
158300* Hemo, peritoneal, or CCPD training add-on
158400     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
158500                                                      OR '0851')
158600        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
158700        MOVE 'A'                       TO AMT-INDIC
158800        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
158900     ELSE
159000* CAPD training add-on
159100        IF (B-COND-CODE = '73')  AND  (B-REV-CODE = '0841')  THEN
159200           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
159300           MOVE 'A'                    TO AMT-INDIC
159400           MOVE CAPD-AMT               TO BLOOD-DOLLAR
159500        ELSE
159600* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
159700           IF (B-COND-CODE = '74')  AND
159800              (B-REV-CODE = '0841' OR '0851')  THEN
159900              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
160000                                           CAPD-OR-CCPD-FACTOR
160100              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
160200           ELSE
160300              MOVE 'A'                 TO AMT-INDIC
160400              MOVE ZERO                TO BLOOD-DOLLAR
160500           END-IF
160600        END-IF
160700     END-IF.
160800
160900/
161000 9000-SET-RETURN-CODE.
161100******************************************************************
161200***  Set the return code                                       ***
161300******************************************************************
161400*   The following 'table' helps in understanding and in making   *
161500*changes to the rather large and complex "IF" statement that     *
161600*follows.  This 'table' just reorders and rewords the comments   *
161700*contained in the working storage area concerning the paid       *
161800*return-codes.                                                   *
161900*                                                                *
162000*  17 = pediatric, outlier, training                             *
162100*  16 = pediatric, outlier                                       *
162200*  15 = pediatric, training                                      *
162300*  14 = pediatric                                                *
162400*                                                                *
162500*  24 = outlier, low volume, training, chronic comorbid          *
162600*  19 = outlier, low volume, training, acute comorbid            *
162700*  29 = outlier, low volume, training                            *
162800*  23 = outlier, low volume, chronic comorbid                    *
162900*  18 = outlier, low volume, acute comorbid                      *
163000*  30 = outlier, low volume, onset                               *
163100*  28 = outlier, low volume                                      *
163200*  34 = outlier, training, chronic comorbid                      *
163300*  35 = outlier, training, acute comorbid                        *
163400*  33 = outlier, training                                        *
163500*  07 = outlier, chronic comorbid                                *
163600*  06 = outlier, acute comorbid                                  *
163700*  09 = outlier, onset                                           *
163800*  03 = outlier                                                  *
163900*                                                                *
164000*  26 = low volume, training, chronic comorbid                   *
164100*  21 = low volume, training, acute comorbid                     *
164200*  12 = low volume, training                                     *
164300*  25 = low volume, chronic comorbid                             *
164400*  20 = low volume, acute comorbid                               *
164500*  32 = low volume, onset                                        *
164600*  10 = low volume                                               *
164700*                                                                *
164800*  27 = training, chronic comorbid                               *
164900*  22 = training, acute comorbid                                 *
165000*  11 = training                                                 *
165100*                                                                *
165200*  08 = onset                                                    *
165300*  04 = acute comorbid                                           *
165400*  05 = chronic comorbid                                         *
165500*  31 = low BMI                                                  *
165600*  02 = no adjustments                                           *
165700*                                                                *
165800*  13 = w/multiple adjustments....reserved for future use        *
165900******************************************************************
166000/
166100     IF PEDIATRIC-TRACK                       = "Y"  THEN
166200        IF OUTLIER-TRACK                      = "Y"  THEN
166300           IF TRAINING-TRACK                  = "Y"  THEN
166400              MOVE 17                  TO PPS-RTC
166500           ELSE
166600              MOVE 16                  TO PPS-RTC
166700           END-IF
166800        ELSE
166900           IF TRAINING-TRACK                  = "Y"  THEN
167000              MOVE 15                  TO PPS-RTC
167100           ELSE
167200              MOVE 14                  TO PPS-RTC
167300           END-IF
167400        END-IF
167500     ELSE
167600        IF OUTLIER-TRACK                      = "Y"  THEN
167700           IF LOW-VOLUME-TRACK                = "Y"  THEN
167800              IF TRAINING-TRACK               = "Y"  THEN
167900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
168000                    MOVE 24            TO PPS-RTC
168100                 ELSE
168200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
168300                       MOVE 19         TO PPS-RTC
168400                    ELSE
168500                       MOVE 29         TO PPS-RTC
168600                    END-IF
168700                 END-IF
168800              ELSE
168900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
169000                    MOVE 23            TO PPS-RTC
169100                 ELSE
169200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
169300                       MOVE 18         TO PPS-RTC
169400                    ELSE
169500                       IF ONSET-TRACK         = "Y"  THEN
169600                          MOVE 30      TO PPS-RTC
169700                       ELSE
169800                          MOVE 28      TO PPS-RTC
169900                       END-IF
170000                    END-IF
170100                 END-IF
170200              END-IF
170300           ELSE
170400              IF TRAINING-TRACK               = "Y"  THEN
170500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
170600                    MOVE 34            TO PPS-RTC
170700                 ELSE
170800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
170900                       MOVE 35         TO PPS-RTC
171000                    ELSE
171100                       MOVE 33         TO PPS-RTC
171200                    END-IF
171300                 END-IF
171400              ELSE
171500                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
171600                    MOVE 07            TO PPS-RTC
171700                 ELSE
171800                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
171900                       MOVE 06         TO PPS-RTC
172000                    ELSE
172100                       IF ONSET-TRACK         = "Y"  THEN
172200                          MOVE 09      TO PPS-RTC
172300                       ELSE
172400                          MOVE 03      TO PPS-RTC
172500                       END-IF
172600                    END-IF
172700                 END-IF
172800              END-IF
172900           END-IF
173000        ELSE
173100           IF LOW-VOLUME-TRACK                = "Y"
173200              IF TRAINING-TRACK               = "Y"  THEN
173300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
173400                    MOVE 26            TO PPS-RTC
173500                 ELSE
173600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
173700                       MOVE 21         TO PPS-RTC
173800                    ELSE
173900                       MOVE 12         TO PPS-RTC
174000                    END-IF
174100                 END-IF
174200              ELSE
174300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
174400                    MOVE 25            TO PPS-RTC
174500                 ELSE
174600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
174700                       MOVE 20         TO PPS-RTC
174800                    ELSE
174900                       IF ONSET-TRACK         = "Y"  THEN
175000                          MOVE 32      TO PPS-RTC
175100                       ELSE
175200                          MOVE 10      TO PPS-RTC
175300                       END-IF
175400                    END-IF
175500                 END-IF
175600              END-IF
175700           ELSE
175800              IF TRAINING-TRACK               = "Y"  THEN
175900                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
176000                    MOVE 27            TO PPS-RTC
176100                 ELSE
176200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
176300                       MOVE 22         TO PPS-RTC
176400                    ELSE
176500                       MOVE 11         TO PPS-RTC
176600                    END-IF
176700                 END-IF
176800              ELSE
176900                 IF ONSET-TRACK               = "Y"  THEN
177000                    MOVE 08            TO PPS-RTC
177100                 ELSE
177200                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
177300                       MOVE 04         TO PPS-RTC
177400                    ELSE
177500                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
177600                          MOVE 05      TO PPS-RTC
177700                       ELSE
177800                          IF LOW-BMI-TRACK = "Y"  THEN
177900                             MOVE 31 TO PPS-RTC
178000                          ELSE
178100                             MOVE 02 TO PPS-RTC
178200                          END-IF
178300                       END-IF
178400                    END-IF
178500                 END-IF
178600              END-IF
178700           END-IF
178800        END-IF
178900     END-IF.
179000/
179100 9100-MOVE-RESULTS.
179200     IF MOVED-CORMORBIDS = SPACES  THEN
179300        NEXT SENTENCE
179400     ELSE
179500        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
179600        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
179700        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
179800        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
179900        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
180000        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
180100        MOVE H-COMORBID-CWF-CODE       TO
180200                                    COMORBID-CWF-RETURN-CODE
180300     END-IF.
180400
180500     MOVE P-GEO-MSA                    TO PPS-MSA.
180600     MOVE P-GEO-CBSA                   TO PPS-CBSA.
180700     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
180800     MOVE B-COND-CODE                  TO PPS-COND-CODE.
180900     MOVE B-REV-CODE                   TO PPS-REV-CODE.
181000     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
181100     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
181200     MOVE BUN-NAT-NONLABOR-PCT         TO
181300                                    PPS-2011-NAT-NONLABOR-PCT.
181400     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
181500     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
181600     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
181700     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
181800     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
181900     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
182000     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
182100     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
182200     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
182300     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
182400                                    PPS-2011-BDGT-NEUT-RATE.
182500     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
182600     MOVE SPACES                       TO
182700                                    PPS-2011-COMORBID-MA-CC.
182800
182900     IF (B-COND-CODE = '74')  AND
183000        (B-REV-CODE = '0841' OR '0851')  THEN
183100         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
183200                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
183300     END-IF.
183400
183500     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
183600           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
183700              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
183800           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
183900              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
184000           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
184100              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
184200     ELSE
184300        MOVE ZERO                      TO
184400                                    PPS-2011-BLEND-COMP-RATE
184500        MOVE ZERO                      TO
184600                                    PPS-2011-BLEND-PPS-RATE
184700        MOVE ZERO                      TO
184800                                    PPS-2011-BLEND-OUTLIER-RATE
184900     END-IF.
185000
185100     MOVE H-PYMT-AMT                   TO
185200                                    PPS-2011-FULL-COMP-RATE.
185300     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
185400                                          PPS-FINAL-PAY-AMT.
185500     MOVE H-OUT-PAYMENT                TO
185600                                    PPS-2011-FULL-OUTLIER-RATE.
185700
185800
185900     IF P-QIP-REDUCTION = ' ' THEN
186000        NEXT SENTENCE
186100     ELSE
186200        COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
186300                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
186400        COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
186500                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
186600        COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
186700                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
186800        COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
186900                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
187000        COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
187100                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
187200        COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
187300                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
187400     END-IF.
187500
187600     IF BUNDLED-TEST   THEN
187700        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
187800        MOVE 0.0                       TO MSA-WAGE-ADJ
187900        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
188000        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
188100        MOVE H-PATIENT-AGE             TO AGE-RETURN
188200        MOVE 0.0                       TO MSA-WAGE-AMT
188300        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
188400        MOVE H-BMI                     TO PPS-BMI
188500        MOVE H-BSA                     TO PPS-BSA
188600        MOVE MSA-BLEND-PCT             TO MSA-PCT
188700        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
188800
188900        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
189000           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
189100           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
189200        ELSE
189300           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
189400           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
189500        END-IF
189600
189700        MOVE H-BUN-BSA                 TO BUN-BSA
189800        MOVE H-BUN-BMI                 TO BUN-BMI
189900        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
190000        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
190100        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
190200        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
190300        MOVE H-OUT-BSA                 TO OUT-BSA
190400        MOVE SB-BSA                    TO OUT-SB-BSA
190500        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
190600        MOVE H-OUT-BMI                 TO OUT-BMI
190700        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
190800        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
190900        MOVE H-OUT-COMORBID-MULTIPLIER TO
191000                                    OUT-COMORBID-MULTIPLIER
191100        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
191200                                    OUT-PREDICTED-SERVICES-MAP
191300        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
191400                                    OUT-CASE-MIX-PREDICTED-MAP
191500        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
191600                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
191700        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
191800        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
191900        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
192000        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
192100        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
192200        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
192300        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
192400        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
192500        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
192600        MOVE CM-BSA                    TO PPS-CM-BSA
192700        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
192800        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
192900        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
193000        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
193100                                    BUN-ADJUSTED-BASE-WAGE-AMT
193200        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
193300                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
193400        MOVE TRAINING-ADD-ON-PMT-AMT   TO
193500                                    PPS-TRAINING-ADD-ON-PMT-AMT
193600        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
193700     END-IF.
193800******        L A S T   S O U R C E   S T A T E M E N T      *****
