;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - octalStringToInt
;;=============================================================
;; Name: Lauren Sabo
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String octalString = "2110";
;;  int length = 4;
;;  int value = 0;
;;  int i = 0;
;;  while (i < length) {
;;      int leftShifts = 3;
;;      while (leftShifts > 0) {
;;          value += value;
;;          leftShifts--;
;;      }
;;      int digit = octalString[i] - 48;
;;      value += digit;
;;      i++;
;;  }
;;  mem[mem[RESULTADDR]] = value;

.orig x3000
    ;; YOUR CODE HERE
    HALT
    
;; Do not change these values! 
;; Notice we wrote some values in hex this time. Maybe those values should be treated as addresses?
ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "2110"            ;;  You can change this string for debugging!
.end
