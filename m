From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 01/12] rtdm: Harden key services against invocations with
 disabled core
Date: Fri, 13 Sep 2019 18:46:44 +0200
Message-Id: <53c06b19f5b1d5738f70ed1a4399784d4b326e71.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We already have check in rtdm_dev_register, but drivers (such as RTnet)
may call other services without checking the core state. Then we risk
crashes, rather than simple errors.

Also guard destroy functions that do __rtdm_synch_flush etc. because the
corresponding init functions are trivial and do not return an error.
This avoid problems when a driver rolls back because another service
reported a disabled core.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/driver.h | 12 ++----------
 kernel/cobalt/rtdm/device.c         |  2 +-
 kernel/cobalt/rtdm/drvlib.c         | 37 +++++++++++++++++++++++++++++--------
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 72f75388da..ceec24467d 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -956,16 +956,8 @@ enum rtdm_timer_mode {
 
 /** @} rtdm_timer */
 
-#ifndef DOXYGEN_CPP /* Avoid broken doxygen output */
-#define rtdm_timer_init(timer, handler, name)				\
-({									\
-	xntimer_init((timer), &nkclock, handler,			\
-		     NULL, XNTIMER_IGRAVITY);				\
-	xntimer_set_name((timer), (name));				\
-	0;								\
-})
-
-#endif /* !DOXYGEN_CPP */
+int rtdm_timer_init(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
+		    const char *name);
 
 void rtdm_timer_destroy(rtdm_timer_t *timer);
 
diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 4cfdb1c5b1..8fe0ed7355 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -380,7 +380,7 @@ static void unregister_driver(struct rtdm_driver *drv)
  * - -EAGAIN is returned if no registry slot is available (check/raise
  * CONFIG_XENO_OPT_REGISTRY_NRSLOTS).
  *
- * - -ENOSYS is returned if cobalt is disabled
+ * - -ENOSYS is returned if the real-time core is disabled.
  *
  * - -ENXIO is returned if no valid minor could be assigned
  *
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 316d87b29d..5dadf3575e 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -114,6 +114,9 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
 	struct xnthread_init_attr iattr;
 	int err;
 
+	if (!realtime_core_enabled())
+		return -ENOSYS;
+
 	iattr.name = name;
 	iattr.flags = 0;
 	iattr.personality = &xenomai_personality;
@@ -500,7 +503,6 @@ EXPORT_SYMBOL_GPL(rtdm_task_busy_sleep);
  * @{
  */
 
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Initialise a timer
  *
@@ -513,8 +515,17 @@ EXPORT_SYMBOL_GPL(rtdm_task_busy_sleep);
  * @coretags{task-unrestricted}
  */
 int rtdm_timer_init(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
-		    const char *name);
-#endif /* DOXYGEN_CPP */
+		    const char *name)
+{
+	if (!realtime_core_enabled())
+		return -ENOSYS;
+
+	xntimer_init((timer), &nkclock, handler, NULL, XNTIMER_IGRAVITY);
+	xntimer_set_name((timer), (name));
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rtdm_timer_init);
 
 /**
  * @brief Destroy a timer
@@ -747,8 +758,10 @@ EXPORT_SYMBOL_GPL(rtdm_event_init);
 void rtdm_event_destroy(rtdm_event_t *event)
 {
 	trace_cobalt_driver_event_destroy(event);
-	__rtdm_synch_flush(&event->synch_base, XNRMID);
-	xnselect_destroy(&event->select_block);
+	if (realtime_core_enabled()) {
+		__rtdm_synch_flush(&event->synch_base, XNRMID);
+		xnselect_destroy(&event->select_block);
+	}
 }
 EXPORT_SYMBOL_GPL(rtdm_event_destroy);
 
@@ -1031,8 +1044,10 @@ EXPORT_SYMBOL_GPL(rtdm_sem_init);
 void rtdm_sem_destroy(rtdm_sem_t *sem)
 {
 	trace_cobalt_driver_sem_destroy(sem);
-	__rtdm_synch_flush(&sem->synch_base, XNRMID);
-	xnselect_destroy(&sem->select_block);
+	if (realtime_core_enabled()) {
+		__rtdm_synch_flush(&sem->synch_base, XNRMID);
+		xnselect_destroy(&sem->select_block);
+	}
 }
 EXPORT_SYMBOL_GPL(rtdm_sem_destroy);
 
@@ -1261,7 +1276,8 @@ void rtdm_mutex_destroy(rtdm_mutex_t *mutex)
 {
 	trace_cobalt_driver_mutex_destroy(mutex);
 
-	__rtdm_synch_flush(&mutex->synch_base, XNRMID);
+	if (realtime_core_enabled())
+		__rtdm_synch_flush(&mutex->synch_base, XNRMID);
 }
 EXPORT_SYMBOL_GPL(rtdm_mutex_destroy);
 
@@ -1418,6 +1434,8 @@ EXPORT_SYMBOL_GPL(rtdm_mutex_timedlock);
  *
  * - -EBUSY is returned if the specified IRQ line is already in use.
  *
+ * - -ENOSYS is returned if the real-time core is disabled.
+ *
  * @coretags{secondary-only}
  */
 int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
@@ -1426,6 +1444,9 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 {
 	int err;
 
+	if (!realtime_core_enabled())
+		return -ENOSYS;
+
 	if (!XENO_ASSERT(COBALT, xnsched_root_p()))
 		return -EPERM;
 
-- 
2.16.4


