Message-ID: <45A4DDA8.6090800@domain.hid>
Date: Wed, 10 Jan 2007 13:35:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
In-Reply-To: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C8948BAC723757FD32FFD21"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C8948BAC723757FD32FFD21
Content-Type: multipart/mixed; boundary="------------060006060003010205080302"

This is a multi-part message in MIME format.
--------------060006060003010205080302
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi all,
>=20
> I am just trying out the interrupt mechanism of Xenomai.
> For that, I have create a kernel module that uses rt_intr_create (from =
the native skin) to
> create an IRQ handler. So far that looks fine.
> However, I noticed, that I have to pass a non-NULL argument  name to rt=
_intr_create().
> Otherwise, cat /proc/xenomai/irq crashes with a kernel oops.
> I think this is a bug as the API documentation allows the usage of a NU=
LL name in rt_intr_create.
> Probably, the zero pointer will not be checked in the proc reading func=
tion.
> I am using 2.6.19.1 on a Pentium 4 (UP) with Xenomai 2.3.
>=20
> I have enclosed a minimum kernel module that leads to a kernel oops to =
see the effect.
>=20

Untested, but this patch should fix the issue - also for RTDM drivers
passing a NULL name to rtdm_irq_request (which was not forbidden so far
too). Nevertheless, passing a name is recommended to ease the system
diagnosis. Maybe the native doc should be changed in this regard too (I
already did so for RTDM in 2.3 and trunk).

Jan

--------------060006060003010205080302
Content-Type: text/plain;
 name="xnintr-handle-NULL-name.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xnintr-handle-NULL-name.patch"

Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(revision 2056)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2007-01-10  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/nucleus/intr.c (xnintr_init): Always set xnintr::name to
+	non-NULL content.
+
 2007-01-04  Philippe Gerum  <rpm@xenomai.org>
=20
 	* include/nucleus/timebase.h (xntbase_convert): Add time base
Index: ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/intr.c	(revision 2056)
+++ ksrc/nucleus/intr.c	(working copy)
@@ -490,7 +490,7 @@ int xnintr_mount(void) { return 0; }
  * therefore it must be allocated in permanent memory.
  *
  * @param name An ASCII string standing for the symbolic name of the
- * interrupt object.
+ * interrupt object or NULL ("<unknown>" will be applied then).
  *
  * @param irq The hardware interrupt channel associated with the
  * interrupt object. This value is architecture-dependent. An
@@ -541,7 +541,7 @@ int xnintr_init(xnintr_t *intr,
 	intr->isr =3D isr;
 	intr->iack =3D iack;
 	intr->cookie =3D NULL;
-	intr->name =3D name;
+	intr->name =3D name ? : "<unknown>";
 	intr->flags =3D flags;
 	intr->unhandled =3D 0;
 	memset(&intr->stat, 0, sizeof(intr->stat));

--------------060006060003010205080302--

--------------enig2C8948BAC723757FD32FFD21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpN2sniDOoMHTA+kRAvKxAJ96ZIt5IOHB8ema8mYpo2OA/3NvigCghPLL
/F6lWBQiJ+fLDNNKIfK8au4=
=HtEP
-----END PGP SIGNATURE-----

--------------enig2C8948BAC723757FD32FFD21--

