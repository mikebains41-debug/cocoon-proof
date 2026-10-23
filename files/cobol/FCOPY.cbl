       IDENTIFICATION DIVISION.
       PROGRAM-ID. FCOPY.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IN-FILE ASSIGN TO INFILE
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-IN-FS.
           SELECT OUT-FILE ASSIGN TO OUTFILE
               ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  IN-FILE.
       01  IN-REC.
           05  IN-ID      PIC X(4).
           05  IN-AMT     PIC 9(5).
       01  IN-ALT         PIC X(9).
       FD  OUT-FILE.
       01  OUT-REC.
           05  OUT-ID     PIC X(4).
           05  FILLER     PIC X VALUE SPACE.
           05  OUT-AMT    PIC 9(7).
       WORKING-STORAGE SECTION.
       01  WS-IN-FS       PIC XX.
       01  WS-EOF         PIC X VALUE 'N'.
       01  WS-COUNT       PIC 9(4) VALUE 0.
       01  WS-COPY        PIC X(9).
       PROCEDURE DIVISION.
           OPEN INPUT IN-FILE
           OPEN OUTPUT OUT-FILE
           PERFORM UNTIL WS-EOF = 'Y'
               READ IN-FILE INTO WS-COPY
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END
                       ADD 1 TO WS-COUNT
                       MOVE IN-ID TO OUT-ID
                       MOVE IN-AMT TO OUT-AMT
                       WRITE OUT-REC
               END-READ
           END-PERFORM
           CLOSE IN-FILE OUT-FILE
           DISPLAY WS-COUNT
           DISPLAY WS-IN-FS
           DISPLAY WS-COPY
           STOP RUN.
