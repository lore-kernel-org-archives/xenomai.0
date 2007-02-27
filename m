Message-ID: <45E403F9.5060803@domain.hid>
Date: Tue, 27 Feb 2007 11:12:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some doc improvements
References: <45E3F802.5020907@domain.hid>
In-Reply-To: <45E3F802.5020907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEEFB88F3F0F0F9F43298EF82"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEEFB88F3F0F0F9F43298EF82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> attached is a patch improving the Doxygen generated documentation. If
> nobody complains, I will commit it to the trunk. Nevertheless, it
> remains the problem, that some symbols are not hyperlinked, mainly most=

> of the rt_dev_* functions. For some strange reasons it works for a few,=

> e.g. rt_dev_setsockopt. I tried Doxygen v1.5.1, which didn't help (but

Maybe due to the ugly doxy-hacks that I applied all over RTDM. Making
doxygen output work AND look nice seems to be an endless journey.

> it has the nice frames, BTW). I'm going to report the problem on the
> Doxygen ML when time permits.
>=20
> Wolfgang.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: include/rtdm/rttesting.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/rtdm/rttesting.h	(revision 2239)
> +++ include/rtdm/rttesting.h	(working copy)
> @@ -50,8 +50,8 @@
>   * Specific return values: none @n
>   * @n
>   * @b IOCTL @n
> - * Mandatory Environments: see @ref IOCTLs below @n
> - * Specific return values: see @ref IOCTLs below @n
> + * Mandatory Environments: see @ref TSTIOCTLs below @n
> + * Specific return values: see @ref TSTIOCTLs below @n

I also spotted this, good that you address it!

Ack to the whole from my side.

Thanks,
Jan


--------------enigEEFB88F3F0F0F9F43298EF82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5AP5niDOoMHTA+kRAoGlAJ9u2Td+7DJ5YOX/kZUBKjIDJl4szwCeL2gR
9F15gFAEL7Xaq7ITFTDXtnc=
=1yxX
-----END PGP SIGNATURE-----

--------------enigEEFB88F3F0F0F9F43298EF82--

