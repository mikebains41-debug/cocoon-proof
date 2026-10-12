       IDENTIFICATION DIVISION.
       PROGRAM-ID. HHDIRECT.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT DFILE ASSIGN TO 'direct.dat'
               ORGANIZATION IS SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  DFILE
           RECORD CONTAINS 844 CHARACTERS.
       01  D-REC.
           05  D-HHA       PIC X(650).
           05  D-HOLD      PIC X(42).
           05  D-CBSA      PIC X(19).
           05  D-REV       PIC X(54).
           05  D-STDV      PIC X(78).
           05  D-HRG       PIC X(1).
       WORKING-STORAGE SECTION.
       01  WS-EOF                  PIC X VALUE 'N'.
       01  HHA-INPUT-DATA          PIC X(650).
       01  HOLD-VARIABLES-DATA     PIC X(42).
       01  CBSA-WAGE-INDEX-DATA    PIC X(19).
       01  TB-REV-DOLL-RATE-UNITS  PIC X(54).
       01  TB-STDV-DATA            PIC X(78).
       01  L-HRG-THRESHOLD         PIC X(1).
       PROCEDURE DIVISION.
           OPEN INPUT DFILE.
           PERFORM UNTIL WS-EOF = 'Y'
               READ DFILE
                   AT END
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
                       MOVE D-HHA TO HHA-INPUT-DATA
                       MOVE D-HOLD TO HOLD-VARIABLES-DATA
                       MOVE D-CBSA TO CBSA-WAGE-INDEX-DATA
                       MOVE D-REV TO TB-REV-DOLL-RATE-UNITS
                       MOVE D-STDV TO TB-STDV-DATA
                       MOVE D-HRG TO L-HRG-THRESHOLD
                       CALL 'HHCAL213' USING HHA-INPUT-DATA
                                             HOLD-VARIABLES-DATA
                                             CBSA-WAGE-INDEX-DATA
                                             TB-REV-DOLL-RATE-UNITS
                                             TB-STDV-DATA
                                             L-HRG-THRESHOLD
               END-READ
           END-PERFORM.
           CLOSE DFILE.
           STOP RUN.
