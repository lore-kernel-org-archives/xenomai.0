Message-ID: <4666AD52.1050101@domain.hid>
Date: Wed, 06 Jun 2007 14:49:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid> <46651F7D.9090702@domain.hid>
In-Reply-To: <46651F7D.9090702@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1D54AB63F05C5177E42D15C5"
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
--------------enig1D54AB63F05C5177E42D15C5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
> ...
>> fast-tsc-to-ns-v2.patch
>>
>>     [Rebased, improved rounding of least significant digit]
>=20
> Rounding in the fast path for the sake of the last digit was silly.
> Instead, I'm now addressing the ugly interval printing via
> xnarch_precise_tsc_to_ns when converting the timer interval back into
> nanos. -v3 incorporating this has just been uploaded.
>=20

After noticing yesterday that even unpatched Xenomai sometimes converts
inaccurately when showing small timer intervals under /proc, I just got
an idea how to address this beautification issue even better: -v4 now
rounds up in the slow, precise tsc-to-ns path, see

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/fast-tsc-to-ns-v4.=
patch

Jan


--------------enig1D54AB63F05C5177E42D15C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFGZq1SniDOoMHTA+kRAr3aAJdvuopmrukW1tj0Xrix/z/SSrQ1AJ4m9ZYy
3BWUQ2m7608sltdpmptOCQ==
=R4Kz
-----END PGP SIGNATURE-----

--------------enig1D54AB63F05C5177E42D15C5--

