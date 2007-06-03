Message-ID: <466288AF.6080708@domain.hid>
Date: Sun, 03 Jun 2007 11:23:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB88041B5663C95D73C163461"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] Don't remove_proc_entry under nklock
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
--------------enigB88041B5663C95D73C163461
Content-Type: multipart/mixed;
 boundary="------------020000000400020405070808"

This is a multi-part message in MIME format.
--------------020000000400020405070808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


--------------020000000400020405070808
Content-Type: text/x-patch;
 name="fix-iface-proc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-iface-proc.patch"

---
 ChangeLog             |    3 +++
 ksrc/nucleus/module.c |    5 ++---
 ksrc/nucleus/shadow.c |   14 +++++++++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -115,7 +115,7 @@ static int nucleus_muxid =3D -1;
=20
 void xnpod_declare_iface_proc(struct xnskentry *iface);
=20
-void xnpod_discard_iface_proc(struct xnskentry *iface);
+void xnpod_discard_iface_proc(const char *iface);
=20
 #ifdef CONFIG_XENO_OPT_PRIOCPL
=20
@@ -2266,7 +2266,7 @@ int xnshadow_register_interface(const ch
 }
=20
 /*
- * xnshadow_unregister_interface() -- Unregister a new skin/interface.
+ * xnshadow_unregister_interface() -- Unregister a skin/interface.
  * NOTE: an interface can be unregistered without its pod being
  * necessarily active.
  */
@@ -2287,7 +2287,15 @@ int xnshadow_unregister_interface(int mu
 		muxtable[muxid].magic =3D 0;
 		xnarch_atomic_set(&muxtable[muxid].refcnt, -1);
 #ifdef CONFIG_PROC_FS
-		xnpod_discard_iface_proc(muxtable + muxid);
+		{
+			const char *name =3D muxtable[muxid].name;
+			muxtable[muxid].proc =3D NULL;
+			xnlock_put_irqrestore(&nklock, s);
+
+			xnpod_discard_iface_proc(name);
+
+			return 0;
+		}
 #endif /* CONFIG_PROC_FS */
 	} else
 		err =3D -EBUSY;
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -939,10 +939,9 @@ void xnpod_declare_iface_proc(struct xns
 				    iface_proc_root);
 }
=20
-void xnpod_discard_iface_proc(struct xnskentry *iface)
+void xnpod_discard_iface_proc(const char *iface_name)
 {
-	remove_proc_entry(iface->name, iface_proc_root);
-	iface->proc =3D NULL;
+	remove_proc_entry(iface_name, iface_proc_root);
 }
=20
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
Index: xenomai/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -3,6 +3,9 @@
 	* ksrc/skins/rtdm/device.c (rtdm_dev_register): Unconditinally
 	check if mandatory close_nrt is provided.
=20
+	* ksrc/nucleus/{module.c, shadow.c}: Move remove_proc_entry out of
+	nklock.
+
 2007-06-02  Philippe Gerum  <rpm@xenomai.org>
=20
 	* ksrc/skins/psos+, src/skins/psos+, include/psos+/psos.h: Add

--------------020000000400020405070808--

--------------enigB88041B5663C95D73C163461
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGYoi0niDOoMHTA+kRAiuSAJ44UcdSw9s1zeStfLaQdzUr8qS7JgCfUUlk
An8QPxJrnwjFGy1q2ETKe2k=
=2zk4
-----END PGP SIGNATURE-----

--------------enigB88041B5663C95D73C163461--

