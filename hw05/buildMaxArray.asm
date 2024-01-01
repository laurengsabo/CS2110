;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - buildMaxArray
;;=============================================================
;; Name: Lauren Sabo
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;	int A[] = {-2, 2, 1};
;;	int B[] = {1, 0, 3};
;;	int C[3];
;;	int length = 3;
;;
;;	int i = 0;
;;	while (i < length) {
;;		if (A[i] >= B[length - i - 1]) {
;;			C[i] = 1;
;;		}
;;		else {
;;			C[i] = 0;
;;		}
;;		i++;
;;	}

.orig x3000
	AND R0, R0, 0	;clears R0
	LD R4, LENGTH	;stores the length of arrays A, B, C
	ADD R4, R4, #-1	;the max index of arrays A, B, C

LOOPSTART			;Loop starts here
	ADD R4, R4, 0	;
    BRn ENDLOOP     ;If R0 >= 0, jump to ENDLOOP

	LD R1, A		;stores the starting address of array A
	LD R2, B		;stores the starting address of array B
	LD R3, C		;stores the starting address of array C
	ADD R3, R3, R0	;R3 = is address of C[R0]
	AND R5, R5, 0

    ADD R1, R1, R0  ;R1 = is address of A[R0]
    LDR R1, R1, #0  ;R1 = is value of A[R0]

	ADD R2, R2, R4  ;R2 = is address of B[R4]
    LDR R2, R2, #0  ;R2 = is value of B[R4]
	NOT R2, R2		;~B[R4]
	ADD R2, R2, #1	;-B[R4]

	ADD R2, R1, R2	;R1 + -R2
	BRzp ONEFILL	;if NOT A[R0] - B[R4] < 0, then 1

	ADD R2, R2, #0
	BRn ZEROFILL	;if NOT A[R0] - B[R4] >= 0, then 0


ONEFILL
	ADD R5, R5, #1
	STR R5, R3, #0  ;1 is stored in the address of C[R0]
	ADD R0, R0, #1	;advances the R0 index one space
	ADD R4, R4, #-1	;takes the R4 index back one space
	BR LOOPSTART

ZEROFILL
	STR R5, R3, #0  ;0 is stored in the address of C[R0]
	ADD R0, R0, #1	;advances the R0 index one space
	ADD R4, R4, #-1	;takes the R4 index back one space
	BR LOOPSTART


ENDLOOP
	HALT

;; Do not change these addresses! 
;; We populate A and B and reserve space for C at these specific addresses in the orig statements below.
A 		.fill x3200		
B 		.fill x3300		
C 		.fill x3400		
LENGTH 	.fill 3			;; Change this value if you decide to increase the size of the arrays below.
.end

;; Do not change any of the .orig lines!
;; If you decide to add more values for debugging, make sure to adjust LENGTH and .blkw 3 accordingly.
.orig x3200				;; Array A : Feel free to change or add values for debugging.
	.fill -2
	.fill 2
	.fill 1
.end

.orig x3300				;; Array B : Feel free change or add values for debugging.
	.fill 1
	.fill 0
	.fill 3
.end

.orig x3400
	.blkw 3				;; Array C: Make sure to increase block size if you've added more values to Arrays A and B!
.end