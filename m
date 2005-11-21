Message-ID: <4382201C.8040503@domain.hid>
Date: Mon, 21 Nov 2005 20:29:32 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig76A9ACFA7E588BDD9708C884"
Subject: [Xenomai-core] [RFC] define your own pipe heap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76A9ACFA7E588BDD9708C884
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi there,

yea, I also want to join this endless pipe discussion! ;)

We ran into troubles here due to large messages that should be sent via
native pipes. Large means larger than the default message heap, the
system heap, of the pipe subsystem so far. That raised the question why
we should not provide some interface (and the required internal patches)
to maintain per-pipe heaps. At least optional. This would allow to
create pipe channels with even some megabyte space as we used them under
RTAI.

I would provide the required patches, but I'm not yet sure if we better
extend rt_pipe_create with an additional parameter bufsize (0 =3D default=
,
i.e. system heap, 0 > allocate per kmalloc or vmalloc) or if we add
another function like rt_pipe_bufsize to allocate a dedicated heap after
creation.

Ideas, comments?

Jan


--------------enig76A9ACFA7E588BDD9708C884
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDgiAdncNeS9Q0k+IRAq1zAKDqDEW/LtTbI3VWEwDEV2dkfwm/iwCguX+C
t8AsUxIX5FjzdyXXdw2YdoE=
=nZUw
-----END PGP SIGNATURE-----

--------------enig76A9ACFA7E588BDD9708C884--

