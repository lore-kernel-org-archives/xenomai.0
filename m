Message-ID: <47123669.8000008@domain.hid>
Date: Sun, 14 Oct 2007 17:31:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16DD6D010B013E52FDBEFB2A"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Fix cleanup of timebase proc entries
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
--------------enig16DD6D010B013E52FDBEFB2A
Content-Type: multipart/mixed;
 boundary="------------090301050303050708080806"

This is a multi-part message in MIME format.
--------------090301050303050708080806
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Let's see how this works out: I've started to post my patches also to
the bug tracker at gna.org.

This one here fixes the broken cleanup of timerstat proc entries. Not
sure if I have caused the whole problem, but at least significant parts
of it. :-]

Jan

--------------090301050303050708080806
Content-Type: text/x-patch;
 name="fix-timebase-proc-cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-timebase-proc-cleanup.patch"

---
 ChangeLog                  |    5 +++++
 include/nucleus/timebase.h |    2 +-
 ksrc/nucleus/module.c      |   20 ++++++--------------
 3 files changed, 12 insertions(+), 15 deletions(-)

Index: xenomai/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -1,3 +1,8 @@
+2007-10-14  Jan Kiszka <jan.kiszka@domain.hid>
+
+	* include/nucleus/timebase.h, ksrc/nucleus/modules.c: Fix cleanup of
+	timebase proc entries.
+
 2007-10-11  Johan Borkhuis  <j.borkhuis@domain.hid>
=20
 	* include/rtdm/rtdm_driver.h: Add private data pointer to rtdm_device
Index: xenomai/include/nucleus/timebase.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/timebase.h
+++ xenomai/include/nucleus/timebase.h
@@ -363,7 +363,7 @@ do {						\
=20
 #define xntbase_umount()			\
 do {						\
-	xnpod_declare_tbase_proc(&nktbase);	\
+	xnpod_discard_tbase_proc(&nktbase);	\
 	removeq(&nktimebaseq, &nktbase.link);	\
 } while (0)
=20
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -1082,18 +1082,10 @@ void xnpod_delete_proc(void)
 	remove_proc_entry("latency", rthal_proc_root);
 	remove_proc_entry("sched", rthal_proc_root);
 #ifdef CONFIG_XENO_OPT_STATS
-	{
-		xnholder_t *holder;
-		xntbase_t *tbase;
-
-		for (holder =3D getheadq(&nktimebaseq);
-		     holder !=3D NULL; holder =3D nextq(&nktimebaseq, holder)) {
-			tbase =3D link2tbase(holder);
-			remove_proc_entry(tbase->name, tmstat_proc_root);
-		}
-		remove_proc_entry("timerstat", rthal_proc_root);
-		remove_proc_entry("stat", rthal_proc_root);
-	}
+	/* All timebases must have been deregistered now. */
+	XENO_ASSERT(NUCLEUS, !getheadq(&nktimebaseq), ;);
+	remove_proc_entry("timerstat", rthal_proc_root);
+	remove_proc_entry("stat", rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_STATS */
 #if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
 	remove_proc_entry("lock", rthal_proc_root);
@@ -1242,6 +1234,8 @@ void __exit __xeno_sys_exit(void)
 	xnshadow_cleanup();
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20
+	xntbase_umount();
+
 #if defined(__KERNEL__) &&  defined(CONFIG_PROC_FS)
 	xnpod_delete_proc();
 #endif /* __KERNEL__ && CONFIG_PROC_FS */
@@ -1260,8 +1254,6 @@ void __exit __xeno_sys_exit(void)
 #endif /* CONFIG_LTT */
 #endif /* __KERNEL__ */
=20
-	xntbase_umount();
-
 	if (nkmsgbuf)
 		xnarch_free_host_mem(nkmsgbuf, XNPOD_FATAL_BUFSZ);
=20

--------------090301050303050708080806--

--------------enig16DD6D010B013E52FDBEFB2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFHEjZsniDOoMHTA+kRAqijAJ9U2Tq1Zx30n/lTrneatDNCmQrvEgCWJ5+8
fVAmZjdTtWYt1Gl1ERJIuw==
=yORK
-----END PGP SIGNATURE-----

--------------enig16DD6D010B013E52FDBEFB2A--

