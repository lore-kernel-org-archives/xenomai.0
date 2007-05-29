Message-ID: <465BF473.1080300@domain.hid>
Date: Tue, 29 May 2007 11:37:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <f3es61$8a2$1@domain.hid>	<18011.7896.952588.610032@domain.hid>	<f3fcrk$3eg$1@domain.hid>	<18011.14565.787935.188919@domain.hid>
	<465B5088.2040804@domain.hid>
In-Reply-To: <465B5088.2040804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9CD089153C97817E4ACFF320"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] add tut02-skeleton
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CD089153C97817E4ACFF320
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

trem wrote:
> Hi
>=20
> You're right, perror could be used instead of strerror(-ret), it's
> simpler. And I've remoded all "fflush", as you said, there are useless
> and it's a tutorial about xenomai. So I think that those "fflush" aren'=
t
> necessary.
>=20

Thanks, merged with minor beautifications.

Please provide your future patches according to [1]. That would make
importing them into my quilt stacks easier.

Jan


[1] http://www.xenomai.org/index.php/Xenomai:Contributing_Patches


--------------enig9CD089153C97817E4ACFF320
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFGW/RzniDOoMHTA+kRAjWBAJiu//TB23iddqGYAkGqO5rHjaI5AJ0dJ0WM
pMbbFGH5nAXLJ/K2dUuTyg==
=/58d
-----END PGP SIGNATURE-----

--------------enig9CD089153C97817E4ACFF320--

