Message-ID: <4D834AA0.5080402@domain.hid>
Date: Fri, 18 Mar 2011 13:05:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=G7sEYAqMKS+PEaDgH2q=d-h=_wsoCkFZLLAip@domain.hid>
In-Reply-To: <AANLkTi=G7sEYAqMKS+PEaDgH2q=d-h=_wsoCkFZLLAip@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA33491FB3B47C73A4947F9B4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and select() function - don't work
	correctly
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA33491FB3B47C73A4947F9B4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-03-18 12:48, Jens K=F6hler wrote:
> Hello,
>=20
> on my atom processor based computer is Xenomai installed. (Kernel 2.6.2=
6,
> 1000Hz, Xenomai 2.4.10, PREEMPT patch, no xenomai application running).=


What does "PREEMPT patch" mean? CONFIG_PREEMPT? Then try over a recent
kernel (2.6.37) with latest ipipe patch as we fixed several issues that
affected Linux task preemption negatively on x86-32.

Jan


--------------enigA33491FB3B47C73A4947F9B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk2DSqQACgkQitSsb3rl5xSRbgCcC2WiiHfd0CG0sk8AqzJ4oWA8
4MUAn1VrR+ZEYyDIFMLJy+eEk9+Phj7u
=tpsd
-----END PGP SIGNATURE-----

--------------enigA33491FB3B47C73A4947F9B4--

