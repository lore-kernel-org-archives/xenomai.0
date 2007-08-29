Message-ID: <46D58382.5020201@domain.hid>
Date: Wed, 29 Aug 2007 16:32:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F1@domain.hid>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6A096B74FEE1615C2BEBD588"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM timeout value
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A096B74FEE1615C2BEBD588
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Osterried (BA/EDD) wrote:
> Hi,
>=20
> it seems that in the RTDM API, all the timeout functions which use
> nanosecs_rel_t have a strange behaviour.
> The timeout in nanoseconds is converted to ticks and the number of tick=
s
> is rounded down. So when we want to wait e.g. 500000 nanoseconds and th=
e
> timertick is 1 ms, xnpod_ns2ticks() rounds down to 0. But 0 is the
> special value RTDM_TIMEOUT_INFINITE, so we wait forever. I use Xenomai
> 2.3.1, but I think it's basically the same in trunk.

It should even impact other skins as well when in tick-based timing
mode. I would bet more users of xnpod_ns2ticks() may have overseen this
rounding issue - like RTDM did.

> Wouldn't it be better to round up the ticks instead of round it down?

Hmm, probably. Mind to work out a patch for xnpod_ticks2ns()?

What do others think about this issue? Can/should we change the rounding
behaviour at nucleus level?

Thanks for reporting,
Jan


--------------enig6A096B74FEE1615C2BEBD588
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1YODniDOoMHTA+kRAm5PAJoD2lau09YSlY0dHPfuRGDglUUBXwCfa4bF
zf7q5Fda29mUxYNVKtr9jho=
=OcQj
-----END PGP SIGNATURE-----

--------------enig6A096B74FEE1615C2BEBD588--

