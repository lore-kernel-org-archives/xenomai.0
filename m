Message-ID: <456C3EF9.30102@domain.hid>
Date: Tue, 28 Nov 2006 14:51:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9D9AA8A2B819FC6C42FE0280"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 1/2] rework shadow CPU affinity
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
--------------enig9D9AA8A2B819FC6C42FE0280
Content-Type: multipart/mixed; boundary="------------050106000207070109060605"

This is a multi-part message in MIME format.
--------------050106000207070109060605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Picking up the earlier discussion of CPU affinity of shadow threads,
this patch now opens the possibility to assign a CPU mask on
xnshadow_map. It cleans up the related nucleus code and updates all
callers of xnshadow_map appropriately.

Be warned, it's only tested on (q)emulated SMP. Comments and test
reports on real hardware are welcome.

Jan


PS: I would consider these patches for 2.4.

--------------050106000207070109060605
Content-Type: text/plain;
 name="rework-shadow-affinity.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rework-shadow-affinity.patch"

---
 include/asm-generic/system.h |    1 -
 include/nucleus/pod.h        |    3 +++
 include/nucleus/shadow.h     |    4 +++-
 ksrc/nucleus/shadow.c        |   43 ++++++++++++++++++------------------=
-------
 ksrc/skins/native/syscall.c  |    3 ++-
 ksrc/skins/posix/syscall.c   |    4 ++--
 ksrc/skins/psos+/syscall.c   |    3 ++-
 ksrc/skins/vrtx/syscall.c    |    3 ++-
 ksrc/skins/vxworks/syscall.c |    3 ++-
 9 files changed, 34 insertions(+), 33 deletions(-)

Index: xenomai/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -38,7 +38,6 @@
 #include <asm/ptrace.h>
 #include <asm/xenomai/hal.h>
 #include <asm/xenomai/atomic.h>
-#include <nucleus/shadow.h>
=20
 /* Tracer interface */
 #define xnarch_trace_max_begin(v)		rthal_trace_max_begin(v)
Index: xenomai/include/nucleus/shadow.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/shadow.h
+++ xenomai/include/nucleus/shadow.h
@@ -22,6 +22,7 @@
=20
 #include <asm/xenomai/atomic.h>
 #include <asm/xenomai/syscall.h>
+#include <asm/xenomai/system.h>
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #endif /* CONFIG_PROC_FS */
@@ -65,7 +66,8 @@ void xnshadow_grab_events(void);
 void xnshadow_release_events(void);
=20
 int xnshadow_map(struct xnthread *thread,
-		 xncompletion_t __user *u_completion);
+		 xncompletion_t __user *u_completion,
+		 xnarch_cpumask_t affinity);
=20
 void xnshadow_unmap(struct xnthread *thread);
=20
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
@@ -752,7 +742,8 @@ void xnshadow_exit(void)
 }
=20
 /*!
- * \fn int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_com=
pletion)
+ * \fn int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_com=
pletion,
+ *                      xnarch_cpumask_t affinity)
  * @internal
  * \brief Create a shadow thread context.
  *
@@ -781,6 +772,9 @@ void xnshadow_exit(void)
  * immediately started and "current" immediately resumes in the Xenomai
  * domain from this service.
  *
+ * @param affinity The processor affinity of this thread. Passing
+ * XNPOD_ALL_CPUS or an empty affinity set means "any cpu".
+ *
  * @return 0 is returned on success. Otherwise:
  *
  * - -ERESTARTSYS is returned if the current Linux task has received a
@@ -803,9 +797,9 @@ void xnshadow_exit(void)
  *
  */
=20
-int xnshadow_map(xnthread_t *thread, xncompletion_t __user * u_completio=
n)
+int xnshadow_map(xnthread_t *thread, xncompletion_t __user * u_completio=
n,
+		 xnarch_cpumask_t affinity)
 {
-	xnarch_cpumask_t affinity;
 	unsigned muxid, magic;
 	int mode, prio, err;
=20
@@ -853,22 +847,21 @@ int xnshadow_map(xnthread_t *thread, xnc
 	xnshadow_thrptd(current) =3D thread;
 	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE, NULL);
=20
+	/* Apply provided cpumask on the Linux task. */
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
Index: xenomai/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -33,6 +33,9 @@
=20
 #include <nucleus/thread.h>
 #include <nucleus/intr.h>
+#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
+#include <nucleus/shadow.h>
+#endif /* __KERNEL__  && CONFIG_XENO_OPT_PERVASIVE */
=20
 /* Creation flags */
 #define XNREUSE  0x00000001     /* Reuse pod with identical properties *=
/
Index: xenomai/ksrc/skins/native/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/syscall.c
+++ xenomai/ksrc/skins/native/syscall.c
@@ -173,7 +173,8 @@ static int __rt_task_create(struct task_
 		ph.opaque2 =3D bulk.a5;	/* hidden pthread_t identifier. */
 		__xn_copy_to_user(curr, (void __user *)bulk.a1, &ph,
 				  sizeof(ph));
-		err =3D xnshadow_map(&task->thread_base, u_completion);
+		err =3D xnshadow_map(&task->thread_base, u_completion,
+				   task->affinity);
 	} else {
 		xnfree(task);
 		/* Unblock and pass back error code. */
Index: xenomai/ksrc/skins/posix/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/posix/syscall.c
+++ xenomai/ksrc/skins/posix/syscall.c
@@ -174,7 +174,7 @@ static int __pthread_create(struct task_
 	if (err)
 		return -err;	/* Conventionally, our error codes are negative. */
=20
-	err =3D xnshadow_map(&k_tid->threadbase, NULL);
+	err =3D xnshadow_map(&k_tid->threadbase, NULL, XNPOD_ALL_CPUS);
=20
 	if (!err && !__pthread_hash(&hkey, k_tid))
 		err =3D -ENOMEM;
@@ -205,7 +205,7 @@ static pthread_t __pthread_shadow(struct
 	if (err)
 		return ERR_PTR(-err);
=20
-	err =3D xnshadow_map(&k_tid->threadbase, NULL);
+	err =3D xnshadow_map(&k_tid->threadbase, NULL, XNPOD_ALL_CPUS);
=20
 	if (!err && !__pthread_hash(hkey, k_tid))
 		err =3D -EAGAIN;
Index: xenomai/ksrc/skins/psos+/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/psos+/syscall.c
+++ xenomai/ksrc/skins/psos+/syscall.c
@@ -98,7 +98,8 @@ static int __t_create(struct task_struct
 		tid =3D xnthread_handle(&task->threadbase);
 		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg4(regs), &tid,
 				  sizeof(tid));
-		err =3D xnshadow_map(&task->threadbase, u_completion);
+		err =3D xnshadow_map(&task->threadbase, u_completion,
+				   XNPOD_ALL_CPUS);
 	} else {
 		/* Unblock and pass back error code. */
=20
Index: xenomai/ksrc/skins/vrtx/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vrtx/syscall.c
+++ xenomai/ksrc/skins/vrtx/syscall.c
@@ -95,7 +95,8 @@ static int __sc_tecreate(struct task_str
 	} else {
 		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs),
 				  &tid, sizeof(tid));
-		err =3D xnshadow_map(&task->threadbase, u_completion);
+		err =3D xnshadow_map(&task->threadbase, u_completion,
+				   XNPOD_ALL_CPUS);
 	}
=20
 	if (err)
Index: xenomai/ksrc/skins/vxworks/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/vxworks/syscall.c
+++ xenomai/ksrc/skins/vxworks/syscall.c
@@ -122,7 +122,8 @@ static int __wind_task_init(struct task_
 		ph.handle =3D xnthread_handle(&task->threadbase);
 		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs), &ph,
 				  sizeof(ph));
-		err =3D xnshadow_map(&task->threadbase, u_completion);
+		err =3D xnshadow_map(&task->threadbase, u_completion,
+				   XNPOD_ALL_CPUS);
 	} else {
 		/* Unblock and pass back error code. */
=20

--------------050106000207070109060605--

--------------enig9D9AA8A2B819FC6C42FE0280
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbD75niDOoMHTA+kRAlYiAJkB2PXlRdsBLoUrfCpLThPedfhn8wCfUaI9
2XTOvGW3aDyeDWzIqxaRwy8=
=8GC/
-----END PGP SIGNATURE-----

--------------enig9D9AA8A2B819FC6C42FE0280--

