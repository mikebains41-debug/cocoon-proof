000100****************************************************************  00010000
000200* COPYBOOK: ADXONTBL                                           *  00020000
000300* EXTRA RURAL COUNTY CODES                                     *  00030000
000400*--------------------------------------------------------------*  00040000
000500* CATEGORY                    CY2019 CY2020 CY2021 CY2022      *  00050000
000600* (A) HIGH UTILIZATION         1.5%   0.5%   ----   ----       *  00060000
000700* (B) LOW POPULATION DENSITY   4.0%   3.0%   2.0%   1.0%       *  00070000
000800* (C) ALL OTHER                3.0%   2.0%   1.0%   ----       *  00080000
000900****************************************************************  00090000
001000 01 T-EXTRA-COUNTY-CODES.                                         00100000
001100    05  T-EXTRA-COUNTY-CODE-DATA.                                 00110000
001200        10  FILLER             PIC X(6) VALUE '01063A'.           00120000
001300        10  FILLER             PIC X(6) VALUE '01129A'.           00130000
001400        10  FILLER             PIC X(6) VALUE '05047C'.           00140000
001500        10  FILLER             PIC X(6) VALUE '12075A'.           00150000
001600        10  FILLER             PIC X(6) VALUE '13259A'.           00160000
001700        10  FILLER             PIC X(6) VALUE '13263C'.           00170000
001800        10  FILLER             PIC X(6) VALUE '16077A'.           00180000
001900        10  FILLER             PIC X(6) VALUE '17057C'.           00190000
002000        10  FILLER             PIC X(6) VALUE '17087C'.           00200000
002100        10  FILLER             PIC X(6) VALUE '18047C'.           00210000
002200        10  FILLER             PIC X(6) VALUE '18121C'.           00220000
002300        10  FILLER             PIC X(6) VALUE '18171C'.           00230000
002400        10  FILLER             PIC X(6) VALUE '19015C'.           00240000
002500        10  FILLER             PIC X(6) VALUE '19099C'.           00250000
002600        10  FILLER             PIC X(6) VALUE '20061C'.           00260000
002700        10  FILLER             PIC X(6) VALUE '21043C'.           00270000
002800        10  FILLER             PIC X(6) VALUE '22007A'.           00280000
002900        10  FILLER             PIC X(6) VALUE '22067A'.           00290000
003000        10  FILLER             PIC X(6) VALUE '25011C'.           00300000
003100        10  FILLER             PIC X(6) VALUE '26067C'.           00310000
003200        10  FILLER             PIC X(6) VALUE '26155C'.           00320000
003300        10  FILLER             PIC X(6) VALUE '27075B'.           00330000
003400        10  FILLER             PIC X(6) VALUE '28031A'.           00340000
003500        10  FILLER             PIC X(6) VALUE '28051A'.           00350000
003600        10  FILLER             PIC X(6) VALUE '28131A'.           00360000
003700        10  FILLER             PIC X(6) VALUE '29053C'.           00370000
003800        10  FILLER             PIC X(6) VALUE '29089C'.           00380000
003900        10  FILLER             PIC X(6) VALUE '30095B'.           00390000
004000        10  FILLER             PIC X(6) VALUE '37007C'.           00400000
004100        10  FILLER             PIC X(6) VALUE '37029C'.           00410000
004200        10  FILLER             PIC X(6) VALUE '37077C'.           00420000
004300        10  FILLER             PIC X(6) VALUE '37085C'.           00430000
004400        10  FILLER             PIC X(6) VALUE '39123C'.           00440000
004500        10  FILLER             PIC X(6) VALUE '45027C'.           00450000
004600        10  FILLER             PIC X(6) VALUE '47053A'.           00460000
004700        10  FILLER             PIC X(6) VALUE '47161C'.           00470000
004800        10  FILLER             PIC X(6) VALUE '48203A'.           00480000
004900        10  FILLER             PIC X(6) VALUE '48431A'.           00490000
005000        10  FILLER             PIC X(6) VALUE '51097C'.           00500000
005100        10  FILLER             PIC X(6) VALUE '51113C'.           00510000
005200        10  FILLER             PIC X(6) VALUE '51175C'.           00520000
005300        10  FILLER             PIC X(6) VALUE '51620C'.           00530000
005400        10  FILLER             PIC X(6) VALUE '54035C'.           00540000
005500        10  FILLER             PIC X(6) VALUE '54065C'.           00550000
005600        10  FILLER             PIC X(6) VALUE '55069C'.           00560000
005700        10  FILLER             PIC X(6) VALUE '72001C'.           00570000
005800        10  FILLER             PIC X(6) VALUE '72083C'.           00580000
005900    05  FILLER     REDEFINES  T-EXTRA-COUNTY-CODE-DATA.           00590000
006000        10  T-ECC-DATA         OCCURS    47 TIMES                 00600000
006100                               ASCENDING KEY IS T-ECC-CODE        00610000
006200                               INDEXED BY IX-ECC.                 00620000
006300            15  T-ECC-CODE     PIC X(5).                          00630000
006400            15  T-ECC-CATEGORY PIC X(1).                          00640000
