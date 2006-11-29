Message-ID: <456D5C8A.1090007@domain.hid>
Date: Wed, 29 Nov 2006 11:10:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Draft for a RTDM I2C driver, V2
References: <456D5705.1000902@domain.hid>
In-Reply-To: <456D5705.1000902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigADF236A06CDC425BE5B819DB"
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
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigADF236A06CDC425BE5B819DB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> Hello,
>=20
> I did some redesigning on my first draft.
> - Now we have some kind of profile in include/rti2c.h.
> - I got rid of some chunks of code that were not really needed.
> - Linux kernel dependencies have been removed (I hope I catched all of
> them)

Will have a look at the code later.

Did you already consider to integrate it in a local Xenomai tree and
post patches against SVN head (=3D> /drivers/i2c, /include/rtdm)? Would
make it easier to test compilation and doc generation. What is the empty
algo folder supposed to contain one day?

What would also be nice is a simple demo application. We still have no
policy were to put such stuff. Maybe we'll take the chance and create an
examples folder in SVN and/or put code/description into the wiki.

Jan


--------------enigADF236A06CDC425BE5B819DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbVyKniDOoMHTA+kRAp+MAJ9Os6Y4FxyS/ATGmpLfCZLQIkBYZQCdEyCT
3eb5hPFTzwZTOKGqC5jJG5I=
=GO8G
-----END PGP SIGNATURE-----

--------------enigADF236A06CDC425BE5B819DB--

