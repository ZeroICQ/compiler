.__._fmt_int_:
	.string "%Ld"
.__._fmt_float_:
	.string "%lf"
.__._fmt_newline_:
	.string "
"
	.globl main
.data
	.__A: .fill 192,1,0
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	$415
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$4
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%rcx
	imulq	$8, %rcx
	popq	%rax
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	pushq	$416
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$4
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$6
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%rcx
	imulq	$8, %rcx
	popq	%rax
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$4
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%r12
	imulq	$8, %r12
	popq	%r10
	movq	(%r10,%r12,1), %r10
	pushq	%r10
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$3
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%rcx
	imulq	$8, %rcx
	popq	%rax
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$4
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%r12
	imulq	$8, %r12
	popq	%r10
	movq	(%r10,%r12,1), %r10
	pushq	%r10
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$3
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$2
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%rcx
	imulq	$8, %rcx
	popq	%rax
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$4
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%r12
	imulq	$8, %r12
	popq	%r10
	movq	(%r10,%r12,1), %r10
	pushq	%r10
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$3
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$6
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%rcx
	imulq	$8, %rcx
	popq	%rax
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$4
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%r12
	imulq	$8, %r12
	popq	%r10
	movq	(%r10,%r12,1), %r10
	pushq	%r10
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$3
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%r12
	imulq	$8, %r12
	popq	%r10
	movq	(%r10,%r12,1), %r10
	pushq	%r10
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$3
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$2
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%r12
	imulq	$8, %r12
	popq	%r10
	movq	(%r10,%r12,1), %r10
	pushq	%r10
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$3
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$6
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%r12
	imulq	$8, %r12
	popq	%r10
	movq	(%r10,%r12,1), %r10
	pushq	%r10
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$0
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$0
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$0
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%rcx
	imulq	$8, %rcx
	popq	%rax
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$4
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$1
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$5
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%rcx
	imulq	$8, %rcx
	popq	%rax
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%r10
	popq	%rax
	addq	%r10, %rax
	pushq	%rax
	leaq	.__A, %rax
	pushq	%rax
	pushq	$0
	pushq	$0
	movq	$2, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$6, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$0
	movq	$1, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$4, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	pushq	$0
	movq	$3, %r9
	popq	%rax
	subq	%r9, %rax
	movq	$1, %r9
	imulq	%r9, %rax
	popq	%r9
	addq	%r9, %rax
	pushq	%rax
	popq	%rcx
	imulq	$8, %rcx
	popq	%rax
	leaq	(%rax,%rcx,1), %rax
	pushq	%rax
	popq	%r10
	popq	%rax
	subq	%r10, %rax
	pushq	%rax
	pushq	$8
	popq	%r10
	popq	%rax
	addq	%r10, %rax
	pushq	%rax
	popq	%rax
	pushq	(%rax)
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	popq	%rbp
	xorq	%rax, %rax
	ret

