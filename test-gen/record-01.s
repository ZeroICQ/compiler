.__._fmt_int_:
	.string "%Ld"
.__._fmt_float_:
	.string "%lf"
.__._fmt_newline_:
	.string "
"
	.globl main
.data
	.__P: .fill 16,1,0
.__.str0:
	.string " "
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	$10
	leaq	.__P, %rax
	pushq	%rax
	popq	%rax
	movq	$0, %rcx
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	pushq	$20
	leaq	.__P, %rax
	pushq	%rax
	popq	%rax
	movq	$8, %rcx
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	leaq	.__P, %rax
	pushq	%rax
	popq	%r11
	movq	$0, %r13
	movq	(%r11,%r13,1), %r11
	pushq	%r11
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__.str0, %rdi
	call	printf
	leaq	.__P, %rax
	pushq	%rax
	popq	%r11
	movq	$8, %r13
	movq	(%r11,%r13,1), %r11
	pushq	%r11
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	popq	%rbp
	xorq	%rax, %rax
	ret

