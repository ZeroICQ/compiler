.__._fmt_int_:
	.string "%Ld"
.__._fmt_float_:
	.string "%lf"
.__._fmt_newline_:
	.string "
"
	.globl main
main:
	pushq	%rbp
	movq	%rsp, %rbp
// start block
	movq	$1.000000, %rax
	pushq	%rax
	movq	$2.000000, %rax
	pushq	%rax
	popq	%rbx
	popq	%rax
	movq	%rax, %xmm0
	movq	%rbx, %xmm1
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$100.000000, %rax
	pushq	%rax
	popq	%rbx
	popq	%rax
	movq	%rax, %xmm0
	movq	%rbx, %xmm1
	mulsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	leaq	.__._fmt_float_, %rdi
	popq	%rax
	movq	%rax, %xmm0
	movq	$1, %rax
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$100.000000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	leaq	.__._fmt_float_, %rdi
	popq	%rax
	movq	%rax, %xmm0
	movq	$1, %rax
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
// end block
	popq	%rbp
	xorq	%rax, %rax
	ret

