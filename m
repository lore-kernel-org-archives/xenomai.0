Message-ID: <465E8FA8.4030507@domain.hid>
Date: Thu, 31 May 2007 11:04:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465ADB44.2070705@domain.hid>
	<1180360288.4727.50.camel@domain.hid>	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>	<465BE777.7010204@domain.hid>	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>	<465C6268.1090704@domain.hid>	<18012.28254.882249.144005@domain.hid>	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
	<465D664E.3040700@domain.hid>
In-Reply-To: <465D664E.3040700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig339135C29BC2AA891C04D868"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] =?iso-8859-15?q?Xenomai_with_=B5Clibc?=
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig339135C29BC2AA891C04D868
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> I noticed that linking like this
>=20
> arm-linux-gcc ...<flags> <object>.o -lpthread -lrt -lpthread_rt ...
>=20
> doesn't raise the error. But linking like this
>=20
> arm-linux-gcc `xeno-config --posix-ldflags` <object>.o -o <target>
>=20
> ie. the standard way for external Xenomai POSIX apps, causes even more
> problems with this toolchain (it's fine here for native builds). Anyone=

> any comments? Maybe Wolfgang?

Reason found, I think. No ELDK issue, rather a bug in Xenomai's
README.INSTALL:

Perrine, did you happen to configure Xenomai with "configure --host=3Darm=

=2E.."? If yes (see config.log), please use "--host=3Darm-linux". This
solved all issues for me.

Awaiting your feedback!

Jan


--------------enig339135C29BC2AA891C04D868
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGXo+pniDOoMHTA+kRAtQuAJ9yLE96IGY3VONBk84kQlmLU6hcWgCfThEE
v6KG2lWf0uOMDNcbeBdHD3A=
=OIK2
-----END PGP SIGNATURE-----

--------------enig339135C29BC2AA891C04D868--

