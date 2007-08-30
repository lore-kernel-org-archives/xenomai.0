Message-ID: <46D66DA5.9030100@domain.hid>
Date: Thu, 30 Aug 2007 09:11:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC31CD54F205E40BA180BBFEB"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] Introduce xntbase_ns2ticks_ceil
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
Cc: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC31CD54F205E40BA180BBFEB
Content-Type: multipart/mixed;
 boundary="------------000308040308040502010008"

This is a multi-part message in MIME format.
--------------000308040308040502010008
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This introduces a round-up-variant of xntbase_ns2ticks. It is uninlined
for the non-trivial case due to its text size. Its only user will be
RTDM for now, but maybe the POSIX skin can use it as well.

Philippe, if you accept this one, I'll handle the RTDM side myself.

Jan

--------------000308040308040502010008
Content-Type: text/plain;
 name="xntbase_ns2ticks_ceil.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xntbase_ns2ticks_ceil.patch"

---
 include/nucleus/timebase.h |    7 +++++++
 ksrc/nucleus/timebase.c    |    7 +++++++
 2 files changed, 14 insertions(+)

Index: xenomai/include/nucleus/timebase.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/timebase.h
+++ xenomai/include/nucleus/timebase.h
@@ -148,6 +148,8 @@ static inline xnticks_t xntbase_ns2ticks
 	return xnarch_ulldiv(t, xntbase_get_tickval(base), NULL);
 }
=20
+xnticks_t xntbase_ns2ticks_ceil(xntbase_t *base, xntime_t t);
+
 static inline int xntbase_master_p(xntbase_t *base)
 {
 	return base =3D=3D &nktbase;
@@ -247,6 +249,11 @@ static inline xnticks_t xntbase_ns2ticks
 	return t;
 }
=20
+static inline xnticks_t xntbase_ns2ticks_ceil(xntbase_t *base, xntime_t =
t)
+{
+	return t;
+}
+
 static inline int xntbase_master_p(xntbase_t *base)
 {
 	return 1;
Index: xenomai/ksrc/nucleus/timebase.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timebase.c
+++ xenomai/ksrc/nucleus/timebase.c
@@ -483,6 +483,12 @@ void xntbase_tick(xntbase_t *base)
 	xnlock_put_irqrestore(&nklock, s);
 }
=20
+xnticks_t xntbase_ns2ticks_ceil(xntbase_t *base, xntime_t t)
+{
+	return xnarch_ulldiv(t + xntbase_get_tickval(base) - 1,
+			     xntbase_get_tickval(base), NULL);
+}
+
 EXPORT_SYMBOL(xntbase_alloc);
 EXPORT_SYMBOL(xntbase_free);
 EXPORT_SYMBOL(xntbase_update);
@@ -490,6 +496,7 @@ EXPORT_SYMBOL(xntbase_switch);
 EXPORT_SYMBOL(xntbase_start);
 EXPORT_SYMBOL(xntbase_stop);
 EXPORT_SYMBOL(xntbase_tick);
+EXPORT_SYMBOL(xntbase_ns2ticks_ceil);
=20
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
=20

--------------000308040308040502010008--

--------------enigC31CD54F205E40BA180BBFEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1m2lniDOoMHTA+kRAmKeAKCDYuh/ER8qhezx9cQpb+kQktuh4wCfVLql
VKuC+wzNOKGqCkVMstaaD6k=
=TCIo
-----END PGP SIGNATURE-----

--------------enigC31CD54F205E40BA180BBFEB--

