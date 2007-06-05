Message-ID: <46651F7D.9090702@domain.hid>
Date: Tue, 05 Jun 2007 10:31:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid>
In-Reply-To: <46649F7E.3060104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig20906430E7A33BBD47A50EFB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Updates, timerstats, rtdm-timers
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
--------------enig20906430E7A33BBD47A50EFB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
=2E..
> fast-tsc-to-ns-v2.patch
>=20
>     [Rebased, improved rounding of least significant digit]

Rounding in the fast path for the sake of the last digit was silly.
Instead, I'm now addressing the ugly interval printing via
xnarch_precise_tsc_to_ns when converting the timer interval back into
nanos. -v3 incorporating this has just been uploaded.

Jan


--------------enig20906430E7A33BBD47A50EFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZR99niDOoMHTA+kRAkwAAJ9V6tICniIT43+rQQNKwLlJHUJVXACePRDT
eFtzng2EBNV8tigbTGnQmPU=
=nsuC
-----END PGP SIGNATURE-----

--------------enig20906430E7A33BBD47A50EFB--

