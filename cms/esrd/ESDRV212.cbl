000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESDRV212.
000300*AUTHOR.     CMS.
000400*EFFECTIVE JANUARY 1, 2021
000500* This subroutine CALLs the appropriate Calculation Subprogram
000600* according to the bill's date
000700******************************************************************
000800*   This subroutine is furnished by the Centers for Medicare     *
000900*   and Medicaid Services.                                       *
001000*   It is to be used as an AID in implementing the Prospective   *
001100*   Payment System for ESRD claims.                              *
001200*                  *  *  *  *  *  *  *  *                        *
001300*   THE PROGRAM WILL:                                            *
001400*       1. Include the MSA Wage Adjusted Rate table.   (ESWRT151)*
001500*       2. Include the COMPOSITE CBSA Wage Index table.(ESCOM151)*
001600*       3. Include the BUNDLED CBSA Wage Index table.  (ESBUN21B)*
001700*       4. Include a special Copylib used to switch between the  *
001800*          mainframe and PC portions of the code.                *
001900*       5. Do some edits on the bill information.                *
002000*       6. Pass back return codes.                               *
002100*       7. Create a final payment WHEN that info is on the claim.*
002200*       8. CALL a calculate subroutine when applicable based on  *
002300*          claim date.                                           *
002400*                                                                *
002500*                  *  *  *  *  *  *  *  *                        *
002600*   CHANGE LOG.                                                  *
002700*                                                                *
002800*   The following changes made by DDS                            *
002900* 10/20/06 - NEW CBSA TABLE FOR CY2007 (I.E. COPY EXCBS070)      *
003000*          - ADDED DATE CHECKS FOR CY2007 AND CALL ESCAL070      *
003100* 12/28/06 - ADDED DATE CHECKS FOR CY2007 APRIL AND CALL ESCAL071*
003200*          - CREATED ENTER AND EXIT PARAGRAPHS FOR CLARITY       *
003300*          - STREAMLINED THE PROCESSING SO THAT IT IS MORE       *
003400*            EFFICIENT                                           *
003500*          - PROVIDED A DRIVER VERSION NUMBER WHICH WILL BE      *
003600*            PASSED BACK (IN THE PPS-CALC-VERS-CD) INDICATING AN *
003700*            INTERNAL ERROR THAT IS FOUND AND THUS THE CALCULATE *
003800*            SUBROUTINE IS NOT CALLED                            *
003900* 01/30/07 - NEW MSA AND CBSA TABLES WHICH INCLUDE THE LATEST    *
004000*            ADDITIONS TO THE STATE CODES PER CR#5490 AND CMSO   *
004100*            DATA ON WEB SITE                                    *
004200* 11/27/07 - ADDED SEVERAL 'IF' TESTS TO CHECK FOR WHEN CBSAS ARE*
004300*            DELETED OR ADDED IN VARIOUS CLAIM YEARS.  THIS WAS  *
004400*            NECESSARY SINCE I DISCOVERED BY ACCIDENT THAT BOB   *
004500*            CHRISTY NEGLECTED TO ACCOUNT FOR CBSAS CHANGING OVER*
004600*            TIME.  THESE TESTS ARE TEMPORARY SO THAT THE PRICER *
004700*            CAN BE DELIVERED TO THE FISCAL INTERMEDIARIES ON    *
004800*            TIME RATHER THAN TRYING TO TAKE THE TIME TO DEVISE A*
004900*            SEARCH-ALL TABLE WHICH WOULD TAKE ACCOUNT OF CBSAS  *
005000*            CHANGING OVER TIME.                                 *
005100* 06/04/08 - Added Copylib which enables this subprogram to act  *
005200*            the same on the IBM mainframe as well as on the PC  *
005300*            under MicroFocus COBOL.  The Copylib is technically *
005400*            slightly different on both systems which enables the*
005500*            test switch to operate correctly without any        *
005600*            standard COBOL changes between the systems.  The    *
005700*            EXACT same code shown in this listing (minus the    *
005800*            Copylib) WILL operate on both systems.  Therefore   *
005900*            there are no problems with synchronizing two        *
006000*            different source codes - - which, from experience,  *
006100*            will get out of sync over time.                     *
006200*          - Added different return codes to differentiate the   *
006300*            errors encountered.  These additional return codes  *
006400*            affect only the manager main-program which runs on  *
006500*            the PC.  They do not affect the running of this     *
006600*            subroutine on the IBM mainframe and will NOT impact *
006700*            'FISS' because only those codes contained in the    *
006800*            manual (IOM) are returned to 'FISS'.                *
006900*          - New CBSA Table for CY2009 (I.E. Copy EXCBS091       *
007000*          - Added date checks for CY2009 and CALL ESCAL091      *
007100* 12/03/08 - Renamed this subroutine ESDRV091 and changed the    *
007200*            appropriate version information.  The 9.0 version of*
007300*            the driver was sent out in November.  Afterwards the*
007400*            policy people who set the wage indexes, changed     *
007500*            their minds about CBSA 16700 and rescinded the new  *
007600*            wage index. This necessitated a re-release of the   *
007700*            ESRD dirver in order to make sure that the FI'S are *
007800*            using the latest version at the start of CY2009.    *
007900* 11/01/09 - Renamed this subroutine ESDRV100 and changed the    *
008000*            appropriate version information.  The 10.0 version  *
008100*            of the driver was sent out in November.             *
008200*          - Removed the ability to process 2005 claims.         *
008300*          - Added features which will make the driver able to   *
008400*            handle the new Bundled wage-index table and process *
008500*            those claims.  However, for this release, these     *
008600*            added features were commented out to speed up       *
008700*            processing.  There are other additions that need    *
008800*            to be made such as the length of the input record   *
008900*            in order for the 2011 driver and pricer to work.    *
009000* 01/08/10 - Renamed this subroutine ESDRV101 and changed the    *
009100*            appropriate version information.  The 10.1 version  *
009200*            of the driver was sent out in mid January.          *
009300*          - Because of a request by FISS and the MACs due to    *
009400*            requirements mandated by the OIG and CWF, the       *
009500*            ability to process 2005 claims was restored.  In    *
009600*            addition, to make this pricer conform to the rules  *
009700*            established with the IPPS Pricer, the ESRD Pricer   *
009800*            will be a 10 year rolling pricer.                   *
009900* 01/21/10 - Renamed this subroutine ESDRV102 and changed the    *
010000*            appropriate version information.  The 10.2 version  *
010100*            of the driver was sent out in late January.         *
010200*          - Fixed a slip-up in restoring the capability to      *
010300*            process 2005 claims.  My test file had real CBSA    *
010400*            values when it should have had blank values in that *
010500*            field, which is the case for 2005 claims.           *
010600* 08/04/10 - Renamed this subroutine ESRDRV110 and changed the   *
010700*            input and output file layout.  Installed the new    *
010800*            bundled (now called just PPS - the old methodology  *
010900*            will now be called composite rate) wage index table.*
011000* 11/09/10   Corrected the problem with CBSA 16700 for 2009 in   *
011100*            the composite rate table.  The latest wage indexes  *
011200*            from Suzanne Asplen's spreadsheet dated 10/27/2010  *
011300*            installed for both Bundled (PPS) and Composite Rate *
011400*            tables.  Updated the 0400-CHECK-CBSA-ADDS-DELETES   *
011500*            paragraph with 2011 CBSA changes.                   *
011600* 03/09/11   Renamed this subroutine ESDRV116 due to conformitity*
011700*            with the Calculate subroutine and also due to the   *
011800*            reworking of the copylib so that it used the same   *
011900*            ones that the calculate subroutines use.            *
012000* 10/28/11   Renamed this subroutine ESDRV120 due to conformitity*
012100*            with the Calculate subroutine.                      *
012200* 12/02/11   Renamed this subroutine ESDRV121 due to conformitity*
012300*            with the Calculate subroutine.                      *
012400* 10/19/12   ESDRV130 created for the CY 2013 ESRD Pricer.
012500*            - Added comments concerning this release
012600*            - Changed W-STORAGE-REF to ESRD D13.0
012700*            - Added  the following line to the WORKING-STORAGE
012800*              SECTION to add the name of the new Calculation
012900*              subprogram -->
013000*                 01  ESCAL130       PIC X(08) VALUE 'ESCAL130'.
013100*            - Changed COPY ESWRT121. to COPY ESWRT130. For MSA
013200*              Wage Index, which is no longer updated, just
013300*              renamed.
013400*            - Changed COPY ESCOM121. to COPY ESCOM130. to use
013500*              the latest Composite Wage Index.
013600*            - Changed COPY ESBUN121. to COPY ESBUN130. To use
013700*              the latest Bundled (PPS) Wage Index.
013800*            - Added section to code to CALL the new Calculation
013900*              Subprogram (ESCAL130)
014000*            - Since the CY 2013 ESRD Pricer update included
014100*              changes to the Calculation subprograms for
014200*              both 2012 and 2011, replaced
014300*              ESCAL116 with ESCAL117, and ESCAL121 with
014400*              ESCAL122 where needed.
014500* 11/15/13 ESDRV14B - TEST ONLY BETA VERSION
014600*          CREATED TO GIVE FISS SOMETHING TO TEST NOW BECAUSE
014700*          THE FINAL RULE WILL NOT BE AVAILABLE FOR ANOTHER
014800*          MONTH
014900*          MADE CHANGES TO ENSURE THAT PACIFIC RIM FACILITIES
015000*          ARE NOW PAID USING THE SAME CALCULATIONS AS
015100*          FACILITIES FROM OTHER AREAS
015200* 11/18/13 ESDRV140 - normal yearly release
015300*       This Driver module includes new logic
015400*       that directs Pacific Rim providers to flow through the
015500*       same pricing calculation as all other providers. This
015600*       logic was tested in the Beta version (ESDRV14B).
015700* 11/15/14 ESDRV150 - normal yearly release
015800*       added code to the 0800-FIND-BUNDLED-CBSA-WI to check to
015900*       make sure that the Wage Index being used to price the
016000*       claim is equal to the year of the claim in B-THRU-DATE
016100* 12/23/14 ESDRV151 - implement use of Special Wage Indexes for
016200*       certain Children's Hospitals
016300* 11/16/15 UPDATED FOR CY 2016 VERSION 0
016400* Stop using 0400-CHECK-CBSA-ADDS-DELETES.
016500* 09/07/16 - VERSION 17.B FOR TESTING ONLY
016600* 10/19/16 - VERSION 17.0 - CR9807 - CY 2017 ANNUAL UPDATE
016700* 03/16/17 - VERSION 17.1 - CR9609 - ADD RETRAINING - JULY 1, 2017
016800* 06/15/17 - VERSION 18.B - BETA VERSION TO TEST TDAPA
016900* 10/02/18 - VERSION 18.C - 2ND BETA VERSION TO TEST TDAPA
017000* 10/24/18 - VERSION 18.0 - CR10312 - CY2018 ANNUAL UPDATE
017100* 10/18/18 - VERSION 19.0 - CR11021 - CY2019 ANNUAL UPDATE
017200* 02/04/19 - VERSION 19.1 - CORRECTED WAGE INDEX
017300* 10/07/19 - VERSION 20.0 - CR11506 - CY2020 ANNUAL UPDATE
017400* 03/12/20 - VERSION 20.1 - CR11390 - ESRD Treatment Choices (ETC)
017500*  Model: Home Dialysis Payment Adjustment (HDPA) - Implementation
017600* 04/10/20 - VERSION 20.2 - added call to ESCAL202 - fix QIP issue
017700* 09/04/20 - VERSION 21.B - added call to ESCAL21B - for testing
017800* 10/20/20 - VERSION 21.0 - added call to ESCAL210
017900*  Added Supplemental Wage Index
018000* 12/11/20 - VERSION 21.1 - added call to ESCAL211
018100* 02/04/21 - VERSION 21.2 - added call to ESCAL212
018200******************************************************************
018300
018400 ENVIRONMENT DIVISION.
018500 CONFIGURATION SECTION.
018600 SOURCE-COMPUTER.            IBM-Z990.
018700 OBJECT-COMPUTER.            IBM.
018800 INPUT-OUTPUT  SECTION.
018900 FILE-CONTROL.
019000
019100 DATA DIVISION.
019200 FILE SECTION.
019300/
019400 WORKING-STORAGE SECTION.
019500 01  W-STORAGE-REF                  PIC X(48)  VALUE
019600     'ESRD D21.2    -    W O R K I N G   S T O R A G E'.
019700
019800 01  DRIVER-VERSION                 PIC X(05) VALUE 'D21.2'.
019900
020000 01  ESCAL056                       PIC X(08) VALUE 'ESCAL056'.
020100 01  ESCAL062                       PIC X(08) VALUE 'ESCAL062'.
020200 01  ESCAL070                       PIC X(08) VALUE 'ESCAL070'.
020300 01  ESCAL071                       PIC X(08) VALUE 'ESCAL071'.
020400 01  ESCAL080                       PIC X(08) VALUE 'ESCAL080'.
020500*01  ESCAL090 does not exist        PIC X(08) VALUE 'ESCAL090'.
020600 01  ESCAL091                       PIC X(08) VALUE 'ESCAL091'.
020700 01  ESCAL100                       PIC X(08) VALUE 'ESCAL100'.
020800*01  ESCAL110 only for FISS testing PIC X(08) VALUE 'ESCAL110'.
020900*01  ESCAL111 only for FISS testing PIC X(08) VALUE 'ESCAL111'.
021000*01  ESCAL112 only for FISS testing PIC X(08) VALUE 'ESCAL112'.
021100*01  ESCAL113 only for FISS testing PIC X(08) VALUE 'ESCAL113'.
021200*01  ESCAL114 only for FISS testing PIC X(08) VALUE 'ESCAL114'.
021300*01  ESCAL115 still under CR7064... PIC X(08) VALUE 'ESCAL115'.
021400 01  ESCAL117                       PIC X(08) VALUE 'ESCAL117'.
021500*01  ESCAL120 does not exist        PIC X(08) VALUE 'ESCAL120'.
021600 01  ESCAL122                       PIC X(08) VALUE 'ESCAL122'.
021700 01  ESCAL130                       PIC X(08) VALUE 'ESCAL130'.
021800 01  ESCAL140                       PIC X(08) VALUE 'ESCAL140'.
021900 01  ESCAL151                       PIC X(08) VALUE 'ESCAL151'.
022000 01  ESCAL160                       PIC X(08) VALUE 'ESCAL160'.
022100 01  ESCAL170                       PIC X(08) VALUE 'ESCAL170'.
022200 01  ESCAL171                       PIC X(08) VALUE 'ESCAL171'.
022300 01  ESCAL180                       PIC X(08) VALUE 'ESCAL180'.
022400 01  ESCAL191                       PIC X(08) VALUE 'ESCAL191'.
022500 01  ESCAL200                       PIC X(08) VALUE 'ESCAL200'.
022600 01  ESCAL202                       PIC X(08) VALUE 'ESCAL202'.
022700 01  ESCAL212                       PIC X(08) VALUE 'ESCAL212'.
022800
022900 01  DISPLAY-LINE-MEASUREMENT.
023000     05  FILLER                     PIC X(50) VALUE
023100         '....:...10....:...20....:...30....:...40....:...50'.
023200     05  FILLER                     PIC X(50) VALUE
023300         '....:...60....:...70....:...80....:...90....:..100'.
023400     05  FILLER                     PIC X(20) VALUE
023500         '....:..110....:..120'.
023600
023700 01  PRINT-LINE-MEASUREMENT.
023800     05  FILLER                     PIC X(51) VALUE
023900         'X....:...10....:...20....:...30....:...40....:...50'.
024000     05  FILLER                     PIC X(50) VALUE
024100         '....:...60....:...70....:...80....:...90....:..100'.
024200     05  FILLER                     PIC X(32) VALUE
024300         '....:..110....:..120....:..130..'.
024400
024500 01  WORK-AREA.
024600     05  W-SUB1                     PIC S9(07) COMP-3 VALUE ZERO.
024700     05  W-SUB2                     PIC S9(07) COMP-3 VALUE ZERO.
024800     05  W-SUB3                     PIC S9(07) COMP-3 VALUE ZERO.
024900
025000*ADDED B-THRU-YEAR-CODE TO COMPARE COMPARE BILL YEAR TO WI YEAR
025100 01  B-THRU-YEAR-CODE                 PIC  9(03) VALUE 0.
025200
025300* 10-20-20 ADDED FOR SUPPLEMENTAL WAGE INDEX
025400 01  H-ESRD-SUPP-WI-RATIO             PIC S9V9(5) VALUE ZERO.
025500
025600/
025700 COPY DSCNTRL.
025800*COPY "DSCNTRL.CPY".
025900/
026000*The Pricer is required to handle claims for the current year and
026100*three prior years in order for claims to be processed in a timely
026200*manner.  However, because claims can be reopened due to requireme
026300*by the OIG or CWF, the pricer needs to be able to process claims
026400*for a total of TEN years running.  Therefore, a diagram is
026500*necessary to figure out which tables need to be kept and which re
026600*from the driver in order to save space and increase efficiency.
026700*An asterisk beside the word 'yes' (below) indicates that the tabl
026800*does not need to be updated (even though it is still needed for
026900*for prior year claims).  Example:  A claim dated Dec. 31, 2008 ne
027000*the MSA table to price the claim items using a blend of 25% MSA 7
027100*CBSA.  Therefore the 2018 pricer needs the MSA table to process a
027200*year old claim.  Beginning in 2019 the MSA table can then be remo
027300*
027400*
027500*                                                        Call
027600*                 Wage index tables needed            Calculate
027700*                                                     Subroutine
027800*
027900*                 Need    Need      Need             2222222222222
028000*20xx                   Composite  Bundled           0000000000000
028100*Year blend      MSA-tbl CBSA-tbl  CBSA-tbl Pricer   1111111111222
028200*                                           Version  0123456789012
028300*
028400*05 100%MSA       yes                        05.6    XXXXXX
028500*06  25%Composite yes*    yes                06.2    XXXXXXX
028600*07  50%  "       yes*    yes                07.0    XXXXXXXX
028700*07  50%  "       yes*    yes                07.1    XXXXXXXX
028800*08  75%  "       yes*    yes                08.0    XXXXXXXXX
028900*09 100%  "       yes*    yes                09.1    XXXXXXXXXX
029000*10 100%  "       yes*    yes                10.0    XXXXXXXXXXX
029100*11  25%Bundled   yes*    yes        yes     11.0    XXXXXXXXXXXX
029200*12  50%  "       yes*    yes        yes     12.0    XXXXXXXXXXXXX
029300*13  75%  "       yes*    yes        yes     13.0    XXXXXXXXXXXXX
029400*14 100%  "       yes*    yes*       yes     14.0    XXXXXXXXXXXXX
029500*15 100%  "       yes*    yes*       yes     15.0    XXXXXXXXXXXXX
029600*16 100%  "       yes*    yes*       yes     16.0     XXXXXXXXXXXX
029700*17 100%  "       yes*    yes*       yes     17.0      XXXXXXXXXXX
029800*18 100%  "       yes*    yes*       yes     18.0       XXXXXXXXXX
029900*19 100%  "        no     yes*       yes     19.0        XXXXXXXXX
030000*20 100%  "        no     yes*       yes     20.0         XXXXXXXX
030100*21 100%  "        no     yes*       yes     21.0          XXXXXXX
030200*22 100%  "        no     yes*       yes     22.0           XXXXXX
030300*23 100%  "        no     yes*       yes     23.0            XXXXX
030400*24 100%  "        no      no        yes     24.0             XXXX
030500*25 100%  "        no      no        yes     25.0              XXX
030600*26 100%  "        no      no        yes     26.0               XX
030700*27 100%  "        no      no        yes     27.0                X
030800*28 100%  "        no      no        yes     28.0
030900*29 100%  "        no      no        yes     29.0
031000/
031100*  The following COPYLIB will NOT change (it's for MSA in 2005). *
031200*  Any wage adjustments are made in the calculation sub-programs.*
031300*  This COPYLIB will be removed in 2019 since it will no longer  *
031400*  be used.                                                      *
031500 COPY ESWRT151.
031600*COPY "ESWRT121.CPY".
031700/
031800*  The following COPYLIB is for the Composite Rate payment       *
031900*  system.  It will cease to be updated beginning in 2014,       *
032000*  although it will still be used through calendar year 2024.    *
032100*  Unless policies change, this table will be limited to ten     *
032200*  calendar years worth of data in order to cut down on the      *
032300*  amount of memory space used by the program.                   *
032400*  This COPYLIB will be removed in 2024 since it will no longer  *
032500*  be used.                                                      *
032600 COPY ESCOM151.
032700*COPY "ESCOM121.CPY".
032800/
032900*  The following COPYLIB is for the new Bundled payment system.  *
033000*  It is effective January 1, 2011 and will be changed on a      *
033100*  yearly basis from then on.  Although it looks similiar to the *
033200*  CBSA COPYLIB below it and also uses CBSAs, the wage indices   *
033300*  are derived in a different manner and while in the blend      *
033400*  period, they have to remain distinct because of the need to   *
033500*  process prior year's bills which use the old single CBSA index*
033600*  This table will superceed the old CBSA table below starting in*
033700*  calendar year 2014.  Unless policies change, this table will  *
033800*  be limited to TEN calendar years worth of data in order to    *
033900*  cut down on the amount of memory space used by the program.   *
034000 COPY ESBUN210.
034100*COPY "ESBUN121.CPY".
034200/
034300 COPY ESCHI151.
034400/
034500 COPY WAGECPY.
034600*COPY "WAGECPY.CPY".
034700/
034800 COPY RTCCPY.
034900*COPY "RTCCPY.CPY".
035000/
035100 LINKAGE SECTION.
035200 COPY BILLCPY.
035300*COPY "BILLCPY.CPY".
035400/
035500 PROCEDURE DIVISION  USING BILL-NEW-DATA
035600                           PPS-DATA-ALL.
035700
035800******************************************************************
035900*    THIS SUBROUTINE WILL...                                     *
036000*        A. Validate BILL-THRU-DATE and P-ESRD-RATE.             *
036100*        B. When P-ESRD-RATE > ZERO, then Rate on the bill is put*
036200*           in the PPS-FINAL-PAY-AMT area and then the record is *
036300*           passed back to the calling program without calling   *
036400*           any Calculate subroutine.                            *
036500*        C. Get MSA WAGE-RATE and/or CBSA WAGE-INDEX from the    *
036600*           appropriate internal Indexed Tables.                 *
036700*        D. Call ONE of various calculate subroutines based on   *
036800*           the date shown on the bill record.  Will not call any*
036900*           calculate subroutines if BILL-THRU-DATE exceeds the  *
037000*           driver design date.  Return code will be "00" and the*
037100*           Driver Version number will be present after 2010.    *
037200*        E. Pass back the Driver Version if no MSA/CBSA and date *
037300*           comtination are found in the Indexed Tables.         *
037400*           Otherwise the calculate subroutine supplies the      *
037500*           Version Number since no further processing in this   *
037600*           program is done after the call to the calculate      *
037700*           subroutine.                                          *
037800******************************************************************
037900
038000 0100-ENTER-DRIVER.
038100     INITIALIZE PPS-DATA-ALL.
038200     MOVE ZEROS TO COM-CBSA-WAGE-RECORD.
038300     MOVE DRIVER-VERSION          TO PPS-CALC-VERS-CD.
038400     MOVE 00                      TO PPS-RTC.
038500*
038600* Propose moving 99 to PPS-RTC so that when claims with a date
038700* greater than the year that the DRIVER is designed for, will
038800* return a RTC=99 rather than RTC=00 which is does currently.
038900* i.e. B-THRU-DATE > 2011 for the current DRIVER will get RTC=99.
039000*
039100*    MOVE 99                      TO PPS-RTC.
039200* You may uncomment the above line to test it out it you wish.
039300*
039400*    DISPLAY '***Entering DRIVER, Bill-New-Data follows'.
039500*    DISPLAY BILL-NEW-DATA.
039600
039700     IF (B-THRU-DATE < 20050401) OR (B-THRU-DATE NOT NUMERIC)
039800        MOVE 98                   TO PPS-RTC
039900        GO TO 0100-EXIT-DRIVER
040000     END-IF.
040100
040200     IF P-ESRD-RATE NOT NUMERIC
040300        MOVE 50                   TO PPS-RTC
040400        GO TO 0100-EXIT-DRIVER
040500     END-IF.
040600
040700*P-ESRD-RATE, also called the Exception Rate, will not be granted*
040800*in full beginning in 2011 (the beginning of the Bundled method) *
040900*and will be eliminated entirely beginning in 2014 which is the  *
041000*end of the blending period.  For 2011, those providers who elect*
041100*to be in the blend, will get only 75% of the exception rate.    *
041200*The exception to this 'Exception Rate' is for those providers   *
041300*located within one of the Pacific Island Trust Territories.     *
041400*These providers are paid at cost and so a new variable is needed*
041500*to allow them to be paid the same way as before, but still allow*
041600*the pediatric providers who had the Exception Rate to be        *
041700*processed under the blended PPS if they chose to elect to be in *
041800*the blend.                                                      *
041900
042000     IF (B-THRU-DATE < 20110101)  AND  (P-ESRD-RATE > ZERO)
042100        MOVE P-ESRD-RATE          TO PPS-FINAL-PAY-AMT
042200        MOVE 01                   TO PPS-RTC
042300        GO TO 0100-EXIT-DRIVER
042400     END-IF.
042500
042600     IF (B-THRU-DATE > 20101231)        AND
042700        (B-THRU-DATE < 20140101)        AND
042800        (P-PACIFIC-IS-TRUST-TERR = '2') AND
042900        (P-ESRD-RATE > ZERO)
043000        MOVE P-ESRD-RATE                TO PPS-FINAL-PAY-AMT
043100        MOVE 01                         TO PPS-RTC
043200        GO TO 0100-EXIT-DRIVER
043300     END-IF.
043400
043500******************************************************************
043600* Check for additions and deletions in CBSAs for each year.      *
043700*CY 2016 COMMENTED OUT
043800******************************************************************
043900
044000*    PERFORM 0400-CHECK-CBSA-ADDS-DELETES
044100*       THRU 0400-ADD-DELETE-EXIT.
044200
044300*    IF PPS-RTC > 00  THEN
044400*       GO TO 0100-EXIT-DRIVER
044500*    END-IF.
044600
044700/
044800******************************************************************
044900* Get the Wage Adjusted Rate as well as                          *
045000*     the COMposite and BUNdled budget neutralized Wage Indexes. *
045100******************************************************************
045200
045300* This driver will NOT CALL any calculate subroutine beyond the
045400* year for which the the driver is designed, and therefore a claim
045500* will not be paid correctly despite the RTC having a value of"00"
045600* A return code of "00" was only valid from 2005 thru 2010.
045700* Beginning in 2011 the return code
045800* should be greater than "01" for paid and unpaid claims.
045900*    FISS has the responsibility to insure that claims beyond the
046000* driver design date are not permitted.  Therefore for 2011, no
046100* claims should have a date beyond 2011.
046200*    FISS also has the responsibility of insuring that the claims
046300* do not have future dates beyond the "TODAYS-DATE"
046400* (which can be accepted from the IBM computer).
046500
046600     IF (B-THRU-DATE > 20131231) THEN
046700* Process 2014 and later claims.
046800        MOVE ZERO                TO W-NEW-RATE1-RECORD
046900                                    W-NEW-RATE2-RECORD
047000        PERFORM 0800-FIND-BUNDLED-CBSA-WI
047100           THRU 0800-FIND-EXIT
047200     ELSE
047300        IF (B-THRU-DATE > 20101231) THEN
047400* Process 2011 - 2013 claims.
047500            MOVE ZERO                TO W-NEW-RATE1-RECORD
047600                                        W-NEW-RATE2-RECORD
047700            PERFORM 0700-FIND-COMPOSITE-CBSA-WI
047800               THRU 0700-FIND-EXIT
047900            PERFORM 0800-FIND-BUNDLED-CBSA-WI
048000               THRU 0800-FIND-EXIT
048100        ELSE
048200           IF (B-THRU-DATE > 20081231)  THEN
048300* Process 2009 - 2010 claims.
048400              MOVE ZERO              TO W-NEW-RATE1-RECORD
048500                                        W-NEW-RATE2-RECORD
048600              PERFORM 0700-FIND-COMPOSITE-CBSA-WI
048700                 THRU 0700-FIND-EXIT
048800           ELSE
048900              IF (B-THRU-DATE > 20051231 AND
049000                  B-THRU-DATE < 20090101)  THEN
049100* Process 2006 - 08 claims.
049200                    PERFORM 0500-FIND-MSA-WAGE-ADJ-RATE
049300                       THRU 0500-FIND-EXIT
049400                    PERFORM 0700-FIND-COMPOSITE-CBSA-WI
049500                       THRU 0700-FIND-EXIT
049600              ELSE
049700                 IF (B-THRU-DATE > 20050331 AND
049800                     B-THRU-DATE < 20060101)  THEN
049900* Process 2005 claims.
050000                     PERFORM 0500-FIND-MSA-WAGE-ADJ-RATE
050100                        THRU 0500-FIND-EXIT
050200                 ELSE
050300                     MOVE 98         TO PPS-RTC
050400                 END-IF
050500              END-IF
050600           END-IF
050700        END-IF
050800     END-IF.
050900*RTC > 00  --  WAGE ADJUSTED RATE NOT FOUND.
051000     IF PPS-RTC > 00  THEN
051100        GO TO 0100-EXIT-DRIVER
051200     END-IF.
051300
051400
051500******************************************************************
051600*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
051700*           THRU DATE BETWEEN 20210101 AND 20211231              *
051800******************************************************************
051900
052000     IF (B-THRU-DATE > 20201231  AND
052100         B-THRU-DATE < 20220101)  THEN
052200        CALL ESCAL212 USING BILL-NEW-DATA
052300                            PPS-DATA-ALL
052400                            WAGE-NEW-RATE-RECORD
052500                            COM-CBSA-WAGE-RECORD
052600                            BUN-CBSA-WAGE-RECORD
052700        GO TO 0100-EXIT-DRIVER
052800     END-IF.
052900
053000
053100******************************************************************
053200*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
053300*           THRU DATE BETWEEN 20200701 AND 20201231              *
053400******************************************************************
053500
053600     IF (B-THRU-DATE > 20200630  AND
053700         B-THRU-DATE < 20210101)  THEN
053800        CALL ESCAL202 USING BILL-NEW-DATA
053900                            PPS-DATA-ALL
054000                            WAGE-NEW-RATE-RECORD
054100                            COM-CBSA-WAGE-RECORD
054200                            BUN-CBSA-WAGE-RECORD
054300        GO TO 0100-EXIT-DRIVER
054400     END-IF.
054500
054600
054700******************************************************************
054800*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
054900*           THRU DATE BETWEEN 20200101 AND 20200630              *
055000******************************************************************
055100
055200     IF (B-THRU-DATE > 20191231  AND
055300         B-THRU-DATE < 20200701)  THEN
055400        CALL ESCAL200 USING BILL-NEW-DATA
055500                            PPS-DATA-ALL
055600                            WAGE-NEW-RATE-RECORD
055700                            COM-CBSA-WAGE-RECORD
055800                            BUN-CBSA-WAGE-RECORD
055900        GO TO 0100-EXIT-DRIVER
056000     END-IF.
056100
056200
056300******************************************************************
056400*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
056500*           THRU DATE BETWEEN 20190101 AND 20191231              *
056600******************************************************************
056700
056800     IF (B-THRU-DATE > 20181231  AND
056900         B-THRU-DATE < 20200101)  THEN
057000        CALL ESCAL191 USING BILL-NEW-DATA
057100                            PPS-DATA-ALL
057200                            WAGE-NEW-RATE-RECORD
057300                            COM-CBSA-WAGE-RECORD
057400                            BUN-CBSA-WAGE-RECORD
057500        GO TO 0100-EXIT-DRIVER
057600     END-IF.
057700
057800******************************************************************
057900*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
058000*           THRU DATE BETWEEN 20180101 AND 20181231              *
058100******************************************************************
058200
058300     IF (B-THRU-DATE > 20171231  AND
058400         B-THRU-DATE < 20190101)  THEN
058500        CALL ESCAL180 USING BILL-NEW-DATA
058600                            PPS-DATA-ALL
058700                            WAGE-NEW-RATE-RECORD
058800                            COM-CBSA-WAGE-RECORD
058900                            BUN-CBSA-WAGE-RECORD
059000        GO TO 0100-EXIT-DRIVER
059100     END-IF.
059200
059300******************************************************************
059400*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
059500*           THRU DATE BETWEEN 20170701 AND 20171231              *
059600******************************************************************
059700
059800     IF (B-THRU-DATE > 20170630  AND
059900         B-THRU-DATE < 20180101)  THEN
060000        CALL ESCAL171 USING BILL-NEW-DATA
060100                            PPS-DATA-ALL
060200                            WAGE-NEW-RATE-RECORD
060300                            COM-CBSA-WAGE-RECORD
060400                            BUN-CBSA-WAGE-RECORD
060500        GO TO 0100-EXIT-DRIVER
060600     END-IF.
060700
060800******************************************************************
060900*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
061000*           THRU DATE BETWEEN 20170101 AND 20170630              *
061100******************************************************************
061200
061300     IF (B-THRU-DATE > 20161231  AND
061400         B-THRU-DATE < 20170701)  THEN
061500        CALL ESCAL170 USING BILL-NEW-DATA
061600                            PPS-DATA-ALL
061700                            WAGE-NEW-RATE-RECORD
061800                            COM-CBSA-WAGE-RECORD
061900                            BUN-CBSA-WAGE-RECORD
062000        GO TO 0100-EXIT-DRIVER
062100     END-IF.
062200
062300******************************************************************
062400*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
062500*           THRU DATE BETWEEN 20160101 AND 20161231              *
062600******************************************************************
062700
062800     IF (B-THRU-DATE > 20151231  AND
062900         B-THRU-DATE < 20170101)  THEN
063000        CALL ESCAL160 USING BILL-NEW-DATA
063100                            PPS-DATA-ALL
063200                            WAGE-NEW-RATE-RECORD
063300                            COM-CBSA-WAGE-RECORD
063400                            BUN-CBSA-WAGE-RECORD
063500        GO TO 0100-EXIT-DRIVER
063600     END-IF.
063700
063800******************************************************************
063900*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
064000*           THRU DATE BETWEEN 20150101 AND 20151231              *
064100******************************************************************
064200
064300     IF (B-THRU-DATE > 20141231  AND
064400         B-THRU-DATE < 20160101)  THEN
064500        CALL ESCAL151 USING BILL-NEW-DATA
064600                            PPS-DATA-ALL
064700                            WAGE-NEW-RATE-RECORD
064800                            COM-CBSA-WAGE-RECORD
064900                            BUN-CBSA-WAGE-RECORD
065000        GO TO 0100-EXIT-DRIVER
065100     END-IF.
065200
065300******************************************************************
065400*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
065500*           THRU DATE BETWEEN 20140101 AND 20141231              *
065600******************************************************************
065700
065800     IF (B-THRU-DATE > 20131231  AND
065900         B-THRU-DATE < 20150101)  THEN
066000        CALL ESCAL140 USING BILL-NEW-DATA
066100                            PPS-DATA-ALL
066200                            WAGE-NEW-RATE-RECORD
066300                            COM-CBSA-WAGE-RECORD
066400                            BUN-CBSA-WAGE-RECORD
066500        GO TO 0100-EXIT-DRIVER
066600     END-IF.
066700
066800******************************************************************
066900*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
067000*           THRU DATE BETWEEN 20130101 AND 20131231              *
067100******************************************************************
067200
067300     IF (B-THRU-DATE > 20121231  AND
067400         B-THRU-DATE < 20140101)  THEN
067500        CALL ESCAL130 USING BILL-NEW-DATA
067600                            PPS-DATA-ALL
067700                            WAGE-NEW-RATE-RECORD
067800                            COM-CBSA-WAGE-RECORD
067900                            BUN-CBSA-WAGE-RECORD
068000        GO TO 0100-EXIT-DRIVER
068100     END-IF.
068200
068300******************************************************************
068400*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
068500*           THRU DATE BETWEEN 20120101 AND 20121231              *
068600*                  Remove this CALL in 2022.                     *
068700******************************************************************
068800
068900     IF (B-THRU-DATE > 20111231  AND
069000         B-THRU-DATE < 20130101)  THEN
069100        CALL ESCAL122 USING BILL-NEW-DATA
069200                            PPS-DATA-ALL
069300                            WAGE-NEW-RATE-RECORD
069400                            COM-CBSA-WAGE-RECORD
069500                            BUN-CBSA-WAGE-RECORD
069600        GO TO 0100-EXIT-DRIVER
069700     END-IF.
069800
069900******************************************************************
070000*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
070100*           THRU DATE BETWEEN 20110101 AND 20111231              *
070200*                  Remove this CALL in 2022.                     *
070300******************************************************************
070400
070500     IF (B-THRU-DATE > 20101231  AND
070600         B-THRU-DATE < 20120101)  THEN
070700        CALL ESCAL117 USING BILL-NEW-DATA
070800                            PPS-DATA-ALL
070900                            WAGE-NEW-RATE-RECORD
071000                            COM-CBSA-WAGE-RECORD
071100                            BUN-CBSA-WAGE-RECORD
071200        GO TO 0100-EXIT-DRIVER
071300     END-IF.
071400
071500******************************************************************
071600*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
071700*           THRU DATE BETWEEN 20100101 AND 20101231              *
071800*                  Remove this CALL in 2021.                     *
071900******************************************************************
072000
072100     IF (B-THRU-DATE > 20091231  AND
072200         B-THRU-DATE < 20110101)  THEN
072300        CALL ESCAL100 USING BILL-NEW-DATA
072400                            PPS-DATA-ALL
072500                            WAGE-NEW-RATE-RECORD
072600                            COM-CBSA-WAGE-RECORD
072700        GO TO 0100-EXIT-DRIVER
072800     END-IF.
072900
073000******************************************************************
073100*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
073200*           THRU DATE BETWEEN 20090101 AND 20091231              *
073300* NOTE:  THERE IS NO ESCAL090 DUE TO THIS VERSION BEING RELEASED *
073400*        BEFORE JANUARY 2009 (AND AFTER THE INITIAL 9.0 RELEASE) *
073500*                  Remove this CALL in 2020.                     *
073600******************************************************************
073700
073800     IF (B-THRU-DATE > 20081231  AND
073900         B-THRU-DATE < 20100101)  THEN
074000        CALL ESCAL091 USING BILL-NEW-DATA
074100                            PPS-DATA-ALL
074200                            WAGE-NEW-RATE-RECORD
074300                            COM-CBSA-WAGE-RECORD
074400        GO TO 0100-EXIT-DRIVER
074500     END-IF.
074600
074700******************************************************************
074800*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
074900*           THRU DATE BETWEEN 20080101 AND 20081231              *
075000*                  Remove this CALL in 2019.                     *
075100******************************************************************
075200
075300     IF (B-THRU-DATE > 20071231  AND
075400         B-THRU-DATE < 20090101)  THEN
075500        CALL ESCAL080 USING BILL-NEW-DATA
075600                            PPS-DATA-ALL
075700                            WAGE-NEW-RATE-RECORD
075800                            COM-CBSA-WAGE-RECORD
075900        GO TO 0100-EXIT-DRIVER
076000     END-IF.
076100
076200******************************************************************
076300*           THE NEXT CALL WILL PROCESS BILLS WITH  A             *
076400*           THRU DATE BETWEEN 20070401 AND 20071231              *
076500*                  Remove this CALL in 2018.                     *
076600******************************************************************
076700
076800     IF (B-THRU-DATE > 20070331  AND
076900         B-THRU-DATE < 20080101)  THEN
077000        CALL ESCAL071 USING BILL-NEW-DATA
077100                            PPS-DATA-ALL
077200                            WAGE-NEW-RATE-RECORD
077300                            COM-CBSA-WAGE-RECORD
077400        GO TO 0100-EXIT-DRIVER
077500     END-IF.
077600
077700******************************************************************
077800*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
077900*           THRU DATE BETWEEN 20070101 AND 20070331              *
078000*                  Remove this CALL in 2018.                     *
078100******************************************************************
078200
078300     IF (B-THRU-DATE > 20061231  AND
078400         B-THRU-DATE < 20070401)  THEN
078500        CALL ESCAL070 USING BILL-NEW-DATA
078600                            PPS-DATA-ALL
078700                            WAGE-NEW-RATE-RECORD
078800                            COM-CBSA-WAGE-RECORD
078900        GO TO 0100-EXIT-DRIVER
079000     END-IF.
079100
079200******************************************************************
079300*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
079400*           THRU DATE BETWEEN 20060101 AND 20061231              *
079500*                  Remove this CALL in 2017.                     *
079600******************************************************************
079700
079800     IF (B-THRU-DATE > 20051231  AND
079900         B-THRU-DATE < 20070101)  THEN
080000        CALL ESCAL062 USING BILL-NEW-DATA
080100                            PPS-DATA-ALL
080200                            WAGE-NEW-RATE-RECORD
080300                            COM-CBSA-WAGE-RECORD
080400        GO TO 0100-EXIT-DRIVER
080500     END-IF.
080600
080700******************************************************************
080800*           THE NEXT CALL WILL PROCESS BILLS WITH A              *
080900*           THRU DATE BETWEEN 20050401 AND 20051231              *
081000*                  Remove this CALL in 2016.                     *
081100******************************************************************
081200
081300     IF (B-THRU-DATE > 20050331  AND
081400         B-THRU-DATE < 20060101)  THEN
081500        CALL ESCAL056 USING BILL-NEW-DATA
081600                            PPS-DATA-ALL
081700                            WAGE-NEW-RATE-RECORD
081800        GO TO 0100-EXIT-DRIVER
081900     END-IF.
082000
082100
082200
082300 0100-EXIT-DRIVER.
082400*    DISPLAY 'GOING BACK'.
082500     GOBACK.
082600******************************************************************
082700/
082800*0400-CHECK-CBSA-ADDS-DELETES.
082900*
083000*    IF B-THRU-CCYY > 2010  THEN
083100** These CBSAs Deleted starting in 2011                          *
083200** Note that '14600' also appears when   < 2009                  *
083300** There is no CBSA that was deleted starting in 2010            *
083400*       IF P-GEO-CBSA = '14600' OR  '23020'  OR  '48260'  THEN
083500*          IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
083600*             MOVE 60             TO PPS-RTC
083700*             GO TO 0400-ADD-DELETE-EXIT
083800*          ELSE
083900*             MOVE 62             TO PPS-RTC
084000*             GO TO 0400-ADD-DELETE-EXIT
084100*          END-IF
084200*       END-IF
084300*    END-IF.
084400*
084500*    IF B-THRU-CCYY > 2008  THEN
084600** This CBSA Deleted starting in 2009                            *
084700*       IF P-GEO-CBSA = '42260'  THEN
084800*          IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
084900*             MOVE 60             TO PPS-RTC
085000*             GO TO 0400-ADD-DELETE-EXIT
085100*          ELSE
085200*             MOVE 62             TO PPS-RTC
085300*             GO TO 0400-ADD-DELETE-EXIT
085400*          END-IF
085500*       END-IF
085600*    END-IF.
085700*
085800*    IF B-THRU-CCYY > 2007  THEN
085900** This CBSA Deleted starting in 2008                            *
086000*       IF P-GEO-CBSA = '21604'  THEN
086100*          IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
086200*             MOVE 60             TO PPS-RTC
086300*             GO TO 0400-ADD-DELETE-EXIT
086400*          ELSE
086500*             MOVE 62             TO PPS-RTC
086600*             GO TO 0400-ADD-DELETE-EXIT
086700*          END-IF
086800*       END-IF
086900*    END-IF.
087000*
087100*    IF B-THRU-CCYY > 2006  THEN
087200** This CBSA Deleted starting in 2007                            *
087300*       IF P-GEO-CBSA = '46940'  THEN
087400*          IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
087500*             MOVE 60             TO PPS-RTC
087600*             GO TO 0400-ADD-DELETE-EXIT
087700*          ELSE
087800*             MOVE 62             TO PPS-RTC
087900*             GO TO 0400-ADD-DELETE-EXIT
088000*          END-IF
088100*       END-IF
088200*    END-IF.
088300*
088400*    IF B-THRU-CCYY < 2011  THEN
088500** These CBSAs Added starting in 2011                            *
088600*      IF P-GEO-CBSA = '18880'  OR
088700*                      '35840'  OR
088800*                      '44600'  THEN
088900*        IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
089000*          MOVE 60                TO PPS-RTC
089100*          GO TO 0400-ADD-DELETE-EXIT
089200*        ELSE
089300*          MOVE 62                TO PPS-RTC
089400*          GO TO 0400-ADD-DELETE-EXIT
089500*        END-IF
089600*      ELSE
089700*        IF B-THRU-CCYY < 2010  THEN
089800** These CBSAs Added starting in 2010                            *
089900*          IF P-GEO-CBSA = '31740'  OR
090000*                          '31860'  THEN
090100*            IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
090200*              MOVE 60            TO PPS-RTC
090300*              GO TO 0400-ADD-DELETE-EXIT
090400*            ELSE
090500*              MOVE 62            TO PPS-RTC
090600*              GO TO 0400-ADD-DELETE-EXIT
090700*            END-IF
090800*          ELSE
090900*            IF B-THRU-CCYY < 2009  THEN
091000** This CBSA Added starting in 2009                            *
091100*              IF P-GEO-CBSA = '14600'  THEN
091200*                IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
091300*                  MOVE 60        TO PPS-RTC
091400*                  GO TO 0400-ADD-DELETE-EXIT
091500*                ELSE
091600*                  MOVE 62        TO PPS-RTC
091700*                  GO TO 0400-ADD-DELETE-EXIT
091800*                END-IF
091900*              ELSE
092000*                IF B-THRU-CCYY < 2008  THEN
092100** These CBSAs Added in 2008                                     *
092200*                  IF P-GEO-CBSA = '29420' OR
092300*                                  '37380' OR
092400*                                  '37764' THEN
092500*                    IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
092600*                      MOVE 60    TO PPS-RTC
092700*                      GO TO 0400-ADD-DELETE-EXIT
092800*                    ELSE
092900*                      MOVE 62    TO PPS-RTC
093000*                      GO TO 0400-ADD-DELETE-EXIT
093100*                    END-IF
093200*                  ELSE
093300*                    IF B-THRU-CCYY < 2007  THEN
093400** This CBSA Added in 2007                                       *
093500*                      IF P-GEO-CBSA = '42680'  THEN
093600*                      IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE THEN
093700*                          MOVE 60 TO PPS-RTC
093800*                          GO TO 0400-ADD-DELETE-EXIT
093900*                        ELSE
094000*                          MOVE 62 TO PPS-RTC
094100*                          GO TO 0400-ADD-DELETE-EXIT
094200*                        END-IF
094300*                      END-IF
094400*                    END-IF
094500*                  END-IF
094600*                END-IF
094700*              END-IF
094800*            END-IF
094900*          END-IF
095000*        END-IF
095100*      END-IF
095200*    END-IF.
095300*
095400*0400-ADD-DELETE-EXIT.
095500*    EXIT.
095600/
095700 0500-FIND-MSA-WAGE-ADJ-RATE.
095800     MOVE WWD-MAX                 TO WWD-SUB.
095900
096000     PERFORM UNTIL B-THRU-DATE NOT < WWD-DATE (WWD-SUB)
096100         SUBTRACT 1 FROM WWD-SUB
096200     END-PERFORM.
096300
096400     SEARCH ALL WWM-ENTRY
096500       AT END
096600          MOVE 60                 TO PPS-RTC
096700          GO TO 0500-FIND-EXIT
096800       WHEN WWM-MSA (WWM-INDX) = P-GEO-MSA
096900          MOVE WWM-PTR (WWM-INDX) TO W-SUB1
097000          PERFORM 0550-N-GET-WAGE-RATE
097100             THRU 0550-N-EXIT
097200     END-SEARCH.
097300
097400 0500-FIND-EXIT.
097500      EXIT.
097600
097700 0550-N-GET-WAGE-RATE.
097800     IF WWW-DTCD (W-SUB1) NOT > WWD-DTCD (WWD-SUB)  THEN
097900        MOVE WWD-DATE (WWD-SUB)   TO W-NEW-EFF-DATE
098000        MOVE WWW-WART1 (W-SUB1)   TO W-NEW-RATE1-RECORD
098100        MOVE WWW-WART2 (W-SUB1)   TO W-NEW-RATE2-RECORD
098200     ELSE
098300        SUBTRACT 1 FROM W-SUB1
098400        IF W-SUB1 > WWM-PTR (WWM-INDX - 1)  THEN
098500           GO TO 0550-N-GET-WAGE-RATE
098600        ELSE
098700          MOVE 0                  TO W-NEW-RATE1-RECORD
098800                                     W-NEW-RATE2-RECORD
098900        END-IF
099000     END-IF.
099100
099200 0550-N-EXIT.
099300     EXIT.
099400/
099500 0700-FIND-COMPOSITE-CBSA-WI.
099600     IF P-SPEC-PYMT-IND = '1'  THEN
099700        MOVE P-SPEC-WAGE-INDX     TO COM-CBSA-W-INDEX
099800        GO TO 0700-FIND-EXIT
099900     END-IF.
100000
100100     MOVE COM-MAX-DATE            TO COM-SUB.
100200
100300     PERFORM UNTIL B-THRU-DATE NOT < COM-DATE (COM-SUB)
100400         SUBTRACT 1 FROM COM-SUB
100500     END-PERFORM.
100600
100700     SEARCH ALL COM-CBSA-ENTRY
100800       AT END
100900          IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
101000             MOVE 60              TO PPS-RTC
101100             GO TO 0700-FIND-EXIT
101200          ELSE
101300             MOVE 61              TO PPS-RTC
101400             GO TO 0700-FIND-EXIT
101500          END-IF
101600       WHEN COM-CBSA-VALUE (COM-INDX) = P-GEO-CBSA
101700          MOVE COM-PTR (COM-INDX) TO W-SUB2
101800          PERFORM 0750-GET-COMP-CBSA-RATE
101900             THRU 0750-COMP-EXIT
102000     END-SEARCH.
102100
102200
102300 0700-FIND-EXIT.
102400      EXIT.
102500
102600 0750-GET-COMP-CBSA-RATE.
102700     IF COM-WI-DATE-CODE (W-SUB2) NOT > COM-DATE-CODE (COM-SUB)
102800                                                   THEN
102900        MOVE COM-DATE (COM-SUB)   TO COM-CBSA-DATE
103000        MOVE COM-WAGE-INDEX (W-SUB2)
103100                                  TO COM-CBSA-W-INDEX
103200     ELSE
103300        SUBTRACT 1 FROM W-SUB2
103400        IF W-SUB2 > COM-PTR (COM-INDX - 1)  THEN
103500           GO TO 0750-GET-COMP-CBSA-RATE
103600        ELSE
103700           MOVE 0                 TO COM-CBSA-W-INDEX
103800        END-IF
103900     END-IF.
104000
104100 0750-COMP-EXIT.
104200     EXIT.
104300******************************************************************
104400/
104500 0800-FIND-BUNDLED-CBSA-WI.
104600     IF P-SPEC-PYMT-IND = '1'  THEN
104700        MOVE P-SPEC-WAGE-INDX     TO BUN-CBSA-W-INDEX
104800        GO TO 0800-FIND-EXIT
104900     END-IF.
105000
105100     IF B-THRU-DATE > 20141231  AND  B-THRU-DATE < 20160101
105200      MOVE "N" TO CHILD-HOSP-SWI-FOUND-SWITCH
105300      PERFORM 0820-SEARCH-CHILD-HOSP-TABLE
105400          WITH TEST AFTER
105500          VARYING CHILD-HOSP-TABLE-SUB FROM 1 BY 1
105600          UNTIL CHILD-HOSP-SWI-FOUND
105700             OR CHILD-HOSP-TABLE-SUB = TOTAL-NUM-OF-CHILD-HOSP
105800      IF CHILD-HOSP-SWI-FOUND
105900          MOVE CHILD-HOSP-SWI (CHILD-HOSP-TABLE-SUB) TO
106000             BUN-CBSA-W-INDEX
106100          GO TO 0800-FIND-EXIT.
106200
106300     MOVE BUN-MAX-DATE            TO BUN-SUB.
106400
106500* FOR CY 2015 VERSION 0 ADDED NEXT LINE TO HOLD THE YEAR CODE
106600* THAT WILL BE USED TO CHECK THAT THE YEAR OF THE WAGE INDEX
106700* THAT'S BEING USED TO PRICE THE CLAIM IS THE SAME AS THE YEAR
106800* OF THE CLAIM
106900*    MOVE B-THRU-DATE (4:1)   TO B-THRU-YEAR-CODE.
107000* CY2020 CHANGED TO ALLOW PRICING OF 2020 AND LATER CLAIMS
107100     MOVE B-THRU-CCYY (3:2)   TO B-THRU-YEAR-CODE.
107200     COMPUTE B-THRU-YEAR-CODE = B-THRU-YEAR-CODE - 10.
107300
107400     PERFORM UNTIL B-THRU-DATE NOT < BUN-DATE (BUN-SUB)
107500         SUBTRACT 1 FROM BUN-SUB
107600     END-PERFORM.
107700
107800     SEARCH ALL BUN-CBSA-ENTRY
107900       AT END
108000          IF MAINFRAME-PC-SWITCH = DS-ERROR-CODE  THEN
108100             MOVE 60              TO PPS-RTC
108200             GO TO 0800-FIND-EXIT
108300          ELSE
108400             MOVE 61              TO PPS-RTC
108500             GO TO 0800-FIND-EXIT
108600          END-IF
108700       WHEN BUN-CBSA-VALUE (BUN-INDX) = P-GEO-CBSA
108800          MOVE BUN-PTR (BUN-INDX) TO W-SUB3
108900          PERFORM 0850-GET-BUNDLED-CBSA-RATE
109000             THRU 0850-BUNDLED-EXIT
109100     END-SEARCH.
109200
109300*** SUPPLEMENTAL WAGE INDEX ***
109400* WHEN P-SUPP-WI-IND = '1' THE SUPPLEMENTAL WAGE INDEX FIELD
109500* CONTAINS THE PRIOR YEAR'S ESRD WAGE INDEX.
109600* THIS CALCULATION CAPS THE ESRD WAGE INDEX DECREASE AT 5%.
109700
109800     IF B-THRU-DATE > 20200930
109900        IF P-SUPP-WI-IND = '1'
110000           IF P-SUPP-WI > 0
110100             COMPUTE H-ESRD-SUPP-WI-RATIO =
110200              (BUN-CBSA-W-INDEX - P-SUPP-WI) / P-SUPP-WI
110300             IF H-ESRD-SUPP-WI-RATIO < -0.05
110400                COMPUTE BUN-CBSA-W-INDEX ROUNDED =
110500                  P-SUPP-WI * 0.95
110600             END-IF
110700             GO TO 0800-FIND-EXIT
110800           ELSE
110900             MOVE 60 TO PPS-RTC
111000             GO TO 0800-FIND-EXIT
111100           END-IF
111200       END-IF
111300     END-IF.
111400
111500 0800-FIND-EXIT.
111600      EXIT.
111700
111800 0820-SEARCH-CHILD-HOSP-TABLE.
111900     IF CHILD-HOSP-PROV (CHILD-HOSP-TABLE-SUB) = P-PROV-OSCAR
112000        SET CHILD-HOSP-SWI-FOUND TO TRUE.
112100
112200 0850-GET-BUNDLED-CBSA-RATE.
112300**** Replaced the 850 paragraph from 2014
112400**** to fix a problem with the CBSA lookup that would
112500**** cause it to price with wage indexes from previous years if
112600**** it couldn't find a wage index to match the year of the claim
112700* CY 2015 ADD CHECK TO MAKE SURE THAT THE YEAR OF THE
112800* WAGE INDEX RECORD IS THE SAME AS THE YEAR OF THE BILL
112900     IF
113000        (BUN-WI-DATE-CODE (W-SUB3) =
113100         B-THRU-YEAR-CODE)
113200     THEN
113300        MOVE BUN-DATE (BUN-SUB)   TO BUN-CBSA-DATE
113400        MOVE BUN-WAGE-INDEX (W-SUB3)
113500                                  TO BUN-CBSA-W-INDEX
113600     ELSE
113700        SUBTRACT 1 FROM W-SUB3
113800        IF W-SUB3 > BUN-PTR (BUN-INDX - 1)
113900        THEN GO TO 0850-GET-BUNDLED-CBSA-RATE
114000        ELSE
114100          MOVE 0                 TO BUN-CBSA-W-INDEX
114200* FOR CY 2015 VERSION 0 ADDED ASSIGNMENT OF RETURN CODE
114300* WHEN THERE IS NO CBSA FOUND FOR THE YEAR OF THE CLAIM
114400           MOVE 60 TO PPS-RTC
114500        END-IF
114600     END-IF.
114700* the following code is the old way to search the Wage Index
114800* Table that was dropped because it would price claims using
114900* a CBSA with a previous year's Wage Index even though the
115000* CBSA had been dropped for the year of the claim
115100*0850-GET-BUNDLED-CBSA-RATE.
115200*    IF BUN-WI-DATE-CODE (W-SUB3) NOT > BUN-DATE-CODE (BUN-SUB)
115300*                                                  THEN
115400*       MOVE BUN-DATE (BUN-SUB)   TO BUN-CBSA-DATE
115500*       MOVE BUN-WAGE-INDEX (W-SUB3)
115600*                                 TO BUN-CBSA-W-INDEX
115700*    ELSE
115800*       SUBTRACT 1 FROM W-SUB3
115900*       IF W-SUB3 > BUN-PTR (BUN-INDX - 1)  THEN
116000*          GO TO 0850-GET-BUNDLED-CBSA-RATE
116100*       ELSE
116200*          MOVE 0                 TO BUN-CBSA-W-INDEX
116300*       END-IF
116400*    END-IF.
116500 0850-BUNDLED-EXIT.
116600     EXIT.
