;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - modulus
;;=============================================================
;; Name: Lauren Sabo
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  int x = 17;
;;  int mod = 5;
;;  while (x >= mod) {
;;      x -= mod;
;;  }
;;  mem[ANSWER] = x;

.orig x3000
    LD R0, X        ;R0 = X
    LD R1, MOD      ;R1 = MOD

    NOT R2, R1
    ADD R2, R2, #1  ;R2 = -MOD

LOOPSTART           ;Loop starts up here
    ADD R0, R0, 0   ;
    BRn ENDLOOP     ;If R0 >= 0, jump to ENDLOOP
    ADD R0, R0, R2  ;R0 = R0 + -MOD = R0 - MOD

    BR LOOPSTART    ;Jump back to LOOPSTART


ENDLOOP
ADD R0, R0, R1
ST R0, ANSWER ;ANSWER = R0

    HALT

    ;; Feel free to change the below values for debugging. We will vary these values when testing your code.
    X      .fill 17
    MOD    .fill 5     
    ANSWER .blkw 1
.end