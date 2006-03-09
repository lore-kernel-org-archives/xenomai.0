Message-ID: <440F7CC7.40505@domain.hid>
Date: Thu, 09 Mar 2006 01:54:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Small doc fix for rtbenchmark.h
References: <200603090130.09536.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200603090130.09536.Sebastian.Smolorz@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBB05907D1F7FE8D8CD8F1BC0"
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
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBB05907D1F7FE8D8CD8F1BC0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Hi Jan,
>=20
> here is a fix for the following doxygen warning:
>=20
> xenomai/include/rtdm/rtbenchmark.h:146: Warning: end of file while insi=
de a=20
> group
>=20
> Sebastian
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> --- xenomai/include/rtdm/rtbenchmark.h	2006-03-09 01:13:40.000000000 +0=
100
> +++ rtbenchmark.h	2006-03-09 01:13:24.000000000 +0100
> @@ -138,6 +138,7 @@ typedef struct rtbnch_trace_special {
> =20
>  #define RTBNCH_RTIOC_SPECIAL_TRACE_EX   \
>      _IOW(RTIOC_TYPE_BENCHMARK, 0x25, struct rtbnch_trace_special)
> +/** @} */
> =20
>  /** @} */
> =20

Yep, indeed - fixed. Might explain some of the other problems that
popped up today, err, yesterday...

Thanks,
Jan


--------------enigBB05907D1F7FE8D8CD8F1BC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFED3zHniDOoMHTA+kRAoVRAJkBSHEdzLAhD3Oa3wkq6Vb/UKAudgCfcDAi
3udAPLzP+DaUths+7TioRWM=
=7wVs
-----END PGP SIGNATURE-----

--------------enigBB05907D1F7FE8D8CD8F1BC0--

