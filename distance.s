	.text

############################################################
## CSO1 Homework 5 - Fall 2025
## Your ID: qff9sw
##
## Sources used while completing the homework should be
## included here.  Remember that you may NOT use a compiler
## or generative AI to produce your solution!
##
##
##
##
############################################################

############################################################
##        product routine (multiplies using add)          ##
############################################################

	.globl	product
product:
	xorq	%rax, %rax
	movq	%rsi, %rdx
	product_loop:
	testq %rdx, %rdx
	je product_done
	addq %rdi, %rax
	subq $1, %rdx
	jmp product_loop
	product_done:
	retq

############################################################
##                 end of product routine                 ##
############################################################

############################################################
##        power routine (exponent using product)          ##
############################################################

	.globl	power
power:
	movq $1, %rax
	testq %rsi, %rsi
	je power_done
	testq %rdi, %rdi
	je base_zero
	movq %rdi,%rcx
	subq $1, %rsi
	call power
	movq %rax, %rdi
	movq %rcx, %rsi
	call product
	retq
	base_zero:
	xor %rax, %rax
	retq
	power_done:
	retq

############################################################
##                  end of power routine                  ##
############################################################

############################################################
##        distance routine (using power for square)       ##
############################################################

	.globl	distance
distance:
	xorq %rax, %rax
	movq %rdx, %r8
	subq %rdi, %r8
	movq %rcx, %r9
	subq %rsi, %r9
	movq $2, %rbx
	movq %r8, %rdi
	movq %rbx, %rsi
	call power
	movq %rax, %r10
	movq %r9, %rdi
	movq %rbx, %rsi
	call power
	addq %r10, %rax
	retq

############################################################
##                  end of distance routine               ##
############################################################


############################################################
	.globl	printNum
printNum:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%fs:40, %rax
	movq	%rax, 16(%rsp)
	movb	$48, 15(%rsp)
	testq	%rdi, %rdi
	je	.LBB0_9
	movq	%rdi, %r14
	movabsq	$1000000000000000, %rbx
	cmpq	%rbx, %rdi
	jae	.LBB0_5
	movabsq	$-3689348814741910323, %rsi
	.LBB0_3:
	movq	%rbx, %rcx
	movq	%rbx, %rax
	mulq	%rsi
	movq	%rdx, %rbx
	shrq	$3, %rbx
	cmpq	%r14, %rbx
	ja	.LBB0_3
	cmpq	$10, %rcx
	jb	.LBB0_7
.LBB0_5:
	movabsq	$-3689348814741910323, %r12
	leaq	15(%rsp), %r15
.LBB0_6:
	xorl	%edx, %edx
	movq	%r14, %rax
	divq	%rbx
	movq	%rax, %rcx
	mulq	%r12
	shrl	$2, %edx
	andl	$-2, %edx
	leal	(%rdx,%rdx,4), %eax
	subl	%eax, %ecx
	orb	$48, %cl
	movb	%cl, 15(%rsp)
	movl	$1, %edi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	write@PLT
	movq	%rbx, %rax
	mulq	%r12
	shrq	$3, %rdx
	cmpq	$9, %rbx
	movq	%rdx, %rbx
	ja	.LBB0_6
	jmp	.LBB0_7
.LBB0_9:
	leaq	15(%rsp), %rsi
	movl	$1, %edi
	movl	$1, %edx
	callq	write@PLT
.LBB0_7:
	leaq	15(%rsp), %rsi
	movb	$10, (%rsi)
	movl	$1, %edi
	movl	$1, %edx
	callq	write@PLT
	movq	%fs:40, %rax
	cmpq	16(%rsp), %rax
	jne	.LBB0_8
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB0_8:
	callq	__stack_chk_fail@PLT
############################################################




############################################################
	.globl	main
main:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	leaq	.L.str(%rip), %rsi
	movl	$1, %edi
	movl	$10, %edx
	callq	write@PLT
	leaq	7(%rsp), %rbx
	movb	$48, (%rbx)
	movb	$48, %al
	xorl	%r14d, %r14d
.LBB1_1:
	movsbq	%al, %rax
	leaq	(%r14,%r14,4), %rcx
	leaq	(%rax,%rcx,2), %r14
	addq	$-48, %r14
	xorl	%edi, %edi
	movl	$1, %edx
	movq	%rbx, %rsi
	callq	read@PLT
	movb	7(%rsp), %al
	cmpb	$10, %al
	jne	.LBB1_1
	leaq	.L.str.1(%rip), %rsi
	xorl	%ebx, %ebx
	xorl	%edi, %edi
	movl	$10, %edx
	callq	write@PLT
	leaq	7(%rsp), %r15
	movb	$48, (%r15)
	movb	$48, %al
	xorl	%r13d, %r13d
.LBB1_3:
	movsbq	%al, %rax
	leaq	(%r13,%r13,4), %rcx
	leaq	(%rax,%rcx,2), %r13
	addq	$-48, %r13
	xorl	%edi, %edi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	read@PLT
	movb	7(%rsp), %al
	cmpb	$10, %al
	jne	.LBB1_3
	leaq	.L.str.2(%rip), %rsi
	xorl	%ebx, %ebx
	xorl	%edi, %edi
	movl	$10, %edx
	callq	write@PLT
	leaq	7(%rsp), %r15
	movb	$48, (%r15)
	movb	$48, %al
	xorl	%r12d, %r12d
.LBB1_4:
	movsbq	%al, %rax
	leaq	(%r12,%r12,4), %rcx
	leaq	(%rax,%rcx,2), %r12
	addq	$-48, %r12
	xorl	%edi, %edi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	read@PLT
	movb	7(%rsp), %al
	cmpb	$10, %al
	jne	.LBB1_4
	leaq	.L.str.3(%rip), %rsi
	xorl	%ebx, %ebx
	xorl	%edi, %edi
	movl	$10, %edx
	callq	write@PLT
	leaq	7(%rsp), %r15
	movb	$48, (%r15)
	movb	$48, %al
.LBB1_2:
	movsbq	%al, %rax
	leaq	(%rbx,%rbx,4), %rcx
	leaq	(%rax,%rcx,2), %rbx
	addq	$-48, %rbx
	xorl	%edi, %edi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	read@PLT
	movb	7(%rsp), %al
	cmpb	$10, %al
	jne	.LBB1_2
	movq	%r14, %rdi
	movq	%r13, %rsi
	callq	product@PLT
	movq	%rax, %r15
	leaq	.L.str.4(%rip), %rsi
	movl	$1, %edi
	movl	$10, %edx
	callq	write@PLT
	movq	%r15, %rdi
	callq	printNum
	movq	%r14, %rdi
	movq	%r13, %rsi
	callq	power@PLT
	movq	%rax, %r15
	leaq	.L.str.5(%rip), %rsi
	movl	$1, %edi
	movl	$11, %edx
	callq	write@PLT
	movq	%r15, %rdi
	callq	printNum
	movq	%r14, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	movq	%rbx, %rcx
	callq	distance@PLT
	movq	%rax, %r15
	leaq	.L.str.6(%rip), %rsi
	movl	$1, %edi
	movl	$11, %edx
	callq	write@PLT
	movq	%r15, %rdi
	callq	printNum
	movq	%fs:40, %rax
	cmpq	8(%rsp), %rax
	jne	.LBB1_6
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB1_6:
	callq	__stack_chk_fail@PLT
############################################################




############################################################
	.section	.rodata
.L.str:
	.asciz	"Enter x1: "
.L.str.1:
	.asciz	"Enter y1: "
.L.str.2:
	.asciz	"Enter x2: "
.L.str.3:
	.asciz	"Enter y2: "
.L.str.4:
	.asciz	"x1 * y1 = "
.L.str.5:
	.asciz	"x1 ** y1 = "
.L.str.6:
	.asciz	"distance = "
############################################################
