Message-ID: <4667BBBE.1040405@domain.hid>
Date: Thu, 07 Jun 2007 10:03:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01FAF561@domain.hid>	<1181143109.17978.101.camel@domain.hid>	<7289437c0706062254v2a386894oeb498459877d5086@domain.hid>	<4667AA4D.6070505@domain.hid>
	<7289437c0706070042gf4346ddj1c4ee3ac20a068d2@domain.hid>
In-Reply-To: <7289437c0706070042gf4346ddj1c4ee3ac20a068d2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig43780B33C7D47D812909155A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Cyclictest
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig43780B33C7D47D812909155A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> Ok. I'll do this.
>=20
> But I don't understand why the same application compiled without any li=
nks
> with Xenomai give different results if there is Xenomai in the kernel.

[Looking at your numbers again] Hmm, maybe some rounding issue of ticks
due to whatever side-effect of I-pipe. We would first of all need the
usual set of information (.config, involved versions) and also
/sys/devices/system/clocksource/clocksource0/current_clocksource.

Jan


--------------enig43780B33C7D47D812909155A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZ7u/niDOoMHTA+kRAjT/AJ4h1VxfhgmB5WKuwMb9TUvKTzFsYQCfSIfC
0kRlH77SVfmAHAksKWGo2n0=
=aVvR
-----END PGP SIGNATURE-----

--------------enig43780B33C7D47D812909155A--

