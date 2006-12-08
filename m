Message-ID: <45795DE1.70000@domain.hid>
Date: Fri, 08 Dec 2006 13:43:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot: Failure building Xenomai kernel for
	TQM860
References: <200612081309.31003.niklaus.giger@domain.hid>
	<45795D28.8010606@domain.hid>
In-Reply-To: <45795D28.8010606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2367CF6AD0EAEC623AF431AB"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2367CF6AD0EAEC623AF431AB
Content-Type: multipart/mixed; boundary="------------090500040809080704010104"

This is a multi-part message in MIME format.
--------------090500040809080704010104
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Niklaus,
>=20
> I just compiled my Linux 2.4 kernel for TQM860L with the latest revisio=
n
> of Xenomai and I cannot reproduce your problem. In you linker path ther=
e
> are no Xenomai objects. How does it come? Do you use --arch=3Dppc with
> prepare_kernel (--arch=3Dpowerpc is not valid any more for the ppc tree=
).
>=20

The problem pops up with CONFIG_XENO_OPT_SCALABLE_SCHED.

The definition of xnlogerr is not visible to queue.h, namely to the
inline function getmlq. Here is possible solution at XENO_ASSERT level.

Jan

--------------090500040809080704010104
Content-Type: text/plain;
 name="assert-with-xnarch_logerr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="assert-with-xnarch_logerr.patch"

Index: include/nucleus/assert.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/assert.h	(revision 1930)
+++ include/nucleus/assert.h	(working copy)
@@ -27,7 +27,7 @@
 #define XENO_ASSERT(subsystem,cond,action)  do { \
     if (unlikely(CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && !(cond))) { \
         xnarch_trace_panic_freeze(); \
-        xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __LINE__,=
 (#cond)); \
+        xnarch_logerr("assertion failed at %s:%d (%s)\n", __FILE__, __LI=
NE__, (#cond)); \
         xnarch_trace_panic_dump(); \
         action; \
     } \

--------------090500040809080704010104--

--------------enig2367CF6AD0EAEC623AF431AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeV3hncNeS9Q0k+IRAnM9AKCUpRPVjdDFn35LsprcgGUOzcIQEACeLSJW
p1daJdkZ5/B27okasYtbr6c=
=ysBN
-----END PGP SIGNATURE-----

--------------enig2367CF6AD0EAEC623AF431AB--

