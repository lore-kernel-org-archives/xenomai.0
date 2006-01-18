Message-ID: <43CEAF25.6010705@domain.hid>
Date: Wed, 18 Jan 2006 22:12:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Scheduling while atomic
References: <fd6a47a90601181204g4c86f778x@domain.hid>
	<43CEA323.7000701@domain.hid>
In-Reply-To: <43CEA323.7000701@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2A9D0EC92072A9EF0DD64310"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A9D0EC92072A9EF0DD64310
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Jeroen Van den Keybus wrote:
>> Hello,
>> =20
>> =20
>> Apparently, the code I shared with Gilles never made it to this forum.=

>> Anyway, the issue I'm having here is really a problem and it might be
>> useful if some of you could try it out or comment on it.=20
>=20
> If you have a makefile for them, I'll give it a try.
> I'm too lazy...err...busy to make one myself(*)  ;-)

Try this, it even works without make:

gcc -o <output> <input.c> `<path-to-xeno-config> --xeno-cflags` \
	`<path-to-xeno-config> --xeno-ldlags` -lnative

Do you (or anybody else) have a running 2.0.x installation? If so,
please test that setup as well.

>=20
> Best regards,
> Hannes.
>=20
> (*) Jan has the copyright on this line, so I hope it's GPL ;-)

No rights reserved. :)


Ok, have to go home now - getting hungry...

Jan


--------------enig2A9D0EC92072A9EF0DD64310
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzq8lniDOoMHTA+kRAtkvAJ9v/94nf8Kguvuh5BBSS9Bk3g9bSgCcDKhR
PE4abPiThA+diGRQqufmqJM=
=gbGN
-----END PGP SIGNATURE-----

--------------enig2A9D0EC92072A9EF0DD64310--

