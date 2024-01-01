;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - palindrome
;;=============================================================
;; Name: Lauren Sabo
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "aibohphobia";
;;  boolean isPalindrome = true
;;  int length = 0;
;;  while (str[length] != '\0') {
;;		length++;
;;	}
;; 	
;;	int left = 0
;;  int right = length - 1
;;  while(left < right) {
;;		if (str[left] != str[right]) {
;;			isPalindrome = false;
;;			break;
;;		}
;;		left++;
;;		right--;
;;	}
;;	mem[mem[ANSWERADDR]] = isPalindrome;

.orig x3000
	AND R0, R0, #0	;clear R0

LOOPSTART1
	LD R7, STRING	;
	ADD R1, R0, R7	;R1 = is address of string[len]
	LDR R2, R1, #0	;R2 = is string[len]
	BRz ENDLOOP1	;if R2 != 0, then ENDLOOP1

	ADD R0, R0, #1	;R0+1
	BR LOOPSTART1	;restart Loop1
ENDLOOP1

AND R1, R1, #0		;clear R1
ADD R1, R1, #1		;R1 = 1
AND R2, R2, #0		;clear R2

LOOPSTART2
	NOT R6, R0		;R6 = ~R0 (R0 = len)
	ADD R7, R6, #1	;R7 = -len
	ADD R3, R2, R7	;R3 = R2 + -len
	BRzp ENDLOOP2	;if R3 < 0, then ENDLOOP2

	LD R7, STRING
	ADD R7, R7, R2	;R7 = is address of string[R2]
	LDR R3, R7, #0	;R3 = is the value of string[R2]

	NOT R4, R2
	ADD R4, R4, #1	;R4 = -R2
	ADD R5, R0, R4	;R5 = len + -R2
	ADD R5, R5, #-1 ;R5 = len + -R2 - 1

	LD R7, STRING
	ADD R7, R5, R7	;R7 = is address of string[R5]
	LDR R4, R7, #0	;R4 = is the value of string[R5]

	NOT R4, R4		;~R4
	ADD R4, R4, #1	;-R4
	ADD R6, R3, R4	;(string[R2 + -len]) + -(string[len - R2 - 1])
	BRz ENDQ		;if R6 != 0, then ENDQ
		AND R1, R1, #0	;clears R1
		BR ENDLOOP2	;end Loop2
	ENDQ

	ADD R2, R2, #1	;R2 + 1
	BR LOOPSTART2	;restart Loop2

ENDLOOP2


ST R1, ANSWERADDR
	HALT

;; Do not change these values!
STRING	.fill x4004
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!
.orig x4004				   
	.stringz "aibohphobia" ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1
.end