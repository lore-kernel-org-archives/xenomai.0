Message-ID: <455895FC.7060203@domain.hid>
Date: Mon, 13 Nov 2006 16:57:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai User Space: Using 100% CPU power
References: <29293133.1163432148953.JavaMail.ngmail@domain.hid>
In-Reply-To: <29293133.1163432148953.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD047F8E8EF8AA336B3B9889"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD047F8E8EF8AA336B3B9889
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I have an application where I need extreme precise timing (about 1=B5s)=
 for a couple of seconds
> using a standard PC (to access a I/O PCI board).
> For this, I want to write an application that initializes normally and =

> whenever the software is in a certain state, I want to enter a  "high-p=
recision-timing mode".
> In this high-precision-timing mode, I want to disable all interrupts an=
d poll permanently on a PCI I/O board.
> The timing itself can be directly taken from the CPU's TSC using rdtsc.=

> Within this mode, the time measurement of register changes on the PCI I=
/O board is very important.
> After a couple of seconds, when all relevant data is taken, I want to l=
eave this
> "high-precision-mode" and come back to the normal mode.
> Then the measurement results are interpreted in detail.
> All this should happen in user mode, not in kernel mode.
>=20
> My questions are now:=20
> Is this possible using Xenomai?
> How can I enter a mode that disables all interrupts (including timer) f=
or a while?

We had this discussion recently here, see

https://mail.gna.org/public/xenomai-help/2006-10/msg00172.html

And be aware that you are about to toast Linux's time keeping (but I
guess that of lower priority in this scenario).

Jan


--------------enigBD047F8E8EF8AA336B3B9889
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFWJX8niDOoMHTA+kRAjQBAKCDOfeFkw9bJpf+ATiV6ud5kKGBqwCeMxjt
vo5uYm3/A409FCytCsWgzPw=
=psqg
-----END PGP SIGNATURE-----

--------------enigBD047F8E8EF8AA336B3B9889--

