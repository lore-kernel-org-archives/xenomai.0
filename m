From: wolfgang.mauerer@domain.hid
Date: Mon, 21 Dec 2009 17:01:00 +0100
Message-Id: <1261411260-839-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH] Add support for sharing kernel/userland data
	between Xenomai and Linux
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

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

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
 include/nucleus/xnshared.h    |   33 +++++++++++++++++++++++++++++++++
 ksrc/nucleus/module.c         |   23 +++++++++++++++++++++++
 ksrc/nucleus/shadow.c         |    4 ++++
 4 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 include/nucleus/xnshared.h

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 483b99f..7d68580 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -53,6 +53,7 @@
 typedef struct xnsysinfo {
 	unsigned long long cpufreq;	/* CPU frequency */
 	unsigned long tickval;		/* Tick duration (ns) */
+	unsigned long xnshared_offset;  /* Offset of xnshared in the sem heap */
 } xnsysinfo_t;
 
 #define SIGSHADOW  SIGWINCH
diff --git a/include/nucleus/xnshared.h b/include/nucleus/xnshared.h
new file mode 100644
index 0000000..4293cda
--- /dev/null
+++ b/include/nucleus/xnshared.h
@@ -0,0 +1,33 @@
+#ifndef XNSHARED_H
+#define XNSHARED_H
+
+/*
+ * Data shared between Xenomai kernel/userland and the Linux kernel/userland
+ * on the global semaphore heap. The features element indicates which data are
+ * shared. Notice that xnshared may only grow, but never shrink.
+ */
+struct xnshared {
+	unsigned long long features;
+
+	/* Embed domain specific structures that describe the
+	 * shared data here */
+};
+
+/*
+ * For each shared feature, add a flag below. For now, it is still
+ * empty.
+ */
+enum xnshared_features {
+/*	XNSHARED_FEAT_A = 1,
+	XNSHARED_FEAT_B, */
+	XNSHARED_MAX_FEATURES,
+};
+
+extern struct xnshared *xnshared;
+
+static inline int xnshared_test_feature(enum xnshared_features feature)
+{
+	return xnshared && xnshared->features & (1 << feature);
+}
+
+#endif
diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
index 5404182..3963fbd 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -34,6 +34,7 @@
 #include <nucleus/pipe.h>
 #endif /* CONFIG_XENO_OPT_PIPE */
 #include <nucleus/select.h>
+#include <nucleus/xnshared.h>
 #include <asm/xenomai/bits/init.h>
 
 MODULE_DESCRIPTION("Xenomai nucleus");
@@ -51,6 +52,9 @@ u_long xnmod_sysheap_size;
 
 int xeno_nucleus_status = -EINVAL;
 
+struct xnshared *xnshared;
+EXPORT_SYMBOL_GPL(xnshared);
+
 struct xnsys_ppd __xnsys_global_ppd;
 EXPORT_SYMBOL_GPL(__xnsys_global_ppd);
 
@@ -82,6 +86,23 @@ void xnmod_alloc_glinks(xnqueue_t *freehq)
 }
 EXPORT_SYMBOL_GPL(xnmod_alloc_glinks);
 
+/*
+ * We re-use the global semaphore heap to provide a multi-purpose shared
+ * memory area between Xenomai and Linux - for both kernel and userland
+ */
+void __init xnheap_init_shared(void)
+{
+	xnshared = (struct xnshared *)xnheap_alloc(&__xnsys_global_ppd.sem_heap,
+						  sizeof(struct xnshared));
+
+	if (!xnshared)
+		xnpod_fatal("Xenomai: cannot allocate memory for xnshared!\n");
+
+	/* Currently, we don't support any sharing, but later versions will
+	 * add flags here */
+	xnshared->features = 0ULL;
+}
+
 int __init __xeno_sys_init(void)
 {
 	int ret;
@@ -106,6 +127,8 @@ int __init __xeno_sys_init(void)
 		goto cleanup_arch;
 
 	xnheap_set_label(&__xnsys_global_ppd.sem_heap, "global sem heap");
+
+	xnheap_init_shared();
 #endif
 	
 #ifdef __KERNEL__
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 0c94a60..0373a8d 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -50,6 +50,7 @@
 #include <nucleus/trace.h>
 #include <nucleus/stat.h>
 #include <nucleus/sys_ppd.h>
+#include <nucleus/xnshared.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/bits/shadow.h>
@@ -1746,6 +1747,9 @@ static int xnshadow_sys_info(struct pt_regs *regs)
 
 	info.cpufreq = xnarch_get_cpu_freq();
 
+	info.xnshared_offset =
+	  xnheap_mapped_offset(&xnsys_ppd_get(1)->sem_heap, xnshared);
+
 	return __xn_safe_copy_to_user((void __user *)infarg, &info, sizeof(info));
 }
 
-- 
1.6.4


