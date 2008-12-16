Message-ID: <4947ED98.9080107@domain.hid>
Date: Tue, 16 Dec 2008 19:04:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86-2.6.27: Port I-pipe tracer over ftrace
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is a port of the I-pipe trace over 2.6.27's new ftrace
infrastructure. It basically off-loads us from maintaining the mcount
stubs. But it also adds some small additional overhead when enabled, and
you should know that playing with /proc/sys/kernel/ftrace_enabled while
using the I-pipe trace may disable the function trace points. Besides
that, all seems to be fine again, ready to be used.

The patch also contains a bunch of tracer-related cleanups, so the patch
actually shrinks.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

---
 Makefile                        |    4 --
 arch/x86/kernel/Makefile        |    1 
 arch/x86/kernel/cpu/common_64.c |    4 +-
 arch/x86/kernel/head64.c        |    2 -
 arch/x86/kernel/ipipe.c         |    5 --
 arch/x86/kernel/mcount_32.S     |   27 ---------------
 arch/x86/kernel/mcount_64.S     |   41 -----------------------
 arch/x86/kernel/smpboot.c       |    2 -
 include/linux/linkage.h         |    4 --
 kernel/ipipe/Kconfig.debug      |    6 ---
 kernel/ipipe/tracer.c           |   69 +++++++++++++++++++++++++++++++++++++---
 kernel/trace/Kconfig            |    1 
 12 files changed, 71 insertions(+), 95 deletions(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -525,10 +525,6 @@ endif
 # Arch Makefiles may override this setting
 KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
 
-ifdef CONFIG_IPIPE_TRACE_MCOUNT
-KBUILD_CFLAGS	+= -pg
-endif
-
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
Index: b/arch/x86/kernel/Makefile
===================================================================
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -79,7 +79,6 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_IPIPE)		+= ipipe.o
-obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+= mcount_$(BITS).o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 
Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -1009,8 +1009,3 @@ EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 EXPORT_SYMBOL(tasklist_lock);
 #endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
-
-#ifdef CONFIG_IPIPE_TRACE_MCOUNT
-void notrace mcount(void);
-EXPORT_SYMBOL(mcount);
-#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
Index: b/arch/x86/kernel/mcount_32.S
===================================================================
--- a/arch/x86/kernel/mcount_32.S
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *  linux/arch/x86/mcount_32.S
- *
- *  Copyright (C) 2005, 2007 Jan Kiszka
- */
-
-.globl mcount
-mcount:
-	cmpl $0,ipipe_trace_enable
-	je out
-
-	pushl %eax
-	pushl %ecx
-	pushl %edx
-
-	pushl $0		# no additional value (v)
-	movl 4(%ebp),%ecx	# __CALLER_ADDR1
-	movl 16(%esp),%edx	# __CALLER_ADDR0
-	movl $0,%eax		# IPIPE_TRACE_FUNC
-	call __ipipe_trace
-	popl %eax
-
-	popl %edx
-	popl %ecx
-	popl %eax
-out:
-	ret
Index: b/arch/x86/kernel/mcount_64.S
===================================================================
--- a/arch/x86/kernel/mcount_64.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- *   linux/arch/x86/kernel/mcount_64.S
- *
- *   Copyright (C) 2002 Free Software Foundation, Inc.
- *   Contributed by Andreas Jaeger <aj@domain.hid>.
- *   Slightly adapted by Philippe Gerum for the I-pipe tracer.
- */
-
-#include <linux/linkage.h>
-
-	.code64
-
-ENTRY(mcount)
-	cmpl	$0,ipipe_trace_enable
-	jz	out
-	subq	$56,%rsp
-	movq	%rax,(%rsp)
-	movq	%rcx,8(%rsp)
-	movq	%rdx,16(%rsp)
-	movq	%rsi,24(%rsp)
-	movq	%rdi,32(%rsp)
-	movq	%r8,40(%rsp)
-	movq	%r9,48(%rsp)
-
-	movq	$0,%rcx		/* No additional value. */
-	movq	8(%rbp),%rdx    /* Parent rip. */
-	movq	56(%rsp),%rsi   /* Caller rip. */
-	movq	$0,%rdi		/* IPIPE_TRACE_FN */
-	call    __ipipe_trace
-
-	movq	48(%rsp),%r9
-	movq	40(%rsp),%r8
-	movq	32(%rsp),%rdi
-	movq	24(%rsp),%rsi
-	movq	16(%rsp),%rdx
-	movq	8(%rsp),%rcx
-	movq	(%rsp),%rax
-	addq	$56,%rsp
-out:	
-	ret
-END(mcount)
Index: b/kernel/ipipe/Kconfig.debug
===================================================================
--- a/kernel/ipipe/Kconfig.debug
+++ b/kernel/ipipe/Kconfig.debug
@@ -39,6 +39,7 @@ config IPIPE_TRACE_ENABLE
 config IPIPE_TRACE_MCOUNT
 	bool "Instrument function entries"
 	default y
+	select FTRACE
 	---help---
 	  When enabled, records every kernel function entry in the tracer
 	  log. While this slows down the system noticeably, it provides
@@ -80,9 +81,4 @@ config IPIPE_TRACE_PANIC
 	  as well as ordinary kernel oopses. You can control the number
 	  of printed back trace points via /proc/ipipe/trace.
 
-config IPIPE_TRACE_ENABLE_VALUE
-	int
-	default 0 if !IPIPE_TRACE_ENABLE
-	default 1 if IPIPE_TRACE_ENABLE
-
 endif
Index: b/kernel/ipipe/tracer.c
===================================================================
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -32,6 +32,7 @@
 #include <linux/utsrelease.h>
 #include <linux/sched.h>
 #include <linux/ipipe.h>
+#include <linux/ftrace.h>
 #include <asm/uaccess.h>
 
 #define IPIPE_TRACE_PATHS           4 /* <!> Do not lower below 3 */
@@ -1292,9 +1293,57 @@ static int __ipipe_wr_trigger(struct fil
 	return count;
 }
 
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+static void notrace
+ipipe_trace_function(unsigned long ip, unsigned long parent_ip)
+{
+	if (!ipipe_trace_enable)
+		return;
+	__ipipe_trace(IPIPE_TRACE_FUNC, ip, parent_ip, 0);
+}
+
+static struct ftrace_ops ipipe_trace_ops = {
+	.func = ipipe_trace_function
+};
+
+static int __ipipe_wr_enable(struct file *file, const char __user *buffer,
+			     unsigned long count, void *data)
+{
+	char *end, buf[16];
+	int val;
+	int n;
+
+	n = (count > sizeof(buf) - 1) ? sizeof(buf) - 1 : count;
+
+	if (copy_from_user(buf, buffer, n))
+		return -EFAULT;
+
+	buf[n] = '\0';
+	val = simple_strtol(buf, &end, 0);
+
+	if (((*end != '\0') && !isspace(*end)) || (val < 0))
+		return -EINVAL;
+
+	mutex_lock(&out_mutex);
+
+	if (ipipe_trace_enable) {
+		if (!val)
+			unregister_ftrace_function(&ipipe_trace_ops);
+	} else if (val) {
+		ftrace_enabled = 1;
+		register_ftrace_function(&ipipe_trace_ops);
+	}
+	ipipe_trace_enable = val;
+
+	mutex_unlock(&out_mutex);
+
+	return count;
+}
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
+
 extern struct proc_dir_entry *ipipe_proc_root;
 
-static void __init
+static struct proc_dir_entry * __init
 __ipipe_create_trace_proc_val(struct proc_dir_entry *trace_dir,
                               const char *name, int *value_ptr)
 {
@@ -1307,6 +1356,7 @@ __ipipe_create_trace_proc_val(struct pro
 		entry->write_proc = __ipipe_wr_proc_val;
 		entry->owner = THIS_MODULE;
 	}
+	return entry;
 }
 
 void __init __ipipe_init_tracer(void)
@@ -1337,7 +1387,6 @@ void __init __ipipe_init_tracer(void)
 		per_cpu(trace_path, cpu) = tp_buf;
 	}
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
-	ipipe_trace_enable = CONFIG_IPIPE_TRACE_ENABLE_VALUE;
 
 	/* Calculate minimum overhead of __ipipe_trace() */
 	local_irq_disable_hw();
@@ -1354,6 +1403,14 @@ void __init __ipipe_init_tracer(void)
 	local_irq_enable_hw();
 	trace_overhead = ipipe_tsc2ns(min);
 
+#ifdef CONFIG_IPIPE_TRACE_ENABLE
+	ipipe_trace_enable = 1;
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+	ftrace_enabled = 1;
+	register_ftrace_function(&ipipe_trace_ops);
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
+#endif /* CONFIG_IPIPE_TRACE_ENABLE */
+
 	trace_dir = create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
 
 	entry = create_proc_entry("max", 0644, trace_dir);
@@ -1379,6 +1436,10 @@ void __init __ipipe_init_tracer(void)
 	                              &back_trace);
 	__ipipe_create_trace_proc_val(trace_dir, "verbose",
 	                              &verbose_trace);
-	__ipipe_create_trace_proc_val(trace_dir, "enable",
-	                              &ipipe_trace_enable);
+	entry = __ipipe_create_trace_proc_val(trace_dir, "enable",
+					      &ipipe_trace_enable);
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+	if (entry)
+		entry->write_proc = __ipipe_wr_enable;
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
 }
Index: b/kernel/trace/Kconfig
===================================================================
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -107,6 +107,7 @@ config DYNAMIC_FTRACE
 	depends on BROKEN
 	depends on FTRACE
 	depends on HAVE_DYNAMIC_FTRACE
+	depends on !IPIPE_TRACE_MCOUNT
 	default y
 	help
          This option will modify all the calls to ftrace dynamically
Index: b/arch/x86/kernel/cpu/common_64.c
===================================================================
--- a/arch/x86/kernel/cpu/common_64.c
+++ b/arch/x86/kernel/cpu/common_64.c
@@ -506,7 +506,7 @@ static int __init nonx32_setup(char *str
 }
 __setup("noexec32=", nonx32_setup);
 
-notrace void pda_init(int cpu)
+void pda_init(int cpu)
 {
 	struct x8664_pda *pda = cpu_pda(cpu);
 
@@ -595,7 +595,7 @@ DEFINE_PER_CPU(struct orig_ist, orig_ist
  * 'CPU state barrier', nothing should get across.
  * A lot of state is already set up in PDA init.
  */
-notrace void __cpuinit cpu_init(void)
+void __cpuinit cpu_init(void)
 {
 	int cpu = stack_smp_processor_id();
 	struct tss_struct *t = &per_cpu(init_tss, cpu);
Index: b/arch/x86/kernel/head64.c
===================================================================
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -72,7 +72,7 @@ static void __init copy_bootdata(char *r
 	}
 }
 
-void __init notrace x86_64_start_kernel(char * real_mode_data)
+void __init x86_64_start_kernel(char * real_mode_data)
 {
 	int i;
 
Index: b/arch/x86/kernel/smpboot.c
===================================================================
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -282,7 +282,7 @@ static void __cpuinit smp_callin(void)
 /*
  * Activate a secondary processor.
  */
-static void notrace __cpuinit start_secondary(void *unused)
+static void __cpuinit start_secondary(void *unused)
 {
 	/*
 	 * Don't put *anything* before cpu_init(), SMP booting is too
Index: b/include/linux/linkage.h
===================================================================
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -95,8 +95,4 @@
 #define ATTRIB_NORET  __attribute__((noreturn))
 #define NORET_AND     noreturn,
 
-#ifndef notrace
-#define notrace		__attribute__((no_instrument_function))
-#endif
-
 #endif

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

