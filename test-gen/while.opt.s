.__._fmt_int_:
	.string "%Ld"
.__._fmt_float_:
	.string "%lf"
.__._fmt_newline_:
	.string "
"
	.globl main
.data
	.__I: .quad 0
.data
	.__K: .quad 0
main:
	pushq	%rbp
	movq	%rsp, %rbp
..L1:
	movq	.__I, %rdx
	xorq	%rax, %rax
	cmpq	$100, %rdx
	setne	%al
	testq	%rax, %rax
	jz	..L2
	addq	$1, .__I
	addq	$3, .__K
	jmp	..L1
..L2:
	leaq	.__._fmt_int_, %rdi
	movq	.__K, %rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$0, .__I
	movq	$0, .__K
..L3:
	movq	.__I, %rdx
	xorq	%rax, %rax
	cmpq	$1000, %rdx
	setne	%al
	testq	%rax, %rax
	jz	..L4
	addq	$1, .__I
	addq	$3, .__K
	movq	.__I, %rdx
	xorq	%rax, %rax
	cmpq	$100, %rdx
	sete	%al
	testq	%rax, %rax
	jz	..L5
	jmp	..L4
	jmp	..L6
..L5:
..L6:
	jmp	..L3
..L4:
	leaq	.__._fmt_int_, %rdi
	movq	.__K, %rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$0, .__I
	movq	$0, .__K
..L7:
	movq	.__I, %rdx
	xorq	%rax, %rax
	cmpq	$200, %rdx
	setne	%al
	testq	%rax, %rax
	jz	..L8
	addq	$1, .__I
	movq	.__I, %rax
	xorq	%rdx, %rdx
	cqo
	movq	$2, %rbx
	idivq	%rbx
	movq	%rdx, %rax
	testq	%rax, %rax
	jz	..L9
	jmp	..L7
	jmp	..L10
..L9:
..L10:
	addq	$3, .__K
..L13:
	movq	$1, %rax
	testq	%rax, %rax
	jz	..L14
	jmp	..L14
	jmp	..L13
..L14:
	jmp	..L7
..L8:
	leaq	.__._fmt_int_, %rdi
	movq	.__K, %rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
..L15:
	jmp	..L16
	leaq	.__._fmt_int_, %rdi
	xorq	%rsi, %rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	jmp	..L15
..L16:
	popq	%rbp
	xorq	%rax, %rax
	ret

