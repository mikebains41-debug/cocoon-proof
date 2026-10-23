       IDENTIFICATION DIVISION.
       PROGRAM-ID. DISP1.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  A   PIC 9(4)        VALUE 3.
       01  B   PIC S9(4)       VALUE -3.
       01  C   PIC S9(3)V99    VALUE 1.5.
       01  D   PIC 9(3)V99     VALUE 12.25.
       01  E   PIC S9(4) COMP  VALUE 42.
       01  F   PIC S9(5)V9 COMP-3 VALUE -123.4.
       01  G   PIC S9(4)       VALUE 0.
       01  H   PIC X(6)        VALUE 'AB'.
       PROCEDURE DIVISION.
           DISPLAY A
           DISPLAY B
           DISPLAY C
           DISPLAY D
           DISPLAY E
           DISPLAY F
           DISPLAY G
           DISPLAY 'H=' H '|' A ' ' 'X'
           DISPLAY 'NO ' WITH NO ADVANCING
           DISPLAY 'NEWLINE'
           STOP RUN.
