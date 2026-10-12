000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESCAL117.
000300*AUTHOR.     CMS.
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
011700* FUTURE    This program is intended to be used in a running TEN *
011800*           year (current year and nine prior years) mode.       *
011900*           As of 10/10, there are no plans on which variables to*
012000*           remove since plans may change yet again.             *
012100*           ESCAL130 Annual updates for CY 2013 made to match
012200*           specifications from the Chronic Care Policy Group.
012300* 11/14/12- Renamed to ESCAL117. Implementation of Changes in
012400*           the ESRD Pricer for CY 2013. In addition,
012500*           code was added to implement the assignment of
012600*           the pediatric hemodialysis rate to
012700*           revenue code 0881 (ultrafiltration) when reported
012800*           on a pediatric claim (CR 7064 - Requirement #11).
012900*           Changed code to add 1 to ONSET-DATE:
013000*            COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
013100*                                  INTEGER-DIALYSIS-DATE) + 1
013200*           in order to match ESCAL122 and ESCAL130.
013300*
013400******************************************************************
013500 DATE-COMPILED.
013600 ENVIRONMENT DIVISION.
013700 CONFIGURATION SECTION.
013800 SOURCE-COMPUTER.            IBM-Z990.
013900 OBJECT-COMPUTER.            ITTY-BITTY-MACHINE-CORPORATION.
014000 INPUT-OUTPUT  SECTION.
014100 FILE-CONTROL.
014200
014300 DATA DIVISION.
014400 FILE SECTION.
014500/
014600 WORKING-STORAGE SECTION.
014700 01  W-STORAGE-REF                  PIC X(46)  VALUE
014800     'ESCAL117      - W O R K I N G   S T O R A G E'.
014900 01  CAL-VERSION                    PIC X(05)  VALUE 'C11.7'.
015000
015100 01  DISPLAY-LINE-MEASUREMENT.
015200     05  FILLER                     PIC X(50) VALUE
015300         '....:...10....:...20....:...30....:...40....:...50'.
015400     05  FILLER                     PIC X(50) VALUE
015500         '....:...60....:...70....:...80....:...90....:..100'.
015600     05  FILLER                     PIC X(20) VALUE
015700         '....:..110....:..120'.
015800
015900 01  PRINT-LINE-MEASUREMENT.
016000     05  FILLER                     PIC X(51) VALUE
016100         'X....:...10....:...20....:...30....:...40....:...50'.
016200     05  FILLER                     PIC X(50) VALUE
016300         '....:...60....:...70....:...80....:...90....:..100'.
016400     05  FILLER                     PIC X(32) VALUE
016500         '....:..110....:..120....:..130..'.
016600/
016700******************************************************************
016800*  This area contains all of the old Composite Rate variables.   *
016900* They will be eliminated when the transition period ends - 2014 *
017000******************************************************************
017100 01  HOLD-COMP-RATE-PPS-COMPONENTS.
017200     05  H-PAYMENT-RATE             PIC 9(04)V9(02).
017300     05  H-PYMT-AMT                 PIC 9(04)V9(02).
017400     05  H-WAGE-ADJ-PYMT-AMT        PIC 9(04)V9(02).
017500     05  H-PATIENT-AGE              PIC 9(03).
017600     05  H-AGE-FACTOR               PIC 9(01)V9(03).
017700     05  H-BSA-FACTOR               PIC 9(01)V9(04).
017800     05  H-BMI-FACTOR               PIC 9(01)V9(04).
017900     05  H-BSA                      PIC 9(03)V9(04).
018000     05  H-BMI                      PIC 9(03)V9(04).
018100     05  HGT-PART                   PIC 9(04)V9(08).
018200     05  WGT-PART                   PIC 9(04)V9(08).
018300     05  COMBINED-PART              PIC 9(04)V9(08).
018400     05  CALC-BSA                   PIC 9(04)V9(08).
018500
018600
018700* The following two variables will change from year to year
018800* and are used for the COMPOSITE part of the Bundled Pricer.
018900 01  DRUG-ADDON                     PIC 9(01)V9(04) VALUE 1.1470.
019000 01  BASE-PAYMENT-RATE              PIC 9(04)V9(02) VALUE 138.53.
019100
019200* The next two percentages MUST add up to 1 (i.e. 100%)
019300* They will continue to change until CY2009 when CBSA will be 1.00
019400 01  MSA-BLEND-PCT                  PIC 9(01)V9(02) VALUE 0.00.
019500 01  CBSA-BLEND-PCT                 PIC 9(01)V9(02) VALUE 1.00.
019600
019700* CONSTANTS AREA
019800* The next two percentages MUST add up TO 1 (i.e. 100%)
019900 01  NAT-LABOR-PCT                  PIC 9(01)V9(05) VALUE 0.53711.
020000 01  NAT-NONLABOR-PCT               PIC 9(01)V9(05) VALUE 0.46289.
020100
020200 01  A-49-CENT-PART-D-DRUG-ADJ      PIC 9(01)V9(02) VALUE 0.49.
020300 01  HEMO-PERI-CCPD-AMT             PIC 9(02)       VALUE 20.
020400 01  CAPD-AMT                       PIC 9(02)       VALUE 12.
020500 01  CAPD-OR-CCPD-FACTOR            PIC 9(01)V9(06) VALUE
020600                                                         0.428571.
020700* The above number technically represents the fractional
020800* number 3/7 which is three days per week that a person can
020900* receive dialysis.  It will remain this value ONLY for the
021000* COMPOSITe side of the Bundled Pricer.  The Bundled portion will
021100* use the calculation method which is more understandable and
021200* follows the method used by the Policy folks.
021300
021400*  The following number that is loaded into the payment equation
021500*  is meant to BUDGET NEUTRALIZE changes in THE CASE MIX INDEX
021600*  and   --DOES NOT CHANGE--
021700
021800 01  CASE-MIX-BDGT-NEUT-FACTOR      PIC 9(01)V9(04) VALUE 0.9116.
021900
022000 01  COMPOSITE-RATE-MULTIPLIERS.
022100*Composite rate payment multiplier (used for blended providers)
022200     05  CR-AGE-LT-18           PIC 9(01)V9(03) VALUE 1.620.
022300     05  CR-AGE-18-44           PIC 9(01)V9(03) VALUE 1.223.
022400     05  CR-AGE-45-59           PIC 9(01)V9(03) VALUE 1.055.
022500     05  CR-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
022600     05  CR-AGE-70-79           PIC 9(01)V9(03) VALUE 1.094.
022700     05  CR-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.174.
022800
022900     05  CR-BSA                 PIC 9(01)V9(03) VALUE 1.037.
023000     05  CR-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.112.
023100/
023200******************************************************************
023300*    This area contains all of the NEW Bundled Rate variables.   *
023400******************************************************************
023500 01  HOLD-BUNDLED-PPS-COMPONENTS.
023600     05  H-BUN-NAT-LABOR-AMT        PIC 9(04)V9(02).
023700     05  H-BUN-NAT-NONLABOR-AMT     PIC 9(04)V9(02).
023800     05  H-BUN-BASE-WAGE-AMT        PIC 9(04)V9(04).
023900     05  H-BUN-AGE-FACTOR           PIC 9(01)V9(03).
024000     05  H-BUN-BSA                  PIC 9(03)V9(04).
024100     05  H-BUN-BSA-FACTOR           PIC 9(01)V9(04).
024200     05  H-BUN-BMI                  PIC 9(03)V9(04).
024300     05  H-BUN-BMI-FACTOR           PIC 9(01)V9(04).
024400     05  H-BUN-ONSET-FACTOR         PIC 9(01)V9(04).
024500     05  H-BUN-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
024600     05  H-BUN-ADJUSTED-BASE-WAGE-AMT
024700                                    PIC 9(07)V9(04).
024800     05  H-BUN-WAGE-ADJ-TRAINING-AMT
024900                                    PIC 9(07)V9(04).
025000     05  H-CC-74-PER-DIEM-AMT       PIC 9(07)V9(04).
025100     05  H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04).
025200     05  H-PPS-FINAL-PAY-AMT        PIC 9(07)V9(02).
025300     05  H-FULL-CLAIM-AMT           PIC 9(07)V9(02).
025400
025500     05  H-COMORBID-MULTIPLIER      PIC 9(01)V9(03).
025600     05  IS-HIGH-COMORBID-FOUND     PIC X(01).
025700         88  HIGH-COMORBID-FOUND               VALUE 'Y'.
025800
025900     05  H-COMORBID-DATA  OCCURS 6 TIMES
026000            INDEXED BY H-COMORBID-INDEX
026100                                    PIC X(02).
026200     05  H-COMORBID-CWF-CODE        PIC X(02).
026300
026400     05  H-BUN-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
026500     05  SUB                        PIC 9(04).
026600
026700     05  THE-DATE                   PIC 9(08).
026800     05  INTEGER-LINE-ITEM-DATE     PIC S9(09).
026900     05  INTEGER-DIALYSIS-DATE      PIC S9(09).
027000     05  ONSET-DATE                 PIC 9(08).
027100     05  MOVED-CORMORBIDS           PIC X(01).
027200
027300 01  HOLD-OUTLIER-PPS-COMPONENTS.
027400     05  H-OUT-AGE-FACTOR           PIC 9(01)V9(03).
027500     05  H-OUT-BSA                  PIC 9(03)V9(04).
027600     05  H-OUT-BSA-FACTOR           PIC 9(01)V9(04).
027700     05  H-OUT-BMI                  PIC 9(03)V9(04).
027800     05  H-OUT-BMI-FACTOR           PIC 9(01)V9(04).
027900     05  H-OUT-ONSET-FACTOR         PIC 9(01)V9(04).
028000     05  H-OUT-COMORBID-MULTIPLIER  PIC 9(01)V9(03).
028100     05  H-OUT-LOW-VOL-MULTIPLIER   PIC 9(01)V9(03).
028200     05  H-OUT-ADJ-AVG-MAP-AMT      PIC 9(03)V9(02).
028300     05  H-OUT-FIX-DOLLAR-LOSS      PIC 9(04)V9(02).
028400     05  H-OUT-LOSS-SHARING-PCT     PIC 9(01)V9(02).
028500     05  H-OUT-PREDICTED-SERVICES-MAP
028600                                    PIC 9(07)V9(04).
028700     05  H-OUT-IMPUTED-MAP          PIC 9(07)V9(04).
028800     05  H-OUT-CM-ADJ-PREDICT-MAP-TRT
028900                                    PIC 9(07)V9(04).
029000     05  H-OUT-PREDICTED-MAP        PIC 9(07)V9(04).
029100     05  H-OUT-PAYMENT              PIC 9(07)V9(04).
029200     05  H-OUT-HEMO-EQUIV-PAYMENT   PIC 9(07)V9(04).
029300
029400
029500* The following variable will change from year to year and is
029600* used for the BUNDLED part of the Bundled Pricer.
029700 01  BUNDLED-BASE-PMT-RATE          PIC 9(04)V9(02) VALUE 229.63.
029800
029900* The next two percentages MUST add up to 1 (i.e. 100%)
030000* They start in 2011 and will continue to change until CY2014 when
030100* BUN-CBSA-BLEND-PCT will be 1.00
030200* The third blend percent is for those providers that waived the
030300* blended percent and went to full PPS.  This variable will be
030400* eliminated in 2014 when it is no longer needed.
030500 01  COM-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.75.
030600 01  BUN-CBSA-BLEND-PCT             PIC 9(01)V9(02) VALUE 0.25.
030700 01  WAIVE-CBSA-BLEND-PCT           PIC 9(01)V9(02) VALUE 1.00.
030800
030900* CONSTANTS AREA
031000* The next two percentages MUST add up TO 1 (i.e. 100%)
031100 01  BUN-NAT-LABOR-PCT              PIC 9(01)V9(05) VALUE 0.41737.
031200 01  BUN-NAT-NONLABOR-PCT           PIC 9(01)V9(05) VALUE 0.58263.
031300 01  TRAINING-ADD-ON-PMT-AMT        PIC 9(02)V9(02) VALUE 33.44.
031400
031500*  The following number that is loaded into the payment equation
031600*  is meant to BUDGET NEUTRALIZE changes in the bundled case-mix
031700*  and   --DOES NOT CHANGE--
031800
031900 01  TRANSITION-BDGT-NEUT-FACTOR    PIC 9(01)V9(04) VALUE 0.9690.
032000
032100 01  PEDIATRIC-MULTIPLIERS.
032200*Separately billable payment multiplier (used for outliers)
032300     05  PED-SEP-BILL-PAY-MULTI.
032400         10  SB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 0.319.
032500         10  SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.185.
032600         10  SB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 0.476.
032700         10  SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.459.
032800     05  PED-EXPAND-BUNDLE-PAY-MULTI.
032900*Expanded bundle payment multiplier (used for normal billing)
033000         10  EB-AGE-LT-13-PD-MODE   PIC 9(01)V9(03) VALUE 1.033.
033100         10  EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03) VALUE 1.219.
033200         10  EB-AGE-13-17-PD-MODE   PIC 9(01)V9(03) VALUE 1.067.
033300         10  EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03) VALUE 1.277.
033400
033500 01  ADULT-MULTIPLIERS.
033600*Separately billable payment multiplier (used for outliers)
033700     05  SEP-BILLABLE-PAYMANT-MULTI.
033800         10  SB-AGE-18-44           PIC 9(01)V9(03) VALUE 0.996.
033900         10  SB-AGE-45-59           PIC 9(01)V9(03) VALUE 0.992.
034000         10  SB-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
034100         10  SB-AGE-70-79           PIC 9(01)V9(03) VALUE 0.963.
034200         10  SB-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 0.915.
034300         10  SB-BSA                 PIC 9(01)V9(03) VALUE 1.014.
034400         10  SB-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.078.
034500         10  SB-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.450.
034600         10  SB-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.354.
034700         10  SB-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.422.
034800         10  SB-GI-BLEED            PIC 9(01)V9(03) VALUE 1.571.
034900         10  SB-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.225.
035000         10  SB-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.309.
035100         10  SB-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.074.
035200         10  SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 0.975.
035300*Case-Mix adjusted payment multiplier (used for normal billing)
035400     05  CASE-MIX-PAYMENT-MULTI.
035500         10  CM-AGE-18-44           PIC 9(01)V9(03) VALUE 1.171.
035600         10  CM-AGE-45-59           PIC 9(01)V9(03) VALUE 1.013.
035700         10  CM-AGE-60-69           PIC 9(01)V9(03) VALUE 1.000.
035800         10  CM-AGE-70-79           PIC 9(01)V9(03) VALUE 1.011.
035900         10  CM-AGE-80-PLUS         PIC 9(01)V9(03) VALUE 1.016.
036000         10  CM-BSA                 PIC 9(01)V9(03) VALUE 1.020.
036100         10  CM-BMI-LT-18-5         PIC 9(01)V9(03) VALUE 1.025.
036200         10  CM-ONSET-LE-120        PIC 9(01)V9(03) VALUE 1.510.
036300         10  CM-PERICARDITIS        PIC 9(01)V9(03) VALUE 1.114.
036400         10  CM-PNEUMONIA           PIC 9(01)V9(03) VALUE 1.135.
036500         10  CM-GI-BLEED            PIC 9(01)V9(03) VALUE 1.183.
036600         10  CM-SICKEL-CELL         PIC 9(01)V9(03) VALUE 1.072.
036700         10  CM-MYELODYSPLASTIC     PIC 9(01)V9(03) VALUE 1.099.
036800         10  CM-MONOCLONAL-GAMM     PIC 9(01)V9(03) VALUE 1.024.
036900         10  CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03) VALUE 1.189.
037000
037100 01  OUTLIER-SB-CALC-AMOUNTS.
037200     05  ADJ-AVG-MAP-AMT-LT-18      PIC 9(04)V9(02) VALUE 53.06.
037300     05  ADJ-AVG-MAP-AMT-GT-17      PIC 9(04)V9(02) VALUE 82.78.
037400     05  FIX-DOLLAR-LOSS-LT-18      PIC 9(04)V9(02) VALUE 195.02.
037500     05  FIX-DOLLAR-LOSS-GT-17      PIC 9(04)V9(02) VALUE 155.44.
037600     05  LOSS-SHARING-PCT-LT-18     PIC 9(03)V9(02) VALUE 0.80.
037700     05  LOSS-SHARING-PCT-GT-17     PIC 9(03)V9(02) VALUE 0.80.
037800/
037900******************************************************************
038000*    This area contains return code variables and their codes.   *
038100******************************************************************
038200 01 PAID-RETURN-CODE-TRACKERS.
038300     05  OUTLIER-TRACK              PIC X(01).
038400     05  ACUTE-COMORBID-TRACK       PIC X(01).
038500     05  CHRONIC-COMORBID-TRACK     PIC X(01).
038600     05  ONSET-TRACK                PIC X(01).
038700     05  LOW-VOLUME-TRACK           PIC X(01).
038800     05  TRAINING-TRACK             PIC X(01).
038900     05  PEDIATRIC-TRACK            PIC X(01).
039000     05  LOW-BMI-TRACK              PIC X(01).
039100 COPY RTCCPY.
039200*COPY "RTCCPY.CPY".
039300*                                                                *
039400*  Legal combinations of adjustments for ADULTS are:             *
039500*     if NO ONSET applies, then they can have any combination of:*
039600*       acute OR chronic comorbid, & outlier, low vol., training.*
039700*     if ONSET applies, then they can have:                      *
039800*           outlier and/or low volume.                           *
039900*  Legal combinations of adjustments for PEDIATRIC are:          *
040000*     outlier and/or training.                                   *
040100*                                                                *
040200*  Illegal combinations of adjustments for PEDIATRIC are:        *
040300*     pediatric with comorbid, onset, low volume, BSA, or BMI.   *
040400*     onset     with comorbid or training.                       *
040500*  Illegal combinations of adjustments for ANYONE are:           *
040600*     acute comorbid AND chronic comorbid.                       *
040700/
040800 LINKAGE SECTION.
040900 COPY BILLCPY.
041000*COPY "BILLCPY.CPY".
041100/
041200 COPY WAGECPY.
041300*COPY "WAGECPY.CPY".
041400/
041500 PROCEDURE DIVISION  USING BILL-NEW-DATA
041600                           PPS-DATA-ALL
041700                           WAGE-NEW-RATE-RECORD
041800                           COM-CBSA-WAGE-RECORD
041900                           BUN-CBSA-WAGE-RECORD.
042000
042100******************************************************************
042200* THERE ARE VARIOUS WAYS TO COMPUTE A FINAL DOLLAR AMOUNT.  THE  *
042300* METHOD USED IN THIS PROGRAM IS TO USE ROUNDED INTERMEDIATE     *
042400* VARIABLES.  THIS WAS DONE TO SIMPLIFY THE CALCULATIONS SO THAT *
042500* WHEN SOMETHING GOES AWRY, ONE IS NOT LEFT WONDERING WHERE IN   *
042600* A VAST COMPUTE STATEMENT, THINGS HAVE GONE AWRY.  THE METHOD   *
042700* UTILIZED HERE HAS BEEN APPROVED BY WIL GEHNE AND JOEY BRYSON   *
042800* BOTH OF WHOM WORK IN THE DIVISION OF INSTITUTIONAL CLAIMS      *
042900* PROCESSING (DICP).                                             *
043000*                                                                *
043100*                                                                *
043200*    PROCESSING:                                                 *
043300*        A. WILL PROCESS CLAIMS BASED ON AGE/HEIGHT/WEIGHT       *
043400*        B. INITIALIZE ESCAL HOLD VARIABLES.                     *
043500*        C. EDIT THE DATA PASSED FROM THE CLAIM BEFORE           *
043600*           ATTEMPTING TO CALCULATE PPS. IF THIS CLAIM           *
043700*           CANNOT BE PROCESSED, SET A RETURN CODE AND           *
043800*           GOBACK.                                              *
043900*        D. ASSEMBLE PRICING COMPONENTS.                         *
044000*        E. CALCULATE THE PRICE.                                 *
044100******************************************************************
044200
044300 0000-START-TO-FINISH.
044400     INITIALIZE PPS-DATA-ALL.
044500
044600     IF BUNDLED-TEST  THEN
044700        INITIALIZE BILL-DATA-TEST
044800        INITIALIZE COND-CD-73
044900     END-IF.
045000     MOVE CAL-VERSION                  TO PPS-CALC-VERS-CD.
045100     MOVE ZEROS                        TO PPS-RTC.
045200
045300     PERFORM 1000-VALIDATE-BILL-ELEMENTS.
045400
045500     IF PPS-RTC = 00  THEN
045600        PERFORM 1200-INITIALIZATION
045700**Calculate patient age
045800        COMPUTE H-PATIENT-AGE = B-THRU-CCYY - B-DOB-CCYY
045900        IF B-DOB-MM > B-THRU-MM  THEN
046000           COMPUTE H-PATIENT-AGE = H-PATIENT-AGE - 1
046100        END-IF
046200        IF H-PATIENT-AGE < 18  THEN
046300           MOVE "Y"                    TO PEDIATRIC-TRACK
046400        END-IF
046500        PERFORM 2000-CALCULATE-BUNDLED-FACTORS
046600        IF P-PROV-WAIVE-BLEND-PAY-INDIC = 'N'  THEN
046700           PERFORM 5000-CALC-COMP-RATE-FACTORS
046800        END-IF
046900        PERFORM 9000-SET-RETURN-CODE
047000        PERFORM 9100-MOVE-RESULTS
047100     END-IF.
047200
047300     GOBACK.
047400/
047500 1000-VALIDATE-BILL-ELEMENTS.
047600     IF P-PROV-TYPE = '40'  OR  '41' OR '05'  THEN
047700        NEXT SENTENCE
047800     ELSE
047900        MOVE 52                        TO PPS-RTC
048000     END-IF.
048100
048200     IF PPS-RTC = 00  THEN
048300        IF P-SPEC-PYMT-IND NOT = '1' AND ' '  THEN
048400           MOVE 53                     TO PPS-RTC
048500        END-IF
048600     END-IF.
048700
048800     IF PPS-RTC = 00  THEN
048900        IF (B-DOB-DATE = ZERO)  OR  (B-DOB-DATE NOT NUMERIC)  THEN
049000           MOVE 54                     TO PPS-RTC
049100        END-IF
049200     END-IF.
049300
049400     IF PPS-RTC = 00  THEN
049500        IF (B-PATIENT-WGT = 0)  OR  (B-PATIENT-WGT NOT NUMERIC)
049600           MOVE 55                     TO PPS-RTC
049700        END-IF
049800     END-IF.
049900
050000     IF PPS-RTC = 00  THEN
050100        IF (B-PATIENT-HGT = 0)  OR  (B-PATIENT-HGT NOT NUMERIC)
050200           MOVE 56                     TO PPS-RTC
050300        END-IF
050400     END-IF.
050500
050600     IF PPS-RTC = 00  THEN
050700        IF B-REV-CODE  = '0821' OR '0831' OR '0841' OR '0851'
050800                                OR '0881'
050900           NEXT SENTENCE
051000        ELSE
051100           MOVE 57                     TO PPS-RTC
051200        END-IF
051300     END-IF.
051400
051500     IF PPS-RTC = 00  THEN
051600        IF B-COND-CODE NOT = '73' AND '74' AND '  '
051700           MOVE 58                     TO PPS-RTC
051800        END-IF
051900     END-IF.
052000
052100     IF PPS-RTC = 00  THEN
052200        IF B-PATIENT-HGT > 300.00
052300           MOVE 71                     TO PPS-RTC
052400        END-IF
052500     END-IF.
052600
052700     IF PPS-RTC = 00  THEN
052800        IF B-PATIENT-WGT > 500.00  THEN
052900           MOVE 72                     TO PPS-RTC
053000        END-IF
053100     END-IF.
053200
053300* Before 2012 pricer, put in edit check to make sure that the
053400* # of sesions does not exceed the # of days in a month.  Maybe
053500* the # of cays in a month minus one when patient goes into a
053600* dialysis center for dialysis (i.e. CC = 74 and rev-cd = (0841
053700* or 0851)).  If done, then will need extra RTC.
053800     IF PPS-RTC = 00  THEN
053900        IF (B-CLAIM-NUM-DIALYSIS-SESSIONS = ZERO) OR
054000           (B-CLAIM-NUM-DIALYSIS-SESSIONS NOT NUMERIC)  THEN
054100           MOVE 73                     TO PPS-RTC
054200        END-IF
054300     END-IF.
054400
054500     IF PPS-RTC = 00  THEN
054600        IF (B-LINE-ITEM-DATE-SERVICE = ZERO) OR
054700           (B-LINE-ITEM-DATE-SERVICE NOT NUMERIC)  THEN
054800           MOVE 74                     TO PPS-RTC
054900        END-IF
055000     END-IF.
055100
055200     IF PPS-RTC = 00  THEN
055300        IF (B-DIALYSIS-START-DATE NOT NUMERIC)  THEN
055400           MOVE 75                     TO PPS-RTC
055500        END-IF
055600     END-IF.
055700
055800     IF PPS-RTC = 00  THEN
055900        IF (B-TOT-PRICE-SB-OUTLIER NOT NUMERIC) THEN
056000           MOVE 76                     TO PPS-RTC
056100        END-IF
056200     END-IF.
056300
056400     IF PPS-RTC = 00  THEN
056500        IF (COMORBID-CWF-RETURN-CODE = SPACES) OR
056600            VALID-COMORBID-CWF-RETURN-CD       THEN
056700           NEXT SENTENCE
056800        ELSE
056900           MOVE 81                     TO PPS-RTC
057000        END-IF
057100     END-IF.
057200/
057300 1200-INITIALIZATION.
057400     INITIALIZE HOLD-COMP-RATE-PPS-COMPONENTS.
057500     INITIALIZE HOLD-BUNDLED-PPS-COMPONENTS.
057600     INITIALIZE HOLD-OUTLIER-PPS-COMPONENTS.
057700     INITIALIZE PAID-RETURN-CODE-TRACKERS.
057800
057900     MOVE SPACES                       TO MOVED-CORMORBIDS.
058000
058100*    Since pricer has to pay a comorbid condition according to the
058200* return code that CWF passes back, it is cleaner if the pricer
058300* sets aside whatever comorbid data exists on the line-item when
058400* it comes into the pricer and then transferrs the CWF code to
058500* the appropriate place in the comorbid data.  This avoids
058600* making convoluted changes in the other parts of the program
058700* which has to look at both original comorbid data AND CWF return
058800* codes to handle comorbids.  Near the end of the program where
058900* variables are transferred to the output, the original comorbid
059000* data is put back into its original place as though nothing
059100* occurred.
059200     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
059300        NEXT SENTENCE
059400     ELSE
059500        MOVE 'Y'                       TO MOVED-CORMORBIDS
059600        MOVE COMORBID-DATA (1)         TO H-COMORBID-DATA (1)
059700        MOVE COMORBID-DATA (2)         TO H-COMORBID-DATA (2)
059800        MOVE COMORBID-DATA (3)         TO H-COMORBID-DATA (3)
059900        MOVE COMORBID-DATA (4)         TO H-COMORBID-DATA (4)
060000        MOVE COMORBID-DATA (5)         TO H-COMORBID-DATA (5)
060100        MOVE COMORBID-DATA (6)         TO H-COMORBID-DATA (6)
060200        MOVE COMORBID-CWF-RETURN-CODE  TO H-COMORBID-CWF-CODE
060300        IF COMORBID-CWF-RETURN-CODE = '10'  THEN
060400           MOVE SPACES                 TO COMORBID-DATA (1)
060500                                          COMORBID-DATA (2)
060600                                          COMORBID-DATA (3)
060700                                          COMORBID-DATA (4)
060800                                          COMORBID-DATA (5)
060900                                          COMORBID-DATA (6)
061000                                          COMORBID-CWF-RETURN-CODE
061100        ELSE
061200           IF COMORBID-CWF-RETURN-CODE = '20'  THEN
061300              MOVE 'MA'                TO COMORBID-DATA (1)
061400              MOVE SPACES              TO COMORBID-DATA (2)
061500                                          COMORBID-DATA (3)
061600                                          COMORBID-DATA (4)
061700                                          COMORBID-DATA (5)
061800                                          COMORBID-DATA (6)
061900                                          COMORBID-CWF-RETURN-CODE
062000           ELSE
062100              IF COMORBID-CWF-RETURN-CODE = '30'  THEN
062200                 MOVE SPACES           TO COMORBID-DATA (1)
062300                 MOVE 'MB'             TO COMORBID-DATA (2)
062400                 MOVE SPACES           TO COMORBID-DATA (3)
062500                 MOVE SPACES           TO COMORBID-DATA (4)
062600                 MOVE SPACES           TO COMORBID-DATA (5)
062700                 MOVE SPACES           TO COMORBID-DATA (6)
062800                                          COMORBID-CWF-RETURN-CODE
062900              ELSE
063000                 IF COMORBID-CWF-RETURN-CODE = '40'  THEN
063100                    MOVE SPACES        TO COMORBID-DATA (1)
063200                    MOVE SPACES        TO COMORBID-DATA (2)
063300                    MOVE 'MC'          TO COMORBID-DATA (3)
063400                    MOVE SPACES        TO COMORBID-DATA (4)
063500                    MOVE SPACES        TO COMORBID-DATA (5)
063600                    MOVE SPACES        TO COMORBID-DATA (6)
063700                                          COMORBID-CWF-RETURN-CODE
063800                 ELSE
063900                    IF COMORBID-CWF-RETURN-CODE = '50'  THEN
064000                       MOVE SPACES     TO COMORBID-DATA (1)
064100                       MOVE SPACES     TO COMORBID-DATA (2)
064200                       MOVE SPACES     TO COMORBID-DATA (3)
064300                       MOVE 'MD'       TO COMORBID-DATA (4)
064400                       MOVE SPACES     TO COMORBID-DATA (5)
064500                       MOVE SPACES     TO COMORBID-DATA (6)
064600                                          COMORBID-CWF-RETURN-CODE
064700                    ELSE
064800                       IF COMORBID-CWF-RETURN-CODE = '60'  THEN
064900                          MOVE SPACES  TO COMORBID-DATA (1)
065000                          MOVE SPACES  TO COMORBID-DATA (2)
065100                          MOVE SPACES  TO COMORBID-DATA (3)
065200                          MOVE SPACES  TO COMORBID-DATA (4)
065300                          MOVE 'ME'    TO COMORBID-DATA (5)
065400                          MOVE SPACES  TO COMORBID-DATA (6)
065500                                          COMORBID-CWF-RETURN-CODE
065600                       ELSE
065700                          MOVE SPACES  TO COMORBID-DATA (1)
065800                                          COMORBID-DATA (2)
065900                                          COMORBID-DATA (3)
066000                                          COMORBID-DATA (4)
066100                                          COMORBID-DATA (5)
066200                                          COMORBID-CWF-RETURN-CODE
066300                          MOVE 'MF'    TO COMORBID-DATA (6)
066400                       END-IF
066500                    END-IF
066600                 END-IF
066700              END-IF
066800           END-IF
066900        END-IF
067000     END-IF.
067100
067200******************************************************************
067300***Calculate BUNDLED Wage Adjusted Rate (note different method)***
067400******************************************************************
067500     COMPUTE H-BUN-NAT-LABOR-AMT ROUNDED =
067600        (BUNDLED-BASE-PMT-RATE * BUN-NAT-LABOR-PCT) *
067700         BUN-CBSA-W-INDEX.
067800
067900     COMPUTE H-BUN-NAT-NONLABOR-AMT ROUNDED =
068000        BUNDLED-BASE-PMT-RATE * BUN-NAT-NONLABOR-PCT
068100
068200     COMPUTE H-BUN-BASE-WAGE-AMT ROUNDED =
068300        H-BUN-NAT-LABOR-AMT + H-BUN-NAT-NONLABOR-AMT.
068400/
068500 2000-CALCULATE-BUNDLED-FACTORS.
068600******************************************************************
068700***  Set BUNDLED age adjustment factor                         ***
068800******************************************************************
068900     IF H-PATIENT-AGE < 13  THEN
069000        IF B-REV-CODE = '0821' OR '0881' THEN
069100           MOVE EB-AGE-LT-13-HEMO-MODE TO H-BUN-AGE-FACTOR
069200        ELSE
069300           MOVE EB-AGE-LT-13-PD-MODE   TO H-BUN-AGE-FACTOR
069400        END-IF
069500     ELSE
069600        IF H-PATIENT-AGE < 18 THEN
069700           IF B-REV-CODE = '0821' OR '0881' THEN
069800              MOVE EB-AGE-13-17-HEMO-MODE
069900                                       TO H-BUN-AGE-FACTOR
070000           ELSE
070100              MOVE EB-AGE-13-17-PD-MODE
070200                                       TO H-BUN-AGE-FACTOR
070300           END-IF
070400        ELSE
070500           IF H-PATIENT-AGE < 45  THEN
070600              MOVE CM-AGE-18-44        TO H-BUN-AGE-FACTOR
070700           ELSE
070800              IF H-PATIENT-AGE < 60  THEN
070900                 MOVE CM-AGE-45-59     TO H-BUN-AGE-FACTOR
071000              ELSE
071100                 IF H-PATIENT-AGE < 70  THEN
071200                    MOVE CM-AGE-60-69  TO H-BUN-AGE-FACTOR
071300                 ELSE
071400                    IF H-PATIENT-AGE < 80  THEN
071500                       MOVE CM-AGE-70-79
071600                                       TO H-BUN-AGE-FACTOR
071700                    ELSE
071800                       MOVE CM-AGE-80-PLUS
071900                                       TO H-BUN-AGE-FACTOR
072000                    END-IF
072100                 END-IF
072200              END-IF
072300           END-IF
072400        END-IF
072500     END-IF.
072600
072700******************************************************************
072800***  Calculate BUNDLED BSA factor (note NEW formula)           ***
072900******************************************************************
073000     COMPUTE H-BUN-BSA  ROUNDED = (.007184 *
073100         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
073200
073300     IF H-PATIENT-AGE > 17  THEN
073400        COMPUTE H-BUN-BSA-FACTOR  ROUNDED =
073500             CM-BSA ** ((H-BUN-BSA - 1.87) / .1)
073600     ELSE
073700        MOVE 1.000                     TO H-BUN-BSA-FACTOR
073800     END-IF.
073900
074000******************************************************************
074100***  Calculate BUNDLED BMI factor                              ***
074200******************************************************************
074300     COMPUTE H-BUN-BMI  ROUNDED = (B-PATIENT-WGT /
074400         (B-PATIENT-HGT ** 2)) * 10000.
074500
074600     IF (H-PATIENT-AGE > 17) AND (H-BUN-BMI < 18.5)  THEN
074700        MOVE CM-BMI-LT-18-5            TO H-BUN-BMI-FACTOR
074800        MOVE "Y"                       TO LOW-BMI-TRACK
074900     ELSE
075000        MOVE 1.000                     TO H-BUN-BMI-FACTOR
075100     END-IF.
075200
075300******************************************************************
075400***  Calculate BUNDLED ONSET factor                            ***
075500******************************************************************
075600     IF B-DIALYSIS-START-DATE > ZERO  THEN
075700        MOVE B-LINE-ITEM-DATE-SERVICE  TO THE-DATE
075800        COMPUTE INTEGER-LINE-ITEM-DATE =
075900            FUNCTION INTEGER-OF-DATE(THE-DATE)
076000        MOVE B-DIALYSIS-START-DATE     TO THE-DATE
076100        COMPUTE INTEGER-DIALYSIS-DATE  =
076200            FUNCTION INTEGER-OF-DATE(THE-DATE)
076300        COMPUTE ONSET-DATE = (INTEGER-LINE-ITEM-DATE -
076400                              INTEGER-DIALYSIS-DATE) + 1
076500        IF H-PATIENT-AGE > 17  THEN
076600           IF ONSET-DATE > 120  THEN
076700              MOVE 1                   TO H-BUN-ONSET-FACTOR
076800           ELSE
076900              MOVE CM-ONSET-LE-120     TO H-BUN-ONSET-FACTOR
077000              MOVE "Y"                 TO ONSET-TRACK
077100           END-IF
077200        ELSE
077300           MOVE 1                      TO H-BUN-ONSET-FACTOR
077400        END-IF
077500     ELSE
077600        MOVE 1.000                     TO H-BUN-ONSET-FACTOR
077700     END-IF.
077800
077900******************************************************************
078000***  Set BUNDLED Co-morbidities adjustment                     ***
078100******************************************************************
078200     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
078300        IF H-PATIENT-AGE  <  18  THEN
078400           MOVE 1.000                  TO
078500                                       H-BUN-COMORBID-MULTIPLIER
078600           MOVE '10'                   TO PPS-2011-COMORBID-PAY
078700        ELSE
078800           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
078900              MOVE 1.000               TO
079000                                       H-BUN-COMORBID-MULTIPLIER
079100              MOVE '10'                TO PPS-2011-COMORBID-PAY
079200           ELSE
079300              PERFORM 2100-CALC-COMORBID-ADJUST
079400              MOVE H-COMORBID-MULTIPLIER TO
079500                                       H-BUN-COMORBID-MULTIPLIER
079600           END-IF
079700        END-IF
079800     ELSE
079900        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
080000           MOVE 1.000                  TO
080100                                       H-BUN-COMORBID-MULTIPLIER
080200           MOVE '10'                   TO PPS-2011-COMORBID-PAY
080300        ELSE
080400           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
080500              MOVE CM-GI-BLEED         TO
080600                                       H-BUN-COMORBID-MULTIPLIER
080700              MOVE '20'                TO PPS-2011-COMORBID-PAY
080800           ELSE
080900              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
081000                 MOVE CM-PNEUMONIA     TO
081100                                       H-BUN-COMORBID-MULTIPLIER
081200                 MOVE '30'             TO PPS-2011-COMORBID-PAY
081300              ELSE
081400                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
081500                    MOVE CM-PERICARDITIS TO
081600                                       H-BUN-COMORBID-MULTIPLIER
081700                    MOVE '40'          TO PPS-2011-COMORBID-PAY
081800                 END-IF
081900              END-IF
082000           END-IF
082100        END-IF
082200     END-IF.
082300
082400******************************************************************
082500***  Calculate BUNDLED Low Volume adjustment                   ***
082600******************************************************************
082700     IF P-PROV-LOW-VOLUME-INDIC = 'Y'  THEN
082800        IF H-PATIENT-AGE > 17  THEN
082900           MOVE CM-LOW-VOL-ADJ-LT-4000 TO
083000                                       H-BUN-LOW-VOL-MULTIPLIER
083100           MOVE "Y"                    TO  LOW-VOLUME-TRACK
083200        ELSE
083300           MOVE 1.000                  TO
083400                                       H-BUN-LOW-VOL-MULTIPLIER
083500        END-IF
083600     ELSE
083700        MOVE 1.000                     TO
083800                                       H-BUN-LOW-VOL-MULTIPLIER
083900     END-IF.
084000
084100
084200******************************************************************
084300***  Calculate BUNDLED Adjusted PPS Base Rate                  ***
084400******************************************************************
084500     COMPUTE H-BUN-ADJUSTED-BASE-WAGE-AMT  ROUNDED  =
084600        (H-BUN-BASE-WAGE-AMT * H-BUN-AGE-FACTOR)    *
084700        (H-BUN-BSA-FACTOR    * H-BUN-BMI-FACTOR)    *
084800        (H-BUN-ONSET-FACTOR  * H-BUN-COMORBID-MULTIPLIER) *
084900        (H-BUN-LOW-VOL-MULTIPLIER).
085000
085100
085200******************************************************************
085300***  Calculate BUNDLED Condition Code payment                  ***
085400******************************************************************
085500* Self-care in Training add-on
085600     IF B-COND-CODE = '73'  THEN
085700* no add-on when onset is present
085800        IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
085900           MOVE ZERO                   TO
086000                                    H-BUN-WAGE-ADJ-TRAINING-AMT
086100        ELSE
086200* use new PPS training add-on amount times wage-index
086300           COMPUTE H-BUN-WAGE-ADJ-TRAINING-AMT  ROUNDED  =
086400             TRAINING-ADD-ON-PMT-AMT * BUN-CBSA-W-INDEX
086500           MOVE "Y"                    TO TRAINING-TRACK
086600        END-IF
086700     ELSE
086800* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
086900        IF (B-COND-CODE = '74')  AND
087000           (B-REV-CODE = '0841' OR '0851')  THEN
087100              COMPUTE H-CC-74-PER-DIEM-AMT  ROUNDED =
087200                 (H-BUN-ADJUSTED-BASE-WAGE-AMT * 3) / 7
087300        ELSE
087400           MOVE ZERO                   TO
087500                                    H-BUN-WAGE-ADJ-TRAINING-AMT
087600                                    H-CC-74-PER-DIEM-AMT
087700        END-IF
087800     END-IF.
087900
088000******************************************************************
088100***  Calculate BUNDLED Outlier                                 ***
088200******************************************************************
088300     PERFORM 2500-CALC-OUTLIER-FACTORS.
088400
088500******************************************************************
088600***  Calculate BUNDLED ESRD PPS Final Payment Rate             ***
088700******************************************************************
088800
088900     IF (B-COND-CODE = '74')  AND
089000        (B-REV-CODE = '0841' OR '0851')  THEN
089100           COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
089200                           H-CC-74-PER-DIEM-AMT
089300           COMPUTE H-FULL-CLAIM-AMT  ROUNDED  =
089400              (H-BUN-ADJUSTED-BASE-WAGE-AMT *
089500              ((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
089600     ELSE
089700        COMPUTE H-PPS-FINAL-PAY-AMT  ROUNDED  =
089800                H-BUN-ADJUSTED-BASE-WAGE-AMT  +
089900                H-BUN-WAGE-ADJ-TRAINING-AMT
090000     END-IF.
090100
090200/
090300 2100-CALC-COMORBID-ADJUST.
090400******************************************************************
090500***  Calculate Co-morbidities adjustment                       ***
090600******************************************************************
090700*  This logic assumes that the comorbids are randomly assigned   *
090800*to the comorbid table.  It will select the highest comorbid for *
090900*payment if one is found.                                        *
091000******************************************************************
091100     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
091200     MOVE 1.000                        TO H-COMORBID-MULTIPLIER.
091300     MOVE '10'                         TO PPS-2011-COMORBID-PAY.
091400
091500     PERFORM VARYING  SUB  FROM  1 BY 1
091600       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
091700         IF COMORBID-DATA (SUB) = 'MA'  THEN
091800           MOVE CM-GI-BLEED            TO H-COMORBID-MULTIPLIER
091900           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
092000           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
092100           MOVE '20'                   TO PPS-2011-COMORBID-PAY
092200         ELSE
092300           IF COMORBID-DATA (SUB) = 'MB'  THEN
092400             IF CM-PNEUMONIA  >  H-COMORBID-MULTIPLIER  THEN
092500               MOVE CM-PNEUMONIA       TO H-COMORBID-MULTIPLIER
092600               MOVE "Y"                TO ACUTE-COMORBID-TRACK
092700               MOVE '30'               TO PPS-2011-COMORBID-PAY
092800             END-IF
092900           ELSE
093000             IF COMORBID-DATA (SUB) = 'MC'  THEN
093100                IF CM-PERICARDITIS  >
093200                                      H-COMORBID-MULTIPLIER  THEN
093300                  MOVE CM-PERICARDITIS TO H-COMORBID-MULTIPLIER
093400                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
093500                  MOVE '40'            TO PPS-2011-COMORBID-PAY
093600                END-IF
093700             ELSE
093800               IF COMORBID-DATA (SUB) = 'MD'  THEN
093900                 IF CM-MYELODYSPLASTIC  >
094000                                      H-COMORBID-MULTIPLIER  THEN
094100                   MOVE CM-MYELODYSPLASTIC  TO
094200                                      H-COMORBID-MULTIPLIER
094300                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
094400                   MOVE '50'           TO PPS-2011-COMORBID-PAY
094500                 END-IF
094600               ELSE
094700                 IF COMORBID-DATA (SUB) = 'ME'  THEN
094800                   IF CM-SICKEL-CELL  >
094900                                      H-COMORBID-MULTIPLIER  THEN
095000                     MOVE CM-SICKEL-CELL  TO
095100                                      H-COMORBID-MULTIPLIER
095200                     MOVE "Y"          TO CHRONIC-COMORBID-TRACK
095300                     MOVE '60'         TO PPS-2011-COMORBID-PAY
095400                   END-IF
095500                 ELSE
095600                   IF COMORBID-DATA (SUB) = 'MF'  THEN
095700                     IF CM-MONOCLONAL-GAMM  >
095800                                      H-COMORBID-MULTIPLIER  THEN
095900                       MOVE CM-MONOCLONAL-GAMM TO
096000                                      H-COMORBID-MULTIPLIER
096100                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
096200                       MOVE '70'       TO PPS-2011-COMORBID-PAY
096300                     END-IF
096400                   END-IF
096500                 END-IF
096600               END-IF
096700             END-IF
096800           END-IF
096900         END-IF
097000     END-PERFORM.
097100/
097200 2500-CALC-OUTLIER-FACTORS.
097300******************************************************************
097400***  Set separately billable OUTLIER age adjustment factor     ***
097500******************************************************************
097600     IF H-PATIENT-AGE < 13  THEN
097700        IF B-REV-CODE = '0821' OR '0881'  THEN
097800           MOVE SB-AGE-LT-13-HEMO-MODE TO H-OUT-AGE-FACTOR
097900        ELSE
098000           MOVE SB-AGE-LT-13-PD-MODE   TO H-OUT-AGE-FACTOR
098100        END-IF
098200     ELSE
098300        IF H-PATIENT-AGE < 18 THEN
098400           IF B-REV-CODE = '0821' OR '0881'  THEN
098500              MOVE SB-AGE-13-17-HEMO-MODE
098600                                       TO H-OUT-AGE-FACTOR
098700           ELSE
098800              MOVE SB-AGE-13-17-PD-MODE
098900                                       TO H-OUT-AGE-FACTOR
099000           END-IF
099100        ELSE
099200           IF H-PATIENT-AGE < 45  THEN
099300              MOVE SB-AGE-18-44        TO H-OUT-AGE-FACTOR
099400           ELSE
099500              IF H-PATIENT-AGE < 60  THEN
099600                 MOVE SB-AGE-45-59     TO H-OUT-AGE-FACTOR
099700              ELSE
099800                 IF H-PATIENT-AGE < 70  THEN
099900                    MOVE SB-AGE-60-69  TO H-OUT-AGE-FACTOR
100000                 ELSE
100100                    IF H-PATIENT-AGE < 80  THEN
100200                       MOVE SB-AGE-70-79
100300                                       TO H-OUT-AGE-FACTOR
100400                    ELSE
100500                       MOVE SB-AGE-80-PLUS
100600                                       TO H-OUT-AGE-FACTOR
100700                    END-IF
100800                 END-IF
100900              END-IF
101000           END-IF
101100        END-IF
101200     END-IF.
101300
101400******************************************************************
101500**Calculate separately billable OUTLIER BSA factor (superscript)**
101600******************************************************************
101700     COMPUTE H-OUT-BSA  ROUNDED = (.007184 *
101800         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
101900
102000     IF H-PATIENT-AGE > 17  THEN
102100        COMPUTE H-OUT-BSA-FACTOR  ROUNDED =
102200             SB-BSA ** ((H-OUT-BSA - 1.87) / .1)
102300     ELSE
102400        MOVE 1.000                     TO H-OUT-BSA-FACTOR
102500     END-IF.
102600
102700******************************************************************
102800***  Calculate separately billable OUTLIER BMI factor          ***
102900******************************************************************
103000     COMPUTE H-OUT-BMI  ROUNDED = (B-PATIENT-WGT /
103100         (B-PATIENT-HGT ** 2)) * 10000.
103200
103300     IF (H-PATIENT-AGE > 17) AND (H-OUT-BMI < 18.5)  THEN
103400        MOVE SB-BMI-LT-18-5            TO H-OUT-BMI-FACTOR
103500     ELSE
103600        MOVE 1.000                     TO H-OUT-BMI-FACTOR
103700     END-IF.
103800
103900******************************************************************
104000***  Calculate separately billable OUTLIER ONSET factor        ***
104100******************************************************************
104200     IF B-DIALYSIS-START-DATE > ZERO  THEN
104300        IF H-PATIENT-AGE > 17  THEN
104400           IF ONSET-DATE > 120  THEN
104500              MOVE 1                   TO H-OUT-ONSET-FACTOR
104600           ELSE
104700              MOVE SB-ONSET-LE-120     TO H-OUT-ONSET-FACTOR
104800           END-IF
104900        ELSE
105000           MOVE 1                      TO H-OUT-ONSET-FACTOR
105100        END-IF
105200     ELSE
105300        MOVE 1.000                     TO H-OUT-ONSET-FACTOR
105400     END-IF.
105500
105600******************************************************************
105700***  Set separately billable OUTLIER Co-morbidities adjustment ***
105800******************************************************************
105900     IF COMORBID-CWF-RETURN-CODE = SPACES  THEN
106000        IF H-PATIENT-AGE  <  18  THEN
106100           MOVE 1.000                  TO
106200                                       H-OUT-COMORBID-MULTIPLIER
106300           MOVE '10'                   TO PPS-2011-COMORBID-PAY
106400        ELSE
106500           IF H-BUN-ONSET-FACTOR  =  CM-ONSET-LE-120  THEN
106600              MOVE 1.000               TO
106700                                       H-OUT-COMORBID-MULTIPLIER
106800              MOVE '10'                TO PPS-2011-COMORBID-PAY
106900           ELSE
107000              PERFORM 2600-CALC-COMORBID-OUT-ADJUST
107100           END-IF
107200        END-IF
107300     ELSE
107400        IF COMORBID-CWF-RETURN-CODE  =  '10'  THEN
107500           MOVE 1.000                  TO
107600                                       H-OUT-COMORBID-MULTIPLIER
107700        ELSE
107800           IF COMORBID-CWF-RETURN-CODE  =  '20'  THEN
107900              MOVE SB-GI-BLEED         TO
108000                                       H-OUT-COMORBID-MULTIPLIER
108100           ELSE
108200              IF COMORBID-CWF-RETURN-CODE  =  '30'  THEN
108300                 MOVE SB-PNEUMONIA     TO
108400                                       H-OUT-COMORBID-MULTIPLIER
108500              ELSE
108600                 IF COMORBID-CWF-RETURN-CODE  =  '40'  THEN
108700                    MOVE SB-PERICARDITIS TO
108800                                       H-OUT-COMORBID-MULTIPLIER
108900                 END-IF
109000              END-IF
109100           END-IF
109200        END-IF
109300     END-IF.
109400
109500******************************************************************
109600***  Set OUTLIER low-volume-multiplier                         ***
109700******************************************************************
109800     IF P-PROV-LOW-VOLUME-INDIC = "N"  THEN
109900        MOVE 1                         TO H-OUT-LOW-VOL-MULTIPLIER
110000     ELSE
110100        IF H-PATIENT-AGE < 18  THEN
110200           MOVE 1                      TO H-OUT-LOW-VOL-MULTIPLIER
110300        ELSE
110400           MOVE SB-LOW-VOL-ADJ-LT-4000 TO H-OUT-LOW-VOL-MULTIPLIER
110500           MOVE "Y"                    TO LOW-VOLUME-TRACK
110600        END-IF
110700     END-IF.
110800
110900******************************************************************
111000***  Calculate predicted OUTLIER services MAP per treatment    ***
111100******************************************************************
111200     COMPUTE H-OUT-PREDICTED-SERVICES-MAP  ROUNDED =
111300        (H-OUT-AGE-FACTOR             *
111400         H-OUT-BSA-FACTOR             *
111500         H-OUT-BMI-FACTOR             *
111600         H-OUT-ONSET-FACTOR           *
111700         H-OUT-COMORBID-MULTIPLIER    *
111800         H-OUT-LOW-VOL-MULTIPLIER).
111900
112000******************************************************************
112100***  Calculate case mix adjusted predicted OUTLIER serv MAP/trt***
112200******************************************************************
112300     IF H-PATIENT-AGE < 18  THEN
112400        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
112500           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-LT-18)
112600        MOVE ADJ-AVG-MAP-AMT-LT-18     TO  H-OUT-ADJ-AVG-MAP-AMT
112700     ELSE
112800
112900        COMPUTE H-OUT-CM-ADJ-PREDICT-MAP-TRT  ROUNDED  =
113000           (H-OUT-PREDICTED-SERVICES-MAP * ADJ-AVG-MAP-AMT-GT-17)
113100        MOVE ADJ-AVG-MAP-AMT-GT-17     TO  H-OUT-ADJ-AVG-MAP-AMT
113200     END-IF.
113300
113400******************************************************************
113500*** Calculate imputed OUTLIER services MAP amount per treatment***
113600******************************************************************
113700     IF (B-COND-CODE = '74')  AND
113800        (B-REV-CODE = '0841' OR '0851')  THEN
113900         COMPUTE H-HEMO-EQUIV-DIAL-SESSIONS  ROUNDED  =
114000            ((B-CLAIM-NUM-DIALYSIS-SESSIONS * 3) / 7)
114100         COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
114200         (B-TOT-PRICE-SB-OUTLIER / H-HEMO-EQUIV-DIAL-SESSIONS)
114300     ELSE
114400        COMPUTE H-OUT-IMPUTED-MAP  ROUNDED =
114500        (B-TOT-PRICE-SB-OUTLIER / B-CLAIM-NUM-DIALYSIS-SESSIONS)
114600     END-IF.
114700
114800******************************************************************
114900*** Comparison of predicted to the imputed OUTLIER svc MAP/trt ***
115000******************************************************************
115100     IF H-PATIENT-AGE < 18   THEN
115200        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED  =
115300           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-LT-18
115400        MOVE FIX-DOLLAR-LOSS-LT-18     TO H-OUT-FIX-DOLLAR-LOSS
115500        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
115600           COMPUTE H-OUT-PAYMENT  ROUNDED  =
115700            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
115800                                         LOSS-SHARING-PCT-LT-18
115900           MOVE LOSS-SHARING-PCT-LT-18 TO H-OUT-LOSS-SHARING-PCT
116000           MOVE "Y"                    TO OUTLIER-TRACK
116100        ELSE
116200           MOVE ZERO                   TO H-OUT-PAYMENT
116300           MOVE ZERO                   TO H-OUT-LOSS-SHARING-PCT
116400        END-IF
116500     ELSE
116600        COMPUTE H-OUT-PREDICTED-MAP  ROUNDED =
116700           H-OUT-CM-ADJ-PREDICT-MAP-TRT + FIX-DOLLAR-LOSS-GT-17
116800           MOVE FIX-DOLLAR-LOSS-GT-17  TO H-OUT-FIX-DOLLAR-LOSS
116900        IF H-OUT-IMPUTED-MAP  >  H-OUT-PREDICTED-MAP  THEN
117000           COMPUTE H-OUT-PAYMENT  ROUNDED  =
117100            (H-OUT-IMPUTED-MAP  -  H-OUT-PREDICTED-MAP)  *
117200                                         LOSS-SHARING-PCT-GT-17
117300           MOVE LOSS-SHARING-PCT-GT-17 TO H-OUT-LOSS-SHARING-PCT
117400           MOVE "Y"                    TO OUTLIER-TRACK
117500        ELSE
117600           MOVE ZERO                   TO H-OUT-PAYMENT
117700        END-IF
117800     END-IF.
117900
118000     MOVE H-OUT-PAYMENT                TO OUT-NON-PER-DIEM-PAYMENT
118100
118200* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
118300     IF (B-COND-CODE = '74')  AND
118400        (B-REV-CODE = '0841' OR '0851')  THEN
118500           COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT *
118600             (((B-CLAIM-NUM-DIALYSIS-SESSIONS) * 3) / 7)
118700     END-IF.
118800/
118900 2600-CALC-COMORBID-OUT-ADJUST.
119000******************************************************************
119100***  Calculate OUTLIER Co-morbidities adjustment               ***
119200******************************************************************
119300*  This logic assumes that the comorbids are randomly assigned   *
119400*to the comorbid table.  It will select the highest comorbid for *
119500*payment if one is found.                                        *
119600******************************************************************
119700
119800     MOVE 'N'                          TO IS-HIGH-COMORBID-FOUND.
119900     MOVE 1.000                        TO
120000                                  H-OUT-COMORBID-MULTIPLIER.
120100
120200     PERFORM VARYING  SUB  FROM  1 BY 1
120300       UNTIL SUB   >  6   OR   HIGH-COMORBID-FOUND
120400         IF COMORBID-DATA (SUB) = 'MA'  THEN
120500           MOVE SB-GI-BLEED            TO
120600                                  H-OUT-COMORBID-MULTIPLIER
120700           MOVE "Y"                    TO IS-HIGH-COMORBID-FOUND
120800           MOVE "Y"                    TO ACUTE-COMORBID-TRACK
120900         ELSE
121000           IF COMORBID-DATA (SUB) = 'MB'  THEN
121100             IF SB-PNEUMONIA  >  H-OUT-COMORBID-MULTIPLIER  THEN
121200               MOVE SB-PNEUMONIA       TO
121300                                  H-OUT-COMORBID-MULTIPLIER
121400               MOVE "Y"                TO ACUTE-COMORBID-TRACK
121500             END-IF
121600           ELSE
121700             IF COMORBID-DATA (SUB) = 'MC'  THEN
121800                IF SB-PERICARDITIS  >
121900                                  H-OUT-COMORBID-MULTIPLIER  THEN
122000                  MOVE SB-PERICARDITIS TO
122100                                  H-OUT-COMORBID-MULTIPLIER
122200                  MOVE "Y"             TO ACUTE-COMORBID-TRACK
122300                END-IF
122400             ELSE
122500               IF COMORBID-DATA (SUB) = 'MD'  THEN
122600                 IF SB-MYELODYSPLASTIC  >
122700                                  H-OUT-COMORBID-MULTIPLIER  THEN
122800                   MOVE SB-MYELODYSPLASTIC  TO
122900                                  H-OUT-COMORBID-MULTIPLIER
123000                   MOVE "Y"            TO CHRONIC-COMORBID-TRACK
123100                 END-IF
123200               ELSE
123300                 IF COMORBID-DATA (SUB) = 'ME'  THEN
123400                   IF SB-SICKEL-CELL  >
123500                                  H-OUT-COMORBID-MULTIPLIER  THEN
123600                     MOVE SB-SICKEL-CELL  TO
123700                                  H-OUT-COMORBID-MULTIPLIER
123800                      MOVE "Y"          TO CHRONIC-COMORBID-TRACK
123900                   END-IF
124000                 ELSE
124100                   IF COMORBID-DATA (SUB) = 'MF'  THEN
124200                     IF SB-MONOCLONAL-GAMM  >
124300                                  H-OUT-COMORBID-MULTIPLIER  THEN
124400                       MOVE SB-MONOCLONAL-GAMM  TO
124500                                  H-OUT-COMORBID-MULTIPLIER
124600                       MOVE "Y"        TO CHRONIC-COMORBID-TRACK
124700                     END-IF
124800                   END-IF
124900                 END-IF
125000               END-IF
125100             END-IF
125200           END-IF
125300         END-IF
125400     END-PERFORM.
125500/
125600 5000-CALC-COMP-RATE-FACTORS.
125700******************************************************************
125800***  Set Composite Rate age adjustment factor                  ***
125900******************************************************************
126000     IF H-PATIENT-AGE < 18  THEN
126100        MOVE CR-AGE-LT-18              TO H-AGE-FACTOR
126200     ELSE
126300        IF H-PATIENT-AGE < 45  THEN
126400           MOVE CR-AGE-18-44           TO H-AGE-FACTOR
126500        ELSE
126600           IF H-PATIENT-AGE < 60  THEN
126700              MOVE CR-AGE-45-59        TO H-AGE-FACTOR
126800           ELSE
126900              IF H-PATIENT-AGE < 70  THEN
127000                 MOVE CR-AGE-60-69     TO H-AGE-FACTOR
127100              ELSE
127200                 IF H-PATIENT-AGE < 80  THEN
127300                    MOVE CR-AGE-70-79  TO H-AGE-FACTOR
127400                 ELSE
127500                    MOVE CR-AGE-80-PLUS
127600                                       TO H-AGE-FACTOR
127700                 END-IF
127800              END-IF
127900           END-IF
128000        END-IF
128100     END-IF.
128200
128300******************************************************************
128400***Calculate Composite Rate BSA factor (note diff superscript) ***
128500******************************************************************
128600     COMPUTE H-BSA  ROUNDED = (.007184 *
128700         (B-PATIENT-HGT ** .725) * (B-PATIENT-WGT ** .425))
128800
128900     IF H-PATIENT-AGE > 17  THEN
129000        COMPUTE H-BSA-FACTOR  ROUNDED =
129100             CR-BSA ** ((H-BSA - 1.84) / .1)
129200     ELSE
129300        MOVE 1.000                     TO H-BSA-FACTOR
129400     END-IF.
129500
129600******************************************************************
129700*** Calculate Composite Rate BMI factor (different BMI < 18.5) ***
129800******************************************************************
129900     COMPUTE H-BMI  ROUNDED = (B-PATIENT-WGT /
130000         (B-PATIENT-HGT ** 2)) * 10000.
130100
130200     IF (H-PATIENT-AGE > 17) AND (H-BMI < 18.5)  THEN
130300        MOVE CR-BMI-LT-18-5            TO H-BMI-FACTOR
130400     ELSE
130500        MOVE 1.000                     TO H-BMI-FACTOR
130600     END-IF.
130700
130800******************************************************************
130900***  Calculate Composite Rate Payment Amount                   ***
131000******************************************************************
131100*P-ESRD-RATE, also called the Exception Rate, will not be granted*
131200*in full beginning in 2011 (the beginning of the Bundled method) *
131300*and will be eliminated entirely beginning in 2014 which is the  *
131400*end of the blending period.  For 2011, those providers who elect*
131500*to be in the blend, will get only 75% of the exception rate.    *
131600*This apparently is for the pediatric providers who originally   *
131700*had the exception rate.                                         *
131800
131900     IF P-ESRD-RATE  =  ZERO  THEN
132000        MOVE BASE-PAYMENT-RATE         TO  H-PAYMENT-RATE
132100     ELSE
132200        MOVE P-ESRD-RATE               TO  H-PAYMENT-RATE
132300     END-IF.
132400
132500     COMPUTE H-WAGE-ADJ-PYMT-AMT ROUNDED =
132600     (((H-PAYMENT-RATE * NAT-LABOR-PCT) * COM-CBSA-W-INDEX) +
132700       (H-PAYMENT-RATE * NAT-NONLABOR-PCT)) *
132800            CBSA-BLEND-PCT.
132900
133000     COMPUTE H-PYMT-AMT ROUNDED = (H-WAGE-ADJ-PYMT-AMT *
133100        H-BMI-FACTOR * H-BSA-FACTOR * CASE-MIX-BDGT-NEUT-FACTOR *
133200        H-AGE-FACTOR * DRUG-ADDON) + A-49-CENT-PART-D-DRUG-ADJ.
133300
133400     MOVE H-PYMT-AMT                   TO CASE-MIX-FCTR-ADJ-RATE.
133500
133600******************************************************************
133700***  Calculate condition code payment                          ***
133800******************************************************************
133900     MOVE SPACES                       TO COND-CD-73.
134000
134100* Hemo, peritoneal, or CCPD training add-on
134200     IF (B-COND-CODE = '73') AND (B-REV-CODE = '0821' OR '0831'
134300                                                      OR '0851')
134400        COMPUTE H-PYMT-AMT = H-PYMT-AMT + HEMO-PERI-CCPD-AMT
134500        MOVE 'A'                       TO AMT-INDIC
134600        MOVE HEMO-PERI-CCPD-AMT        TO BLOOD-DOLLAR
134700     ELSE
134800* CAPD training add-on
134900        IF (B-COND-CODE = '73')  AND  (B-REV-CODE = '0841')  THEN
135000           COMPUTE H-PYMT-AMT = H-PYMT-AMT + CAPD-AMT
135100           MOVE 'A'                    TO AMT-INDIC
135200           MOVE CAPD-AMT               TO BLOOD-DOLLAR
135300        ELSE
135400* Dialysis in Home and (CAPD or CCPD) Per-Diem calculation
135500           IF (B-COND-CODE = '74')  AND
135600              (B-REV-CODE = '0841' OR '0851')  THEN
135700              COMPUTE H-PYMT-AMT ROUNDED = H-PYMT-AMT *
135800                                           CAPD-OR-CCPD-FACTOR
135900              MOVE CAPD-OR-CCPD-FACTOR TO HEMO-CCPD-CAPD
136000           ELSE
136100              MOVE 'A'                 TO AMT-INDIC
136200              MOVE ZERO                TO BLOOD-DOLLAR
136300           END-IF
136400        END-IF
136500     END-IF.
136600
136700/
136800 9000-SET-RETURN-CODE.
136900******************************************************************
137000***  Set the return code                                       ***
137100******************************************************************
137200*   The following 'table' helps in understanding and in making   *
137300*changes to the rather large and complex "IF" statement that     *
137400*follows.  This 'table' just reorders and rewords the comments   *
137500*contained in the working storage area concerning the paid       *
137600*return-codes.                                                   *
137700*                                                                *
137800*  17 = pediatric, outlier, training                             *
137900*  16 = pediatric, outlier                                       *
138000*  15 = pediatric, training                                      *
138100*  14 = pediatric                                                *
138200*                                                                *
138300*  24 = outlier, low volume, training, chronic comorbid          *
138400*  19 = outlier, low volume, training, acute comorbid            *
138500*  29 = outlier, low volume, training                            *
138600*  23 = outlier, low volume, chronic comorbid                    *
138700*  18 = outlier, low volume, acute comorbid                      *
138800*  30 = outlier, low volume, onset                               *
138900*  28 = outlier, low volume                                      *
139000*  34 = outlier, training, chronic comorbid                      *
139100*  35 = outlier, training, acute comorbid                        *
139200*  33 = outlier, training                                        *
139300*  07 = outlier, chronic comorbid                                *
139400*  06 = outlier, acute comorbid                                  *
139500*  09 = outlier, onset                                           *
139600*  03 = outlier                                                  *
139700*                                                                *
139800*  26 = low volume, training, chronic comorbid                   *
139900*  21 = low volume, training, acute comorbid                     *
140000*  12 = low volume, training                                     *
140100*  25 = low volume, chronic comorbid                             *
140200*  20 = low volume, acute comorbid                               *
140300*  32 = low volume, onset                                        *
140400*  10 = low volume                                               *
140500*                                                                *
140600*  27 = training, chronic comorbid                               *
140700*  22 = training, acute comorbid                                 *
140800*  11 = training                                                 *
140900*                                                                *
141000*  08 = onset                                                    *
141100*  04 = acute comorbid                                           *
141200*  05 = chronic comorbid                                         *
141300*  31 = low BMI                                                  *
141400*  02 = no adjustments                                           *
141500*                                                                *
141600*  13 = w/multiple adjustments....reserved for future use        *
141700******************************************************************
141800/
141900     IF PEDIATRIC-TRACK                       = "Y"  THEN
142000        IF OUTLIER-TRACK                      = "Y"  THEN
142100           IF TRAINING-TRACK                  = "Y"  THEN
142200              MOVE 17                  TO PPS-RTC
142300           ELSE
142400              MOVE 16                  TO PPS-RTC
142500           END-IF
142600        ELSE
142700           IF TRAINING-TRACK                  = "Y"  THEN
142800              MOVE 15                  TO PPS-RTC
142900           ELSE
143000              MOVE 14                  TO PPS-RTC
143100           END-IF
143200        END-IF
143300     ELSE
143400        IF OUTLIER-TRACK                      = "Y"  THEN
143500           IF LOW-VOLUME-TRACK                = "Y"  THEN
143600              IF TRAINING-TRACK               = "Y"  THEN
143700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
143800                    MOVE 24            TO PPS-RTC
143900                 ELSE
144000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
144100                       MOVE 19         TO PPS-RTC
144200                    ELSE
144300                       MOVE 29         TO PPS-RTC
144400                    END-IF
144500                 END-IF
144600              ELSE
144700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
144800                    MOVE 23            TO PPS-RTC
144900                 ELSE
145000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
145100                       MOVE 18         TO PPS-RTC
145200                    ELSE
145300                       IF ONSET-TRACK         = "Y"  THEN
145400                          MOVE 30      TO PPS-RTC
145500                       ELSE
145600                          MOVE 28      TO PPS-RTC
145700                       END-IF
145800                    END-IF
145900                 END-IF
146000              END-IF
146100           ELSE
146200              IF TRAINING-TRACK               = "Y"  THEN
146300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
146400                    MOVE 34            TO PPS-RTC
146500                 ELSE
146600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
146700                       MOVE 35         TO PPS-RTC
146800                    ELSE
146900                       MOVE 33         TO PPS-RTC
147000                    END-IF
147100                 END-IF
147200              ELSE
147300                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
147400                    MOVE 07            TO PPS-RTC
147500                 ELSE
147600                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
147700                       MOVE 06         TO PPS-RTC
147800                    ELSE
147900                       IF ONSET-TRACK         = "Y"  THEN
148000                          MOVE 09      TO PPS-RTC
148100                       ELSE
148200                          MOVE 03      TO PPS-RTC
148300                       END-IF
148400                    END-IF
148500                 END-IF
148600              END-IF
148700           END-IF
148800        ELSE
148900           IF LOW-VOLUME-TRACK                = "Y"
149000              IF TRAINING-TRACK               = "Y"  THEN
149100                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
149200                    MOVE 26            TO PPS-RTC
149300                 ELSE
149400                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
149500                       MOVE 21         TO PPS-RTC
149600                    ELSE
149700                       MOVE 12         TO PPS-RTC
149800                    END-IF
149900                 END-IF
150000              ELSE
150100                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
150200                    MOVE 25            TO PPS-RTC
150300                 ELSE
150400                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
150500                       MOVE 20         TO PPS-RTC
150600                    ELSE
150700                       IF ONSET-TRACK         = "Y"  THEN
150800                          MOVE 32      TO PPS-RTC
150900                       ELSE
151000                          MOVE 10      TO PPS-RTC
151100                       END-IF
151200                    END-IF
151300                 END-IF
151400              END-IF
151500           ELSE
151600              IF TRAINING-TRACK               = "Y"  THEN
151700                 IF CHRONIC-COMORBID-TRACK    = "Y"  THEN
151800                    MOVE 27            TO PPS-RTC
151900                 ELSE
152000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
152100                       MOVE 22         TO PPS-RTC
152200                    ELSE
152300                       MOVE 11         TO PPS-RTC
152400                    END-IF
152500                 END-IF
152600              ELSE
152700                 IF ONSET-TRACK               = "Y"  THEN
152800                    MOVE 08            TO PPS-RTC
152900                 ELSE
153000                    IF ACUTE-COMORBID-TRACK   = "Y"  THEN
153100                       MOVE 04         TO PPS-RTC
153200                    ELSE
153300                       IF CHRONIC-COMORBID-TRACK = "Y"  THEN
153400                          MOVE 05      TO PPS-RTC
153500                       ELSE
153600                          IF LOW-BMI-TRACK = "Y"  THEN
153700                             MOVE 31 TO PPS-RTC
153800                          ELSE
153900                             MOVE 02 TO PPS-RTC
154000                          END-IF
154100                       END-IF
154200                    END-IF
154300                 END-IF
154400              END-IF
154500           END-IF
154600        END-IF
154700     END-IF.
154800/
154900 9100-MOVE-RESULTS.
155000     IF MOVED-CORMORBIDS = SPACES  THEN
155100        NEXT SENTENCE
155200     ELSE
155300        MOVE H-COMORBID-DATA (1)       TO COMORBID-DATA (1)
155400        MOVE H-COMORBID-DATA (2)       TO COMORBID-DATA (2)
155500        MOVE H-COMORBID-DATA (3)       TO COMORBID-DATA (3)
155600        MOVE H-COMORBID-DATA (4)       TO COMORBID-DATA (4)
155700        MOVE H-COMORBID-DATA (5)       TO COMORBID-DATA (5)
155800        MOVE H-COMORBID-DATA (6)       TO COMORBID-DATA (6)
155900        MOVE H-COMORBID-CWF-CODE       TO
156000                                    COMORBID-CWF-RETURN-CODE
156100     END-IF.
156200
156300     MOVE P-GEO-MSA                    TO PPS-MSA.
156400     MOVE P-GEO-CBSA                   TO PPS-CBSA.
156500     MOVE H-WAGE-ADJ-PYMT-AMT          TO PPS-WAGE-ADJ-RATE.
156600     MOVE B-COND-CODE                  TO PPS-COND-CODE.
156700     MOVE B-REV-CODE                   TO PPS-REV-CODE.
156800     MOVE H-BUN-BASE-WAGE-AMT          TO PPS-2011-WAGE-ADJ-RATE.
156900     MOVE BUN-NAT-LABOR-PCT            TO PPS-2011-NAT-LABOR-PCT.
157000     MOVE BUN-NAT-NONLABOR-PCT         TO
157100                                    PPS-2011-NAT-NONLABOR-PCT.
157200     MOVE NAT-LABOR-PCT                TO PPS-NAT-LABOR-PCT.
157300     MOVE NAT-NONLABOR-PCT             TO PPS-NAT-NONLABOR-PCT.
157400     MOVE H-AGE-FACTOR                 TO PPS-AGE-FACTOR.
157500     MOVE H-BSA-FACTOR                 TO PPS-BSA-FACTOR.
157600     MOVE H-BMI-FACTOR                 TO PPS-BMI-FACTOR.
157700     MOVE CASE-MIX-BDGT-NEUT-FACTOR    TO PPS-BDGT-NEUT-RATE.
157800     MOVE H-BUN-AGE-FACTOR             TO PPS-2011-AGE-FACTOR.
157900     MOVE H-BUN-BSA-FACTOR             TO PPS-2011-BSA-FACTOR.
158000     MOVE H-BUN-BMI-FACTOR             TO PPS-2011-BMI-FACTOR.
158100     MOVE TRANSITION-BDGT-NEUT-FACTOR  TO
158200                                    PPS-2011-BDGT-NEUT-RATE.
158300     MOVE SPACES                       TO PPS-2011-COMORBID-MA.
158400     MOVE SPACES                       TO
158500                                    PPS-2011-COMORBID-MA-CC.
158600
158700     IF (B-COND-CODE = '74')  AND
158800        (B-REV-CODE = '0841' OR '0851')  THEN
158900         COMPUTE H-OUT-PAYMENT ROUNDED = H-OUT-PAYMENT /
159000                                     B-CLAIM-NUM-DIALYSIS-SESSIONS
159100     END-IF.
159200
159300     IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
159400           COMPUTE PPS-2011-BLEND-COMP-RATE    ROUNDED =
159500              H-PYMT-AMT           *  COM-CBSA-BLEND-PCT
159600           COMPUTE PPS-2011-BLEND-PPS-RATE     ROUNDED =
159700              H-PPS-FINAL-PAY-AMT  *  BUN-CBSA-BLEND-PCT
159800           COMPUTE PPS-2011-BLEND-OUTLIER-RATE ROUNDED =
159900              H-OUT-PAYMENT        *  BUN-CBSA-BLEND-PCT
160000     ELSE
160100        MOVE ZERO                      TO
160200                                    PPS-2011-BLEND-COMP-RATE
160300        MOVE ZERO                      TO
160400                                    PPS-2011-BLEND-PPS-RATE
160500        MOVE ZERO                      TO
160600                                    PPS-2011-BLEND-OUTLIER-RATE
160700     END-IF.
160800
160900     MOVE H-PYMT-AMT                   TO
161000                                    PPS-2011-FULL-COMP-RATE.
161100     MOVE H-PPS-FINAL-PAY-AMT          TO PPS-2011-FULL-PPS-RATE
161200                                          PPS-FINAL-PAY-AMT.
161300     MOVE H-OUT-PAYMENT                TO
161400                                    PPS-2011-FULL-OUTLIER-RATE.
161500
161600     IF BUNDLED-TEST   THEN
161700        MOVE DRUG-ADDON                TO DRUG-ADD-ON-RETURN
161800        MOVE 0.0                       TO MSA-WAGE-ADJ
161900        MOVE H-WAGE-ADJ-PYMT-AMT       TO CBSA-WAGE-ADJ
162000        MOVE BASE-PAYMENT-RATE         TO CBSA-WAGE-PMT-RATE
162100        MOVE H-PATIENT-AGE             TO AGE-RETURN
162200        MOVE 0.0                       TO MSA-WAGE-AMT
162300        MOVE COM-CBSA-W-INDEX          TO CBSA-WAGE-INDEX
162400        MOVE H-BMI                     TO PPS-BMI
162500        MOVE H-BSA                     TO PPS-BSA
162600        MOVE MSA-BLEND-PCT             TO MSA-PCT
162700        MOVE CBSA-BLEND-PCT            TO CBSA-PCT
162800
162900        IF P-PROV-WAIVE-BLEND-PAY-INDIC        = 'N'  THEN
163000           MOVE COM-CBSA-BLEND-PCT     TO COM-CBSA-PCT-BLEND
163100           MOVE BUN-CBSA-BLEND-PCT     TO BUN-CBSA-PCT-BLEND
163200        ELSE
163300           MOVE ZERO                   TO COM-CBSA-PCT-BLEND
163400           MOVE WAIVE-CBSA-BLEND-PCT   TO BUN-CBSA-PCT-BLEND
163500        END-IF
163600
163700        MOVE H-BUN-BSA                 TO BUN-BSA
163800        MOVE H-BUN-BMI                 TO BUN-BMI
163900        MOVE H-BUN-ONSET-FACTOR        TO BUN-ONSET-FACTOR
164000        MOVE H-BUN-COMORBID-MULTIPLIER TO BUN-COMORBID-MULTIPLIER
164100        MOVE H-BUN-LOW-VOL-MULTIPLIER  TO BUN-LOW-VOL-MULTIPLIER
164200        MOVE H-OUT-AGE-FACTOR          TO OUT-AGE-FACTOR
164300        MOVE H-OUT-BSA                 TO OUT-BSA
164400        MOVE SB-BSA                    TO OUT-SB-BSA
164500        MOVE H-OUT-BSA-FACTOR          TO OUT-BSA-FACTOR
164600        MOVE H-OUT-BMI                 TO OUT-BMI
164700        MOVE H-OUT-BMI-FACTOR          TO OUT-BMI-FACTOR
164800        MOVE H-OUT-ONSET-FACTOR        TO OUT-ONSET-FACTOR
164900        MOVE H-OUT-COMORBID-MULTIPLIER TO
165000                                    OUT-COMORBID-MULTIPLIER
165100        MOVE H-OUT-PREDICTED-SERVICES-MAP  TO
165200                                    OUT-PREDICTED-SERVICES-MAP
165300        MOVE H-OUT-CM-ADJ-PREDICT-MAP-TRT  TO
165400                                    OUT-CASE-MIX-PREDICTED-MAP
165500        MOVE H-HEMO-EQUIV-DIAL-SESSIONS    TO
165600                                    OUT-HEMO-EQUIV-DIAL-SESSIONS
165700        MOVE H-OUT-LOW-VOL-MULTIPLIER  TO OUT-LOW-VOL-MULTIPLIER
165800        MOVE H-OUT-ADJ-AVG-MAP-AMT     TO OUT-ADJ-AVG-MAP-AMT
165900        MOVE H-OUT-IMPUTED-MAP         TO OUT-IMPUTED-MAP
166000        MOVE H-OUT-FIX-DOLLAR-LOSS     TO OUT-FIX-DOLLAR-LOSS
166100        MOVE H-OUT-LOSS-SHARING-PCT    TO OUT-LOSS-SHARING-PCT
166200        MOVE H-OUT-PREDICTED-MAP       TO OUT-PREDICTED-MAP
166300        MOVE CR-BSA                    TO CR-BSA-MULTIPLIER
166400        MOVE CR-BMI-LT-18-5            TO CR-BMI-MULTIPLIER
166500        MOVE A-49-CENT-PART-D-DRUG-ADJ TO A-49-CENT-DRUG-ADJ
166600        MOVE CM-BSA                    TO PPS-CM-BSA
166700        MOVE CM-BMI-LT-18-5            TO PPS-CM-BMI-LT-18-5
166800        MOVE BUNDLED-BASE-PMT-RATE     TO PPS-BUN-BASE-PMT-RATE
166900        MOVE BUN-CBSA-W-INDEX          TO PPS-BUN-CBSA-W-INDEX
167000        MOVE H-BUN-ADJUSTED-BASE-WAGE-AMT  TO
167100                                    BUN-ADJUSTED-BASE-WAGE-AMT
167200        MOVE H-BUN-WAGE-ADJ-TRAINING-AMT   TO
167300                                    PPS-BUN-WAGE-ADJ-TRAIN-AMT
167400        MOVE TRAINING-ADD-ON-PMT-AMT   TO
167500                                    PPS-TRAINING-ADD-ON-PMT-AMT
167600        MOVE H-PAYMENT-RATE            TO COM-PAYMENT-RATE
167700     END-IF.
167800******        L A S T   S O U R C E   S T A T E M E N T      *****
