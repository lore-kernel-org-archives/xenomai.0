Message-ID: <451D3376.5050706@domain.hid>
Date: Fri, 29 Sep 2006 16:53:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000905000107080807030001"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] reorder tracer support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000905000107080807030001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This patch moves the I-pipe tracer configuration into the kernel hacking
section of Kconfig. My feeling is that this is the place where is really
belongs. :)

Furthermore, it allows to separately control if mcount support should be
activated, i.e. logging of each kernel function entry. Switching this
off can be useful if only explicit trace points are desired (e.g.
ipipe_trace_special / xntrace_special or the worst-case timing of some
code path via xntrace_user_start/stop).

Finally, the patch fixes some minor dependencies of the tracer.

Jan

--------------000905000107080807030001
Content-Type: text/plain;
 name="tracer-reorder-options.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tracer-reorder-options.patch"

---
 Makefile                         |    8 ++--
 arch/i386/boot/compressed/misc.c |    2 -
 arch/i386/kernel/Makefile        |    2 -
 arch/i386/kernel/ipipe-root.c    |    4 +-
 kernel/ipipe/Kconfig             |   54 ------------------------------
 kernel/ipipe/Kconfig.debug       |   69 +++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug                |    2 +
 7 files changed, 79 insertions(+), 62 deletions(-)

Index: linux-2.6.17.13/Makefile
===================================================================
--- linux-2.6.17.13.orig/Makefile
+++ linux-2.6.17.13/Makefile
@@ -469,15 +469,15 @@ else
 CFLAGS		+= -O2
 endif
 
-ifdef CONFIG_IPIPE_TRACE
-CFLAGS          += -pg -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
-else
+ifdef CONFIG_IPIPE_TRACE_MCOUNT
+CFLAGS          += -pg
+endif
+
 ifdef CONFIG_FRAME_POINTER
 CFLAGS		+= -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
 else
 CFLAGS		+= -fomit-frame-pointer
 endif
-endif
 
 ifdef CONFIG_UNWIND_INFO
 CFLAGS		+= -fasynchronous-unwind-tables
Index: linux-2.6.17.13/kernel/ipipe/Kconfig
===================================================================
--- linux-2.6.17.13.orig/kernel/ipipe/Kconfig
+++ linux-2.6.17.13/kernel/ipipe/Kconfig
@@ -4,57 +4,3 @@ config IPIPE
 	---help---
 	  Activate this option if you want the interrupt pipeline to be
 	  compiled in.
-
-config IPIPE_TRACE
-	bool "Latency tracing"
-	depends on IPIPE && PROC_FS
-	select FRAME_POINTER
-	default n
-	---help---
-	  Activate this option if you want to use per-function tracing of
-	  the kernel. The tracer will collect data via instrumentation
-	  features like the one below or with the help of explicite calls
-	  of ipipe_trace_xxx(). See include/linux/ipipe_trace.h for the
-	  in-kernel tracing API. The collected data and runtime control
-	  is available via /proc/ipipe/trace/*.
-
-config IPIPE_TRACE_ENABLE
-	bool "Enable tracing on boot"
-	depends on IPIPE_TRACE
-	default y
-	---help---
-	  Disable this option if you want to arm the tracer after booting
-	  manually ("echo 1 > /proc/ipipe/tracer/enable"). This can reduce
-	  boot time on slow embedded devices due to the tracer overhead.
-
-config IPIPE_TRACE_IRQSOFF
-	bool "Trace IRQs-off times"
-	depends on IPIPE_TRACE
-	default y
-	---help---
-	  Activate this option if I-pipe shall trace the longest path
-	  with hard-IRQs switched off.
-
-config IPIPE_TRACE_SHIFT
-	int "Depth of trace log (14 => 16Kpoints, 15 => 32Kpoints)"
-	range 10 18
-	default 14
-	depends on IPIPE_TRACE
-	---help---
-	  The number of trace points to hold tracing data for each
-	  trace path, as a power of 2.
-
-config IPIPE_TRACE_VMALLOC
-	bool "Use vmalloc'ed trace buffer"
-	depends on IPIPE_TRACE
-	---help---
-	  Instead of reserving static kernel data, the required buffer
-	  is allocated via vmalloc during boot-up when this option is
-	  enabled. This can help to start systems that are low on memory,
-	  but it slightly degrades overall performance. Try this option
-	  when a traced kernel hangs unexpectedly at boot time.
-
-config IPIPE_TRACE_ENABLE_VALUE
-	int
-	default 0 if !IPIPE_TRACE_ENABLE
-	default 1 if IPIPE_TRACE_ENABLE
Index: linux-2.6.17.13/kernel/ipipe/Kconfig.debug
===================================================================
--- /dev/null
+++ linux-2.6.17.13/kernel/ipipe/Kconfig.debug
@@ -0,0 +1,69 @@
+config IPIPE_DEBUG
+	bool "I-pipe debugging"
+	depends on IPIPE
+
+config IPIPE_TRACE
+	bool "Latency tracing"
+	depends on IPIPE_DEBUG
+	select FRAME_POINTER
+	select KALLSYMS
+	select PROC_FS
+	---help---
+	  Activate this option if you want to use per-function tracing of
+	  the kernel. The tracer will collect data via instrumentation
+	  features like the one below or with the help of explicite calls
+	  of ipipe_trace_xxx(). See include/linux/ipipe_trace.h for the
+	  in-kernel tracing API. The collected data and runtime control
+	  is available via /proc/ipipe/trace/*.
+
+config IPIPE_TRACE_ENABLE
+	bool "Enable tracing on boot"
+	depends on IPIPE_TRACE
+	default y
+	---help---
+	  Disable this option if you want to arm the tracer after booting
+	  manually ("echo 1 > /proc/ipipe/tracer/enable"). This can reduce
+	  boot time on slow embedded devices due to the tracer overhead.
+
+config IPIPE_TRACE_MCOUNT
+	bool "Intrument function entries"
+	depends on IPIPE_TRACE
+	default y
+	---help---
+	  When enabled, records every kernel function entry in the tracer
+	  log. While this slows down the system noticeably, it provides
+	  the highest level of information about the flow of events.
+	  However, it can be switch off in order to record only explicit
+	  I-pipe trace points.
+
+config IPIPE_TRACE_IRQSOFF
+	bool "Trace IRQs-off times"
+	depends on IPIPE_TRACE
+	default y
+	---help---
+	  Activate this option if I-pipe shall trace the longest path
+	  with hard-IRQs switched off.
+
+config IPIPE_TRACE_SHIFT
+	int "Depth of trace log (14 => 16Kpoints, 15 => 32Kpoints)"
+	range 10 18
+	default 14
+	depends on IPIPE_TRACE
+	---help---
+	  The number of trace points to hold tracing data for each
+	  trace path, as a power of 2.
+
+config IPIPE_TRACE_VMALLOC
+	bool "Use vmalloc'ed trace buffer"
+	depends on IPIPE_TRACE
+	---help---
+	  Instead of reserving static kernel data, the required buffer
+	  is allocated via vmalloc during boot-up when this option is
+	  enabled. This can help to start systems that are low on memory,
+	  but it slightly degrades overall performance. Try this option
+	  when a traced kernel hangs unexpectedly at boot time.
+
+config IPIPE_TRACE_ENABLE_VALUE
+	int
+	default 0 if !IPIPE_TRACE_ENABLE
+	default 1 if IPIPE_TRACE_ENABLE
Index: linux-2.6.17.13/lib/Kconfig.debug
===================================================================
--- linux-2.6.17.13.orig/lib/Kconfig.debug
+++ linux-2.6.17.13/lib/Kconfig.debug
@@ -23,6 +23,8 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
+source "kernel/ipipe/Kconfig.debug"
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
Index: linux-2.6.17.13/arch/i386/boot/compressed/misc.c
===================================================================
--- linux-2.6.17.13.orig/arch/i386/boot/compressed/misc.c
+++ linux-2.6.17.13/arch/i386/boot/compressed/misc.c
@@ -15,7 +15,7 @@
 #include <asm/io.h>
 #include <asm/page.h>
 
-#ifdef CONFIG_IPIPE_TRACE
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
 void __attribute__ ((no_instrument_function)) mcount(void)
 {
 }
Index: linux-2.6.17.13/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.17.13.orig/arch/i386/kernel/Makefile
+++ linux-2.6.17.13/arch/i386/kernel/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_IPIPE)		+= ipipe-core.o ipipe-root.o
-obj-$(CONFIG_IPIPE_TRACE)	+= ipipe-mcount.o
+obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+= ipipe-mcount.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
Index: linux-2.6.17.13/arch/i386/kernel/ipipe-root.c
===================================================================
--- linux-2.6.17.13.orig/arch/i386/kernel/ipipe-root.c
+++ linux-2.6.17.13/arch/i386/kernel/ipipe-root.c
@@ -642,7 +642,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(init_tss);
 EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_IPIPE_TRACE
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
 void notrace mcount(void);
 EXPORT_SYMBOL(mcount);
-#endif /* CONFIG_IPIPE_TRACE */
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */

--------------000905000107080807030001--

