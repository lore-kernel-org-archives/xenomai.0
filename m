Message-ID: <43BE5E3E.1060208@domain.hid>
Date: Fri, 06 Jan 2006 13:10:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9911318958EC44B5438EA57F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Oops, I broke something
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
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
--------------enig9911318958EC44B5438EA57F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Philippe,

my RTDM header "optimisation" broke the compilation of
testsuite/latency. I need an extra link for the userspace compilation
inside xeno now. Please apply this patch

--- configure.in        (Revision 372)
+++ configure.in        (Arbeitskopie)
@@ -348,6 +348,8 @@

 base=include
 AC_CONFIG_LINKS([src/include/xenomai:$base])
+base=rtdm
+AC_CONFIG_LINKS([src/include/$base:include/$base])
 base=asm-$XENO_TARGET_ARCH
 AC_CONFIG_LINKS([src/include/asm/xenomai:include/$base])
 base=asm-generic

and run bootstrap. Sorry.

But this raised the question to me again if we really need the "xenomai"
prefix for all the skin headers /from within xenomai/. Why not doing the
same linking dance for the other skins as well? Or do you also prefer
that user include <xenomai/native/task.h> instead of just <native/task.h>?

Jan

--------------enig9911318958EC44B5438EA57F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDvl4+niDOoMHTA+kRAm5FAJwOy+nve3qaCOw/B5HO/zH4C7gZvQCfV2ta
3WUlOEOU7OsxKEwLue42UEM=
=Orww
-----END PGP SIGNATURE-----

--------------enig9911318958EC44B5438EA57F--

