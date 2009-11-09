Message-ID: <4AF8A72E.1060204@domain.hid>
Date: Tue, 10 Nov 2009 00:35:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig48D1B4D24DB9829738381BE0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] hal: Ensure atomicity of
	rthal_local_irq_disabled
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
--------------enig48D1B4D24DB9829738381BE0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[Patch is now also available in 'for-upstream']

ipipe_test_pipeline_from is not atomic /wrt reading the current cpu
number (or an offset for the per-cpu area) and actually reading the
virtualized interrupt state. Work around this by disabling hard IRQs
while accessing this service.

This fixes false-positives of RTDM driver debug checks.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/hal.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index 97c549e..3095b85 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -117,7 +117,14 @@ typedef spinlock_t rthal_spinlock_t;
 #endif /* !CONFIG_XENO_OPT_PIPELINE_HEAD */
 #define rthal_local_irq_flags(x)	((x) =3D ipipe_test_pipeline_from(&rtha=
l_domain) & 1)
 #define rthal_local_irq_test()		ipipe_test_pipeline_from(&rthal_domain)
-#define rthal_local_irq_disabled()	ipipe_test_pipeline_from(&rthal_domai=
n)
+#define rthal_local_irq_disabled()				\
+({								\
+	unsigned long __flags, __ret;				\
+	local_irq_save_hw(__flags);				\
+	__ret =3D ipipe_test_pipeline_from(&rthal_domain);	\
+	local_irq_restore_hw(__flags);				\
+	__ret;							\
+})
 #define rthal_stage_irq_enable(dom)	ipipe_unstall_pipeline_from(dom)
 #define rthal_local_irq_save_hw(x)	local_irq_save_hw(x)
 #define rthal_local_irq_restore_hw(x)	local_irq_restore_hw(x)
--=20
1.6.0.2


--------------enig48D1B4D24DB9829738381BE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr4p1wACgkQitSsb3rl5xRMzgCgjeRzV40FUKFAGtNW2QCHWATW
BiEAoJkGwCiG7DLsuoF7uhgIs3xIV03s
=P3/S
-----END PGP SIGNATURE-----

--------------enig48D1B4D24DB9829738381BE0--

