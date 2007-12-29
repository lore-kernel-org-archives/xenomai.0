Message-ID: <4776D45C.80207@domain.hid>
Date: Sun, 30 Dec 2007 00:12:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6589A63433FE845AA2A3077C"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 1/5] x86: optimize access to __ipipe_tick_regs
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
--------------enig6589A63433FE845AA2A3077C
Content-Type: multipart/mixed;
 boundary="------------020405080301070001010807"

This is a multi-part message in MIME format.
--------------020405080301070001010807
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

By intention, the compiler is not able to fold succeeding accesses to
via __raw_get_cpu_var & friends into a single one. As we are in an
atomic section in __ipipe_handle_irq, let's help him with a temporary
variable, saving some text size in this hotpath.

Jan

--------------020405080301070001010807
Content-Type: text/x-patch;
 name="optimize-regs-saving.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimize-regs-saving.patch"

---
 arch/x86/kernel/ipipe_32.c |    9 +++++----
 arch/x86/kernel/ipipe_64.c |   13 +++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

Index: linux-2.6.24-rc6-xeno/arch/x86/kernel/ipipe_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno.orig/arch/x86/kernel/ipipe_32.c
+++ linux-2.6.24-rc6-xeno/arch/x86/kernel/ipipe_32.c
@@ -771,10 +771,11 @@ finalize:
 	 * information. */
=20
 	if (irq =3D=3D __ipipe_tick_irq) {
-		__raw_get_cpu_var(__ipipe_tick_regs).eflags =3D regs.eflags;
-		__raw_get_cpu_var(__ipipe_tick_regs).eip =3D regs.eip;
-		__raw_get_cpu_var(__ipipe_tick_regs).xcs =3D regs.xcs;
-		__raw_get_cpu_var(__ipipe_tick_regs).ebp =3D regs.ebp;
+		struct pt_regs *tick_regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
+		tick_regs->eflags =3D regs.eflags;
+		tick_regs->xcs =3D regs.xcs;
+		tick_regs->eip =3D regs.eip;
+		tick_regs->ebp =3D regs.ebp;
 	}
=20
 	/*
Index: linux-2.6.24-rc6-xeno/arch/x86/kernel/ipipe_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno.orig/arch/x86/kernel/ipipe_64.c
+++ linux-2.6.24-rc6-xeno/arch/x86/kernel/ipipe_64.c
@@ -751,12 +751,13 @@ int __ipipe_handle_irq(struct pt_regs *r
 finalize:
=20
 	if (irq =3D=3D __ipipe_tick_irq) {
-		__raw_get_cpu_var(__ipipe_tick_regs).rip =3D regs->rip;
-		__raw_get_cpu_var(__ipipe_tick_regs).cs =3D regs->cs;
-		__raw_get_cpu_var(__ipipe_tick_regs).eflags =3D regs->eflags;
-		__raw_get_cpu_var(__ipipe_tick_regs).rbp =3D regs->rbp;
-		__raw_get_cpu_var(__ipipe_tick_regs).rsp =3D regs->rsp;
-		__raw_get_cpu_var(__ipipe_tick_regs).ss =3D regs->ss;
+		struct pt_regs *tick_regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
+		tick_regs->ss =3D regs->ss;
+		tick_regs->rsp =3D regs->rsp;
+		tick_regs->eflags =3D regs->eflags;
+		tick_regs->cs =3D regs->cs;
+		tick_regs->rip =3D regs->rip;
+		tick_regs->rbp =3D regs->rbp;
 	}
=20
 	/*

--------------020405080301070001010807--

--------------enig6589A63433FE845AA2A3077C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdtRcniDOoMHTA+kRAlPeAJ0Qt05MRy/ajWNxngz2/NnvktAk2gCeLhwM
1Ro7bmq9S+zq/Zkge0WNF0k=
=lBed
-----END PGP SIGNATURE-----

--------------enig6589A63433FE845AA2A3077C--

