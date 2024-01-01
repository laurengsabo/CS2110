;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Factorial
;;=============================================================
;;  Name: Lauren Sabo
;;============================================================

;;  In this file, you must implement the 'MULTIPLY' and 'FACTORIAL' subroutines.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'MULTIPLY' or 'FACTORIAL' labels
;;      * Add the [a, b] or [n] params separated by a comma (,) 
;;        (e.g. 3, 5 for 'MULTIPLY' or 6 for 'FACTORIAL')
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to 
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. 3 * 5 = 15 or 6! = 720)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  MULTIPLY Pseudocode (see PDF for explanation and examples)   
;;  
;;  MULTIPLY(int a, int b) {
;;      int ret = 0;
;;      while (b > 0) {
;;          ret += a;
;;          b--;
;;      }
;;      return ret;
;;  }

MULTIPLY ;; Do not change this label! Treat this as like the name of the function in a function header
    
    ADD R6, R6, #-4
    STR R7, R6, #2
    STR R5, R6, #1
    ADD R5, R6, #0

    ADD R6, R6, #-5
    STR R0, R6, #0       ;; save R0
    STR R1, R6, #1       ;; save R1
    STR R2, R6, #2       ;; save R2
    STR R3, R6, #3       ;; save R3
    STR R4, R6, #4       ;; save R4

    LDR R0, R5, #4
    LDR R1, R5, #5
    AND R2, R2, #0

    MLOOP
        ADD R1, R1, #0
        BRnz ENDMLOOP
        ADD R2, R2, R0
        ADD R1, R1, #-1
        BR MLOOP
    ENDMLOOP

    STR R2, R5, #3

    LDR R0, R6, #0
    LDR R1, R6, #1
    LDR R2, R6, #2
    LDR R3, R6, #3
    LDR R4, R6, #4

    ADD R6, R5, #0

    LDR R5, R6, #1
    LDR R7, R6, #2

    ADD R6, R6, #3

    LDR R0, R6, #4
    LDR R1, R6, #3
    LDR R2, R6, #2
    LDR R3, R6, #1
    LDR R4, R6, #0

    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3  

    RET

;;  FACTORIAL Pseudocode (see PDF for explanation and examples)
;;
;;  FACTORIAL(int n) {
;;      int ret = 1;
;;      for (int x = 2; x <= n; x++) {
;;          ret = MULTIPLY(ret, x);
;;      }
;;      return ret;
;;  }

FACTORIAL ;; Do not change this label! Treat this as like the name of the function in a function header
    ADD R6, R6, #-4      ;; place stack pointer to build up first portion of the stack (a)
    STR R7, R6, #2       ;; save return address
    STR R5, R6, #1       ;; save old frame pointer
    ADD R5, R6, #0       ;; set current frame pointer

    ADD R6, R6, #-5      ;; place stack pointer to save all of the registers on the stack (b)
    STR R0, R6, #0       ;; save R0
    STR R1, R6, #1       ;; save R1
    STR R2, R6, #2       ;; save R2
    STR R3, R6, #3       ;; save R3
    STR R4, R6, #4       ;; save R4

    LDR R2, R5, #4
    NOT R2, R2
    ADD R2, R2, #1
    
    AND R1, R1, #0
    ADD R1, R1, #1
    AND R0, R0, #0
    ADD R0, R0, #2

    FLOOP
        ADD R3, R0, R2
        BRp ENDFLOOP
        ADD R6, R6, #-1
        STR R0, R6, #0
        ADD R6, R6, #-1
        STR R1, R6, #0
        JSR MULTIPLY
        LDR R1, R6, #0
        ADD R6, R6, #3
        ADD R0, R0, #1
        BR FLOOP
    ENDFLOOP
    
    STR R1, R5, #3

    LDR R0, R6, #0
    LDR R1, R6, #1
    LDR R2, R6, #2
    LDR R3, R6, #3
    LDR R4, R6, #4
    
    ADD R6, R5, #0

    LDR R5, R6, #1
    LDR R7, R6, #2

    ADD R6, R6, #3

    RET

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end