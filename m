Message-ID: <44A8BA2E.9090106@domain.hid>
Date: Mon, 03 Jul 2006 08:33:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>	<1151592402.19389.31.camel@domain.hid>	<44A4C4CB.5F24DA68@domain.hid>	<1151657621.3060.26.camel@domain.hid>
	<44A8B191.3DCC39C2@domain.hid>
In-Reply-To: <44A8B191.3DCC39C2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3A5F42D6CE7C9BF8296D0B1E"
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
To: Detlef Vollmann <dv@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A5F42D6CE7C9BF8296D0B1E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Detlef Vollmann wrote:
>>> Now I have another question on this: on the PXA I have a hardware
>>> problem so that I must sometimes set the next match value to the
>>> match value after the next one, so effectively loosing one
>>> interrupt.

Just out of curiosity: What is the technical background of this issue?
Does it mean that the hardware is not able to trigger a timer event over
a certain period of time and you therefore have to defer the event until
this is possible again? Do you know ahead of time when this will happen?
Or only when you try to set the timer and the hardware tells you about
it somehow?

Looks like designing a real-time application around such a quirk isn't
that easy. But it's not a generic PXA issue, is it?

Jan


--------------enig3A5F42D6CE7C9BF8296D0B1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqLouniDOoMHTA+kRAmh6AJ9SXG6mosPid2NJfimv8kg1WbPWqQCfRR0X
j7M6LNMieRl1RHgw7CkLOxw=
=9Rxa
-----END PGP SIGNATURE-----

--------------enig3A5F42D6CE7C9BF8296D0B1E--

