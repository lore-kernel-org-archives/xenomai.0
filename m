Message-ID: <44CB2884.80801@domain.hid>
Date: Sat, 29 Jul 2006 11:21:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5D859A6981BC23E3043DF785"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] detect conflict with INPUT_PCSPKR
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
--------------enig5D859A6981BC23E3043DF785
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is a simple patch to catch the very rare but fatal conflict between
Xenomai's TSC emulation and the PC speaker driver on 2.6/x86.

Jan


--- include/asm-i386/hal.h      (Revision 1390)
+++ include/asm-i386/hal.h      (Arbeitskopie)
@@ -169,6 +169,11 @@ static inline unsigned long long rthal_r
     return t;
 }
 #else  /* !CONFIG_X86_TSC */
+#if defined(CONFIG_INPUT_PCSPKR) || defined(CONFIG_INPUT_PCSPKR_MODULE)
+#error Please disable PC speaker driver (CONFIG_INPUT_PCSPKR).
+#error It conflicts with Xenomai's TSC emulation.
+#endif /* CONFIG_INPUT_PCSPKR */
+
 #define RTHAL_8254_COUNT2LATCH  0xfffe
 void rthal_setup_8254_tsc(void);
 rthal_time_t rthal_get_8254_tsc(void);



--------------enig5D859A6981BC23E3043DF785
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEyyiIniDOoMHTA+kRAr3QAJ9mZJUjyGYFlwg+WxZ+skMCjqwoVACfczrZ
bBi4y21pkWErLPdXKrLL4jA=
=uDmE
-----END PGP SIGNATURE-----

--------------enig5D859A6981BC23E3043DF785--

