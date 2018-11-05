From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/kernel: Simplify mayday processing
Message-ID: <3e868e4f-7bd5-2874-d72b-fc2449ef4b65@siemens.com>
Date: Mon, 5 Nov 2018 13:20:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>, Dmitriy Cherkasov <dmitriy@oss-tech.org>

The mayday mechanism exists in order to kick a xenomai userspace task
into secondary mode while it is running userspace code. For that, we ask
I-pipe to call us back when the task was interrupted and is about to
return to userspace.

So far we defer the relaxation from that callback via a VDSO-like
mechanism that triggers a special syscall to the return path of that
very same syscall. However, that is not desirable because it is a
complex, arch-specific mechanism that can easily break and,
specifically, that destroys the backtrace of ptraced tasks.

Fortunately, we can fulfill the needs of mayday also by relaxing
the task directly from the mayday callback. Tested successfully on
x86-64 and ARM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Pending in my queue for 3 years now, back then blocked by blackfin
breaking over it. Now that it's gone, time to move on. This is the start
of upstreaming our debugger improvements for Xenomai that should ideally
make it into 3.1.

I would appreciate if you could test ARM64 and PowerPC for me. Until we
have QEMU test images for both, it's still tricky for me to do that.

 include/cobalt/kernel/ppd.h                        |   1 -
 include/cobalt/uapi/syscall.h                      |   2 +-
 kernel/cobalt/arch/arm/Makefile                    |   2 +-
 .../cobalt/arch/arm/include/asm/xenomai/thread.h   |  10 -
 kernel/cobalt/arch/arm/mayday.c                    | 146 --------------
 kernel/cobalt/arch/arm64/Makefile                  |   2 +-
 .../cobalt/arch/arm64/include/asm/xenomai/thread.h |  10 -
 kernel/cobalt/arch/arm64/mayday.c                  |  62 ------
 kernel/cobalt/arch/powerpc/Makefile                |   2 +-
 .../arch/powerpc/include/asm/xenomai/thread.h      |   4 -
 kernel/cobalt/arch/powerpc/mayday.c                |  91 ---------
 kernel/cobalt/arch/x86/Makefile                    |   2 +-
 .../cobalt/arch/x86/include/asm/xenomai/thread.h   |   4 -
 kernel/cobalt/arch/x86/mayday.c                    | 212 ---------------------
 kernel/cobalt/include/asm-generic/xenomai/mayday.h |  39 ----
 kernel/cobalt/posix/process.c                      |  47 +----
 kernel/cobalt/posix/syscall.c                      |  29 ---
 kernel/cobalt/thread.c                             |   1 -
 kernel/cobalt/trace/cobalt-posix.h                 |   1 -
 19 files changed, 7 insertions(+), 660 deletions(-)
 delete mode 100644 kernel/cobalt/arch/arm/mayday.c
 delete mode 100644 kernel/cobalt/arch/arm64/mayday.c
 delete mode 100644 kernel/cobalt/arch/powerpc/mayday.c
 delete mode 100644 kernel/cobalt/arch/x86/mayday.c
 delete mode 100644 kernel/cobalt/include/asm-generic/xenomai/mayday.h

diff --git a/include/cobalt/kernel/ppd.h b/include/cobalt/kernel/ppd.h
index 5eabd1d4e5..f0079fe6ed 100644
--- a/include/cobalt/kernel/ppd.h
+++ b/include/cobalt/kernel/ppd.h
@@ -32,7 +32,6 @@ struct cobalt_umm {
 
 struct cobalt_ppd {
 	struct cobalt_umm umm;
-	unsigned long mayday_tramp;
 	atomic_t refcnt;
 	char *exe_path;
 	struct rb_root fds;
diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 58f9c07f57..1cb22a5936 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -113,7 +113,7 @@
 #define sc_cobalt_trace				90
 #define sc_cobalt_corectl			91
 #define sc_cobalt_get_current			92
-#define sc_cobalt_mayday			93
+/* 93: formerly mayday */
 #define sc_cobalt_backtrace			94
 #define sc_cobalt_serialdbg			95
 #define sc_cobalt_extend			96
diff --git a/kernel/cobalt/arch/arm/Makefile b/kernel/cobalt/arch/arm/Makefile
index f2e4e207c5..f18243599a 100644
--- a/kernel/cobalt/arch/arm/Makefile
+++ b/kernel/cobalt/arch/arm/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_XENOMAI) += xenomai.o
 
-xenomai-y := machine.o mayday.o thread.o switch.o syscall.o
+xenomai-y := machine.o thread.o switch.o syscall.o
 
 ccflags-y := -Iarch/arm/xenomai/include -Iinclude/xenomai
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
index 3ab97327ef..c51b51a931 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
@@ -37,16 +37,6 @@ struct xnarchtcb {
 #define xnarch_fpu_ptr(tcb)     NULL
 #endif
 #endif
-	struct {
-		unsigned long pc;
-		unsigned long r0;
-#ifdef __ARM_EABI__
-		unsigned long r7;
-#endif
-#ifdef CONFIG_ARM_THUMB
-		unsigned long psr;
-#endif
-	} mayday;
 };
 
 #define xnarch_fault_regs(d)	((d)->regs)
diff --git a/kernel/cobalt/arch/arm/mayday.c b/kernel/cobalt/arch/arm/mayday.c
deleted file mode 100644
index 20e45591d9..0000000000
--- a/kernel/cobalt/arch/arm/mayday.c
+++ /dev/null
@@ -1,146 +0,0 @@
-/*
- * Copyright (C) 2010 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#include <linux/types.h>
-#include <linux/ipipe.h>
-#include <linux/vmalloc.h>
-#include <cobalt/kernel/thread.h>
-#include <cobalt/uapi/syscall.h>
-#include <asm/cacheflush.h>
-#include <asm/ptrace.h>
-
-static void *mayday;
-
-static inline void setup_mayday(void *page)
-{
-	/*
-	 * We want this code to appear at the top of the MAYDAY page:
-	 *
-	 * ifdef ARM_EABI
-	 *
-	 * e59f000c     ldr     r0, [pc, #12]
-	 * e59f700c     ldr     r7, [pc, #12]
-	 * ef000000 	svc	0x00000000
-	 * e3a00000 	mov	r0, #0
-	 * e5800000 	str	r0, [r0]	; <bug>
-	 * 1000005e     .word   0x1000005e	; sc_cobalt_mayday | __COBALT_SYSCALL_BIT
-	 * 000f0042     .word   0x000f0042
-	 *
-	 * elif ARM_OABI
-	 *
-	 * e59f0008     ldr     r0, [pc, #8]
-	 * ef9f0042 	swi	0x009f0042
-	 * e3a00000 	mov	r0, #0
-	 * e5800000 	str	r0, [r0]	; <bug>
-	 * 1000005e     .word   0x1000005e	; sc_cobalt_mayday | __COBALT_SYSCALL_BIT
-	 *
-	 * endif
-	 *
-	 * 32bit instruction words will be laid out by the compiler as
-	 * the target endianness requires.
-	 *
-	 * We don't mess with CPSR here, so no need to save/restore it
-	 * in handle/fixup code.
-	 */
-#ifdef __ARM_EABI__
-	static const struct {
-		u32 ldr_r0;
-		u32 ldr_r7;
-		u32 swi_0;
-		u32 mov_r0;
-		u32 str_r0;
-		u32 cst_r0;
-		u32 cst_r7;
-	} code = {
-		.ldr_r0 = 0xe59f000c,
-		.ldr_r7 = 0xe59f700c,
-		.swi_0 = 0xef000000,
-		.mov_r0 = 0xe3a00000,
-		.str_r0 = 0xe5800000,
-		.cst_r0 =  __xn_syscode(sc_cobalt_mayday),
-		.cst_r7 = 0x000f0042,
-	};
-#else /* OABI */
-	static const struct {
-		u32 ldr_r0;
-		u32 swi_syscall;
-		u32 mov_r0;
-		u32 str_r0;
-		u32 cst_r0;
-	} code = {
-		.ldr_r0 = 0xe59f0008,
-		.swi_syscall = 0xef9f0042,
-		.mov_r0 = 0xe3a00000,
-		.str_r0 = 0xe5800000,
-		.cst_r0 =  __xn_syscode(sc_cobalt_mayday),
-	};
-#endif /* OABI */
-
-	memcpy(page, &code, sizeof(code));
-
-	flush_dcache_page(vmalloc_to_page(page));
-}
-
-int xnarch_init_mayday(void)
-{
-	mayday = vmalloc(PAGE_SIZE);
-	if (mayday == NULL)
-		return -ENOMEM;
-
-	setup_mayday(mayday);
-
-	return 0;
-}
-
-void xnarch_cleanup_mayday(void)
-{
-	vfree(mayday);
-}
-
-void *xnarch_get_mayday_page(void)
-{
-	return mayday;
-}
-
-void xnarch_handle_mayday(struct xnarchtcb *tcb, struct pt_regs *regs,
-			  unsigned long tramp)
-{
-	tcb->mayday.pc = regs->ARM_pc;
-	tcb->mayday.r0 = regs->ARM_r0;
-#ifdef __ARM_EABI__
-	tcb->mayday.r7 = regs->ARM_r7;
-#endif
-#ifdef CONFIG_ARM_THUMB
-	/* The code on the mayday page must be run in ARM mode */
-	tcb->mayday.psr = regs->ARM_cpsr;
-	regs->ARM_cpsr &= ~PSR_T_BIT;
-#endif
-	regs->ARM_pc = tramp;
-}
-
-void xnarch_fixup_mayday(struct xnarchtcb *tcb, struct pt_regs *regs)
-{
-	regs->ARM_pc = tcb->mayday.pc;
-	regs->ARM_r0 = tcb->mayday.r0;
-#ifdef __ARM_EABI__
-	regs->ARM_r7 = tcb->mayday.r7;
-#endif
-#ifdef CONFIG_ARM_THUMB
-	regs->ARM_cpsr = tcb->mayday.psr;
-#endif
-}
diff --git a/kernel/cobalt/arch/arm64/Makefile b/kernel/cobalt/arch/arm64/Makefile
index af0a0e8ce7..368b17d531 100644
--- a/kernel/cobalt/arch/arm64/Makefile
+++ b/kernel/cobalt/arch/arm64/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_XENOMAI) += xenomai.o
 
-xenomai-y := machine.o mayday.o thread.o syscall.o
+xenomai-y := machine.o thread.o syscall.o
 
 ccflags-y := -Iarch/arm64/xenomai/include -Iinclude/xenomai
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h
index eab6851135..c81c013213 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h
@@ -33,16 +33,6 @@ struct xnarchtcb {
 	struct fpsimd_state *fpup;
 #define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
 #endif
-	struct {
-		unsigned long pc;
-		unsigned long r0;
-#ifdef __ARM_EABI__
-		unsigned long r7;
-#endif
-#ifdef CONFIG_ARM_THUMB
-		unsigned long psr;
-#endif
-	} mayday;
 };
 
 #define xnarch_fault_regs(d)	((d)->regs)
diff --git a/kernel/cobalt/arch/arm64/mayday.c b/kernel/cobalt/arch/arm64/mayday.c
deleted file mode 100644
index ca1151c65c..0000000000
--- a/kernel/cobalt/arch/arm64/mayday.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (C) 2010 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#include <linux/types.h>
-#include <linux/ipipe.h>
-#include <linux/vmalloc.h>
-#include <cobalt/kernel/thread.h>
-#include <cobalt/uapi/syscall.h>
-#include <asm/cacheflush.h>
-#include <asm/ptrace.h>
-
-static void *mayday;
-
-static inline void setup_mayday(void *page)
-{
-}
-
-int xnarch_init_mayday(void)
-{
-	mayday = vmalloc(PAGE_SIZE);
-	if (mayday == NULL)
-		return -ENOMEM;
-
-	setup_mayday(mayday);
-
-	return 0;
-}
-
-void xnarch_cleanup_mayday(void)
-{
-	vfree(mayday);
-}
-
-void *xnarch_get_mayday_page(void)
-{
-	return mayday;
-}
-
-void xnarch_handle_mayday(struct xnarchtcb *tcb, struct pt_regs *regs,
-			  unsigned long tramp)
-{
-	xnthread_relax(0, 0);
-}
-
-void xnarch_fixup_mayday(struct xnarchtcb *tcb, struct pt_regs *regs)
-{
-}
diff --git a/kernel/cobalt/arch/powerpc/Makefile b/kernel/cobalt/arch/powerpc/Makefile
index 4e728d52d8..18147eeacd 100644
--- a/kernel/cobalt/arch/powerpc/Makefile
+++ b/kernel/cobalt/arch/powerpc/Makefile
@@ -1,7 +1,7 @@
 
 obj-$(CONFIG_XENOMAI) += xenomai.o
 
-xenomai-y := machine.o mayday.o thread.o
+xenomai-y := machine.o thread.o
 
 xenomai-$(CONFIG_XENO_ARCH_FPU) += fpu.o
 
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
index 0ab48bef7f..97129f7392 100644
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
@@ -29,10 +29,6 @@ struct xnarchtcb {
 #else
 #define xnarch_fpu_ptr(tcb)     NULL
 #endif
-	struct {
-		unsigned long nip;
-		unsigned long r0;
-	} mayday;
 };
 
 #define xnarch_fault_regs(d)	((d)->regs)
diff --git a/kernel/cobalt/arch/powerpc/mayday.c b/kernel/cobalt/arch/powerpc/mayday.c
deleted file mode 100644
index 254f9abd29..0000000000
--- a/kernel/cobalt/arch/powerpc/mayday.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Copyright (C) 2010 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/types.h>
-#include <linux/ipipe.h>
-#include <linux/vmalloc.h>
-#include <cobalt/kernel/thread.h>
-#include <cobalt/uapi/syscall.h>
-#include <asm/cacheflush.h>
-#include <asm/ptrace.h>
-
-static void *mayday;
-
-static inline void setup_mayday(void *page)
-{
-	/*
-	 * We want this code to appear at the top of the MAYDAY page:
-	 *
-	 * 3c 00 0b 00	lis     r0,mux_code@h
-	 * 60 00 02 2b	ori     r0,r0,mux_code@l
-	 * 44 00 00 02	sc
-	 * 00 b0 0b 00  .long	0x00b00b00 <illegal insn>
-	 *
-	 * We don't mess with CCR here, so no need to save/restore it
-	 * in handle/fixup code.
-	 */
-	u32 mux, insn[4];
-
-	mux = __xn_syscode(sc_cobalt_mayday);
-	insn[0] = 0x3c000000 | (mux >> 16);
-	insn[1] = 0x60000000 | (mux & 0xffff);
-	insn[2] = 0x44000002;
-	insn[3] = 0x00b00b00;
-	memcpy(page, insn, sizeof(insn));
-
-	flush_dcache_range((unsigned long)page,
-			   (unsigned long)page + sizeof(insn));
-}
-
-int xnarch_init_mayday(void)
-{
-	mayday = vmalloc(PAGE_SIZE);
-	if (mayday == NULL)
-		return -ENOMEM;
-
-	setup_mayday(mayday);
-
-	return 0;
-}
-
-void xnarch_cleanup_mayday(void)
-{
-	vfree(mayday);
-}
-
-void *xnarch_get_mayday_page(void)
-{
-	return mayday;
-}
-
-void xnarch_handle_mayday(struct xnarchtcb *tcb,
-			  struct pt_regs *regs,
-			  unsigned long tramp)
-{
-	tcb->mayday.nip = regs->nip;
-	tcb->mayday.r0 = regs->gpr[0];
-	regs->nip = tramp;
-}
-
-void xnarch_fixup_mayday(struct xnarchtcb *tcb,
-			 struct pt_regs *regs)
-{
-	regs->nip = tcb->mayday.nip;
-	regs->gpr[0] = tcb->mayday.r0;
-}
diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
index e65d25a31c..d430a6741e 100644
--- a/kernel/cobalt/arch/x86/Makefile
+++ b/kernel/cobalt/arch/x86/Makefile
@@ -1,5 +1,5 @@
 
 obj-$(CONFIG_XENOMAI) += xenomai.o
-xenomai-y := machine.o mayday.o thread.o smi.o c1e.o
+xenomai-y := machine.o thread.o smi.o c1e.o
 
 ccflags-y := -Iarch/x86/xenomai/include -Iinclude/xenomai
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 0c5c4da9c3..10cd6ecd5c 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -50,10 +50,6 @@ struct xnarchtcb {
 	x86_fpustate *kfpu_state;
 #endif
 	unsigned int root_kfpu: 1;
-	struct {
-		unsigned long ip;
-		unsigned long ax;
-	} mayday;
 };
 
 #define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
diff --git a/kernel/cobalt/arch/x86/mayday.c b/kernel/cobalt/arch/x86/mayday.c
deleted file mode 100644
index 15f07bd619..0000000000
--- a/kernel/cobalt/arch/x86/mayday.c
+++ /dev/null
@@ -1,212 +0,0 @@
-/*
- * Copyright (C) 2010 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/types.h>
-#include <linux/ipipe.h>
-#include <linux/vmalloc.h>
-#include <cobalt/kernel/thread.h>
-#include <cobalt/uapi/syscall.h>
-#include <asm/ptrace.h>
-
-static void *mayday;
-#ifdef CONFIG_XENO_ARCH_SYS3264
-static void *mayday_compat;
-#endif
-
-static inline void setup_mayday32(void *page)
-{
-	/*
-	 * We want this code to appear at the top of the MAYDAY page:
-	 *
-	 *	b8 2b 02 00 0c		mov    $<mux_code>,%eax
-	 *      cd 80			int    $0x80
-	 *	0f 0b			ud2a
-	 *
-	 * We intentionally don't mess with EFLAGS here, so that we
-	 * don't have to save/restore it in handle/fixup code.
-	 */
-	static const struct __attribute__ ((__packed__)) {
-		struct __attribute__ ((__packed__)) {
-			u8 op;
-			u32 imm;
-		} mov_eax;
-		u16 syscall;
-		u16 bug;
-	} code = {
-		.mov_eax = {
-			.op = 0xb8,
-			.imm = __xn_syscode(sc_cobalt_mayday)
-		},
-		.syscall = 0x80cd,
-		.bug = 0x0b0f,
-	};
-
-	memcpy(page, &code, sizeof(code));
-
-	/* no cache flush required. */
-}
-
-static inline void setup_mayday64(void *page)
-{
-	/*
-	 * We want this code to appear at the top of the MAYDAY page:
-	 *
-	 *      50                      push   %rax
-	 *      41 53                   push   %r11
-	 *      51                      push   %rcx
-	 *	b8 2b 02 00 0c		mov    $<mux_code>,%eax
-	 *	0f 05			syscall
-	 *      59                      pop     %rcx
-	 *      41 5b                   pop     %r11
-	 *      48 87 04 24             xchg    %rax,(%rsp)
-	 *      c3                      retq
-	 *
-	 * The flow for a MAYDAY diversion on x86_64 is as follows:
-	 *
-	 * [runaway code]
-	 *      <watchdog/timer IRQ entry>
-	 *             [%orig_rip = %rip, %rip = &mayday_page] ; handle_mayday
-	 *      <watchdog/timer IRQ exit>
-	 *
-	 * [mayday_page trampoline]
-	 *      <MAYDAY syscall>             ; relax + fixup_mayday
-	 *             [%rax = %orig_rip]
-         *      ret-to-runaway-code
-	 *
-	 * [runaway code]
-	 *      ...
-	 *
-	 * We must take care of preserving %rcx and %r11 which are
-	 * clobbered by the kernel when handling a syscall in long
-	 * mode. This is required because the runaway thread code did
-	 * not actually plan for running the MAYDAY syscall - we
-	 * forced it to do so, by diverting the return path of the
-	 * watchdog/timer IRQ which preempted it.
-	 *
-	 * On x86_64, we want the MAYDAY syscall to return to us, so
-	 * that we can restore the clobbered registers, prior to
-	 * branching back to the user code. fixup_mayday ensures that
-	 * the original %rip is returned from the MAYDAY syscall in
-	 * %rax, therefore we have to save the latter across the
-	 * syscall as well.
-	 *
-	 * In addition, we intentionally don't mess with EFLAGS here,
-	 * so that we don't have to save/restore it in handle/fixup
-	 * code.
-	 */
-	static const struct __attribute__ ((__packed__)) {
-		u8 push_rax;
-		u16 push_r11;
-		u8 push_rcx;
-		struct __attribute__ ((__packed__)) {
-			u8 op;
-			u32 imm;
-		} mov_eax;
-		u16 syscall;
-		u8 pop_rcx;
-		u16 pop_r11;
-		struct __attribute__ ((__packed__)) {
-			u16 op;
-			u16 spec;
-		} xchg_rax_tos;
-		u8 retq;
-	} code = {
-		.push_rax = 0x50,
-		.push_r11 = 0x5341,
-		.push_rcx = 0x51,
-		.mov_eax = {
-			.op = 0xb8,
-			.imm = __xn_syscode(sc_cobalt_mayday)
-		},
-		.syscall = 0x050f,
-		.pop_rcx = 0x59,
-		.pop_r11 = 0x5b41,
-		.xchg_rax_tos = {
-			.op = 0x8748,
-			.spec = 0x2404
-		},
-		.retq = 0xc3,
-	};
-
-	memcpy(page, &code, sizeof(code));
-
-	/* no cache flush required. */
-}
-
-int xnarch_init_mayday(void)
-{
-	mayday = vmalloc(PAGE_SIZE);
-	if (mayday == NULL)
-		return -ENOMEM;
-
-#ifdef CONFIG_X86_32
-	setup_mayday32(mayday);
-#else
-	setup_mayday64(mayday);
-#ifdef CONFIG_XENO_ARCH_SYS3264
-	mayday_compat = vmalloc(PAGE_SIZE);
-	if (mayday_compat == NULL) {
-		vfree(mayday);
-		return -ENOMEM;
-	}
-	setup_mayday32(mayday_compat);
-#endif
-#endif
-	return 0;
-}
-
-void xnarch_cleanup_mayday(void)
-{
-	vfree(mayday);
-#ifdef CONFIG_XENO_ARCH_SYS3264
-	vfree(mayday_compat);
-#endif
-}
-
-void *xnarch_get_mayday_page(void)
-{
-#if defined(CONFIG_X86_32) || !defined(CONFIG_XENO_ARCH_SYS3264)
-	return mayday;
-#else
-	return test_thread_flag(TIF_IA32) ? mayday_compat : mayday;
-#endif
-}
-
-void xnarch_handle_mayday(struct xnarchtcb *tcb, struct pt_regs *regs,
-			  unsigned long tramp)
-{
-	tcb->mayday.ip = regs->ip;
-	tcb->mayday.ax = regs->ax;
-	regs->ip = tramp;
-}
-
-void xnarch_fixup_mayday(struct xnarchtcb *tcb, struct pt_regs *regs)
-{
-#ifdef CONFIG_X86_64
-	if (IS_ENABLED(CONFIG_XENO_ARCH_SYS3264) &&
-		test_thread_flag(TIF_IA32)) {
-		regs->ip = tcb->mayday.ip;
-		regs->ax = tcb->mayday.ax;
-	} else
-		regs->ax = tcb->mayday.ip;
-#else
-	regs->ip = tcb->mayday.ip;
-	regs->ax = tcb->mayday.ax;
-#endif
-}
diff --git a/kernel/cobalt/include/asm-generic/xenomai/mayday.h b/kernel/cobalt/include/asm-generic/xenomai/mayday.h
deleted file mode 100644
index 67f6983d6a..0000000000
--- a/kernel/cobalt/include/asm-generic/xenomai/mayday.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright (C) 2009, 2012 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ASM_GENERIC_MAYDAY_H
-#define _COBALT_ASM_GENERIC_MAYDAY_H
-
-struct xnarchtcb;
-struct task_struct;
-struct pt_regs;
-
-int xnarch_init_mayday(void);
-
-void xnarch_cleanup_mayday(void);
-
-void *xnarch_get_mayday_page(void);
-
-void xnarch_handle_mayday(struct xnarchtcb *tcb,
-			  struct pt_regs *regs,
-			  unsigned long tramp);
-
-void xnarch_fixup_mayday(struct xnarchtcb *tcb,
-			 struct pt_regs *regs);
-
-#endif /* !_COBALT_ASM_GENERIC_MAYDAY_H */
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index d0f2f3725c..10a9fb5678 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -54,7 +54,6 @@
 #include <rtdm/driver.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
-#include <asm-generic/xenomai/mayday.h>
 #include "../debug.h"
 #include "internal.h"
 #include "thread.h"
@@ -790,16 +789,9 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 
 static int handle_mayday_event(struct pt_regs *regs)
 {
-	struct xnthread *thread = xnthread_current();
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	struct cobalt_ppd *sys_ppd;
-
-	XENO_BUG_ON(COBALT, !xnthread_test_state(thread, XNUSER));
+	XENO_BUG_ON(COBALT, !xnthread_test_state(xnthread_current(), XNUSER));
 
-	/* We enter the mayday handler with hw IRQs off. */
-	sys_ppd = cobalt_ppd_get(0);
-
-	xnarch_handle_mayday(tcb, regs, sys_ppd->mayday_tramp);
+	xnthread_relax(0, 0);
 
 	return KEVENT_PROPAGATE;
 }
@@ -1295,21 +1287,6 @@ int ipipe_kevent_hook(int kevent, void *data)
 	return ret;
 }
 
-static inline unsigned long map_mayday_page(void)
-{
-	void __user *u_addr = NULL;
-	void *mayday_page;
-	int ret;
-
-	mayday_page = xnarch_get_mayday_page();
-	ret = rtdm_mmap_to_user(NULL, mayday_page, PAGE_SIZE,
-				get_mayday_prot(), &u_addr, NULL, NULL);
-	if (ret)
-		return 0UL;
-
-	return (unsigned long)u_addr;
-}
-
 static int attach_process(struct cobalt_process *process)
 {
 	struct cobalt_ppd *p = &process->sys_ppd;
@@ -1323,15 +1300,6 @@ static int attach_process(struct cobalt_process *process)
 
 	cobalt_umm_set_name(&p->umm, "private heap[%d]", task_pid_nr(current));
 
-	p->mayday_tramp = map_mayday_page();
-	if (p->mayday_tramp == 0) {
-		printk(XENO_WARNING
-		       "%s[%d] cannot map MAYDAY page\n",
-		       current->comm, task_pid_nr(current));
-		ret = -ENOMEM;
-		goto fail_mayday;
-	}
-
 	exe_path = get_exe_path(current);
 	if (IS_ERR(exe_path)) {
 		printk(XENO_WARNING
@@ -1351,7 +1319,6 @@ static int attach_process(struct cobalt_process *process)
 fail_hash:
 	if (p->exe_path)
 		kfree(p->exe_path);
-fail_mayday:
 	cobalt_umm_destroy(&p->umm);
 
 	return ret;
@@ -1498,14 +1465,6 @@ __init int cobalt_init(void)
 	if (ret)
 		goto fail_debug;
 
-	/*
-	 * Setup the mayday stuff early, before userland can mess with
-	 * real-time ops.
-	 */
-	ret = xnarch_init_mayday();
-	if (ret)
-		goto fail_mayday;
-
 	for (i = 0; i < PROCESS_HASH_SIZE; i++)
 		INIT_HLIST_HEAD(&process_hash[i]);
 
@@ -1537,8 +1496,6 @@ fail_register:
 	cobalt_memdev_cleanup();
 fail_memdev:
 	xnsynch_destroy(&yield_sync);
-	xnarch_cleanup_mayday();
-fail_mayday:
 	xndebug_cleanup();
 fail_debug:
 	kfree(process_hash);
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 058a8282bf..a9c979903c 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -26,7 +26,6 @@
 #include <cobalt/kernel/tree.h>
 #include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/init.h>
-#include <asm-generic/xenomai/mayday.h>
 #include <asm/syscall.h>
 #include "internal.h"
 #include "thread.h"
@@ -271,34 +270,6 @@ static COBALT_SYSCALL(serialdbg, current,
 	return 0;
 }
 
-static COBALT_SYSCALL(mayday, current, (void))
-{
-	struct pt_regs *regs = task_pt_regs(current);
-	struct xnthread *cur;
-
-	cur = xnthread_current();
-	if (cur == NULL) {
-		printk(XENO_WARNING
-		       "MAYDAY received from invalid context %s[%d]\n",
-		       current->comm, task_pid_nr(current));
-		return -EPERM;
-	}
-
-	/*
-	 * If the thread was kicked by the watchdog, this syscall we
-	 * have just forced on it via the mayday escape will cause it
-	 * to relax. See handle_head_syscall().
-	 */
-	xnarch_fixup_mayday(xnthread_archtcb(cur), regs);
-
-	/*
-	 * Return whatever value xnarch_fixup_mayday set for this
-	 * register, in order not to undo what xnarch_fixup_mayday
-	 * did.
-	 */
-	return __xn_reg_rval(regs);
-}
-
 static void stringify_feature_set(unsigned long fset, char *buf, int size)
 {
 	unsigned long feature;
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 04c0b62d3f..1a069d07c9 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -39,7 +39,6 @@
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/thread.h>
 #include <trace/events/cobalt-core.h>
-#include <asm-generic/xenomai/mayday.h>
 #include "debug.h"
 
 static DECLARE_WAIT_QUEUE_HEAD(join_all);
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 77392e7257..27b3ef0817 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -154,7 +154,6 @@
 		__cobalt_symbolic_syscall(trace),			\
 		__cobalt_symbolic_syscall(corectl),			\
 		__cobalt_symbolic_syscall(get_current),			\
-		__cobalt_symbolic_syscall(mayday),			\
 		__cobalt_symbolic_syscall(backtrace),			\
 		__cobalt_symbolic_syscall(serialdbg),			\
 		__cobalt_symbolic_syscall(extend),			\
-- 
2.16.4

