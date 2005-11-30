Message-ID: <438D9B20.5090609@domain.hid>
Date: Wed, 30 Nov 2005 13:29:20 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems with mutex
References: <438D993E.7010904@domain.hid>
In-Reply-To: <438D993E.7010904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1E3E68F7158934D010472E88"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: kai.m.moritz@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E3E68F7158934D010472E88
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Kai Moritz wrote:
> Hello folks,
>=20
> I'm using Xenomai 2.0.1 with Linux 2.6.14 and ipipe. I've a strange
> problem using mutex-locks. Repeted calls to rt_mutex_lock with
> TM_NONBLOCK on the same mutex return always 0, which means lock
> successfully aquired, if I understand the API-documentation right.
> I've attached a small programm to test that behavior and the
> log-messages it produces on my machine. Perhaps anyone has a hint, what=

> I'm doing wrong...

Does the same thread lock this mutex over and over again (I did not look
at your code yet)? If so, note that mutexes can be acquired recursively
by the original owner.

Jan



--------------enig1E3E68F7158934D010472E88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDjZsgncNeS9Q0k+IRAkvyAKC1Y5qVn++ST2yuTGfn0OuWErBRiACgxZWr
m4gKzFIEFqMSyhIkdSIGJ7M=
=SoZW
-----END PGP SIGNATURE-----

--------------enig1E3E68F7158934D010472E88--

