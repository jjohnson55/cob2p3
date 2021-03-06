        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. Project3.
AUTHOR. John Stephen Johnson.
ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  SNUMS.
      03  SHRSVAR PIC 999V99.
      03  SRATEVAR PIC 999V99.
      03  SHRSTO40 PIC 999V99.
      03  SPAY PIC 9(5)V99.
      03  SOVERTIME PIC 999V99.
      03  SOVERTIMEPAY PIC 999V99.
      03  SOVERTIMETOT PIC 9(5)V99.
      03  STOTAL PIC 9(5)V99.
01  SEXIT PIC X.    
01  SDATEVARS.
      03  SDAY PIC 9(4).
      03  SMONTH PIC 99.
      03  SYEAR PIC 99.
01  SDATEDISPLAYINFO.
      03  HMONTH PIC XX.
      03  FILLER PIC X VALUE '-'.
      03  HDAY PIC XX.
      03  FILLER PIC X VALUE '-'.
      03  HYEAR PIC XXXX.
SCREEN SECTION.
01  HEADERVARS.
      03  HEADER.
       05  LINE 01 COL 01  VALUE 'JOHN STEPHEN JOHNSON'.
       05  COL 37  VALUE 'PROJECT 3'.
       05  COL 71  PIC X(10)    FROM SDATEDISPLAYINFO.
01  INPUTVARS.
      03  HRVARS.
       05  LINE  6 COL 11  VALUE 'HOURS WORKED'.
       05  COL 25  PIC ZZ9.99  TO SHRSVAR.
      03  RVARS.
       05  LINE  7 COL 11  VALUE 'PAY RATE'.
       05  COL 25  PIC ZZ9.99  TO SRATEVAR.
01  OUTVARS.
      03  LINE 10 COL 35  PIC X(6) VALUE 'HOURS'.
      03  LINE 10 COL 42 PIC X(6) VALUE 'PAY'.
      03  LINE 10 COL 50  PIC X(6) VALUE 'TOTALS'.
      03  LINE 11 COL 23  VALUE 'REGULAR'.
      03  COL 34  PIC ZZ9.99  FROM SHRSTO40.
      03  COL 42  PIC ZZ9.99  FROM SRATEVAR. 
      03  COL 50  PIC ZZ,ZZ9.99  FROM SPAY.
      03  LINE 12 COL 23  VALUE 'OT'.
      03  COL 34  PIC ZZ9.99  FROM SOVERTIME.
      03  COL 42  PIC ZZ9.99  FROM SOVERTIMEPAY.
      03  COL 50  PIC ZZ,ZZ9.99  FROM SOVERTIMETOT.
      03  LINE 14 COL 23  VALUE 'OVERALL'.
      03  COL 34  PIC ZZ9.99  FROM SHRSVAR. 
      03  COL 50  PIC ZZ,ZZ9.99  FROM STOTAL.
01  EXITMSG.
      03  LINE 24 COL 70  PIC X TO SEXIT.
      03  COL 26  VALUE 'PRESS ANY KEY TO RUN AGAIN OR Q TO EXIT'.
PROCEDURE DIVISION.
100-MAIN.
      PERFORM 300-DATE.
      DISPLAY HEADER.
      PERFORM UNTIL SEXIT EQUALS 'q' OR 'Q'
       DISPLAY INPUTVARS
       ACCEPT  HRVARS
       ACCEPT  RVARS
       PERFORM 200-COMPUTETOTALS
       DISPLAY OUTVARS
       DISPLAY EXITMSG
       ACCEPT  EXITMSG
      END-PERFORM.
      STOP RUN.
     
200-COMPUTETOTALS.
      IF SHRSVAR <= 40
       MOVE SHRSVAR TO SHRSTO40
       MOVE ZERO TO SOVERTIME
       MOVE ZERO TO SOVERTIMEPAY
       MOVE ZERO TO SOVERTIMETOT
      ELSE
       MOVE 40 TO SHRSTO40
       COMPUTE SOVERTIME = SHRSVAR - 40
       COMPUTE SOVERTIMEPAY ROUNDED = SRATEVAR * 1.5
       COMPUTE SOVERTIMETOT  ROUNDED = SOVERTIME  * SOVERTIMEPAY
      END-IF.
       COMPUTE SPAY ROUNDED = SHRSTO40 * SRATEVAR.
       COMPUTE STOTAL = SPAY + SOVERTIMETOT.
     
300-DATE.
       MOVE FUNCTION CURRENT-DATE TO SDATEVARS.
       MOVE SMONTH TO HMONTH.
       MOVE SYEAR TO HDAY.
       MOVE SDAY TO HYEAR.
     