Message-ID: <458A4DE0.5030005@domain.hid>
Date: Thu, 21 Dec 2006 10:03:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45894179.8060805@domain.hid> <4587E404.2050101@domain.hid>
	<4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
In-Reply-To: <15069404.1166690889417.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig336562E4628A1B799A3A4786"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
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
--------------enig336562E4628A1B799A3A4786
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> meanwhile I have done a couple of additional tests.
> With one of the PCs I have, I have disabled the Memory Cache to slow it=
 down.
> The effect was the very same.=20
> I have reproduced the behaviour on another PC (also P4, but different m=
ainboard).
> The system freezes as well.
> And finally, I have found out that printing out a line with printf() di=
rectly after the system() call provides
> a workaround.Then the system is stable.
>=20
> I have replaced the system() call where I called rtroute with a simple =
call to "ls -l" (i.e system("ls -l") ).
> Then the system freezes as well.
> It looks to me as if a system() call out of the realtime task is not pr=
operly handled.
> An printf() after the system() call seems to move the system back on tr=
ack...
>=20
> Hope that helps a little bit to identify the issue...

Unfortunately not yet. I tried with exactly the same configuration you
once mailed on a Pentium M 1.3 GHz - but all worked fine. The obvious
differences are the CPU speed (I may have access to a crash box with
more GHz next week) and the NIC (rt_eepro100 in my case).

As my hope of being able to reproduce it on my own is not that high, I
would like to ask you to try nailing down the lock-up on kernel level.
That means trying to identify (via printk e.g. - if this doesn't make
the bug jump around) which function is still executed and where we do
not get.

TIA,
Jan


--------------enig336562E4628A1B799A3A4786
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFik3kniDOoMHTA+kRAnqkAJ0YR5w4niQm+n8itEw7JC2HDm0/cgCeNJkl
6o0r4xcHQ/9EKjNqa5DDJJY=
=tyX3
-----END PGP SIGNATURE-----

--------------enig336562E4628A1B799A3A4786--

