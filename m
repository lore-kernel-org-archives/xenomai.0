Message-ID: <43FC6A37.6030406@domain.hid>
Date: Wed, 22 Feb 2006 14:42:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Accessing the dev_private field of the RTDM driver
	context
References: <fd6a47a90602220529l42118430u@domain.hid>
In-Reply-To: <fd6a47a90602220529l42118430u@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA54C0F51DB7B506269D098F4"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA54C0F51DB7B506269D098F4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
> The dev_private data field of an rtdm_dev_context is defined as char[0]=
=2E How
> do I access such a field properly (given the fact that I defined a nonz=
ero
> context_size in the rtdm_device structure during driver registration) ?=

>=20
> E.g. trying to do:
>=20
> (struct my_struct *)context->dev_private =3D NULL;
>=20
> results in:
>=20
> error: incompatible types in assignment
>=20
> I _am_ able to compare though:
>=20
> if ((struct my_struct *)context->dev_private =3D=3D NULL)
> ...
>=20
> seems to compile fine.
>=20
>=20
> Jeroen.
>=20

context->dev_private does not contain an address, it IS the start
address of your private date. It's size is specified during device
registration. See existing drivers for usage examples.

Jan


--------------enigA54C0F51DB7B506269D098F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/Go3niDOoMHTA+kRAnzaAJ4y/mMiApwFjCoGtrwV/Fok5bhdzQCfV8pa
kVJtBLzl2jjGM44iRegies0=
=Ezlk
-----END PGP SIGNATURE-----

--------------enigA54C0F51DB7B506269D098F4--

