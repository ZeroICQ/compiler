.__._fmt_int_:
	.string "%Ld"
.__._fmt_float_:
	.string "%lf"
.__._fmt_newline_:
	.string "
"
	.globl main
.__.str0:
	.string " "
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	$2
	pushq	$2
	pushq	$2
	popq	%r10
	popq	%rax
	imulq	%r10, %rax
	pushq	%rax
	popq	%r10
	popq	%rax
	addq	%r10, %rax
	pushq	%rax
	pushq	$3
	pushq	$3
	popq	%r10
	popq	%rax
	addq	%r10, %rax
	pushq	%rax
	popq	%r10
	popq	%rax
	subq	%r10, %rax
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__.str0, %rdi
	call	printf
	pushq	$10
	pushq	$2
	popq	%r10
	popq	%rax
	cqo
	idivq	%r10
	pushq	%rax
	pushq	$3
	popq	%r10
	popq	%rax
	imulq	%r10, %rax
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	popq	%rbp
	xorq	%rax, %rax
	ret

