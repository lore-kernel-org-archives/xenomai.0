Message-ID: <43F1D2DE.2020305@domain.hid>
Date: Tue, 14 Feb 2006 13:53:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9681BE3C90DF00A314628238"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix warnings on !XENO_OPT_NATIVE_REGISTRY
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
--------------enig9681BE3C90DF00A314628238
Content-Type: multipart/mixed; boundary="------------080106020309020609090600"

This is a multi-part message in MIME format.
--------------080106020309020609090600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

this patch addresses the compiler warnings when
CONFIG_XENO_OPT_NATIVE_REGISTRY is switched off.

Jan

--------------080106020309020609090600
Content-Type: text/plain;
 name="config_warnings.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="config_warnings.patch"

Index: ksrc/skins/native/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/mutex.c	(revision 564)
+++ ksrc/skins/native/mutex.c	(working copy)
@@ -106,7 +106,7 @@
     .write_proc =3D NULL
 };
=20
-#elif CONFIG_XENO_OPT_NATIVE_REGISTRY
+#elif defined(CONFIG_XENO_OPT_NATIVE_REGISTRY)
=20
 static RT_OBJECT_PROCNODE __mutex_pnode =3D {
=20
Index: ksrc/skins/native/heap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/heap.c	(revision 564)
+++ ksrc/skins/native/heap.c	(working copy)
@@ -106,7 +106,7 @@
     .write_proc =3D NULL
 };
=20
-#elif CONFIG_XENO_OPT_NATIVE_REGISTRY
+#elif defined(CONFIG_XENO_OPT_NATIVE_REGISTRY)
=20
 static RT_OBJECT_PROCNODE __heap_pnode =3D {
=20
Index: ksrc/skins/native/event.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/event.c	(revision 564)
+++ ksrc/skins/native/event.c	(working copy)
@@ -99,7 +99,7 @@
     .write_proc =3D NULL
 };
=20
-#elif CONFIG_XENO_OPT_NATIVE_REGISTRY
+#elif defined(CONFIG_XENO_OPT_NATIVE_REGISTRY)
=20
 static RT_OBJECT_PROCNODE __event_pnode =3D {
=20
Index: ksrc/skins/native/cond.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/cond.c	(revision 564)
+++ ksrc/skins/native/cond.c	(working copy)
@@ -97,7 +97,7 @@
     .write_proc =3D NULL
 };
=20
-#elif CONFIG_XENO_OPT_NATIVE_REGISTRY
+#elif defined(CONFIG_XENO_OPT_NATIVE_REGISTRY)
=20
 static RT_OBJECT_PROCNODE __cond_pnode =3D {
=20
Index: ksrc/skins/native/sem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/sem.c	(revision 564)
+++ ksrc/skins/native/sem.c	(working copy)
@@ -100,7 +100,7 @@
     .write_proc =3D NULL
 };
=20
-#elif CONFIG_XENO_OPT_NATIVE_REGISTRY
+#elif defined(CONFIG_XENO_OPT_NATIVE_REGISTRY)
=20
 static RT_OBJECT_PROCNODE __sem_pnode =3D {
=20
Index: ksrc/skins/native/queue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/queue.c	(revision 564)
+++ ksrc/skins/native/queue.c	(working copy)
@@ -103,7 +103,7 @@
     .write_proc =3D NULL
 };
=20
-#elif CONFIG_XENO_OPT_NATIVE_REGISTRY
+#elif defined(CONFIG_XENO_OPT_NATIVE_REGISTRY)
=20
 static RT_OBJECT_PROCNODE __queue_pnode =3D {
=20
Index: ksrc/skins/native/alarm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/alarm.c	(revision 564)
+++ ksrc/skins/native/alarm.c	(working copy)
@@ -94,7 +94,7 @@
     .write_proc =3D NULL
 };
=20
-#elif CONFIG_XENO_OPT_NATIVE_REGISTRY
+#elif defined(CONFIG_XENO_OPT_NATIVE_REGISTRY)
=20
 static RT_OBJECT_PROCNODE __alarm_pnode =3D {
=20
Index: ksrc/skins/native/pipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/pipe.c	(revision 564)
+++ ksrc/skins/native/pipe.c	(working copy)
@@ -71,7 +71,7 @@
     .link_proc =3D &__pipe_link_proc,
 };
=20
-#elif CONFIG_XENO_OPT_NATIVE_REGISTRY
+#elif defined(CONFIG_XENO_OPT_NATIVE_REGISTRY)
=20
 static RT_OBJECT_PROCNODE __pipe_pnode =3D {
=20

--------------080106020309020609090600--

--------------enig9681BE3C90DF00A314628238
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8dLeniDOoMHTA+kRAiwrAJ9g5n5ACRhLPf21SBWU+9QsoGfw5QCePdSh
kjW7cMFAenE3kVpBnFUsNr4=
=ID7Q
-----END PGP SIGNATURE-----

--------------enig9681BE3C90DF00A314628238--

