000100******************************************************************
000200*                                                                *
000300*   ***** Possible Return Codes From CALCULTE Subtoutine *****   *
000400*                                                                *
000500*   ****  PPS-RTC 00-49 = Bill Payment Information Codes         *
000600*   **  OLD Return code    effective 4/1/2005 - 12/31/2010       *
000700*          00 = ESRD PPS Payment calculated                      *
000800*                                                                *
000900*   **  NEW Return codes   effective 1/1/2011                    *
001000*          02 = no adjustments                                   *
001100*          03 = w/outlier                                        *
001200*          04 = w/acute comorbid                                 *
001300*          05 = w/chronic comorbid                               *
001400*          06 = w/acute comorbid, outlier                        *
001500*          07 = w/chronic comorbid, outlier                      *
001600*          08 = w/onset                                          *
001700*          09 = w/onset, outlier                                 *
001800*          10 = w/low volume                                     *
001900*          11 = w/training                                       *
002000*          12 = w/low volume, training                           *
002100*          13 = w/multiple adjustments....reserved for future use*
002200*          14 = w/pediatric                                      *
002300*          15 = w/pediatric, training                            *
002400*          16 = w/pediatric, outlier                             *
002500*          17 = w/pediatric, outlier, training                   *
002600*          18 = w/acute comorbid, outlier, low volume            *
002700*          19 = w/acute comorbid, outlier, low volume, training  *
002800*          20 = w/acute comorbid, low volume                     *
002900*          21 = w/acute comorbid, low volume, training           *
003000*          22 = w/acute comorbid, training                       *
003100*          23 = w/chronic comorbid, outlier, low volume          *
003200*          24 = w/chronic comorbid, outlier, low volume, training*
003300*          25 = w/chronic comorbid, low volume                   *
003400*          26 = w/chronic comorbid, low volume, training         *
003500*          27 = w/chronic comorbid, training                     *
003600*          28 = w/outlier, low volume                            *
003700*          29 = w/outlier, low volume, training                  *
003800*          30 = w/onset, outlier, low volume                     *
003900*          31 = w/low BMI                                        *
004000*          32 = low volume, onset                                *
004100*          33 = outlier, training                                *
004200*          34 = outlier, training, chronic comorbid              *
004300*          35 = outlier, training, acute comorbid                *
004400*                                                                *
004500*   **    PPS-RTC 50-99 = Why the bill was NOT paid              *
004600*                                                                *
004700*          52 = Provider type NOT = '40' OR '41'                 *
004800*          53 = Special payment indicator NOT = '1' OR blank     *
004900*          54 = Date of Birth  NOT numeric OR = ZERO             *
005000*          55 = Patient Weight NOT numeric OR = ZERO             *
005100*          56 = Patient Height NOT numeric OR = ZERO             *
005200*          57 = Revenue Center Code NOT in range                 *
005300*          58 = Condition Code NOT IN {'  ','73','74','84','87'} *
005400*          71 = Exceeds Maximum Height allowance                 *
005500*          72 = Exceeds Maximum Weight allowance                 *
005600*          73 = Claim-Num-Dial-Session NOT numeric OR = ZERO     *
005700*          74 = Line-Item-Svc-Date NOT numeric OR = ZERO         *
005800*          75 = Dial-Start-Date NOT numeric  OR = ZERO           *
005900*          76 = Tot-Outlier-Pmt NOT numeric                      *
006000*          81 = Comorbid-CWF-Return-code NOT valid               *
006100*                                                                *
006200*          99 = Internal PRICER error ..FIX before giving to FISS*
006300*               This code used to check that no invalid return   *
006400*               codes are generated meaning that there is a logic*
006500*               error internal to the calculate routine.         *
006600*                                                                *
006700*                                                                *
006800*   ***** Possible Return Codes From DRIVER Subtoutine *****     *
006900*                                                                *
007000*   ****  PPS-RTC 00-49 = Bill Payment Information Codes         *
007100*   **  OLD Return code    effective 4/1/2005 - 12/31/2010       *
007200*          01 = ESRD facility rate > ZERO                        *
007300*                                                                *
007400*   **    PPS-RTC 50-99 = Why the bill was NOT paid              *
007500*                                                                *
007600*          50 = ESRD facility rate not numeric                   *
007700*MAINFRAME 60 = CBSA wage adjusted rate record not found         *
007800*PC-ONLY   61 = CBSA wage index rate record not found            *
007900*                   WINDOW:  M-61-CBSA-not found                 *
008000*PC-ONLY   62 = CBSA is not valid for this calendar year         *
008100*                   WINDOW:  M-62-CBSA-not valid this-year       *
008200*          98 = Claim through date before 04/01/05 or not numeric*
008300******************************************************************
