000100******************************************************************
000200*             THIS IS THE MSA WAGE-ADJUSTED RATE                 *
000300*          ASSOCIATED WITH THE BILL BEING PROCESSED              *
000400******************************************************************
000500 01  WAGE-NEW-RATE-RECORD.
000600     05  W-NEW-MSA                  PIC 9(04).
000700     05  W-NEW-EFF-DATE.
000800          10  W-NEW-EFF-DATE-CC     PIC 9(02).
000900          10  W-NEW-EFF-DATE-YMD.
001000              15  W-NEW-EFF-DATE-YY PIC 9(02).
001100              15  W-NEW-EFF-DATE-MM PIC 9(02).
001200              15  W-NEW-EFF-DATE-DD PIC 9(02).
001300     05  W-NEW-RATE1-RECORD         PIC S9(04)V9(02).
001400     05  W-NEW-RATE2-RECORD         PIC S9(04)V9(02).
001500
001600******************************************************************
001700* This is the 2006 through 2013 COMposite CBSA rate WAGE INDEX.  *
001800*          This record is passed to the ESCALxx program          *
001900******************************************************************
002000 01  COM-CBSA-WAGE-RECORD.
002100     05  COM-CBSA                   PIC 9(05).
002200     05  COM-CBSA-DATE.
002300          10  COM-CBSA-DATE-CC      PIC 9(02).
002400          10  COM-CBSA-DATE-YMD.
002500             15  COM-CBSA-DATE-YY   PIC 9(02).
002600             15  COM-CBSA-DATE-MM   PIC 9(02).
002700             15  COM-CBSA-DATE-DD   PIC 9(02).
002800     05  COM-CBSA-W-INDEX           PIC S9(02)V9(04).
002900
003000******************************************************************
003100*This is the 2011 and later BUNdled CBSA wage index derived by   *
003200*using the BUNdled rate rules.                                   *
003300*          This record is passed to the ESCALxx program          *
003400******************************************************************
003500 01  BUN-CBSA-WAGE-RECORD.
003600     05  BUN-CBSA                   PIC 9(05).
003700     05  BUN-CBSA-DATE.
003800          10  BUN-CBSA-DATE-CC      PIC 9(02).
003900          10  BUN-CBSA-DATE-YMD.
004000             15  BUN-CBSA-DATE-YY   PIC 9(02).
004100             15  BUN-CBSA-DATE-MM   PIC 9(02).
004200             15  BUN-CBSA-DATE-DD   PIC 9(02).
004300     05  BUN-CBSA-W-INDEX           PIC S9(02)V9(04).
