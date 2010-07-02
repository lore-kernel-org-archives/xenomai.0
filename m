From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Fri,  2 Jul 2010 13:49:10 +0200
Message-Id: <1278071353-13836-5-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 4/7] nucleus: Add CLOCK_HOST_REALTIME bits to
	nkvdso
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Augment the shared vdso page with all data required to
implement a clock CLOCK_HOST_REALTIME that provides time
information synchronised with the NTP-corrected time
in the Linux kernel.

The definition of the hostrt data is placed in a separate
head file so that we can use it irregardless of pervasive
rt support is compiled in or not.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/hal.h    |    2 +
 include/asm-generic/system.h |    4 ++
 include/asm-sim/system.h     |    4 ++
 include/nucleus/Makefile.am  |    1 +
 include/nucleus/hostrt.h     |   65 ++++++++++++++++++++++++++++++++++++++++++
 include/nucleus/vdso.h       |   16 ++++++++--
 ksrc/nucleus/Kconfig         |    4 ++
 ksrc/nucleus/module.c        |   25 ++++++++++++++++
 8 files changed, 118 insertions(+), 3 deletions(-)
 create mode 100644 include/nucleus/hostrt.h

diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index f90cafa..4203a3b 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -680,6 +680,8 @@ static inline int rthal_trace_panic_dump(void)
 
 #endif /* CONFIG_IPIPE_TRACE */
 
+#define rthal_set_hostrt_data	ipipe_set_hostrt_data
+#define rthal_hostrt_data	ipipe_hostrt_data
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index a2c8fb9..a4e278a 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -490,4 +490,8 @@ static inline void xnarch_hisyscall_entry(void)	{ }
 #define xnarch_post_graph(obj,state)
 #define xnarch_post_graph_if(obj,state,cond)
 
+/* Synchronised realtime clock*/
+#define xnarch_set_hostrt_data	rthal_set_hostrt_data
+#define xnarch_hostrt_data	rthal_hostrt_data
+
 #endif /* !_XENO_ASM_GENERIC_SYSTEM_H */
diff --git a/include/asm-sim/system.h b/include/asm-sim/system.h
index 1a5a875..56af408 100644
--- a/include/asm-sim/system.h
+++ b/include/asm-sim/system.h
@@ -598,4 +598,8 @@ static inline long IS_ERR(const void *ptr)
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
+/* Host realtime support is not supported in the simulator */
+#define xnarch_set_hostrt_data	{ }
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
index 0000000..5230165
--- /dev/null
+++ b/include/nucleus/hostrt.h
@@ -0,0 +1,65 @@
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
+#include <linux/time.h>
+#include <linux/ipipe_tickdev.h>
+#include <asm-generic/xenomai/system.h>
+
+#ifndef CONFIG_XENO_OPT_PERVASIVE
+extern struct xnarch_hostrt_data *nkhostrt_data;
+
+static inline struct xnarch_hostrt_data *get_hostrt_data(void)
+{
+	return nkhostrt_data;
+}
+#endif /* !CONFIG_XENO_OPT_PERVASIVE */
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
index 2343e5d..57f2ee7 100644
--- a/include/nucleus/vdso.h
+++ b/include/nucleus/vdso.h
@@ -28,6 +28,7 @@
 #endif
 
 #include <nucleus/types.h>
+#include <nucleus/hostrt.h>
 
 /*
  * Data shared between Xenomai kernel/userland and the Linux kernel/userland
@@ -37,8 +38,11 @@
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
@@ -52,10 +56,16 @@ struct xnvdso {
 #define XNVDSO_FEATURES	(XNVDSO_FEAT_A | XNVDSO_FEAT_B | XVDSO_FEAT_C)
 */
 #define XNVDSO_FEAT_DROP_U_MODE 0x0000000000000001ULL
-#define XNVDSO_FEATURES (XNVDSO_FEAT_DROP_U_MODE)
+#define XNVDSO_FEAT_HOST_REALTIME	0x0000000000000002ULL
+#define XNVDSO_FEATURES (XNVDSO_FEAT_DROP_U_MODE | XNVDSO_FEAT_HOST_REALTIME)
 
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
index 84cec06..8e5ad40 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -35,12 +35,28 @@
 #endif /* CONFIG_XENO_OPT_PIPE */
 #include <nucleus/select.h>
 #include <asm/xenomai/bits/init.h>
+
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 #include <nucleus/vdso.h>
 #else
 static inline void xnheap_init_vdso(void) { }
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
+#ifdef CONFIG_XENO_OPT_HOSTRT
+#include <nucleus/hostrt.h>
+
+#ifndef CONFIG_XENO_OPT_PERVASIVE
+struct xnarch_hostrt_data *nkhostrt_data;
+#endif
+
+static inline void init_hostrt(void)
+{
+	seqcount_init(&get_hostrt_data()->seqcount);
+	xnarch_set_hostrt_data(get_hostrt_data());
+}
+#else
+static inline void init_hostrt(void) { }
+#endif /* CONFIG_XENO_OPT_HOSTRT */
 MODULE_DESCRIPTION("Xenomai nucleus");
 MODULE_AUTHOR("rpm@xenomai.org");
 MODULE_LICENSE("GPL");
@@ -113,7 +129,16 @@ int __init __xeno_sys_init(void)
 	xnheap_set_label(&__xnsys_global_ppd.sem_heap, "global sem heap");
 
 	xnheap_init_vdso();
+
+#if defined(CONFIG_XENO_OPT_HOSTRT) && !defined(CONFIG_XENO_OPT_PERVASIVE)
+	nkhostrt_data = xnarch_alloc_host_mem(sizeof(struct xnarch_hostrt_data));
+	if (nkhostrt_data == NULL) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 #endif
+	init_hostrt();
+#endif /* !__XENO_SIM__ */
 	
 #ifdef __KERNEL__
 	xnpod_mount();
-- 
1.6.4


