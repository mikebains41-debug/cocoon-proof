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
           RECORD CONTAINS 518 CHARACTERS.
       01  D-REC.
           05  D-01 PIC X(60).
           05  D-02 PIC X(182).
           05  D-03 PIC X(6).
           05  D-04 PIC X(240).
           05  D-05 PIC X(30).
       WORKING-STORAGE SECTION.
       01  WS-EOF                  PIC X VALUE 'N'.
       01  BILL-NEW-DATA PIC X(60).
       01  PPS-DATA-ALL PIC X(182).
       01  PRICER-OPT-VERS-SW PIC X(6).
       01  PROV-NEW-HOLD PIC X(240).
       01  WAGE-NEW-INDEX-RECORD PIC X(30).
       PROCEDURE DIVISION.
           OPEN INPUT DFILE.
           PERFORM UNTIL WS-EOF = 'Y'
               READ DFILE
                   AT END
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
                       MOVE D-01 TO BILL-NEW-DATA
                       MOVE D-02 TO PPS-DATA-ALL
                       MOVE D-03 TO PRICER-OPT-VERS-SW
                       MOVE D-04 TO PROV-NEW-HOLD
                       MOVE D-05 TO WAGE-NEW-INDEX-RECORD
           DISPLAY 'COCOON B BILL-NEW-DATA '
               FUNCTION HEX-OF(BILL-NEW-DATA)
           DISPLAY 'COCOON B PPS-DATA-ALL '
               FUNCTION HEX-OF(PPS-DATA-ALL)
           DISPLAY 'COCOON B PRICER-OPT-VERS-SW '
               FUNCTION HEX-OF(PRICER-OPT-VERS-SW)
           DISPLAY 'COCOON B PROV-NEW-HOLD '
               FUNCTION HEX-OF(PROV-NEW-HOLD)
           DISPLAY 'COCOON B WAGE-NEW-INDEX-RECORD '
               FUNCTION HEX-OF(WAGE-NEW-INDEX-RECORD)
                       CALL 'LTCAL058' USING BILL-NEW-DATA
                                       PPS-DATA-ALL
                                       PRICER-OPT-VERS-SW
                                       PROV-NEW-HOLD
                                       WAGE-NEW-INDEX-RECORD
           DISPLAY 'COCOON A BILL-NEW-DATA '
               FUNCTION HEX-OF(BILL-NEW-DATA)
           DISPLAY 'COCOON A PPS-DATA-ALL '
               FUNCTION HEX-OF(PPS-DATA-ALL)
           DISPLAY 'COCOON A PRICER-OPT-VERS-SW '
               FUNCTION HEX-OF(PRICER-OPT-VERS-SW)
           DISPLAY 'COCOON A PROV-NEW-HOLD '
               FUNCTION HEX-OF(PROV-NEW-HOLD)
           DISPLAY 'COCOON A WAGE-NEW-INDEX-RECORD '
               FUNCTION HEX-OF(WAGE-NEW-INDEX-RECORD)
               END-READ
           END-PERFORM.
           CLOSE DFILE.
           STOP RUN.
