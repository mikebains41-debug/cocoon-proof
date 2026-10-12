000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL122.
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
014400* ESCAL121...Note that there is NO ESCAL120 calculating
014500*            subroutine due to a reversing of CBSA 41980 composite
014600*            & PPS WAGE INDEX which was sent out with the ESDRV120
014700*            subroutine prior to the start of the calendar year.
014800*            There is NO difference between the original ESCAL120
014900*            and ESCAL121 except the notational difference in the
015000*            version number.
015100* 11/14/12- Renamed to ESCAL122. Implementation of Changes in
015200*           the ESRD Pricer for CY 2013. In addition,
015300*           code was added to implement the assignment of
015400*           the pediatric hemodialysis rate to
015500*           revenue code 0881 (ultrafiltration) when reported
015600*           on a pediatric claim (CR 7064 - Requirement #11).
015700*
015800******************************************************************
015900 DATE-COMPILED.
016000 ENVIRONMENT DIVISION.
016100 CONFIGURATION SECTION.
016200 SOURCE-COMPUTER.            IBM-Z990.
016300 OBJECT-COMPUTER.            ITTY-BITTY-MACHINE-CORPORATION.
016400 INPUT-OUTPUT  SECTION.
016500 FILE-CONTROL.
016600
016700 DATA DIVISION.
016800 FILE SECTION.
016900/
017000 WORKING-STORAGE SECTION.
017100 01  W-STORAGE-REF                  PIC X(46) VALUE
017200     'ESCAL122      - W O R K I N G   S T O R A G E'.
017300 01  CAL-VERSION                    PIC X(05) VALUE 'C12.2'.
017400
017500 01  DISPLAY-LINE-MEASUREMENT.
017600     05  FILLER                     PIC X(50) VALUE
017700         '....:...10....:...20....:...30....:...40....:...50'.
017800     05  FILLER                     PIC X(50) VALUE
017900         '....:...60....:...70....:...80....:...90....:..100'.
018000     05  FILLER                     PIC X(20) VALUE
018100         '....:..110....:..120'.
018200
018300 01  PRINT-LINE-MEASUREMENT.
018400     05  FILLER                     PIC X(51) VALUE
018500         'X....:...10....:...20....:...30....:...40....:...50'.
018600     05  FILLER                     PIC X(50) VALUE
018700         '....:...60....:...70....:...80....:...90....:..100'.
018800     05  FILLER                     PIC X(32) VALUE
018900         '....:..110....:..120....:..130..'.
019000/
019100******************************************************************
019200*  This area contains all of the old Composite Rate variables.   *
019300* They will be eliminated when the transition period ends - 2014 *
019400******************************************************************
019500 01  HOLD-COMP-RATE-PPS-COMPONENTS.
019600     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
019700     05  H-PYMT-AMT                 PIC 9(04)V9(02).
019800     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
019900     05  H-PATIENT-AGE              PIC 9(03).
020000     05  H-AGE-FACTOR               PIC 9(01)V9(03).
020100     05  H-BSA-FACTOR               PIC 9(01)V9(04).
020200     05  H-BMI-FACTOR               PIC 9(01)V9(04).
020300     05  H-BSA                      PIC 9(03)V9(04).
020400     05  H-BMI                      PIC 9(03)V9(04).
020500     05  HGT-PART                   PIC 9(04)V9(08).
020600     05  WGT-PART                   PIC 9(04)V9(08).
020700     05  COMBINED-PART              PIC 9(04)V9(08).
020800     05  CALC-BSA                   PIC 9(04)V9(08).
020900
021000
021100* The following two variables will change from year to year
021200* and are used for the COMPOSITE part of the Bundled Pricer.
021300 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1430.
021400 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 141.94.
021500
021600* The next two percentages MUST add up to 1 (i.e. 100%)
021700* They will continue to change until CY2009 when CBSA will be 1.00
021800 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
021900 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
022000
022100* CONSTANTS AREA
022200* The next two percentages MUST add up TO 1 (i.e. 100%)
022300 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
022400 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
022500
022600* The next variable is only applicapable for the 2011 Pricer.
022700 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
022800
022900 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
023000 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
023100 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
023200                                                         0.428571.
023300* The above number technically represents the fractional
023400* number 3/7 which is three days per week that a person can
023500* receive dialysis.  It will remain this value ONLY for the
023600* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
023700* use the calculation method which is more understandable and
023800* follows the method used by the Policy folks.
023900
024000*  The following number that is loaded into the payment equation
024100*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
024200*  and   --DOES NOT CHANGE--
024300
024400 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
024500
024600 01  COMPOSITE-RATE-MULTIPLIERS.
024700*Composite rate payment multiplier (used for blended providers)
024800     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
024900     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
025000     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
025100     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
025200     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
025300     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
025400
025500     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
025600     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
025700/
025800******************************************************************
025900*    This area contains all of the NEW Bundled Rate variables.   *
026000******************************************************************
026100 01  HOLD-BUNDLED-PPS-COMPONENTS.
026200     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
026300     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
026400     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
026500     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
026600     05  H-BUN-BSA                  PIC 9(03)V9(04).
026700     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
026800     05  H-BUN-BMI                  PIC 9(03)V9(04).
026900     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
027000     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
027100     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
027200     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
027300                                    PIC 9(07)V9(04).
027400     05  H-BUN-WAGE-ADJ-TRAINING-AMT
027500                                    PIC 9(07)V9(04).
027600     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
027700     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
027800     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
027900     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
028000     05  H-LV-BUN-ADJUST-BASE-WAGE-AMT
028100                                    PIC 9(07)V9(04).
028200     05  H-LV-PPS-FINAL-PAY-AMT     PIC 9(07)V9(04).
028300     05  H-LV-OUT-PREDICT-SERVICES-MAP
028400                                    PIC 9(07)V9(04).
028500     05  H-LV-OUT-CM-ADJ-PREDICT-M-TRT
028600                                    PIC 9(07)V9(04).
028700     05  H-LV-OUT-PREDICTED-MAP
028800                                    PIC 9(07)V9(04).
028900     05  H-LV-OUT-PAYMENT           PIC 9(07)V9(04).
029000
029100     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
029200     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
029300         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
029400
029500     05  H-COMORBID-DATA  OCCURS 6 TIMES
029600            INDEXED BY H-COMORBID-INDEX
029700                                    PIC X(02).
029800     05  H-COMORBID-CWF-CODE        PIC X(02).
029900
030000     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
030100
030200     05  QIP-REDUCTION              PIC 9(01)V9(03).
030300     05  SUB                        PIC 9(04).
030400
030500     05  THE-DATE                   PIC 9(08).
030600     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
030700     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
030800     05  ONSET-DATE                 PIC 9(08).
030900     05  MOVED-CORMORBIDS           PIC X(01).
031000
031100 01  HOLD-OUTLIER-PPS-COMPONENTS.
031200     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
031300     05  H-OUT-BSA                  PIC 9(03)V9(04).
031400     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
031500     05  H-OUT-BMI                  PIC 9(03)V9(04).
031600     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
031700     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
031800     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
031900     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
032000     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
032100     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
032200     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
032300     05  H-OUT-PREDICTED-SERVICES-MAP
032400                                    PIC 9(07)V9(04).
032500     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
032600     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
032700                                    PIC 9(07)V9(04).
032800     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
032900     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
033000     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
033100
033200
033300* The following variable will change from year to year and is
033400* used for the BUNDLED part of the Bundled Pricer.
033500 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 234.81.
033600
033700* The next two percentages MUST add up to 1 (i.e. 100%)
033800* They start in 2011 and will continue to change until CY2014 when
033900* BUN-CBSA-BLEND-PCT will be 1.00
034000* The third blend percent is for those providers that waived the
034100* blended percent and went to full PPS.  This variable will be
034200* eliminated in 2014 when it is no longer needed.
034300 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.50.
034400 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.50.
034500 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
034600
034700* CONSTANTS AREA
034800* The next two percentages MUST add up TO 1 (i.e. 100%)
034900 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.41737.
035000 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.58263.
035100 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 33.44.
035200
035300*  The following number that is loaded into the payment equation
035400*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
035500*  and   --DOES NOT CHANGE--
035600
035700 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
035800
035900 01  PEDIATRIC-MULTIPLIERS.
036000*Separately billable payment multiplier (used for outliers)
036100     05  PED-SEP-BILL-PAY-MULTI.
036200         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.319.
036300         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.185.
036400         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.476.
036500         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.459.
036600     05  PED-EXPAND-BUNDLE-PAY-MULTI.
036700*Expanded bundle payment multiplier (used for normal billing)
036800         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.033.
036900         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.219.
037000         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.067.
037100         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.277.
037200
037300 01  ADULT-MULTIPLIERS.
037400*Separately billable payment multiplier (used for outliers)
037500     05  SEP-BILLABLE-PAYMANT-MULTI.
037600         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 0.996.
037700         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 0.992.
037800         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
037900         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 0.963.
038000         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.915.
038100         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.014.
038200         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.078.
038300         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.450.
038400         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.354.
038500         10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
038600         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.571.
038700         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.225.
038800         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.309.
038900         10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
039000         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.975.
039100*Case-Mix adjusted payment multiplier (used for normal billing)
039200     05  CASE-MIX-PAYMENT-MULTI.
039300         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.171.
039400         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.013.
039500         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
039600         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.011.
039700         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.016.
039800         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.020.
039900         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.025.
040000         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.510.
040100         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.114.
040200         10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
040300         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.183.
040400         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.072.
040500         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.099.
040600         10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
040700         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.189.
040800
040900 01  OUTLIER-SB-CALC-AMOUNTS.
041000     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 45.44.
041100     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 78.00.
041200     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 71.64.
041300     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 141.21.
041400     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
041500     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
041600/
041700******************************************************************
041800*    This area contains return code variables and their codes.   *
041900******************************************************************
042000 01 PAID-RETURN-CODE-TRACKERS.
042100     05  OUTLIER-TRACK              PIC X(01).
042200     05  ACUTE-COMORBID-TRACK       PIC X(01).
042300     05  CHRONIC-COMORBID-TRACK     PIC X(01).
042400     05  ONSET-TRACK                PIC X(01).
042500     05  LOW-VOLUME-TRACK           PIC X(01).
042600     05  TRAINING-TRACK             PIC X(01).
042700     05  PEDIATRIC-TRACK            PIC X(01).
042800     05  LOW-BMI-TRACK              PIC X(01).
042900 COPY RTCCPY.
043000*COPY "RTCCPY.CPY".
043100*                                                                *
043200*  Legal combinations of adjustments for ADULTS are:             *
043300*     if NO ONSET applies, then they can have any combination of:*
043400*       acute OR chronic comorbid, & outlier, low vol., training.*
043500*     if ONSET applies, then they can have:                      *
043600*           outlier and/or low volume.                           *
043700*  Legal combinations of adjustments for PEDIATRIC are:          *
043800*     outlier and/or training.                                   *
043900*                                                                *
044000*  Illegal combinations of adjustments for PEDIATRIC are:        *
044100*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
044200*     onset     with comorbid or training.                       *
044300*  Illegal combinations of adjustments for ANYONE are:           *
044400*     acute comorbid AND chronic comorbid.                       *
044500/
044600 LINKAGE SECTION.
044700 COPY BILLCPY.
044800*COPY "BILLCPY.CPY".
044900/
045000 COPY WAGECPY.
045100*COPY "WAGECPY.CPY".
045200/
045300 PROCEDURE DIVISION  USING BILL-NEW-DATA
045400                           PPS-DATA-ALL
045500                           WAGE-NEW-RATE-RECORD
045600                           COM-CBSA-WAGE-RECORD
045700                           BUN-CBSA-WAGE-RECORD.
045800
045900******************************************************************
046000* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
046100* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
046200* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
046300* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
046400* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
046500* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
046600* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
046700* PROCESSING (DICP).                                             *
046800*                                                                *
046900*                                                                *
047000*    PROCESSING:                                                 *
047100*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
047200*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
047300*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
047400*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
047500*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
047600*           GOBACK.                                              *
047700*        D. ASSEMBLE PRICING COMPONENTS.                         *
047800*        E. CALCULATE THE PRICE.                                 *
047900******************************************************************
048000
048100 0000-START-TO-FINISH.
048200     INITIALIZE PPS-DATA-ALL.
048300
048400     IF BUNDLED-TEST  THEN
048500        INITIALIZE BILL-DATA-TEST
048600        INITIALIZE COND-CD-73
048700     END-IF.
048800     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
048900     MOVE ZEROS                        TO PPS-RTC.
049000
049100     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
049200
049300     IF PPS-RTC = 00  THEN
049400        PERFORM 1200-INITIALIZATION
049500**Calculate patient age
049600        COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
049700        IF B-DOB-MM > B-THRU-MM  THEN
049800           COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
049900        END-IF
050000        IF H-PATIENT-AGE < 18  THEN
050100           MOVE "Y"                    TO PEDIATRIC-TRACK
050200        END-IF
050300        PERFORM 2000-CALCULATE-BUNDLED-FACTORS
050400        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
050500           PERFORM 5000-CALC-COMP-RATE-FACTORS
050600        END-IF
050700        PERFORM 9000-SET-RETURN-CODE
050800        PERFORM 9100-MOVE-RESULTS
050900     END-IF.
051000
051100     GOBACK.
051200/
051300 1000-VALIDATE-BILL-ELEMENTS.
051400     IF P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
051500        NEXT SENTENCE
051600     ELSE
051700        MOVE 52                        TO PPS-RTC
051800     END-IF.
051900
052000     IF PPS-RTC = 00  THEN
052100        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
052200           MOVE 53                     TO PPS-RTC
052300        END-IF
052400     END-IF.
052500
052600     IF PPS-RTC = 00  THEN
052700        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
052800           MOVE 54                     TO PPS-RTC
052900        END-IF
053000     END-IF.
053100
053200     IF PPS-RTC = 00  THEN
053300        IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
053400           MOVE 55                     TO PPS-RTC
053500        END-IF
053600     END-IF.
053700
053800     IF PPS-RTC = 00  THEN
053900        IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
054000           MOVE 56                     TO PPS-RTC
054100        END-IF
054200     END-IF.
054300
054400     IF PPS-RTC = 00  THEN
054500        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
054600                                OR '0881'
054700           NEXT SENTENCE
054800        ELSE
054900           MOVE 57                     TO PPS-RTC
055000        END-IF
055100     END-IF.
055200
055300     IF PPS-RTC = 00  THEN
055400        IF B-COND-CODE NOT = '73' AND '74' AND '  '
055500           MOVE 58                     TO PPS-RTC
055600        END-IF
055700     END-IF.
055800
055900     IF PPS-RTC = 00  THEN
056000        IF P-QIP-REDUCTION NOT = '1' AND '2' AND '3' AND '4' AND
056100                                 ' '  THEN
056200           MOVE 53                     TO PPS-RTC
056300*  This RTC is for the Special Payment Indicator not = '1' or
056400*  blank, which closely approximates the intent of the edit check.
056500*  I propose to make this a PPS-RTC = 59 in 2013 version of Pricer
056600        END-IF
056700     END-IF.
056800
056900     IF PPS-RTC = 00  THEN
057000        IF B-PATIENT-HGT > 300.00
057100           MOVE 71                     TO PPS-RTC
057200        END-IF
057300     END-IF.
057400
057500     IF PPS-RTC = 00  THEN
057600        IF B-PATIENT-WGT > 500.00  THEN
057700           MOVE 72                     TO PPS-RTC
057800        END-IF
057900     END-IF.
058000
058100* Before 2012 pricer, put in edit check to make sure that the
058200* # of sesions does not exceed the # of days in a month.  Maybe
058300* the # of cays in a month minus one when patient goes into a
058400* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
058500* or 0851)).  If done, then will need extra RTC.
058600     IF PPS-RTC = 00  THEN
058700        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
058800           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
058900           MOVE 73                     TO PPS-RTC
059000        END-IF
059100     END-IF.
059200
059300     IF PPS-RTC = 00  THEN
059400        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
059500           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
059600           MOVE 74                     TO PPS-RTC
059700        END-IF
059800     END-IF.
059900
060000     IF PPS-RTC = 00  THEN
060100        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
060200           MOVE 75                     TO PPS-RTC
060300        END-IF
060400     END-IF.
060500
060600     IF PPS-RTC = 00  THEN
060700        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
060800           MOVE 76                     TO PPS-RTC
060900        END-IF
061000     END-IF.
061100
061200     IF PPS-RTC = 00  THEN
061300        IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
061400            VALID-COMORBID-CWF-RETURN-CD       THEN
061500           NEXT SENTENCE
061600        ELSE
061700           MOVE 81                     TO PPS-RTC
061800        END-IF
061900     END-IF.
062000/
062100 1200-INITIALIZATION.
062200     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
062300     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
062400     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
062500     INITIALIZE PAID-RETURN-CODE-TRACKERS.
062600
062700     MOVE SPACES                       TO MOVED-CORMORBIDS.
062800
062900     IF P-QIP-REDUCTION = ' '  THEN
063000* no reduction
063100        MOVE 1.000 TO QIP-REDUCTION
063200     ELSE
063300        IF P-QIP-REDUCTION = '1'  THEN
063400* one-half percent reduction
063500           MOVE 0.995 TO QIP-REDUCTION
063600        ELSE
063700           IF P-QIP-REDUCTION = '2'  THEN
063800* one percent reduction
063900              MOVE 0.990 TO QIP-REDUCTION
064000           ELSE
064100              IF P-QIP-REDUCTION = '3'  THEN
064200* one and one-half percent reduction
064300                 MOVE 0.985 TO QIP-REDUCTION
064400              ELSE
064500* two percent reduction
064600                 MOVE 0.980 TO QIP-REDUCTION
064700              END-IF
064800           END-IF
064900        END-IF
065000     END-IF.
065100
065200*    Since pricer has to pay a comorbid condition according to the
065300* return code that CWF passes back, it is cleaner if the pricer
065400* sets aside whatever comorbid data exists on the line-item when
065500* it comes into the pricer and then transferrs the CWF code to
065600* the appropriate place in the comorbid data.  This avoids
065700* making convoluted changes in the other parts of the program
065800* which has to look at both original comorbid data AND CWF return
065900* codes to handle comorbids.  Near the end of the program where
066000* variables are transferred to the output, the original comorbid
066100* data is put back into its original place as though nothing
066200* occurred.
066300     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
066400        NEXT SENTENCE
066500     ELSE
066600        MOVE 'Y'                       TO MOVED-CORMORBIDS
066700        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
066800        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
066900        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
067000        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
067100        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
067200        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
067300        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
067400        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
067500           MOVE SPACES                 TO COMORBID-DATA (1)
067600                                          COMORBID-DATA (2)
067700                                          COMORBID-DATA (3)
067800                                          COMORBID-DATA (4)
067900                                          COMORBID-DATA (5)
068000                                          COMORBID-DATA (6)
068100                                          COMORBID-CWF-RETURN-CODE
068200        ELSE
068300           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
068400              MOVE 'MA'                TO COMORBID-DATA (1)
068500              MOVE SPACES              TO COMORBID-DATA (2)
068600                                          COMORBID-DATA (3)
068700                                          COMORBID-DATA (4)
068800                                          COMORBID-DATA (5)
068900                                          COMORBID-DATA (6)
069000                                          COMORBID-CWF-RETURN-CODE
069100           ELSE
069200              IF COMORBID-CWF-RETURN-CODE = '30'  THEN
069300                 MOVE SPACES           TO COMORBID-DATA (1)
069400                 MOVE 'MB'             TO COMORBID-DATA (2)
069500                 MOVE SPACES           TO COMORBID-DATA (3)
069600                 MOVE SPACES           TO COMORBID-DATA (4)
069700                 MOVE SPACES           TO COMORBID-DATA (5)
069800                 MOVE SPACES           TO COMORBID-DATA (6)
069900                                          COMORBID-CWF-RETURN-CODE
070000              ELSE
070100                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
070200                    MOVE SPACES        TO COMORBID-DATA (1)
070300                    MOVE SPACES        TO COMORBID-DATA (2)
070400                    MOVE 'MC'          TO COMORBID-DATA (3)
070500                    MOVE SPACES        TO COMORBID-DATA (4)
070600                    MOVE SPACES        TO COMORBID-DATA (5)
070700                    MOVE SPACES        TO COMORBID-DATA (6)
070800                                          COMORBID-CWF-RETURN-CODE
070900                 ELSE
071000                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
071100                       MOVE SPACES     TO COMORBID-DATA (1)
071200                       MOVE SPACES     TO COMORBID-DATA (2)
071300                       MOVE SPACES     TO COMORBID-DATA (3)
071400                       MOVE 'MD'       TO COMORBID-DATA (4)
071500                       MOVE SPACES     TO COMORBID-DATA (5)
071600                       MOVE SPACES     TO COMORBID-DATA (6)
071700                                          COMORBID-CWF-RETURN-CODE
071800                    ELSE
071900                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
072000                          MOVE SPACES  TO COMORBID-DATA (1)
072100                          MOVE SPACES  TO COMORBID-DATA (2)
072200                          MOVE SPACES  TO COMORBID-DATA (3)
072300                          MOVE SPACES  TO COMORBID-DATA (4)
072400                          MOVE 'ME'    TO COMORBID-DATA (5)
072500                          MOVE SPACES  TO COMORBID-DATA (6)
072600                                          COMORBID-CWF-RETURN-CODE
072700                       ELSE
072800                          MOVE SPACES  TO COMORBID-DATA (1)
072900                                          COMORBID-DATA (2)
073000                                          COMORBID-DATA (3)
073100                                          COMORBID-DATA (4)
073200                                          COMORBID-DATA (5)
073300                                          COMORBID-CWF-RETURN-CODE
073400                          MOVE 'MF'    TO COMORBID-DATA (6)
073500                       END-IF
073600                    END-IF
073700                 END-IF
073800              END-IF
073900           END-IF
074000        END-IF
074100     END-IF.
074200
074300******************************************************************
074400***Calculate BUNDLED Wage Adjusted Rate (note different method)***
074500******************************************************************
074600     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
074700        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
074800         BUN-CBSA-W-INDEX.
074900
075000     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
075100        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
075200
075300     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
075400        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
075500/
075600 2000-CALCULATE-BUNDLED-FACTORS.
075700******************************************************************
075800***  Set BUNDLED age adjustment factor                         ***
075900******************************************************************
076000     IF H-PATIENT-AGE < 13  THEN
076100        IF B-REV-CODE = '0821' OR '0881' THEN
076200           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
076300        ELSE
076400           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
076500        END-IF
076600     ELSE
076700        IF H-PATIENT-AGE < 18 THEN
076800           IF B-REV-CODE = '0821' OR '0881' THEN
076900              MOVE EB-AGE-13-17-HEMO-MODE
077000                                       TO H-BUN-AGE-FACTOR
077100           ELSE
077200              MOVE EB-AGE-13-17-PD-MODE
077300                                       TO H-BUN-AGE-FACTOR
077400           END-IF
077500        ELSE
077600           IF H-PATIENT-AGE < 45  THEN
077700              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
077800           ELSE
077900              IF H-PATIENT-AGE < 60  THEN
078000                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
078100              ELSE
078200                 IF H-PATIENT-AGE < 70  THEN
078300                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
078400                 ELSE
078500                    IF H-PATIENT-AGE < 80  THEN
078600                       MOVE CM-AGE-70-79
078700                                       TO H-BUN-AGE-FACTOR
078800                    ELSE
078900                       MOVE CM-AGE-80-PLUS
079000                                       TO H-BUN-AGE-FACTOR
079100                    END-IF
079200                 END-IF
079300              END-IF
079400           END-IF
079500        END-IF
079600     END-IF.
079700
079800******************************************************************
079900***  Calculate BUNDLED BSA factor (note NEW formula)           ***
080000******************************************************************
080100     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
080200         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
080300
080400     IF H-PATIENT-AGE > 17  THEN
080500        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
080600             CM-BSA ** ((H-BUN-BSA - 1.87) / .1)
080700     ELSE
080800        MOVE 1.000                     TO H-BUN-BSA-FACTOR
080900     END-IF.
081000
081100******************************************************************
081200***  Calculate BUNDLED BMI factor                              ***
081300******************************************************************
081400     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
081500         (B-PATIENT-HGT ** 2)) * 10000.
081600
081700     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
081800        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
081900        MOVE "Y"                       TO LOW-BMI-TRACK
082000     ELSE
082100        MOVE 1.000                     TO H-BUN-BMI-FACTOR
082200     END-IF.
082300
082400******************************************************************
082500***  Calculate BUNDLED ONSET factor                            ***
082600******************************************************************
082700     IF B-DIALYSIS-START-DATE > ZERO  THEN
082800        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
082900        COMPUTE INTEGER-LINE-ITEM-DATE =
083000            FUNCTION INTEGER-OF-DATE(THE-DATE)
083100        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
083200        COMPUTE INTEGER-DIALYSIS-DATE  =
083300            FUNCTION INTEGER-OF-DATE(THE-DATE)
083400* Need to add one to onset-date because the start date should
083500* be included in the count of days.  fix made 9/6/2011
083600        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
083700                              INTEGER-DIALYSIS-DATE) + 1
083800        IF H-PATIENT-AGE > 17  THEN
083900           IF ONSET-DATE > 120  THEN
084000              MOVE 1                   TO H-BUN-ONSET-FACTOR
084100           ELSE
084200              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
084300              MOVE "Y"                 TO ONSET-TRACK
084400           END-IF
084500        ELSE
084600           MOVE 1                      TO H-BUN-ONSET-FACTOR
084700        END-IF
084800     ELSE
084900        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
085000     END-IF.
085100
085200******************************************************************
085300***  Set BUNDLED Co-morbidities adjustment                     ***
085400******************************************************************
085500     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
085600        IF H-PATIENT-AGE  <  18  THEN
085700           MOVE 1.000                  TO
085800                                       H-BUN-COMORBID-MULTIPLIER
085900           MOVE '10'                   TO PPS-2011-COMORBID-PAY
086000        ELSE
086100           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
086200              MOVE 1.000               TO
086300                                       H-BUN-COMORBID-MULTIPLIER
086400              MOVE '10'                TO PPS-2011-COMORBID-PAY
086500           ELSE
086600              PERFORM 2100-CALC-COMORBID-ADJUST
086700              MOVE H-COMORBID-MULTIPLIER TO
086800                                       H-BUN-COMORBID-MULTIPLIER
086900           END-IF
087000        END-IF
087100     ELSE
087200        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
087300           MOVE 1.000                  TO
087400                                       H-BUN-COMORBID-MULTIPLIER
087500           MOVE '10'                   TO PPS-2011-COMORBID-PAY
087600        ELSE
087700           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
087800              MOVE CM-GI-BLEED         TO
087900                                       H-BUN-COMORBID-MULTIPLIER
088000              MOVE '20'                TO PPS-2011-COMORBID-PAY
088100           ELSE
088200              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
088300                 MOVE CM-PNEUMONIA     TO
088400                                       H-BUN-COMORBID-MULTIPLIER
088500                 MOVE '30'             TO PPS-2011-COMORBID-PAY
088600              ELSE
088700                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
088800                    MOVE CM-PERICARDITIS TO
088900                                       H-BUN-COMORBID-MULTIPLIER
089000                    MOVE '40'          TO PPS-2011-COMORBID-PAY
089100                 END-IF
089200              END-IF
089300           END-IF
089400        END-IF
089500     END-IF.
089600
089700******************************************************************
089800***  Calculate BUNDLED Low Volume adjustment                   ***
089900******************************************************************
090000     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
090100        IF H-PATIENT-AGE > 17  THEN
090200           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
090300                                       H-BUN-LOW-VOL-MULTIPLIER
090400           MOVE "Y"                    TO  LOW-VOLUME-TRACK
090500        ELSE
090600           MOVE 1.000                  TO
090700                                       H-BUN-LOW-VOL-MULTIPLIER
090800        END-IF
090900     ELSE
091000        MOVE 1.000                     TO
091100                                       H-BUN-LOW-VOL-MULTIPLIER
091200     END-IF.
091300
091400******************************************************************
091500***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
091600******************************************************************
091700     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
091800        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
091900        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
092000        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
092100        (H-BUN-LOW-VOL-MULTIPLIER).
092200
092300******************************************************************
092400***  Calculate BUNDLED Condition Code payment                  ***
092500******************************************************************
092600* Self-care in Training add-on
092700     IF B-COND-CODE = '73'  THEN
092800* no add-on when onset is present
092900        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
093000           MOVE ZERO                   TO
093100                                    H-BUN-WAGE-ADJ-TRAINING-AMT
093200        ELSE
093300* use new PPS training add-on amount times wage-index
093400           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
093500             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
093600           MOVE "Y"                    TO TRAINING-TRACK
093700        END-IF
093800     ELSE
093900* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
094000        IF (B-COND-CODE = '74')  AND
094100           (B-REV-CODE = '0841' OR '0851')  THEN
094200              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
094300                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
094400        ELSE
094500           MOVE ZERO                   TO
094600                                    H-BUN-WAGE-ADJ-TRAINING-AMT
094700                                    H-CC-74-PER-DIEM-AMT
094800        END-IF
094900     END-IF.
095000
095100******************************************************************
095200***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
095300******************************************************************
095400     IF (B-COND-CODE = '74')  AND
095500        (B-REV-CODE = '0841' OR '0851')  THEN
095600           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
095700                           H-CC-74-PER-DIEM-AMT
095800           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
095900              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
096000              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
096100     ELSE
096200        COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
096300                H-BUN-ADJUSTED-BASE-WAGE-AMT  +
096400                H-BUN-WAGE-ADJ-TRAINING-AMT
096500     END-IF.
096600
096700******************************************************************
096800***  Calculate BUNDLED Outlier                                 ***
096900******************************************************************
097000     PERFORM 2500-CALC-OUTLIER-FACTORS.
097100
097200******************************************************************
097300***  Calculate Low Volume payment for recovery purposes        ***
097400******************************************************************
097500     IF LOW-VOLUME-TRACK = "Y"  THEN
097600        PERFORM 3000-LOW-VOL-FULL-PPS-PAYMENT
097700        PERFORM 3100-LOW-VOL-OUT-PPS-PAYMENT
097800
097900        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT -
098000           H-PPS-FINAL-PAY-AMT
098100
098200        COMPUTE H-LV-OUT-PAYMENT       = H-LV-OUT-PAYMENT       -
098300           H-OUT-PAYMENT
098400
098500        COMPUTE H-LV-PPS-FINAL-PAY-AMT = H-LV-PPS-FINAL-PAY-AMT +
098600           H-LV-OUT-PAYMENT
098700
098800        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
098900           COMPUTE PPS-LOW-VOL-AMT  ROUNDED =
099000              H-LV-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
099100        ELSE
099200           MOVE H-LV-PPS-FINAL-PAY-AMT TO PPS-LOW-VOL-AMT
099300        END-IF
099400     END-IF.
099500
099600
099700/
099800 2100-CALC-COMORBID-ADJUST.
099900******************************************************************
100000***  Calculate Co-morbidities adjustment                       ***
100100******************************************************************
100200*  This logic assumes that the comorbids are randomly assigned   *
100300*to the comorbid table.  It will select the highest comorbid for *
100400*payment if one is found.                                        *
100500******************************************************************
100600     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
100700     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
100800     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
100900
101000     PERFORM VARYING  SUB  FROM  1 BY 1
101100       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
101200         IF COMORBID-DATA (SUB) = 'MA'  THEN
101300           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
101400           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
101500           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
101600           MOVE '20'                   TO PPS-2011-COMORBID-PAY
101700         ELSE
101800           IF COMORBID-DATA (SUB) = 'MB'  THEN
101900             IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
102000               MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
102100               MOVE "Y"                TO ACUTE-COMORBID-TRACK
102200               MOVE '30'               TO PPS-2011-COMORBID-PAY
102300             END-IF
102400           ELSE
102500             IF COMORBID-DATA (SUB) = 'MC'  THEN
102600                IF CM-PERICARDITIS  >
102700                                      H-COMORBID-MULTIPLIER  THEN
102800                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
102900                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
103000                  MOVE '40'            TO PPS-2011-COMORBID-PAY
103100                END-IF
103200             ELSE
103300               IF COMORBID-DATA (SUB) = 'MD'  THEN
103400                 IF CM-MYELODYSPLASTIC  >
103500                                      H-COMORBID-MULTIPLIER  THEN
103600                   MOVE CM-MYELODYSPLASTIC  TO
103700                                      H-COMORBID-MULTIPLIER
103800                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
103900                   MOVE '50'           TO PPS-2011-COMORBID-PAY
104000                 END-IF
104100               ELSE
104200                 IF COMORBID-DATA (SUB) = 'ME'  THEN
104300                   IF CM-SICKEL-CELL  >
104400                                      H-COMORBID-MULTIPLIER  THEN
104500                     MOVE CM-SICKEL-CELL  TO
104600                                      H-COMORBID-MULTIPLIER
104700                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
104800                     MOVE '60'         TO PPS-2011-COMORBID-PAY
104900                   END-IF
105000                 ELSE
105100                   IF COMORBID-DATA (SUB) = 'MF'  THEN
105200                     IF CM-MONOCLONAL-GAMM  >
105300                                      H-COMORBID-MULTIPLIER  THEN
105400                       MOVE CM-MONOCLONAL-GAMM TO
105500                                      H-COMORBID-MULTIPLIER
105600                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
105700                       MOVE '70'       TO PPS-2011-COMORBID-PAY
105800                     END-IF
105900                   END-IF
106000                 END-IF
106100               END-IF
106200             END-IF
106300           END-IF
106400         END-IF
106500     END-PERFORM.
106600/
106700 2500-CALC-OUTLIER-FACTORS.
106800******************************************************************
106900***  Set separately billable OUTLIER age adjustment factor     ***
107000******************************************************************
107100     IF H-PATIENT-AGE < 13  THEN
107200        IF B-REV-CODE = '0821' OR '0881' THEN
107300           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
107400        ELSE
107500           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
107600        END-IF
107700     ELSE
107800        IF H-PATIENT-AGE < 18 THEN
107900           IF B-REV-CODE = '0821' OR '0881' THEN
108000              MOVE SB-AGE-13-17-HEMO-MODE
108100                                       TO H-OUT-AGE-FACTOR
108200           ELSE
108300              MOVE SB-AGE-13-17-PD-MODE
108400                                       TO H-OUT-AGE-FACTOR
108500           END-IF
108600        ELSE
108700           IF H-PATIENT-AGE < 45  THEN
108800              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
108900           ELSE
109000              IF H-PATIENT-AGE < 60  THEN
109100                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
109200              ELSE
109300                 IF H-PATIENT-AGE < 70  THEN
109400                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
109500                 ELSE
109600                    IF H-PATIENT-AGE < 80  THEN
109700                       MOVE SB-AGE-70-79
109800                                       TO H-OUT-AGE-FACTOR
109900                    ELSE
110000                       MOVE SB-AGE-80-PLUS
110100                                       TO H-OUT-AGE-FACTOR
110200                    END-IF
110300                 END-IF
110400              END-IF
110500           END-IF
110600        END-IF
110700     END-IF.
110800
110900******************************************************************
111000**Calculate separately billable OUTLIER BSA factor (superscript)**
111100******************************************************************
111200     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
111300         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
111400
111500     IF H-PATIENT-AGE > 17  THEN
111600        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
111700             SB-BSA ** ((H-OUT-BSA - 1.87) / .1)
111800     ELSE
111900        MOVE 1.000                     TO H-OUT-BSA-FACTOR
112000     END-IF.
112100
112200******************************************************************
112300***  Calculate separately billable OUTLIER BMI factor          ***
112400******************************************************************
112500     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
112600         (B-PATIENT-HGT ** 2)) * 10000.
112700
112800     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
112900        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
113000     ELSE
113100        MOVE 1.000                     TO H-OUT-BMI-FACTOR
113200     END-IF.
113300
113400******************************************************************
113500***  Calculate separately billable OUTLIER ONSET factor        ***
113600******************************************************************
113700     IF B-DIALYSIS-START-DATE > ZERO  THEN
113800        IF H-PATIENT-AGE > 17  THEN
113900           IF ONSET-DATE > 120  THEN
114000              MOVE 1                   TO H-OUT-ONSET-FACTOR
114100           ELSE
114200              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
114300           END-IF
114400        ELSE
114500           MOVE 1                      TO H-OUT-ONSET-FACTOR
114600        END-IF
114700     ELSE
114800        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
114900     END-IF.
115000
115100******************************************************************
115200***  Set separately billable OUTLIER Co-morbidities adjustment ***
115300******************************************************************
115400     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
115500        IF H-PATIENT-AGE  <  18  THEN
115600           MOVE 1.000                  TO
115700                                       H-OUT-COMORBID-MULTIPLIER
115800           MOVE '10'                   TO PPS-2011-COMORBID-PAY
115900        ELSE
116000           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
116100              MOVE 1.000               TO
116200                                       H-OUT-COMORBID-MULTIPLIER
116300              MOVE '10'                TO PPS-2011-COMORBID-PAY
116400           ELSE
116500              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
116600           END-IF
116700        END-IF
116800     ELSE
116900        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
117000           MOVE 1.000                  TO
117100                                       H-OUT-COMORBID-MULTIPLIER
117200        ELSE
117300           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
117400              MOVE SB-GI-BLEED         TO
117500                                       H-OUT-COMORBID-MULTIPLIER
117600           ELSE
117700              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
117800                 MOVE SB-PNEUMONIA     TO
117900                                       H-OUT-COMORBID-MULTIPLIER
118000              ELSE
118100                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
118200                    MOVE SB-PERICARDITIS TO
118300                                       H-OUT-COMORBID-MULTIPLIER
118400                 END-IF
118500              END-IF
118600           END-IF
118700        END-IF
118800     END-IF.
118900
119000******************************************************************
119100***  Set OUTLIER low-volume-multiplier                         ***
119200******************************************************************
119300     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
119400        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
119500     ELSE
119600        IF H-PATIENT-AGE < 18  THEN
119700           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
119800        ELSE
119900           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
120000           MOVE "Y"                    TO LOW-VOLUME-TRACK
120100        END-IF
120200     END-IF.
120300
120400******************************************************************
120500***  Calculate predicted OUTLIER services MAP per treatment    ***
120600******************************************************************
120700     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
120800        (H-OUT-AGE-FACTOR             *
120900         H-OUT-BSA-FACTOR             *
121000         H-OUT-BMI-FACTOR             *
121100         H-OUT-ONSET-FACTOR           *
121200         H-OUT-COMORBID-MULTIPLIER    *
121300         H-OUT-LOW-VOL-MULTIPLIER).
121400
121500******************************************************************
121600***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
121700******************************************************************
121800     IF H-PATIENT-AGE < 18  THEN
121900        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
122000           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
122100        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
122200     ELSE
122300
122400        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
122500           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
122600        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
122700     END-IF.
122800
122900******************************************************************
123000*** Calculate imputed OUTLIER services MAP amount per treatment***
123100******************************************************************
123200     IF (B-COND-CODE = '74')  AND
123300        (B-REV-CODE = '0841' OR '0851')  THEN
123400         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
123500            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
123600         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
123700         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
123800     ELSE
123900        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
124000        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
124100     END-IF.
124200
124300******************************************************************
124400*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
124500******************************************************************
124600     IF H-PATIENT-AGE < 18   THEN
124700        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
124800           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
124900        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
125000        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
125100           COMPUTE H-OUT-PAYMENT  ROUNDED  =
125200            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
125300                                         LOSS-SHARING-PCT-LT-18
125400           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
125500           MOVE "Y"                    TO OUTLIER-TRACK
125600        ELSE
125700           MOVE ZERO                   TO H-OUT-PAYMENT
125800           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
125900        END-IF
126000     ELSE
126100        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
126200           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
126300           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
126400        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
126500           COMPUTE H-OUT-PAYMENT  ROUNDED  =
126600            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
126700                                         LOSS-SHARING-PCT-GT-17
126800           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
126900           MOVE "Y"                    TO OUTLIER-TRACK
127000        ELSE
127100           MOVE ZERO                   TO H-OUT-PAYMENT
127200        END-IF
127300     END-IF.
127400
127500     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
127600
127700* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
127800     IF (B-COND-CODE = '74')  AND
127900        (B-REV-CODE = '0841' OR '0851')  THEN
128000           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
128100             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
128200     END-IF.
128300/
128400 2600-CALC-COMORBID-OUT-ADJUST.
128500******************************************************************
128600***  Calculate OUTLIER Co-morbidities adjustment               ***
128700******************************************************************
128800*  This logic assumes that the comorbids are randomly assigned   *
128900*to the comorbid table.  It will select the highest comorbid for *
129000*payment if one is found.                                        *
129100******************************************************************
129200
129300     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
129400     MOVE 1.000                        TO
129500                                  H-OUT-COMORBID-MULTIPLIER.
129600
129700     PERFORM VARYING  SUB  FROM  1 BY 1
129800       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
129900         IF COMORBID-DATA (SUB) = 'MA'  THEN
130000           MOVE SB-GI-BLEED            TO
130100                                  H-OUT-COMORBID-MULTIPLIER
130200           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
130300           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
130400         ELSE
130500           IF COMORBID-DATA (SUB) = 'MB'  THEN
130600             IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
130700               MOVE SB-PNEUMONIA       TO
130800                                  H-OUT-COMORBID-MULTIPLIER
130900               MOVE "Y"                TO ACUTE-COMORBID-TRACK
131000             END-IF
131100           ELSE
131200             IF COMORBID-DATA (SUB) = 'MC'  THEN
131300                IF SB-PERICARDITIS  >
131400                                  H-OUT-COMORBID-MULTIPLIER  THEN
131500                  MOVE SB-PERICARDITIS TO
131600                                  H-OUT-COMORBID-MULTIPLIER
131700                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
131800                END-IF
131900             ELSE
132000               IF COMORBID-DATA (SUB) = 'MD'  THEN
132100                 IF SB-MYELODYSPLASTIC  >
132200                                  H-OUT-COMORBID-MULTIPLIER  THEN
132300                   MOVE SB-MYELODYSPLASTIC  TO
132400                                  H-OUT-COMORBID-MULTIPLIER
132500                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
132600                 END-IF
132700               ELSE
132800                 IF COMORBID-DATA (SUB) = 'ME'  THEN
132900                   IF SB-SICKEL-CELL  >
133000                                  H-OUT-COMORBID-MULTIPLIER  THEN
133100                     MOVE SB-SICKEL-CELL  TO
133200                                  H-OUT-COMORBID-MULTIPLIER
133300                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
133400                   END-IF
133500                 ELSE
133600                   IF COMORBID-DATA (SUB) = 'MF'  THEN
133700                     IF SB-MONOCLONAL-GAMM  >
133800                                  H-OUT-COMORBID-MULTIPLIER  THEN
133900                       MOVE SB-MONOCLONAL-GAMM  TO
134000                                  H-OUT-COMORBID-MULTIPLIER
134100                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
134200                     END-IF
134300                   END-IF
134400                 END-IF
134500               END-IF
134600             END-IF
134700           END-IF
134800         END-IF
134900     END-PERFORM.
135000/
135100******************************************************************
135200*** Calculate Low Volume Full PPS payment for recovery purposes***
135300******************************************************************
135400 3000-LOW-VOL-FULL-PPS-PAYMENT.
135500******************************************************************
135600** Modified code from 'Calc BUNDLED Adjust PPS Base Rate' para. **
135700     COMPUTE H-LV-BUN-ADJUST-BASE-WAGE-AMT  ROUNDED  =
135800        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)     *
135900        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)     *
136000        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER).
136100
136200******************************************************************
136300**Modified code from 'Calc BUNDLED Condition Code pay' paragraph**
136400* Self-care in Training add-on
136500     IF B-COND-CODE = '73'  THEN
136600* no add-on when onset is present
136700        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
136800           MOVE ZERO                   TO
136900                                    H-BUN-WAGE-ADJ-TRAINING-AMT
137000        ELSE
137100* use new PPS training add-on amount times wage-index
137200           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
137300             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
137400           MOVE "Y"                    TO TRAINING-TRACK
137500        END-IF
137600     ELSE
137700* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
137800        IF (B-COND-CODE = '74')  AND
137900           (B-REV-CODE = '0841' OR '0851')  THEN
138000              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
138100                 (H-LV-BUN-ADJUST-BASE-WAGE-AMT * 3) / 7
138200        ELSE
138300           MOVE ZERO                   TO
138400                                    H-BUN-WAGE-ADJ-TRAINING-AMT
138500                                    H-CC-74-PER-DIEM-AMT
138600        END-IF
138700     END-IF.
138800
138900******************************************************************
139000**Modified code from 'Calc BUNDLED ESRD PPS Final Pay Rate para.**
139100     IF (B-COND-CODE = '74')  AND
139200        (B-REV-CODE = '0841' OR '0851')  THEN
139300           COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
139400                           H-CC-74-PER-DIEM-AMT
139500     ELSE
139600        COMPUTE H-LV-PPS-FINAL-PAY-AMT  ROUNDED  =
139700                H-LV-BUN-ADJUST-BASE-WAGE-AMT +
139800                H-BUN-WAGE-ADJ-TRAINING-AMT
139900     END-IF.
140000
140100/
140200******************************************************************
140300*** Calculate Low Volume OUT PPS payment for recovery purposes ***
140400******************************************************************
140500 3100-LOW-VOL-OUT-PPS-PAYMENT.
140600******************************************************************
140700**Modified code from 'Calc predict OUT serv MAP per treat' para.**
140800     COMPUTE H-LV-OUT-PREDICT-SERVICES-MAP  ROUNDED =
140900        (H-OUT-AGE-FACTOR             *
141000         H-OUT-BSA-FACTOR             *
141100         H-OUT-BMI-FACTOR             *
141200         H-OUT-ONSET-FACTOR           *
141300         H-OUT-COMORBID-MULTIPLIER).
141400
141500******************************************************************
141600**modifi code 'Calc case mix adj predict OUT serv MAP/trt' para.**
141700     IF H-PATIENT-AGE < 18  THEN
141800        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
141900           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
142000        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
142100     ELSE
142200        COMPUTE H-LV-OUT-CM-ADJ-PREDICT-M-TRT  ROUNDED  =
142300           (H-LV-OUT-PREDICT-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
142400        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
142500     END-IF.
142600
142700******************************************************************
142800** 'Calculate imput OUT services MAP amount per treatment' para **
142900** It is not necessary to modify or insert this paragraph here. **
143000
143100******************************************************************
143200**Modified 'Compare of predict to imputed OUT svc MAP/trt' para.**
143300     IF H-PATIENT-AGE < 18   THEN
143400        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED  =
143500           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-LT-18
143600        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
143700        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
143800           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
143900            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
144000                                         LOSS-SHARING-PCT-LT-18
144100           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
144200        ELSE
144300           MOVE ZERO                   TO H-LV-OUT-PAYMENT
144400           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
144500        END-IF
144600     ELSE
144700        COMPUTE H-LV-OUT-PREDICTED-MAP  ROUNDED =
144800           H-LV-OUT-CM-ADJ-PREDICT-M-TRT + FIX-DOLLAR-LOSS-GT-17
144900           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
145000        IF H-OUT-IMPUTED-MAP  >  H-LV-OUT-PREDICTED-MAP  THEN
145100           COMPUTE H-LV-OUT-PAYMENT  ROUNDED  =
145200            (H-OUT-IMPUTED-MAP  -  H-LV-OUT-PREDICTED-MAP)  *
145300                                         LOSS-SHARING-PCT-GT-17
145400           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
145500        ELSE
145600           MOVE ZERO                   TO H-LV-OUT-PAYMENT
145700        END-IF
145800     END-IF.
145900
146000     MOVE H-LV-OUT-PAYMENT             TO OUT-NON-PER-DIEM-PAYMENT
146100
146200* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
146300     IF (B-COND-CODE = '74')  AND
146400        (B-REV-CODE = '0841' OR '0851')  THEN
146500           COMPUTE H-LV-OUT-PAYMENT ROUNDED = H-LV-OUT-PAYMENT *
146600             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
146700     END-IF.
146800/
146900 5000-CALC-COMP-RATE-FACTORS.
147000******************************************************************
147100***  Set Composite Rate age adjustment factor                  ***
147200******************************************************************
147300     IF H-PATIENT-AGE < 18  THEN
147400        MOVE CR-AGE-LT-18              TO H-AGE-FACTOR
147500     ELSE
147600        IF H-PATIENT-AGE < 45  THEN
147700           MOVE CR-AGE-18-44           TO H-AGE-FACTOR
147800        ELSE
147900           IF H-PATIENT-AGE < 60  THEN
148000              MOVE CR-AGE-45-59        TO H-AGE-FACTOR
148100           ELSE
148200              IF H-PATIENT-AGE < 70  THEN
148300                 MOVE CR-AGE-60-69     TO H-AGE-FACTOR
148400              ELSE
148500                 IF H-PATIENT-AGE < 80  THEN
148600                    MOVE CR-AGE-70-79  TO H-AGE-FACTOR
148700                 ELSE
148800                    MOVE CR-AGE-80-PLUS
148900                                       TO H-AGE-FACTOR
149000                 END-IF
149100              END-IF
149200           END-IF
149300        END-IF
149400     END-IF.
149500
149600******************************************************************
149700**Calculate Composite Rate BSA factor (2012 superscript now same)*
149800******************************************************************
149900     COMPUTE H-BSA  ROUNDED = (.007184 *
150000         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
150100
150200     IF H-PATIENT-AGE > 17  THEN
150300        COMPUTE H-BSA-FACTOR  ROUNDED =
150400             CR-BSA ** ((H-BSA - 1.87) / .1)
150500     ELSE
150600        MOVE 1.000                     TO H-BSA-FACTOR
150700     END-IF.
150800
150900******************************************************************
151000*** Calculate Composite Rate BMI factor (different BMI < 18.5) ***
151100******************************************************************
151200     COMPUTE H-BMI  ROUNDED = (B-PATIENT-WGT /
151300         (B-PATIENT-HGT ** 2)) * 10000.
151400
151500     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)  THEN
151600        MOVE CR-BMI-LT-18-5            TO H-BMI-FACTOR
151700     ELSE
151800        MOVE 1.000                     TO H-BMI-FACTOR
151900     END-IF.
152000
152100******************************************************************
152200***  Calculate Composite Rate Payment Amount                   ***
152300******************************************************************
152400*P-ESRD-RATE, also called the Exception Rate, will not be granted*
152500*in full beginning in 2011 (the beginning of the Bundled method) *
152600*and will be eliminated entirely beginning in 2014 which is the  *
152700*end of the blending period.  For 2011, those providers who elect*
152800*to be in the blend, will get only 75% of the exception rate.    *
152900*This apparently is for the pediatric providers who originally   *
153000*had the exception rate.                                         *
153100
153200     IF P-ESRD-RATE  =  ZERO  THEN
153300        MOVE BASE-PAYMENT-RATE         TO  H-PAYMENT-RATE
153400     ELSE
153500        MOVE P-ESRD-RATE               TO  H-PAYMENT-RATE
153600     END-IF.
153700
153800     COMPUTE H-WAGE-ADJ-PYMT-AMT ROUNDED =
153900     (((H-PAYMENT-RATE * NAT-LABOR-PCT) * COM-CBSA-W-INDEX) +
154000       (H-PAYMENT-RATE * NAT-NONLABOR-PCT)) *
154100            CBSA-BLEND-PCT.
154200
154300     COMPUTE H-PYMT-AMT ROUNDED = (H-WAGE-ADJ-PYMT-AMT *
154400        H-BMI-FACTOR * H-BSA-FACTOR * CASE-MIX-BDGT-NEUT-FACTOR *
154500        H-AGE-FACTOR * DRUG-ADDON).
154600
154700     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
154800
154900******************************************************************
155000***  Calculate condition code payment                          ***
155100******************************************************************
155200     MOVE SPACES                       TO COND-CD-73.
155300
155400* Hemo, peritoneal, or CCPD training add-on
155500     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
155600                                                      OR '0851')
155700        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
155800        MOVE 'A'                       TO AMT-INDIC
155900        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
156000     ELSE
156100* CAPD training add-on
156200        IF (B-COND-CODE = '73')  AND  (B-REV-CODE = '0841')  THEN
156300           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
156400           MOVE 'A'                    TO AMT-INDIC
156500           MOVE CAPD-AMT               TO BLOOD-DOLLAR
156600        ELSE
156700* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
156800           IF (B-COND-CODE = '74')  AND
156900              (B-REV-CODE = '0841' OR '0851')  THEN
157000              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
157100                                           CAPD-OR-CCPD-FACTOR
157200              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
157300           ELSE
157400              MOVE 'A'                 TO AMT-INDIC
157500              MOVE ZERO                TO BLOOD-DOLLAR
157600           END-IF
157700        END-IF
157800     END-IF.
157900
158000/
158100 9000-SET-RETURN-CODE.
158200******************************************************************
158300***  Set the return code                                       ***
158400******************************************************************
158500*   The following 'table' helps in understanding and in making   *
158600*changes to the rather large and complex "IF" statement that     *
158700*follows.  This 'table' just reorders and rewords the comments   *
158800*contained in the working storage area concerning the paid       *
158900*return-codes.                                                   *
159000*                                                                *
159100*  17 = pediatric, outlier, training                             *
159200*  16 = pediatric, outlier                                       *
159300*  15 = pediatric, training                                      *
159400*  14 = pediatric                                                *
159500*                                                                *
159600*  24 = outlier, low volume, training, chronic comorbid          *
159700*  19 = outlier, low volume, training, acute comorbid            *
159800*  29 = outlier, low volume, training                            *
159900*  23 = outlier, low volume, chronic comorbid                    *
160000*  18 = outlier, low volume, acute comorbid                      *
160100*  30 = outlier, low volume, onset                               *
160200*  28 = outlier, low volume                                      *
160300*  34 = outlier, training, chronic comorbid                      *
160400*  35 = outlier, training, acute comorbid                        *
160500*  33 = outlier, training                                        *
160600*  07 = outlier, chronic comorbid                                *
160700*  06 = outlier, acute comorbid                                  *
160800*  09 = outlier, onset                                           *
160900*  03 = outlier                                                  *
161000*                                                                *
161100*  26 = low volume, training, chronic comorbid                   *
161200*  21 = low volume, training, acute comorbid                     *
161300*  12 = low volume, training                                     *
161400*  25 = low volume, chronic comorbid                             *
161500*  20 = low volume, acute comorbid                               *
161600*  32 = low volume, onset                                        *
161700*  10 = low volume                                               *
161800*                                                                *
161900*  27 = training, chronic comorbid                               *
162000*  22 = training, acute comorbid                                 *
162100*  11 = training                                                 *
162200*                                                                *
162300*  08 = onset                                                    *
162400*  04 = acute comorbid                                           *
162500*  05 = chronic comorbid                                         *
162600*  31 = low BMI                                                  *
162700*  02 = no adjustments                                           *
162800*                                                                *
162900*  13 = w/multiple adjustments....reserved for future use        *
163000******************************************************************
163100/
163200     IF PEDIATRIC-TRACK                       = "Y"  THEN
163300        IF OUTLIER-TRACK                      = "Y"  THEN
163400           IF TRAINING-TRACK                  = "Y"  THEN
163500              MOVE 17                  TO PPS-RTC
163600           ELSE
163700              MOVE 16                  TO PPS-RTC
163800           END-IF
163900        ELSE
164000           IF TRAINING-TRACK                  = "Y"  THEN
164100              MOVE 15                  TO PPS-RTC
164200           ELSE
164300              MOVE 14                  TO PPS-RTC
164400           END-IF
164500        END-IF
164600     ELSE
164700        IF OUTLIER-TRACK                      = "Y"  THEN
164800           IF LOW-VOLUME-TRACK                = "Y"  THEN
164900              IF TRAINING-TRACK               = "Y"  THEN
165000                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
165100                    MOVE 24            TO PPS-RTC
165200                 ELSE
165300                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
165400                       MOVE 19         TO PPS-RTC
165500                    ELSE
165600                       MOVE 29         TO PPS-RTC
165700                    END-IF
165800                 END-IF
165900              ELSE
166000                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
166100                    MOVE 23            TO PPS-RTC
166200                 ELSE
166300                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
166400                       MOVE 18         TO PPS-RTC
166500                    ELSE
166600                       IF ONSET-TRACK         = "Y"  THEN
166700                          MOVE 30      TO PPS-RTC
166800                       ELSE
166900                          MOVE 28      TO PPS-RTC
167000                       END-IF
167100                    END-IF
167200                 END-IF
167300              END-IF
167400           ELSE
167500              IF TRAINING-TRACK               = "Y"  THEN
167600                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
167700                    MOVE 34            TO PPS-RTC
167800                 ELSE
167900                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
168000                       MOVE 35         TO PPS-RTC
168100                    ELSE
168200                       MOVE 33         TO PPS-RTC
168300                    END-IF
168400                 END-IF
168500              ELSE
168600                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
168700                    MOVE 07            TO PPS-RTC
168800                 ELSE
168900                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
169000                       MOVE 06         TO PPS-RTC
169100                    ELSE
169200                       IF ONSET-TRACK         = "Y"  THEN
169300                          MOVE 09      TO PPS-RTC
169400                       ELSE
169500                          MOVE 03      TO PPS-RTC
169600                       END-IF
169700                    END-IF
169800                 END-IF
169900              END-IF
170000           END-IF
170100        ELSE
170200           IF LOW-VOLUME-TRACK                = "Y"
170300              IF TRAINING-TRACK               = "Y"  THEN
170400                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
170500                    MOVE 26            TO PPS-RTC
170600                 ELSE
170700                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
170800                       MOVE 21         TO PPS-RTC
170900                    ELSE
171000                       MOVE 12         TO PPS-RTC
171100                    END-IF
171200                 END-IF
171300              ELSE
171400                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
171500                    MOVE 25            TO PPS-RTC
171600                 ELSE
171700                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
171800                       MOVE 20         TO PPS-RTC
171900                    ELSE
172000                       IF ONSET-TRACK         = "Y"  THEN
172100                          MOVE 32      TO PPS-RTC
172200                       ELSE
172300                          MOVE 10      TO PPS-RTC
172400                       END-IF
172500                    END-IF
172600                 END-IF
172700              END-IF
172800           ELSE
172900              IF TRAINING-TRACK               = "Y"  THEN
173000                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
173100                    MOVE 27            TO PPS-RTC
173200                 ELSE
173300                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
173400                       MOVE 22         TO PPS-RTC
173500                    ELSE
173600                       MOVE 11         TO PPS-RTC
173700                    END-IF
173800                 END-IF
173900              ELSE
174000                 IF ONSET-TRACK               = "Y"  THEN
174100                    MOVE 08            TO PPS-RTC
174200                 ELSE
174300                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
174400                       MOVE 04         TO PPS-RTC
174500                    ELSE
174600                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
174700                          MOVE 05      TO PPS-RTC
174800                       ELSE
174900                          IF LOW-BMI-TRACK = "Y"  THEN
175000                             MOVE 31 TO PPS-RTC
175100                          ELSE
175200                             MOVE 02 TO PPS-RTC
175300                          END-IF
175400                       END-IF
175500                    END-IF
175600                 END-IF
175700              END-IF
175800           END-IF
175900        END-IF
176000     END-IF.
176100/
176200 9100-MOVE-RESULTS.
176300     IF MOVED-CORMORBIDS = SPACES  THEN
176400        NEXT SENTENCE
176500     ELSE
176600        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
176700        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
176800        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
176900        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
177000        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
177100        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
177200        MOVE H-COMORBID-CWF-CODE       TO
177300                                    COMORBID-CWF-RETURN-CODE
177400     END-IF.
177500
177600     MOVE P-GEO-MSA                    TO PPS-MSA.
177700     MOVE P-GEO-CBSA                   TO PPS-CBSA.
177800     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
177900     MOVE B-COND-CODE                  TO PPS-COND-CODE.
178000     MOVE B-REV-CODE                   TO PPS-REV-CODE.
178100     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
178200     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
178300     MOVE BUN-NAT-NONLABOR-PCT         TO
178400                                    PPS-2011-NAT-NONLABOR-PCT.
178500     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
178600     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
178700     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
178800     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
178900     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
179000     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
179100     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
179200     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
179300     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
179400     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
179500                                    PPS-2011-BDGT-NEUT-RATE.
179600     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
179700     MOVE SPACES                       TO
179800                                    PPS-2011-COMORBID-MA-CC.
179900
180000     IF (B-COND-CODE = '74')  AND
180100        (B-REV-CODE = '0841' OR '0851')  THEN
180200         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
180300                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
180400     END-IF.
180500
180600     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
180700           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
180800              H-PYMT-AMT              *  COM-CBSA-BLEND-PCT
180900           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
181000              H-PPS-FINAL-PAY-AMT     *  BUN-CBSA-BLEND-PCT
181100           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
181200              H-OUT-PAYMENT           *  BUN-CBSA-BLEND-PCT
181300     ELSE
181400        MOVE ZERO                      TO
181500                                    PPS-2011-BLEND-COMP-RATE
181600        MOVE ZERO                      TO
181700                                    PPS-2011-BLEND-PPS-RATE
181800        MOVE ZERO                      TO
181900                                    PPS-2011-BLEND-OUTLIER-RATE
182000     END-IF.
182100
182200     MOVE H-PYMT-AMT                   TO
182300                                    PPS-2011-FULL-COMP-RATE.
182400     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
182500                                          PPS-FINAL-PAY-AMT.
182600     MOVE H-OUT-PAYMENT                TO
182700                                    PPS-2011-FULL-OUTLIER-RATE.
182800
182900
183000     IF P-QIP-REDUCTION = ' ' THEN
183100        NEXT SENTENCE
183200     ELSE
183300        COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
183400                PPS-2011-BLEND-COMP-RATE    *  QIP-REDUCTION
183500        COMPUTE PPS-2011-FULL-COMP-RATE     ROUNDED =
183600                PPS-2011-FULL-COMP-RATE     *  QIP-REDUCTION
183700        COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
183800                PPS-2011-BLEND-PPS-RATE     *  QIP-REDUCTION
183900        COMPUTE PPS-2011-FULL-PPS-RATE      ROUNDED =
184000                PPS-2011-FULL-PPS-RATE      *  QIP-REDUCTION
184100        COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
184200                PPS-2011-BLEND-OUTLIER-RATE *  QIP-REDUCTION
184300        COMPUTE PPS-2011-FULL-OUTLIER-RATE  ROUNDED =
184400                PPS-2011-FULL-OUTLIER-RATE  *  QIP-REDUCTION
184500     END-IF.
184600
184700     IF BUNDLED-TEST   THEN
184800        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
184900        MOVE 0.0                       TO MSA-WAGE-ADJ
185000        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
185100        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
185200        MOVE H-PATIENT-AGE             TO AGE-RETURN
185300        MOVE 0.0                       TO MSA-WAGE-AMT
185400        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
185500        MOVE H-BMI                     TO PPS-BMI
185600        MOVE H-BSA                     TO PPS-BSA
185700        MOVE MSA-BLEND-PCT             TO MSA-PCT
185800        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
185900
186000        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
186100           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
186200           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
186300        ELSE
186400           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
186500           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
186600        END-IF
186700
186800        MOVE H-BUN-BSA                 TO BUN-BSA
186900        MOVE H-BUN-BMI                 TO BUN-BMI
187000        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
187100        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
187200        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
187300        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
187400        MOVE H-OUT-BSA                 TO OUT-BSA
187500        MOVE SB-BSA                    TO OUT-SB-BSA
187600        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
187700        MOVE H-OUT-BMI                 TO OUT-BMI
187800        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
187900        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
188000        MOVE H-OUT-COMORBID-MULTIPLIER TO
188100                                    OUT-COMORBID-MULTIPLIER
188200        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
188300                                    OUT-PREDICTED-SERVICES-MAP
188400        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
188500                                    OUT-CASE-MIX-PREDICTED-MAP
188600        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
188700                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
188800        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
188900        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
189000        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
189100        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
189200        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
189300        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
189400        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
189500        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
189600        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
189700        MOVE CM-BSA                    TO PPS-CM-BSA
189800        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
189900        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
190000        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
190100        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
190200                                    BUN-ADJUSTED-BASE-WAGE-AMT
190300        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
190400                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
190500        MOVE TRAINING-ADD-ON-PMT-AMT   TO
190600                                    PPS-TRAINING-ADD-ON-PMT-AMT
190700        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
190800     END-IF.
190900******        L A S T   S O U R C E   S T A T E M E N T      *****
