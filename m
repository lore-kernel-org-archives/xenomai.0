Message-ID: <441F3476.1080003@domain.hid>
Date: Tue, 21 Mar 2006 00:02:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up
References: 200603201434.15258@domain.hid> <200603201434.15258@domain.hid>
	<441ED657.1080405@domain.hid> <200603201901.3123@domain.hid>
In-Reply-To: <200603201901.3123@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD53FFA6F7CB5E114377E0B5A"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD53FFA6F7CB5E114377E0B5A
Content-Type: multipart/mixed; boundary="------------000309060005050800020308"

This is a multi-part message in MIME format.
--------------000309060005050800020308
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> I' tried to create  user realtime task, and after all effort (and
> many related partial problems solved) I still cannot do blocking
> variant of rtdm_event_timedwait.
> 1) How can I recognize, that the function is called within proper
> context / ie. is there an rtdm equivalent to xnpod_unblockable_p?

First of all, there is the concept of the dual entry points, one for RT
(xxx_rt), the other for non-RT (xxx_nrt). If your driver only registers
a handler on xxx_rt, it will never get called in unblockable context. If
it registers different functions on those entry points, it can easily
tell the contexts apart.

Given that you have some significant amount of code to share between a
RT and a non-RT invocation, you can register the same handler on both
entry points. Then rtdm_in_rt_context() will tell you in which context
you currently are.

> 2) Could be the problem elsewhere?

I prepared the attached patch that catches illegal service
invocations. It will get checked in as soon as we decided how to switch
XENO_ASSERTs on. For now this is done via CONFIG_XENO_OPT_DEBUG. Feel
free to apply it on your Xenomai code and check if it's useful. I tested
it a bit, and it didn't break anything of RTDM in an obvious way. :)

> 3) My General Standards PCI-24DSI-12 card is not supported by comedi.
> And I'm not familiar with it either. The original driver is not so
> complicated and the port looked as easy work ;-) But waiting inside

I can understand that you do not want to complicate your job with comedi
when there is no support for your hardware anyway.

> ioctl or read handler for an interrupt is critical for proper
> functionality.

This must work. See the 16550A driver e.g., it has a similar design,
specifically for handling RTSER_RTIOC_WAIT_EVENT.

> 4) I realized when I make a realtime task (prio 1 ~ lowest, I hope)
> and in my main (nrt) task I call sleep(1), It will fall asleep
> forever (or maybe to some signal).

Sounds like something is blocking the Linux timer. Did you accidentally
register your driver on it? See /proc/interrupts for the timer IRQ
counter, in contrast to /proc/xenomai/irq.

> 5) Is it possible to set some event or to send signal/message/...
> from rt to nrt and back?

rt->nrt: rtdm_nrtsig_xxx
nrt->rt: any blocking rtdm-IPC service (except for mutexes of course)
can be signalled also from non-rt

> 6) Is there some easy-to-understand documentation? What I can or
> cannot...?

Did you browse the API documentation of RTDM, maybe also had a look at
the related RTDM-and-Applications.pdf (hmm, were does a user get this
from? At least, it's in the SVN, but the homepage still requires an
update...)? If yes, please let us know what remains unclear and what
would be additionally desirable. A tour on RTDM, like Philippe already
wrote for other subsystems, would be nice - it just takes someone to
write it...

> Petr Cervenka
>=20

Jan

--------------000309060005050800020308
Content-Type: text/x-patch;
 name="rtdm-asserts.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm-asserts.patch"

Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/.svn/text-base/rtdm_driver.h.svn-base	2006-03-09 22:16:0=
3.000000000 +0100
+++ include/rtdm/rtdm_driver.h	2006-03-20 17:55:10.000000000 +0100
@@ -38,6 +38,7 @@
 #include <nucleus/heap.h>
 #include <nucleus/pod.h>
 #include <nucleus/synch.h>
+#include <nucleus/assert.h>
 #include <rtdm/rtdm.h>
=20
=20
@@ -890,6 +891,7 @@ static inline rtdm_task_t *rtdm_task_cur
=20
 static inline int rtdm_task_wait_period(void)
 {
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
     return xnpod_wait_thread_period(NULL);
 }
=20
Index: include/nucleus/assert.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/.svn/text-base/assert.h.svn-base	2006-03-08 00:48:14.=
000000000 +0100
+++ include/nucleus/assert.h	2006-03-20 20:04:10.000000000 +0100
@@ -22,18 +22,14 @@
=20
 #include <nucleus/compiler.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_LEVEL
-#define CONFIG_XENO_OPT_DEBUG_LEVEL  0
-#endif
-
-#if CONFIG_XENO_OPT_DEBUG_LEVEL > 0
+#if CONFIG_XENO_OPT_DEBUG
 #define XENO_ASSERT(cond,action)  do { \
 if (unlikely((cond) !=3D 0)) \
 	do { action; } while(0); \
 } while(0)
-#else  /* CONFIG_XENO_OPT_DEBUG_LEVEL =3D=3D 0 */
+#else  /* !CONFIG_XENO_OPT_DEBUG */
 #define XENO_ASSERT(cond,action) do { } while(0)
-#endif /* CONFIG_XENO_OPT_DEBUG_LEVEL > 0 */
+#endif /* CONFIG_XENO_OPT_DEBUG */
=20
 #define XENO_BUGON(cond)  \
     XENO_ASSERT(cond,xnpod_fatal("assertion failed at %s:%d",__FILE__,__=
LINE__))
Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/.svn/text-base/drvlib.c.svn-base	2006-03-13 23:13:19.=
000000000 +0100
+++ ksrc/skins/rtdm/drvlib.c	2006-03-20 20:11:38.000000000 +0100
@@ -279,6 +279,8 @@ void rtdm_task_join_nrt(rtdm_task_t *tas
     spl_t s;
=20
=20
+    XENO_ASSERT(xnpod_root_p(), return;);
+
     xnlock_get_irqsave(&nklock, s);
=20
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
     xnthread_t  *thread =3D xnpod_current_thread();
=20
=20
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
+
     xnpod_suspend_thread(thread, XNDELAY, xnpod_ns2ticks(delay), NULL);
=20
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
     int         err =3D 0;
=20
=20
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
=20
     delay =3D xnpod_ns2ticks(wakeup_time) - xnpod_get_time();
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
     int     err =3D 0;
=20
=20
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
=20
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
     int         err =3D 0;
=20
=20
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
=20
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
     int     err =3D 0;
=20
=20
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
=20
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
@@ -895,6 +925,8 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem,=20
     int         err =3D 0;
=20
=20
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
=20
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
     int     err =3D 0;
=20
=20
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
=20
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
     int         err =3D 0;
=20
=20
+    XENO_ASSERT(!xnpod_unblockable_p(), return -EPERM;);
+
     xnlock_get_irqsave(&nklock, s);
=20
     if (testbits(mutex->synch_base.status, SYNCH_DELETED))
@@ -1179,6 +1221,8 @@ void rtdm_mutex_unlock(rtdm_mutex_t *mut
     spl_t s;
=20
=20
+    XENO_ASSERT(!xnpod_asynch_p(), return;);
+
     xnlock_get_irqsave(&nklock, s);
=20
     __clear_bit(0, &mutex->locked);
@@ -1426,6 +1470,9 @@ static struct file_operations rtdm_mmap_
  * - -EAGAIN is returned if too much memory has been already locked by t=
he
  * user process.
  *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
  * @note RTDM supports two models for unmapping the user memory range ag=
ain.
  * One is explicite unmapping via rtdm_munmap(), either performed when t=
he
  * user requests it via an IOCTL etc. or when the related device is clos=
ed.
@@ -1457,6 +1504,9 @@ int rtdm_mmap_to_user(rtdm_user_info_t *
     void                    *old_priv_data;
     void                    *user_ptr;
=20
+
+    XENO_ASSERT(xnpod_root_p(), return -EPERM;);
+
     filp =3D filp_open("/dev/zero", O_RDWR, 0);
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
=20
+
+    XENO_ASSERT(xnpod_root_p(), return -EPERM;);
+
     down_write(&user_info->mm->mmap_sem);
     err =3D do_munmap(user_info->mm, (unsigned long)ptr, len);
     up_write(&user_info->mm->mmap_sem);

--------------000309060005050800020308--

--------------enigD53FFA6F7CB5E114377E0B5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHzR2niDOoMHTA+kRAnHtAJ0URyuFMgX48+h/a1qt7mgt1rcE8gCfXJmC
iCvuvjbJtjcFA8F5P1kjXh0=
=K3by
-----END PGP SIGNATURE-----

--------------enigD53FFA6F7CB5E114377E0B5A--

