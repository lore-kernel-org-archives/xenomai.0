From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:18:17 +0200
Message-Id: <1278584301-8064-4-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 3/7] nucleus: Infrastructure for
	CLOCK_HOST_REALTIME
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: jan.kiszka@domain.hid, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Augment the shared vdso page with all data required to
implement a clock CLOCK_HOST_REALTIME that provides time
information synchronised with the NTP-corrected time
in the Linux kernel. Data exchange between Linux and
Xenomai is handled via an ipipe event.

Additionally, the patch creates an instance of struct xnvdso
independently of pervasive rt support. This avoids repeating
the definitions for hostrt in both cases.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/hal.h    |   11 +++++++
 include/asm-generic/system.h |    3 ++
 include/asm-sim/system.h     |    3 ++
 include/nucleus/Makefile.am  |    1 +
 include/nucleus/hostrt.h     |   54 +++++++++++++++++++++++++++++++++++
 include/nucleus/vdso.h       |   20 +++++++++++--
 ksrc/nucleus/Kconfig         |    4 ++
 ksrc/nucleus/module.c        |   64 +++++++++++++++++++++++++++++++++++++++--
 8 files changed, 153 insertions(+), 7 deletions(-)
 create mode 100644 include/nucleus/hostrt.h

diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index f90cafa..9986eb6 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -295,6 +295,14 @@ static int hdlr(unsigned event, struct ipipe_domain *ipd, void *data) \
 	return RTHAL_EVENT_PROPAGATE;				      \
 }
 
+#define RTHAL_DECLARE_HOSTRT_EVENT(hdlr)			      \
+static int hdlr(unsigned event, struct ipipe_domain *ipd, void *data) \
+{								      \
+	struct rthal_hostrt_data *hostrt = data;		      \
+	do_##hdlr(hostrt);					      \
+	return RTHAL_EVENT_PROPAGATE;				      \
+}
+
 #ifndef TASK_ATOMICSWITCH
 #ifdef CONFIG_PREEMPT
 /* We want this feature for preemptible kernels, or the behaviour when
@@ -354,6 +362,8 @@ static inline void rthal_enable_notifier(struct task_struct *p)
     ipipe_catch_event(&rthal_domain,IPIPE_EVENT_SYSCALL,hdlr)
 #define rthal_catch_exception(ex,hdlr)	\
     ipipe_catch_event(&rthal_domain,ex|IPIPE_EVENT_SELF,hdlr)
+#define rthal_catch_hostrt(hdlr)	\
+    ipipe_catch_event(ipipe_root_domain, IPIPE_EVENT_HOSTRT, hdlr)
 
 #ifdef IPIPE_EVENT_RETURN
 #define RTHAL_HAVE_RETURN_EVENT
@@ -680,6 +690,7 @@ static inline int rthal_trace_panic_dump(void)
 
 #endif /* CONFIG_IPIPE_TRACE */
 
+#define rthal_hostrt_data	ipipe_hostrt_data
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index a2c8fb9..b510e64 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -490,4 +490,7 @@ static inline void xnarch_hisyscall_entry(void)	{ }
 #define xnarch_post_graph(obj,state)
 #define xnarch_post_graph_if(obj,state,cond)
 
+/* Synchronised realtime clock*/
+#define xnarch_hostrt_data	rthal_hostrt_data
+
 #endif /* !_XENO_ASM_GENERIC_SYSTEM_H */
diff --git a/include/asm-sim/system.h b/include/asm-sim/system.h
index 1a5a875..de24a3b 100644
--- a/include/asm-sim/system.h
+++ b/include/asm-sim/system.h
@@ -598,4 +598,7 @@ static inline long IS_ERR(const void *ptr)
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
+/* Host realtime support is not supported in the simulator */
+struct xnarch_hostrt_data { };
+
 #endif /* !_XENO_ASM_SIM_SYSTEM_H */
diff --git a/include/nucleus/Makefile.am b/include/nucleus/Makefile.am
index 3a6a024..b04d7f6 100644
--- a/include/nucleus/Makefile.am
+++ b/include/nucleus/Makefile.am
@@ -6,6 +6,7 @@ includesub_HEADERS = \
 	bufd.h \
 	compiler.h \
 	heap.h \
+	hostrt.h \
 	intr.h \
 	jhash.h \
 	map.h \
diff --git a/include/nucleus/hostrt.h b/include/nucleus/hostrt.h
new file mode 100644
index 0000000..70ffbfe
--- /dev/null
+++ b/include/nucleus/hostrt.h
@@ -0,0 +1,54 @@
+#ifndef _XENO_NUCLEUS_HOSTRT_H
+#define _XENO_NUCLEUS_HOSTRT_H
+
+/*!\file hostrt.h
+ * \brief Definitions for global semaphore heap shared objects
+ * \author Wolfgang Mauerer
+ *
+ * Copyright (C) 2010 Wolfgang Mauerer <wolfgang.mauerer@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <nucleus/types.h>
+#ifdef __KERNEL__
+#include <asm-generic/xenomai/system.h>
+#else /* !__KERNEL__ */
+#include <time.h>
+#include <sys/types.h>
+#include <nucleus/seqlock_user.h>
+typedef u_int32_t u32;
+typedef u_int64_t cycle_t;
+
+/*
+ * xnarch_hostrt_data must be kept in sync with the corresponding ipipe
+ * definitions in ipipe_tickdev.h We cannot directly include the file
+ * here because the definitions are also required in Xenomai userland.
+ */
+struct xnarch_hostrt_data {
+	short live;
+	seqcount_t seqcount;
+	time_t wall_time_sec;
+	u32 wall_time_nsec;
+	struct timespec wall_to_monotonic;
+	cycle_t cycle_last;
+	cycle_t mask;
+	u32 mult;
+	u32 shift;
+};
+#endif /* !__KERNEL__ */
+
+#endif
diff --git a/include/nucleus/vdso.h b/include/nucleus/vdso.h
index c431f88..bce4c5a 100644
--- a/include/nucleus/vdso.h
+++ b/include/nucleus/vdso.h
@@ -24,6 +24,7 @@
  */
 
 #include <nucleus/types.h>
+#include <nucleus/hostrt.h>
 
 /*
  * Data shared between Xenomai kernel/userland and the Linux kernel/userland
@@ -33,8 +34,11 @@
 struct xnvdso {
 	unsigned long long features;
 
-	/* Embed domain specific structures that describe the
-	 * shared data here */
+	struct xnarch_hostrt_data hostrt_data;
+	/*
+	 * Embed further domain specific structures that
+	 * describe the shared data here
+	 */
 };
 
 /*
@@ -48,10 +52,20 @@ struct xnvdso {
 #define XNVDSO_FEATURES	(XNVDSO_FEAT_A | XNVDSO_FEAT_B | XVDSO_FEAT_C)
 */
 #define XNVDSO_FEAT_DROP_U_MODE 0x0000000000000001ULL
-#define XNVDSO_FEATURES (XNVDSO_FEAT_DROP_U_MODE)
+#define XNVDSO_FEAT_HOST_REALTIME	0x0000000000000002ULL
+#ifdef CONFIG_XENO_OPT_HOSTRT
+#define XNVDSO_FEATURES (XNVDSO_FEAT_DROP_U_MODE | XNVDSO_FEAT_HOST_REALTIME)
+#else
+#define XNVDSO_FEATURES XNVDSO_FEAT_DROP_U_MODE
+#endif /* CONFIG_XENO_OPT_HOSTRT */
 
 extern struct xnvdso *nkvdso;
 
+static inline struct xnarch_hostrt_data *get_hostrt_data(void)
+{
+	return &nkvdso->hostrt_data;
+}
+
 static inline int xnvdso_test_feature(unsigned long long feature)
 {
 	return testbits(nkvdso->features, feature);
diff --git a/ksrc/nucleus/Kconfig b/ksrc/nucleus/Kconfig
index 211a4ad..3724e68 100644
--- a/ksrc/nucleus/Kconfig
+++ b/ksrc/nucleus/Kconfig
@@ -355,6 +355,10 @@ config XENO_OPT_SHIRQ
 config XENO_OPT_SELECT
 	bool
 
+config XENO_OPT_HOSTRT
+       depends on IPIPE_HOSTRT
+       def_bool y
+
 menu "Timing"
 
 config XENO_OPT_TIMING_PERIODIC
diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
index 84cec06..3f962ba 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -35,11 +35,66 @@
 #endif /* CONFIG_XENO_OPT_PIPE */
 #include <nucleus/select.h>
 #include <asm/xenomai/bits/init.h>
-#ifdef CONFIG_XENO_OPT_PERVASIVE
+#include <asm/xenomai/hal.h>
 #include <nucleus/vdso.h>
+
+#ifndef CONFIG_XENO_OPT_PERVASIVE
+/*
+ * We need an instance of struct xnvdso even in the non-pervasive case,
+ * for example to implement hostrt support.
+ */
+static struct xnvdso static_nkvdso;
+struct xnvdso *nkvdso;
+EXPORT_SYMBOL_GPL(nkvdso);
+
+void __init xnheap_init_vdso(void)
+{
+	static_nkvdso.features = XNVDSO_FEATURES;
+	nkvdso = &static_nkvdso;
+}
+#endif /* !CONFIG_XENO_OPT_PERVASIVE */
+
+#ifdef CONFIG_XENO_OPT_HOSTRT
+static IPIPE_DEFINE_SPINLOCK(__hostrtlock);
+
+static inline void do_hostrt_event(struct xnarch_hostrt_data *hostrt)
+{
+	unsigned long flags;
+
+	/*
+	 * The locking strategy is twofold:
+	 * - The spinlock protects against concurrent updates from within the
+	 *   Linux kernel and against preemption by Xenomai
+	 * - The sequence counter is for lockless read-only access.
+	 */
+
+	spin_lock_irqsave(&__hostrtlock, flags);
+	write_seqcount_begin(&nkvdso->hostrt_data.seqcount);
+
+	nkvdso->hostrt_data.live = 1;
+	nkvdso->hostrt_data.cycle_last = hostrt->cycle_last;
+	nkvdso->hostrt_data.mask = hostrt->mask;
+	nkvdso->hostrt_data.mult = hostrt->mult;
+	nkvdso->hostrt_data.shift = hostrt->shift;
+	nkvdso->hostrt_data.wall_time_sec = hostrt->wall_time_sec;
+	nkvdso->hostrt_data.wall_time_nsec = hostrt->wall_time_nsec;
+	nkvdso->hostrt_data.wall_to_monotonic = hostrt->wall_to_monotonic;
+
+	write_seqcount_end(&nkvdso->hostrt_data.seqcount);
+	spin_unlock_irqrestore(&__hostrtlock, flags);
+}
+
+RTHAL_DECLARE_HOSTRT_EVENT(hostrt_event);
+
+static inline void init_hostrt(void)
+{
+	seqcount_init(&nkvdso->hostrt_data.seqcount);
+	nkvdso->hostrt_data.live = 0;
+	rthal_catch_hostrt(&hostrt_event);
+}
 #else
-static inline void xnheap_init_vdso(void) { }
-#endif /* CONFIG_XENO_OPT_PERVASIVE */
+static inline void init_hostrt(void) { }
+#endif /* CONFIG_XENO_OPT_HOSTRT */
 
 MODULE_DESCRIPTION("Xenomai nucleus");
 MODULE_AUTHOR("rpm@xenomai.org");
@@ -113,7 +168,8 @@ int __init __xeno_sys_init(void)
 	xnheap_set_label(&__xnsys_global_ppd.sem_heap, "global sem heap");
 
 	xnheap_init_vdso();
-#endif
+	init_hostrt();
+#endif /* !__XENO_SIM__ */
 	
 #ifdef __KERNEL__
 	xnpod_mount();
-- 
1.6.4


