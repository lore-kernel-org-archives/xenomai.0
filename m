From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:29:02 +0200
Message-Id: <326891e8af2eb5c6650a1184c6743496ad8fbb3b.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 22/25] Add legacy kernel support for
	delayed_work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Note that the kernel 2.4 version of schedule_delayed_work is not
universally usable.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/wrappers.h   |    3 +++
 include/compat/linux/workqueue.h |   13 +++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index d864397..7513781 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -192,6 +192,7 @@ do {									\
 #define DECLARE_WORK(n,f,d)      	struct tq_struct n = __WORK_INITIALIZER(n, f, d)
 #define DECLARE_WORK_NODATA(n, f)	DECLARE_WORK(n, f, NULL)
 #define DECLARE_WORK_FUNC(f)		void f(void *cookie)
+#define DECLARE_DELAYED_WORK_NODATA(n, f) DECLARE_WORK(n, f, NULL)
 
 /* Msleep is unknown before 2.4.28 */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,28)
@@ -436,9 +437,11 @@ unsigned long find_next_bit(const unsigned long *addr,
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,20)
 #define DECLARE_WORK_NODATA(f, n)	DECLARE_WORK(f, n, NULL)
 #define DECLARE_WORK_FUNC(f)		void f(void *cookie)
+#define DECLARE_DELAYED_WORK_NODATA(n, f) DECLARE_DELAYED_WORK(n, f, NULL)
 #else /* >= 2.6.20 */
 #define DECLARE_WORK_NODATA(f, n)	DECLARE_WORK(f, n)
 #define DECLARE_WORK_FUNC(f)		void f(struct work_struct *work)
+#define DECLARE_DELAYED_WORK_NODATA(n, f) DECLARE_DELAYED_WORK(n, f)
 #endif /* >= 2.6.20 */
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) */
diff --git a/include/compat/linux/workqueue.h b/include/compat/linux/workqueue.h
index 3ac37aa..6fad03c 100644
--- a/include/compat/linux/workqueue.h
+++ b/include/compat/linux/workqueue.h
@@ -28,4 +28,17 @@
 #define schedule_work(x)         schedule_task(x)
 #define flush_scheduled_work()   flush_scheduled_tasks()
 
+/*
+ * WARNING: This is not identical to 2.6 schedule_delayed_work as it delayes
+ * the caller to schedule the task after the specified delay. That's fine for
+ * our current use cases, though.
+ */
+#define schedule_delayed_work(work, delay) do {			\
+	if (delay) {						\
+		set_current_state(TASK_UNINTERRUPTIBLE);	\
+		schedule_timeout(delay);			\
+	}							\
+	schedule_task(work);					\
+} while (0)
+
 #endif /* _XENO_COMPAT_LINUX_WORKQUEUE_H */
-- 
1.6.0.2


