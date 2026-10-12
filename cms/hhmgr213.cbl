000100 IDENTIFICATION DIVISION.                                         00010032
000200 PROGRAM-ID.    HHMGR213.                                         00020037
000300                                                                  00030032
000400*----------------------------------------------------------------*00040032
000500*  THIS PROGRAM CALLS HHOPN213                                   *00050037
000600*----------------------------------------------------------------*00060032
000700                                                                  00070032
000800 DATE-COMPILED.                                                   00080032
000900 ENVIRONMENT                     DIVISION.                        00090032
001000                                                                  00100032
001100 CONFIGURATION                   SECTION.                         00110032
001200 SOURCE-COMPUTER.                IBM-370.                         00120032
001300 OBJECT-COMPUTER.                IBM-370.                         00130032
001400                                                                  00140032
001500 INPUT-OUTPUT SECTION.                                            00150032
001600 FILE-CONTROL.                                                    00160032
001700                                                                  00170032
001800     SELECT HHAFILE    ASSIGN TO UT-S-HHAFILE                     00180032
001900         FILE STATUS IS UT1-STAT.                                 00190032
002000     SELECT OUTFILE    ASSIGN TO UT-S-OUTFILE                     00200032
002100         FILE STATUS IS UT2-STAT.                                 00210032
002200     SELECT PRTFILE    ASSIGN TO UT-S-PRTFILE                     00220032
002300         FILE STATUS IS PRT-STAT.                                 00230032
002400                                                                  00240032
002500 DATA DIVISION.                                                   00250032
002600 FILE SECTION.                                                    00260032
002700 FD  HHAFILE                                                      00270032
002800     LABEL RECORDS ARE STANDARD                                   00280032
002900     RECORDING MODE IS F                                          00290032
003000     BLOCK CONTAINS 0 RECORDS.                                    00300032
003100 01  HHA-REC                     PIC X(650).                      00310032
003200                                                                  00320032
003300 FD  OUTFILE                                                      00330032
003400     LABEL RECORDS ARE STANDARD                                   00340032
003500     RECORDING MODE IS F                                          00350032
003600     BLOCK CONTAINS 0 RECORDS.                                    00360032
003700 01  OUT-REC                     PIC X(650).                      00370032
003800                                                                  00380032
003900 FD  PRTFILE                                                      00390032
004000     RECORDING MODE IS F                                          00400032
004100     BLOCK CONTAINS 133 RECORDS                                   00410032
004200     LABEL RECORDS ARE STANDARD.                                  00420032
004300 01  PRTFILE-LINE                PIC X(133).                      00430032
004400                                                                  00440032
004500                                                                  00450032
004600 WORKING-STORAGE SECTION.                                         00460032
004610 01  FILLER                         PIC X(40)  VALUE              00461032
004620     'HHMGR    - W O R K I N G   S T O R A G E'.                  00462032
004630 01  HHMGR-VERSION               PIC X(09)  VALUE 'M2021.3'.      00463037
004640 01  HHOPN213                    PIC X(08)  VALUE 'HHOPN213'.     00464037
004650 01  SUB1                        PIC 9(03)  VALUE 0.              00465032
004660 01  EOF-SW                      PIC 9(01)  VALUE 0.              00466032
004670 01  LINE-CTR                    PIC 9(02)  VALUE 65.             00467032
004680 01  HHAFILE-CTR                 PIC 9(09)  VALUE 0.              00468032
004690 01  OUTFILE-CTR                 PIC 9(09)  VALUE 0.              00469032
004700 01  PRTFILE-CTR                 PIC 9(09)  VALUE 0.              00470032
004800 01  UT1-STAT.                                                    00480032
004900     05  UT1-STAT1               PIC X.                           00490032
005000     05  UT1-STAT2               PIC X.                           00500032
005100 01  UT2-STAT.                                                    00510032
005200     05  UT2-STAT1               PIC X.                           00520032
005300     05  UT2-STAT2               PIC X.                           00530032
005400 01  PRT-STAT.                                                    00540032
005500     05  PRT-STAT1               PIC X.                           00550032
005600     05  PRT-STAT2               PIC X.                           00560032
005700*----------------------------------------------------------------*00570032
005800*  INPUT/OUTPUT RECORD LAYOUT - PIC X(650)                       *00580032
005900*  THIS RECORD WAS MODIFIED FOR THE 01/01/2020 RELEASE           *00590032
006000*----------------------------------------------------------------*00600032
006100 01  HHA-INPUT-DATA.                                              00610032
006200     05  HHA-DATA.                                                00620032
006300         10  HHA-NPI                 PIC X(10).                   00630032
006400         10  HHA-HIC                 PIC X(12).                   00640032
006500         10  HHA-PROV-NO             PIC X(06).                   00650032
006600         10  HHA-INIT-PAY-QRP-INDICATOR  PIC X(01).               00660032
006700             88  HHA-WITH-DATA-CHECK VALUE '0', '1'.              00670032
006800             88  HHA-NO-DATA-CHECK   VALUE '2', '3'.              00680032
006810         10  HHA-PROV-VBP-ADJ-FAC    PIC 9V9(5).                  00681032
006820         10  HHA-PROV-OUTLIER-PAY-TOTAL PIC 9(08)V9(02).          00682032
006830         10  HHA-PROV-PAYMENT-TOTAL  PIC 9(09)V9(02).             00683032
006840         10  HHA-TOB                 PIC X(03).                   00684032
006850             88 HHA-VALID-TOB-CLAIM  VALUE                        00685032
006860             '327', '329',                                        00686032
006870             '32F', '32G', '32H', '32I', '32J',                   00687032
006880             '32K', '32M', '32Q', '32P'.                          00688032
006890             88 H-VALID-TOB-RAP     VALUE                         00689032
006900             '322'.                                               00690032
006901         10  HHA-CBSA                PIC X(05).                   00690132
006902         10  HHA-COUNTY-CODE         PIC X(05).                   00690232
006903         10  HHA-SERV-FROM-DATE.                                  00690332
006904             15  HHA-FROM-CC         PIC XX.                      00690432
006905             15  HHA-FROM-YYMMDD.                                 00690532
006906                 25  HHA-FROM-YY     PIC XX.                      00690632
006907                 25  HHA-FROM-MM     PIC XX.                      00690732
006908                 25  HHA-FROM-DD     PIC XX.                      00690832
006909         10  HHA-SERV-THRU-DATE.                                  00690932
006910             15  HHA-THRU-CC         PIC XX.                      00691032
006911             15  HHA-THRU-YYMMDD.                                 00691132
006912                 25  HHA-THRU-YY     PIC XX.                      00691232
006913                 25  HHA-THRU-MM     PIC XX.                      00691332
006914                 25  HHA-THRU-DD     PIC XX.                      00691432
006915         10  HHA-ADMIT-DATE.                                      00691532
006916             15  HHA-ADMIT-CC        PIC XX.                      00691632
006917             15  HHA-ADMIT-YYMMDD.                                00691732
006918                 25  HHA-ADMIT-YY    PIC XX.                      00691832
006919                 25  HHA-ADMIT-MM    PIC XX.                      00691932
006920                 25  HHA-ADMIT-DD    PIC XX.                      00692032
006921         10  HHA-LUPA-SRC-ADM           PIC X.                    00692132
006922         10  HHA-ADJ-IND                PIC X.                    00692232
006923         10  HHA-PEP-INDICATOR       PIC X.                       00692332
006924         10  HHA-HRG-INPUT-CODE       PIC X(05).                  00692432
006925         10  HHA-HRG-NO-OF-DAYS       PIC 9(03).                  00692532
006926         10  HHA-HRG-WGTS             PIC 9(02)V9(04).            00692632
006927         10  HHA-HRG-PAY              PIC 9(07)V9(02).            00692732
006928         10  HHA-REVENUE-DATA     OCCURS 6.                       00692832
006929             15  HHA-REVENUE-CODE              PIC X(04).         00692932
006930             15  HHA-REVENUE-QTY-COV-VISITS    PIC 9(03).         00693032
006931             15  HHA-REVENUE-QTY-OUTL-UNITS    PIC 9(05).         00693132
006932             15  HHA-REVENUE-EARLIEST-DATE     PIC 9(08).         00693232
006933             15  HHA-REVENUE-DOLL-RATE         PIC 9(07)V9(02).   00693332
006934             15  HHA-REVENUE-COST              PIC 9(07)V9(02).   00693432
006935             15  HHA-REVENUE-ADD-ON-VISIT-AMT  PIC 9(07)V9(02).   00693532
006936         10  HHA-PAY-RTC                PIC 99.                   00693632
006937         10  HHA-REVENUE-SUM1-6-QTY-ALL PIC 9(05).                00693732
006938         10  HHA-OUTLIER-PAYMENT        PIC 9(07)V9(02).          00693832
006939         10  HHA-TOTAL-PAYMENT          PIC 9(07)V9(02).          00693932
006940     05  HHA-VBP-ADJ-AMT                PIC S9(7)V99.             00694032
006941     05  HHA-PPS-STD-VALUE              PIC 9(7)V99.              00694132
006942     05  HHA-RECEIPT-DATE           PIC X(8).                     00694232
006943     05  HHA-OVERRIDE-IND           PIC X(1).                     00694332
006944     05  HHA-LATE-SUB-PEN-AMT       PIC 9(7)V9(2).                00694432
006945     05  FILLER                     PIC X(188).                   00694532
006946                                                                  00694632
006947 01  HOLD-VARIABLES-DATA.                                         00694732
006948     02  HOLD-VAR-DATA.                                           00694832
006949         05  PRICER-OPTION-SW         PIC X.                      00694932
006950         05  HHOPN-VERSION            PIC X(07).                  00695032
006960         05  HHDRV-VERSION            PIC X(07).                  00696032
006970         05  HHCAL-VERSION            PIC X(07).                  00697032
006980         05  FILLER                   PIC X(20).                  00698032
006990                                                                  00699032
007000                                                                  00700032
007100 01  TOTAL-COUNTERS.                                              00710032
007200     03  FILLER    OCCURS 23.                                     00720034
007300         05  COUNT-TOTAL       PIC 9(09)  COMP.                   00730032
007400                                                                  00740032
007500*******************************************************           00750032
007600*----------------------------------------------------**           00760032
007700*    HHA PAYMENT REPORT COMPONENTS                    *           00770032
007800*----------------------------------------------------**           00780032
007900 01  HHA-DETAIL-LINE.                                             00790032
008000     05  FILLER                  PIC X(02)  VALUE SPACES.         00800032
008100     05  PRT-NPI                 PIC X(10).                       00810032
008200     05  FILLER                  PIC X(02).                       00820032
008300     05  PRT-HIC                 PIC X(12).                       00830032
008400     05  FILLER                  PIC X(02).                       00840032
008500     05  PRT-PROV                PIC X(06).                       00850032
008600     05  FILLER                  PIC X(02)  VALUE SPACES.         00860032
008700     05  PRT-MSA-CBSA            PIC X(05).                       00870032
008800     05  FILLER                  PIC X(01)  VALUE SPACES.         00880032
008900     05  PRT-FROM-DATE           PIC X(08).                       00890032
009000     05  FILLER                  PIC X(03)  VALUE SPACES.         00900032
009100     05  PRT-PEP                 PIC X.                           00910032
009200     05  FILLER                  PIC X(02)  VALUE SPACES.         00920032
009300     05  PRT-MED-IND1            PIC X.                           00930032
009400     05  PRT-MED-IND2            PIC X.                           00940032
009500     05  PRT-MED-IND3            PIC X.                           00950032
009600     05  PRT-MED-IND4            PIC X.                           00960032
009700     05  PRT-MED-IND5            PIC X.                           00970032
009800     05  PRT-MED-IND6            PIC X.                           00980032
009900     05  FILLER                  PIC X(01)  VALUE SPACES.         00990032
010000     05  PRT-TOB                 PIC XXX.                         01000032
010100     05  PRT-OUTLIER-PAY         PIC $$,$$$,$$$.99.               01010032
010200     05  PRT-PAYMENT-RATE        PIC $$,$$$,$$$.99.               01020032
010300     05  FILLER                  PIC X(01)  VALUE SPACES.         01030032
010400     05  FILLER                  PIC X(01)  VALUE SPACES.         01040032
010500     05  PRT-HHA-RTC             PIC 99.                          01050032
010600     05  FILLER                  PIC X(01)  VALUE SPACES.         01060032
010700     05  PRT-13-QTY              PIC X(5).                        01070032
010800     05  FILLER                  PIC X(01)  VALUE '/'.            01080032
010900     05  PRT-16-QTY              PIC X(5).                        01090032
011000     05  FILLER                  PIC X(02)  VALUE SPACES.         01100032
011100     05  PRT-INIT-PAY-IND        PIC X.                           01110032
011200     05  FILLER                  PIC X(01)  VALUE SPACES.         01120032
011300     05  PRT-THRU-DATE           PIC X(08).                       01130032
011400     05  PRT-REV-DOLL-RATE-1     PIC $$,$$$,$$$.99.               01140032
011500                                                                  01150032
011600 01  HHA-HEAD1.                                                   01160032
011700     05  FILLER                  PIC X(01)  VALUE SPACES.         01170032
011800     05  FILLER                  PIC X(44)  VALUE                 01180032
011900        ' C M S,                                     '.           01190032
012000     05  FILLER                  PIC X(44)  VALUE                 01200032
012100        '                                            '.           01210032
012200     05  FILLER                  PIC X(44)  VALUE                 01220032
012300        '                                            '.           01230032
012400                                                                  01240032
012500 01  HHA-HEAD2.                                                   01250032
012600     05  FILLER                  PIC X(01)  VALUE SPACES.         01260032
012700     05  FILLER                  PIC X(44)  VALUE                 01270032
012800        ' PBG,DDS     HHA NATIONAL PRICER            '.           01280032
012900     05  FILLER                  PIC X(44)  VALUE                 01290032
013000        '                          T E S T   D A T A '.           01300032
013100     05  FILLER                  PIC X(44)  VALUE                 01310032
013200        '  R E P O R T                               '.           01320032
013300                                                                  01330032
013400 01  HHA-HEAD3.                                                   01340032
013500     05  FILLER                  PIC X(01)  VALUE SPACES.         01350032
013600     05  FILLER                  PIC X(44)  VALUE                 01360032
013700        '    NPI         HIC         PROV           F'.           01370032
013800     05  FILLER                  PIC X(44)  VALUE                 01380032
013900        'ROM    PEP  MED   TOB    OUTLIER         TOT'.           01390032
014000     05  FILLER                  PIC X(44)  VALUE                 01400032
014100        'AL   RTC SUM3/SUM6  PAY  THRU        REV-1  '.           01410032
014200                                                                  01420032
014300 01  HHA-HEAD4.                                                   01430032
014400     05  FILLER                  PIC X(01)  VALUE SPACES.         01440032
014500     05  FILLER                  PIC X(44)  VALUE                 01450032
014600        '    NO.         NO.         NO.  MSA/CBSA  D'.           01460032
014700     05  FILLER                  PIC X(44)  VALUE                 01470032
014800        'ATE    COD  COD          PAYMENT        PAYM'.           01480032
014900     05  FILLER                  PIC X(44)  VALUE                 01490032
015000        'ENT         QTY     IND  DATE        RATE   '.           01500032
015100                                                                  01510032
015200**--------------------------------------------------------------  01520032
015300 PROCEDURE  DIVISION.                                             01530032
015400                                                                  01540032
015500 0000-MAINLINE  SECTION.                                          01550032
015600     OPEN INPUT  HHAFILE                                          01560032
015700          OUTPUT OUTFILE                                          01570032
015800          OUTPUT PRTFILE.                                         01580032
015900                                                                  01590032
016000     MOVE LOW-VALUES TO TOTAL-COUNTERS.                           01600032
016100                                                                  01610032
016200     PERFORM 0100-PROCESS-RECORDS THRU 0100-EXIT UNTIL EOF-SW = 1.01620032
016300                                                                  01630032
016400     DISPLAY ' '.                                                 01640032
016500                                                                  01650032
016600     DISPLAY '-- PROGRAM HHMGR213  VERSION  ===> ' HHMGR-VERSION. 01660037
016700     DISPLAY '-- PROGRAM HHOPN213  VERSION  ===> ' HHOPN-VERSION. 01670037
016800     DISPLAY '-- PROGRAM HHDRV213  VERSION  ===> ' HHDRV-VERSION. 01680037
016900                                                                  01690032
017000     DISPLAY ' '.                                                 01700032
017100                                                                  01710032
017200     IF COUNT-TOTAL (1) > 0                                       01720032
017300         DISPLAY '-- PROGRAM HHCAL016  VERSION  ===> P2001.6 '.   01730032
017400     IF COUNT-TOTAL (2) > 0                                       01740032
017500         DISPLAY '-- PROGRAM HHCAL023  VERSION  ===> P2002.3 '.   01750032
017600     IF COUNT-TOTAL (3) > 0                                       01760032
017700         DISPLAY '-- PROGRAM HHCAL033  VERSION  ===> P2003.3 '.   01770032
017800     IF COUNT-TOTAL (4) > 0                                       01780032
017900         DISPLAY '-- PROGRAM HHCAL044  VERSION  ===> P2004.4 '.   01790032
018000     IF COUNT-TOTAL (5) > 0                                       01800032
018100         DISPLAY '-- PROGRAM HHCAL053  VERSION  ===> P2005.3 '.   01810032
018200     IF COUNT-TOTAL (6) > 0                                       01820032
018300         DISPLAY '-- PROGRAM HHCAL066  VERSION  ===> P2006.6 '.   01830032
018400     IF COUNT-TOTAL (7) > 0                                       01840032
018500         DISPLAY '-- PROGRAM HHCAL074  VERSION  ===> P2007.4 '.   01850032
018600     IF COUNT-TOTAL (8) > 0                                       01860032
018700         DISPLAY '-- PROGRAM HHCAL088  VERSION  ===> P2008.8 '.   01870032
018800     IF COUNT-TOTAL (9) > 0                                       01880032
018900         DISPLAY '-- PROGRAM HHCAL095  VERSION  ===> P2009.5 '.   01890032
019000     IF COUNT-TOTAL (10) > 0                                      01900032
019100         DISPLAY '-- PROGRAM HHCAL10D  VERSION  ===> P2010.D '.   01910032
019200     IF COUNT-TOTAL (11) > 0                                      01920032
019300         DISPLAY '-- PROGRAM HHCAL10A  VERSION  ===> P2010.A '.   01930032
019400     IF COUNT-TOTAL (12) > 0                                      01940032
019500         DISPLAY '-- PROGRAM HHCAL112  VERSION  ===> P2011.2 '.   01950032
019600     IF COUNT-TOTAL (13) > 0                                      01960032
019700         DISPLAY '-- PROGRAM HHCAL121  VERSION  ===> P2012.1 '.   01970032
019800     IF COUNT-TOTAL (14) > 0                                      01980032
019900         DISPLAY '-- PROGRAM HHCAL131  VERSION  ===> P2013.1 '.   01990032
020000     IF COUNT-TOTAL (15) > 0                                      02000032
020100         DISPLAY '-- PROGRAM HHCAL144  VERSION  ===> P2014.4 '.   02010032
020200     IF COUNT-TOTAL (16) > 0                                      02020032
020300         DISPLAY '-- PROGRAM HHCAL152  VERSION  ===> P2015.2 '.   02030032
020400     IF COUNT-TOTAL (17) > 0                                      02040032
020500         DISPLAY '-- PROGRAM HHCAL160  VERSION  ===> P2016.0 '.   02050032
020600     IF COUNT-TOTAL (18) > 0                                      02060032
020700         DISPLAY '-- PROGRAM HHCAL170  VERSION  ===> P2017.0 '.   02070032
020800     IF COUNT-TOTAL (19) > 0                                      02080032
020900         DISPLAY '-- PROGRAM HHCAL181  VERSION  ===> P2018.1 '.   02090032
021000     IF COUNT-TOTAL (20) > 0                                      02100032
021100         DISPLAY '-- PROGRAM HHCAL190  VERSION  ===> P2019.0 '.   02110032
021200     IF COUNT-TOTAL (21) > 0                                      02120032
021300         DISPLAY '-- PROGRAM HHCAL200  VERSION  ===> P2020.0 '.   02130034
021310     IF COUNT-TOTAL (22) > 0                                      02131035
021320         DISPLAY '-- PROGRAM HHCAL213  VERSION  ===> P2021.3 '.   02132037
021400                                                                  02140032
021500     DISPLAY ' '.                                                 02150032
021600                                                                  02160032
021700     IF COUNT-TOTAL (1) > 0                                       02170032
021800        DISPLAY '-- FY2001 RECORD COUNT  ===> ' COUNT-TOTAL (1).  02180032
021900     IF COUNT-TOTAL (2) > 0                                       02190032
022000        DISPLAY '-- FY2002 RECORD COUNT  ===> ' COUNT-TOTAL (2).  02200032
022100     IF COUNT-TOTAL (3) > 0                                       02210032
022200        DISPLAY '-- FY2003 RECORD COUNT  ===> ' COUNT-TOTAL (3).  02220032
022300     IF COUNT-TOTAL (4) > 0                                       02230032
022400        DISPLAY '-- FY2004 RECORD COUNT  ===> ' COUNT-TOTAL (4).  02240032
022500     IF COUNT-TOTAL (5) > 0                                       02250032
022600        DISPLAY '-- FY2005 RECORD COUNT  ===> ' COUNT-TOTAL (5).  02260032
022700     IF COUNT-TOTAL (6) > 0                                       02270032
022800        DISPLAY '-- CY2006 RECORD COUNT  ===> ' COUNT-TOTAL (6).  02280032
022900     IF COUNT-TOTAL (7) > 0                                       02290032
023000        DISPLAY '-- CY2007 RECORD COUNT  ===> ' COUNT-TOTAL (7).  02300032
023100     IF COUNT-TOTAL (8) > 0                                       02310032
023200        DISPLAY '-- CY2008 RECORD COUNT  ===> ' COUNT-TOTAL (8).  02320032
023300     IF COUNT-TOTAL (9) > 0                                       02330032
023400        DISPLAY '-- CY2009 RECORD COUNT  ===> ' COUNT-TOTAL (9).  02340032
023500     IF COUNT-TOTAL (10) > 0                                      02350032
023600        DISPLAY '-- CY2010C RECORD COUNT ===> ' COUNT-TOTAL (10). 02360032
023700     IF COUNT-TOTAL (11) > 0                                      02370032
023800        DISPLAY '-- CY20109 RECORD COUNT ===> ' COUNT-TOTAL (11). 02380032
023900     IF COUNT-TOTAL (12) > 0                                      02390032
024000        DISPLAY '-- CY2011  RECORD COUNT ===> ' COUNT-TOTAL (12). 02400032
024100     IF COUNT-TOTAL (13) > 0                                      02410032
024200        DISPLAY '-- CY2012  RECORD COUNT ===> ' COUNT-TOTAL (13). 02420032
024300     IF COUNT-TOTAL (14) > 0                                      02430032
024400        DISPLAY '-- CY2013  RECORD COUNT ===> ' COUNT-TOTAL (14). 02440032
024500     IF COUNT-TOTAL (15) > 0                                      02450032
024600        DISPLAY '-- CY2014  RECORD COUNT ===> ' COUNT-TOTAL (15). 02460032
024700     IF COUNT-TOTAL (16) > 0                                      02470032
024800        DISPLAY '-- CY2015  RECORD COUNT ===> ' COUNT-TOTAL (16). 02480032
024900     IF COUNT-TOTAL (17) > 0                                      02490032
025000        DISPLAY '-- CY2016  RECORD COUNT ===> ' COUNT-TOTAL (17). 02500032
025100     IF COUNT-TOTAL (18) > 0                                      02510032
025200        DISPLAY '-- CY2017  RECORD COUNT ===> ' COUNT-TOTAL (18). 02520032
025300     IF COUNT-TOTAL (19) > 0                                      02530032
025400        DISPLAY '-- CY2018  RECORD COUNT ===> ' COUNT-TOTAL (19). 02540032
025500     IF COUNT-TOTAL (20) > 0                                      02550032
025600        DISPLAY '-- CY2019  RECORD COUNT ===> ' COUNT-TOTAL (20). 02560032
025700     IF COUNT-TOTAL (21) > 0                                      02570032
025800        DISPLAY '-- CY2020  RECORD COUNT ===> ' COUNT-TOTAL (21). 02580032
025810     IF COUNT-TOTAL (22) > 0                                      02581034
025820        DISPLAY '-- CY2021  RECORD COUNT ===> ' COUNT-TOTAL (22). 02582034
025900                                                                  02590032
026000     DISPLAY ' '.                                                 02600032
026100                                                                  02610032
026200     DISPLAY '-- INPUT  COUNTS FOR HHAFILE  ===> ' HHAFILE-CTR.   02620032
026300     DISPLAY '-- OUTPUT COUNTS FOR OUTFILE  ===> ' OUTFILE-CTR.   02630032
026400     DISPLAY '-- OUTPUT COUNTS FOR PRTFILE  ===> ' PRTFILE-CTR.   02640032
026500                                                                  02650032
026600     CLOSE HHAFILE.                                               02660032
026700     CLOSE OUTFILE.                                               02670032
026800     CLOSE PRTFILE.                                               02680032
026900                                                                  02690032
027000     STOP RUN.                                                    02700032
027100                                                                  02710032
027200 0100-PROCESS-RECORDS.                                            02720032
027300     READ HHAFILE INTO HHA-INPUT-DATA                             02730032
027400         AT END                                                   02740032
027500             MOVE 1 TO EOF-SW                                     02750032
027600             GO TO 0100-EXIT.                                     02760032
027700                                                                  02770032
027800     ADD 1 TO HHAFILE-CTR.                                        02780032
027900                                                                  02790032
028000     MOVE ALL '0' TO HOLD-VAR-DATA                                02800032
028100     INITIALIZE      HHA-PAY-RTC                                  02810032
028200                     HHA-REVENUE-SUM1-6-QTY-ALL                   02820032
028300                     HHA-OUTLIER-PAYMENT                          02830032
028400                     HHA-TOTAL-PAYMENT                            02840032
028500                     HHA-VBP-ADJ-AMT                              02850032
028600                     HHA-PPS-STD-VALUE.                           02860032
028700                                                                  02870032
028800     IF  EOF-SW = 0                                               02880032
028900         PERFORM 0400-APPLY-COUNTERS THRU 0400-EXIT               02890032
029000         PERFORM 0200-CALL-DRV THRU 0200-EXIT                     02900032
029100         PERFORM 1100-WRITE THRU 1100-EXIT.                       02910032
029200                                                                  02920032
029300 0100-EXIT.  EXIT.                                                02930032
029400 0200-CALL-DRV.                                                   02940032
029500         MOVE 'A' TO PRICER-OPTION-SW                             02950032
029600         CALL  HHOPN213   USING HHA-INPUT-DATA                    02960037
029700                                HOLD-VARIABLES-DATA.              02970035
029800                                                                  02980032
029900 0200-EXIT.  EXIT.                                                02990032
030000 0400-APPLY-COUNTERS.                                             03000032
030100                                                                  03010032
030200      IF HHA-SERV-THRU-DATE < 20020101                            03020032
030300         ADD 1 TO COUNT-TOTAL (1)                                 03030032
030400         GO TO 0400-EXIT.                                         03040032
030500                                                                  03050032
030600      IF HHA-SERV-THRU-DATE < 20030101                            03060032
030700         ADD 1 TO COUNT-TOTAL (2)                                 03070032
030800         GO TO 0400-EXIT.                                         03080032
030900                                                                  03090032
031000      IF HHA-SERV-THRU-DATE < 20040101                            03100032
031100         ADD 1 TO COUNT-TOTAL (3)                                 03110032
031200         GO TO 0400-EXIT.                                         03120032
031300                                                                  03130032
031400      IF HHA-SERV-THRU-DATE < 20050101                            03140032
031500         ADD 1 TO COUNT-TOTAL (4)                                 03150032
031600         GO TO 0400-EXIT.                                         03160032
031700                                                                  03170032
031800      IF HHA-SERV-THRU-DATE < 20060101                            03180032
031900         ADD 1 TO COUNT-TOTAL (5)                                 03190032
032000         GO TO 0400-EXIT.                                         03200032
032100                                                                  03210032
032200      IF HHA-SERV-THRU-DATE < 20070101                            03220032
032300         ADD 1 TO COUNT-TOTAL (6)                                 03230032
032400         GO TO 0400-EXIT.                                         03240032
032500                                                                  03250032
032600      IF HHA-SERV-THRU-DATE < 20080101                            03260032
032700         ADD 1 TO COUNT-TOTAL (7)                                 03270032
032800         GO TO 0400-EXIT.                                         03280032
032900                                                                  03290032
033000      IF HHA-SERV-THRU-DATE < 20090101                            03300032
033100         ADD 1 TO COUNT-TOTAL (8)                                 03310032
033200         GO TO 0400-EXIT.                                         03320032
033300                                                                  03330032
033400      IF HHA-SERV-THRU-DATE < 20100101                            03340032
033500         ADD 1 TO COUNT-TOTAL (9)                                 03350032
033600         GO TO 0400-EXIT.                                         03360032
033700                                                                  03370032
033800      IF HHA-SERV-THRU-DATE < 20100401                            03380032
033900         ADD 1 TO COUNT-TOTAL (10)                                03390032
034000         GO TO 0400-EXIT.                                         03400032
034100                                                                  03410032
034200      IF HHA-SERV-THRU-DATE < 20110101                            03420032
034300         ADD 1 TO COUNT-TOTAL (11)                                03430032
034400         GO TO 0400-EXIT.                                         03440032
034500                                                                  03450032
034600      IF HHA-SERV-THRU-DATE < 20120101                            03460032
034700         ADD 1 TO COUNT-TOTAL (12)                                03470032
034800         GO TO 0400-EXIT.                                         03480032
034900                                                                  03490032
035000      IF HHA-SERV-THRU-DATE < 20130101                            03500032
035100         ADD 1 TO COUNT-TOTAL (13)                                03510032
035200         GO TO 0400-EXIT.                                         03520032
035300                                                                  03530032
035400      IF HHA-SERV-THRU-DATE < 20140101                            03540032
035500         ADD 1 TO COUNT-TOTAL (14)                                03550032
035600         GO TO 0400-EXIT.                                         03560032
035700                                                                  03570032
035800      IF HHA-SERV-THRU-DATE < 20150101                            03580032
035900         ADD 1 TO COUNT-TOTAL (15)                                03590032
036000         GO TO 0400-EXIT.                                         03600032
036100                                                                  03610032
036200      IF HHA-SERV-THRU-DATE < 20160101                            03620032
036300         ADD 1 TO COUNT-TOTAL (16)                                03630032
036400         GO TO 0400-EXIT.                                         03640032
036500                                                                  03650032
036600      IF HHA-SERV-THRU-DATE < 20170101                            03660032
036700         ADD 1 TO COUNT-TOTAL (17)                                03670032
036800         GO TO 0400-EXIT.                                         03680032
036900                                                                  03690032
037000      IF HHA-SERV-THRU-DATE < 20180101                            03700032
037100         ADD 1 TO COUNT-TOTAL (18)                                03710032
037200         GO TO 0400-EXIT.                                         03720032
037300                                                                  03730032
037400      IF HHA-SERV-THRU-DATE < 20190101                            03740032
037500         ADD 1 TO COUNT-TOTAL (19)                                03750032
037600         GO TO 0400-EXIT.                                         03760032
037700                                                                  03770032
037800      IF HHA-SERV-THRU-DATE < 20200101                            03780032
037900         ADD 1 TO COUNT-TOTAL (20)                                03790032
038000         GO TO 0400-EXIT.                                         03800032
038100                                                                  03810032
038200      IF HHA-SERV-THRU-DATE < 20210101                            03820032
038300         ADD 1 TO COUNT-TOTAL (21)                                03830032
038400         GO TO 0400-EXIT.                                         03840032
038500                                                                  03850032
038600      ADD 1 TO COUNT-TOTAL (22).                                  03860032
038700                                                                  03870032
038800 0400-EXIT.  EXIT.                                                03880032
038900                                                                  03890032
039000 1100-WRITE.                                                      03900032
039100                                                                  03910032
039200******************************************************************03920032
039300*    PRINT HHA PROSPECTIVE PAYMENT TEST DATA DETAIL REPORT        03930032
039400******************************************************************03940032
039500                                                                  03950032
039600     IF  LINE-CTR > 54                                            03960032
039700         PERFORM 1200-HHA-HEADINGS THRU 1200-EXIT.                03970032
039800                                                                  03980032
039900     MOVE SPACES          TO  HHA-DETAIL-LINE.                    03990032
040000                                                                  04000032
040100*    IF HHA-SERV-THRU-DATE < 20060101                             04010032
040200*       MOVE HHA-MSA2          TO PRT-MSA-CBSA                    04020032
040300*    ELSE                                                         04030032
040400*       MOVE HHA-CBSA          TO PRT-MSA-CBSA.                   04040032
040500                                                                  04050032
040600     MOVE HHA-CBSA           TO PRT-MSA-CBSA.                     04060032
040700     MOVE HHA-SERV-FROM-DATE TO PRT-FROM-DATE.                    04070032
040800     MOVE HHA-SERV-THRU-DATE TO PRT-THRU-DATE.                    04080032
040900                                                                  04090032
041000     MOVE HHA-NPI                TO PRT-NPI.                      04100032
041100     MOVE HHA-HIC                TO PRT-HIC.                      04110032
041200     MOVE HHA-PROV-NO            TO PRT-PROV.                     04120032
041300                                                                  04130032
041400*    MOVE HHA-REVENUE-SUM1-3-QTY-THR TO PRT-13-QTY.               04140032
041500     MOVE HHA-REVENUE-SUM1-6-QTY-ALL TO PRT-16-QTY.               04150032
041600                                                                  04160032
041700     MOVE HHA-PEP-INDICATOR          TO PRT-PEP.                  04170032
041800*    MOVE HHA-MED-REVIEW-INDICATOR (1)  TO PRT-MED-IND1.          04180032
041900*    MOVE HHA-MED-REVIEW-INDICATOR (2)  TO PRT-MED-IND2.          04190032
042000*    MOVE HHA-MED-REVIEW-INDICATOR (3)  TO PRT-MED-IND3.          04200032
042100*    MOVE HHA-MED-REVIEW-INDICATOR (4)  TO PRT-MED-IND4.          04210032
042200*    MOVE HHA-MED-REVIEW-INDICATOR (5)  TO PRT-MED-IND5.          04220032
042300*    MOVE HHA-MED-REVIEW-INDICATOR (6)  TO PRT-MED-IND6.          04230032
042400     MOVE HHA-TOB                    TO PRT-TOB.                  04240032
042500     MOVE HHA-INIT-PAY-QRP-INDICATOR TO PRT-INIT-PAY-IND.         04250032
042600                                                                  04260032
042700     MOVE HHA-OUTLIER-PAYMENT        TO PRT-OUTLIER-PAY.          04270032
042800     MOVE HHA-TOTAL-PAYMENT          TO PRT-PAYMENT-RATE.         04280032
042900     MOVE HHA-REVENUE-DOLL-RATE (1)  TO                           04290032
043000                                      PRT-REV-DOLL-RATE-1.        04300032
043100                                                                  04310032
043200     MOVE HHA-PAY-RTC                TO PRT-HHA-RTC.              04320032
043300                                                                  04330032
043400     WRITE PRTFILE-LINE FROM HHA-DETAIL-LINE                      04340032
043500                             AFTER ADVANCING 1.                   04350032
043600     ADD 1 TO PRTFILE-CTR.                                        04360032
043700     IF PRT-STAT1 > 0 DISPLAY ' BAD1 WRITE ON PRTFILE FILE'.      04370032
043800     ADD 1 TO LINE-CTR.                                           04380032
043900                                                                  04390032
044000******************************************************************04400032
044100*    WRITE OUT-REC FILE 600 BYTES TO GO INTO YOUR INTERFACE       04410032
044200******************************************************************04420032
044300     WRITE OUT-REC FROM HHA-INPUT-DATA.                           04430032
044400                                                                  04440032
044500     IF UT2-STAT1 > 0 DISPLAY ' BAD2 WRITE ON OUTFILE  FILE'.     04450032
044600     ADD 1 TO OUTFILE-CTR.                                        04460032
044700                                                                  04470032
044800 1100-EXIT.  EXIT.                                                04480032
044900                                                                  04490032
045000 1200-HHA-HEADINGS.                                               04500032
045100     WRITE PRTFILE-LINE FROM HHA-HEAD1                            04510032
045200                             AFTER ADVANCING PAGE.                04520032
045300     IF PRT-STAT1 > 0 DISPLAY ' BAD3 WRITE ON PRTFILE FILE'.      04530032
045400     WRITE PRTFILE-LINE FROM HHA-HEAD2                            04540032
045500                             AFTER ADVANCING 1.                   04550032
045600     IF PRT-STAT1 > 0 DISPLAY ' BAD5 WRITE ON PRTFILE FILE'.      04560032
045700     MOVE ALL '---' TO PRTFILE-LINE.                              04570032
045800     WRITE PRTFILE-LINE AFTER ADVANCING 1.                        04580032
045900     IF PRT-STAT1 > 0 DISPLAY ' BAD4 WRITE ON PRTFILE FILE'.      04590032
046000     WRITE PRTFILE-LINE FROM HHA-HEAD3                            04600032
046100                             AFTER ADVANCING 2.                   04610032
046200     IF PRT-STAT1 > 0 DISPLAY ' BAD6 WRITE ON PRTFILE FILE'.      04620032
046300     WRITE PRTFILE-LINE FROM HHA-HEAD4                            04630032
046400                             AFTER ADVANCING 1.                   04640032
046500     IF PRT-STAT1 > 0 DISPLAY ' BAD7 WRITE ON PRTFILE FILE'.      04650032
046600     MOVE ALL '  -' TO PRTFILE-LINE.                              04660032
046700     WRITE PRTFILE-LINE AFTER ADVANCING 1.                        04670032
046800     IF PRT-STAT1 > 0 DISPLAY ' BAD7 WRITE ON PRTFILE FILE'.      04680032
046900     MOVE 7 TO LINE-CTR.                                          04690032
047000                                                                  04700032
047100 1200-EXIT.  EXIT.                                                04710032
