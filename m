Message-ID: <43B949F1.60001@domain.hid>
Date: Mon, 02 Jan 2006 16:42:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCHES] various fixes
References: <43B92C73.6080004@domain.hid>
In-Reply-To: <43B92C73.6080004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig08C4A91BD0AF4CA220776965"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig08C4A91BD0AF4CA220776965
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> ...
> Moreover, here are two minor fixes:
> 
>  * accuracy.patch - add missing define to let this posix demo compile

Forget about this one. I oversaw the way SPERIOD is passed in the
original Makefile while compiling accuracy.c by hand.

Jan

--------------enig08C4A91BD0AF4CA220776965
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDuUnxniDOoMHTA+kRAvZPAJ9jZXve20V+4zbCfnxb23cHL2IKVQCfTdTe
jLif3T67zcP2lbi/ovnmykY=
=/wxq
-----END PGP SIGNATURE-----

--------------enig08C4A91BD0AF4CA220776965--

