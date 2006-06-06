Message-ID: <44855D43.60806@domain.hid>
Date: Tue, 06 Jun 2006 12:47:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_task_wait_period returning -ETIMEDOUT
References: <44855B98.6070406@domain.hid>
In-Reply-To: <44855B98.6070406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C4CF4549E3117B55A9B3B62"
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
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C4CF4549E3117B55A9B3B62
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> rt_task_wait_period() is spuriously returning -ETIMEDOUT.
>=20
> (spuriously =3D maybe once every two hours with period =3D 500us)
>=20
> I'm using the trunk code and that error code is not mentioned in the
> rt_task_wait_period documentation.
>=20
> Any clues?

testsuite/latency makes use of rt_task_wait_period as well. Already
tried to run it at the same frequency? Does it fail as well?

Further question: Does this error correlate with some real deadline miss
of your application?

SMI&friends might be a reason here, check delays of the testsuite (and
your kernel config, of course). Is the workaround enabled? Is it
reported to be used (kernel log)?

Jan


--------------enig6C4CF4549E3117B55A9B3B62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEhV1DniDOoMHTA+kRAh7KAJsEDWHGjPMm0h/rjB4223oG2wpLKACfVB5p
1m2QTGxZT+CNe0kOOrA07zU=
=Al1o
-----END PGP SIGNATURE-----

--------------enig6C4CF4549E3117B55A9B3B62--

