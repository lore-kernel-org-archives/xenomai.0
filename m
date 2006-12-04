From: Sebastian Smolorz <ssm@domain.hid>
Date: Mon, 4 Dec 2006 18:23:56 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_smFdF1DMCk1ne6j"
Message-Id: <E1GrHXk-00023w-Oq@domain.hid>
Subject: [Adeos-main] [PATCH] I-pipe tracer for ARM
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

--Boundary-00=_smFdF1DMCk1ne6j
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

here comes a preliminary version of the missing ARM-parts for the I-pipe 
tracer. It's not yet complete, some features for the tracing of IRQs-off 
times are missing, but will soon be added. Besides of that, the tracer seems 
to work. ;-)

The following traces were recorded on a S3C2440. It would be nice if someone 
could have a look at them and determine if everything looks sane so far.

--
Sebastian

--Boundary-00=_smFdF1DMCk1ne6j
Content-Type: text/x-diff; charset="us-ascii"; name="ipipe-tracer-arm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-tracer-arm.patch"

diff -uNrp ipipe/v2.6/2.6.15/arch/arm/boot/compressed/head.S ipipe.work/v2.6/2.6.15/arch/arm/boot/compressed/head.S
--- ipipe/v2.6/2.6.15/arch/arm/boot/compressed/head.S	1970-01-01 01:00:00.000000000 +0100
+++ ipipe.work/v2.6/2.6.15/arch/arm/boot/compressed/head.S	2006-12-04 17:45:52.000000000 +0100
@@ -0,0 +1,727 @@
+/*
+ *  linux/arch/arm/boot/compressed/head.S
+ *
+ *  Copyright (C) 1996-2002 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/config.h>
+#include <linux/linkage.h>
+
+/*
+ * Debugging stuff
+ *
+ * Note that these macros must not contain any code which is not
+ * 100% relocatable.  Any attempt to do so will result in a crash.
+ * Please select one of the following when turning on debugging.
+ */
+#ifdef DEBUG
+
+#if defined(CONFIG_DEBUG_ICEDCC)
+		.macro	loadsp, rb
+		.endm
+		.macro	writeb, ch, rb
+		mcr	p14, 0, \ch, c0, c1, 0
+		.endm
+#else
+
+#include <asm/arch/debug-macro.S>
+
+		.macro	writeb,	ch, rb
+		senduart \ch, \rb
+		.endm
+
+#if defined(CONFIG_ARCH_SA1100)
+		.macro	loadsp, rb
+		mov	\rb, #0x80000000	@ physical base address
+#ifdef CONFIG_DEBUG_LL_SER3
+		add	\rb, \rb, #0x00050000	@ Ser3
+#else
+		add	\rb, \rb, #0x00010000	@ Ser1
+#endif
+		.endm
+#elif defined(CONFIG_ARCH_IOP331)
+		.macro loadsp, rb
+                mov   	\rb, #0xff000000
+                orr     \rb, \rb, #0x00ff0000
+                orr     \rb, \rb, #0x0000f700   @ location of the UART
+		.endm
+#elif defined(CONFIG_ARCH_S3C2410)
+		.macro loadsp, rb
+		mov	\rb, #0x50000000
+		add	\rb, \rb, #0x4000 * CONFIG_S3C2410_LOWLEVEL_UART_PORT
+		.endm
+#else
+		.macro	loadsp,	rb
+		addruart \rb
+		.endm
+#endif
+#endif
+#endif
+
+		.macro	kputc,val
+		mov	r0, \val
+		bl	putc
+		.endm
+
+		.macro	kphex,val,len
+		mov	r0, \val
+		mov	r1, #\len
+		bl	phex
+		.endm
+
+		.macro	debug_reloc_start
+#ifdef DEBUG
+		kputc	#'\n'
+		kphex	r6, 8		/* processor id */
+		kputc	#':'
+		kphex	r7, 8		/* architecture id */
+		kputc	#':'
+		mrc	p15, 0, r0, c1, c0
+		kphex	r0, 8		/* control reg */
+		kputc	#'\n'
+		kphex	r5, 8		/* decompressed kernel start */
+		kputc	#'-'
+		kphex	r8, 8		/* decompressed kernel end  */
+		kputc	#'>'
+		kphex	r4, 8		/* kernel execution address */
+		kputc	#'\n'
+#endif
+		.endm
+
+		.macro	debug_reloc_end
+#ifdef DEBUG
+		kphex	r5, 8		/* end of kernel */
+		kputc	#'\n'
+		mov	r0, r4
+		bl	memdump		/* dump 256 bytes at start of kernel */
+#endif
+		.endm
+
+		.section ".start", #alloc, #execinstr
+/*
+ * sort out different calling conventions
+ */
+		.align
+start:
+		.type	start,#function
+		.rept	8
+		mov	r0, r0
+		.endr
+
+		b	1f
+		.word	0x016f2818		@ Magic numbers to help the loader
+		.word	start			@ absolute load/run zImage address
+		.word	_edata			@ zImage end address
+1:		mov	r7, r1			@ save architecture ID
+		mov	r8, #0			@ save r0
+
+#ifndef __ARM_ARCH_2__
+		/*
+		 * Booting from Angel - need to enter SVC mode and disable
+		 * FIQs/IRQs (numeric definitions from angel arm.h source).
+		 * We only do this if we were in user mode on entry.
+		 */
+		mrs	r2, cpsr		@ get current mode
+		tst	r2, #3			@ not user?
+		bne	not_angel
+		mov	r0, #0x17		@ angel_SWIreason_EnterSVC
+		swi	0x123456		@ angel_SWI_ARM
+not_angel:
+		mrs	r2, cpsr		@ turn off interrupts to
+		orr	r2, r2, #0xc0		@ prevent angel from running
+		msr	cpsr_c, r2
+#else
+		teqp	pc, #0x0c000003		@ turn off interrupts
+#endif
+
+		/*
+		 * Note that some cache flushing and other stuff may
+		 * be needed here - is there an Angel SWI call for this?
+		 */
+
+		/*
+		 * some architecture specific code can be inserted
+		 * by the linker here, but it should preserve r7 and r8.
+		 */
+
+		.text
+		adr	r0, LC0
+		ldmia	r0, {r1, r2, r3, r4, r5, r6, ip, sp}
+		subs	r0, r0, r1		@ calculate the delta offset
+
+						@ if delta is zero, we are
+		beq	not_relocated		@ running at the address we
+						@ were linked at.
+
+		/*
+		 * We're running at a different address.  We need to fix
+		 * up various pointers:
+		 *   r5 - zImage base address
+		 *   r6 - GOT start
+		 *   ip - GOT end
+		 */
+		add	r5, r5, r0
+		add	r6, r6, r0
+		add	ip, ip, r0
+
+#ifndef CONFIG_ZBOOT_ROM
+		/*
+		 * If we're running fully PIC === CONFIG_ZBOOT_ROM = n,
+		 * we need to fix up pointers into the BSS region.
+		 *   r2 - BSS start
+		 *   r3 - BSS end
+		 *   sp - stack pointer
+		 */
+		add	r2, r2, r0
+		add	r3, r3, r0
+		add	sp, sp, r0
+
+		/*
+		 * Relocate all entries in the GOT table.
+		 */
+1:		ldr	r1, [r6, #0]		@ relocate entries in the GOT
+		add	r1, r1, r0		@ table.  This fixes up the
+		str	r1, [r6], #4		@ C references.
+		cmp	r6, ip
+		blo	1b
+#else
+
+		/*
+		 * Relocate entries in the GOT table.  We only relocate
+		 * the entries that are outside the (relocated) BSS region.
+		 */
+1:		ldr	r1, [r6, #0]		@ relocate entries in the GOT
+		cmp	r1, r2			@ entry < bss_start ||
+		cmphs	r3, r1			@ _end < entry
+		addlo	r1, r1, r0		@ table.  This fixes up the
+		str	r1, [r6], #4		@ C references.
+		cmp	r6, ip
+		blo	1b
+#endif
+
+not_relocated:	mov	r0, #0
+1:		str	r0, [r2], #4		@ clear bss
+		str	r0, [r2], #4
+		str	r0, [r2], #4
+		str	r0, [r2], #4
+		cmp	r2, r3
+		blo	1b
+
+		/*
+		 * The C runtime environment should now be setup
+		 * sufficiently.  Turn the cache on, set up some
+		 * pointers, and start decompressing.
+		 */
+		bl	cache_on
+
+		mov	r1, sp			@ malloc space above stack
+		add	r2, sp, #0x10000	@ 64k max
+
+/*
+ * Check to see if we will overwrite ourselves.
+ *   r4 = final kernel address
+ *   r5 = start of this image
+ *   r2 = end of malloc space (and therefore this image)
+ * We basically want:
+ *   r4 >= r2 -> OK
+ *   r4 + image length <= r5 -> OK
+ */
+		cmp	r4, r2
+		bhs	wont_overwrite
+		add	r0, r4, #4096*1024	@ 4MB largest kernel size
+		cmp	r0, r5
+		bls	wont_overwrite
+
+		mov	r5, r2			@ decompress after malloc space
+		mov	r0, r5
+		mov	r3, r7
+		bl	decompress_kernel
+
+		add	r0, r0, #127
+		bic	r0, r0, #127		@ align the kernel length
+/*
+ * r0     = decompressed kernel length
+ * r1-r3  = unused
+ * r4     = kernel execution address
+ * r5     = decompressed kernel start
+ * r6     = processor ID
+ * r7     = architecture ID
+ * r8-r14 = unused
+ */
+		add	r1, r5, r0		@ end of decompressed kernel
+		adr	r2, reloc_start
+		ldr	r3, LC1
+		add	r3, r2, r3
+1:		ldmia	r2!, {r8 - r13}		@ copy relocation code
+		stmia	r1!, {r8 - r13}
+		ldmia	r2!, {r8 - r13}
+		stmia	r1!, {r8 - r13}
+		cmp	r2, r3
+		blo	1b
+
+		bl	cache_clean_flush
+		add	pc, r5, r0		@ call relocation code
+
+/*
+ * We're not in danger of overwriting ourselves.  Do this the simple way.
+ *
+ * r4     = kernel execution address
+ * r7     = architecture ID
+ */
+wont_overwrite:	mov	r0, r4
+		mov	r3, r7
+		bl	decompress_kernel
+		b	call_kernel
+
+		.type	LC0, #object
+LC0:		.word	LC0			@ r1
+		.word	__bss_start		@ r2
+		.word	_end			@ r3
+		.word	zreladdr		@ r4
+		.word	_start			@ r5
+		.word	_got_start		@ r6
+		.word	_got_end		@ ip
+		.word	user_stack+4096		@ sp
+LC1:		.word	reloc_end - reloc_start
+		.size	LC0, . - LC0
+
+#ifdef CONFIG_ARCH_RPC
+		.globl	params
+params:		ldr	r0, =params_phys
+		mov	pc, lr
+		.ltorg
+		.align
+#endif
+
+/*
+ * Turn on the cache.  We need to setup some page tables so that we
+ * can have both the I and D caches on.
+ *
+ * We place the page tables 16k down from the kernel execution address,
+ * and we hope that nothing else is using it.  If we're using it, we
+ * will go pop!
+ *
+ * On entry,
+ *  r4 = kernel execution address
+ *  r6 = processor ID
+ *  r7 = architecture number
+ *  r8 = run-time address of "start"
+ * On exit,
+ *  r1, r2, r3, r8, r9, r12 corrupted
+ * This routine must preserve:
+ *  r4, r5, r6, r7
+ */
+		.align	5
+cache_on:	mov	r3, #8			@ cache_on function
+		b	call_cache_fn
+
+__setup_mmu:	sub	r3, r4, #16384		@ Page directory size
+		bic	r3, r3, #0xff		@ Align the pointer
+		bic	r3, r3, #0x3f00
+/*
+ * Initialise the page tables, turning on the cacheable and bufferable
+ * bits for the RAM area only.
+ */
+		mov	r0, r3
+		mov	r8, r0, lsr #18
+		mov	r8, r8, lsl #18		@ start of RAM
+		add	r9, r8, #0x10000000	@ a reasonable RAM size
+		mov	r1, #0x12
+		orr	r1, r1, #3 << 10
+		add	r2, r3, #16384
+1:		cmp	r1, r8			@ if virt > start of RAM
+		orrhs	r1, r1, #0x0c		@ set cacheable, bufferable
+		cmp	r1, r9			@ if virt > end of RAM
+		bichs	r1, r1, #0x0c		@ clear cacheable, bufferable
+		str	r1, [r0], #4		@ 1:1 mapping
+		add	r1, r1, #1048576
+		teq	r0, r2
+		bne	1b
+/*
+ * If ever we are running from Flash, then we surely want the cache
+ * to be enabled also for our execution instance...  We map 2MB of it
+ * so there is no map overlap problem for up to 1 MB compressed kernel.
+ * If the execution is in RAM then we would only be duplicating the above.
+ */
+		mov	r1, #0x1e
+		orr	r1, r1, #3 << 10
+		mov	r2, pc, lsr #20
+		orr	r1, r1, r2, lsl #20
+		add	r0, r3, r2, lsl #2
+		str	r1, [r0], #4
+		add	r1, r1, #1048576
+		str	r1, [r0]
+		mov	pc, lr
+
+__armv4_cache_on:
+		mov	r12, lr
+		bl	__setup_mmu
+		mov	r0, #0
+		mcr	p15, 0, r0, c7, c10, 4	@ drain write buffer
+		mcr	p15, 0, r0, c8, c7, 0	@ flush I,D TLBs
+		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
+		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
+		orr	r0, r0, #0x0030
+		bl	__common_cache_on
+		mov	r0, #0
+		mcr	p15, 0, r0, c8, c7, 0	@ flush I,D TLBs
+		mov	pc, r12
+
+__arm6_cache_on:
+		mov	r12, lr
+		bl	__setup_mmu
+		mov	r0, #0
+		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
+		mcr	p15, 0, r0, c5, c0, 0	@ invalidate whole TLB v3
+		mov	r0, #0x30
+		bl	__common_cache_on
+		mov	r0, #0
+		mcr	p15, 0, r0, c5, c0, 0	@ invalidate whole TLB v3
+		mov	pc, r12
+
+__common_cache_on:
+#ifndef DEBUG
+		orr	r0, r0, #0x000d		@ Write buffer, mmu
+#endif
+		mov	r1, #-1
+		mcr	p15, 0, r3, c2, c0, 0	@ load page table pointer
+		mcr	p15, 0, r1, c3, c0, 0	@ load domain access control
+		mcr	p15, 0, r0, c1, c0, 0	@ load control register
+		mov	pc, lr
+
+/*
+ * All code following this line is relocatable.  It is relocated by
+ * the above code to the end of the decompressed kernel image and
+ * executed there.  During this time, we have no stacks.
+ *
+ * r0     = decompressed kernel length
+ * r1-r3  = unused
+ * r4     = kernel execution address
+ * r5     = decompressed kernel start
+ * r6     = processor ID
+ * r7     = architecture ID
+ * r8-r14 = unused
+ */
+		.align	5
+reloc_start:	add	r8, r5, r0
+		debug_reloc_start
+		mov	r1, r4
+1:
+		.rept	4
+		ldmia	r5!, {r0, r2, r3, r9 - r13}	@ relocate kernel
+		stmia	r1!, {r0, r2, r3, r9 - r13}
+		.endr
+
+		cmp	r5, r8
+		blo	1b
+		debug_reloc_end
+
+call_kernel:	bl	cache_clean_flush
+		bl	cache_off
+		mov	r0, #0
+		mov	r1, r7			@ restore architecture number
+		mov	pc, r4			@ call kernel
+
+/*
+ * Here follow the relocatable cache support functions for the
+ * various processors.  This is a generic hook for locating an
+ * entry and jumping to an instruction at the specified offset
+ * from the start of the block.  Please note this is all position
+ * independent code.
+ *
+ *  r1  = corrupted
+ *  r2  = corrupted
+ *  r3  = block offset
+ *  r6  = corrupted
+ *  r12 = corrupted
+ */
+
+call_cache_fn:	adr	r12, proc_types
+		mrc	p15, 0, r6, c0, c0	@ get processor ID
+1:		ldr	r1, [r12, #0]		@ get value
+		ldr	r2, [r12, #4]		@ get mask
+		eor	r1, r1, r6		@ (real ^ match)
+		tst	r1, r2			@       & mask
+		addeq	pc, r12, r3		@ call cache function
+		add	r12, r12, #4*5
+		b	1b
+
+/*
+ * Table for cache operations.  This is basically:
+ *   - CPU ID match
+ *   - CPU ID mask
+ *   - 'cache on' method instruction
+ *   - 'cache off' method instruction
+ *   - 'cache flush' method instruction
+ *
+ * We match an entry using: ((real_id ^ match) & mask) == 0
+ *
+ * Writethrough caches generally only need 'on' and 'off'
+ * methods.  Writeback caches _must_ have the flush method
+ * defined.
+ */
+		.type	proc_types,#object
+proc_types:
+		.word	0x41560600		@ ARM6/610
+		.word	0xffffffe0
+		b	__arm6_cache_off	@ works, but slow
+		b	__arm6_cache_off
+		mov	pc, lr
+@		b	__arm6_cache_on		@ untested
+@		b	__arm6_cache_off
+@		b	__armv3_cache_flush
+
+		.word	0x00000000		@ old ARM ID
+		.word	0x0000f000
+		mov	pc, lr
+		mov	pc, lr
+		mov	pc, lr
+
+		.word	0x41007000		@ ARM7/710
+		.word	0xfff8fe00
+		b	__arm7_cache_off
+		b	__arm7_cache_off
+		mov	pc, lr
+
+		.word	0x41807200		@ ARM720T (writethrough)
+		.word	0xffffff00
+		b	__armv4_cache_on
+		b	__armv4_cache_off
+		mov	pc, lr
+
+		.word	0x00007000		@ ARM7 IDs
+		.word	0x0000f000
+		mov	pc, lr
+		mov	pc, lr
+		mov	pc, lr
+
+		@ Everything from here on will be the new ID system.
+
+		.word	0x4401a100		@ sa110 / sa1100
+		.word	0xffffffe0
+		b	__armv4_cache_on
+		b	__armv4_cache_off
+		b	__armv4_cache_flush
+
+		.word	0x6901b110		@ sa1110
+		.word	0xfffffff0
+		b	__armv4_cache_on
+		b	__armv4_cache_off
+		b	__armv4_cache_flush
+
+		@ These match on the architecture ID
+
+		.word	0x00020000		@ ARMv4T
+		.word	0x000f0000
+		b	__armv4_cache_on
+		b	__armv4_cache_off
+		b	__armv4_cache_flush
+
+		.word	0x00050000		@ ARMv5TE
+		.word	0x000f0000
+		b	__armv4_cache_on
+		b	__armv4_cache_off
+		b	__armv4_cache_flush
+
+		.word	0x00060000		@ ARMv5TEJ
+		.word	0x000f0000
+		b	__armv4_cache_on
+		b	__armv4_cache_off
+		b	__armv4_cache_flush
+
+		.word	0x00070000		@ ARMv6
+		.word	0x000f0000
+		b	__armv4_cache_on
+		b	__armv4_cache_off
+		b	__armv6_cache_flush
+
+		.word	0			@ unrecognised type
+		.word	0
+		mov	pc, lr
+		mov	pc, lr
+		mov	pc, lr
+
+		.size	proc_types, . - proc_types
+
+/*
+ * Turn off the Cache and MMU.  ARMv3 does not support
+ * reading the control register, but ARMv4 does.
+ *
+ * On entry,  r6 = processor ID
+ * On exit,   r0, r1, r2, r3, r12 corrupted
+ * This routine must preserve: r4, r6, r7
+ */
+		.align	5
+cache_off:	mov	r3, #12			@ cache_off function
+		b	call_cache_fn
+
+__armv4_cache_off:
+		mrc	p15, 0, r0, c1, c0
+		bic	r0, r0, #0x000d
+		mcr	p15, 0, r0, c1, c0	@ turn MMU and cache off
+		mov	r0, #0
+		mcr	p15, 0, r0, c7, c7	@ invalidate whole cache v4
+		mcr	p15, 0, r0, c8, c7	@ invalidate whole TLB v4
+		mov	pc, lr
+
+__arm6_cache_off:
+		mov	r0, #0x00000030		@ ARM6 control reg.
+		b	__armv3_cache_off
+
+__arm7_cache_off:
+		mov	r0, #0x00000070		@ ARM7 control reg.
+		b	__armv3_cache_off
+
+__armv3_cache_off:
+		mcr	p15, 0, r0, c1, c0, 0	@ turn MMU and cache off
+		mov	r0, #0
+		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
+		mcr	p15, 0, r0, c5, c0, 0	@ invalidate whole TLB v3
+		mov	pc, lr
+
+/*
+ * Clean and flush the cache to maintain consistency.
+ *
+ * On entry,
+ *  r6 = processor ID
+ * On exit,
+ *  r1, r2, r3, r11, r12 corrupted
+ * This routine must preserve:
+ *  r0, r4, r5, r6, r7
+ */
+		.align	5
+cache_clean_flush:
+		mov	r3, #16
+		b	call_cache_fn
+
+__armv6_cache_flush:
+		mov	r1, #0
+		mcr	p15, 0, r1, c7, c14, 0	@ clean+invalidate D
+		mcr	p15, 0, r1, c7, c5, 0	@ invalidate I+BTB
+		mcr	p15, 0, r1, c7, c15, 0	@ clean+invalidate unified
+		mcr	p15, 0, r1, c7, c10, 4	@ drain WB
+		mov	pc, lr
+
+__armv4_cache_flush:
+		mov	r2, #64*1024		@ default: 32K dcache size (*2)
+		mov	r11, #32		@ default: 32 byte line size
+		mrc	p15, 0, r3, c0, c0, 1	@ read cache type
+		teq	r3, r6			@ cache ID register present?
+		beq	no_cache_id
+		mov	r1, r3, lsr #18
+		and	r1, r1, #7
+		mov	r2, #1024
+		mov	r2, r2, lsl r1		@ base dcache size *2
+		tst	r3, #1 << 14		@ test M bit
+		addne	r2, r2, r2, lsr #1	@ +1/2 size if M == 1
+		mov	r3, r3, lsr #12
+		and	r3, r3, #3
+		mov	r11, #8
+		mov	r11, r11, lsl r3	@ cache line size in bytes
+no_cache_id:
+		bic	r1, pc, #63		@ align to longest cache line
+		add	r2, r1, r2
+1:		ldr	r3, [r1], r11		@ s/w flush D cache
+		teq	r1, r2
+		bne	1b
+
+		mcr	p15, 0, r1, c7, c5, 0	@ flush I cache
+		mcr	p15, 0, r1, c7, c6, 0	@ flush D cache
+		mcr	p15, 0, r1, c7, c10, 4	@ drain WB
+		mov	pc, lr
+
+__armv3_cache_flush:
+		mov	r1, #0
+		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
+		mov	pc, lr
+
+/*
+ * Various debugging routines for printing hex characters and
+ * memory, which again must be relocatable.
+ */
+#ifdef DEBUG
+		.type	phexbuf,#object
+phexbuf:	.space	12
+		.size	phexbuf, . - phexbuf
+
+phex:		adr	r3, phexbuf
+		mov	r2, #0
+		strb	r2, [r3, r1]
+1:		subs	r1, r1, #1
+		movmi	r0, r3
+		bmi	puts
+		and	r2, r0, #15
+		mov	r0, r0, lsr #4
+		cmp	r2, #10
+		addge	r2, r2, #7
+		add	r2, r2, #'0'
+		strb	r2, [r3, r1]
+		b	1b
+
+puts:		loadsp	r3
+1:		ldrb	r2, [r0], #1
+		teq	r2, #0
+		moveq	pc, lr
+2:		writeb	r2, r3
+		mov	r1, #0x00020000
+3:		subs	r1, r1, #1
+		bne	3b
+		teq	r2, #'\n'
+		moveq	r2, #'\r'
+		beq	2b
+		teq	r0, #0
+		bne	1b
+		mov	pc, lr
+putc:
+		mov	r2, r0
+		mov	r0, #0
+		loadsp	r3
+		b	2b
+
+memdump:	mov	r12, r0
+		mov	r10, lr
+		mov	r11, #0
+2:		mov	r0, r11, lsl #2
+		add	r0, r0, r12
+		mov	r1, #8
+		bl	phex
+		mov	r0, #':'
+		bl	putc
+1:		mov	r0, #' '
+		bl	putc
+		ldr	r0, [r12, r11, lsl #2]
+		mov	r1, #8
+		bl	phex
+		and	r0, r11, #7
+		teq	r0, #3
+		moveq	r0, #' '
+		bleq	putc
+		and	r0, r11, #7
+		add	r11, r11, #1
+		teq	r0, #7
+		bne	1b
+		mov	r0, #'\n'
+		bl	putc
+		cmp	r11, #64
+		blt	2b
+		mov	pc, r10
+#endif
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+                .text
+                .align 0
+                .type mcount %function
+                .global mcount
+mcount:
+		mov pc, lr	@ just return
+#endif
+
+
+reloc_end:
+
+		.align
+		.section ".stack", "w"
+user_stack:	.space	4096
diff -uNrp ipipe/v2.6/2.6.15/arch/arm/kernel/entry-common.S ipipe.work/v2.6/2.6.15/arch/arm/kernel/entry-common.S
--- ipipe/v2.6/2.6.15/arch/arm/kernel/entry-common.S	2006-05-04 14:43:39.000000000 +0200
+++ ipipe.work/v2.6/2.6.15/arch/arm/kernel/entry-common.S	2006-12-04 09:48:15.000000000 +0100
@@ -294,3 +294,28 @@ sys_mmap2:
 		str	r5, [sp, #4]
 		b	do_mmap2
 #endif
+
+#ifdef CONFIG_FRAME_POINTER
+
+	.text
+	.align 0
+	.type arm_return_addr %function
+	.global arm_return_addr
+
+arm_return_addr:
+	mov	ip, r0
+	mov	r0, fp
+3:
+	cmp	r0, #0
+	beq	1f		@ frame list hit end, bail
+	cmp	ip, #0
+	beq	2f		@ reached desired frame
+	ldr	r0, [r0, #-12]  @ else continue, get next fp
+	sub	ip, ip, #1
+	b	3b
+2:
+	ldr	r0, [r0, #-4]   @ get target return address
+1:
+	mov	pc, lr
+
+#endif
diff -uNrp ipipe/v2.6/2.6.15/arch/arm/kernel/Makefile ipipe.work/v2.6/2.6.15/arch/arm/kernel/Makefile
--- ipipe/v2.6/2.6.15/arch/arm/kernel/Makefile	2006-02-20 14:54:22.000000000 +0100
+++ ipipe.work/v2.6/2.6.15/arch/arm/kernel/Makefile	2006-12-01 13:42:49.000000000 +0100
@@ -20,6 +20,7 @@ obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_IPIPE)		+= ipipe-core.o ipipe-root.o
+obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+= ipipe-mcount.o
 
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
diff -uNrp ipipe/v2.6/2.6.15/include/asm-arm/system.h ipipe.work/v2.6/2.6.15/include/asm-arm/system.h
--- ipipe/v2.6/2.6.15/include/asm-arm/system.h	2006-10-21 00:08:28.000000000 +0200
+++ ipipe.work/v2.6/2.6.15/include/asm-arm/system.h	2006-12-04 17:27:24.000000000 +0100
@@ -177,7 +177,7 @@ do {									\
  */
 #if __LINUX_ARM_ARCH__ >= 6
 
-#define local_irq_save_hw(x)					\
+#define local_irq_save_hw_notrace(x)				\
 	({							\
 	__asm__ __volatile__(					\
 	"mrs	%0, cpsr		@ local_irq_save_hw\n"	\
@@ -195,7 +195,7 @@ do {									\
 /*
  * Save the current interrupt enable state & disable IRQs
  */
-#define local_irq_save_hw(x)					\
+#define local_irq_save_hw_notrace(x)				\
 	({							\
 		unsigned long temp;				\
 		(void) (&temp == &x);				\
@@ -211,7 +211,7 @@ do {									\
 /*
  * Enable IRQs
  */
-#define local_irq_enable_hw()					\
+#define local_irq_enable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -226,7 +226,7 @@ do {									\
 /*
  * Disable IRQs
  */
-#define local_irq_disable_hw()					\
+#define local_irq_disable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -241,7 +241,7 @@ do {									\
 /*
  * Enable FIQs
  */
-#define local_fiq_enable_hw()					\
+#define local_fiq_enable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -256,7 +256,7 @@ do {									\
 /*
  * Disable FIQs
  */
-#define local_fiq_disable_hw()					\
+#define local_fiq_disable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -283,7 +283,7 @@ do {									\
 /*
  * restore saved IRQ & FIQ state
  */
-#define local_irq_restore_hw(x)					\
+#define local_irq_restore_hw_notrace(x)				\
 	__asm__ __volatile__(					\
 	"msr	cpsr_c, %0		@ local_irq_restore_hw\n"\
 	:							\
@@ -306,6 +306,8 @@ unsigned long __ipipe_test_root(void);
 unsigned long __ipipe_test_and_stall_root(void);
 void __ipipe_restore_root(unsigned long flags);
 
+#define local_test_iflag_hw(x)   (!((x) & PSR_I_BIT))
+
 /* PSR_I_BIT is bit no. 7 and is set if interrupts are _disabled_ */
 #define local_irq_save(flags)		((flags) = __ipipe_test_and_stall_root() << 7)
 #define local_irq_enable()		__ipipe_unstall_root()
@@ -317,15 +319,62 @@ void __ipipe_restore_root(unsigned long 
 
 #define irqs_disabled()		__ipipe_test_root()
 
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+
+#include <linux/ipipe_trace.h>
+
+#define local_irq_disable_hw() do { \
+	if (!irqs_disabled_hw()) { \
+		local_irq_disable_hw_notrace(); \
+		ipipe_trace_begin(0x80000000); \
+	} \
+} while (0)
+#define local_irq_enable_hw() do { \
+	if (irqs_disabled_hw()) { \
+		ipipe_trace_end(0x80000000); \
+		local_irq_enable_hw_notrace(); \
+	} \
+} while (0)
+#define local_irq_save_hw(x) do { \
+	local_save_flags_hw(x); \
+	if (local_test_iflag_hw(x)) { \
+		local_irq_disable_hw_notrace(); \
+		ipipe_trace_begin(0x80000001); \
+	} \
+} while (0)
+#define local_irq_restore_hw(x) do { \
+	if (local_test_iflag_hw(x)) \
+		ipipe_trace_end(0x80000001); \
+	local_irq_restore_hw_notrace(x); \
+} while (0)
+
+#else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#define local_irq_save_hw(flags)	local_irq_save_hw_notrace(flags)
+#define local_irq_enable_hw()		local_irq_enable_hw_notrace()
+#define local_irq_disable_hw()		local_irq_disable_hw_notrace()
+#define local_fiq_enable_hw()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable_hw()		local_fiq_disable_hw_notrace()
+#define local_irq_restore_hw(flags)	local_irq_restore_hw_notrace(flags)
+
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
 #else /* !CONFIG_IPIPE */
 
-#define local_irq_save(flags)		local_irq_save_hw(flags)
-#define local_irq_enable()		local_irq_enable_hw()
-#define local_irq_disable()		local_irq_disable_hw()
-#define local_fiq_enable()		local_fiq_enable_hw()
-#define local_fiq_disable()		local_fiq_disable_hw()
-#define local_save_flags(flags)	local_save_flags_hw(flags)
-#define local_irq_restore(flags)	local_irq_restore_hw(flags)
+#define local_irq_save(flags)		local_irq_save_hw_notrace(flags)
+#define local_irq_enable()		local_irq_enable_hw_notrace()
+#define local_irq_disable()		local_irq_disable_hw_notrace()
+#define local_fiq_enable()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable()		local_fiq_disable_hw_notrace()
+#define local_save_flags(flags)		local_save_flags_hw(flags)
+#define local_irq_restore(flags)	local_irq_restore_hw_notrace(flags)
+
+#define local_irq_save_hw(flags)	local_irq_save_hw_notrace(flags)
+#define local_irq_enable_hw()		local_irq_enable_hw_notrace()
+#define local_irq_disable_hw()		local_irq_disable_hw_notrace()
+#define local_fiq_enable_hw()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable_hw()		local_fiq_disable_hw_notrace()
+#define local_irq_restore_hw(flags)	local_irq_restore_hw_notrace(flags)
 
 #define irqs_disabled()		irqs_disabled_hw()
 
diff -uNrp ipipe/v2.6/common/arch/arm/kernel/ipipe-mcount.S ipipe.work/v2.6/common/arch/arm/kernel/ipipe-mcount.S
--- ipipe/v2.6/common/arch/arm/kernel/ipipe-mcount.S	1970-01-01 01:00:00.000000000 +0100
+++ ipipe.work/v2.6/common/arch/arm/kernel/ipipe-mcount.S	2006-12-04 09:46:30.000000000 +0100
@@ -0,0 +1,40 @@
+/*
+ *  linux/arch/arm/kernel/ipipe-mcount.S
+ *
+ *  Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_FRAME_POINTER
+
+	.text
+	.align 0
+	.type mcount %function
+	.global mcount
+
+mcount:
+
+	ldr	ip, =ipipe_trace_enable	@ leave early, if disabled
+	ldr	ip, [ip]
+	cmp	ip, #0
+	moveq	pc,lr
+
+	mov	ip,  sp
+	stmdb   sp!, {r0 - r3, fp, ip, lr, pc}	@ create stack frame
+
+	mov	r3, #0			@ no additional value (v)
+	ldr	r2, [fp, #-4]		@ get lr (the return address
+					@ of the caller of the
+					@ instrumented function)
+	mov	r1, lr			@ get lr - (the return address
+					@ of the instrumented function)
+	mov	r0, #0			@ IPIPE_TRACE_FN
+
+	sub	fp, ip, #4		@ point fp at this frame
+
+	bl	__ipipe_trace
+
+	ldmdb   fp, {r0 - r3, fp, sp, pc}	@ pop entry frame and return
+
+#endif
diff -uNrp ipipe/v2.6/common/arch/arm/kernel/ipipe-root.c ipipe.work/v2.6/common/arch/arm/kernel/ipipe-root.c
--- ipipe/v2.6/common/arch/arm/kernel/ipipe-root.c	2006-10-09 22:41:23.000000000 +0200
+++ ipipe.work/v2.6/common/arch/arm/kernel/ipipe-root.c	2006-12-01 17:22:43.000000000 +0100
@@ -376,3 +376,8 @@ EXPORT_SYMBOL_GPL(show_stack);
 #ifndef MULTI_CPU
 EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
 #endif
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+void notrace mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
diff -uNrp ipipe/v2.6/common/include/asm-arm/ipipe.h ipipe.work/v2.6/common/include/asm-arm/ipipe.h
--- ipipe/v2.6/common/include/asm-arm/ipipe.h	2006-11-12 20:33:33.000000000 +0100
+++ ipipe.work/v2.6/common/include/asm-arm/ipipe.h	2006-12-04 09:41:06.000000000 +0100
@@ -95,6 +95,8 @@ do {								\
 #define IPIPE_LAST_EVENT	IPIPE_EVENT_CLEANUP
 #define IPIPE_NR_EVENTS		(IPIPE_LAST_EVENT + 1)
 
+#define BROKEN_BUILTIN_RETURN_ADDRESS
+
 struct ipipe_domain;
 
 struct ipipe_sysinfo {
@@ -124,7 +126,18 @@ extern void __ipipe_mach_demux_irq(unsig
 #define __ipipe_read_timebase()		__ipipe_mach_get_tsc()
 
 #define ipipe_cpu_freq()	(HZ * __ipipe_mach_ticks_per_jiffy)
-#define ipipe_tsc2ns(t)		(((t) * 1000) / (ipipe_cpu_freq() / 1000000))
+#define ipipe_tsc2ns(t) \
+({ \
+	unsigned long long delta = (t)*1000; \
+	do_div(delta, ipipe_cpu_freq() / 1000000 + 1); \
+	(unsigned long)delta; \
+})
+#define ipipe_tsc2us(t) \
+({ \
+	unsigned long long delta = (t); \
+	do_div(delta, ipipe_cpu_freq() / 1000000 + 1); \
+	(unsigned long)delta; \
+})
 
 /* Private interface -- Internal use only */
 
diff -uNrp ipipe/v2.6/common/include/linux/ipipe.h ipipe.work/v2.6/common/include/linux/ipipe.h
--- ipipe/v2.6/common/include/linux/ipipe.h	2006-10-15 16:28:49.000000000 +0200
+++ ipipe.work/v2.6/common/include/linux/ipipe.h	2006-12-01 17:41:55.000000000 +0100
@@ -38,7 +38,13 @@
 #ifndef BROKEN_BUILTIN_RETURN_ADDRESS
 #define __BUILTIN_RETURN_ADDRESS0 ((unsigned long)__builtin_return_address(0))
 #define __BUILTIN_RETURN_ADDRESS1 ((unsigned long)__builtin_return_address(1))
-#endif /* !BUILTIN_RETURN_ADDRESS */
+#else	/* BROKEN_BUILTIN_RETURN_ADDRESS */
+#ifdef CONFIG_ARM
+extern unsigned long arm_return_addr(int level);
+#define __BUILTIN_RETURN_ADDRESS0 arm_return_addr(0)
+#define __BUILTIN_RETURN_ADDRESS1 arm_return_addr(1)
+#endif /* CONFIG_ARM */
+#endif /* !BROKEN_BUILTIN_RETURN_ADDRESS */
 
 #define IPIPE_ROOT_PRIO		100
 #define IPIPE_ROOT_ID		0

--Boundary-00=_smFdF1DMCk1ne6j
Content-Type: text/plain;
  charset="us-ascii";
  name="ipipe-traces"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-traces"

I-pipe worst-case tracing service on 2.6.15/ipipe-1.5-03
------------------------------------------------------------
Begin: 21055672 cycles, Trace Points: 3 (-10/+10), Length: 4651 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- <unused>
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
     +func                 -15    1.333N __ipipe_stall_root+0x10 (run_timer_softirq+0x38)
 |   +begin   0x80000001   -13    1.333N __ipipe_stall_root+0x34 (run_timer_softirq+0x38)
 |   #end     0x80000001   -12    1.444N __ipipe_stall_root+0x4c (run_timer_softirq+0x38)
     #func                 -10    1.444N __ipipe_unstall_root+0x10 (run_timer_softirq+0x19c)
 |   #begin   0x80000000    -9    1.555  __ipipe_unstall_root+0x30 (run_timer_softirq+0x19c)
 |   +end     0x80000000    -7    1.333N __ipipe_unstall_root+0x68 (run_timer_softirq+0x19c)
     +func                  -6    1.444N __ipipe_stall_root+0x10 (__do_softirq+0x74)
 |   +begin   0x80000001    -5    1.555  __ipipe_stall_root+0x34 (__do_softirq+0x74)
 |   #end     0x80000001    -3    2.111N __ipipe_stall_root+0x4c (__do_softirq+0x74)
     +func                  -1    1.444N default_idle+0x10 (cpu_idle+0x48)
>|   +begin   0x80000000     0+   1.555  default_idle+0x44 (cpu_idle+0x48)
:|   +func                   1! 4650.111N s3c24xx_default_idle+0x10 (default_idle+0x78)
<|   +end     0x80000000  4651    1.666N default_idle+0x8c (cpu_idle+0x48)
 |   +func                4653    1.333N __ipipe_grab_irq+0x10 (__irq_svc+0x24)
 |   +func                4654    1.555N __ipipe_handle_irq+0x10 (__ipipe_grab_irq+0xc8)
 |   +func                4656    1.333N __ipipe_ack_timerirq+0x10 (__ipipe_handle_irq+0x150)
 |   +func                4657    1.333N ipipe_test_and_stall_pipeline_from+0x10 (__ipipe_ack_timerirq+0x20)
 |   #func                4658    1.444N __ipipe_mach_acktimer+0x10 (__ipipe_ack_timerirq+0x28)
 |   #func                4660    1.444N s3c_irq_ack+0x10 (__ipipe_ack_timerirq+0x44)
 |   #func                4661    1.555N s3c_irq_unmask+0x10 (__ipipe_ack_timerirq+0x50)
 |   +func                4663    1.444N __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1a8)
 |   +func                4664    1.666N __ipipe_sync_stage+0x10 (__ipipe_walk_pipeline+0x9c)
 |   #func                4666    0.000N asm_do_IRQ+0x14 (__ipipe_sync_stage+0x1f8)


I-pipe frozen back-tracing service on 2.6.15/ipipe-1.5-03
------------------------------------------------------------
Freeze: 18284279888 cycles, Trace Points: 30 (+10)

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- <unused>
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:    #func                 -90+   1.333N vma_prio_tree_next+0x10 (update_mmu_cache+0x144)
:    #func                 -89+   2.333  prio_tree_next+0x14 (vma_prio_tree_next+0x64)
:    #func                 -86+   1.555N prio_tree_left+0x10 (prio_tree_next+0x128)
:    #func                 -85+   1.555N prio_tree_right+0x10 (prio_tree_next+0x180)
:    #func                 -83+   1.333N prio_tree_parent+0x10 (prio_tree_next+0x170)
:    #func                 -82+   1.777N prio_tree_right+0x10 (prio_tree_next+0x180)
:    #func                 -80+   1.666N __ipipe_unstall_root+0x10 (update_mmu_cache+0x150)
:|   #begin   0x80000000   -78+   1.555N __ipipe_unstall_root+0x30 (update_mmu_cache+0x150)
:|   +end     0x80000000   -77+   9.666N __ipipe_unstall_root+0x68 (update_mmu_cache+0x150)
:    +func                 -67+   1.444N __up_read+0x10 (do_page_fault+0x1d4)
:    +func                 -66+   1.777N __ipipe_test_and_stall_root+0x10 (__up_read+0x18)
:|   +begin   0x80000001   -64+   1.777  __ipipe_test_and_stall_root+0x34 (__up_read+0x18)
:|   #end     0x80000001   -62+   1.555N __ipipe_test_and_stall_root+0x4c (__up_read+0x18)
:    #func                 -61+   1.555N __ipipe_restore_root+0x10 (__up_read+0xd4)
:    #func                 -59+   1.555N __ipipe_unstall_root+0x10 (__ipipe_restore_root+0x24)
:|   #begin   0x80000000   -57+   2.222  __ipipe_unstall_root+0x30 (__ipipe_restore_root+0x24)
:|   +end     0x80000000   -55!  12.555N __ipipe_unstall_root+0x68 (__ipipe_restore_root+0x24)
:    +func                 -43+   3.333N __ipipe_syscall_root+0x10 (vector_swi+0x64)
:    +func                 -39+   1.777N sys_write+0x14 (ret_fast_syscall+0x0)
:    +func                 -38+   4.222N fget_light+0x10 (sys_write+0x24)
:    +func                 -33+   3.444N vfs_write+0x10 (sys_write+0x50)
:    +func                 -30+   5.000N rw_verify_area+0x14 (vfs_write+0x94)
:    +func                 -25+   4.333N __ipipe_frozen_ctrl+0x14 (vfs_write+0xc4)
:    +func                 -21+   2.111N simple_strtol+0x10 (__ipipe_frozen_ctrl+0x9c)
:    +func                 -18+   6.000N simple_strtoul+0x10 (simple_strtol+0x30)
:    +func                 -12+   1.777N ipipe_trace_frozen_reset+0x10 (__ipipe_frozen_ctrl+0xfc)
:    +func                 -11+   2.777  __ipipe_global_path_lock+0x10 (ipipe_trace_frozen_reset+0x14)
:|   +begin   0x80000001    -8+   6.000N __ipipe_global_path_lock+0x30 (ipipe_trace_frozen_reset+0x14)
:|   +end     0x80000001    -2+   2.333N __ipipe_global_path_unlock+0x68 (ipipe_trace_frozen_reset+0x68)
<    +freeze  0xffffffff     0   97.444N __ipipe_frozen_ctrl+0x108 (vfs_write+0xc4)
     +func                  97    3.222N do_PrefetchAbort+0x10 (ret_from_exception+0x0)
     +func                 100    2.333N do_translation_fault+0x14 (do_PrefetchAbort+0x1c)
     +func                 103    2.777N do_page_fault+0x14 (do_translation_fault+0x2c)
     +func                 105    2.222N __down_read_trylock+0x10 (do_page_fault+0xbc)
     +func                 108    1.888N __ipipe_test_and_stall_root+0x10 (__down_read_trylock+0x18)
 |   +begin   0x80000001   109    1.888N __ipipe_test_and_stall_root+0x34 (__down_read_trylock+0x18)
 |   #end     0x80000001   111    2.111N __ipipe_test_and_stall_root+0x4c (__down_read_trylock+0x18)
     #func                 113    1.777N __ipipe_restore_root+0x10 (__down_read_trylock+0x4c)
     #func                 115    1.555N __ipipe_unstall_root+0x10 (__ipipe_restore_root+0x24)
 |   #begin   0x80000000   117    0.000N __ipipe_unstall_root+0x30 (__ipipe_restore_root+0x24)

--Boundary-00=_smFdF1DMCk1ne6j--

