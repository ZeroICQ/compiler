.__._fmt_int_:
	.string "%Ld"
.__._fmt_float_:
	.string "%lf"
.__._fmt_newline_:
	.string "
"
	.globl main
.data
	.__A: .double 0
.data
	.__B: .double 0
.__.str0:
	.string " "
.__.str1:
	.string " "
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	$10
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	leaq	.__A, %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	pushq	.__A
	pushq	.__A
	popq	%r10
	popq	%rax
	movq	%rax, %xmm0
	movq	%r10, %xmm1
	mulsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	pushq	.__A
	popq	%r10
	popq	%rax
	movq	%rax, %xmm0
	movq	%r10, %xmm1
	addsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	leaq	.__B, %rax
	pushq	%rax
	popq	%rax
	popq	(%rax)
	pushq	.__A
	pushq	$10
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	sete	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__A
	pushq	$10
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setne	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__A
	pushq	$9
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	seta	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__A
	pushq	$11
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	seta	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__A
	pushq	$11
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setb	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__A
	pushq	$9
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setb	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__B
	pushq	$110
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	sete	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__B
	pushq	.__A
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setae	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__B
	pushq	.__A
	pushq	.__B
	popq	%r10
	popq	%rax
	movq	%rax, %xmm0
	movq	%r10, %xmm1
	addsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setae	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__B
	pushq	.__A
	pushq	$100
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r10
	popq	%rax
	movq	%rax, %xmm0
	movq	%r10, %xmm1
	mulsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setbe	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	.__B
	pushq	$0
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setbe	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	leaq	.__.str0, %rdi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.200000, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	seta	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.200000, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setae	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setb	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setbe	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	sete	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.200000, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setb	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.200000, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setbe	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	seta	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setae	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setne	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	leaq	.__.str1, %rdi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	pushq	$0
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%r10
	popq	%rax
	movq	%rax, %xmm0
	movq	%r10, %xmm1
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	pushq	$0
	popq	%rax
	cvtsi2sd	%rax, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%r10
	popq	%rax
	movq	%rax, %xmm0
	movq	%r10, %xmm1
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	seta	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.200000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setae	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setb	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setbe	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setne	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.200000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setb	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.200000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setbe	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	seta	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.200000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	setae	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	movq	$10.100000, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, %xmm1
	xorpd	%xmm0, %xmm0
	subsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	pushq	%rax
	popq	%r11
	popq	%rax
	movq	%rax, %xmm0
	movq	%r11, %xmm1
	xorq	%rax, %rax
	comisd	%xmm1, %xmm0
	sete	%al
	pushq	%rax
	leaq	.__._fmt_int_, %rdi
	popq	%rsi
	call	printf
	leaq	.__._fmt_newline_, %rdi
	call	printf
	popq	%rbp
	xorq	%rax, %rax
	ret

