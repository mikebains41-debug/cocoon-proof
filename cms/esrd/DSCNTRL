000100
000200*****************************************************************
000300*****************************************************************
000400*      This copylib is for use on the ....MAINFRAME ONLY....    *
000500*This version of the copylib    eliminates    the MicroFocus non*
000600*standard usage of COMP-X pictures.  Instead it substitutes COMP*
000700*(COMPUTATIONAL) which is technically what MF is using but in a *
000800*different way.                                                 *
000900*                                                               *
001000*This version also    eliminates   the MicroFocus non standard  *
001100*usage of 78 level numbers.  Instead, it substitutes the 88 level
001200*which is close to what MF uses it for.                         *
001300*                                                               *
001400*I am eliminating the error messages that would be generated in *
001500*compilation on the IBM mainframe since the program will never  *
001600*be able to run on the IBM and I am using it for cross reference*
001700*compilations only as well as to check out some other things.   *
001800*                                                               *
001900*This version of the copylib should  NEVER  be used as a copylib*
002000*in Micro Focus.  This copylib is actually for use by the Dialog*
002100*System <e.g. DS-.....> which is why it can't be executed on the*
002200*mainframe.                                                     *
002300*                                                               *
002400*This copylib contains an extra variable not used in the standar*
002500*Micro Focus version.  The MAINFRAME-PC-SWITCH picture clause and
002600*its value are differnet between the mainframe and PC versions. *
002700*****************************************************************
002800*****************************************************************
002900
003000 01  MAINFRAME-PC-SWITCH                 PIC 9(04) COMP VALUE 0.
003100
003200*****************************************************************
003300*  Dialog System Control Block (Using Micro Focus Constants).   *
003400*  For use with Dialog System Version 2.                        *
003500*****************************************************************
003600
003700 01  DS-CONTROL-BLOCK.
003800     05  DS-VERSION-NUMBERS.
003900         10  DS-DATA-BLOCK-VERSION-NO    PIC 9(08) COMP-5.
004000         10  DS-VERSION-NO               PIC 9(02) COMP.
004100*        10  DS-VERSION-NO               PIC 9(02) COMP-X.
004200         10  FILLER                      PIC X(01).
004300     05  DS-OUTPUT-FIELDS.
004400         10  DS-SYSTEM-ERROR.
004500             15  DS-ERROR-CODE           PIC 9(04) COMP-5.
004600               88  DS-NO-ERROR                     VALUE 0.
004700               88  DS-NOT-INITIALISED              VALUE 1.
004800               88  DS-CANNOT-OPEN-SET              VALUE 2.
004900               88  DS-ERROR-READING-FILE           VALUE 3.
005000               88  DS-INVALID-SET                  VALUE 4.
005100               88  DS-CANNOT-CREATE-PANEL          VALUE 5.
005200               88  DS-DYNAMIC-ERROR                VALUE 6.
005300               88  DS-INVALID-FUNCTION             VALUE 7.
005400               88  DS-INVALID-PROC                 VALUE 8.
005500               88  DS-VALIDATION-PROG-ERROR        VALUE 9.
005600               88  DS-DATA-BLOCK-VERNO-ERROR       VALUE 10.
005700               88  DS-PUSH-LIMIT-REACHED           VALUE 11.
005800               88  DS-ERROR-FILE-MISSING           VALUE 12.
005900               88  DS-SUBSCRIPT-ERROR              VALUE 13.
006000               88  DS-PROC-LIMIT-REACHED           VALUE 14.
006100               88  DS-CTRL-BREAK-PRESSED           VALUE 15.
006200               88  DS-ERROR-ON-TRACE-FILE          VALUE 16.
006300               88  DS-SCREEN-MANAGER-ERROR         VALUE 17.
006400               88  DS-CANNOT-FIND-SCREENSET        VALUE 18.
006500               88  DS-INVALID-IDENTIFIER           VALUE 19.
006600               88  DS-BAD-PARAMETER                VALUE 20.
006700               88  DS-POSS-DSRUN-MISMATCH          VALUE 21.
006800               88  DS-CALLOUT-FAILED               VALUE 22.
006900               88  DS-NO-CONCURRENCY               VALUE 23.
007000               88  DS-INVALID-INSTANCE             VALUE 24.
007100               88  DS-ALREADY-INITIALISED          VALUE 25.
007200               88  DS-SYSTEM-MODULE-MISSING        VALUE 26.
007300               88  DS-OLE-ERROR                    VALUE 27.
007400             15  DS-ERROR-DETAILS-1      PIC 9(04) COMP-5.
007500             15  DS-ERROR-DETAILS-2      PIC 9(04) COMP-5.
007600         10  DS-VALIDATION-ERROR-NO      PIC 9(04) COMP-5.
007700         10  DS-FIELD-COUNT              PIC 9(04) COMP-5.
007800         10  DS-FIELD-OCCURRENCE         PIC 9(04) COMP-5.
007900         10  DS-FIELD-NO                 PIC 9(04) COMP-5.
008000         10  DS-WINDOW-NAME              PIC X(32).
008100         10  DS-OBJECT-NAME              PIC X(32).
008200         10  DS-FIELD-CHANGE             PIC 9(02) COMP.
008300*        10  DS-FIELD-CHANGE             PIC 9(02) COMP-X.
008400           88 DS-FIELD-CHANGE-TRUE                 VALUE 1.
008500         10  DS-EXIT-FIELD               PIC 9(02) COMP.
008600*        10  DS-EXIT-FIELD               PIC 9(02) COMP-X.
008700           88 DS-EXIT-FIELD-TRUE                   VALUE 1.
008800         10  DS-SESSION-ID               PIC 9(09) COMP-5.
008900         10  DS-OUTPUT-RESERVED          PIC X(06).
009000     05  DS-INPUT-FIELDS.
009100         10  DS-CONTROL                  PIC X(01).
009200           88  DS-CONTINUE                         VALUE "C".
009300           88  DS-NEW-SET                          VALUE "N".
009400           88  DS-LOAD-SYSTEM                      VALUE "L".
009500           88  DS-QUIT-SET                         VALUE "Q".
009600           88  DS-PUSH-SET                         VALUE "S".
009700           88  DS-USE-SET                          VALUE "U".
009800           88  DS-USE-INSTANCE-SET                 VALUE "I".
009900           88  DS-PATHNAME                         VALUE "P".
010000           88  DS-ERR-FILE-OPEN                    VALUE "E".
010100           88  DS-USE-KWIT                         VALUE "K".
010200           88  DS-USE-3D-CONTROLS                  VALUE "3".
010300         10  DS-CLEAR-DIALOG             PIC 9(02) COMP.
010400*        10  DS-CLEAR-DIALOG             PIC 9(02) COMP-X.
010500         10  DS-CONTROL-PARAM            PIC 9(04) COMP-5.
010600           88  DS-CONTROL-PARAM-DEFAULT            VALUE 0.
010700           88  DS-SCREEN-NOCLEAR                   VALUE 1.
010800           88  DS-IGNORE-DB-VER-NO                 VALUE 2.
010900           88  DS-CHECK-CTRL-BREAK                 VALUE 4.
011000           88  DS-NO-NAME-INFO                     VALUE 8.
011100           88  DS-SMALL-TIMEOUT                    VALUE 16.
011200         10  DS-PROCEDURE                PIC X(32).
011300         10  DS-PARAMETER-COUNT          PIC 9(02) COMP.
011400*        10  DS-PARAMETER-COUNT          PIC 9(02) COMP-X.
011500         10  DS-SCREENSET-INSTANCE       PIC 9(02) COMP.
011600*        10  DS-SCREENSET-INSTANCE       PIC 9(02) COMP-X.
011700         10  DS-INPUT-RESERVED           PIC X(08).
011800         10  DS-SCREENSET-NAME.
011900             15  DS-SET-NAME-LENGTH      PIC 9(04) COMP-5.
012000             15  DS-SET-NAME             PIC X(256).
012100
012200*****************************************************************
012300*   End of Control Block                                        *
012400*****************************************************************
