Message-ID: <4E0A3FF5.2000101@domain.hid>
Date: Tue, 28 Jun 2011 22:56:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E0A3E1C.70509@domain.hid>
In-Reply-To: <4E0A3E1C.70509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig350B8CDD650B45040EF7BAB4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] posix: only use rt_printf when in primary mode
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig350B8CDD650B45040EF7BAB4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 2011-06-28 22:48, Jan Kiszka wrote:
> Hi Gilles,
>=20
> dynamic printf backend selection is a suboptimal idea when you want
> chronological output (not that uncommon during debugging). The native
> printf may actually hit the screen (or the log file) before some earlie=
r
> queued rt_printf message because the dump thread is busy or has a lower=

> priority.

Oh, I missed the buffer flush - that should work.

Sorry for the noise.

Jan


--------------enig350B8CDD650B45040EF7BAB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4KP/UACgkQitSsb3rl5xTRTgCgtPedd49+n8buOMPC+c0PLALp
1L8Anja6TFXw0KtcgWJlpN2O0xI+/PJU
=ovSN
-----END PGP SIGNATURE-----

--------------enig350B8CDD650B45040EF7BAB4--

