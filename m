Message-ID: <4C0FC490.2070207@domain.hid>
Date: Wed, 09 Jun 2010 18:42:56 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <AANLkTim6W405xv2vwsA57MUle64rB7REu-hLv_t5nFC9@domain.hid>
In-Reply-To: <AANLkTim6W405xv2vwsA57MUle64rB7REu-hLv_t5nFC9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig86763AA8E19C658A4C633CC2"
Subject: Re: [Xenomai-help] error while compiling the kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>, xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig86763AA8E19C658A4C633CC2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Am 09.06.2010 18:18, schrieb ramon costa:
> Hi,
>=20
> During the compilation  (CONCURRENCY_LEVEL=3D2 fakeroot make-kpkg --ini=
trd
> --append-to-version -xenomai-2.5.3 --revision 1.0 binary-arch)
> the following error is obtained :
>=20
>   H16TOFW firmware/matrox/g400_warp.fw
> make[2]: Leaving directory `/home/costa/linux-2.6.32.11'
> /usr/bin/make -j2 EXTRAVERSION=3D.11-xenomai-2.5.3  ARCH=3Di386 \
>                  -C Documentation/lguest
> make[2]: Entering directory
> `/home/costa/linux-2.6.32.11/Documentation/lguest'
> cc -m32 -Wall -Wmissing-declarations -Wmissing-prototypes -O3
> -I../../include -I../../arch/x86/include -U_FORTIFY_SOURCE    lguest.c =
=20
> -o lguest
> lguest.c:21:25: error: sys/eventfd.h: No such file or directory
> lguest.c: In function =91create_thread=92:
> lguest.c:1027: warning: implicit declaration of function =91eventfd=92
> make[2]: *** [lguest] Error 1
> make[2]: Leaving directory
> `/home/costa/linux-2.6.32.11/Documentation/lguest'
> make[1]: *** [debian/stamp/build/kernel] Error 2
> make[1]: Leaving directory `/home/costa/linux-2.6.32.11'
> make: *** [debian/stamp/do-build-arch] Error 2
> debian:/home/costa/linux-2.6.32.11# make menuconfig
> scripts/kconfig/mconf arch/x86/Kconfig
>=20
>=20
> any suggestion ?

Disable "Linux hypervisor example code" in the "Virtualization" section o=
f the kernel configuration.

Stefan

>=20
> Ramon
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--------------enig86763AA8E19C658A4C633CC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFMD8SUIPTw9rIdn6oRAmpFAJ90RaS3dzv8QozfOiJudcckVVelfgCePyYx
CmQoKv+ShnPyqJeVtKeXSGY=
=g7Ns
-----END PGP SIGNATURE-----

--------------enig86763AA8E19C658A4C633CC2--

