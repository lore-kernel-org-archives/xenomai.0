Message-ID: <48FBB337.7080503@domain.hid>
Date: Mon, 20 Oct 2008 00:22:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC7EE7DE07328938B8F5975DA"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] x86-32: Cleanup redundant NMI wrapping
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7EE7DE07328938B8F5975DA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

We are now doing the housekeeping in nmi_enter/exit, so this hunk can
safely be reverted.

---
 arch/x86/kernel/traps_32.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: b/arch/x86/kernel/traps_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86/kernel/traps_32.c
+++ b/arch/x86/kernel/traps_32.c
@@ -836,21 +836,17 @@ static int ignore_nmis;
=20
 notrace __kprobes void do_nmi(struct pt_regs *regs, long error_code)
 {
-	int cpu, cs;
+	int cpu;
=20
 	nmi_enter();
=20
 	cpu =3D smp_processor_id();
=20
-	cs =3D ipipe_disable_context_check(cpu);
-=20
 	++nmi_count(cpu);
=20
 	if (!ignore_nmis)
 		default_do_nmi(regs);
=20
- 	ipipe_restore_context_check(cpu, cs);
-=20
 	nmi_exit();
 }
=20


--------------enigC7EE7DE07328938B8F5975DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj7szwACgkQniDOoMHTA+lSLQCdEzjb4vX8pqvHd0x7wa4rSE2n
XgEAn0ZZmIBIglMNE42hfh/QpYsI5R0a
=r6En
-----END PGP SIGNATURE-----

--------------enigC7EE7DE07328938B8F5975DA--

