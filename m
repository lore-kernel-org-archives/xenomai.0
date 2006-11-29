Message-ID: <456D8199.5000700@domain.hid>
Date: Wed, 29 Nov 2006 13:48:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH 1/2] rework shadow CPU affinity
References: <456C3EF9.30102@domain.hid>
In-Reply-To: <456C3EF9.30102@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig66840947D93618F38B39FFAF"
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
To: xenomai-core <xenomai@xenomai.org>
Cc: "M. Koehrer" <mathias_koehrer@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66840947D93618F38B39FFAF
Content-Type: multipart/mixed; boundary="------------050104090406050904010009"

This is a multi-part message in MIME format.
--------------050104090406050904010009
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Second try of this patch, now consequently basing the affinity API for
xnshadow_map on current->cpus_allowed (affects the native skin). Just
like the current code does, this patch restricts a shadow thread to a
single (the first) CPU of its affinity mask.

Jan

--------------050104090406050904010009
Content-Type: text/plain;
 name="rework-shadow-affinity-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rework-shadow-affinity-v2.patch"

---
 ksrc/nucleus/shadow.c       |   35 +++++++++++++----------------------
 ksrc/skins/native/syscall.c |    3 +++
 2 files changed, 16 insertions(+), 22 deletions(-)

Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -409,18 +409,6 @@ static void lostage_handler(void *cookie
 		xnltt_log_event(xeno_ev_lohandler, reqnum, p->comm, p->pid);
=20
 		switch (rq->req[reqnum].type) {
-		case LO_START_REQ:
-
-#ifdef CONFIG_SMP
-			if (xnshadow_thread(p))
-				/* Set up the initial task affinity using the
-				   information passed to xnpod_start_thread(). */
-				set_cpus_allowed(p,
-						 xnshadow_thread(p)->affinity);
-#endif /* CONFIG_SMP */
-
-			goto do_wakeup;
-
 		case LO_WAKEUP_REQ:
=20
 #ifdef CONFIG_SMP
@@ -443,7 +431,9 @@ static void lostage_handler(void *cookie
 			if (!xnshadow_thread(current))
 				xnpod_renice_root(XNPOD_ROOT_PRIO_BASE);
 #endif /* CONFIG_XENO_OPT_RPIDISABLE */
-		      do_wakeup:
+
+			/* fall through */
+		case LO_START_REQ:
=20
 #ifdef CONFIG_XENO_OPT_ISHIELD
 			if (xnshadow_thread(p) &&
@@ -853,22 +843,23 @@ int xnshadow_map(xnthread_t *thread, xnc
 	xnshadow_thrptd(current) =3D thread;
 	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE, NULL);
=20
+	/* Restrict affinity to a single CPU of the current set */
+	affinity =3D xnarch_cpumask_of_cpu(
+		xnarch_first_cpu(current->cpus_allowed));
+	set_cpus_allowed(current, affinity);
+
 	if (u_completion) {
 		xnshadow_signal_completion(u_completion, 0);
 		return 0;
 	}
=20
-	/* Nobody waits for us, so we may start the shadow immediately
-	   after having forced the CPU affinity to the current
-	   processor. Note that we don't use smp_processor_id() to prevent
-	   kernel debug stuff to yell at us for calling it in a preemptible
-	   section of code. */
-
-	affinity =3D xnarch_cpumask_of_cpu(rthal_processor_id());
-	set_cpus_allowed(current, affinity);
+	/* Nobody waits for us, so we may start the shadow immediately. */
=20
 	mode =3D thread->rrperiod !=3D XN_INFINITE ? XNRRB : 0;
-	xnpod_start_thread(thread, mode, 0, affinity, NULL, NULL);
+	err =3D xnpod_start_thread(thread, mode, 0, affinity, NULL, NULL);
+
+	if (err)
+		return err;
=20
 	err =3D xnshadow_harden();
=20
Index: xenomai/ksrc/skins/native/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/syscall.c
+++ xenomai/ksrc/skins/native/syscall.c
@@ -168,6 +168,9 @@ static int __rt_task_create(struct task_
 	err =3D rt_task_create(task, name, 0, prio, XNFPU | XNSHADOW | mode);
=20
 	if (err =3D=3D 0) {
+		/* Apply CPU affinity */
+		set_cpus_allowed(current, task->affinity);
+
 		/* Copy back the registry handle to the ph struct. */
 		ph.opaque =3D xnthread_handle(&task->thread_base);
 		ph.opaque2 =3D bulk.a5;	/* hidden pthread_t identifier. */

--------------050104090406050904010009--

--------------enig66840947D93618F38B39FFAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbYGZniDOoMHTA+kRAnxTAJ4ks0K691yyM4GJQCE3hEyZhnemkQCfSGYe
k3JB4VDGlepA/YmF3AunLTE=
=ijBd
-----END PGP SIGNATURE-----

--------------enig66840947D93618F38B39FFAF--

