Message-ID: <4C6C2A4D.70503@domain.hid>
Date: Wed, 18 Aug 2010 20:45:33 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>	<4C6932E8.7050701@domain.hid>	<4C694AB3.8050407@domain.hid>	<4C698E16.5050806@domain.hid>,
	<1282040830.1730.232.camel@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065794@domain.hid>
	<4C6AA99D.3010907@domain.hid>
In-Reply-To: <4C6AA99D.3010907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig36E411DF2222C882D42469B3"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system [PATCH]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36E411DF2222C882D42469B3
Content-Type: multipart/mixed;
 boundary="------------000900070103060607080802"

This is a multi-part message in MIME format.
--------------000900070103060607080802
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17.08.2010 17:24, Stefan Kisdaroczi wrote:
> On 17.08.2010 15:51, Hemal C.Bavishi wrote:
>  =20
>> When I tried to compile it with the latest version of kernel with xeno=
mai 2.5.4, I am getting following errors in Xenomai (disable CONFIG_SMP, =
enable CONFIG_X86_UP_APIC and
>> CONFIG_X86_UP_IOAPIC (*).)
>>  =20
>>    =20
> Just tested, got the same build error with 2.6.34.
> If I patch 2.6.34 with prepare-kernel [1] it compiles,
> if I use the debian packaged patch generated with prepare-patch [2] it
> fails.
>
> I guess a fix is needed in prepare-patch for 2.6.34, but no time to loo=
k
> closer now.
>  =20

patch for prepare-patch.sh attached.
prepare-kernel.sh try's to find ipipe.h and uses the old or new tree
structure. Is it ok to change this unconditionally in prepare-patch.sh?
All adeos-patches in xenomai-2.5.git have ipipe.h in
arch/$linux_arch/include/asm/, so i think yes.

Stefan


--------------000900070103060607080802
Content-Type: text/x-patch;
 name="0001-debian-fix-asm-include-directory-linking-in-prepare-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-debian-fix-asm-include-directory-linking-in-prepare-.pa";
 filename*1="tch"

=46rom 8e792591e8c42a4c38d16514e02622f3398c9f22 Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Wed, 18 Aug 2010 20:24:15 +0200
Subject: [PATCH] debian: fix asm include directory linking in prepare-pat=
ch.sh

---
 debian/prepare-patch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/debian/prepare-patch.sh b/debian/prepare-patch.sh
index 296638d..6ca734b 100755
--- a/debian/prepare-patch.sh
+++ b/debian/prepare-patch.sh
@@ -112,7 +112,7 @@ for linux_arch in $supported_arch ; do
     esac
=20
     patch_link r m ksrc/arch/$base_arch arch/$linux_arch/xenomai
-    patch_link r n include/asm-$base_arch include/asm-$linux_arch/xenoma=
i
+    patch_link r n include/asm-$base_arch arch/$linux_arch/include/asm/x=
enomai
=20
     p=3D"+drivers-\$(CONFIG_XENOMAI)		+=3D arch/$linux_arch/xenomai/"
     echo $p | patch_append arch/$linux_arch/Makefile
--=20
1.7.1


--------------000900070103060607080802--

--------------enig36E411DF2222C882D42469B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxsKlQACgkQIPTw9rIdn6r5mwCeKfEB+96ePkn9M2NTCbdR/w99
U+QAn1lzCpauXuaPlo0TZWBncm3G9r9t
=SOdO
-----END PGP SIGNATURE-----

--------------enig36E411DF2222C882D42469B3--

