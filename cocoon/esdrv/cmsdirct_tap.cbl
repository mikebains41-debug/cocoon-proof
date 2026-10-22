       IDENTIFICATION DIVISION.
       PROGRAM-ID. CMSDIRCT.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT DFILE ASSIGN TO 'direct.dat'
               ORGANIZATION IS SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  DFILE
           RECORD CONTAINS 846 CHARACTERS.
       01  D-REC.
           05  D-01 PIC X(450).
           05  D-02 PIC X(396).
       WORKING-STORAGE SECTION.
       01  WS-EOF                  PIC X VALUE 'N'.
       01  W-SKIPX                 PIC X(09) VALUE SPACES.
       01  W-SKIP                  PIC 9(09) VALUE 0.
       01  W-N                     PIC 9(09) VALUE 0.
       01  BILL-NEW-DATA PIC X(450).
       01  PPS-DATA-ALL PIC X(396).
       PROCEDURE DIVISION.
           ACCEPT W-SKIPX FROM ENVIRONMENT 'COCOON_SKIP'.
           IF W-SKIPX NOT = SPACES
               COMPUTE W-SKIP = FUNCTION NUMVAL(W-SKIPX)
           END-IF.
           OPEN INPUT DFILE.
           PERFORM UNTIL WS-EOF = 'Y'
               READ DFILE
                   AT END
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
                       ADD 1 TO W-N
                       IF W-N > W-SKIP
                       MOVE D-01 TO BILL-NEW-DATA
                       MOVE D-02 TO PPS-DATA-ALL
           DISPLAY 'COCOON B BILL-NEW-DATA '
               FUNCTION HEX-OF(BILL-NEW-DATA)
           DISPLAY 'COCOON B PPS-DATA-ALL '
               FUNCTION HEX-OF(PPS-DATA-ALL)
                       CALL 'ESDRV212' USING BILL-NEW-DATA
                                       PPS-DATA-ALL
           DISPLAY 'COCOON A BILL-NEW-DATA '
               FUNCTION HEX-OF(BILL-NEW-DATA)
           DISPLAY 'COCOON A PPS-DATA-ALL '
               FUNCTION HEX-OF(PPS-DATA-ALL)
                       END-IF
               END-READ
           END-PERFORM.
           CLOSE DFILE.
           STOP RUN.
