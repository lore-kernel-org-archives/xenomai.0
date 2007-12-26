Message-ID: <4772752D.1090201@domain.hid>
Date: Wed, 26 Dec 2007 16:37:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4CB998512937C1E4DD6ABE02"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [RESENT][PATCH 1/4] x86_64: remove unneeded i8253 lock
	conversion
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
--------------enig4CB998512937C1E4DD6ABE02
Content-Type: multipart/mixed;
 boundary="------------010204010603060509000509"

This is a multi-part message in MIME format.
--------------010204010603060509000509
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

/me noticed that this one still applies...

Jan

--------------010204010603060509000509
Content-Type: text/x-patch;
 name="remove-i8253_lock-conversion-x86_64.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-i8253_lock-conversion-x86_64.patch"

---
 arch/x86_64/kernel/time.c  |    2 +-
 include/asm-x86_64/i8253.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.23.1-xeno_64/arch/x86_64/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/arch/x86_64/kernel/time.c
+++ linux-2.6.23.1-xeno_64/arch/x86_64/kernel/time.c
@@ -51,7 +51,7 @@ static char *timename =3D NULL;
=20
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
-IPIPE_DEFINE_SPINLOCK(i8253_lock);
+DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
=20
 volatile unsigned long __jiffies __section_jiffies =3D INITIAL_JIFFIES;
Index: linux-2.6.23.1-xeno_64/include/asm-x86_64/i8253.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/include/asm-x86_64/i8253.h
+++ linux-2.6.23.1-xeno_64/include/asm-x86_64/i8253.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_I8253_H__
 #define __ASM_I8253_H__
=20
-IPIPE_DECLARE_SPINLOCK(i8253_lock);
+extern spinlock_t i8253_lock;
=20
 #endif	/* __ASM_I8253_H__ */



--------------010204010603060509000509--

--------------enig4CB998512937C1E4DD6ABE02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcnUxniDOoMHTA+kRAuH7AJ4iWdIBo8EFpzj8lZIdJ3PeDdQs4ACfQcs5
rBg/GxlIQpClfiIQ6SO5exQ=
=af1L
-----END PGP SIGNATURE-----

--------------enig4CB998512937C1E4DD6ABE02--

