From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Mon,  1 Aug 2011 22:20:16 +0200
Message-Id: <1312230016-21196-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] [RFC] heap: rename sys_sem_heap syscall to
	sys_heap_info
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

And add the count of used bytes to the xnheap_desc structure. This allows
for checking for leaks in unit tests.
---
 include/asm-generic/syscall.h |    2 +-
 include/nucleus/heap.h        |    7 +++++++
 ksrc/nucleus/shadow.c         |   31 ++++++++++++++++++++++++++-----
 src/skins/common/sem_heap.c   |    4 ++--
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 4154b46..a9cdc87 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -32,7 +32,7 @@
 #define __xn_sys_info		4	/* xnshadow_get_info(muxid,&info) */
 #define __xn_sys_arch		5	/* r = xnarch_local_syscall(args) */
 #define __xn_sys_trace		6	/* r = xntrace_xxx(...) */
-#define __xn_sys_sem_heap	7
+#define __xn_sys_heap_info	7
 #define __xn_sys_current	8	/* threadh = xnthread_handle(cur) */
 #define __xn_sys_current_info	9	/* r = xnshadow_current_info(&info) */
 #define __xn_sys_mayday        10	/* request mayday fixup */
diff --git a/include/nucleus/heap.h b/include/nucleus/heap.h
index 253dca3..53b3bb4 100644
--- a/include/nucleus/heap.h
+++ b/include/nucleus/heap.h
@@ -281,10 +281,17 @@ int xnheap_check_block(xnheap_t *heap,
 #define XNHEAP_DEV_NAME  "/dev/rtheap"
 #define XNHEAP_DEV_MINOR 254
 
+/* Possible arguments to the sys_heap_info syscall */
+#define XNHEAP_PROC_PRIVATE_HEAP 0
+#define XNHEAP_PROC_SHARED_HEAP  1
+#define XNHEAP_SYS_HEAP          2
+#define XNHEAP_SYS_STACKPOOL     3
+
 struct xnheap_desc {
 	unsigned long handle;
 	unsigned int size;
 	unsigned long area;
+	unsigned long used;
 };
 
 #endif /* !_XENO_NUCLEUS_HEAP_H */
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index a228c91..bd0096f 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2052,18 +2052,39 @@ static int xnshadow_sys_trace(struct pt_regs *regs)
 	return err;
 }
 
-static int xnshadow_sys_sem_heap(struct pt_regs *regs)
+static int xnshadow_sys_heap_info(struct pt_regs *regs)
 {
 	struct xnheap_desc hd, __user *u_hd;
 	struct xnheap *heap;
-	unsigned global;
+	unsigned heap_nr;
 
-	global = __xn_reg_arg2(regs);
+	heap_nr = __xn_reg_arg2(regs);
 	u_hd = (struct xnheap_desc __user *)__xn_reg_arg1(regs);
-	heap = &xnsys_ppd_get(global)->sem_heap;
+
+	switch(heap_nr) {
+	case XNHEAP_PROC_PRIVATE_HEAP:
+	case XNHEAP_PROC_SHARED_HEAP:
+		heap = &xnsys_ppd_get(heap_nr)->sem_heap;
+		break;
+
+	case XNHEAP_SYS_HEAP:
+		heap = &kheap;
+		break;
+
+#if CONFIG_XENO_OPT_SYS_STACKPOOLSZ > 0
+	case XNHEAP_SYS_STACKPOOL:
+		heap = &kstacks;
+		break;
+#endif
+
+	default:
+		return -EINVAL;
+	}
+
 	hd.handle = (unsigned long)heap;
 	hd.size = xnheap_extentsize(heap);
 	hd.area = xnheap_base_memory(heap);
+	hd.used = xnheap_used_mem(heap);
 
 	return __xn_safe_copy_to_user(u_hd, &hd, sizeof(*u_hd));
 }
@@ -2122,7 +2143,7 @@ static xnsysent_t __systab[] = {
 	[__xn_sys_completion] = {&xnshadow_sys_completion, __xn_exec_lostage},
 	[__xn_sys_barrier] = {&xnshadow_sys_barrier, __xn_exec_lostage},
 	[__xn_sys_trace] = {&xnshadow_sys_trace, __xn_exec_any},
-	[__xn_sys_sem_heap] = {&xnshadow_sys_sem_heap, __xn_exec_lostage},
+	[__xn_sys_heap_info] = {&xnshadow_sys_heap_info, __xn_exec_lostage},
 	[__xn_sys_current] = {&xnshadow_sys_current, __xn_exec_any},
 	[__xn_sys_current_info] =
 		{&xnshadow_sys_current_info, __xn_exec_shadow},
diff --git a/src/skins/common/sem_heap.c b/src/skins/common/sem_heap.c
index 2c9514e..baaa6a6 100644
--- a/src/skins/common/sem_heap.c
+++ b/src/skins/common/sem_heap.c
@@ -57,10 +57,10 @@ static void *map_sem_heap(unsigned int shared)
 	int ret;
 
 	hdesc = shared ? &global_hdesc : &private_hdesc;
-	ret = XENOMAI_SYSCALL2(__xn_sys_sem_heap, hdesc, shared);
+	ret = XENOMAI_SYSCALL2(__xn_sys_heap_info, hdesc, shared);
 	if (ret < 0) {
 		errno = -ret;
-		perror("Xenomai: sys_sem_heap");
+		perror("Xenomai: sys_heap_info");
 		return MAP_FAILED;
 	}
 
-- 
1.7.2.5


