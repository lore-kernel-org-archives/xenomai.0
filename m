Message-ID: <5491D227.2020807@siemens.com>
Date: Wed, 17 Dec 2014 19:57:43 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5491B5E9.4030200@siemens.com> <5491C2CA.7000906@xenomai.org>
 <5491C179.2000600@siemens.com> <5491CB3F.2050509@xenomai.org>
 <5491CC27.6080909@siemens.com> <5491D196.3040309@xenomai.org>
In-Reply-To: <5491D196.3040309@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mayday mechanism broken on x86-64 - simpler approach
 feasible?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2014-12-17 19:55, Philippe Gerum wrote:
> I meant to tell crap: x86_64 implies vsyscall available, so there is no
> "safe" binding prologue there. Only x86_32 has this, so that legacy
> non-NPTL libc which do not support vsyscall work. So back to the initial
> discussion.

OK. Here is a hack that implements fault-based mayday support on x86:

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 544507c..d4300e7 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -40,6 +40,7 @@ struct xnarchtcb {
 		unsigned long ip;
 		unsigned long ax;
 		unsigned long sp;
+		bool pending;
 	} mayday;
 };
 
diff --git a/kernel/cobalt/arch/x86/mayday.c b/kernel/cobalt/arch/x86/mayday.c
index 4b986c9..6ed7fea 100644
--- a/kernel/cobalt/arch/x86/mayday.c
+++ b/kernel/cobalt/arch/x86/mayday.c
@@ -24,114 +24,18 @@
 #include <cobalt/uapi/syscall.h>
 #include <asm/ptrace.h>
 
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
-	 *	b8 2b 02 00 0c		mov    $<mux_code>,%eax
-	 *	0f 05			syscall
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
-		.syscall = 0x050f,
-		.bug = 0x0b0f,
-	};
-
-	memcpy(page, &code, sizeof(code));
-
-	/* no cache flush required. */
-}
-
 int xnarch_init_mayday(void)
 {
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
 	return 0;
 }
 
 void xnarch_cleanup_mayday(void)
 {
-	vfree(mayday);
-#ifdef CONFIG_XENO_ARCH_SYS3264
-	vfree(mayday_compat);
-#endif
 }
 
 void *xnarch_get_mayday_page(void)
 {
-#if defined(CONFIG_X86_32) || !defined(CONFIG_XENO_ARCH_SYS3264)
-	return mayday;
-#else
-	return test_thread_flag(TIF_IA32) ? mayday_compat : mayday;
-#endif
+	return NULL;
 }
 
 void xnarch_handle_mayday(struct xnarchtcb *tcb, struct pt_regs *regs,
@@ -140,7 +44,8 @@ void xnarch_handle_mayday(struct xnarchtcb *tcb, struct pt_regs *regs,
 	tcb->mayday.sp = regs->sp;
 	tcb->mayday.ip = regs->ip;
 	tcb->mayday.ax = regs->ax;
-	regs->ip = tramp;
+	tcb->mayday.pending = true;
+	regs->ip = 0;
 }
 
 void xnarch_fixup_mayday(struct xnarchtcb *tcb, struct pt_regs *regs)
@@ -148,4 +53,5 @@ void xnarch_fixup_mayday(struct xnarchtcb *tcb, struct pt_regs *regs)
 	regs->ip = tcb->mayday.ip;
 	regs->ax = tcb->mayday.ax;
 	regs->sp = tcb->mayday.sp;
+	tcb->mayday.pending = false;
 }
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 39f4e26..528836b 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -699,6 +699,12 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 	if (xnthread_test_state(thread, XNROOT))
 		return 0;
 
+	if (xnthread_archtcb(thread)->mayday.pending) {
+		xnarch_fixup_mayday(xnthread_archtcb(thread), d->regs);
+		xnthread_relax(0, 0);
+		return 1;
+	}
+
 	trace_cobalt_thread_fault(thread, d);
 
 	if (xnarch_fault_fpu_p(d)) {
@@ -1256,10 +1262,13 @@ static inline unsigned long map_mayday_page(void)
 	int ret;
 
 	mayday_page = xnarch_get_mayday_page();
+	if (!mayday_page)
+		return 0UL;
+
 	ret = rtdm_mmap_to_user(NULL, mayday_page, PAGE_SIZE,
 				PROT_READ|PROT_EXEC, &u_addr, NULL, NULL);
 	if (ret)
-		return 0UL;
+		return -1UL;
 
 	return (unsigned long)u_addr;
 }
@@ -1278,7 +1287,7 @@ static int attach_process(struct cobalt_process *process)
 	cobalt_umm_set_name(&p->umm, "private heap[%d]", current->pid);
 
 	p->mayday_tramp = map_mayday_page();
-	if (p->mayday_tramp == 0) {
+	if (p->mayday_tramp == -1UL) {
 		printk(XENO_WARN
 		       "%s[%d] cannot map MAYDAY page\n",
 		       current->comm, current->pid);


The test case is in my for-forge queue, i.e. the ported sigdebug. I-pipe
bits are pushed to for-upstream/3.14 for reference. I had some troubles
with improper root irqs state when running the smokey test under gdb.
Not related to mayday, just a side effect of debugging the issue.
Should be fixed now.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

