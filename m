Message-ID: <448EEF9D.30208@domain.hid>
Date: Tue, 13 Jun 2006 19:02:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] strange periodic behavior
References: <45045.155.98.4.39.1150149018.squirrel@domain.hid>
	<448E5A2B.9060606@domain.hid>
	<3384.206.81.135.88.1150211884.squirrel@domain.hid>
	<448EDECA.7030302@domain.hid>
	<36429.155.98.4.39.1150216385.squirrel@domain.hid>
	<448EE9C3.4060706@domain.hid>
	<40729.155.98.4.39.1150217383.squirrel@domain.hid>
In-Reply-To: <40729.155.98.4.39.1150217383.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig879997B115006B5217886AD9"
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
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig879997B115006B5217886AD9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
>  > Grmbl, my fault. Your test looks ok, but I was rather referring to y=
our
>> *code*.
>=20
> Sorry, here's a small portion of what it outputs.  The first column is =
the
> timestamp and the second is the overrun value from rt_task_wait_period.=
=20
> In this case, the "control loop" is supposed to be running at 10 KHz.
>=20
> 0.000087,	0
> 0.000302,	0
> 0.000522,	0
> 0.000742,	0
> 0.000962,	0
> 0.001182,	0
> 0.001402,	0
> 0.001623,	0
> 0.001843,	0
> 0.002063,	0
> 0.002283,	0
> 0.002503,	0
> 0.002723,	0
> 0.002944,	0
> 0.003164,	0
> 0.003384,	0
> 0.003604,	0
> 0.003824,	0
> 0.004045,	0
> 0.004265,	0
> 0.004485,	0
> 0.004705,	0
> 0.004925,	0
> 0.005146,	0
> 0.005366,	0
> 0.005586,	0
> 0.005806,	0
> 0.006026,	0
> 0.006246,	0
> 0.006467,	0
> 0.006687,	0
> 0.006907,	0
> 0.007127,	0
> 0.007347,	0
> 0.007568,	0
> 0.007788,	0
> 0.008008,	0
> 0.008228,	0
> 0.008448,	0
> 0.008669,	0
> 0.008889,	0
> 0.009109,	0
> 0.009329,	0
> 0.009549,	0
> 0.009769,	0
> 0.009990,	0
> 0.010210,	0
>=20

[looking at it again]
Ah, this is drifting! The more important is the code to see what clock
sources you use. They are obviously not in sync.

Jan


--------------enig879997B115006B5217886AD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEju+dniDOoMHTA+kRAhy9AJwN3rNGr4uWHlQszWW9n7KyZNmt8ACeJNYW
p3BHH1RH/OPIYlHXE5z3Cvo=
=FZjW
-----END PGP SIGNATURE-----

--------------enig879997B115006B5217886AD9--

