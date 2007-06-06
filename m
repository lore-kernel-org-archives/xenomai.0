Message-ID: <46670109.7070408@domain.hid>
Date: Wed, 06 Jun 2007 20:46:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid>
	<46651F7D.9090702@domain.hid>	<18021.58231.177931.286548@domain.hid>	<46668CC3.8050002@domain.hid>
	<4666ACE5.7030200@domain.hid>	<4666AFB3.6040602@domain.hid>
	<4666B4C7.6020308@domain.hid>	<4666B716.6010909@domain.hid>
	<18022.64424.836736.431121@domain.hid>
In-Reply-To: <18022.64424.836736.431121@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig41FA8187972E88CA038BCC2E"
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
--------------enig41FA8187972E88CA038BCC2E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Not when the macro and inline bear names that are easy to understa=
nd. If
>  > > you do not find the names easy to understand, then change them (I =
do not
>  > > like rthal_llmul either, but I could not find a name). To make the=

>  > > assembly fully understandable, you would need to comment every
>  > > statement. And now, run the assembly code in gdb, and try and prin=
t the
>  > > value of a 64 bits intermediate result: you can't.
>  >=20
>  > No question, this is a matter of taste.
>=20
> No, really, being able to debug the code inside gdb appears to me as
> something more than a "matter of taste", I thought that as the person
> who made Xenomai run with kgdb you would have agreed with me.

Do we optimise hot path for debuggability? I really don't expect such a
well-defined small function being the target of a debugging session.
Moreover, you typically debug such micro services with stepi anyway,
watching registers, not variables (which are often undefined due to gcc
optimisations).

> Now, about the way I wrote arithmetic code, their are reasons behind my=

> choices. There are some repetitive patterns in this arithmetic code and=

> I wanted to facter them out. The first pattern is the conversion betwee=
n
> 32 bits and 64 bits, we have to do this in a way that is understood by
> the compiler on a particular platform, hence the definition of
> rthal_u64from/tou32 which is different for each platform. x86
> understands shifts and mask (or cast), but gcc for power pc or arm
> prefers the union trick.
> There is also only one way to cause gcc to use the 32x32->64 fast
> multiplication it is exactly what does rthal_ullmul. If you want to do
> the same thing, but write it differently, you invariably cause gcc to
> use a full 64 bits multiplication.
>=20
> So, when in rthal_generic_llmulshft, I read:
>=20
>     long long hi =3D (ll >> BITS_PER_LONG) * m;
>     unsigned long long lo =3D ((long)ll) * m;
>=20
> I think this is all wrong:
> - on a 64 bits machine, BITS_PER_LONG is 64 and ll is 64 bits, so ll >>=

>   BITS_PER_LONG is 0

Yes, utterly wrong, notices this as well. We must set 32 bits in stone.
And doing things with true 64 bit requires 128-bit math for the setup, I
guess that's not worth the trouble.

>=20
> - for the first multiplication, the compiler will not detect the
>   "fastmult" condition, and will use a full 64 bits multiplication. In
>   order to get it to generate the minimal multiplication, you should
>   have used:
>=20
>   long long hi =3D (long long)(int)(ll >> 32) * (int) m
>=20
>  I find:
> static inline long long rthal_llmi(const int i, const int j)
> {
>         /* Fast 32x32->64 multiplication */
> 	return (long long) i * j;
> }
>=20
> /* (...) */
> 	__rthal_u64tou32(op, oph, opl);
> 	hi =3D rthal_llmi(oph, m);
>=20
> easier to write and maintain, understand once you know what
> rthal_llmi does, and generates better code with regard to the
> 32bits/64bits conversion.
>=20
> - for the second multiplication, since the two arguments are 32 bits, t=
he
>   compiler will use a 32 bits multiplication, and since you (wrongly)
>   cast the first argument to long, it will use a signed multiplication,=

>   whereas we would want it to use an unsigned multiplication, as the
>   assembly routine correctly does.
>=20
> Here again, using:
>=20
>       lo =3D rthal_ullmul(opl, m);
> would have been less error-prone.
>   =20
> So, Ok, I will try to do something for x86 (either reduce the numbers o=
f
> registers used by the C code, or reduce the assembly to the bare
> minimum). But, please, pick my generic implementation of llmulshft, it
> was carefully written.

Yes, it is the better choice for 32 bit archs (my previous tests didn't
reflect the usage in Xenomai truely, redoing them made my generic
version fall behind yours). Will include it.

But your generic code produces worse binaries on 64 bit. Anyway, given
the potential of 64-bit instructions, we would better do this
differently there, e.g. like this for x64:

#define rthal_llmulshft(ll, m, s)                                      \
({                                                                     \
       long long __ret;                                                \
                                                                       \
       __asm__ (                                                       \
               /* HI:LO =3D ll * m */                                    =
\
               "imull %[__m]\n\t"                                      \
                                                                       \
               /* ret =3D HI:LO >> s */                                  =
\
               "shrd %%cl,%%rdx,%%rax\n\t"                             \
               : "=3Da" (__ret)                                          =
\
               : "a" (ll), [__m] "m" (m), "c" (s));                    \
       __ret;                                                          \
})

This version actually makes inlining xnarch_tsc_to_ns on that arch
interesting again...

Jan



--------------enig41FA8187972E88CA038BCC2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZwEJniDOoMHTA+kRArbqAJ99Gvt43sF41CP86ehbR/Ho9Mo9AgCeLPOS
NNIcIWmB+NLBe1vgvtq5/eE=
=Sqrh
-----END PGP SIGNATURE-----

--------------enig41FA8187972E88CA038BCC2E--

