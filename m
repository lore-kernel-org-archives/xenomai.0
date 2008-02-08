Message-ID: <47ACD0FF.8000601@domain.hid>
Date: Fri, 08 Feb 2008 23:00:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2B779B1A6A3B5ECC61AD7AB0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Optional timer freeze during ptracing
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B779B1A6A3B5ECC61AD7AB0
Content-Type: multipart/mixed;
 boundary="------------010101010108010301080406"

This is a multi-part message in MIME format.
--------------010101010108010301080406
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Freezing all Xenomai timers while just a single RT application is under
ptrace control can be helpful in certain debugging scenarios, but it can
as well be harmful when other parts of the systems have to continue to wo=
rk.

I brought this concern up back in 2006, and I originally thought we may
address this by freezing per process. But this is far too complex for a
simple problem like this: Just make the whole thing configurable, and
keep it off by default so that -ideally- only users who are aware of the
side effects will arm it.

Gilles, you recently stumbled over such a side effect and introduced
XNTIMER_NOBLCK (for customized timer instrumentations as far as I
understood this). Do you think we still need that knob when we have
CONFIG_XENO_OPT_PTRACE_TIMER_FREEZE?

Jan

--------------010101010108010301080406
Content-Type: text/x-patch;
 name="make-ptrace-timer-freeze-optional.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="make-ptrace-timer-freeze-optional.patch"

---
 ksrc/nucleus/Kconfig  |   14 ++++++++++++++
 ksrc/nucleus/shadow.c |   22 ++++++++--------------
 2 files changed, 22 insertions(+), 14 deletions(-)

Index: b/ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/Kconfig
+++ b/ksrc/nucleus/Kconfig
@@ -194,6 +194,20 @@ config XENO_OPT_DEBUG_TIMERS
 	This option activates debugging output for critical
 	timer-related operations performed by the Xenomai core.
=20
+config XENO_OPT_PTRACE_TIMER_FREEZE
+	bool "Freeze timers while debugging applications"
+	depends on XENO_OPT_DEBUG
+	help
+
+	If this feature is enabled, Xenomai no longer fires timers
+	while some real-time application is being debugged via
+	ptrace (gdb etc.). This can ease stepping through real-time
+	applications as it avoids certain types of timeouts to ocure
+	due to the debugging-related delays. On the other hand, this
+	global freeze can cause unwanted side-effects to other,
+	unrelated components in the system that rely on timers
+	continue to work.
+
 config XENO_OPT_WATCHDOG
 	bool "Watchdog support"
 	depends on XENO_OPT_DEBUG
Index: b/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -840,18 +840,6 @@ static inline void set_linux_task_priori
 		       prio, p->comm);
 }
=20
-static inline void lock_timers(void)
-{
-	xnarch_atomic_inc(&nkpod->timerlck);
-	setbits(nktbase.status, XNTBLCK);
-}
-
-static inline void unlock_timers(void)
-{
-	if (xnarch_atomic_dec_and_test(&nkpod->timerlck))
-		clrbits(nktbase.status, XNTBLCK);
-}
-
 static void xnshadow_dereference_skin(unsigned magic)
 {
 	unsigned muxid;
@@ -2199,6 +2187,7 @@ static inline void do_schedule_event(str
 		   SIGSTOP and SIGINT in order to encompass both the NPTL and
 		   LinuxThreads behaviours. */
=20
+#ifdef CONFIG_XENO_OPT_PTRACE_TIMER_FREEZE
 		if (xnthread_test_info(threadin, XNDEBUG)) {
 			if (signal_pending(next)) {
 				sigset_t pending;
@@ -2213,10 +2202,12 @@ static inline void do_schedule_event(str
 			}
=20
 			xnthread_clear_info(threadin, XNDEBUG);
-			unlock_timers();
+			if (xnarch_atomic_dec_and_test(&nkpod->timerlck))
+				clrbits(nktbase.status, XNTBLCK);
 		}
=20
 	      no_ptrace:
+#endif /* CONFIG_XENO_OPT_PTRACE_TIMER_FREEZE */
=20
 		if (XENO_DEBUG(NUCLEUS)) {
 			int sigpending =3D signal_pending(next);
@@ -2261,6 +2252,7 @@ static inline void do_sigwake_event(stru
=20
 	xnlock_get_irqsave(&nklock, s);
=20
+#ifdef CONFIG_XENO_OPT_PTRACE_TIMER_FREEZE
 	if ((p->ptrace & PT_PTRACED) && !xnthread_test_info(thread, XNDEBUG)) {=

 		sigset_t pending;
=20
@@ -2271,9 +2263,11 @@ static inline void do_sigwake_event(stru
 		    sigismember(&pending, SIGSTOP)
 		    || sigismember(&pending, SIGINT)) {
 			xnthread_set_info(thread, XNDEBUG);
-			lock_timers();
+			xnarch_atomic_inc(&nkpod->timerlck);
+			setbits(nktbase.status, XNTBLCK);
 		}
 	}
+#endif /* CONFIG_XENO_OPT_PTRACE_TIMER_FREEZE */
=20
 	if (xnthread_test_state(thread, XNRELAX))
 		goto unlock_and_exit;

--------------010101010108010301080406--

--------------enig2B779B1A6A3B5ECC61AD7AB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHrNEFniDOoMHTA+kRAgpkAJ49bdzLfWd3FBKI5ZhDXGhxTJ/wUACeNBj7
V2Zi0NcVg6uHJrIhnXLq9I0=
=zf3x
-----END PGP SIGNATURE-----

--------------enig2B779B1A6A3B5ECC61AD7AB0--

