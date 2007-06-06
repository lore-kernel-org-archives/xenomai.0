Message-ID: <46668CC3.8050002@domain.hid>
Date: Wed, 06 Jun 2007 12:30:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid>	<46651F7D.9090702@domain.hid>
	<18021.58231.177931.286548@domain.hid>
In-Reply-To: <18021.58231.177931.286548@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBE40774D51E0CFE001D718B6"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE40774D51E0CFE001D718B6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Jan Kiszka wrote:
>  > ...
>  > > fast-tsc-to-ns-v2.patch
>  > >=20
>  > >     [Rebased, improved rounding of least significant digit]
>  >=20
>  > Rounding in the fast path for the sake of the last digit was silly.
>  > Instead, I'm now addressing the ugly interval printing via
>  > xnarch_precise_tsc_to_ns when converting the timer interval back int=
o
>  > nanos. -v3 incorporating this has just been uploaded.
>=20
> Hi,
>=20
> I had a look at the fast-tsc-to-ns implementation, here is how I would
> rewrite it:
>=20
> static inline void xnarch_init_llmulshft(const unsigned m_in,
> 					 const unsigned d_in,
> 					 unsigned *m_out,
> 					 unsigned *s_out)
> {
> 	unsigned long long mult;
>=20
> 	*s_out =3D 31;
> 	while (1) {
> 		mult =3D ((unsigned long long)m_in) << *s_out;
> 		do_div(mult, d_in);
> 		if (mult <=3D INT_MAX)
> 			break;
> 		(*s_out)--;
> 	}
> 	*m_out =3D (unsigned)mult;
> }
>=20
> /* Non x86. */
> #define __rthal_u96shift(h, m, l, s) ({		\
> 	unsigned _l =3D (l);			\
> 	unsigned _m =3D (m);			\
> 	unsigned _s =3D (s);			\
> 	_l >>=3D _s;				\
> 	_m >>=3D s;				\
> 	_l |=3D (_m << (32 - s));			\
> 	_m |=3D ((h) << (32 - s));		\
>         __rthal_u64fromu32(_m, _l);		\
> })
>=20
> /* x86 */
> #define __rthal_u96shift(h, m, l, s) ({		\
> 	unsigned _l =3D (l);			\
> 	unsigned _m =3D (m);			\
> 	unsigned _s =3D (s);			\
> 	asm ("shrdl\t%%cl,%1,%0"		\
> 	     : "+r,?m"(_l)			\
> 	     : "r,r"(_m), "c,c"(_s));		\
> 	asm ("shrdl\t%%cl,%1,%0"		\
> 	     : "+r,?m"(_m)			\
> 	     : "r,r"(h), "c,c"(_s));		\
> 	__rthal_u64fromu32(_m, _l);		\
> })
>=20
> static inline long long rthal_llmi(int i, int j)
> {
>         /* Signed fast 32x32->64 multiplication */
> 	return (long long) i * j;
> }
>=20
> static inline long long gilles_llmulshft(const long long op,
> 					 const unsigned m,
> 					 const unsigned s)
> {
> 	unsigned oph, opl, tlh, tll, thh, thl;
> 	unsigned long long th, tl;
>=20
> 	__rthal_u64tou32(op, oph, opl);
> 	tl =3D rthal_ullmul(opl, m);
> 	__rthal_u64tou32(tl, tlh, tll);
> 	th =3D rthal_llmi(oph, m);
> 	th +=3D tlh;
> 	__rthal_u64tou32(th, thh, thl);
> =09
> 	return __rthal_u96shift(thh, thl, tll, s);
> }
>=20
>=20

Thanks for your suggestion.

While your generic version produces comparable code, the x86 variant is
about twice as large as the full-assembly version. And code size
translates into I-cache occupation, which may have latency costs.

[gcc 4.1, i386]
-O2 -mregparm=3D3 -fomit-frame-pointer:
    63: 08048490   119 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
    68: 08048510   121 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x86
    77: 08048450    57 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
    78: 080483c0   135 FUNC    GLOBAL DEFAULT   13 __rthal_generic_llmuls=
hft

-Os -mregparm=3D3 -fomit-frame-pointer:
    63: 0804843b    93 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
    68: 08048498    97 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x86
    77: 08048410    43 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
    78: 080483b4    92 FUNC    GLOBAL DEFAULT   13 __rthal_generic_llmuls=
hft

-O2:
    63: 08048480   120 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
    68: 08048500   105 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x86
    77: 08048440    60 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
    78: 080483c0   117 FUNC    GLOBAL DEFAULT   13 __rthal_generic_llmuls=
hft

-Os:
    63: 08048438   104 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
    68: 080484a0    83 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x86
    77: 0804840b    45 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
    78: 080483b4    87 FUNC    GLOBAL DEFAULT   13 __rthal_generic_llmuls=
hft

I'm not arguing we should turn each and every Xenomai arch code into
pure assembly. But in this case it already happened, it's less scattered
source code-wise, and it is compacter object-wise. So I would prefer to
keep it as is.

Jan


--------------enigBE40774D51E0CFE001D718B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZozDniDOoMHTA+kRAgB6AJ9DoRuo7lb1uC/ZF7ehi09feaR42wCeOzWY
Xm8+0xqzUJ5p6SsPkKZtikA=
=WAQf
-----END PGP SIGNATURE-----

--------------enigBE40774D51E0CFE001D718B6--

