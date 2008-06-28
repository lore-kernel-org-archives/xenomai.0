Message-ID: <48667CE8.60305@domain.hid>
Date: Sat, 28 Jun 2008 20:03:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1KCdDN-0007XY-Dw@domain.hid>
In-Reply-To: <E1KCdDN-0007XY-Dw@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC11D10CD5A771748AA503F29"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-commits] r3998 - in /trunk: ./
 doc/doxygen/ doc/txt/ include/ include/asm-generic/ include/comedi/
 include/compat/linux/ ksrc/drivers/ ksrc/drivers/comedi/ ksrc/skins/
 ksrc/skins/comedi/ src/skins/ src/skins/comedi/ src/utils/
 src/utils/comedi/
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
--------------enigC11D10CD5A771748AA503F29
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Author: rpm
> Date: Sat Jun 28 18:23:51 2008
> New Revision: 3998
>=20
> URL: http://svn.gna.org/viewcvs/xenomai?rev=3D3998&view=3Drev
> Log:
> Merge COMEDI over RTDM framework
>=20
> Added:
=2E..
>     trunk/ksrc/skins/comedi/
>     trunk/ksrc/skins/comedi/Config.h
>     trunk/ksrc/skins/comedi/Config.in
>     trunk/ksrc/skins/comedi/Kconfig
>     trunk/ksrc/skins/comedi/Makefile
>     trunk/ksrc/skins/comedi/buffer.c
>     trunk/ksrc/skins/comedi/command.c
>     trunk/ksrc/skins/comedi/device.c
>     trunk/ksrc/skins/comedi/driver.c
>     trunk/ksrc/skins/comedi/driver_facilities.c
>     trunk/ksrc/skins/comedi/instruction.c
>     trunk/ksrc/skins/comedi/interface.c
>     trunk/ksrc/skins/comedi/os_facili. ties.c
>     trunk/ksrc/skins/comedi/subdevice.c
>     trunk/ksrc/skins/comedi/transfer.c
>     trunk/src/skins/comedi/
>     trunk/src/skins/comedi/Makefile.am
>     trunk/src/skins/comedi/Makefile.in
>     trunk/src/skins/comedi/async.c
>     trunk/src/skins/comedi/descriptor.c
>     trunk/src/skins/comedi/info.c
>     trunk/src/skins/comedi/range.c
>     trunk/src/skins/comedi/sync.c
>     trunk/src/skins/comedi/sys.c

Why did these parts went in as a skin? As far as I can see, comedi4rtdm
is a pure driver stack, _using_ the RTDM skin. I didn't find any Xenomai
nucleus reference on first glance, so the whole thing should, in theory,
be directly portable over Native-RTDM - another sign that it isn't a
skin. IMHO, it should rather populate only ksrc/drivers and, e.g.,
src/drvlibs/comedi.

Jan


--------------enigC11D10CD5A771748AA503F29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkhmfO4ACgkQniDOoMHTA+lBDgCeKK3J35EC+31jnP7tzEQ+OJ4A
hfIAn1n2ieob5LFxb0Hzkv7g/zk8Fg/7
=aIMx
-----END PGP SIGNATURE-----

--------------enigC11D10CD5A771748AA503F29--

