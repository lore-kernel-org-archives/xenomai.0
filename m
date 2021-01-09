From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2] cobalt/clock: pipeline: make HOSTRT depend on IPIPE
Date: Sat,  9 Jan 2021 11:48:33 +0100
Message-Id: <20210109104833.706898-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

This interface is pointless with Dovetail whose applications directly
refer to the wallclock time exported through the common vDSO.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/vdso.h  | 18 +++++++++++-------
 kernel/cobalt/Kconfig         |  4 ----
 kernel/cobalt/ipipe/kevents.c | 14 ++++++++------
 kernel/cobalt/posix/clock.c   |  4 ++--
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/cobalt/kernel/vdso.h b/include/cobalt/kernel/vdso.h
index f7140adc7..7da88a730 100644
--- a/include/cobalt/kernel/vdso.h
+++ b/include/cobalt/kernel/vdso.h
@@ -25,21 +25,25 @@
 #include <asm/processor.h>
 #include <cobalt/uapi/kernel/vdso.h>
 
+extern struct xnvdso *nkvdso;
+
 /*
  * Define the available feature set here. We have a single feature
- * defined for now.
+ * defined for now, only in the I-pipe case.
  */
-#ifdef CONFIG_XENO_OPT_HOSTRT
-#define XNVDSO_FEATURES XNVDSO_FEAT_HOST_REALTIME
-#else
-#define XNVDSO_FEATURES 0
-#endif /* CONFIG_XENO_OPT_HOSTRT */
+#ifdef CONFIG_IPIPE_HAVE_HOSTRT
 
-extern struct xnvdso *nkvdso;
+#define XNVDSO_FEATURES XNVDSO_FEAT_HOST_REALTIME
 
 static inline struct xnvdso_hostrt_data *get_hostrt_data(void)
 {
 	return &nkvdso->hostrt_data;
 }
 
+#else
+
+#define XNVDSO_FEATURES 0
+
+#endif
+
 #endif /* _COBALT_KERNEL_VDSO_H */
diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index 0d96913bd..ead4740c1 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -210,10 +210,6 @@ config XENO_OPT_TIMER_RBTREE
 
 endchoice
 
-config XENO_OPT_HOSTRT
-       depends on IPIPE_HAVE_HOSTRT
-       def_bool y
-
 config XENO_OPT_PIPE
 	bool
 
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index 620975dfd..e1e1e3a95 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -378,7 +378,7 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 	xnsched_run();
 }
 
-#ifdef CONFIG_XENO_OPT_HOSTRT
+#ifdef CONFIG_IPIPE_HAVE_HOSTRT
 
 static IPIPE_DEFINE_SPINLOCK(__hostrtlock);
 
@@ -418,7 +418,7 @@ static inline void init_hostrt(void)
 	nkvdso->hostrt_data.live = 0;
 }
 
-#else /* !CONFIG_XENO_OPT_HOSTRT */
+#else /* !CONFIG_IPIPE_HAVE_HOSTRT */
 
 struct ipipe_hostrt_data;
 
@@ -429,7 +429,7 @@ static inline int handle_hostrt_event(struct ipipe_hostrt_data *hostrt)
 
 static inline void init_hostrt(void) { }
 
-#endif /* !CONFIG_XENO_OPT_HOSTRT */
+#endif /* !CONFIG_IPIPE_HAVE_HOSTRT */
 
 static void __handle_taskexit_event(struct task_struct *p)
 {
@@ -757,12 +757,14 @@ int ipipe_kevent_hook(int kevent, void *data)
 	case IPIPE_KEVT_CLEANUP:
 		ret = handle_cleanup_event(data);
 		break;
-	case IPIPE_KEVT_HOSTRT:
-		ret = handle_hostrt_event(data);
-		break;
 	case IPIPE_KEVT_SETAFFINITY:
 		ret = handle_setaffinity_event(data);
 		break;
+#ifdef CONFIG_IPIPE_HAVE_HOSTRT
+	case IPIPE_KEVT_HOSTRT:
+		ret = handle_hostrt_event(data);
+		break;
+#endif
 #ifdef IPIPE_KEVT_CLOCKFREQ
 	case IPIPE_KEVT_CLOCKFREQ:
 		ret = handle_clockfreq_event(data);
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 561358e74..40271f3ed 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -31,7 +31,7 @@ DECLARE_BITMAP(cobalt_clock_extids, COBALT_MAX_EXTCLOCKS);
 
 static int do_clock_host_realtime(struct timespec *tp)
 {
-#ifdef CONFIG_XENO_OPT_HOSTRT
+#ifdef CONFIG_IPIPE_HAVE_HOSTRT
 	struct xnvdso_hostrt_data *hostrt_data;
 	u64 now, base, mask, cycle_delta;
 	__u32 mult, shift;
@@ -78,7 +78,7 @@ static int do_clock_host_realtime(struct timespec *tp)
 	tp->tv_nsec = rem;
 
 	return 0;
-#else /* CONFIG_XENO_OPT_HOSTRT */
+#else
 	return -EINVAL;
 #endif
 }
-- 
2.26.2


