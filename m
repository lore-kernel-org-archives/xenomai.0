Message-ID: <44E21CD6.10802@domain.hid>
Date: Tue, 15 Aug 2006 21:13:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200608152104.20562.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200608152104.20562.Sebastian.Smolorz@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3E68FA3A3C3BC434E1C91F8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Small typo fix for rtcan.h
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3E68FA3A3C3BC434E1C91F8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Hi,
>=20
> here comes a minor typo fix for rtcan.h
>=20
> Sebastian
>=20

Thanks, applied.

Jan

>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: include/rtdm/rtcan.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/rtdm/rtcan.h	(Revision 1442)
> +++ include/rtdm/rtcan.h	(Arbeitskopie)
> @@ -1077,7 +1077,7 @@
> =20
> =20
>  /*!
> - * @anchor Error2 @name Protocoll error type
> + * @anchor Error2 @name Protocol error type
>   * Error in the data[2] field of struct can_frame.
>   * @{ */
>  /* error in CAN protocol (type) / data[2] */
> @@ -1093,7 +1093,7 @@
>  /** @} */
> =20
>  /*!
> - * @anchor Error3 @name Protocoll error location
> + * @anchor Error3 @name Protocol error location
>   * Error in the data[3] field of struct can_frame.
>   * @{ */
>  /* error in CAN protocol (location) / data[3] */
> @@ -1120,7 +1120,7 @@
>  /** @} */
> =20
>  /*!
> - * @anchor Error4 @name Protocoll error location
> + * @anchor Error4 @name Protocol error location
>   * Error in the data[4] field of struct can_frame.
>   * @{ */
>  /* error status of CAN-transceiver / data[4] */



--------------enigD3E68FA3A3C3BC434E1C91F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE4hzZniDOoMHTA+kRAg6dAJ0fc8eXp6VQDX4tiwAwzWAzsBeVhgCeOM12
dWEKkrSJXBV4a4bFMSi3WY0=
=RhQs
-----END PGP SIGNATURE-----

--------------enigD3E68FA3A3C3BC434E1C91F8--

