Message-ID: <4CB07B50.5080504@domain.hid>
Date: Sat, 09 Oct 2010 16:25:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CB06CE9.9090204@domain.hid> <4CB06E2F.7070209@domain.hid>
	<4CB06E7F.7070402@domain.hid> <4CB06FB8.4020106@domain.hid>
In-Reply-To: <4CB06FB8.4020106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9D311D80B60EA4E7848715D6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [forge] irqbench removal
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D311D80B60EA4E7848715D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 09.10.2010 15:35, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Am 09.10.2010 15:29, Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Philippe,
>>>>
>>>> irqbench does not inherently depend on a third I-pipe domain.
>>> Yes, but it inherently depends on x86 too.
>>
>> Not by design, just by missing contributions to add a few more I/O bin=
dings.
>=20
> Currently it does not compile on anything else than x86. Denx has a
> "gpioirqbench":
> http://git.denx.de/?p=3Dgpioirqbench.git;a=3Dsummary
>=20
> Maybe it is time to find some common ground and have atlast a bench
> which can run an all architectures ?
>=20

No concerns.

Wolfgang, do you see a reasonable way to make the hardware interface
between host and target more compatible so that we could also use the
existing x86 measurement tool with your targets? That was my original
idea (to avoid the need for multiple embedded boards). Having a gpio
option also for the measurement host is nevertheless worthwhile.

Jan


--------------enig9D311D80B60EA4E7848715D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkywe1AACgkQitSsb3rl5xSxbwCguy+vOtMsBN4BRm7JQqZFocx1
tDYAn1j9UlAmwE6EG4Zf95YjcLFjQE5m
=Lekp
-----END PGP SIGNATURE-----

--------------enig9D311D80B60EA4E7848715D6--

