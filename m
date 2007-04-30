Message-ID: <4635F801.7060000@domain.hid>
Date: Mon, 30 Apr 2007 16:06:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4630F284.6040103@domain.hid>
In-Reply-To: <4630F284.6040103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDA83AD743CB9378D0949DDD7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH 7/7] Detect illicit cross-domain
	calls	(i386/x86_64)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA83AD743CB9378D0949DDD7
Content-Type: multipart/mixed;
 boundary="------------020802080409070800050407"

This is a multi-part message in MIME format.
--------------020802080409070800050407
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> There are already three major instrumentation points for Linux included=
:
>  - preempt_xxx()
>  - might_resched()
>  - raw_local_irq_save/disable()

 - smp_processor_id()

The last spot used to cause quite some headache in earlier patches, and
running on it over non-root domain for whatever reason should be
detected as well.

Moreover, this patch revision sanitises some #ifdefs and copes the with
an internal usage of local_irq_disable over non-root domains in
__ipipe_handle_exception().

Jan


PS: The hunk around i386's __unlazy_fpu is already on its way into mainli=
ne.

--------------020802080409070800050407
Content-Type: text/plain;
 name="debug-dom-violation-v5.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="debug-dom-violation-v5.patch"

---
 include/linux/ipipe_base.h  |    6 ++++
 include/linux/ipipe_trace.h |    7 ++++-
 include/linux/kernel.h      |    8 ++++-
 include/linux/preempt.h     |   59 +++++++++++++++++--------------------=
-------
 include/linux/smp.h         |   14 ++++++++--
 kernel/ipipe/Kconfig.debug  |    9 ++++++
 kernel/ipipe/core.c         |   25 ++++++++++++++++++
 7 files changed, 88 insertions(+), 40 deletions(-)

Index: linux-2.6.20/include/linux/ipipe_base.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe_base.h
+++ linux-2.6.20/include/linux/ipipe_base.h
@@ -75,6 +75,12 @@ void __ipipe_unstall_root(void);
=20
 void __ipipe_restore_root(unsigned long x);
=20
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+static inline void ipipe_check_context(struct ipipe_domain *border_ipd) =
{ }
+#endif /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #endif	/* CONFIG_IPIPE */
=20
 #endif	/* !__LINUX_IPIPE_BASE_H */
Index: linux-2.6.20/include/linux/kernel.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/kernel.h
+++ linux-2.6.20/include/linux/kernel.h
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/ipipe_base.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
=20
@@ -72,9 +73,12 @@ struct user;
  */
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int cond_resched(void);
-# define might_resched() cond_resched()
+# define might_resched() do { \
+		ipipe_check_context(ipipe_root_domain); \
+		cond_resched(); \
+	} while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() ipipe_check_context(ipipe_root_domain)
 #endif
=20
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
Index: linux-2.6.20/include/linux/preempt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/preempt.h
+++ linux-2.6.20/include/linux/preempt.h
@@ -8,6 +8,7 @@
=20
 #include <linux/thread_info.h>
 #include <linux/linkage.h>
+#include <linux/ipipe_base.h>
=20
 #ifdef CONFIG_DEBUG_PREEMPT
   extern void fastcall add_preempt_count(int val);
@@ -26,52 +27,40 @@
=20
 asmlinkage void preempt_schedule(void);
=20
-#ifdef CONFIG_IPIPE
-#include <asm/ipipe.h>
-DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
-extern struct ipipe_domain ipipe_root;
-#define ipipe_preempt_guard() (per_cpu(ipipe_percpu_domain, ipipe_proces=
sor_id()) =3D=3D &ipipe_root)
-#else  /* !CONFIG_IPIPE */
-#define ipipe_preempt_guard()	1
-#endif /* CONFIG_IPIPE */
-
-#define preempt_disable()						\
-do {									\
-	if (ipipe_preempt_guard()) {					\
-		inc_preempt_count();					\
-		barrier();						\
-	}								\
+#define preempt_disable() \
+do { \
+	ipipe_check_context(ipipe_root_domain); \
+	inc_preempt_count(); \
+	barrier(); \
 } while (0)
=20
-#define preempt_enable_no_resched()					\
-do {									\
-	if (ipipe_preempt_guard()) {					\
-		barrier();						\
-		dec_preempt_count();					\
-	}								\
+#define preempt_enable_no_resched() \
+do { \
+	ipipe_check_context(ipipe_root_domain); \
+	barrier(); \
+	dec_preempt_count(); \
 } while (0)
=20
-#define preempt_check_resched()						\
-do {									\
-	if (ipipe_preempt_guard()) {					\
-		if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))	\
-			preempt_schedule();				\
-	}								\
+#define preempt_check_resched() \
+do { \
+	ipipe_check_context(ipipe_root_domain); \
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
+		preempt_schedule(); \
 } while (0)
=20
-#define preempt_enable()						\
-do {									\
-	preempt_enable_no_resched();					\
+#define preempt_enable() \
+do { \
+	preempt_enable_no_resched(); \
 	barrier(); \
-	preempt_check_resched();					\
+	preempt_check_resched(); \
 } while (0)
=20
 #else
=20
-#define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do { } while (0)
-#define preempt_enable()		do { } while (0)
-#define preempt_check_resched()		do { } while (0)
+#define preempt_disable()		ipipe_check_context(ipipe_root_domain)
+#define preempt_enable_no_resched()	ipipe_check_context(ipipe_root_domai=
n)
+#define preempt_enable()		ipipe_check_context(ipipe_root_domain)
+#define preempt_check_resched()		ipipe_check_context(ipipe_root_domain)
=20
 #endif
=20
Index: linux-2.6.20/kernel/ipipe/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/Kconfig.debug
+++ linux-2.6.20/kernel/ipipe/Kconfig.debug
@@ -2,6 +2,15 @@ config IPIPE_DEBUG
 	bool "I-pipe debugging"
 	depends on IPIPE
=20
+config IPIPE_DEBUG_CONTEXT
+	bool "Check for illicit cross-domain calls"
+	depends on IPIPE_DEBUG
+	---help---
+	  Enable this feature to arm checkpoints in the kernel that
+	  verify the correct invocation context. On entry of critical
+	  Linux services a warning is issued if the caller is not
+	  running over the root domain.
+
 config IPIPE_TRACE
 	bool "Latency tracing"
 	depends on IPIPE_DEBUG
Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -33,6 +33,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #endif	/* CONFIG_PROC_FS */
+#include <linux/ipipe_trace.h>
=20
 static int __ipipe_ptd_key_count;
=20
@@ -1383,6 +1384,30 @@ void __init ipipe_init_proc(void)
=20
 #endif	/* CONFIG_PROC_FS */
=20
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void ipipe_check_context(struct ipipe_domain *border_ipd)
+{
+	static int check_hit;
+
+	if (likely(ipipe_current_domain->priority <=3D border_ipd->priority) ||=

+	    check_hit)
+		return;
+
+	check_hit =3D 1;
+
+	ipipe_trace_panic_freeze();
+	ipipe_set_printk_sync(ipipe_current_domain);
+	printk(KERN_ERR "I-pipe: Detected illicit call from domain '%s'\n"
+	       KERN_ERR "        into a service reserved for domain '%s' and "
+			"below.\n",
+	       ipipe_current_domain->name, border_ipd->name);
+	show_stack(NULL, NULL);
+	ipipe_trace_panic_dump();
+}
+
+EXPORT_SYMBOL(ipipe_check_context);
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 EXPORT_SYMBOL(ipipe_virtualize_irq);
 EXPORT_SYMBOL(ipipe_control_irq);
 EXPORT_SYMBOL(ipipe_suspend_domain);
Index: linux-2.6.20/include/linux/smp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/smp.h
+++ linux-2.6.20/include/linux/smp.h
@@ -109,6 +109,8 @@ static inline int smp_call_function_sing
=20
 #endif /* !SMP */
=20
+#include <linux/ipipe_base.h>
+
 /*
  * smp_processor_id(): get the current CPU ID.
  *
@@ -126,9 +128,17 @@ static inline int smp_call_function_sing
  */
 #ifdef CONFIG_DEBUG_PREEMPT
   extern unsigned int debug_smp_processor_id(void);
-# define smp_processor_id() debug_smp_processor_id()
+# define smp_processor_id()				\
+	({						\
+		ipipe_check_context(ipipe_root_domain);	\
+		debug_smp_processor_id();		\
+	})
 #else
-# define smp_processor_id() raw_smp_processor_id()
+# define smp_processor_id()				\
+	({						\
+		ipipe_check_context(ipipe_root_domain);	\
+		raw_smp_processor_id();			\
+	})
 #endif
=20
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
Index: linux-2.6.20/include/linux/ipipe_trace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe_trace.h
+++ linux-2.6.20/include/linux/ipipe_trace.h
@@ -39,6 +39,11 @@ int ipipe_trace_frozen_reset(void);
 void ipipe_trace_panic_freeze(void);
 void ipipe_trace_panic_dump(void);
=20
-#endif /* CONFIG_IPIPE_TRACE */
+#else /* !CONFIG_IPIPE_TRACE */
+
+static inline void ipipe_trace_panic_freeze(void) { }
+static inline void ipipe_trace_panic_dump(void) { }
+
+#endif /* !CONFIG_IPIPE_TRACE */
=20
 #endif	/* !__LINUX_IPIPE_H */

--------------020802080409070800050407
Content-Type: text/plain;
 name="debug-dom-violation-i386-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="debug-dom-violation-i386-v2.patch"

---
 arch/i386/kernel/ipipe.c    |    9 +++++++--
 arch/i386/kernel/process.c  |    2 +-
 include/asm-i386/i387.h     |    9 +++++----
 include/asm-i386/irqflags.h |    7 +++++--
 4 files changed, 18 insertions(+), 9 deletions(-)

Index: linux-2.6.20/include/asm-i386/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/irqflags.h
+++ linux-2.6.20/include/asm-i386/irqflags.h
@@ -54,6 +54,7 @@ static inline void raw_local_irq_restore
 static inline void raw_local_irq_disable(void)
 {
 #ifdef CONFIG_IPIPE
+	ipipe_check_context(ipipe_root_domain);
 	__ipipe_stall_root();
 	barrier();
 #else
@@ -144,8 +145,10 @@ static inline unsigned long __raw_local_
 #define raw_local_save_flags(flags) \
 		do { (flags) =3D __raw_local_save_flags(); } while (0)
=20
-#define raw_local_irq_save(flags) \
-		do { (flags) =3D __raw_local_irq_save(); } while (0)
+#define raw_local_irq_save(flags) do {			\
+		ipipe_check_context(ipipe_root_domain);	\
+		(flags) =3D __raw_local_irq_save();	\
+	} while (0)
=20
 static inline int raw_irqs_disabled_flags(unsigned long flags)
 {
Index: linux-2.6.20/include/asm-i386/i387.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/i387.h
+++ linux-2.6.20/include/asm-i386/i387.h
@@ -75,10 +75,11 @@ static inline void __save_init_fpu( stru
 }
=20
 #define __unlazy_fpu( tsk ) do { \
-	if (task_thread_info(tsk)->status & TS_USEDFPU) \
-		save_init_fpu( tsk ); 			\
-	else						\
-		tsk->fpu_counter =3D 0;			\
+	if (task_thread_info(tsk)->status & TS_USEDFPU) {	\
+		__save_init_fpu(tsk); 				\
+		stts();						\
+	} else							\
+		tsk->fpu_counter =3D 0;				\
 } while (0)
=20
 #define __clear_fpu( tsk )					\
Index: linux-2.6.20/arch/i386/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/process.c
+++ linux-2.6.20/arch/i386/kernel/process.c
@@ -636,7 +636,7 @@ struct task_struct fastcall * __switch_t
 {
 	struct thread_struct *prev =3D &prev_p->thread,
 				 *next =3D &next_p->thread;
-	int cpu =3D smp_processor_id();
+	int cpu =3D raw_smp_processor_id();
 	struct tss_struct *tss =3D &per_cpu(init_tss, cpu);
=20
 	/* never put a printk in __switch_to... printk() calls wake_up*() indir=
ectly */
Index: linux-2.6.20/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.20/arch/i386/kernel/ipipe.c
@@ -711,8 +711,13 @@ fastcall int __ipipe_handle_exception(st
 	/* Track the hw interrupt state before calling the Linux
 	 * exception handler, replicating it into the virtual mask. */
=20
-	if (irqs_disabled_hw())
-		local_irq_disable();
+	if (irqs_disabled_hw()) {
+		/* Do not trigger the alarm in ipipe_check_context() by using
+		 * plain local_irq_disable(). */
+		__ipipe_stall_root();
+		trace_hardirqs_off();
+		barrier();
+	}
=20
 #ifdef CONFIG_KGDB
 	/* catch exception KGDB is interested in over non-root domains */

--------------020802080409070800050407
Content-Type: text/plain;
 name="debug-dom-violation-x86_64-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="debug-dom-violation-x86_64-v2.patch"

---
 arch/x86_64/kernel/ipipe.c    |    9 +++++++--
 arch/x86_64/kernel/process.c  |    2 +-
 include/asm-x86_64/irqflags.h |    7 +++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

Index: linux-2.6.20-x64/include/asm-x86_64/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-x64.orig/include/asm-x86_64/irqflags.h
+++ linux-2.6.20-x64/include/asm-x86_64/irqflags.h
@@ -86,6 +86,7 @@ static inline int raw_irqs_disabled_flag
 static inline void raw_local_irq_disable(void)
 {
 #ifdef CONFIG_IPIPE
+	ipipe_check_context(ipipe_root_domain);
 	__ipipe_stall_root();
 	barrier();
 #else
@@ -128,8 +129,10 @@ static inline unsigned long __raw_local_
 	return flags;
 }
=20
-#define raw_local_irq_save(flags) \
-		do { (flags) =3D __raw_local_irq_save(); } while (0)
+#define raw_local_irq_save(flags) do {			\
+		ipipe_check_context(ipipe_root_domain);	\
+		(flags) =3D __raw_local_irq_save();	\
+	} while (0)
=20
 static inline int raw_irqs_disabled(void)
 {
Index: linux-2.6.20-x64/arch/x86_64/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-x64.orig/arch/x86_64/kernel/ipipe.c
+++ linux-2.6.20-x64/arch/x86_64/kernel/ipipe.c
@@ -611,8 +611,13 @@ asmlinkage int __ipipe_handle_exception(
 	/* Track the hw interrupt state before calling the Linux
 	 * exception handler, replicating it into the virtual mask. */
=20
-	if (irqs_disabled_hw())
-		local_irq_disable();
+	if (irqs_disabled_hw()) {
+		/* Do not trigger the alarm in ipipe_check_context() by using
+		 * plain local_irq_disable(). */
+		__ipipe_stall_root();
+		trace_hardirqs_off();
+		barrier();
+	}
=20
 #ifdef CONFIG_KGDB
 	/* catch exception KGDB is interested in over non-root domains */
Index: linux-2.6.20-x64/arch/x86_64/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-x64.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.20-x64/arch/x86_64/kernel/process.c
@@ -572,7 +572,7 @@ __switch_to(struct task_struct *prev_p,=20
 {
 	struct thread_struct *prev =3D &prev_p->thread,
 				 *next =3D &next_p->thread;
-	int cpu =3D smp_processor_id(); =20
+	int cpu =3D raw_smp_processor_id(); =20
 	struct tss_struct *tss =3D &per_cpu(init_tss, cpu);
=20
 	/* we're going to use this soon, after a few expensive things */

--------------020802080409070800050407--

--------------enigDA83AD743CB9378D0949DDD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGNfgBniDOoMHTA+kRAoieAJ0UNPOYYZV8lAeMxxj8JCfKSXP0VQCeLTN/
Q4hKNEyokVzSSsb4fD/VnOg=
=Fjst
-----END PGP SIGNATURE-----

--------------enigDA83AD743CB9378D0949DDD7--

