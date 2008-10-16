Message-ID: <48F7B86D.8090204@domain.hid>
Date: Thu, 16 Oct 2008 23:55:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.318326730@domain.hid>
	<48F79C8E.3070900@domain.hid>
In-Reply-To: <48F79C8E.3070900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC83D3E8B66805CBD69E71BE5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 06/12] Lockless fast
	path	for	xnsynch_acquire/release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC83D3E8B66805CBD69E71BE5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>=20
> Ok. Though I do not see the point of the FASTSEM/FASTSYNCH rename.
> FASTSEM is short, and we are not much interested in getting anything
> else than semaphores faster.

We aren't optimizing semaphores (at least not yet), we are optimizing
mutexes only. And if we ever optimize also semaphores, FASTSYNCH will
luckily still fit. :)

Jan


--------------enigC83D3E8B66805CBD69E71BE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3uG0ACgkQniDOoMHTA+ny/QCeNr9W649+TRcQiXWtMZn6qtlO
yd8AniNAzi7MiOY+mI4FKXAQr1tE9ii3
=anK6
-----END PGP SIGNATURE-----

--------------enigC83D3E8B66805CBD69E71BE5--

