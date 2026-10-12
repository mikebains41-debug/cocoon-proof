000100 IDENTIFICATION DIVISION.                                         00010028
000200 PROGRAM-ID.    HHOPN213.                                         00020034
000300                                                                  00030028
000400*----------------------------------------------------------------*00040028
000500*  THIS PROGRAM CALLS HHDRV213                                   *00050034
000600*----------------------------------------------------------------*00060028
000700                                                                  00070028
000800 DATE-COMPILED.                                                   00080028
000900 ENVIRONMENT                     DIVISION.                        00090028
001000                                                                  00100028
001100 CONFIGURATION                   SECTION.                         00110028
001200 SOURCE-COMPUTER.                IBM-370.                         00120028
001300 OBJECT-COMPUTER.                IBM-370.                         00130028
001400                                                                  00140028
001500 INPUT-OUTPUT SECTION.                                            00150028
001600 FILE-CONTROL.                                                    00160028
001700                                                                  00170028
001800     SELECT MSAFILE    ASSIGN TO UT-S-MSAFILE                     00180028
001900         FILE STATUS IS MSA-STAT.                                 00190028
002000     SELECT CBSAFILE   ASSIGN TO UT-S-CBSAFILE                    00200028
002100         FILE STATUS IS CBSA-STAT.                                00210028
002200     SELECT HRGTABL    ASSIGN TO UT-S-HRGTABL                     00220028
002300         FILE STATUS IS HRG-STAT.                                 00230028
002400     SELECT REVTABL    ASSIGN TO UT-S-REVTABL                     00240028
002500         FILE STATUS IS REV-STAT.                                 00250028
002600                                                                  00260028
002700 DATA DIVISION.                                                   00270028
002800 FILE SECTION.                                                    00280028
002900                                                                  00290028
003000 FD  MSAFILE                                                      00300028
003100     RECORDING MODE IS F                                          00310028
003200     LABEL RECORDS ARE STANDARD.                                  00320028
003300 01  MSA-REC.                                                     00330028
003400     05  MSA-CODE.                                                00340028
003500         10  MSA-BLANK            PIC X(02).                      00350028
003600         10  MSA-STATE            PIC X(02).                      00360028
003700     05  FILLER                   PIC X.                          00370028
003800     05  MSA-EFFDATE              PIC X(08).                      00380028
003900     05  FILLER                   PIC X.                          00390028
004000     05  MSA-WAGEIND              PIC 9(02)V9(04).                00400028
004100     05  FILLER                   PIC X(08).                      00410028
004200     05  MSA-NAME                 PIC X(52).                      00420028
004300                                                                  00430028
004400 FD  CBSAFILE                                                     00440028
004500     RECORDING MODE IS F                                          00450028
004600     LABEL RECORDS ARE STANDARD.                                  00460028
004700 01  F-CBSA-REC.                                                  00470028
004800     05  F-CBSA.                                                  00480028
004900         10  F-CBSA-BLANK            PIC X(03).                   00490028
005000         10  F-CBSA-STATE            PIC X(02).                   00500028
005100     05  FILLER                   PIC X.                          00510028
005200     05  F-CBSA-EFFDATE           PIC X(08).                      00520028
005300     05  FILLER                   PIC X.                          00530028
005400     05  F-CBSA-WAGEIND           PIC 9(02)V9(04).                00540028
005500     05  FILLER                   PIC X(08).                      00550028
005600     05  F-CBSA-NAME              PIC X(51).                      00560028
005700                                                                  00570028
005800 FD  HRGTABL                                                      00580028
005900     RECORDING MODE IS F                                          00590028
006000     LABEL RECORDS ARE STANDARD.                                  00600028
006100 01  HRG-TABL-REC.                                                00610028
006200     05  HRG-CODE                 PIC X(05).                      00620028
006300     05  FILLER                   PIC X(01).                      00630028
006400     05  HRG-EFFDATE              PIC X(08).                      00640028
006500     05  FILLER                   PIC X(01).                      00650028
006600     05  HRG-WGTS                 PIC 9(02)V9(04).                00660028
006700     05  FILLER                   PIC X(01).                      00670028
006800     05  HRG-THRESHOLD            PIC X(01).                      00680028
006900     05  FILLER                   PIC X(57).                      00690028
007000                                                                  00700028
007100 FD  REVTABL                                                      00710028
007200     RECORDING MODE IS F                                          00720028
007300     LABEL RECORDS ARE STANDARD.                                  00730028
007400 01  REV-TABL-REC.                                                00740028
007500     05  REV-CODE                       PIC X(04).                00750028
007600     05  FILLER                         PIC X.                    00760028
007700     05  REV-EFFDATE                    PIC X(08).                00770028
007800     05  FILLER                         PIC X.                    00780028
007900     05  REV-DOLL-RATE-NRURAL           PIC 9(07)V9(02).          00790028
008000     05  FILLER                         PIC X.                    00800028
008100     05  REV-DOLL-RATE-RURAL            PIC 9(07)V9(02).          00810028
008200     05  FILLER                         PIC X.                    00820028
008300     05  REV-DOLL-RATE-NRURAL-NOSUBMIT  PIC 9(07)V9(02).          00830028
008400     05  FILLER                         PIC X.                    00840028
008500     05  REV-DOLL-RATE-RURAL-NOSUBMIT   PIC 9(07)V9(02).          00850028
008600     05  FILLER                         PIC X.                    00860028
008700     05  REV-UDOLL-RATE-NRURAL          PIC 9(07)V9(02).          00870028
008800     05  FILLER                         PIC X.                    00880028
008900     05  REV-UDOLL-RATE-RURAL           PIC 9(07)V9(02).          00890028
009000     05  FILLER                         PIC X.                    00900028
009100     05  REV-UDOLL-RATE-NRURAL-NOSUBMIT PIC 9(07)V9(02).          00910028
009200     05  FILLER                         PIC X.                    00920028
009300     05  REV-UDOLL-RATE-RURAL-NOSUBMIT  PIC 9(07)V9(02).          00930028
009400                                                                  00940028
009500 WORKING-STORAGE SECTION.                                         00950028
009600 01  FILLER                         PIC X(40)  VALUE              00960028
009700     'HHOPN    - W O R K I N G   S T O R A G E'.                  00970028
009800 01  OPN-VERSION                 PIC X(07)  VALUE 'O2021.3'.      00980034
009900 01  DRV-VERSION                 PIC X(07)  VALUE 'D2021.3'.      00990034
010000 01  HHDRV213                    PIC X(08)  VALUE 'HHDRV213'.     01000034
010100 01  SUB1                        PIC 9(03)  VALUE 0.              01010028
010200 01  EOF-SW                      PIC 9(01)  VALUE 0.              01020028
010300 01  EOF-MSA                     PIC 9(01)  VALUE 0.              01030028
010400 01  EOF-CBSA                    PIC 9(01)  VALUE 0.              01040028
010500 01  EOF-HRG                     PIC 9(01)  VALUE 0.              01050028
010600 01  EOF-REV                     PIC 9(01)  VALUE 0.              01060028
010700 01  LOAD-TABLES-SW              PIC 9(01)  VALUE 0.              01070028
010800 01  TABLES-LOADED-SW            PIC 9(01)  VALUE 0.              01080028
010900 01  HRG-CT                      PIC 9(10)  VALUE 0.              01090028
011000 01  MSA-STAT.                                                    01100028
011100     05  MSA-STAT1               PIC X.                           01110028
011200     05  MSA-STAT2               PIC X.                           01120028
011300 01  CBSA-STAT.                                                   01130028
011400     05  CBSA-STAT1               PIC X.                          01140028
011500     05  CBSA-STAT2               PIC X.                          01150028
011600 01  HRG-STAT.                                                    01160028
011700     05  HRG-STAT1               PIC X.                           01170028
011800     05  HRG-STAT2               PIC X.                           01180028
011900 01  REV-STAT.                                                    01190028
012000     05  REV-STAT1               PIC X.                           01200028
012100     05  REV-STAT2               PIC X.                           01210028
012200*******************************************************           01220028
012300*    PASSED TO HHDRV PROGRAM                          *           01230028
012400*******************************************************           01240028
012500 01  WAGE-INDEX-DATA.                                             01250028
012600     02  WIR-MSA               PIC X(04).                         01260028
012700     02  WIR-EFFDATE           PIC X(08).                         01270028
012800     02  WIR-AREA-WAGEIND      PIC 9(02)V9(04).                   01280028
012900                                                                  01290028
013000 01  MSA-WI-TABLE.                                                01300028
013100     05  M-MSA-DATA        OCCURS 4000                            01310028
013200                           INDEXED BY MU1 MU2 MU3.                01320028
013300         10  TB-MSA        PIC X(04).                             01330028
013400         10  FILLER        PIC X(01).                             01340028
013500         10  TB-EFFDATE    PIC X(08).                             01350028
013600         10  FILLER        PIC X(01).                             01360028
013700         10  TB-WAGEIND    PIC 9(02)V9(04).                       01370028
013800                                                                  01380028
013900 01  CBSA-WAGE-INDEX-DATA.                                        01390028
014000     02  WIR-CBSA              PIC X(05).                         01400028
014100     02  WIR-CBSA-EFFDATE      PIC X(08).                         01410028
014200     02  WIR-CBSA-WAGEIND      PIC 9(02)V9(04).                   01420028
014300                                                                  01430028
014400 01  CBSA-WI-TABLE.                                               01440028
014500     05  T-CBSA-DATA        OCCURS 8000                           01450030
014600                           INDEXED BY MA1 MA2 MA3.                01460028
014700         10  T-CBSA            PIC X(05).                         01470028
014800         10  FILLER            PIC X(01).                         01480028
014900         10  T-CBSA-EFFDATE    PIC X(08).                         01490028
015000         10  FILLER            PIC X(01).                         01500028
015100         10  T-CBSA-WAGEIND    PIC 9(02)V9(04).                   01510028
015200                                                                  01520028
015300 01  HRG-TABLE.                                                   01530028
015400     05  M-HRG-DATA        OCCURS 432                             01540028
015500                           INDEXED BY HU1 HU2 HU3.                01550028
015600         10  TB-HRG-CODE       PIC X(05).                         01560028
015700         10  FILLER            PIC X(01).                         01570028
015800         10  TB-HRG-EFFDATE    PIC X(08).                         01580028
015900         10  FILLER            PIC X(01).                         01590028
016000         10  TB-HRG-WGTS       PIC 9(02)V9(04).                   01600028
016100         10  FILLER            PIC X(01).                         01610028
016200         10  TB-HRG-THRESHOLD  PIC X(01).                         01620028
016300                                                                  01630028
016400 01  REVENUE-TABLE.                                               01640028
016500     05  M-REV-DATA        OCCURS 200                             01650028
016600                           INDEXED BY RU1 RU2 RU3.                01660028
016700         10  TB-REV-CODE.                                         01670028
016800             15  TB-REV-CODE-1ST.                                 01680028
016900                 88  TB-REV-CODE-RURAL-CHECK   VALUE '99'.        01690028
017000                 20  TB-REV-CODE-RURAL       PIC XX.              01700028
017100             15  TB-REV-CODE-2ND          PIC XX.                 01710028
017200         10  FILLER                       PIC X(01).              01720028
017300         10  TB-REV-EFFDATE               PIC X(08).              01730028
017400         10  FILLER                       PIC X(01).              01740028
017500         10  TB-REV-DOLL-RATE-NRURAL      PIC 9(07)V9(02).        01750028
017600         10  FILLER                       PIC X(01).              01760028
017700         10  TB-REV-DOLL-RATE-RURAL       PIC 9(07)V9(02).        01770028
017800         10  FILLER                       PIC X.                  01780028
017900         10  TB-DOLL-RATE-NRURAL-NOSUBMIT PIC 9(07)V9(02).        01790028
018000         10  FILLER                       PIC X.                  01800028
018100         10  TB-DOLL-RATE-RURAL-NOSUBMIT  PIC 9(07)V9(02).        01810028
018200         10  FILLER                       PIC X(01).              01820028
018300         10  TB-REV-UDOLL-RATE-NRURAL     PIC 9(07)V9(02).        01830028
018400         10  FILLER                       PIC X(01).              01840028
018500         10  TB-REV-UDOLL-RATE-RURAL      PIC 9(07)V9(02).        01850028
018600         10  FILLER                       PIC X.                  01860028
018700         10  TB-UDOLL-RATE-NRURAL-NOSUBMIT PIC 9(07)V9(02).       01870028
018800         10  FILLER                       PIC X.                  01880028
018900         10  TB-UDOLL-RATE-RURAL-NOSUBMIT PIC 9(07)V9(02).        01890028
019000                                                                  01900028
019100 LINKAGE SECTION.                                                 01910028
019200*----------------------------------------------------------------*01920028
019300*  INPUT/OUTPUT RECORD LAYOUT - PIC X(650)                       *01930028
019400*  THIS RECORD WAS MODIFIED FOR THE 01/01/2020 RELEASE           *01940028
019500*----------------------------------------------------------------*01950028
019600 01  HHA-INPUT-DATA.                                              01960028
019700     05  HHA-DATA.                                                01970028
019800         10  HHA-NPI                 PIC X(10).                   01980028
019900         10  HHA-HIC                 PIC X(12).                   01990028
019910         10  HHA-PROV-NO             PIC X(06).                   01991028
019920         10  HHA-INIT-PAY-QRP-INDICATOR  PIC X(01).               01992028
019930             88  HHA-WITH-DATA-CHECK VALUE '0', '1'.              01993028
019940             88  HHA-NO-DATA-CHECK   VALUE '2', '3'.              01994028
019950         10  HHA-PROV-VBP-ADJ-FAC    PIC 9V9(5).                  01995028
019960         10  HHA-PROV-OUTLIER-PAY-TOTAL PIC 9(08)V9(02).          01996028
019970         10  HHA-PROV-PAYMENT-TOTAL  PIC 9(09)V9(02).             01997028
019980         10  HHA-TOB                 PIC X(03).                   01998028
019990             88 HHA-VALID-TOB-CLAIM  VALUE                        01999028
019991             '327', '329',                                        01999128
019992             '32F', '32G', '32H', '32I', '32J',                   01999228
019993             '32K', '32M', '32Q', '32P'.                          01999328
019994             88 H-VALID-TOB-RAP     VALUE                         01999428
019995             '322'.                                               01999528
019996         10  HHA-CBSA                PIC X(05).                   01999628
019997         10  HHA-COUNTY-CODE         PIC X(05).                   01999728
019998         10  HHA-SERV-FROM-DATE.                                  01999828
019999             15  HHA-FROM-CC         PIC XX.                      01999928
020000             15  HHA-FROM-YYMMDD.                                 02000028
020001                 25  HHA-FROM-YY     PIC XX.                      02000128
020002                 25  HHA-FROM-MM     PIC XX.                      02000228
020003                 25  HHA-FROM-DD     PIC XX.                      02000328
020004         10  HHA-SERV-THRU-DATE.                                  02000428
020005             15  HHA-THRU-CC         PIC XX.                      02000528
020006             15  HHA-THRU-YYMMDD.                                 02000628
020007                 25  HHA-THRU-YY     PIC XX.                      02000728
020008                 25  HHA-THRU-MM     PIC XX.                      02000828
020009                 25  HHA-THRU-DD     PIC XX.                      02000928
020010         10  HHA-ADMIT-DATE.                                      02001028
020011             15  HHA-ADMIT-CC        PIC XX.                      02001128
020012             15  HHA-ADMIT-YYMMDD.                                02001228
020013                 25  HHA-ADMIT-YY    PIC XX.                      02001328
020014                 25  HHA-ADMIT-MM    PIC XX.                      02001428
020015                 25  HHA-ADMIT-DD    PIC XX.                      02001528
020016         10  HHA-LUPA-SRC-ADM           PIC X.                    02001628
020017         10  HHA-ADJ-IND                PIC X.                    02001728
020018         10  HHA-PEP-INDICATOR       PIC X.                       02001828
020019         10  HHA-HRG-INPUT-CODE       PIC X(05).                  02001928
020020         10  HHA-HRG-NO-OF-DAYS       PIC 9(03).                  02002028
020021         10  HHA-HRG-WGTS             PIC 9(02)V9(04).            02002128
020022         10  HHA-HRG-PAY              PIC 9(07)V9(02).            02002228
020023         10  HHA-REVENUE-DATA     OCCURS 6.                       02002328
020024             15  HHA-REVENUE-CODE              PIC X(04).         02002428
020025             15  HHA-REVENUE-QTY-COV-VISITS    PIC 9(03).         02002528
020026             15  HHA-REVENUE-QTY-OUTL-UNITS    PIC 9(05).         02002628
020027             15  HHA-REVENUE-EARLIEST-DATE     PIC 9(08).         02002728
020028             15  HHA-REVENUE-DOLL-RATE         PIC 9(07)V9(02).   02002828
020029             15  HHA-REVENUE-COST              PIC 9(07)V9(02).   02002928
020030             15  HHA-REVENUE-ADD-ON-VISIT-AMT  PIC 9(07)V9(02).   02003028
020031         10  HHA-PAY-RTC                PIC 99.                   02003128
020032         10  HHA-REVENUE-SUM1-6-QTY-ALL PIC 9(05).                02003228
020033         10  HHA-OUTLIER-PAYMENT        PIC 9(07)V9(02).          02003328
020034         10  HHA-TOTAL-PAYMENT          PIC 9(07)V9(02).          02003428
020035         10  HHA-VBP-ADJ-AMT            PIC S9(7)V99.             02003528
020036         10  HHA-PPS-STD-VALUE          PIC 9(7)V99.              02003628
020037         10  HHA-RECEIPT-DATE           PIC X(8).                 02003728
020038         10  HHA-OVERRIDE-IND           PIC X(1).                 02003828
020039         10  HHA-LATE-SUB-PEN-AMT       PIC 9(7)V9(2).            02003928
020040         10  FILLER                     PIC X(188).               02004028
020050                                                                  02005028
020060 01  HOLD-VARIABLES-DATA.                                         02006028
020070     02  HOLD-VAR-DATA.                                           02007028
020080         05  PRICER-OPTION-SW              PIC X(01).             02008028
020090         05  HHOPN-VERSION                 PIC X(07).             02009028
020100         05  HHDRV-VERSION                 PIC X(07).             02010028
020200         05  HHCAL-VERSION                 PIC X(07).             02020028
020300         05  FILLER                        PIC X(20).             02030028
020400                                                                  02040028
020500**==================================================***           02050028
020600 PROCEDURE  DIVISION USING HHA-INPUT-DATA                         02060028
020700                           HOLD-VARIABLES-DATA.                   02070028
020800                                                                  02080028
020900 0000-MAINLINE  SECTION.                                          02090028
021000                                                                  02100028
021100     MOVE OPN-VERSION TO HHOPN-VERSION.                           02110032
021200                                                                  02120028
021300**** IF PRICER-OPTION-SW = 'A'                                    02130028
021400        IF TABLES-LOADED-SW NOT NUMERIC                           02140028
021500            MOVE 1 TO TABLES-LOADED-SW.                           02150028
021600                                                                  02160028
021700        IF TABLES-LOADED-SW = 0                                   02170028
021800            PERFORM 1100-LOAD-CBSAFILE THRU 1100-EXIT             02180028
021900            PERFORM 1300-LOAD-MSAFILE THRU 1300-EXIT              02190028
022000            PERFORM 1800-LOAD-HRGTABL THRU 1800-EXIT              02200028
022100            PERFORM 2500-LOAD-REVTABL THRU 2500-EXIT              02210028
022200            MOVE 1 TO TABLES-LOADED-SW.                           02220028
022300                                                                  02230028
022400        INITIALIZE      HHA-PAY-RTC                               02240028
022500                        HHA-REVENUE-SUM1-6-QTY-ALL                02250028
022600                        HHA-OUTLIER-PAYMENT                       02260028
022700                        HHA-TOTAL-PAYMENT                         02270028
022800                        HHA-VBP-ADJ-AMT                           02280028
022900                        HHA-PPS-STD-VALUE.                        02290028
023000                                                                  02300028
023100 0100-PROCESS-RECORDS.                                            02310028
023200                                                                  02320028
023300******************************************************************02330028
023400*        FY 2020 VERSION 0                                       *02340028
023500******************************************************************02350028
023600         CALL HHDRV213 USING WAGE-INDEX-DATA                      02360034
023700                             MSA-WI-TABLE                         02370028
023800                             CBSA-WAGE-INDEX-DATA                 02380028
023900                             CBSA-WI-TABLE                        02390028
024000                             HRG-TABLE                            02400028
024100                             REVENUE-TABLE                        02410028
024200                             HHA-INPUT-DATA                       02420028
024300                             HOLD-VARIABLES-DATA.                 02430028
024400         GOBACK.                                                  02440028
024500                                                                  02450028
024600******************************************************************02460028
024700                                                                  02470028
024800 0100-EXIT.  EXIT.                                                02480028
024900                                                                  02490028
025000                                                                  02500028
025100 1100-LOAD-CBSAFILE.                                              02510028
025200     OPEN INPUT CBSAFILE.                                         02520028
025300     INITIALIZE CBSA-WI-TABLE.                                    02530028
025400     MOVE 0 TO EOF-CBSA.                                          02540028
025500     SET MA3 TO EOF-CBSA.                                         02550028
025600                                                                  02560028
025700     PERFORM 1200-READ-CBSAFILE THRU 1200-EXIT                    02570028
025800             UNTIL EOF-CBSA = 1.                                  02580028
025900                                                                  02590028
026000     CLOSE CBSAFILE.                                              02600028
026100                                                                  02610028
026200 1100-EXIT.  EXIT.                                                02620028
026300                                                                  02630028
026400 1200-READ-CBSAFILE.                                              02640028
026500     READ CBSAFILE                                                02650028
026600          AT END   MOVE 1 TO EOF-CBSA.                            02660028
026700                                                                  02670028
026800     IF EOF-CBSA = 0                                              02680028
026900        IF F-CBSA-EFFDATE > '20050930' OR                         02690028
027000          (F-CBSA-STATE = '98' OR '99')                           02700028
027100           SET MA3 UP BY 1                                        02710028
027200               MOVE F-CBSA         TO T-CBSA         (MA3)        02720028
027300               MOVE F-CBSA-EFFDATE TO T-CBSA-EFFDATE (MA3)        02730028
027400               MOVE F-CBSA-WAGEIND TO T-CBSA-WAGEIND (MA3).       02740028
027500                                                                  02750028
027600 1200-EXIT.  EXIT.                                                02760028
027700                                                                  02770028
027800 1300-LOAD-MSAFILE.                                               02780028
027900     OPEN INPUT MSAFILE.                                          02790028
028000     INITIALIZE MSA-WI-TABLE.                                     02800028
028100     MOVE 0 TO EOF-MSA.                                           02810028
028200     SET MU3 TO EOF-MSA.                                          02820028
028300                                                                  02830028
028400     PERFORM 1400-READ-MSAFILE THRU 1400-EXIT                     02840028
028500             UNTIL EOF-MSA = 1.                                   02850028
028600                                                                  02860028
028700     CLOSE MSAFILE.                                               02870028
028800                                                                  02880028
028900 1300-EXIT.  EXIT.                                                02890028
029000                                                                  02900028
029100 1400-READ-MSAFILE.                                               02910028
029200     READ MSAFILE                                                 02920028
029300          AT END   MOVE 1 TO EOF-MSA.                             02930028
029400                                                                  02940028
029500     IF EOF-MSA = 0                                               02950028
029600        IF MSA-EFFDATE > '19970930' OR                            02960028
029700          (MSA-STATE = '98' OR '99')                              02970028
029800           SET MU3 UP BY 1                                        02980028
029900               MOVE MSA-CODE    TO TB-MSA     (MU3)               02990028
030000               MOVE MSA-EFFDATE TO TB-EFFDATE (MU3)               03000028
030100               MOVE MSA-WAGEIND TO TB-WAGEIND (MU3).              03010028
030200                                                                  03020028
030300 1400-EXIT.  EXIT.                                                03030028
030400                                                                  03040028
030500                                                                  03050028
030600 1800-LOAD-HRGTABL.                                               03060028
030700     OPEN INPUT HRGTABL.                                          03070028
030800     INITIALIZE HRG-TABLE.                                        03080028
030900     MOVE 0 TO EOF-HRG.                                           03090028
031000     SET HU3 TO EOF-HRG.                                          03100028
031100                                                                  03110028
031200     PERFORM 1900-READ-HRGTABL THRU 1900-EXIT                     03120028
031300             UNTIL EOF-HRG = 1.                                   03130028
031400                                                                  03140028
031500     CLOSE HRGTABL.                                               03150028
031600                                                                  03160028
031700 1800-EXIT.  EXIT.                                                03170028
031800                                                                  03180028
031900 1900-READ-HRGTABL.                                               03190028
032000     READ HRGTABL                                                 03200028
032100          AT END   MOVE 1 TO EOF-HRG.                             03210028
032200     ADD 1 TO HRG-CT.                                             03220028
032300     IF EOF-HRG = 0                                               03230028
032400        SET HU3 UP BY 1                                           03240028
032500            MOVE HRG-CODE      TO TB-HRG-CODE     (HU3)           03250028
032600            MOVE HRG-EFFDATE   TO TB-HRG-EFFDATE  (HU3)           03260028
032700            MOVE HRG-WGTS      TO TB-HRG-WGTS     (HU3)           03270028
032800            MOVE HRG-THRESHOLD TO TB-HRG-THRESHOLD(HU3).          03280028
032900                                                                  03290028
033000 1900-EXIT.  EXIT.                                                03300028
033100                                                                  03310028
033200                                                                  03320028
033300 2500-LOAD-REVTABL.                                               03330028
033400     OPEN INPUT REVTABL.                                          03340028
033500     INITIALIZE REVENUE-TABLE.                                    03350028
033600     MOVE 0 TO EOF-REV.                                           03360028
033700     SET RU3 TO EOF-REV.                                          03370028
033800                                                                  03380028
033900     PERFORM 2600-READ-REVTABL THRU 2600-EXIT                     03390028
034000             UNTIL EOF-REV = 1.                                   03400028
034100                                                                  03410028
034200     CLOSE REVTABL.                                               03420028
034300                                                                  03430028
034400 2500-EXIT.  EXIT.                                                03440028
034500                                                                  03450028
034600 2600-READ-REVTABL.                                               03460028
034700     READ REVTABL                                                 03470028
034800          AT END   MOVE 1 TO EOF-REV.                             03480028
034900                                                                  03490028
035000     IF EOF-REV = 0                                               03500028
035100        SET RU3 UP BY 1                                           03510028
035200            MOVE REV-CODE      TO TB-REV-CODE     (RU3)           03520028
035300            MOVE REV-EFFDATE   TO TB-REV-EFFDATE  (RU3)           03530028
035400            MOVE REV-DOLL-RATE-NRURAL TO                          03540028
035500                              TB-REV-DOLL-RATE-NRURAL (RU3)       03550028
035600            MOVE REV-DOLL-RATE-RURAL TO                           03560028
035700                              TB-REV-DOLL-RATE-RURAL (RU3)        03570028
035800            MOVE REV-DOLL-RATE-NRURAL-NOSUBMIT TO                 03580028
035900                          TB-DOLL-RATE-NRURAL-NOSUBMIT (RU3)      03590028
036000            MOVE REV-DOLL-RATE-RURAL-NOSUBMIT TO                  03600028
036100                         TB-DOLL-RATE-RURAL-NOSUBMIT (RU3)        03610028
036200                                                                  03620028
036300            MOVE REV-UDOLL-RATE-NRURAL TO                         03630028
036400                              TB-REV-UDOLL-RATE-NRURAL (RU3)      03640028
036500            MOVE REV-UDOLL-RATE-RURAL TO                          03650028
036600                              TB-REV-UDOLL-RATE-RURAL (RU3)       03660028
036700            MOVE REV-UDOLL-RATE-NRURAL-NOSUBMIT TO                03670028
036800                          TB-UDOLL-RATE-NRURAL-NOSUBMIT (RU3)     03680028
036900            MOVE REV-UDOLL-RATE-RURAL-NOSUBMIT TO                 03690028
037000                         TB-UDOLL-RATE-RURAL-NOSUBMIT (RU3)       03700028
037100     END-IF.                                                      03710028
037200                                                                  03720028
037300 2600-EXIT.  EXIT.                                                03730028
