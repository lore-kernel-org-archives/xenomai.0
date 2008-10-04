Message-ID: <48E76494.9030901@domain.hid>
Date: Sat, 04 Oct 2008 14:41:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3B8B68C8B8B716772C432F5E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] gdb lockup on multi-threaded process exit
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
--------------enig3B8B68C8B8B716772C432F5E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I'm banging my head against this issue for several days now, first
trying to sort out an unrelated bug I also came across at this chance,
then trying to understand what happens, and finally getting mad about
why this may only happen with Xenomai:

One process, two threads, running under gdb control (no breakpoints,
just the automatically set ones that track thread creation/destruction).
All happens already with only one CPU. The first thread decides to issue
exit() exactly while the second one is on its way from primary to
secondary mode due to running on a breakpoint (int3 -> xnpod_trap_fault
-> xnshadow_relax...). The group exit of thread A causes SIGKILL to be
set in thread B, but triggers no further actions due to B already being
awake and on its way to queue and handle the other signal (SIGTRAP). Now
when B comes to dequeue the next signal it finds SIGTRAP and SIGKILL
set, but picks up SIGTRAP due to its lower number. Now ptrace causes B
to stop, gdb gets confused, sends A, which is already a zombie, a
SIGSTOP and waits on it to confirm this stop - which never happens. If
someone is interested, I can provide an LTTng dump of this scenario.

My problem is now that I still don't understand what prevents this
deadlock on vanilla Linux. Does Xenomai create a thread schedule here
that is impossible there? Or does it only widens an otherwise very
small race window that also exists with mainline? Before making a fool
of my self on LKML, I would like to collect some further ideas on the
workaround or fix(?) below that cures this deadlock for me.

Thanks,
Jan

---
 kernel/signal.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

Index: b/kernel/signal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1486,10 +1486,24 @@ static void do_notify_parent_cldstop(str
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
=20
+/*
+ * Return nonzero if there is a SIGKILL that should be waking us up.
+ * Called with the siglock held.
+ */
+static int sigkill_pending(struct task_struct *tsk)
+{
+	return ((sigismember(&tsk->pending.signal, SIGKILL) ||
+		 sigismember(&tsk->signal->shared_pending.signal, SIGKILL)) &&
+		!unlikely(sigismember(&tsk->blocked, SIGKILL)));
+}
+
 static inline int may_ptrace_stop(void)
 {
 	if (!likely(current->ptrace & PT_PTRACED))
 		return 0;
+
+	if (unlikely(sigkill_pending(current)))
+		return 0;
 	/*
 	 * Are we in the middle of do_coredump?
 	 * If so and our tracer is also part of the coredump stopping
@@ -1507,17 +1521,6 @@ static inline int may_ptrace_stop(void)
 }
=20
 /*
- * Return nonzero if there is a SIGKILL that should be waking us up.
- * Called with the siglock held.
- */
-static int sigkill_pending(struct task_struct *tsk)
-{
-	return ((sigismember(&tsk->pending.signal, SIGKILL) ||
-		 sigismember(&tsk->signal->shared_pending.signal, SIGKILL)) &&
-		!unlikely(sigismember(&tsk->blocked, SIGKILL)));
-}
-
-/*
  * This must be called with current->sighand->siglock held.
  *
  * This should be the path for all ptrace stops.


--------------enig3B8B68C8B8B716772C432F5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjnZJoACgkQniDOoMHTA+lcNQCfcJYLiUj0PncA/XOuTgYsOVKT
iXoAn1uI8k0w9bB+PlTDGHHLX+PSJ7YJ
=2lAu
-----END PGP SIGNATURE-----

--------------enig3B8B68C8B8B716772C432F5E--

