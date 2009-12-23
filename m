From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Wed, 23 Dec 2009 10:25:51 +0100
Message-Id: <1261560352-9120-2-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1261560352-9120-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1261560352-9120-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 1/2] Add support for sharing kernel/userland
	data between Xenomai and Linux
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

A new structure (struct xnshared) is introduced. It allows us to share
generic data between user and kernel of Linux and Xenomai; a bitmap
of feature flags located at the beginning of the structure identifies
which data are shared. The structure is allocated in the global semaphore
heap, and xnsysinfo.xnshared_offset identifies the offset of the
structure within the heap.

Currently, no shared features are yet supported - the patch only
introduces the necessary ABI changes. When the need arises
to share data between said entities, the structure must
be accordingly extended, and a new feature bit must be added
to the flags.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/syscall.h |    1 +
 include/nucleus/Makefile.am   |    3 +-
 include/nucleus/xnvdso.h      |   61 +++++++++++++++++++++++++++++++++++++++++
 ksrc/nucleus/module.c         |    7 +++++
 ksrc/nucleus/shadow.c         |   22 +++++++++++++++
 5 files changed, 93 insertions(+), 1 deletions(-)
 create mode 100644 include/nucleus/xnvdso.h

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 483b99f..8f1ddc6 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -53,6 +53,7 @@
 typedef struct xnsysinfo {
 	unsigned long long cpufreq;	/* CPU frequency */
 	unsigned long tickval;		/* Tick duration (ns) */
+	unsigned long xnvdso_off;  	/* Offset of xnvdso in the sem heap */
 } xnsysinfo_t;
 
 #define SIGSHADOW  SIGWINCH
diff --git a/include/nucleus/Makefile.am b/include/nucleus/Makefile.am
index 4be05f8..26d3fa2 100644
--- a/include/nucleus/Makefile.am
+++ b/include/nucleus/Makefile.am
@@ -34,4 +34,5 @@ includesub_HEADERS = \
 	trace.h \
 	types.h \
 	version.h \
-	xenomai.h
+	xenomai.h \
+	xnvdso.h
diff --git a/include/nucleus/xnvdso.h b/include/nucleus/xnvdso.h
new file mode 100644
index 0000000..fbff8fa
--- /dev/null
+++ b/include/nucleus/xnvdso.h
@@ -0,0 +1,61 @@
+#ifndef _XENO_NUCLEUS_XNVDSO_H
+#define _XENO_NUCLEUS_XNVDSO_H
+
+/*!\file xnvdso.h
+ * \brief Definitions for global semaphore heap shared objects
+ * \author Wolfgang Mauerer
+ *
+ * Copyright (C) 2009 Wolfgang Mauerer <wolfgang.mauerer@domain.hid>.
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
+
+/*
+ * Data shared between Xenomai kernel/userland and the Linux kernel/userland
+ * on the global semaphore heap. The features element indicates which data are
+ * shared. Notice that struct xnvdso may only grow, but never shrink.
+ */
+struct xnvdso {
+	unsigned long long features;
+
+	/* Embed domain specific structures that describe the
+	 * shared data here */
+};
+
+/*
+ * For each shared feature, add a flag below. For now, the set is still
+ * empty.
+ */
+/*
+#define XNVDSO_FEAT_A	0x0000000000000001
+#define XNVDSO_FEAT_B	0x0000000000000002
+#define XNVDSO_FEAT_C	0x0000000000000004
+#define XNVDSO_FEATURES	(XNVDSO_FEAT_A | XNVDSO_FEAT_B | XVDSO_FEAT_C)
+*/
+
+#define XNVDSO_FEATURES 0x0000000000000000
+
+extern struct xnvdso *xnvdso;
+
+static inline int xnvdso_test_feature(unsigned long long feature)
+{
+	return testbits(xnvdso->features, feature);
+}
+
+extern void xnheap_init_vdso(void);
+#endif /* _XENO_NUCLEUS_XNVDSO_H */
diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
index 5404182..0a17661 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -35,6 +35,11 @@
 #endif /* CONFIG_XENO_OPT_PIPE */
 #include <nucleus/select.h>
 #include <asm/xenomai/bits/init.h>
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+#include <nucleus/xnvdso.h>
+#else
+static inline void xnheap_init_vdso(void) { }
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
 
 MODULE_DESCRIPTION("Xenomai nucleus");
 MODULE_AUTHOR("rpm@xenomai.org");
@@ -106,6 +111,8 @@ int __init __xeno_sys_init(void)
 		goto cleanup_arch;
 
 	xnheap_set_label(&__xnsys_global_ppd.sem_heap, "global sem heap");
+
+	xnheap_init_vdso();
 #endif
 	
 #ifdef __KERNEL__
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index d0cb416..bff7dc5 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -50,6 +50,7 @@
 #include <nucleus/trace.h>
 #include <nucleus/stat.h>
 #include <nucleus/sys_ppd.h>
+#include <nucleus/xnvdso.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/bits/shadow.h>
@@ -693,6 +694,24 @@ void xnshadow_clear_sig(xnthread_t *thread, unsigned muxid)
 }
 EXPORT_SYMBOL_GPL(xnshadow_clear_sig);
 
+struct xnvdso *xnvdso;
+EXPORT_SYMBOL_GPL(xnvdso);
+
+/*
+ * We re-use the global semaphore heap to provide a multi-purpose shared
+ * memory area between Xenomai and Linux - for both kernel and userland
+ */
+void __init xnheap_init_vdso(void)
+{
+	xnvdso = (struct xnvdso *)xnheap_alloc(&__xnsys_global_ppd.sem_heap,
+						  sizeof(*xnvdso));
+
+	if (!xnvdso)
+		xnpod_fatal("Xenomai: cannot allocate memory for xnvdso!\n");
+
+	xnvdso->features = XNVDSO_FEATURES;
+}
+
 static inline void handle_rt_signals(xnthread_t *thread,
 				     struct pt_regs *regs,
 				     int sysflags)
@@ -1746,6 +1765,9 @@ static int xnshadow_sys_info(struct pt_regs *regs)
 
 	info.cpufreq = xnarch_get_cpu_freq();
 
+	info.xnvdso_off =
+	  xnheap_mapped_offset(&xnsys_ppd_get(1)->sem_heap, xnvdso);
+
 	return __xn_safe_copy_to_user((void __user *)infarg, &info, sizeof(info));
 }
 
-- 
1.6.4


