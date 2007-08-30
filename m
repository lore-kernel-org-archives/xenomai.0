Message-ID: <46D66DA7.6060800@domain.hid>
Date: Thu, 30 Aug 2007 09:11:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigADF44CAA933BCC6BC48A77E0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/2] Round up in RTDM converting ns to ticks
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
Cc: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigADF44CAA933BCC6BC48A77E0
Content-Type: multipart/mixed;
 boundary="------------040300050503040109000106"

This is a multi-part message in MIME format.
--------------040300050503040109000106
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

As suggested by Markus, this patch lets RTDM round up when nanoseconds
are to be converted to ticks (only relevant if RTDM runs over a
periodic, tick-based timebase).

This is against trunk only, I haven't yet decided what to do with 2.3.x.
The rounding change may have unexpected side-effects, so I'm hesitating
to change the stable version as well.

Jan

--------------040300050503040109000106
Content-Type: text/plain;
 name="round-up-in-rtdm.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="round-up-in-rtdm.patch"

---
 include/rtdm/rtdm_driver.h |   11 +++++------
 ksrc/skins/rtdm/drvlib.c   |   32 ++++++++++++++++----------------
 2 files changed, 21 insertions(+), 22 deletions(-)

Index: xenomai/include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/rtdm/rtdm_driver.h
+++ xenomai/include/rtdm/rtdm_driver.h
@@ -876,8 +876,8 @@ static inline int rtdm_timer_start_in_ha
 					      nanosecs_rel_t interval,
 					      enum rtdm_timer_mode mode)
 {
-	return xntimer_start(timer, xntbase_ns2ticks(rtdm_tbase, expiry),
-			     xntbase_ns2ticks(rtdm_tbase, interval),
+	return xntimer_start(timer, xntbase_ns2ticks_ceil(rtdm_tbase, expiry),
+			     xntbase_ns2ticks_ceil(rtdm_tbase, interval),
 			     (xntmode_t)mode);
 }
=20
@@ -945,10 +945,9 @@ static inline int rtdm_task_set_period(r
 {
 	if (period < 0)
 		period =3D 0;
-	return
-	    xnpod_set_thread_periodic(task, XN_INFINITE,
-				      xntbase_ns2ticks(xnthread_time_base(task),
-						       period));
+	return xnpod_set_thread_periodic(task, XN_INFINITE,
+					 xntbase_ns2ticks_ceil
+					 (xnthread_time_base(task), period));
 }
=20
 static inline int rtdm_task_unblock(rtdm_task_t *task)
Index: xenomai/ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/rtdm/drvlib.c
+++ xenomai/ksrc/skins/rtdm/drvlib.c
@@ -145,8 +145,8 @@ int rtdm_task_init(rtdm_task_t *task, co
=20
 	if (period > 0) {
 		res =3D xnpod_set_thread_periodic(task, XN_INFINITE,
-						xntbase_ns2ticks(rtdm_tbase,
-								 period));
+						xntbase_ns2ticks_ceil
+						(rtdm_tbase,  period));
 		if (res)
 			goto cleanup_out;
 	}
@@ -370,8 +370,8 @@ int __rtdm_task_sleep(xnticks_t timeout,
 	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
=20
 	xnpod_suspend_thread(thread, XNDELAY,
-			     xntbase_ns2ticks(xnthread_time_base(thread),
-					      timeout), mode, NULL);
+			     xntbase_ns2ticks_ceil(xnthread_time_base(thread),
+						   timeout), mode, NULL);
=20
 	return xnthread_test_info(thread, XNBREAK) ? -EINTR : 0;
 }
@@ -544,8 +544,8 @@ int rtdm_timer_start(rtdm_timer_t *timer
 	int err;
=20
 	xnlock_get_irqsave(&nklock, s);
-	err =3D xntimer_start(timer, xntbase_ns2ticks(rtdm_tbase, expiry),
-			    xntbase_ns2ticks(rtdm_tbase, interval),
+	err =3D xntimer_start(timer, xntbase_ns2ticks_ceil(rtdm_tbase, expiry),=

+			    xntbase_ns2ticks_ceil(rtdm_tbase, interval),
 			    (xntmode_t)mode);
 	xnlock_put_irqrestore(&nklock, s);
=20
@@ -714,7 +714,7 @@ void rtdm_toseq_init(rtdm_toseq_t *timeo
 	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), /* only warn here */;);
=20
 	*timeout_seq =3D
-	    xntbase_get_jiffies(base) + xntbase_ns2ticks(base, timeout);
+	    xntbase_get_jiffies(base) + xntbase_ns2ticks_ceil(base, timeout);
 }
=20
 EXPORT_SYMBOL(rtdm_toseq_init);
@@ -934,9 +934,9 @@ int rtdm_event_timedwait(rtdm_event_t *e
 		} else {
 			/* infinite or relative timeout */
 			xnsynch_sleep_on(&event->synch_base,
-				xntbase_ns2ticks(xnthread_time_base(thread),
-						 timeout),
-				XN_RELATIVE);
+					 xntbase_ns2ticks_ceil
+					 (xnthread_time_base(thread), timeout),
+					 XN_RELATIVE);
 		}
=20
 		if (likely
@@ -1143,9 +1143,9 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem,=20
 		} else {
 			/* infinite or relative timeout */
 			xnsynch_sleep_on(&sem->synch_base,
-				xntbase_ns2ticks(xnthread_time_base(thread),
-						 timeout),
-				XN_RELATIVE);
+					 xntbase_ns2ticks_ceil
+					 (xnthread_time_base(thread), timeout),
+					 XN_RELATIVE);
 		}
=20
 		if (xnthread_test_info(thread, XNTIMEO | XNRMID | XNBREAK)) {
@@ -1377,9 +1377,9 @@ restart:
 		} else {
 			/* infinite or relative timeout */
 			xnsynch_sleep_on(&mutex->synch_base,
-				xntbase_ns2ticks(xnthread_time_base(curr_thread),
-						 timeout),
-				XN_RELATIVE);
+					 xntbase_ns2ticks_ceil
+					 (xnthread_time_base(curr_thread),
+					  timeout), XN_RELATIVE);
 		}
=20
 		if (unlikely(xnthread_test_info(curr_thread,

--------------040300050503040109000106--

--------------enigADF44CAA933BCC6BC48A77E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1m2nniDOoMHTA+kRAgNOAJ9dU/Q7KzOmV7j1OnZ/MNBqYWfOsQCghPIe
x0T/+ZGU7MFXXl8W10Te/d8=
=pVyr
-----END PGP SIGNATURE-----

--------------enigADF44CAA933BCC6BC48A77E0--

