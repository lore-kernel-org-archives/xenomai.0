Message-ID: <45BE2C1B.9000909@domain.hid>
Date: Mon, 29 Jan 2007 18:17:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] negative results in latency histogram.
References: <ac3922a00701290846q1f394bfl53efd41353a0ecb0@domain.hid>
In-Reply-To: <ac3922a00701290846q1f394bfl53efd41353a0ecb0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7CF91439DA780E2F95B450C7"
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
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7CF91439DA780E2F95B450C7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Syed Amer Gilani wrote:
> When i use latency with the in-kernel timer handler i get negative
> results but those don't show up in the Histogram (-h). They are just
> counted as positive values?

Yep.

> Bug or purpose?

I guess this was just established to simplify the code. But feel free to
enhance the statistics with support for negative histogram buckets,
patches are welcome!

Jan


--------------enig7CF91439DA780E2F95B450C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFviwbniDOoMHTA+kRAk81AJ9kSkCmBICg2ycsoqSyCzG7Zb1N/ACfUdHI
pweHl+XVgbOTtU3f91O5o9s=
=EExA
-----END PGP SIGNATURE-----

--------------enig7CF91439DA780E2F95B450C7--

