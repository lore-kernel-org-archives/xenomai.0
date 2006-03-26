Message-ID: <44267889.8040301@domain.hid>
Date: Sun, 26 Mar 2006 13:18:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] CONFIG_XENO_OPT_DEBUG_LEVEL
References: <441EFB6D.8000507@domain.hid>
	<441F1675.1010703@domain.hid>	<441F3BE9.5010409@domain.hid>
	<441FB2F3.8090202@domain.hid>
In-Reply-To: <441FB2F3.8090202@domain.hid>
Content-Type: multipart/mixed; boundary="------------020301060302030606070107"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020301060302030606070107
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Hi,
>>>>
>>>> as I started to actually use XENO_ASSERT, I noticed that there is no
>>>> infrastructure yet to enable it. CONFIG_XENO_OPT_DEBUG_LEVEL is nowhere
>>>> defined. Add this as integer to Kconfig? Or better convert
>>>> nucleus/assert.h to CONFIG_OPT_DEBUG for now until we really feel like
>>>> we need more than on/off for this? I would vote for the latter ATM.
>>>
>>> Actually, we already need more than a simple switch: I'd really like the
>>> queue debugging option to become a level on its own (say, 4294967295?).
>>> I'll add this tomorrow.
>>
>>
>> Hmm, raises my old concern again: this "vertical" debugging implies to
>> switch everything on when you only want queue debugging. I still think
>> we rather need "horizontal" control: switch on queues, asserts, ...
> 
> It just depends whether we want to make the assertion mechanism a
> formalized exported feature or not. If there is a limited number of
> "clients", the simpler the better. This said, implementing sub-system
> debug switches instead of global debug levels would still be pretty
> trivial, provided we keep the number of sub-systems within reasonable
> limits (e.g. <= 64).
> 

Here is an attempt to base the activation of XENO_ASSERT on a subsystem
debug switch at compile time, applied on RTDM.

The procedure of adding a new system for XENO_ASSERT usage would be to
define the required kbuild switch according to the naming scheme
CONFIG_XENO_OPT_DEBUG_subsystem, include nucleus/assert.h, and add
"#define CONFIG_XENO_OPT_DEBUG_subsystem 0" for the unset case.
XENO_ASSERT is new called with (subsystem, condition, action). If we
invent further debugging macros, they could be controlled in a similar way.

What do you think?

Jan

--------------020301060302030606070107
Content-Type: text/plain;
 name="rtdm-asserts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtdm-asserts.patch"

Index: include/rtdm/rtdm_driver.h
===================================================================
--- include/rtdm/rtdm_driver.h	(Revision 793)
+++ include/rtdm/rtdm_driver.h	(Arbeitskopie)
@@ -40,6 +40,13 @@
 #include <nucleus/synch.h>
 #include <rtdm/rtdm.h>
 
+/* debug support */
+#include <nucleus/assert.h>
+
+#ifndef CONFIG_XENO_OPT_DEBUG_RTDM
+#define CONFIG_XENO_OPT_DEBUG_RTDM  0
+#endif
+
 
 struct rtdm_dev_context;
 
@@ -891,6 +898,7 @@ static inline rtdm_task_t *rtdm_task_cur
 
 static inline int rtdm_task_wait_period(void)
 {
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
     return xnpod_wait_thread_period(NULL);
 }
 
Index: include/nucleus/assert.h
===================================================================
--- include/nucleus/assert.h	(Revision 793)
+++ include/nucleus/assert.h	(Arbeitskopie)
@@ -22,20 +22,12 @@
 
 #include <nucleus/compiler.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_LEVEL
-#define CONFIG_XENO_OPT_DEBUG_LEVEL  0
-#endif
-
-#if CONFIG_XENO_OPT_DEBUG_LEVEL > 0
-#define XENO_ASSERT(cond,action)  do { \
-if (unlikely((cond) != 0)) \
+#define XENO_ASSERT(subsystem,cond,action)  do { \
+if (unlikely(CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && !(cond))) \
 	do { action; } while(0); \
 } while(0)
-#else  /* CONFIG_XENO_OPT_DEBUG_LEVEL == 0 */
-#define XENO_ASSERT(cond,action) do { } while(0)
-#endif /* CONFIG_XENO_OPT_DEBUG_LEVEL > 0 */
 
-#define XENO_BUGON(cond)  \
-    XENO_ASSERT(cond,xnpod_fatal("assertion failed at %s:%d",__FILE__,__LINE__))
+#define XENO_BUGON(subsystem,cond)  \
+    XENO_ASSERT(subsystem,cond,xnpod_fatal("assertion failed at %s:%d",__FILE__,__LINE__))
 
 #endif /* !_XENO_NUCLEUS_ASSERT_H */
Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 793)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,13 @@
+2006-03-26  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/include/nucleus/assert.h: XENO_ASSERT with built-in
+	activation at compile time.
+
+	* ksrc/skins/rtdm/Kconfig, ksrc/skins/rtdm/Config.in,
+	ksrc/skins/rtdm/drvlib.c, include/rtdm/rtdm_driver.h: Use
+	XENO_ASSERT to check for correct RTDM driver API invocation
+	contexts.
+
 2006-03-24  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
 
 	* ksrc/nucleus/pod.c (xnpod_init): Return immediately with an
Index: ksrc/skins/rtdm/Kconfig
===================================================================
--- ksrc/skins/rtdm/Kconfig	(Revision 793)
+++ ksrc/skins/rtdm/Kconfig	(Arbeitskopie)
@@ -7,3 +7,12 @@ config XENO_SKIN_RTDM
 	This API skin allows to write real-time drivers against a common
 	light weight interface in kernel mode, but use them across all other
 	skins in both kernel and user mode.
+
+config XENO_OPT_DEBUG_RTDM
+    bool "RTDM Debugging support"
+    depends on XENO_OPT_DEBUG && XENO_SKIN_RTDM
+    help
+
+    This option activates debugging checks for the RTDM subsystem.
+    It is a recommended option for analysing potential issues in RTDM
+    drivers. A minor runtime overhead is added.
Index: ksrc/skins/rtdm/drvlib.c
===================================================================
--- ksrc/skins/rtdm/drvlib.c	(Revision 793)
+++ ksrc/skins/rtdm/drvlib.c	(Arbeitskopie)
@@ -279,6 +279,8 @@ void rtdm_task_join_nrt(rtdm_task_t *tas
     spl_t s;
 
 
+    XENO_ASSERT(RTDM, xnpod_root_p(), return;);
+
     xnlock_get_irqsave(&nklock, s);
 
     while (!xnthread_test_flags(task, XNZOMBIE)) {
@@ -305,6 +307,9 @@ EXPORT_SYMBOL(rtdm_task_join_nrt);
  * - -EINTR is returned if calling task has been unblock by a signal or
  * explicitely via rtdm_task_unblock().
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -319,6 +324,8 @@ int rtdm_task_sleep(uint64_t delay)
     xnthread_t  *thread = xnpod_current_thread();
 
 
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
     xnpod_suspend_thread(thread, XNDELAY, xnpod_ns2ticks(delay), NULL);
 
     return xnthread_test_flags(thread, XNBREAK) ? -EINTR : 0;
@@ -337,6 +344,9 @@ EXPORT_SYMBOL(rtdm_task_sleep);
  * - -EINTR is returned if calling task has been unblock by a signal or
  * explicitely via rtdm_task_unblock().
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -354,6 +364,8 @@ int rtdm_task_sleep_until(uint64_t wakeu
     int         err = 0;
 
 
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
 
     delay = xnpod_ns2ticks(wakeup_time) - xnpod_get_time();
@@ -626,6 +638,9 @@ EXPORT_SYMBOL(rtdm_event_signal);
  *
  * - -EIDRM is returned if @a event has been destroyed.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -641,6 +656,8 @@ int rtdm_event_wait(rtdm_event_t *event)
     int     err = 0;
 
 
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
 
     if (testbits(event->synch_base.status, SYNCH_DELETED))
@@ -689,6 +706,9 @@ EXPORT_SYMBOL(rtdm_event_wait);
  *
  * - -EIDRM is returned if @a event has been destroyed.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -706,6 +726,8 @@ int rtdm_event_timedwait(rtdm_event_t *e
     int         err = 0;
 
 
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
 
     if (unlikely(testbits(event->synch_base.status, SYNCH_DELETED)))
@@ -810,6 +832,9 @@ void rtdm_sem_destroy(rtdm_sem_t *sem);
  *
  * - -EIDRM is returned if @a sem has been destroyed.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -825,6 +850,8 @@ int rtdm_sem_down(rtdm_sem_t *sem)
     int     err = 0;
 
 
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
 
     if (testbits(sem->synch_base.status, SYNCH_DELETED))
@@ -878,6 +905,9 @@ EXPORT_SYMBOL(rtdm_sem_down);
  *
  * - -EIDRM is returned if @a sem has been destroyed.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -895,6 +925,8 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem, 
     int         err = 0;
 
 
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
 
     if (testbits(sem->synch_base.status, SYNCH_DELETED))
@@ -1035,6 +1067,9 @@ void rtdm_mutex_destroy(rtdm_mutex_t *mu
  *
  * - -EIDRM is returned if @a mutex has been destroyed.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -1050,6 +1085,8 @@ int rtdm_mutex_lock(rtdm_mutex_t *mutex)
     int     err = 0;
 
 
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
 
     if (testbits(mutex->synch_base.status, SYNCH_DELETED))
@@ -1097,6 +1134,9 @@ EXPORT_SYMBOL(rtdm_mutex_lock);
  *
  * - -EIDRM is returned if @a mutex has been destroyed.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -1114,6 +1154,8 @@ int rtdm_mutex_timedlock(rtdm_mutex_t *m
     int         err = 0;
 
 
+    XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
 
     if (testbits(mutex->synch_base.status, SYNCH_DELETED))
@@ -1179,6 +1221,8 @@ void rtdm_mutex_unlock(rtdm_mutex_t *mut
     spl_t s;
 
 
+    XENO_ASSERT(RTDM, !xnpod_asynch_p(), return;);
+
     xnlock_get_irqsave(&nklock, s);
 
     __clear_bit(0, &mutex->locked);
@@ -1426,6 +1470,9 @@ static struct file_operations rtdm_mmap_
  * - -EAGAIN is returned if too much memory has been already locked by the
  * user process.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * @note RTDM supports two models for unmapping the user memory range again.
  * One is explicite unmapping via rtdm_munmap(), either performed when the
  * user requests it via an IOCTL etc. or when the related device is closed.
@@ -1457,6 +1504,9 @@ int rtdm_mmap_to_user(rtdm_user_info_t *
     void                    *old_priv_data;
     void                    *user_ptr;
 
+
+    XENO_ASSERT(RTDM, xnpod_root_p(), return -EPERM;);
+
     filp = filp_open("/dev/zero", O_RDWR, 0);
     if (IS_ERR(filp))
         return PTR_ERR(filp);
@@ -1499,6 +1549,9 @@ EXPORT_SYMBOL(rtdm_mmap_to_user);
  *
  * - -EINVAL is returned if an invalid address or size was passed.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -1512,6 +1565,9 @@ int rtdm_munmap(rtdm_user_info_t *user_i
 {
     int err;
 
+
+    XENO_ASSERT(RTDM, xnpod_root_p(), return -EPERM;);
+
     down_write(&user_info->mm->mmap_sem);
     err = do_munmap(user_info->mm, (unsigned long)ptr, len);
     up_write(&user_info->mm->mmap_sem);
Index: ksrc/skins/rtdm/Config.in
===================================================================
--- ksrc/skins/rtdm/Config.in	(Revision 793)
+++ ksrc/skins/rtdm/Config.in	(Arbeitskopie)
@@ -3,3 +3,10 @@
 #
 
 dep_tristate 'Real-Time Driver Model' CONFIG_XENO_SKIN_RTDM $CONFIG_XENO_OPT_NUCLEUS
+
+if [ "$CONFIG_XENO_SKIN_RTDM" != "n" ]; then
+	mainmenu_option next_comment
+	comment 'RTDM interface options'
+	dep_bool 'Debugging support' CONFIG_XENO_OPT_DEBUG_RTDM $CONFIG_XENO_OPT_DEBUG
+	endmenu
+fi

--------------020301060302030606070107--

