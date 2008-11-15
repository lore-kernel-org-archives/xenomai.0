Message-ID: <491F432D.80702@domain.hid>
Date: Sat, 15 Nov 2008 22:46:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF2955742AA2BCC5EE6C0F49F"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] x86: Fix root state corruptions
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
--------------enigF2955742AA2BCC5EE6C0F49F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Only fair: I touched this code a few times recently while
re-enabling KGDB support, but I didn't noticed this lethal bug. Now I
had to hunt it for half a day.

What was wrong should be obvious. Its effect was a spuriously unstalled
root domain once in a while after we handled a fault over a non-root
domain. Fortunately this is a corner case - unless you use the FPU in
userspace (initial usage fault...).

Patch is (still) against 2.6.26, but it is required for all recent
i386/x86_64/x86 ipipe versions, from 2.6.23 to 2.6.27.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/ipipe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/arch/x86/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -751,7 +751,7 @@ int __ipipe_handle_exception(struct pt_r
 	if (!ipipe_root_domain_p &&
 	    __ipipe_xlate_signo[vector] >=3D 0 &&
 	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_c=
ode, regs)) {
-		if (!flags)
+		if (flags & X86_EFLAGS_IF)
 			__clear_bit(IPIPE_STALL_FLAG,
 				    &ipipe_root_cpudom_var(status));
 		return 1;
@@ -759,7 +759,7 @@ int __ipipe_handle_exception(struct pt_r
 #endif /* CONFIG_KGDB */
=20
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		if (!flags)
+		if (flags & X86_EFLAGS_IF)
 			__clear_bit(IPIPE_STALL_FLAG,
 				    &ipipe_root_cpudom_var(status));
 		return 1;


--------------enigF2955742AA2BCC5EE6C0F49F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkkfQzIACgkQniDOoMHTA+myRQCeLTXlaRhuOSmtC15zlXsU7PJJ
NSUAn0urm24JChopn1qI0/zswaPzcTxS
=qvqB
-----END PGP SIGNATURE-----

--------------enigF2955742AA2BCC5EE6C0F49F--

