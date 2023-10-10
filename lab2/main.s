	.arch armv7-a
	.fpu vfpv3-d16
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	1
	.global	encryptDecrypt
	.syntax unified
	.thumb
	.thumb_func
	.type	encryptDecrypt, %function
encryptDecrypt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]
	mov	r3, r1
	strb	r3, [r7, #3]
	movs	r3, #0
	str	r3, [r7, #8]
	b	.L2
.L3:
	ldr	r3, [r7, #8]
	adds	r3, r3, #1
	str	r3, [r7, #8]
.L2:
	ldr	r3, [r7, #8]
	ldr	r2, [r7, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L3
	movs	r3, #0
	str	r3, [r7, #12]
	b	.L4
.L5:
	ldr	r3, [r7, #12]
	ldr	r2, [r7, #4]
	add	r3, r3, r2
	ldrb	r1, [r3]	@ zero_extendqisi2
	ldr	r3, [r7, #12]
	ldr	r2, [r7, #4]
	add	r3, r3, r2
	ldrb	r2, [r7, #3]
	eors	r2, r2, r1
	uxtb	r2, r2
	strb	r2, [r3]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	str	r3, [r7, #12]
.L4:
	ldr	r2, [r7, #12]
	ldr	r3, [r7, #8]
	cmp	r2, r3
	blt	.L5
	ldr	r3, [r7, #4]
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	encryptDecrypt, .-encryptDecrypt
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Enter message: \000"
	.align	2
.LC1:
	.ascii	"%99[^\012]\000"
	.align	2
.LC2:
	.ascii	"Enter encryption key: \000"
	.align	2
.LC3:
	.ascii	"%c\000"
	.align	2
.LC4:
	.ascii	"Encrypted message: %s\012\000"
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #112
	add	r7, sp, #0
	ldr	r2, .L10
.LPIC5:
	add	r2, pc
	ldr	r3, .L10+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [r7, #108]
	mov	r3, #0
	ldr	r3, .L10+8
.LPIC0:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	add	r3, r7, #8
	mov	r1, r3
	ldr	r3, .L10+12
.LPIC1:
	add	r3, pc
	mov	r0, r3
	bl	__isoc99_scanf(PLT)
	bl	getchar(PLT)
	ldr	r3, .L10+16
.LPIC2:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	adds	r3, r7, #3
	mov	r1, r3
	ldr	r3, .L10+20
.LPIC3:
	add	r3, pc
	mov	r0, r3
	bl	__isoc99_scanf(PLT)
	ldrb	r2, [r7, #3]	@ zero_extendqisi2
	add	r3, r7, #8
	mov	r1, r2
	mov	r0, r3
	bl	encryptDecrypt(PLT)
	str	r0, [r7, #4]
	ldr	r1, [r7, #4]
	ldr	r3, .L10+24
.LPIC4:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	movs	r3, #0
	ldr	r1, .L10+28
.LPIC6:
	add	r1, pc
	ldr	r2, .L10+4
	ldr	r2, [r1, r2]
	ldr	r1, [r2]
	ldr	r2, [r7, #108]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L9
	bl	__stack_chk_fail(PLT)
.L9:
	mov	r0, r3
	adds	r7, r7, #112
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L11:
	.align	2
.L10:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC5+4)
	.word	__stack_chk_guard(GOT)
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC2-(.LPIC2+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LC4-(.LPIC4+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC6+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",%progbits
