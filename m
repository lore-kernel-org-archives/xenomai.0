Message-ID: <467BEDEF.7030101@domain.hid>
Date: Fri, 22 Jun 2007 17:42:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBA9051B05EE6C43A596B15E1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] fix automatic patch election
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
--------------enigBA9051B05EE6C43A596B15E1
Content-Type: multipart/mixed;
 boundary="------------010305070706080307050704"

This is a multi-part message in MIME format.
--------------010305070706080307050704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Currently, the patch election algorithm does not take the kernel
sub-level version into account, thus one gets offered 2.6.20, although
the kernel is 2.6.19. This patch fixes it.

Should go into 2.3.x as well.

--------------010305070706080307050704
Content-Type: text/plain;
 name="fix-patch-election.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-patch-election.patch"

Index: xenomai/scripts/prepare-kernel.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/scripts/prepare-kernel.sh
+++ xenomai/scripts/prepare-kernel.sh
@@ -357,7 +357,7 @@ elif test -r $linux_tree/include/linux/a
    exit 2
 else
    if test x$adeos_patch =3D x; then
-      default_adeos_patch=3D`( ls $xenomai_root/ksrc/arch/$xenomai_arch/=
patches/adeos-ipipe-$linux_VERSION.$linux_PATCHLEVEL*|sort -r ) 2>/dev/nu=
ll | head -n1`
+      default_adeos_patch=3D`( ls $xenomai_root/ksrc/arch/$xenomai_arch/=
patches/adeos-ipipe-$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL*|sor=
t -r ) 2>/dev/null | head -n1`
    fi
    if test x$default_adeos_patch =3D x; then
       default_adeos_patch=3D/dev/null

--------------010305070706080307050704--

--------------enigBA9051B05EE6C43A596B15E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGe+3vniDOoMHTA+kRAlXeAJ9rMCKMmXD0e8h2h/b+CVRPzpnp/wCdGWFR
EK8iILMo6W/yMqdSsbd1Sck=
=0W3w
-----END PGP SIGNATURE-----

--------------enigBA9051B05EE6C43A596B15E1--

