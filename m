Message-ID: <4A62D2B8.8030907@domain.hid>
Date: Sun, 19 Jul 2009 10:00:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A62D1C1.9050807@domain.hid>
In-Reply-To: <4A62D1C1.9050807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3BC3B926ACEC951AA750764B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/3] x86-64: Work around gcc issues with
 populating syscall registers
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3BC3B926ACEC951AA750764B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

gcc-4.1.3 of kubuntu has problem with proper syscall register
initialization in rt_task_shadow if TLS is enabled. But it is likely
that more compiler versions below 4.3 and more configuration variants
are affected.

This patch installs a workaround for these gcc versions which places an
optimization barrier before the register variable setup. This forces gcc
to actually load the registers.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-x86/syscall_64.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/syscall_64.h b/include/asm-x86/syscall_64.h
index adaa40b..6918ac4 100644
--- a/include/asm-x86/syscall_64.h
+++ b/include/asm-x86/syscall_64.h
@@ -82,7 +82,11 @@ static inline int __xn_interrupted_p(struct pt_regs *r=
egs)
  * in kernel space.
  */
=20
+#if __GNUC__ < 4 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ < 3)
+#define LOAD_ARGS_0()	asm volatile ("" ::: "memory");
+#else
 #define LOAD_ARGS_0()
+#endif
 #define LOAD_REGS_0
 #define ASM_ARGS_0
=20


--------------enig3BC3B926ACEC951AA750764B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpi0rgACgkQniDOoMHTA+lQnwCfeQPR7X4EgDBpxwsMM/g+AdEA
pSsAoIOTvKlnqnHIUUcpzbXNzNsbc+cB
=y/hF
-----END PGP SIGNATURE-----

--------------enig3BC3B926ACEC951AA750764B--

