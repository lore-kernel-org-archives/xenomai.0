Message-ID: <4562BD03.60702@domain.hid>
Date: Tue, 21 Nov 2006 09:46:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4562BA12.8080809@domain.hid>
In-Reply-To: <4562BA12.8080809@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF753C399965274BFBB5D2A59"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: RT-Socket-CAN, shorter names
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
--------------enigF753C399965274BFBB5D2A59
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hallo,
>=20
> I plan to shorten the following names using "can" instead of "rtcan" to=

> be consistent with the naming scheme:
>=20
> CONFIG_XENO_DRIVERS_RTCAN_* -> CONFIG_XENO_DRIVERS_CAN_
> xeno_rtcan_* -> xeno_can_*
>=20
> Jan, I think you already suggested such a modification?

Ack, go ahead. And maybe also think about shortening the module naming
scheme.

Jan


--------------enigF753C399965274BFBB5D2A59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYr0DniDOoMHTA+kRAnC4AJ0Y9vipEz7+2QQyhq1Bq97ARear3wCdHQPZ
3sWTmLXQZ4vTdW4rzSOqqXo=
=0E3x
-----END PGP SIGNATURE-----

--------------enigF753C399965274BFBB5D2A59--

