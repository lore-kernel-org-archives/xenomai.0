Message-ID: <4642E54B.3060600@domain.hid>
Date: Thu, 10 May 2007 11:26:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1178727256.11688.35.camel@domain.hid>	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<12120203.1178785866207.JavaMail.ngmail@domain.hid>
In-Reply-To: <12120203.1178785866207.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig622008560DF63ECAAC606663"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
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
--------------enig622008560DF63ECAAC606663
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> ...
> I measured the following runtime:
> For configuring Xenomai without any option:  4.8us per step
> Configuring Xenomai with --enable-x86-sep: 4.5us per step.
>=20
> I ran this experiment on a 3.2 GHz Pentium D on a server main board wit=
h
> E7230 chipset.
> Xenomai 2.3.1, kernel 2.6.20.4, SMP
> Thus the performance here is not really excellent (as there is no need =
to do
> a task switch.

Mind to run oprofile on this setup to see where costs primarily come from=
?

>=20
> I agree with all the comments that recommended to improve the design fi=
rst before
> trying to improve the OS performance.=20
> However, if there is (RT)OS, I expect it to be as fast as possible.

And there it is again, the common misunderstanding: RTOSes are not
GPOSes, only faster. They provide services optimised for predictable and
low (in that order) worst-case performance.

So adding optimisations for whatever average case must not hurt those
goals significantly. And that often means your overall performance is
even worse than with an GPOS. No excuses for keeping Xenomai unoptimised
if it can be tuned smartly, just an explanation why we may not help in
every case.

Jan


--------------enig622008560DF63ECAAC606663
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQuVPniDOoMHTA+kRAhdbAJ0ZIkvq+x5OiZZZiQ8DA+aFLT7GzACfZX0p
6QGhfA0dJz+z216zdvA5rY8=
=nXjh
-----END PGP SIGNATURE-----

--------------enig622008560DF63ECAAC606663--

