Message-ID: <4AB4C0C1.7000708@domain.hid>
Date: Sat, 19 Sep 2009 13:30:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1441C62225F07AEFF1329D22"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PULL REQUEST] x86-hal: Include fix for NMI watchdog
	on 2.6.31
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1441C62225F07AEFF1329D22
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 280f42f0874d00b8ea0ca8b966e568604eec17=
f0:
  Jan Kiszka (1):
        rtipc: Fix 64-bit related warnings

are available in the git repository at:

  git://xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      	x86-hal: Include fix for NMI watchdog on 2.6.31

 ksrc/arch/x86/nmi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

---

x86-hal: Include fix for NMI watchdog on 2.6.31
   =20
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

diff --git a/ksrc/arch/x86/nmi.c b/ksrc/arch/x86/nmi.c
index a9d9380..19cd16f 100644
--- a/ksrc/arch/x86/nmi.c
+++ b/ksrc/arch/x86/nmi.c
@@ -29,7 +29,9 @@
 #include <linux/version.h>
 #include <linux/nmi.h>
 #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
-#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,19)
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,31)
+#include <asm/perf_counter.h>
+#elif LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,19)
 #include <asm/intel_arch_perfmon.h>
 #endif /* Linux < 2.6.19 */
 #include <asm/nmi.h>


--------------enig1441C62225F07AEFF1329D22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkq0wMoACgkQitSsb3rl5xTO/wCZAZEdlZ50z3GjxeF8JsQV1Jjn
jVoAoLfnWpkDv09gW9MQvkV1Cr3SEy8H
=oCay
-----END PGP SIGNATURE-----

--------------enig1441C62225F07AEFF1329D22--

