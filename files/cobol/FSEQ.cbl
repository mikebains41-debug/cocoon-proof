       IDENTIFICATION DIVISION.
       PROGRAM-ID. FSEQ.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT REC-FILE ASSIGN TO RECFILE
               ORGANIZATION IS SEQUENTIAL
               FILE STATUS IS WS-FS.
       DATA DIVISION.
       FILE SECTION.
       FD  REC-FILE.
       01  REC.
           05  REC-KEY    PIC 9(3).
           05  REC-NAME   PIC X(5).
       WORKING-STORAGE SECTION.
       01  WS-FS          PIC XX.
       01  WS-I           PIC 9(3) VALUE 0.
       PROCEDURE DIVISION.
           OPEN OUTPUT REC-FILE
           PERFORM 3 TIMES
               ADD 1 TO WS-I
               MOVE WS-I TO REC-KEY
               MOVE 'NAME' TO REC-NAME
               WRITE REC
           END-PERFORM
           CLOSE REC-FILE
           OPEN EXTEND REC-FILE
           MOVE 9 TO REC-KEY
           MOVE 'LAST' TO REC-NAME
           WRITE REC
           CLOSE REC-FILE
           OPEN I-O REC-FILE
           READ REC-FILE
           READ REC-FILE
           MOVE 'TWO' TO REC-NAME
           REWRITE REC
           DISPLAY 'REWRITE ' WS-FS
           CLOSE REC-FILE
           OPEN INPUT REC-FILE
           PERFORM 5 TIMES
               READ REC-FILE
                   AT END DISPLAY 'END ' WS-FS
                   NOT AT END DISPLAY REC-KEY ' ' REC-NAME ' ' WS-FS
               END-READ
           END-PERFORM
           READ REC-FILE
           DISPLAY 'AFTER END ' WS-FS
           CLOSE REC-FILE
           CLOSE REC-FILE
           DISPLAY 'CLOSED TWICE ' WS-FS
           STOP RUN.
