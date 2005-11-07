Message-ID: <436F80EF.5020302@domain.hid>
Date: Mon, 07 Nov 2005 17:29:35 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig866D00A41169734F418D31D7"
Subject: [Xenomai-core] [PATCH] fixes, clarifications, cleanups for RTDM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig866D00A41169734F418D31D7
Content-Type: multipart/mixed; boundary="------------020602060307040709020204"

This is a multi-part message in MIME format.
--------------020602060307040709020204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

this patch
 o fixes a cleanup-on-error problem with rtdm_task_init()
 o moves this call into drvlib (i.e. de-inlines it)
 o gets rid of __u64 and __s64 usages in favour of uint64_t and int64_t
   (for consistent types in both kernel and user space)
 o tries to improve the documentation of rtdm_device.device_name and
   RTDM_EXECUTE_ATOMICALLY and
 o moves EXPORT_SYMBOLs to their related functions

Tested, caused no regressions so far. Please apply.

Jan

--------------020602060307040709020204
Content-Type: text/plain;
 name="rtdm_task_init_etc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm_task_init_etc.patch"

Index: skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/rtdm/drvlib.c	(revision 112)
+++ skins/rtdm/drvlib.c	(working copy)
@@ -58,7 +58,7 @@
  *
  * Rescheduling: never.
  */
-__u64 rtdm_clock_read(void);
+uint64_t rtdm_clock_read(void);
 #endif /* DOXYGEN_CPP */
 /** @} */
=20
@@ -69,7 +69,6 @@
  * @{
  */
=20
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Intialise and start a real-time task
  *
@@ -96,8 +95,40 @@
  */
 int rtdm_task_init(rtdm_task_t *task, const char *name,
                    rtdm_task_proc_t task_proc, void *arg,
-                   int priority, __u64 period);
+                   int priority, uint64_t period)
+{
+    int res;
=20
+
+    res =3D xnpod_init_thread(task, name, priority, 0, 0);
+    if (res)
+        goto error_out;
+
+    if (period !=3D XN_INFINITE) {
+        res =3D xnpod_set_thread_periodic(task, XN_INFINITE,
+                                        xnpod_ns2ticks(period));
+        if (res)
+            goto cleanup_out;
+    }
+
+    res =3D xnpod_start_thread(task, 0, 0, XNPOD_ALL_CPUS, task_proc, ar=
g);
+    if (res)
+        goto cleanup_out;
+
+    return res;
+
+
+ cleanup_out:
+    xnpod_delete_thread(task);
+
+ error_out:
+    return res;
+}
+
+EXPORT_SYMBOL(rtdm_task_init);
+
+
+#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy a real-time task
  *
@@ -153,7 +184,7 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_task_set_period(rtdm_task_t *task, __u64 period);
+int rtdm_task_set_period(rtdm_task_t *task, uint64_t period);
=20
 /**
  * @brief Wait on next real-time task period
@@ -246,7 +277,9 @@
     xnlock_put_irqrestore(&nklock, s);
 }
=20
+EXPORT_SYMBOL(rtdm_task_join_nrt);
=20
+
 /**
  * @brief Sleep a specified amount of time
  *
@@ -266,7 +299,7 @@
  *
  * Rescheduling: always.
  */
-int rtdm_task_sleep(__u64 delay)
+int rtdm_task_sleep(uint64_t delay)
 {
     xnthread_t  *thread =3D xnpod_current_thread();
=20
@@ -276,7 +309,9 @@
     return xnthread_test_flags(thread, XNBREAK) ? -EINTR : 0;
 }
=20
+EXPORT_SYMBOL(rtdm_task_sleep);
=20
+
 /**
  * @brief Sleep until a specified absolute time
  *
@@ -296,7 +331,7 @@
  *
  * Rescheduling: always, unless the specified time already passed.
  */
-int rtdm_task_sleep_until(__u64 wakeup_time)
+int rtdm_task_sleep_until(uint64_t wakeup_time)
 {
     xnthread_t  *thread =3D xnpod_current_thread();
     xnsticks_t  delay;
@@ -320,7 +355,9 @@
     return err;
 }
=20
+EXPORT_SYMBOL(rtdm_task_sleep_until);
=20
+
 /**
  * @brief Busy-wait a specified amount of time
  *
@@ -337,13 +374,15 @@
  *
  * Rescheduling: never.
  */
-void rtdm_task_busy_sleep(__u64 delay)
+void rtdm_task_busy_sleep(uint64_t delay)
 {
     xnticks_t wakeup =3D xnarch_get_cpu_tsc() + xnarch_ns_to_tsc(delay);=

=20
     while (xnarch_get_cpu_tsc() < wakeup)
         cpu_relax();
 }
+
+EXPORT_SYMBOL(rtdm_task_busy_sleep);
 /** @} */
=20
=20
@@ -368,8 +407,10 @@
     xnlock_put_irqrestore(&nklock, s);
 }
=20
+EXPORT_SYMBOL(_rtdm_synch_flush);
=20
=20
+
 /*!
  * @ingroup driverapi
  * @defgroup rtdmsync Synchronisation Services
@@ -431,7 +472,7 @@
  *
  * Rescheduling: never.
  */
-void rtdm_toseq_init(rtdm_toseq_t *timeout_seq, __s64 timeout);
+void rtdm_toseq_init(rtdm_toseq_t *timeout_seq, int64_t timeout);
 #endif /* DOXYGEN_CPP */
 /** @} */
=20
@@ -552,7 +593,9 @@
     xnlock_put_irqrestore(&nklock, s);
 }
=20
+EXPORT_SYMBOL(rtdm_event_signal);
=20
+
 /**
  * @brief Wait on event occurrence
  *
@@ -605,7 +648,9 @@
     return err;
 }
=20
+EXPORT_SYMBOL(rtdm_event_wait);
=20
+
 /**
  * @brief Wait on event occurrence with timeout
  *
@@ -638,7 +683,7 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_event_timedwait(rtdm_event_t *event, __s64 timeout,
+int rtdm_event_timedwait(rtdm_event_t *event, int64_t timeout,
                          rtdm_toseq_t *timeout_seq)
 {
     xnthread_t  *thread;
@@ -687,6 +732,8 @@
=20
     return err;
 }
+
+EXPORT_SYMBOL(rtdm_event_timedwait);
 /** @} */
=20
=20
@@ -787,7 +834,9 @@
     return err;
 }
=20
+EXPORT_SYMBOL(rtdm_sem_down);
=20
+
 /**
  * @brief Decrement a semaphore with timeout
  *
@@ -823,7 +872,7 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_sem_timeddown(rtdm_sem_t *sem, __s64 timeout,
+int rtdm_sem_timeddown(rtdm_sem_t *sem, int64_t timeout,
                        rtdm_toseq_t *timeout_seq)
 {
     xnthread_t  *thread;
@@ -871,7 +920,9 @@
     return err;
 }
=20
+EXPORT_SYMBOL(rtdm_sem_timeddown);
=20
+
 /**
  * @brief Increment a semaphore
  *
@@ -905,6 +956,8 @@
=20
     xnlock_put_irqrestore(&nklock, s);
 }
+
+EXPORT_SYMBOL(rtdm_sem_up);
 /** @} */
=20
=20
@@ -1001,7 +1054,9 @@
     return err;
 }
=20
+EXPORT_SYMBOL(rtdm_mutex_lock);
=20
+
 /**
  * @brief Request a mutex with timeout
  *
@@ -1036,7 +1091,7 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_mutex_timedlock(rtdm_mutex_t *mutex, __s64 timeout,
+int rtdm_mutex_timedlock(rtdm_mutex_t *mutex, int64_t timeout,
                          rtdm_toseq_t *timeout_seq)
 {
     xnthread_t  *thread;
@@ -1084,7 +1139,9 @@
     return err;
 }
=20
+EXPORT_SYMBOL(rtdm_mutex_timedlock);
=20
+
 /**
  * @brief Release a mutex
  *
@@ -1115,6 +1172,8 @@
=20
     xnlock_put_irqrestore(&nklock, s);
 }
+
+EXPORT_SYMBOL(rtdm_mutex_unlock);
 /** @} */
=20
 /** @} Synchronisation services */
@@ -1520,19 +1579,3 @@
 /** @} */
=20
 #endif /* DOXYGEN_CPP */
-
-
-EXPORT_SYMBOL(rtdm_task_join_nrt);
-EXPORT_SYMBOL(rtdm_task_sleep);
-EXPORT_SYMBOL(rtdm_task_sleep_until);
-EXPORT_SYMBOL(rtdm_task_busy_sleep);
-EXPORT_SYMBOL(_rtdm_synch_flush);
-EXPORT_SYMBOL(rtdm_event_wait);
-EXPORT_SYMBOL(rtdm_event_timedwait);
-EXPORT_SYMBOL(rtdm_event_signal);
-EXPORT_SYMBOL(rtdm_sem_down);
-EXPORT_SYMBOL(rtdm_sem_timeddown);
-EXPORT_SYMBOL(rtdm_sem_up);
-EXPORT_SYMBOL(rtdm_mutex_lock);
-EXPORT_SYMBOL(rtdm_mutex_timedlock);
-EXPORT_SYMBOL(rtdm_mutex_unlock);
Index: skins/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/rtdm/rtdm_driver.h	(revision 112)
+++ skins/rtdm/rtdm_driver.h	(working copy)
@@ -381,7 +381,7 @@
     /** Size of driver defined appendix to struct rtdm_dev_context */
     size_t                          context_size;
=20
-    /** Named device identification */
+    /** Named device identification (orthogonal to Linux device name spa=
ce) */
     char                            device_name[RTDM_MAX_DEVNAME_LEN+1];=

=20
     /** Protocol device identification: protocol family (PF_xxx) */
@@ -477,7 +477,7 @@
=20
=20
 /* --- clock services --- */
-static inline __u64 rtdm_clock_read(void)
+static inline uint64_t rtdm_clock_read(void)
 {
     return xnpod_ticks2ns(xnpod_get_time());
 }
@@ -500,7 +500,7 @@
  * Generally, it is illegal to suspend the current task by calling
  * rtdm_task_sleep(), rtdm_event_wait(), etc. while holding a spinlock. =
In
  * contrast, this macro allows to combine several operations including
- * potentially rescheduling calls to an atomic code block with respect t=
o
+ * a potentially rescheduling call to an atomic code block with respect =
to
  * other RTDM_EXECUTE_ATOMICALLY() blocks. The macro is a light-weight
  * alternative for protecting code blocks via mutexes, and it can even b=
e used
  * to synchronise real-time and non-real-time contexts.
@@ -511,7 +511,9 @@
  * @c break, @c return, @c goto, etc. This would leave the global lock h=
eld
  * during the code block execution in an inconsistent state. Moreover, d=
o not
  * embed complex operations into the code bock. Consider that they will =
be
- * executed under preemption lock with interrupts switched-off.
+ * executed under preemption lock with interrupts switched-off. Also not=
e that
+ * invocation of rescheduling calls may break the atomicity until the ta=
sk
+ * gains the CPU again.
  *
  * Environments:
  *
@@ -841,29 +843,10 @@
=20
 /** @} */
=20
-static inline int rtdm_task_init(rtdm_task_t *task, const char *name,
-                                 rtdm_task_proc_t task_proc, void *arg,
-                                 int priority, __u64 period)
-{
-    int res;
+int rtdm_task_init(rtdm_task_t *task, const char *name,
+                   rtdm_task_proc_t task_proc, void *arg,
+                   int priority, uint64_t period);
=20
-    res =3D xnpod_init_thread(task, name, priority, 0, 0);
-    if (res)
-        goto done;
-
-    if (!__builtin_constant_p(period) || (period !=3D XN_INFINITE)) {
-        res =3D xnpod_set_thread_periodic(task, XN_INFINITE,
-                                        xnpod_ns2ticks(period));
-        if (res)
-            goto done;
-    }
-
-    res =3D xnpod_start_thread(task, 0, 0, XNPOD_ALL_CPUS, task_proc, ar=
g);
-
-  done:
-    return res;
-}
-
 static inline void rtdm_task_destroy(rtdm_task_t *task)
 {
     xnpod_delete_thread(task);
@@ -877,7 +860,7 @@
     xnpod_schedule();
 }
=20
-static inline int rtdm_task_set_period(rtdm_task_t *task, __u64 period)
+static inline int rtdm_task_set_period(rtdm_task_t *task, uint64_t perio=
d)
 {
     return xnpod_set_thread_periodic(task, XN_INFINITE,
                                      xnpod_ns2ticks(period));
@@ -901,16 +884,16 @@
     return xnpod_wait_thread_period();
 }
=20
-int rtdm_task_sleep(__u64 delay);
-int rtdm_task_sleep_until(__u64 wakeup_time);
-void rtdm_task_busy_sleep(__u64 delay);
+int rtdm_task_sleep(uint64_t delay);
+int rtdm_task_sleep_until(uint64_t wakeup_time);
+void rtdm_task_busy_sleep(uint64_t delay);
=20
=20
 /* --- timeout sequences */
=20
-typedef __u64                       rtdm_toseq_t;
+typedef uint64_t                    rtdm_toseq_t;
=20
-static inline void rtdm_toseq_init(rtdm_toseq_t *timeout_seq, __s64 time=
out)
+static inline void rtdm_toseq_init(rtdm_toseq_t *timeout_seq, int64_t ti=
meout)
 {
     *timeout_seq =3D xnpod_get_time() + xnpod_ns2ticks(timeout);
 }
@@ -937,7 +920,7 @@
 }
=20
 int rtdm_event_wait(rtdm_event_t *event);
-int rtdm_event_timedwait(rtdm_event_t *event, __s64 timeout,
+int rtdm_event_timedwait(rtdm_event_t *event, int64_t timeout,
                          rtdm_toseq_t *timeout_seq);
 void rtdm_event_signal(rtdm_event_t *event);
=20
@@ -971,7 +954,7 @@
 }
=20
 int rtdm_sem_down(rtdm_sem_t *sem);
-int rtdm_sem_timeddown(rtdm_sem_t *sem, __s64 timeout,
+int rtdm_sem_timeddown(rtdm_sem_t *sem, int64_t timeout,
                        rtdm_toseq_t *timeout_seq);
 void rtdm_sem_up(rtdm_sem_t *sem);
=20
@@ -995,7 +978,7 @@
 }
=20
 int rtdm_mutex_lock(rtdm_mutex_t *mutex);
-int rtdm_mutex_timedlock(rtdm_mutex_t *mutex, __s64 timeout,
+int rtdm_mutex_timedlock(rtdm_mutex_t *mutex, int64_t timeout,
                          rtdm_toseq_t *timeout_seq);
 void rtdm_mutex_unlock(rtdm_mutex_t *mutex);
=20

--------------020602060307040709020204--

--------------enig866D00A41169734F418D31D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDb4DvncNeS9Q0k+IRAijPAJ95beSD24sS6TxE26587xuUq2cykwCeJFJd
fpzOG/atqZ4SqzHw9j+t6ak=
=3QwN
-----END PGP SIGNATURE-----

--------------enig866D00A41169734F418D31D7--

