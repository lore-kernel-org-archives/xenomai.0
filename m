Message-ID: <4A62D608.2090802@domain.hid>
Date: Sun, 19 Jul 2009 10:15:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A60E4FF.9020307@domain.hid>
In-Reply-To: <4A60E4FF.9020307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37B73A4E350F65864CFBF969"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [rfc] Jumpless *llimd.
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
--------------enig37B73A4E350F65864CFBF969
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> we discussed this issue several times already I believe: it would be=20
> fine if llimd (and nodiv_llimd) could work without jumps. 32 bits=20
> compiler are unable to generate code without jumps for the following=20
> sequence:
>=20
> union u64 {
> 	long long ll;
> 	unsigned l, h;
> };
>=20
> long long llimd(union u64 x, unsigned m, unsigned d)
> {
> 	unsigned s =3D x.h & 0x80000000;
> 	if (s)
> 		x.ll =3D -x.ll;
> 	x.ll =3D ullimd(x.ll, m, d);
> 	if (s)
> 		x.ll =3D -x.ll;
> }
>=20
> even though this works for x86_64 compiler.
>=20
> So, I thought, we might help a bit with inline assembly (after all,=20
> ullimd is already inline assembly). For instance, we could define macro=
s
> with the following semantic:
>=20
> #define sign_split(s, x)                        \
>         s =3D x.l & (1 << 31);                    \
>         if (s)                                  \
>                 x.ll =3D -x.ll;
>=20
> #define sign_apply(s, x)                        \
>         if (s)                                  \
>                 x.ll =3D -x.ll
>=20
>=20
> Jumpless versions on x86_32, using the cmov instruction, would give us:=

>=20
> #define x86_sign_split(s, x)                                           =
 \
>         ({                                                             =
 \
>                 unsigned tmpl =3D 0, tmph =3D 0;                       =
     \
>                 s =3D x.h;                                        	\
>                 asm ("sub %[tmpl], %[xl]\n\t"                          =
 \
>                      "sbb %[tmph], %[xh]\n\t"                          =
 \
>                      "andl $0x80000000, %[s]\n\t"                      =
 \
>                      "cmovnz %[tmpl], %[xl]\n\t"                       =
 \
>                      "cmovnz %[tmph], %[xh]\n\n"                       =
 \
>                      : [s]"+m"(s), [tmph]"+rm?"(tmph), [tmpl]"+rm?"(tmp=
l), \
>                        [xh]"=3Dr"(x.h), [xl]"=3Dr"(x.l));              =
   	\
>          })
>=20
> #define x86_sign_apply(s, x)                                           =
 \
>         ({                                                             =
 \
>                 unsigned tmpl =3D 0, tmph =3D 0;                       =
     \
>                 asm ("sub %[tmpl], %[xl]\n\t"                          =
 \
>                      "sbb %[tmph], %[xh]\n\t"                          =
 \
>                      "cmpl $0x80000000, %[s]\n\t" 			\
>                      "cmove %[tmpl], %[xl]\n\t"                 	\
>                      "cmove %[tmph], %[xh]\n\n"                 	\
>                      : [tmph]"+rm?"(tmph), [tmpl]"+rm?"(tmpl), 		\
>                        [xh]"=3Dr"(x.h), [xl]"=3Dr"(x.l)                =
     \
>                      : [s]"m"(s));                      		\
>          })
>=20
> What do you think? I am out of my mind? Would you see llimd defined
> locally in each asm/arith.h using these macros? Or should we make this =

> yet another macro defined by asm/arith.h and used by=20
> asm-generic/arith.h?=20
>=20
> Note that on ARM, the inline assembly would be shorter (maybe there are=

> shorter solutions on x86_32, but as usual, they are probably not natura=
l).
>=20

The approach is generally fine, but you have to take measures to avoid
using cmove on CPUs that don't support it. They may be still around
(older VIA C3 e.g.).

Jan


--------------enig37B73A4E350F65864CFBF969
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpi1ggACgkQniDOoMHTA+n8bgCeIDJDZXO3gbEZ2nNicIGG0HsQ
LAUAmgMgf0TlXqRbCpi6RmAC1A8ZYeME
=+y/O
-----END PGP SIGNATURE-----

--------------enig37B73A4E350F65864CFBF969--

