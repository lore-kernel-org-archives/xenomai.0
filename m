Message-ID: <448EE593.7010809@domain.hid>
Date: Tue, 13 Jun 2006 18:19:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
References: <448E98A3.6080707@domain.hid>
	<448E9E8B.70809@domain.hid>	<448EA7F7.5000802@domain.hid>
	<448EB038.8070802@domain.hid>
In-Reply-To: <448EB038.8070802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig45B1D6D96D06A82F46297A49"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45B1D6D96D06A82F46297A49
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Here is likely why we have different levels of accuracy and performance=
,
>  firstly my version is bluntly based on the khz freq, secondly it
> calculates the other way around, i.e. ns2tsc, so that tsc are keep in
> the inner code, but more efficiently converted from ns counts passed to=

> the outer interface:
>=20
> static unsigned long ns2cyc_scale;
> #define NS2CYC_SCALE_FACTOR 10 /* 2^10, carefully chosen */
>=20
> static inline void set_ns2cyc_scale(unsigned long cpu_khz)
> {
>     ns2cyc_scale =3D (cpu_khz << NS2CYC_SCALE_FACTOR) / 1000000;
> }
>=20
> static inline unsigned long long ns_2_cycles(unsigned long long ns)
> {
>     return ns * ns2cyc_scale >> NS2CYC_SCALE_FACTOR;
> }

Your version performs ~50% better than mine (outperforming the original
version by factor 7 on a 1 GHz box, vs. 4.8). I think you compared
non-optimised code, didn't you? Without -O2, I see 15 times better
performance.

[Gilles variant yet refuses the get benchmarked.]

Jan


--------------enig45B1D6D96D06A82F46297A49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjuWTniDOoMHTA+kRAnHxAJ9UOQy8ZN6ozihWjap2UNIgMgmQXQCeJkJf
1Pt1fmhbt6JgTaAq/duPzSg=
=9IXt
-----END PGP SIGNATURE-----

--------------enig45B1D6D96D06A82F46297A49--

