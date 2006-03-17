Message-ID: <441ABA73.2020903@domain.hid>
Date: Fri, 17 Mar 2006 14:32:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig65B1468E4E3827C55D2F18B4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH] security check for skin access
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
--------------enig65B1468E4E3827C55D2F18B4
Content-Type: multipart/mixed; boundary="------------060405070900050503070406"

This is a multi-part message in MIME format.
--------------060405070900050503070406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

you all may know that Xenomai provides a bulk of very powerful
interfaces to userspace real-time applications. But not everyone may
have thought about the fact yet that these syscall extensions are
accessible for *all* users in the system!

Well, real-time and security is a more complex topic, but we should at
least restore the same level of security which Linux provides. For this
purpose, the attached (and long-planned) patch adds basic access control
to all Xenomai skin services by requiring CAP_SYS_NICE, i.e. the same
capability that is also required to manipulate the normal Linux
scheduling parameters.

I would suggest to merge it, either as an option (with default=3Dy), or
unconditionally (it's just a tiny additional check in the syscall path).

Jan

--------------060405070900050503070406
Content-Type: text/plain;
 name="security.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="security.patch"

Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(revision 719)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1141,6 +1141,12 @@ static inline int do_hisyscall_event (un
     if (!__xn_reg_mux_p(regs))
 	goto linux_syscall;
=20
+    if (unlikely(!cap_raised(p->cap_effective, CAP_SYS_NICE)))
+	{
+	__xn_error_return(regs,-EPERM);
+	return RTHAL_EVENT_STOP;
+	}
+
     muxid =3D __xn_mux_id(regs);
     muxop =3D __xn_mux_op(regs);
=20

--------------060405070900050503070406--

--------------enig65B1468E4E3827C55D2F18B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGrpzniDOoMHTA+kRAqFZAJ9tHWrErdPobwvh97gl3YQwjtCIRQCfXU8l
3pcLHE7OnTL41KOzUmXvSlI=
=oAB0
-----END PGP SIGNATURE-----

--------------enig65B1468E4E3827C55D2F18B4--

