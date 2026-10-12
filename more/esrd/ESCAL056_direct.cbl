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
           RECORD CONTAINS 870 CHARACTERS.
       01  D-REC.
           05  D-01 PIC X(450).
           05  D-02 PIC X(396).
           05  D-03 PIC X(24).
       WORKING-STORAGE SECTION.
       01  WS-EOF                  PIC X VALUE 'N'.
       01  BILL-NEW-DATA PIC X(450).
       01  PPS-DATA-ALL PIC X(396).
       01  WAGE-NEW-RATE-RECORD PIC X(24).
       PROCEDURE DIVISION.
           OPEN INPUT DFILE.
           PERFORM UNTIL WS-EOF = 'Y'
               READ DFILE
                   AT END
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
                       MOVE D-01 TO BILL-NEW-DATA
                       MOVE D-02 TO PPS-DATA-ALL
                       MOVE D-03 TO WAGE-NEW-RATE-RECORD
                       CALL 'ESCAL056' USING BILL-NEW-DATA
                                       PPS-DATA-ALL
                                       WAGE-NEW-RATE-RECORD
               END-READ
           END-PERFORM.
           CLOSE DFILE.
           STOP RUN.
