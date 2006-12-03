Message-ID: <45730D18.4040109@domain.hid>
Date: Sun, 03 Dec 2006 18:44:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] porting to kernel 2.2
References: <20061203150211.80319.qmail@domain.hid>
In-Reply-To: <20061203150211.80319.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2FA9102E147461B607D71F01"
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
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FA9102E147461B607D71F01
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
>=20
> Note: forwarded message attached.

Your first message made it to this list already. Probably the limited
information prevented any quick response of some guru.

So, mind telling us more about what your system actually reports to you?
Your program starts fine here (after adding mlockall), and this points
to a potential configuration issue. What does your kernel console tell
that is suspicious? Do existing tests run fine (=3D>testsuite)? What does=

/proc/xenomai/ contain, specifically "timer" (when the timer is said to
be not started...)? How did you configure the Xenomai part in your
kernel .config, specifically the timer?

Jan


--------------enig2FA9102E147461B607D71F01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcw0YniDOoMHTA+kRAo2AAJ9O2bQc2EkayggHJ/Qqagne8ccm1ACcCKUY
2DskbOlAmFmDbt6nw3bF4YE=
=I1si
-----END PGP SIGNATURE-----

--------------enig2FA9102E147461B607D71F01--

