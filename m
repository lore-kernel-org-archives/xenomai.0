Message-ID: <439F117E.7030606@domain.hid>
Date: Tue, 13 Dec 2005 19:22:54 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - implementing a
	periodic thread
References: <439F0B78.2000002@domain.hid>
In-Reply-To: <439F0B78.2000002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig054FEE0A7ACE15EB1778D7A5"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paolo Gai <pj@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig054FEE0A7ACE15EB1778D7A5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Paolo Gai wrote:
> Dear all,
>=20
> here is another small demo... this time of a periodic thread in POSIX.
>=20
> It works under Xenomai, but it fails under Posix Real-Time.
>=20
> The reason of the failure is the SIGUSR1 not being blocked by the main
> thread. If in main() the comments below the note "// REMOVE THE COMMENT=
S
> BELOW" are removed, then the signal is masked also in the main(), and a=
s
> a result the POSIX version works.
>=20
> The question I have is if the behavior in Xenomai (that is, not failing=

> like the POSIX counterpart) is correct or not...
>=20

Without having read your program in details and thought about the signal
behaviour as well, just two general remarks:

1. Signals are not yet supported by Xenomai in primary mode. All you
receive are Linux signals so that the real-time thread is effectively
running only in secondary mode (also due to the printf).

2. Periodic threads can be set up more easily and efficiently under
POSIX by using clock_nanosleep with absolute timeouts.

Jan


--------------enig054FEE0A7ACE15EB1778D7A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDnxGCncNeS9Q0k+IRAkjJAJ4q2PdgW7Dy51lmtErGxLt7Qe/JcgCgsh3e
P4xjfnSc0euwhI6LuzpEXnY=
=zB1u
-----END PGP SIGNATURE-----

--------------enig054FEE0A7ACE15EB1778D7A5--

