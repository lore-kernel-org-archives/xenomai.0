Message-ID: <4693A702.1010604@domain.hid>
Date: Tue, 10 Jul 2007 17:34:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
In-Reply-To: <1982070.1184078400928.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B1B2005E44FE8BDD18C68D7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B1B2005E44FE8BDD18C68D7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> yes, it terminates nicely.
> I have attached my config.

Nothing obvious. Leaves us with probable timing differences or the
different versions of our setups (I found this over 2.3.2 and trunk).

OK, further analysis on your side would be appreciated. E.g. trying the
latest release, switching on debug features in Xenomai like the NMI
watchdog or nucleus debugging. Also, nailing down what service call
precisely locks up (the join, the termination of the task, etc.) would
be good to reduce the search space.

Jan


--------------enig6B1B2005E44FE8BDD18C68D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGk6cDniDOoMHTA+kRAi5uAJ9F+c+tlWhl7bAEDLX2OaaC7vUaTQCfS8B4
dgO1xF13Nu1SaElF5bEDggk=
=lTak
-----END PGP SIGNATURE-----

--------------enig6B1B2005E44FE8BDD18C68D7--

