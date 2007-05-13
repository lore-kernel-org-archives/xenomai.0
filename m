Message-ID: <4646E606.8050505@domain.hid>
Date: Sun, 13 May 2007 12:18:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC814BB49FF2DF13B591CD11D"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] cleanup legacy sched hacks
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC814BB49FF2DF13B591CD11D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I don't think we need those two legacy hacks anymore as we killed
preempt_disable/enable calls over non-root domain. I converted them
into context checks and got no warnings so far.

---
 kernel/sched.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

Index: linux-2.6.20/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/sched.c
+++ linux-2.6.20/kernel/sched.c
@@ -3422,10 +3422,8 @@ asmlinkage void __sched schedule(void)
 	long *switch_count;
 	struct rq *rq;
=20
-#ifdef CONFIG_IPIPE
-	if (unlikely(!ipipe_root_domain_p))
-		return;
-#endif /* CONFIG_IPIPE */
+	ipipe_check_context(ipipe_root_domain);
+
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
 	 * schedule() atomically, we ignore that path for now.
@@ -3600,11 +3598,8 @@ asmlinkage void __sched preempt_schedule
 	struct task_struct *task =3D current;
 	int saved_lock_depth;
 #endif
-#ifdef CONFIG_IPIPE
-	/* Do not reschedule over non-Linux domains. */
-	if (unlikely(!ipipe_root_domain_p))
-		return;
-#endif /* CONFIG_IPIPE */
+	ipipe_check_context(ipipe_root_domain);
+
 	/*
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task.  Just return..


--------------enigC814BB49FF2DF13B591CD11D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGRuYHniDOoMHTA+kRAjKiAJsG2i6eiFtk1NbuDlTaofCBp8ZZKACfWD3f
YXTGyZMpCIGHHEg9hGH28U0=
=2d7P
-----END PGP SIGNATURE-----

--------------enigC814BB49FF2DF13B591CD11D--

