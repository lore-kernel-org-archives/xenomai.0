Message-ID: <446C264A.7040206@domain.hid>
Date: Thu, 18 May 2006 09:46:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig60DCA8FE1D2C68822016521A"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC] non-RT-safe rtdm_event_*wait
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
Cc: grugh@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig60DCA8FE1D2C68822016521A
Content-Type: multipart/mixed; boundary="------------000203050000040509040604"

This is a multi-part message in MIME format.
--------------000203050000040509040604
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

attached is an experimental patch to allow blocking from non-RT context
on RTDM events. Petr Cervenka made me think about this extension which
could partially open RTDM drivers also for non-shadowed, i.e. standard
Linux tasks.

Why not simply shadowing non-RT waiters? Because this kind of sync
support should be cheaper than adding yet another (though low-prio) task
to the real-time domain ("should" =3D=3D I didn't benchmark my believe). =
And
it's more convenient because no shadow setup is required prior to
blocking on "dual-use" resources.

The patch seems to work (see attached simple test, also try ^C for
interruption testing), but requires more refactoring before being
applied. This will not happen before release 2.2 anyway. I also want to
add non-RT support for rtdm_sem in the final patch (rtdm_mutex makes no
sense due to risk of prio inversion). The whole non-RT support will
furthermore become optional to avoid code bloating.

Given that we then would have more powerful context-agnostic
synchronisation services for RTDM drivers, we may even consider
registering certain RTDM devices also with standard Linux, thus making
them available to Linux users without the need to use librtdm services.
Well, I haven't thought about all implications and limitation of such a
step, as well as its actual usefulness. It's just an idea so far.

Feedback is welcome, specifically about real tests or bugs you may spot
in this code.

Jan

--------------000203050000040509040604
Content-Type: text/x-patch;
 name="rtdm-nrtevent-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm-nrtevent-v2.patch"

Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm_driver.h	(Revision 1112)
+++ include/rtdm/rtdm_driver.h	(Arbeitskopie)
@@ -921,6 +921,7 @@ static inline void rtdm_toseq_init(rtdm_
=20
 typedef struct {
     xnsynch_t                       synch_base;
+    struct list_head                nrt_wait_queue;
 } rtdm_event_t;
=20
 #define RTDM_EVENT_PENDING          XNSYNCH_SPARE1
@@ -928,15 +929,18 @@ typedef struct {
 static inline void rtdm_event_init(rtdm_event_t *event, unsigned long pe=
nding)
 {
     xnsynch_init(&event->synch_base, XNSYNCH_PRIO);
+    INIT_LIST_HEAD(&event->nrt_wait_queue);
     if (pending)
         xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
 }
=20
 void _rtdm_synch_flush(xnsynch_t *synch, unsigned long reason);
+void _rtdm_nrtev_destroy(struct list_head *wait_queue);
=20
 static inline void rtdm_event_destroy(rtdm_event_t *event)
 {
     _rtdm_synch_flush(&event->synch_base, XNRMID);
+    _rtdm_nrtev_destroy(&event->nrt_wait_queue);
 }
=20
 int rtdm_event_wait(rtdm_event_t *event);
@@ -944,10 +948,11 @@ int rtdm_event_timedwait(rtdm_event_t *e
                          rtdm_toseq_t *timeout_seq);
 void rtdm_event_signal(rtdm_event_t *event);
=20
-static inline void rtdm_event_pulse(rtdm_event_t *event)
+/*static inline void rtdm_event_pulse(rtdm_event_t *event)
 {
     _rtdm_synch_flush(&event->synch_base, 0);
-}
+}*/
+void rtdm_event_pulse(rtdm_event_t *event);
=20
 void rtdm_event_clear(rtdm_event_t *event);
=20
Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(Revision 1112)
+++ ksrc/skins/rtdm/drvlib.c	(Arbeitskopie)
@@ -2,7 +2,7 @@
  * @file
  * Real-Time Driver Model for Xenomai, driver library
  *
- * @note Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>
+ * @note Copyright (C) 2005, 2006 Jan Kiszka <jan.kiszka@domain.hid>
  * @note Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>
  *
  * Xenomai is free software; you can redistribute it and/or modify it
@@ -548,8 +548,9 @@ void rtdm_event_destroy(rtdm_event_t *ev
  * @brief Signal an event occurrence to currently listening waiters
  *
  * This function wakes up all current waiters of the given event, but it=
 does
- * not change the event state. Subsequently callers of rtdm_event_wait()=
 or
- * rtdm_event_wait_until() will therefore be blocked first.
+ * not set the event to a signalled state. Subsequent callers of
+ * rtdm_event_wait() or rtdm_event_wait_until() will therefore be blocke=
d
+ * first.
  *
  * @param[in,out] event Event handle as returned by rtdm_event_init()
  *
@@ -568,6 +569,146 @@ void rtdm_event_pulse(rtdm_event_t *even
 #endif /* DOXYGEN_CPP */
=20
=20
+rtdm_nrtsig_t nrtevent;
+static LIST_HEAD(nrtev_queue);
+
+struct nrtev_waiter {
+    xnflags_t           flags;
+    struct task_struct  *task;
+    struct list_head    wait_queue;
+};
+
+/* Append the entire source wait queue to the target one and reset
+   the source queue. */
+static fastcall void
+rtdm_migrate_nrt_queue(struct list_head *dest, struct list_head *source)=

+{
+    struct list_head *src_head, *src_tail;
+
+
+    src_head =3D source->next;
+    src_tail =3D source->prev;
+    INIT_LIST_HEAD(source);
+
+    dest->prev->next =3D src_head;
+    src_head->prev =3D dest->prev;
+
+    dest->prev =3D src_tail;
+    src_tail->next =3D dest;
+}
+
+static int
+rtdm_nrtev_wait(struct list_head *wait_queue, int64_t timeout, spl_t s)
+{
+    struct nrtev_waiter entry;
+    int err =3D 0;
+
+
+    entry.flags =3D 0;
+    entry.task  =3D current;
+    list_add(&entry.wait_queue, wait_queue);
+    set_current_state(TASK_INTERRUPTIBLE);
+
+    xnlock_put_irqrestore(&nklock, s);
+
+    if (timeout) {
+        unsigned long to =3D MAX_JIFFY_OFFSET;
+
+        if (timeout < MAX_JIFFY_OFFSET * 1000000000LL / HZ)
+            to =3D xnarch_uldiv(timeout, 1000000000 / HZ);
+
+        if (!schedule_timeout(to))
+            err =3D -ETIMEDOUT;
+    } else
+        schedule();
+
+    if (signal_pending(current))
+        err =3D -ERESTARTSYS;
+    else if (testbits(entry.flags, XNRMID))
+        err =3D -EIDRM;
+
+    xnlock_get_irqsave(&nklock, s);
+
+    list_del(&entry.wait_queue);
+
+    return err;
+}
+
+void _rtdm_nrtev_destroy(struct list_head *nrt_wait_queue)
+{
+    struct nrtev_waiter *entry;
+    spl_t s;
+
+
+    xnlock_get_irqsave(&nklock, s);
+
+    if (!list_empty(&nrtev_queue)) {
+        list_for_each_entry(entry, nrt_wait_queue, wait_queue)
+            setbits(entry->flags, XNRMID);
+
+        rtdm_migrate_nrt_queue(&nrtev_queue, nrt_wait_queue);
+        rtdm_nrtsig_pend(&nrtevent);
+    }
+
+    xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(_rtdm_nrtev_destroy);
+
+
+void rtdm_nrtev_handler(rtdm_nrtsig_t nrt_sig)
+{
+    struct nrtev_waiter *entry;
+    spl_t s;
+
+
+    xnlock_get_irqsave(&nklock, s);
+
+    while (!list_empty(&nrtev_queue)) {
+        entry =3D list_entry(nrtev_queue.next,
+                           struct nrtev_waiter, wait_queue);
+
+        list_del(&entry->wait_queue);
+        INIT_LIST_HEAD(&entry->wait_queue);
+
+        xnlock_put_irqrestore(&nklock, s);
+
+        wake_up_process(entry->task);
+
+        xnlock_get_irqsave(&nklock, s);
+    }
+
+    xnlock_put_irqrestore(&nklock, s);
+}
+
+
+static fastcall void rtdm_event_pulse_internal(rtdm_event_t *event)
+{
+    if (xnsynch_flush(&event->synch_base, 0))
+        xnpod_schedule();
+
+    if (!list_empty(&event->nrt_wait_queue)) {
+        rtdm_migrate_nrt_queue(&nrtev_queue, &event->nrt_wait_queue);
+        rtdm_nrtsig_pend(&nrtevent);
+    }
+}
+
+
+void rtdm_event_pulse(rtdm_event_t *event)
+{
+    spl_t s;
+
+
+    xnlock_get_irqsave(&nklock, s);
+
+    rtdm_event_pulse_internal(event);
+
+    xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(rtdm_event_pulse);
+
+
 /**
  * @brief Signal an event occurrence
  *
@@ -596,8 +737,7 @@ void rtdm_event_signal(rtdm_event_t *eve
     xnlock_get_irqsave(&nklock, s);
=20
     xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
-    if (xnsynch_flush(&event->synch_base, 0))
-        xnpod_schedule();
+    rtdm_event_pulse_internal(event);
=20
     xnlock_put_irqrestore(&nklock, s);
 }
@@ -678,50 +818,65 @@ EXPORT_SYMBOL(rtdm_event_wait);
 int rtdm_event_timedwait(rtdm_event_t *event, int64_t timeout,
                          rtdm_toseq_t *timeout_seq)
 {
+    int64_t     eff_timeout;
     xnthread_t  *thread;
     spl_t       s;
     int         err =3D 0;
=20
=20
+#if 1
+    XENO_ASSERT(RTDM, !xnpod_asynch_p() && !xnpod_locked_p(), return -EP=
ERM;);
+#else
     XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+#endif
=20
     xnlock_get_irqsave(&nklock, s);
=20
-    if (unlikely(testbits(event->synch_base.status, RTDM_SYNCH_DELETED))=
)
+    if (unlikely(xnsynch_test_flags(&event->synch_base, RTDM_SYNCH_DELET=
ED)))
         err =3D -EIDRM;
+
     else if (likely(xnsynch_test_flags(&event->synch_base,
                                        RTDM_EVENT_PENDING)))
         xnsynch_clear_flags(&event->synch_base, RTDM_EVENT_PENDING);
-    else {
+
+    else if (timeout < 0) {
         /* non-blocking mode */
-        if (timeout < 0) {
-            err =3D -EWOULDBLOCK;
-            goto unlock_out;
-        }
+        err =3D -EWOULDBLOCK;
=20
+    } else {
         if (timeout_seq && (timeout > 0)) {
             /* timeout sequence */
-            timeout =3D *timeout_seq - xnpod_get_time();
-            if (unlikely(timeout <=3D 0)) {
+            eff_timeout =3D *timeout_seq - xnpod_get_time();
+            if (unlikely(eff_timeout <=3D 0)) {
                 err =3D -ETIMEDOUT;
                 goto unlock_out;
             }
-            xnsynch_sleep_on(&event->synch_base, timeout);
         } else {
             /* infinite or relative timeout */
-            xnsynch_sleep_on(&event->synch_base, xnpod_ns2ticks(timeout)=
);
+            eff_timeout =3D xnpod_ns2ticks(timeout);
         }
=20
-        thread =3D xnpod_current_thread();
-
-        if (likely(!xnthread_test_flags(thread, XNTIMEO|XNRMID|XNBREAK))=
)
-            xnsynch_clear_flags(&event->synch_base, RTDM_EVENT_PENDING);=

-        else if (xnthread_test_flags(thread, XNTIMEO))
-            err =3D -ETIMEDOUT;
-        else if (xnthread_test_flags(thread, XNRMID))
-            err =3D -EIDRM;
-        else /* XNBREAK */
-            err =3D -EINTR;
+#if 1
+        if (unlikely(xnpod_root_p())) {
+            err =3D rtdm_nrtev_wait(&event->nrt_wait_queue, timeout, s);=

+            if (err =3D=3D 0)
+                xnsynch_clear_flags(&event->synch_base, RTDM_EVENT_PENDI=
NG);
+        } else
+#endif
+        {
+            xnsynch_sleep_on(&event->synch_base, eff_timeout);
+
+            thread =3D xnpod_current_thread();
+
+            if (likely(!xnthread_test_flags(thread, XNTIMEO|XNRMID|XNBRE=
AK)))
+                xnsynch_clear_flags(&event->synch_base, RTDM_EVENT_PENDI=
NG);
+            else if (xnthread_test_flags(thread, XNTIMEO))
+                err =3D -ETIMEDOUT;
+            else if (xnthread_test_flags(thread, XNRMID))
+                err =3D -EIDRM;
+            else /* XNBREAK */
+                err =3D -EINTR;
+        }
     }
=20
  unlock_out:
Index: ksrc/skins/rtdm/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/module.c	(Revision 1112)
+++ ksrc/skins/rtdm/module.c	(Arbeitskopie)
@@ -49,6 +49,7 @@
 #endif /* __KERNEL__ */
=20
 #include "rtdm/device.h"
+#include "rtdm/drvlib.h"
 #include "rtdm/proc.h"
=20
=20
@@ -97,10 +98,14 @@ int SKIN_INIT(rtdm)
     if (err)
         goto cleanup_pod;
=20
+    err =3D rtdm_nrtev_init();
+    if (err)
+        goto cleanup_dev;
+
 #ifdef CONFIG_PROC_FS
     err =3D rtdm_proc_init();
     if (err)
-        goto cleanup_dev;
+        goto cleanup_nrtev;
 #endif /* CONFIG_PROC_FS */
=20
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
@@ -124,9 +129,12 @@ int SKIN_INIT(rtdm)
 #ifdef CONFIG_PROC_FS
     rtdm_proc_cleanup();
=20
-  cleanup_dev:
+  cleanup_nrtev:
 #endif /* CONFIG_PROC_FS */
=20
+    rtdm_nrtev_cleanup();
+
+  cleanup_dev:
     rtdm_dev_cleanup();
=20
   cleanup_pod:
Index: ksrc/skins/rtdm/drvlib.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.h	(Revision 0)
+++ ksrc/skins/rtdm/drvlib.h	(Revision 0)
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef _RTDM_DRVLIB_H
+#define _RTDM_DRVLIB_H
+
+#include <rtdm/rtdm_driver.h>
+
+
+extern rtdm_nrtsig_t nrtevent;
+
+void rtdm_nrtev_handler(rtdm_nrtsig_t nrt_sig);
+
+static inline int rtdm_nrtev_init(void)
+{
+    return rtdm_nrtsig_init(&nrtevent, rtdm_nrtev_handler);
+}
+
+static inline void rtdm_nrtev_cleanup(void)
+{
+    rtdm_nrtsig_destroy(&nrtevent);
+}
+
+#endif /* _RTDM_DRVLIB_H */

--------------000203050000040509040604
Content-Type: text/plain;
 name="rtdm-nrtev-test.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm-nrtev-test.c"

#include <linux/module.h>
#include <rtdm/rtdm_driver.h>

rtdm_task_t task;
rtdm_event_t ev;

void task_fnc(void *arg)
{
    rtdm_task_sleep(20*1000000000LL);
    rtdm_event_signal(&ev);
    printk("signalled\n");
}

int nrtev_test(void)
{
    rtdm_event_init(&ev, 0);

    rtdm_task_init(&task, "nrtev_test", task_fnc, NULL, 20, 0);

    printk("waiting...\n");
    printk("res1 =3D %d\n", rtdm_event_timedwait(&ev, 5000000000LL, NULL)=
);
    printk("res2 =3D %d\n", rtdm_event_timedwait(&ev, -1, NULL));
    printk("res3 =3D %d\n", rtdm_event_timedwait(&ev, 0, NULL));

    rtdm_task_join_nrt(&task, 100);
    printk("done\n");

    return -ENOANO;
}

module_init(nrtev_test);

--------------000203050000040509040604--

--------------enig60DCA8FE1D2C68822016521A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEbCZOniDOoMHTA+kRAjpxAJ4mEvlyMdne1X9S9MYHXHtVGXmiWQCeJUw7
E6aLBpJBWRjhI/+1xG24KoA=
=FjZV
-----END PGP SIGNATURE-----

--------------enig60DCA8FE1D2C68822016521A--

