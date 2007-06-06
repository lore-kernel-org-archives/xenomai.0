Message-ID: <4666B716.6010909@domain.hid>
Date: Wed, 06 Jun 2007 15:31:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid>	<46651F7D.9090702@domain.hid>
	<18021.58231.177931.286548@domain.hid>
	<46668CC3.8050002@domain.hid> <4666ACE5.7030200@domain.hid>
	<4666AFB3.6040602@domain.hid> <4666B4C7.6020308@domain.hid>
In-Reply-To: <4666B4C7.6020308@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C97BF8F381F315AB457CDFD"
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
--------------enig7C97BF8F381F315AB457CDFD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Gilles Chanteperdrix wrote:
>>>>
>>>>
>>>>> Jan Kiszka wrote:
>>>>>
>>>>>> Jan Kiszka wrote:
>>>>>> ...
>>>>>>
>>>>>>> fast-tsc-to-ns-v2.patch
>>>>>>>
>>>>>>>    [Rebased, improved rounding of least significant digit]
>>>>>> Rounding in the fast path for the sake of the last digit was silly=
=2E
>>>>>> Instead, I'm now addressing the ugly interval printing via
>>>>>> xnarch_precise_tsc_to_ns when converting the timer interval back i=
nto
>>>>>> nanos. -v3 incorporating this has just been uploaded.
>>>>> Hi,
>>>>>
>>>>> I had a look at the fast-tsc-to-ns implementation, here is how I wo=
uld
>>>>> rewrite it:
>>>>>
>>>>> static inline void xnarch_init_llmulshft(const unsigned m_in,
>>>>> 					 const unsigned d_in,
>>>>> 					 unsigned *m_out,
>>>>> 					 unsigned *s_out)
>>>>> {
>>>>> 	unsigned long long mult;
>>>>>
>>>>> 	*s_out =3D 31;
>>>>> 	while (1) {
>>>>> 		mult =3D ((unsigned long long)m_in) << *s_out;
>>>>> 		do_div(mult, d_in);
>>>>> 		if (mult <=3D INT_MAX)
>>>>> 			break;
>>>>> 		(*s_out)--;
>>>>> 	}
>>>>> 	*m_out =3D (unsigned)mult;
>>>>> }
>>>>>
>>>>> /* Non x86. */
>>>>> #define __rthal_u96shift(h, m, l, s) ({		\
>>>>> 	unsigned _l =3D (l);			\
>>>>> 	unsigned _m =3D (m);			\
>>>>> 	unsigned _s =3D (s);			\
>>>>> 	_l >>=3D _s;				\
>>>>> 	_m >>=3D s;				\
>>>>> 	_l |=3D (_m << (32 - s));			\
>>>>> 	_m |=3D ((h) << (32 - s));		\
>>>>>       __rthal_u64fromu32(_m, _l);		\
>>>>> })
>>>>>
>>>>> /* x86 */
>>>>> #define __rthal_u96shift(h, m, l, s) ({		\
>>>>> 	unsigned _l =3D (l);			\
>>>>> 	unsigned _m =3D (m);			\
>>>>> 	unsigned _s =3D (s);			\
>>>>> 	asm ("shrdl\t%%cl,%1,%0"		\
>>>>> 	     : "+r,?m"(_l)			\
>>>>> 	     : "r,r"(_m), "c,c"(_s));		\
>>>>> 	asm ("shrdl\t%%cl,%1,%0"		\
>>>>> 	     : "+r,?m"(_m)			\
>>>>> 	     : "r,r"(h), "c,c"(_s));		\
>>>>> 	__rthal_u64fromu32(_m, _l);		\
>>>>> })
>>>>>
>>>>> static inline long long rthal_llmi(int i, int j)
>>>>> {
>>>>>       /* Signed fast 32x32->64 multiplication */
>>>>> 	return (long long) i * j;
>>>>> }
>>>>>
>>>>> static inline long long gilles_llmulshft(const long long op,
>>>>> 					 const unsigned m,
>>>>> 					 const unsigned s)
>>>>> {
>>>>> 	unsigned oph, opl, tlh, tll, thh, thl;
>>>>> 	unsigned long long th, tl;
>>>>>
>>>>> 	__rthal_u64tou32(op, oph, opl);
>>>>> 	tl =3D rthal_ullmul(opl, m);
>>>>> 	__rthal_u64tou32(tl, tlh, tll);
>>>>> 	th =3D rthal_llmi(oph, m);
>>>>> 	th +=3D tlh;
>>>>> 	__rthal_u64tou32(th, thh, thl);
>>>>> =09
>>>>> 	return __rthal_u96shift(thh, thl, tll, s);
>>>>> }
>>>>>
>>>>>
>>>> Thanks for your suggestion.
>>>>
>>>> While your generic version produces comparable code, the x86 variant=
 is
>>>> about twice as large as the full-assembly version. And code size
>>>> translates into I-cache occupation, which may have latency costs.
>>>>
>>>> [gcc 4.1, i386]
>>>> -O2 -mregparm=3D3 -fomit-frame-pointer:
>>>>    63: 08048490   119 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
>>>>    68: 08048510   121 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x=
86
>>>>    77: 08048450    57 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
>>>>    78: 080483c0   135 FUNC    GLOBAL DEFAULT   13 __rthal_generic_ll=
mulshft
>>>>
>>>> -Os -mregparm=3D3 -fomit-frame-pointer:
>>>>    63: 0804843b    93 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
>>>>    68: 08048498    97 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x=
86
>>>>    77: 08048410    43 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
>>>>    78: 080483b4    92 FUNC    GLOBAL DEFAULT   13 __rthal_generic_ll=
mulshft
>>>>
>>>> -O2:
>>>>    63: 08048480   120 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
>>>>    68: 08048500   105 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x=
86
>>>>    77: 08048440    60 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
>>>>    78: 080483c0   117 FUNC    GLOBAL DEFAULT   13 __rthal_generic_ll=
mulshft
>>>>
>>>> -Os:
>>>>    63: 08048438   104 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft
>>>>    68: 080484a0    83 FUNC    GLOBAL DEFAULT   13 gilles_llmulshft_x=
86
>>>>    77: 0804840b    45 FUNC    GLOBAL DEFAULT   13 rthal_llmulshft
>>>>    78: 080483b4    87 FUNC    GLOBAL DEFAULT   13 __rthal_generic_ll=
mulshft
>>>>
>>>> I'm not arguing we should turn each and every Xenomai arch code into=

>>>> pure assembly. But in this case it already happened, it's less scatt=
ered
>>>> source code-wise, and it is compacter object-wise. So I would prefer=
 to
>>>> keep it as is.
>>> I would say the advantage of having a C version outperform the
>>> advantages of the full assembly version. C is really easier to
>>> understand and debug.
>>
>> Personally, I prefer the clear (and commented) assembly over the neste=
d
>> macros and inlines.
>=20
> Not when the macro and inline bear names that are easy to understand. I=
f
> you do not find the names easy to understand, then change them (I do no=
t
> like rthal_llmul either, but I could not find a name). To make the
> assembly fully understandable, you would need to comment every
> statement. And now, run the assembly code in gdb, and try and print the=

> value of a 64 bits intermediate result: you can't.

No question, this is a matter of taste.

>=20
>>
>>> The differences between the two versions are some register moves, whi=
ch
>>> cost almost nothing, especially since each operation in the assembly
>>
>> Cycle-wise, you are right. But what bites us more in the worst case ar=
e
>> memory accesses, specifically when they are not cached. Code size
>> matters more according to my experience.
>>
>>
>>> version depends on the result of the previous operation, which means
>>> lots of pipeline stall, the register moves will just feed the pipelin=
e.
>>> I do not think they really matter. Look at the assembly produced for
>>> gilles_llmulshft on ARM, a low end architecture where each instructio=
n
>>> really costs:
>>> gilles_llmulshft:
>>>        @ args =3D 0, pretend =3D 0, frame =3D 0
>>>        @ frame_needed =3D 0, uses_anonymous_args =3D 0
>>>        @ link register save eliminated.
>>>        stmfd   sp!, {r4, r5, r6, r7}
>>>        umull   r6, r7, r0, r2
>>>        mov     r4, r7
>>>        mov     r5, #0
>>>        smlal   r4, r5, r2, r1
>>>        rsb     ip, r3, #32
>>>        mov     r2, r4, lsr r3
>>>        orr     r1, r2, r5, asl ip
>>>        mov     r2, r2, asl ip
>>>        orr     r0, r2, r6, lsr r3
>>>        @ lr needed for prologue
>>>        ldmfd   sp!, {r4, r5, r6, r7}
>>>        mov     pc, lr
>>>
>>> pretty minimal, no ?
>>
>> OK, your version can perfectly go into the ARM arch. But i386 is
>> different: less registers, thus easily a lot of variable shuffling...
>=20
> variable shuffling which does not really matter, that is my point,
> otherwise the x86 family would not be as fast as it is.

Think of the *code size*...

>=20
>>
>>> The full assembly version has another big drawback, it is a big block=

>>> that the optimizer can not split, whereas in a C version, the optimiz=
er
>>> can decide to interleave the surrounding code. So a C version will
>>> inline better.
>>
>> We are not inlining that service anymore, at least not for its primary=

>> usage tsc-to-ns. Inlining costs object size, thus increases the latenc=
y
>> (although it saves us a few cycles).
>=20
> it *is* inlined, in tsc_to/from_ns. Another question that I forgot in m=
y

xnarch_tsc_to_ns uninlines this service, and I don't see other, larger
users so far.

> previous mails: why not using llmulshft for the two services ?

See below, see my original post on all the conversion approaches: scaled
math is inaccurate, doing it both ways may cause noticeable errors when
dealing with calculated vs. measured time stamps over, granted, fairly
long periods.

>=20
>>
>>> There is one thing I do not like with llmulshft (any implementation),=
 it
>>> is the rounding policy towards minus infinity. llmulshft(-1, 2/3)
>>> returns -1 whereas llimd would return 0.
>>
>> See other postings: rounding of the last digit doesn't matter with
>> scaled math, it's already inaccurate by nature. That's also why we hav=
e
>> it only one-way.
>=20
> When returning -1 instead of 0, it is not the last digit that is wrong,=

> but the first (and only) one.

So this is about -1 nanoseconds vs. 0 nanoseconds. Well, does this error
matter in real life? :->



--------------enig7C97BF8F381F315AB457CDFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZrcWniDOoMHTA+kRAmULAJ9PGiemQWJe1mQ1XUCdfDnh3qQ5fQCffH4w
fQ8B3PanFHYyCOIGJOMjJaQ=
=d/0F
-----END PGP SIGNATURE-----

--------------enig7C97BF8F381F315AB457CDFD--

