Message-ID: <45462ADA.2020803@domain.hid>
Date: Mon, 30 Oct 2006 17:39:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
References: <1162208265.4955.17.camel@domain.hid>	<21364954.1162202747823.JavaMail.ngmail@domain.hid>
	<16802252.1162217706570.JavaMail.ngmail@domain.hid>
In-Reply-To: <16802252.1162217706570.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig79ED15BF4D2E5C150DEA7714"
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
--------------enig79ED15BF4D2E5C150DEA7714
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> ...
> I have enclosed my kernel configuration, perhaps this can help to ident=
ify an issue.

CONFIG_XENO_OPT_STATS is on which can degrade the performance slightly.
Try to turn this off. I would be interested in the difference on your
boxes (a few micros should be noticeable on the slower one).

I don't know if RTAI has comparable accounting. If yes, check if it's
off as well to keep the conditions fair. I guess CONFIG_REGPARM is not
enabled for RTAI then (LXRT should break, right?).

Jan


--------------enig79ED15BF4D2E5C150DEA7714
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFRirbniDOoMHTA+kRAk7tAJwPBAQjCVbAjEvGbXWTmQ8xO80YUgCfdvRc
c5RjtMVEfdsydC2IlbC0qiM=
=qGNz
-----END PGP SIGNATURE-----

--------------enig79ED15BF4D2E5C150DEA7714--

