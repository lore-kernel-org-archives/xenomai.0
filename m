Message-ID: <4BB53566.3010601@domain.hid>
Date: Fri, 02 Apr 2010 02:08:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>
In-Reply-To: <20100401230843.GF3755@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E43A925DE5676F7A15BA712"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E43A925DE5676F7A15BA712
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andreas Glatz wrote:
> Hi Philippe,
>=20
> At the Xenomai Users Meeting last year I asked you if Xenomai would off=
er a possibility to lower the priority of certain Xenomai tasks below tha=
t of Linux. We need this feature since we have tasks in our RT applicatio=
n which should only run when Linux is idle (A statistics collection task =
which part of the RT application and hard to isolate from this applicatio=
n).
>=20

What prevents using a borderline thread (if you need to interact with
blocking Xenomai services) with SCHED_OTHER and a Linux nice level of 19?=


Jan


--------------enig8E43A925DE5676F7A15BA712
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1NWYACgkQitSsb3rl5xQ50gCglpwx2NjcFafr1bMr2Z1x2SN8
EmsAmgM7VuWjWwZsiehw/SWtaLL6sZ4h
=fbf1
-----END PGP SIGNATURE-----

--------------enig8E43A925DE5676F7A15BA712--

