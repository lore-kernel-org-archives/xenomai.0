Message-ID: <45AEA9A7.7000001@domain.hid>
Date: Wed, 17 Jan 2007 23:56:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] irq conflict
References: <45ADEDDC.5060407@domain.hid>
In-Reply-To: <45ADEDDC.5060407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFB50A49B101682BCC3FF09A1"
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
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB50A49B101682BCC3FF09A1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Theo Veenker wrote:
> Hi all,
>=20
> I need to run xenomai on a HP Compaq nc6320. I use kernel 2.6.17.14
> and xenomai 2.2.5. The non-realtime kernel runs fine on this laptop,

Means the same kernel with I-pipe (and Xenomai) disabled or the same
kernel version and .config, but unpatched?

> but the xenomai pactched kernel gives several of these messages:
>=20
>   IRQ routing conflict for xxxx.xx.xx.x, have irq 11, want irq 10
>=20
> And some things (e.g. mouse, network) then don't work, not properly
> anyway. The same kernel runs fine however on other systems.
>=20
> Any clue what I can do about it?

Please provide bootlogs for both rt and non-rt kernel startup. And the
=2Econfig.

>=20
> Anyone running xenomai on a recent Compaq laptop?
>=20
> Regards,
>=20
> Theo
>=20
>=20

Jan


--------------enigFB50A49B101682BCC3FF09A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrqmoniDOoMHTA+kRAiPyAJ9jfude9MT4RPi1pLjb9HnpRuRiJQCfVR8f
FxqcZdpyNlIz0mE6INsFXQ8=
=BoMC
-----END PGP SIGNATURE-----

--------------enigFB50A49B101682BCC3FF09A1--

